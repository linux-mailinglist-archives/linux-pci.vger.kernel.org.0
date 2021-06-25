Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA03B4AF2
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 01:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYXdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 19:33:47 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40933 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhFYXdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 19:33:47 -0400
Received: by mail-ed1-f54.google.com with SMTP id t3so15617740edc.7
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 16:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GSicSMy/nF6trnS/MfRL+W4ghg4phn0UKLi5jH9tX0=;
        b=dHh2I8uFDjmv4hg0aVa6hD6TImzsFuNkpVoNOvplAZVO9D0jo7r2weQksRFqtoJi7O
         os8MbiSi4AXSSRjaEqwDWU/qgRPI3vHjG4tsEAMsGSNSw8IXjClSy/NfFm9rDx2jlnps
         DdeNFZ/M4W/9jb+BarOz5sZPz3xd06rD0aoMMzQscGz/JdVp778/0ELl/hujJ6pU3uV8
         PvKdtBnmcFm4LwTz+9vR7Bao6PkLCXsTnmV9zjso5Z2VbllSfzrxcU6Luxn5YcfsROME
         hqBLyMjLxhQKq5sRbxWRSsJf+o/3iU/V07hp64nj3SLxmwPU6IXTszU4g4COvGOTmCry
         BKGA==
X-Gm-Message-State: AOAM530NnrLF4MyDi2HL0pIZxHtega6/guB4yFMiBHrnU2FJEpETGf6N
        2L2lajTXoqtVy7hoD5BMztw=
X-Google-Smtp-Source: ABdhPJxcwVf9Ujl44620E7ruXJyLFgSSTjsl1l7fOmqWeKzz9Qf8o+1gglnW9qFQ+OBy56Qtdtd6bA==
X-Received: by 2002:aa7:c256:: with SMTP id y22mr18306948edo.177.1624663881680;
        Fri, 25 Jun 2021 16:31:21 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b8sm4741015edr.42.2021.06.25.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 16:31:21 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/sysfs: Pass iomem_get_mapping() as a function pointer
Date:   Fri, 25 Jun 2021 23:31:18 +0000
Message-Id: <20210625233118.2814915-3-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625233118.2814915-1-kw@linux.com>
References: <20210625233118.2814915-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The struct bin_attribute requires the "mapping" member to be a function
pointer with a signature requiring the return type to be a pointer to
the struct address_space.

Thus, convert every invocation of iomem_get_mapping() into a function
pointer assignment, therefore allowing for the iomem_get_mapping()
invocation to be deferred to when the sysfs open callback runs.

Co-authored-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index beb8d1f4fafe..cff1c121eb08 100644
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
-- 
2.32.0

