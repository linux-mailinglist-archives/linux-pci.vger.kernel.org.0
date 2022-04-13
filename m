Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB34FF079
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiDMHYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 03:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiDMHYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 03:24:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE034BFC4
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 00:22:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1neXK8-0002PA-B8; Wed, 13 Apr 2022 09:21:56 +0200
Message-ID: <b112c517d5ee86ef09088ed3cc00291417101a6e.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/7] Add the iMX8MP PCIe support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Date:   Wed, 13 Apr 2022 09:21:53 +0200
In-Reply-To: <AS8PR04MB867606A1E2E45A0C0A1525A48CEA9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <CAJ+vNU0McZxj_74DC0wCUyHq-NaT14URnvUP+kvudz7YLQq7fg@mail.gmail.com>
         <AS8PR04MB86766041887E97E22B0AC8C48CE99@AS8PR04MB8676.eurprd04.prod.outlook.com>
         <4f8f93c51fedc84d94534e962bc7c68c4a4e5616.camel@pengutronix.de>
         <AS8PR04MB867606A1E2E45A0C0A1525A48CEA9@AS8PR04MB8676.eurprd04.prod.outlook.com>
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

Hi Richard,

Am Montag, dem 11.04.2022 um 03:32 +0000 schrieb Hongxing Zhu:
> > -----Original Message-----
> > From: Lucas Stach <l.stach@pengutronix.de>
> > Sent: 2022年4月8日 16:13
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>; tharvey@gateworks.com;
> > Alexander Stein <alexander.stein@ew.tq-group.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>; bhelgaas@google.com;
> > Lorenzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; Rob Herring
> > <robh@kernel.org>; Shawn
> > Guo <shawnguo@kernel.org>; Vinod Koul <vkoul@kernel.org>;
> > linux-phy@lists.infradead.org; Device Tree Mailing List
> > <devicetree@vger.kernel.org>; linux-pci@vger.kernel.org; Linux ARM
> > Mailing
> > List <linux-arm-kernel@lists.infradead.org>; open list
> > <linux-kernel@vger.kernel.org>; Sascha Hauer
> > <kernel@pengutronix.de>;
> > dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v2 0/7] Add the iMX8MP PCIe support
> > 
> > Am Freitag, dem 08.04.2022 um 03:14 +0000 schrieb Hongxing Zhu:
> > > > 
> > [...]
> > > > Richard,
> > > > 
> > > > Thanks for working on this!
> > > > 
> > > > Do you plan on submitting another version soon? I've tried to
> > > > test
> > > > this with an imx8mp board I'm bringing up and while the host
> > > > controller enumerates I fail to get a link to a device. It's
> > > > very
> > > > likely I am missing something as this series depends on the
> > > > IMX8MP blk-ctrl
> > and gpc series which I also can't cleanly apply.
> > > > Lucas just submitted a 'consolidated i.MX8MP HSIO/MEDIA/HDMI
> > > > blk-ctrl series' [1] yet I can't find a repo/branch that
> > > > applies to either.
> > > > 
> > > > Perhaps you have a git repo somewhere I can look at while we
> > > > wait
> > > > for imx8mp blk-ctl/gpc to settle and you to submit a v3?
> > > Hi Tim:
> > > Thanks for your kindly help to do the tests.
> > > I had listed the dependencies in the cover-letter log.
> > > Alexander and I used to test this series commits based on the
> > > V5.17 kernel.
> > > 
> > > Lucas had provided some review comments and suggestions about the
> > > PLL
> > > bits
> > >  manipulations of HSIOMIX in i.MX8MP PCIe PHY driver #3 of this
> > > series.
> > > And he suggested to let the HSIOMIX blk-ctrl make this PLL as a
> > > real
> > > clock,
> > >  and used by i.MX8MP PCIe PHY driver later.
> > > 
> > > Although I have some confusions, it's better let's wating for the
> > > blk-ctrl settle down and get clear discussion with Lucas later.
> > > How do you think about that?
> > 
> > Just to let you know my plans: I was quite busy with getting the
> > i.MX8MP
> > HDMI part to work. Now that this is at least in a state where it
> > can collect
> > some feedback from upstream I have some time to circle back to this
> > topic. I
> > can't commit to do it immediately, but I'll get around to looking
> > at the PCIe
> > series a bit more in-depth and apply my HSIO PLL suggestion to the
> > blk-ctrl
> > driver during the next week.
> 
> Hi Lucas:
> Thanks for your helpful reply.
> I know that you're busy with the blk-ctrl settle down now, and had
> explained to
> Tim.

Yesterday I tried to get this series working on my 8MP-EVK board, but
was unsuccessful for now. The PCIe link does not come up. PCIe REF_CLK
is present and PERST de-asserted. I'm not sure if this is due to a
faulty EP device (I don't have another M.2 KeyE device around to check)
or if this may be due to the old revision of my 8MP-EVK, as I'm still
working with a RevA board. The schematic revision log doesn't show
anything that would obviously influence PCIe operation, but I have also
not found any schematics for RevA.

Do you know if there have been any PCIe related changes/fixes in the
later EVK board revisions?

For now I'll try to get this working on a custom i.MX8MP board, where I
can use a different EP device. Maybe I'll have a bit more luck there.

Regards,
Lucas

