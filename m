Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AAD56A417
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiGGNrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiGGNrh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:47:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED99D20BC5
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:47:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i18so31193261lfu.8
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1GOHn3c7MIyi+6bnMCT0vJuD5+SAX16SAikKtNPcpE=;
        b=ytNzWjq70HR07Yee4GkPmD6pP/4W5f72nUf3VFPRCa3LfJI3GJJCCfiiRSXVk/ToSU
         o5DIYWNsSoYicP+aZL4FDOF3QlbHbrHzuh3HecvfNcxNJssXEj9jZI4WXiwyAQk9AcN/
         LmV1kDrMbifMU9F53Ym74IgUGOEWdVi4LS5EFmNwJr3zFHxTxCX7P0yavLxh+b2XbZJ9
         +9P3hl89mpgir6cVip+XUzEigi1YGktjDj8ar8KPbrgtHF2rQq0A3+NPZNxRpv0T333S
         QbjVuKku51IVPw2HDZ1rnQDH2KJxmw9mimy5+zgllz7MAqRY99LhPeTluMLv/UtgRDTK
         ehEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1GOHn3c7MIyi+6bnMCT0vJuD5+SAX16SAikKtNPcpE=;
        b=1UobaMGdL5lgmGPQ/LZv//lO+RhParUESoZb0NYL84Ee2mCa50xl8g0C7Sg+i63xtK
         xR0cguatzSZc+CaGxwqZQ0jL114eCRyIm0aDFQfs4Ukcugxk2L7kSs59P93DkjYcMR0L
         4l44PbXcDIytGIrjetcu9FQNLbhXzgyeh59DUEjnmY7wTGo/q75/YKm4al7E+tmmpvNj
         bWdyC4PravTbu7eSGqqilJl2PkMRZ7vVK5WiBLgLMsDF8wY2NiaSD/WFL2mPnnHs/TKX
         kKoaTbh+gXg/V9Vr8rB5qXpXHtxqW4ODHQH+s2hmIUIeopp9S9dvzWzYLv8VWfNBkvlH
         SGwg==
X-Gm-Message-State: AJIora9zKNpwASOpfb4+Fm14W1PGnL3BNTNxWy4pE2Zp9dlD+qMooKt6
        8WZdSLYcrCeR4QLLODGpYUVDww==
X-Google-Smtp-Source: AGRyM1s4ALA35hlnvtetI0pZvp4m5E5jSAWufaoCc2OgZY55mOiQa0sHo8ttN5GvYlrBK/Bp4Pd3qw==
X-Received: by 2002:a05:6512:2610:b0:47f:74dc:3205 with SMTP id bt16-20020a056512261000b0047f74dc3205mr28218343lfb.429.1657201654279;
        Thu, 07 Jul 2022 06:47:34 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a197916000000b0047fa941067fsm6856966lfc.29.2022.07.07.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:47:33 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v17 0/6] PCI: dwc: Fix higher MSI vectors handling
Date:   Thu,  7 Jul 2022 16:47:27 +0300
Message-Id: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
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

Changes since v16:
 - Fix a typo in the dt schema (noticed and fixed by Johan).

Changes since v15:
 - Rebased on top of linux-next to take care of the conflict with the
   comit 27235cd867cf ("PCI: dwc: Fix MSI msi_msg DMA mapping").

Changes since v14:
 - Fixed the dtschema warnings in qcom,pcie.yaml (reported by Rob
   Herring)

Changes since v13:
 - Changed msiX from pointer to the char array (reported by Johan).

Changes since v12:
 - Dropped split_msi_names array in favour of generating the msi_name on
   the fly (Rob),
 - Dropped separate split MSI ISR as requested by Rob,
 - Many small syntax & spelling changes as suggested by Johan and Rob,
 - Moved a revert to be a last patch, as it is now a reminder to
   Lorenzo,
 - Renamed series to name dwc rather than qcom, as the are no more
   actual changes to the qcom PCIe driver (Johan thanks for all
   suggestions for making the code to work as is).

Changes since v11 (suggested by Johan):
 - Added back reporting errors for the "msi0" interrupt,
 - Stopped overriding num_vectors field if it is less than the amount of
   MSI vectors deduced from interrupt list,
 - Added a warning (and an override) if the host specifies more MSI
   vectors than available,
 - Moved has_split_msi_irq variable to the patch where it is used.

Changes since v10:
 - Remove has_split_msi_irqs flag. Trust DT and use split MSI IRQs if
   they are described in the DT. This removes the need for the
   pcie-qcom.c changes (everything is handled by the core (suggested by
   Johan).
 - Rebased on top of Lorenzo's DWC branch

Changes since v9:
 - Relax requirements and stop validating the DT. If the has_split_msi
   was specified, parse as many msiN irqs as specified in DT. If there
   are none, fallback to the single "msi" IRQ.

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


Dmitry Baryshkov (6):
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: split MSI IRQ parsing/allocation to a separate function
  PCI: dwc: Handle MSIs routed to multiple GIC interrupts
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  51 +++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 164 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 9 files changed, 185 insertions(+), 54 deletions(-)

-- 
2.35.1

