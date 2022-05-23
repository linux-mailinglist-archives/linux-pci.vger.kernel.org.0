Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367E531A21
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbiEWSjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbiEWSi5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 14:38:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299EC84A00
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:18:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r3so11316083ljd.7
        for <linux-pci@vger.kernel.org>; Mon, 23 May 2022 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAQjizdLMl0Og1Syh05TGYx3nDIu1bvaAdxxkO91pXc=;
        b=Xz/+ngiHZLU9VwBl+7Luw5ffHNsi7153XfZJfen02t4elYmbpulimWOBz6wHn2whaJ
         o/vzT6zZPFhuYBlnAPkxMdyYJH5RjTphhtOu93tOyqReY4H967iD9zyMkg1XaeU6SKWO
         rED7tQfjF/isLqr/x42tcQfQzci8So87XHF/EYuyB+NXvdw1ZWSsn4jy1vDuEhxaAHFc
         rg00Olj5WT0WWFk8uoiA8Gn6G9g2iRBAqxbwW3v26G4czDmjpV7bbqFhl96RJCIwoAEE
         ECyn7mwX1I8J7vpLY7ve0BTLh7egBLJMiXDW+0TN3ZaADg4fkjezs0SEKIA38Fn8NTZC
         jA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eAQjizdLMl0Og1Syh05TGYx3nDIu1bvaAdxxkO91pXc=;
        b=8Hv/tGUi319xOoaNACN5nsV2LH+IrE0Pv13gr2tB27S6eS00rvS4F1hvlcPslkRgXf
         nba3CVEOKfPfSt58Ki6kKmNtp2NcLY2ER+TZCLsgsmF/wgBG8j8xfJeQluKyFoWlMmlr
         aSCrR1HPNN7lS+GADxtmYCBFZ048rbWII3nIfnc/AdZ/GMDs+GSp+wdw08Zn+QhFwAzq
         K7RSGMFHZp6lUuFxklaZziHq26jyEHRzXQv+awc6u8Fw5zLgzE8LCStwO864Yiurq+V/
         BNBCcKYzA/B5NroTTc+Hh/geaXiSVmeQCeAyxp+8AR4M3wNav3WlCQADn6ptVJgDtNPX
         q5YA==
X-Gm-Message-State: AOAM531ZQuRsmaDBtQMSzUoo4l9K50F909ln4i/nzAQysqcmnfgxuIbc
        y6/C8uzfUjZaW77yDxqJq/JejVL1beHzYw==
X-Google-Smtp-Source: ABdhPJxkXlYvwuGBh7AjqRFTUdGyWMLJlRzap7FAFnLgcAvA2yviMC0HTLtxyX1WCVX2S8UFSi/JXw==
X-Received: by 2002:a05:651c:102a:b0:253:ee90:98ba with SMTP id w10-20020a05651c102a00b00253ee9098bamr2317457ljm.415.1653329918093;
        Mon, 23 May 2022 11:18:38 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e6e14000000b0024f3d1daedesm1904127ljc.102.2022.05.23.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:18:37 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v12 0/8] PCI: qcom: Fix higher MSI vectors handling
Date:   Mon, 23 May 2022 21:18:28 +0300
Message-Id: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
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
[3] https://lore.kernel.org/linux-arm-msm/20220422211002.2012070-1-dmitry.baryshkov@linaro.org/


Dmitry Baryshkov (8):
  PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8
    endpoints"
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: split MSI IRQ parsing/allocation to a separate function
  PCI: dwc: Handle MSIs routed to multiple GIC interrupts
  PCI: dwc: Implement special ISR handler for split MSI IRQ setup
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  53 +++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  12 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |   2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 243 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c   |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 10 files changed, 246 insertions(+), 75 deletions(-)

-- 
2.35.1

