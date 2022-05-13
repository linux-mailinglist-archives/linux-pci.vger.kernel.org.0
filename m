Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB355262C5
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380615AbiEMNRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 09:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiEMNRC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:17:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451FDFF8
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:01 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s27so10281204ljd.2
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4LZO7nOvZAxEv3sjVx7hc+qBpA6kJoq69HVRvs8naE=;
        b=Q3tU4O20eqpYECFShQzRMej9AYSYGMrvfC3i7qC7mqg8a7xMfootGBJmCFDp12GuWU
         veLd1En3JR56f6GpG0DbzPrBzPFzxjauw4Q3CnrHZhezalLuBx5NCe4KjMCDhjsUCTk/
         DNaM7BfoyNH0UPcQR31qwoUnWHHGuD+WtZZYgc3AQsiiAVzz5X0qeXTt/m3lptxGqxF4
         xH/5ZMqeOkcwS5vwusF3iAt3kjj7i2UQxgB4i+8GlHwR9skGtssF8drRpnbZ9R13bMyN
         DX87oC24QI4OcXaT0HIKwCSPbsIKYNofr+GGpDWtOpnibFOXoreHpRaIfYZwAq0T1BCE
         QhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4LZO7nOvZAxEv3sjVx7hc+qBpA6kJoq69HVRvs8naE=;
        b=QnMGFhNRnPxN0iYyucUfUcl8cuI3hT4PQieN74N2LZgPBsK87+s2+7s54jvJ4PIqim
         E5JNW55RNzaDlQAs+TLkT5kx2ScsWUml0/2ZuFxfymDKKePaV4R+fth2s7/ih2E4a0mc
         R5aanTvUPbM1ESgYCC6ANZTiptd/0JgDKjIwOPX45/RKY8ojCJLMJyqNNqpU+aaUbRRh
         Oy1LVAuzvczQVOe3il2aG0jI3f6jYS4/Avptf8J0e+MLRejcPfDy3nPA3YFpZEBleHYx
         qG/ibNM6eg+OqcsvX93lVcyLJC202RiEa0KDLM1TvGa+0722l5QcD0GzMYnaMKtGwt3L
         EwgA==
X-Gm-Message-State: AOAM531YeopLi0FSFzL3rfk6sbTZSrKvvHW7b1xr3WFOrkLT6AEdCQz+
        5pT6jsrf28oNtKE36Mwn0JOCNg==
X-Google-Smtp-Source: ABdhPJzYnQAzCQRLkMtOH2IC1csq94BNYAY08L58FIuVCGiSXO1Fd0F+8Lp41F9BrJyyihYk4F7uxg==
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id b5-20020a2ebc05000000b0024b212d7521mr2990946ljf.243.1652447819951;
        Fri, 13 May 2022 06:16:59 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b0024f3d1dae8fsm436991ljl.23.2022.05.13.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:16:59 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 03/10] PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
Date:   Fri, 13 May 2022 16:16:48 +0300
Message-Id: <20220513131655.2927616-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
References: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a9a31e9e7b6e..1874a09fb8fb 100644
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

