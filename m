Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568421C1991
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEAP37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgEAP3z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 11:29:55 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FC9208DB;
        Fri,  1 May 2020 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588346994;
        bh=/G7XNzajf9Wo8tshCVgx7SQ2cL/bvxT5Q+QNU0HpWEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n6p+Fb4La0rgNC4UHvcZ+6ploTng5cabOHHDfq3l6wa7oXGtV/GxNNuYxhzAjb5cu
         QiZArscg2YtWFwf95CZYlm6jNH5nxYaY30LFYtE4/TDeXUZjK0pcOEjeWBPhoAsHXc
         vbyhmBe7G9bownYnkMZxsW6tPv8LnHfotA/zlUPI=
Date:   Fri, 1 May 2020 10:29:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Austin Bolen <Austin.Bolen@dell.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <kbusch@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER
 ownership
Message-ID: <20200501152952.GA109568@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dd43d44-3f9c-28c1-56ff-9720e6fb750a@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 05:35:34PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 4/30/2020 3:40 PM, Bjorn Helgaas wrote:
> > On Sun, Apr 26, 2020 at 11:30:06AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > Currently PCIe AER driver uses HEST FIRMWARE_FIRST bit to
> > > determine the PCIe AER Capability ownership between OS and
> > > firmware. This support is added based on following spec
> > > reference.
> > > 
> > > Per ACPI spec r6.3, table 18-387, 18-388, 18-389, HEST table
> > > flags field BIT-0 and BIT-1 can be used to expose the
> > > ownership of error source between firmware and OSPM.
> > > 
> > > Bit [0] - FIRMWARE_FIRST: If set, indicates that system
> > >            firmware will handle errors from this source
> > >            first.
> > > Bit [1] – GLOBAL: If set, indicates that the settings
> > >            contained in this structure apply globally to all
> > >            PCI Express Bridges.
> > > 
> > > Although above spec reference states that setting
> > > FIRMWARE_FIRST bit means firmware will handle the error source
> > > first, it does not explicitly state anything about AER
> > > ownership. So using HEST to determine AER ownership is
> > > incorrect.
> > > 
> > > Also, as per following specification references, _OSC can be
> > > used to negotiate the AER ownership between firmware and OS.
> > > Details are,
> > > 
> > > Per ACPI spec r6.3, sec 6.2.11.3, table titled “Interpretation
> > > of _OSC Control Field” and as per PCI firmware specification r3.2,
> > > sec 4.5.1, table 4-5, OS can set bit 3 of _OSC control field
> > > to request control over PCI Express AER. If the OS successfully
> > > receives control of this feature, it must handle error reporting
> > > through the AER Capability as described in the PCI Express Base
> > > Specification.
> > > 
> > > Since above spec references clearly states _OSC can be used to
> > > determine AER ownership, don't depend on HEST FIRMWARE_FIRST bit.
> > 
> > I pulled out the _OSC part of this to a separate patch.  What's left
> > is below, and is essentially equivalent to Alex's patch:
> > 
> >    https://lore.kernel.org/r/20190326172343.28946-3-mr.nuke.me@gmail.com/
> > 
> > I like what this does, but what I don't like is the fact that we now
> > have this thing called pcie_aer_get_firmware_first() that is not
> > connected with the ACPI FIRMWARE_FIRST bit at all.
>
> I agree. Since the current function has nothing to do with firmware
> first check, we can rename it. May be pci_aer_is_native() ?
>
> > I think the end result will be more readable if we get rid of the
> > "firmware_first" completely.  I don't know if we need a wrapper for it
> > at all, or if we should just open-code:
>
> Since pcie_aer_get_firmware_first() is used in following exported functions,
> I think we still need to check for "pcie_ports_native"
> and "pci_is_pcie()"

We *could* check pci_is_pcie(), but I don't think it's strictly
necessary because we really just depend on the AER capability, and we
already check for dev->aer_cap, which will only be set if we find one.

Good point about "pcie_ports_native".  I think I implemented
host->native_aer in a sub-optimal way: instead of sprinkling tests for
pcie_ports_native around, I think I should have done something like
this in acpi_pci_root_create():

  if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL) &&
      !pcie_ports_native)
        host_bridge->native_aer = 0;

That way (1) it's more obvious that the point of pcie_ports_native is
to override _OSC, and (2) we only need to check native_aer elsewhere.

If we refactored like that, the following should be sufficient:

> >    int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> >    {
> >      struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > 
> >      if (!host->native_aer)
> >        return -EIO;
