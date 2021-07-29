Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C853DAFDB
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 01:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhG2XdE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 19:33:04 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34684 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhG2XdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 19:33:04 -0400
Received: by mail-pl1-f180.google.com with SMTP id d1so8856711pll.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 16:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6T89ZET1uZxz7012CVHYYU1Wf5+KMJNNw9LfH+Awp7U=;
        b=k52GPol6PPw4OLy6mD1tN9eBIP9FJmx/SdFExF8WVEQs1jwon+Zm62iVDfhlR620NZ
         88bCP6FSM1xddupAUcQr4Ja9Y/AZQRkpTLw+JuwjOZ/Sp1yt+Cdp/kbep0mPkZqYTME8
         U16T2oXqaIkyYQU5GmI+k+GScAT5mrEdZl8c3cu+nFPNeMwt3JW0W8znZ5/b33PZkTEx
         Gh90uDcV8kDr0QtZg+Obnw3bcv/mRwMp0epnlGaBA05caFJfAK6SCTD0TjvzPeshoiw3
         ZofNF0JEOtJ++VuzIu4ffnqCTUHUww1Svs1w+p/KVB8biNuyODcyIvduJAhjdjanpZLR
         8OLg==
X-Gm-Message-State: AOAM530Pgm5zUvX941VW1hduS5/mFR5nWagpqDZh3/0BRKnKUGk6CYmF
        kXxLcdogIXhofwDvVTzXSHs=
X-Google-Smtp-Source: ABdhPJytKJRfPJnSf9PVIBQtXXq6qHhvdTw0BUfgmucgRlQPwP5/0GpADUgtPKQssxhsaUv0gkLENg==
X-Received: by 2002:a63:2116:: with SMTP id h22mr5864724pgh.410.1627601579551;
        Thu, 29 Jul 2021 16:32:59 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d22sm4843325pfo.88.2021.07.29.16.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:32:59 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v3 2/2] sysfs: Rename struct bin_attribute member to f_mapping
Date:   Thu, 29 Jul 2021 23:32:35 +0000
Message-Id: <20210729233235.1508920-3-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729233235.1508920-1-kw@linux.com>
References: <20210729233235.1508920-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are two users of iomem_get_mapping(), the struct file and struct
bin_attribute.  The former has a member called "f_mapping" and the
latter has a member called "mapping", and both are poniters to struct
address_space.

Rename struct bin_attribute member to "f_mapping" to keep both meaning
and the usage consistent with other users of iomem_get_mapping().

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 6 +++---
 fs/sysfs/file.c         | 4 ++--
 include/linux/sysfs.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 76e5545d0e73..f65382915f01 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -965,7 +965,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_io->read = pci_read_legacy_io;
 	b->legacy_io->write = pci_write_legacy_io;
 	b->legacy_io->mmap = pci_mmap_legacy_io;
-	b->legacy_io->mapping = iomem_get_mapping;
+	b->legacy_io->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_io);
 	error = device_create_bin_file(&b->dev, b->legacy_io);
 	if (error)
@@ -978,7 +978,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	b->legacy_mem->size = 1024*1024;
 	b->legacy_mem->attr.mode = 0600;
 	b->legacy_mem->mmap = pci_mmap_legacy_mem;
-	b->legacy_io->mapping = iomem_get_mapping;
+	b->legacy_io->f_mapping = iomem_get_mapping;
 	pci_adjust_legacy_attr(b, pci_mmap_mem);
 	error = device_create_bin_file(&b->dev, b->legacy_mem);
 	if (error)
@@ -1195,7 +1195,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 		}
 	}
 	if (res_attr->mmap)
-		res_attr->mapping = iomem_get_mapping;
+		res_attr->f_mapping = iomem_get_mapping;
 	res_attr->attr.name = res_attr_name;
 	res_attr->attr.mode = 0600;
 	res_attr->size = pci_resource_len(pdev, num);
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a3ee4c32a264..d019d6ac6ad0 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -174,8 +174,8 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 {
 	struct bin_attribute *battr = of->kn->priv;
 
-	if (battr->mapping)
-		of->file->f_mapping = battr->mapping();
+	if (battr->f_mapping)
+		of->file->f_mapping = battr->f_mapping();
 
 	return 0;
 }
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d5bcc897583c..e3f1e8ac1f85 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -176,7 +176,7 @@ struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
 	void			*private;
-	struct address_space *(*mapping)(void);
+	struct address_space *(*f_mapping)(void);
 	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
 			char *, loff_t, size_t);
 	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
-- 
2.32.0

