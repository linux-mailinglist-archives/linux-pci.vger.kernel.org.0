Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06D17B676
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 06:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgCFFkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 00:40:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:60255 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgCFFkL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 00:40:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 21:40:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; 
   d="scan'208";a="352663280"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Mar 2020 21:40:07 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 06 Mar 2020 07:40:06 +0200
Date:   Fri, 6 Mar 2020 07:40:06 +0200
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
Subject: Re: [PATCH v6] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20200306054006.GZ2540@lahna.fi.intel.com>
References: <20200303101052.133631-1-kherbst@redhat.com>
 <20200304093324.GI2540@lahna.fi.intel.com>
 <CACO55ts7VGUJoSM_X_huZ0o68+P6SaWgFKbQzkw=-F+Kh5WfcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55ts7VGUJoSM_X_huZ0o68+P6SaWgFKbQzkw=-F+Kh5WfcA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 05, 2020 at 05:11:57PM +0100, Karol Herbst wrote:
> On Wed, Mar 4, 2020 at 10:33 AM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > Hi,
> >
> > On Tue, Mar 03, 2020 at 11:10:52AM +0100, Karol Herbst wrote:
> > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> > > states.
> >
> > I think it is good to explain bit more here why this fix is needed.
> >
> 
> is something like this fine?
> 
> Fixes the infamous 'runpm' bug many users are facing on Laptops with Nvidia
> Pascal GPUs by skipping PCI power state changes on the GPU.

I would open up 'runpm' -> runtime PM.

> It's still unknown why this issue exists, but this is a reliable workaround
> and solves a very annoying issue for user having to choose between a
> crashing kernel or higher power consumption of their Laptops.

Also I think it would be good to include a short log snippet how this
manifests and in what kind of scenario it happens.
