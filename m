Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8464F774806
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjHHTY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjHHTYK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46AD92C1
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 12:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689BE62B1C
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 19:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1392C433C7;
        Tue,  8 Aug 2023 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691522429;
        bh=6e39yrlLiKSrgUoZ2M444RyiaqrYu/3GKu7yzntRXUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knblRZFv4xYk3/h5YWLYc8x4JJSh6TrKafTMWGlNegq8YrscP7JgxPAYaCweHUb9c
         up+IHej4UtJ0ugwfumzqV117J24Uv/9gCDAPUCDrpd6oBmAsnUZD4Mdj5OWrO31trC
         WlGHJzzMgIex59by5WFzDreSe5PNILNBk5Bgl3D4H3nqTAeqRc2Pddcoewn2NRlx8G
         OJLhVrLU3pr/3MsTR05y0I6ou0LnaizgEFDgsNKbeT2FwMiac4YPOuuNi8qP4OrIHo
         uLBn6p2MJ3KDdeSV6NOb4YsWsqiiVyw6nBN7EDT+wQcZrTMnBKcLU2jozjd5vLL1uO
         SVNH6il+YDgXw==
Received: by pali.im (Postfix)
        id DC11A687; Tue,  8 Aug 2023 21:20:26 +0200 (CEST)
Date:   Tue, 8 Aug 2023 21:20:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kwilczynski@kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808192026.t65ebdii5bv2xx5b@pali>
References: <20230808072605.n3rjfsxuogza7qth@pali>
 <20230808162627.GA314706@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808162627.GA314706@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 08 August 2023 11:26:27 Bjorn Helgaas wrote:
> [+cc linux-arm-kernel, beginning of thread:
> https://lore.kernel.org/r/20230114164125.1298-1-pali@kernel.org]
> 
> On Tue, Aug 08, 2023 at 09:26:05AM +0200, Pali Rohár wrote:
> > On Friday 04 August 2023 12:35:13 Russell King (Oracle) wrote:
> > ...
> 
> > > For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> > > platform, and this works fine.
> > > 
> > > Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> > > NAS platform that is connected to PCIe, and removing PCIe support
> > > effectively makes his platform utterly useless.
> > > 
> > > Please revert this patch.
> > 
> > Please do not revert it, instead start fixing problems.
> 
> We know that like all the other drivers, the mvebu driver isn't
> perfect.  But I don't think effectively removing the driver completely
> helps anybody.  If people try to use it and notice problems, we have a
> chance to try to fix them.

I do not want to remove it. I was trying to find somebody who can start
caring about issues. In last year I was resending patches, some smaller
which could improve situation, but most of them were ignored or rejected.

So I'm here and waiting for alternatives, and I'm prepared to review
changes and patches for mvebu, which can improve driver support.

But I do not see anything. The only one who wrote something useful was
Uwe as he wanted to do some git bisect (which normally indicates issues
or also fixup/patch).

Also some times ago Greg wrote something like that (mainline) kernel is
place for unsupported and broken drivers. But mvebu is going in this
direction.

How can I otherwise point out to start doing something in this area?

Or are you unhappy with the fact that there is at least somebody (me)
who is willing to do patch review for this marvell stuff? You should
have said it to me earlier.

But as I'm reading now, that I should go away, maybe you should have to
find also new reviewer for driver. Good luck here as there was nobody
who even wanted to do anything in this area.

> Or maybe I'm missing your point.  I think you're suggesting that we
> keep pci-mvebu in the tree but unselectable because it depends on
> CONFIG_BROKEN.  What would be the advantage of doing that?
> 
> Bjorn

Well, all knows here that driver is in bad state. In past there were
regressions and no accepted fixes for it. (At that time I prepared fix,
but you did not like it and nobody else comes with other alternative
patch).

There area other options which can be done now, if there are only people
like Russel who are complaining but refusing to do absolutely nothing.
For example mark driver as experimental (there is some Kconfig symbol
for it). Or add a new menuconfig selectable symbol which appropriately
warn all distributions about problems and would be dependency for mvebu.
(if you do not like broken symbol).
