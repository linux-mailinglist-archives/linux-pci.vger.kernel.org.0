Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A750E79F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiDYSAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbiDYSAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 14:00:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3641827FFD;
        Mon, 25 Apr 2022 10:57:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh6so7084839ejb.0;
        Mon, 25 Apr 2022 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCw5SiyH02JYEtCbJEBk5eKSQGGhic3V110ywY3fNdE=;
        b=laUNwVSZ14D4dL8jv9hcIJQmdV2MZ5C/1j+xNDSueiDVLc/zGrThozVnvtFxmiAqU3
         Fy74Su/eNRAMUZU3Yw20DnjRLNQo/d65U14GHnmCKD27CVX+DsWXtrlE4EX9X6TMb211
         kBycbitLRlwMUncCkjRCVyKJW71MAbUblN4P5OJInVXNmrMLOqMpmJCpb6Rt5x68V0br
         RVkYgNMOxtLGs/698/87Lrp3sAG865o20WEegFs/YKKqhkMPHGadMANh1X6Vy9xlKTZj
         FScb86cgpqELLsqrioqI3Ye4BpJ34CgydzsrhfVcTfET1OdcuuhCzMmPlGyLpqDMduTr
         3VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCw5SiyH02JYEtCbJEBk5eKSQGGhic3V110ywY3fNdE=;
        b=ClK+U958U1WA5cq0QxnDzv6YHmw5mdf9SuVt/yminuQrd5doH8C8+cnYPqXkhXaM7Y
         kmeg95w1kjRs756jtRutcPOs9MEXJT8M988sPTwgkiP87g44pxCgibu4GzUU09ryrhnx
         r8WCp8UEjHmwGHMONg8vbLnWrfHX1rafLnZkZHJ8I2XcrC/PBjICszBEoC2gKuKFzhZm
         IJUd5dNWQqRZX/k/M0i5iDagKrNY5ZgBvcX/pXl43v+qR+oMT2Fd5k0A2SJBvlkUqUA7
         rSqLonNGXhqP0ztvqlUYn2Du1x3QBWb9kiaGjXNdtUKfnFPoj2Vj5rX04zzb4tGjsSLv
         CjZg==
X-Gm-Message-State: AOAM533/04HvSxg3QyCPGy3BtIZQnLspnTyBL50UXZDdcT8rINKHChXe
        AFqpiGjMkVF5wxEgNttxWkc=
X-Google-Smtp-Source: ABdhPJwgJPQ7Pdur7c3zxCEHWM7f4+KFEQ4/hAEDbTEc9ljH71+UuCZocMgoM7FbMdmeIkp+TyXYoA==
X-Received: by 2002:a17:907:7287:b0:6f3:8414:74f1 with SMTP id dt7-20020a170907728700b006f3841474f1mr9343687ejc.123.1650909452587;
        Mon, 25 Apr 2022 10:57:32 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-91.zg.cable.xnet.hr. [94.253.165.91])
        by smtp.googlemail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm3853198ejk.41.2022.04.25.10.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:57:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        p.zabel@pengutronix.de, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] PCI: qcom: fix IPQ8074 Gen2 support
Date:   Mon, 25 Apr 2022 19:57:27 +0200
Message-Id: <20220425175727.2704430-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
cause the system to hang as its using DBI registers in the .init
and those are only accesible after phy_power_on().

So solve this by splitting the DBI read/writes to .post_init.

Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9419b5d9d482..ed261d84d2b4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1059,9 +1059,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int i, ret;
-	u32 val;
 
 	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
 		ret = reset_control_assert(res->rst[i]);
@@ -1118,6 +1116,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 		goto err_clk_aux;
 	}
 
+	return 0;
+
+err_clk_aux:
+	clk_disable_unprepare(res->ahb_clk);
+err_clk_ahb:
+	clk_disable_unprepare(res->axi_s_clk);
+err_clk_axi_s:
+	clk_disable_unprepare(res->axi_m_clk);
+err_clk_axi_m:
+	clk_disable_unprepare(res->iface);
+err_clk_iface:
+	/*
+	 * Not checking for failure, will anyway return
+	 * the original failure in 'ret'.
+	 */
+	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
+		reset_control_assert(res->rst[i]);
+
+	return ret;
+}
+
+static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
 	writel(SLV_ADDR_SPACE_SZ,
 		pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
 
@@ -1145,24 +1170,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 		PCI_EXP_DEVCTL2);
 
 	return 0;
-
-err_clk_aux:
-	clk_disable_unprepare(res->ahb_clk);
-err_clk_ahb:
-	clk_disable_unprepare(res->axi_s_clk);
-err_clk_axi_s:
-	clk_disable_unprepare(res->axi_m_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->iface);
-err_clk_iface:
-	/*
-	 * Not checking for failure, will anyway return
-	 * the original failure in 'ret'.
-	 */
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
-		reset_control_assert(res->rst[i]);
-
-	return ret;
 }
 
 static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
@@ -1612,6 +1619,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
 static const struct qcom_pcie_ops ops_2_3_3 = {
 	.get_resources = qcom_pcie_get_resources_2_3_3,
 	.init = qcom_pcie_init_2_3_3,
+	.post_init = qcom_pcie_post_init_2_3_3,
 	.deinit = qcom_pcie_deinit_2_3_3,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
-- 
2.35.1

