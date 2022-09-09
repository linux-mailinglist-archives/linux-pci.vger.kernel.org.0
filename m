Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A85B3342
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiIIJOt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiIIJOq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:14:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE2C959A
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:14:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z23so1102948ljk.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HU2fqxeSVcRcvbRyBLFrKxTAT+0TWkjgqZ5eADgSGgk=;
        b=We02NjLi51MFUWy5j1PR8dUf3JOzbFBji89SbW0N7UHRaMvU9ck3wtDBMKOr6ehWlv
         X3LMeztDf03ajQKIDHby2nMLUKvO5NURFs/c2mpdvGfKq3Z6qroVZ/xOpiyMbaCVxySR
         rMoKbGSv2zX8RbxTgBAnI7MEq5X4P0pA7somHl2KjGMsONaQ7QVQD4LIXuVPBFVuUtQh
         CJrw007ZrePCg/xSFhMKjSzJ2VyXac8RnNc3hkuuZBdXAtCQNgKwctNnVfIG1ijeH/gb
         PQzYJyh0UliLlDYFISOnNJgFRg6iuEd6zKoR93/f1lLV9oTH8BmTqWAVzFI+r93qO06j
         3x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HU2fqxeSVcRcvbRyBLFrKxTAT+0TWkjgqZ5eADgSGgk=;
        b=pCYOm6gBy+UxJlPHt6iAhJiBdJgzRwyy96pMOUxa+WLOSKu5HBkMZZPKLC2zvoZgru
         Er9HHEBihudBHYowZtdOJfS8kD1x2QJXA6qO0uM1J69keszPXE9ec2bJEV4F5RU7zTrx
         jGJ+viZn9eznzdzwEBdCfu1Ba2HETTXqPbZYVtlAAzkKi23BVvv1oGCnjP8jQH7LMY2r
         2Gp83Serdcmp8poKsZkFQ2a7MhfCr6/Q1jPM9FiJgrFOLuVgL3koGF56AZoCUUyT70ft
         +u2HMViGk1P5FpHfJ9eVEPc7osleQ3xh7jMkdBIzdmCA7L0WD84OnDiJ66H8fQ818C0A
         YmCw==
X-Gm-Message-State: ACgBeo3ZwLquL5SqylXOs9JK7DK3ZXwypnAj6N1f07KUICzOU8CPJDwz
        HwNn51a6Q+RQUreyYlYn++aP5A==
X-Google-Smtp-Source: AA6agR5lcebEObTLYz0gr98T0UKvJvrLyaTqdW8FhnL3PFen7y0ov8oPxNjx1i1523hBzHR2rn0ygg==
X-Received: by 2002:a05:651c:12ca:b0:261:df67:b76f with SMTP id 10-20020a05651c12ca00b00261df67b76fmr3384572lje.421.1662714879840;
        Fri, 09 Sep 2022 02:14:39 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e4c1a000000b0026acbb6ed1asm201615lja.66.2022.09.09.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:14:39 -0700 (PDT)
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
Subject: [PATCH v3 5/9] phy: qcom-qmp-pcie: turn secondary programming table into a pointer
Date:   Fri,  9 Sep 2022 12:14:29 +0300
Message-Id: <20220909091433.3715981-6-dmitry.baryshkov@linaro.org>
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

Having a complete struct qmp_phy_cfg_tables as a secondary field in the
struct qmp_phy_cfg wastes memory, since most of the PHY configuration
tables do not have the secondary table. Change it to be a pointer to
lower the amount of wasted memory.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 5250c3f06c89..d115f7ef3901 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1372,7 +1372,7 @@ struct qmp_phy_cfg {
 	 * Additional init sequence for PHY blocks, providing additional
 	 * register programming. Unless required it can be left omitted.
 	 */
-	struct qmp_phy_cfg_tables secondary;
+	struct qmp_phy_cfg_tables *secondary;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1687,7 +1687,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.secondary = {
+	.secondary = &(struct qmp_phy_cfg_tables) {
 	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,
@@ -1730,7 +1730,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
 	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.secondary = {
+	.secondary = &(struct qmp_phy_cfg_tables) {
 	.tx_tbl			= sm8250_qmp_gen3x2_pcie_tx_tbl,
 	.tx_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
 	.rx_tbl			= sm8250_qmp_gen3x2_pcie_rx_tbl,
@@ -2086,7 +2086,7 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 	int ret;
 
 	qcom_qmp_phy_pcie_serdes_init(qphy, &cfg->main);
-	qcom_qmp_phy_pcie_serdes_init(qphy, &cfg->secondary);
+	qcom_qmp_phy_pcie_serdes_init(qphy, cfg->secondary);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
@@ -2096,10 +2096,10 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_pcie_lanes_init(qphy, &cfg->main);
-	qcom_qmp_phy_pcie_lanes_init(qphy, &cfg->secondary);
+	qcom_qmp_phy_pcie_lanes_init(qphy, cfg->secondary);
 
 	qcom_qmp_phy_pcie_pcs_init(qphy, &cfg->main);
-	qcom_qmp_phy_pcie_pcs_init(qphy, &cfg->secondary);
+	qcom_qmp_phy_pcie_pcs_init(qphy, cfg->secondary);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
-- 
2.35.1

