Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F265E8E4C
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiIXQDO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiIXQDL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 12:03:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C6386A2
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 10so4654754lfy.5
        for <linux-pci@vger.kernel.org>; Sat, 24 Sep 2022 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TSSeGxkA04EStEqPdtwM+UF8rYBTCo8H11fKPOug3TA=;
        b=znVnIt8hJfh2B7MzcZw7vFFi0UMxuvMMlI4WuMqK3rs8/ZIkUQj7QoW7vYHH/z40HL
         /Zo5zQKzZaSuOy9hImFq0dnCKxZXlp6/L3F8EGdBeQ0sC/QqWLmRf7W76i4z2rBafdty
         UDQvc44nV+xdFGscYsfYNvQ3vTiEgkpEv5Au/vvIfdMHurEu6K+9UjJz4FToGu4cCXbh
         jNC61EQfH0ZOlyyPyTZ9vXKj62BhgMPNtK9pIkVdEeCIaOg4k/xtySHt6hVf6fGhJ5IA
         WdbA+eFvAdlvHQhgyG6LQ6a0EyLABxjLBBLdI0Eg7DIaw3vbNet/K0ksMv/h7LWC+EDa
         bGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TSSeGxkA04EStEqPdtwM+UF8rYBTCo8H11fKPOug3TA=;
        b=tVhOet8nsR5V48bnhP19cN9ZJZlqxCNFmlioVgYCG0/v21X7GYr8apy/lDQj5FkDDp
         8WH2orCT3/HApn9LiBwHmEkzpZIIK0eBzAKsyDSg/NXP8F8nrThTfPotHERzLOvqY4IM
         8XiDc4EU12DyB6HK9a6IASY5jtzt/C5DPzWw1hdxxP2FF88vg2/A4W4msg8wbVYNcw7q
         BiKMErbQ+16x/a09yhqkN8yKk0Bbl0psLRpr005TP47Nb/OO5xLwwWlHjTdCEW2Cy8RB
         KFNuTaR1S2hSIfC4CVdEPEEuknErfoJe8uGReWQfrJ8EGy4qP4Klo1e/da2tvkBoHaZG
         fGeg==
X-Gm-Message-State: ACrzQf0kxWVNplCmUgM2wAEVCLLUBw6h4ibTedUvv+1kzp1ewt6c1+Iz
        2FFlZL2tZX1yUr1zcczcgBBRYQ==
X-Google-Smtp-Source: AMsMyM5c62MQ2IDiSSC+OHDs5fqWC6jotyWLyLeJtngbsCeJcrNkoegG6uhNW4sfCgvlIjIPHirRCQ==
X-Received: by 2002:ac2:51b8:0:b0:497:ac71:736a with SMTP id f24-20020ac251b8000000b00497ac71736amr5894389lfk.510.1664035386622;
        Sat, 24 Sep 2022 09:03:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([95.161.222.31])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b00499f9ba6af0sm1928015lfq.207.2022.09.24.09.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:03:06 -0700 (PDT)
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
Subject: [PATCH v4 3/6] phy: qcom-qmp-pcie: support separate tables for EP mode
Date:   Sat, 24 Sep 2022 19:02:59 +0300
Message-Id: <20220924160302.285875-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe QMP PHY requires different programming sequences when being
used for the RC (Root Complex) or for the EP (End Point) modes. Allow
selecting the submode and thus selecting a set of PHY programming
tables.

Since the RC and EP modes share common some common init sequence, the
common sequence is kept in the main table and the sequence differences
are pushed to the extra tables.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 67 ++++++++++++++++++++----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 6e8c74585670..1fc23df59454 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1320,10 +1320,14 @@ struct qmp_phy_cfg {
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
 	struct qmp_phy_cfg_tables common;
 	/*
-	 * Additional init sequence for PHY blocks, providing additional
-	 * register programming. Unless required it can be left omitted.
+	 * Additional init sequences for PHY blocks, providing additional
+	 * register programming. They are used for providing separate sequences
+	 * for the Root Complex and for the End Point usecases.
+	 *
+	 * If EP mode is not supported, both tables can be left empty.
 	 */
-	struct qmp_phy_cfg_tables *extra;
+	struct qmp_phy_cfg_tables *extra_rc; /* for the RC only */
+	struct qmp_phy_cfg_tables *extra_ep; /* for the EP only */
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1367,6 +1371,7 @@ struct qmp_phy_cfg {
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pipe_clk: pipe clock
  * @qmp: QMP phy to which this lane belongs
+ * @extra: currently selected PHY extra init table set
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -1379,6 +1384,7 @@ struct qmp_phy {
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
+	const struct qmp_phy_cfg_tables *extra;
 	struct qcom_qmp *qmp;
 };
 
@@ -1624,7 +1630,15 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.extra = &(struct qmp_phy_cfg_tables) {
+	/*
+	 * For sm8250 the split between the primary and extra_rc tables is
+	 * historical, it reflects the programming sequence common to all PCIe
+	 * PHYs on this platform and a sequence required for this particular
+	 * PHY type. If EP support for sm8250 is required, the
+	 * primary/extra_rc split is to be reconsidered and adjusted
+	 * according to EP programming sequence.
+	 */
+	.extra_rc = &(struct qmp_phy_cfg_tables) {
 	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
@@ -1666,7 +1680,15 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.extra = &(struct qmp_phy_cfg_tables) {
+	/*
+	 * For sm8250 the split between the primary and extra_rc tables is
+	 * historical, it reflects the programming sequence common to all PCIe
+	 * PHYs on this platform and a sequence required for this particular
+	 * PHY type. If EP support for sm8250 is required, the
+	 * primary/extra_rc split is to be reconsidered and adjusted
+	 * according to EP programming sequence.
+	 */
+	.extra_rc = &(struct qmp_phy_cfg_tables) {
 	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
 	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
@@ -2000,8 +2022,12 @@ static int qmp_pcie_power_on(struct phy *phy)
 	unsigned int mask, val, ready;
 	int ret;
 
+	/* Default to RC mode if the mode was not selected using phy_set_mode_ext() */
+	if (!qphy->extra)
+		qphy->extra = cfg->extra_rc;
+
 	qmp_pcie_serdes_init(qphy, &cfg->common);
-	qmp_pcie_serdes_init(qphy, cfg->extra);
+	qmp_pcie_serdes_init(qphy, qphy->extra);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
@@ -2011,10 +2037,10 @@ static int qmp_pcie_power_on(struct phy *phy)
 
 	/* Tx, Rx, and PCS configurations */
 	qmp_pcie_lanes_init(qphy, &cfg->common);
-	qmp_pcie_lanes_init(qphy, cfg->extra);
+	qmp_pcie_lanes_init(qphy, qphy->extra);
 
 	qmp_pcie_pcs_init(qphy, &cfg->common);
-	qmp_pcie_pcs_init(qphy, cfg->extra);
+	qmp_pcie_pcs_init(qphy, qphy->extra);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
@@ -2101,6 +2127,26 @@ static int qmp_pcie_disable(struct phy *phy)
 	return qmp_pcie_exit(phy);
 }
 
+static int qmp_pcie_set_mode(struct phy *phy,
+				 enum phy_mode mode, int submode)
+{
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
+
+	switch (submode) {
+	case PHY_MODE_PCIE_RC:
+		qphy->extra = qphy->cfg->extra_rc;
+		break;
+	case PHY_MODE_PCIE_EP:
+		qphy->extra = qphy->cfg->extra_ep;
+		break;
+	default:
+		dev_err(&phy->dev, "Unuspported submode %d\n", submode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int qmp_pcie_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -2224,6 +2270,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 static const struct phy_ops qmp_pcie_ops = {
 	.power_on	= qmp_pcie_enable,
 	.power_off	= qmp_pcie_disable,
+	.set_mode	= qmp_pcie_set_mode,
 	.owner		= THIS_MODULE,
 };
 
@@ -2278,7 +2325,9 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 		qphy->pcs_misc = qphy->pcs + 0x400;
 
 	if (IS_ERR(qphy->pcs_misc)) {
-		if (cfg->common.pcs_misc_tbl || cfg->extra->pcs_misc_tbl)
+		if (cfg->common.pcs_misc_tbl ||
+		    cfg->extra_rc->pcs_misc_tbl ||
+		    cfg->extra_ep->pcs_misc_tbl)
 			return PTR_ERR(qphy->pcs_misc);
 	}
 
-- 
2.35.1

