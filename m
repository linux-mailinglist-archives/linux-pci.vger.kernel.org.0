Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445AB709A38
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjESOnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjESOmx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 10:42:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2E10FC
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d18d772bdso2330602b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 19 May 2023 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684507364; x=1687099364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI+i05lzXUFOa/Wt+qCq2zIVxieQpfBQT3yhV8ufVhA=;
        b=UH0O2514/iDnKDxDe0vWzjD2YlBM+MfhgGuIdPfytBmq0vGCukWuUy2xsb2RzlnWzj
         OpxBy6K93k9zf9Ibr3ulNLcra5FDmfI6gIem+FeuHYV+to4f0EXxS/Ds9E9vsmXDD4gR
         jqnb9BV23DdYbJTog2vI0sxXc9cFWxWNkG10VD/gslu9on7UPHle48HFLq/DNJXLrjz6
         5wh1D5YosY7NkKoL4/IrTS4Z+DQuM3g1zbv6kt9gJiIDJVQpy0M2JKTtmHRfnuQdCIeA
         JEk+UKOvQzNuLl5rWYbywrVmvKnMHpFfsYmZqHNCzUrjmzpkvwCWfgpDKs2sf39pwa7M
         w7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507364; x=1687099364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI+i05lzXUFOa/Wt+qCq2zIVxieQpfBQT3yhV8ufVhA=;
        b=gMqsdPpmeXw9N1WcBjjpqUuWkAfCnMGx5c9lhIxQQRnQihnHarPZf6WzbLXCquwI5g
         lSnyuEXJmz7sCf0SEoctyAcnTtJHfmFQP+9DI1ru0lqtNJ7iU2yRpE1bECbsnmgguJdW
         XoRTZtqVhnJJ4BkRpOVx1jmgg3jJMlhbFkdGU7brolLumNXWsfZSf0ptj/Ef8ZD014aw
         xHXggMmHLIqLWflqAAp62NaYTGrqzX2NBbGRZwsPlnXHNYLeXLZqH07IskwFcH1Py/gX
         +zYCz3prUNcQAyESg1Xtj8ETEhPIHaT5n14sRDLTJVhD79Kw8CePmHJ19A8GYx/8jHTJ
         5qog==
X-Gm-Message-State: AC+VfDw9DCGMIrz3eW4y/xe2ZZ9REcExJxyL/7cMiuTfZTZznbT/tZOZ
        2Cdnu5Q3bfq6kCHoID1Ezrl5
X-Google-Smtp-Source: ACHHUZ7Hf1ixBT074nTikvKLNqOwJSJ9qvRfgXAWbOR2Wxw5AgMhngUKUJgbtfnzMUbXdxV5VxMGSg==
X-Received: by 2002:a05:6a00:2d96:b0:64c:b819:89c1 with SMTP id fb22-20020a056a002d9600b0064cb81989c1mr3362785pfb.27.1684507363952;
        Fri, 19 May 2023 07:42:43 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.13])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b005d22639b577sm3089611pff.165.2023.05.19.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:42:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 6/7] PCI: qcom-ep: Add support for BME notification
Date:   Fri, 19 May 2023 20:12:14 +0530
Message-Id: <20230519144215.25167-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to pass BME (Bus Master Enable) notification to Endpoint
function driver so that the BME event can be processed by the function.

Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 4ce01ff7527c..1435f516d3f7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -573,6 +573,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
+		pci_epc_bme_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
 		val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
-- 
2.25.1

