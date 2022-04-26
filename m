Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4415050FEC2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350853AbiDZNZH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350844AbiDZNZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 09:25:05 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB0F15737;
        Tue, 26 Apr 2022 06:21:57 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id EFACD5FBBE;
        Tue, 26 Apr 2022 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650979315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3MPG+xGmR4VMjoWP9SmdGX2PEI83rfYf+MZ3I3FUJrI=;
        b=gDHOiM3w+YaLFxLLc1F70fyqbPq93DIDUQzzsn/TEwBbqKfZc2s1wlBSzwaR28BRe1qmSb
        hUBPgzGEpH+idDN1yKP5VTHdpm1l5ck2rlPlaldXQ/DtKoExmkubxJQ5WK4rBCog0ewUO0
        6iRf3wiGhn+7BCRnZAASp/VZNDIJYQQ=
Received: from localhost.localdomain (fttx-pool-80.245.77.37.bambit.de [80.245.77.37])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id B7B49401C9;
        Tue, 26 Apr 2022 13:21:53 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [RFC/RFT v2 00/11] RK3568 PCIe V3 support
Date:   Tue, 26 Apr 2022 15:21:28 +0200
Message-Id: <20220426132139.26761-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 6ee0f1ac-3381-46d2-9e26-38a02835f5ee
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This series adds Rockchip PCIe V3 support found on rk3568 SOC.

It is based on "Enable rk356x PCIe controller" series of Peter Geis
v8: https://patchwork.kernel.org/project/linux-rockchip/list/?series=634925

Compared to PCIeV2 which uses the Naneng combphy, pciev3
uses a dedicated pci-phy.

This Version is still an RFC/RFT because i cannot only test PCIe-slot on R2Pro
as the other is a M.2 Key-E where i don't have any Hardware.

last 3 Patches show a replacement for bifurcation setting to make it more
useful for vendor-indepent lane-mapping.

Frank Wunderlich (11):
  dt-bindings: phy: rockchip: add PCIe v3 phy
  dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
  dt-bindings: phy: rockchip: add PCIe v3 constants
  phy: rockchip: Support PCIe v3
  dt-bindings: pci: add bifurcation option to Rockchip DesignWare
    binding
  PCI: rockchip-dwc: add PCIe bifurcation
  arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
  arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro
  dt-bindings: pci: add lane-map to rockchip PCIe binding
  PCI: rockchip: add a lane-map to rockchip pcie driver
  arm64: dts: rockchip: add basic lane-map and drop bifurcation from
    r2pro

 .../bindings/pci/rockchip-dw-pcie.yaml        |   3 +
 .../bindings/phy/rockchip,pcie3-phy.yaml      |  84 ++++++
 .../devicetree/bindings/soc/rockchip/grf.yaml |   3 +
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   |  79 +++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 122 ++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 ++
 drivers/phy/rockchip/Kconfig                  |   9 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 278 ++++++++++++++++++
 include/dt-bindings/phy/phy-rockchip-pcie3.h  |  21 ++
 include/linux/phy/pcie.h                      |  12 +
 11 files changed, 634 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
 create mode 100644 include/dt-bindings/phy/phy-rockchip-pcie3.h
 create mode 100644 include/linux/phy/pcie.h

-- 
2.25.1

