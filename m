Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DFA7B091B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjI0PqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjI0PqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 11:46:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08285272B0
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 08:46:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-405497850dbso94604705e9.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Sep 2023 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695829566; x=1696434366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4KIRIpLWXsBrRP9d+c7xABdNFBjUHWJxGRoEU4D424=;
        b=heO3sbA5/jSD4OTjjbU4ueMtEMTv+oKmJVGfizJMsYG+xNcOvlLW/ecGJcwj7MTRpZ
         tlc5/6AKU8UBoVXAqTrJgOy0Qn3Jw3/IjBuUiLeTmwCp7pH/ce5fy1d7fkSxVePP+PM9
         xsYPX59liv5lU3Ua5BTM6d5SbR6FeSfrAcVXTadgME/zqz/qpziIkAhcvfBa0ZH8ewSX
         pbGkqezdcNQSQSpJ9VjnNOKzFO3lykEnMYq+FBIHR4/wfL4Q1LcZHUb83TMwJG5fEChM
         Cu2v3/GAIfI5ZyP9axeUPebVnPGJpNX22+I4fZ6MLqhx3MbkFQOEjVOkB2eCRenkjrXb
         FpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829566; x=1696434366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4KIRIpLWXsBrRP9d+c7xABdNFBjUHWJxGRoEU4D424=;
        b=Zq0fUH6kqXfD7pGOwFWMUMH6/qOZYq3kZUB5ulo79OUBglnAHBq71Y0ha5cUwxPpzJ
         bbMzdgjsfZIWDKvBFBYjOb6uyICQ6ZKp7Cc8vFXZAULCJB2+g5qAlWlp3niTYIpRQaY6
         f2cKGWjDdj4BoUmlXWdtXuE5so2uqsy+W76aipM2bssseeT244wmxQI1BvoC0/oU/f9+
         Q0b2En5ofXBYjf96S7+pvQ8M+78KFGgx5KQ7RzunkQp8nrtArZuSWf6EyS/75kAsfsFI
         aYP+KbN/5F/kXeaeW09U6sHykJmCnjIVPCFhc1mpVih0hB61nR5kuNRZbactVH0ocSvi
         vF2Q==
X-Gm-Message-State: AOJu0Yx4gI8UmpZSshxcoaCvV30pP92Qp6Sj06QQD4158eqXf9xyD1ZT
        3t3ZQrGi1m+7VpbniwT14Ct1
X-Google-Smtp-Source: AGHT+IENYlPN4Yk/IrG1gmW0ad9aruzWRlfQPJlznq6ru3A3ILwJDW+NzqIIFKf00C/Vww/PNPnV8g==
X-Received: by 2002:a05:600c:2207:b0:401:dc7e:b688 with SMTP id z7-20020a05600c220700b00401dc7eb688mr2277313wml.6.1695829566150;
        Wed, 27 Sep 2023 08:46:06 -0700 (PDT)
Received: from thinkpad.fritz.box ([2a02:2454:9d09:3f00:b024:394e:56d7:d8b4])
        by smtp.gmail.com with ESMTPSA id s28-20020adfa29c000000b003232f167df5sm6925852wra.108.2023.09.27.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:46:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/3] PCI: qcom-ep: Make use of PCIE_SPEED2MBS_ENC() macro for encoding link speed
Date:   Wed, 27 Sep 2023 17:46:02 +0200
Message-Id: <20230927154603.172049-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927154603.172049-1-manivannan.sadhasivam@linaro.org>
References: <20230927154603.172049-1-manivannan.sadhasivam@linaro.org>
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

- New patch

 drivers/pci/controller/dwc/pcie-qcom-ep.c | 31 +++++------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 8bd8107690a6..32c8d9e37876 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -23,6 +23,7 @@
 #include <linux/reset.h>
 #include <linux/module.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 /* PARF registers */
@@ -135,10 +136,8 @@
 #define CORE_RESET_TIME_US_MAX			1005
 #define WAKE_DELAY_US				2000 /* 2 ms */
 
-#define PCIE_GEN1_BW_MBPS			250
-#define PCIE_GEN2_BW_MBPS			500
-#define PCIE_GEN3_BW_MBPS			985
-#define PCIE_GEN4_BW_MBPS			1969
+#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
+		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
 
 #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
 
@@ -266,7 +265,7 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
 static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
-	u32 offset, status, bw;
+	u32 offset, status;
 	int speed, width;
 	int ret;
 
@@ -279,25 +278,7 @@ static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	switch (speed) {
-	case 1:
-		bw = MBps_to_icc(PCIE_GEN1_BW_MBPS);
-		break;
-	case 2:
-		bw = MBps_to_icc(PCIE_GEN2_BW_MBPS);
-		break;
-	case 3:
-		bw = MBps_to_icc(PCIE_GEN3_BW_MBPS);
-		break;
-	default:
-		dev_warn(pci->dev, "using default GEN4 bandwidth\n");
-		fallthrough;
-	case 4:
-		bw = MBps_to_icc(PCIE_GEN4_BW_MBPS);
-		break;
-	}
-
-	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
+	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret)
 		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
 			ret);
@@ -335,7 +316,7 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
 	 * for the pcie-mem path.
 	 */
-	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
+	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
 		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
 			ret);
-- 
2.25.1

