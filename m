Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693FE5FD31F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 04:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJMCGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 22:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMCGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 22:06:52 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC87122BED;
        Wed, 12 Oct 2022 19:06:51 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A7AD1B1B09;
        Thu, 13 Oct 2022 04:06:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1058E1B1ADB;
        Thu, 13 Oct 2022 04:06:50 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 71F911802204;
        Thu, 13 Oct 2022 10:06:48 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     vkoul@kernel.org, a.fatoum@pengutronix.de, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH RESEND v12 0/4] Add the iMX8MP PCIe support
Date:   Thu, 13 Oct 2022 09:46:58 +0800
Message-Id: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re-base to the pci-v6.1-changes of pci/next branch. 
Update the cover-letter, and re-send the v12 patch-set.
This series adds the i.MX8MP PCIe support and tested on i.MX8MP
EVK board when one PCIe NVME device is used.

- i.MX8MP PCIe has reversed initial PERST bit value refer to i.MX8MQ/i.MX8MM.
  Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
- Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
  And share as much as possible codes with i.MX8MM PCIe PHY.
- Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
  driver.

Main changes v11-->v12:
 - In the local down kernel(6.0-rc7 plus local codes) PM tests, i.MX8MP
   PCIe encounters link failure.
   To resolve this failure, the resets of i.MX8MP PCIe PHY should be always
   kept 1b'1. Merge the fix into v12 patches here.

Main changes v10-->v11:
Refer to Ahmad's comments do the following changes;
 - Correct the spell mistake and refine the commit log.
 - Make codes indent by the member name
 - Use the dev_err_probe replace the dev_err.

Main changes v9-->v10:
- Refer to Vinod's review comments, drop the array, and use the static data
  structure directly in the drvdata definition.

Main changes v8-->v9:
- Split the PHY driver changes into three patches.
  - To keep the format consistent, re-define the PHY_CMN_REG75, and remove
    two useless BIT definitions.
  - Refine the i.MX8MM PCIe PHY driver, let it more reviewable, flexible,
    and easy to expand.
  - Add the i.MX8MP PCIe PHY support.
- Only PHY related patches in v9, Since the others patches had been merged
  by Phillipp/Shawn/Lorenzo [1].

Main changes v7-->v8:
- Add the Reviewed-by tag, no other changes.
  Only two patches in v8, Since the others patches had been merged by
  Phillipp/Shawn/Lorenzo [1].

<snipped.>

[1]
Shawn's tree
d50650500064 arm64: dts: imx8mp-evk: Add PCIe support
9e65987b9584 arm64: dts: imx8mp: Add iMX8MP PCIe support
5506018d3dec soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets

Philipp's tree
051d9eb40388 reset: imx7: Fix the iMX8MP PCIe PHY PERST support

Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  16 ++++++++--
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
2 files changed, 106 insertions(+), 52 deletions(-)

[RESEND v12 1/4] dt-binding: phy: Add i.MX8MP PCIe PHY binding
[RESEND v12 2/4] phy: freescale: imx8m-pcie: Refine register
[RESEND v12 3/4] phy: freescale: imx8m-pcie: Refine i.MX8MM PCIe PHY
[RESEND v12 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
