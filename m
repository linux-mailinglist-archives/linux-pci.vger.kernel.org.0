Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2957A5EBE76
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiI0JYd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiI0JYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:24:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A89115A78
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a10so10299499ljq.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+WALVDKGJ8TjpguNws9V7oDyGWCAG+ppaoeEBl6oQTs=;
        b=REvxypI6NYFJxXOy2OaCGcqlncy/01sKMRM+5lJit+BDTPiUWjrAoG3N9ooDhH5mFV
         btCXa8geykRDdyVHCDEd49LKLGNvWaCkSRWAIJuJtaC+LCvljsAMGNJV3eTjp2jZl/KA
         Ha4biub1jlbcjgT9EsJkDpTzCrEDQobVuZhqKNuQwwr17MV4OdmLRwmZin9H2yTyoHwx
         Nm8TkDAD5tczUObst+NI19GfIhCDwbtU7EfwqzDY+zftG9diXh8YVpPTTRy0crSXNmSD
         b3FvBb/e8777KcHEaRlxtmD8E51vtYik4tHfDvpAP51KG83wtqjjQVR1FbIC5+JPku/z
         vfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+WALVDKGJ8TjpguNws9V7oDyGWCAG+ppaoeEBl6oQTs=;
        b=J6VaR3mBAF5+u34sg9xpPK2+4oj+bMbZuRlnZlUuoYqd/GipVuVappSukY1lU0ybnM
         BFgSzNqufxB903zm7gf+WC7oe+WCm62sg1L64l09pQ7AflUi8NwawzZW0dCB7P+s9Rxf
         zNS45ioNdiebCD+i/j6PiaNUP7IJuNQD4lB3/P9QK2kjwnf/kfajy31x/9Zeg7TVBWVk
         oJgYMDzfE8eX1isnktYEDAaycCc2X4kukgEkXbxwGU32Bwe/w5X8H0dPsuj7OSzuPHtg
         NVr0vlyxMMoPw0T2v+nAz+2rVoXVgd69ZeEj1FpC0D35XrsR7MFSVqBjEIfB43FoALHx
         MP1Q==
X-Gm-Message-State: ACrzQf19ruxFxAXZvhn0gDZWWOs7JdenVE8zCiDEiRL7f4EXsJsjjq/k
        +DQLKzr75UsGTnrWEdYcCyjHXQ==
X-Google-Smtp-Source: AMsMyM4cVZECH0F/MQlDHtKGzBzN39n6V5xkPo1jJ+I2hRQCv25o+4UgB1zNju6tvYj6G2MsSeeN0A==
X-Received: by 2002:a2e:98da:0:b0:26c:7b01:70a with SMTP id s26-20020a2e98da000000b0026c7b01070amr7161189ljj.197.1664270529729;
        Tue, 27 Sep 2022 02:22:09 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r28-20020a2e8e3c000000b0026c15d60ad1sm104584ljk.132.2022.09.27.02.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:22:09 -0700 (PDT)
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
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v6 2/5] phy: qcom-qmp-pcie: support separate tables for EP mode
Date:   Tue, 27 Sep 2022 12:22:03 +0300
Message-Id: <20220927092207.161501-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
References: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
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

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 46 ++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index ae0d7b49dfa3..ba01338d93ac 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/phy/pcie.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
@@ -1320,10 +1321,14 @@ struct qmp_phy_cfg {
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_cfg_tables tables;
 	/*
-	 * Additional init sequence for PHY blocks, providing additional
-	 * register programming. Unless required it can be left omitted.
+	 * Additional init sequences for PHY blocks, providing additional
+	 * register programming. They are used for providing separate sequences
+	 * for the Root Complex and End Point use cases.
+	 *
+	 * If EP mode is not supported, both tables can be left unset.
 	 */
 	const struct qmp_phy_cfg_tables *tables_rc;
+	const struct qmp_phy_cfg_tables *tables_ep;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1367,6 +1372,7 @@ struct qmp_phy_cfg {
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pipe_clk: pipe clock
  * @qmp: QMP phy to which this lane belongs
+ * @mode: currently selected PHY mode
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -1380,6 +1386,7 @@ struct qmp_phy {
 	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
 	struct qcom_qmp *qmp;
+	int mode;
 };
 
 /**
@@ -1991,13 +1998,19 @@ static int qmp_pcie_power_on(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
+	const struct qmp_phy_cfg_tables *mode_tables;
 	void __iomem *pcs = qphy->pcs;
 	void __iomem *status;
 	unsigned int mask, val, ready;
 	int ret;
 
+	if (qphy->mode == PHY_MODE_PCIE_RC)
+		mode_tables = cfg->tables_rc;
+	else
+		mode_tables = cfg->tables_ep;
+
 	qmp_pcie_serdes_init(qphy, &cfg->tables);
-	qmp_pcie_serdes_init(qphy, cfg->tables_rc);
+	qmp_pcie_serdes_init(qphy, mode_tables);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
 	if (ret) {
@@ -2007,10 +2020,10 @@ static int qmp_pcie_power_on(struct phy *phy)
 
 	/* Tx, Rx, and PCS configurations */
 	qmp_pcie_lanes_init(qphy, &cfg->tables);
-	qmp_pcie_lanes_init(qphy, cfg->tables_rc);
+	qmp_pcie_lanes_init(qphy, mode_tables);
 
 	qmp_pcie_pcs_init(qphy, &cfg->tables);
-	qmp_pcie_pcs_init(qphy, cfg->tables_rc);
+	qmp_pcie_pcs_init(qphy, mode_tables);
 
 	/*
 	 * Pull out PHY from POWER DOWN state.
@@ -2097,6 +2110,23 @@ static int qmp_pcie_disable(struct phy *phy)
 	return qmp_pcie_exit(phy);
 }
 
+static int qmp_pcie_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
+
+	switch (submode) {
+	case PHY_MODE_PCIE_RC:
+	case PHY_MODE_PCIE_EP:
+		qphy->mode = submode;
+		break;
+	default:
+		dev_err(&phy->dev, "Unsupported submode %d\n", submode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int qmp_pcie_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -2220,6 +2250,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
 static const struct phy_ops qmp_pcie_ops = {
 	.power_on	= qmp_pcie_enable,
 	.power_off	= qmp_pcie_disable,
+	.set_mode	= qmp_pcie_set_mode,
 	.owner		= THIS_MODULE,
 };
 
@@ -2235,6 +2266,8 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	if (!qphy)
 		return -ENOMEM;
 
+	qphy->mode = PHY_MODE_PCIE_RC;
+
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
@@ -2278,7 +2311,8 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 
 	if (IS_ERR(qphy->pcs_misc)) {
 		if (cfg->tables.pcs_misc ||
-		    (cfg->tables_rc && cfg->tables_rc->pcs_misc))
+		    (cfg->tables_rc && cfg->tables_rc->pcs_misc) ||
+		    (cfg->tables_ep && cfg->tables_ep->pcs_misc))
 			return PTR_ERR(qphy->pcs_misc);
 	}
 
-- 
2.35.1

