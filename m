Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12956465E05
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 07:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355639AbhLBGGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 01:06:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52264 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355624AbhLBGGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 01:06:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF261B8221F;
        Thu,  2 Dec 2021 06:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E5C00446;
        Thu,  2 Dec 2021 06:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638424997;
        bh=yxUfmcUDvPbycrmYxcjh6jMwLQ1IsWjPimgu3PlIhMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G819as4hBBSmyZpaslWx5bffENZv4XAD/HXL2i6LhT+vAK7tX+Q59KS1RVZ99O/Og
         lpPbUj8OcpYd5LTlQzpLlyr2fkAUI58K0zatPOn85n8o0xjjWZIQJAr9dOsiI7xWcA
         wpRGaYj5Lw8txq0U6QEC04/1ceNugkdBbS2YQ6N1qwcncVTvh+YzKOehj94Q4azSVo
         hD3ssM9Ym0V7dTZZkQiN9N8QygsqPhg//fba1N3bEBUwDn+2dqjq9QAtjLmLPtTNnF
         exJSDqKjWjJOXBQDJPlIEPfmYw7zTriG1zIwZ+7hyzJ7YRkCMa/R+18P65hTMQoqMu
         Efg+GChc9oWpg==
Date:   Thu, 2 Dec 2021 11:33:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Message-ID: <YahhobQWe9ndJR/j@matsya>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
 <20211201124419.GA13080@lpieralisi>
 <AS8PR04MB8676FE0B835E52FDD40816138C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8676FE0B835E52FDD40816138C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02-12-21, 05:43, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Wednesday, December 1, 2021 8:44 PM
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; Marcel Ziswiler
> > <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> > kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> > galak@kernel.crashing.org; shawnguo@kernel.org;
> > linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm
> > pcie support
> > 
> > On Thu, Nov 18, 2021 at 09:54:41AM +0800, Richard Zhu wrote:
> > > Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > > driver when enable i.MX8MM PCIe support.
> > >
> > > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > > i.MX8MM PCIe support[6-8] to have whole view to review this
> > patch-set.
> > >
> > > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> > driver
> > > [2] and this patch-set. And tested by Tim and Marcel on the different
> > > reference clock modes boards.
> > >
> > > [1]
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpa
> > tc
> > >
> > hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> > 929120
> > >
> > -3-l.stach%40pengutronix.de%2F&amp;data=04%7C01%7Chongxing.zhu
> > %40nxp.c
> > >
> > om%7C3edb11e040e6412cf91108d9b4c85052%7C686ea1d3bc2b4c6fa9
> > 2cd99c5c3016
> > >
> > 35%7C0%7C1%7C637739594698843569%7CUnknown%7CTWFpbGZsb3d
> > 8eyJWIjoiMC4wLj
> > >
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> > amp;sdata=
> > >
> > 5xlZSnBYs1SIIbMnmlQwi0qtfLDgKbueLNjPWIPD1pw%3D&amp;reserved=
> > 0
> > > [2]
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpa
> > tc
> > >
> > hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> > 202640
> > > .980366-1-l.stach%40pengutronix.de%2F&amp;data=04%7C01%7Chon
> > gxing.zhu%
> > >
> > 40nxp.com%7C3edb11e040e6412cf91108d9b4c85052%7C686ea1d3bc2
> > b4c6fa92cd99
> > >
> > c5c301635%7C0%7C1%7C637739594698843569%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjo
> > >
> > iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C3000&amp
> > > ;sdata=1388J8dLuKUc6KEUnWj5pLpkaPDC4kTIZFF%2BPTspHZY%3D&a
> > mp;reserved=0
> > >
> > > Main changes v5 --> v6:
> > > - Add "Reviewed-by: Rob Herring <robh@kernel.org>" into #1 and #3
> > patches.
> > > - Merge Rob's review comments to the #2 patch.
> > >
> > > Main changes v4 --> v5:
> > > - Set the AUX_EN always 1b'1, thus it can fix the regression introduced
> > in v4
> > >   series on Marcel's board.
> > > - Use the lower-case letter in the devicetreee refer to Marcel's
> > comments.
> > > _ Since the default value of the deemphasis parameters are zero, only
> > set
> > >   the deemphasis registers when the input paramters are none zero.
> > >
> > > Main changes v3 --> v4:
> > > - Update the yaml to fix syntax error, add maxitems and drop
> > > description of phy
> > > - Correct the clock name in PHY DT node.
> > > - Squash the EVK board relalted dts changes into one patch, and drop
> > the
> > >   useless dummy clock and gpio suffix in DT nodes.
> > > - Add board specific de-emphasis parameters as DT properties. Thus
> > each board
> > >   can specify its actual de-emphasis values.
> > > - Update the commit log of PHY driver.
> > > - Remove the useless codes from PCIe driver, since they are moved to
> > > PHY driver
> > > - After the discussion and verification of the CLKREQ# configurations
> > with Tim,
> > >   agree to add an optional boolean property "fsl,clkreq-unsupported",
> > indicates
> > >   the CLKREQ# signal is hooked or not in HW designs.
> > > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag,
> > since
> > >   Marcel help to test the v3 patch-set.
> > >
> > > Main changes v2 --> v3:
> > > - Regarding Lucas' comments.
> > >  - to have a whole view to review the patches, send out the i.MX8MM
> > PCIe support too.
> > >  - move the PHY related bits manipulations of the GPR/SRC to
> > standalone PHY driver.
> > >  - split the dts changes to SOC and board DT, and use the enum instead
> > of raw value.
> > >  - update the license of the dt-binding header file.
> > >
> > > Changes v1 --> v2:
> > > - Update the license of the dt-binding header file to make the license
> > >   compatible with dts files.
> > > - Fix the dt_binding_check errors.
> > >
> > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6
> > +++
> > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  92
> > +++++++++++++++++++++++++++++++
> > > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |
> > 55 +++++++++++++++++++
> > > arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |
> > 46 +++++++++++++++-
> > > drivers/pci/controller/dwc/pci-imx6.c                        |
> > 73 ++++++++++++++++++++++---
> > > drivers/phy/freescale/Kconfig                                |
> > 9 ++++
> > > drivers/phy/freescale/Makefile                               |
> > 1 +
> > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> > 237
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > +++++++++++++++++++++
> > > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> > 14 +++++
> > > 9 files changed, 525 insertions(+), 8 deletions(-)
> > 
> > Hi Richard,
> > 
> > I can pull this series into the PCI tree (but not the dts changes that should
> > be routed elsewhere) or give an ACK for patch 8, please let me know
> > what's the best option.
> [Richard Zhu] Hi Lorenzo:
> First of all, thanks a lot for your kindly help.
> To my original understand, #1-3 patch had been reviewed by Rob, might be
>  merged into Rob's dt-binding git repos.
> Shawn takes dts changes ( #4, #6 and #7). And PHY driver merged by vkoul
>  or Kishon.
> In the end, the PCIe changes(#8) are merged into PCIe git repos.
> 
> I'm appreciated if you pull this whole series although I'm not sure that
>  you can do it or not.
> Today, I'm glad to receive vkoul's comments about the PHY driver part.
> Let me continue refine the PHY driver, send anther version of this patch-set.
> Then, let's figure out what's the best option to merge this series.

I think phy binding and driver changes should go thru phy tree and pcie
binding and driver changes thru pcie tree, dt should be picked by
respective arch tree

-- 
~Vinod
