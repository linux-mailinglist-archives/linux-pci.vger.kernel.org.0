Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754151BB93
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351836AbiEEJQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346224AbiEEJQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:16:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5E4C403
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:12:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w1so6445833lfa.4
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbPm7wPFz42k3w9HjVTRf/Wo4cb2U+ygFCZJLREQuWI=;
        b=lYJ4qoHTvAqPOqdl117lhEV53qwVUf1MnS7+7HtyGmc35mpqGBLqJnZmf7MiEOIVLh
         MNcqTgYPNBA8jEK3oGxvCxvLyQferb3nnxTx5TLIdkzCDXsBGmpOCnDhZzVRe9l/dgov
         +vMolSGp2E9wpVLHHYJpY+m7socXec8ggC/3wUALnhwkwnBGqaFX8e//emXSjdI+nVEd
         S2WGjs1w80lA7NYJbBPqHQYaXP25FEITR1F9f0xsBM9rYkM7ERe8aQIOjv5714c02O+O
         bGZkSHSXDzTf+Qd3Cgp5E8rHZHFvynKQP4ANesAjikQyBPfsDMP1UN9qK8RCxCLsf5q1
         SNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbPm7wPFz42k3w9HjVTRf/Wo4cb2U+ygFCZJLREQuWI=;
        b=U9laaG4ahZugsFyN/z+0aKv/0pBKDfIb+uqOZX/doW8udaUeJXc/LZxjoTI4zSbwyD
         3K+dY+VTZW/OOAlZKA/2JYc82wpq1jTOvbgzeRBw8E8UwsFmzz0q7PE9/0I75xGwhYqQ
         tFlB/J/C9FcKpqOwtyxGzE3qQXBj7yGpRFCxxaLjwLRtxsi2IOwODEnQCmTGGjoCpOmm
         +mzUnGOEtDvuPonWDu0hERRala4Q3gqat/d5P1WUdeRZoBircvEMnMhEM+dLbC4cCfP/
         uCbyLTOBDsUm6lSt1M5yoND4xt7PH9q9GUF32vbbVX04u0bLm8DBVsYUR9sj9QtOPoQC
         xRLw==
X-Gm-Message-State: AOAM531YOqxmTLryYoYEA06ptbqTPMn+5FvrGveyPV2SIvIYkrlb76Vy
        HjTo5KpEpijuTWMgnXvjZCy24w==
X-Google-Smtp-Source: ABdhPJxDCxyeY3ldnLiGjJq7eNDoD+Gcj981AvOQx96OACeIr0VRCatY4RW3MqiFDGcvre7SrrUQOw==
X-Received: by 2002:a05:6512:ace:b0:473:ba5b:8e06 with SMTP id n14-20020a0565120ace00b00473ba5b8e06mr5227621lfu.614.1651741953418;
        Thu, 05 May 2022 02:12:33 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2593a000000b0047255d211e8sm133564lfi.279.2022.05.05.02.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:12:33 -0700 (PDT)
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
Subject: [PATCH v6 2/7] PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
Date:   Thu,  5 May 2022 12:12:26 +0300
Message-Id: <20220505091231.1308963-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
References: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subdrivers pass -ESOMETHING if they do not want the core to touch
MSI IRQ. dw_pcie_host_init() also checks if (msi_irq > 0) rather than
just if (msi_irq). So let's make dw_pcie_free_msi() also check that
msi_irq is greater than zero.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2fa86f32d964..43d1d6116007 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -257,7 +257,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 
 static void dw_pcie_free_msi(struct pcie_port *pp)
 {
-	if (pp->msi_irq)
+	if (pp->msi_irq > 0)
 		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
 
 	irq_domain_remove(pp->msi_domain);
-- 
2.35.1

