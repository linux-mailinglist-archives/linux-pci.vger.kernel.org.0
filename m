Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A625B333E
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIIJOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiIIJOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:14:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6287BF68
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 02:14:40 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bn9so1074238ljb.6
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QVU+UE1EBysRzdp8C3u3a6aWiuWRGj3Z9ISz0CxJ14s=;
        b=OKHr8RdKD9EhTKcN1thF3eGKdstebYgTaLc9RFPp00s3JLJ0XOsqGqO07q+o8P+TSA
         A24Nt5mnCdJtWRGlDgS0RWQmqwdBrIM3M2Hs5jGeXRUb2NYled2Jfu0WS/kIGJCrFv3p
         fuBLZ/Y4CdZoyUAvoACqFI/R+JZVlFcWXwh5SkQcFpxKubMG1deIutcEzfYGJu1mPInF
         qQ1di+XnwyFsLPV5REL88th6MprTcHbFoJFfZ1HrCuD3dFzqU1YUgT6bEuj8zQ88J+rz
         YAmX6Mc6XnaVk6yyHNAPIDL7bsRbs5qfTOIrErnPMxcdI1y4+m+vnvMeqgJ9VCWGrUjM
         Bmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QVU+UE1EBysRzdp8C3u3a6aWiuWRGj3Z9ISz0CxJ14s=;
        b=sZVGWcT0wnfe8G97p2u1YwjecSoBl09Z3TlFE+2LbfO4wfEQTnXTqSsndl5xKDXNag
         MVbSIXycFI0VZubDzVxnLOBvDejTpelwyISUx1tgcSV7vgQffGdR+CPxh6eLgQADVxQF
         pB71f5oHhMkyMZ8YXwl7Qm/eFlcAsrYF/BadrOHpIV0U/8g0+JTC2scYQAP9qy829dof
         6Qamf+O5WLD31a5ZB2c9JvLEO/lUqVPe/c0znw3vWaXdlSo4pl1ObRdWJoRPnVBtoZ3J
         BKaWzFM6FaIrpp8tNJMk8FimQ5ua0y087a0jFLSOogCbL9FeRch9YRgb4cNsrxCffvnn
         RgkA==
X-Gm-Message-State: ACgBeo0JDQM/CgqJ963+kK4CKSPdKFD8TOuu2QSKWObRvJOOGKVN+rEq
        ghZH3s/0/5rOysx4SIb5SMb1aw==
X-Google-Smtp-Source: AA6agR6MkCfQZE4VRnkdK44y+9KMn8oo1xI27A0WO+/R0RGWxiXBd8yfCRQNyBwoTSaD9ZF0QpBc/Q==
X-Received: by 2002:a2e:9b89:0:b0:26a:a004:ac3 with SMTP id z9-20020a2e9b89000000b0026aa0040ac3mr3434130lji.104.1662714878740;
        Fri, 09 Sep 2022 02:14:38 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e4c1a000000b0026acbb6ed1asm201615lja.66.2022.09.09.02.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:14:38 -0700 (PDT)
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
Subject: [PATCH v3 4/9] phy: qcom-qmp-pcie: split PHY programming to separate functions
Date:   Fri,  9 Sep 2022 12:14:28 +0300
Message-Id: <20220909091433.3715981-5-dmitry.baryshkov@linaro.org>
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

Split the code using PHY programming tables into separate functions,
which take a single struct qmp_phy_cfg_tables instance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 92 +++++++++++++-----------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index ca8dffaf1081..5250c3f06c89 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1949,15 +1949,54 @@ static void qcom_qmp_phy_pcie_configure(void __iomem *base,
 	qcom_qmp_phy_pcie_configure_lane(base, regs, tbl, num, 0xff);
 }
 
-static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
+static void qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	void __iomem *serdes = qphy->serdes;
 
-	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->main.serdes_tbl, cfg->main.serdes_tbl_num);
-	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->secondary.serdes_tbl, cfg->secondary.serdes_tbl_num);
+	if (!tables)
+		return;
 
-	return 0;
+	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, tables->serdes_tbl, tables->serdes_tbl_num);
+}
+
+static void qcom_qmp_phy_pcie_lanes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
+{
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	void __iomem *tx = qphy->tx;
+	void __iomem *rx = qphy->rx;
+
+	if (!tables)
+		return;
+
+	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
+					 tables->tx_tbl, tables->tx_tbl_num, 1);
+
+	if (cfg->is_dual_lane_phy)
+		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
+						 tables->tx_tbl, tables->tx_tbl_num, 2);
+
+	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
+					 tables->rx_tbl, tables->rx_tbl_num, 1);
+	if (cfg->is_dual_lane_phy)
+		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
+						 tables->rx_tbl, tables->rx_tbl_num, 2);
+}
+
+static void qcom_qmp_phy_pcie_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
+{
+	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	void __iomem *pcs = qphy->pcs;
+	void __iomem *pcs_misc = qphy->pcs_misc;
+
+	if (!tables)
+		return;
+
+	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
+				    tables->pcs_tbl, tables->pcs_tbl_num);
+	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
+				    tables->pcs_misc_tbl,
+				    tables->pcs_misc_tbl_num);
 }
 
 static int qcom_qmp_phy_pcie_com_init(struct qmp_phy *qphy)
@@ -2041,15 +2080,13 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
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
 
-	qcom_qmp_phy_pcie_serdes_init(qphy);
+	qcom_qmp_phy_pcie_serdes_init(qphy, &cfg->main);
+	qcom_qmp_phy_pcie_serdes_init(qphy, &cfg->secondary);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
@@ -2058,42 +2095,11 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
-					 cfg->main.tx_tbl, cfg->main.tx_tbl_num, 1);
-	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
-					 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 1);
+	qcom_qmp_phy_pcie_lanes_init(qphy, &cfg->main);
+	qcom_qmp_phy_pcie_lanes_init(qphy, &cfg->secondary);
 
-	/* Configuration for other LANE for USB-DP combo PHY */
-	if (cfg->is_dual_lane_phy) {
-		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
-						 cfg->main.tx_tbl, cfg->main.tx_tbl_num, 2);
-		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
-						 cfg->secondary.tx_tbl, cfg->secondary.tx_tbl_num, 2);
-	}
-
-	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
-					 cfg->main.rx_tbl, cfg->main.rx_tbl_num, 1);
-	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
-					 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 1);
-
-	if (cfg->is_dual_lane_phy) {
-		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
-						 cfg->main.rx_tbl, cfg->main.rx_tbl_num, 2);
-		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
-						 cfg->secondary.rx_tbl, cfg->secondary.rx_tbl_num, 2);
-	}
-
-	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
-				    cfg->main.pcs_tbl, cfg->main.pcs_tbl_num);
-	qcom_qmp_phy_pcie_configure(pcs, cfg->regs,
-				    cfg->secondary.pcs_tbl, cfg->secondary.pcs_tbl_num);
-
-	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
-				    cfg->main.pcs_misc_tbl,
-				    cfg->main.pcs_misc_tbl_num);
-	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs,
-				    cfg->secondary.pcs_misc_tbl,
-				    cfg->secondary.pcs_misc_tbl_num);
+	qcom_qmp_phy_pcie_pcs_init(qphy, &cfg->main);
+	qcom_qmp_phy_pcie_pcs_init(qphy, &cfg->secondary);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
-- 
2.35.1

