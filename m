Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95DA4C3380
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 18:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiBXRWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 12:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiBXRWM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 12:22:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703F52E6E
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 09:21:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FC9C61A8E
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 17:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B3EC340E9;
        Thu, 24 Feb 2022 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645723299;
        bh=0DvAwOYRhr/x4Z8RjLyIHitIvW2rgVY4my4bYOvYKUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntSSReLMHcbBQHUBMTCYVDrzvSSn44hsBQFxzZlidhq70sQM38Wvcplme2LvGsIRa
         roiZ0BAY9FN0HD8IgE7vg33Zn1Xx27d0LAPB6O7/MCciZwV6//sFNfhd11+9WIxSq5
         20cU4ISuaEkKa3uvT9i2NMZuv3fFO/RhT3noL5SOD/ziQ3sgzYJ7UDZ4Cbq1Oovq1O
         4nAxdYdg8WbPgKXukTmia8wiAG61cow+/s0wdUY0+SfPnJ5P/WJCHw9/yUpXu0mUtD
         /B7TlcXRXPNk8I86aKsxZnNxOD91XYfKNR6C3uom8rzSOVNf72J2ZY6icllEYsEOMy
         y6PCXihbPSLfg==
Received: by pali.im (Postfix)
        id A5BEAB6E; Thu, 24 Feb 2022 18:21:36 +0100 (CET)
Date:   Thu, 24 Feb 2022 18:21:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marcel Menzel <mail@mcl.gg>, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: Kernel 5.16.3 and above fails to detect PCIe devices on Turris
 Omnia (Armada 385 / mvebu)
Message-ID: <20220224172136.ydx4wu7avmfq4ndt@pali>
References: <d4dd76f4-19e4-c35a-bd46-6e014707402e@mcl.gg>
 <20220224162532.GA274119@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224162532.GA274119@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 February 2022 10:25:32 Bjorn Helgaas wrote:
> On Thu, Feb 24, 2022 at 05:00:30PM +0100, Marcel Menzel wrote:
> > +linux-pci
> > 
> > Am 24.02.2022 um 14:52 schrieb Marcel Menzel:
> > > Am 24.02.2022 um 14:09 schrieb Marcel Menzel:
> > > > Hello,
> > > > 
> > > > When upgrading from kernel 5.16.2 to a newer version (tried 5.16.3
> > > > and 5.16.10 with unchanged .config), the Kernel fails to detect both
> > > > my installed mPCIe WiFi cards in my Turris Omnia (newer version,
> > > > silver case, GPIO pins installed again).
> > > > I have two Mediatek MT7915 based cards installed. I also tried with
> > > > one Atheros at9k and one ath10k based card, yielding the same
> > > > result. On a Kernel version newer than 5.16.2, all cards aren't
> > > > getting recognized correctly.
> > > > 
> > > > Before 5.16.3 I also had to disable PCIe ASPM via boot aragument,
> > > > otherwise the WiFi drivers would complain about weird device
> > > > behaviors and failing to initialize them, but re-enabling it does
> > > > not yield any different results.
> 
> Please try this commit, which is headed to mainline today:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=c49ae619905eebd3f54598a84e4cd2bd58ba8fe9
> 
> This commit should fix the PCI enumeration problem.

It should fix that regression. If not, please let me know.

> If you still have
> to disable ASPM, that sounds like a separate problem that we should
> also try to debug.

This is different and known issue and **not** related to ASPM. I spend
some time on it, initially I thought it is bug in Atheros cards, but now
I'm in impression that this is issue in Marvell PCIe HW that link
retraining (required step of ASPM) triggers either Link Down or Hot
Reset which triggers another Atheros issue (this one is already
documented in kernel pci quirks code).

I will try to implement some workaround for this but requirement is to
have all new improvements in pci-mvebu.c + pci-aardvark.c drivers... and
review process is slow. So it would not be before all those changes are
reviewed and merged.
