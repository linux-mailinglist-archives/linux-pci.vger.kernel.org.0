Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E63838EF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfHFSss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 14:48:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:55688 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFSsr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 14:48:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 11:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="165069094"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2019 11:48:46 -0700
Message-ID: <1565118597.2401.116.camel@intel.com>
Subject: Re: [RFC V1 RESEND 5/6] PCI/MSI: Free MSI-X resources by group
From:   Megha Dey <megha.dey@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@linux.intel.com
Date:   Tue, 06 Aug 2019 12:09:57 -0700
In-Reply-To: <alpine.DEB.2.21.1906291002190.1802@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
         <1561162778-12669-6-git-send-email-megha.dey@linux.intel.com>
         <alpine.DEB.2.21.1906291002190.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2019-06-29 at 10:08 +0200, Thomas Gleixner wrote:
> Megha,
> 
> On Fri, 21 Jun 2019, Megha Dey wrote:
> > 
> > +static int free_msi_irqs_grp(struct pci_dev *dev, int group_id)
> > +{
> > 
> > +
> > +	for_each_pci_msi_entry(entry, dev) {
> > +		if (entry->group_id == group_id && entry->irq)
> > +			for (i = 0; i < entry->nvec_used; i++)
> > +				BUG_ON(irq_has_action(entry->irq +
> > i));
> BUG_ON is wrong here. This can and must be handled gracefully.
> 

Hmm, I reused this code from the 'free_msi_irqs' function. I am not
sure why it is wrong to use BUG_ON here but ok to use it there, please
let me know.

> > 
> > +	}
> > +
> > +	pci_msi_teardown_msi_irqs_grp(dev, group_id);
> > +
> > +	list_for_each_entry_safe(entry, tmp, msi_list, list) {
> > +		if (entry->group_id == group_id) {
> > +			clear_bit(entry->msi_attrib.entry_nr, dev-
> > >entry);
> > +			list_del(&entry->list);
> > +			free_msi_entry(entry);
> > +		}
> > +	}
> > +
> > +	list_for_each_entry_safe(msix_sysfs_entry, tmp_msix,
> > pci_msix, list) {
> > +		if (msix_sysfs_entry->group_id == group_id) {
> Again. Proper group management makes all of that just straight
> forward and
> not yet another special case.
> 

Yeah, the new proposal of having a group_list would get rid of this.

> > 
> > +			msi_attrs = msix_sysfs_entry-
> > >msi_irq_group->attrs;
> >  
> > +static void pci_msix_shutdown_grp(struct pci_dev *dev, int
> > group_id)
> > +{
> > +	struct msi_desc *entry;
> > +	int grp_present = 0;
> > +
> > +	if (pci_dev_is_disconnected(dev)) {
> > +		dev->msix_enabled = 0;
> Huch? What's that? I can't figure out why this is needed and of
> course it
> completely lacks a comment explaining this. 
> 

Again, I have reused this code from the pci_msix_shutdown() function.
So for the group case, this is not required?

> > 
> > +		return;
> > +	}
> > +
> > +	/* Return the device with MSI-X masked as initial states
> > */
> > +	for_each_pci_msi_entry(entry, dev) {
> > +		if (entry->group_id == group_id) {
> > +			/* Keep cached states to be restored */
> > +			__pci_msix_desc_mask_irq(entry, 1);
> > +			grp_present = 1;
> > +		}
> > +	}
> > +
> > +	if (!grp_present) {
> > +		pci_err(dev, "Group to be disabled not
> > present\n");
> > +		return;
> So you print an error and silently return
> 

This is a void function, hence no error value can be returned. What do
you think is the right thing to do if someone wants to delete a group
which is not present?

> > 
> > +	}
> > +}
> > +
> > +int pci_disable_msix_grp(struct pci_dev *dev, int group_id)
> > +{
> > +	int num_vecs;
> > +
> > +	if (!pci_msi_enable || !dev)
> > +		return -EINVAL;
> > +
> > +	pci_msix_shutdown_grp(dev, group_id);
> > +	num_vecs = free_msi_irqs_grp(dev, group_id);
> just to call in another function which has to do the same group_id
> lookup
> muck again.

Even with the new proposal, we are to have 2 sets of functions: one to
delete all the msic_desc entries associated with the device, and the
other to delete those only belonging a 'user specified' group. So we do
need to pass a group_id to these functions right? Yes, internally the
deletion would be straightforward with the new approach.

> 
> > 
> > +
> > +	return num_vecs;
> > +}
> > +EXPORT_SYMBOL(pci_disable_msix_grp);
> Why is this exposed ?
> 

As before, I just followed what pci_disable_msix() did <sigh>. Looks
like pci_disable_msix is called from a variety of drivers, thus it is
exposed. Currently, no one will use the pci_disable_msix_grp()
externally, thus it need not be exposed for now.

> Thanks,
> 
> 	tglx
