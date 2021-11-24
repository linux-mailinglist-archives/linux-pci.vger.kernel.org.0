Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280D145B668
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 09:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbhKXIY4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 03:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhKXIYz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 03:24:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A97D60F5D;
        Wed, 24 Nov 2021 08:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637742106;
        bh=iRJV566wWy9TwKvYb4r0Wes1xMamTHsrmwaXBsxss9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zXfCTZw1+nUFPRDyogQ23SbwxyFE3gEHPPgahw5HEVFomTslnEMYg56/FbGNoLaXw
         RpNrKmekhJmjDXl5aS7fFTY/RRTM/fN06TChckwUNy4kCo0nomEKh1/vyjpw8ielTX
         Hn2RKk5mV8RDcTE4OhtEhQfW+zFGckYCj5PkpmHo=
Date:   Wed, 24 Nov 2021 09:21:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <YZ32F0e/Cun9rB0i@kroah.com>
References: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
 <20211123235557.GA2247853@bhelgaas>
 <CAPcyv4g0=zz8BtB9DRW0FGsRRvgGwEaQcgbmXDhJ3DwNFS9Z+g@mail.gmail.com>
 <20211124063316.GA6792@lst.de>
 <CAPcyv4ii=bjKNQxoMLF-gscJy7Bh8CUn205_1GpCwfMyJ22+6g@mail.gmail.com>
 <20211124072824.GA7738@lst.de>
 <YZ3qvtHlMkRnC74f@kroah.com>
 <CAPcyv4iYcBFDhDtcxc37EWfX1Wpuh8Zsm4-whTL0vNyY4zW3AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iYcBFDhDtcxc37EWfX1Wpuh8Zsm4-whTL0vNyY4zW3AQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 11:54:03PM -0800, Dan Williams wrote:
> On Tue, Nov 23, 2021 at 11:33 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 24, 2021 at 08:28:24AM +0100, Christoph Hellwig wrote:
> > > On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> > > > I am missing the counter proposal in both Bjorn's and your distaste
> > > > for aux bus and PCIe portdrv?
> > >
> > > Given that I've only brought in in the last mail I have no idea what
> > > the original proposal even is.
> >
> > Neither do I :(
> 
> To be clear I am also trying to get to the root of Bjorn's concern.
> 
> The proposal in $SUBJECT is to build on / treat a CXL topology as a
> Linux device topology on /sys/bus/cxl that references devices on
> /sys/bus/platform (CXL ACPI topology root and Host Bridges) and
> /sys/bus/pci (CXL Switches and Endpoints).

Wait, I am confused.

A bus lists devices that are on that bus.  It does not list devices that
are on other busses.

Now a device in a bus list can have a parent be on different types of
busses, as the parent device does not matter, but the device itself can
not be of different types.

So I do not understand what you are describing here at all.  Do you have
an example output of sysfs that shows this situation?

> This CXL port device topology has already been shipping for a few
> kernel cycles.

So it's always been broken?  :)

> What is on
> the table now is a driver for CXL port devices (a logical Linux
> construct). The driver handles discovery of "component registers"
> either by ACPI table or PCI DVSEC and offers services to proxision CXL
> regions.

So a normal bus controller device that creates new devices of a bus
type, right?  What is special about that?

> CXL 'regions' are also proposed as Linux devices that
> represent an active CXL memory range which can interleave multiple
> endpoints across multiple switches and host bridges.

As long as these 'devices' have drivers and do not mess with the
resources of any other device in the system, I do not understand the
problem here.

Or is the issue that you are again trying to carve up "real" devices
into tiny devices that then somehow need to be aware of the resources
being touched by different drivers at the same time?

I'm still confused, sorry.

greg k-h
