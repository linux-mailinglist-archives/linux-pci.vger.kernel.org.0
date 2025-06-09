Return-Path: <linux-pci+bounces-29265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44FCAD294E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3653E7A8974
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8022126D;
	Mon,  9 Jun 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UAiAuorv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3C225A38
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507449; cv=none; b=r/v1umFOmqjfe9zJE764VxwXxRFmIoikjHp7ur8iJQk8bzJLDqXjVqBt/RpIK4npvk/kjeP1vN7FxVs4oXmHnnmsp1CDH1gRue2V9BuIWUmxFuVGVAe6pzkU6Pz3MvJFP6rD/Ln6FgJGHN3IV+2KH+z5M7BBQUdYhjeOxnLQDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507449; c=relaxed/simple;
	bh=SXgvOcebgYBHl9rBEBRljt9jfrxgE2HdmT8iq1xbmQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNWfALXRGLFfKsu/dm2HzvDWtAh5syvr61DuwOTPNiv/Vkr7fxkU9BSnF4XjCGCuMJ7hBPh+wGkMTqVHxOHK7re59ClUPknWUOr+cSsgtFqhB1YIxjjlBsdYNpoTAZ7BCQv7TVdhNjmL6Jxyg0+wkmG/U/IGxpTkWNUv5C2HWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UAiAuorv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so3938393a91.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749507447; x=1750112247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMoKAlogNuxi+k73MimG2uE83AVBZtkP2P3fFABB9ok=;
        b=UAiAuorvQoBuTMXX6rkDlWi04E0VLMLVD5yeymVyIlTAMvZgGSk1cDUSGQe//E1vfv
         CRkFpTlaf8ROCl6hL1J1mb1pby14FtHtZV+0TRt5veJFFZW4vAMqxIGpRKu9NcigrY4B
         WDWLYsxMBo/Ir8tJuukgWKRJ45njTT+hb1fPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749507447; x=1750112247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMoKAlogNuxi+k73MimG2uE83AVBZtkP2P3fFABB9ok=;
        b=L3ydG02rclSTfA76DE9TOnOFz8WVScf8ZPDtyF6asYLcxnnKtCkmROL6L11rFYFh79
         eRd3NLK9M+vS1iakKMZP1onRbwoGPokabDhLp0RHYNzEhO0X4l0e/5EOs66ld+M2Pu5y
         ILe8yfYnBRGX9VV+qASZ9435EAXIKHqPBcft2sm8VYjTWrrKHNVwDQU7QMLiECoIOnoL
         F7EDZBH6WoEwnBT/Q7aoKq7xyZx8ZHv1aCAhGzDnBqqnasubIIzjuVPfxmZAKuBQ4xee
         8CZ5bpGBODbu0x16mTZRnLOBgC9buZuVpcDyX2FQKt7ARoIEM3T12oRJcayKgSGlTJ4C
         jBUA==
X-Gm-Message-State: AOJu0YysNm3xvI+WivGpt6ceGYzave0D6s899wcIRy4xo5fiNqJnAGfy
	uGp7FF8B2cqicTyNXbQGwz4cNXkQzcLlBE6EglxCcl4CtDi/Zl9r+1khDl74QnmS958VAXtnkZd
	OJO09peNRAGEdOouLnFp16muMEn/jGQcQdZzqXfdQfImTcRGdvFiamt2U25/Q+lc5nvVK6i9iFn
	t45xDmttmIkUzgT31hj0VHFr/hM3gmINZl/cHBesPuBhzMg5POGnOy
X-Gm-Gg: ASbGncu2YJ7O0S/tsnbGmb2kN+NsEqzbPqvNh5jWhUkaZJRZDLf2ztuExUNVRtQxH9i
	aEvQCDRPjixlsXSTk81ZmMvZOMHb9kAyYC2N7iVb7OrgGvgoSKbFRFxpFpDM2xl/ah9ioqqg61x
	e/dMA1zN/9nQQBDEFgziYAnEGEXApdS0Dz1/aAMmu3GXZ4eCoEXLzp/bPAMV93Ub0HT+j7QjJ6b
	c8/CBcwp8CVPU50hoGr89V4Rqb35q/2zTioXr4rFHGt3dhDfwyFYJTSeWOjPFZDxk5I8MQLmtYm
	vCK5/lDxNpmvVEd8aHYvNOl/lAFDDRIFit0ri7IZ6NpwQssvd8IZpGOJkrRK2fXRVLtCB7+pCHH
	TtfPOms5n5S5OY88bTwMh5XAZvJPeZPwm0QZmZlyi7EVcwwnHpo7Y
X-Google-Smtp-Source: AGHT+IH9Z2VFHsTsQkiIm50bQai7IcSgX6nHAp/z/E6H/q5Ll4+CHu3KKn/F1i+u9OsTfpSNvWZuDg==
X-Received: by 2002:a17:90b:2ec7:b0:312:ec:4128 with SMTP id 98e67ed59e1d1-3134706f814mr18808620a91.34.1749507446759;
        Mon, 09 Jun 2025 15:17:26 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078d65sm59290415ad.5.2025.06.09.15.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:17:26 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] PCI: brcmstb: Enable Broadcom Cable Modem SoCs
Date: Mon,  9 Jun 2025 18:17:06 -0400
Message-ID: <20250609221710.10315-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609221710.10315-1-james.quinlan@broadcom.com>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom's Cable Modem (CM) group also uses this PCIe driver
as it shares the PCIe HW core with the STB group.

Make the modifications to enable the CM SoCs.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 186 +++++++++++++++++++++-----
 1 file changed, 152 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index db7872cda960..e25dbcdc56a7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -51,6 +51,9 @@
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
 #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
 
+#define PCIE_RC_DL_PDL_CONTROL_4			0x1010
+#define  PCIE_RC_DL_PDL_CONTROL_4_NPH_FC_INIT_MASK	0xff000000
+
 #define PCIE_RC_DL_MDIO_ADDR				0x1100
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
@@ -60,6 +63,7 @@
 #define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
 
 #define PCIE_MISC_MISC_CTRL				0x4008
+#define  PCIE_MISC_MISC_CTRL_PCIE_IN_CPL_RO_MASK	0x20
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
 #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
@@ -170,6 +174,7 @@
 /* MSI target addresses */
 #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
 #define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
+#define BRCM_MSI_TARGET_ADDR_FOR_CM	0xfffffffffcULL
 
 /* MDIO registers */
 #define MDIO_PORT0			0x0
@@ -223,13 +228,23 @@ enum {
 enum pcie_soc_base {
 	GENERIC,
 	BCM2711,
+	BCM3162,
+	BCM3392,
+	BCM3390,
 	BCM4908,
 	BCM7278,
 	BCM7425,
 	BCM7435,
 	BCM7712,
+	BCM33940,
 };
 
+/*
+ * BCM3390 CM chip actually conforms to STB design, so it
+ * is not present in the macro below.
+ */
+#define IS_CM_SOC(t) ((t) == BCM3162 || (t) == BCM33940 || (t) == BCM3392)
+
 struct inbound_win {
 	u64 size;
 	u64 pci_offset;
@@ -757,6 +772,9 @@ static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
 	int ret = 0;
 
+	if (IS_CM_SOC(pcie->cfg->soc_base))
+		return 0;
+
 	if (pcie->bridge_reset) {
 		if (val)
 			ret = reset_control_assert(pcie->bridge_reset);
@@ -891,13 +909,13 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	struct inbound_win *b = b_begin;
 
 	/*
-	 * STB chips beside 7712 disable the first inbound window default.
-	 * Rather being mapped to system memory it is mapped to the
-	 * internal registers of the SoC.  This feature is deprecated, has
-	 * security considerations, and is not implemented in our modern
-	 * SoCs.
+	 * STB chips beside CM chips and 7712 disable the first inbound
+	 * window default.  Rather being mapped to system memory it is
+	 * mapped to the internal registers of the SoC.  This feature is
+	 * deprecated, has security considerations, and is not
+	 * implemented in our modern SoCs.
 	 */
-	if (pcie->cfg->soc_base != BCM7712)
+	if (pcie->cfg->soc_base != BCM7712 && !IS_CM_SOC(pcie->cfg->soc_base))
 		add_inbound_win(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
@@ -905,16 +923,32 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		u64 cpu_start = entry->res->start;
 
 		size = resource_size(entry->res);
+
+		/*
+		 * For BCM3390, single dma-range may map to the SoC
+		 * register space in [0xf0000000..0xffffffff].  If present,
+		 * this has to be assigned to inbound window #1, as this is
+		 * the only one that HW allows to map to register space.
+		 * So if we see this range, place it in inbound_wins[1]
+		 * which is previously disabled (zeroed out).
+		 */
+		if (pcie->cfg->soc_base == BCM3390 && cpu_start >= 0xf0000000
+		    && cpu_start + size - 1 <= 0xffffffff) {
+			add_inbound_win(b_begin, &n, size, cpu_start, pcie_start);
+			n--;
+			continue;
+		}
+
 		tot_size += size;
 		if (pcie_start < lowest_pcie_addr)
 			lowest_pcie_addr = pcie_start;
 		/*
-		 * 7712 and newer chips may have many BARs, with each
-		 * offering a non-overlapping viewport to system memory.
-		 * That being said, each BARs size must still be a power of
-		 * two.
+		 * 7712, CM, and newer chips may have many inbound windows,
+		 * with each offering a non-overlapping viewport to system
+		 * memory.  That being said, each window's size must still
+		 * be a power of two.
 		 */
-		if (pcie->cfg->soc_base == BCM7712)
+		if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base))
 			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
 
 		if (n > pcie->cfg->num_inbound_wins)
@@ -927,11 +961,11 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	}
 
 	/*
-	 * 7712 and newer chips do not have an internal memory mapping system
-	 * that enables multiple memory controllers.  As such, it can return
-	 * now w/o doing special configuration.
+	 * 7712, CM, and newer chips do not have an internal memory
+	 * mapping system that enables multiple memory controllers.  As
+	 * such, it can return now w/o doing special configuration.
 	 */
-	if (pcie->cfg->soc_base == BCM7712)
+	if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base))
 		return n;
 
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
@@ -1051,10 +1085,10 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
 		/*
 		 * Most STB chips:
 		 *     Do nothing.
-		 * 7712:
-		 *     All of their BARs need to be set.
+		 * 7712, CM:
+		 *     All of their inbound windows need to be set.
 		 */
-		if (pcie->cfg->soc_base == BCM7712) {
+		if (pcie->cfg->soc_base == BCM7712 || IS_CM_SOC(pcie->cfg->soc_base)) {
 			/* BUS remap register settings */
 			reg_offset = brcm_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1118,6 +1152,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		burst = 0x0; /* 128 bytes */
 	else if (pcie->cfg->soc_base == BCM7278)
 		burst = 0x3; /* 512 bytes */
+	else if (pcie->cfg->soc_base == BCM3162 || pcie->cfg->soc_base == BCM33940)
+		burst = 0x1; /* Encoding: 0=64, 1=128, 2=Rsvd, 3=Rsvd */
 	else
 		burst = 0x2; /* 512 bytes */
 
@@ -1144,18 +1180,20 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		return -EINVAL;
 	}
 
-	tmp = readl(base + PCIE_MISC_MISC_CTRL);
-	for (memc = 0; memc < pcie->num_memc; memc++) {
-		u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
-
-		if (memc == 0)
-			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(0));
-		else if (memc == 1)
-			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(1));
-		else if (memc == 2)
-			u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(2));
+	if (!IS_CM_SOC(pcie->cfg->soc_base)) {
+		tmp = readl(base + PCIE_MISC_MISC_CTRL);
+		for (memc = 0; memc < pcie->num_memc; memc++) {
+			u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
+
+			if (memc == 0)
+				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(0));
+			else if (memc == 1)
+				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(1));
+			else if (memc == 2)
+				u32p_replace_bits(&tmp, scb_size_val, SCB_SIZE_MASK(2));
+		}
+		writel(tmp, base + PCIE_MISC_MISC_CTRL);
 	}
-	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	/*
 	 * We ideally want the MSI target address to be located in the 32bit
@@ -1164,8 +1202,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 * 4GB or when the inbound area is smaller than 4GB (taking into
 	 * account the rounding-up we're forced to perform).
 	 */
-	if (inbound_wins[2].pci_offset >= SZ_4G ||
-	    (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
+	if (IS_CM_SOC(pcie->cfg->soc_base))
+		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_FOR_CM;
+	else if (inbound_wins[2].pci_offset >= SZ_4G ||
+		 (inbound_wins[2].size + inbound_wins[2].pci_offset) < SZ_4G)
 		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
 	else
 		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
@@ -1226,6 +1266,29 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK);
 	writel(tmp, base + PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1);
 
+	/*
+	 * Relax read ordering for chip architectures using RBUS/SCB that
+	 * use WiFi Runner offload (i.e. BCM3390) to avoid deadlock where
+	 * reads are blocked by writes.
+	 */
+	if (pcie->cfg->soc_base == BCM3390) {
+		tmp = readl(base + PCIE_MISC_MISC_CTRL);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_IN_CPL_RO_MASK);
+		writel(tmp, base + PCIE_MISC_MISC_CTRL);
+	}
+
+	/*
+	 * The 3392 has a bug that requires the NP credit advertised by the
+	 * MAC to be overwritten with 0x10 in bits 31:24 of the following
+	 * register.
+	 */
+	if (pcie->cfg->soc_base == BCM3392) {
+		tmp = readl(base + PCIE_RC_DL_PDL_CONTROL_4);
+		u32p_replace_bits(&tmp, 0x10,
+				  PCIE_RC_DL_PDL_CONTROL_4_NPH_FC_INIT_MASK);
+		writel(tmp, base + PCIE_RC_DL_PDL_CONTROL_4);
+	}
+
 	if (pcie->cfg->post_setup) {
 		ret = pcie->cfg->post_setup(pcie);
 		if (ret < 0)
@@ -1246,8 +1309,8 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
-	/* 7712 does not have this (RGR1) timer */
-	if (pcie->cfg->soc_base == BCM7712)
+	/* CM and 7712 do not have this (RGR1) timer */
+	if (IS_CM_SOC(pcie->cfg->soc_base) || pcie->cfg->soc_base == BCM7712)
 		return;
 
 	/* Each unit in timeout register is 1/216,000,000 seconds */
@@ -1354,7 +1417,10 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 
 	brcm_config_clkreq(pcie);
 
-	if (pcie->ssc) {
+	if (IS_CM_SOC(pcie->cfg->soc_base)) {
+		/* This driver does configure SSC for CM chips */
+		ssc_str = "";
+	} else if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
 			ssc_str = "(SSC)";
@@ -1715,6 +1781,14 @@ static const int pcie_offsets[] = {
 	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
 
+static const int pcie_offset_bcm3162[] = {
+	[RGR1_SW_INIT_1] = 0x9210,
+	[EXT_CFG_INDEX] = 0x9000,
+	[EXT_CFG_DATA] = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4204,
+	[PCIE_INTR2_CPU_BASE] = 0x4300
+};
+
 static const int pcie_offsets_bcm7278[] = {
 	[RGR1_SW_INIT_1]	= 0xc010,
 	[EXT_CFG_INDEX]		= 0x9000,
@@ -1739,6 +1813,14 @@ static const int pcie_offsets_bcm7712[] = {
 	[PCIE_INTR2_CPU_BASE]	= 0x4400,
 };
 
+static const int pcie_offset_bcm33940[] = {
+	[RGR1_SW_INIT_1] = 0x9210,
+	[EXT_CFG_INDEX] = 0x9000,
+	[EXT_CFG_DATA] = 0x9004,
+	[PCIE_HARD_DEBUG] = 0x4304,
+	[PCIE_INTR2_CPU_BASE] = 0x4400
+};
+
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
 	.soc_base	= GENERIC,
@@ -1765,6 +1847,30 @@ static const struct pcie_cfg_data bcm2712_cfg = {
 	.num_inbound_wins = 10,
 };
 
+static const struct pcie_cfg_data bcm3162_cfg = {
+	.offsets	= pcie_offset_bcm3162,
+	.soc_base	= BCM3162,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
+};
+
+static const struct pcie_cfg_data bcm3392_cfg = {
+	.offsets	= pcie_offset_bcm33940,
+	.soc_base	= BCM3392,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 10,
+};
+
+static const struct pcie_cfg_data bcm3390_cfg = {
+	.offsets	= pcie_offsets,
+	.soc_base	= BCM3390,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 3,
+};
+
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
 	.soc_base	= BCM4908,
@@ -1814,9 +1920,20 @@ static const struct pcie_cfg_data bcm7712_cfg = {
 	.num_inbound_wins = 10,
 };
 
+static const struct pcie_cfg_data bcm33940_cfg = {
+	.offsets	= pcie_offset_bcm33940,
+	.soc_base	= BCM33940,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.num_inbound_wins = 10,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
+	{ .compatible = "brcm,bcm3162-pcie", .data = &bcm3162_cfg },
+	{ .compatible = "brcm,bcm3390-pcie", .data = &bcm3390_cfg },
+	{ .compatible = "brcm,bcm3392-pcie", .data = &bcm3392_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
@@ -1825,6 +1942,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
+	{ .compatible = "brcm,bcm33940-pcie", .data = &bcm33940_cfg },
 	{},
 };
 
-- 
2.43.0


