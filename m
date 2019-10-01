Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0871EC2F23
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 10:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfJAIq5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 04:46:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:13027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfJAIq5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 04:46:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 01:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205026256"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 01:46:52 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 11:46:51 +0300
Date:   Tue, 1 Oct 2019 11:46:51 +0300
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
Message-ID: <20191001084651.GC2714@lahna.fi.intel.com>
References: <20190927144421.22608-1-kherbst@redhat.com>
 <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com>
 <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
 <20190930092934.GT2714@lahna.fi.intel.com>
 <CACO55tu9M8_TWu2MxNe_NROit+d+rHJP5_Tb+t73q5vr19sd1w@mail.gmail.com>
 <20190930163001.GX2714@lahna.fi.intel.com>
 <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 06:36:12PM +0200, Karol Herbst wrote:
> On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > > still happens with your patch applied. The machine simply gets shut down.
> > >
> > > dmesg can be found here:
> > > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> >
> > Looking your dmesg:
> >
> > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> > Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
> >
> > I would assume it runtime suspends here. Then it wakes up because of PCI
> > access from userspace:
> >
> > Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
> >
> > and for some reason it does not get resumed properly. There are also few
> > warnings from ACPI that might be relevant:
> >
> > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> >
> 
> afaik this is the case for essentially every laptop out there.

OK, so they are harmless?

> > This seems to be Dell XPS 9560 which I think has been around some time
> > already so I wonder why we only see issues now. Has it ever worked for
> > you or maybe there is a regression that causes it to happen now?
> 
> oh, it's broken since forever, we just tried to get more information
> from Nvidia if they know what this is all about, but we got nothing
> useful.
> 
> We were also hoping to find a reliable fix or workaround we could have
> inside nouveau to fix that as I think nouveau is the only driver
> actually hit by this issue, but nothing turned out to be reliable
> enough.

Can't you just block runtime PM from the nouveau driver until this is
understood better? That can be done by calling pm_runtime_forbid() (or
not calling pm_runtime_allow() in the driver). Or in case of PCI driver
you just don't decrease the reference count when probe() ends.

I think that would be much better than blocking any devices behind
Kabylake PCIe root ports from entering D3 (I don't really think the
problem is in the root ports itself but there is something we are
missing when the NVIDIA GPU is put into D3cold or back from there).
