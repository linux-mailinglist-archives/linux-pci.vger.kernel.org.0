Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1645DA54
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 13:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbhKYMv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 07:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354607AbhKYMvq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5F1D6112E;
        Thu, 25 Nov 2021 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844402;
        bh=Mty959mLbQPgGqYK1YgoWBQXMBWeDHeOIHaBNRXQLDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZ8jAeCM1FvwWsjUuBg22F3rqTn5Gxri9xshTqL27+M4DZFIHFMqelcZo4gZzIB7k
         YRWlQcuuT9pTyetEgh+/jrN1DhhrNriQJ+FSS/eA+8enUxQGrTvOvT3WmgRszWIa/r
         IiwwScu5hGrGYuD0e+Yz1Di/hTXGBBaoDr3wV5P/9RWhE9qr4uJEDOyYj5nXIVf4IJ
         hyXUkgYY7TSYEdyIQ27zD4WOUV8b5jL/Lvey24mJ5AimP73nJXvzofRa3vtK1Q5H3a
         sFz4rKoY3CghoBHbHSpaWLXcUUC+cnE9BobMHgArFX0kVd6uiJVP2P+8C3bmCx32XR
         ALDcUhSAkkHeg==
Received: by pali.im (Postfix)
        id A5A7867E; Thu, 25 Nov 2021 13:46:41 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] PCI: mvebu: Fix configuring secondary bus of PCIe Root Port via emulated bridge
Date:   Thu, 25 Nov 2021 13:46:01 +0100
Message-Id: <20211125124605.25915-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125124605.25915-1-pali@kernel.org>
References: <20211125124605.25915-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It looks like that mvebu PCIe controller has for each PCIe link fully
independent PCIe host bridge and so every PCIe Root Port is isolated not
only on its own bus but also isolated from each others. But in past device
tree structure was defined to put all PCIe Root Ports (as PCI Bridge
devices) into one root bus 0 and this bus is emulated by pci-mvebu.c
driver.

Probably reason for this decision was incorrect understanding of PCIe
topology of these Armada SoCs and also reason of misunderstanding how is
PCIe controller generating Type 0 and Type 1 config requests (it is fully
different compared to other drivers). Probably incorrect setup leaded to
very surprised things like having PCIe Root Port (PCI Bridge device, with
even incorrect Device Class set to Memory Controller) and the PCIe device
behind the Root Port on the same PCI bus, which obviously was needed to
somehow hack (as these two devices cannot be in reality on the same bus).

Properly set mvebu local bus number and mvebu local device number based on
PCI Bridge secondary bus number configuration. Also correctly report
configured secondary bus number in config space. And explain in driver
comment why this setup is correct.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 1f08673eef12 ("PCI: mvebu: Convert to PCI emulated bridge config space")
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-mvebu.c | 98 +++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 4edce441901c..36fbdc4f0e06 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -127,6 +127,11 @@ static bool mvebu_pcie_link_up(struct mvebu_pcie_port *port)
 	return !(mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_LINK_DOWN);
 }
 
+static u8 mvebu_pcie_get_local_bus_nr(struct mvebu_pcie_port *port)
+{
+	return (mvebu_readl(port, PCIE_STAT_OFF) & PCIE_STAT_BUS) >> 8;
+}
+
 static void mvebu_pcie_set_local_bus_nr(struct mvebu_pcie_port *port, int nr)
 {
 	u32 stat;
@@ -490,6 +495,20 @@ mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
 		*value = mvebu_readl(port, PCIE_CMD_OFF);
 		break;
 
+	case PCI_PRIMARY_BUS: {
+		/*
+		 * From the whole 32bit register we support reading from HW only
+		 * secondary bus number which is mvebu local bus number.
+		 * Other bits are retrieved only from emulated config buffer.
+		 */
+		__le32 *cfgspace = (__le32 *)&bridge->conf;
+		u32 val = le32_to_cpu(cfgspace[PCI_PRIMARY_BUS / 4]);
+		val &= ~0xff00;
+		val |= mvebu_pcie_get_local_bus_nr(port) << 8;
+		*value = val;
+		break;
+	}
+
 	default:
 		return PCI_BRIDGE_EMUL_NOT_HANDLED;
 	}
@@ -594,7 +613,8 @@ mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
 		break;
 
 	case PCI_PRIMARY_BUS:
-		mvebu_pcie_set_local_bus_nr(port, conf->secondary_bus);
+		if (mask & 0xff00)
+			mvebu_pcie_set_local_bus_nr(port, conf->secondary_bus);
 		break;
 
 	default:
@@ -1186,8 +1206,84 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		/*
+		 * PCIe topology exported by mvebu hw is quite complicated. In
+		 * reality has something like N fully independent host bridges
+		 * where each host bridge has one PCIe Root Port (which acts as
+		 * PCI Bridge device). Each host bridge has its own independent
+		 * internal registers, independent access to PCI config space,
+		 * independent interrupt lines, independent window and memory
+		 * access configuration. But additionally there is some kind of
+		 * peer-to-peer support between PCIe devices behind different
+		 * host bridges limited just to forwarding of memory and I/O
+		 * transactions (forwarding of error messages and config cycles
+		 * is not supported). So we could say there are N independent
+		 * PCIe Root Complexes.
+		 *
+		 * For this kind of setup DT should have been structured into
+		 * N independent PCIe controllers / host bridges. But instead
+		 * structure in past was defined to put PCIe Root Ports of all
+		 * host bridges into one bus zero, like in classic multi-port
+		 * Root Complex setup with just one host bridge.
+		 *
+		 * This means that pci-mvebu.c driver provides "virtual" bus 0
+		 * on which registers all PCIe Root Ports (PCI Bridge devices)
+		 * specified in DT by their BDF addresses and virtually routes
+		 * PCI config access of each PCI bridge device to specific PCIe
+		 * host bridge.
+		 *
+		 * Normally PCI Bridge should choose between Type 0 and Type 1
+		 * config requests based on primary and secondary bus numbers
+		 * configured on the bridge itself. But because mvebu PCI Bridge
+		 * does not have registers for primary and secondary bus numbers
+		 * in its config space, it determinates type of config requests
+		 * via its own custom way.
+		 *
+		 * There are two options how mvebu determinate type of config
+		 * request.
+		 *
+		 * 1. If Secondary Bus Number Enable bit is not set or is not
+		 * available (applies for pre-XP PCIe controllers) then Type 0
+		 * is used if target bus number equals Local Bus Number (bits
+		 * [15:8] in register 0x1a04) and target device number differs
+		 * from Local Device Number (bits [20:16] in register 0x1a04).
+		 * Type 1 is used if target bus number differs from Local Bus
+		 * Number. And when target bus number equals Local Bus Number
+		 * and target device equals Local Device Number then request is
+		 * routed to Local PCI Bridge (PCIe Root Port).
+		 *
+		 * 2. If Secondary Bus Number Enable bit is set (bit 7 in
+		 * register 0x1a2c) then mvebu hw determinate type of config
+		 * request like compliant PCI Bridge based on primary bus number
+		 * which is configured via Local Bus Number (bits [15:8] in
+		 * register 0x1a04) and secondary bus number which is configured
+		 * via Secondary Bus Number (bits [7:0] in register 0x1a2c).
+		 * Local PCI Bridge (PCIe Root Port) is available on primary bus
+		 * as device with Local Device Number (bits [20:16] in register
+		 * 0x1a04).
+		 *
+		 * Secondary Bus Number Enable bit is disabled by default and
+		 * option 2. is not available on pre-XP PCIe controllers. Hence
+		 * this driver always use option 1.
+		 *
+		 * Basically it means that primary and secondary buses shares
+		 * one virtual number configured via Local Bus Number bits and
+		 * Local Device Number bits determinates if accessing primary
+		 * or secondary bus. Set Local Device Number to 1 and redirect
+		 * all writes of PCI Bridge Secondary Bus Number register to
+		 * Local Bus Number (bits [15:8] in register 0x1a04).
+		 *
+		 * So when accessing devices on buses behind secondary bus
+		 * number it would work correctly. And also when accessing
+		 * device 0 at secondary bus number via config space would be
+		 * correctly routed to secondary bus. Due to issues described
+		 * in mvebu_pcie_setup_hw(), PCI Bridges at primary bus (zero)
+		 * are not accessed directly via PCI config space but rarher
+		 * indirectly via kernel emulated PCI bridge driver.
+		 */
 		mvebu_pcie_setup_hw(port);
 		mvebu_pcie_set_local_dev_nr(port, 1);
+		mvebu_pcie_set_local_bus_nr(port, 0);
 	}
 
 	bridge->sysdata = pcie;
-- 
2.20.1

