Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D647B0771
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjI0O5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjI0O5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 10:57:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E58F4
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:57:42 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9338e4695so188585961fa.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695826660; x=1696431460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kF3xTzsn9HLZQj02Y4JAVq4+cnHK5cK7+MRBOAK1zto=;
        b=zSHzsHoystgSRI8WbSiGKcLfQskrpMxRxAB7ABn3riafYp8WN13+U4YT8L77Mw6W0f
         HlnWyaGbi6Sy2AFz0T6jr3/fu55o6cvQj3/AiSF56I2EYHpCa6Shb30U/6pYPW80mW1l
         qOemVXQDrwuXuXOme4SGTK+owFNnvrGjEOq0MPcU17uz01WoZmeKqcgBHdfAaeD8EYy9
         jsBYUPRiE+YWntvqQt2BVNqephU2XWl4P5A4zn8g3Q1hwNduz3WgCK8RfvhEwR6WMm2X
         lyUauhquPV8zo7Np3nWwrw2cxyqRwuaqd9X5L7w5qTW2JbtWLdjKrO7MBtxREuuQZoBq
         Bf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695826660; x=1696431460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF3xTzsn9HLZQj02Y4JAVq4+cnHK5cK7+MRBOAK1zto=;
        b=JoAqFwTG8D9wWwJISXZ+czY+GClX8PuAc7PAqt/zQ0bMWrKVRDVfrrin6F5f1xokjE
         h2XyV2OccuuYygUjdndgVlehGZA1v3kQVbI43OiLN+miNiteFHIqKB4YIebu2Cx5y1IH
         0enH2bbtw5U9/yo5LwbyRMVXyw470OeLdipEN07mOvdszQcL45Au65nrPi+EgHDV1MqO
         USfnxVUcIlqAm91xm/hQHVwghPuLHdsnX9pMQE9Bz/GVq+mMrAx6kNZyfcSGewUBbyR9
         EvhFMyinUdoFcfAZCxT7ub7W7nl0dBaqWtgLMdNL72ZVDvqHq1hXK0zAedqP64rpHaJN
         F/3g==
X-Gm-Message-State: AOJu0YyUb74bOU8cVE0Scl0bcgqfCFTqKbny9TstpZV4y8zPoNc7Wgx3
        Fh4TR9sdF19CLYDkTzDldsir
X-Google-Smtp-Source: AGHT+IGG7mnyMmEuRPdbZUTFhUCWPBXMktolkIEDpgdfwWvheKVZBGucA66WnqOUDknn4aOsIf4umw==
X-Received: by 2002:a2e:9d55:0:b0:2c0:1cfd:8698 with SMTP id y21-20020a2e9d55000000b002c01cfd8698mr2040919ljj.36.1695826660497;
        Wed, 27 Sep 2023 07:57:40 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906831a00b0099bc8bd9066sm9405220ejx.150.2023.09.27.07.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:57:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] PCI: qcom: Make use of QCOM_PCIE_LINK_SPEED_TO_BW() macro for encoding link speed
Date:   Wed, 27 Sep 2023 16:57:38 +0200
Message-Id: <20230927145738.115843-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Instead of hardcoding the link speed in MBps, let's make use of the
existing QCOM_PCIE_LINK_SPEED_TO_BW() macro that does the encoding of the
link speed for us.

This eliminates the need for a switch case in qcom_pcie_icc_update() and
also works for future Gen speeds without any code modifications.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

- Switched to QCOM_PCIE_LINK_SPEED_TO_BW() macro as per Bjorn's suggestion
  https://lore.kernel.org/linux-pci/20230924160713.217086-1-manivannan.sadhasivam@linaro.org/

 drivers/pci/controller/dwc/pcie-qcom.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 297442c969b6..dce80d6dc88f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -148,6 +148,9 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
+#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
+		MBps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE)
+
 #define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
 struct qcom_pcie_resources_1_0_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
@@ -1347,7 +1350,7 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
 	 * for the pcie-mem path.
 	 */
-	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
+	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
 		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
 			ret);
@@ -1360,7 +1363,7 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
-	u32 offset, status, bw;
+	u32 offset, status;
 	int speed, width;
 	int ret;
 
@@ -1377,22 +1380,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	switch (speed) {
-	case 1:
-		bw = MBps_to_icc(250);
-		break;
-	case 2:
-		bw = MBps_to_icc(500);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		fallthrough;
-	case 3:
-		bw = MBps_to_icc(985);
-		break;
-	}
-
-	ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
+	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret) {
 		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
 			ret);
-- 
2.25.1

