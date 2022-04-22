Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E650C2A4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiDVWT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiDVWSY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:18:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C0E24E904
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q22so11054992ljh.10
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gfbcYi90VHSh39P/bZzk6rssopLYBjtF7uMGAekry8=;
        b=kmyYVf+hNaqkYZIdCB9r+E6Ffly6R3kC5X/i4Rp2F5t+42EplGPh+eFoyhQwIMHBWk
         g5oIJuU/OxwalyZBaxh+tioQFgodAfCR+B7oXMca7NfZPUtRzIMq80R2bLiFyKpHRFjY
         Fg3FF+mFSFOupfzQf30iAj2GmvGwug+zGPywpiDJ/DpVMnzn/KGfSMZMXSqlzEfRo3Km
         RJFwVvZb5+rI8PyR0plijIU56k812T+utXiBGyveWQwFHIK+MR/aQd8y01B106iBcMwo
         px2URkrtswH65ZE5YxxyGPVDUE49rpXLSRGC5j+vic8+HFpadGAhAM1Iit5gLiI5DEb3
         W85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gfbcYi90VHSh39P/bZzk6rssopLYBjtF7uMGAekry8=;
        b=xDQLkzyJdU2sIMC/Vlj8BrvAdgzAQ41eupNItGtj9bzK0pPk4h8/MKk3MY5GBFYdP8
         2GtzhfUPUF66CzCU7rR1zEqBViFjO9pC65DCKOQpvouqzjpZAZ898PBwGzgMqFPNUxcZ
         tjicDl2Et8a+CGNi1KzmtUjBJSQlQUoIPHSlq+46M5NFTHPCJMF75sMChKmuVvRq4yiI
         vp1b8tpco4T1mwgUzUwXlUxNQgfto7/nTFbwlHpn/x9Hk/KXjNj0izQo3mKnBVgs1D1J
         RANwsOo6A3zW7ZfIKGhYofLOGfiwrt7NTGImgAtM1zLGj0rea4Sl76FFWjSjuuhZj+zz
         EA4Q==
X-Gm-Message-State: AOAM533qqaQI2K6aDeFWfEal8Yha7dplo0r3VQ6T54eBwtb9+//xGZul
        zDFprm4Q4sI8JymsCiyYOqylNQ==
X-Google-Smtp-Source: ABdhPJxSfkHVJ07KB73M5FjvXpYMsfOskLEEeoTTneKBUKR2b5pgjXJTWVhoXxyiVJSdh4X/o0t/rg==
X-Received: by 2002:a2e:94ce:0:b0:24b:3811:b242 with SMTP id r14-20020a2e94ce000000b0024b3811b242mr3898143ljh.197.1650661804677;
        Fri, 22 Apr 2022 14:10:04 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24d46000000b0046bb728b873sm351240lfp.252.2022.04.22.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:04 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/7]  dt-bindings: YAMLify pci/qcom,pcie schema
Date:   Sat, 23 Apr 2022 00:09:55 +0300
Message-Id: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
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


Dmitry Baryshkov (7):
  dt-bindings: pci/qcom,pcie: convert to YAML
  dt-bindings: pci/qcom,pcie: resets are not defined for msm8996
  dt-bindings: pci/qcom,pcie: add schema for sc7280 chipset
  arm64: dts: qcom: stop using snps,dw-pcie falback
  arm: dts: qcom: stop using snps,dw-pcie falback
  arm: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
  arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios

 .../devicetree/bindings/pci/qcom,pcie.txt     | 397 -----------
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 634 ++++++++++++++++++
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
 21 files changed, 666 insertions(+), 429 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml

-- 
2.35.1

