Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ED645B05A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 00:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhKWXlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 18:41:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:45181 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhKWXlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 18:41:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="295966237"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="295966237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 15:38:27 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509607343"
Received: from bjarrett-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.138.19])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 15:38:27 -0800
Date:   Tue, 23 Nov 2021 15:38:26 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211123233826.drs7kr5tyb5xz6a2@intel.com>
References: <20211120000250.1663391-21-ben.widawsky@intel.com>
 <20211123182128.GA2230781@bhelgaas>
 <20211123220315.itoh4izu56yrrjlh@intel.com>
 <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-23 14:36:32, Dan Williams wrote:
> On Tue, Nov 23, 2021 at 2:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> [..]
> > > I hope this driver is not modeled on the PCI portdrv.  IMO, that was a
> > > design error, and the "port service drivers" (PME, hotplug, AER, etc)
> > > should be directly integrated into the PCI core instead of pretending
> > > to be independent drivers.
> >
> > I'd like to understand a bit about why you think it was a design error. The port
> > driver is intended to be a port services driver, however I see the services
> > provided as quite different than the ones you mention. The primary service
> > cxl_port will provide from here on out is the ability to manage HDM decoder
> > resources for a port. Other independent drivers that want to use HDM decoder
> > resources would rely on the port driver for this.
> >
> > It could be in CXL core just the same, but I don't see too much of a benefit
> > since the code would be almost identical. One nice aspect of having the port
> > driver outside of CXL core is it would allow CXL devices which do not need port
> > services (type-1 and probably type-2) to not need to load the port driver. We do
> > not have examples of such devices today but there's good evidence they are being
> > built. Whether or not they will even want CXL core is another topic up for
> > debate however.
> >
> > I admit Dan and I did discuss putting this in either its own port driver, or
> > within core as a port driver. My inclination is, less is more in CXL core; but
> > perhaps you will be able to change my mind.
> 
> No, I don't think Bjorn is talking about whether the driver is
> integrated into cxl_core.ko vs its own cxl_port.ko. IIUC this goes
> back to the original contention about have /sys/bus/cxl at all:
> 
> https://lore.kernel.org/r/CAPcyv4iu8D-hJoujLXw8a4myS7trOE1FcUhESLB_imGMECVfrg@mail.gmail.com
> 
> Unlike pcieportdrv where the functionality is bounded to a single
> device instance with relatively simpler hierarchical coordination of
> the memory space and services. CXL interleaving is both a foreign
> concept to the PCIE core and an awkward fit for the pci_bus_type
> device model. CXL uses the cxl_bus_type and bus drivers to coordinate
> CXL operations that have cross PCI device implications.
> 
> Outside of that I think the auxiliary device driver model, of which
> the PCIE portdrv model is an open-coded form, is a useful construct
> for separation of concerns. That said, I do want to hear more about
> what trouble it has caused though to make sure that CXL does not trip
> over the same issues longer term.
> 
> [..]
> > > > +static void rescan_ports(struct work_struct *work)
> > > > +{
> > > > +   if (bus_rescan_devices(&cxl_bus_type))
> > > > +           pr_warn("Failed to rescan\n");
> > >
> > > Needs some context.  A bare "Failed to rescan" in the dmesg log
> > > without a clue about who emitted it is really annoying.
> > >
> > > Maybe you defined pr_fmt() somewhere; I couldn't find it easily.
> > >
> >
> > I actually didn't know about pr_fmt() trick, so thanks for that. I'll improve
> > this message to be more useful and contextual.
> 
> I am skeptical that this implementation of the workqueue properly
> synchronizes with workqueue shutdown concerns, but I have not had a
> chance to dig in too deep on this patchset.

Yeah, we discussed this. Please do check that. I'm happy to send out v2 with all
of Jonathan's fixes first, so you don't have to duplicate effort with what he
has already uncovered.

> 
> Regardless, it is not worth reporting a rescan failure, because those
> are to be expected here. The rescan attempts to rescan when a
> constraint changes, there is no guarantee that all constraints are met
> just because one constraint changed, so rescan failures
> (device_attach() failures) are not interesting to report. The
> individual driver probe failure reporting is sufficient.

Agreed.
