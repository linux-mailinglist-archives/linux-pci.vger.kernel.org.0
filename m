Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00F5B3357
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIIJOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiIIJOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:14:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4689FDB
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:14:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f11so1634408lfa.6
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BG/TDrsuuuP6fpTPNslkj+bSpnJP0yproc+vCPdzyEE=;
        b=rK3jD3C7Bl6R85J/1ihgcwK4hC+M9srfdz34IbLOA8F+rbwg5PlSnI1iaruhlxUI2I
         Q3cjcqnzTf3ViB7jX+cP0D/euSCmIems85x/P7c/guPp+s9rC1gUH/Sv2qbYFEFjepgO
         lXvV1LdVV6zqsrLnW1DVjSr8CtpGGSWF4gh42kmoRhuBRVOvsJu4vYcP5vj7OZWANMZw
         et4ARbtiVNfYqD4e7J7SCNBe5zO6S1TBpdec2K+mNv15vNkN/bbrpKJMbiJ65XXM9Fry
         wXvZRZvEGbhxHjXSeA9GTB2IeBytICR6hRyUe5KAM3uDaBK3GZFejedZ0spCM71XtOwL
         KTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BG/TDrsuuuP6fpTPNslkj+bSpnJP0yproc+vCPdzyEE=;
        b=ixn4M9a+KDRyk1WSjwkLXTaxY5Y2JfZSKGQJRwHKuGGlAyA+R9rNvQL7kG4PhFGrun
         E8u5aAc+p2NP4QyJRKCAp8qggHpEv8DghcIyPxBBdqE9YIm1cOi2968E0I2oih0MF7e7
         sn09CW4PStSf9Hb3+t1TEij/z9Us5q3vuFHCvUl2ak2x5AUMd/36ZXWOJcBo4gZowna1
         yUaZLdOHv0FBLKPFk7cUYYSPjYY4vYVwx8EtENH0Wm2rFvTFcqPv+aqgoT7R+4PBZZTi
         WTOpiHysAEzdYBK2AgxnO4wScshiigDUBrIvV2e4M+VSX1pe4IUf44sDq67bM4Ep0q+B
         Jn0A==
X-Gm-Message-State: ACgBeo1AdE/pyNC63XKp7V42rgoOLYWaxXr6sq05RGTVtI/ToQwmSsSw
        ZNugUFSLIW8To8inty6XrH2S0w==
X-Google-Smtp-Source: AA6agR5HQg+Un5RLLGNR7B+3/W+q+RGySeJeTdGJ9BqHia5jtWkKVN6Y9ntbpFMa/p0DMCd0lr404g==
X-Received: by 2002:a19:ac45:0:b0:494:9978:178a with SMTP id r5-20020a19ac45000000b004949978178amr3872345lfc.505.1662714880682;
        Fri, 09 Sep 2022 02:14:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e4c1a000000b0026acbb6ed1asm201615lja.66.2022.09.09.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:14:40 -0700 (PDT)
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
Subject: [PATCH v3 6/9] phy: qcom-qmp-pcie: support separate tables for EP mode
Date:   Fri,  9 Sep 2022 12:14:30 +0300
Message-Id: <20220909091433.3715981-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
are pushed to the secondary tables.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 54 ++++++++++++++++++++----
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d115f7ef3901..d945e8c61811 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1369,10 +1369,14 @@ struct qmp_phy_cfg {
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
 	struct qmp_phy_cfg_tables main;
 	/*
-	 * Additional init sequence for PHY blocks, providing additional
-	 * register programming. Unless required it can be left omitted.
+	 * Additional init sequences for PHY blocks, providing additional
+	 * register programming. They are used for providing separate sequences
+	 * for the Root Complex and for the End Point usecases.
+	 *
+	 * If EP mode is not supported, both tables can be left empty.
 	 */
-	struct qmp_phy_cfg_tables *secondary;
+	struct qmp_phy_cfg_tables *secondary_rc; /* for the RC only */
+	struct qmp_phy_cfg_tables *secondary_ep; /* for the EP only */
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1422,6 +1426,7 @@ struct qmp_phy_cfg {
  * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  * @mode: current PHY mode
+ * @secondary: currently selected PHY secondary init table set
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -1434,6 +1439,7 @@ struct qmp_phy {
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
+	const struct qmp_phy_cfg_tables *secondary;
 	unsigned int index;
 	struct qcom_qmp *qmp;
 	enum phy_mode mode;
@@ -1687,7 +1693,15 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.secondary = &(struct qmp_phy_cfg_tables) {
+	/*
+	 * For sm8250 the split between the primary and secondary_rc tables is
+	 * historical, it reflects the programming sequence common to all PCIe
+	 * PHYs on this platform and a sequence required for this particular
+	 * PHY type. If EP support for sm8250 is required, the
+	 * primary/secondary_rc split is to be reconsidered and adjusted
+	 * according to EP programming sequence.
+	 */
+	.secondary_rc = &(struct qmp_phy_cfg_tables) {
 	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
@@ -1730,7 +1744,15 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.secondary = &(struct qmp_phy_cfg_tables) {
+	/*
+	 * For sm8250 the split between the primary and secondary_rc tables is
+	 * historical, it reflects the programming sequence common to all PCIe
+	 * PHYs on this platform and a sequence required for this particular
+	 * PHY type. If EP support for sm8250 is required, the
+	 * primary/secondary_rc split is to be reconsidered and adjusted
+	 * according to EP programming sequence.
+	 */
+	.secondary_rc = &(struct qmp_phy_cfg_tables) {
 	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
 	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
@@ -2085,8 +2107,12 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 	unsigned int mask, val, ready;
 	int ret;
 
+	/* Default to RC mode if the mode was not selected using phy_set_mode_ext() */
+	if (!qphy->secondary)
+		qphy->secondary = cfg->secondary_rc;
+
 	qcom_qmp_phy_pcie_serdes_init(qphy, &cfg->main);
-	qcom_qmp_phy_pcie_serdes_init(qphy, cfg->secondary);
+	qcom_qmp_phy_pcie_serdes_init(qphy, qphy->secondary);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
@@ -2096,10 +2122,10 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_pcie_lanes_init(qphy, &cfg->main);
-	qcom_qmp_phy_pcie_lanes_init(qphy, cfg->secondary);
+	qcom_qmp_phy_pcie_lanes_init(qphy, qphy->secondary);
 
 	qcom_qmp_phy_pcie_pcs_init(qphy, &cfg->main);
-	qcom_qmp_phy_pcie_pcs_init(qphy, cfg->secondary);
+	qcom_qmp_phy_pcie_pcs_init(qphy, qphy->secondary);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
@@ -2201,6 +2227,18 @@ static int qcom_qmp_phy_pcie_set_mode(struct phy *phy,
 
 	qphy->mode = mode;
 
+	switch (submode) {
+	case PHY_SUBMODE_PCIE_RC:
+		qphy->secondary = qphy->cfg->secondary_rc;
+		break;
+	case PHY_SUBMODE_PCIE_EP:
+		qphy->secondary = qphy->cfg->secondary_ep;
+		break;
+	default:
+		dev_err(&phy->dev, "Unuspported submode %d\n", submode);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.35.1

