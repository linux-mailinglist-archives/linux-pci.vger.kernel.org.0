Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8F8E458
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 07:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfHOFEd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 01:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfHOFEd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 01:04:33 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76CB7208C2;
        Thu, 15 Aug 2019 05:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565845471;
        bh=y71YcEKZSjvMAukIo9CAwKrx2uYPp2uFzBl7jwo8jBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCqUFNMbbcDIBTdLF2mNp5q4Xmdh0a2FvGciWsDjIDlUFkXc5Xk4k/IkAP3uLmOXQ
         Vc0FlGSB67e887MXdWma8Dpy9hBeqyrLHxHzZVghwnYL+2NpN06Gr/6D4ZgYH0q8HJ
         aPOIX8sMIZO1d2Cn82UjEkSc7h6Mxq2k/vxF8iKg=
Date:   Thu, 15 Aug 2019 00:04:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 5/7] PCI/ATS: Add PASID support for PCIe VF devices
Message-ID: <20190815050430.GG253360@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d10b5f08212a42c4a710ec649bffe082599dbb46.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190812200508.GM11785@google.com>
 <20190813221958.GA139211@skuppusw-desk.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813221958.GA139211@skuppusw-desk.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 13, 2019 at 03:19:58PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On Mon, Aug 12, 2019 at 03:05:08PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 01, 2019 at 05:06:02PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > When IOMMU tries to enable PASID for VF device in
> > > iommu_enable_dev_iotlb(), it always fails because PASID support for PCIe
> > > VF device is currently broken in PCIE driver. Current implementation
> > > expects the given PCIe device (PF & VF) to implement PASID capability
> > > before enabling the PASID support. But this assumption is incorrect. As
> > > per PCIe spec r4.0, sec 9.3.7.14, all VFs associated with PF can only
> > > use the PASID of the PF and not implement it.
> > > 
> > > Also, since PASID is a shared resource between PF/VF, following rules
> > > should apply.
> > > 
> > > 1. Use proper locking before accessing/modifying PF resources in VF
> > >    PASID enable/disable call.
> > > 2. Use reference count logic to track the usage of PASID resource.
> > > 3. Disable PASID only if the PASID reference count (pasid_ref_cnt) is zero.
> > > 
> > > Cc: Ashok Raj <ashok.raj@intel.com>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Suggested-by: Ashok Raj <ashok.raj@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ---
> > >  drivers/pci/ats.c   | 113 ++++++++++++++++++++++++++++++++++----------
> > >  include/linux/pci.h |   2 +
> > >  2 files changed, 90 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > index 079dc5444444..9384afd7d00e 100644
> > > --- a/drivers/pci/ats.c
> > > +++ b/drivers/pci/ats.c
> > > @@ -402,6 +402,8 @@ void pci_pasid_init(struct pci_dev *pdev)
> > >  	if (pdev->is_virtfn)
> > >  		return;
> > >  
> > > +	mutex_init(&pdev->pasid_lock);
> > > +
> > >  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> > >  	if (!pos)
> > >  		return;
> > > @@ -436,32 +438,57 @@ void pci_pasid_init(struct pci_dev *pdev)
> > >  int pci_enable_pasid(struct pci_dev *pdev, int features)
> > >  {
> > >  	u16 control, supported;
> > > +	int ret = 0;
> > > +	struct pci_dev *pf = pci_physfn(pdev);
> > >  
> > > -	if (WARN_ON(pdev->pasid_enabled))
> > > -		return -EBUSY;
> > > +	mutex_lock(&pf->pasid_lock);
> > >  
> > > -	if (!pdev->eetlp_prefix_path)
> > > -		return -EINVAL;
> > > +	if (WARN_ON(pdev->pasid_enabled)) {
> > > +		ret = -EBUSY;
> > > +		goto pasid_unlock;
> > > +	}
> > >  
> > > -	if (!pdev->pasid_cap)
> > > -		return -EINVAL;
> > > +	if (!pdev->eetlp_prefix_path) {
> > > +		ret = -EINVAL;
> > > +		goto pasid_unlock;
> > > +	}
> > >  
> > > -	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> > > -			     &supported);
> > > +	if (!pf->pasid_cap) {
> > > +		ret = -EINVAL;
> > > +		goto pasid_unlock;
> > > +	}
> > > +
> > > +	if (pdev->is_virtfn && pf->pasid_enabled)
> > > +		goto update_status;
> > > +
> > > +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
> > >  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
> > >  
> > >  	/* User wants to enable anything unsupported? */
> > > -	if ((supported & features) != features)
> > > -		return -EINVAL;
> > > +	if ((supported & features) != features) {
> > > +		ret = -EINVAL;
> > > +		goto pasid_unlock;
> > > +	}
> > >  
> > >  	control = PCI_PASID_CTRL_ENABLE | features;
> > > -	pdev->pasid_features = features;
> > > -
> > > +	pf->pasid_features = features;
> > >  	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
> > >  
> > > -	pdev->pasid_enabled = 1;
> > > +	/*
> > > +	 * If PASID is not already enabled in PF, increment pasid_ref_cnt
> > > +	 * to count PF PASID usage.
> > > +	 */
> > > +	if (pdev->is_virtfn && !pf->pasid_enabled) {
> > > +		atomic_inc(&pf->pasid_ref_cnt);
> > > +		pf->pasid_enabled = 1;
> > > +	}
> > >  
> > > -	return 0;
> > > +update_status:
> > > +	atomic_inc(&pf->pasid_ref_cnt);
> > > +	pdev->pasid_enabled = 1;
> > > +pasid_unlock:
> > > +	mutex_unlock(&pf->pasid_lock);
> > > +	return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_enable_pasid);
> > >  
> > > @@ -472,16 +499,29 @@ EXPORT_SYMBOL_GPL(pci_enable_pasid);
> > >  void pci_disable_pasid(struct pci_dev *pdev)
> > >  {
> > >  	u16 control = 0;
> > > +	struct pci_dev *pf = pci_physfn(pdev);
> > > +
> > > +	mutex_lock(&pf->pasid_lock);
> > >  
> > >  	if (WARN_ON(!pdev->pasid_enabled))
> > > -		return;
> > > +		goto pasid_unlock;
> > >  
> > > -	if (!pdev->pasid_cap)
> > > -		return;
> > > +	if (!pf->pasid_cap)
> > > +		goto pasid_unlock;
> > >  
> > > -	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
> > > +	atomic_dec(&pf->pasid_ref_cnt);
> > >  
> > > +	if (atomic_read(&pf->pasid_ref_cnt))
> > > +		goto done;
> > > +
> > > +	/* Disable PASID only if pasid_ref_cnt is zero */
> > > +	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
> > > +
> > > +done:
> > >  	pdev->pasid_enabled = 0;
> > > +pasid_unlock:
> > > +	mutex_unlock(&pf->pasid_lock);
> > > +
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_disable_pasid);
> > >  
> > > @@ -492,15 +532,25 @@ EXPORT_SYMBOL_GPL(pci_disable_pasid);
> > >  void pci_restore_pasid_state(struct pci_dev *pdev)
> > >  {
> > >  	u16 control;
> > > +	struct pci_dev *pf = pci_physfn(pdev);
> > >  
> > >  	if (!pdev->pasid_enabled)
> > >  		return;
> > >  
> > > -	if (!pdev->pasid_cap)
> > > +	if (!pf->pasid_cap)
> > >  		return;
> > >  
> > > +	mutex_lock(&pf->pasid_lock);
> > > +
> > > +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, &control);
> > > +	if (control & PCI_PASID_CTRL_ENABLE)
> > > +		goto pasid_unlock;
> > > +
> > >  	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
> > > -	pci_write_config_word(pdev, pdev->pasid_cap + PCI_PASID_CTRL, control);
> > > +	pci_write_config_word(pf, pf->pasid_cap + PCI_PASID_CTRL, control);
> > > +
> > > +pasid_unlock:
> > > +	mutex_unlock(&pf->pasid_lock);
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
> > >  
> > > @@ -517,15 +567,22 @@ EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
> > >  int pci_pasid_features(struct pci_dev *pdev)
> > >  {
> > >  	u16 supported;
> > > +	struct pci_dev *pf = pci_physfn(pdev);
> > > +
> > > +	mutex_lock(&pf->pasid_lock);
> > >  
> > > -	if (!pdev->pasid_cap)
> > > +	if (!pf->pasid_cap) {
> > > +		mutex_unlock(&pf->pasid_lock);
> > >  		return -EINVAL;
> > > +	}
> > >  
> > > -	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> > > +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP,
> > >  			     &supported);
> > >  
> > >  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
> > >  
> > > +	mutex_unlock(&pf->pasid_lock);
> > > +
> > >  	return supported;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_pasid_features);
> > > @@ -579,15 +636,21 @@ EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> > >  int pci_max_pasids(struct pci_dev *pdev)
> > >  {
> > >  	u16 supported;
> > > +	struct pci_dev *pf = pci_physfn(pdev);
> > > +
> > > +	mutex_lock(&pf->pasid_lock);
> > >  
> > > -	if (!pdev->pasid_cap)
> > > +	if (!pf->pasid_cap) {
> > > +		mutex_unlock(&pf->pasid_lock);
> > >  		return -EINVAL;
> > > +	}
> > >  
> > > -	pci_read_config_word(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> > > -			     &supported);
> > > +	pci_read_config_word(pf, pf->pasid_cap + PCI_PASID_CAP, &supported);
> > >  
> > >  	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
> > >  
> > > +	mutex_unlock(&pf->pasid_lock);
> > > +
> > >  	return (1 << supported);
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_max_pasids);
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 3c9c4c82be27..4bfcca045afd 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -461,8 +461,10 @@ struct pci_dev {
> > >  	atomic_t	pri_ref_cnt;	/* Number of PF/VF PRI users */
> > >  #endif
> > >  #ifdef CONFIG_PCI_PASID
> > > +	struct mutex	pasid_lock;	/* PASID enable lock */
> > 
> > I think these locks are finer-grained than necessary.  I'm not sure
> > it's worth having two mutexes for every device (one for PRI and
> > another for PASID).  Is there really a performance benefit for having
> > two?

> Performance benefit should be minimal. But, PRI and PASID are functionally
> independent. So I don't think its correct to protect its resources with
> a common lock. Let me know your comments.

I'm not an expert on PRI and PASID, but if we can figure out a place
to put it and a way to manage it, I think it's OK to have a lock that
protects both.  I'm thinking about the size of the pci_dev -- I'm not
sure the benefit of having two locks is commensurate with the size
cost.

> > Do it (or do they) need to be in struct pci_dev?  You only use the PF
> > mutexes, so maybe it could be in the struct pci_sriov, which I think
> > is only one per PF.

> Its possible to move it to pci_sriov structure. But is that the right
> place for it? This lock is only used for protecting PRI and PASID feature
> updates and PRI/PASID are not dependent on IOV feature. Let me know your
> comments.

Hmm.  I misunderstood the use of these.  I had the impression they
were only used for PFs.  If that were the case, pci_sriov might make
sense because we only allocate that for PFs (when we enable SR-IOV in
sriov_init()).  But IIUC that's *not* the case: even non-SR-IOV
devices can use PRI/PASID; it's just that if a *VF* uses them, the VF
is actually using the PRI of the PF.

> If you want to move this lock to pci_sriov structure and use one lock
> for both PRI/PASID, then the implementation would look like following. We
> could create physfn lock/unlock functions in include/linux/pci.h similar
> to pci_physfn() function.

> #ifdef CONFIG_PCI_IOV
> static inline void pci_physfn_reslock(struct pci_dev *dev)
> {
>     struct pci_dev *pf = pci_physfn(dev);
> 
>     if (!pf->is_physfn)
>         return;
> 
>     mutex_lock(&pf->sriov->reslock);
> 
> }
> #else
> static inline void pci_physfn_reslock(struct pci_dev *dev) {}; 
> #endif

Yeah, that's not a pretty solution.  IIUC, we don't need to lock at
all for non-SR-IOV devices, because we're operating on our own device
and nobody else should be touching it.  Right?

Only the SR-IOV case (operating on a PF with SR-IOV enabled or on one
of its VFs) needs locking because these are all sharing one resource.

So it's kind of a shame to allocate the lock for *every* pci_dev, when
we only need it for PFs with SR-IOV enabled.

Bjorn
