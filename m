Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECA455172E
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiFTLUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241275AbiFTLUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 07:20:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06713F13
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c2so16771281lfk.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPW5UrM16VIb0V7/sU8bftbljN5lwsuQwzROP9bFs3c=;
        b=z63foj1St8+WGq5iyo42Fms+ef/6ySYKv0EpoFzzWYHiwF+hTSW0svQ2QtkpZspOKn
         w/If1Q+T1p4b44QSNkabI9rAqLvcvOXyXG95BzQEv5Js305rD/hJ0TtyXKiDSVWFkaYM
         LjbPpxSiLaaNYB5H1VTYLfiulVdres6JlPUyWg0tdrUgp+ICgGFmkWbaZ0XxCovM/bhJ
         t2CuSujaNqDBlsLIOFEK9+pI7TY34SNA4UVfcnjqWlL1aimGUk93nU+GiU1VmAtwgQIt
         H1fZy+H7vlJDCwklSJaz9mJGNJ0fwXGLFQINNUopjr0x3QyQq1A0R0BPFOvh8p1BY8za
         R50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPW5UrM16VIb0V7/sU8bftbljN5lwsuQwzROP9bFs3c=;
        b=4AEmsTiC2unhoZmVZEADLCxMeBSmlBuNx41hgKcJI1A9Xq/hcqVUQ6g0yUdVR554Gp
         6tdtkZmG58Va8Dl+jxKbLQQFFwQSDv57eACX62F7Sx+ahJ2RdnUo0/MUiYjuUcCqvl9Z
         oOYDovj7G3RhS/HgZ3LOziEBF4I+WCKqBY9aAZ71XEF2Z1nww4S36MUHZbQDfw8nSX+l
         Q5vXdeSq309x15Jf1q6SpJlXEqVtf0ElwmufNlZv/EpWg+eRMPXmO81A/0yfEMa+g8CK
         rYi8juckCrynvm7ZgvozJ9OXWt98aFTzIEGhRPqzcACnRnOab6T4RxOdp2BMgthjJvVN
         ICCw==
X-Gm-Message-State: AJIora9tArvwCQACeMAClt4XW9PwEsbKy6hFmL3dHBajkINk5XgD0joz
        fVigXxwaHk02QxGG9GDNkPRGvw==
X-Google-Smtp-Source: AGRyM1thbPERxbw6rr5yL+3USXzmm55c9jLEmXSLB02vgh7FbfH8XB+NMuRxNM7sWDI+QlODSw1GDg==
X-Received: by 2002:a05:6512:104b:b0:47f:6f91:4783 with SMTP id c11-20020a056512104b00b0047f6f914783mr2456909lfb.527.1655724017823;
        Mon, 20 Jun 2022 04:20:17 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b00478f5d3de95sm1727270lfr.120.2022.06.20.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:20:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v15 1/7] PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
Date:   Mon, 20 Jun 2022 14:20:09 +0300
Message-Id: <20220620112015.1600380-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
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
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9979302532b7..af91fe69f542 100644
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

