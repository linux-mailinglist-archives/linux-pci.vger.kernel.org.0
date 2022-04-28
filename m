Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D05132AD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345687AbiD1Low (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 07:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbiD1Loq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 07:44:46 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC666FBC
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l19so6321173ljb.7
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFeP+wlMs5f/su3ORobrj/Yy4MoRl+estrIOSgCRy3g=;
        b=RW45UfHESE5ZFvbky9okdlnqsq/i92EOulvsvfMbQpBOXR1g5AcRaIu43Yrmt42Jr+
         naaYud7S/Xe9O/7Cwn2Sy2UWQC9l7PKSsagKDIzVgBzxvbiAw6vhFMBg4q/yqfw8q88d
         Z9PsooeyDHxFfPwrsfY7HVCjxSTK7qgjGrzoYb0y13svmsdENtAQqAxab0gcRO067aEL
         NN2nLSqZ8DP41bkaM+KzZbjyJ8H0LSt1CJhWBFwnyxRP4DwCz0GYoOJTAvyLxBiRrLPu
         AkzbSHu63vzzpey00H/uGz+F9d3Vr0tz7Ca9Guh9ze/OZ+7JyoYIjkxByoHJalH4IqHf
         uJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFeP+wlMs5f/su3ORobrj/Yy4MoRl+estrIOSgCRy3g=;
        b=YyWZ03rPFqhWtqdgdnJ8ci5xI+7wS2q5EbgwjVIPjA2RIG6PuqE16OCurDOyFiVPC+
         yUKs1LHXvJYJhOSblE+msqCVQIEuRcJh2mDCj0WKYVa7jZpli0NapmDGiQ/PAAPmnKaJ
         8TSuV3ZuE+Gkex4rVYtMMACjC1p8BZBZOeDtQ7W0J/VrGE9VvNuf69egULoyVE+24jyr
         t0x0yXg/9LVnKPK0ETCwqf0CbtPdOxWxo/Dn//LljLokoGtdO83Z6Mi+qkMaMB/VaT9h
         DXzlaA99h08noBytYqT37k5x2wJlA2sETME44k6sBc2lNyykRlW8vm5/9nxKrzi+9FFd
         HoqQ==
X-Gm-Message-State: AOAM533Yal89s8gT3palquaQHs+tyW7nk8QeMdGz7fY8AmPyT0yTq3He
        LVt8CCYefltHYBvb8F/nxMaTvQ==
X-Google-Smtp-Source: ABdhPJwpJf149dDvtvWmWu01QdboGQZWM/jCTA2QtpsIYK/1TsBM2tKKhszXtS5uLm7ph9fQZLIgSw==
X-Received: by 2002:a2e:b6d3:0:b0:24f:3144:6349 with SMTP id m19-20020a2eb6d3000000b0024f31446349mr1982733ljo.50.1651146074869;
        Thu, 28 Apr 2022 04:41:14 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm2338790lfb.302.2022.04.28.04.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:41:14 -0700 (PDT)
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
Subject: [PATCH v4 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
Date:   Thu, 28 Apr 2022 14:41:05 +0300
Message-Id: <20220428114113.3411536-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert pci/qcom,pcie schema to YAML description. The first patch
introduces several warnings which are fixed by the other patches in the
series.

Note regarding the snps,dw-pcie compatibility. The Qualcomm PCIe
controller uses Synopsys PCIe IP core. However it is not just fused to
the address space. Accessing PCIe registers requires several clocks and
regulators to be powered up. Thus it can be assumed that the qcom,pcie
bindings are not fully compatible with the snps,dw-pcie schema.

Changes since v3:
 - Rebase on linux-next to include sm8150 patches

Changes since v2 (still kudos to Krzyshtof):
 - Readded reg-names conversion patch
 - Mention wake-gpio update in the commit message
 - Remove extra quotes in the schema

Changes since v1 (all kudos to Krzyshtof):
 - Dropped the reg-names patch. It will be handled separately
 - Squashed the snps,dw-pcie removal (from schema) into the first patch
 - Replaced deprecated perst-gpio and wake-gpio with perst-gpios and
   wake-gpios in the examples and in DT files
 - Moved common clocks/clock-names, resets/reset-names and power-domains
   properties to the top level of the schema, leaving only platform
   specifics in the conditional branches
 - Dropped iommu-map/iommu-map-mask for now
 - Added (missed) interrupt-cells, clocks, clock-names, resets,
   reset-names properties to the required list (resets/reset-names are
   removed in the next patch, as they are not used on msm8996)
 - Fixed IRQ flags in the examples
 - Merged apq8064/ipq8064 into the single condition statement
 - Added extra empty lines


Dmitry Baryshkov (8):
  dt-bindings: pci/qcom,pcie: convert to YAML
  dt-bindings: pci/qcom,pcie: resets are not defined for msm8996
  dt-bindings: pci/qcom-pcie: specify reg-names explicitly
  dt-bindings: pci/qcom,pcie: add schema for sc7280 chipset
  arm64: dts: qcom: stop using snps,dw-pcie falback
  arm: dts: qcom: stop using snps,dw-pcie falback
  arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
  arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios

Dmitry Baryshkov (8):
  dt-bindings: pci/qcom,pcie: convert to YAML
  dt-bindings: pci/qcom,pcie: resets are not defined for msm8996
  dt-bindings: pci/qcom-pcie: specify reg-names explicitly
  dt-bindings: pci/qcom,pcie: add schema for sc7280 chipset
  arm64: dts: qcom: stop using snps,dw-pcie falback
  arm: dts: qcom: stop using snps,dw-pcie falback
  arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
  arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios

 .../devicetree/bindings/pci/qcom,pcie.txt     | 398 ----------
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 714 ++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts   |   2 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts    |   2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi           |   2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi |   2 +-
 .../boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts    |   2 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |   2 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |   6 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   |   6 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts     |   4 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi    |   4 +-
 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    |   4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   6 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |   2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |   2 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |   2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   4 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   6 +-
 21 files changed, 746 insertions(+), 430 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml

-- 
2.35.1

