Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BA86B3529
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCJEIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCJEIf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:08:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5D5CC08
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:08:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c4so2905058pfl.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m47cP73h9+tUW+X/2AFChPVWpE3J+7t5tQOf5sCuZMY=;
        b=YyX4jWg+rcUcstIwvR5IvhqxffkzI8Ddp7NSv8c32jRCVzxOJVgnn8ecnxhD0drOH3
         4sav29wg90Y7fwNMsJTekCsPSsKw6UBYtXnpfpiTFoICmJ/2S4MNUxQp9oWuAlyAW7bQ
         qAH9XJVoeyb4vxqzYHFoPUqPBbLRdmSRFfKrmSzNBy2YLtjv5p3fJP7X35l5evUU9XUJ
         bKLvB5JTpVDaW9016zEbuby+PGTULPlTiJY/yWWzTvVGg5zHA0MZaPd75C/86RsWOIGK
         CDm3M8D6HRO6DhkfVgIIelOuYB84imOlomPnIEVj73j0lk4DrS9l0BR+ZHfCZSzTiMnW
         ZWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m47cP73h9+tUW+X/2AFChPVWpE3J+7t5tQOf5sCuZMY=;
        b=Dtj6zTLQkllTjwZ4nHEi6Zi9BMlJSFPidPax6OrWNltOZ+Tie1ilu+MGBr7ZBnSTFE
         4u8vXfp6L1qpSZXRCyiAqH3zXNc/EMWEQoIBLaDDdyZSVPZRm2gKay/hkkOF19yAOmzd
         08pnXJjYactuU96aUuWo+jO/C0PvJI9Kxlmx6pXeyV8nFMSG+d3uzDcfOgP9uIc3tyRP
         tYpMOyyHgUNdVdyWuzXRZdeCKq5xqsq/UAHv/xOCe1N+ZbPSsVytm4cUyXBd57MqZQC0
         K8zUaNkz5hxlxmG+cgL1M2yFkl3PAoe6X4HEf3398Vpt4b2l9E1oqCtJnLDRlS0c8eEt
         KVQw==
X-Gm-Message-State: AO0yUKVuj/fMXpJOoQm/UabueTgT7f3CBUBBK+om4B3rkeRZ+E6XPb7C
        EX2bDrN8q75CU2ZdaVb/j0Uw
X-Google-Smtp-Source: AK7set/32j7o7G44kWqbpgKKUoS2UtFz1ybDGITTi3UKQ2X+vyQRm4QGYb2NpsBlRsy9VRiQfmSQoQ==
X-Received: by 2002:a62:18c1:0:b0:575:b783:b6b3 with SMTP id 184-20020a6218c1000000b00575b783b6b3mr18221453pfy.28.1678421311266;
        Thu, 09 Mar 2023 20:08:31 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:08:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/19] Qcom PCIe cleanups and improvements
Date:   Fri, 10 Mar 2023 09:37:57 +0530
Message-Id: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
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

This series brings in several code cleanups and improvements to the
Qualcomm PCIe controller drivers (RC and EP). The cleanup part mostly
cleans up the bitfield definitions and transitions to bulk APIs for clocks,
and resets. The improvement part adds the debugfs entries to track link
transition counts in RC driver.

Testing
-------

This series has been tested on SDM845, SM8250, SC8280XP, IPQ4019 based
platforms.

Merging Strategy
----------------

Binding and driver patches through PCI tree and DTS patches through Qcom
tree.

NOTE: For the sake of maintaining dependency, I've clubbed both cleanup and
improvement patches in the same series. If any of the maintainers prefer to
have them splitted, please let me know.

Thanks,
Mani

Changes in v3:

* Introduced init_debugfs callback for defining the debugfs interface specific
  to IP versions
* Added a debugfs patch for v2.4.0
* Added a patch to rename qcom_pcie_config_sid_sm8250() function
* Added tested-by for patch 11/19

Changes in v2:

* Moved the "mhi" region to last in the binding and dtsi's
* Dropped the patches renaming the "mmio" region

Manivannan Sadhasivam (19):
  PCI: qcom: Remove PCIE20_ prefix from register definitions
  PCI: qcom: Sort and group registers and bitfield definitions
  PCI: qcom: Use bitfield definitions for register fields
  PCI: qcom: Add missing macros for register fields
  PCI: qcom: Use lower case for hex
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.1.0
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 1.0.0
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.2
  PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.3.3
  PCI: qcom: Use bulk reset APIs for handling resets for IP rev 2.4.0
  PCI: qcom: Use macros for defining total no. of clocks & supplies
  PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version
  dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
  arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
  arm64: dts: qcom: sc8280xp: Add "mhi" region to the PCIe nodes
  PCI: qcom: Expose link transition counts via debugfs for v1.9.0 &
    v2.7.0
  PCI: qcom: Expose link transition counts via debugfs for v2.4.0

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   12 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   25 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   10 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   15 +-
 drivers/pci/controller/dwc/pcie-qcom.c        | 1200 +++++++----------
 5 files changed, 521 insertions(+), 741 deletions(-)

-- 
2.25.1

