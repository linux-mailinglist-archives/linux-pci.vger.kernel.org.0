Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1658E5E73F4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 08:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiIWGZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiIWGZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 02:25:56 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBDBFFA64;
        Thu, 22 Sep 2022 23:25:52 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CED6215AED;
        Fri, 23 Sep 2022 08:25:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5256A200DC1;
        Fri, 23 Sep 2022 08:25:50 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 575091820F59;
        Fri, 23 Sep 2022 14:25:48 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v3 0/14] Add iMX PCIe EP mode support
Date:   Fri, 23 Sep 2022 14:06:46 +0800
Message-Id: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
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
i.MX8MQ EVK, i.MX8MM EVK and i.MX8MP EVK boards.
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
drivers/pci/controller/dwc/Kconfig                        |  25 ++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                     | 200 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
10 files changed, 316 insertions(+), 19 deletions(-)

 [PATCH v3 01/14] dt-bindings: imx6q-pcie: Add iMX8MM PCIe EP mode
 [PATCH v3 02/14] dt-bindings: imx6q-pcie: Add iMX8MQ PCIe EP mode
 [PATCH v3 03/14] dt-bindings: imx6q-pcie: Add iMX8MP PCIe EP mode
 [PATCH v3 04/14] PCI: dwc: Kconfig: Add iMX PCIe EP mode support
 [PATCH v3 05/14] arm64: dts: Add iMX8MM PCIe EP support
 [PATCH v3 06/14] arm64: dts: Add iMX8MM PCIe EP support on EVK board
 [PATCH v3 07/14] arm64: dts: Add iMX8MQ PCIe EP support
 [PATCH v3 08/14] arm64: dts: Add iMX8MQ PCIe EP support on EVK board
 [PATCH v3 09/14] arm64: dts: Add iMX8MP PCIe EP support
 [PATCH v3 10/14] arm64: dts: Add iMX8MP PCIe EP support on EVK board
 [PATCH v3 11/14] misc: pci_endpoint_test: Add iMX8 PCIe EP device
 [PATCH v3 12/14] PCI: imx6: Add iMX8MM PCIe EP mode
 [PATCH v3 13/14] PCI: imx6: Add iMX8MQ PCIe EP support
 [PATCH v3 14/14] PCI: imx6: Add iMX8MP PCIe EP support
