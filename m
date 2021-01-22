Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C32300028
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 11:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbhAVKOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 05:14:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:36660 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbhAVKJA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 05:09:00 -0500
IronPort-SDR: Oei/IflOQRDhkV1ZlAF8GqrAhptQ62GpPQu+UVAb9UNwdJKqNxdO8ILn8onfJKB+EYyMQQuepB
 3xCnmvlL/Nsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="264244104"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="264244104"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 02:05:52 -0800
IronPort-SDR: GTVcV40CII561+g1c4ZQEaXgUOCdiGelZbxh/WWOVbfil8fndYoLNlP0ch3/or33rw5JoYOFYX
 F08IjTXyVxVg==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="427923843"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 02:05:47 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Jan 2021 12:05:45 +0200
Date:   Fri, 22 Jan 2021 12:05:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mingchuang Qiao <mingchuang.qiao@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        linux-pci@vger.kernel.org, matthias.bgg@gmail.com,
        lambert.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        haijun.liu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Re-enable downstream port LTR if it was
 previously enabled
Message-ID: <20210122100545.GL1988617@lahna.fi.intel.com>
References: <20210121223139.GA2698934@bjorn-Precision-5520>
 <1611298991.5980.42.camel@mcddlt001>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1611298991.5980.42.camel@mcddlt001>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Jan 22, 2021 at 03:03:11PM +0800, Mingchuang Qiao wrote:
> On Thu, 2021-01-21 at 16:31 -0600, Bjorn Helgaas wrote:
> > [+cc Alex and Mingchuang et al from
> > https://lore.kernel.org/r/20210112072739.31624-1-mingchuang.qiao@mediatek.com]
> > 
> > On Tue, Jan 19, 2021 at 04:14:10PM +0300, Mika Westerberg wrote:
> > > PCIe r5.0, sec 7.5.3.16 says that the downstream ports must reset the
> > > LTR enable bit if the link goes down (port goes DL_Down status). Now, if
> > > we had LTR previously enabled and the PCIe endpoint gets hot-removed and
> > > then hot-added back the ->ltr_path of the downstream port is still set
> > > but the port now does not have the LTR enable bit set anymore.
> > > 
> > > For this reason check if the bridge upstream had LTR enabled previously
> > > and re-enable it before enabling LTR for the endpoint.
> > > 
> > > Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > I think this and Mingchuang's patch, which is essentially identical,
> > are right and solves the problem for hot-remove/hot-add.  In that
> > scenario we call pci_configure_ltr() on the hot-added device, and
> > with this patch, we'll re-enable LTR on the bridge leading to the new
> > device before enabling LTR on the new device itself.
> > 
> > But don't we have a similar problem if we simply do a Fundamental
> > Reset on a device?  I think the reset path will restore the device's
> > state, including PCI_EXP_DEVCTL2, but it doesn't do anything with the
> > upstream bridge, does it?
> > 
> 
> Yes. I think the same problem exists under such scenario, and that’s the
> issue my patch intends to resolve.
> I also prepared a v2 patch for review(update the patch description).
> Shall I submit the v2 patch for review?

I looked at your patch and indeed it is essentially doing the same as
this one. So let's forget this patch and go forward with yours :)

Would you like to expand your patch to handle the reset case too that
Bjorn desribes below?

> > So if a bridge and a device below it both have LTR enabled, can't we
> > have the following:
> > 
> >   - bridge LTR enabled
> >   - device LTR enabled
> >   - reset device, e.g., via Secondary Bus Reset
> >   - link goes down, bridge disables LTR
> >   - link comes back up, LTR disabled in both bridge and device
> >   - restore device state, including LTR enable
> >   - device sends LTR message
> >   - bridge reports Unsupported Request
