Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA502444897
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhKCSwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhKCSwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF5C06120B;
        Wed,  3 Nov 2021 11:49:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso2120127pjb.2;
        Wed, 03 Nov 2021 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+KIUczUS/ZsYc2yKqmHED/7x17icKPInYDTolIdaty0=;
        b=VRwLrL82bnQDTaHfLIz36gShEC2CRz5Ssow3SBz2QkVVpRIUdqnJPNY9dr635rzky5
         EI9H0iZ4vQpItvYSglTFAXJdafJdyAxGP8lMnqzwtgF8XF2lEWXA0unrjHV1BxF7Lokj
         zSn55qlG7xzZarOzCzpIPEGnb0Uffg/uH7Txm/909GRFSsj2fhjlTHkh/uY4YMufGM0y
         TdR1YwNjvGZmqne1FnPNOub3PPpZpaLcYqBgouh2g7U5eseNiK5HheQWMxuvDbulc+t7
         6XIQyOQsgQRDNsTQvnOSwy85BcWiL0Gjtb3zB65Zzhf2kROaQ8Z/XprheMBHaPp1Ib7S
         vlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+KIUczUS/ZsYc2yKqmHED/7x17icKPInYDTolIdaty0=;
        b=rQGrnBDgyHLipFgbehzFtv/a4sMEeMbqKkk4VR2E77MBbMJZAp69DIkuylx3rHTd1I
         hj+OYXrqZnDh32WA6vx0B0HM2LHtYDELuKEeDgOhBBdTVsYI2Ky6qHvKqjsF9PVOE/Vi
         BYK5onWd31E+3A3R99qo8/15Z+0cjh+lbbWbcgpthbnrx0VZQS6h1h66xqsYWat5Hrg9
         ZFNa01nRvV2wzL2rtZPJFc6vzItuoEDW6wMxmYlOvFs0oRQcXbPrvm/V3KCGbtEXrXUY
         rEKt0plBeaETu9ym+Vz37Xm/IaijIR/CFs4bcYlaBwWMuU4PUoHnC4D1Lri7/cGYe0Lt
         6D5g==
X-Gm-Message-State: AOAM533Z6+8t1CEvWy4OA4Yty9J0fXqvdmzYXlIsKzImlQ8zZsSxaZfo
        7lR/Mei1WzTuwvxB1Zge2b5kc0Fz6RP21A==
X-Google-Smtp-Source: ABdhPJz7p4koVRRiR5HdILl24gGZV0hYsk1W8hGHmXKRWDnY3dPh8DQfSUExvFTUANzPFJ75UZXuzQ==
X-Received: by 2002:a17:902:bc8a:b0:141:eb43:81a1 with SMTP id bb10-20020a170902bc8a00b00141eb4381a1mr20280237plb.52.1635965393405;
        Wed, 03 Nov 2021 11:49:53 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:49:52 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 3/7] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
Date:   Wed,  3 Nov 2021 14:49:33 -0400
Message-Id: <20211103184939.45263-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103184939.45263-1-jim2101024@gmail.com>
References: <20211103184939.45263-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We need to split a function in two so that the driver can take advantage of
the recently added function pci_subdev_prepare() which is a member
of struct pci_host_bridge.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index cc30215f5a43..ba4d6daf312c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -863,17 +863,10 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 
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
-	u32 tmp, burst, aspm_support;
+	int ret, memc;
+	u32 tmp, burst;
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
@@ -956,6 +949,21 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
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
+	u32 aspm_support, tmp;
+	int ret, i;
 
 	/* Unassert the fundamental reset */
 	pcie->perst_set(pcie, 0);
@@ -1186,6 +1194,10 @@ static int brcm_pcie_resume(struct device *dev)
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

