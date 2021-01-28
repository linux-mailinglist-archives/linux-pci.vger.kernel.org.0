Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F119307FDB
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 21:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhA1Usx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 15:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhA1Usr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 15:48:47 -0500
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jan 2021 12:48:07 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B837C061573
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2021 12:48:07 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 88190100D9410;
        Thu, 28 Jan 2021 21:39:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 383F811105F; Thu, 28 Jan 2021 21:39:29 +0100 (CET)
Date:   Thu, 28 Jan 2021 21:39:29 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Andy Lavr <andy.lavr@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, linux@yadro.com,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20210128203929.GB6613@wunner.de>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
 <20210128145316.GA3052488@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128145316.GA3052488@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 08:53:16AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 18, 2020 at 08:39:45PM +0300, Sergei Miroshnichenko wrote:
> > Currently PCI hotplug works on top of resources which are usually reserved:
> > by BIOS, bootloader, firmware, or by the kernel (pci=hpmemsize=XM). These
> > resources are gaps in the address space where BARs of new devices may fit,
> > and extra bus number per port, so bridges can be hot-added. This series aim
> > the BARs problem: it shows the kernel how to redistribute them on the run,
> > so the hotplug becomes predictable and cross-platform. A follow-up patchset
> > will propose a solution for bus numbers. And another one -- for the powerpc
> > arch-specific problems.
> 
> I can certainly see scenarios where this functionality will be useful,
> but the series currently doesn't mention bug reports that it fixes.  I
> suspect there *are* some related bug reports, e.g., for Thunderbolt
> hotplug.  We should dig them up, include pointers to them, and get the
> reporters to test the series and provide feedback.

In case it helps, an earlier version of the series was referenced
in this LWN article more than 2 years ago (scroll down to the
"Moving BARs" section at the end of the article):

https://lwn.net/Articles/767885/

The article provides some context:  Specifically, macOS is capable
of resizing and moving BARs, so this series sort of helps us catch
up with the competition.

With Thunderbolt, this series is particularly useful if
(a) PCIe cards are hot-added with large BARs (such as GPUs) and/or
(b) the Thunderbolt daisy-chain is very long.

Thunderbolt is essentially a cascade of nested hotplug ports,
so if more and more devices are added, it's easy to see that
the top-level hotplug port's BAR window may run out of space.

My understanding is that Sergei's use case doesn't involve
Thunderbolt at all but rather hotplugging of GPUs and network
cards in PowerPC servers in a datacenter, which may have the
same kinds of issues.

I intended to review and test this iteration of the series more
closely, but haven't been able to carve out the required time.
I'm adding some Thunderbolt folks to cc in the hope that they
can at least test the series on their development branch.
Getting this upstreamed should really be in the best interest
of Intel and other promulgators of Thunderbolt.

Thanks,

Lukas
