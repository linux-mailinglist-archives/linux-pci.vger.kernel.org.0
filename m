Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB53F7DA3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhHYVXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 17:23:46 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51727 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHYVXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 17:23:45 -0400
Received: by mail-wm1-f49.google.com with SMTP id u15so454597wmj.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Aug 2021 14:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pus7lzKHrBqat0liDWmIGHtUAC+V64E1vXqi3om7Leg=;
        b=EqTVgW2mMTZjlp7uVWWtdmOc8DDStY/WxEBZyrqkoR5wfK2ZfGN6euVbH8IDMHoXh1
         ULIoMSlIplQpKM8w/87MYue+aSHPSQWum0nPERejSUlPVF0+vSxwkbMEG0oA4SVsTsvH
         CJGdDLUT/4Vf6osnHPbpVXPnOAXZwSI1OEnxYE6BN/hd8M590eT/jxvKvcTSsgVa+xLS
         oCG4X22ZSFsonzPmsv4YGvrEzKhwOd5cUJU8pdbCHF5IR9JUM3zeb597Q+4QuRcNL97x
         JmUpOcI3vcCx9KuYu8to6etW+mDNnFD8mxOB3PSEEoKjnc4DT/I4PkzhHrkx9/sgNGuw
         fo9w==
X-Gm-Message-State: AOAM530zbhaPHahHO2rZ/uppi5fIYck5FLFV9J5IL4L6QiIqocB+p0ZS
        CY7Hfryd9gRxhaEXVtayJmAea2EWBOI=
X-Google-Smtp-Source: ABdhPJxvaQmptfTKuChrPpBKpCsRq7lrafpNdJv1K4typReumYbDg8wnJCNIhulSnx4nWmc4OYcT5g==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr11006105wmg.44.1629926578502;
        Wed, 25 Aug 2021 14:22:58 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d24sm663527wmb.35.2021.08.25.14.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:22:58 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 1/4] PCI/sysfs: Add pci_dev_resource_attr_is_visible() helper
Date:   Wed, 25 Aug 2021 21:22:52 +0000
Message-Id: <20210825212255.878043-2-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210825212255.878043-1-kw@linux.com>
References: <20210825212255.878043-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This helper aims to replace functions pci_create_resource_files() and
pci_create_attr() that are currently involved in the PCI resource sysfs
objects dynamic creation and set up once the.

After the conversion to use static sysfs objects when exposing the PCI
BAR address space this helper is to be called from the .is_bin_visible()
callback for each of the PCI resources attributes.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index b70f61fbcd4b..c94ab9830932 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1237,6 +1237,46 @@ static int pci_create_resource_files(struct pci_dev *pdev)
 	}
 	return 0;
 }
+
+static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
+						struct bin_attribute *attr,
+						int bar, bool write_combine)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	resource_size_t resource_size = pci_resource_len(pdev, bar);
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (!resource_size)
+		return 0;
+
+	if (write_combine) {
+		if (arch_can_pci_mmap_wc() && (flags &
+		    (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
+			(IORESOURCE_MEM | IORESOURCE_PREFETCH))
+			attr->mmap = pci_mmap_resource_wc;
+		else
+			return 0;
+	} else {
+		if (flags & IORESOURCE_MEM) {
+			attr->mmap = pci_mmap_resource_uc;
+		} else if (flags & IORESOURCE_IO) {
+			attr->read = pci_read_resource_io;
+			attr->write = pci_write_resource_io;
+			if (arch_can_pci_mmap_io())
+				attr->mmap = pci_mmap_resource_uc;
+		} else {
+			return 0;
+		}
+	}
+
+	attr->size = resource_size;
+	if (attr->mmap)
+		attr->f_mapping = iomem_get_mapping;
+
+	attr->private = (void *)(unsigned long)bar;
+
+	return attr->attr.mode;
+}
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
-- 
2.32.0

