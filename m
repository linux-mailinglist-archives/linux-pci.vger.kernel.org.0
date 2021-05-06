Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC75E37576D
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhEFPfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235770AbhEFPeC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ABBD613C2;
        Thu,  6 May 2021 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315176;
        bh=YnX8Fz29kf60K0H0Lln7W4fAoz60MdG7mey2fziRxCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGwE/af0ZzxIt4YljcqEMGH5eX1G4XH0FH/wq+Wu6hGOXOHP5EeITwkQfvf51FGeC
         GCnpT701QVw8HwwEhHZFk1AaUsuuL8itj9fzS7YYndCijD17qAmaHdoKM3H1gGA+wu
         U0G3bzUuH3WT1bEes0ympfcQVARGKDmnkDuKV0tYxjJenwtxklvC4nBlL3+TwcpbPg
         XYLMT3gN3RovN8opGcjvQtwWdbSRUIQyV8irPJLXRtL1ZDC7gSt63FHQ+J65Nhxxx9
         jyBmvDS/SwzxblHuMWGp4e5Wigf/8tMtSQy85leCb1ECXTDpXX6joQ3eOe6sgkJeoM
         yJzLTerKqCSjQ==
Received: by pali.im (Postfix)
        id 249398A1; Thu,  6 May 2021 17:32:56 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 42/42] PCI: aardvark: Add support for Advanced Error Reporting registers on emulated bridge
Date:   Thu,  6 May 2021 17:31:53 +0200
Message-Id: <20210506153153.30454-43-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI aardvark hardware supports access to Advanced Error Reporting
configuration registers of PCIe core via PCIE_CORE_PCIERR_CAP.

Export them via emulated software root bridge through the new .read_ext and
.write_ext emulated bridge callbacks.

Note that in Advanced Error Reporting Capability header, the offset to the
next Extended Capability header is set, but it is not documented in Armada
3700 Functional Specification. As this change adds support only for
Advanced Error Reporting, explicitly clear PCI_EXT_CAP_NEXT bits in AER
capability header.

After this change, pcieport driver correctly detects AER support and allows
PCIe AER driver to start receiving ERR interrupts. It prints into dmesg:

    [    4.358401] pcieport 0000:00:00.0: AER: enabled with IRQ 52

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ac3ee48e69d7..8914af62ccc3 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -683,11 +683,85 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 	}
 }
 
+static pci_bridge_emul_read_status_t
+advk_pci_bridge_emul_ext_conf_read(struct pci_bridge_emul *bridge,
+				   int reg, u32 *value)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	case 0:
+		*value = advk_readl(pcie, PCIE_CORE_PCIERR_CAP + reg);
+		/*
+		 * Clear PCI_EXT_CAP_NEXT bits as they are set to 0x150 offset.
+		 * Armada 3700 Functional Specification does not contain any
+		 * documentation about registers at that address, so explicitly
+		 * mark Advanced Error Reporting Capability header as the end of
+		 * Extended Capabilities.
+		 */
+		*value &= 0x000fffff;
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	case PCI_ERR_UNCOR_STATUS:
+	case PCI_ERR_UNCOR_MASK:
+	case PCI_ERR_UNCOR_SEVER:
+	case PCI_ERR_COR_STATUS:
+	case PCI_ERR_COR_MASK:
+	case PCI_ERR_CAP:
+	case PCI_ERR_HEADER_LOG+0:
+	case PCI_ERR_HEADER_LOG+4:
+	case PCI_ERR_HEADER_LOG+8:
+	case PCI_ERR_HEADER_LOG+12:
+	case PCI_ERR_ROOT_COMMAND:
+	case PCI_ERR_ROOT_STATUS:
+	case PCI_ERR_ROOT_ERR_SRC:
+		*value = advk_readl(pcie, PCIE_CORE_PCIERR_CAP + reg);
+		return PCI_BRIDGE_EMUL_HANDLED;
+
+	default:
+		return PCI_BRIDGE_EMUL_NOT_HANDLED;
+	}
+}
+
+static void
+advk_pci_bridge_emul_ext_conf_write(struct pci_bridge_emul *bridge,
+				    int reg, u32 old, u32 new, u32 mask)
+{
+	struct advk_pcie *pcie = bridge->data;
+
+	switch (reg) {
+	/* These are W1C registers, so clear other bits */
+	case PCI_ERR_UNCOR_STATUS:
+	case PCI_ERR_COR_STATUS:
+	case PCI_ERR_ROOT_STATUS:
+		new &= mask;
+		fallthrough;
+
+	case PCI_ERR_UNCOR_MASK:
+	case PCI_ERR_UNCOR_SEVER:
+	case PCI_ERR_COR_MASK:
+	case PCI_ERR_CAP:
+	case PCI_ERR_HEADER_LOG+0:
+	case PCI_ERR_HEADER_LOG+4:
+	case PCI_ERR_HEADER_LOG+8:
+	case PCI_ERR_HEADER_LOG+12:
+	case PCI_ERR_ROOT_COMMAND:
+	case PCI_ERR_ROOT_ERR_SRC:
+		advk_writel(pcie, new, PCIE_CORE_PCIERR_CAP + reg);
+		break;
+
+	default:
+		break;
+	}
+}
+
 static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 	.read_base = advk_pci_bridge_emul_base_conf_read,
 	.write_base = advk_pci_bridge_emul_base_conf_write,
 	.read_pcie = advk_pci_bridge_emul_pcie_conf_read,
 	.write_pcie = advk_pci_bridge_emul_pcie_conf_write,
+	.read_ext = advk_pci_bridge_emul_ext_conf_read,
+	.write_ext = advk_pci_bridge_emul_ext_conf_write,
 };
 
 /*
-- 
2.20.1

