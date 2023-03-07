Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518066AE452
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 16:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCGPSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 10:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCGPRf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 10:17:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE671570A6
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 07:14:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id oj5so13492163pjb.5
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 07:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAvWJkbCnkvCCrjEbntOUm0v01njPW2wZQKEuX5KGW0=;
        b=HNUPtFivuXck9bKH1v/OW+mJdGen3G1yROd35N9fSwvXOESdOYuwuwRsourE1FGH6a
         VkbWNV9qDYEPfwm/PhwxdCG48bc1+nBl5pj1B4AhW97hfwJSo9HV6UicIxBIWeburtsq
         69VCHPr86Xjiji3vItjVaSC2BUx/1K4hAoob6wFHNzCcj8E9dzQiV5WEGsRRWlVRuRBT
         M0W+gih57ordX2DGX3tqSIWjHrl/vzWMrS7Tfsz1gm9yAQ4byhn4766nJkaZzb1qm88B
         eeovI1O6W+PMItNUw/73iKhLEvTgYz4Xml79jMm4nhYWXzX4AtsinX5T8uonCT/+kjqD
         BnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAvWJkbCnkvCCrjEbntOUm0v01njPW2wZQKEuX5KGW0=;
        b=ndxieJowPvQgzdCNXRhJJ3L82qkdYb7O0oBu9OwZa3Ib113f2nQ07TYyhJHh4Muq6x
         9JDei40r8dApAcSoh7xzbgDAVMZJQPMH30ABHglllH69XuYb8Y4tfU5qMD92Hv1br+8K
         mnIgkW0LzZRHz0HcxbpAnuNu/FhbiPFU8aM0JI71gaGo54w6cnF5y/x96FhnkzJJC90p
         35YmX7izLFy4ZI0inZxDS1vfHFBBTXIp6Y7z6kTMgskuiOLXB95KXYfIXmjTNOJKuLb9
         n3WsO9O6q9LPR7mLBisEnXU2VK/RtaViKIEi16xydAzOAv+dxT1R9krLb1LwSJHlbm5p
         0kFw==
X-Gm-Message-State: AO0yUKXWvxmQ2V2GRC+aUXtixeZQDT3YMZo3jFa5oWdgneRkCiucS+5O
        wxVhk6OOrSJsMxFb+wbavpYAUWLk/eo0FEtcOw==
X-Google-Smtp-Source: AK7set+NUD7sY2Ur8p8ntBFn2P5LOHIRjGP4dKqf/Ivc6AgvQmjtWWshdsWI1aJ8GMKYcX2YlpadFQ==
X-Received: by 2002:a17:902:ec8f:b0:19a:972a:7cb3 with SMTP id x15-20020a170902ec8f00b0019a972a7cb3mr19475595plg.60.1678202082304;
        Tue, 07 Mar 2023 07:14:42 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090340c800b0019c2cf12d15sm8549332pld.116.2023.03.07.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:14:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/7] PCI: qcom-ep: Add support for Link down notification
Date:   Tue,  7 Mar 2023 20:44:14 +0530
Message-Id: <20230307151416.176595-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
References: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to pass Link down notification to Endpoint function driver
so that the LINK_DOWN event can be processed by the function.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b32839ea26..4ce01ff7527c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -569,6 +569,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
+		pci_epc_linkdown(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
-- 
2.25.1

