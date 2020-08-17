Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8566247A5E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 00:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgHQWYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 18:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgHQWYf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 18:24:35 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7512072D;
        Mon, 17 Aug 2020 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597703074;
        bh=o61YhvDLcpTWPSTbalCw7Ijn7+cVlJNuvPEz9eAJyv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M4HrR5HEVBOUY+f7cCMEeQqu/IO7NhvM5jTNuvV0osZuW2n+FN8YvItOFyxtZfEOM
         In6+vdc80th4PlscWfms5JLY8lOKRkGTi7tVGViFFGZ183dYDTi2gHQpgmosB1xNvB
         guzt5y1y41nfTiTZcznMjiRZI6iB80vYXBBv7Rjg=
Date:   Mon, 17 Aug 2020 17:24:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Sean V Kelley <sean.v.kelley@intel.com>, rjw@rjwysocki.net,
        bhelgaas@google.com, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/9] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20200817222433.GA1453800@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810103252.00000318@Huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 10, 2020 at 10:32:52AM +0100, Jonathan Cameron wrote:
> On Fri, 7 Aug 2020 17:55:17 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
> > On 7 Aug 2020, at 15:53, Bjorn Helgaas wrote:
> > > On Tue, Aug 04, 2020 at 12:40:47PM -0700, Sean V Kelley wrote:  

> > >>  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > >> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> > >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> > >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END ||
> > >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC))
> > >>  		dev = dev->bus->self;

I'm not sure I understand this "if" statement.  Previously (with no
RCEC support), the possible ways I see to call pcie_do_recovery() are
with:

  AER native:   Root Port
  AER via APEI: Root Port or other PCIe device (ACPI v6.3, 18.3.2.5)
  DPC:          Root Port or Switch Downstream Port
  EDR:          Root Port or Switch Downstream Port

I *guess* the reason we have this "if" statement is for the AER/APEI
case?  And the effect is that even if AER/APEI gives us an Endpoint,
we back up and handle it as though we got it from the Downstream Port
above it, i.e., we reset the Endpoint along with any other children of
that Downstream Port?

Then, IIUC, your patches add this case:

  AER native:   Root Port or RCEC
  AER via APEI: Root Port, RCEC, or other PCIe device

Just noodling here, but I wonder if this would be more understandable
as something like:

  type = pci_pcie_type(dev);
  if (type == PCI_EXP_TYPE_ROOT_PORT ||
      type == PCI_EXP_TYPE_DOWNSTREAM ||
      type == PCI_EXP_TYPE_RC_EC)
    bridge = dev;
  else if (type == PCI_EXP_TYPE_RC_END)
    bridge = dev->rcec;
  else
    bridge = pci_upstream_bridge(dev);

and then we could do:

  if (type == PCI_EXP_TYPE_RC_END)
    flr_on_rciep(dev);
  else
    reset_link(bridge);

It's still awkward to have to deal with being supplied either
endpoints or bridges.  But I guess in the AER/APEI case, we aren't
allowed to touch the error registers so maybe we can't avoid the
awkwardness.

> > >>  		status = reset_link(dev);  
> > >
> > > reset_link() might be misnamed.  IIUC "dev" is a bridge, and the point
> > > is really to reset any devices below "dev."  Whether we do that by
> > > resetting link, DPC trigger, secondary bus reset, FLR, etc, is sort of
> > > immaterial.  Some of those methods might be applicable for RCiEPs.
> > >
> > > But you didn't add that name; I'm just trying to understand this
> > > better.  
> > 
> > Yes, that’s a confusing term with the _link attached. It’s difficult 
> > to relate to the different resets that might be applicable. I was 
> > thinking about that when looking at the callback path via the 
> > “reset_link” of the RCiEP to the RCEC for the sole purpose of 
> > clearing the Root Port Error Status. It would be worth time to spend 
> > looking at better descriptive naming/methods.
> 
> Agreed, this caused me some some confusion as well so more descriptive
> naming would be good.

Maybe something like reset_subordinate_devices()?  Then it's clear
that we pass a bridge and reset the devices *below* it.  It's not
quite as obvious for RCECs, since they aren't bridges and the RCiEPs
aren't actually *subordinates*, but maybe it's still suggestive of the
logical relationship?

Bjorn
