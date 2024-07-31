Return-Path: <linux-pci+bounces-11084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1E9438F8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 00:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F971F23042
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDB17165E;
	Wed, 31 Jul 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TbfFuTwI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86816FF39
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464931; cv=none; b=RY3vaXd3G+9yKOcGYEElv6jz2c2yHc43mXSunqHXC+bdEyeYWQfl2yfmSYCWDV0qiYl2IRaJGdXGtVYZ4zS7jo4MwPP+YW5Nlrt+g0ooHk+xkQc85xXxZw1QKrsjinWEdAjDOcewWXC7iKCdq9cGm98f2qRCTRVqougufUgKBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464931; c=relaxed/simple;
	bh=50hNICu5I0cQ1dc8e6sKALzLgxa4Aa4k1WXKXjZo4o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FRpm685WtnQvlhS5Rr104oLWY1ath5a3IvkjglIEn4fJviKow0BpDW5MIetxHcVzMn1Uc1X4tTtYpRxetkimQNrxVIKoUwMuVHRXxXrjGO6Q3UF8S8rhkfu+gd4ZEHCxjwNFicT/GiVlJ0Kf8umPwPcdm8wkiDSu+nbq0NSEtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TbfFuTwI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44ff9281e93so35337361cf.2
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464928; x=1723069728; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pfZmRNKdTMWf2ZqvAr4Qq8R0KQvMMl+ZjRL68UJXeA=;
        b=TbfFuTwIcFZ8aXqpry3bIst/7IwaYoLavYxeh4K69qOdKMUfweGDUmkYh83p2sk5wM
         SB1BWY1ym5vN5pyt0o/ZMDXyDwUv0lJtBiRPqn62oSYzhUD3wCPzueuhO/OTMClZ4uEQ
         4U1XDKboymrJM41KTUvUVNsQ9JjJ0KLTA0b9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464928; x=1723069728;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pfZmRNKdTMWf2ZqvAr4Qq8R0KQvMMl+ZjRL68UJXeA=;
        b=rEuFtE/a7ESVL0g/jPRct0ViNpaRuppoga7i7q8Zpv1J5uYv9CfFEJj4MDGaSNyY5Q
         MVJmvYbre1aIEhGCZcECcRyYSPczxjRz7HxhvZ8qLCO7ohBu8X+kQJAb26joaIzD/be5
         12L7EhyOlkY3/Veo+OPuNzsY3NO3mA96mkz9EIbgdlZnbbMkf8s8/f/PhnKv7gWpS2ct
         PYj+s1QWJnKf44uXydhplETPN7JpxgEAwjMkqfcAGZMZ2vdu2AWMOrchK30nBB1ots0e
         ZMWjeGlP9rhL2PPn+widMO+R0OfVnfn/I5VieLGJMQBCSggaNP1u8ijkknqX+jNtgvaE
         2p5w==
X-Gm-Message-State: AOJu0YyzbjqIvzntIONZ3TE+NA53pEfMdDtaM5Vf/fMZewPbpizb5k5M
	/2+4CdMB4jAjSJhYGJ1jftOOiSehOz38fO56TS5Wc/R41jxM5hY3nZXdf12zqnqAuAGXSxeYIKd
	c1WeGeRzpDscz7OjfA0ylIndcg4B79UdYlviYqT+6wLw9n0cQD5cmWoTc+4xr2b7vBo+ZKpNBX0
	42Ccy24sScbMVlPLezyx9R8bv60UEKJeRCYhebDkZYKD7JtQ==
X-Google-Smtp-Source: AGHT+IHBBkmfHuYFGI148IzJz1GuxHa/aa+gI22Rh/rpjLFTRKmigH5kniWSfAx/Gc1Jo5Fg2Wy6fQ==
X-Received: by 2002:ac8:7dc6:0:b0:44f:fb58:8c3e with SMTP id d75a77b69052e-4514f9b69b1mr8006651cf.46.1722464927837;
        Wed, 31 Jul 2024 15:28:47 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:47 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many regular inbound windows
Date: Wed, 31 Jul 2024 18:28:23 -0400
Message-Id: <20240731222831.14895-10-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Provide support for new chips with multiple inbound windows while
keeping the legacy support for the older chips.

In existing chips there are three inbound windows with fixed purposes: the
first was for mapping SoC internal registers, the second was for memory,
and the third was for memory but with the endian swapped.  Typically, only
one window was used.

Complicating the inbound window usage was the fact that the PCIe HW would
do a baroque internal mapping of system memory, and concatenate the regions
of multiple memory controllers.

Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
drop the internal mapping while providing for multiple inbound windows.
This works in concert with the dma-ranges property, where each provided
range becomes an inbound window.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 228 ++++++++++++++++++++------
 1 file changed, 177 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4659208ae8da..0ecca3d9576f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -75,15 +75,19 @@
 #define PCIE_MEM_WIN0_HI(win)	\
 		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
 
+/*
+ * NOTE: You may see the term "BAR" in a number of register names used by
+ *   this driver.  The term is an artifact of when the HW core was an
+ *   endpoint device (EP).  Now it is a root complex (RC) and anywhere a
+ *   register has the term "BAR" it is related to an inbound window.
+ */
+
+#define PCIE_BRCM_MAX_INBOUND_WINS			16
 #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
 #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
 
-#define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
-#define  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK		0x1f
-#define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
+#define PCIE_MISC_RC_BAR4_CONFIG_LO			0x40d4
 
-#define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
-#define  PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK		0x1f
 
 #define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
 #define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
@@ -130,6 +134,10 @@
 	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
 	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
 
+#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP			0x40ac
+#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK	BIT(0)
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP			0x410c
+
 #define PCIE_MSI_INTR2_BASE		0x4500
 
 /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
@@ -217,12 +225,20 @@ enum pcie_type {
 	BCM4908,
 	BCM7278,
 	BCM2711,
+	BCM7712,
+};
+
+struct inbound_win {
+	u64 size;
+	u64 pci_offset;
+	u64 cpu_addr;
 };
 
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_type type;
 	const bool has_phy;
+	unsigned int num_inbound_wins;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
@@ -274,6 +290,7 @@ struct brcm_pcie {
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	bool			has_phy;
+	int			num_inbound_wins;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -789,23 +806,61 @@ static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
-static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
-							u64 *rc_bar2_size,
-							u64 *rc_bar2_offset)
+static inline void set_bar(struct inbound_win *b, int *count, u64 size,
+			   u64 cpu_addr, u64 pci_offset)
+{
+	b->size = size;
+	b->cpu_addr = cpu_addr;
+	b->pci_offset = pci_offset;
+	(*count)++;
+}
+
+static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
+				      struct inbound_win inbound_wins[])
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	u64 pci_offset, cpu_addr, size = 0, tot_size = 0;
 	struct resource_entry *entry;
 	struct device *dev = pcie->dev;
 	u64 lowest_pcie_addr = ~(u64)0;
-	int ret, i = 0;
-	u64 size = 0;
+	int ret, i = 0, n = 0;
+
+	/*
+	 * The HW registers (and PCIe) use order-1 numbering for BARs. As
+	 * such, we have inbound_wins[0] unused and BAR1 starts at inbound_wins[1].
+	 */
+	struct inbound_win *b_begin = &inbound_wins[1];
+	struct inbound_win *b = b_begin;
+
+	/*
+	 * STB chips beside 7712 disable the first inbound window default.
+	 * Rather being mapped to system memory it is mapped to the
+	 * internal registers of the SoC.  This feature is deprecated, has
+	 * security considerations, and is not implemented in our modern
+	 * SoCs.
+	 */
+	if (pcie->type != BCM7712)
+		set_bar(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
 		u64 pcie_beg = entry->res->start - entry->offset;
+		u64 cpu_beg = entry->res->start;
 
-		size += entry->res->end - entry->res->start + 1;
+		size = resource_size(entry->res);
+		tot_size += size;
 		if (pcie_beg < lowest_pcie_addr)
 			lowest_pcie_addr = pcie_beg;
+		/*
+		 * 7712 and newer chips may have many BARs, with each
+		 * offering a non-overlapping viewport to system memory.
+		 * That being said, each BARs size must still be a power of
+		 * two.
+		 */
+		if (pcie->type == BCM7712)
+			set_bar(b++, &n, size, cpu_beg, pcie_beg);
+
+		if (n > pcie->num_inbound_wins)
+			break;
 	}
 
 	if (lowest_pcie_addr == ~(u64)0) {
@@ -813,13 +868,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 		return -EINVAL;
 	}
 
+	/*
+	 * 7712 and newer chips do not have an internal memory mapping system
+	 * that enables multiple memory controllers.  As such, it can return
+	 * now w/o doing special configuration.
+	 */
+	if (pcie->type == BCM7712)
+		return n;
+
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
 						  PCIE_BRCM_MAX_MEMC);
-
 	if (ret <= 0) {
 		/* Make an educated guess */
 		pcie->num_memc = 1;
-		pcie->memc_size[0] = 1ULL << fls64(size - 1);
+		pcie->memc_size[0] = 1ULL << fls64(tot_size - 1);
 	} else {
 		pcie->num_memc = ret;
 	}
@@ -828,10 +890,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 	for (i = 0, size = 0; i < pcie->num_memc; i++)
 		size += pcie->memc_size[i];
 
-	/* System memory starts at this address in PCIe-space */
-	*rc_bar2_offset = lowest_pcie_addr;
-	/* The sum of all memc views must also be a power of 2 */
-	*rc_bar2_size = 1ULL << fls64(size - 1);
+	/* Our HW mandates that the window size must be a power of 2 */
+	size = 1ULL << fls64(size - 1);
+
+	/*
+	 * For STB chips, the BAR2 cpu_addr is hardwired to the start
+	 * of system memory, so we set it to 0.
+	 */
+	cpu_addr = 0;
+	pci_offset = lowest_pcie_addr;
 
 	/*
 	 * We validate the inbound memory view even though we should trust
@@ -866,25 +933,90 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 	 *   outbound memory @ 3GB). So instead it will  start at the 1x
 	 *   multiple of its size
 	 */
-	if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
-	    (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
-		dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, off 0x%llx\n",
-			*rc_bar2_size, *rc_bar2_offset);
+	if (!size || (pci_offset & (size - 1)) ||
+	    (pci_offset < SZ_4G && pci_offset > SZ_2G)) {
+		dev_err(dev, "Invalid inbound_win2_offset/size: size 0x%llx, off 0x%llx\n",
+			size, pci_offset);
 		return -EINVAL;
 	}
 
-	return 0;
+	/* Enable inbound window 2, the main inbound window for STB chips */
+	set_bar(b++, &n, size, cpu_addr, pci_offset);
+
+	/*
+	 * Disable inbound window 3.  On some chips presents the same
+	 * window as #2 but the data appears in a settable endianness.
+	 */
+	set_bar(b++, &n, 0, 0, 0);
+
+	return n;
+}
+
+static u32 brcm_bar_reg_offset(int bar)
+{
+	if (bar <= 3)
+		return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
+	else
+		return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
+}
+
+static u32 brcm_ubus_reg_offset(int bar)
+{
+	if (bar <= 3)
+		return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
+	else
+		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP + 8 * (bar - 4);
+}
+
+static void set_inbound_win_registers(struct brcm_pcie *pcie,
+				      const struct inbound_win *inbound_wins,
+				      int num_inbound_wins)
+{
+	void __iomem *base = pcie->base;
+	int i;
+
+	for (i = 1; i <= num_inbound_wins; i++) {
+		u64 pci_offset = inbound_wins[i].pci_offset;
+		u64 cpu_addr = inbound_wins[i].cpu_addr;
+		u64 size = inbound_wins[i].size;
+		u32 reg_offset = brcm_bar_reg_offset(i);
+		u32 tmp = lower_32_bits(pci_offset);
+
+		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
+				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
+
+		/* Write low */
+		writel(tmp, base + reg_offset);
+		/* Write high */
+		writel(upper_32_bits(pci_offset), base + reg_offset + 4);
+
+		/*
+		 * Most STB chips:
+		 *     Do nothing.
+		 * 7712:
+		 *     All of their BARs need to be set.
+		 */
+		if (pcie->type == BCM7712) {
+			/* BUS remap register settings */
+			reg_offset = brcm_ubus_reg_offset(i);
+			tmp = lower_32_bits(cpu_addr) & ~0xfff;
+			tmp |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
+			writel(tmp, base + reg_offset);
+			tmp = upper_32_bits(cpu_addr);
+			writel(tmp, base + reg_offset + 4);
+		}
+	}
 }
 
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
-	u64 rc_bar2_offset, rc_bar2_size;
+	struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
 	u32 tmp, burst, aspm_support;
-	int num_out_wins = 0;
-	int ret, memc;
+	int num_out_wins = 0, num_rc_bars = 0;
+	int memc;
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
@@ -933,17 +1065,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
-	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
-						    &rc_bar2_offset);
-	if (ret)
-		return ret;
+	num_rc_bars = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
+	if (num_rc_bars < 0)
+		return num_rc_bars;
+
+	set_inbound_win_registers(pcie, inbound_wins, num_rc_bars);
 
-	tmp = lower_32_bits(rc_bar2_offset);
-	u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
-			  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK);
-	writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
-	writel(upper_32_bits(rc_bar2_offset),
-	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
+	if (!brcm_pcie_rc_mode(pcie)) {
+		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
+		return -EINVAL;
+	}
 
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
 	for (memc = 0; memc < pcie->num_memc; memc++) {
@@ -965,25 +1096,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 * 4GB or when the inbound area is smaller than 4GB (taking into
 	 * account the rounding-up we're forced to perform).
 	 */
-	if (rc_bar2_offset >= SZ_4G || (rc_bar2_size + rc_bar2_offset) < SZ_4G)
+	if (inbound_wins[2].pci_offset >= SZ_4G ||
+	    (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
 		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
 	else
 		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
 
-	if (!brcm_pcie_rc_mode(pcie)) {
-		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
-		return -EINVAL;
-	}
-
-	/* disable the PCIe->GISB memory window (RC_BAR1) */
-	tmp = readl(base + PCIE_MISC_RC_BAR1_CONFIG_LO);
-	tmp &= ~PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK;
-	writel(tmp, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
-
-	/* disable the PCIe->SCB memory window (RC_BAR3) */
-	tmp = readl(base + PCIE_MISC_RC_BAR3_CONFIG_LO);
-	tmp &= ~PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK;
-	writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
 
 	/* Don't advertise L0s capability if 'aspm-no-l0s' */
 	aspm_support = PCIE_LINK_STATE_L1;
@@ -1034,7 +1152,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		num_out_wins++;
 	}
 
-	/* PCIe->SCB endian mode for BAR */
+	/* PCIe->SCB endian mode for inbound window */
 	tmp = readl(base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
 	u32p_replace_bits(&tmp, PCIE_RC_CFG_VENDOR_SPCIFIC_REG1_LITTLE_ENDIAN,
 		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
@@ -1516,6 +1634,7 @@ static const struct pcie_cfg_data generic_cfg = {
 	.type		= GENERIC,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
 };
 
 static const struct pcie_cfg_data bcm7425_cfg = {
@@ -1523,6 +1642,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 	.type		= BCM7425,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
@@ -1530,6 +1650,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 	.type		= BCM7435,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
 };
 
 static const struct pcie_cfg_data bcm4908_cfg = {
@@ -1537,6 +1658,7 @@ static const struct pcie_cfg_data bcm4908_cfg = {
 	.type		= BCM4908,
 	.perst_set	= brcm_pcie_perst_set_4908,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
 };
 
 static const int pcie_offset_bcm7278[] = {
@@ -1552,6 +1674,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
 	.type		= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.num_inbound_wins = 3,
 };
 
 static const struct pcie_cfg_data bcm2711_cfg = {
@@ -1559,6 +1682,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.type		= BCM2711,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
@@ -1567,6 +1691,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
+	.num_inbound_wins = 3,
 };
 
 static const struct of_device_id brcm_pcie_match[] = {
@@ -1623,6 +1748,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 	pcie->has_phy = data->has_phy;
+	pcie->num_inbound_wins = data->num_inbound_wins;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
-- 
2.17.1


