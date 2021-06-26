Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598733B4E84
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 14:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFZNAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 09:00:04 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:40582 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZNAC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 09:00:02 -0400
Received: by mail-ej1-f42.google.com with SMTP id d16so16342296ejm.7
        for <linux-pci@vger.kernel.org>; Sat, 26 Jun 2021 05:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeHsd8nXNureHN0+p+LqLfCUcfld/0+7qss7Qnv1OLo=;
        b=KYy7R0OAB7BhfdZn977u6cF92Qa1PUqvG+ruMCpjunGryaiULjHVyW4k+kYawkU1M/
         8NZdZguV0u6Z/LCzxJ5AEZhJK4Tym7Xa4bN6vJWyNy3QSrzoFEPM/gpe6xNlStEmFHpt
         Es6unKDH3ea9nMt1e7LtFUMfTclQT3D41OOUCyP83K/8nr+MgqoUjBCPidhKqF6qG9vE
         HhhH2cW0rH4g/dv309ZhbergGDPpTnIfluqxqYgmZrCCRDGmenUjpnoUgTMVWMXqrCHK
         5b//tjWs9C459Yrxpc49Zh6FgcQg+QEjAZDHQJ573EnMbjqUNWTM8t6YaVXrDpYWtUGd
         IWCg==
X-Gm-Message-State: AOAM533F8Ym+RSR0DAqe0qLxbcuLnzMiliMzMrNy+rSHmuZ7ylAi4iJI
        48tAApck/oXY66wDuioxgz0=
X-Google-Smtp-Source: ABdhPJwaeB6yVPvDBSSbLAEayKoBl0l09E9yqjjyRosJtZTLxApp/8q4lv6uN8aunHoBy/bUdpb5XA==
X-Received: by 2002:a17:906:ae57:: with SMTP id lf23mr1920636ejb.205.1624712259453;
        Sat, 26 Jun 2021 05:57:39 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e7sm3755748ejm.93.2021.06.26.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 05:57:39 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] PCI/sysfs: Pass iomem_get_mapping() as a function pointer
Date:   Sat, 26 Jun 2021 12:57:34 +0000
Message-Id: <20210626125735.2868256-3-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210626125735.2868256-1-kw@linux.com>
References: <20210626125735.2868256-1-kw@linux.com>
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

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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

