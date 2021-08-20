Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E500E3F3100
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhHTQGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 12:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229619AbhHTQCa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 12:02:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 895B561354;
        Fri, 20 Aug 2021 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629475312;
        bh=78IR/EQoyvmDQWCnnDOdjLShYpeojXRJBTg83Xksn9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cg8AXYyfBSV2w8XZXtZFhZqDVzBiH1OnG5Eb5QxXbTIK8B+vulV0W4eoXHYjFXPAi
         ConeToGdxlsPwS4GxGRlOVb0/HiFIHq9l4OdiJt2Bw57tVz94aB5S1Qxej1l4EVuI1
         ClG7XdQ9JQicU+Ckv3XCkzVUhHNGvI2t98yvhOEzAOcO5745kzr9YgLaxqsUmKzHSq
         D0t770ByxB6Bc7UHaKOaZLVppSo+VbwcXQwvr5yT9mYSxa5fgONGOcAgkkalD0WghY
         zUAki5NDYD4cJa2OiNjntXi/pXrlGB1a/6jcx0UVPKIIwEk29Kln1dTsQY5JnCbiY9
         8fykkY9bvXC3A==
Received: by pali.im (Postfix)
        id AC2C6B98; Fri, 20 Aug 2021 18:01:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] PCI: aardvark: Add support for sending Set_Slot_Power_Limit message
Date:   Fri, 20 Aug 2021 18:00:22 +0200
Message-Id: <20210820160023.3243-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210820160023.3243-1-pali@kernel.org>
References: <20210820160023.3243-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCIe Base specification 3.0, when transitioning from a
non-DL_Up Status to a DL_Up Status, the Port must initiate the
transmission of a Set_Slot_Power_Limit Message to the other component
on the Link to convey the value programmed in the Slot Power Limit
Scale and Value fields of the Slot Capabilities register. This
Transmission is optional if the Slot Capabilities register has not
yet been initialized.

As PCIe Root Bridge is emulated by kernel emulate readback of Slot Power
Limit Scale and Value bits in Slot Capabilities register.

Also send that Set_Slot_Power_Limit message via Message Generation Control
Register in Link Up handler when link changes from down to up state and
slot power limit value was defined.

Slot power limit value is read from DT property 'slot-power-limit' which
value is in mW unit. When this DT property is not specified then it is
treated as "Slot Capabilities register has not yet been initialized".

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../devicetree/bindings/pci/aardvark-pci.txt  |  2 +
 drivers/pci/controller/pci-aardvark.c         | 66 ++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
index 2b8ca920a7fa..bb658f261db0 100644
--- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -20,6 +20,7 @@ contain the following properties:
    define the mapping of the PCIe interface to interrupt numbers.
  - bus-range: PCI bus numbers covered
  - phys: the PCIe PHY handle
+ - slot-power-limit: see pci.txt
  - max-link-speed: see pci.txt
  - reset-gpios: see pci.txt
 
@@ -52,6 +53,7 @@ Example:
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
 		phys = <&comphy1 0>;
+		slot-power-limit: <10000>;
 		pcie_intc: interrupt-controller {
 			interrupt-controller;
 			#interrupt-cells = <1>;
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index f94898f6072f..cf704c199c15 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -166,6 +166,11 @@
 #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
 #define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
 #define     DIS_ORD_CHK				BIT(30)
+#define PME_MSG_GEN_CTRL			(LMI_BASE_ADDR + 0x220)
+#define     SEND_SET_SLOT_POWER_LIMIT		BIT(13)
+#define     SEND_PME_TURN_OFF			BIT(14)
+#define     SLOT_POWER_LIMIT_DATA_SHIFT		16
+#define     SLOT_POWER_LIMIT_DATA_MASK		GENMASK(25, 16)
 
 /* PCIe core controller registers */
 #define CTRL_CORE_BASE_ADDR			0x18000
@@ -267,6 +272,7 @@ static bool advk_pcie_link_up(struct advk_pcie *pcie)
 {
 	u32 val, ltssm_state;
 	u16 slotsta, slotctl;
+	u32 slotpwr;
 	bool link_up;
 
 	val = advk_readl(pcie, CFG_REG);
@@ -277,7 +283,25 @@ static bool advk_pcie_link_up(struct advk_pcie *pcie)
 		pcie->link_up = true;
 		slotsta = le16_to_cpu(pcie->bridge.pcie_conf.slotsta);
 		slotctl = le16_to_cpu(pcie->bridge.pcie_conf.slotctl);
+		slotpwr = (le32_to_cpu(pcie->bridge.pcie_conf.slotcap) &
+			   (PCI_EXP_SLTCAP_SPLV | PCI_EXP_SLTCAP_SPLS)) >> 7;
 		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta | PCI_EXP_SLTSTA_DLLSC);
+		if (!(slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE) && slotpwr) {
+			/*
+			 * According to PCIe Base specification 3.0, when transitioning from a
+			 * non-DL_Up Status to a DL_Up Status, the Port must initiate the
+			 * transmission of a Set_Slot_Power_Limit Message to the other component
+			 * on the Link to convey the value programmed in the Slot Power Limit
+			 * Scale and Value fields of the Slot Capabilities register. This
+			 * Transmission is optional if the Slot Capabilities register has not
+			 * yet been initialized.
+			 */
+			val = advk_readl(pcie, PME_MSG_GEN_CTRL);
+			val &= ~SLOT_POWER_LIMIT_DATA_MASK;
+			val |= slotpwr << SLOT_POWER_LIMIT_DATA_SHIFT;
+			val |= SEND_SET_SLOT_POWER_LIMIT;
+			advk_writel(pcie, val, PME_MSG_GEN_CTRL);
+		}
 		if ((slotctl & PCI_EXP_SLTCTL_DLLSCE) && (slotctl & PCI_EXP_SLTCTL_HPIE))
 			mod_timer(&pcie->link_up_irq_timer, jiffies + 1);
 	}
@@ -956,6 +980,9 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
 static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 {
 	struct pci_bridge_emul *bridge = &pcie->bridge;
+	struct device *dev = &pcie->pdev->dev;
+	u8 slot_power_limit_scale, slot_power_limit_value;
+	u32 slot_power_limit;
 	int ret;
 
 	bridge->conf.vendor =
@@ -988,6 +1015,40 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	/* Indicates supports for Completion Retry Status */
 	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
 
+	if (of_property_read_u32(dev->of_node, "slot-power-limit", &slot_power_limit))
+		slot_power_limit = 0;
+
+	if (slot_power_limit)
+		dev_info(dev, "Slot power limit %u.%uW\n", slot_power_limit / 1000,
+			 (slot_power_limit / 100) % 10);
+
+	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
+	if (slot_power_limit == 0) {
+		slot_power_limit_scale = 0;
+		slot_power_limit_value = 0x00;
+	} else if (slot_power_limit <= 255) {
+		slot_power_limit_scale = 3;
+		slot_power_limit_value = slot_power_limit;
+	} else if (slot_power_limit <= 255*10) {
+		slot_power_limit_scale = 2;
+		slot_power_limit_value = slot_power_limit / 10;
+	} else if (slot_power_limit <= 255*100) {
+		slot_power_limit_scale = 1;
+		slot_power_limit_value = slot_power_limit / 100;
+	} else if (slot_power_limit <= 239*1000) {
+		slot_power_limit_scale = 0;
+		slot_power_limit_value = slot_power_limit / 1000;
+	} else if (slot_power_limit <= 250*1000) {
+		slot_power_limit_scale = 0;
+		slot_power_limit_value = 0xF0;
+	} else if (slot_power_limit <= 275*1000) {
+		slot_power_limit_scale = 0;
+		slot_power_limit_value = 0xF1;
+	} else {
+		slot_power_limit_scale = 0;
+		slot_power_limit_value = 0xF2;
+	}
+
 	/*
 	 * Mark bridge as Hot-Plug Capable to allow delivering Data Link Layer
 	 * State Changed interrupt. No Command Completed Support is set because
@@ -996,7 +1057,10 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	 * bit permanently as there is no support for unplugging PCIe card from
 	 * the slot. Assume that PCIe card is always connected in slot.
 	 */
-	bridge->pcie_conf.slotcap = cpu_to_le32(PCI_EXP_SLTCAP_NCCS | PCI_EXP_SLTCAP_HPC);
+	bridge->pcie_conf.slotcap = cpu_to_le32(PCI_EXP_SLTCAP_NCCS |
+						PCI_EXP_SLTCAP_HPC |
+						slot_power_limit_value << 7 |
+						slot_power_limit_scale << 15);
 	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
 	return 0;
-- 
2.20.1

