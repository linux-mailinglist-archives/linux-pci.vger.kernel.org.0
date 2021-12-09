Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E446F539
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhLIUvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhLIUvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:51:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA87C0617A2;
        Thu,  9 Dec 2021 12:47:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso5840447pjb.2;
        Thu, 09 Dec 2021 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P7CI0O4LKASyygrit9TZpBhgpylHroNbFUMb6QAS3I8=;
        b=krYXYVyzpkXUZrVhcOnlFBHk5CBiWI//2NQK/pT90PtsZ4THWwSsycO0PeoKMdjk8D
         bIhYSk5kcr06MlzL+4LC6UN+eVbu7bHt3WJ6EcKH04c6Ea3v8sbZx/lBz1VZK1cyRH89
         UOYvEfcxL4kY+6kUKeYgB2OmAEY6bPrqpjwatwq8DgrqMTZ/f1A1ouo/tCmz9GWXm5GL
         F3ZG6D1Xjlf64d6EsQURczWYoIL3tFw0VcEAA5nekNUxsFgj99yOfEkrq18lcBWaPrPy
         H43X0ZRXYGNfyX0KHh68LvCHVih9U3DPPoSAzLzmdmf76dIXnpbK66VVtT9EnsaxvqR0
         PjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P7CI0O4LKASyygrit9TZpBhgpylHroNbFUMb6QAS3I8=;
        b=c4cVoAvROtU6RFriAZmPoBY+A0rNRU2WH5szhehGjjjy0PLDiTPYWqgyS+aAHuHmd9
         I6ZN84xAX5A/4slcAOeo0csefxsO5V5g+Lp8wnw1fEntQJlc2b6OLxi+KuBkSrezR5A2
         4vnYJBq1BleDWv6RJHRoX+CcmFuWud3z8NepPXnVeqMwr5emXaQLUls3KFhPzHLRwR0a
         VPbLHcnXVd6f2MDRpIPxTiVM0W+wlAJIifcQK6ZcfYiggvxzolUx98FjFoNPsS1fesBK
         2sVYELBvj98bKPB5XjQA95bChBdjnoUb5U+iNhri/JxoZeetrjEUTvSIixXFO0n/pR7T
         MFHA==
X-Gm-Message-State: AOAM533mHf3BAS90lzoLl/6LD8G+YduvOotFNEkhdYRLnnMLpHwx8kb+
        lF0NBRgvqzzrBFQsvVU4Dkf6hcKTRmw=
X-Google-Smtp-Source: ABdhPJwYPJnlyTvi5MhfAObzMxXqiHUoRovDyNSrsYs+OhGJPp6v+G+E/l4UY6YSLMIlYrCDY5LCXw==
X-Received: by 2002:a17:90a:1919:: with SMTP id 25mr18941559pjg.154.1639082863527;
        Thu, 09 Dec 2021 12:47:43 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id f185sm568370pfg.39.2021.12.09.12.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:47:42 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v1 4/4] PCI: brcmstb: Augment driver for MIPs SOCs
Date:   Thu,  9 Dec 2021 15:47:25 -0500
Message-Id: <20211209204726.6676-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209204726.6676-1-jim2101024@gmail.com>
References: <20211209204726.6676-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The current brcmstb driver works for Arm and Arm64.  A few things are
modified here for us to support MIPs as well.

  o There are four outbound range register groups and each directs a window
    of up to 128MB.  Even though there are four 128MB DT "ranges" in the
    bmips PCIe DT node, these ranges are contiguous and are collapsed into
    a single range by the OF range parser.  Now the driver assumes a single
    range -- for MIPs only -- and splits it back into 128MB sizes.

  o For bcm7425, the config space accesses must be 32-bit reads or
    writes.  In addition, the 4k config space register array is missing
    and not used.

  o The registers for the upper 32-bits of the outbound window address do
    not exist.

  o Burst size must be set to 256 (this refers to an internal bus).

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pcie-brcmstb.c | 82 +++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 93b141110537..4ac474d4a956 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -274,7 +274,7 @@ config PCIE_BRCMSTB
 		   BMIPS_GENERIC || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
-	default ARCH_BRCMSTB
+	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Say Y here to enable PCIe host controller support for
 	  Broadcom STB based SoCs, like the Raspberry Pi 4.
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..a267cd5b3233 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -118,6 +118,7 @@
 #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
+#define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x00800000
 
 
 #define PCIE_INTR2_CPU_BASE		0x4300
@@ -205,6 +206,8 @@ enum {
 
 enum pcie_type {
 	GENERIC,
+	BCM7425,
+	BCM7435,
 	BCM4908,
 	BCM7278,
 	BCM2711,
@@ -223,6 +226,12 @@ static const int pcie_offsets[] = {
 	[EXT_CFG_DATA]   = 0x9004,
 };
 
+static const int pcie_offsets_bmips_7425[] = {
+	[RGR1_SW_INIT_1] = 0x8010,
+	[EXT_CFG_INDEX]  = 0x8300,
+	[EXT_CFG_DATA]   = 0x8304,
+};
+
 static const struct pcie_cfg_data generic_cfg = {
 	.offsets	= pcie_offsets,
 	.type		= GENERIC,
@@ -230,6 +239,20 @@ static const struct pcie_cfg_data generic_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm7425_cfg = {
+	.offsets	= pcie_offsets_bmips_7425,
+	.type		= BCM7425,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
+static const struct pcie_cfg_data bcm7435_cfg = {
+	.offsets	= pcie_offsets,
+	.type		= BCM7435,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
 static const struct pcie_cfg_data bcm4908_cfg = {
 	.offsets	= pcie_offsets,
 	.type		= BCM4908,
@@ -297,6 +320,11 @@ struct brcm_pcie {
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
+static inline bool is_bmips(const struct brcm_pcie *pcie)
+{
+	return pcie->type == BCM7435 || pcie->type == BCM7425;
+}
+
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -443,6 +471,9 @@ static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
 			  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK);
 	writel(tmp, pcie->base + PCIE_MEM_WIN0_BASE_LIMIT(win));
 
+	if (is_bmips(pcie))
+		return;
+
 	/* Write the cpu & limit addr upper bits */
 	high_addr_shift =
 		HWEIGHT32(PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK);
@@ -718,12 +749,35 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	return base + PCIE_EXT_CFG_DATA + where;
 }
 
+static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devfn,
+					 int where)
+{
+	struct brcm_pcie *pcie = bus->sysdata;
+	void __iomem *base = pcie->base;
+	int idx;
+
+	/* Accesses to the RC go right to the RC registers if slot==0 */
+	if (pci_is_root_bus(bus))
+		return PCI_SLOT(devfn) ? NULL : base + (where & ~0x3);
+
+	/* For devices, write to the config space index register */
+	idx = PCIE_ECAM_OFFSET(bus->number, devfn, (where & ~3));
+	writel(idx, base + IDX_ADDR(pcie));
+	return base + DATA_ADDR(pcie);
+}
+
 static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
 };
 
+static struct pci_ops brcm_pcie_ops32 = {
+	.map_bus = brcm_pcie_map_conf32,
+	.read = pci_generic_config_read32,
+	.write = pci_generic_config_write32,
+};
+
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
@@ -883,7 +937,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 0);
 
 	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
-	tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
+	if (is_bmips(pcie))
+		tmp &= ~PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
+	else
+		tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
 	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
 	/* Wait for SerDes to be stable */
 	usleep_range(100, 200);
@@ -893,8 +950,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
 	 * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
 	 */
-	if (pcie->type == BCM2711)
-		burst = 0x0; /* 128B */
+	if (is_bmips(pcie))
+		burst = 0x1; /* 256 bytes */
+	else if (pcie->type == BCM2711)
+		burst = 0x0; /* 128 bytes */
 	else if (pcie->type == BCM7278)
 		burst = 0x3; /* 512 bytes */
 	else
@@ -988,6 +1047,19 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 			return -EINVAL;
 		}
 
+		if (is_bmips(pcie)) {
+			u64 start = res->start;
+			unsigned int j, nwins = resource_size(res) / SZ_128M;
+
+			/* bmips PCIe outbound windows have a 128MB max size */
+			if (nwins > BRCM_NUM_PCIE_OUT_WINS)
+				nwins = BRCM_NUM_PCIE_OUT_WINS;
+			for (j = 0; j < nwins; j++, start += SZ_128M)
+				brcm_pcie_set_outbound_win(pcie, j, start,
+							   start - entry->offset,
+							   SZ_128M);
+			break;
+		}
 		brcm_pcie_set_outbound_win(pcie, num_out_wins, res->start,
 					   res->start - entry->offset,
 					   resource_size(res));
@@ -1226,6 +1298,8 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
+	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
+	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
 	{},
 };
 
@@ -1315,7 +1389,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = &brcm_pcie_ops;
+	bridge->ops = pcie->type == BCM7425 ? &brcm_pcie_ops32 : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.17.1

