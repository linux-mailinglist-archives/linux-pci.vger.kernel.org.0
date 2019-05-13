Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DBF1BCE2
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfEMSJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:09:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13563 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732296AbfEMSJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:09:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2cc0000>; Mon, 13 May 2019 11:09:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:09:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:09:20 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:09:20 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:09:16 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 22/29] PCI: tegra: Access endpoint config only if PCIe link is up
Date:   Mon, 13 May 2019 23:37:37 +0530
Message-ID: <20190513180744.16493-23-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513180744.16493-1-mmaddireddy@nvidia.com>
References: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770956; bh=xXlsRpMxcGNM8a62Knw1OwFUnD+sqr/re3xlYPKt+qA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FAuqRJjO1j8s8ksHGJsC1LwRem7chW0yJvVkMHdYvwqPeRFrpIRropgrTmuM+tFl3
         ReFNqahbnTrWMJege7MdboGMHIHreBmeHLIHz295Kp37qx3r5dgipiT0bt7vZ2sPC5
         X/WFz7xul1TX8xkOcIBJGmf7qKB8y1SpT/DAOo4WHMX3X47g6OiwATMxt03bwmupGF
         2DhMEkb5K5AMInut8I2AHyikroQDXnhiuIOJuyzhic3fe41m95cqENeurv8x/wHoMH
         KUwLNZsy363PmFM0Pjl3+fPw0451Rp64azLEDA0fPczr61GYnTPGLL598YTNLf7moU
         ApeP4CHVUVrvA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few endpoints like Wi-Fi supports power on/off and to leverage that
root port must support hot-plug and hot-unplug. Tegra PCIe doesn't
support hot-plug and hot-unplug, however it supports endpoint power
on/off feature as follows,
 - Power off sequence:
   - Transition of PCIe link to L2
   - Power off endpoint
   - Leave root port in power up state with the link in L2
 - Power on sequence:
   - Power on endpoint
   - Apply hot reset to get PCIe link up

PCIe client driver stops accessing PCIe endpoint config and BAR registers
after endpoint is powered off. However, software applications like x11
server or lspci can access endpoint config registers in which case
host controller raises "response decoding" errors. To avoid this scenario,
add PCIe link up check in config read and write callback functions before
accessing endpoint config registers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V3: Update the commit log with explanation for the need of this patch

V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()

 drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d20c88a79e00..33f4dfab9e35 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
 	return readl(pcie->pads + offset);
 }
 
+static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
+{
+	u32 value;
+
+	value = readl(port->base + RP_LINK_CONTROL_STATUS);
+	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
+}
+
 /*
  * The configuration space mapping on Tegra is somewhat similar to the ECAM
  * defined by PCIe. However it deviates a bit in how the 4 bits for extended
@@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *value)
 {
+	struct tegra_pcie *pcie = bus->sysdata;
+	struct pci_dev *bridge;
+	struct tegra_pcie_port *port;
+
 	if (bus->number == 0)
 		return pci_generic_config_read32(bus, devfn, where, size,
 						 value);
 
+	bridge = pcie_find_root_port(bus->self);
+
+	list_for_each_entry(port, &pcie->ports, list)
+		if (port->index + 1 == PCI_SLOT(bridge->devfn))
+			break;
+
+	/* If there is no link, then there is no device */
+	if (!tegra_pcie_link_up(port)) {
+		*value = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
 	return pci_generic_config_read(bus, devfn, where, size, value);
 }
 
 static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 value)
 {
+	struct tegra_pcie *pcie = bus->sysdata;
+	struct tegra_pcie_port *port;
+	struct pci_dev *bridge;
+
 	if (bus->number == 0)
 		return pci_generic_config_write32(bus, devfn, where, size,
 						  value);
 
+	bridge = pcie_find_root_port(bus->self);
+
+	list_for_each_entry(port, &pcie->ports, list)
+		if (port->index + 1 == PCI_SLOT(bridge->devfn))
+			break;
+
+	/* If there is no link, then there is no device */
+	if (!tegra_pcie_link_up(port))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	return pci_generic_config_write(bus, devfn, where, size, value);
 }
 
-- 
2.17.1

