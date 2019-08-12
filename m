Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251708A439
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfHLRZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 13:25:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:55016 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfHLRZ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 13:25:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 10:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="175952232"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 10:25:58 -0700
Message-ID: <1565632032.7042.12.camel@intel.com>
Subject: Re: [RFC V1 RESEND 2/6] PCI/MSI: Dynamic allocation of MSI-X
 vectors by group
From:   Megha Dey <megha.dey@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com
Date:   Mon, 12 Aug 2019 10:47:12 -0700
In-Reply-To: <alpine.DEB.2.21.1908071525390.24014@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com>
          <1561162778-12669-3-git-send-email-megha.dey@linux.intel.com>
          <alpine.DEB.2.21.1906280739100.32342@nanos.tec.linutronix.de>
         <1565118316.2401.112.camel@intel.com>
         <alpine.DEB.2.21.1908071525390.24014@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-08-07 at 15:56 +0200, Thomas Gleixner wrote:
> Megha,
> 
> On Tue, 6 Aug 2019, Megha Dey wrote:
> > 
> > On Sat, 2019-06-29 at 09:59 +0200, Thomas Gleixner wrote:
> > > 
> > > On Fri, 21 Jun 2019, Megha Dey wrote:
> > Totally agreed. The request to add a dynamic MSI-X infrastructure
> > came
> > from some driver teams internally and currently they do not have
> > bandwidth to come up with relevant test cases. <sigh>
> Hahahaha.
> 
> > 
> > But we hope that this patch set could serve as a precursor to the
> > interrupt message store (IMS) patch set, and we can use this patch
> > set
> > as the baseline for the IMS patches.
> If IMS needs the same functionality, then we need to think about it
> slightly differently because IMS is not necessarily tied to PCI.
>  
> IMS has some similarity to the ARM GIC ITS stuff IIRC, which already
> provides these things outside of PCI. Marc?
> 
> We probably need some generic infrastructure for this so PCI and
> everything
> else can use it.

Yeah agreed, I will look at the ARM GIC ITS to see how we can
consolidate this code.

> 
> > 
> > > 
> > > > 
> > > > +		/*
> > > > +		 * Save the pointer to the first msi_desc
> > > > entry of
> > > > every
> > > > +		 * MSI-X group. This pointer is used by other
> > > > functions
> > > > +		 * as the starting point to iterate through
> > > > each
> > > > of the
> > > > +		 * entries in that particular group.
> > > > +		 */
> > > > +		if (!i)
> > > > +			dev->dev.grp_first_desc =
> > > > list_last_entry
> > > > +			(dev_to_msi_list(&dev->dev), struct
> > > > msi_desc, list);
> > > How is that supposed to work? The pointer gets overwritten on
> > > every
> > > invocation of that interface. I assume this is merily an
> > > intermediate
> > > storage for setup. Shudder.
> > > 
> > Yes, you are right.
> > 
> > The grp_first_desc is simply a temporary storage to store the
> > first msi_desc entry of every group, which can be used by other
> > functions to iterate through the entries belonging to that group
> > only,
> > using the for_each_pci_msi_entry/ for_each_msi_entry_from macro. It
> > is
> > not the cleanest of solutions, I agree.
> Yeah, it's too ugly to exist.
> 

will get rid of it.

> > 
> > With your proposal of supporting a separate group list, I don't
> > think
> > there will be a need to use this kind of temporary storage
> > variable.
> Exactly.
> 
> > 
> > > 
> > > > 
> > > > -	for_each_pci_msi_entry(entry, dev) {
> > > > +	for_each_pci_msi_entry_from(entry, dev) {
> > >   > +/* Iterate through MSI entries of device dev starting from a
> > > given desc */
> > >   > +#define for_each_msi_entry_from(desc,
> > > dev)                             \
> > >   > +       desc =
> > > (*dev).grp_first_desc;                                   \
> > >   > +       list_for_each_entry_from((desc),
> > > dev_to_msi_list((dev)),
> > > list)  \
> > > 
> > > So this hides the whole group stuff behind a hideous iterator.
> > > 
> > > for_each_pci_msi_entry_from() ? from what? from the device? Sane
> > > iterators
> > > which have a _from naming, have also a from argument.
> > > 
> > This was meant to be "iterate over all the entries belonging to a
> > group", sorry if that was not clear. 
> > 
> > The current 'for_each_pci_msi_entry' macro iterates through all the
> > msi_desc entries belonging to a particular device. Since we have a
> > piecewise allocation of the MSI-X vectors with this change, we
> > would
> > want to iterate only through the newly added entries, i.e the
> > entries
> > allocated to the current group.
> I understand that, but please make macros and function names so they
> are
> halfways self explaining and intuitive.
> 

yeah, point taken.

>  > In V2, I will introduce a new macro,
> 'for_each_pci_msi_entry_group',
> > 
> > which will only iterate through the msi_desc entries belonging to a
> > particular group.
> for_each_pci_msi_entry_group()
> 
> is ambiguous. It could mean to iterate over the groups. 
> 
> for_each_pci_msi_entry_in_group()
> 
> avoids that.

Yes, agreed.
>  
> > 
> > > 
> > > > 
> > > > -	ret = msix_setup_entries(dev, base, entries, nvec,
> > > > affd);
> > > > +	ret = msix_setup_entries(dev, dev->base, entries,
> > > > nvec,
> > > > affd, group);
> > > >  	if (ret)
> > > >  		return ret;
> > > Any error exit in this function will leave MSIx disabled. That
> > > means
> > > if
> > > this is a subsequent group allocation which fails for whatever
> > > reason, this
> > > will render all existing and possibly already in use interrupts
> > > unusable.
> > > 
> > Hmmm yeah, I hadn't thought about this!
> > 
> > So according to the code, we must 'Ensure MSI-X is disabled while
> > it is
> > set up'. MSI-X would be disabled until the setup of the new vectors
> > is
> > complete, even if we do not take the error exit right?
> > 
> > Earlier this was not a problem since we disable the MSI-X, setup
> > all
> > the vectors at once, and then enable the MSI-X once and for all. 
> > 
> > I am not sure how to avoid disabling of MSI-X here.
> The problem with your code is that is keeps it disabled in case of an
> error, which makes all existing users (groups) starve.
> 
> But, yes there is also the question what happens during the time when
> interrupts are raised on already configured devices exactly during
> the time
> where MSI-X is disabled temporarily to setup a new group. I fear that
> will
> end up with lost interrupts and/or spurious interrupts via the legacy
> INT[ABCD]. That really needs to be investigated _before_ we go there.
> 

Hmm, yeah that is my concern, I do not know what the behavior would be.
Any experiments that I can run to know more?

> > 
> > > 
> > > > 
> > > >  static int __pci_enable_msix_range(struct pci_dev *dev,
> > > >  				   struct msix_entry *entries,
> > > > int
> > > > minvec,
> > > > -				   int maxvec, struct
> > > > irq_affinity
> > > > *affd)
> > > > +				   int maxvec, struct
> > > > irq_affinity
> > > > *affd,
> > > > +				   bool one_shot, int group)
> > > >  {
> > > >  	int rc, nvec = maxvec;
> > > >  
> > > >  	if (maxvec < minvec)
> > > >  		return -ERANGE;
> > > >  
> > > > -	if (WARN_ON_ONCE(dev->msix_enabled))
> > > > -		return -EINVAL;
> > > So any misbehaving PCI driver can now call into this without
> > > being
> > > caught.
> > > 
> > I do not understand what misbehaving PCI driver means :(
> The one which calls into that interface _AFTER_ msix is enabled. We
> catch
> that right now and reject it.
> 

Right.
> > 
> > Basically this statement is what denies multiple MSI-X vector
> > allocations, and I wanted to remove it so that we could do just
> > that.
> > 
> > Please let me know how I could change this.
> There are several ways to do that, but it needs to be made
> conditionally on
> things like 'device has group mode support' ...
>  

Ok.
> > 
> > > 
> > > If you want to support group based allocations, then the PCI/MSI
> > > facility
> > > has to be refactored from ground up.
> > > 
> > >   1) Introduce the concept of groups by adding a group list head
> > > to
> > > struct
> > >      pci_dev. Ideally you create a new struct pci_dev_msi or
> > > whatever
> > > where
> > >      all this muck goes into.
> > > 
> > I think we can use the existing list_head 'msi_list' in the struct
> > device for this, instead of having a new list_head for the group.
> > So
> > now instead of msi_list being a list of all the msi_desc entries,
> > it
> > will have a list of the different groups associated with the
> > device.
> > 
> > IMHO, since IMS is non PCI compliant, having this group_list_head
> > would
> > be better off in struct device than struct pci_dev, which would
> > enable
> > code reuse.
> Sure, but then we really need to look at the IMS requirements in
> order not
> to rewrite this whole thing over and over.
> 

Yeah, since IMS is non PCI compliant, if we make all these changes at
the struct device level unlike the struct pci_dev level, I think we can
reuse the same code for all MSI/ MSI like interrupts.

Having said that I will send out an RFC of the initial IMS code, to
avoid any sort of code duplication.
> > 
> > > 
> > >   2) Change the existing code to treat the current allocation
> > > mode as
> > > a
> > >      group allocation. Keep the entries in a new struct
> > > msi_entry_group and
> > >      have a group id, list head and the entries in there.
> > > 
> > I am thinking of something like this, please let me know if this is
> > what you are suggesting:
> > 
> > 1. Introduce a new msi_entry_group struct:
> > struct msi_entry_grp {
> >   int group_id; // monotonically increasing group_id
> >   int num_vecs; // number of msi_desc entries per group
> >   struct list_head group_list; // Added to msi_list in struct
> > device
> >   struct list_head entry_list; // list of msi_desc entries for this
> > grp
> > }
> Looks about right.

Ok! 
> > 
> > 2. Add a new 'for_each_pci_msi_entry_group' macro. This macro
> > should
> > only iterate through the msi_desc entries belonging to a group.
> See above.
>  

will update this is V2.

> > 
> > 3. The existing for_each_pci_msi_entry, needs to be modified so
> > that it
> > is backward compatible. This macro should still be able to iterate
> > through all the entries in all the groups. 
> I'm not sure. It might be just the thing which iterates over group 0,
> which
> is the default for all devices which do not use/support group mode,
> but
> let's see.
>  

Yeah, I am currently trying to get this approach to work i.e. reworking
the for_each_pci_msi_entry macro to be group aware (not gotten it to
work thus far, though).

> Thanks,
> 
> 	tglx
