Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16768838E5
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfHFSoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 14:44:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:9448 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfHFSoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 14:44:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 11:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="165067943"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2019 11:44:05 -0700
Message-ID: <1565118316.2401.112.camel@intel.com>
Subject: Re: [RFC V1 RESEND 2/6] PCI/MSI: Dynamic allocation of MSI-X
 vectors by group
From:   Megha Dey <megha.dey@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com
Date:   Tue, 06 Aug 2019 12:05:16 -0700
In-Reply-To: <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
         <1561162778-12669-3-git-send-email-megha.dey@linux.intel.com>
         <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2019-06-29 at 09:59 +0200, Thomas Gleixner wrote:
> Megha,
> 
> On Fri, 21 Jun 2019, Megha Dey wrote:
> 
> > 
> > Currently, MSI-X vector enabling and allocation for a PCIe device
> > is
> > static i.e. a device driver gets only one chance to enable a
> > specific
> > number of MSI-X vectors, usually during device probe. Also, in many
> > cases, drivers usually reserve more than required number of vectors
> > anticipating their use, which unnecessarily blocks resources that
> > could have been made available to other devices. Lastly, there is
> > no
> > way for drivers to reserve more vectors, if the MSI-X has already
> > been
> > enabled for that device.
> It would be helpful if the justification for this would contain a
> real
> world example instead of some handwaving. Also this whole set lacks a
> pointer to a driver which makes use of it.

Hi Thomas,

Totally agreed. The request to add a dynamic MSI-X infrastructure came
from some driver teams internally and currently they do not have
bandwidth to come up with relevant test cases. <sigh>

But we hope that this patch set could serve as a precursor to the
interrupt message store (IMS) patch set, and we can use this patch set
as the baseline for the IMS patches.

> 
> > 
> > Hence, a dynamic MSI-X kernel infrastructure can benefit drivers by
> > deferring MSI-X allocation to post probe phase, where actual demand
> > information is available.
> > 
> > This patch enables the dynamic allocation of MSI-X vectors even
> > after
> git grep 'This patch' Documentation/process/submitting-patches.rst
> 

Yeah, will change this in V2.

> > 
> > MSI-X is enabled for a PCIe device by introducing a new API:
> > pci_alloc_irq_vectors_dyn().
> > 
> > This API can be called multiple times by the driver. The MSI-X
> > vectors
> > allocated each time are associated with a group ID. If the existing
> > static allocation is used, a default group ID of -1 is assigned.
> > The
> Why -1? Why not start from group ID 0 which is the most natural
> thing,
> 

According to this scheme, we had divided static/dynamic allocation of
the MSI-X vectors, hence the statically allocated vectors were assigned
a default group ID -1. The dynamic allocation group IDs would start
from 0.

But now if we are going to treat the current static allocation of MSI-X 
vectors also as a group ID, the IDs should start from 0.

> > 
> > +
> >  	/* Configure MSI capability structure */
> >  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
> >  	if (ret) {
> > @@ -669,7 +676,7 @@ static void __iomem *msix_map_region(struct
> > pci_dev *dev, unsigned nr_entries)
> >  
> >  static int msix_setup_entries(struct pci_dev *dev, void __iomem
> > *base,
> >  			      struct msix_entry *entries, int
> > nvec,
> > -			      struct irq_affinity *affd)
> > +			      struct irq_affinity *affd, int
> > group)
> >  {
> >  	struct irq_affinity_desc *curmsk, *masks = NULL;
> >  	struct msi_desc *entry;
> > @@ -698,8 +705,20 @@ static int msix_setup_entries(struct pci_dev
> > *dev, void __iomem *base,
> >  			entry->msi_attrib.entry_nr = i;
> >  		entry->msi_attrib.default_irq	= dev->irq;
> >  		entry->mask_base		= base;
> > +		entry->group_id			= group;
> >  
> >  		list_add_tail(&entry->list, dev_to_msi_list(&dev-
> > >dev));
> What protects other users which might concurrently iterate the list
> from
> falling on their nose?
> 
> Right now the device entry list is set up and then considered
> immutable
> until the driver shuts down. So there is no need for serialization.
> 
> With that scheme entries are populated piecewise and are visible and
> might
> be in use.

Yeah, good point, I will add a mutex_lock to protect the list.

According to your proposal, now we will have 2 lists; one for the
groups and one for the entries belonging to that group, so I will add
the necessary protection for both of these lists.

> > 
> > +
> > +		/*
> > +		 * Save the pointer to the first msi_desc entry of
> > every
> > +		 * MSI-X group. This pointer is used by other
> > functions
> > +		 * as the starting point to iterate through each
> > of the
> > +		 * entries in that particular group.
> > +		 */
> > +		if (!i)
> > +			dev->dev.grp_first_desc = list_last_entry
> > +			(dev_to_msi_list(&dev->dev), struct
> > msi_desc, list);
> How is that supposed to work? The pointer gets overwritten on every
> invocation of that interface. I assume this is merily an intermediate
> storage for setup. Shudder.
> 

Yes, you are right.

The grp_first_desc is simply a temporary storage to store the
first msi_desc entry of every group, which can be used by other
functions to iterate through the entries belonging to that group only,
using the for_each_pci_msi_entry/ for_each_msi_entry_from macro. It is
not the cleanest of solutions, I agree.

With your proposal of supporting a separate group list, I don't think
there will be a need to use this kind of temporary storage variable.

> > 
> > +
> >  		if (masks)
> >  			curmsk++;
> >  	}
> > @@ -715,7 +734,7 @@ static void msix_program_entries(struct pci_dev
> > *dev,
> >  	struct msi_desc *entry;
> >  	int i = 0;
> >  
> > -	for_each_pci_msi_entry(entry, dev) {
> > +	for_each_pci_msi_entry_from(entry, dev) {
>   > +/* Iterate through MSI entries of device dev starting from a
> given desc */
>   > +#define for_each_msi_entry_from(desc,
> dev)                             \
>   > +       desc =
> (*dev).grp_first_desc;                                   \
>   > +       list_for_each_entry_from((desc), dev_to_msi_list((dev)),
> list)  \
> 
> So this hides the whole group stuff behind a hideous iterator.
> 
> for_each_pci_msi_entry_from() ? from what? from the device? Sane
> iterators
> which have a _from naming, have also a from argument.
> 

This was meant to be "iterate over all the entries belonging to a
group", sorry if that was not clear. 

The current 'for_each_pci_msi_entry' macro iterates through all the
msi_desc entries belonging to a particular device. Since we have a
piecewise allocation of the MSI-X vectors with this change, we would
want to iterate only through the newly added entries, i.e the entries
allocated to the current group.

In V2, I will introduce a new macro, 'for_each_pci_msi_entry_group',
which will only iterate through the msi_desc entries belonging to a
particular group.

> > 
> >  		if (entries)
> >  			entries[i++].vector = entry->irq;
> >  		entry->masked = readl(pci_msix_desc_addr(entry) +
> > @@ -730,28 +749,31 @@ static void msix_program_entries(struct
> > pci_dev *dev,
> >   * @entries: pointer to an array of struct msix_entry entries
> >   * @nvec: number of @entries
> >   * @affd: Optional pointer to enable automatic affinity
> > assignement
> > + * @group: The Group ID to be allocated to the msi-x vectors
> That suggest that the group id is allocated in this function. Which
> is not
> true. The id is handed in so the entries can be associated to that
> group.
> 

Yeah , my bad , I will update this in V2

> > 
> >   *
> >   * Setup the MSI-X capability structure of device function with a
> >   * single MSI-X irq. A return of zero indicates the successful
> > setup of
> >   * requested MSI-X entries with allocated irqs or non-zero for
> > otherwise.
> >   **/
> >  static int msix_capability_init(struct pci_dev *dev, struct
> > msix_entry *entries,
> > -				int nvec, struct irq_affinity
> > *affd)
> > +				int nvec, struct irq_affinity
> > *affd, int group)
> >  {
> >  	int ret;
> >  	u16 control;
> > -	void __iomem *base;
> >  
> >  	/* Ensure MSI-X is disabled while it is set up */
> >  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE,
> > 0);
> >  
> >  	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
> > &control);
> > +
> >  	/* Request & Map MSI-X table region */
> > -	base = msix_map_region(dev, msix_table_size(control));
> > -	if (!base)
> > -		return -ENOMEM;
> > +	if (!dev->msix_enabled) {
> > +		dev->base = msix_map_region(dev,
> > msix_table_size(control));
> > +		if (!dev->base)
> > +			return -ENOMEM;
> > +	}
> >  
> > -	ret = msix_setup_entries(dev, base, entries, nvec, affd);
> > +	ret = msix_setup_entries(dev, dev->base, entries, nvec,
> > affd, group);
> >  	if (ret)
> >  		return ret;
> Any error exit in this function will leave MSIx disabled. That means
> if
> this is a subsequent group allocation which fails for whatever
> reason, this
> will render all existing and possibly already in use interrupts
> unusable.
> 

Hmmm yeah, I hadn't thought about this!

So according to the code, we must 'Ensure MSI-X is disabled while it is
set up'. MSI-X would be disabled until the setup of the new vectors is
complete, even if we do not take the error exit right?

Earlier this was not a problem since we disable the MSI-X, setup all
the vectors at once, and then enable the MSI-X once and for all. 

I am not sure how to avoid disabling of MSI-X here.

> > 
> >  static int __pci_enable_msix_range(struct pci_dev *dev,
> >  				   struct msix_entry *entries, int
> > minvec,
> > -				   int maxvec, struct irq_affinity
> > *affd)
> > +				   int maxvec, struct irq_affinity
> > *affd,
> > +				   bool one_shot, int group)
> >  {
> >  	int rc, nvec = maxvec;
> >  
> >  	if (maxvec < minvec)
> >  		return -ERANGE;
> >  
> > -	if (WARN_ON_ONCE(dev->msix_enabled))
> > -		return -EINVAL;
> So any misbehaving PCI driver can now call into this without being
> caught.
> 

I do not understand what misbehaving PCI driver means :(

Basically this statement is what denies multiple MSI-X vector
allocations, and I wanted to remove it so that we could do just that.

Please let me know how I could change this.

> > 
> > -
> >  	for (;;) {
> >  		if (affd) {
> >  			nvec = irq_calc_affinity_vectors(minvec,
> > nvec, affd);
> > @@ -1096,7 +1118,8 @@ static int __pci_enable_msix_range(struct
> > pci_dev *dev,
> >  				return -ENOSPC;
> >  		}
> >  
> > -		rc = __pci_enable_msix(dev, entries, nvec, affd);
> > +		rc = __pci_enable_msix(dev, entries, nvec, affd,
> > one_shot,
> > +									
> > group);
> >  		if (rc == 0)
> >  			return nvec;
> >  
> > @@ -1127,7 +1150,8 @@ static int __pci_enable_msix_range(struct
> > pci_dev *dev,
> >  int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry
> > *entries,
> >  		int minvec, int maxvec)
> >  {
> > -	return __pci_enable_msix_range(dev, entries, minvec,
> > maxvec, NULL);
> > +	return __pci_enable_msix_range(dev, entries, minvec,
> > maxvec, NULL,
> > +								fa
> > lse, -1);
> >  }
> >  EXPORT_SYMBOL(pci_enable_msix_range);
> >  
> > @@ -1153,9 +1177,49 @@ int pci_alloc_irq_vectors_affinity(struct
> > pci_dev *dev, unsigned int min_vecs,
> >  				   unsigned int max_vecs, unsigned
> > int flags,
> >  				   struct irq_affinity *affd)
> >  {
> > +	int group = -1;
> > +
> > +	dev->one_shot = true;
> So instead of checking first whether this was already initialized you
> unconditionally allow this function to be called and cause havoc.
> 

Ok, got your point.

With your proposal, we can remove the one_shot member, as we will
change to use the current allocation as a group allocation itself.

> > 
> > +
> > +	return pci_alloc_irq_vectors_affinity_dyn(dev, min_vecs,
> > max_vecs,
> > +					flags, NULL, &group, dev-
> > >one_shot);
> > +}
> > +EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> > +
> > +/**
> > + * pci_alloc_irq_vectors_affinity_dyn - allocate multiple IRQs for
> > a device
> > + * dynamically. Can be called multiple times.
> > + * @dev:		PCI device to operate on
> > + * @min_vecs:		minimum number of vectors required
> > (must be >= 1)
> > + * @max_vecs:		maximum (desired) number of vectors
> > + * @flags:		flags or quirks for the allocation
> > + * @affd:		optional description of the affinity
> > requirements
> > + * @group_id:		group ID assigned to vectors
> > allocated
> This is again misleading. It suggest that this is a group id handed
> in,
> while it is a pointer to an int where the group id will be stored.
> 

Yeah will update this in V2.

> > 
> > + * @one_shot:		true if dynamic MSI-X allocation is
> > disabled, else false
> What? You have a interface for dynamically allocating the vectors and
> that
> has an argument to disable dynamic allocation?

Well my intention was to let the user choose if they wanted the
one_shot(static) or the dynamic approach to allocate MSI-X vectors.

Of course when we change to your suggested approach, we will not have
this issue, since everything will be a group allocation.

> 
> > 
> > + * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-
> > X. Return
> > + * the number of vectors allocated (which might be smaller than
> > @max_vecs)
> > + * if successful, or a negative error code on error. If less than
> > @min_vecs
> > + * interrupt vectors are available for @dev the function will fail
> > with -ENOSPC.
> > + * Assign a unique group ID to the set of vectors being allocated.
> > + *
> > + * To get the Linux IRQ number used for a vector that can be
> > passed to
> > + * request_irq() use the pci_irq_vector_group() helper.
> > + */
> > +int pci_alloc_irq_vectors_affinity_dyn(struct pci_dev *dev,
> > +				       unsigned int min_vecs,
> > +				       unsigned int max_vecs,
> > +				       unsigned int flags,
> > +				       struct irq_affinity *affd,
> > +				       int *group_id, bool
> > one_shot)
> > +{
> > +
> >  	struct irq_affinity msi_default_affd = {0};
> > -	int msix_vecs = -ENOSPC;
> > +	int msix_vecs = -ENOSPC, i;
> >  	int msi_vecs = -ENOSPC;
> > +	struct msix_entry *entries = NULL;
> > +	struct msi_desc *entry;
> > +	int p = 0;
> >  
> >  	if (flags & PCI_IRQ_AFFINITY) {
> >  		if (!affd)
> > @@ -1166,8 +1230,54 @@ int pci_alloc_irq_vectors_affinity(struct
> > pci_dev *dev, unsigned int min_vecs,
> >  	}
> >  
> >  	if (flags & PCI_IRQ_MSIX) {
> > -		msix_vecs = __pci_enable_msix_range(dev, NULL,
> > min_vecs,
> > -						    max_vecs,
> > affd);
> > +		if (dev->msix_enabled) {
> > +			if (one_shot) {
> > +				goto err_alloc;
> > +			} else {
> > +				for_each_pci_msi_entry(entry, dev)
> > {
> > +					if (entry->group_id != -1)
> > +						p = 1;
> > +				}
> > +				if (!p)
> > +					goto err_alloc;
> > +			}
> > +		} else {
> > +			dev->num_msix = pci_msix_vec_count(dev);
> > +			dev->entry = kcalloc(BITS_TO_LONGS(dev-
> > >num_msix),
> > +					sizeof(unsigned long),
> > GFP_KERNEL);
> > +			if (!dev->entry)
> > +				return -ENOMEM;
> > +		}
> > +
> > +		entries = kcalloc(max_vecs, sizeof(struct
> > msix_entry),
> > +								GF
> > P_KERNEL);
> > +		if (entries == NULL)
> > +			return -ENOMEM;
> > +
> > +		for (i = 0; i < max_vecs; i++) {
> > +			entries[i].entry = find_first_zero_bit(
> > +						dev->entry, dev-
> > >num_msix);
> > +			if (entries[i].entry == dev->num_msix)
> > +				return -ENOSPC;
> Leaks entries and dev->entry
> 

Hmm, I do a kfree(entries) later. But yeah the dev->entry has a memory
leak.

> > 
> > +			set_bit(entries[i].entry, dev->entry);
> > +		}
> > +
> > +		if (!one_shot) {
> > +			/* Assign a unique group ID */
> > +			*group_id = idr_alloc(dev->grp_idr, NULL,
> > +						0, dev->num_msix,
> > GFP_KERNEL);
> Why on earth do you need an IDR for this? The group ID is merily a
> cookie. So just having an u64 which starts from 0 and is incremented
> after
> each invocation should be good enough. You can catch the wraparound
> case,
> but even if you just use an unsigned int, then it takes 4G
> invocations to
> reach that point.
> 

I thought an IDR is better to manage the group IDs i.e to track
the group ID which have been allocated/freed, so that the group ID
could be reused.

For now MSI-X can have a maximum of 2048 interrupts, but going forward
the IMS interrupts have no theoretical limit. Since it seems unlikely
that there will be > 2^64 IMS vectors for any system, for now we can
have the simple approach suggested by you, and make changes later if
necessary.

So, in V2 the group ID will only be a monotonically increasing number,
which does not get reused even if the group is deleted at some point.

> > 
> > +			if (*group_id < 0) {
> > +				if (*group_id == -ENOSPC)
> > +					pci_err(dev, "No free
> > group IDs\n");
> > +				return *group_id;
> > +			}
> > +		}
> > +
> > +		msix_vecs = __pci_enable_msix_range(dev, entries,
> > min_vecs,
> > +					max_vecs, affd, one_shot,
> > *group_id);
> > +
> > +		kfree(entries);
> > +
> >  		if (msix_vecs > 0)
> >  			return msix_vecs;
> >  	}
> > @@ -1197,8 +1307,12 @@ int pci_alloc_irq_vectors_affinity(struct
> > pci_dev *dev, unsigned int min_vecs,
> >  	if (msix_vecs == -ENOSPC)
> >  		return -ENOSPC;
> >  	return msi_vecs;
> > +
> > +err_alloc:
> > +	WARN_ON_ONCE(dev->msix_enabled);
> Oh well.
> 

Will remove this in V2.

> > 
> > +	return -EINVAL;
> >  }
> > -EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> > +EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity_dyn);
> >  
> > +	/* For dynamic MSI-x */
> > +	dev->grp_idr = kzalloc(sizeof(struct idr), GFP_KERNEL);
> > +	if (!dev->grp_idr)
> > +		return NULL;
> > +
> > +	/* Initialise the IDR structures */
> > +	idr_init(dev->grp_idr);
> As already pointed out, that's overengineered.
> 
> First of all this patch is doing too many things at once. These
> changes
> need to be split up in reviewable bits and pieces.

Yes, will submit smaller changes in V2.

> 
> But I consider this approach as a POC and not something which can be
> meant
> as a maintainable solution. It just duct tapes this new functionality
> into
> the existing code thereby breaking things left and right. And even if
> you
> can 'fix' these issues with more duct tape it won't be maintainable
> at all.
> 

Yeah I agree that this is not maintainable in the long run.

> If you want to support group based allocations, then the PCI/MSI
> facility
> has to be refactored from ground up.
> 
>   1) Introduce the concept of groups by adding a group list head to
> struct
>      pci_dev. Ideally you create a new struct pci_dev_msi or whatever
> where
>      all this muck goes into.
> 

I think we can use the existing list_head 'msi_list' in the struct
device for this, instead of having a new list_head for the group. So
now instead of msi_list being a list of all the msi_desc entries, it
will have a list of the different groups associated with the device.

IMHO, since IMS is non PCI compliant, having this group_list_head would
be better off in struct device than struct pci_dev, which would enable
code reuse.

>   2) Change the existing code to treat the current allocation mode as
> a
>      group allocation. Keep the entries in a new struct
> msi_entry_group and
>      have a group id, list head and the entries in there.
> 

I am thinking of something like this, please let me know if this is
what you are suggesting:

1. Introduce a new msi_entry_group struct:
struct msi_entry_grp {
  int group_id; // monotonically increasing group_id
  int num_vecs; // number of msi_desc entries per group
  struct list_head group_list; // Added to msi_list in struct device
  struct list_head entry_list; // list of msi_desc entries for this grp
}

2. Add a new 'for_each_pci_msi_entry_group' macro. This macro should
only iterate through the msi_desc entries belonging to a group.

3. The existing for_each_pci_msi_entry, needs to be modified so that it
is backward compatible. This macro should still be able to iterate
through all the entries in all the groups. 

>      Take care of protecting the group list.
> 
>      Assign group id 0 and add the entry_group to the list in the pci
> device.
> 
>      Rework the related functions so they are group aware.
> 
>      This can be split into preparatory and functional pieces, i.e.
> multiple
>      patches.
> 
>   3) Split out the 'first time' enablement code into separate
> functions and
>      store the relevant state in struct pci_dev_msi
> 
>   4) Rename pci_alloc_irq_vectors_affinity() to
>      pci_alloc_irq_vectors_affinity_group() and add a group_id
> pointer
>      argument.
> 
>      Make pci_alloc_irq_vectors_affinity() a wrapper function which
> hands
>      in a NULL group id pointer and does proper sanity checking.
> 
>   5) Create similar constructs for related functionality
> 
>   6) Enable the group allocation mode for subsequent allocations
> 

All this makes perfect sense. Thanks for the detailed feedback Thomas,
I will send out a V2 shortly.

> Thanks,
> 
> 	tglx
> 
> 
>   
> 
