Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1030A826
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 13:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhBAM5Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 07:57:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:43643 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231965AbhBAM5S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 07:57:18 -0500
IronPort-SDR: zucFqhekyCJdXY2ngokoJcy0FjuZMpzXR5RUeV/BMH5X8A+imGnPq3RhSpZ2GggkPZOZ0jCOlX
 pXnAYW/KZr9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="244760734"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="244760734"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:55:29 -0800
IronPort-SDR: HXfPiJhpJpd7fKHTjPK89vk8V1sQE//dMcTmyPWoo4FFKm1h71NOBJjdITieReIR6E8lVlsPoW
 EudHPkghjwsA==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="369845321"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 04:55:25 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 01 Feb 2021 14:55:23 +0200
Date:   Mon, 1 Feb 2021 14:55:23 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Andy Lavr <andy.lavr@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@aculab.com>,
        Rajat Jain <rajatja@google.com>, linux@yadro.com,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20210201125523.GN2542@lahna.fi.intel.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
 <20210128145316.GA3052488@bjorn-Precision-5520>
 <20210128203929.GB6613@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128203929.GB6613@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jan 28, 2021 at 09:39:29PM +0100, Lukas Wunner wrote:
> On Thu, Jan 28, 2021 at 08:53:16AM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 18, 2020 at 08:39:45PM +0300, Sergei Miroshnichenko wrote:
> > > Currently PCI hotplug works on top of resources which are usually reserved:
> > > by BIOS, bootloader, firmware, or by the kernel (pci=hpmemsize=XM). These
> > > resources are gaps in the address space where BARs of new devices may fit,
> > > and extra bus number per port, so bridges can be hot-added. This series aim
> > > the BARs problem: it shows the kernel how to redistribute them on the run,
> > > so the hotplug becomes predictable and cross-platform. A follow-up patchset
> > > will propose a solution for bus numbers. And another one -- for the powerpc
> > > arch-specific problems.
> > 
> > I can certainly see scenarios where this functionality will be useful,
> > but the series currently doesn't mention bug reports that it fixes.  I
> > suspect there *are* some related bug reports, e.g., for Thunderbolt
> > hotplug.  We should dig them up, include pointers to them, and get the
> > reporters to test the series and provide feedback.
> 
> In case it helps, an earlier version of the series was referenced
> in this LWN article more than 2 years ago (scroll down to the
> "Moving BARs" section at the end of the article):
> 
> https://lwn.net/Articles/767885/
> 
> The article provides some context:  Specifically, macOS is capable
> of resizing and moving BARs, so this series sort of helps us catch
> up with the competition.
> 
> With Thunderbolt, this series is particularly useful if
> (a) PCIe cards are hot-added with large BARs (such as GPUs) and/or
> (b) the Thunderbolt daisy-chain is very long.
> 
> Thunderbolt is essentially a cascade of nested hotplug ports,
> so if more and more devices are added, it's easy to see that
> the top-level hotplug port's BAR window may run out of space.
> 
> My understanding is that Sergei's use case doesn't involve
> Thunderbolt at all but rather hotplugging of GPUs and network
> cards in PowerPC servers in a datacenter, which may have the
> same kinds of issues.
> 
> I intended to review and test this iteration of the series more
> closely, but haven't been able to carve out the required time.
> I'm adding some Thunderbolt folks to cc in the hope that they
> can at least test the series on their development branch.
> Getting this upstreamed should really be in the best interest
> of Intel and other promulgators of Thunderbolt.

Sure. It seems that this series was submitted in December so probably
not applicable to the pci.git/next anymore. Anyways, I can give it a try
on a TBT capable system if someone tells me what exactly to test ;-)
Probably at least that the existing functionality still works but
something else maybe too?
