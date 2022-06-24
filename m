Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58287559810
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiFXKo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 06:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiFXKo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 06:44:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2F5536A;
        Fri, 24 Jun 2022 03:44:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t5so3910701eje.1;
        Fri, 24 Jun 2022 03:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgKJiuiIV64M2/XHoBeL7al5rsJ5eSB8Xi/LwgqHjog=;
        b=Ahabk+A+spN/IW6Ozq9eVFJ9by0R5rIS05cqffDD0wfU0ytANSvRjNVOKSIr0ceKoy
         T4pa6RSpsZds2lEDer5slWW3kcudbiiHPx9QP3hNVHYnuglKLQTcrhIc4aN+GDnk7Udg
         EyzMJZkSou3pN29ywN3pwqbz2lQOJikFkhCFC2rb1Y4X4Q7BQQ/YoIc66Kk6TLIHfBHk
         tcFufywL/oGxQaepTJ2OKh14Cs4oBBc73Mp6DkyXTfffPxona3ozu3sNKhs+0pWDmByF
         7QygZFEoTBgFFIu1+epS1LPIRoVEiyCE9WnIKMRuPIOHGglXWrGaO1MEtlhPLwAlarSA
         bR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DgKJiuiIV64M2/XHoBeL7al5rsJ5eSB8Xi/LwgqHjog=;
        b=oZEzzYP3bc7jVCvlt59IQIcxCcTC1lM25AXYlefcl5I1szeBTs5O5Fx+7AprifTokB
         BwG/BE9AAhToz+Cg0BKL3JuGuhoUnsTNMpmjF1ZDWiVFqcxQmOs2dh6GgZo0uL5meUAD
         TFSocQKRdLqHND0y1r99U27hW0kr5AsC8lUzKh3MMmtWvg0w8qyFbKDUZQKmVMOWYMW0
         aaRiNtmSq2XLLFYUZ0ZmpRaIiXd7LdOMljYjCRi4IagzbKC4Uou/ojVZiLnTR9/EuFfq
         WZrH5nq2/j4OVZ8tDYyB8oTab1aCDTIKXFXMEVBPpAfsDxGUAqlRrKfucai+KQBN687m
         DRtg==
X-Gm-Message-State: AJIora8mB/oqN3YIG0QIMZhVaanY9ACsqNnSZKFYubMqxF+v13XtEVsj
        wBpP+lieZULTxyjBGjWiTu0=
X-Google-Smtp-Source: AGRyM1vm5HPnhFG74EthcmGmumexkMTAIlylgPjMF+p5pAsiHfzts3hJuTePi/oXQqEyDDqGi0UXnA==
X-Received: by 2002:a17:907:8a01:b0:726:2c8e:4cad with SMTP id sc1-20020a1709078a0100b007262c8e4cadmr3840274ejc.611.1656067464045;
        Fri, 24 Jun 2022 03:44:24 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-60.xnet.hr. [88.207.98.60])
        by smtp.googlemail.com with ESMTPSA id v2-20020aa7d802000000b0042ab2127051sm1663301edq.64.2022.06.24.03.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 03:44:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 1/2] PCI: qcom: Move IPQ8074 DBI register accesses after phy_power_on()
Date:   Fri, 24 Jun 2022 12:44:19 +0200
Message-Id: <20220624104420.257368-1-robimarko@gmail.com>
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

Currently the Gen2 port in IPQ8074 will cause the system to hang as it
accesses DBI registers in qcom_pcie_init_2_3_3(), and those are only
accesible after phy_power_on().

Move the DBI read/writes to a new qcom_pcie_post_init_2_3_3(), which is
executed after phy_power_on().

Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v4:
* Correct title and description

Changes in v3:
* Make sure it applies onto 5.19-rc3
* Update the commit description to make it clear this only affects the
Gen2 port

Changes in v2:
* Rebase onto next-20220621
---
 drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a1f1aca2fb59..24708d5d817d 100644
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
@@ -1596,6 +1603,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
 static const struct qcom_pcie_ops ops_2_3_3 = {
 	.get_resources = qcom_pcie_get_resources_2_3_3,
 	.init = qcom_pcie_init_2_3_3,
+	.post_init = qcom_pcie_post_init_2_3_3,
 	.deinit = qcom_pcie_deinit_2_3_3,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
-- 
2.36.1

