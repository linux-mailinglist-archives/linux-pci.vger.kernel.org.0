Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1320524A95
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbiELKqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 06:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352780AbiELKp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 06:45:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C489BF43
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p26so8271713lfh.10
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzR6y+s/rLlcoOu2dDQknc5DKjFo+5yNrwU72UblAeg=;
        b=ol1JW7fcNHfwQ1YNlwm0Lip823FLYoNhjGWx7m8Cx25T4sg5NVcH7vaWnUvXoIaZlH
         xO8Dx0bOnZtXQbLF+mUXdC1rfWUZA7BxdNUjTc2f134n9tHay0TJpXmtFYyNR4/tFiJJ
         2hN1V4IYAMtN5AfTOYlLuCdfKxWjskijvZomJYtgedDLCHgEkaeDo3quwuXokEFlnf7O
         FlmsyJsMowP/g1Ykq+SfDgsRTtryOP9o2HTY6AdoMd7axSqGN7Ul2d8Z81TwEdC5RzzC
         Wae3dI7ehvqFyh9PWVI1t+cGRxUI5EfS/pYonu1Jj3R8hj7qiuEpsgjZT8F8PxG6raIi
         BZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzR6y+s/rLlcoOu2dDQknc5DKjFo+5yNrwU72UblAeg=;
        b=MPNTf1Kw4/gtwwsi1OTWJvBiBeaUF+iZ0HNNYudF4jqJfoXj5ICw1TWu/RmvUxskfM
         pmNqZGZdRf2b/wHg9hu8C+pJlwWmNorDClDakrsrJnYfcpDvZ17jFTROr8vtryuSCenD
         wVeVc/6Izhd7Cf8gQqdxtsFXj2CpeGvwe9G7tnl2q1MgnnZWZoo/+O3prj4p3t7GGf3W
         uB0VMtdcEaKqA582BZGwhozqK8Dr+Fgly6r2PzSKO4/lRPbVgGsnT/puJGaRr5lAv5jk
         WMAvFCKiHSAXJR0Wiug9P/esMNTrJGSw9bLujkwSlrfKUVBMIEIUI2n0FYeYz3YlhpDW
         j8Gw==
X-Gm-Message-State: AOAM532IUbIQuJ/tvqH4VjQWVkoPlI6KB0WQled6l2c/ePmec7+GuXy1
        +mdwfOFfX/jZfdnXVL6njF+E2Q==
X-Google-Smtp-Source: ABdhPJzgzzVA3Ej3QA6e0x3uM0Ffqjexeynj5QlvErI0QzXLII84XahRJ8xD55yq+CN/RLq64KJsVQ==
X-Received: by 2002:a19:4942:0:b0:473:e75f:c058 with SMTP id l2-20020a194942000000b00473e75fc058mr24184779lfj.82.1652352346599;
        Thu, 12 May 2022 03:45:46 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e9695000000b0024f3d1daeafsm831660lji.55.2022.05.12.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:45:46 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 00/10] PCI: qcom: Fix higher MSI vectors handling
Date:   Thu, 12 May 2022 13:45:35 +0300
Message-Id: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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

I have replied with my Tested-by to the patch at [2], which has landed
in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
Add support for handling MSIs from 8 endpoints"). However lately I
noticed that during the tests I still had 'pcie_pme=nomsi', so the
device was not forced to use higher MSI vectors.

After removing this option I noticed that hight MSI vectors are not
delivered on tested platforms. After additional research I stumbled upon
a patch in msm-4.14 ([1]), which describes that each group of MSI
vectors is mapped to the separate interrupt. Implement corresponding
mapping.

The first patch in the series is a revert of  [2] (landed in pci-next).
Either both patches should be applied or both should be dropped.

Patchseries dependecies: [3] (for the schema change).

Changes since v7:
 - Move code back to the dwc core driver (as required by Rob),
 - Change dt schema to require either a single "msi" interrupt or an
   array of "msi0", "msi1", ... "msi7" IRQs. Disallow specifying a
   part of the array (the DT should specify the exact amount of MSI IRQs
   allowing fallback to a single "msi" IRQ),
 - Fix in the DWC init code for the dma_mapping_error() return value.

Changes since v6:
 - Fix indentation of the arguments as requested by Stanimir

Changes since v5:
 - Fixed commit subject and in-comment code according to Bjorn's
   suggestion,
 - Changed variable idx to i to follow dw_handle_msi_irq() style.

Changes since v4:
 - Fix the minItems/maxItems properties in the YAML schema.

Changes since v3:
 - Reimplement MSI handling scheme in the Qualcomm host controller
   driver.

Changes since v2:
 - Fix and rephrase commit message for patch 2.

Changes since v1:
 - Split a huge patch into three patches as suggested by Bjorn Helgaas
 - snps,dw-pcie removal is now part of [3]

[1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
[2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
[3] https://lore.kernel.org/linux-arm-msm/20220422211002.2012070-1-dmitry.baryshkov@linaro.org/


Dmitry Baryshkov (10):
  PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8
    endpoints"
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: Propagate error from dma_mapping_error()
  PCI: dwc: split MSI IRQ parsing/allocation to a separate function
  PCI: dwc: Handle MSIs routed to multiple GIC interrupts
  PCI: qcom: Handle MSIs routed to multiple GIC interrupts
  PCI: dwc: Implement special ISR handler for split MSI IRQ setup
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  53 ++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  11 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 214 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   3 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  13 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 10 files changed, 231 insertions(+), 73 deletions(-)

-- 
2.35.1

