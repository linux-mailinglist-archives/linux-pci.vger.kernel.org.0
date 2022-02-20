Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CCE4BD104
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbiBTTem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiBTTem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB454506A
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32D8460EEC
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44C8C340F4;
        Sun, 20 Feb 2022 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385659;
        bh=Kg7tvKfErrUrv+LwL7iITXtlKgsPFVj4d1HwBEXX4fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3rpjMmhOpoHbxu7b4TkB3HRBbQscbUpfEmtG1P8zKFbd+PJugbOPpnTe3TvmVeeQ
         3XIV5+woHjZVjiWO3hSq9NYejjrh9xI0HVAUBmVqutMLtOiJVD6mqjALedjQtQWeod
         uOeJbJ+j9yod2VxvF79wagVpsclOP+M1T5vaFPP8wZSngMilJVmI7l/YJF5ZHCvcpO
         HqaYjWuLaJOLkzMW36+EegEQppOiyD/ayQM69uWH1j+zPhOkyHiZFJxv8wtGqXnQ+B
         zEtTtopj1LnPL+yX9gae1YTlvWKAegm9agfEEfvTkzv+8o4zkwyj4XChOuNHue0mPy
         tC2sxzb3w8VUw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 12/18] PCI: aardvark: Send Set_Slot_Power_Limit message
Date:   Sun, 20 Feb 2022 20:33:40 +0100
Message-Id: <20220220193346.23789-13-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Emulate Slot PowerLimit Scale and Value bits in the Slot Capabilities
register of the emulated bridge and if slot power limit value is
defined, send that Set_Slot_Power_Limit message via Message Generation
Control Register in Link Up handler on link up event.

Slot power limit value is read from device-tree property
'slot-power-limit-milliwatt'. If this property is not specified, we
treat it as "Slot Capabilities register has not yet been initialized".

According to PCIe Base specification 3.0, when transitioning from a
non-DL_Up Status to a DL_Up Status, the Port must initiate the
transmission of a Set_Slot_Power_Limit Message to the other component
on the Link to convey the value programmed in the Slot Power Limit
Scale and Value fields of the Slot Capabilities register. This
transmission is optional if the Slot Capabilities register has not
yet been initialized.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 52 ++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 62bb0308b9f7..41127a26c5bc 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -212,6 +212,11 @@ enum {
 };
 
 #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
+#define PME_MSG_GEN_CTRL			(LMI_BASE_ADDR + 0x220)
+#define     SEND_SET_SLOT_POWER_LIMIT		BIT(13)
+#define     SEND_PME_TURN_OFF			BIT(14)
+#define     SLOT_POWER_LIMIT_DATA_SHIFT		16
+#define     SLOT_POWER_LIMIT_DATA_MASK		GENMASK(25, 16)
 
 /* PCIe core controller registers */
 #define CTRL_CORE_BASE_ADDR			0x18000
@@ -285,6 +290,8 @@ struct advk_pcie {
 	raw_spinlock_t msi_irq_lock;
 	DECLARE_BITMAP(msi_used, MSI_IRQ_NUM);
 	struct mutex msi_used_lock;
+	u8 slot_power_limit_value;
+	u8 slot_power_limit_scale;
 	int link_gen;
 	bool link_was_up;
 	struct timer_list link_irq_timer;
@@ -317,8 +324,9 @@ static inline bool advk_pcie_link_up(struct advk_pcie *pcie)
 {
 	/* check if LTSSM is in normal operation - some L* state */
 	u8 ltssm_state = advk_pcie_ltssm_state(pcie);
+	u16 slotsta, slotctl;
+	u32 slotpwr, val;
 	bool link_is_up;
-	u16 slotsta;
 
 	link_is_up = ltssm_state >= LTSSM_L0 && ltssm_state < LTSSM_DISABLED;
 
@@ -332,6 +340,28 @@ static inline bool advk_pcie_link_up(struct advk_pcie *pcie)
 		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta);
 
 		mod_timer(&pcie->link_irq_timer, jiffies + 1);
+
+		/*
+		 * According to PCIe Base specification 3.0, when transitioning
+		 * from a non-DL_Up Status to a DL_Up Status, the Port must
+		 * initiate the transmission of a Set_Slot_Power_Limit Message
+		 * to the other component on the Link to convey the value
+		 * programmed in the Slot Power Limit Scale and Value fields of
+		 * the Slot Capabilities register. This transmission is optional
+		 * if the Slot Capabilities register has not yet been
+		 * initialized.
+		 */
+		slotctl = le16_to_cpu(pcie->bridge.pcie_conf.slotctl);
+		slotpwr = (le32_to_cpu(pcie->bridge.pcie_conf.slotcap) &
+			   (PCI_EXP_SLTCAP_SPLV | PCI_EXP_SLTCAP_SPLS)) >>
+			  PCI_EXP_SLTCAP_SPLV_SHIFT;
+		if (!(slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE) && slotpwr) {
+			val = advk_readl(pcie, PME_MSG_GEN_CTRL);
+			val &= ~SLOT_POWER_LIMIT_DATA_MASK;
+			val |= slotpwr << SLOT_POWER_LIMIT_DATA_SHIFT;
+			val |= SEND_SET_SLOT_POWER_LIMIT;
+			advk_writel(pcie, val, PME_MSG_GEN_CTRL);
+		}
 	}
 
 	return link_is_up;
@@ -944,8 +974,9 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 
 	case PCI_EXP_SLTCTL: {
 		u16 slotctl = le16_to_cpu(bridge->pcie_conf.slotctl);
-		/* Only emulation of HPIE and DLLSCE bits is provided */
-		slotctl &= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+		/* Only emulation of HPIE, DLLSCE and ASPLD bits is provided */
+		slotctl &= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE |
+			   PCI_EXP_SLTCTL_ASPL_DISABLE;
 		bridge->pcie_conf.slotctl = cpu_to_le16(slotctl);
 		break;
 	}
@@ -1107,9 +1138,13 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	 * Set physical slot number to 1 since there is only one port and zero
 	 * value is reserved for ports within the same silicon as Root Port
 	 * which is not our case.
+	 *
+	 * Set slot power limit.
 	 */
 	slotcap = PCI_EXP_SLTCAP_NCCS | PCI_EXP_SLTCAP_HPC |
-		  (1 << PCI_EXP_SLTCAP_PSN_SHIFT);
+		  (1 << PCI_EXP_SLTCAP_PSN_SHIFT) |
+		  (pcie->slot_power_limit_value << PCI_EXP_SLTCAP_SPLV_SHIFT) |
+		  (pcie->slot_power_limit_scale << PCI_EXP_SLTCAP_SPLS_SHIFT);
 	bridge->pcie_conf.slotcap = cpu_to_le32(slotcap);
 	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
@@ -1842,6 +1877,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct advk_pcie *pcie;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
+	u32 slot_power_limit;
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
@@ -1954,6 +1990,14 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	else
 		pcie->link_gen = ret;
 
+	slot_power_limit = of_pci_get_slot_power_limit(dev->of_node,
+						       &pcie->slot_power_limit_value,
+						       &pcie->slot_power_limit_scale);
+	if (slot_power_limit)
+		dev_info(dev, "Slot Power Limit: %u.%uW\n",
+			 slot_power_limit / 1000,
+			 (slot_power_limit / 100) % 10);
+
 	ret = advk_pcie_setup_phy(pcie);
 	if (ret)
 		return ret;
-- 
2.34.1

