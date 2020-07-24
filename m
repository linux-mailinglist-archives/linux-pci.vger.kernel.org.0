Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D722C2A7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 11:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgGXJ54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 05:57:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:11514 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXJ54 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 05:57:56 -0400
IronPort-SDR: V32r2pIyF8oQqic5JDUoSVyKSi2QHVEEj57/b3YD0cmdpiPCWVs4rZwGEftxurAiFXKRMPMKm6
 SCUcBLZQ1WBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="212218703"
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="212218703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 02:57:55 -0700
IronPort-SDR: cS6AjwGmqe1CzASREo9m3bSD0i7nq6nx2NdTBrfCiDcatBkQp2JO/2N1o/OCEYIcYy8doDCyNu
 L5Yqc3r1+Ymg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="393270148"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Jul 2020 02:57:51 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 24 Jul 2020 12:57:51 +0300
Date:   Fri, 24 Jul 2020 12:57:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Patrick Volkerding <volkerdi@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
Message-ID: <20200724095751.GU1375436@lahna.fi.intel.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520>
 <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
 <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
 <20200721122247.GI5180@lahna.fi.intel.com>
 <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
 <20200721152737.GS5180@lahna.fi.intel.com>
 <d3253a47-09ff-8bc7-3ca1-a80bdc09d1c2@gmail.com>
 <20200722092507.GC5180@lahna.fi.intel.com>
 <CACO55tsv63VP93F7xJ3nfZ7SkOk0c6WkgvuP+8fY14gypmn4Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tsv63VP93F7xJ3nfZ7SkOk0c6WkgvuP+8fY14gypmn4Fg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 10:30:58PM +0200, Karol Herbst wrote:
> On Wed, Jul 22, 2020 at 11:25 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Jul 21, 2020 at 01:37:12PM -0500, Patrick Volkerding wrote:
> > > On 7/21/20 10:27 AM, Mika Westerberg wrote:
> > > > On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> > > >> Sure thing. Also, feel free to let me know if you'd like access to one of the
> > > >> systems we saw breaking with this patch - I'm fairly sure I've got one of them
> > > >> locally at my apartment and don't mind setting up AMT/KVM/SSH
> > > > Probably no need for remote access (thanks for the offer, though). I
> > > > attached a test patch to the bug report:
> > > >
> > > >   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> > > >
> > > > that tries to work it around (based on the ->pm_cap == 0). I wonder if
> > > > anyone would have time to try it out.
> > >
> > >
> > > Hi Mika,
> > >
> > > I can confirm that this patch applied to 5.4.52 fixes the issue with
> > > hybrid graphics on the Thinkpad X1 Extreme gen2.
> >
> > Great, thanks for testing!
> >
> 
> yeah, works on the P1G2 as well.

Thanks for testing!

Since we have the revert queued for this release cycle, I think I will
send an updated version of "PCI/PM: Assume ports without DLL Link Active
train links in 100 ms" after v5.9-rc1 is released that has this
workaround in place.

(I'm continuing my vacation so will be offline next week).
