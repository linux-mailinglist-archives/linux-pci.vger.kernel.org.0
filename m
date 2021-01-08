Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFEC2EFB3D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 23:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbhAHWb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 17:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbhAHWb0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 17:31:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB4723A74;
        Fri,  8 Jan 2021 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610145045;
        bh=RfrNnUxqpgdg1FN3ZSwdDVqxQrDShq6i7TaVpK5s6fI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u5giCa9cMNCemfl6FJRL3u4N3DIeFrNlRs4AT9+Y33JJaVr3knEQVJkPlAgRMpwse
         sjHkr+CUPTsEj4Qrxwl03PcqAd6UOpjmSbMFsSNgGHabmVbUHKEPLXndRhWzuS5nhk
         idYoXAoloRofb6fJ1bj/BXGiYk/FvpC5Lcr6+25wYMDDZBv57z0yOKjKxTVkProvce
         VgZB2vlQ5B6+9b5901/Y2UHw4CXTYkCOyHb+eSGh7QjmjUzDi4riClHnl19R+g3x31
         b+WCBI5/D+j5LiAlruaa9x6y8RlhzJGWdzoAeEQzx1cVGx5R3a3OdK377WXuOylPSO
         GwAhtaopMia7w==
Date:   Fri, 8 Jan 2021 16:30:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hedi Berriche <hedi.berriche@hpe.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Russ Anderson <rja@hpe.com>, Joerg Roedel <jroedel@suse.com>,
        stable@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 1/1] PCI/ERR: don't clobber status after reset_link()
Message-ID: <20210108223043.GA1477254@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210224142.GA58424@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith]

On Thu, Dec 10, 2020 at 04:41:42PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 02, 2020 at 03:09:51PM +0000, Hedi Berriche wrote:
> > Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> > broke pcie_do_recovery(): updating status after reset_link() has the ill
> > side effect of causing recovery to fail if the error status is
> > PCI_ERS_RESULT_CAN_RECOVER or PCI_ERS_RESULT_NEED_RESET as the following
> > code will *never* run in the case of a successful reset_link()
> > 
> >    177         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> >    ...
> >    181         }
> > 
> >    183         if (status == PCI_ERS_RESULT_NEED_RESET) {
> >    ...
> >    192         }
> 
> The line numbers are basically useless because they depend on some
> particular version of the file.
> 
> > For instance in the case of PCI_ERS_RESULT_NEED_RESET we end up not
> > calling ->slot_reset() (because we skip report_slot_reset()) thus
> > breaking driver (re)initialisation.
> > 
> > Don't clobber status with the return value of reset_link(); set status
> > to PCI_ERS_RESULT_RECOVERED, in case of successful link reset, if and
> > only if the initial value of error status is PCI_ERS_RESULT_DISCONNECT
> > or PCI_ERS_RESULT_NO_AER_DRIVER.
> >
> > Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> > Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> > 
> > Reviewed-by: Sinan Kaya <okaya@kernel.org>
> > Cc: Russ Anderson <rja@hpe.com>
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Joerg Roedel <jroedel@suse.com>
> > 
> > Cc: stable@kernel.org # v5.7+
> > ---
> >  drivers/pci/pcie/err.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index c543f419d8f9..2730826cfd8a 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -165,10 +165,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  	pci_dbg(dev, "broadcast error_detected message\n");
> >  	if (state == pci_channel_io_frozen) {
> >  		pci_walk_bus(bus, report_frozen_detected, &status);
> > -		status = reset_link(dev);
> > -		if (status != PCI_ERS_RESULT_RECOVERED) {
> > +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
> >  			pci_warn(dev, "link reset failed\n");
> >  			goto failed;
> > +		} else {
> > +			if (status == PCI_ERS_RESULT_DISCONNECT ||
> > +			    status == PCI_ERS_RESULT_NO_AER_DRIVER)
> > +				status = PCI_ERS_RESULT_RECOVERED;
> 
> This code (even before your patch) doesn't match
> Documentation/PCI/pci-error-recovery.rst very well.  The code handles
> pci_channel_io_frozen specially, but I don't think this is mentioned
> in the doc.
> 
> The doc says we call ->error_detected() for all affected drivers.
> Then we're supposed to do a slot reset if any driver returned
> NEED_RESET.  But in fact, we always do a reset for the
> pci_channel_io_frozen case and never do one otherwise, regardless of
> what ->error_detected() returned.
> 
> The doc says DISCONNECT means "Driver ... doesn't want to recover at
> all." Many drivers can return either NEED_RESET or DISCONNECT, and I
> assume they expect them to be handled differently.  But I'm not sure
> what DISCONNECT really means.  Do we reset the device?  Do we not
> attempt recovery at all?
> 
> After your patch, if the reset_link() succeeded, we convert DISCONNECT
> and NO_AER_DRIVER to RECOVERED.  IIUC, that means we do exactly the
> same thing if the consensus of the ->error_detected() functions was
> RECOVERED, DISCONNECT, or NO_AER_DRIVER: we call reset_link() and
> continue with "status = PCI_ERS_RESULT_RECOVERED".
> 
> (I'd reverse the sense of the "if (reset_link())" to make this easier
> to read)

Can we push this forward now?  There are several pending patches in
this area from Keith and Sathyanarayanan; I haven't gotten to them
yet, so not sure whether they help address any of this.

> >  		}
> >  	} else {
> >  		pci_walk_bus(bus, report_normal_detected, &status);
> > -- 
> > 2.28.0
> > 
