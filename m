Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582366B00FF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCHIZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCHIYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:24:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70113580CB
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 00:24:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y2so15831663pjg.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 00:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osj1SKW6kZ1T93ajN37jlKR7h51v+fvQYy/hH2nwHc8=;
        b=VewtrsHjftHPXayimBaLVs/TwnICwIS7DwMkz3opd126q+y3jtCz4OhpG8/hHPqtEJ
         fH+moNKb5ymPsiGbzq8UAbk0n6vxE44/qghRFfCpi8/0ONfqmfXMj0x/2vC4RHiXu6Cj
         DJEuz44r4xTDmHlNVk81wcT8/A1QvUUYcQ25ZTCzboEfE4SQ5a25Pj3x5lhvY6b00cwJ
         nU+XPXPPMJJukvCQBdNav1ZSeWICeXBI/13uVYGwmmPvaad/iZJIQAYSYDfzPjYyMBaQ
         3MQOcY+x/JIplYc4d62V2dgo0I00g+OQZZRa8ks0UurBKwYAdpxGesAba+qGWdqi4okh
         CWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osj1SKW6kZ1T93ajN37jlKR7h51v+fvQYy/hH2nwHc8=;
        b=Kd6n6BJZ8lOF26/UhFT5ulLe6SoYqgkZpLjRt5JZm0YNw53F3s6QsxJeTFXFlzkAPt
         xpajkQ25KWrqBOAoSUNGRnG8avOwWJHSbNic2IJcZWEfT3cJvZifULlj9ynHbnvlJ6cR
         jLYjhC+HstMh6o+gIDekm8/WpzM8egVUN8etfGSe0zobVC58aCg+0wRDYromn5UCqNJ7
         mRP2oDWY7ihSVuNXs+k7nBxbMEM7kHhI28H/dX4wFX32zAmACBwzPUR2Nmg+iK8YgyeT
         /JAoghrcE53DKjXDc+G8lgvUJN05cyU2ZFJ3IUjPrxqGontpqsOK/ZgxC6OqOEFLEjfx
         ZjDQ==
X-Gm-Message-State: AO0yUKXH/X+8wwZVtKonoruA9gkGR60CcrWOGfWuv7SovtlO5mKQlClW
        WciEV9O4lWET18JV5rsRatdA
X-Google-Smtp-Source: AK7set8JlGASTjjTyOz8omjowBwQoY5LeKSQuohvDNUO3uchr/1Qz30dXPwyx7GO4AmhLSqJRoogxQ==
X-Received: by 2002:a17:902:ab8e:b0:19d:1a9c:34dd with SMTP id f14-20020a170902ab8e00b0019d1a9c34ddmr13479566plr.17.1678263871779;
        Wed, 08 Mar 2023 00:24:31 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:24:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/13] Add PCIe RC support to Qcom SDX55 SoC
Date:   Wed,  8 Mar 2023 13:54:11 +0530
Message-Id: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Hi,

This series adds PCIe RC support to the Qcom SDX55 SoC. The PCIe controller
in SDX55 can act as both Root Complex and Endpoint but only one mode at a
time i.e., the mode cannot be switched during runtime.

This series has been tested on Thundercomm T55 board having QCA6390 WLAN
chipset connected to the PCIe controller. For powering up the WLAN chipset,
an out-of-tree patch has been used since we do not have a proper driver in
mainline to handle the power supplies.

NOTE: Even with this series, I couldn't get network connectivity using
QCA6390. But that's due to ath11k regression for which I've filed a bug
report: https://bugzilla.kernel.org/show_bug.cgi?id=217070

Merging strategy
----------------

PCI and binding patches through PCI tree
PHY patches through PHY tree
Devicetree patches through Qcom tree

Thanks,
Mani

Changes in v3:

* Removed "iommus" property from binding and dtsi file
* Fixed the PCIe I/O range
* Rebased on top of v6.3-rc1
* Collected reviews

Changes in v2:

* Added patch to move status property down
* Added patch to list property values vertically
* Addressed comments from Konrad
* Collected review tags
* Fixed review tag for dts patch

Manivannan Sadhasivam (13):
  dt-bindings: PCI: qcom: Update maintainers entry
  dt-bindings: PCI: qcom: Add iommu-map properties
  dt-bindings: PCI: qcom: Add SDX55 SoC
  dt-bindings: PCI: qcom-ep: Fix the unit address used in example
  ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node
  ARM: dts: qcom: sdx55: Rename pcie0_{phy/lane} to pcie_{phy/lane}
  ARM: dts: qcom: sdx55: Add support for PCIe RC controller
  ARM: dts: qcom: sdx55: List the property values vertically
  ARM: dts: qcom: sdx55-t55: Enable PCIe RC support
  ARM: dts: qcom: sdx55-t55: Move "status" property down
  phy: qcom-qmp-pcie: Split out EP related init sequence for SDX55
  phy: qcom-qmp-pcie: Add RC init sequence for SDX55
  PCI: qcom: Add support for SDX55 SoC

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml    |  32 +++-
 arch/arm/boot/dts/qcom-sdx55-t55.dts          |  50 ++++-
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   |   2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 178 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-qcom.c        |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  91 +++++++--
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h    |   2 +
 8 files changed, 297 insertions(+), 64 deletions(-)

-- 
2.25.1

