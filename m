Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E891C46F5C1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhLIVSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhLIVSC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:18:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70052C0617A2;
        Thu,  9 Dec 2021 13:14:28 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u11so4853359plf.3;
        Thu, 09 Dec 2021 13:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Qzj5uM3WmTTnFaEKj5iKt+4OPXn0Lx6lUn5gyvkQ+E=;
        b=T7zIYHXGDGLH68yTR9AS+wy5YX4rG81euAcVO+77a6QXucxpOLsryN1xcuLI3aTb7J
         VRni6YqAAqlt94AIDRc6BrLELzW3yxEC5MqWw+8m86mi4dt70oBkfpuWiYrktw6jrtxD
         oy5zYUip31rq0vzE/z2zP48wc4SmXc2tjYkZckFEKv3ra/6vz38xIa+xuQzhNc6h/FpV
         w8f6bwKUsxNZCu394H+EqVZN4n8b0J6AqYvfcEcxv+6+6mW7eHNR95tC3w59HallXnf/
         rshjeohThuGuJY7MCO+YzS2+b33IBTuv90tMlr4iz1z5wjoOI/V7LSb30ytSDQYprtiy
         xJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Qzj5uM3WmTTnFaEKj5iKt+4OPXn0Lx6lUn5gyvkQ+E=;
        b=ex8qWLqAcCTnWM4FYeJd2QPyuuQd+0Af78aVLsiyyEcvLRPwC/Dreni/ymRxF/lx7a
         77+gjZlpNEax7lsUdv4q95nTbtX/zDcznrCt5m5ucIANolSRquYDPVIso9lXy0/AwuQt
         QAWzQT1E/ZF0rITDGdqwUC2npD56OyJwm8kH6NeSOQrCRZM7QwUos8F+3tcDKVD231LS
         PVkozhckhheBKP+AXcg6oQlBf3F3A7YZ4Ex5c8X1IKIsXZqGkIcRfZRD9bLMWyqoS0m/
         nWoeqm3e65FONFARk9K8x423PC36tgOo2bIxhjFXKfhTP7I1pF4rRqXT01O9+3bYp9vr
         m1dQ==
X-Gm-Message-State: AOAM531VO4gSKb/+q2FA+eNManbvkBx3Vl1Xkucg0jytn9g7zZ8Q76rh
        7GikFSoqZ0ZbKKFlP2c4M3T3KQFGpDg=
X-Google-Smtp-Source: ABdhPJxJq3ZihiJupQgXscc7nwgUJE1FJX6qa58J9Fl7YdyGBvG0UmIGNfLmNJOVbp9oG0KDahudVQ==
X-Received: by 2002:a17:903:1210:b0:143:a088:7932 with SMTP id l16-20020a170903121000b00143a0887932mr71635830plh.11.1639084467692;
        Thu, 09 Dec 2021 13:14:27 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id y4sm617800pfi.178.2021.12.09.13.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:14:27 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 5/7] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
Date:   Thu,  9 Dec 2021 16:14:03 -0500
Message-Id: <20211209211407.8102-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
References: <20211209211407.8102-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We need to take some code in brcm_pcie_setup() and put it in a new function
brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
be called indirectly by pci_host_probe() as opposed to the host driver
invoking it directly.

Some code that was executed after the PCIe linkup is now placed so that it
executes prior to linkup, since this code has to run prior to the
invocation of pci_host_probe().

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 65 ++++++++++++++++-----------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9ed79ddb6a83..5f373227aad6 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -863,16 +863,9 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
-	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	u64 rc_bar2_offset, rc_bar2_size;
 	void __iomem *base = pcie->base;
-	struct device *dev = pcie->dev;
-	struct resource_entry *entry;
-	bool ssc_good = false;
-	struct resource *res;
-	int num_out_wins = 0;
-	u16 nlw, cls, lnksta;
-	int i, ret, memc;
+	int ret, memc;
 	u32 tmp, burst, aspm_support;
 
 	/* Reset the bridge */
@@ -957,6 +950,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
+	/* Don't advertise L0s capability if 'aspm-no-l0s' */
+	aspm_support = PCIE_LINK_STATE_L1;
+	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
+		aspm_support |= PCIE_LINK_STATE_L0S;
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+	u32p_replace_bits(&tmp, aspm_support,
+		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+
+	/*
+	 * For config space accesses on the RC, show the right class for
+	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
+	 */
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+	u32p_replace_bits(&tmp, 0x060400,
+			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+
+	return 0;
+}
+
+static int brcm_pcie_linkup(struct brcm_pcie *pcie)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	struct device *dev = pcie->dev;
+	void __iomem *base = pcie->base;
+	struct resource_entry *entry;
+	struct resource *res;
+	int num_out_wins = 0;
+	u16 nlw, cls, lnksta;
+	bool ssc_good = false;
+	u32 tmp;
+	int ret, i;
+
 	/* Unassert the fundamental reset */
 	pcie->perst_set(pcie, 0);
 
@@ -994,24 +1021,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		num_out_wins++;
 	}
 
-	/* Don't advertise L0s capability if 'aspm-no-l0s' */
-	aspm_support = PCIE_LINK_STATE_L1;
-	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
-		aspm_support |= PCIE_LINK_STATE_L0S;
-	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
-	u32p_replace_bits(&tmp, aspm_support,
-		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
-	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
-
-	/*
-	 * For config space accesses on the RC, show the right class for
-	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
-	 */
-	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
-	u32p_replace_bits(&tmp, 0x060400,
-			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
-	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
-
 	if (pcie->ssc) {
 		ret = brcm_pcie_set_ssc(pcie);
 		if (ret == 0)
@@ -1200,6 +1209,10 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		goto err_reset;
 
+	ret = brcm_pcie_linkup(pcie);
+	if (ret)
+		goto err_reset;
+
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
-- 
2.17.1

