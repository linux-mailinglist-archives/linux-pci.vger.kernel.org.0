Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7705059207A
	for <lists+linux-pci@lfdr.de>; Sun, 14 Aug 2022 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiHNP1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Aug 2022 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239624AbiHNP1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Aug 2022 11:27:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EF0AE62;
        Sun, 14 Aug 2022 08:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A1E6B80B27;
        Sun, 14 Aug 2022 15:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4449C433C1;
        Sun, 14 Aug 2022 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660490852;
        bh=5GyLM1CyVv10Ove+YIIf3oMlmnKfA55OKySxx0jDfxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A67viJI2thCRSB5Fr624goC6G8U1y/41RffDWMv3el7/1F5562HU7+47a5YiiP9Ot
         TysGLZucmttPDDe19UCllhJRbGjjdO+lTNKqdr/axnMHyP1s9OpcWvPpF3u0iriyrQ
         uiLjl49XE4bTjfYG1at4sIHhvbZuB4+4B9QcN53jzRhvZGyuywshhbVWGoOSR3oiMy
         zlrcu5+0RPdHL5glYp30e1m95EwxtmV+Vfc2BvC0W2q9kqaGyTV7Fy0mGwObry0X1v
         cNMHHoajVxJQOIbWVerTbdoquP7uleM1qwZEF+VVtbbB5ia36TLPHB85Toy00u2UOp
         xZ436PF4wxogA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, thomas.petazzoni@bootlin.com,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.19 12/64] PCI: aardvark: Fix reporting Slot capabilities on emulated bridge
Date:   Sun, 14 Aug 2022 11:23:45 -0400
Message-Id: <20220814152437.2374207-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814152437.2374207-1-sashal@kernel.org>
References: <20220814152437.2374207-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit bcdb6fd4f3e9ac1097698c8d8f56b70853b49873 ]

Slot capabilities are currently not reported because emulated bridge does
not report the PCI_EXP_FLAGS_SLOT flag.

Set PCI_EXP_FLAGS_SLOT to let the kernel know that PCI_EXP_SLT* registers
are supported.

Move setting of PCI_EXP_SLTCTL register from "dynamic" pcie_conf_read
function to static buffer as it is only statically filled the
PCI_EXP_SLTSTA_PDS flag and dynamic read callback is not needed for this
register.

Set Presence State Bit to 1 since there is no support for unplugging the
card and there is currently no platform able to detect presence of a card -
in such a case the bit needs to be set to 1.

Finally correctly set Physical Slot Number to 1 since there is only one
port and zero value is reserved for ports within the same silicon as Root
Port which is not our case for Aardvark HW.

Link: https://lore.kernel.org/r/20220524132827.8837-3-kabel@kernel.org
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 33 +++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ffec82c8a523..62db476a8651 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -8,6 +8,7 @@
  * Author: Hezi Shahmoon <hezi.shahmoon@marvell.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -857,14 +858,11 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 
 
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
@@ -977,8 +975,25 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
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
+	bridge->pcie_conf.slotcap = cpu_to_le32(FIELD_PREP(PCI_EXP_SLTCAP_PSN,
+							   1));
+	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
 
 	/* Indicates supports for Completion Retry Status */
 	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
-- 
2.35.1

