Return-Path: <linux-pci+bounces-41388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F80C63CFC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B969A3AFE41
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 11:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DEE27280F;
	Mon, 17 Nov 2025 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dasis97o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78323C8C7
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378765; cv=none; b=CrGwPDvdHfw/1q1BFDuK8z/sIDam9DfFuSmfYt24EEXkgxjtc4jOO2EpgEcF+xcdrUtaK7uLIYh0PrglD9I11l5Fkgm9JUqFKGmzbJKhRo9A53kDw/ggdPpRTOQj3/nSOFOcXlpYWxvh/Wy8MJmByr8poxhV9gD5eSXxZ78BjLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378765; c=relaxed/simple;
	bh=x+iTw4g9lbiDbrutja7M5tjrA2Jgw1r2YkCf2t6rOxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru8W1RjcR+/fw8z7j42OfsyjK2XaPiG0rPVUhDkg1hXX2UcZZGRlMaJWg4WPdCO+9sxScVYqyoYu2DIcu1pt1mYNSTr+Bu68nh6mAXrm4bJ+gOFysdVzgFlUez31ES+XZda+djpbS+iHYPX7Dwwslz9Y6j+DpDHJG/X5gj7fM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dasis97o; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763378762; x=1794914762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x+iTw4g9lbiDbrutja7M5tjrA2Jgw1r2YkCf2t6rOxw=;
  b=Dasis97oJE2Yrwcqt8iLJR2eOGw1dP/bE5H1RYjnEWjEF3tV3Xr1L+Ob
   x7b8y99+CQmDKRtplFBamZydgJtEu2lsvlG54i4jVIwdW1ph2ukIgmJVS
   o+zLIvvmCKrEUGlYxxfgYsuJjxqEIZHN9wTsL1cnA/VfuPXxF7Ml8Lptg
   7Ds1CkBfS6aCeWFOVzOw+GdO4pPg0qoLgmOl/jEAEd6XTAvQJnNqDKZ5X
   PNie6Vq7IeUQBB2VS3i5RlAJgdhg2QUzJWW73cR0vW5BXBoDolvakZxTp
   b0dQpqsyMC0S+dO/wj8kgG6aQjDEPrY9nNF3aypr2KQEupWwSpMwDd+AL
   A==;
X-CSE-ConnectionGUID: Dj/AJzv3TWCAy1Sapnkw0Q==
X-CSE-MsgGUID: fvOa4rkyQcuxvxQsf2gKIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76725219"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="76725219"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 03:26:02 -0800
X-CSE-ConnectionGUID: 4kLHzUwUTkCUaQgLVOPpeg==
X-CSE-MsgGUID: dI6PeNCkTD2HP1IurChfVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="213825467"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 17 Nov 2025 03:26:00 -0800
Date: Mon, 17 Nov 2025 19:11:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v2 5/8] PCI/IDE: Initialize an ID for all IDE streams
Message-ID: <aRsC1q0NsyZ2aKjO@yilunxu-OptiPlex-7050>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
 <20251113021446.436830-6-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113021446.436830-6-dan.j.williams@intel.com>

> @@ -98,6 +141,51 @@ void pci_ide_init(struct pci_dev *pdev)
>  		}
>  
>  		nr_ide_mem = nr_assoc;
> +
> +		/*
> +		 * Claim Stream IDs and Selective Stream blocks that are already
> +		 * active on the device
> +		 */
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);
> +		id = FIELD_GET(PCI_IDE_SEL_CTL_ID, val);
> +		if ((val & PCI_IDE_SEL_CTL_EN) &&
> +		    !claim_stream(hb, id, pdev, i))
> +			return;
> +	}
> +
> +	/* Reserve link stream-ids that are already active on the device */
> +	for (u16 i = 0; i < nr_link_ide; ++i) {
                                         ^
i++. Since i++ is used in previous patch, better keep all loops aligned.


> +		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 + i * PCI_IDE_LINK_BLOCK_SIZE;
> +		u8 id;
> +
> +		pci_read_config_dword(pdev, pos + PCI_IDE_LINK_CTL_0, &val);
> +		id = FIELD_GET(PCI_IDE_LINK_CTL_ID, val);
> +		if ((val & PCI_IDE_LINK_CTL_EN) &&
> +		    !claim_stream(hb, id, NULL, -1))
> +			return;
> +	}
> +
> +	for (u16 i = 0; i < nr_streams; i++) {
> +		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> +
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +		if (val & PCI_IDE_SEL_CTL_EN)
> +			continue;
> +		val &= ~PCI_IDE_SEL_CTL_ID;
> +		val |= FIELD_PREP(PCI_IDE_SEL_CTL_ID, PCI_IDE_RESERVED_STREAM_ID);

FIELD_MODIFY could save a line.

> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +	}
> +
> +	for (u16 i = 0; i < nr_link_ide; ++i) {

ditto

> +		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 +
> +			  i * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +		pci_read_config_dword(pdev, pos, &val);
> +		if (val & PCI_IDE_LINK_CTL_EN)
> +			continue;
> +		val &= ~PCI_IDE_LINK_CTL_ID;
> +		val |= FIELD_PREP(PCI_IDE_LINK_CTL_ID, PCI_IDE_RESERVED_STREAM_ID);

ditto

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

