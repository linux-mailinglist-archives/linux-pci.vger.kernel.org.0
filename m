Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ABB5A6906
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiH3Q7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiH3Q7X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:59:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA92CEB12
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x23so11711062pll.7
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=DEZxBEVQDmbO3QSre3sa73s6DhO8qX+KayjAX2fmCbRFwic8NG6XuAuDzC7zXaebzg
         WzEPgm7lq7KjDM5jCYBNaHzjSHmYLk3ChZbvejiFUfLHeaIdVvFxsDjuCB9L1y3dsP+7
         20d5vmUxRfulyomW3kyhiGKJ4lszVGk7V0pEqKOSQWiNpA3ntJ9wPuTpxNl4AEBeCTlL
         rWormvz1OEV/lItoLy8JbIsH281EPBd8+GyRmDInmwmErudiTLdJbjwhOogR4dd8972U
         KfyDoAkl2yNWkoXOsOdQZNeLf5ON6WSN3GkT05IabyBynducw9T47J6PnjPOMqIujXV7
         dmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FMZK2zbDyl55wonvxZo05JFqyO2/6cJpEjPTCWuWIWI=;
        b=LVMIgYlFr7x/DswQs8YmwN7BWXqE2toHZiIM45ckVGvlccIgcl+N/Bc0gI/20qYlR2
         ZCAvYoGLeWB9zIOpPEV+opSWqAzm/hYl8/R/SmNKUL7kqswluiiSTKrHqzcWAkK45dsU
         AYJRvsoLW3sQMNB+4JMdhmNim0slb7HglCGscOGYckXebLKr71ZZumcmElepC6uV/TfJ
         dkQiLA0Hr2socV2BnVQgxOnuEYx8ymmRUjmaAbNBX1o2paqSvNjq03cWeDjx20+m2Wss
         QoVGNAwqQx8rzzunN6q8rQ03Y4DKYAOpisuRb7m3qFegbZfreYdsOZaa4Tq/PmZK8jM/
         jNnw==
X-Gm-Message-State: ACgBeo381YltB9bUf5Wjw7cC1Ts5d3/xF3Sf0WzYWZTQFQXIl/O8YI91
        gJ4HzH8l1vs3pU9o76dbONga
X-Google-Smtp-Source: AA6agR6hP1/3DL9GUw99sS8mR62251oVzQJSTfMrgO+fPtawl5EyLLcsl6sNeP8K2fT/jRRR6D9gUA==
X-Received: by 2002:a17:90a:cb14:b0:1fd:c964:f708 with SMTP id z20-20020a17090acb1400b001fdc964f708mr11522996pjt.62.1661878750176;
        Tue, 30 Aug 2022 09:59:10 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001f510175984sm8841261pji.41.2022.08.30.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:59:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/11] PCI: qcom-ep: Disable IRQs during driver remove
Date:   Tue, 30 Aug 2022 22:28:11 +0530
Message-Id: <20220830165817.183571-6-manivannan.sadhasivam@linaro.org>
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

