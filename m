Return-Path: <linux-pci+bounces-10120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F368792DBCD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 00:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D51F249F7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38D15DBD5;
	Wed, 10 Jul 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="edVSAu28"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0D15ADA7
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649813; cv=none; b=ooufJQRttcnMbUZyHpUobEfAy1u6sqIcplSknmoYAL8qUY6DfgLVJnEyLwjNXMgowiTDjdupBKaLhiu02eGFak2sKhPXtVSMs2TBqHdMyyj1LyTz/dmC6jvkg0h8SOSiS/AK0bam6maUM5i0c5Eax1xAFeCBLvk9Ta/ybJBCSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649813; c=relaxed/simple;
	bh=Oc12zZ+OFxxigdvkHmYMYQ31d6qhSMljzASjble9uk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=jgjk4ROdbjNzQvYktxUtGNnuyhKzrYhNGIHAEulHAbKWt++ZHBQqu9EPNz4Bt313NYYAScLEj07QF+8XE40Xic3J7sq7Tx5fVDJj1ud/stVsdez5rT1LT6/RmNZxF8mTBrlCTstKaO0i5Psvwgtc87LF6sKng/LBa2PLTNAjxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=edVSAu28; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5ec93f113so1535486d6.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720649809; x=1721254609; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vVfAAUbnRjy4aqR382GbUT/ZsB0Z+SjVKwbf+iZ1yEY=;
        b=edVSAu28M2j537xBRsKYt8ZxsKONLeUdoJLC7WsE/+5PhgFw+YL+rg4gNjciDPLGLH
         SHqe/rVlnjULiyF1yI+rdjSpHRMIjD82dbHeoidJuJGbVI2mn00nezLA9TvIbE6VM8AS
         fc1fzszHOJT+dXJrqwE33ngHioQIF9otJMw/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649809; x=1721254609;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVfAAUbnRjy4aqR382GbUT/ZsB0Z+SjVKwbf+iZ1yEY=;
        b=qztmRzh1haVX9GW3glhApvS53Oj9hY1XrzOeVXmahDVlrk1OriQkm9EXsp3CuHCA8Y
         YE0KEmU5A5XIrDkdLC9Dk2dgyaP6BFpSwrgT1H0Uc8E1W5YRl130syStWpCP6v3/vLKj
         imSOpTtoZfk1+aM2/HPODuL0A/HxZm5p0sliEKqcdMTLC3Gqw0Rv3SqXCwSufUQu9vUQ
         MK9NTG20ybleUaQglBapbqH88Cs9OEITiKeDuq0QevgBPo2S2hTw7H4qyzOw0udIG42A
         zEVDSLVrvQsVPicUPukMbFTA1tjlf7UsW75pAqahP/ikBt0F22k+vHAU+gSvZ3DVpCU+
         03gQ==
X-Gm-Message-State: AOJu0YxNLUCwXixju8zJ1NWeOfdStqPHJZGAAeIAcvI5dUC4Kzdz0ueS
	nnzrKdjmUU5ZMrBJtCTC+TrJq2R+f/Zn9i/oOtmf3FwtE9hGiG0NMe2r3fmW8bbwpwGP8RDy3v+
	Z6hs5LIbOkg+ojec2JYNK/a44LVrT5eQwlnEGv+JTXlPF31OxwrXGS+CHCrJupvqaJPNjODsdzV
	rWkByRC+I0c5kBtk1PMzMY2tWL8UC2f8dijarvZSAFgozlBnar
X-Google-Smtp-Source: AGHT+IHm4vU8woXclQb2wxNBOH+IUBSbtmQRuMXmtvOdnp/GGhFSMCv2GU2upGZFdVsNIEeWIrdzwQ==
X-Received: by 2002:ad4:5d6c:0:b0:6b5:9576:a679 with SMTP id 6a1803df08f44-6b61bc7ef66mr72721536d6.12.1720649808872;
        Wed, 10 Jul 2024 15:16:48 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba04c16sm20182326d6.60.2024.07.10.15.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 15:16:48 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
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
Subject: [PATCH v3 09/12] PCI: brcmstb: Refactor for chips with many regular inbound BARs
Date: Wed, 10 Jul 2024 18:16:23 -0400
Message-Id: <20240710221630.29561-10-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240710221630.29561-1-james.quinlan@broadcom.com>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ab5b8a061cec00c6"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--000000000000ab5b8a061cec00c6

Previously, our chips provided three inbound "BARS" with fixed purposes:
the first was for mapping SoC internal registers, the second was for
memory, and the third was for memory but with the endian swapped.  We
typically only used one of these BARs.

Complicating that BARs usage was the fact that the PCIe HW would do a
baroque internal mapping of system memory, and concatenate the regions of
multiple memory controllers.

Newer chips such as the 7712 and Cable Modem SOCs have taken a step forward
and now provide multiple inbound BARs.  This works in concert with the
dma-ranges property, where each provided range becomes an inbound BAR.

This commit provides support for these new chips and their multiple
inbound BARs but also keeps the legacy support for the older system.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 216 ++++++++++++++++++++------
 1 file changed, 167 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8ab5a8ca05b4..c44a92217855 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -75,15 +75,12 @@
 #define PCIE_MEM_WIN0_HI(win)	\
 		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
 
+#define PCIE_BRCM_MAX_RC_BARS				16
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
@@ -130,6 +127,10 @@
 	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
 	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
 
+#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP			0x40ac
+#define  PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK	BIT(0)
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP			0x410c
+
 #define PCIE_MSI_INTR2_BASE		0x4500
 
 /* Offsets from INTR2_CPU and MSI_INTR2 BASE offsets */
@@ -217,12 +218,20 @@ enum pcie_type {
 	BCM4908,
 	BCM7278,
 	BCM2711,
+	BCM7712,
+};
+
+struct rc_bar {
+	u64 size;
+	u64 pci_offset;
+	u64 cpu_addr;
 };
 
 struct pcie_cfg_data {
 	const int *offsets;
 	const enum pcie_type type;
 	const bool has_phy;
+	unsigned int num_inbound;
 	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
@@ -274,6 +283,7 @@ struct brcm_pcie {
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
 	bool			has_phy;
+	int			num_inbound;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -789,23 +799,61 @@ static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
-static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
-							u64 *rc_bar2_size,
-							u64 *rc_bar2_offset)
+static inline void set_bar(struct rc_bar *b, int *count, u64 size,
+			   u64 cpu_addr, u64 pci_offset)
+{
+	b->size = size;
+	b->cpu_addr = cpu_addr;
+	b->pci_offset = pci_offset;
+	(*count)++;
+}
+
+static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
+				      struct rc_bar rc_bars[])
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
+	 * such, we have rc_bars[0] unused and BAR1 starts at rc_bars[1].
+	 */
+	struct rc_bar *b_begin = &rc_bars[1];
+	struct rc_bar *b = b_begin;
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
+		if (n > pcie->num_inbound)
+			break;
 	}
 
 	if (lowest_pcie_addr == ~(u64)0) {
@@ -813,13 +861,20 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
@@ -828,10 +883,15 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
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
@@ -866,25 +926,89 @@ static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 	 *   outbound memory @ 3GB). So instead it will  start at the 1x
 	 *   multiple of its size
 	 */
-	if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
-	    (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
+	if (!size || (pci_offset & (size - 1)) ||
+	    (pci_offset < SZ_4G && pci_offset > SZ_2G)) {
 		dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, off 0x%llx\n",
-			*rc_bar2_size, *rc_bar2_offset);
+			size, pci_offset);
 		return -EINVAL;
 	}
 
-	return 0;
+	/* Enable BAR2, the inbound window for STB chips */
+	set_bar(b++, &n, size, cpu_addr, pci_offset);
+
+	/*
+	 * Disable BAR3.  On some chips presents the same window as BAR2
+	 * but the data appears in a settable endianness.
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
+static void set_inbound_win_registers(struct brcm_pcie *pcie, const struct rc_bar *rc_bars,
+				      int num_rc_bars)
+{
+	void __iomem *base = pcie->base;
+	int i;
+
+	for (i = 1; i <= num_rc_bars; i++) {
+		u64 pci_offset = rc_bars[i].pci_offset;
+		u64 cpu_addr = rc_bars[i].cpu_addr;
+		u64 size = rc_bars[i].size;
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
+	struct rc_bar rc_bars[PCIE_BRCM_MAX_RC_BARS];
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
@@ -933,17 +1057,16 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
-	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
-						    &rc_bar2_offset);
-	if (ret)
-		return ret;
+	num_rc_bars = brcm_pcie_get_inbound_wins(pcie, rc_bars);
+	if (num_rc_bars < 0)
+		return num_rc_bars;
 
-	tmp = lower_32_bits(rc_bar2_offset);
-	u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
-			  PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK);
-	writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
-	writel(upper_32_bits(rc_bar2_offset),
-	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
+	set_inbound_win_registers(pcie, rc_bars, num_rc_bars);
+
+	if (!brcm_pcie_rc_mode(pcie)) {
+		dev_err(pcie->dev, "PCIe RC controller misconfigured as Endpoint\n");
+		return -EINVAL;
+	}
 
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
 	for (memc = 0; memc < pcie->num_memc; memc++) {
@@ -965,25 +1088,12 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 * 4GB or when the inbound area is smaller than 4GB (taking into
 	 * account the rounding-up we're forced to perform).
 	 */
-	if (rc_bar2_offset >= SZ_4G || (rc_bar2_size + rc_bar2_offset) < SZ_4G)
+	if (rc_bars[2].pci_offset >= SZ_4G ||
+	    (rc_bars[2].size + rc_bars[2].pci_offset) < SZ_4G)
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
@@ -1516,6 +1626,7 @@ static const struct pcie_cfg_data generic_cfg = {
 	.type		= GENERIC,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound	= 3,
 };
 
 static const struct pcie_cfg_data bcm7425_cfg = {
@@ -1523,6 +1634,7 @@ static const struct pcie_cfg_data bcm7425_cfg = {
 	.type		= BCM7425,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound	= 3,
 };
 
 static const struct pcie_cfg_data bcm7435_cfg = {
@@ -1530,6 +1642,7 @@ static const struct pcie_cfg_data bcm7435_cfg = {
 	.type		= BCM7435,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound	= 3,
 };
 
 static const struct pcie_cfg_data bcm4908_cfg = {
@@ -1537,6 +1650,7 @@ static const struct pcie_cfg_data bcm4908_cfg = {
 	.type		= BCM4908,
 	.perst_set	= brcm_pcie_perst_set_4908,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound	= 3,
 };
 
 static const int pcie_offset_bcm7278[] = {
@@ -1552,6 +1666,7 @@ static const struct pcie_cfg_data bcm7278_cfg = {
 	.type		= BCM7278,
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+	.num_inbound	= 3,
 };
 
 static const struct pcie_cfg_data bcm2711_cfg = {
@@ -1559,6 +1674,7 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.type		= BCM2711,
 	.perst_set	= brcm_pcie_perst_set_generic,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound	= 3,
 };
 
 static const struct pcie_cfg_data bcm7216_cfg = {
@@ -1567,6 +1683,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
 	.perst_set	= brcm_pcie_perst_set_7278,
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
 	.has_phy	= true,
+	.num_inbound	= 3,
 };
 
 static const struct of_device_id brcm_pcie_match[] = {
@@ -1623,6 +1740,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
 	pcie->has_phy = data->has_phy;
+	pcie->num_inbound = data->num_inbound;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
-- 
2.17.1


--000000000000ab5b8a061cec00c6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCy73lU5ea0sk1Flxgk3DSMmw7UkS4/
ldz+zXaQAUiUOjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA3
MTAyMjE2NDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAUBX28f+OOLwBoMvwOHjjG2t/jrCf7yTHth8l1lvP1jA7aAkl
sp747XWCOxcAbzWTHWpvNDyHUwCLaZPPshlQlpUuUJp/1tRtf8Lm1V8OoEz5Mgsz8BOAAQeXyS7x
DXC1KHbtAtlLoyFmtR3G82APINDKGomiSsq/EB0YxUFs1tZuN4KMTNy530EALAbsQOmIN9Qjo+UI
wv95DqGBnEuE8+BVGJOqqV2yIJbd1RKFe17q2zufUR68fJAVQdJyBC5qGW1GKaoLRNN0OI/ojX70
C0Ue7UvUcDD8eB4I924ZFdAVDu8YNv7lO0PaD3DVAnF7gADyEGr9kR1L4UxXl7XVwA==
--000000000000ab5b8a061cec00c6--

