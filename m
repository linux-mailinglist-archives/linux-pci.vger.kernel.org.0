Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70E50CAB2
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiDWNnI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiDWNmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 09:42:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09B1759EE
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z18so1677076lfu.9
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmG3r1mZsoVYs6QsuMg1BBRJC+fIBK1Gsm9c/gPZCvQ=;
        b=brJk0DzJNCmKD58MDuyNtEZdvjAvWql5feN/k63q8FkURGD2ZZiZOooj1Uweb4/nmY
         aTQyhVHdXCM0i+znL3n04sOGYFJHam5eqgIX/5lEpaFnr3kmH/eTfgQRbbshTkV1Tr8G
         maXIfNDgGmTEOaL5IC7UbaJpUvvgJRSkM7q6vsCd/Lj5wkvlJoONW44nW+bK7HFFL8rv
         RI4yfiOEHPxAYViyGsVzk1MHxELD8Qw7F9+I/uL0Q9qbyXUQkZJdkY4zVmSchEyHg91R
         NMAeTH0R7ShOtM5J+wxyj9tUTv1zhun70Xu7P994JBOA2B4Vf4v1upeeFQKC/YitGsHZ
         Qggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmG3r1mZsoVYs6QsuMg1BBRJC+fIBK1Gsm9c/gPZCvQ=;
        b=hWBNFl1Utvg2flXa0dn5xX9aDHX4zubITs6A8Vn1HjAARe3Uh9F7vcW8o5VXJcPRp4
         tuWuKrG1JvN0uS0tGrf/9ajOThaR8VsVqp9dqyE0Mg58j4Srb6I2fOE5LKVCW866HDe+
         Zax38/uEDIys+aGKM5GM2uZTHSCR62+Mr7RkZMhv6whaXYykJZbvjCzAbiSbQdZV70nz
         OKLksBhHshXemq1/jtL/SDuwJJ89i1ZalUMovnb4w0MXfJIfVtJoiAdHIQI81/6sRLIg
         RL2pRlwV+bdBe0TTDGKHRxeYWiCN6VHr/6WI6YEPDNfrmshVF3a91UNFMsAwCglhpDYH
         UKyg==
X-Gm-Message-State: AOAM532sLfZSYT7V0eGuSgOrxpKFxn2q5ga66k8gF0M8OiS+9zsSYGAu
        d6hZD2uQ4cHIQ3M+vTw5oK/Oeg==
X-Google-Smtp-Source: ABdhPJzNLqTQ0ZF1Gk+ntfeo51DuIfvr6hU33kAUNwB8sXvtjcrjTuyKjJ30vzcYy2TCS1mdmhm4tw==
X-Received: by 2002:a05:6512:11cc:b0:44a:5770:7425 with SMTP id h12-20020a05651211cc00b0044a57707425mr6363344lfr.406.1650721181764;
        Sat, 23 Apr 2022 06:39:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([94.25.228.223])
        by smtp.gmail.com with ESMTPSA id c21-20020a2ea795000000b0024ee0f8ef92sm544535ljf.36.2022.04.23.06.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:39:41 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] PCI: qcom: Fix higher MSI vectors handling
Date:   Sat, 23 Apr 2022 16:39:34 +0300
Message-Id: <20220423133939.2123449-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have replied with my Tested-by to the patch at [2], which has landed
in the linux-next as the commit 8ae0117418f3 ("PCI: qcom:
Add support for handling MSIs from 8 endpoints"). However lately I
noticed that during the tests I still had 'pcie_pme=nomsi', so the
device was not forced to use higher MSI vectors.

After removing this option I noticed that hight MSI vectors are not
delivered on tested platforms. After additional research I stumbled upon
a patch in msm-4.14 ([1]), which describes that each group of MSI
vectors is mapped to the separate interrupt. Implement corresponding
mapping.

Patchseries dependecies: [2] (landed in pci-next) and [3] (for the
schema change).

Changes since v1:
 - Split a huge patch into three patches as suggested by Bjorn Helgaas
 - snps,dw-pcie removal is now part of [3]

[1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
[2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
[3] https://lore.kernel.org/linux-arm-msm/20220422211002.2012070-1-dmitry.baryshkov@linaro.org/


Dmitry Baryshkov (5):
  PCI: dwc: Convert msi_irq to the array
  PCI: dwc: Teach dwc core to parse additional MSI interrupts
  PCI: qcom: Handle MSI IRQs properly
  dt-bindings: pci/qcom,pcie: support additional MSI interrupts
  arm64: dts: qcom: sm8250: provide additional MSI interrupts

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 14 ++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 11 +++-
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
 .../pci/controller/dwc/pcie-designware-host.c | 53 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
 10 files changed, 70 insertions(+), 22 deletions(-)


base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
prerequisite-patch-id: bfbbebbfd7a7f7acf46ddfa99da1cb259fbcf9e6
prerequisite-patch-id: dc9fc1a533b2ee58336b6af58546ec4ce4dc69d1
prerequisite-patch-id: d02abf52f065fee631769ed3362b5cba30c9b71e
prerequisite-patch-id: ade72962f2915faef888a605b322fbfb063009d7
prerequisite-patch-id: e7c1182f9dd63f4dec7f76b08f74b1b3152bf49d
prerequisite-patch-id: fe65300b2a281a148e079e4d8cecb6018475abd6
prerequisite-patch-id: 509ce8b6c53bc9426b6ffaaa63a4a64b221a8b18
prerequisite-patch-id: f459fbbb2cfb317b8c85701eefd8f7c9e1a55b34
-- 
2.35.1

