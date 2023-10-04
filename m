Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07047B8598
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbjJDQot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 12:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbjJDQor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 12:44:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E954ACE
        for <linux-pci@vger.kernel.org>; Wed,  4 Oct 2023 09:44:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d8c05784so1844717b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Oct 2023 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696437883; x=1697042683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4IEC6XCK24n1wITjZREwVBDCFLCyw9ygvF6/hCtGR0=;
        b=mu5T4V90A9l/3nQeyFk/x/I8Fi9Yng739I3ldXZr6scKwLI1JGnpMeZxOQ8Kif+uA1
         DgsHlQ8oUtzoSZ/nl33ZpEHbnPwyenrmvZQyvARj4aCf3B8C7ap6SP518JUfJ2MBUN5g
         us2zLf8tIMUuL5xP/TTwXwGK+zsjEMZzrmT19CZ3u6BbsAdfF02Zs4OuaFWxM1lJSJjs
         J8nzLerQhCNSIP9mGv65m+Bh1v6Vs4WP78rnHI1+DrmHRGe8YwT8aasd+7shqrriKboB
         1l5aVycV4cxe6xRKO4/fTjk4lt7E1Pob83oc+2EuOf6/or8pJN0iky5i9FbLF2YTjQAI
         P/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437883; x=1697042683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4IEC6XCK24n1wITjZREwVBDCFLCyw9ygvF6/hCtGR0=;
        b=artlTTvvPxeh4g7pskvUEb+0vQ4+S4mCgIeAikNKDg8B/srrrVo2UgRm0m0v5ylEcK
         GCCqr0C8Dydk9FgNmj8V5z2N+PXRMuAjlTVAi9rFkM1rNIPkkUPIS8MQFkcG6d1Ds/6d
         5K9s2axKNPRKbm6uA+wUKqBXlMk4Gu53lzRgvcPtM2CrmrL8QvlPu4uBdM4+yb/nqw2P
         TpuXp5LYQOgRyxCtZC5hMSZLOrzb2fcQIoASL29dh0Tu7r3LY+wQak27RMPN3bpsQZXT
         2yFDUVEJolvtsManX+R6dhkn5XxvAs43Jao8+G2h1Nd+gR+V/cK1/+8i3yo5dfnjhIlF
         aqNQ==
X-Gm-Message-State: AOJu0Yy0UFYWZBnzwtEwn4Hk7JpU4MZboUVvEa0L5H5LzNywJL1LSaj2
        5DpBZwTAm+ol+pmlPJFPymSz
X-Google-Smtp-Source: AGHT+IHzu1GFmgDAo8U93kkM9EidImikgb1LUVvgT5JBzNPFRTay0hk2AB5zES9Tat+W44s87NkG4A==
X-Received: by 2002:a05:6a21:329c:b0:15c:b7b9:fc21 with SMTP id yt28-20020a056a21329c00b0015cb7b9fc21mr3263421pzb.14.1696437883311;
        Wed, 04 Oct 2023 09:44:43 -0700 (PDT)
Received: from localhost.localdomain ([117.217.185.220])
        by smtp.gmail.com with ESMTPSA id k14-20020aa792ce000000b0066a31111cc5sm3434628pfa.152.2023.10.04.09.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:44:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 2/3] PCI: qcom-ep: Use PCIE_SPEED2MBS_ENC() macro for encoding link speed
Date:   Wed,  4 Oct 2023 22:14:29 +0530
Message-Id: <20231004164430.39662-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
References: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

