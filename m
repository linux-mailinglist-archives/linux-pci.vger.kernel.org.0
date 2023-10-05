Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81957BA50F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbjJEQNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjJEQMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 12:12:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7220E54
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 08:30:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF0FC433C8;
        Thu,  5 Oct 2023 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696519845;
        bh=LmfNyPbOSeKnJZ7uRhbYxrU4BT2H6lZ5i0wAgmL22D0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Eo1pAO9oJUfDWBTATY0MSs+7M4DZ5HlB9Lh8HOPtrFWYm03jZJ2YHTuopkAtMvBZL
         yaKv0Eiz2o3f5/Cy5etNlbuOZLZjVxRbGPFBV/44Z/2G53WwMt/sqOtoLqoYy2VwWG
         qMD2swyye9f4ECpR0JvCf7EUxgHvnhzSOZeQ4OOK+t1hpNk1KGonBToxZrQZv0J9xS
         4ObxdfBwYmF+kWFIkt9rkpaSEpSRVkqW/Bp1y0noUN84J6H+QbWqTd7iCkxPEt+hf8
         oxKiyMwXl41IKQO0SdgkdvcWY0K4iw0xd6ciJ2PzkXR3G/irbVits8FfjRUzkw0TbD
         76mYOBc1x2kxw==
Date:   Thu, 5 Oct 2023 10:30:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20231005153043.GA746943@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005090258.GQ3208943@black.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 12:02:58PM +0300, Mika Westerberg wrote:
> On Wed, Oct 04, 2023 at 05:23:24PM -0500, Bjorn Helgaas wrote:
> ...

> The thing with TUXEDO is that on Thomas's system with mem_sleep=deep
> this patch (without denylist) breaks the resume as he describes here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=216877
> 
> However, on exact same TUXEDO system with the same firmwares Werner is
> not able to reproduce the issue with or without the patch. So I'm not
> sure what to do and that's why I added denylist that should take effect
> on Thomas' system when mem_sleep=deep is set but also work on the same
> system without it.
> 
> And since we have the denylist, I decided to add the ASUS there to avoid
> accidentally breaking those too.
> ...

> > I think there's still something we're missing.
> > 
> > We restore the LTR config before restoring DEVCTL2 (including the LTR
> > enable bit) and L1SS state.  I don't think we know the state of ASPM
> > and L1SS at that point, do we?  Do you think there could be an issue
> > there, too?
> 
> AFAICT LTR does not affect until it is explicitly enabled and I don't
> think many drivers actually program it (although we have some sort of
> API for it at least for Intel LPSS devices).

I couldn't find anything in the spec that suggests LTR should be an
issue.  I'm just grasping at straws here.

There's obviously *something* we're doing wrong because ASPM worked
before suspend, so we should be able to get it to work after resume.

Could we learn anything by dumping config space of the problem devices
before/after the suspend/resume and comparing them?

If we could figure out a difference between Werner's working TUXEDO
and Thomas' non-working TUXEDO, that might be a hint, too.

> If you have suggestions, I'm all open. If I understand you would like
> this to be done like:
> 
>   - Drop the denylist
>   - Add back the suspend/restore of L1SS
>   - Ask everyone in this thread to try it out
> 
> I can do that no problem but I guess that for the TUXEDO one (Thomas')
> it probably is going to fail still.

Right, without the denylist, I expect Thomas' TUXEDO to fail, but I
still hope we can figure out why.  If we just keep it on the denylist,
that system will suffer from more power consumption than necessary,
but only after suspend/resume.

A denylist seems like the absolute last resort.  In this case we don't
know about anything *wrong* with those platforms; all we know is that
our resume path doesn't work.  It's likely that it fails on other
platforms we haven't heard about, too.

Bjorn
