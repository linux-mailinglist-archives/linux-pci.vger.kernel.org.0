Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05963422FB7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhJESMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 14:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhJESMD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 14:12:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AAA3613D3;
        Tue,  5 Oct 2021 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633457412;
        bh=wYP5bV8qIKGMs3p7wWFOuIhkwAnisSor5JIw7ccsUn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSDdYzG52NpFY/cmi6ydq7rxMiYLjP+G4pvsoEiIMTRoCz7ZxsWgtRdFDbnP4+5kr
         33LD3hVMmWFtzAKqGyfmiFOgtmiZ+yAYU3vAIrJYipONLILwhv2P8DrHz7pteeyImB
         YzoAiPl6eK4kLFPPfNj0waTJPH8uHLl6SrbyTle6d9arKj1iPvLiIjQDG2jMRcXDCd
         2ozxSbGXUiogi136mZrS2R0ojiOpkZw7L/2bi8eKNxHCsWg/ncBv7g9hgWBo8B96o3
         +i2kUUCkqQWhxM0lwGsi+SBSPprD6hTbsu9ctZkRoYmoY/p9UtoJCdjg13eymYoUdN
         gVdnsTRjvrabg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 12/13] PCI: aardvark: Fix checking for link up via LTSSM state
Date:   Tue,  5 Oct 2021 20:09:51 +0200
Message-Id: <20211005180952.6812-13-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211005180952.6812-1-kabel@kernel.org>
References: <20211005180952.6812-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Current implementation of advk_pcie_link_up() is wrong as it marks also
link disabled or hot reset states as link up.

Fix it by marking link up only to those states which are defined in PCIe
Base specification 3.0, Table 4-14: Link Status Mapped to the LTSSM.

To simplify implementation, Define macros for every LTSSM state which
aardvark hardware can return in CFG_REG register.

Fix also checking for link training according to the same Table 4-14.
Define a new function advk_pcie_link_training() for this purpose.

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: Remi Pommarel <repk@triplefau.lt>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 76 ++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 2c66cdbb8dd6..f831f7d197bd 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -165,8 +165,50 @@
 #define CFG_REG					(LMI_BASE_ADDR + 0x0)
 #define     LTSSM_SHIFT				24
 #define     LTSSM_MASK				0x3f
-#define     LTSSM_L0				0x10
 #define     RC_BAR_CONFIG			0x300
+
+/* LTSSM values in CFG_REG */
+enum {
+	LTSSM_DETECT_QUIET			= 0x0,
+	LTSSM_DETECT_ACTIVE			= 0x1,
+	LTSSM_POLLING_ACTIVE			= 0x2,
+	LTSSM_POLLING_COMPLIANCE		= 0x3,
+	LTSSM_POLLING_CONFIGURATION		= 0x4,
+	LTSSM_CONFIG_LINKWIDTH_START		= 0x5,
+	LTSSM_CONFIG_LINKWIDTH_ACCEPT		= 0x6,
+	LTSSM_CONFIG_LANENUM_ACCEPT		= 0x7,
+	LTSSM_CONFIG_LANENUM_WAIT		= 0x8,
+	LTSSM_CONFIG_COMPLETE			= 0x9,
+	LTSSM_CONFIG_IDLE			= 0xa,
+	LTSSM_RECOVERY_RCVR_LOCK		= 0xb,
+	LTSSM_RECOVERY_SPEED			= 0xc,
+	LTSSM_RECOVERY_RCVR_CFG			= 0xd,
+	LTSSM_RECOVERY_IDLE			= 0xe,
+	LTSSM_L0				= 0x10,
+	LTSSM_RX_L0S_ENTRY			= 0x11,
+	LTSSM_RX_L0S_IDLE			= 0x12,
+	LTSSM_RX_L0S_FTS			= 0x13,
+	LTSSM_TX_L0S_ENTRY			= 0x14,
+	LTSSM_TX_L0S_IDLE			= 0x15,
+	LTSSM_TX_L0S_FTS			= 0x16,
+	LTSSM_L1_ENTRY				= 0x17,
+	LTSSM_L1_IDLE				= 0x18,
+	LTSSM_L2_IDLE				= 0x19,
+	LTSSM_L2_TRANSMIT_WAKE			= 0x1a,
+	LTSSM_DISABLED				= 0x20,
+	LTSSM_LOOPBACK_ENTRY_MASTER		= 0x21,
+	LTSSM_LOOPBACK_ACTIVE_MASTER		= 0x22,
+	LTSSM_LOOPBACK_EXIT_MASTER		= 0x23,
+	LTSSM_LOOPBACK_ENTRY_SLAVE		= 0x24,
+	LTSSM_LOOPBACK_ACTIVE_SLAVE		= 0x25,
+	LTSSM_LOOPBACK_EXIT_SLAVE		= 0x26,
+	LTSSM_HOT_RESET				= 0x27,
+	LTSSM_RECOVERY_EQUALIZATION_PHASE0	= 0x28,
+	LTSSM_RECOVERY_EQUALIZATION_PHASE1	= 0x29,
+	LTSSM_RECOVERY_EQUALIZATION_PHASE2	= 0x2a,
+	LTSSM_RECOVERY_EQUALIZATION_PHASE3	= 0x2b,
+};
+
 #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
 
 /* PCIe core controller registers */
@@ -258,13 +300,35 @@ static inline u32 advk_readl(struct advk_pcie *pcie, u64 reg)
 	return readl(pcie->base + reg);
 }
 
-static int advk_pcie_link_up(struct advk_pcie *pcie)
+static u8 advk_pcie_ltssm_state(struct advk_pcie *pcie)
 {
-	u32 val, ltssm_state;
+	u32 val;
+	u8 ltssm_state;
 
 	val = advk_readl(pcie, CFG_REG);
 	ltssm_state = (val >> LTSSM_SHIFT) & LTSSM_MASK;
-	return ltssm_state >= LTSSM_L0;
+	return ltssm_state;
+}
+
+static inline bool advk_pcie_link_up(struct advk_pcie *pcie)
+{
+	/* check if LTSSM is in normal operation - some L* state */
+	u8 ltssm_state = advk_pcie_ltssm_state(pcie);
+	return ltssm_state >= LTSSM_L0 && ltssm_state < LTSSM_DISABLED;
+}
+
+static inline bool advk_pcie_link_training(struct advk_pcie *pcie)
+{
+	/*
+	 * According to PCIe Base specification 3.0, Table 4-14: Link
+	 * Status Mapped to the LTSSM is Link Training mapped to LTSSM
+	 * Configuration and Recovery states.
+	 */
+	u8 ltssm_state = advk_pcie_ltssm_state(pcie);
+	return ((ltssm_state >= LTSSM_CONFIG_LINKWIDTH_START &&
+		 ltssm_state < LTSSM_L0) ||
+		(ltssm_state >= LTSSM_RECOVERY_EQUALIZATION_PHASE0 &&
+		 ltssm_state <= LTSSM_RECOVERY_EQUALIZATION_PHASE3));
 }
 
 static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
@@ -287,7 +351,7 @@ static void advk_pcie_wait_for_retrain(struct advk_pcie *pcie)
 	size_t retries;
 
 	for (retries = 0; retries < RETRAIN_WAIT_MAX_RETRIES; ++retries) {
-		if (!advk_pcie_link_up(pcie))
+		if (advk_pcie_link_training(pcie))
 			break;
 		udelay(RETRAIN_WAIT_USLEEP_US);
 	}
@@ -706,7 +770,7 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
 		/* u32 contains both PCI_EXP_LNKCTL and PCI_EXP_LNKSTA */
 		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
 			~(PCI_EXP_LNKSTA_LT << 16);
-		if (!advk_pcie_link_up(pcie))
+		if (advk_pcie_link_training(pcie))
 			val |= (PCI_EXP_LNKSTA_LT << 16);
 		*value = val;
 		return PCI_BRIDGE_EMUL_HANDLED;
-- 
2.32.0

