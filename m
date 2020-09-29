Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC027C227
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgI2KO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:14:59 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:50343 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgI2KO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 06:14:57 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 06:14:56 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 158632801039B;
        Tue, 29 Sep 2020 12:08:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E139A209CB; Tue, 29 Sep 2020 12:07:59 +0200 (CEST)
Date:   Tue, 29 Sep 2020 12:07:59 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ethan Zhao <xerces.zhao@gmail.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Ethan Zhao <haifeng.zhao@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Oliver <oohall@gmail.com>,
        ruscur@russell.cc,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>, ashok.raj@linux.intel.com,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Subject: Re: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of
 DPC before handling DLLSC and PDC
Message-ID: <20200929100759.GA21885@wunner.de>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com>
 <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
 <20200929081800.GA15858@wunner.de>
 <CAKF3qh3UxkVOwCOUB4rNdxLX0k9oZQRzXT_N0BNYKWL_BAHa5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKF3qh3UxkVOwCOUB4rNdxLX0k9oZQRzXT_N0BNYKWL_BAHa5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 05:46:41PM +0800, Ethan Zhao wrote:
> On Tue, Sep 29, 2020 at 4:29 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Sun, Sep 27, 2020 at 11:27:46AM -0400, Sinan Kaya wrote:
> > > On 9/26/2020 11:28 PM, Ethan Zhao wrote:
> > > > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > > > @@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> > > >     down_read(&ctrl->reset_lock);
> > > >     if (events & DISABLE_SLOT)
> > > >             pciehp_handle_disable_request(ctrl);
> > > > -   else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
> > > > +   else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
> > > > +           pci_wait_port_outdpc(pdev);
> > > >             pciehp_handle_presence_or_link_change(ctrl, events);
> > > > +   }
> > > >     up_read(&ctrl->reset_lock);
> > >
> > > This looks like a hack TBH.
[...]
> > > Why is device lock not protecting this situation?
> > > Is there a lock missing in hotplug driver?
> >
> > According to Ethan's commit message, there are two issues here:
> > One, that pciehp may remove a device even though DPC recovered the error,
> > and two, that a null pointer deref occurs.
> >
> > The latter is most certainly not a locking issue but failure of DPC
> > to hold a reference on the pci_dev.
> 
> This is what patch 3/5 proposed to fix.

Please reorder the series to fix the null pointer deref first,
i.e. move patch 3 before patch 2.  If the null pointer deref is
fixed by patch 3, do not mention it in patch 2.

Thanks,

Lukas
