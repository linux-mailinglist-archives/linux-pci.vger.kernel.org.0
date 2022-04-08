Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D2D4F907E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiDHIPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiDHIPN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 04:15:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC65D1A3
        for <linux-pci@vger.kernel.org>; Fri,  8 Apr 2022 01:13:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ncjjg-0007iG-8O; Fri, 08 Apr 2022 10:12:52 +0200
Message-ID: <4f8f93c51fedc84d94534e962bc7c68c4a4e5616.camel@pengutronix.de>
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
Date:   Fri, 08 Apr 2022 10:12:49 +0200
In-Reply-To: <AS8PR04MB86766041887E97E22B0AC8C48CE99@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <CAJ+vNU0McZxj_74DC0wCUyHq-NaT14URnvUP+kvudz7YLQq7fg@mail.gmail.com>
         <AS8PR04MB86766041887E97E22B0AC8C48CE99@AS8PR04MB8676.eurprd04.prod.outlook.com>
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

Am Freitag, dem 08.04.2022 um 03:14 +0000 schrieb Hongxing Zhu:
> > 
[...]
> > Richard,
> > 
> > Thanks for working on this!
> > 
> > Do you plan on submitting another version soon? I've tried to test this with an
> > imx8mp board I'm bringing up and while the host controller enumerates I fail
> > to get a link to a device. It's very likely I am missing something as this series
> > depends on the IMX8MP blk-ctrl and gpc series which I also can't cleanly apply.
> > Lucas just submitted a 'consolidated i.MX8MP HSIO/MEDIA/HDMI blk-ctrl
> > series' [1] yet I can't find a repo/branch that applies to either.
> > 
> > Perhaps you have a git repo somewhere I can look at while we wait for
> > imx8mp blk-ctl/gpc to settle and you to submit a v3?
> Hi Tim:
> Thanks for your kindly help to do the tests.
> I had listed the dependencies in the cover-letter log.
> Alexander and I used to test this series commits based on the V5.17 kernel.
> 
> Lucas had provided some review comments and suggestions about the PLL bits
>  manipulations of HSIOMIX in i.MX8MP PCIe PHY driver #3 of this series.
> And he suggested to let the HSIOMIX blk-ctrl make this PLL as a real clock,
>  and used by i.MX8MP PCIe PHY driver later.
> 
> Although I have some confusions, it's better let's wating for the blk-ctrl
> settle down and get clear discussion with Lucas later.
> How do you think about that?

Just to let you know my plans: I was quite busy with getting the
i.MX8MP HDMI part to work. Now that this is at least in a state where
it can collect some feedback from upstream I have some time to circle
back to this topic. I can't commit to do it immediately, but I'll get
around to looking at the PCIe series a bit more in-depth and apply my
HSIO PLL suggestion to the blk-ctrl driver during the next week.

Regards,
Lucas

