Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D55B4475
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIJGbK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIJGbJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:31:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C65A83C
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:31:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t14so6578253wrx.8
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=A6MnCj2se0faTLxU7PAsnpqHYvC5MdUEcJAJwKpneuk=;
        b=ZQPW/e3uE08A1vHM+0FO//L6uqJ4cOAHftQUFZHMGS15pJ+gT5Qxkc96XA2FacYmVY
         NGvqjg7kNwASl+fgaDj60Adz8wJQQL884QxdjWb+AK1w1Y0SMk1hErNhgRAANqbFcQZ7
         P/yZks6chztgMBBuERVfc8ccOMYiFW/6DKAxZw4Ye/cCPpjas7eMAn1CCit97az4f2e/
         O8aauMJrMp/vOn9zepr8LlwMCjE8Jc2z1DTX8yiQMiBIq2Ve0O+lemmHapd8+QayC9Ly
         RgVLrmwHpSNgFDnuPCm9SvC92M/vXNEnCOJwUrep+JJrA3xs+ojPI1xoJSgOWCG94c5s
         0uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=A6MnCj2se0faTLxU7PAsnpqHYvC5MdUEcJAJwKpneuk=;
        b=k4Z9Lg6LGdEe+UBoigIp7SXzjX6uHMTLRZCk8Z7UxoGhU75k0oLtsZD8sRc+gdh/Gx
         eH6SHOODmv+68opAJtddcgc5N/dhIWHYfcZxO2FkpxFXEPQ1uNtxxc5xLK7RJj5CKx1N
         IKgNeCx+sPs1y7zYyBqEE/F1nbA1CCOzjYadExDFOERuXHlm4jBof2tyXWwyXKCJnzFY
         khbjxgsKdBHCmIbBx7Gx+x9rTKL29RX87iGq025QlDjXQrXOy6HXBYy1nyqy4Hrg2bIb
         pfRp48xlPB68BSrGc+dEI8CywKIjijlRt4h6jMb6UHYiDZQAsK/0GKUC2vxfRDWJz4tm
         5UcQ==
X-Gm-Message-State: ACgBeo1qkJn4Gxv7fd4XkYut58kZrubDFesqw0bfXmXbAyfFwuu9FAiV
        kXUrEGi6UhligPxnD9nGL73f
X-Google-Smtp-Source: AA6agR6+DDlQpQMYwmCOlPd/pOo8N8SiqTmfGsE3pKl9js0b8ymhF4lLqfUEpipV8WBJYNJJcHJb/w==
X-Received: by 2002:adf:d215:0:b0:228:6293:10ff with SMTP id j21-20020adfd215000000b00228629310ffmr9728557wrh.171.1662791462703;
        Fri, 09 Sep 2022 23:31:02 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/12] Improvements to the Qcom PCIe Endpoint driver
Date:   Sat, 10 Sep 2022 12:00:33 +0530
Message-Id: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hello,

This series contains improvements to the Qualcomm PCIe Endpoint controller
driver. The major improvements are the addition of SM8450 SoC support and
debugfs interface for exposing link transition counts.

This series has been tested on SM8450 based dev board.

Thanks,
Mani

Changes in v3:

* Removed the maxItems property from "items" list
* Reworded the debugfs patch
* Dropped the eDMA patch since that depends on ongoing eDMA series from Sergey
* Added two new patches that helps in saving power during idle and low power
  state

Changes in v2:

* Fixed the comments on bindings patches
* Added Ack from Krzysztof

Manivannan Sadhasivam (12):
  PCI: qcom-ep: Add kernel-doc for qcom_pcie_ep structure
  PCI: qcom-ep: Do not use hardcoded clks in driver
  PCI: qcom-ep: Make use of the cached dev pointer
  PCI: qcom-ep: Disable IRQs during driver remove
  PCI: qcom-ep: Expose link transition counts via debugfs
  PCI: qcom-ep: Gate Master AXI clock to MHI bus during L1SS
  PCI: qcom-ep: Disable Master AXI Clock when there is no PCIe traffic
  dt-bindings: PCI: qcom-ep: Make PERST separation optional
  PCI: qcom-ep: Make PERST separation optional
  dt-bindings: PCI: qcom-ep: Define clocks per platform
  dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
  PCI: qcom-ep: Add support for SM8450 SoC

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml |  86 +++++++---
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 154 ++++++++++++++----
 2 files changed, 188 insertions(+), 52 deletions(-)

-- 
2.25.1

