Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8681AE932B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 23:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJ2Wsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 18:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfJ2Wsq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 18:48:46 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DD5F2087E;
        Tue, 29 Oct 2019 22:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572389324;
        bh=nGkre3Sct3Yf3NySCEnp4F3IW+iStUtH8WMnuaRtciY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HKL3uHQ5f832mdiZWTaWDdHO0xTJAZ79UxYj7BXixyTKZRYQYBz2EhNQGpJqgv48Q
         cxFhrHwu7pcerAOIr9vbWJz9rgxUZUGyUtZORyjFLjYF6f3uiZCdoOBtg7p/cvKdEt
         c506rGVG1iFe4JHvyTFcZz9aEN7MSP+VqbLsBNh4=
Date:   Tue, 29 Oct 2019 17:48:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v9 7/8] PCI/DPC: Clear AER registers in EDR mode
Message-ID: <20191029224842.GA121219@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283cbbb4-78b7-7773-5613-d77341af166b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 01:04:29PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 10/28/19 4:27 PM, Bjorn Helgaas wrote:
> > On Thu, Oct 03, 2019 at 04:39:03PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > As per PCI firmware specification r3.2 Downstream Port Containment
> > > Related Enhancements ECN,
> > Specific reference, please, e.g., the section/table/figure of the PCI
> > Firmware Spec being modified by the ECN.
> Ok. I will include it.
> > 
> > > OS is responsible for clearing the AER
> > > registers in EDR mode. So clear AER registers in dpc_process_error()
> > > function.
> > > 
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > Acked-by: Keith Busch <keith.busch@intel.com>
> > > ---
> > >   drivers/pci/pcie/dpc.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > index fafc55c00fe0..de2d892bc7c4 100644
> > > --- a/drivers/pci/pcie/dpc.c
> > > +++ b/drivers/pci/pcie/dpc.c
> > > @@ -275,6 +275,10 @@ static void dpc_process_error(struct dpc_dev *dpc)
> > >   		pci_aer_clear_fatal_status(pdev);
> > >   	}
> > > +	/* In EDR mode, OS is responsible for clearing AER registers */
> > > +	if (dpc->firmware_dpc)
> >
> > I guess "EDR mode" is effectively the same as "firmware-first mode"?
>
> Yes, EDR mode is an upgrade to FF mode in which firmware allows OS
> to share some of it job by sending ACPI notification. If you don't
> get ACPI notification, EDR mode is effectively same as FF mode.

Hmm, somehow the connection between FF and EDR needs to be clear from
the code, so people who weren't involved in the development of EDR and
don't even have access to the specs/ECNs can make sense out of this.

> > At least, the only place we set "firmware_dpc = 1" is:
> > 
> >    +       if (pcie_aer_get_firmware_first(pdev))
> >    +               dpc->firmware_dpc = 1;
> > 
> > If they're the same, why do we need two different names for it?
> For better readability and performance, I tried to cache the value of
> pcie_aer_get_firmware_first() result in DPC driver.

pcie_aer_get_firmware_first() already caches the value, so I don't
think you're gaining any useful performance here, and having two
different names *decreases* readability.

I do agree that pcie_aer_get_firmware_first() is not optimally
implemented.  I think we should probably look up the firmware-first
indication explicitly during enumeration so we don't have to bother
with the dev->__aer_firmware_first_valid thing.  And if we got rid of
all those leading underscores, it would probably run faster, too ;)

> > > +		pci_cleanup_aer_error_status_regs(pdev);
> > > +
> > >   	/*
> > >   	 * Irrespective of whether the DPC event is triggered by
> > >   	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
> > > -- 
> > > 2.21.0
> > > 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
> 
