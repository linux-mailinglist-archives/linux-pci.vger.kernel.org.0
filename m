Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F28516AB3
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 08:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383442AbiEBGKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 02:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357937AbiEBGKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 02:10:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F194FC44
        for <linux-pci@vger.kernel.org>; Sun,  1 May 2022 23:06:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p8so11550062pfh.8
        for <linux-pci@vger.kernel.org>; Sun, 01 May 2022 23:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdeJyrAXD9bV7ofsp6PZP8FNw3ldBFFBZZjktwKzfAQ=;
        b=JRtFD/BNr6MYu1sW228vEjCTznBOimfGyL2+KcRKKevlX4fUtx3iKfdJhDybZfdHRV
         19AmptZVlYHL0z31E5nBMfsHmtxRJjez1GbFlQRd2wMpdgwD4YE3djfp1FiIKEd6NEPu
         gYQlKNX8fCaKqQrsg6WArJ0sSTkAab+k3SI2oGGQtYEBNURJL0dCsmD+9u4Ai5y4EShT
         NEibiivVkyLc0wkJRnORv0l0TQdLSit/S+lx+UNsOMRiPoa2bPPLSGU9fq0Gu3HQOtCP
         aTFEwROxWsvjKfJi6Lku8nfoZbrZdglKRSIfkGEIh4nebhupZ+KctbXngsnRLVkPE5q6
         QeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdeJyrAXD9bV7ofsp6PZP8FNw3ldBFFBZZjktwKzfAQ=;
        b=dCOUp62NexhoFIF3RUz7EO51fJZPR13qvC8+akPZiX60yQzooL37La3v/A2AnRnOu+
         fBxa9Y0RdQMsfjrckWmjUy3bteJZC1JFyZ7Lr0l3VUtkETe+wSj1Yac7X3K5u8DrucQK
         KhWXh7A7yW16hKUzKMjEwkipm88wjB8YDEEINI6UMFTAgCTjsrGtCA4WrGsInb5GVfnV
         orhxq31RVkuEjC+9e2Hu0L057CI3nS0JiWBa91Ne33FPRrfZtSpWmRxUgplrDG3NGwXH
         8uTWAVMchUQn+Nq5RHZZBEX5XUqyPalz8Ei+RQolXdoaaLXUpVKtO693HZWf0xKnxBtX
         0JJg==
X-Gm-Message-State: AOAM531oSxm/j5nM8IkYG89YrxmPCR3O8S9WlYhMnygJX79+Zkq1ULMC
        PLyQly/NuD6F87Zg0E93voSJ
X-Google-Smtp-Source: ABdhPJzF6Gn2GNHpVPP8zhiQVusSfdVrgtGxGamUdIIAJ+rECZ//fMTwXWWxZTJkpDF1j6Fa3l1bcw==
X-Received: by 2002:a63:82c6:0:b0:3ab:2601:5e2d with SMTP id w189-20020a6382c6000000b003ab26015e2dmr8493084pgd.251.1651471603127;
        Sun, 01 May 2022 23:06:43 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.99])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm3933826pfn.91.2022.05.01.23.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 23:06:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        bhelgaas@google.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/8] PCI: qcom-ep: Add support for Link down notification
Date:   Mon,  2 May 2022 11:36:09 +0530
Message-Id: <20220502060611.58987-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
References: <20220502060611.58987-1-manivannan.sadhasivam@linaro.org>
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

Add support to pass Link down notification to Endpoint function driver
so that the LINK_DOWN event can be processed by the function.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 6ce8eddf3a37..9fb6e960f73d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -497,6 +497,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
+		pci_epc_linkdown(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
-- 
2.25.1

