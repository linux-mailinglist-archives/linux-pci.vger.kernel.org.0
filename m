Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1EC2FBA
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbfJAJLj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 05:11:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:34845 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfJAJLj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 05:11:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205029276"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 02:11:35 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 12:11:34 +0300
Date:   Tue, 1 Oct 2019 12:11:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
Message-ID: <20191001091134.GD2714@lahna.fi.intel.com>
References: <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com>
 <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
 <20190930092934.GT2714@lahna.fi.intel.com>
 <CACO55tu9M8_TWu2MxNe_NROit+d+rHJP5_Tb+t73q5vr19sd1w@mail.gmail.com>
 <20190930163001.GX2714@lahna.fi.intel.com>
 <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
 <20191001084651.GC2714@lahna.fi.intel.com>
 <CACO55ts9ommYbA5g4=G+f0G=v90qGM7EsurU7AL7bU=PFzQMnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55ts9ommYbA5g4=G+f0G=v90qGM7EsurU7AL7bU=PFzQMnw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 01, 2019 at 10:56:39AM +0200, Karol Herbst wrote:
> On Tue, Oct 1, 2019 at 10:47 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Sep 30, 2019 at 06:36:12PM +0200, Karol Herbst wrote:
> > > On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > >
> > > > On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > > > > still happens with your patch applied. The machine simply gets shut down.
> > > > >
> > > > > dmesg can be found here:
> > > > > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> > > >
> > > > Looking your dmesg:
> > > >
> > > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> > > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> > > > Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
> > > >
> > > > I would assume it runtime suspends here. Then it wakes up because of PCI
> > > > access from userspace:
> > > >
> > > > Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
> > > >
> > > > and for some reason it does not get resumed properly. There are also few
> > > > warnings from ACPI that might be relevant:
> > > >
> > > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > >
> > >
> > > afaik this is the case for essentially every laptop out there.
> >
> > OK, so they are harmless?
> >
> 
> yes
> 
> > > > This seems to be Dell XPS 9560 which I think has been around some time
> > > > already so I wonder why we only see issues now. Has it ever worked for
> > > > you or maybe there is a regression that causes it to happen now?
> > >
> > > oh, it's broken since forever, we just tried to get more information
> > > from Nvidia if they know what this is all about, but we got nothing
> > > useful.
> > >
> > > We were also hoping to find a reliable fix or workaround we could have
> > > inside nouveau to fix that as I think nouveau is the only driver
> > > actually hit by this issue, but nothing turned out to be reliable
> > > enough.
> >
> > Can't you just block runtime PM from the nouveau driver until this is
> > understood better? That can be done by calling pm_runtime_forbid() (or
> > not calling pm_runtime_allow() in the driver). Or in case of PCI driver
> > you just don't decrease the reference count when probe() ends.
> >
> 
> the thing is, it does work for a lot of laptops. We could only observe
> this on kaby lake and skylake ones. Even on Cannon Lakes it seems to
> work just fine.

Can't you then limit it to those?

I've experienced that Kabylake root ports can enter and exit in D3cold
just fine because we do that for Thunderbolt for example. But that
always requires help from ACPI. If the system is using non-standard ACPI
methods for example that may require some tricks in the driver side.

> > I think that would be much better than blocking any devices behind
> > Kabylake PCIe root ports from entering D3 (I don't really think the
> > problem is in the root ports itself but there is something we are
> > missing when the NVIDIA GPU is put into D3cold or back from there).
> 
> I highly doubt there is anything wrong with the GPU alone as we have
> too many indications which tell us otherwise.
> 
> Anyway, at this point I don't know where to look further for what's
> actually wrong. And apparently it works on Windows, but I don't know
> why and I have no idea what Windows does on such systems to make it
> work reliably.

By works you mean that Windows is able to put it into D3cold and back?
If that's the case it may be that there is some ACPI magic that the
Windows driver does and we of course are missing in Linux.
