Return-Path: <linux-pci+bounces-18245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1B9EE37B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E23D280C63
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8720E6FE;
	Thu, 12 Dec 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLHDjaXv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA220E6EF
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997220; cv=none; b=UdaToK8AZMFytvAqRAdHXNiR09t45hw7VSk1BDCbp6YfF8wJUUmvYD0M5GHtmOpyHauKSV0jYIHjlGVqSD12uLpzHNuxaJqCOn5UxceDFsrdcUoJ9Ot4rVJFdEOxLTVml2w+gTuj6W6/pU4/aVM1SB0jU859/Xa8au1b01ipVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997220; c=relaxed/simple;
	bh=TaI1Dcx+eELk9hTyKx75u7qeSvVJzGBRlCGF9iGcreo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J70LhdHxQFyO+Rm9gospKb6GqDZaNsm8H/lo/kcZlN5ZzSZmgGMQ84oSgut5XnD1x+EQ6xtbFYFL/F9tWt+9I9D9PZalivf8QpH7dY7jc0AuvvmfzJiP8fFiiwrreQ7JFTONfVtvOSHdECZfFldFaB/M+84i4UPT9tpEZLOysPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLHDjaXv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733997219; x=1765533219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TaI1Dcx+eELk9hTyKx75u7qeSvVJzGBRlCGF9iGcreo=;
  b=HLHDjaXvA/2N1JvilRCZbVrEe2VxPRqq29niNBi4GdvNBzm1M/TkwJBQ
   IhSb7PJdtyCzUM28ZnneQONjP37J7wBPHNIOnpGlf/UQG4IJzW9NXBu4A
   shpDNRFcLHKMSptUZ8mxYFC3EdOphL3H2/1tzYjkuiXuetM7FYHqQ0T1Y
   6Ym+6dmprUsCVO6x1UO2Nb86pQUMZLX+IeZ43WpwkZEP3sEwGer6kuc3O
   lvGQmM8aA8YYhP6NqN0EYE3BjO6eWRQZkhMReaumwWEghm92HAZU6WCCR
   bFNDR19gYZR58jeQX/EI6t0a8CsUwSMeABSIb9NgmMBeivcqIbfeCEYLS
   w==;
X-CSE-ConnectionGUID: ZCbhhti2TOWJ0BcmBsPigA==
X-CSE-MsgGUID: kOSc1jWMQMiqIgzgkKNYiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="21997554"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="21997554"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:53:38 -0800
X-CSE-ConnectionGUID: kfDg5nk1RiGc12L9CzFKjA==
X-CSE-MsgGUID: MDwheczeTY2+u+x6yvDAnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96074112"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 12 Dec 2024 01:53:36 -0800
Date: Thu, 12 Dec 2024 17:50:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Z1qx2nAHbZN72Ljf@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>

> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	if_not_guard(mutex_intr, &pci_tsm->lock)
> +		return -EINTR;
> +
> +	if (pci_tsm->state < PCI_TSM_CONNECT)
> +		return 0;
> +	if (pci_tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;

Check PCI_TSM_INIT first, or this condition will never hit.

  if (pci_tsm->state < PCI_TSM_INIT)
	return -ENXIO;
  if (pci_tsm->state < PCI_TSM_CONNECT)
	return 0;

I suggest the same sequence for pci_tsm_connect().

> +
> +	tsm_ops->disconnect(pdev);
> +	pci_tsm->state = PCI_TSM_INIT;
> +
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +	int rc;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	if_not_guard(mutex_intr, &pci_tsm->lock)
> +		return -EINTR;
> +
> +	if (pci_tsm->state >= PCI_TSM_CONNECT)
> +		return 0;
> +	if (pci_tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +
> +	rc = tsm_ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +	pci_tsm->state = PCI_TSM_CONNECT;
> +	return 0;
> +}
> +

[...]

> +
> +static void __pci_tsm_init(struct pci_dev *pdev)
> +{
> +	bool tee_cap;
> +
> +	if (!is_physical_endpoint(pdev))
> +		return;

This Filters out virtual functions, just because not ready for support,
is it?

> +
> +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +
> +	if (!(pdev->ide_cap || tee_cap))
> +		return;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +	if (!tsm_ops)
> +		return;
> +
> +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
> +	if (!pci_tsm)
> +		return;
> +
> +	/*
> +	 * If a physical device has any security capabilities it may be
> +	 * a candidate to connect with the platform TSM
> +	 */
> +	struct pci_dsm *dsm __free(dsm_remove) = tsm_ops->probe(pdev);

IIUC, pdev->tsm should be for every pci function (physical or virtual),
pdev->tsm->dsm should be only for physical functions, is it?

> +
> +	pci_dbg(pdev, "Device security capabilities detected (%s%s ), TSM %s\n",
> +		pdev->ide_cap ? " ide" : "", tee_cap ? " tee" : "",
> +		dsm ? "attach" : "skip");
> +
> +	if (!dsm)
> +		return;
> +
> +	mutex_init(&pci_tsm->lock);
> +	pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					       PCI_DOE_PROTO_CMA);
> +	if (!pci_tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return;
> +	}
> +
> +	pci_tsm->state = PCI_TSM_INIT;
> +	pci_tsm->dsm = no_free_ptr(dsm);
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	if (pci_tsm_owner_attr_group)
> +		sysfs_merge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> +}

