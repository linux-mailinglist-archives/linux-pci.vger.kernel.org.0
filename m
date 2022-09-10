Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082C5B4479
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIJGbP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiIJGbO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:31:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631A5A83C
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:31:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b17so6560981wrq.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gbwg87hG3tf6Wqw8hsoPn0QdO74QME7etMAVFms+/pw=;
        b=KwtvUurXbeHO6LN5XkdbNw+CFAxApERtegitBPv/R/BdNUucdsg3cCdZdJ+a9zF5ew
         5sT0qI05Pl3tCASlfLDWc4LTQ4+5AQ1nACHtoksFaJbnnpIPpX0xtRJxOI6IKx4B+tJ2
         ncT3+L/of2l+IMrhCQEei8RItm5+EdUkJkD21CuEQmp+MOHc7ozr03Kb+IJsFU97ruUU
         dZ03pbLu6L5jW6n5mcXdn+MdvPP2r5PauSmG3bDJmXybZm6TqPa/708M/dVLvTzMZlZA
         A5xMOZOsyn0QN1bN/RQQeotLmXt8VwH8QRYcgcZ4+Mk8Swa3AHJ6WQMbt5dnJHz96lMZ
         XH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gbwg87hG3tf6Wqw8hsoPn0QdO74QME7etMAVFms+/pw=;
        b=FiwkqPPYW1VuuhfknsJ6Qe7EbdWO7K0h0oKYU6SBqo01LSn+qPYs+JtH8ivbdeKBvZ
         N/ooeCo4XP9Y6HRzGGGlWeTePoDwulKC1HHCIi/98Vl4+w4Hr+4+SmIq0R2QrKxIeQSu
         u48+GCkqMs7iVWxWKqtsiCnPmmcY3Rmzz8J/31e8b/xAaF5j24Ueq7qqCUbyWatn19ui
         0CtydilyX0Y6+XQGNNYc8ZdmIr4q7ixzUZFXpc0g0RDITdt566lMEtj/IgQRF/czZYIh
         pgwmRez6/W7mHGSzr/E64UCbkCiLwe6TDSstPbNIZLjIEFrNyExdhCDUHXEi5Y9PpXko
         WCeg==
X-Gm-Message-State: ACgBeo3kEOKyjngaxLbNXdkHDOH5y5ymYfCO+fhpVHyyndnV2TKiKqHg
        czBYuoqQXXHqXZm9AQ3Ihw6d+q17ffcINoA=
X-Google-Smtp-Source: AA6agR5ydCjDmuydp4TsC7dOTrPwX4Vdzi7U/ldbEVD9S451Y42QFo5vu9Y81QWIEeKYvZnWCtHnGA==
X-Received: by 2002:a5d:64a4:0:b0:226:df7c:2e5d with SMTP id m4-20020a5d64a4000000b00226df7c2e5dmr9730168wrp.416.1662791470430;
        Fri, 09 Sep 2022 23:31:10 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 01/12] PCI: qcom-ep: Add kernel-doc for qcom_pcie_ep structure
Date:   Sat, 10 Sep 2022 12:00:34 +0530
Message-Id: <20220910063045.16648-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
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

Add kernel-doc for qcom_pcie_ep structure.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 9f92d53da81a..27b7c9710b5f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -140,6 +140,23 @@ static struct clk_bulk_data qcom_pcie_ep_clks[] = {
 	{ .id = "slave_q2a" },
 };
 
+/**
+ * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
+ * @pci: Designware PCIe controller struct
+ * @parf: Qualcomm PCIe specific PARF register base
+ * @elbi: Designware PCIe specific ELBI register base
+ * @perst_map: PERST regmap
+ * @mmio_res: MMIO region resource
+ * @core_reset: PCIe Endpoint core reset
+ * @reset: PERST# GPIO
+ * @wake: WAKE# GPIO
+ * @phy: PHY controller block
+ * @perst_en: Flag for PERST enable
+ * @perst_sep_en: Flag for PERST separation enable
+ * @link_status: PCIe Link status
+ * @global_irq: Qualcomm PCIe specific Global IRQ
+ * @perst_irq: PERST# IRQ
+ */
 struct qcom_pcie_ep {
 	struct dw_pcie pci;
 
-- 
2.25.1

