Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB2C1C7F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfI3IFm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 04:05:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:26754 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3IFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 04:05:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 01:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,565,1559545200"; 
   d="scan'208";a="204781826"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Sep 2019 01:05:35 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 30 Sep 2019 11:05:34 +0300
Date:   Mon, 30 Sep 2019 11:05:34 +0300
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
Message-ID: <20190930080534.GS2714@lahna.fi.intel.com>
References: <20190927144421.22608-1-kherbst@redhat.com>
 <20190927214252.GA65801@google.com>
 <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tuaY1jFXpJPeC9M4PoWEDyy547_tE8MpLaTDb+C+ffsbg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Karol,

On Fri, Sep 27, 2019 at 11:53:48PM +0200, Karol Herbst wrote:
> > What exactly is the serious issue?  I guess it's that the rescan
> > doesn't detect the GPU, which means it's not responding to config
> > accesses?  Is there any timing component here, e.g., maybe we're
> > missing some delay like the ones Mika is adding to the reset paths?
> 
> When I was checking up on some of the PCI registers of the bridge
> controller, the slot detection told me that there is no device
> recognized anymore. I don't know which register it was anymore, though
> I guess one could read it up in the SoC spec document by Intel.
> 
> My guess is, that the bridge controller fails to detect the GPU being
> here or actively threw it of the bus or something. But a normal system
> suspend/resume cycle brings the GPU back online (doing a rescan via
> sysfs gets the device detected again)

Can you elaborate a bit what kind of scenario the issue happens (e.g
steps how it reproduces)? It was not 100% clear from the changelog. Also
what the result when the failure happens?

I see there is a script that does something but unfortunately I'm not
fluent in Python so can't extract the steps how the issue can be
reproduced ;-)

One thing that I'm working on is that Linux PCI subsystem misses certain
delays that are needed after D3cold -> D0 transition, otherwise the
device and/or link may not be ready before we access it. What you are
experiencing sounds similar. I wonder if you could try the following
patch and see if it makes any difference?

https://patchwork.kernel.org/patch/11106611/
