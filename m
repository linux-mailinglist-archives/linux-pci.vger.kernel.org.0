Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265D5515B8B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiD3IvF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Apr 2022 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiD3IvE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Apr 2022 04:51:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34603B16
        for <linux-pci@vger.kernel.org>; Sat, 30 Apr 2022 01:47:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y19so13036221ljd.4
        for <linux-pci@vger.kernel.org>; Sat, 30 Apr 2022 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZJrQpBqWc0KVALG1rh1UB+pQIMCJksr0Y84G0XAqkI=;
        b=hTuCF4hyvZSJQ4ETq8X2DOmQPb1Vur/Gp+tQdjC+Pflmei4fPKv+wfi/gE30pQZotr
         eoZLLY2EQAW/EQC0fO0HiPpT0wQSMjs+irljtm3VNOCtQObwjALXVB8rAsmdsFV5qKxN
         Xwj2alIVS7fBc5nwMKzuDCljR5OdLnTe5phlD0fFo30C1rmXFP155k+S1ZB6OC7311BA
         wSy/9HWID+WktQKWkMw/qVdiZRT6KmCBC217h1VOv8Dftan+5NISpZjxFoVoIo6Gusqf
         f9wWHahivjOddi71jY2lUlrBLH3mSnbBCwdbEm44W8snUjTlHiDNBCtIPFGyAwrJsFvw
         Ncng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZJrQpBqWc0KVALG1rh1UB+pQIMCJksr0Y84G0XAqkI=;
        b=caGelamRxmRyCKvfhtlrAP7v9rdL53+2P06TX7YGOjW5RviSmOPLiF8b9rF9gPqRsa
         /hXwlQF3IwbcBKOlBPkHedfcRFR4S1TDiyeNeZ5l9D6E/93XKQSY9FNFadlRRxBoTJcj
         82kk4O7ClUI5BtIABv2e/PnbYQC5komGjxJ29VlYUaEAtkZ8sYZnaUjvUXMKhNOcWViB
         dFs7SgvlLhaT9gLBiUth4qeHVFTgRvIp0WiC1lUkv3ilLnwGz9E+BjY1DgU7wWn8Eghx
         xzQvVTihAGw/HUgo8s6WaV3zqvRKzQXysXnyQIJqgi3Uc0pM2d22uuXMOMH1QHo5fY+g
         WbNg==
X-Gm-Message-State: AOAM530FIFNbhiQVyoPehxS7fREeidmfxndWbk5Lhe686Sd770Q5KCPV
        DV9uxt2Hbvh3p3ffR36ReI36qg==
X-Google-Smtp-Source: ABdhPJxT9ORINi6yVj7e5MWsiqCSpscPApz5kAYeTJXdT9blVn/yAO/bNVIgRembFabd51zMZxLN9A==
X-Received: by 2002:a2e:960a:0:b0:24f:1492:41e8 with SMTP id v10-20020a2e960a000000b0024f149241e8mr2110319ljh.184.1651308461592;
        Sat, 30 Apr 2022 01:47:41 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x11-20020a2e9dcb000000b0024f4c30365esm78463ljj.132.2022.04.30.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 01:47:41 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Siddartha Mohanadoss <quic_smohanad@quicinc.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] PCI: qcom-ep: Add MODULE_DEVICE_TABLE
Date:   Sat, 30 Apr 2022 11:47:40 +0300
Message-Id: <20220430084740.3769925-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Add MODULE_DEVICE_TABLE to enable module autoloading for respective
device.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 6ce8eddf3a37..b56d1438f40b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -703,6 +703,7 @@ static const struct of_device_id qcom_pcie_ep_match[] = {
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, qcom_pcie_ep_match);
 
 static struct platform_driver qcom_pcie_ep_driver = {
 	.probe	= qcom_pcie_ep_probe,
-- 
2.35.1

