Return-Path: <linux-pci+bounces-28185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D4ABEFFF
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9611BA62EA
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842A238173;
	Wed, 21 May 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTGy7+VF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9223D2A8
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820094; cv=none; b=rg0YFqu+GO0man3wdoGnpoSqsduSbZ01+/rCmduqccUOhKo4tmtPEM1vtdNaAcCyEiklXYsym7c+mTVeNQs2qbbqu6of/t5pb4qXYMUGNb8X/J20bt3150nvHSG73j2l6few7nlU0KM7FTvXTfmNzBhnCVRLGOwAnWNFyJk2L8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820094; c=relaxed/simple;
	bh=Rb4cfY3v25MNT81q5d9zd5P1uaUCYqJRe1e+gl/Pn8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSzyn4xexR3JC2Pv30Ah8Q8Zd+ANK8LmlLjz4XW39od45iFO2a9MXVGlMTOt0Kk4p67n7eZKa1gCADiXXnzbIcFAB3bG8yy8bZAaBNkdqEPdvIQhd2cpb3rWC0dgMPx1sqb8v8JqI8lmVcHaQy+A7UdzzkmEyk6UIKugW9wIxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTGy7+VF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747820092; x=1779356092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rb4cfY3v25MNT81q5d9zd5P1uaUCYqJRe1e+gl/Pn8w=;
  b=iTGy7+VF6f97JLhl83QCw05TThVg1KuPniesJeOYTKJ3SO745G6Rpt69
   /ACChJ43u1jXZoGMDtBanaW3qC0Z+VnXehYBf000mDEx0z/Exd7J3HFKr
   H/DG0vb7mqdM7lgNI7bsVw62nTYUwoOfHXN/Ol6E3KEIc2YHMKballI3m
   ex3psW+dvZYC555OXcJFPRv5zJWtWAW59i8ir0FU5pHsGRIa/z6xyB0f+
   2Kqao/ELrLW5blwcLjYNDBVr4M3LQl+KvlZahT4CT6hG3kkOgf6awLaSD
   2fQKB1SgcXWoDPgjB2Je2/00MsaijL57Vf9kUMBxke+q+6nr7RVqgN0O2
   Q==;
X-CSE-ConnectionGUID: dNGvp5r0QGaZ4NWtReWGVA==
X-CSE-MsgGUID: 7iT8yhh6SAKbVIUo4DImag==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="48907832"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="48907832"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:34:51 -0700
X-CSE-ConnectionGUID: SXlkNt2xR5CiNavRkUldmw==
X-CSE-MsgGUID: Il/egPONQsWXosrMwWVp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="139842774"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 21 May 2025 02:34:49 -0700
Date: Wed, 21 May 2025 17:28:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, May 20, 2025 at 01:12:12PM -0700, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> [..]
> > > +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> > > +{
> > > +	struct pci_tdi *tdi;
> > > +
> > > +	if (!kvm)
> > > +		return -EINVAL;
> > 
> > Does not belong here, if the caller failed to get the kvm pointer from
> > an fd, then that caller should handle it.
> 
> Sure.
> 
> [..]
> > > +static int __pci_tsm_unbind(struct pci_dev *pdev)
> > > +{
> > > +	struct pci_tdi *tdi;
> > > +
> > > +	lockdep_assert_held(&pci_tsm_rwsem);
> > > +
> > > +	if (!pdev->tsm)
> > > +		return -EINVAL;
> > 
> > Nothing checks for these errors.
> 
> True this function signature should probably drop the error code
> altogether and become a void helper. I.e. it should be impossible for a
> bound device to not have a reference, or not be in the right state.
> 
> > 
> > > +
> > > +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > > +	if (!pf0_dev)
> > > +		return -EINVAL;
> > > +
> > > +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> > > +	if (IS_ERR(lock))
> > > +		return PTR_ERR(lock);
> > > +
> > > +	tdi = pdev->tsm->tdi;
> > > +	if (!tdi)
> > > +		return 0;
> > > +
> > > +	tsm_ops->unbind(tdi);
> > > +	pdev->tsm->tdi = NULL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int pci_tsm_unbind(struct pci_dev *pdev)
> > > +{
> > > +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> > > +	if (!lock)
> > > +		return -EINTR;
> > > +
> > > +	return __pci_tsm_unbind(pdev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_tsm_unbind);
> > > +
> > > +/**
> > > + * pci_tsm_guest_req - VFIO/IOMMUFD helper to handle guest requests
> > > + * @pdev: @pdev representing a bound tdi
> > > + * @info: envelope for the request
> > > + *
> > > + * Expected flow is guest low-level TSM driver initiates a guest request
> > > + * like "transition TDISP state to RUN", "fetch report" via a
> > > + * technology specific guest-host-interface and KVM exit reason. KVM
> > > + * posts to userspace (e.g. QEMU) that holds the host-to-guest RID
> > > + * mapping.
> > > + */
> > > +int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
> > > +{
> > > +	struct pci_tdi *tdi;
> > > +	int rc;
> > > +
> > > +	lockdep_assert_held_read(&pci_tsm_rwsem);
> > > +
> > > +	if (!pdev->tsm)
> > > +		return -ENODEV;
> > > +
> > > +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> > > +	if (!pf0_dev)
> > > +		return -EINVAL;
> > > +
> > > +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> > > +	if (IS_ERR(lock))
> > > +		return -ENODEV;
> > > +
> > > +	tdi = pdev->tsm->tdi;
> > > +	if (!tdi)
> > > +		return -ENODEV;
> > > +
> > > +	rc = tsm_ops->guest_req(pdev, info);
> > > +	if (rc)
> > > +		return -EIO;
> > 
> > return rc.
> 
> Agree.
> 
> [..]
> > > @@ -86,12 +101,40 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> > >   	return PCI_FUNC(pdev->devfn) == 0;
> > >   }
> > >   
> > > +enum pci_tsm_guest_req_type {
> > > +	PCI_TSM_GUEST_REQ_TDXC,
> > 
> > Will Intel ever need more types here?
> 
> I doubt it as this is routing to a TDX vs TIO vs ... blob handler. It is
> unfortunate that we need this indirection (i.e. missing
> standardization), but it is in the same line-of-thought as
> configfs-tsm-report providing a transport along with a
> technology-specific "provider" identifier for parsing the blob.
> 
> > > + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
> > > + * @type: identify the format of the following blobs
> > > + * @type_info: extra input/output info, e.g. firmware error code
> > 
> > Call it "fw_ret"?
> 
> Sure.

This field is intended for out-of-blob values, like fw_ret. But fw_ret
is specified in GHCB and is vendor specific. Other vendors may also
have different values of this kind.

So I intend to gather these out-of-blob values in type_info, like:

enum pci_tsm_guest_req_type {
  PCI_TSM_GUEST_REQ_TDXC,
  PCI_TSM_GUEST_REQ_SEV_SNP,
};

/* SEV SNP guest request type info */
struct pci_tsm_guest_req_sev_snp {
	s32 fw_err;
};

Since IOMMUFD has the userspace entry, maybe these definitions should be
moved to include/uapi/linux/iommufd.h.

In pci-tsm.h, just define:

struct pci_tsm_guest_req_info {
	u32 type;
	void __user *type_info;
	size_t type_info_len;
	void __user *req;
	size_t req_len;
	void __user *resp;
	size_t resp_len;
};

BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0

> 
> [..]
> > > @@ -102,6 +145,11 @@ struct pci_tsm_ops {
> > >   	void (*remove)(struct pci_tsm *tsm);
> > >   	int (*connect)(struct pci_dev *pdev);
> > >   	void (*disconnect)(struct pci_dev *pdev);
> > > +	struct pci_tdi *(*bind)(struct pci_dev *pdev, struct pci_dev *pf0_dev,
> > > +				struct kvm *kvm, u64 tdi_id);
> > 
> > p0_dev is not needed here, we should be able to calculate it from pdev.
> 
> The pci_tsm core needs to hold the lock before calling this routine. At
> that point might as well pass the already looked up device rather than
> require the low-level TSM driver to repeat that work.
> 
> > tdi_id is 32bit.
> 
> @Yilun, I saw that you had it as 64-bit in one location, was that
> unintentional.

Intel is also switching to gBDF as tdi_id, so yes 32bit is good.

> 
> Note that INTERFACE_ID is Reserved to be 12-bytes, but today FUNCTION_ID
> is indeed only 4-bytes. I will fix this up unless some arch speaks up
> and says they need to pass a larger id around.

Yes.

Thanks,
Yilun

> 
> > Should return an error code. Thanks,
> 
> Lets make it an ERR_PTR() because the low-level provider likely needs to
> allocate more than just a 'struct pci_tdi' on bind.

