Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483AE76BC4
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfGZOkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jul 2019 10:40:17 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55634 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGZOkQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2019 10:40:16 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C5DBF5C0AF6;
        Fri, 26 Jul 2019 16:40:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1564152014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=xXvBZt2loW2wVxqkmYT2gOg2/wgOnSpx+FICc1eWU54=;
        b=k9OCOvip8cfpxfzJ+aCk4Ob+jtjM6XQpjG//Qj50KO9qpJf6DvIcJ3OsXLnmZ8c0KtYJJL
        F8XNABsdDGAMDTg3ig/0Ei/+O4IEi9QElFxC0znKyK9HWZaPv6exN4sNtGkHnLOL1UCpCs
        aCLiQcPUKou8JhOQEFt43V8mvACOQbM=
From:   Stefan Agner <stefan@agner.ch>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, tpiepho@impinj.com,
        leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH RESEND v8] PCI: imx6: limit DBI register length
Date:   Fri, 26 Jul 2019 16:40:07 +0200
Message-Id: <20190726144007.26605-1-stefan@agner.ch>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define the length of the DBI registers and limit config space to its
length. This makes sure that the kernel does not access registers
beyond that point, avoiding the following abort on a i.MX 6Quad:
  # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
  [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
  ...
  [  100.056423] PC is at dw_pcie_read+0x50/0x84
  [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
  ...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v3:
- Rebase on pci/dwc
Changes in v4:
- Rebase on pci/dwc
Changes in v5:
- Rebased ontop of pci/dwc
- Use DBI length of 0x200
Changes in v6:
- Use pci_dev.cfg_size mechanism to limit config space (this made patch 1
  of previous versions of this patchset obsolete).
Changes in v7:
- Restrict fixup to Synopsys/0xabcd
- Apply cfg_size limitation only if dbi_length is specified
Changes in v8:
- Restrict fixup for Synopsys/0xabcd and class PCI bridge
- Check device driver to be pci-imx6

 drivers/pci/controller/dwc/pci-imx6.c | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9b5cb5b70389..8b8efa3063f5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -57,6 +57,7 @@ enum imx6_pcie_variants {
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	u32 flags;
+	int dbi_length;
 };
 
 struct imx6_pcie {
@@ -1212,6 +1213,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX6Q,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+		.dbi_length = 0x200,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1254,6 +1256,37 @@ static struct platform_driver imx6_pcie_driver = {
 	.shutdown = imx6_pcie_shutdown,
 };
 
+static void imx6_pcie_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pcie_port *pp = bus->sysdata;
+
+	/* Bus parent is the PCI bridge, its parent is this platform driver */
+	if (!bus->dev.parent || !bus->dev.parent->parent)
+		return;
+
+	/* Make sure we only quirk devices associated with this driver */
+	if (bus->dev.parent->parent->driver != &imx6_pcie_driver.driver)
+		return;
+
+	if (bus->number == pp->root_bus_nr) {
+		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+		/*
+		 * Limit config length to avoid the kernel reading beyond
+		 * the register set and causing an abort on i.MX 6Quad
+		 */
+		if (imx6_pcie->drvdata->dbi_length) {
+			dev->cfg_size = imx6_pcie->drvdata->dbi_length;
+			dev_info(&dev->dev, "Limiting cfg_size to %d\n",
+					dev->cfg_size);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
+			PCI_CLASS_BRIDGE_PCI, 8, imx6_pcie_quirk);
+
 static int __init imx6_pcie_init(void)
 {
 #ifdef CONFIG_ARM
-- 
2.22.0

