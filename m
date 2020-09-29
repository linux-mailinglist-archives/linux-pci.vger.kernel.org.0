Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081B27BF58
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgI2I1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 04:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgI2I1S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 04:27:18 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Sep 2020 01:27:18 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34456C061755;
        Tue, 29 Sep 2020 01:27:18 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C9ACA3000C988;
        Tue, 29 Sep 2020 10:18:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 91B9959759; Tue, 29 Sep 2020 10:18:00 +0200 (CEST)
Date:   Tue, 29 Sep 2020 10:18:00 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Ethan Zhao <haifeng.zhao@intel.com>, bhelgaas@google.com,
        oohall@gmail.com, ruscur@russell.cc,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com, mika.westerberg@linux.intel.com,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com
Subject: Re: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of
 DPC before handling DLLSC and PDC
Message-ID: <20200929081800.GA15858@wunner.de>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com>
 <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 27, 2020 at 11:27:46AM -0400, Sinan Kaya wrote:
> On 9/26/2020 11:28 PM, Ethan Zhao wrote:
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> >  	down_read(&ctrl->reset_lock);
> >  	if (events & DISABLE_SLOT)
> >  		pciehp_handle_disable_request(ctrl);
> > -	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
> > +	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
> > +		pci_wait_port_outdpc(pdev);
> >  		pciehp_handle_presence_or_link_change(ctrl, events);
> > +	}
> >  	up_read(&ctrl->reset_lock);
> 
> This looks like a hack TBH.
> 
> Lukas, Keith;
> 
> What is your take on this?
> Why is device lock not protecting this situation?
> 
> Is there a lock missing in hotplug driver?

According to Ethan's commit message, there are two issues here:
One, that pciehp may remove a device even though DPC recovered the error,
and two, that a null pointer deref occurs.

The latter is most certainly not a locking issue but failure of DPC
to hold a reference on the pci_dev.

Thanks,

Lukas
