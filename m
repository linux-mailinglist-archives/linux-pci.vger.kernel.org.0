Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FABF6AC54E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCFPe2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCFPeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CB9C147
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso13502397pjr.5
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=WIfdJaBzivm0SsoyXJxtpP+FVDfpCIb19DMrUIZn9JmoLmViOtWHq4gK5rEsmeeDTN
         p0Zw70DhepV42ULj/DwelLZzjimaV+AdWta7ZG5VzeCVpFbh0jmdEx1TVwmus2m+OphR
         ewqslEtnFf/eGNM/v8lVcOcK/P9bmEiabnNKZxJGLCI+Uh/H3Wlb9Iw6yxbJReyllOfP
         PhOzAhll0LFfLWg7suSZFt4l/lUAAOVa+AVDxrHgCybXpe7fiOCiid9AteZLAwOxypQE
         KL84IBC+HEYeopdOStra85mlBOp8+8x6BLUzEfuhrjymSDwqXnhUU3cfpVeo6fpBVhuv
         YsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=iXHa33YfVNO01hS9X2yNvWBXG6Hcof0mjE7FrIYbfxtyO1tTTJzPa5iMLjxshDeB5f
         W64AX9jrA3FpWrrbGXdDehA9jfBOoaQOlkkguPaER5AxDDm7FX3dzHz1TIwqfHdiQzyu
         PJ2k75wmUiuuLxW/LpM2C+CAsF8mEJRYHD3Id32KYLHW1WzqYDxfqrtBRWHgEUvu5WHe
         vrjBoGa/xjxn2o3qS1r/sn9gy/OGspV6IBjNxK5SktP/tlbDu3UB6lxjz+cutl57EfcA
         vA3k7IJkGWwJQiZdafKUUYW7/ySXdwz0EWHGAJ9G138S/5xOv4uEpmdD36IrvHLxz5gt
         l4Hw==
X-Gm-Message-State: AO0yUKWAKFtWbIMOZjtktuTDYi/hijRi+GqJaBCGDP7+sGDLEoNPpWux
        S8gXfu4+CjObWmm9kQbOeIKx
X-Google-Smtp-Source: AK7set9i5rke2x6vgk1ILaEXl7fOJW1AdeiwtHqSdSsE5yjGB9Aw3Ks55LT7hsCqA6yRIpbwv9WLTw==
X-Received: by 2002:a17:903:2290:b0:19e:25b4:7740 with SMTP id b16-20020a170903229000b0019e25b47740mr13907218plh.28.1678116811714;
        Mon, 06 Mar 2023 07:33:31 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/19] PCI: qcom: Use macros for defining total no. of clocks & supplies
Date:   Mon,  6 Mar 2023 21:02:15 +0530
Message-Id: <20230306153222.157667-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
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

To keep uniformity, let's use macros to define the total number of clocks
and supplies in qcom_pcie_resources_{2_7_0/2_9_0} structs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ed43e03b972f..e1180c84f0fa 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -185,16 +185,18 @@ struct qcom_pcie_resources_2_4_0 {
 	int num_resets;
 };
 
-/* 6 clocks typically, 7 for sm8250 */
+#define QCOM_PCIE_2_7_0_MAX_CLOCKS		12
+#define QCOM_PCIE_2_7_0_MAX_SUPPLIES		2
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[QCOM_PCIE_2_7_0_MAX_CLOCKS];
 	int num_clks;
-	struct regulator_bulk_data supplies[2];
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_7_0_MAX_SUPPLIES];
 	struct reset_control *pci_reset;
 };
 
+#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
 struct qcom_pcie_resources_2_9_0 {
-	struct clk_bulk_data clks[5];
+	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
 	struct reset_control *rst;
 };
 
-- 
2.25.1

