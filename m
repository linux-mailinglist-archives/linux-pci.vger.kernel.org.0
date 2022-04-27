Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E14051177E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiD0MUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 08:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiD0MUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 08:20:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059774EA0E
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 05:17:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu29so2873604lfb.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Apr 2022 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjLnXGfkIR05kXKOCheJZDc4f1DBX0xJuReW0/g+Ysg=;
        b=bascVFI3Z07hSXeIRl4B/UcxxxjcIVM+fiWysgRncRBRmWiLSPC2TmTee5AS/lJ+ce
         JYkcaUY6K5Q/Gn2gF7LPig2LFzDTj8ft0Zh3CulMcOfnwV9k9ev0jppYsq13qmXVhCGb
         Kg2mMvM4gDjDSbTobHyLydlG19rWCttrqZQgg9Fk5brT27zZaqeWACZ7Yl3jAPK6JVeT
         7XiBlOiYSNo/jH60C6t9wSXjWhiv3Y3ex9wEGC0R+wKdMOAlht+jZLhKgqgetpKC4IXM
         JXriS24/GXvgXEmpHninBqUNjEYBOgdWVfxYqsrCVKLipZIVoGYSGN99eSytzdBbhZqg
         gCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjLnXGfkIR05kXKOCheJZDc4f1DBX0xJuReW0/g+Ysg=;
        b=peRbVdUVen+NY8x9UJKQ4Cp3lso6FolyO0Rk7ilgfCfhO6Wz/2PgFs6xcGlEuS6pXl
         M6Sl/X6O29kcAz9FmglMIyJJkyejUwVRe7YA5t2/nvXUuWyAbRlQRtsZhccwlq8CW0js
         qr4MPnKMrZPxZJxkQTGdhLABK16dpc+K2mVEWhaxIVUf5hH04Y6N7IW/NxtAOOpuxUwy
         6NpdBCpmx+EHJFp8l+mq9svELRM9HRsOkGNXMrU3HqzNB1ilk7jYQHAOUA8NvIWkv/W+
         WSNKLsHHpRh7G3fnW8lGKHR19yX4ie/5IO8Ux5XqRQIgIj/lCuKQGMlY2dTQnT0jj4/8
         kVmA==
X-Gm-Message-State: AOAM533W5oWP2xHyDuiusFwbk6WkZBEivxI3t49K+U1b/+hg0rpp9hDp
        GwH/Od4UausORsX/Ifg27uw0Og==
X-Google-Smtp-Source: ABdhPJxVHQUzNKpUL5VDuc04/wa985OVJgEyhxawcG6jzV2iiMJzeu88WwCLV8+1RlTpPMWS7jF60A==
X-Received: by 2002:a05:6512:2307:b0:471:c299:7a47 with SMTP id o7-20020a056512230700b00471c2997a47mr19705027lfu.134.1651061818192;
        Wed, 27 Apr 2022 05:16:58 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y1-20020a0565123f0100b0044584339e5dsm2043388lfa.190.2022.04.27.05.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:16:57 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/5] PCI: qcom: Handle MSI IRQs properly
Date:   Wed, 27 Apr 2022 15:16:51 +0300
Message-Id: <20220427121653.3158569-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427121653.3158569-1-dmitry.baryshkov@linaro.org>
References: <20220427121653.3158569-1-dmitry.baryshkov@linaro.org>
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

