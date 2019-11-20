Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB48C103C1D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfKTNko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 08:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbfKTNkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:43 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B7222528;
        Wed, 20 Nov 2019 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257243;
        bh=5dgLwV0bZt3GcdVTr26oMTVvZYWZr57SNUE+QxYGXDU=;
        h=From:To:Cc:Subject:Date:From;
        b=IbQ0hrxI3iau/m/kYqnq45+w2tafjS8Avec+zY5r13Hf8wzfAjIxVxnBCS8Gh0vBF
         ICDXSX8AY9hm4omYt9enGyLj4Sjrq8N/t6VhFLgaW03RrJpHQO6ClJyqUrZQ+nbf98
         JXGLErJgTfojOH9mjHBRuHA/BxnQkjwA4+Hsh+1k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] pci: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:36 +0800
Message-Id: <20191120134036.14502-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pci/Kconfig                | 24 ++++++++++++------------
 drivers/pci/controller/dwc/Kconfig |  6 +++---
 drivers/pci/hotplug/Kconfig        |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 77c1428cd945..4bef5c2bae9f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -106,14 +106,14 @@ config PCI_PF_STUB
 	  When in doubt, say N.
 
 config XEN_PCIDEV_FRONTEND
-        tristate "Xen PCI Frontend"
-        depends on X86 && XEN
-        select PCI_XEN
+	tristate "Xen PCI Frontend"
+	depends on X86 && XEN
+	select PCI_XEN
 	select XEN_XENBUS_FRONTEND
-        default y
-        help
-          The PCI device frontend driver allows the kernel to import arbitrary
-          PCI devices from a PCI backend to support PCI driver domains.
+	default y
+	help
+	  The PCI device frontend driver allows the kernel to import arbitrary
+	  PCI devices from a PCI backend to support PCI driver domains.
 
 config PCI_ATS
 	bool
@@ -180,12 +180,12 @@ config PCI_LABEL
 	select NLS
 
 config PCI_HYPERV
-        tristate "Hyper-V PCI Frontend"
-        depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
+	tristate "Hyper-V PCI Frontend"
+	depends on X86_64 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
 	select PCI_HYPERV_INTERFACE
-        help
-          The PCI device frontend driver allows the kernel to import arbitrary
-          PCI devices from a PCI backend to support PCI driver domains.
+	help
+	  The PCI device frontend driver allows the kernel to import arbitrary
+	  PCI devices from a PCI backend to support PCI driver domains.
 
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0ba988b5b5bc..625a031b2193 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -7,9 +7,9 @@ config PCIE_DW
 	bool
 
 config PCIE_DW_HOST
-        bool
+	bool
 	depends on PCI_MSI_IRQ_DOMAIN
-        select PCIE_DW
+	select PCIE_DW
 
 config PCIE_DW_EP
 	bool
@@ -224,7 +224,7 @@ config PCIE_HISI_STB
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
-          Say Y here if you want PCIe controller support on HiSilicon STB SoCs
+	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
 
 config PCI_MESON
 	bool "MESON PCIe controller"
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index e7b493c22bf3..32455a79372d 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -83,7 +83,7 @@ config HOTPLUG_PCI_CPCI_ZT5550
 	depends on HOTPLUG_PCI_CPCI && X86
 	help
 	  Say Y here if you have an Performance Technologies (formerly Intel,
-          formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
+	  formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpcihp_zt5550.
-- 
2.17.1

