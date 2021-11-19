Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339C457881
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhKSWLV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbhKSWLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 17:11:16 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF169C061574;
        Fri, 19 Nov 2021 14:08:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so8928861pjb.1;
        Fri, 19 Nov 2021 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Qzj5uM3WmTTnFaEKj5iKt+4OPXn0Lx6lUn5gyvkQ+E=;
        b=GDBt8g5Niq+zlRLNMjg3+WqhC86C2L43ATn6svv85dl6zQ56CsdkZMY3QzF8+H2qd9
         gzdYAA4cvCRwImuoXceQ8k5VAeSwmxJq6eGi3A1a5VHCyxqi5Pn0+8mb2fdBEUjZdkjI
         TcOOyJgdkW+3y0M5aQeRpp7R2X7ELgxGQw1oUg4zH3ZGPIe6Fvwq7cY2SZyrpLrbIvKv
         orQyHhL9dGhY0JTDRH5ykJyaNhWwvbOv/LKkyLz+/BqFsMgQfSPUBCiiwl06xa8l+Lo/
         6E7XKDSjqGR1VfMKYRfBbYJH/awezZz7En/AxBRDOFmyvamtmMNuJ7ssCOUgvoiRg/j7
         n8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Qzj5uM3WmTTnFaEKj5iKt+4OPXn0Lx6lUn5gyvkQ+E=;
        b=Q9VYPQp3rk0epDTzq8PONa1l6VqjfrLeKjRvPKxR9/2vemUkq+ZHoFwIKVCk7icowv
         eDkMQ1RMw9pthQ0u2pohNJEoeHBwtcg5msjTMOWzIxGDQb577do0jG0N1EJwt5SduMbp
         d4HjZKnwB8GitbDwCwriCb/qw6xEEyMv41mrYQk39+ee3qP0A/YQnfLkvJ4L55uaN/TT
         A19ebxZk4vvmNfFh7Co9SHOa2yINojcShrEsb+nkvgGg+3oZcYQF47JER/ZzS0e07kRx
         9AVvLP1rO/FbCKbCIK3XJRxS3plouQi8FS/+aLb5lO+Xq3K8VKBl/5ByL9FjIQabHMOn
         FGcg==
X-Gm-Message-State: AOAM530IHJFsvFgl/+wHV9rUZFwWYYWoD91aZxW4I1WJ50Akk568ZtLN
        C3lq9PfeJ2JESdkNJGtorKmlX9+70FbrKw==
X-Google-Smtp-Source: ABdhPJxn0P0q6CY+GSX7H1+0FReMXcgaPqgEf8Ede+HaJV7J5IkSZmvYUO6EXrjDi+IyreLfEUSDOg==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr3796903pjb.142.1637359693167;
        Fri, 19 Nov 2021 14:08:13 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t2sm612940pfd.36.2021.11.19.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:08:12 -0800 (PST)
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
Subject: [PATCH v9 5/7] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
Date:   Fri, 19 Nov 2021 17:07:52 -0500
Message-Id: <20211119220756.18628-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119220756.18628-1-jim2101024@gmail.com>
References: <20211119220756.18628-1-jim2101024@gmail.com>
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

