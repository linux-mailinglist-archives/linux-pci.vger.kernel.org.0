Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7866BC893
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 09:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCPINV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 04:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCPIM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 04:12:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04073B373E
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:12:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j13so895067pjd.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNgtgV0/H9qT1IA92xeBKKtQgc9OA3//cEkirT2DuYA=;
        b=UeMZdRVoOpOIlm9fwiN0jYr+phCmYHBVM8+1T+l5gZ8oqphexykuLEbzrSF0tkZboZ
         RkK7jwBe440jF4OjBtXxwPLz66vIgJ3kQaG2eyBlwIQqz90Feadxa3+9Mx56+RDP0PaS
         US7GCKEKuJr4pqVsup3HpiT3Nov8xTd2ab7QQTV4DhBXBFr0fVo9N+jztGmb+pkIERDc
         C3aVCai+egVZ+8b8prj+B4Gmf3pPFyeVsiWwT6CutXVRhjgkqp/dlKPh7tFyqagiZXXp
         2fHlikqryt2F71z+GpQ61lxBxzFynk38t8skK4luhWU4EdSli0OssnCeQkna2RgHObCU
         HHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNgtgV0/H9qT1IA92xeBKKtQgc9OA3//cEkirT2DuYA=;
        b=aur8IgltgrvJy0EitAIPSFzVh+7cBYibE4QTlP++rWHuv3qM+sGg2vMWisFdSIItQb
         t0WPg5jtHAhwXcuY06WppD6MN/5NSBh3Y4n/B4dodCfO2h370QrFS2YLNsLXcQAiY9ea
         22icuy6tlwhbfdOtddnn5Qc3U0LVVm3xDjnh/+vOMv9tbjyxgFXwV7NOm3fdbCMx0eTn
         2AONwoEDREWbGiXKDmeDD0IPlhY/Xl8GpuiwrU8rei+FoeR+kn/sggZh1PFpCiChMeh7
         +nBncKC95yJXPrwHcFsmaIpe2lOZbMdnQGr0aSTfk5a7HFsCSRVWkQjbRNKPEBh3IiPj
         c/rQ==
X-Gm-Message-State: AO0yUKV56xIYMc8j0jTvbozarhANu2lF0C0rDtDMLH8zeCUQuNT1mMsC
        FRZmVYtu8c18ZGjEvwpK+OotQqQKJ6M2HFDL0A==
X-Google-Smtp-Source: AK7set90HGRG3/1+AW/0TzR/GSW23hFqPZKL9DLcyvSP8c8ZM10m/IJwmB5PRViwHY9neoMfAV5v2A==
X-Received: by 2002:a05:6a21:7882:b0:d6:95c3:87ac with SMTP id bf2-20020a056a21788200b000d695c387acmr2791100pzc.0.1678954349591;
        Thu, 16 Mar 2023 01:12:29 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:28 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 13/19] PCI: qcom: Use macros for defining total no. of clocks & supplies
Date:   Thu, 16 Mar 2023 13:41:11 +0530
Message-Id: <20230316081117.14288-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
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

To keep uniformity, let's use macros to define the total number of clocks
and supplies in qcom_pcie_resources_{2_7_0/2_9_0} structs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8baeee3189b1..5aef890e627a 100644
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

