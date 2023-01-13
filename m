Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13585669D92
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjAMQXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjAMQW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:22:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500706147C;
        Fri, 13 Jan 2023 08:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD66EB82189;
        Fri, 13 Jan 2023 16:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62D2C433F0;
        Fri, 13 Jan 2023 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673626641;
        bh=ZvTX6LgnsVxHP/nn+kEAnIIzNIaAPDqMNjglQidPBxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVZh0z88hXIK/5/RYc8qJh1S1mPXk9GOR0CuDl9PbK4pQMNNxkh1SwhmO8x4LVMEx
         rBRT0RQA14Mjm2odPwsgHEsN22EWuJ3C+cfX03iXWCmdPJbYd6aGbLwzpiTlckK2Hn
         OkrCDGvp1YY5uWenMY4h+t3zk5ph7B6ihtvgsCwQ5aYLaCkxv57ZL5BXAFA0K2wyWO
         z49oSRgegJ2dttzSRI0vT4EAZclCYSyB4zTtomLKsr7gQutnWV6R1Pqj3WDZ9ptGrB
         P88L7WSXeAJMuA0naYCwOeccSkDMx8ICS6hgLbrB5C4x42lSkAnB1IWfEOyw6xgYU0
         mXZegfNuwuYug==
Date:   Fri, 13 Jan 2023 17:17:12 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "kw@linux.com" <kw@linux.com>,
        Frank Li <frank.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 0/14] Add i.MX PCIe EP mode support
Message-ID: <Y8GECJPWt126G8am@lpieralisi>
References: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
 <AS8PR04MB86761655C5F12142BA183B998C049@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86761655C5F12142BA183B998C049@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 04:42:30AM +0000, Hongxing Zhu wrote:
> Ping.
> Almost one month pass away after this re-send of v4 series. 
> Any comments?

Can you rebase on top of v6.2-rc1 and resend it please ? I will merge
the dt bindings and PCI changes then.

Thanks,
Lorenzo

> Thanks.
> Best Regards
> Richard Zhu
> 
> > -----Original Message-----
> > From: Richard Zhu <hongxing.zhu@nxp.com>
> > Sent: 2022年10月24日 16:06
> > To: l.stach@pengutronix.de; bhelgaas@google.com; robh+dt@kernel.org;
> > lorenzo.pieralisi@arm.com; shawnguo@kernel.org; kishon@ti.com;
> > kw@linux.com; Frank Li <frank.li@nxp.com>
> > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: [PATCH v4 0/14] Add i.MX PCIe EP mode support
> > 
> > i.MX PCIe controller is one dual mode PCIe controller, and can work either as
> > RC or EP.
> > 
> > This series add the i.MX PCIe EP mode support. And had been verified on
> > i.MX8MQ, i.MX8MM EVK and i.MX8MP EVK boards.
> > 
> > In the verification, one EVK board used as RC, the other one used as EP.
> > Use the cross TX/RX differential cable connect the two PCIe ports of these two
> > EVK boards.
> > 
> > +-----------+                +------------+
> > |   PCIe TX |<-------------->|PCIe RX     |
> > |           |                |            |
> > |EVK Board  |                |EVK Board   |
> > |           |                |            |
> > |   PCIe RX |<-------------->|PCIe TX     |
> > +-----------+                +------------+
> > 
> > NOTE:
> > Re-base to 6.1-rc1, and re-send the v4 series.
> > BTW, the following PHY changes [1] is required when apply this series.
> > 
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchw
> > ork.kernel.org%2Fproject%2Flinux-pci%2Fcover%2F1665625622-20551-1-git-s
> > end-email-hongxing.zhu%40nxp.com%2F&amp;data=05%7C01%7Chongxing.z
> > hu%40nxp.com%7C80b50b3789f9433f62e008dab5998a09%7C686ea1d3bc2b
> > 4c6fa92cd99c5c301635%7C0%7C0%7C638021968298265067%7CUnknown%
> > 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=j70ORNKBvTCjWtJzS375
> > TvuQfCGrVRQNbxS%2BhrGI0ZA%3D&amp;reserved=0
> > 
> > Main changes from v3 -> v4:
> > - Add the Rob's ACK in the dt-binding patch.
> > - Use "i.MX" to keep spell consistent.
> > - Squash generic endpoint infrastructure changes of
> >   "[12/14] PCI: imx6: Add iMX8MM PCIe EP mode" into Kconfig changes.
> > 
> > Main changes from v2 -> v3:
> > - Add the i.MX8MP PCIe EP support, and verified on i.MX8MP EVK board.
> > - Rebase to latest pci/next branch(tag: v6.0-rc1 plus some PCIe changes).
> > 
> > Main changes from v1 -> v2:
> > - Add Rob's ACK into first two commits.
> > - Rebase to the tag: pci-v5.20-changes of the pci/next branch.
> > 
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |   3 ++
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi             |  14 ++++++
> > arch/arm64/boot/dts/freescale/imx8mm.dtsi                 |  20
> > +++++++++
> > arch/arm64/boot/dts/freescale/imx8mp-evk.dts              |  13 ++++++
> > arch/arm64/boot/dts/freescale/imx8mp.dtsi                 |  19
> > ++++++++
> > arch/arm64/boot/dts/freescale/imx8mq-evk.dts              |  12 ++++++
> > arch/arm64/boot/dts/freescale/imx8mq.dtsi                 |  27
> > ++++++++++++
> > drivers/misc/pci_endpoint_test.c                          |   2 +
> > drivers/pci/controller/dwc/Kconfig                        |  23
> > +++++++++-
> > drivers/pci/controller/dwc/pci-imx6.c                     | 200
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > ++++++++++++++++--------
> > 10 files changed, 314 insertions(+), 19 deletions(-)
> > 
> > [RESEND v4 01/14] dt-bindings: imx6q-pcie: Add i.MX8MM PCIe EP mode
> > [RESEND v4 02/14] dt-bindings: imx6q-pcie: Add i.MX8MQ PCIe EP mode
> > [RESEND v4 03/14] dt-bindings: imx6q-pcie: Add i.MX8MP PCIe EP mode
> > [RESEND v4 04/14] arm64: dts: Add i.MX8MM PCIe EP support [RESEND v4
> > 05/14] arm64: dts: Add i.MX8MM PCIe EP support on EVK [RESEND v4 06/14]
> > arm64: dts: Add i.MX8MQ PCIe EP support [RESEND v4 07/14] arm64: dts:
> > Add i.MX8MQ PCIe EP support on EVK [RESEND v4 08/14] arm64: dts: Add
> > i.MX8MP PCIe EP support [RESEND v4 09/14] arm64: dts: Add i.MX8MP PCIe
> > EP support on EVK [RESEND v4 10/14] misc: pci_endpoint_test: Add i.MX8
> > PCIe EP device [RESEND v4 11/14] PCI: imx6: Add i.MX PCIe EP mode support
> > [RESEND v4 12/14] PCI: imx6: Add i.MX8MQ PCIe EP support [RESEND v4
> > 13/14] PCI: imx6: Add i.MX8MM PCIe EP support [RESEND v4 14/14] PCI: imx6:
> > Add i.MX8MP PCIe EP support
