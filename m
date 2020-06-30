Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6B20F552
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbgF3NAs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 09:00:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35058 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387860AbgF3NAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2020 09:00:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id d4so18322175otk.2;
        Tue, 30 Jun 2020 06:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqwbwU46JyOBSJ4M/llFeE1rugAXIYDl6Af9czQJBYA=;
        b=jDFgAAuJGqYlbU3fXLv/gMLOuQAgYysSgZSbE6LepFkZOT3HfO8Qp2g512nitXF8WU
         tNL8LbHaLiHWlMgAIIEiCFaAfI6TO/0L9EiHmYLaWoh6gUj1VLFDDvC/aVPiU86eNlzD
         NWuurDaD4xa5PQzaFP/bfg4nNL2GJTW09ssxbhRplYCxZikO+6H75j0Q9MwIUq3s7Htc
         4poFgdVtWsWy2dxLNFi6TDz4/vaAgL/rDpMso6eUUDfCVbFWLEmmN4fwK2mXrNcX1GAz
         TmOlI6aWtq66iOgYRYYrpAN6RfUx0CbUwNnQzncJs2/WFMTdR7vaJX1ol8Fe6gG6vJfL
         Xl/Q==
X-Gm-Message-State: AOAM530oW9yWTHcFvY2+YKQ5T4QFA6QisDf0aqqI//cEwLhdIuchj9vF
        uMDPD/AqqOnGSb60rDvQSvEjZVIcv4Khfs7w0b45kg==
X-Google-Smtp-Source: ABdhPJxcZHXFcqosLW4f6iGFDsj3uWlS9K4nihvXh0uIED4aD7noF+010OtlL0o8ZeIfLr5tSucG2WE3CDKvAel9ATU=
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr17985171otb.262.1593522045805;
 Tue, 30 Jun 2020 06:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com> <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com> <20200630125216.GA1109228@kroah.com>
In-Reply-To: <20200630125216.GA1109228@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 15:00:34 +0200
Message-ID: <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 2:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> > On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > > Add a new (optional) field to denote the physical location of a device
> > > in the system, and expose it in sysfs. This was discussed here:
> > > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > >
> > > (The primary choice for attribute name i.e. "location" is already
> > > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > > that want to support this new attribute can opt-in by setting a flag in
> > > bus_type, and then populating the location of device while enumerating
> > > it.
> >
> > So why not just call it "physical_location"?
>
> That's better, and will allow us to put "3rd blue plug from the left,
> 4th row down" in there someday :)
>
> All of this is "relative" to the CPU, right?  But what CPU?  Again, how
> are the systems with drawers of PCI and CPUs and memory that can be
> added/removed at any point in time being handled here?  What is
> "internal" and "external" for them?
>
> What exactly is the physical boundry here that is attempting to be
> described?

Also, where is the "physical location" information going to come from?

If that is the platform firmware (which I suspect is the anticipated
case), there may be problems with reliability related to that.
