Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962DB7B0918
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjI0PqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjI0PqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:46:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C0272AB
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 08:46:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3231d6504e1so7605717f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695829565; x=1696434365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnVyIhUQftvj++Ho5Yy6rcq1eYnc1pWWiufohODrEFE=;
        b=yMMij82nkhn4Th830NPLjXLNPcSSoWWVBozahIduJCUCr97mo97OVUDEnaUSIqHIn8
         mB2+bKQFfdICXcxkcifGdTUhUFG0s7cTcx2viflW6pMBn2s01RlHhAGUyz8aYaQMdrXk
         Dwp3G9SRV+fm2cvq4NPT7yYTJaDodrhOfSBlbG95/og1E4w1Jjd48WhTGKQtgtbJ4lDF
         IWtElAfog+Wbm6L5MXKfCew5VKxWgJFJjm536l7oYh8Z0psCzMqJNVPCf4kcxmd/g0Q2
         w55c+P+jV1i/xJOWuplzClh91O7xjX8qGtI8Fe6ugc5aFbIPicSPFQKdbU8Ja6n8+k9O
         T86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829565; x=1696434365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnVyIhUQftvj++Ho5Yy6rcq1eYnc1pWWiufohODrEFE=;
        b=fIeDk/9+zPMBY8txlMBETfhV9p3kb3oqbovkSTBNxh1vo0ZTw3yFgInHx3WyR6J8fL
         JnLY8ru1X8/qvfNqIIb2jgT98BpWgBwRV9+8Z+kI4C6STUMEHlgTnDWkPkuYCnDzz5OJ
         KUUHMuIQarQnqRNVDVbySgz2wX9JfPq0jD48sXlFI/yycLLqODcZN/kl64OC8ZQxYe3L
         I66MCl67HxlzomB9u2ZBmiGP4RtcDWH1VV7KFCoN51QQxYGMi2phNoM/GN07IH4ibfQK
         5YtZ+sLdCCxX+Y/2nXrDrV3E/8lmDq5XkyOyoZNhO8XQNL3zxXjM0N60FAHswiFzVscf
         wrVA==
X-Gm-Message-State: AOJu0YwsQ6CJFQwf781XoFRVyDfa/lS079eGG3IHWnaWM56aXN6kQCnT
        QpnnaP+EbJld0XwevOdC+leO
X-Google-Smtp-Source: AGHT+IHPVlFHZSR7dS0CVY+TjYfy0oJ3z2n7yBnN6VGdCusCelDVK4SOfVJbaXNnh5OXlhTYFnYG6A==
X-Received: by 2002:a05:6000:4cd:b0:321:4df5:b85e with SMTP id h13-20020a05600004cd00b003214df5b85emr2167996wri.26.1695829565184;
        Wed, 27 Sep 2023 08:46:05 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id s28-20020adfa29c000000b003232f167df5sm6925852wra.108.2023.09.27.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:46:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/3] PCI: qcom: Make use of PCIE_SPEED2MBS_ENC() macro for encoding link speed
Date:   Wed, 27 Sep 2023 17:46:01 +0200
Message-Id: <20230927154603.172049-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of hardcoding the link speed in MBps, let's make use of the
existing PCIE_SPEED2MBS_ENC() macro that does the encoding of the
link speed for us. Also, let's Wrap it with QCOM_PCIE_LINK_SPEED_TO_BW()
macro to do the conversion to ICC speed.

This eliminates the need for a switch case in qcom_pcie_icc_update() and
also works for future Gen speeds without any code modifications.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v3:

- Used Mbps_to_icc() macro and changed the commit message a bit

Changes in v2:

- Switched to QCOM_PCIE_LINK_SPEED_TO_BW() macro as per Bjorn's suggestion
  https://lore.kernel.org/linux-pci/20230924160713.217086-1-manivannan.sadhasivam@linaro.org/

 drivers/pci/controller/dwc/pcie-qcom.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e2f29404c84e..367acb419a2b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -148,6 +148,9 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
+#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
+		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
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

