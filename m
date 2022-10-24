Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2860B917
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 22:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJXUDJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiJXUC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 16:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF31DEC3C;
        Mon, 24 Oct 2022 11:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AD1D6142F;
        Mon, 24 Oct 2022 18:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709FBC433D6;
        Mon, 24 Oct 2022 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666635281;
        bh=HUCPdxjSypEvtWJdEnkiifCdgEXKyFFcsRSmCFbXjCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=df93AYSk6R3l9npPNyEXFKQbgPw1Da53l2wrgpww1kK4SepvefeMrjX32NBhD8Tou
         t846DZCGbQe77a5Jiuf3/OsP9zRHu8iMycUZNMa8Yx+PDsLfXXNz1icLdoRacY2q5K
         LFpFb/nI4dHrfZZxI6DjM99QMGAP6e5PaPkgW1C7FHi0lRuIBs0w3VPGWMz34uKB8t
         T2VsWy40NhUGGK8lB0ZRgpq7aM4cAk9/r8WUxf8mUpLY1g0BAa4QKGa3vDeRc9e5Qb
         masfXsCJ2ZqRVk+paroApIxOGz4KLv0lWaDhF0nLJxlLvG+4ryXopu6JIvQ4SVkrkc
         Q5qmP6pWAPkvw==
Date:   Mon, 24 Oct 2022 13:14:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Rogalski <rrogalski@tutanota.com>
Cc:     alexander.deucher@amd.com, davem@davemloft.net, lijo.lazar@amd.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: SPARC64: getting "no compatible bridge window" errors :/
Message-ID: <20221024181439.GA562211@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <NEsdtVI--3-9@tutanota.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 21, 2022 at 05:47:59AM +0200, Richard Rogalski wrote:
> Hello, very very sorry about the late reply. Life has been hectic. Also, not sure if this is how I reply to one of these, sorry if I screwed it up :)
> 
> > This is great, thanks a lot for your report!  Is this a regression?
> 
> Believe it or not, I am a brand new SPARC user :). So I can't say
> right now. Should I try a few old kernel releases to check?

I wouldn't bother trying older kernels.  In fact, I just noticed that
you're running a 5.15 kernel, which is about a year old.  It would be
much more interesting to try to reproduce the problem on a current
kernel, e.g., v6.0.

At https://packages.gentoo.org/packages/sys-kernel/gentoo-kernel, it
doesn't look like sparc gets much attention ;)

> > Any chance you could collect a dmesg log with "ofpci_debug=1"?
> 
> https://gitlab.freedesktop.org/drm/amd/uploads/0ed3c92921d7f88b06654b5f46e9756d/dmesg
> 
> > Do the devices we complain about (NICs and storage HBAs 09:00.0, 
> > 09:00.1, 0d:00.0, 0d:00.1, 0e:00.0, 0f:00.0, 0001:03:00.0, 
> > 0001:03:00.1, 0001:0:00.0, 0001:0a:00.1) work?
> 
> Well, I don't have any fiber optic equipment: these just came with
> the server. Also it has wayy too many NICs. I can't quite say.
> However... for the HBAs, that's where my root is :O. This is mildly
> concerning :D.

I spent way too long looking at these PCI resource weirdnesses.
Bottom line: ignore them.

From your ofpci_debug dmesg log (annotated with logging the PCI core
would do if it were doing this instead of the sparc OF code):

  pci@400: PCI MEM   [mem 0x84000100000-0x8407f7fffff] offset 84000000000
  pci@400: PCI MEM64 [mem 0x84100000000-0x84dffffffff] offset 80000000000
  pci_bus 0000:00: root bus resource [mem 0x84000100000-0x8407f7fffff] (bus address [0x00100000-0x7f7fffff])
  pci_bus 0000:00: root bus resource [mem 0x84100000000-0x84dffffffff] (bus address [0x4100000000-0x4dffffffff])

  pci 0000:04:00.0: can't claim VGA legacy [mem 0x000a0000-0x000bffff]: no compatible bridge window

    This one happens because according to OF, there is no bridge
    aperture to the PCI bus 0xa0000-0xbffff region.  The only accessible
    PCI bus regions are [0x00100000-0x7f7fffff] and
    [0x4100000000-0x4dffffffff].  Probably an OF defect.

  pci 0000:02:0c.0: PCI bridge to [bus 09]
  pci 0000:02:0c.0:       Using flags[0010220c] start[0000004120000000] size[0000000010000000]
  pci 0000:02:0c.0:   bridge window [mem 0x84120000000-0x8412fffffff 64bit pref]
  pci 0000:09:00.0: can't claim BAR 0 [mem 0x84120000000-0x8412007ffff 64bit]: no compatible bridge window

    These and similar warnings happen because OF says the upstream
    bridge window is prefetchable, but this is a non-prefetchable BAR.
    These likely work fine because in most cases prefetching will not
    occur on PCIe, even though the bridge window allows it.

So the warnings above are mostly harmless.  If you were to hot-add
something, there could be issues because we aren't keeping track of
the space these devices use.

lspci on sparc is unusual: it shows PCI bus addresses, not CPU
physical addresses like other arches [1], which means we see things
like this in dmesg, which shows the CPU physical address:

  pci_bus 0000:00: root bus resource [mem 0x84000100000-0x8407f7fffff] (bus address [0x00100000-0x7f7fffff])
  pci 0000:04:00.0: reg 0x10: [mem 0x84000800000-0x84000ffffff]

and this in lspci, which is the PCI bus address:

  0000:04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 10) (prog-if 00 [VGA controller])
      Region 0: Memory at 00800000 (32-bit, non-prefetchable) [size=8M]

Annoying but harmless.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?id=v5.18#n1
