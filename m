Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B713216250
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 01:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGFXas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 19:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgGFXas (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 19:30:48 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A937206DF;
        Mon,  6 Jul 2020 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594078247;
        bh=f2hh0GUopLuKkcXDVWTmfciWI/Nf4mF/htzG+HH8RNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f4JVsr+FBnvTXG/UGYU+BhWL5/GxgtIyQWiYhUmKhQntGNfdpLXH2OTsU18T84J6J
         rozvcMTQ33o4xawcau+dKYIVeXMZClT4LHt5FI2a32iIOtwL6UZQqex47R6nyu3Xiu
         74ZKhPMc9knrbc6jjicKTbDTibtxKc9O39VOPWKg=
Date:   Mon, 6 Jul 2020 18:30:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
Message-ID: <20200706233040.GA169334@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6FhWyZOJvkrPcHacyvJucGMupOpL=Jm8BpyO7wPrZ_DQA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 03:31:47PM -0700, Rajat Jain wrote:
> On Mon, Jul 6, 2020 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:

> > > -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> > > +static void pci_acpi_set_external_facing(struct pci_dev *dev)
> > >  {
> > >       u8 val;
> > >
> > > -     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > > +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> > > +         pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
> >
> > This looks like a change worthy of its own patch.  We used to look for
> > "ExternalFacingPort" only on Root Ports; now we'll also do it for
> > Switch Downstream Ports.
> 
> Can do. (please see below)
> 
> > Can you include DT and ACPI spec references if they exist?  I found
> > this mention:
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> > which actually says it should only be implemented for Root Ports.
> 
> I actually have no references. It seems to me that the microsoft spec
> assumes that all external ports must be implemented on root ports, but
> I think it would be equally fair for systems with PCIe switches to
> implement one on one of their switch downstream ports. I don't have an
> immediate use of this anyway, so if you think this should rather wait
> unless someone really has this case, this can wait. Let me know.

I agree that it "makes sense" to pay attention to this property no
matter where it appears, but since that Microsoft doc went to the
trouble to restrict it to Root Ports, I think we should leave this
as-is and only look for it in the Root Port.  Otherwise Linux will
accept something Windows will reject, and that seems like a needless
difference.

We can at least include the above link to the Microsoft doc in the
commit log.

> > It also mentions a "DmaProperty" that looks related.  Maybe Linux
> > should also pay attention to this?
> 
> Interesting. Since this is not in use currently by the kernel as well
> as not exposed by (our) BIOS, I don't have an immediate use case for
> this. I'd like to defer this for later (as-the-need-arises).

I agree, you can defer this until you see a need for it.  I just
pointed it out in case it would be useful to you.

> > > +     /*
> > > +      * Devices are marked as external-facing using info from platform
> > > +      * (ACPI / devicetree). An external-facing device is still an internal
> > > +      * trusted device, but it faces external untrusted devices. Thus any
> > > +      * devices enumerated downstream an external-facing device is marked
> > > +      * as untrusted.
> >
> > This comment has a subject/verb agreement problem.
> 
> I assume you meant s/is/are/ in last sentence. Will do.

Right.  There's also something wrong with "enumerated downstream an".
