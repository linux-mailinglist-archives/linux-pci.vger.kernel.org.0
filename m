Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134E4BD0FC
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244638AbiBTTe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiBTTeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365C44506A
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C686460EF2
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A9DC340EB;
        Sun, 20 Feb 2022 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385643;
        bh=Q7udoEyumIV3Id2yJHB78wnTUYP2itFHIQHmBGa4kZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ar+RHAJLl2cEgY7Ug7FkARP9pfAWugx9dRQIepRlneW/SSePDMyCbSQXKc7NejXf5
         Gkkmp8FLZjfDND9UOP45yyw5lKG0TjJ4QX5NH8Z8CoswwDV5x6WR+N6+EvEi/T1+qJ
         /vF06O619dqje4eugCsUMLyIMwxNx/y6YtyXsw6QxBKcpFY/Cw6rWxW0CLoslxdnVm
         Z6cT/lDcoTe9Vk08txt1C7Tn37b944sOEwOsHpWXWk17L5urvOJLMb2l0axO6jUhaP
         w/FQscc/5tN9khuH+QJoyKsGKRo2Wz7/+w0bSZXmOOGlMJI+a5yBwNPpPJjUeXpLKk
         7UwAS2+yST5NA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 05/18] PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
Date:   Sun, 20 Feb 2022 20:33:33 +0100
Message-Id: <20220220193346.23789-6-kabel@kernel.org>
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

Slot capabilities are currently not reported because emulated bridge
does not report the PCI_EXP_FLAGS_SLOT flag.

Set PCI_EXP_FLAGS_SLOT to let the kernel know that PCI_EXP_SLT*
registers are supported.

Move setting of PCI_EXP_SLTCTL register from "dynamic" pcie_conf_read
function to static buffer as it is only statically filled the
PCI_EXP_SLTSTA_PDS flag and dynamic read callback is not needed for this
register.

Set Presence State Bit to 1 since there is no support for unplugging the
card and there is currently no platform able to detect presence of
a card - in such a case the bit needs to be set to 1.

Finally correctly set Physical Slot Number to 1 since there is only one
port and zero value is reserved for ports within the same silicon as
Root Port which is not our case for Aardvark HW.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 31 +++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 01dd530e1b5f..c80c78505bfa 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -859,14 +859,11 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 
 
 	switch (reg) {
-	case PCI_EXP_SLTCTL:
-		*value = PCI_EXP_SLTSTA_PDS << 16;
-		return PCI_BRIDGE_EMUL_HANDLED;
-
 	/*
-	 * PCI_EXP_RTCTL and PCI_EXP_RTSTA are also supported, but do not need
-	 * to be handled here, because their values are stored in emulated
-	 * config space buffer, and we read them from there when needed.
+	 * PCI_EXP_SLTCAP, PCI_EXP_SLTCTL, PCI_EXP_RTCTL and PCI_EXP_RTSTA are
+	 * also supported, but do not need to be handled here, because their
+	 * values are stored in emulated config space buffer, and we read them
+	 * from there when needed.
 	 */
 
 	case PCI_EXP_LNKCAP: {
@@ -1055,8 +1052,24 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
 	/* Support interrupt A for MSI feature */
 	bridge->conf.intpin = PCI_INTERRUPT_INTA;
 
-	/* Aardvark HW provides PCIe Capability structure in version 2 */
-	bridge->pcie_conf.cap = cpu_to_le16(2);
+	/*
+	 * Aardvark HW provides PCIe Capability structure in version 2 and
+	 * indicate slot support, which is emulated.
+	 */
+	bridge->pcie_conf.cap = cpu_to_le16(2 | PCI_EXP_FLAGS_SLOT);
+
+	/*
+	 * Set Presence Detect State bit permanently since there is no support
+	 * for unplugging the card nor detecting whether it is plugged. (If a
+	 * platform exists in the future that supports it, via a GPIO for
+	 * example, it should be implemented via this bit.)
+	 *
+	 * Set physical slot number to 1 since there is only one port and zero
+	 * value is reserved for ports within the same silicon as Root Port
+	 * which is not our case.
+	 */
+	bridge->pcie_conf.slotcap = cpu_to_le32(1 << PCI_EXP_SLTCAP_PSN_SHIFT);
+	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
 	/* Indicates supports for Completion Retry Status */
 	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
-- 
2.34.1

