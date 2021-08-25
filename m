Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95F23F7DA0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhHYVXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 17:23:46 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53152 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhHYVXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 17:23:46 -0400
Received: by mail-wm1-f47.google.com with SMTP id f10so453236wml.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Aug 2021 14:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zf6rkWUjaV1Tx6F+wfWGn1LuKnP4vz9zUcrgqSHDegA=;
        b=Zr2+VJb5mb6AVUa3XqU32+GZNhnaQmmaBtjVg6A5ZZZwo/W5dm0DjVOkL2CrU7vxK5
         z7lLaxdg1D0sankXdy9itbgxAC/q4FF1dOea0l1F0jEFTX53osCFvMRMl7kyfv2jjbi+
         9puvjWVPqA6J7m36Dk/++EJQPUTxvwW/Zf9N5JZxWkGYWdsaZJdIp1UNFr8gaByGfVPZ
         TGdl9sweCE1a8cv1Zb6gUv4Fiu+YgbEFLwOgx+o+iNDEtfxUhI59oFyX5BHtH3dokZFw
         HXE6h5Rpmts/qp7Jsw4iv6JFSe0PmhnvCZImzwg9lIrb6Qqbg9gkNY1MPKTwEB6TLNEy
         H3fQ==
X-Gm-Message-State: AOAM531OGWIOAbx2F4bNf9XY0FqGhpSc2rNQnyWAi+kLlHJECDNKLz8C
        4hGVNxACnm/rEUKWizDDNbeoPHTcXOU=
X-Google-Smtp-Source: ABdhPJwXoYV+D0edvzKjhf7OAUxbCeuEx1+CXOWzBjo5+z7py5grrnpCQUgdYgT6TRDY4i8gAUHooQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr469551wmg.36.1629926579498;
        Wed, 25 Aug 2021 14:22:59 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d24sm663527wmb.35.2021.08.25.14.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:22:59 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI/sysfs: Add pci_dev_resource_attr() macro
Date:   Wed, 25 Aug 2021 21:22:53 +0000
Message-Id: <20210825212255.878043-3-kw@linux.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210825212255.878043-1-kw@linux.com>
References: <20210825212255.878043-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_dev_resource_attr() macro will be used to declare and define
each of the PCI resource sysfs objects statically while also reducing
unnecessary code repetition.

Internally this macro relies on the pci_dev_resource_attr_is_visible()
helper which should correctly handle different types of PCI BAR address
space while also providing support for creating either normal and/or
write-combine attributes as required.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c94ab9830932..6eba5c0887df 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1277,6 +1277,53 @@ static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
 
 	return attr->attr.mode;
 }
+
+#define pci_dev_resource_attr(_bar)					\
+static struct bin_attribute						\
+pci_dev_resource##_bar##_attr = __BIN_ATTR(resource##_bar,		\
+					   0600, NULL, NULL, 0);	\
+									\
+static struct bin_attribute *pci_dev_resource##_bar##_attrs[] = {	\
+	&pci_dev_resource##_bar##_attr,					\
+	NULL,								\
+};									\
+									\
+static umode_t								\
+pci_dev_resource##_bar##_attr_is_visible(struct kobject *kobj,		\
+					 struct bin_attribute *a,	\
+					 int n)				\
+{									\
+	return pci_dev_resource_attr_is_visible(kobj, a, _bar, false);	\
+};									\
+									\
+static const struct							\
+attribute_group pci_dev_resource##_bar##_attr_group = {			\
+	.bin_attrs = pci_dev_resource##_bar##_attrs,			\
+	.is_bin_visible = pci_dev_resource##_bar##_attr_is_visible,	\
+};									\
+									\
+static struct bin_attribute						\
+pci_dev_resource##_bar##_wc_attr = __BIN_ATTR(resource##_bar##_wc,	\
+					      0600, NULL, NULL, 0);	\
+									\
+static struct bin_attribute *pci_dev_resource##_bar##_wc_attrs[] = {	\
+	&pci_dev_resource##_bar##_wc_attr,				\
+	NULL,								\
+};									\
+									\
+static umode_t								\
+pci_dev_resource##_bar##_wc_attr_is_visible(struct kobject *kobj,	\
+					    struct bin_attribute *a,	\
+					    int n)			\
+{									\
+	return pci_dev_resource_attr_is_visible(kobj, a, _bar, true);	\
+};									\
+									\
+static const struct							\
+attribute_group pci_dev_resource##_bar##_wc_attr_group = {		\
+	.bin_attrs = pci_dev_resource##_bar##_wc_attrs,			\
+	.is_bin_visible = pci_dev_resource##_bar##_wc_attr_is_visible,	\
+}
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
-- 
2.32.0

