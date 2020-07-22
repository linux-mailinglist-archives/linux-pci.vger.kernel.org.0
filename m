Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EB2294CE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgGVJZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 05:25:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:38606 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgGVJZR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 05:25:17 -0400
IronPort-SDR: Dshz7hZBMcK5ovvd5kpPK2lqAxj1reEwpKgp5MjGVd6KdbM0Akd0tbIDAkqDGfclx1k4/VlWsQ
 oW+gLujTXGxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="138378835"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="138378835"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 02:25:11 -0700
IronPort-SDR: EOpJ7Pi5GhJPrVgrFw+6krLmQuyu24P0i+zE7fQ4EyQQ6sxaEeWwzgKFc7MI/TqfL3+fxGXL1t
 KVkLOW1mG4Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="392625020"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jul 2020 02:25:08 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 22 Jul 2020 12:25:07 +0300
Date:   Wed, 22 Jul 2020 12:25:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Patrick Volkerding <volkerdi@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>, Karol Herbst <kherbst@redhat.com>,
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
Message-ID: <20200722092507.GC5180@lahna.fi.intel.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520>
 <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
 <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
 <20200721122247.GI5180@lahna.fi.intel.com>
 <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
 <20200721152737.GS5180@lahna.fi.intel.com>
 <d3253a47-09ff-8bc7-3ca1-a80bdc09d1c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3253a47-09ff-8bc7-3ca1-a80bdc09d1c2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 01:37:12PM -0500, Patrick Volkerding wrote:
> On 7/21/20 10:27 AM, Mika Westerberg wrote:
> > On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> >> Sure thing. Also, feel free to let me know if you'd like access to one of the
> >> systems we saw breaking with this patch - I'm fairly sure I've got one of them
> >> locally at my apartment and don't mind setting up AMT/KVM/SSH
> > Probably no need for remote access (thanks for the offer, though). I
> > attached a test patch to the bug report:
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> >
> > that tries to work it around (based on the ->pm_cap == 0). I wonder if
> > anyone would have time to try it out.
> 
> 
> Hi Mika,
> 
> I can confirm that this patch applied to 5.4.52 fixes the issue with
> hybrid graphics on the Thinkpad X1 Extreme gen2.

Great, thanks for testing!
