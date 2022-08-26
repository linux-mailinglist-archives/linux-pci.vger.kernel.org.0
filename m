Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333415A2E2E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbiHZSU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbiHZSUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:20:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60F45019B
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso8819878pjh.5
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=s1bHMc0t+EgY3JRHamFbe3O2W7KIQwgHUw9wruSHUsE7dwRznHeez60mroak5+DItd
         uCAE7MOSTJuyW8nVbq9I564pWBEyIa41jJusbUayQUWoDGvAWuGogzVomkMxZ1QjMIAR
         EeLE0LY0cVnfU2IJgXIewZJBTcYjZRvH1R2Rs/jQGZqkDePADEXQu7P1j0zoag7P1sXg
         Ejpna3IBKuDXXE/a3tEaiMlWGIHVJLOOM07REKrHUKuO8ZuApRFuBlC/Czw/IHlih6Mz
         qs9eVQVyNT6FcS0MnDy6vPL1emxlu/cdQKTBkdy0BfbcHodqT6B8vsoR81HQelzwjtDG
         kYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=YApWLX5w3i644HZFX+Aea6RcuHUMWdOo//Lv/aQdLmiB2YT7deyTSneUlMBSpFc1J6
         FazV73M6KJ3s2S7Yh6v46T9aP2b3spHNDQxIbBhXoWiOg4iuuBQCW2LTotx/S38wxp9P
         EYOUCURe8tWEYW5e2ODre6cshaN1YbFYmBr1Uu5fEd2eXvTCk7VXRRCmCrjGFp/8IiNC
         +I0bD6r4BR1RTQ1oiY7JPByRHCKwe2pkxL/mF99Jwuiqxph/o7kxN/6fL5D14f3YwGdC
         LEoh+HwJoSGdYxeka/gyGF3RO2v/wKfwJ+9USyb021DQP2xhSN8Fgkeqt/IgooctLJ8y
         ELtw==
X-Gm-Message-State: ACgBeo0KlWVFonquz8+JJ3HC+6XTngBVjXucIrey7bOa2u9azWs8jbIy
        ikV7jQN25CvcTCtlzaFcJ7wk
X-Google-Smtp-Source: AA6agR7alkQWrE4//3h6rPpk3p0vMMc3NvIzKVWZN679umAD49dP1iV+0bBg3GO0nea//FM7CXrj5Q==
X-Received: by 2002:a17:90b:1646:b0:1fb:7b7d:e7cc with SMTP id il6-20020a17090b164600b001fb7b7de7ccmr5545692pjb.79.1661538001213;
        Fri, 26 Aug 2022 11:20:01 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/11] PCI: qcom-ep: Disable IRQs during driver remove
Date:   Fri, 26 Aug 2022 23:49:17 +0530
Message-Id: <20220826181923.251564-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Disable the Global and PERST IRQs during driver remove to avoid getting
spurious IRQs after resource deallocation.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 54b927adf60a..98ef36e3a94d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -586,11 +586,11 @@ static int qcom_pcie_ep_enable_irq_resources(struct platform_device *pdev,
 {
 	int irq, ret;
 
-	irq = platform_get_irq_byname(pdev, "global");
-	if (irq < 0)
-		return irq;
+	pcie_ep->global_irq = platform_get_irq_byname(pdev, "global");
+	if (pcie_ep->global_irq < 0)
+		return pcie_ep->global_irq;
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	ret = devm_request_threaded_irq(&pdev->dev, pcie_ep->global_irq, NULL,
 					qcom_pcie_ep_global_irq_thread,
 					IRQF_ONESHOT,
 					"global_irq", pcie_ep);
@@ -700,6 +700,9 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 {
 	struct qcom_pcie_ep *pcie_ep = platform_get_drvdata(pdev);
 
+	disable_irq(pcie_ep->global_irq);
+	disable_irq(pcie_ep->perst_irq);
+
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return 0;
 
-- 
2.25.1

