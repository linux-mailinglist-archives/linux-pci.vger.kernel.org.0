Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA0B5E8E46
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiIXQDL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiIXQDK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 12:03:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C53A155
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b6so3106839ljr.10
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5Fw2HWdlMkJhO3UC0znX6ahd5v6qxKMsjDOm0yRZsrg=;
        b=Ic5WniG9E+e+bTFlBI8w1LvNb2y/C2zRUPlxP2fFTaD+swgTZmOjQ/sS6gbwvEzBFH
         Gspt1VY8P7b3y8gXCY9y2W+wZBPpKaYfg/MEYciPh1Mjm5Wfb6oOtz7ORudtAP0RHXBN
         RdBYxz3Q8NxhSBZ6+q3vDKnX8h7Zn5eLnI/6m8i67N8QfuN6ciWFnQdeYTYBneCdWnpW
         IUM109P9OXS7auXiVXL5dRiMMPOWiouHkA9exp67azOESHVH/APF+v4M/U+SjrInZwga
         AMxxP0r5+DKdvN/4yWD2BrRRh6a5DKGCZQY983isgPkCgUxTlz6XNZtkacRUDkmfRsQe
         o7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5Fw2HWdlMkJhO3UC0znX6ahd5v6qxKMsjDOm0yRZsrg=;
        b=Jt8Em/ukd5LrO6W3JhDNEJcLPza6eRkt4MBe4tte0rDSQmpKX8p7fo7Up4S48CXrLe
         7oDTfnbsCa8SatyMs4wVwZMH4c0td9uV4f7RgVNyuIgnQGqjqUUf61q7QLSBJeQJCvRk
         Pzk8VXWMi6ZGDf9wO5wYF+1Hr9jQ2WnACYJ0Fx1vNdeQmWu6upHH7p+TCh8APxYqJH8Q
         Lt060PRswZAalLdolW6u73zqZ/hbS6cjhs4eicoRjXAJVttB99IUiwlZ+zj2oGGwDFVX
         9812/aPnZLJgnXymJt00IfahUNCzu+UoOUwP0uj+NBpVmiiIA2CIPeh9yfQHvKMpYB60
         mZvw==
X-Gm-Message-State: ACrzQf01T08ghwR5OpPbXElcSXAqu5QHWUIADcTQnbZJR2ZiHb/KjJ1l
        FfpGC+NlBirdkztoUfnxxoNGHw==
X-Google-Smtp-Source: AMsMyM7M2IxI4tauVrsGy1D2gHP8KO5950S7LC1ANkRMgbdrMgYnj6X6XZ2T7LDNU9sEdoDucfRIGw==
X-Received: by 2002:a05:651c:234:b0:26c:77bf:8eb3 with SMTP id z20-20020a05651c023400b0026c77bf8eb3mr3313764ljn.178.1664035385780;
        Sat, 24 Sep 2022 09:03:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([95.161.222.31])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm1928015lfq.207.2022.09.24.09.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:03:05 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH v4 2/6] phy: qcom-qmp-pcie: split PHY programming to separate functions
Date:   Sat, 24 Sep 2022 19:02:58 +0300
Message-Id: <20220924160302.285875-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Split the code using PHY programming tables into separate functions,
which take a single struct qmp_phy_cfg_tables instance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 80 ++++++++++++++----------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 30806816c8b0..6e8c74585670 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1877,15 +1877,53 @@ static void qmp_pcie_configure(void __iomem *base,
 	qmp_pcie_configure_lane(base, regs, tbl, num, 0xff);
 }
 
-static int qmp_pcie_serdes_init(struct qmp_phy *qphy)
+static void qmp_pcie_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
 
-	qmp_pcie_configure(serdes, cfg->regs, cfg->common.serdes_tbl, cfg->common.serdes_tbl_num);
-	qmp_pcie_configure(serdes, cfg->regs, cfg->extra->serdes_tbl, cfg->extra->serdes_tbl_num);
+	if (!tables)
+		return;
 
-	return 0;
+	qmp_pcie_configure(serdes, cfg->regs, tables->serdes_tbl, tables->serdes_tbl_num);
+}
+
+static void qmp_pcie_lanes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
+{
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	void __iomem *tx = qphy->tx;
+	void __iomem *rx = qphy->rx;
+
+	if (!tables)
+		return;
+
+	qmp_pcie_configure_lane(tx, cfg->regs,
+				tables->tx_tbl, tables->tx_tbl_num, 1);
+
+	if (cfg->lanes >= 2)
+		qmp_pcie_configure_lane(qphy->tx2, cfg->regs,
+					tables->tx_tbl, tables->tx_tbl_num, 2);
+
+	qmp_pcie_configure_lane(rx, cfg->regs,
+				tables->rx_tbl, tables->rx_tbl_num, 1);
+	if (cfg->lanes >= 2)
+		qmp_pcie_configure_lane(qphy->rx2, cfg->regs,
+					tables->rx_tbl, tables->rx_tbl_num, 2);
+}
+
+static void qmp_pcie_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
+{
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	void __iomem *pcs = qphy->pcs;
+	void __iomem *pcs_misc = qphy->pcs_misc;
+
+	if (!tables)
+		return;
+
+	qmp_pcie_configure(pcs, cfg->regs,
+			   tables->pcs_tbl, tables->pcs_tbl_num);
+	qmp_pcie_configure(pcs_misc, cfg->regs,
+			   tables->pcs_misc_tbl, tables->pcs_misc_tbl_num);
 }
 
 static int qmp_pcie_init(struct phy *phy)
@@ -1957,15 +1995,13 @@ static int qmp_pcie_power_on(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *tx = qphy->tx;
-	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
-	void __iomem *pcs_misc = qphy->pcs_misc;
 	void __iomem *status;
 	unsigned int mask, val, ready;
 	int ret;
 
-	qmp_pcie_serdes_init(qphy);
+	qmp_pcie_serdes_init(qphy, &cfg->common);
+	qmp_pcie_serdes_init(qphy, cfg->extra);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
@@ -1974,31 +2010,11 @@ static int qmp_pcie_power_on(struct phy *phy)
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qmp_pcie_configure_lane(tx, cfg->regs, cfg->common.tx_tbl, cfg->common.tx_tbl_num, 1);
-	qmp_pcie_configure_lane(tx, cfg->regs, cfg->extra->tx_tbl, cfg->extra->tx_tbl_num, 1);
-
-	if (cfg->lanes >= 2) {
-		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->common.tx_tbl,
-					cfg->common.tx_tbl_num, 2);
-		qmp_pcie_configure_lane(qphy->tx2, cfg->regs, cfg->extra->tx_tbl,
-					cfg->extra->tx_tbl_num, 2);
-	}
-
-	qmp_pcie_configure_lane(rx, cfg->regs, cfg->common.rx_tbl, cfg->common.rx_tbl_num, 1);
-	qmp_pcie_configure_lane(rx, cfg->regs, cfg->extra->rx_tbl, cfg->extra->rx_tbl_num, 1);
-
-	if (cfg->lanes >= 2) {
-		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->common.rx_tbl,
-					cfg->common.rx_tbl_num, 2);
-		qmp_pcie_configure_lane(qphy->rx2, cfg->regs, cfg->extra->rx_tbl,
-					cfg->extra->rx_tbl_num, 2);
-	}
-
-	qmp_pcie_configure(pcs, cfg->regs, cfg->common.pcs_tbl, cfg->common.pcs_tbl_num);
-	qmp_pcie_configure(pcs, cfg->regs, cfg->extra->pcs_tbl, cfg->extra->pcs_tbl_num);
+	qmp_pcie_lanes_init(qphy, &cfg->common);
+	qmp_pcie_lanes_init(qphy, cfg->extra);
 
-	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->common.pcs_misc_tbl, cfg->common.pcs_misc_tbl_num);
-	qmp_pcie_configure(pcs_misc, cfg->regs, cfg->extra->pcs_misc_tbl, cfg->extra->pcs_misc_tbl_num);
+	qmp_pcie_pcs_init(qphy, &cfg->common);
+	qmp_pcie_pcs_init(qphy, cfg->extra);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
-- 
2.35.1

