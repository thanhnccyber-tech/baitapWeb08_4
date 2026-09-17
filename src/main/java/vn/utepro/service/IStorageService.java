package vn.utepro.service;

import org.springframework.web.multipart.MultipartFile;

public interface IStorageService {
    String store(MultipartFile file, String fileName);
    String getStorageFilename(MultipartFile file, String id);
}