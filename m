Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E723078CB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhA1O4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 09:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232117AbhA1OyA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 09:54:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 330AF64DE0;
        Thu, 28 Jan 2021 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611845599;
        bh=nPiVwN9rBo2vc15h/UwsGsCVLK3WXzkJnEU6rg/dN3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jYYVuKlbp30uef0Web9NxSN2TMboUWpp1hnCA6flqRsKOG4qxXfvX4clGpau3QI3f
         /AxJuzttLw+5l/V5f6jg2h05BxFSm6k2KIurdbviQuAZdqXZxVJyOYgyc2KRbGtJOg
         X54FU41nsdLrJqniKhT6L+Urj8eFoBXSukkQ8IDDKFhpYb89PabffxzSXJvbOMQDPr
         SuXikE5LRkGPu+coIF2hgQ57qjylckN/OO+7hGR9+rpTE0Q1cAdFtPLiOWkkH5i751
         iA0KNL9yrSGfPYFtQkHzMm9PdzkD5f9wBGSyZORHI6tAROaRpi5yxOkzFmYtL7H3vr
         ChWzBUQOkebFg==
Date:   Thu, 28 Jan 2021 08:53:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, linux@yadro.com
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20210128145316.GA3052488@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 18, 2020 at 08:39:45PM +0300, Sergei Miroshnichenko wrote:
> Currently PCI hotplug works on top of resources which are usually reserved:
> by BIOS, bootloader, firmware, or by the kernel (pci=hpmemsize=XM). These
> resources are gaps in the address space where BARs of new devices may fit,
> and extra bus number per port, so bridges can be hot-added. This series aim
> the BARs problem: it shows the kernel how to redistribute them on the run,
> so the hotplug becomes predictable and cross-platform. A follow-up patchset
> will propose a solution for bus numbers. And another one -- for the powerpc
> arch-specific problems.

Hi Sergei,

It looks like there's a lot of good work here, but I don't really know
how to move forward with it.

I can certainly see scenarios where this functionality will be useful,
but the series currently doesn't mention bug reports that it fixes.  I
suspect there *are* some related bug reports, e.g., for Thunderbolt
hotplug.  We should dig them up, include pointers to them, and get the
reporters to test the series and provide feedback.

We had some review traffic on earlier versions, but as far as I can
see, nobody has stepped up with any actual signs of approval, e.g.,
Tested-by, Reviewed-by, or Acked-by tags.  That's a problem because
this touches a lot of sensitive code and I don't want to be stuck
fixing issues all by myself.  When issues crop up, I look to the
author and reviewers to help out.

Along that line, I'm a little concerned about how we will be able to
reproduce and debug problems.  Issues will likely depend on the
topology, the resources of the specific devices involved, and a
specific sequence of hotplug operations.  Those may be hard to
reproduce even for the reporter.  Maybe this is nothing more than a
grep pattern to extract relevant events from dmesg.  Ideal, but maybe
impractical, would be a way to reproduce things in a VM using qemu and
a script to simulate hotplugs.

> To arrange a space for BARs of new hot-added devices, the kernel can pause
> the drivers of working PCI devices and reshuffle the assigned BARs. When a
> driver is un-paused by the kernel, it should ioremap() the new addresses of
> its BARs.
> 
> Drivers indicate their support of the feature by implementing the new hooks
> .bar_fixed(), .rescan_prepare(), .rescan_done() in the struct pci_driver.
> If a driver doesn't yet support the feature, BARs of its devices are seen
> as immovable and handled in the same way as resources with the PCI_FIXED
> flag: they are guaranteed to remain untouched.
> 
> This approached was discussed during LPC 2020 [1].
> 
> The feature is usable not only for hotplug, but also for booting with a
> complete set of BARs assigned, and for Resizable BARs.

I'm interested in more details about both of these.  What does "a
complete set of BARs assigned" mean?  On x86, the BIOS usually assigns
all the BARs ahead of time, but I know that's not the case for all
arches.

For Resizable BARs, is the point that this allows more flexibility in
resizing BARs because we can now move things out of the way?

> Tested on a number of x86_64 machines without any special kernel command
> line arguments (some of them -- with older v8 revision of this patchset):
>  - PC: i7-5930K + ASUS X99-A;
>  - PC: i5-8500 + ASUS Z370-F;
>  - PC: AMD Ryzen 7 3700X + ASRock X570 + AMD 5700 XT (Resizable BARs);
>  - Supermicro Super Server/H11SSL-i: AMD EPYC 7251;
>  - HP ProLiant DL380 G5: Xeon X5460;
>  - Dell Inspiron N5010: i5 M 480;
>  - Dell Precision M6600: i7-2920XM.

Does this testing show no change in behavior and no regressions, or
does it show that this series fixes cases that previously did not
work?  If the latter, some bugzilla reports with before/after dmesg
logs would give some insight into how this works and also some good
justification.

> Also tested on a Power8 (Vesnin) and Power9 (Nicole) ppc64le machines, but
> with extra patchset, which is to be sent upstream a bit later.
> 
> The set contains:
>  01-02: Independent bugfixes, both are not related directly to the movable
>         BARs feature, but without them the rest of this series will not
> 	work as expected;
> 
>  03-14: Implement the essentials of the feature;
> 
>  15-21: Performance improvements for movable BARs and pciehp;
> 
>  22: Enable the feature by default;
> 
>  23-24: Add movable BARs support to nvme and portdrv;
> 
>  25-26: Debugging helpers.
> 
> This patchset is a part of our work on adding support for hot-adding
> chains of chassis full of other bridges, NVME drives, SAS HBAs, GPUs, etc.
> without special requirements such as Hot-Plug Controller, reservation of
> bus numbers or memory regions by firmware, etc.

This is a little bit of a chicken and egg situation.  I suspect many
people would like this functionality, but currently we either avoid it
because it's "known not to work" or we hack around it with the
firmware reservations you mention.

Bjorn
