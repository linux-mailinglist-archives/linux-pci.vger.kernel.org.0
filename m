Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A821363C8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 00:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAIX0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 18:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgAIX0m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 18:26:42 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0EF02073A;
        Thu,  9 Jan 2020 23:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578612401;
        bh=au4i6hoUP1jq46fOB57Lzy3xYgHp/aHV7LUZVNXrNi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IayYNWt2dNCbCf2b5jpPKtrHNjK17fcpT+tXk6QIPczBSmXpOixzLWd7i9OjF/e+T
         bcUSXVKldBczVMj5tQm+HNlUeko5PIeVCqKZyCWMOL+SZioOlaje8AtwykIPJRDx05
         ofMD+I1JA86CC8b3lxdM4p4fCcmypUSFekpLYeQg=
Date:   Thu, 9 Jan 2020 17:26:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v11 1/8] PCI/ERR: Update error status after reset_link()
Message-ID: <20200109232639.GA42480@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7fdfec-5060-bcaa-38c4-6b973149e5cc@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 08, 2020 at 04:14:09PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 1/3/20 6:54 PM, Bjorn Helgaas wrote:
> > On Fri, Jan 03, 2020 at 05:03:03PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > On 1/3/20 4:34 PM, Bjorn Helgaas wrote:
> > > > On Thu, Dec 26, 2019 at 04:39:07PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > 
> > > > > Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> > > > > reset_link() to recover from fatal errors. But, if the reset is
> > > > > successful there is no need to continue the rest of the error recovery
> > > > > checks. Also, during fatal error recovery, if the initial value of error
> > > > > status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> > > > > even after successful recovery (using reset_link()) pcie_do_recovery()
> > > > > will report the recovery result as failure. So update the status of
> > > > > error after reset_link().
> > > > I like the part about updating "status" with the result of
> > > > reset_link(), and I split that into its own patch because it
> > > > seems like a fix that *can* be separated.
> > > > 
> > > > But I'm not convinced that we should skip the ->slot_reset()
> > > > callbacks if the reset_link() was successful.
> > > If reset_link() call is successful then the result value will be
> > > "PCI_ERS_RESULT_RECOVERED". So even if you proceed with
> > > rest of the code, slot_reset() will never get called right ?
> > The current code:
> > 
> >          if (state == pci_channel_io_frozen &&
> >              reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> >                  goto failed;
> >          ...
> >          if (status == PCI_ERS_RESULT_NEED_RESET) {
> >                  status = PCI_ERS_RESULT_RECOVERED;
> >                  pci_walk_bus(bus, report_slot_reset, &status);
> > 
> > doesn't save the result of reset_link(), so if status was
> > PCI_ERS_RESULT_NEED_RESET and the reset succeeds, we will call
> > ->slot_reset().
> > 
> > After your patch, if "state == pci_channel_io_frozen", we *never* call
> > ->slot_reset().
> > 
> > Do you think that matches pci-error-recovery.rst?  It doesn't seem
> > like it to me, but perhaps I haven't read it closely enough.
> Documentation does not have clear details on what to do with return
> value of reset_link() (step 3). But IMO, if step 3 recovers the device and
> returns PCI_ERS_RESULT_RECOVERED then there is no need to proceed
> to slot reset (step 4). May be we should update the Documentation?

Are you suggesting we don't need to call a driver callback after
resetting the device?  Note that the ->slot_reset() doesn't *perform*
a reset; it is called *after* completion of a reset.

The doc says:

  ... Upon completion of slot reset, the platform will call the device
  slot_reset() callback.
  ...
  This call gives drivers the chance to re-initialize the hardware
  (re-download firmware, etc.).  At this point, the driver may assume
  that the card is in a fresh state and is fully functional. The slot
  is unfrozen and the driver has full access to PCI config space,
  memory mapped I/O space and DMA. Interrupts (Legacy, MSI, or MSI-X)
  will also be available.

After we reset a device, the driver certainly needs a chance to
reinitialize it.

> > > > According to
> > > > Documentation/PCI/pci-error-recovery.rst, we should call
> > > > ->slot_reset() after completion of the reset.
> > > > 
> > > > For example, rsxx_err_handler implements ->slot_reset(), but
> > > > not ->resume().  If we reset the device, we'll claim success and
> > > > return, but we won't call rsxx_slot_reset(), which does a bunch
> > > > of important-looking recovery stuff.
> > > > 
> > > > If pci-error-recovery.rst is wrong, we should fix that (after
> > > > auditing all the drivers to make sure they match).
> > > > 
> > > > > Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> > > > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > > > Cc: Keith Busch <keith.busch@intel.com>
> > > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > > Acked-by: Keith Busch <keith.busch@intel.com>
> > > > > ---
> > > > >    drivers/pci/pcie/err.c | 10 +++++++---
> > > > >    1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > > > index b0e6048a9208..53cd9200ec2c 100644
> > > > > --- a/drivers/pci/pcie/err.c
> > > > > +++ b/drivers/pci/pcie/err.c
> > > > > @@ -204,9 +204,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> > > > >    	else
> > > > >    		pci_walk_bus(bus, report_normal_detected, &status);
> > > > > -	if (state == pci_channel_io_frozen &&
> > > > > -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> > > > > -		goto failed;
> > > > > +	if (state == pci_channel_io_frozen) {
> > > > > +		status = reset_link(dev, service);
> > > > > +		if (status != PCI_ERS_RESULT_RECOVERED)
> > > > > +			goto failed;
> > > > > +		goto done;
> > > > > +	}
> > > > >    	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> > > > >    		status = PCI_ERS_RESULT_RECOVERED;
> > > > > @@ -228,6 +231,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> > > > >    	if (status != PCI_ERS_RESULT_RECOVERED)
> > > > >    		goto failed;
> > > > > +done:
> > > > >    	pci_dbg(dev, "broadcast resume message\n");
> > > > >    	pci_walk_bus(bus, report_resume, &status);
> > > > > -- 
> > > > > 2.21.0
> > > > > 
> > > -- 
> > > Sathyanarayanan Kuppuswamy
> > > Linux kernel developer
> > > 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
> 
