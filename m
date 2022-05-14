Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67D5270E4
	for <lists+linux-pci@lfdr.de>; Sat, 14 May 2022 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiENMAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 May 2022 08:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiENMAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2022 08:00:01 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740983;
        Sat, 14 May 2022 04:59:58 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id F10191007E5;
        Sat, 14 May 2022 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1652529596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jp8Teq4Isc+9gmZReRzppDgzK1yE9IJ/3uRsTw6ryLw=;
        b=oCp832NTVPSaEBRhBlPm8aZYMaEUSpQPU/3kx6pVPlYzmwxzuydQkVam2N3UHmA7WayaLP
        386fK61d5ybZKWQhuwRJCw6PQnrjGPWO1rVJNW169kEYrOA2UhSI+6vmcW2QzTkGXKt9Nr
        3yaSAdNYIG7ojFg4fXLYuLl69NgLFRc=
Received: from localhost.localdomain (fttx-pool-217.61.148.252.bambit.de [217.61.148.252])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id B4D82360502;
        Sat, 14 May 2022 11:59:54 +0000 (UTC)
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
Subject: [RFC v3 0/5] RK3568 PCIe V3 support
Date:   Sat, 14 May 2022 13:59:41 +0200
Message-Id: <20220514115946.8858-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c0d866d5-96cb-4e67-abe9-7c9f9293d3cc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This series adds Rockchip PCIe V3 support found on rk3568 SOC.

It is based on "Enable rk356x PCIe controller" series of Peter Geis
v9: https://patchwork.kernel.org/project/linux-rockchip/list/?series=636944

Compared to PCIeV2 which uses the Naneng combphy, PCIe v3 uses a dedicated
PCI-phy.

New in this version is that lane-map is no separate patch and moved from
PCIe- to phy-driver.

Peter has tested m2-slot too and so the bifurcation.

The Phy-Patch is now changed to original author, but our changes are
squashed in.

Frank Wunderlich (4):
  dt-bindings: phy: rockchip: add PCIe v3 phy
  dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
  arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
  arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro

Shawn Lin (1):
  phy: rockchip: Support PCIe v3

 .../bindings/phy/rockchip,pcie3-phy.yaml      |  82 +++++
 .../devicetree/bindings/soc/rockchip/grf.yaml |   3 +
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   |  90 +++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 122 +++++++
 drivers/phy/rockchip/Kconfig                  |   9 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 317 ++++++++++++++++++
 include/linux/phy/pcie.h                      |  12 +
 8 files changed, 636 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
 create mode 100644 include/linux/phy/pcie.h

-- 
2.25.1

