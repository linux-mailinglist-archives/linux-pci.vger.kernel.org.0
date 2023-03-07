Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09AB6AE458
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 16:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCGPSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Mar 2023 10:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCGPRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Mar 2023 10:17:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769411E82
        for <linux-pci@vger.kernel.org>; Tue,  7 Mar 2023 07:14:45 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h8so14383741plf.10
        for <linux-pci@vger.kernel.org>; Tue, 07 Mar 2023 07:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG6X0V5nxXAs/7mwFsePGG2/rhZWHmM/NsTiFkA/mm8=;
        b=YHkphKuDjhtwDazatKKFqREMUkuOcbXYwMKoKsgilp3oVm9M2R1giSizaO40MxRD9u
         aHBDrHih67JBZ6mouH945gvCBITUgOGkXvgOhCAOLbVNgs6/cn05QFqX5V/vxeqZmYdC
         tIhbPQpXkj4mi7H3euHOTmClqUNaZU0GQds5tg6ajX2MnktW/NSRCfWI7F4UiIBftfBA
         xaSojjWTHYt1MD4HF2Ep/8BIBOVxb2yuObJU5AW+wyw8Zbv5vKtbq/dn3a3A4Iub6CrP
         eg+tIXqkgqLrOCxR+VpfOHA5DH6pKym0iF03Q0EynNQJUcco7JhET45ejlTyb+sDZa8X
         ykEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG6X0V5nxXAs/7mwFsePGG2/rhZWHmM/NsTiFkA/mm8=;
        b=cGBNzHkf+ndDKzqghqXSfrEX0kmWKmq+mRknkERsM1h9XwqZMV3CeYKG5x06UuWwiA
         aTOQwq0ibE/5JcHbmvReLYdPrQyGdUk4wDVFyRJ2NWTuwlE92MKOGnAoaaLjMlbQgZSe
         Rl50ikvB/B3JDpOTImz+k/yt63g44Sonl/z4WbhBOaevIX9WEFQYigOuKUBuXoHvRfGY
         bbsgUaLXMPOcmQXq0FwyXHBY6w8/zaboIcugas5P+Yr+6bV2HARaro1JHPAJ2YHbq5DJ
         I1einFSm6Coh0Dj8BmYPHU4NUPnq8A81oHOYrFkq6nV41FT2iDEEU638g2MtM/YOGFDE
         VOTw==
X-Gm-Message-State: AO0yUKU+j01jZ5J8LgwG0nS+5R/fM41m5U/7jI88u5xS/hf/hjPoe70/
        gYV8DBA41weW6x9h28oPllHX
X-Google-Smtp-Source: AK7set8jxfxzZuh8JJPF6P5YEb2jZqC32slH88BAEnsXRBZwekfSBaARZjVDpy3IyXUCv0Xsv1VPFw==
X-Received: by 2002:a17:902:da90:b0:19a:a0d0:10f0 with SMTP id j16-20020a170902da9000b0019aa0d010f0mr17717100plx.23.1678202085374;
        Tue, 07 Mar 2023 07:14:45 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090340c800b0019c2cf12d15sm8549332pld.116.2023.03.07.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:14:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/7] PCI: qcom-ep: Add support for BME notification
Date:   Tue,  7 Mar 2023 20:44:15 +0530
Message-Id: <20230307151416.176595-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
References: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to pass BME (Bus Master Enable) notification to Endpoint
function driver so that the BME event can be processed by the function.

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

