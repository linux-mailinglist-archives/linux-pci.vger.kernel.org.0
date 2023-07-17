Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F5755C2B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGQGzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGQGzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 02:55:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB610DA
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2023 23:55:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6686c74183cso4262850b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2023 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689576916; x=1692168916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb9LlQcGjFjNwM13Qknh1i1JQ2UWaF+8pLaINltAQNI=;
        b=DbjIHxX88jeFICr7g1j9fsD29rDdWOtUu2IOiOfD/bNC6WuiQrRMtIVaBgJjv7sHnE
         zUZ79J9y91fEZuRsoi/nAN6P4NuEfG2LPGXl+SiSEykzobOtG0XNAyuV8UGrtFDLn4nT
         Q6tgZK8O3h8/Ea2XRXAk9ESvVOaqkn7pQYRXDBDQzh91/XKTDVvEyOPqxlv8Het/dEzd
         nDi3M2z7kLnCZmh3Hv+3DG+x+E+OsGXWWaA52UONNq6MbNjqcWM31U2zkMpD4E57sIHI
         /x6idkHrLgIA1QgMvAaoIZkJIW7xLItLZ0UYNoLyMqtyXXJcRq1RzyTK8tdvC+tBY7Pl
         6ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576916; x=1692168916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb9LlQcGjFjNwM13Qknh1i1JQ2UWaF+8pLaINltAQNI=;
        b=dP3uMvDzu4NDgwVVqzjY3Zn/zyR+VGRAOyYeLMz1gyuzC+9B7vslbtufSw/3svPYyZ
         z+zjuNQDqU68T8gW8xhKeEQm6ps6YbPwnv3/yz6nF1jn2Fj0q+w11qwmg7afaVj0HAe2
         siARxjsrockczA50C/xbXaa4bFYtNkGdjlGlcw/r9o2vRqpl+VEgBPN3x46MHAdb0iZD
         kVVmBc1nEAuafb9uzTHtLIBXoj9DhAbnG3SdD+pZoVIbHhB7LmoStXSmd3ef1smujpZP
         SrbQhsd6k6+CHcUA9crRcqy9LTyvvvtfO7KG5R1yntKEpxQhhf9ypmh+xthJ7CAfdSfJ
         +vxQ==
X-Gm-Message-State: ABy/qLYiEETOV+NRl0TpjZFvrC4ZYtCm+tjhn1oRM4ijjQ2I/DwVP2eO
        XmzfdZGlx8rw2y/AawT6Lwyq
X-Google-Smtp-Source: APBJJlHys8IijXNMKPy4AQJ4Y8zCJiG01oEkjG+qyJuN8uscZecC7frkak3ANFiQ9/ONcwiDh6D7tw==
X-Received: by 2002:a05:6a21:585:b0:12f:382d:2a37 with SMTP id lw5-20020a056a21058500b0012f382d2a37mr10650798pzb.15.1689576916635;
        Sun, 16 Jul 2023 23:55:16 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.209])
        by smtp.gmail.com with ESMTPSA id x7-20020a62fb07000000b006675c242548sm11196422pfm.182.2023.07.16.23.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:55:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/7] PCI: qcom-ep: Add eDMA support
Date:   Mon, 17 Jul 2023 12:24:55 +0530
Message-Id: <20230717065459.14138-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
References: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe Endpoint controllers have the in-built Embedded DMA (eDMA)
peripheral for offloading the data transfer between PCIe bus and memory.

Let's add the support for it by enabling the eDMA IRQ in the driver.
Rest of the functionality will be handled by the eDMA DMA Engine driver.

Since the eDMA on Qualcomm platforms only uses a single IRQ for all
channels, use 1 for edma.nr_irqs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 736be5bee458..1baec81183b6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -74,6 +74,7 @@
 #define PARF_INT_ALL_PLS_ERR			BIT(15)
 #define PARF_INT_ALL_PME_LEGACY			BIT(16)
 #define PARF_INT_ALL_PLS_PME			BIT(17)
+#define PARF_INT_ALL_EDMA			BIT(22)
 
 /* PARF_BDF_TO_SID_CFG register fields */
 #define PARF_BDF_TO_SID_BYPASS			BIT(0)
@@ -395,7 +396,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	writel_relaxed(0, pcie_ep->parf + PARF_INT_ALL_MASK);
 	val = PARF_INT_ALL_LINK_DOWN | PARF_INT_ALL_BME |
 	      PARF_INT_ALL_PM_TURNOFF | PARF_INT_ALL_DSTATE_CHANGE |
-	      PARF_INT_ALL_LINK_UP;
+	      PARF_INT_ALL_LINK_UP | PARF_INT_ALL_EDMA;
 	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
 
 	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
@@ -744,6 +745,7 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.dev = dev;
 	pcie_ep->pci.ops = &pci_ops;
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
+	pcie_ep->pci.edma.nr_irqs = 1;
 	platform_set_drvdata(pdev, pcie_ep);
 
 	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
-- 
2.25.1

