Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1817D24D18D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHUJca (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 05:32:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:49384 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgHUJc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 05:32:28 -0400
IronPort-SDR: jG1hCB6skCxBI0tgbgyRFyKXIR92xqWqVPMa5SxcGtNcZ0qbqdNkGIdqI2T1pE8QV8WHczyuRe
 P+BTpB1sz/Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="154766895"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="154766895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 02:32:28 -0700
IronPort-SDR: IExlpaOJfoMVIfJA+PSXmIS9rSPVqSGFQE38EdIGbDMSwddRFzAaS0JpIYoVHT44q7aaZA+3YK
 MScSjOXp1kMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="401424995"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 21 Aug 2020 02:32:25 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 21 Aug 2020 12:32:24 +0300
Date:   Fri, 21 Aug 2020 12:32:24 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Assume ports without DLL Link Active train links
 in 100 ms
Message-ID: <20200821093224.GN1375436@lahna.fi.intel.com>
References: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
 <20200820081314.l25cjoehbnvbjbrk@wunner.de>
 <825a566040de2eedc81350cc914dd38dcc3ba4ff.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825a566040de2eedc81350cc914dd38dcc3ba4ff.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Aug 20, 2020 at 11:36:37AM -0400, Lyude Paul wrote:
> On Thu, 2020-08-20 at 10:13 +0200, Lukas Wunner wrote:
> > On Wed, Aug 19, 2020 at 04:06:25PM +0300, Mika Westerberg wrote:
> > > Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting, but
> > > at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and the Intel
> > > JHL7540 Thunderbolt 3 Bridge [8086:15ea] do not.
> > [...]
> > > +	 * Also do the same for devices that have power management disabled
> > > +	 * by their driver and are completely power managed through the
> > > +	 * root port power resource instead. This is a special case for
> > > +	 * nouveau.
> > >  	 */
> > > -	if (!pci_is_pcie(dev)) {
> > > +	if (!pci_is_pcie(dev) || !child->pm_cap) {
> > 
> > It sounds like the above-mentioned Thunderbolt controllers are broken,
> > not the Nvidia cards, so to me (as an outside observer) it would seem
> > more logical that a quirk for the former is needed.  The code comment
> > suggests that nouveau somehow has a problem, but that doesn't seem to
> > be the case (IIUC).  Also, it's a little ugly to have references to
> > specific drivers in PCI core code.
> > 
> > Maybe this can be fixed with quirks for the Thunderbolt controllers
> > which set a flag, and that flag causes the 1000 msec wait to be skipped?
>
> Sorry, some stuff came up yesterday so I didn't get the time to go through my
> laptops and test them. I do agree with this though - I'd be worried as well that
> nouveau might not be the only driver out there that needs this kind of delay

I actually expect that nouveau is the only one because it is doing some
PM tricks to get the runtime PM working, which is that it leaves the GPU
device in D0 and puts the parent root port into D3cold. The BIOS ASL
code has some assumptions there and I think this 1000 ms delay just
works that around by luck ;-)

IIRC Bjorn suggested quirking the affected downstream ports when I
originally sent the patch but I thought we could make this solution more
generic. Which of course, did not work too well.

I can look into the quirk solution instead if this is what people
prefer.
