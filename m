Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE6609C82
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJXI1x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 04:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJXI1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 04:27:47 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0254A1B7AD;
        Mon, 24 Oct 2022 01:27:38 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 853CD220E80;
        Mon, 24 Oct 2022 10:27:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 57181220E60;
        Mon, 24 Oct 2022 10:27:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 538481802201;
        Mon, 24 Oct 2022 16:27:03 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 0/14] Add i.MX PCIe EP mode support
Date:   Mon, 24 Oct 2022 16:06:29 +0800
Message-Id: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
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
Re-base to 6.1-rc1, and re-send the v4 series.
BTW, the following PHY changes [1] is required when apply this series.

[1] https://patchwork.kernel.org/project/linux-pci/cover/1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com/

Main changes from v3 -> v4:
- Add the Rob's ACK in the dt-binding patch.
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

[RESEND v4 01/14] dt-bindings: imx6q-pcie: Add i.MX8MM PCIe EP mode
[RESEND v4 02/14] dt-bindings: imx6q-pcie: Add i.MX8MQ PCIe EP mode
[RESEND v4 03/14] dt-bindings: imx6q-pcie: Add i.MX8MP PCIe EP mode
[RESEND v4 04/14] arm64: dts: Add i.MX8MM PCIe EP support
[RESEND v4 05/14] arm64: dts: Add i.MX8MM PCIe EP support on EVK
[RESEND v4 06/14] arm64: dts: Add i.MX8MQ PCIe EP support
[RESEND v4 07/14] arm64: dts: Add i.MX8MQ PCIe EP support on EVK
[RESEND v4 08/14] arm64: dts: Add i.MX8MP PCIe EP support
[RESEND v4 09/14] arm64: dts: Add i.MX8MP PCIe EP support on EVK
[RESEND v4 10/14] misc: pci_endpoint_test: Add i.MX8 PCIe EP device
[RESEND v4 11/14] PCI: imx6: Add i.MX PCIe EP mode support
[RESEND v4 12/14] PCI: imx6: Add i.MX8MQ PCIe EP support
[RESEND v4 13/14] PCI: imx6: Add i.MX8MM PCIe EP support
[RESEND v4 14/14] PCI: imx6: Add i.MX8MP PCIe EP support
