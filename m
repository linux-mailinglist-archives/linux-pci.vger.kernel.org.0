Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6145C4CF46D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 10:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiCGJR1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 04:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiCGJR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 04:17:27 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FA86515F;
        Mon,  7 Mar 2022 01:16:32 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D7011A21DF;
        Mon,  7 Mar 2022 10:16:31 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B80421A005F;
        Mon,  7 Mar 2022 10:16:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BF67B183AD67;
        Mon,  7 Mar 2022 17:16:28 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 0/7] Add the iMX8MP PCIe support
Date:   Mon,  7 Mar 2022 17:07:27 +0800
Message-Id: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
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

Based on the i.MX8MP GPC and blk-ctrl patch-set[1] issued by Lucas and the
following commits.
  - one codes refine patch-set[5].
  - two Fixes[2],[3].
  - one binding commit[4].
  - some dts changes in Shawn's git if you want to test PCIe on i.MX8MM EVK.
    b4d36c10bf17 arm64: dts: imx8mm-evk: Add the pcie support on imx8mm evk board
    aaeba6a8e226 arm64: dts: imx8mm: Add the pcie support
    cfc5078432ca arm64: dts: imx8mm: Add the pcie phy support

Sorry about that there may be some conflictions when do the codes merge.
I'm waiting for the ack now, and will re-base them in a proper sequence later.

This series patches add the i.MX8MP PCIe support and tested on i.MX8MM EVK and
i.MX8MP EVk boards. The PCIe NVME works fine on both boards.

- i.MX8MP PCIe PHY has two resets refer to the i.MX8MM PCIe PHY.
  Add one more PHY reset for i.MX8MP PCIe PHY accordingly.
- Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
  And share as much as possible codes with i.MX8MM PCIe PHY.
- Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
  driver.

Main changes v1-->v2:
- It's my fault forget including Vinod, re-send v2 after include Vinod
  and linux-phy@lists.infradead.org.
- List the basements of this patch-set. The branch, codes changes and so on.
- Clean up some useless register and bit definitions in #3 patch.

[1]https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220228201731.3330192-1-l.stach@pengutronix.de/
[2]https://patchwork.ozlabs.org/project/linux-pci/patch/1646289275-17813-1-git-send-email-hongxing.zhu@nxp.com/
[3]https://patchwork.ozlabs.org/project/linux-pci/patch/1645672013-8949-1-git-send-email-hongxing.zhu@nxp.com/
[4]https://patchwork.ozlabs.org/project/linux-pci/patch/1646293805-18248-1-git-send-email-hongxing.zhu@nxp.com/
[5]https://patchwork.ozlabs.org/project/linux-pci/cover/1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com/

NOTE:
Based git <git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git>
Based branch <pci/imx6>

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   1 +
Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   4 +-
arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  55 ++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46 ++++++++++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                        |  19 +++++++-
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
drivers/reset/reset-imx7.c                                   |   1 +
7 files changed, 286 insertions(+), 45 deletions(-)

[PATCH v2 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST support
[PATCH v2 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
[PATCH v2 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
[PATCH v2 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible
[PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
[PATCH v2 6/7] arm64: dts: imx8mp-evk: Add PCIe support
[PATCH v2 7/7] PCI: imx6: Add the iMX8MP PCIe support
