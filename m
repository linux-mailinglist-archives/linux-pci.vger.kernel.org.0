Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDBC5FA70E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Oct 2022 23:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJJVga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Oct 2022 17:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJJVgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Oct 2022 17:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF147D781;
        Mon, 10 Oct 2022 14:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9FD60F66;
        Mon, 10 Oct 2022 21:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B78BC43470;
        Mon, 10 Oct 2022 21:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665437778;
        bh=cKD9beUox1BasmA2rdg6BBwLnZXOcROsJgR89GU+KyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Nt9b4AziSTJzIuVOCG7x+qhZ9AgmlgLrLgQ1tpqC2L3BTWpm4rWDYxkc9jZgZeWB7
         099I6vjM0d6YQYMjm8HSIUjX5UiwqNLB9UWsYByWaLf4pGwmdZGOF3sbRluP4SdT0P
         1+g30KY6DTWyCWhq4Csv/fz/nl8E7gPC+3VmfLl8nh4MnphpyB5fBsYOyr0/hYt92t
         I5xaesWgzug0PAKetDhIqa6mKBZN72HKjdvFp2V5T2MeeuXl2E5/9E2Nh8qk+81Aow
         O5xqU39/djgaRK/wFbyf4U3fvNTraqjVeDQxxjgG63+QMxBnvV09Vj5m2iW5Irxvi/
         BprVcGFDT7IDQ==
Date:   Mon, 10 Oct 2022 16:36:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Rogalski <rrogalski@tutanota.com>
Cc:     Linux Pci <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: Re: SPARC64: getting "no compatible bridge window" errors :/
Message-ID: <20221010213616.GA2937885@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003223500.GA2124698@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lijo]

On Mon, Oct 03, 2022 at 05:35:02PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 26, 2022 at 12:11:06PM -0500, Bjorn Helgaas wrote:
> > [+cc Alex, David, sparclinux, LKML]
> > 
> > On Sun, Sep 25, 2022 at 06:59:23PM +0200, Richard Rogalski wrote:
> > > I hope this is the right place for this.
> > 
> > This is great, thanks a lot for your report!  Is this a regression?
> > If so, what's the most recent kernel that worked?  
> > 
> > > In my dmesg output, I get things like:
> > > 
> > > pci 0000:04:00.0: can't claim VGA legacy [mem 0x000a0000-0x000bffff]: no compatible bridge window
> > > pci 0000:06:00.0: can't claim VGA legacy [mem 0x000a0000-0x000bffff]: no compatible bridge window
> > > pci 0000:06:00.1: can't claim BAR 0 [mem 0x84110200000-0x84110203fff 64bit]: no compatible bridge window
> > > 
> > > I opened a bug for amdgpu [here](https://gitlab.freedesktop.org/drm/amd/-/issues/2169) but looking further into it I think it is caused by deeper PCIe problems :\
> > > 
> > > https://gitlab.freedesktop.org/drm/amd/uploads/cbf47807972c8a990bb2a8cdbb39ad9e/8C7CA9QNG dmesg log
> > > https://gitlab.freedesktop.org/drm/amd/uploads/6a799425dea50febd82f8bc11e54433a/ll.txt lspci -vv
> > > https://gitlab.freedesktop.org/drm/amd/uploads/7d4a794b1f7d67a1ffcdee5dfdec3ad6/config.txt kernel .config
> > 
> > Your error output attachment [1] contains an address that looks like
> > it's in 06:00.0 BAR 5:
> > 
> >   pci 0000:06:00.0: reg 0x24: [mem 0x84001200000-0x8400123ffff]
> >   NON-RESUMABLE ERROR: insn effective address [0x0000084001201410]
> > 
> > This looks like an amdgpu issue.  There have been recent changes like
> > c1c39032a074 ("drm/amdgpu: make sure to init common IP before gmc")
> > and dd6aeb4e5f59 ("drm/amdgpu: Don't enable LTR if not supported")
> > that could be related.

Ping for any updates?  Added Lijo, who fixed the LTR issue.

> > The PCI "no compatible bridge window" warnings are definitely an
> > issue, but I don't think they're related to the amdgpu crash:
> > 
> >   pci@400: PCI MEM64 [mem 0x84100000000-0x84dffffffff] offset 80000000000
> >   pci_bus 0000:00: root bus resource [mem 0x84100000000-0x84dffffffff] (bus address [0x4100000000-0x4dffffffff])
> >   pci 0000:09:00.0: can't claim BAR 0 [mem 0x84120000000-0x8412007ffff 64bit]: no compatible bridge window
> > 
> > Those and this from lspci:
> > 
> >   0000:01:00.0 bridge to [bus 02-09] window [mem 0x4100000000-0x412fffffff pref]
> >   0000:02:0c.0 bridge to [bus 09]    window [mem 0x4120000000-0x412fffffff pref]
> >   0000:09:00.0 Intel 82599ES NIC Region 0: Memory at 0x84120000000
> > 
> > are telling us there's something wrong with how the resource-to-bus
> > offset is being applied.  It looks like the offset was applied to the
> > NIC BAR, but didn't get applied to the bridge windows.
> > 
> > Could you start a new thread here (linux-kernel@vger.kernel.org,
> > linux-pci@vger.kernel.org, and sparclinux@vger.kernel.org) for this
> > issue and attach the dmesg log when booting with "ofpci_debug=1"?
> 
> Any chance you could collect a dmesg log with "ofpci_debug=1"?
> 
> I'd like to look at the resource-to-bus offset issue.

I would still like to see this dmesg log if possible.

> > Do the devices we complain about (NICs and storage HBAs 09:00.0,
> > 09:00.1, 0d:00.0, 0d:00.1, 0e:00.0, 0f:00.0, 0001:03:00.0,
> > 0001:03:00.1, 0001:0:00.0, 0001:0a:00.1) work?
> > 
> > Bjorn
> > 
> > [1] https://gitlab.freedesktop.org/drm/amd/uploads/b51f4d6783eeebf90de9a400525d07d6/qq
