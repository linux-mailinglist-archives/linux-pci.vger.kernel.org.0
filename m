Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E27B5156CB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 23:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbiD2VeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 17:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbiD2Vd5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 17:33:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244023EF10
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:30:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so16166366lfa.10
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=goa3USIzgFnot/RzMg+KWOHUx1cjO1GVqQ9lvgA7QVI=;
        b=UlB8vM9+Nr9fDFu1FF73XowN1h/9tE5MLV0bfuzOJw6vYJdGxyyr6CxZ4X9fHfvqUE
         JwZIkg67HpS+Cq2HpEab/jGXgYUt7YZ6hB9biQwQWCcxULuIfFJKSU4our1xpPRVZlNj
         5pS85Fv6+7bg3+USVeGUkPfkpEz4pNIOvSXZnnaIQjxQB8iVjtRzzg7U9NBc9P0OQVk/
         znvOBhBEZXZJMO6oIk9Mxx0kzppYfexAt9MFd/iI1ipHkRLFWihHwB56RkIpCA6wDk6U
         sbtP9jO3ToH4ewp8u0Me7Oq6aCAVeZVyxR7nocvJp3oFLGsBpLC4PQUHsGVp3HlT5SrF
         nTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=goa3USIzgFnot/RzMg+KWOHUx1cjO1GVqQ9lvgA7QVI=;
        b=kF09S7PO6pQRBkS7K7UQBX8620IVKUlq4TsXMHQL5qsbTgGK+vLH1qiSSn8uqUHizZ
         mUQj5lZw12Xp9+BAfoInMi05eUwmgP2J97mXnJrRhYq9UBrQh8gxhv++48e+6KeswGbb
         jRud3yBS68bkqLak9RJWqTo7yMP5S9Qjz+NUNwPqouTDYFM5MCeKJ1hTse2a1MOPzGG4
         SBtdkNqXUUcnGWbKleDs4EQ+QRQpd+W2mo2wpapAaFeyuKBCUvBazbndBBeodwm28tSc
         spqRHXhGR0Yh7YWDXW/k3DmbisKu13Lq4YUW//FSj3PsO+d2OdhpXQIktvGYIW2Tbni7
         6yYA==
X-Gm-Message-State: AOAM531OhD9QRpsNYNxN5keNCtt3C4aMZQzvM01RnDNaTs//FWkqqIiY
        WxpKrmlPyGDZFAH1whJomVNZmg==
X-Google-Smtp-Source: ABdhPJwxFrwsTBtG79yMlexgdeDvXhoOVELN19WahCoWMSMJiQ9G7MAXRG0fib3o1D+azVPXNmyHLQ==
X-Received: by 2002:a05:6512:322a:b0:472:7d2:1114 with SMTP id f10-20020a056512322a00b0047207d21114mr839868lfe.105.1651267833277;
        Fri, 29 Apr 2022 14:30:33 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 11-20020ac2568b000000b0047255d21182sm28589lfr.177.2022.04.29.14.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:30:32 -0700 (PDT)
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
Subject: [PATCH v5 0/8] dt-bindings: YAMLify pci/qcom,pcie schema
Date:   Sat, 30 Apr 2022 00:30:24 +0300
Message-Id: <20220429213032.3724066-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes since v4:
 - Change subjects to follow convention (suggested by Bjorn Helgaas)

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
  dt-bindings: PCI: qcom: Convert to YAML
  dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
  dt-bindings: PCI: qcom: Specify reg-names explicitly
  dt-bindings: PCI: qcom: Add schema for sc7280 chipset
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

