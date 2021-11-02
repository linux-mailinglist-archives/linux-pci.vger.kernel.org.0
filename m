Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE19443469
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 18:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhKBRPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 13:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhKBRPw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 13:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACFD561051;
        Tue,  2 Nov 2021 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635873197;
        bh=G1om8c0vcFzwgqgDeCK6eQYDL8ECQ2Fb4KIp+WlFoDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1lOwW8/97VvuJii5R7+ucTEe7y0m0FA2LMnjF/3qzpbtU2cXiSfu0UDdvLzV4Lly
         z9xUXM+uU7XcJb6qKlG97ZM2Wf7axTSMYhm4O4LftgMELqiNu5sYOlfVhOdhupxfXp
         XmwzrozrQ/8/ULq8ir3TaggKp8c4UGqDcvgHHgVsch/HvknhH4I2lbogJynq4XUWEd
         Vmz5NW6ZT2Jow5ZQ9F+rP6qEzNQv1k5DCMpFgEA+jJdwIgBiFleNEeMxvDXZEPCcER
         qH4IOn6asXr+3HAh3v6PS8wzbXurECYsCNp5QAQ5Pp1gQwGXZex9g9MUC+xQX23QqC
         3HM+aiiUpvyyQ==
Received: by pali.im (Postfix)
        id 42803A41; Tue,  2 Nov 2021 18:13:14 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: Marvell: Update PCIe fixup
Date:   Tue,  2 Nov 2021 18:12:58 +0100
Message-Id: <20211102171259.9590-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211101150405.14618-1-pali@kernel.org>
References: <20211101150405.14618-1-pali@kernel.org>
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
PCI-E fixup") for all other Marvell ARM platforms which have same buggy
PCIe controller and do not use pci-mvebu.c controller driver yet.

Long-term goal for these Marvell ARM platforms should be conversion to
pci-mvebu.c controller driver and removal of these fixups in arch code.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: stable@vger.kernel.org

---
Changes in v2:
* Move MIPS change into separate patch
* Add information that this patch is for platforms which do not use pci-mvebu.c
---
 arch/arm/Kconfig              |  1 +
 arch/arm/mach-dove/pcie.c     | 11 ++++++++---
 arch/arm/mach-mv78xx0/pcie.c  | 11 ++++++++---
 arch/arm/mach-orion5x/Kconfig |  1 +
 arch/arm/mach-orion5x/pci.c   | 12 +++++++++---
 5 files changed, 27 insertions(+), 9 deletions(-)

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
-- 
2.20.1

