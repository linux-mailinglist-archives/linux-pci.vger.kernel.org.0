Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E373B4E85
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 14:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhFZNAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 09:00:04 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:44971 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFZNAD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 09:00:03 -0400
Received: by mail-ej1-f44.google.com with SMTP id n2so8681954eju.11
        for <linux-pci@vger.kernel.org>; Sat, 26 Jun 2021 05:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/9RgNe62o+MABqNxYIkb3XyaCH+OLLdVkKO/3a82KM=;
        b=YDqerCYKV3paiYj1yL2HP49cJ50wXHb0PXpY25SW9UALkEF4wprD5IUWl3fiVq3YI1
         30ECtqV8uWml/KuduyrWemRONIOHbXmqFIR8tH8/DONv8E2DNCI9xDsw9R80A7i3jb+T
         JF23kQyJTFy9XwLEdYO0ZDFx4UeJ8IpiAn+OVQp8ckfUnC98YdEvlOQULDUqLLsrkIDX
         NQ1aSeIOUANSqNgjhjI2yeq4Qg3EOUeFicMgULeOrtpvPARnJJ29zok7x9k+Jb0B60ii
         5jbGB22aJ5X4STrn6n/CrzFv1cMKPlxZzsw57nPO/mpb8tb07PFZSO1gvIAqBwOPrueS
         AmuQ==
X-Gm-Message-State: AOAM532tPkOgwv0Jr3LoXCJbeLVIlLSNul1k0i00cJVQ2cR0sXTlLza0
        yCjYmAXZn7JEc0FJ72UMkRe6CY7pSo5CUQ==
X-Google-Smtp-Source: ABdhPJyAO22+98TU15rsxIPrIvsDPacKmQcC8yoFO+Mz7XbwY89uHVCtG9mJtyWjl+VwQewl9/mc/A==
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr15800173ejz.151.1624712260448;
        Sat, 26 Jun 2021 05:57:40 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e7sm3755748ejm.93.2021.06.26.05.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 05:57:40 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 3/3] sysfs: Rename struct bin_attribute member to f_mapping
Date:   Sat, 26 Jun 2021 12:57:35 +0000
Message-Id: <20210626125735.2868256-4-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210626125735.2868256-1-kw@linux.com>
References: <20210626125735.2868256-1-kw@linux.com>
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
index cff1c121eb08..26cef98d8352 100644
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
index fbb7c7df545c..fa5de9b1fa4a 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -170,7 +170,7 @@ struct bin_attribute {
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

