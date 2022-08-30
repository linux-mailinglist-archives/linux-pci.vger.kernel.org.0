Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26A45A5D9E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiH3IDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 04:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiH3IDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 04:03:47 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E93D25DA;
        Tue, 30 Aug 2022 01:03:44 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EF5BE1A3CF3;
        Tue, 30 Aug 2022 10:03:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B6E261A1712;
        Tue, 30 Aug 2022 10:03:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D403D180031C;
        Tue, 30 Aug 2022 16:03:40 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v5 0/7] Add the iMX8MP PCIe support
Date:   Tue, 30 Aug 2022 15:45:57 +0800
Message-Id: <1661845564-11373-1-git-send-email-hongxing.zhu@nxp.com>
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
This series adds the i.MX8MP PCIe support and tested on i.MX8MP
EVK board when one PCIe NVME device is used.

- i.MX8MP PCIe has reversed initial PERST bit value refer to i.MX8MQ/i.MX8MM.
  Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
- Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
  And share as much as possible codes with i.MX8MM PCIe PHY.
- Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
  driver.

Main changes v4-->v5:
- Use Lucas' approach, let blk-ctrl driver do the hsio-mix resets.
- Fetch the iomuxc-gpr regmap by the different phandles.
- Reorder the patches, place the DT changes at the begin of this series.

Main changes v3-->v4:
- Regarding Phillipp's suggestions, add fix tag into the first commit.
- Add Reviewed and Tested tags.

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

Lucas(1):
soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets

Richard(6):
dt-binding: phy: Add iMX8MP PCIe PHY binding
arm64: dts: imx8mp: Add iMX8MP PCIe support
arm64: dts: imx8mp-evk: Add PCIe support
reset: imx7: Fix the iMX8MP PCIe PHY PERST support
phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
PCI: imx6: Add iMX8MP PCIe support

Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  16 ++++++++--
arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  53 ++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  43 ++++++++++++++++++++++++++
drivers/pci/controller/dwc/pci-imx6.c                        |  29 ++++++++++++++++--
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
drivers/reset/reset-imx7.c                                   |   1 +
drivers/soc/imx/imx8mp-blk-ctrl.c                            |  10 ++++++
7 files changed, 235 insertions(+), 54 deletions(-)

