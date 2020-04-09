Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62651A3D17
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 01:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgDIXtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 19:49:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35438 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIXtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 19:49:35 -0400
Received: by mail-io1-f68.google.com with SMTP id w20so227059iob.2;
        Thu, 09 Apr 2020 16:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsFz03cVlyUKvUVnGieh3oxHpNilVECqAGJgEoC0c7M=;
        b=PolnOrYFBaaDITFG4zBKiw/HE5y8zPUxNIHHDV3rDxpT9TFsAwpLFatlqPFSZAWF0s
         MpcSz78jOpWFqVkv45s541vDG9aEyViOcrErn3SjTldoQavR8Bkp+TRbOakN/zdjfMHr
         t0WrZ8tt7nP8P5didB80eOsDEZVdxULZFRyqVh3fV02U+62Q2C89xK5vTtl73Y+tg0FX
         LwM+IloJQTFLmaNPZtTleatCe2BmtUGn5BVzMga8TI0zpxzaK5g5yndH8jL4mbqqaJ1X
         xJkITkLmBjfRmu3lClY+AjKqRqOTuOukDbSSrQZdvW/EEK1J2h+8zHH6ECXfIGcx2p6+
         qpWA==
X-Gm-Message-State: AGi0PuZzWHjCGL1YNfJil/PkWvrU0nhLMP8sBTSLVbRuX30+mYgJx1U5
        WjcK0KsRJ0Is1N+RMcEKCQ==
X-Google-Smtp-Source: APiQypLqrY1IbsEwkeqc1fPB7uBxtzjUwc62zIg6o0IpJEI79OSAmxl+HVZGBtZ2DF2+YhPeGl8i+w==
X-Received: by 2002:a02:9a0d:: with SMTP id b13mr2129894jal.60.1586476174014;
        Thu, 09 Apr 2020 16:49:34 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id w7sm93416ior.51.2020.04.09.16.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:49:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robert Richter <rrichter@marvell.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: host-generic: Eliminate pci_host_common_probe wrappers
Date:   Thu,  9 Apr 2020 17:49:23 -0600
Message-Id: <20200409234923.21598-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409234923.21598-1-robh@kernel.org>
References: <20200409234923.21598-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Most ECAM host drivers are just different pci_ecam_ops which can be DT
match table data. That's already the case in some cases, but let's
do that for all the ECAM drivers. Then we can use
of_device_get_match_data() in pci_host_common_probe() and eliminate the
probe wrapper functions and use pci_host_common_probe() directly for
probe.

Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-hisi.c    | 11 +----------
 drivers/pci/controller/pci-host-common.c  |  9 +++++++--
 drivers/pci/controller/pci-host-generic.c | 15 +--------------
 drivers/pci/controller/pci-thunder-ecam.c | 12 +++++-------
 drivers/pci/controller/pci-thunder-pem.c  | 12 +++++-------
 drivers/pci/controller/pcie-tango.c       |  7 +++++--
 include/linux/pci-ecam.h                  |  3 +--
 7 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 90017045334d..0ba50fb473b1 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -332,15 +332,6 @@ static struct platform_driver hisi_pcie_driver = {
 };
 builtin_platform_driver(hisi_pcie_driver);
 
-static int hisi_pcie_almost_ecam_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct pci_ecam_ops *ops;
-
-	ops = (struct pci_ecam_ops *)of_device_get_match_data(dev);
-	return pci_host_common_probe(pdev, ops);
-}
-
 static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -385,7 +376,7 @@ static const struct of_device_id hisi_pcie_almost_ecam_of_match[] = {
 };
 
 static struct platform_driver hisi_pcie_almost_ecam_driver = {
-	.probe  = hisi_pcie_almost_ecam_probe,
+	.probe  = pci_host_common_probe,
 	.driver = {
 		   .name = "hisi-pcie-almost-ecam",
 		   .of_match_table = hisi_pcie_almost_ecam_of_match,
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 6d15bc12e726..953de57f6c57 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
@@ -55,15 +56,19 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 	return ERR_PTR(err);
 }
 
-int pci_host_common_probe(struct platform_device *pdev,
-			  const struct pci_ecam_ops *ops)
+int pci_host_common_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
 	struct list_head resources;
+	const struct pci_ecam_ops *ops;
 	int ret;
 
+	ops = of_device_get_match_data(&pdev->dev);
+	if (!ops)
+		return -ENODEV;
+
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index fd8cff61de14..b51977abfdf1 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -11,8 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
@@ -79,23 +77,12 @@ static const struct of_device_id gen_pci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, gen_pci_of_match);
 
-static int gen_pci_probe(struct platform_device *pdev)
-{
-	const struct of_device_id *of_id;
-	struct pci_ecam_ops *ops;
-
-	of_id = of_match_node(gen_pci_of_match, pdev->dev.of_node);
-	ops = (struct pci_ecam_ops *)of_id->data;
-
-	return pci_host_common_probe(pdev, ops);
-}
-
 static struct platform_driver gen_pci_driver = {
 	.driver = {
 		.name = "pci-host-generic",
 		.of_match_table = gen_pci_of_match,
 	},
-	.probe = gen_pci_probe,
+	.probe = pci_host_common_probe,
 	.remove = pci_host_common_remove,
 };
 module_platform_driver(gen_pci_driver);
diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index c3fdd3e6b21c..7e8835fee5f7 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -357,22 +357,20 @@ const struct pci_ecam_ops pci_thunder_ecam_ops = {
 #ifdef CONFIG_PCI_HOST_THUNDER_ECAM
 
 static const struct of_device_id thunder_ecam_of_match[] = {
-	{ .compatible = "cavium,pci-host-thunder-ecam" },
+	{
+		.compatible = "cavium,pci-host-thunder-ecam",
+		.data = &pci_thunder_ecam_ops,
+	},
 	{ },
 };
 
-static int thunder_ecam_probe(struct platform_device *pdev)
-{
-	return pci_host_common_probe(pdev, &pci_thunder_ecam_ops);
-}
-
 static struct platform_driver thunder_ecam_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = thunder_ecam_of_match,
 		.suppress_bind_attrs = true,
 	},
-	.probe = thunder_ecam_probe,
+	.probe = pci_host_common_probe,
 };
 builtin_platform_driver(thunder_ecam_driver);
 
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index 2e792707ceab..3f847969143e 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -451,22 +451,20 @@ static const struct pci_ecam_ops pci_thunder_pem_ops = {
 };
 
 static const struct of_device_id thunder_pem_of_match[] = {
-	{ .compatible = "cavium,pci-host-thunder-pem" },
+	{
+		.compatible = "cavium,pci-host-thunder-pem",
+		.data = &pci_thunder_pem_ops,
+	},
 	{ },
 };
 
-static int thunder_pem_probe(struct platform_device *pdev)
-{
-	return pci_host_common_probe(pdev, &pci_thunder_pem_ops);
-}
-
 static struct platform_driver thunder_pem_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = thunder_pem_of_match,
 		.suppress_bind_attrs = true,
 	},
-	.probe = thunder_pem_probe,
+	.probe = pci_host_common_probe,
 };
 builtin_platform_driver(thunder_pem_driver);
 
diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index 3b2b10906fdd..c56c5539da6b 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -295,11 +295,14 @@ static int tango_pcie_probe(struct platform_device *pdev)
 	spin_lock_init(&pcie->used_msi_lock);
 	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
 
-	return pci_host_common_probe(pdev, &smp8759_ecam_ops);
+	return pci_host_common_probe(pdev);
 }
 
 static const struct of_device_id tango_pcie_ids[] = {
-	{ .compatible = "sigma,smp8759-pcie" },
+	{
+		.compatible = "sigma,smp8759-pcie",
+		.data = &smp8759_ecam_ops,
+ 	},
 	{ },
 };
 
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index fd0edb8b8a00..1af5cb02ef7f 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -61,8 +61,7 @@ extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
 
 #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
 /* for DT-based PCI controllers that support ECAM */
-int pci_host_common_probe(struct platform_device *pdev,
-			  const struct pci_ecam_ops *ops);
+int pci_host_common_probe(struct platform_device *pdev);
 int pci_host_common_remove(struct platform_device *pdev);
 #endif
 #endif
-- 
2.20.1

