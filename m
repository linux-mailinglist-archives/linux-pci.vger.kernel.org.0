Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72227F585
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgI3Wv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731808AbgI3Wv4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 18:51:56 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C272F20719;
        Wed, 30 Sep 2020 22:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601506316;
        bh=KFmouRsvBVZ3Y/PYT9xJnwdLHua2k27n0cu1H9BZ6l8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ErCOiYuE3T/ukx2QVvOYx3P0p85+8zd+cviA6M2gceIzSfDLjPA9npAn6qBYwnZ64
         D8WZF8dQV6bbmloxOP+jC9nRt+BSSIUUmr/oIZ34jAPvXpKNwOIl5kUOFbSrvWE/mR
         Z4k8wm4xr98IWOFHxbMljjMiI7xM95LPcjIeY/qk=
Date:   Wed, 30 Sep 2020 17:51:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Android Kernel Team <kernel-team@android.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] of: address: Work around missing device_type property
 in pcie nodes
Message-ID: <20200930225154.GA2631019@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+xBKbYXWipwmZ=ZidorsMUFDw2NpUyxobx4FCTn+8Hmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 03:34:10PM -0500, Rob Herring wrote:
> On Wed, Sep 30, 2020 at 12:37 PM Niklas Söderlund
> <niklas.soderlund@ragnatech.se> wrote:
> >
> > Hi Marc,
> >
> > On 2020-09-30 18:23:21 +0100, Marc Zyngier wrote:
> > > Hi Niklas,
> > >
> > > [+ Samuel]
> > >
> > > On 2020-09-30 17:27, Niklas Söderlund wrote:
> > > > Hi Marc,
> > > >
> > > > I'm afraid this commit breaks booting my rk3399 device.
> > > >
> > > > I bisected the problem to this patch merged as [1]. I'm testing on a
> > > > Scarlet device and I'm using the unmodified upstream
> > > > rk3399-gru-scarlet-inx.dtb for my tests.
> > > >
> > > > The problem I'm experience is a black screen after the bootloader and
> > > > the device is none responsive over the network. I have no serial console
> > > > to this device so I'm afraid I can't tell you if there is anything
> > > > useful on to aid debugging there.
> > > >
> > > > If I try to test one commit earlier [2] the system boots as expected and
> > > > everything works as it did for me in v5.8 and earlier. I have worked
> > > > little with this device and have no clue about what is really on the PCI
> > > > buss. But running from [2] I have this info about PCI if it's helpful,
> > > > please ask if somethings missing.
> > >
> > > Please see the thread at [1]. The problem was reported a few weeks back
> > > by Samuel, and I was expecting Rob and Lorenzo to push a fix for this.
> >
> > Thanks for providing a solution.
> >
> > >
> > > Rob, Lorenzo, any update on this?
> 
> The fix is in Bjorn's tree[1].
> 
> Bjorn, going to send this to Linus before v5.9 is out?

Definitely, thanks for the reminder.  I'm assuming the fix in question
is https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=e338eecf3fe79054e8a31b8c39a1234b5acfdabe

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=for-linus
