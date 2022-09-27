Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70B5EBE24
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiI0JQ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiI0JQZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:16:25 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F32288DE3;
        Tue, 27 Sep 2022 02:16:20 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 16AD51AF559;
        Tue, 27 Sep 2022 11:16:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 91AFD1AF555;
        Tue, 27 Sep 2022 11:16:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 231121802201;
        Tue, 27 Sep 2022 17:16:16 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 0/14] Add i.MX PCIe EP mode support
Date:   Tue, 27 Sep 2022 16:57:02 +0800
Message-Id: <1664269036-16142-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX PCIe controller is one dual mode PCIe controller, and can work either
as RC or EP.

This series add the i.MX PCIe EP mode support. And had been verified on
i.MX8MQ, i.MX8MM EVK and i.MX8MP EVK boards.

In the verification, one EVK board used as RC, the other one used as EP.
Use the cross TX/RX differential cable connect the two PCIe ports of these
two EVK boards.

+-----------+                +------------+
|   PCIe TX |<-------------->|PCIe RX     |
|           |                |            |
|EVK Board  |                |EVK Board   |
|           |                |            |
|   PCIe RX |<-------------->|PCIe TX     |
+-----------+                +------------+

NOTE:
The following commits should be cherried back firstly, when apply this
series.

Shawn's tree (git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git)
d50650500064 arm64: dts: imx8mp-evk: Add PCIe support
9e65987b9584 arm64: dts: imx8mp: Add iMX8MP PCIe support
5506018d3dec soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets

Philipp's tree (git://git.pengutronix.de/git/pza/linux)
051d9eb40388 reset: imx7: Fix the iMX8MP PCIe PHY PERST support

The PHY changes:
https://patchwork.kernel.org/project/linux-pci/cover/1664174463-13721-1-git-send-email-hongxing.zhu@nxp.com/

Main changes from v3 -> v4:
- Add the Rob's ACK in the dt-binding patch.
- Based on pci/next, specify the dependencies(listed above) of this series.
- Use "i.MX" to keep spell consistent.
- Squash generic endpoint infrastructure changes of
  "[12/14] PCI: imx6: Add iMX8MM PCIe EP mode" into Kconfig changes.

Main changes from v2 -> v3:
- Add the i.MX8MP PCIe EP support, and verified on i.MX8MP EVK board.
- Rebase to latest pci/next branch(tag: v6.0-rc1 plus some PCIe changes).

Main changes from v1 -> v2:
- Add Rob's ACK into first two commits.
- Rebase to the tag: pci-v5.20-changes of the pci/next branch.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |   3 ++
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi             |  14 ++++++
arch/arm64/boot/dts/freescale/imx8mm.dtsi                 |  20 +++++++++
arch/arm64/boot/dts/freescale/imx8mp-evk.dts              |  13 ++++++
arch/arm64/boot/dts/freescale/imx8mp.dtsi                 |  19 ++++++++
arch/arm64/boot/dts/freescale/imx8mq-evk.dts              |  12 ++++++
arch/arm64/boot/dts/freescale/imx8mq.dtsi                 |  27 ++++++++++++
drivers/misc/pci_endpoint_test.c                          |   2 +
drivers/pci/controller/dwc/Kconfig                        |  23 +++++++++-
drivers/pci/controller/dwc/pci-imx6.c                     | 200 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
10 files changed, 314 insertions(+), 19 deletions(-)

[PATCH v4 01/14] dt-bindings: imx6q-pcie: Add i.MX8MM PCIe EP mode
[PATCH v4 02/14] dt-bindings: imx6q-pcie: Add i.MX8MQ PCIe EP mode
[PATCH v4 03/14] dt-bindings: imx6q-pcie: Add i.MX8MP PCIe EP mode
[PATCH v4 04/14] arm64: dts: Add i.MX8MM PCIe EP support
[PATCH v4 05/14] arm64: dts: Add i.MX8MM PCIe EP support on EVK board
[PATCH v4 06/14] arm64: dts: Add i.MX8MQ PCIe EP support
[PATCH v4 07/14] arm64: dts: Add i.MX8MQ PCIe EP support on EVK board
[PATCH v4 08/14] arm64: dts: Add i.MX8MP PCIe EP support
[PATCH v4 09/14] arm64: dts: Add i.MX8MP PCIe EP support on EVK board
[PATCH v4 10/14] misc: pci_endpoint_test: Add i.MX8 PCIe EP device
[PATCH v4 11/14] PCI: imx6: Add i.MX PCIe EP mode support
[PATCH v4 12/14] PCI: imx6: Add i.MX8MQ PCIe EP support
[PATCH v4 13/14] PCI: imx6: Add i.MX8MM PCIe EP support
[PATCH v4 14/14] PCI: imx6: Add i.MX8MP PCIe EP support
