Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66CC2294C8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 11:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGVJXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 05:23:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:20705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgGVJXw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 05:23:52 -0400
IronPort-SDR: 6e/I5EKMAeOVd0It1tqlHIYmRgDIw4fLVsnJGf4DxPR0BuPH5wJ7WQXVxbN/bY0YoECxoSJttG
 L+oBkMTdXwqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="168440190"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="168440190"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 02:23:52 -0700
IronPort-SDR: jP3fe072rBo2wvDbMnJ3ED+rOZ+vIZrkcAANoPNtUQzH2fOUvQUPvZNJPsgGZYCtkksdKGraHC
 BqxRxmFIKIGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="392624818"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jul 2020 02:23:48 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 22 Jul 2020 12:23:47 +0300
Date:   Wed, 22 Jul 2020 12:23:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
Message-ID: <20200722092347.GB5180@lahna.fi.intel.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520>
 <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
 <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
 <20200721122247.GI5180@lahna.fi.intel.com>
 <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
 <20200721152737.GS5180@lahna.fi.intel.com>
 <dc7a592219f58f9a5df7fa7135fa3fc87d9450f0.camel@redhat.com>
 <a80a591ce61b632503c9ed52adc7c40faad8b068.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80a591ce61b632503c9ed52adc7c40faad8b068.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 02:24:19PM -0400, Lyude Paul wrote:
> On Tue, 2020-07-21 at 12:00 -0400, Lyude Paul wrote:
> > On Tue, 2020-07-21 at 18:27 +0300, Mika Westerberg wrote:
> > > On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> > > > Sure thing. Also, feel free to let me know if you'd like access to one
> > > > of
> > > > the
> > > > systems we saw breaking with this patch - I'm fairly sure I've got one
> > > > of
> > > > them
> > > > locally at my apartment and don't mind setting up AMT/KVM/SSH
> > > 
> > > Probably no need for remote access (thanks for the offer, though). I
> > > attached a test patch to the bug report:
> > > 
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> > > 
> > > that tries to work it around (based on the ->pm_cap == 0). I wonder if
> > > anyone would have time to try it out.
> > 
> > Will give it a shot today and let you know the result
> 
> Ahh-actually, I thought the laptop I had locally could reproduce this bug but
> that doesn't appear to be the case whoops. Karol Herbst still has access to a
> machine that can test this though, so they'll likely get to trying the patch
> today or tommorrow

OK sounds good :)
