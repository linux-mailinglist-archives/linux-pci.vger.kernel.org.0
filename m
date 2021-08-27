Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECD3F9624
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhH0Id1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 04:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231869AbhH0IdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 04:33:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C21260F4F;
        Fri, 27 Aug 2021 08:32:35 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH V4 01/10] PCI/VGA: Move vgaarb to drivers/pci
Date:   Fri, 27 Aug 2021 16:31:20 +0800
Message-Id: <20210827083129.2781420-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210827083129.2781420-1-chenhuacai@loongson.cn>
References: <20210827083129.2781420-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The VGA arbiter is really PCI-specific and doesn't depend on any GPU
things.  Move it to the PCI subsystem.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/Kconfig           | 19 -------------------
 drivers/gpu/vga/Makefile          |  1 -
 drivers/pci/Kconfig               | 19 +++++++++++++++++++
 drivers/pci/Makefile              |  1 +
 drivers/{gpu/vga => pci}/vgaarb.c |  0
 5 files changed, 20 insertions(+), 20 deletions(-)
 rename drivers/{gpu/vga => pci}/vgaarb.c (100%)

diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index 1ad4c4ef0b5e..eb8b14ab22c3 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -1,23 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config VGA_ARB
-	bool "VGA Arbitration" if EXPERT
-	default y
-	depends on (PCI && !S390)
-	help
-	  Some "legacy" VGA devices implemented on PCI typically have the same
-	  hard-decoded addresses as they did on ISA. When multiple PCI devices
-	  are accessed at same time they need some kind of coordination. Please
-	  see Documentation/gpu/vgaarbiter.rst for more details. Select this to
-	  enable VGA arbiter.
-
-config VGA_ARB_MAX_GPUS
-	int "Maximum number of GPUs"
-	default 16
-	depends on VGA_ARB
-	help
-	  Reserves space in the kernel to maintain resource locking for
-	  multiple GPUS.  The overhead for each GPU is very small.
-
 config VGA_SWITCHEROO
 	bool "Laptop Hybrid Graphics - GPU switching support"
 	depends on X86
diff --git a/drivers/gpu/vga/Makefile b/drivers/gpu/vga/Makefile
index e92064442d60..9800620deda3 100644
--- a/drivers/gpu/vga/Makefile
+++ b/drivers/gpu/vga/Makefile
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_VGA_ARB)  += vgaarb.o
 obj-$(CONFIG_VGA_SWITCHEROO) += vga_switcheroo.o
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c473d75e625..7c9e56d7b857 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -252,6 +252,25 @@ config PCIE_BUS_PEER2PEER
 
 endchoice
 
+config VGA_ARB
+	bool "VGA Arbitration" if EXPERT
+	default y
+	depends on (PCI && !S390)
+	help
+	  Some "legacy" VGA devices implemented on PCI typically have the same
+	  hard-decoded addresses as they did on ISA. When multiple PCI devices
+	  are accessed at same time they need some kind of coordination. Please
+	  see Documentation/gpu/vgaarbiter.rst for more details. Select this to
+	  enable VGA arbiter.
+
+config VGA_ARB_MAX_GPUS
+	int "Maximum number of GPUs"
+	default 16
+	depends on VGA_ARB
+	help
+	  Reserves space in the kernel to maintain resource locking for
+	  multiple GPUS.  The overhead for each GPU is very small.
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index d62c4ac4ae1b..ebe720f69b15 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PCI_PF_STUB)	+= pci-pf-stub.o
 obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
+obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/pci/vgaarb.c
similarity index 100%
rename from drivers/gpu/vga/vgaarb.c
rename to drivers/pci/vgaarb.c
-- 
2.27.0

