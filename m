Return-Path: <linux-pci+bounces-36936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC46B9EA97
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 12:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032D71891BD3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1962F28E3;
	Thu, 25 Sep 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz0Fyvnb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007F2F2608;
	Thu, 25 Sep 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796231; cv=none; b=A94Tv+Ge5RBhaso6Qur5pVjMmv5n+agKi90Ev0ugyvsSG+/x3CQFsXacYIh+Ok3ZYAWsQmmlYIVAEO64QGiZlIgn38j78SHjXZ7PrNnX1jgKWS0vE1txG41OuK08rMjajWGOMJTFIKKXfIzJ8uBTiptfFlb22laMl3DhzN8tdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796231; c=relaxed/simple;
	bh=AbnctzRpqXmWshNFGOVoDd3nWMcwlGGsaTGZdAa5Km4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es0wD5Jtk2cANF0MRUAzDXjVpdKiT+HpE4ciNltUoiIydifxoBpYMYkoh6zpfU9yvirklTPJ25AuxYhMpy3BQXhhaGue7BE4wQz4K3BQGrpzoahrwEXMvYxPCr7M4U/vYLYocAp/XYfMrSL/O9jK6O2Vu+t2c7w+2S8cTxOVlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz0Fyvnb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758796230; x=1790332230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AbnctzRpqXmWshNFGOVoDd3nWMcwlGGsaTGZdAa5Km4=;
  b=cz0FyvnbjicczIvtGgvilqR0S4FxWw9UbV8Jm6ZADsdJSzHH3yykxQ9x
   NCRVR3tc1cV8sRmwGArGZd6ywFuPUWsZqboMu0h/4N04A7U6JB+NwRI4U
   BZIcKPBb19mjczUZ62G47I6Sailuunz8LaPsXDI4zDIK0o020CdGlLbyT
   LL5xd+whqzq3sBljlMTSUxISYfvkbP60nIpoZ6Pr4QggYVogsE/y4y8sH
   o6DII+0ZwM48nTXmZfVCidK2J76qcPTUiJIZ4fE8xz3a+l5K/Ao9x/uFF
   9gy/TddL3uH/cNmgl8kBVoGHgJM2VtOV0rTTEKp4oWK/K1csyFs2Tl9Qj
   w==;
X-CSE-ConnectionGUID: mr3UKjQQRsOSMG5IQ0YcLw==
X-CSE-MsgGUID: vNu66JUrTfWJsUeCXeGRBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="63734572"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="63734572"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 03:30:29 -0700
X-CSE-ConnectionGUID: w0km/078TEqfAOlCSUcjyQ==
X-CSE-MsgGUID: mjhVJLhQRBa4AFj3UyoXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="177135275"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 25 Sep 2025 03:30:26 -0700
Date: Thu, 25 Sep 2025 18:18:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Arto Merilainen <amerilainen@nvidia.com>, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	linux-pci@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v4 07/10] PCI/IDE: Add IDE establishment helpers
Message-ID: <aNUW6s9++Ely4v2R@yilunxu-OptiPlex-7050>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-8-dan.j.williams@intel.com>
 <9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com>
 <6896333756c9f_184e1f100ef@dwillia2-xfh.jf.intel.com.notmuch>
 <21903f51-1ed0-41a4-a8c8-cfa78ce6093d@nvidia.com>
 <yq5azfbjq2nf.fsf@kernel.org>
 <yq5a1pod4obp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a1pod4obp.fsf@kernel.org>

> This is the change I am adding
> 
>  drivers/pci/ide.c                        | 128 ++++++++++++++++++++++-
>  drivers/virt/coco/arm-cca-host/arm-cca.c |  13 +++
>  include/linux/pci-ide.h                  |   7 ++
>  3 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 3f772979eacb..23d1712ba97a 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -101,7 +101,7 @@ void pci_ide_init(struct pci_dev *pdev)
>  	pdev->ide_cap = ide_cap;
>  	pdev->nr_link_ide = nr_link_ide;
>  	pdev->nr_sel_ide = nr_streams;
> -	pdev->nr_ide_mem = nr_ide_mem;
> +	pdev->nr_ide_mem = min(nr_ide_mem, PCI_IDE_AASOC_REG_MAX);
>  }
>  
>  struct stream_index {
> @@ -213,11 +213,13 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  				.rid_start = pci_dev_id(rp),
>  				.rid_end = pci_dev_id(rp),
>  				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +				.nr_mem = 0,
>  			},
>  			[PCI_IDE_RP] = {
>  				.rid_start = pci_dev_id(pdev),
>  				.rid_end = rid_end,
>  				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +				.nr_mem = 0,
>  			},
>  		},
>  		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> @@ -228,6 +230,109 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
>  
> +static int add_range_merge_overlap(struct range *range, int az, int nr_range,
> +				   u64 start, u64 end)
> +{
> +	int i;
> +
> +	if (start >= end)
> +		return nr_range;
> +
> +	/* get new start/end: */
> +	for (i = 0; i < nr_range; i++) {
> +
> +		if (!range[i].end)
> +			continue;
> +
> +		/* Try to add to the end */
> +		if (range[i].end + 1 == start) {
> +			range[i].end = end;
> +			return nr_range;
> +		}
> +
> +		/* Try to add to the start */
> +		if (range[i].start == end + 1) {
> +			range[i].start = start;
> +			return nr_range;
> +		}
> +	}
> +
> +	/* Need to add it: */
> +	return add_range(range, az, nr_range, start, end);
> +}

Can add_range_with_merge() serve your purpose?

> +
> +int pci_ide_add_address_assoc_block(struct pci_dev *pdev,
> +				    struct pci_ide *ide,
> +				    u64 start, u64 end)
> +{
> +	struct pci_ide_partner *partner;
> +
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +
> +		if (pdev != ide->pdev)
> +			return -EINVAL;
> +		partner = &ide->partner[PCI_IDE_RP];
> +		break;

IIUC, you want to program the RP is it? So is it better we input the to
be programmed device (RP), not the target device (EP) with the range.

> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (partner->nr_mem >= pdev->nr_ide_mem)
> +		return -ENOMEM;

I don't get why the desired number blocks for RP is related to the
supported number blocks for EP.

Apart from this, I don't see the necessary to input the EP device.

> +
> +	partner->nr_mem = add_range_merge_overlap(partner->mem,
> +					   PCI_IDE_AASOC_REG_MAX, partner->nr_mem,
> +					   start, end);
> +	return 0;
> +}
> +
> +
> +int pci_ide_merge_address_assoc_block(struct pci_dev *pdev,
> +				      struct pci_ide *ide, u64 start, u64 end)
> +{
> +	struct pci_ide_partner *partner;
> +
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +
> +		if (pdev != ide->pdev)
> +			return -EINVAL;
> +		partner = &ide->partner[PCI_IDE_RP];
> +		break;
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return -EINVAL;
> +	}
> +
> +	for (int i = 0; i < PCI_IDE_AASOC_REG_MAX; i++) {
> +		struct range *r = &partner->mem[i];
> +
> +		if (r->start < start)
> +			start = r->start;
> +		if (r->end > end)
> +			end = r->end;
> +		r->start = 0;
> +		r->end = 0;
> +	}
> +	partner->mem[0].start = start;
> +	partner->mem[0].end = end;
> +	partner->nr_mem = 1;

IIUC, this function will merge previously added ranges, and the newly
input range, into one, which is wield to me as a kAPI.

> +
> +	return 0;
> +}

I noticed Arto has a good idea that there needs at most 2 blocks no
matter how the mmio layout is for PF/VF/MFD..., one for 32 bit, one for
64 bit. And the direct connected upstream bridge to the DSM device has
already aggregated the 2 ranges on enumeration. [1] That greatly reduces
the complexity. No need for callers to iterate the devices/resources to
collect the ranges again.

For TDX, the firmware enforces to setup only one addr block for RP, no
matter how many supported blocks the RP actually has. That means TDX
could only support 64 bit IDE ranges. I'd like to require an input
parameter like "max_nr_mem_rp" for this purpose.

Based on the above, I've found the only input from the caller is the
max_nr_mem_rp, how about we just add it in pci_ide_stream_alloc(),
input 0 if you don't need the addr block setup.

[...]

>  
> @@ -163,9 +164,21 @@ static int cca_tsm_connect(struct pci_dev *pdev)
>  	if (rc)
>  		goto err_stream;
>  
> +	/*
> +	 * Try to use the available address assoc register blocks.
> +	 * If we fail with ENOMEM, create one block covering the entire
> +	 * address range. (Should work for arm64)
> +	 */
> +	pci_dev_for_each_resource(pdev, res) {
> +		rc = pci_ide_add_address_assoc_block(pdev, ide, res->start, res->end);
> +		if (rc == -ENOMEM)
> +			pci_ide_merge_address_assoc_block(pdev, ide, res->start, res->end);
> +	}

You just input the addr of PF0, not VF/MFD... any limitation? If we
switch to get ranges from direct upstream bridge, are you still OK?

Thanks,
Yilun

