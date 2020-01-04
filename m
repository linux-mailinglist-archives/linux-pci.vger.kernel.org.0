Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4313004F
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2020 03:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgADCyS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 21:54:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgADCyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jan 2020 21:54:18 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8441F21734;
        Sat,  4 Jan 2020 02:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578106456;
        bh=GtmSPPQcxVoRmv6SdAaSiNS6pLyQpUBLceP4jq+f3QM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JYYzR5wM1GeabfRJ1t12x/L9lKTP+k8lYiz8mR1E4WaYnlcx3giXXKvoFT3Ths+t5
         2KdMidQSq54cUXiZnMUbtcWBH7ynO/rghY9bPzW0mqP7zmRu6gMGl6vnh0ci6ZurUB
         fpQTv+34pRnJSAJGxrjgisvHlImVoITTcyq1vIRs=
Date:   Fri, 3 Jan 2020 20:54:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v11 1/8] PCI/ERR: Update error status after reset_link()
Message-ID: <20200104025414.GA85401@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbefb691-4171-8e58-e9ad-b4632645e519@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 03, 2020 at 05:03:03PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 1/3/20 4:34 PM, Bjorn Helgaas wrote:
> > On Thu, Dec 26, 2019 at 04:39:07PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> > > reset_link() to recover from fatal errors. But, if the reset is
> > > successful there is no need to continue the rest of the error recovery
> > > checks. Also, during fatal error recovery, if the initial value of error
> > > status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> > > even after successful recovery (using reset_link()) pcie_do_recovery()
> > > will report the recovery result as failure. So update the status of
> > > error after reset_link().
> > I like the part about updating "status" with the result of
> > reset_link(), and I split that into its own patch because it
> > seems like a fix that *can* be separated.
> > 
> > But I'm not convinced that we should skip the ->slot_reset()
> > callbacks if the reset_link() was successful.
>
> If reset_link() call is successful then the result value will be
> "PCI_ERS_RESULT_RECOVERED". So even if you proceed with
> rest of the code, slot_reset() will never get called right ?

The current code:

        if (state == pci_channel_io_frozen &&
            reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
                goto failed;
        ...
        if (status == PCI_ERS_RESULT_NEED_RESET) {
                status = PCI_ERS_RESULT_RECOVERED;
                pci_walk_bus(bus, report_slot_reset, &status);

doesn't save the result of reset_link(), so if status was
PCI_ERS_RESULT_NEED_RESET and the reset succeeds, we will call
->slot_reset().

After your patch, if "state == pci_channel_io_frozen", we *never* call
->slot_reset().

Do you think that matches pci-error-recovery.rst?  It doesn't seem
like it to me, but perhaps I haven't read it closely enough.

> > According to
> > Documentation/PCI/pci-error-recovery.rst, we should call
> > ->slot_reset() after completion of the reset.
> > 
> > For example, rsxx_err_handler implements ->slot_reset(), but
> > not ->resume().  If we reset the device, we'll claim success and
> > return, but we won't call rsxx_slot_reset(), which does a bunch
> > of important-looking recovery stuff.
> > 
> > If pci-error-recovery.rst is wrong, we should fix that (after
> > auditing all the drivers to make sure they match).
> > 
> > > Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > Acked-by: Keith Busch <keith.busch@intel.com>
> > > ---
> > >   drivers/pci/pcie/err.c | 10 +++++++---
> > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > index b0e6048a9208..53cd9200ec2c 100644
> > > --- a/drivers/pci/pcie/err.c
> > > +++ b/drivers/pci/pcie/err.c
> > > @@ -204,9 +204,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> > >   	else
> > >   		pci_walk_bus(bus, report_normal_detected, &status);
> > > -	if (state == pci_channel_io_frozen &&
> > > -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> > > -		goto failed;
> > > +	if (state == pci_channel_io_frozen) {
> > > +		status = reset_link(dev, service);
> > > +		if (status != PCI_ERS_RESULT_RECOVERED)
> > > +			goto failed;
> > > +		goto done;
> > > +	}
> > >   	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> > >   		status = PCI_ERS_RESULT_RECOVERED;
> > > @@ -228,6 +231,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> > >   	if (status != PCI_ERS_RESULT_RECOVERED)
> > >   		goto failed;
> > > +done:
> > >   	pci_dbg(dev, "broadcast resume message\n");
> > >   	pci_walk_bus(bus, report_resume, &status);
> > > -- 
> > > 2.21.0
> > > 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
> 
