Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CA5A0E6E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiHYKuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 06:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbiHYKuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 06:50:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70DBAB05A
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d8so15297487lfq.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 03:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+tlaOVQg+3piNlGJMYKBMRzblnUx75It//2apLVPW8A=;
        b=uz0Cj6v/dHD3yZX7z5Vy1Vl8Kpsgx4qmfq2lzB5nSS6oNF7fvmU0uXo6wjBdtXr0Yy
         mqqtJeOGERhtdOz594iA0MfyHQ8hSwU60ZSp77WIXRRCWcQ7rEtaWWL6TCtOxwoTyov/
         hcMp7/9zAhzFU9P/X31MeKGK5HFYe50UsROM087KBnGKpfJHLHgi9by+MxIbrZObP4oO
         m8sOKeVv8qfcqj/KfB5SR3zOb4LAII6+l+RY6sgPWQ7/CH06fiLc5AgGK5/uq6lK4IvQ
         AEtaDSVg0S7vluf+92TllGs398fQD4I7jo448mrO+j9sGhUeSsUTBdn7Pk05Cl0QRXKg
         SFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+tlaOVQg+3piNlGJMYKBMRzblnUx75It//2apLVPW8A=;
        b=f5+LA82x7eL3vhwGDS2hgoUlDalshYlw9MZdZoIJsNgiM4qrgKbuVGeb3R8aYh6X4s
         7ojQtdWcAgG/Eahd6jc1Zn/aTJnSKqrouLbffPPxfwmaf5C+FLIX1bAGzpU1MsF27Zm5
         2MnF7ozMZ71pBktGrzv1xZtze/KfXYRXbGVyJFjwpQIb6xIgnil3erhqW+F7pnGvA+bJ
         VdaH/gLdlpZGlQwDpa+JlNmxStrZyDvAcpHg4xouOxs4IiJr4UCBKMMmS6mPKQ2usEJE
         LsYVaaX+X6ogSmlbP7Jx64LHOtuJwfDThNZ7cZOWmInB5YeXIWkyfo0gCy+EjWwBrvvg
         +Xsg==
X-Gm-Message-State: ACgBeo2fOQqS7w0BUSQPgyTm0R+bkhIpCP9A5nyj59/G1mRLYHEMyZMn
        adnUCSZ+XG6bbAt8s0NTs5O43A==
X-Google-Smtp-Source: AA6agR6Wabloawy6Mhw54B9pbWQ0G+jlluNvISwNPiQ/uPL4k1chNCISuXhFZ+dgLihz/AiYstDDAA==
X-Received: by 2002:a05:6512:3e05:b0:492:e04d:8c8c with SMTP id i5-20020a0565123e0500b00492e04d8c8cmr1093741lfv.638.1661424647150;
        Thu, 25 Aug 2022 03:50:47 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u14-20020ac258ce000000b00492f49037dfsm429609lfo.152.2022.08.25.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:50:46 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
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
Subject: [PATCH v2 1/6] phy: qcom-qmp-pcie: drop if (table) conditions
Date:   Thu, 25 Aug 2022 13:50:39 +0300
Message-Id: <20220825105044.636209-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
References: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop unused if (table) conditions, since the function
qcom_qmp_phy_pcie_configure_lane() has this check anyway.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 2d65e1f56bfc..c84846020272 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1930,8 +1930,7 @@ static int qcom_qmp_phy_pcie_serdes_init(struct qmp_phy *qphy)
 	int serdes_tbl_num = cfg->serdes_tbl_num;
 
 	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, serdes_tbl, serdes_tbl_num);
-	if (cfg->serdes_tbl_sec)
-		qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
+	qcom_qmp_phy_pcie_configure(serdes, cfg->regs, cfg->serdes_tbl_sec,
 				       cfg->serdes_tbl_num_sec);
 
 	return 0;
@@ -2037,44 +2036,38 @@ static int qcom_qmp_phy_pcie_power_on(struct phy *phy)
 	/* Tx, Rx, and PCS configurations */
 	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs,
 				    cfg->tx_tbl, cfg->tx_tbl_num, 1);
-	if (cfg->tx_tbl_sec)
-		qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
+	qcom_qmp_phy_pcie_configure_lane(tx, cfg->regs, cfg->tx_tbl_sec,
 					    cfg->tx_tbl_num_sec, 1);
 
 	/* Configuration for other LANE for USB-DP combo PHY */
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
 					    cfg->tx_tbl, cfg->tx_tbl_num, 2);
-		if (cfg->tx_tbl_sec)
-			qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
+		qcom_qmp_phy_pcie_configure_lane(qphy->tx2, cfg->regs,
 						    cfg->tx_tbl_sec,
 						    cfg->tx_tbl_num_sec, 2);
 	}
 
 	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
 				    cfg->rx_tbl, cfg->rx_tbl_num, 1);
-	if (cfg->rx_tbl_sec)
-		qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
+	qcom_qmp_phy_pcie_configure_lane(rx, cfg->regs,
 					    cfg->rx_tbl_sec, cfg->rx_tbl_num_sec, 1);
 
 	if (cfg->is_dual_lane_phy) {
 		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
 					    cfg->rx_tbl, cfg->rx_tbl_num, 2);
-		if (cfg->rx_tbl_sec)
-			qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
+		qcom_qmp_phy_pcie_configure_lane(qphy->rx2, cfg->regs,
 						    cfg->rx_tbl_sec,
 						    cfg->rx_tbl_num_sec, 2);
 	}
 
 	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
-	if (cfg->pcs_tbl_sec)
-		qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
+	qcom_qmp_phy_pcie_configure(pcs, cfg->regs, cfg->pcs_tbl_sec,
 				       cfg->pcs_tbl_num_sec);
 
 	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
 			       cfg->pcs_misc_tbl_num);
-	if (cfg->pcs_misc_tbl_sec)
-		qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
+	qcom_qmp_phy_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec,
 				       cfg->pcs_misc_tbl_num_sec);
 
 	/*
-- 
2.35.1

