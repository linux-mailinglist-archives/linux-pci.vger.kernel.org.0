Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4432542A9C8
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhJLQoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhJLQoI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:44:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49F1E608FE;
        Tue, 12 Oct 2021 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056926;
        bh=A7KXi+Zwk8hcitOOVk07yzSIAKQxKQCRJEkIfaWieyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqPskwu7dKEbG7fJVfH061wzQxt6p2PtQbU6aBxA+85BoUEOEpHjvbhNR8AdicUzY
         4l4UDCixbAWj/HasQ2VbATktSqAEvdBC6em1uqHNgs/gce+rb17srlW7g81mjMktf0
         TctDp/N1ksuxQqlC0n6lvPEaeUcxDSDovtMCmo4wuqs7cnM7Yu5j+WQT5z10D4Jmji
         OBNJ5uk/1idYpY0DP2/lNg8+V31NIM3Vg42D+uKFHRSisfCLrXp1vV5YV5PvolBc9M
         KeljPLKloNVL4mimDJm0/H7+iHQR5XsbTO04fQKkv+F6B6m+eZRd2Eq/1YF0cGW48e
         9gXCZRfJPZ35A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 13/14] PCI: aardvark: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge
Date:   Tue, 12 Oct 2021 18:41:44 +0200
Message-Id: <20211012164145.14126-14-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Aardvark supports PCIe Hot Reset via PCIE_CORE_CTRL1_REG.

Use it for implementing PCI_BRIDGE_CTL_BUS_RESET bit of PCI_BRIDGE_CONTROL
register on emulated bridge.

With this, the function pci_reset_secondary_bus() starts working and can
reset connected PCIe card. Custom userspace script [1] which uses setpci
can trigger PCIe Hot Reset and reset the card manually.

[1] https://alexforencich.com/wiki/en/pcie/hot-reset-linux

Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 801657e7da93..ad31a172c5c2 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -781,6 +781,22 @@ advk_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		*value = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
 		return PCI_BRIDGE_EMUL_HANDLED;
 
+	case PCI_INTERRUPT_LINE: {
+		/*
+		 * From the whole 32bit register we support reading from HW only
+		 * one bit: PCI_BRIDGE_CTL_BUS_RESET.
+		 * Other bits are retrieved only from emulated config buffer.
+		 */
+		__le32 *cfgspace = (__le32 *)&bridge->conf;
+		u32 val = le32_to_cpu(cfgspace[PCI_INTERRUPT_LINE / 4]);
+		if (advk_readl(pcie, PCIE_CORE_CTRL1_REG) & HOT_RESET_GEN)
+			val |= PCI_BRIDGE_CTL_BUS_RESET << 16;
+		else
+			val &= ~(PCI_BRIDGE_CTL_BUS_RESET << 16);
+		*value = val;
+		return PCI_BRIDGE_EMUL_HANDLED;
+	}
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -797,6 +813,17 @@ advk_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		advk_writel(pcie, new, PCIE_CORE_CMD_STATUS_REG);
 		break;
 
+	case PCI_INTERRUPT_LINE:
+		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
+			u32 val = advk_readl(pcie, PCIE_CORE_CTRL1_REG);
+			if (new & (PCI_BRIDGE_CTL_BUS_RESET << 16))
+				val |= HOT_RESET_GEN;
+			else
+				val &= ~HOT_RESET_GEN;
+			advk_writel(pcie, val, PCIE_CORE_CTRL1_REG);
+		}
+		break;
+
 	default:
 		break;
 	}
-- 
2.32.0

