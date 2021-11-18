Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FA4552A0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 03:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbhKRCYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 21:24:42 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46196 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241550AbhKRCYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 21:24:40 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 925FC202317;
        Thu, 18 Nov 2021 03:21:38 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D3102031B0;
        Thu, 18 Nov 2021 03:21:38 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 011A1183AC96;
        Thu, 18 Nov 2021 10:21:35 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     hongxing.zhu@nxp.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm pcie support
Date:   Thu, 18 Nov 2021 09:54:41 +0800
Message-Id: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
one standalone PCIe PHY driver should be seperated from i.MX PCIe
driver when enable i.MX8MM PCIe support.

This patch-set adds the standalone PCIe PHY driver suport[1-5], and i.MX8MM
PCIe support[6-8] to have whole view to review this patch-set.

The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
[2] and this patch-set. And tested by Tim and Marcel on the different
reference clock modes boards.

[1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/

Main changes v5 --> v6:
- Add "Reviewed-by: Rob Herring <robh@kernel.org>" into #1 and #3 patches.
- Merge Rob's review comments to the #2 patch.

Main changes v4 --> v5:
- Set the AUX_EN always 1b'1, thus it can fix the regression introduced in v4
  series on Marcel's board.
- Use the lower-case letter in the devicetreee refer to Marcel's comments.
_ Since the default value of the deemphasis parameters are zero, only set
  the deemphasis registers when the input paramters are none zero.

Main changes v3 --> v4:
- Update the yaml to fix syntax error, add maxitems and drop description of phy
- Correct the clock name in PHY DT node.
- Squash the EVK board relalted dts changes into one patch, and drop the
  useless dummy clock and gpio suffix in DT nodes.
- Add board specific de-emphasis parameters as DT properties. Thus each board
  can specify its actual de-emphasis values.
- Update the commit log of PHY driver.
- Remove the useless codes from PCIe driver, since they are moved to PHY driver
- After the discussion and verification of the CLKREQ# configurations with Tim,
  agree to add an optional boolean property "fsl,clkreq-unsupported", indicates
  the CLKREQ# signal is hooked or not in HW designs.
- Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag, since
  Marcel help to test the v3 patch-set.

Main changes v2 --> v3:
- Regarding Lucas' comments.
 - to have a whole view to review the patches, send out the i.MX8MM PCIe support too.
 - move the PHY related bits manipulations of the GPR/SRC to standalone PHY driver.
 - split the dts changes to SOC and board DT, and use the enum instead of raw value.
 - update the license of the dt-binding header file.

Changes v1 --> v2:
- Update the license of the dt-binding header file to make the license
  compatible with dts files.
- Fix the dt_binding_check errors.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6 +++
Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  92 +++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |  55 +++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  46 +++++++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                        |  73 ++++++++++++++++++++++---
drivers/phy/freescale/Kconfig                                |   9 ++++
drivers/phy/freescale/Makefile                               |   1 +
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 237 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 +++++
9 files changed, 525 insertions(+), 8 deletions(-)

[PATCH v6 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
[PATCH v6 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
[PATCH v6 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
[PATCH v6 4/8] arm64: dts: imx8mm: Add the pcie phy support
[PATCH v6 5/8] phy: freescale: pcie: Initialize the imx8 pcie
[PATCH v6 6/8] arm64: dts: imx8mm: Add the pcie support
[PATCH v6 7/8] arm64: dts: imx8mm-evk: Add the pcie support on imx8mm
[PATCH v6 8/8] PCI: imx: Add the imx8mm pcie support
