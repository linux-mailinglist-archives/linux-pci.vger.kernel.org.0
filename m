Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9A20F881
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbgF3Pi3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 11:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbgF3Pi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 11:38:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC25A20675;
        Tue, 30 Jun 2020 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593531508;
        bh=+mq7WcFXbYo5431aLEmBieudqWsKg/kt/fvcWMZkCBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bl5RxFhCCwtZ5oZDGw16ns2h6Q1i3BvDgAiiZajr1R4bo3LNxd92zGKQulajPnAgr
         r+LDhITZ9t4UD+Arr3ExbqZRI1I7z4PJOV36rG+wNmngm6kE6gmcaxGmW6D7xP69RV
         T0U12bR/14EoCs2+2EM2angdXKN5GkhIQdYlIyCI=
Date:   Tue, 30 Jun 2020 17:38:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200630153816.GD1785141@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
 <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 03:00:34PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 30, 2020 at 2:52 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> > > On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > > > Add a new (optional) field to denote the physical location of a device
> > > > in the system, and expose it in sysfs. This was discussed here:
> > > > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > > >
> > > > (The primary choice for attribute name i.e. "location" is already
> > > > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > > > that want to support this new attribute can opt-in by setting a flag in
> > > > bus_type, and then populating the location of device while enumerating
> > > > it.
> > >
> > > So why not just call it "physical_location"?
> >
> > That's better, and will allow us to put "3rd blue plug from the left,
> > 4th row down" in there someday :)
> >
> > All of this is "relative" to the CPU, right?  But what CPU?  Again, how
> > are the systems with drawers of PCI and CPUs and memory that can be
> > added/removed at any point in time being handled here?  What is
> > "internal" and "external" for them?
> >
> > What exactly is the physical boundry here that is attempting to be
> > described?
> 
> Also, where is the "physical location" information going to come from?

Who knows?  :)

Some BIOS seem to provide this, but do you trust that?

> If that is the platform firmware (which I suspect is the anticipated
> case), there may be problems with reliability related to that.

s/may/will/

which means making the kernel inact a policy like this patch series
tries to add, will result in a lot of broken systems, which is why I
keep saying that it needs to be done in userspace.

It's as if some of us haven't been down this road before and just keep
being ignored...

{sigh}

greg k-h
