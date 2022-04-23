Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB450CAB7
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiDWNnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiDWNmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 09:42:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E18175DDB
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g19so18838944lfv.2
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjLnXGfkIR05kXKOCheJZDc4f1DBX0xJuReW0/g+Ysg=;
        b=tPxHzSvcbHVrJcPaHI3w6IXRZnjd1/7PmmmSOmJki5dt9sK34gHAWFeW5mPUtseOL/
         LGXP75Grt+aFRB1h9JySiPHXgPPWt+rKm/3/A3QwZ4lrWJWZhHU3Ml2HYzlM3zSSudZI
         aDXbwsA63ib6a+omZCoT8sSgzyMKH6VKIMvsiDconOz2bOtWsPDxlFkJgHLCYjuBNdLb
         ogN+zXLJQEAAYHaMsQ9BNXdfxZvDpn8iLcK/BHnGQrl/p0EBCEpux2xkZhfS9AX+0dHH
         YQlQHvUifeWjn6AMmUbljX4+jDUYDmDTs2V3lq3T06OAzrWzp0YgtkUWobX0UecBkfou
         oTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjLnXGfkIR05kXKOCheJZDc4f1DBX0xJuReW0/g+Ysg=;
        b=AADaj2XKtTCCZsoD0B710xbgYN8vcpMiB/yvclxFEUBJbSYSugkmZW2NLhBT4mRINR
         Ii4krU3ynAhzimmDDsqbL7aE1uOB4tRd5ZgY/bvUw6JERvIzvg21zSfDFQS5Ekt2UCDu
         ZYCNJWzbqYxAd2/JLJahzN9x9GJ0L5ogoFbpGWd34DjidVoFSDE4koxxBWT0m+N7lQ0U
         i9a+Y+bEEKQHikTLirQB5qjGnxINz/p5sVWVKq60SGiGIunngPiG79dcd8v6lE45ysRn
         T9M+cK8Xv2j42lD3yNG569eTcLEEzy2O6eDRA7YeZmcjC7M8fZvsi0KVldWAHhoY8Li7
         YJGw==
X-Gm-Message-State: AOAM532D3UMYO+AUmYaOk+9EZddTc71Fis865BHRy5DtKiDFXLzv2YpC
        PV4x19cHoatpPHyLDC8XpF8mBg==
X-Google-Smtp-Source: ABdhPJzTQUedhaFJ+BPuIQ34P3eMPAo0aMzEcIde4OutNBX/SAcRk5PK+PbSVZ9xrS5HHS/gSe2syA==
X-Received: by 2002:ac2:4153:0:b0:46b:be5d:ab6b with SMTP id c19-20020ac24153000000b0046bbe5dab6bmr6507487lfi.565.1650721185813;
        Sat, 23 Apr 2022 06:39:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([94.25.228.223])
        by smtp.gmail.com with ESMTPSA id c21-20020a2ea795000000b0024ee0f8ef92sm544535ljf.36.2022.04.23.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:39:45 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] PCI: qcom: Handle MSI IRQs properly
Date:   Sat, 23 Apr 2022 16:39:37 +0300
Message-Id: <20220423133939.2123449-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
References: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Thus to receive higher MSI vectors properly,
enable has_split_msi_irq support.

Note, that if DT doesn't list extra MSI interrupts, DWC core will limit
the amount of supported MSI vectors accordingly (to 32).

Fixes: 20f1bfb8dd62 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 45631c0aa468..78c4e2bcf38a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1587,6 +1587,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
+	pp->has_split_msi_irq = true;
 
 	pcie->pci = pci;
 
-- 
2.35.1

