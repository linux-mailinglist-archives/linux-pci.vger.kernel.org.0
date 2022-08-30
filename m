Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC71F5A6921
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiH3RBG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiH3RA2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 13:00:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B16C121
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x23so11712674pll.7
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7Z3u13rYQpnMB98SibwD18Rv6bC0Tn7F50N9xepOERw=;
        b=sldTHnD1qgrZpMPHpc1hPZG8EsxLnZF132ClKRNUBn9xjfcdISQUHaSRPsK9Ez7dID
         n/3DLtYZz6U94P7tTy8lIoUIeJmhhye099Y7QSnwkvm2Ps5EcSj/Uj3WJYiQfm9z78rF
         CzJmqlgYAMidW9dafxB/dc2n4cHWdgFafkca2xIp9okVB/lNf/bvaa0Lcx0kODBRqo/B
         WlVqg+vCj0qccdihUJ2pGwdfFz0//9UDH7JCz0e1jU1gYd9ykASqoV1X1NG/IUho3QiU
         /p4fBEGQSaSprd7VWecqGwzwuJTxcS1DahcaE7vzE6JBBZh0dzsZ8DtLKQGAUOtJ21d8
         bbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7Z3u13rYQpnMB98SibwD18Rv6bC0Tn7F50N9xepOERw=;
        b=ZshJCSxm4r1qm0IYFU3SBkKMmHrJjjoqWm2DBXQ0nlKjA+EI+IBiLepWm0OBn5j0Ww
         KOlZM4Qx5MqGNdeyLrUOmdf9bHkAEHh16PimsbvaH/s7cK+1GC3y78JIjh280pitw1bu
         c8zGZ9eHF3RDA3mEROMNstHmYXrQ8VOW8WE49TX5pOKgh/jHf+W5vzFFRZkKXaUgfi0n
         jCekqIzMvQ9ZMboKfQMRY03ingwyQvy3RSC0fCuqS3qUgpQq1u2wDJklg+yi9n3zIWr7
         fC9jAt10XBJuiTVnneplfMF2FI2RWGkOOvoI7OedayIQvTR+zRtxnFIhsIDiU4Gl8LC/
         7G0w==
X-Gm-Message-State: ACgBeo3ldWN14ogmmi+n963vyuKPLb/FgODA57/0ikR04Y1aS3WqTDd8
        KfCT6iKwl1zyWrRaudOnlkmo
X-Google-Smtp-Source: AA6agR4ZLBvQrgM2XBFylZu8fxpCao63txCa2/kmk9jdO5RVB55e818vG7ukPztVNGo9hdb2mz+ZXA==
X-Received: by 2002:a17:902:e382:b0:173:36e4:ede6 with SMTP id g2-20020a170902e38200b0017336e4ede6mr21241607ple.139.1661878784846;
        Tue, 30 Aug 2022 09:59:44 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:59:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 11/11] PCI: qcom-ep: Add support for SM8450 SoC
Date:   Tue, 30 Aug 2022 22:28:17 +0530
Message-Id: <20220830165817.183571-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SM8450 SoC to the Qualcomm PCIe Endpoint Controller
driver. The driver uses the same config as of the existing SDX55 chipset.
So additional settings are not required.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 4908f08bd90b..fa1819c9f667 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -775,6 +775,7 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
 	{ .compatible = "qcom,sdx55-pcie-ep", },
+	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }
 };
 
-- 
2.25.1

