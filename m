Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD250D1EB
	for <lists+linux-pci@lfdr.de>; Sun, 24 Apr 2022 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiDXNXj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Apr 2022 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiDXNXi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Apr 2022 09:23:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FAA1AA
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w1so21906262lfa.4
        for <linux-pci@vger.kernel.org>; Sun, 24 Apr 2022 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqL8llnX3k0LZEaNoV5Vdp4GgnVXzeumqjyslS75z/E=;
        b=JnLsqtwkHiLjRESz7QrLyUFNZUlpCWj8oqPRifj8JkNSJOXmOYtIQUrOpG71enpV5A
         FwAj91k2+wAimqiqtHbBruV1ROVdnQf7wWEk/5WuFm1CKhz3V7dDrJ6WWjitMX56TyeB
         FlWAJjVumDcrKa+VZeVXebajSJppajnmBahYWjyH6FbnHvSRCDaTrnItqIgrcXkdIOpO
         2TlyDBK1jZP1r3pnkglZQY5FWmejjgngo7xFRSvZN2d3uJ+cw05h2jyqfpTdiJveOdBc
         AjZKuySC7vzN0IYjQ4NL2CjfKFi66cUxRsKvLz1Ffv3kCpVRlXrYzqRVH9w/ZKWtvL8e
         vrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqL8llnX3k0LZEaNoV5Vdp4GgnVXzeumqjyslS75z/E=;
        b=tW8WjvLEqlHlfZND12DRXO6kqqgXRd6+gRHe76/6OHhl+TJ+obK8wSG5aZ7uuR84h8
         7HYxVM/FaAvcU6wsbK2eJ9ilf09qdy6nFMED89NQdu/Xd2iDHHXP1APUA43xDsKgTedv
         9JJkSTAteklHBGDAQxCfrKscu/7COqdIcQh6yR7YtIfrTe39hYvt0uPhDLQntGy21m5s
         e+pTW5KCmJ9Wc+dtneqvndH+av0/4co9s5SuuOwQJ0pnxJd4+3yDYrMGFa7Tiq/CYHXP
         PQBvFD5w9/uDq324j/c84W9+X07ZjmG3gRtLIjMn5e5VbPK50TAk6UHfko2fAyHfdUvF
         urSA==
X-Gm-Message-State: AOAM530cSiP6ckvY3mlfLuoU6xszYc9lSpJd3NODdwyEIh0JDzoCAZh9
        EisuTFSs28xpLcl6g9W/wvo7BQ==
X-Google-Smtp-Source: ABdhPJxVgUpCgkcu1XNcQuQ0HsmEBuh3pEQZ+YwTsCZvGR1Lo4iwqswy+yD0kN/PtrHU7QSlW8lruQ==
X-Received: by 2002:a05:6512:2009:b0:471:ffee:6ee1 with SMTP id a9-20020a056512200900b00471ffee6ee1mr2392821lfb.268.1650806435703;
        Sun, 24 Apr 2022 06:20:35 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id l12-20020a056512332c00b0046d0e0e5b44sm1015877lfe.20.2022.04.24.06.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:20:35 -0700 (PDT)
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
Subject: [PATCH v3 0/8]  dt-bindings: YAMLify pci/qcom,pcie schema
Date:   Sun, 24 Apr 2022 16:20:26 +0300
Message-Id: <20220424132034.2235768-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

 .../devicetree/bindings/pci/qcom,pcie.txt     | 397 ----------
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 712 ++++++++++++++++++
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
 21 files changed, 744 insertions(+), 429 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml


base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
-- 
2.35.1

