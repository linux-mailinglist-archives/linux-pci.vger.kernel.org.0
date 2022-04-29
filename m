Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A368515710
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiD2VqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiD2VqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 17:46:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41BF78FDF
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s27so12006578ljd.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbPm7wPFz42k3w9HjVTRf/Wo4cb2U+ygFCZJLREQuWI=;
        b=c82XR8chvTx0ayhTAPNs1n2FMh/H4yVn5Vitbl4A+wtGjE8fDcZgXWDDycoV1z8q0a
         qvu+5qA25yMdD1bCuTdQ8wgVjgDSvKYSR2l6MJvCl1DQTdWt8LZuKbyyjqRv2le6pM8z
         tlmF2y2jE9oe+mN0AXTuxAzmrit+tEVblyEaOM5/iTHh/iQvkhO9Q8qCoZeJMYNFVzdS
         VMilk/8KuPA6qP5aq/xBgAmHlET8U8QScy+QYV49q/TWXI+WkRMKSN8pNrsTJWh4VNPi
         3fDChBJU5k8plzXZgcoP1sG4iBTMUX604Aga94jrpd93aeW3v3glLsBtWRbAFRrkTTAq
         2I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbPm7wPFz42k3w9HjVTRf/Wo4cb2U+ygFCZJLREQuWI=;
        b=ODi1DstG+liWK/U4xfc/S3wLSjcdDSuoe8KNYr2xXAIFwMiPb2pzw+GIPAE/mRfeXc
         DiguWpPPVH3snCOS5W2eaY1QSaH9v2jkslO48wMEIICOTRa2t4th8IRpTjPPAp6/aukD
         hQBrblDbrXjPsF+9aJIweKFf2LqqeITeC+RD4yR6j3EmAQljbRAk7fYcFG2q8xV+s49H
         DJTGfX1EbQKWPT9J+z+ykOoD7r0dLBfpanDxkB3T1yWmDagVjUVWw6v0CYROsYe1B2RP
         HFYE4K9OiMpLQyHMVZcTuyEdC0GissMNKtE6ho1OLneIiuEbTOr7GfeOpCZ7XQWkauz/
         AzFg==
X-Gm-Message-State: AOAM531s/jAKg/4KSDEmKu9vWQQP2koaq45upfYcU0sa2+KmgyYOj8W9
        o/Kq4wRI6wzF7ujoNLH8zlxz8w==
X-Google-Smtp-Source: ABdhPJyPJJ/vuHiUdGNPITvMM7UFkeYlT4CiD9o0gX6e4HdkBHt/8FtoRxuHUajfqArKisGWUlkDRw==
X-Received: by 2002:a05:651c:54c:b0:24f:2919:25ac with SMTP id q12-20020a05651c054c00b0024f291925acmr782134ljp.122.1651268572952;
        Fri, 29 Apr 2022 14:42:52 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id g4-20020a19ac04000000b0047255d211f6sm30520lfc.293.2022.04.29.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:42:52 -0700 (PDT)
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
Subject: [PATCH v5 2/7] PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
Date:   Sat, 30 Apr 2022 00:42:45 +0300
Message-Id: <20220429214250.3728510-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
References: <20220429214250.3728510-1-dmitry.baryshkov@linaro.org>
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

