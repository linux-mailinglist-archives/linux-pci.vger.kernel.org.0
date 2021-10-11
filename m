Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE2428D05
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhJKMcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhJKMcl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 08:32:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D44C061570
        for <linux-pci@vger.kernel.org>; Mon, 11 Oct 2021 05:30:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mZuRt-0008OU-8K; Mon, 11 Oct 2021 14:30:33 +0200
Message-ID: <2eee557db84087acca4665603ba3d2716199f842.camel@pengutronix.de>
Subject: Re: [PATCH 0/6] Add IMX8M Mini PCI support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, Tim Harvey <tharvey@gateworks.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Mon, 11 Oct 2021 14:30:31 +0200
In-Reply-To: <CAHCN7xLC1ob_nxRsZezgYQ9p-me7hNd+1MNFQt2wtcRqU+z9Sw@mail.gmail.com>
References: <20210723204958.7186-1-tharvey@gateworks.com>
         <36070609-9f1f-00c8-ccf5-8ed7877b29da@pengutronix.de>
         <VI1PR04MB58533AF76EA4DFD8AD6CDA158CEC9@VI1PR04MB5853.eurprd04.prod.outlook.com>
         <CAJ+vNU1tgVsQWtxa0E8SArO=hA2K8OkqiSPrRSpx0Q5XS4gUWA@mail.gmail.com>
         <CAHCN7xLC1ob_nxRsZezgYQ9p-me7hNd+1MNFQt2wtcRqU+z9Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Adam,

Am Montag, dem 11.10.2021 um 07:25 -0500 schrieb Adam Ford:
> On Mon, Aug 16, 2021 at 10:45 AM Tim Harvey <tharvey@gateworks.com> wrote:
> > 
> > On Thu, Jul 29, 2021 at 6:28 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> > > 
> > > Hi Tim:
> > > Just as Ahmad mentioned, Lucas had issue one patch-set to support i.MX8MM PCIe.
> > > Some comments in the review cycle.
> > > - One separate PHY driver should be used for i.MX8MM PCIe driver.
> > > - Schema file should be used I think, otherwise the .txt file in the dt-binding.
> > > 
> > > I'm preparing one patch-set, but it's relied on the yaml file exchanges and power-domain changes(block control and so on).
> > > Up to now, I only walking on the first step, trying to exchange the dt-binding files to schema yaml file.
> > > 
> > > Best Regards
> > > Richard Zhu
> > 
> > Richard / Ahmad,
> > 
> > Thanks for your response - I did not see the series from Lucas. I will
> > drop this and wait for him to complete his work.
> > 
> 
> Tim,
> 
> It appears that the power domain changes have been applied to Shawn's
> for-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=for-next
> 
> Is there any chance you could rebase and resend this series?

This wasn't about the power domain series. I also tried to get i.MX8M
PCIe upstream, but the feedback was that we need to split out the PHY
functionality, Richard is currently working on this. There is no point
in resending this series.

Regards,
Lucas

