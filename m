Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C163E6AC53B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCFPeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCFPds (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:33:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AFB32CFF
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ky4so10800344plb.3
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBoZXs7oWaG22XZASLiUsiWHjHyRIoI/eDEhjgIXc7Q=;
        b=UVA9L/s90wCetrJd7EWLPjzEaKsVJA4hZV1B6VwH1cVGOOM4qO6ZOJTilvRuvM5Dvn
         9QDcLqQ58ey26VH4oZ2hVAdJ4GYglmq0Jho9P6jM8E7eR2VHRFBBbW7hiJiJ0EWr4oTQ
         iqYyNnYUNGWNCdnxKwQtrqtmvma2w8tqVov87jFgv2KaJemrao85uCP9CKRNenJzi4xO
         2Oi0wb+T1gj+tnuUkz15KaqDac6cV9rHfgeYJ9InmGgcC1jFN7P3bF5ZgCEmCITnln9v
         CCOPROPJ1RmOerq95hMKAhFiV5zFXMkIs8qGMMWhWaY5RXThtV5eQQfKXFAXfEkE3iM7
         xbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBoZXs7oWaG22XZASLiUsiWHjHyRIoI/eDEhjgIXc7Q=;
        b=TOoZ2m1KwcKDvVLEB5li4eluZoUXcHu8K5bikzyXuu66eZyReVU+4YIG4f+i0T2VwE
         cCXhp4kDKj4nI1g7uvVBoDx6JBrbh96tJeCmTZa0ZmkPiHDG0TPfqitvMnKwZkqEn9xp
         w12spu/GaR2CfrBYiBJqoA33VMZS8rmjOUpQgP+Wo/wHh88YLVjmA6gy6Dw+Hc8/0nDw
         T86tMIiZkVmQzmuLe5XI7yaZnIQjl9C2sg19yenLuLm+BrhmY3CKgIC6kTryvwDOicBY
         wFJu4EA0lytTA6bYz1cnlwF5lhnC0XCShBo0tCHCZ9U/kGgyb9+kxR1XRQg3XeupXY2l
         v3Ew==
X-Gm-Message-State: AO0yUKWTOogz34FVYFEV7OGyBqPNRfHKN+UcobO1Dt0WuGp967xg7RLc
        AHi1lUQpVQ3jwxGTx0fZ4YNG
X-Google-Smtp-Source: AK7set+hzSZX+ORf5IOG1kTrSNfNx3PyXjEdR0admtfuyQIsPjVgZeIfb9D2Ich8EGvBE+brpqN0dA==
X-Received: by 2002:a17:902:e542:b0:19b:78:539e with SMTP id n2-20020a170902e54200b0019b0078539emr14724926plf.68.1678116800657;
        Mon, 06 Mar 2023 07:33:20 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/19] PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
Date:   Mon,  6 Mar 2023 21:02:13 +0530
Message-Id: <20230306153222.157667-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
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

All the resets are asserted and deasserted at the same time. So the bulk
reset APIs can be used to handle them together. This simplifies the code
a lot.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++++++--------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6b83e3627336..8c39fc554a89 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -170,9 +170,10 @@ struct qcom_pcie_resources_2_3_2 {
 };
 
 #define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
+#define QCOM_PCIE_2_3_3_MAX_RESETS		7
 struct qcom_pcie_resources_2_3_3 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
-	struct reset_control *rst[7];
+	struct reset_control_bulk_data rst[QCOM_PCIE_2_3_3_MAX_RESETS];
 };
 
 #define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
@@ -889,10 +890,6 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int i;
-	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
-				    "axi_m_sticky", "sticky",
-				    "ahb", "sleep", };
 	int ret;
 
 	res->clks[0].id = "iface";
@@ -905,11 +902,17 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
-		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
-		if (IS_ERR(res->rst[i]))
-			return PTR_ERR(res->rst[i]);
-	}
+	res->rst[0].id = "axi_m";
+	res->rst[1].id = "axi_s";
+	res->rst[2].id = "pipe";
+	res->rst[3].id = "axi_m_sticky";
+	res->rst[4].id = "sticky";
+	res->rst[5].id = "ahb";
+	res->rst[6].id = "sleep";
+
+	ret = devm_reset_control_bulk_get_exclusive(dev, ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -926,25 +929,20 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
-	int i, ret;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_assert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d assert failed (%d)\n", i, ret);
-			return ret;
-		}
+	ret = reset_control_bulk_assert(ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0) {
+		dev_err(dev, "cannot assert resets\n");
+		return ret;
 	}
 
 	usleep_range(2000, 2500);
 
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
-		ret = reset_control_deassert(res->rst[i]);
-		if (ret) {
-			dev_err(dev, "reset #%d deassert failed (%d)\n", i,
-				ret);
-			return ret;
-		}
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(res->rst), res->rst);
+	if (ret < 0) {
+		dev_err(dev, "cannot deassert resets\n");
+		return ret;
 	}
 
 	/*
@@ -966,8 +964,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 * Not checking for failure, will anyway return
 	 * the original failure in 'ret'.
 	 */
-	for (i = 0; i < ARRAY_SIZE(res->rst); i++)
-		reset_control_assert(res->rst[i]);
+	reset_control_bulk_assert(ARRAY_SIZE(res->rst), res->rst);
 
 	return ret;
 }
-- 
2.25.1

