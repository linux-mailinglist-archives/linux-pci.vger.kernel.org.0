Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544DC77B169
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 08:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjHNGS0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 02:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjHNGRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 02:17:53 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540D10EB;
        Sun, 13 Aug 2023 23:17:42 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DACF41A1C11;
        Mon, 14 Aug 2023 08:17:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A9DF61A1C08;
        Mon, 14 Aug 2023 08:17:40 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B8FA1800319;
        Mon, 14 Aug 2023 14:17:38 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 0/9] Add legacy i.MX PCIe EP mode supports
Date:   Mon, 14 Aug 2023 13:42:38 +0800
Message-Id: <1691991767-15809-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add legacy 32bit i.MX PCIe EP mode support

The PCI controller contained in i.MX6/7 legacy SOCs is one dual mode
PCIe controller, and can work either as RC or EP.

This series add i.MX6/7 PCIe EP mode supports. And had been verified
on i.MX6 sabresd and i.MX7 SDB boards.

In the verification, one board PCIe is used as RC, the other one is used
as EP.
Use the cross TX/RX differential cable connect the two PCIe ports of
these two boards.

+-----------+                +------------+
|   PCIe TX |<-------------->|PCIe RX     |
|           |                |            |
|    Board  |                |    Board   |
|           |                |            |
|   PCIe RX |<-------------->|PCIe TX     |
+-----------+                +------------+

Changes from v3 to v4:
Add Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
into number 8 and 9 patches. Thanks.

Changes from v2 to v3:
Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
into dt-binding patches. Thanks.

Changes from v1 to v2:
Refer to Frank's comments:
To simple .get_features codes, add "const struct pci_epc_features"
*epc_features in drvdata. Thanks.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 50 +++++++++++++++++++++++++++++++++++++++++----
arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi                       | 14 +++++++++++++
arch/arm/boot/dts/nxp/imx/imx6qp.dtsi                        |  4 ++++
arch/arm/boot/dts/nxp/imx/imx6sx.dtsi                        | 17 +++++++++++++++
arch/arm/boot/dts/nxp/imx/imx7d.dtsi                         | 27 ++++++++++++++++++++++++
drivers/pci/controller/dwc/pci-imx6.c                        | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
6 files changed, 201 insertions(+), 4 deletions(-)

[PATCH v4 1/9] dt-bindings: PCI: fsl,imx6q: Add i.MX6Q and i.MX6QP
[PATCH v4 2/9] dt-bindings: PCI: fsl,imx6q: Add i.MX6SX PCIe EP
[PATCH v4 3/9] dt-bindings: PCI: fsl,imx6q: Add i.MX7D PCIe EP
[PATCH v4 4/9] arm: dts: nxp: Add i.MX6QDL and i.MX6QP PCIe EP
[PATCH v4 5/9] arm: dts: nxp: Add i.MX6SX PCIe EP support
[PATCH v4 6/9] arm: dts: nxp: Add i.MX7D PCIe EP support
[PATCH v4 7/9] PCI: imx6: Add i.MX6Q and i.MX6QP PCIe EP supports
[PATCH v4 8/9] PCI: imx6: Add i.MX6SX PCIe EP support
[PATCH v4 9/9] PCI: imx6: Add i.MX7D PCIe EP support
