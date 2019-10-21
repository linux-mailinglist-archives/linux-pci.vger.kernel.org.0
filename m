Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC2CDEB96
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfJUMG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 08:06:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:2412 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfJUMG2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 08:06:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 05:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209431575"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Oct 2019 05:06:11 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Oct 2019 15:06:11 +0300
Date:   Mon, 21 Oct 2019 15:06:11 +0300
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191021120611.GB2819@lahna.fi.intel.com>
References: <20191016144449.24646-1-kherbst@redhat.com>
 <20191021114017.GY2819@lahna.fi.intel.com>
 <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 02:00:46PM +0200, Karol Herbst wrote:
> On Mon, Oct 21, 2019 at 1:40 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > Hi Karol,
> >
> > Sorry for commenting late, I just came back from vacation.
> >
> > On Wed, Oct 16, 2019 at 04:44:49PM +0200, Karol Herbst wrote:
> > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > states.
> > >
> > > v2: convert to pci_dev quirk
> > >     put a proper technical explanation of the issue as a in-code comment
> > > v3: disable it only for certain combinations of intel and nvidia hardware
> > >
> > > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: Mika Westerberg <mika.westerberg@intel.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: nouveau@lists.freedesktop.org
> > > ---
> > >  drivers/pci/pci.c    | 11 ++++++++++
> > >  drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
> >
> > I may be missing something but why you can't do this in the nouveau
> > driver itself?
> 
> What do you mean precisely? Move the quirk into nouveau, but keep the
> changes to pci core?

No, just block runtime PM from the device in nouveau driver.
