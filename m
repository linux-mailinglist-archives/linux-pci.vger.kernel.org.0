Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5AC1DF9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfI3J3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 05:29:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:41802 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfI3J3j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 05:29:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 02:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="204793408"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2019 02:29:35 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 30 Sep 2019 12:29:34 +0300
Date:   Mon, 30 Sep 2019 12:29:34 +0300
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
Message-ID: <20190930092934.GT2714@lahna.fi.intel.com>
References: <20190927144421.22608-1-kherbst@redhat.com>
 <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
 <20190930080534.GS2714@lahna.fi.intel.com>
 <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tuMo1aAA7meGtEey6J6sOS-ZA0ebZeL52i2zfkWtPqe_g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 11:15:48AM +0200, Karol Herbst wrote:
> On Mon, Sep 30, 2019 at 10:05 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi Karol,
> >
> > On Fri, Sep 27, 2019 at 11:53:48PM +0200, Karol Herbst wrote:
> > > > What exactly is the serious issue?  I guess it's that the rescan
> > > > doesn't detect the GPU, which means it's not responding to config
> > > > accesses?  Is there any timing component here, e.g., maybe we're
> > > > missing some delay like the ones Mika is adding to the reset paths?
> > >
> > > When I was checking up on some of the PCI registers of the bridge
> > > controller, the slot detection told me that there is no device
> > > recognized anymore. I don't know which register it was anymore, though
> > > I guess one could read it up in the SoC spec document by Intel.
> > >
> > > My guess is, that the bridge controller fails to detect the GPU being
> > > here or actively threw it of the bus or something. But a normal system
> > > suspend/resume cycle brings the GPU back online (doing a rescan via
> > > sysfs gets the device detected again)
> >
> > Can you elaborate a bit what kind of scenario the issue happens (e.g
> > steps how it reproduces)? It was not 100% clear from the changelog. Also
> > what the result when the failure happens?
> >
> 
> yeah, I already have an updated patch in the works which also does the
> rework Bjorn suggested. Had no time yet to test if I didn't mess it
> up.
> 
> I am also thinking of adding a kernel parameter to enable this
> workaround on demand, but not quite sure on that one yet.

Right, I think it would be good to figure out the root cause before
adding any workarounds ;-) It might very well be that we are just
missing something the PCIe spec requires but not implemented in Linux.

> > I see there is a script that does something but unfortunately I'm not
> > fluent in Python so can't extract the steps how the issue can be
> > reproduced ;-)
> >
> > One thing that I'm working on is that Linux PCI subsystem misses certain
> > delays that are needed after D3cold -> D0 transition, otherwise the
> > device and/or link may not be ready before we access it. What you are
> > experiencing sounds similar. I wonder if you could try the following
> > patch and see if it makes any difference?
> >
> > https://patchwork.kernel.org/patch/11106611/
> 
> I think I already tried this path. The problem isn't that the device
> isn't accessible too late, but that it seems that the device
> completely falls off the bus. But I can retest again just to be sure.

Yes, please try it and share full dmesg if/when the failure still happens.
