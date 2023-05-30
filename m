Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04B171693F
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjE3QZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjE3QZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 12:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD3E8;
        Tue, 30 May 2023 09:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F53562CD7;
        Tue, 30 May 2023 16:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E037C433D2;
        Tue, 30 May 2023 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463903;
        bh=ACMyBw8aBnxiwOn2sGNCuMmXFrRs+KzaneQ9BAek270=;
        h=From:To:Cc:Subject:Date:From;
        b=XvWvDIE1Ft9keSbeXqQfOI1P3L00zUknWIQdylE1nrnb9OynfjQ1ln8qoIgm3NPq0
         SZ73e2WlSLBQxQepWFJEQXhJcKghKsmYT+up9nc1PUj+i/vCthruVK1OAeqGQMn59e
         DCqaAQOp06jGCvqZpEUTM+TJ3suSTx1eCt+OEyB51GT9rfn8Fac54EFwMtN7SgugPW
         HGZFi9/ESXdojChhxxgPtL0fU/3o9t7x7QzZnhBbkx9/l/ekSeTzoHEl4/3g0AsQdD
         PRFE62cp5QePE2869nUSxvHX4PABXveEGgmdWNRDYKc5jsDqi0+lyxFGDW///XMW2C
         jNI4QCt2zJgzg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v3 00/15] Introduce the SC8180x devices
Date:   Tue, 30 May 2023 21:54:39 +0530
Message-Id: <20230530162454.51708-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This introduces Qualcomm SC8180x SoC which features in Lenovo Flex 5G
laptop. This also adds support for Primus platform as well as Lenovo Flex 5G
laptop.

Changes in v3:
 - Split DTS patch into smaller check
 - checkpatch and dtbs check error fixes
 - fix comments from Konrad/Krzysztof

Changes in v2:
 - Fix the ufs pcie and phy bindings
 - Lots of error fixes for dtbs_check
 - Add few more missing compatiables

Bjorn Andersson (3):
  arm64: dts: qcom: Introduce the SC8180x platform
  arm64: dts: qcom: sc8180x: Introduce Primus
  arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G

Vinod Koul (12):
  dt-bindings: PCI: qcom: Fix sc8180x clocks and interrupts
  dt-bindings: usb: qcom,dwc3: Add SC8180x binding
  dt-bindings: interconnect: split SC8180x to own schema
  scsi: ufs: dt-bindings: Add SC8180x binding
  dt-bindings: qcom,pdc: Add SC8180x compatible
  arm64: dts: qcom: sc8180x: Add interconnects and lmh
  arm64: dts: qcom: sc8180x: Add thermal zones
  arm64: dts: qcom: sc8180x: Add QUPs
  arm64: dts: qcom: sc8180x: Add PCIe instances
  arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes
  arm64: dts: qcom: sc8180x: Add display and gpu nodes
  arm64: dts: qcom: sc8180x: Add pmics

 .../bindings/interconnect/qcom,rpmh.yaml      |   11 -
 .../interconnect/qcom,sc8180x-rpmh.yaml       |   49 +
 .../interrupt-controller/qcom,pdc.yaml        |    1 +
 .../devicetree/bindings/pci/qcom,pcie.yaml    |   29 +-
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |    2 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml    |    3 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  |  583 +++
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |  326 ++
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts   |  706 +++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         | 4030 +++++++++++++++++
 11 files changed, 5730 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x-primus.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8180x.dtsi

-- 
2.40.1

