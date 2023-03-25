Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630AB6C8DFD
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 13:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCYMY7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 08:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCYMY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 08:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656AC2;
        Sat, 25 Mar 2023 05:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC6AA60C48;
        Sat, 25 Mar 2023 12:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334BAC433D2;
        Sat, 25 Mar 2023 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747097;
        bh=1dklbVwFwR0zhMisSmK0/9gJpIfc7bnmRJm4tVTpEP4=;
        h=From:To:Cc:Subject:Date:From;
        b=kq+hukc6ikZx9SJzvxhdssupIjoLs/fpTfE4xWR1GCUAQf+ej4+CZPJ6As1nBx/Np
         LnTe6uwtqRqgrBX8wcFx7iA8t9RlLfsrIhHjEF5zws5SH1BNQEw5/apXO7k4iKqEPN
         Uy7pV/q9o/Dh1UqRs27VBKuLeF+QbeTJYbTLOInceRv5Os9TizexZ9yXkIxh/nxT68
         rKRgc/2/r6fPkD5tZD46tl9Fnb/ND04aN/xOju7u135zEC1uc4Nn4GKbm+20O4KZKj
         8x3BBE8d1WSRsffNs0PUWyactCPqtrXyQxPNcfK3Mi5YCLhNVrOxR7Sfku/eXrUcvl
         Io5wExRlyhzbw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 00/12] Introduce the SC8180x devices
Date:   Sat, 25 Mar 2023 17:54:32 +0530
Message-Id: <20230325122444.249507-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This introduces Qualcomm SC8180x SoC which features in Lenovo Flex 5G
laptop. This also adds support for Primus platform as well as Lenovo Flex 5G
laptop.

I would be great if submaintainers can ack the binding patch so that
everything can go thru qcom tree

Changes in v2:
 - Fix the ufs pcie and phy bindings
 - Lots of error fixes for dtbs_check
 - Add few more missing compatiables

Bjorn Andersson (3):
  arm64: dts: qcom: Introduce the SC8180x platform
  arm64: dts: qcom: sc8180x: Introduce Primus
  arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G

Vinod Koul (9):
  dt-bindings: firmware: document Qualcomm SC8180X SCM
  dt-bindings: PCI: qcom: Document sc8180x properties
  dt-bindings: phy: qcom,qmp-pcie: fix the sc8180x regs
  dt-bindings: usb: qcom,dwc3: Add SC8180x binding
  dt-bindings: interconnect: split SC8180x to own schema
  scsi: ufs: dt-bindings: Add SC8180x binding
  dt-bindings: phy: qcom,qmp-ufs: fix the sc8180x regs
  regulator: dt-bindings: qcom,rpmh: Add compatible for PMC8180
  dt-bindings: qcom,pdc: Add SC8180x compatible

 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../bindings/interconnect/qcom,rpmh.yaml      |   11 -
 .../interconnect/qcom,sc8180x-rpmh.yaml       |   76 +
 .../interrupt-controller/qcom,pdc.yaml        |    1 +
 .../devicetree/bindings/pci/qcom,pcie.yaml    |   49 +-
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |    2 +-
 .../phy/qcom,msm8996-qmp-ufs-phy.yaml         |   18 +-
 .../regulator/qcom,rpmh-regulator.yaml        |    4 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |    2 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |    2 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  |  590 +++
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |  326 ++
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts   |  706 +++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         | 3950 +++++++++++++++++
 15 files changed, 5709 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-primus.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x.dtsi

-- 
2.39.2

