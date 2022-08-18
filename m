Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B4597F23
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbiHRHTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbiHRHTi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 03:19:38 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5AB8E470;
        Thu, 18 Aug 2022 00:19:37 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DF260202EE3;
        Thu, 18 Aug 2022 09:19:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A8B832006BA;
        Thu, 18 Aug 2022 09:19:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D9E781820F56;
        Thu, 18 Aug 2022 15:19:33 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v3 0/6] Add the iMX8MP PCIe support
Date:   Thu, 18 Aug 2022 15:02:27 +0800
Message-Id: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Based on the 6.0-rc1 of the pci/next branch. 
This series adds the i.MX8MP PCIe support and had been tested on i.MX8MP
EVK board when one PCIe NVME device is used.

- i.MX8MP PCIe has reversed initial PERST bit value refer to i.MX8MQ/i.MX8MM.
  Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
- Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
  And share as much as possible codes with i.MX8MM PCIe PHY.
- Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
  driver.

Main changes v2-->v3:
- Fix the schema checking error in the PHY dt-binding patch.
- Inspired by Lucas, the PLL configurations might not required when
  external OSC is used as PCIe referrence clock. It's true. Remove all
  the HSIO PLL bit manipulations, and PCIe works fine on i.MX8MP EVK board
  with one NVME device is used.
- Drop the #4 patch of v2, since it had been applied by Rob.

Main changes v1-->v2:
- It's my fault forget including Vinod, re-send v2 after include Vinod
  and linux-phy@lists.infradead.org.
- List the basements of this patch-set. The branch, codes changes and so on.
- Clean up some useless register and bit definitions in #3 patch.

Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  16 +++++++--
arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  53 +++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46 ++++++++++++++++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                        |  17 +++++++++-
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
drivers/reset/reset-imx7.c                                   |   1 +
6 files changed, 232 insertions(+), 51 deletions(-)

 [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST support
 [PATCH v3 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding
 [PATCH v3 3/6] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
 [PATCH v3 4/6] arm64: dts: imx8mp: add the iMX8MP PCIe support
 [PATCH v3 5/6] arm64: dts: imx8mp-evk: Add PCIe support
 [PATCH v3 6/6] PCI: imx6: Add the iMX8MP PCIe support
