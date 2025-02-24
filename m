Return-Path: <linux-pci+bounces-22177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF1A41790
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94BF3B1A44
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF961993B7;
	Mon, 24 Feb 2025 08:37:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88F01DDC28
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386224; cv=none; b=XSahkk/H/dGUqvg/0ntZUySrUaOEVr73iuF4sSEdKHu2+nRgdCXbSNDu88MveUBM5s8PFciT1sv11fZvh98lc0Yqw1wnjLK3s7EgHKXePQzC1ibsIC0u3MtHZCT9Oqt/c1pceDnUM1R5Mo87biM9ctmpUs1mTmPIsakejgNIrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386224; c=relaxed/simple;
	bh=SYAz3IP3oRsZ4UkPKmmjhNOw+B4w+2N+1RV+6ry4vwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJvSJxvSWxvQhsZNKiLCOE0JYgLUtOWBwUT7w2MS47aPbhrpEg/y0yvCfsWN5EDRlBnoEyT7DB01U2NNVeFAdZF+dx0IHN9Rv9f/I1d/h1hBqMyT0uKFzdKPNiU345+JG6Nv/NmfrTM7z/3h2p46TPvEWyRTzYDFpvL6J5EevKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A85472118E;
	Mon, 24 Feb 2025 08:36:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5641113929;
	Mon, 24 Feb 2025 08:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJO0EpYvvGeJVAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Mon, 24 Feb 2025 08:36:38 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	"Ivan T. Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v6 7/7] PCI: brcmstb: Add BCM2712 support
Date: Mon, 24 Feb 2025 10:35:59 +0200
Message-ID: <20250224083559.47645-8-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250224083559.47645-1-svarbanov@suse.de>
References: <20250224083559.47645-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A85472118E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Add a bare minimum amount of changes in order to support PCIe Root
Complex hardware IP found on RPi5. The PCIe controller on BCM2712
is based on BCM7712 and as such it inherits register offsets, PERST#
assertion, bridge_reset ops, and inbound windows count.

Although, the implementation for BCM2712 needs a workaround related to
the control of the bridge_reset where turning off of the Root Port must
not shutdown the bridge_reset and this must be avoided. To implement
this workaround a quirks field is introduced in pcie_cfg_data struct.

Also, it needs adjustment of PHY PLL setup to use a 54MHz input refclk.
The default input reference clock for the PHY PLL is 100Mhz, except for
some devices where it is 54Mhz like BCM2712C1 and BCM2712D0.

To implement those adjustments introduce a new .post_setup op in
pcie_cfg_data and call it at the end of brcm_pcie_setup function.

The BCM2712 .post_setup callback implements the required MDIO writes
that switch the PLL refclk and also change PHY PM clock period.

Without this RPi5 PCIex1 is unable to enumerate endpoint devices on
the expansion connector.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 69 ++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4c5fff1919ba..744fe1a4cf9c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -55,6 +55,10 @@
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
+#define PCIE_RC_PL_PHY_CTL_15				0x184c
+#define  PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
+#define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
+
 #define PCIE_MISC_MISC_CTRL				0x4008
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
@@ -234,13 +238,24 @@ struct inbound_win {
 	u64 cpu_addr;
 };
 
+/*
+ * The RESCAL block is tied to PCIe controller #1, regardless of the number of
+ * controllers, and turning off PCIe controller #1 prevents access to the RESCAL
+ * register blocks, therefore no other controller can access this register
+ * space, and depending upon the bus fabric we may get a timeout (UBUS/GISB),
+ * or a hang (AXI).
+ */
+#define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN		BIT(0)
+
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_soc_base soc_base;
 	const bool has_phy;
+	const u32 quirks;
 	u8 num_inbound_wins;
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	int (*post_setup)(struct brcm_pcie *pcie);
 };
 
 struct subdev_regulators {
@@ -816,6 +831,38 @@ static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 	return 0;
 }
 
+static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
+{
+	const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
+	const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
+	int ret, i;
+	u32 tmp;
+
+	/* Allow a 54MHz (xosc) refclk source */
+	ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, SET_ADDR_OFFSET, 0x1600);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i], data[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	usleep_range(100, 200);
+
+	/*
+	 * Set L1SS sub-state timers to avoid lengthy state transitions,
+	 * PM clock period is 18.52ns (1/54MHz, round down).
+	 */
+	tmp = readl(pcie->base + PCIE_RC_PL_PHY_CTL_15);
+	tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
+	tmp |= 0x12;
+	writel(tmp, pcie->base + PCIE_RC_PL_PHY_CTL_15);
+
+	return 0;
+}
+
 static void add_inbound_win(struct inbound_win *b, u8 *count, u64 size,
 			    u64 cpu_addr, u64 pci_offset)
 {
@@ -1179,6 +1226,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
 	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
 
+	if (pcie->cfg->post_setup) {
+		ret = pcie->cfg->post_setup(pcie);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -1488,8 +1541,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 	writel(tmp, base + HARD_DEBUG(pcie));
 
-	/* Shutdown PCIe bridge */
-	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
+	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
+		/* Shutdown PCIe bridge */
+		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1699,6 +1753,16 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.num_inbound_wins = 3,
 };
 
+static const struct pcie_cfg_data bcm2712_cfg = {
+	.offsets	= pcie_offsets_bcm7712,
+	.soc_base	= BCM7712,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.post_setup	= brcm_pcie_post_setup_bcm2712,
+	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
+	.num_inbound_wins = 10,
+};
+
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
 	.soc_base	= BCM4908,
@@ -1750,6 +1814,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
-- 
2.47.0


