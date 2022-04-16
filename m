Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B84503704
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiDPOLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiDPOLf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 10:11:35 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CCB15FED
        for <linux-pci@vger.kernel.org>; Sat, 16 Apr 2022 07:09:03 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id 536B65FB56;
        Sat, 16 Apr 2022 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650117331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c7cLwYkQx+UgcFCUSlE8PMzw+TTvuN7Xap07GmrtOwQ=;
        b=td7K6Qu3lBEpcA31PRIpEJ/SDJbnn+2Fr8UO1kYI18UixmbBzbbi1z8+tliEaQbVoVY0EE
        UA2BrAqn+8fORt9+Iv3kW5i+qz+yC1SCrjSvTxi4qRTxkRVqgmCV1nRIhFkwtilG7dQ9U5
        DKCijIQ5eFeOEgrefYx1siXQgYwy0/k=
Received: from localhost.localdomain (fttx-pool-217.61.150.108.bambit.de [217.61.150.108])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id CA4D51005BA;
        Sat, 16 Apr 2022 13:55:29 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC/RFT 0/6] RK3568 PCIe V3 support
Date:   Sat, 16 Apr 2022 15:54:52 +0200
Message-Id: <20220416135458.104048-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b85ff0f6-efa2-44a0-8e44-ec2828455f06
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This series adds Rockchip PCIe V3 support found on rk3568 SOC.

It is based on "Enable rk356x PCIe controller" series of Peter Geis
v7: https://patchwork.kernel.org/project/linux-rockchip/cover/20220416110507.642398-1-pgwipeout@gmail.com/

Compared to PCIeV2 which uses the Naneng combphy, pciev3
uses a dedicated pci-phy.

Frank Wunderlich (6):
  dt-bindings: phy: rockchip: add pcie3 phy
  dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
  phy: rockchip: Support pcie v3
  PCI: rockchip-dwc: add pcie bifurcation
  arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
  arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro

 .../bindings/phy/rockchip-pcie3-phy.yaml      |  77 +++++
 .../devicetree/bindings/soc/rockchip/grf.yaml |   2 +
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   |  79 +++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 122 ++++++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  11 +
 drivers/phy/rockchip/Kconfig                  |   9 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 278 ++++++++++++++++++
 include/dt-bindings/phy/phy-snps-pcie3.h      |  21 ++
 include/linux/phy/pcie.h                      |  12 +
 10 files changed, 612 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
 create mode 100644 include/dt-bindings/phy/phy-snps-pcie3.h
 create mode 100644 include/linux/phy/pcie.h

-- 
2.25.1

