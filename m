Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAEE45DA55
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352392AbhKYMv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354618AbhKYMvq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFC5961131;
        Thu, 25 Nov 2021 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844403;
        bh=7IW9blK/IMJBVLWjKlB8p1LQPUnBoN7J+3jnRgIKmoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bln5kbB7dLx5PJDb/oLLEqvWOKQ1+NmzcCexth7QJp7mASDPM8LN05ujos6LP1die
         YP5RhuPz8TosihuoAqXObqM6Hz8IcdT/Rd23nd/YZP3U5KmMMqJLJg0srm3wRlrJ9z
         QKOj77j+j6CK2pcI/Zt/vVAuVZOXmEwrf89UzUUCdqWwJAc+T2dyiuTQT0gWExlN77
         MMD50tp2zFGhA2EsXUJ8Y475YGWs66fB8DAVeGB0vMhSgHIYz9GXdls6b1IhaBIw9d
         Dm91B52G/O1PUO8ZcUUUT67n383bila83NW/P2IQELZGPlCpMR+I4goKC0sddc80i2
         izijHrwr0gt3g==
Received: by pali.im (Postfix)
        id B096767E; Thu, 25 Nov 2021 13:46:42 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] PCI: mvebu: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated bridge
Date:   Thu, 25 Nov 2021 13:46:02 +0100
Message-Id: <20211125124605.25915-13-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hardware supports PCIe Hot Reset via PCIE_CTRL_OFF register. Use it for
implementing PCI_BRIDGE_CTL_BUS_RESET bit of PCI_BRIDGE_CONTROL register on
emulated bridge.

With this change the function pci_reset_secondary_bus() starts working and
can reset connected PCIe card.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1f08673eef12 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 36fbdc4f0e06..3075ea98c131 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -57,6 +57,7 @@
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
 #define  PCIE_CTRL_RC_MODE		BIT(1)
+#define  PCIE_CTRL_MASTER_HOT_RESET	BIT(24)
 #define PCIE_STAT_OFF		0x1a04
 #define  PCIE_STAT_BUS                  0xff00
 #define  PCIE_STAT_DEV                  0x1f0000
@@ -509,6 +510,22 @@ mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		break;
 	}
 
+	case PCI_INTERRUPT_LINE: {
+		/*
+		 * From the whole 32bit register we support reading from HW only
+		 * one bit: PCI_BRIDGE_CTL_BUS_RESET.
+		 * Other bits are retrieved only from emulated config buffer.
+		 */
+		__le32 *cfgspace = (__le32 *)&bridge->conf;
+		u32 val = le32_to_cpu(cfgspace[PCI_INTERRUPT_LINE / 4]);
+		if (mvebu_readl(port, PCIE_CTRL_OFF) & PCIE_CTRL_MASTER_HOT_RESET)
+			val |= PCI_BRIDGE_CTL_BUS_RESET << 16;
+		else
+			val &= ~(PCI_BRIDGE_CTL_BUS_RESET << 16);
+		*value = val;
+		break;
+	}
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -617,6 +634,17 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 			mvebu_pcie_set_local_bus_nr(port, conf->secondary_bus);
 		break;
 
+	case PCI_INTERRUPT_LINE:
+		if (mask & (PCI_BRIDGE_CTL_BUS_RESET << 16)) {
+			u32 ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
+			if (new & (PCI_BRIDGE_CTL_BUS_RESET << 16))
+				ctrl |= PCIE_CTRL_MASTER_HOT_RESET;
+			else
+				ctrl &= ~PCIE_CTRL_MASTER_HOT_RESET;
+			mvebu_writel(port, ctrl, PCIE_CTRL_OFF);
+		}
+		break;
+
 	default:
 		break;
 	}
-- 
2.20.1

