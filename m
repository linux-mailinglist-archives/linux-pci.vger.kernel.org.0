Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932195954E9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiHPIX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiHPIWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 04:22:02 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A251514658D;
        Mon, 15 Aug 2022 23:01:56 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BE1D2020E6;
        Tue, 16 Aug 2022 08:01:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E93EE2020DF;
        Tue, 16 Aug 2022 08:01:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3A3EB180031A;
        Tue, 16 Aug 2022 14:01:53 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 0/10] Add iMX PCIe EP mode support
Date:   Tue, 16 Aug 2022 13:44:37 +0800
Message-Id: <1660628687-25676-1-git-send-email-hongxing.zhu@nxp.com>
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

i.MX PCIe controller is one dual mode PCIe controller, and can work either
as RC or EP.
This series add the i.MX PCIe EP mode support. And had been verified on
i.MX8MQ and i.MX8MM EVK boards.
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

Main changes from v1 -> v2:
- Add Rob's ACK into first two commits.
- Rebase to the tag: pci-v5.20-changes of the pci/next branch.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |   2 +
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi             |  14 +++++++
arch/arm64/boot/dts/freescale/imx8mm.dtsi                 |  20 ++++++++++
arch/arm64/boot/dts/freescale/imx8mq-evk.dts              |  12 ++++++
arch/arm64/boot/dts/freescale/imx8mq.dtsi                 |  27 +++++++++++++
drivers/misc/pci_endpoint_test.c                          |   2 +
drivers/pci/controller/dwc/Kconfig                        |  25 +++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                     | 181 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
8 files changed, 264 insertions(+), 19 deletions(-)

[PATCH v2 01/10] dt-bindings: imx6q-pcie: Add iMX8MM PCIe EP mode
[PATCH v2 02/10] dt-bindings: imx6q-pcie: Add iMX8MQ PCIe EP mode
[PATCH v2 03/10] PCI: dwc: Kconfig: Add iMX PCIe EP mode support
[PATCH v2 04/10] arm64: dts: Add iMX8MM PCIe EP support
[PATCH v2 05/10] arm64: dts: Add iMX8MQ PCIe EP support
[PATCH v2 06/10] arm64: dts: Add iMX8MM PCIe EP support on EVK board
[PATCH v2 07/10] arm64: dts: Add iMX8MQ PCIe EP support on EVK board
[PATCH v2 08/10] misc: pci_endpoint_test: Add iMX8 PCIe EP device
[PATCH v2 09/10] PCI: imx6: Add iMX8MM PCIe EP mode
[PATCH v2 10/10] PCI: imx6: Add iMX8MQ PCIe EP support
