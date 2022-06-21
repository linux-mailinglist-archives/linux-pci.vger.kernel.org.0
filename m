Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBE5530C5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349264AbiFULXn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349938AbiFULXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 07:23:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCC038A4;
        Tue, 21 Jun 2022 04:23:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id es26so17201750edb.4;
        Tue, 21 Jun 2022 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QvLRXiq8Bnt0eVtULkdQpLTyiJt3SvSjod+5Ee1wHE=;
        b=HMxM/aSlAuvaJsppaX7ddSubVt1WRfhY6JdmStM/lact7dWcIhwpBX7cz+FHKMJm6t
         2HupTlKSz0UHEjqwnyxZx1HOJvnoyAivxWsEi8kTIgPsxu1mTbRYGAeE+twEt/wBycAi
         m5+u5LKdDaif2kZxbUni7KGQKiXxONlXDlYtafEwt0gNn743reBmGHcJEmwoNig4EL1E
         OttNdoPwbVgtBrnRtgy0NSUxQamjNPKlTrSyI8FeVJrVEpYglXBfg07kVMwnNMGj8xa5
         DWzkvQHd5JFDkfY807CwqOe+f0w2VsRZHtJrh+eBTSxHDqKBljSoq6QPqOO2pg3r3Ii+
         2DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QvLRXiq8Bnt0eVtULkdQpLTyiJt3SvSjod+5Ee1wHE=;
        b=yPHTSrdhiapBHqipRWmZGQhW923uPCq7wwF9VggDMqXhrrvmrg9ETVyDZMZGhlS9qD
         KeIFJHXc7cT/ZuxJyZ/hb2jst9Mo9M753qZZCOGPZpEdCeIykwMVt4Zi8i/IaNdYTH67
         bFyzykRHbdQSfQ/y1y5AxHrFRkpUc15frD2GUsL8ZDjcKXdLE3T25I6JnkEDQ49ssuYo
         DcnurzBwLwRGqBPdRtFUEcbOmF/mrfrYjs3GJerkr2JYUj5fxJJgPyY12esuMK+SNpaD
         T2nx6cG2CKC2C2FVKp9F+JnvBPHF5rit1/vmSuWUfQRDFXU3WAwhzNS/SEufIkCXMzbt
         D4rg==
X-Gm-Message-State: AJIora/KPA0CNtLffWlacGOMQ3SVnFYpvPUERNBvsFybBFVWjkeLJP8X
        hpfRJslqL+jH0oNfoQAr3Ik=
X-Google-Smtp-Source: AGRyM1sL1ZkhLrEB/tV8w83l9vV8GuWECpMuHhwAq6ozTvxgrj1WCBu30JWPo8tUpOaWLX9Cpm7q7g==
X-Received: by 2002:a05:6402:5388:b0:435:71b:5d44 with SMTP id ew8-20020a056402538800b00435071b5d44mr34535569edb.364.1655810614370;
        Tue, 21 Jun 2022 04:23:34 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-158.xnet.hr. [88.207.99.158])
        by smtp.googlemail.com with ESMTPSA id a12-20020a50858c000000b0042617ba638esm12394840edh.24.2022.06.21.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 04:23:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Date:   Tue, 21 Jun 2022 13:23:30 +0200
Message-Id: <20220621112330.448754-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
* Rebase onto next-20220621
---
 drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 51fed83484af..da6d79d61397 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int i, ret;
-	u32 val;
 
 	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
 		ret = reset_control_assert(res->rst[i]);
@@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
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
 
@@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
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
@@ -1598,6 +1605,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
 static const struct qcom_pcie_ops ops_2_3_3 = {
 	.get_resources = qcom_pcie_get_resources_2_3_3,
 	.init = qcom_pcie_init_2_3_3,
+	.post_init = qcom_pcie_post_init_2_3_3,
 	.deinit = qcom_pcie_deinit_2_3_3,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
-- 
2.36.1

