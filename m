Return-Path: <linux-pci+bounces-44459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5ED10613
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 03:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41E0030012C3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 02:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A67921B195;
	Mon, 12 Jan 2026 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGHSUOZI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D01AA1D2;
	Mon, 12 Jan 2026 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186062; cv=none; b=MBu5EZaNKq3CFyk3x53Zu1G014KsPrKFbDDhoktE/lYSVDTK9vM5C68/EhQYGArw+fuDCIzTzaH0DvQjiafWq6F9Y8/YgbjWGgLrrOtehLl6dDcGbF6gVjipxLRLMRNhDkqwIPsD8Z4aVHEdZ53jf1Amhq0g9Fj89tuIg5tzzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186062; c=relaxed/simple;
	bh=sKjiMSHw5tbfzA5zXUxgFdCcJgmQX3byUqOgara7lhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt5w5BGEBieGmNv49uI65XuwVSxVoUD8qfPJDDoc+NHnKzcnZs7x9wR5pAnL9k8epFDpl/rakjlJeA8rPzADcrJPOE+kcND5xqVh41bNXhZzVwvpFzrWuwUxHaHK5J/RnCZB/AfBcdnMJkLe7X3AHW08EKZgm3GrKXwyDU5wgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGHSUOZI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768186060; x=1799722060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKjiMSHw5tbfzA5zXUxgFdCcJgmQX3byUqOgara7lhI=;
  b=bGHSUOZIhNoNr3wVGMyuK+dKslMvr7AzLS/7VWv8Hdgy/rMbjqOfX/hE
   O6zbx0oQlbsWNrEWyBZ7Tk3OmUD72HRieRV/2NGl+tGsd79R5qCgvdSdK
   ML6KxzZKcyqBdKt/KCz26m6gHBdBvQZRKiEuv8lqXW4R37DXgCHwVMRqH
   45qkM9lyv4/JfISbsUSe5xEkJ2/x7Ug/eb1OhdtToLNvSx+CvV21Rlv4i
   6rC3rCqyxGMtR9Lq6cPGA1H4gKA4MIhATP+wGsFK/zmsmNd4+7ARY62RN
   XuaA/z/gKADxove4a6c8Wk6OHb89/puXUeCULaM60Sys9mJ0Z7CwXt2wT
   A==;
X-CSE-ConnectionGUID: 8zijrvSiTmC7ZgwmKfOwgQ==
X-CSE-MsgGUID: ICFawCEdREG/JIJNLfSwXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="80913926"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="80913926"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 18:47:39 -0800
X-CSE-ConnectionGUID: PCwSQgIETh+CL21WB6bnBQ==
X-CSE-MsgGUID: C+1Vg8WARVGsumylIiEHvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204389050"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jan 2026 18:47:37 -0800
Date: Mon, 12 Jan 2026 10:30:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dan.j.williams@intel.com, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/IDE: Fix using wrong VF ID for RID range
 calculation
Message-ID: <aWRctnwjEXvUyayb@yilunxu-OptiPlex-7050>
References: <20260111080631.506487-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111080631.506487-1-ming.li@zohomail.com>

On Sun, Jan 11, 2026 at 04:06:31PM +0800, Li Ming wrote:
> When allocate a new IDE stream for a pci device in SR-IOV case, the RID
> range of the new IDE stream should cover all VFs of the device. VF id
> range of a pci device is [0 - (num_VFs - 1)], so should use (num_VFs - )
> as the last VF's ID.
> 
> Fixes: 1e4d2ff3ae45 ("PCI/IDE: Add IDE establishment helpers")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/pci/ide.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 26f7cc94ec31..9629f3ceb213 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -283,8 +283,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  	/* for SR-IOV case, cover all VFs */
>  	num_vf = pci_num_vf(pdev);
>  	if (num_vf)
> -		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> -				    pci_iov_virtfn_devfn(pdev, num_vf));
> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf - 1),
> +				    pci_iov_virtfn_devfn(pdev, num_vf - 1));

I don't have VF for test but I believe the change is correct.

The calculated rid_end will be passed to IDE RID association register values,
which is inclusive according to IDE SPEC.

  void pci_ide_stream_to_regs(...)
  {
	...
	regs->rid1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
	...
  }

Is it better we clarify the kernel-doc a little bit:

--------8<--------

diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index 2521a2914294..f0c6975fd429 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -26,7 +26,7 @@ enum pci_ide_partner_select {
 /**
  * struct pci_ide_partner - Per port pair Selective IDE Stream settings
  * @rid_start: Partner Port Requester ID range start
- * @rid_end: Partner Port Requester ID range end
+ * @rid_end: Partner Port Requester ID range end (inclusive)
  * @stream_index: Selective IDE Stream Register Block selection
  * @mem_assoc: PCI bus memory address association for targeting peer partner
  * @pref_assoc: PCI bus prefetchable memory address association for

