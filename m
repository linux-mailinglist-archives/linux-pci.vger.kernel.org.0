Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC10D3DAFDA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 01:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhG2Xc6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 19:32:58 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:45048 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhG2Xc6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 19:32:58 -0400
Received: by mail-pj1-f43.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so11852394pjh.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 16:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQO9BjZ87IuTOirQKDMY9xJZve77mpQW3jqbgk9DnKg=;
        b=XkQnWi1WfMhcBichImBkgGlspJ26lGbACISaqAUBTXj1E0a961DA2jJyY1UTcSCXNs
         W/Jl4uRs+HLlPXu9A/kWQarCv+8H8INfbUNtFaOFMGjIgdxokcaIcgFi12hrQviVtH+w
         ZUdj/5tnB/cm24fV54v1x9WuRdc+pMEkx/eeWyYNJBwvPCdIgf7ljSkFyb91iQuAVri+
         sUTa9LGVNOvzMPAEkci6QoVgn03vidOUI7Oq0Q4Qlk6Ad4Fc9Jt5wKAB4PElZ44TodPZ
         BM16dhd+EtDZU54856xL02hxq10vrhRTQl0/w0gwboiFT4fvPNLuhx4kxQgmAioIlHM+
         xWOg==
X-Gm-Message-State: AOAM532W/ioN4tUNK6MWXyJO1SNyYnUvS4Yol7sVAAprPw1GjfzdjqT4
        XCt+uaZBg5HkrqVRy+7XwCg=
X-Google-Smtp-Source: ABdhPJwrl0tWRmALfe549CHQC8Zv+T3pir64aApusb9goKvIv9+GoLy5W+ZKxgAJ5oegTvkIL7FXiQ==
X-Received: by 2002:a05:6a00:148e:b029:331:5b07:c89a with SMTP id v14-20020a056a00148eb02903315b07c89amr7629353pfu.41.1627601573458;
        Thu, 29 Jul 2021 16:32:53 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d22sm4843325pfo.88.2021.07.29.16.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:32:53 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v3 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs open callback
Date:   Thu, 29 Jul 2021 23:32:34 +0000
Message-Id: <20210729233235.1508920-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729233235.1508920-1-kw@linux.com>
References: <20210729233235.1508920-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Defer invocation of the iomem_get_mapping() to the sysfs open callback
so that it can be executed as needed when the binary sysfs object has
been accessed.

To do that, convert the "mapping" member of the struct bin_attribute
from a pointer to the struct address_space into a function pointer with
a signature that requires the same return type, and then updates the
sysfs_kf_bin_open() to invoke provided function should the function
pointer be valid.

Also, convert every invocation of iomem_get_mapping() into a function
pointer assignment, therefore allowing for the iomem_get_mapping()
invocation to be deferred to when the sysfs open callback runs.

Thus, this change removes the need for the fs_initcalls to complete
before any other sub-system that uses the iomem_get_mapping() would be
able to invoke it safely without leading to a failure and an Oops
related to an invalid iomem_get_mapping() access.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/pci-sysfs.c | 6 +++---
 fs/sysfs/file.c         | 2 +-
 include/linux/sysfs.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7c1820..76e5545d0e73 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -965,7 +965,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
-	b->legacy_io->mapping = iomem_get_mapping();
+	b->legacy_io->mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_io);
 	error = device_create_bin_file(&b->dev, b->legacy_io);
 	if (error)
@@ -978,7 +978,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem->size = 1024*1024;
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
-	b->legacy_io->mapping = iomem_get_mapping();
+	b->legacy_io->mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_mem);
 	error = device_create_bin_file(&b->dev, b->legacy_mem);
 	if (error)
@@ -1195,7 +1195,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 		}
 	}
 	if (res_attr->mmap)
-		res_attr->mapping = iomem_get_mapping();
+		res_attr->mapping = iomem_get_mapping;
 	res_attr->attr.name = res_attr_name;
 	res_attr->attr.mode = 0600;
 	res_attr->size = pci_resource_len(pdev, num);
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 9aefa7779b29..a3ee4c32a264 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -175,7 +175,7 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 	struct bin_attribute *battr = of->kn->priv;
 
 	if (battr->mapping)
-		of->file->f_mapping = battr->mapping;
+		of->file->f_mapping = battr->mapping();
 
 	return 0;
 }
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a12556a4b93a..d5bcc897583c 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -176,7 +176,7 @@ struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
 	void			*private;
-	struct address_space	*mapping;
+	struct address_space *(*mapping)(void);
 	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
-- 
2.32.0

