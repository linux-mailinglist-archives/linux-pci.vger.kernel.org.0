Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636EB5EBFF5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 12:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiI0Kkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 06:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiI0Kkr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 06:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166192585;
        Tue, 27 Sep 2022 03:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D0261765;
        Tue, 27 Sep 2022 10:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00533C433C1;
        Tue, 27 Sep 2022 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664275245;
        bh=DA4fSOa6GRctG/cz6WPvoD1hPM15TyILiZ0edmgdXBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GH2U78y/mpeStLQelepkQSPwkIumC5OU4regHqfZ0qggtQDJAFEFIU5kWazfBL4Wj
         BmYTA/xGPCvK62LHkFMajL4fk9ZN9dmySTCfhW+pZ3OiHSv4Q29Rsc7ClSgd5iLd6e
         xmvij6CMrrntkVH/xYuOs0xdgMQzRXigFIECJgDIOReu/iZGGZI1ji/HI9Lcw01tpF
         yCWQN4lwK5pKQu9mzJwPYvou/FMO4U8MiEniXYO16qNALBOs2/ubMjZaDJWjUO6+9V
         Oc9lQt4HUSaBWjOxYSweRitzkozSZMKswkg5aYzqnhSiAQBNZU1cTCOLImt0HZcAEn
         0DgbQ27azZrcw==
Date:   Tue, 27 Sep 2022 12:40:38 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Message-ID: <YzLTJqzvv6BgraiL@lpieralisi>
References: <AS8PR04MB86763A2187AED57CFD55625E8C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220830150534.GA97821@bhelgaas>
 <AS8PR04MB867644D39C15DDEF5CE88E008C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB867644D39C15DDEF5CE88E008C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 01:37:02AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年8月30日 23:06
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>; l.stach@pengutronix.de;
> > bhelgaas@google.com; lorenzo.pieralisi@arm.com; vkoul@kernel.org; Marcel
> > Ziswiler <marcel.ziswiler@toradex.com>; kishon@ti.com;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>; kernel@pengutronix.de; linux-phy@lists.infradead.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v1 0/2] Fix the wrong order of phy callbacks
> > 
> > On Tue, Aug 30, 2022 at 07:50:55AM +0000, Hongxing Zhu wrote:
> > > > -----Original Message-----
> > > > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > > Sent: 2022年8月30日 15:16
> > > > To: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> > > > bhelgaas@google.com; lorenzo.pieralisi@arm.com; vkoul@kernel.org;
> > > > Marcel Ziswiler <marcel.ziswiler@toradex.com>; kishon@ti.com
> > > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > > linux-phy@lists.infradead.org; linux-arm-kernel@lists.infradead.org
> > > > Subject: Re: [PATCH v1 0/2] Fix the wrong order of phy callbacks
> > 
> > The above quoting style makes it harder than necessary to follow conversation.
> > See hints at:
> > 
> > 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wiki
> > pedia.org%2Fwiki%2FPosting_style%23Interleaved_style&amp;data=05%7C01
> > %7Chongxing.zhu%40nxp.com%7C70f38214c8f94c5932b408da8a991996%7C
> > 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637974687433589209
> > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> > JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ceZmDd
> > sNeC9nU6qmt2qXR03fQn33vY%2FqvBIYzeWW7mk%3D&amp;reserved=0
> > 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.
> > kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=05%7C01%7Chongxi
> > ng.zhu%40nxp.com%7C70f38214c8f94c5932b408da8a991996%7C686ea1d3b
> > c2b4c6fa92cd99c5c301635%7C0%7C0%7C637974687433589209%7CUnkno
> > wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=PkhpGGf7FcvsQTjc0
> > hUMpr9Q4JVKeFoLR4foA6zt6jg%3D&amp;reserved=0
> > 
> > The ideal thing would be something like this, where there's a single line for
> > each sender:
> > 
> > On Tue, Aug 30, 2022 at 07:50:55AM +0000, Hongxing Zhu wrote:
> > > On Tue, Aug 30, 2022, at 03:16PM, Ahmad Fatoum wrote:
> > > > On 30.08.22 05:47, Hongxing Zhu wrote:
> > > > > Do you mean to squash this fix to the preview series?
> > > > > I'm afraid that it's not easy to do that.
> > > > > Because there are a lot of pci-imx6 code changes after
> > > > > commit: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8
> > > > > pcie standalone phy driver").
> > > >
> > > > The way I understand it, if a bisect ends up between your two
> > > > patches, i.MX8M PCIe will be broken, whereas it worked before. I
> > > > thus wonder if we shouldn't instead squash this series here into a
> > > > single patch.
> > >
> > > Yes, it's a possible case when do the bisect.
> > > Since these changes are belong to different git repo.
> > 
> > I don't understand the point about different git repos.  Patch 1/2 touches
> > drivers/pci/controller/dwc/pci-imx6.c, patch 2/2 touches
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c.  They're in different directories,
> > of course, but are in the same Linux kernel source repo.
> > 
> > They're maintained by different people, but we can easily deal with that by
> > getting an ack from one and merging via the other.
> > 
> > > It will bring maintain difficulties if these two patches are squashed
> > > into a  single one.
> > > It's difficult to make a choice.
> > 
> > What maintenance difficulty do you see here?  I think it looks
> > *easier* if these are squashed -- that would avoid the possibility of backporting
> > one without the other, which would certainly be a problem.
> > 
> > If a bisect lands after patch 1/2 but before 2/2, it looks like i.MX8M will break
> > unnecessarily.
> > 
> > I think Ahmad is right that patches 1/2 and 2/2 should be squashed into a
> > single patch to avoid this bisection hole.
> Hi Bjorn:
> Thanks for your comments.
> My descriptions are not accurate enough. These two files are maintained by
>  different people, I'm afraid to bring troubles to the maintainers if
> I squash these two patch into a single one before.
> Now, I understood the situation.
> I'm glad to squash them to avoid the bisetion hole.

Are you sending an updated patch ?

Thanks,
Lorenzo
