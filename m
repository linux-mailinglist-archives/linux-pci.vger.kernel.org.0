Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E385A5D40
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiH3Hqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiH3Hqc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:46:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8317DF48
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 00:46:30 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oSvwt-00058t-RN; Tue, 30 Aug 2022 09:46:15 +0200
Message-ID: <6c02b8af4c887eb58ccf03d0ee107e2f5c7f17de.camel@pengutronix.de>
Subject: Re: [PATCH v4 0/6] Add iMX8MP PCIe support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
Cc:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Tue, 30 Aug 2022 09:46:14 +0200
In-Reply-To: <AS8PR04MB867602341382CB5D63379DC88C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
         <c668fff254b9f56b699a2714bb8c016e3b0cc5b5.camel@pengutronix.de>
         <AS8PR04MB867602341382CB5D63379DC88C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, dem 30.08.2022 um 02:58 +0000 schrieb Hongxing Zhu:
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: 2022年8月29日 23:20
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; p.zabel@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; robh@kernel.org;
> > shawnguo@kernel.org; vkoul@kernel.org; alexander.stein@ew.tq-group.com;
> > marex@denx.de; richard.leitner@linux.dev
> > Cc: linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v4 0/6] Add iMX8MP PCIe support
> > 
> > Hi Richard,
> > 
> > instead of review comments I sent you a two patches to rework things more to
> > my liking. Hope you agree with the approach.
> > 
> > One question, though: did you test this with devices with Gen2/3 speeds? The
> > Marvell WiFi module on my EVK board only links with Gen1, while it claims
> > Gen2 speed in the LnkCap register. However, it does seem to come up with
> > Gen1 as the target link speed in LnkCtl2, so maybe the device is at fault here.
> Hi Lucas:
> Thanks for your help on this series.
> I'm agree with your approach, and let blk-ctrl driver do the hsiomix resets.
> Can I include the #1 patch into this series, and rebase the 2# fixup! patch
>  into the phy changes patch with your sign-off?
> 
Sure, that's why I sent them this way. Feel free to include them in
your series with my sign-off.

> Yes, I did the Gen3 NVEM device tests on i.MX8MP EVK board.
> The Gen3 works fine.
> Logs:
> "
> [    1.808033] phy phy-32f00000.pcie-phy.1: phy_power_on was called before phy_init
> [    1.822609] imx6q-pcie 33800000.pcie: iATU unroll: enabled
> [    1.836620] imx6q-pcie 33800000.pcie: iATU regions: 4 ob, 4 ib, align 64K, limit 16G
> [    1.950427] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> [    2.058138] imx6q-pcie 33800000.pcie: PCIe Gen.3 x1 link up
> [    2.063731] imx6q-pcie 33800000.pcie: Link up, Gen3
> [    2.068619] imx6q-pcie 33800000.pcie: PCIe Gen.3 x1 link up
> "
Thanks for the confirmation.

Also can you please reorder the series, to have the DT changes at the
end?

Regards,
Lucas

> 
> Best Regards
> Richard Zhu
> > 
> > Regards,
> > Lucas
> > 
> > Am Montag, dem 29.08.2022 um 16:15 +0800 schrieb Richard Zhu:
> > > Based on the 6.0-rc1 of the pci/next branch.
> > > This series adds the i.MX8MP PCIe support and tested on i.MX8MP EVK
> > > board when one PCIe NVME device is used.
> > > 
> > > - i.MX8MP PCIe has reversed initial PERST bit value refer to
> > i.MX8MQ/i.MX8MM.
> > >   Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
> > > - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
> > >   And share as much as possible codes with i.MX8MM PCIe PHY.
> > > - Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
> > >   driver.
> > > 
> > > Main changes v3-->v4:
> > > - Regarding Phillip's suggestions, add fix tag into the first commit.
> > > - Add Reviewed and Tested tags.
> > > 
> > > Main changes v2-->v3:
> > > - Fix the schema checking error in the PHY dt-binding patch.
> > > - Inspired by Lucas, the PLL configurations might not required when
> > >   external OSC is used as PCIe referrence clock. It's true. Remove all
> > >   the HSIO PLL bit manipulations, and PCIe works fine on i.MX8MP EVK
> > board
> > >   with one NVME device is used.
> > > - Drop the #4 patch of v2, since it had been applied by Rob.
> > > 
> > > Main changes v1-->v2:
> > > - It's my fault forget including Vinod, re-send v2 after include Vinod
> > >   and linux-phy@lists.infradead.org.
> > > - List the basements of this patch-set. The branch, codes changes and so on.
> > > - Clean up some useless register and bit definitions in #3 patch.
> > > 
> > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  16
> > +++++++--
> > > arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  53
> > +++++++++++++++++++++++++++++
> > > arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46
> > ++++++++++++++++++++++++-
> > > drivers/pci/controller/dwc/pci-imx6.c                        |  17
> > +++++++++-
> > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 150
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
> > ------------------
> > > drivers/reset/reset-imx7.c                                   |   1 +
> > > 6 files changed, 232 insertions(+), 51 deletions(-)
> > > 
> > > [PATCH v4 1/6] reset: imx7: Fix the iMX8MP PCIe PHY PERST support
> > > [PATCH v4 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding [PATCH v4
> > > 3/6] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY [PATCH v4 4/6]
> > > arm64: dts: imx8mp: Add iMX8MP PCIe support [PATCH v4 5/6] arm64: dts:
> > > imx8mp-evk: Add PCIe support [PATCH v4 6/6] PCI: imx6: Add iMX8MP PCIe
> > > support
> > 
> 


