Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7485F6880
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiJFNuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJFNuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 09:50:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FCF10FC9
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 06:49:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z20so1751283plb.10
        for <linux-pci@vger.kernel.org>; Thu, 06 Oct 2022 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PFAW0jcwtPS3OhOTEsyS1TaHRevCT8P/51hfS6qzO/0=;
        b=XbL5jZNUUKXEiK1u2yAh2XjMo9JrXVhEG6s45pdssMhcckLQfzKl5TyNqp9xhLguG9
         ov6efDxeJ/OpTauHbeWKGubyk8nmkZ0frvB0931/42GCU57aK6jZmmRo3EFq0Wvrk/sQ
         VveP+1s1nqV3fnYAbx7ypCAZ6ZuRFEh6L0VeoWsPg6P8u34Q5ByaRzYQNEV3kp8I7n2u
         SHIQ/piSpxgfOgTtTfDazd5KPaVJ6aGCsIamTS1HLctAbMOyWeXIHxSQVEH7KzUbCvqA
         7pF/b/C78Bfq9nQctz1ynXZDPLyzvd54oOeF/pJMBz2+1jgUkgwUUliCH6+OvmItDzjG
         f5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PFAW0jcwtPS3OhOTEsyS1TaHRevCT8P/51hfS6qzO/0=;
        b=cffdyET95qPvHZCDcSHi2SzxhYChn4g98o/2G5Jwhw134pQ8ksrEr+VIhQeeXbMtL0
         BeCONUihKuV6AUwUkaNw/y3e+2+YrwRiS9FJWteFgr7Opy7NhC/0ApQyvnNjlPSqZw6i
         ZJ4w7ofhApcumnSVvE46zydK36pfgFWTJofW/K/5GAYkYirgsXQQgULKROhzv6AF0QlD
         9owF1lYQnVQgpbRSJXNzEUtnUbeIoX7OGfHcPLYLmg7TnlYa4YkkrhbaVszFeo1EuVaC
         PK1zfkLa3Cm0KNSO/4Y7H10yYiIYmF9E/xjbd0nFDAj+7PaI6F1tVFSXTMmNHnEwxWGE
         lRxA==
X-Gm-Message-State: ACrzQf0vhpcfgr9lcc4y/e8IbE0Z0u/Vc45KB1mt7/dv5HZDJG99HdOK
        0deQNoUtrNp00ndCkfoai3sp
X-Google-Smtp-Source: AMsMyM5xaxKXrosoPmAx2Qu5DUI+EN+99LbrZR2mjLKSwZpFm2w1XpzWVVo9XnEfhsv6NC31xPKYOg==
X-Received: by 2002:a17:903:2d1:b0:17d:ba07:42d4 with SMTP id s17-20020a17090302d100b0017dba0742d4mr4859423plk.92.1665064191962;
        Thu, 06 Oct 2022 06:49:51 -0700 (PDT)
Received: from localhost.localdomain ([220.158.158.220])
        by smtp.gmail.com with ESMTPSA id k25-20020a635a59000000b00434760ee36asm1874053pgm.16.2022.10.06.06.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:49:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
Date:   Thu,  6 Oct 2022 19:19:24 +0530
Message-Id: <20221006134927.41437-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
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

dw_pcie_ep_linkup() may take more time to execute depending on the EPF
driver implementation. Calling this API in the hard IRQ handler is not
encouraged since the hard IRQ handlers are supposed to complete quickly.

So move the dw_pcie_ep_linkup() call to threaded IRQ handler.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1b6b437823d2..6a487f52e1fb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -287,6 +287,7 @@ struct tegra_pcie_dw {
 	struct gpio_desc *pex_refclk_sel_gpiod;
 	unsigned int pex_rst_irq;
 	int ep_state;
+	long link_status;
 };
 
 static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
@@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
 static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val, speed;
 
+	if (test_and_clear_bit(0, &pcie->link_status))
+		dw_pcie_ep_linkup(ep);
+
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
 	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
@@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
-	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
 	u32 status_l0, status_l1, link_status;
 
@@ -515,7 +519,7 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 			link_status = appl_readl(pcie, APPL_LINK_STATUS);
 			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
 				dev_dbg(pcie->dev, "Link is up with Host\n");
-				dw_pcie_ep_linkup(ep);
+				set_bit(0, &pcie->link_status);
 			}
 		}
 
-- 
2.25.1

