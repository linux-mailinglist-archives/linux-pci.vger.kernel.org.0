Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7467651C190
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380117AbiEEN5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359502AbiEEN5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 09:57:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CFA57136
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 06:54:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g16so5699523lja.3
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxpW3jQfQRJuzP0YaVQ3Gyvey8yuBaVOYp4o4X4T9zc=;
        b=Mf8uiALjSdPsSvTCptWwY1VHfnuotSMm721a+9uwmXe5hBKiriK4tFI8AgZbOf5/lR
         aeMw411CB7PhNymVv9hRt6GWg7GN4WSmR3KUPH0GperVoMEWbhKplXr90TH25J5jIeYj
         5cDKNmPKaMTQiaiYm/Ix3znDKfqdsbAxhJLGPN/KrCfyepFBUao2m+cBQrmlWlZyWT79
         mHxI17uheLzmtCN12YpJYjbdeBoVrhS6HacKOF/Olb0Wzmk3ivmwxe9dnCiUwB+jh9Lw
         9pGrc8AOH8d1FXciKhOSHacBsC+ah4UmBpN9Hg1gXm70GQQpSfrDtFmd1pasPvitFQE4
         1sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxpW3jQfQRJuzP0YaVQ3Gyvey8yuBaVOYp4o4X4T9zc=;
        b=sZXuHAMH+fjeSZpzYlQq34gIXIf7aa5eMcYhzpEXhvVwQJsm3/UvKJc5lXfuRWyVq+
         BpHxTKpzWBDiL9OfhVUfKBMgqfN6svr8N0ztD1NtlIpJ6BOKTa0bVbnuQDkopTO9QUyU
         vhCXJZFKsUdLXxgDadxMGbYGE/Eq9Kz3E2ujOhyjV4Ssu/oeoeObTEpYEsHjQQwU7mDI
         NtK2n96E9uWpGrvjmFM2PhxKSRZfQii2UgNY1cClJDVccD0HcdI41QmBVHFXkVTWrFSW
         mq7rElkmeDj+sVnQlEr+mbsB3FmjmKRFwugDjSt3jHOnzL3+21Lfi/5HZ3561Bd0y1aW
         bcJQ==
X-Gm-Message-State: AOAM532Yoh/hKdgkJBUF1DaYA8GfnsNz+4UCrG/dbxaGPW8YjBmosEIz
        Ley8I6P6kZGYeTC0G43SEK2Vtg==
X-Google-Smtp-Source: ABdhPJxKgq8lst4mQr1wDvUGKp7wtQoV6Z07DBPyUVJgE7KdYio9PLwT6GmCdo1ru40/y0Gf4ujOzA==
X-Received: by 2002:a05:651c:887:b0:247:f630:d069 with SMTP id d7-20020a05651c088700b00247f630d069mr16784652ljq.514.1651758848324;
        Thu, 05 May 2022 06:54:08 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z24-20020ac25df8000000b0047255d211ccsm221788lfq.251.2022.05.05.06.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:54:07 -0700 (PDT)
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
Subject: [PATCH v7 0/7] PCI: qcom: Fix higher MSI vectors handling
Date:   Thu,  5 May 2022 16:54:00 +0300
Message-Id: <20220505135407.1352382-1-dmitry.baryshkov@linaro.org>
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

Since we can not expect that other platforms will use multi-IRQ scheme
for MSI mapping (e.g. iMX and Tegra map all 256 MSI interrupts to single
IRQ), it's support is implemented directly in pcie-qcom rather than in
the core driver.

The first patch in the series is a revert of  [2] (landed in pci-next).
Either both patches should be applied or both should be dropped.

Patchseries dependecies: [3] (for the schema change).

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


Dmitry Baryshkov (7):
  PCI: qcom: Revert "PCI: qcom: Add support for handling MSIs from 8
    endpoints"
  PCI: dwc: Correct msi_irq condition in dw_pcie_free_msi()
  PCI: dwc: Add msi_host_deinit callback
  PCI: dwc: Export several functions useful for MSI implentations
  PCI: qcom: Handle MSIs routed to multiple GIC interrupts
  dt-bindings: PCI: qcom: Support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  45 +++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  11 +-
 .../pci/controller/dwc/pcie-designware-host.c |  72 +++++----
 drivers/pci/controller/dwc/pcie-designware.h  |  12 ++
 drivers/pci/controller/dwc/pcie-qcom.c        | 138 +++++++++++++++++-
 5 files changed, 246 insertions(+), 32 deletions(-)

-- 
2.35.1

