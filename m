Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD1D1538AC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 20:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBETDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 14:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBETDk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 14:03:40 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4114217BA;
        Wed,  5 Feb 2020 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580929419;
        bh=s4sCPMZzjx09ipN9D6fBvtZZmWenqnm+d8znhpi4TZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0AKQV4UfO1b+QsLo33c8vCAfvP7G5/ZUeMPltiu7YqChu+hOnUoUKqMGhMMwaiPys
         z9n6XYK5WgOjl8qvi/DXwGj+inl7NMbZEXz5QFPnx7Rx3VZ9MSmi6a0Uz251GXAWWp
         dYNBRi0Mieb69JSfl2NBHUVqU/FJpm5ijtfC31xU=
Date:   Wed, 5 Feb 2020 13:03:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v13 1/8] PCI/ERR: Update error status after reset_link()
Message-ID: <20200205190337.GA232001@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205182800.GB112031@skuppusw-desk.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 10:28:00AM -0800, Kuppuswamy Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On Sat, Jan 18, 2020 at 08:00:30PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
> > reset_link() to recover from fatal errors. But during fatal error
> > recovery, if the initial value of error status is
> > PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
> > even after successful recovery (using reset_link()) pcie_do_recovery()
> > will report the recovery result as failure. So update the status of
> > error after reset_link().
> 
> Since this patch has no dependency on EDR, can we merge it first?

We *could*, but I don't think there's any benefit.  bdb5ac85777d
appeared in v4.20, so this wouldn't really be a candidate for v5.6.

I'm expecting (hoping, anyway) that we'll merge this whole series for
v5.7.  For minor bugfixes like this one, we should add stable tags so
they'll get backported.

> > Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Acked-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/pci/pcie/err.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index b0e6048a9208..71639055511e 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -204,9 +204,11 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> >  	else
> >  		pci_walk_bus(bus, report_normal_detected, &status);
> >  
> > -	if (state == pci_channel_io_frozen &&
> > -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
> > -		goto failed;
> > +	if (state == pci_channel_io_frozen) {
> > +		status = reset_link(dev, service);
> > +		if (status != PCI_ERS_RESULT_RECOVERED)
> > +			goto failed;
> > +	}
> >  
> >  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> >  		status = PCI_ERS_RESULT_RECOVERED;
> > -- 
> > 2.21.0
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
