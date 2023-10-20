Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99347D08B2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjJTGoP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 02:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347022AbjJTGoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 02:44:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07D110DF
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 23:43:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so489821b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 23:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697784228; x=1698389028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIRbF0ojAg9xFaalNOKQP8+O57Je1nCdZOHBfvcS3gw=;
        b=mE1HReKCTYK6dctPvKJEBs3VkoDnPFll0xkZEZuxES0bAJNigwC8+Dw3UVo5ADjK01
         wgP6L40kAkgKsM6/5xeYTS3bMbNDG86khhjISe2nZ6/0BEInESka4+wAIhcfhdPZe6UU
         2kjLil3+74wHzusBxUkuP8HYzCyJLHJcr3lUwUTUDPeW7k69ylJ/u55B7VXt1NVbok5L
         10rTI/2BXTYqfWuNV0DW5NzTM7foNFL1YleARkyZq/8qi9gqF3uXF25j02Vq6PiyAz9z
         aeujbzOpipAAe29hVf4Ti3eckCBGOLpno5PjBUEiJPdjGm6/wEvqRS3cEOUbo91QAFin
         rfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784228; x=1698389028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIRbF0ojAg9xFaalNOKQP8+O57Je1nCdZOHBfvcS3gw=;
        b=OInN/4TkFlFdf1a4WxEc0YqBuMsPj2GiOuZihGDwC+ZWIOelqFmuSyrhcnGwjMKSb3
         81Qds48jFfKIw7NiPpdRuX4AUvaFU4EGNxob9uCrK+V/9yJWU2BK5/D5cNrOao7+8G0x
         vtyNFCDZjQw8E0VWDFQdC0L0MBpwf32Jt+LHUAQpdku8ze8DeAnHNYvJyxvpsPTgypkB
         P3TOqWKr/Ar7AguM5SXqUGxmXN2YVyRADmR8H3HpvsViog+lWyadETPoFFmX3TSRbERs
         HDIqh3KXS8WjEvQyD4I4aQebQ4khj08CQtH77Mvq3ucx3+3gkC/0MhAwnvDAgw2A0xUD
         wCYA==
X-Gm-Message-State: AOJu0YysB2aG3d2mp2IyMpkjBdB+2h1kSOCEmS3PD8Ve9SrDk7xOlGjZ
        xPk4z3SQwkhP8gUhSjnBjNao
X-Google-Smtp-Source: AGHT+IH26TsR370CFGtCUUbUlg4dDjpRRH/7q7TzX9DrIU1FlzPbc3yC77jhiCPIGWY97+oQegX3TA==
X-Received: by 2002:a05:6a21:4886:b0:16b:8498:d9bc with SMTP id av6-20020a056a21488600b0016b8498d9bcmr917350pzc.62.1697784228243;
        Thu, 19 Oct 2023 23:43:48 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.40])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902bc4300b001c60ba709b7sm760951plz.125.2023.10.19.23.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:43:47 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vidyas@nvidia.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 2/3] PCI: qcom-ep: Refactor EP initialization completion
Date:   Fri, 20 Oct 2023 12:13:19 +0530
Message-Id: <20231020064320.5302-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020064320.5302-1-manivannan.sadhasivam@linaro.org>
References: <20231020064320.5302-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vidya Sagar <vidyas@nvidia.com>

Instead of doing the initialization complete and notifying it to the EPF
drivers at two different places, let's call the dw_pcie_ep_init_notify()
function that takes care of both.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
[mani: removed ep_init_late() callback and modified commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 32c8d9e37876..3d5196291192 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -447,7 +447,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	      PARF_INT_ALL_LINK_UP | PARF_INT_ALL_EDMA;
 	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
 
-	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
+	ret = dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto err_disable_resources;
@@ -466,8 +466,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val &= ~PARF_MSTR_AXI_CLK_EN;
 	writel_relaxed(val, pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
-	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
-
 	/* Enable LTSSM */
 	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
 	val |= BIT(8);
-- 
2.25.1

