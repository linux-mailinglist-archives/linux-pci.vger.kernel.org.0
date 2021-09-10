Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD94840727A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhIJU1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:44 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:38875 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhIJU1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:40 -0400
Received: by mail-lf1-f46.google.com with SMTP id x27so6449105lfu.5
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSY0I3VKOsoIdgVYMSbo9+/e6WBendyy8et/oBmrSfE=;
        b=3dXauB0pGk7oc74a9u20zxUTovDXKzHFfmEIJ95H3JyxAFCy4qIN6gpS11iafoJRKp
         umarcnW1AdnYKZkrVMVjsfYSetxh0TzYWK+D6TTAiKUwcxs54ZdKlCmBW8K4T4znoLcx
         RVdqY+3OFwsiinZ4/Ir83Cek1RdXk37vhxPjrzLPqhd2+f3z8gznXg048bjguOzIa19j
         /tLBNN/Yyyr1vnaFyzYJnAlF0bOyj1GitdIKNdcCFW3k4e27KFveZKoJTvbV2y/YddjN
         0Aczu/flVvhxxI3UcXa51fhfUEu4FDyXDpGtvpbzX65fmeQQPyd0U8VeauJX5nWbeon3
         /1Ig==
X-Gm-Message-State: AOAM532/v5urqms0bz4VcxeAKbkpWr5cyWvtDBE/KXXTXFtKQQo7JDO3
        og2rDqtk0sayw9H6bCG7AHE=
X-Google-Smtp-Source: ABdhPJwDU4Ymo5vqpvVCIIQ5vZ25wcRBW4sQUKjpF12x1V/GrJS+e72UkFcDrGuy/uIZewSwWB1wwg==
X-Received: by 2002:a05:6512:32c9:: with SMTP id f9mr5189742lfg.249.1631305587678;
        Fri, 10 Sep 2021 13:26:27 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:27 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/7] PCI/sysfs: Add pci_dev_resource_attr() macro
Date:   Fri, 10 Sep 2021 20:26:18 +0000
Message-Id: <20210910202623.2293708-3-kw@linux.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910202623.2293708-1-kw@linux.com>
References: <20210910202623.2293708-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_dev_resource_attr() macro will be used to declare and define
each of the PCI resource sysfs objects statically while also reducing
unnecessary code repetition.

This macro aims to also replace functions pci_create_resource_files()
and pci_create_attr() that are currently involved in the PCI resource
sysfs objects dynamic creation and set up once the.

Internally this macro relies on the pci_dev_resource_attr_is_visible()
helper which should correctly handle creating either normal and/or
write-combine attributes as required.

Two other macros were also added to help reduce code duplication, the
pci_dev_bin_attribute() and pci_dev_resource_group().

The pci_dev_bin_attribute() macro abstracts the declaration and
definition of a binary attribute with all the required fields from
struct bin_attribute set as needed for a given PCI resource sysfs
attribute.

The pci_dev_resource_group() macro will be used to reduce unnecessary
code repetition following the use of the pci_dev_resource_attr() macro
when adding each of the many newly created resource groups to the list
of other PCI sysfs objects stored in the pci_dev_groups array.

The conversion to static sysfs objects will result in two sysfs
attributes to be created for each PCI resource (the underlying BAR)
independently, one for a normal resource, and one for a resource
that is write-combine capable, should this feature be supported.

Each such resource will be then placed in a dedicated attribute
resource group so that access to it can be controlled using a
dedicated .is_bin_visible() callback where depending on what the
underlying resource (a given BAR) supports will be either made
visible or hidden.

Therefore, for six standard PCI BARs, a total of twelve attribute
groups will be thus created per device.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-sysfs.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 4272d1aba205..ccdd1e34aeee 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1261,6 +1261,67 @@ static umode_t pci_dev_resource_attr_is_visible(struct kobject *kobj,
 	return a->attr.mode;
 };
 
+#define pci_dev_bin_attribute(_name, _mmap, _bar)		\
+struct bin_attribute pci_dev_##_name##_attr = {			\
+	.attr = { .name = __stringify(_name), .mode = 0600 },	\
+	.read = pci_read_resource_io,				\
+	.write = pci_write_resource_io,				\
+	.mmap = _mmap,						\
+	.private = (void *)(unsigned long)_bar,			\
+	.f_mapping = iomem_get_mapping,				\
+}
+
+#define pci_dev_resource_attr(_bar)					\
+static pci_dev_bin_attribute(resource##_bar,				\
+			     pci_mmap_resource_uc,			\
+			     _bar);					\
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
+static pci_dev_bin_attribute(resource##_bar##_wc,			\
+			     pci_mmap_resource_wc,			\
+			     _bar);					\
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
+
+#define pci_dev_resource_group(_bar)		\
+	&pci_dev_resource##_bar##_attr_group,	\
+	&pci_dev_resource##_bar##_wc_attr_group
+
 #else /* !(defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)) */
 int __weak pci_create_resource_files(struct pci_dev *dev) { return 0; }
 void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
-- 
2.33.0

