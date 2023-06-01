Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DC71A139
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jun 2023 16:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjFAO6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jun 2023 10:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjFAO60 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2023 10:58:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A327710D8
        for <linux-pci@vger.kernel.org>; Thu,  1 Jun 2023 07:58:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so899829a12.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2023 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685631482; x=1688223482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI+i05lzXUFOa/Wt+qCq2zIVxieQpfBQT3yhV8ufVhA=;
        b=luiwntytbmX2sLwXUJD+GCD4AelS02z0wAnjXKyRcnz2TONRfJx9/jDRnrx9sxosMV
         l88HaGJQd7NoCbz830SuB5aHfIzoXGH+s8bWfkKnfPc1kMR6D7+1BLzSSNNYp3bQsbZJ
         E6FSd7ygdv9KV2pSDrz/+KtdPpt7KFtYWB8grWa6N2rrgN2sYH/dGdy+BSKYzNAUGmL6
         hmKHbSxQeXgCLj96ntTZP0Vhb44Wvhz6euvvipO2Ey4JjY1kltyzN0J2MmPVtM6K/bcq
         kdgjDSE7ADUKl0iT2puGrfUK4e3gKlUC5T1OlgOkys0qFvN6I1lKvUqfSG22AYpSXvWo
         qA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631482; x=1688223482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FI+i05lzXUFOa/Wt+qCq2zIVxieQpfBQT3yhV8ufVhA=;
        b=MIvlLJ5DY/pOsbkPWlkpVfBLsPOF8j684z6q0RYZAejyzSvZHsTVXLJe3IBEEeiUhy
         jMT2TrTdl0c8qlRhsrREPCzoI3zY//jZ/QgBtFy3BLfrEkq0CNBgkcJfdyLpBLkbeDG9
         NJCek2/XEqsHWJWasv5YYFDS9v1mgMpp0FO8TZs/su/V3BlVPtAy0urT3Z2SQlVq4DzL
         ZHZGw/W5zUNuuolovGUSwoD7wIsFB6jEF+yfX/DYu9nRlN2gxN2M0fOQsYyL34mhFk+d
         a2qLHM7GocHpP3L4Cb3LVqd/C9wUAR+lkmR4w2YJx5J8Hs6gT6eZZmLN3QcRTEnfF1Xo
         /Kfg==
X-Gm-Message-State: AC+VfDzSSG3V5A3Yy2mw9uSfwSdsMc495dmSXLRTJIETiTHvJC4ofNB0
        W+HjwDBY6LGap6t2rSkh9epj
X-Google-Smtp-Source: ACHHUZ4U7+pUjijouXJ4Ywlqnv9Ltli2YHvNZUAVwzrQ/OXE7+AK/HJWqUJA+nyLcxX9FHy4LgI8KA==
X-Received: by 2002:a17:902:ced1:b0:1b0:6038:2982 with SMTP id d17-20020a170902ced100b001b060382982mr10438042plg.41.1685631481923;
        Thu, 01 Jun 2023 07:58:01 -0700 (PDT)
Received: from localhost.localdomain ([117.217.186.123])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001b0603829a0sm3577826plg.199.2023.06.01.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:58:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 8/9] PCI: qcom-ep: Add support for BME notification
Date:   Thu,  1 Jun 2023 20:27:17 +0530
Message-Id: <20230601145718.12204-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
References: <20230601145718.12204-1-manivannan.sadhasivam@linaro.org>
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

