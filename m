Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49A44CC65
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhKJWUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhKJWU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:26 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C132C0797BF;
        Wed, 10 Nov 2021 14:15:25 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q126so3426749pgq.13;
        Wed, 10 Nov 2021 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvW84sSM/ElHSJsh3mR8zIRk7WcSP30fNyjpi271Ac0=;
        b=o1ywP0id3ECtESf0REWtug+UcPlSNjlFpDDWFPhKmC76P7GNw1EEPeuGSPLSVgQW83
         Y19SYpmAeiDtFqfDFqHhGhe0Xrptn7Z5qtkBsLxB9I5w1kNz3zCdZG0P6NZ0WqP3VEAz
         FKT6NwHi/PDsa5FJ8DYNO+MlgtWAdG5XBRDvCr6u405AJpmHJdGK5HEjpmLnjHmy4hn8
         r+rea+cKrHsH5yWF9gPQuxn8A9I1ya29KdGSWIvf4ky2/txyMyKzJhyeW62+1AEOEly8
         DFbpSKcxvw7P6Yw2fu4tHgws/ur9NCFqHpQfaNfWhJsV8swsY1EsQkanRx8GV62RVGIV
         NAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvW84sSM/ElHSJsh3mR8zIRk7WcSP30fNyjpi271Ac0=;
        b=ZKZRotaNTFBqrUFqFEwAlI5Wwv3/5KbDFQVlhJqDmkalnAGLXJRQqiUKRMSnYCS6i9
         JgXf6gBsMDGDvJpr+rivTlKor6uYedeG1n7CrBPrSuGi4feDrn2Bu34Fb+2PJUTcP19n
         c9s+GFoqm/AbwfjiFFLXpgcyqfN7idOM99RP6msdZxFq/saIN6r/GS/jABssp1+ySfJ2
         saWf+//fe2YpdFP9EiTwyZ1v2zpVVF6ZOvRyUQpg+oRYCC1AitLhgDiEakTtGkKTzsrk
         9jgR94So8s6zp/KUT4ueXjgWdcWu08YwiU4uojt3pI9Qm2gilbdLVHZ7qWGsL2WaWjVl
         mHEw==
X-Gm-Message-State: AOAM530w9jsghFwptLmhPnY1IlSHSpLn1VNanwZJLWnRSBp7FCiXot+I
        wabDh62BS1Y0Iqr/MIBAOnXDTRq1A5PQ5w==
X-Google-Smtp-Source: ABdhPJzIGi5KipSekueMBs3NqNVbMJL1cyf++SsRu8rJ6bD9cBYgCuQ1ksTGud46Cw7E7X6WmepKJg==
X-Received: by 2002:aa7:8059:0:b0:47e:5de6:5bc7 with SMTP id y25-20020aa78059000000b0047e5de65bc7mr2285307pfm.78.1636582524337;
        Wed, 10 Nov 2021 14:15:24 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:23 -0800 (PST)
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
Subject: [PATCH v8 7/8] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
Date:   Wed, 10 Nov 2021 17:14:47 -0500
Message-Id: <20211110221456.11977-8-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
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
index ff7d0d291531..1a841c240abb 100644
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
@@ -1186,6 +1195,10 @@ static int brcm_pcie_resume(struct device *dev)
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

