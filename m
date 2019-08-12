Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E764F8A515
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfHLR6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 13:58:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:16540 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfHLR6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 13:58:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 10:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="376033949"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga006.fm.intel.com with ESMTP; 12 Aug 2019 10:52:30 -0700
Message-ID: <1565633624.7042.23.camel@intel.com>
Subject: Re: [RFC V1 RESEND 5/6] PCI/MSI: Free MSI-X resources by group
From:   Megha Dey <megha.dey@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com
Date:   Mon, 12 Aug 2019 11:13:44 -0700
In-Reply-To: <alpine.DEB.2.21.1908110912470.7324@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
          <1561162778-12669-6-git-send-email-megha.dey@linux.intel.com>
          <alpine.DEB.2.21.1906291002190.1802@nanos.tec.linutronix.de>
         <1565118597.2401.116.camel@intel.com>
         <alpine.DEB.2.21.1908110912470.7324@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 2019-08-11 at 09:18 +0200, Thomas Gleixner wrote:
> On Tue, 6 Aug 2019, Megha Dey wrote:
> 
> > 
> > On Sat, 2019-06-29 at 10:08 +0200, Thomas Gleixner wrote:
> > > 
> > > Megha,
> > > 
> > > On Fri, 21 Jun 2019, Megha Dey wrote:
> > > > 
> > > > 
> > > > +static int free_msi_irqs_grp(struct pci_dev *dev, int
> > > > group_id)
> > > > +{
> > > > 
> > > > +
> > > > +	for_each_pci_msi_entry(entry, dev) {
> > > > +		if (entry->group_id == group_id && entry->irq)
> > > > +			for (i = 0; i < entry->nvec_used; i++)
> > > > +				BUG_ON(irq_has_action(entry-
> > > > >irq +
> > > > i));
> > > BUG_ON is wrong here. This can and must be handled gracefully.
> > > 
> > Hmm, I reused this code from the 'free_msi_irqs' function. I am not
> > sure why it is wrong to use BUG_ON here but ok to use it there,
> > please
> > let me know.
> We are not adding BUG_ON() anymore except for situations where there
> is
> absolutely no way out. Just because there is still older code having
> BUG_ON() does not make it any better. Copying it surely is no
> justification.
> 
> If there is really no way out, then you need to explain it.
> 

Ok, got it. I will look into it closely to see if the BUG_ON is
absolutely required.

>  
> > 
> > > 
> > > > 
> > > > +static void pci_msix_shutdown_grp(struct pci_dev *dev, int
> > > > group_id)
> > > > +{
> > > > +	struct msi_desc *entry;
> > > > +	int grp_present = 0;
> > > > +
> > > > +	if (pci_dev_is_disconnected(dev)) {
> > > > +		dev->msix_enabled = 0;
> > > Huch? What's that? I can't figure out why this is needed and of
> > > course it
> > > completely lacks a comment explaining this. 
> > > 
> > Again, I have reused this code from the pci_msix_shutdown()
> > function.
> > So for the group case, this is not required?
> Copy and paste is not an argument, really. Can this happen here? If
> so,
> then please add a comment.
> 

Ok, will do.
> > 
> > > 
> > > > 
> > > > 
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	/* Return the device with MSI-X masked as initial
> > > > states
> > > > */
> > > > +	for_each_pci_msi_entry(entry, dev) {
> > > > +		if (entry->group_id == group_id) {
> > > > +			/* Keep cached states to be restored
> > > > */
> > > > +			__pci_msix_desc_mask_irq(entry, 1);
> > > > +			grp_present = 1;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (!grp_present) {
> > > > +		pci_err(dev, "Group to be disabled not
> > > > present\n");
> > > > +		return;
> > > So you print an error and silently return
> > > 
> > This is a void function, hence no error value can be returned. What
> > do
> > you think is the right thing to do if someone wants to delete a
> > group
> > which is not present?
> Well, you made it a void function. 

ok sure, got your point.
>  
> > 
> > > 
> > > > 
> > > > 
> > > > +	}
> > > > +}
> > > > +
> > > > +int pci_disable_msix_grp(struct pci_dev *dev, int group_id)
> > > > +{
> > > > +	int num_vecs;
> > > > +
> > > > +	if (!pci_msi_enable || !dev)
> > > > +		return -EINVAL;
> > > > +
> > > > +	pci_msix_shutdown_grp(dev, group_id);
> > > > +	num_vecs = free_msi_irqs_grp(dev, group_id);
> > > just to call in another function which has to do the same
> > > group_id
> > > lookup
> > > muck again.
> > Even with the new proposal, we are to have 2 sets of functions: one
> > to
> > delete all the msic_desc entries associated with the device, and
> > the
> > other to delete those only belonging a 'user specified' group. So
> > we do
> > need to pass a group_id to these functions right? Yes, internally
> > the
> > deletion would be straightforward with the new approach.
> That does not matter. If pci_msix_shutdown_grp() does not find a
> group, why
> proceeding instead of having a proper error return and telling the
> caller?
> 

Oh ok, I got it now, I will return a proper error code in the
pci_msi_shutdown_grp and do the free_msi_irqs_grp only if the group is
found.

> Thanks,
> 
> 	tglx
