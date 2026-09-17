package vn.utepro.service.impl;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import vn.utepro.service.IStorageService;

import java.io.IOException;
import java.nio.file.*;

@Service
public class StorageServiceImpl implements IStorageService {

    private final Path rootLocation;

    public StorageServiceImpl() {
        this.rootLocation = Paths.get("uploads");
        try { Files.createDirectories(rootLocation); }
        catch (IOException e) { throw new RuntimeException("Could not init storage", e); }
    }

    @Override
    public String store(MultipartFile file, String fileName) {
        try {
            if (file == null || file.isEmpty()) throw new RuntimeException("File empty");
            Path dest = rootLocation.resolve(Paths.get(fileName)).normalize().toAbsolutePath();
            Files.copy(file.getInputStream(), dest, StandardCopyOption.REPLACE_EXISTING);
            return fileName;
        } catch (IOException e) {
            throw new RuntimeException("Failed to store file", e);
        }
    }

    @Override
    public String getStorageFilename(MultipartFile file, String id) {
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        return "p" + id + "." + ext;
    }
}