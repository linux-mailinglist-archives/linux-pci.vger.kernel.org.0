Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AD6A1AC8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBXLAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 06:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjBXK7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 05:59:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A863DD7
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:16 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h14so16492646plf.10
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nUiMlzdFVdylVAwvGF2mzTH+MQ8jxdhSSAuOwiDOrk=;
        b=sD8fpV1iBm1gOL4hX7ssWFPYQXWuJgQM8zfQlrHHNH7z4u/zl+ABhh3jZ9pqJ1wVj0
         B2vre9cVycIC8F/bA4JpHy3L9p4kxWrr1DAGUo7LNSZeIlOGA68QahK65J/W34IjD4aW
         txEgU8+p3DQaH/gFVaGvmVbba0SofD0L49Z23g3ywpEmWZsyv99YcS/9RAAx3P+/BAYa
         J/Nxq3++RIozCHDwOm+WIHfuEA/Ji7ud0cjY/xYFjubCxZLu9QA2Lka1F4jxN5LMG7iN
         ZMFlit9zuVRtpx0vpb19qfbkT/3YkzQLseDNNBRnD7eNE1tIH/lS1VoNnOoHCkiCweTA
         hV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nUiMlzdFVdylVAwvGF2mzTH+MQ8jxdhSSAuOwiDOrk=;
        b=1DyDtupTGOagDOQ0VXdVi2MskAJZVUJKmZCx1+M62inXQShLdGNbQpbDp9zBpOzjHp
         GgSctHaTSeMmu9cYpmu1ojZOLDAKiXdpEmOOm+yk8nQs55YjIdEUlGMUKNTj3XOfP7Re
         fdKTVHZQ7NgoIFkc/TBeBfdodaYp4cuTOogkujYM/buJxDGpIvOGkKUhZV/D10ohFGkw
         RqfMWgspedkyAX6fMtt2dhxyu05kcdkl5oKbVk0K8FAF16rig90omZPNer27AIlaOBtR
         /+wWNgEktGOjvarKFa6ALwa4KbA0FkdAo/yLYRN92RPWOZ2RBqh1XMJi09UDaX7RwJDT
         VT7Q==
X-Gm-Message-State: AO0yUKVWFBUReF9KYJc7whEQFvToy3Q4hLgfzJSSSbgknBq1xIpROYcX
        yuxYiKiubCVL54lSIyo5Gyv4d04CYv2MqKE=
X-Google-Smtp-Source: AK7set/S+ZygCYuCUKF9LEBR1rJYfsKfJShN1QO28O1CvLDthNfwy1uzHl2p2i6zudrTi6g/rOYYrw==
X-Received: by 2002:a17:90b:388f:b0:234:6b7e:d016 with SMTP id mu15-20020a17090b388f00b002346b7ed016mr15132219pjb.22.1677236355675;
        Fri, 24 Feb 2023 02:59:15 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/13] Add PCIe RC support to Qcom SDX55 SoC
Date:   Fri, 24 Feb 2023 16:28:53 +0530
Message-Id: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Changes in v2:

* Added patche to move status property down
* Added patch to list property values vertically
* Addressed comments from Konrad
* Collected review tags
* Fixed review tag for dts patch

Manivannan Sadhasivam (13):
  dt-bindings: PCI: qcom: Update maintainers entry
  dt-bindings: PCI: qcom: Add iommu properties
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
 .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 +++-
 arch/arm/boot/dts/qcom-sdx55-t55.dts          |  53 +++++-
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   |   2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi             | 179 ++++++++++++++----
 drivers/pci/controller/dwc/pcie-qcom.c        |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      |  91 +++++++--
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h    |   2 +
 8 files changed, 303 insertions(+), 65 deletions(-)

-- 
2.25.1

