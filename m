Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3B3189B7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 12:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBKLn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 06:43:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:25159 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhBKLlu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 06:41:50 -0500
IronPort-SDR: n8BL/aUGguU9epXZl2vi8ZILgCIXsr+Em1KsX6BNJpJ0NkBRSsMOXJmpbKTelJ/H7PLcr174G6
 56eZCkUR7DKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="267068026"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="267068026"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 03:39:48 -0800
IronPort-SDR: H4pUb/sNT5P4+5pxnOQaim8PI+F3swEsk366x71JUt/0t0kV+MyPrj6gTGJUy5SiHLlEzeBkZN
 XyAb9Heu/J8A==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="380566784"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 03:39:44 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 11 Feb 2021 13:39:41 +0200
Date:   Thu, 11 Feb 2021 13:39:41 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20210211113941.GF2542@lahna.fi.intel.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
 <20210128145316.GA3052488@bjorn-Precision-5520>
 <20210128203929.GB6613@wunner.de>
 <20210201125523.GN2542@lahna.fi.intel.com>
 <44ce19d112b97930b1a154740c2e15f3f2d10818.camel@yadro.com>
 <20210204104912.GE2542@lahna.fi.intel.com>
 <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc5d363476d445cfdf04b0ec4db9275db803af3.camel@yadro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Feb 10, 2021 at 07:40:06PM +0000, Sergei Miroshnichenko wrote:
> On Thu, 2021-02-04 at 12:49 +0200, Mika Westerberg
> wrote:
> > On Wed, Feb 03, 2021 at 08:17:14PM +0000, Sergei Miroshnichenko
> > wrote:
> > > On Mon, 2021-02-01 at 14:55 +0200, Mika Westerberg wrote:
> > > > On Thu, Jan 28, 2021 at 09:39:29PM +0100, Lukas Wunner wrote:
> > > > > On Thu, Jan 28, 2021 at 08:53:16AM -0600, Bjorn Helgaas wrote:
> > > > > > On Fri, Dec 18, 2020 at 08:39:45PM +0300, Sergei
> > > > > > Miroshnichenko
> > > > > > wrote:
> > > > > > > ...
> > > > > 
> > > > > I intended to review and test this iteration of the series more
> > > > > closely, but haven't been able to carve out the required time.
> > > > > I'm adding some Thunderbolt folks to cc in the hope that they
> > > > > can at least test the series on their development branch.
> > > > > Getting this upstreamed should really be in the best interest
> > > > > of Intel and other promulgators of Thunderbolt.
> > > > 
> > > > Sure. It seems that this series was submitted in December so
> > > > probably
> > > > not applicable to the pci.git/next anymore. Anyways, I can give
> > > > it a
> > > > try
> > > > on a TBT capable system if someone tells me what exactly to test
> > > > ;-)
> > > > Probably at least that the existing functionality still works but
> > > > something else maybe too?
> > > 
> > > For setups that worked fine, the only expected change is a possible
> > > little different BAR layout (in /proc/iomem), and there should the
> > > same
> > > quantity (or more) of BARs assigned than before.
> > > 
> > > But if there are any problematic setups, which weren't able to
> > > arrange
> > > new BARs, this patchset may push a bit further.
> > 
> > Got it.
> > 
> > > In a few days I'll provide an updated branch for our mirror of the
> > > kernel on Github, with a complete and bumped set of patches,
> > > reducing
> > > the steps required to test them.
> > 
> > Sounds good, thanks!
> 
> Hi Mika,
> 
> The branch is finally ready, so if you still have time for that, please
> take a look:
> 
> https://github.com/YADRO-KNS/linux/tree/yadro/pcie_hotplug/movable_bars_v9.1

Thanks for sharing!

I tried this series on top of v5.11-rc7 on a Dell XPS 9380 so that I
have two TBT3 devices connected. Each device includes PCIe switch and a
xHCI endpoint.

What I see that the hotplug downstream port does not have enough bus
numbers (and other resources allocated) so when attaching the second
device it does not fit there anymore. The resulting 'lspci -t' output
looks like below:

-[0000:00]-+-00.0
           +-02.0
           +-04.0
           +-08.0
           +-12.0
           +-14.0
           +-14.2
           +-15.0
           +-15.1
           +-16.0
           +-1c.0-[01]----00.0
           +-1c.6-[02]----00.0
           +-1d.0-[03-3b]----00.0-[04-3b]--+-00.0-[05]----00.0
           |                               +-01.0-[06-1f]----00.0-[07-09]--+-02.0-[08]----00.0
           |                               |                               \-04.0-[09]----00.0-[0a]--
           |                               +-02.0-[20]----00.0
           |                               \-04.0-[21-3b]--
           +-1d.4-[3c]----00.0
           +-1f.0
           +-1f.3
           +-1f.4
           \-1f.5

So the last PCIE switch is not visible anymore, and the xHCI on the
second TBT device is not functional either.

On the mainline kernel I get this:

-[0000:00]-+-00.0
           +-02.0
           +-04.0
           +-08.0
           +-12.0
           +-14.0
           +-14.2
           +-15.0
           +-15.1
           +-16.0
           +-1c.0-[01]----00.0
           +-1c.6-[02]----00.0
           +-1d.0-[03-3b]----00.0-[04-3b]--+-00.0-[05]----00.0
           |                               +-01.0-[06-1f]----00.0-[07-1f]--+-02.0-[08]----00.0
           |                               |                               \-04.0-[09-1f]----00.0-[0a-1f]--+-02.0-[0b]----00.0
           |                               |                                                               \-04.0-[0c-1f]--
           |                               +-02.0-[20]----00.0
           |                               \-04.0-[21-3b]--
           +-1d.4-[3c]----00.0
           +-1f.0
           +-1f.3
           +-1f.4
           \-1f.5

In this topology I can add yet another TBT device and there are still
resources available and all the endpoints are functional too.

I can send you the full dmesg and lspci -vv output if needed.
