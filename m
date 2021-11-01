Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A181441D18
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 16:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhKAPHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 11:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAPHF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 11:07:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4144A610E5;
        Mon,  1 Nov 2021 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635779072;
        bh=srzdJY9DWsUKRRAlTPJse3oqP8KifB/YE/m+79Y120Q=;
        h=From:To:Cc:Subject:Date:From;
        b=GbGBjVYfDh1Pco0glqRhlXRHXsV7rrGtNpR0ZwIxjjxIYexkPQaaIlNqQxEh1CQgG
         W9Eamhl6YArcSag1szCYnSeQmg+NfDHZb5+IuvYxkF2+1f9K0KXalaymH+oxriT8/z
         tuuflinGydpplfKnO3Xw0JM2Lgll37xS4Fb4krS43L+fk0ykGAfcNJ2j1YFyp3QVoq
         ZxcntX+zDoT8vFnhk/UOkPnT12fGsl6sPzH+8UFfYQe0nS8rGTTFls2AN6E2Y4BJQW
         ZgNy3xdpnFkQnf1nbO0x8uagUIDm4iT8WneIR1x5tWcuQcOkLThOF5wM4x4OTEnuBa
         RVMHU7t3KkUEg==
Received: by pali.im (Postfix)
        id DA02C7E4; Mon,  1 Nov 2021 16:04:29 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Marvell: Update PCIe fixup
Date:   Mon,  1 Nov 2021 16:04:05 +0100
Message-Id: <20211101150405.14618-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- The code relies on rc_pci_fixup being called, which only happens
  when CONFIG_PCI_QUIRKS is enabled, so add that to Kconfig. Omitting
  this causes a booting failure with a non-obvious cause.
- Update rc_pci_fixup to set the class properly, copying the
  more modern style from other places
- Correct the rc_pci_fixup comment

This patch just re-applies commit 1dc831bf53fd ("ARM: Kirkwood: Update
PCI-E fixup") for all other Marvell platforms which use same buggy PCIe
controller.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: stable@vger.kernel.org
---
 arch/arm/Kconfig              |  1 +
 arch/arm/mach-dove/pcie.c     | 11 ++++++++---
 arch/arm/mach-mv78xx0/pcie.c  | 11 ++++++++---
 arch/arm/mach-orion5x/Kconfig |  1 +
 arch/arm/mach-orion5x/pci.c   | 12 +++++++++---
 arch/mips/Kconfig             |  1 +
 arch/mips/pci/fixup-cobalt.c  |  6 ++++++
 7 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fc196421b2ce..9f157e973555 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -400,6 +400,7 @@ config ARCH_DOVE
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_PCI
+	select PCI_QUIRKS if PCI
 	select MVEBU_MBUS
 	select PINCTRL
 	select PINCTRL_DOVE
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index ee91ac6b5ebf..ecf057a0f5ba 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -135,14 +135,19 @@ static struct pci_ops pcie_ops = {
 	.write = pcie_wr_conf,
 };
 
+/*
+ * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
+ * is operating as a root complex this needs to be switched to
+ * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
+ * the device. Decoding setup is handled by the orion code.
+ */
 static void rc_pci_fixup(struct pci_dev *dev)
 {
-	/*
-	 * Prevent enumeration of root complex.
-	 */
 	if (dev->bus->parent == NULL && dev->devfn == 0) {
 		int i;
 
+		dev->class &= 0xff;
+		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 			dev->resource[i].start = 0;
 			dev->resource[i].end   = 0;
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 636d84b40466..9362b5fc116f 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -177,14 +177,19 @@ static struct pci_ops pcie_ops = {
 	.write = pcie_wr_conf,
 };
 
+/*
+ * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
+ * is operating as a root complex this needs to be switched to
+ * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
+ * the device. Decoding setup is handled by the orion code.
+ */
 static void rc_pci_fixup(struct pci_dev *dev)
 {
-	/*
-	 * Prevent enumeration of root complex.
-	 */
 	if (dev->bus->parent == NULL && dev->devfn == 0) {
 		int i;
 
+		dev->class &= 0xff;
+		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 			dev->resource[i].start = 0;
 			dev->resource[i].end   = 0;
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index e94a61901ffd..7189a5b1ec46 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_ORION5X
 	select GPIOLIB
 	select MVEBU_MBUS
 	select FORCE_PCI
+	select PCI_QUIRKS
 	select PHYLIB if NETDEVICES
 	select PLAT_ORION_LEGACY
 	help
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bfbacf5..5145fe89702e 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -509,14 +509,20 @@ static int __init pci_setup(struct pci_sys_data *sys)
 /*****************************************************************************
  * General PCIe + PCI
  ****************************************************************************/
+
+/*
+ * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
+ * is operating as a root complex this needs to be switched to
+ * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
+ * the device. Decoding setup is handled by the orion code.
+ */
 static void rc_pci_fixup(struct pci_dev *dev)
 {
-	/*
-	 * Prevent enumeration of root complex.
-	 */
 	if (dev->bus->parent == NULL && dev->devfn == 0) {
 		int i;
 
+		dev->class &= 0xff;
+		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 			dev->resource[i].start = 0;
 			dev->resource[i].end   = 0;
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 771ca53af06d..c8d51bd20b84 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -346,6 +346,7 @@ config MIPS_COBALT
 	select CEVT_GT641XX
 	select DMA_NONCOHERENT
 	select FORCE_PCI
+	select PCI_QUIRKS
 	select I8253
 	select I8259
 	select IRQ_MIPS_CPU
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index 44be65c3e6bb..202f3a0bd97d 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -36,6 +36,12 @@
 #define VIA_COBALT_BRD_ID_REG  0x94
 #define VIA_COBALT_BRD_REG_to_ID(reg)	((unsigned char)(reg) >> 4)
 
+/*
+ * The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
+ * is operating as a root complex this needs to be switched to
+ * PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
+ * the device. Decoding setup is handled by the orion code.
+ */
 static void qube_raq_galileo_early_fixup(struct pci_dev *dev)
 {
 	if (dev->devfn == PCI_DEVFN(0, 0) &&
-- 
2.20.1

