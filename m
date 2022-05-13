Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C715262BF
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 15:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380614AbiEMNRC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiEMNQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 09:16:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84565F9
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:16:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bx33so10223703ljb.12
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulWWnp+Nuygcg9mpIGR4KnsZLaMcWPuhs6bcuEDBk1Y=;
        b=aPYdlIrrYacieLJCltg7pH7U2rt2FD09kukvD3RbZA5I5LGbdmRuywiXta1HeMKO/K
         8EzEVuxTVjw59kisYjC0YUmG27RAoJ1FiIelNWG1UfchG5ILS6ug9+A4SjwTBv/sFMf4
         EqJ2eU+jLtalKS/9oJsLb4dEM8AcXbeLq/lsKZsOdlxOwR9ZSq0IiWAo1WLtleRXZpw8
         oxXglsAw8zzth2ofej1ud2G/TNruidzQwP9kFas9DrVvf37GeSmMTs2RTBvA4zI23Mqs
         yURk+M4+c9sdtRBpQ/gtGFCyruPGwEESivGQvAPPCrmveUortyyBk63xnnnBxZ1O5hvE
         lieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ulWWnp+Nuygcg9mpIGR4KnsZLaMcWPuhs6bcuEDBk1Y=;
        b=76xJsnZ8dqYxBGMTrekoW4Cmv5uJNJAqbE289M5LKLwDQ5crDusg6VoTwGhKwJQpQs
         htXCT90iV70ipuJzWoXogsbobADxiLhdasq6UkMgNeMxvRmlBgQrN7ZSLOpnOxXKHvPx
         XzG/IYBxwtWkHwiozlJdw1dveOZ7CBtYAIfGsjM13HZhEbVEe9PTQWiJl/3vd2xDOlvT
         TChKVEJkzwsuhzGVbU39KvXcf+yEiaq70sfIHsZCMU6PKWeMScJzPm+ZObRRcDhB3W/Y
         awJrsIDt4InoWOWOTxN7gDDyLX5r4fh4e8sgva3u5BUSOWNOr3ZwkaBig5QAipr8Z4+s
         twcw==
X-Gm-Message-State: AOAM531bveP0wTgitnlm7qMCu9MX0LUgOWHdxp4ECVI820sD0caCtrN2
        8EYXYQhiIkxBc1psJ0mxcAihvg==
X-Google-Smtp-Source: ABdhPJxIAW4Ju9ky88hwEh9N8TXvptSFq8iadf/pRScgSh+jsoJozkpXmSIne46NPVyt8XjsJaNozg==
X-Received: by 2002:a05:651c:2120:b0:24f:555d:a2d3 with SMTP id a32-20020a05651c212000b0024f555da2d3mr3119399ljq.157.1652447816403;
        Fri, 13 May 2022 06:16:56 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b0024f3d1dae8fsm436991ljl.23.2022.05.13.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:16:55 -0700 (PDT)
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 00/10] PCI: qcom: Fix higher MSI vectors handling
Date:   Fri, 13 May 2022 16:16:45 +0300
Message-Id: <20220513131655.2927616-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Changes since v8:
 - Fix typos noted by Bjorn Helgaas
 - Add missing links to the patch 1 (revert)
 - Fix sm8250 interrupt-names (Johan)
 - Specify num_vectors in qcom configuration data (Johan)
 - Rework parsing of MSI IRQs (Johan)

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
  PCI: dwc: Propagate error from dma_mapping_error()
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: split MSI IRQ parsing/allocation to a separate function
  PCI: dwc: Handle MSIs routed to multiple GIC interrupts
  PCI: dwc: Implement special ISR handler for split MSI IRQ setup
  PCI: qcom: Handle MSIs routed to multiple GIC interrupts
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  53 ++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 213 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   3 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  14 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 10 files changed, 232 insertions(+), 73 deletions(-)

-- 
2.35.1

