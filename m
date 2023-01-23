Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEC2677E1D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 15:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjAWOcr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 09:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjAWOco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 09:32:44 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C516C673;
        Mon, 23 Jan 2023 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674484362;
  x=1706020362;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=1RiHrwj6ISB7lKtNwWNe0bcD7KzheIvmO/6WEMs8K5k=;
  b=PanAXpHfYvkoUSB4r4BNj818WVY5h/V3Aq1oaiW6Tp67j/D+MvqjxdiK
   TfJsxOAiOZlI6OQMCW0jkCF8Fsjpub4SrWFRa9fyWfL8BSlSghpeb76sF
   LrI2DGO1oi/quavQeWXhoVL+5o/h2ynIZzbG30/RgCg0g7DnjegKTtjtk
   1xnHuddvmBX921Vt4/QlAHUpxc0wiOnuDkuZY9aaqwHGyZ+ILyLcr/MaR
   yQkGu72Bp1mRt73L93A/mijwD3XvnYjNnidZYOYVqxKLnr4eN57KN9NgP
   w57X59e95wQ895QQ/F298+S0ondpgH0/2omXlQxcwo6tbhLm+c374/ZNI
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Mon, 23 Jan 2023 15:32:31 +0100
Subject: [PATCH] mfd: Add Simple PCI MFD driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com>
X-B4-Tracking: v=1; b=H4sIAH+azmMC/x2NywqDMBAAf0X27MKatgf7K+Ihj01daNKQFSmI/
 270OAPD7KBchRXe3Q6VN1H55QZD34FfbP4wSmgMhsyDBkOoksqXMcWAxQu+npHC6EYK0UOLnFVG
 V232y5WtqVy2VI7yvzfTfBwny19zpHYAAAA=
To:     Lee Jones <lee@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.11.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a PCI driver which registers all child nodes specified in the
devicetree.  It will allow platform devices to be used on virtual
systems which already support PCI and devicetree, such as UML with
virt-pci.

The driver has no id_table by default; user space needs to provide one
using the new_id mechanism in sysfs.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mfd/Kconfig          | 11 +++++++++++
 drivers/mfd/Makefile         |  1 +
 drivers/mfd/simple-mfd-pci.c | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 30db49f31866..1e325334e9ae 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1277,6 +1277,17 @@ config MFD_SIMPLE_MFD_I2C
 	  sub-devices represented by child nodes in Device Tree will be
 	  subsequently registered.
 
+config MFD_SIMPLE_MFD_PCI
+	tristate "Simple Multi-Functional Device support (PCI)"
+	depends on PCI
+	depends on OF || COMPILE_TEST
+	help
+	  This enables support for a PCI driver for which any sub-devices
+	  represented by child nodes in the devicetree will be registered.
+
+	  The driver does not bind to any devices by default; that should
+	  be done via sysfs using new_id.
+
 config MFD_SL28CPLD
 	tristate "Kontron sl28cpld Board Management Controller"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 457471478a93..7ae329039a13 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -268,6 +268,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
+obj-$(CONFIG_MFD_SIMPLE_MFD_PCI)	+= simple-mfd-pci.o
 obj-$(CONFIG_MFD_SMPRO)		+= smpro-core.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
 
diff --git a/drivers/mfd/simple-mfd-pci.c b/drivers/mfd/simple-mfd-pci.c
new file mode 100644
index 000000000000..c5b2540e924a
--- /dev/null
+++ b/drivers/mfd/simple-mfd-pci.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+
+static int simple_mfd_pci_probe(struct pci_dev *pdev,
+				const struct pci_device_id *id)
+{
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static struct pci_driver simple_mfd_pci_driver = {
+	/* No id_table, use new_id in sysfs */
+	.name = "simple-mfd-pci",
+	.probe = simple_mfd_pci_probe,
+};
+
+module_pci_driver(simple_mfd_pci_driver);
+
+MODULE_LICENSE("GPL");

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230120-simple-mfd-pci-54f0d9b90dfc

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>
