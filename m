Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97DA7B8595
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjJDQoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243467AbjJDQoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 12:44:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E138DC
        for <linux-pci@vger.kernel.org>; Wed,  4 Oct 2023 09:44:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d2441b95so26979b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Oct 2023 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696437880; x=1697042680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9XaYn4lnPCdZB+6xNgGrQfZXQTuNNsqAtwrHKyNOHg=;
        b=rsDHKJcLPFehRXqwzgavkAknaxznvjRbIBb8ILgDf4enuqORaEsKVJOJm+k2dIuwMD
         lYRruGDfBU8mY/UqFcqR3C7iULOS8oA5pG/mJ4LG+giZcNzvAAWIHhYuv+VsnN1+QstW
         0SD/4dRGcbjC2Dm/P25pefUHaHdB/vdB2CHStSdKYABznNhLWgFhr2dTWizPZycajXDd
         6CzYpeN5lPS41qkN98CQ4r2G7sNeE605/flTCgIKRKaD9mbvluN3BLVSniiwxsnhsFyE
         uQNgUyqM7ay01IpC07jc0kD5MoMqNiMxnRM5+cPROg2188qd6oFBILmIwX4AkzfdegeW
         X01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437880; x=1697042680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9XaYn4lnPCdZB+6xNgGrQfZXQTuNNsqAtwrHKyNOHg=;
        b=jjLWk9weeSyOcNcovWSSad+w6pzZ0sYyFyeOggnFVQ4v36Ki2mpR+O1kaJZ/z/2h+0
         pgjexYEhlrVhwYzjCkmeGw+tPBN3ebwDwPKj2nKUh/aV5igbMsJzi7M0+GSpdHk4cmzQ
         gM+5cdJg3XPpcin85Ppv+SQCVFTpry5gw2jpFY8lD7j1W7LyMaXiMu9qqNFvCPz/N+mw
         L1K5T6o0+7JONDe1cKYLAq/bYHy6JPh9BgodD/GWxY28/JkurgCko+PxLvR2EBSV99Ry
         X+Yf71aOrfF0+dMgr/3iuZGGTQJ6055+W+WSAz2bi3IdQhKdSHkpvo2TsBOocGvDurpD
         mfcQ==
X-Gm-Message-State: AOJu0Ywyq93HC56XrSpLLG9i2C2DJLn/1DHZzzRp7GLIDTapib7Ct2cq
        bnS/qZ15QoIZ5T3ql2sL9hES
X-Google-Smtp-Source: AGHT+IEFcvP3XfvGXNIkQ2XxxnOQguVsBOs1pcwF/K2wzns1RX27yQqJNGuDIdCewhaTO3npgwYxRw==
X-Received: by 2002:a05:6a20:8f0b:b0:155:1710:664a with SMTP id b11-20020a056a208f0b00b001551710664amr274538pzk.18.1696437879936;
        Wed, 04 Oct 2023 09:44:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.185.220])
        by smtp.gmail.com with ESMTPSA id k14-20020aa792ce000000b0066a31111cc5sm3434628pfa.152.2023.10.04.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:44:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/3] PCI: qcom: Use PCIE_SPEED2MBS_ENC() macro for encoding link speed
Date:   Wed,  4 Oct 2023 22:14:28 +0530
Message-Id: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of hardcoding the link speed in MBps, use existing
PCIE_SPEED2MBS_ENC() macro that does the encoding of the link speed for us.
Also, let's Wrap it with QCOM_PCIE_LINK_SPEED_TO_BW() macro to do the
conversion to ICC speed.

This eliminates the need for a switch case in qcom_pcie_icc_update() and
also works for future Gen speeds without any code modifications.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v4:

* Modified the subject and commit message as per Bjorn's suggestion

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

