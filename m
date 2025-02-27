Return-Path: <linux-pci+bounces-22527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77567A47616
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 07:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C923B10E1
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB42135AB;
	Thu, 27 Feb 2025 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPGluZte"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D91EB5C3
	for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2025 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639178; cv=none; b=tTHkWnTipovTZz5BtorMSRzvW6lHODz93Li6G0Ou9ojtBstUDwX/5hw2qKneCBv3q41XH2PoOl81JwRDawg5kIwtIK+d2pmvLhqjyhnSNMjBKJ5LBl1JZnpY8LG7htgKPZpGqpICU3FUvokY64Z1YArLAJOnZTcLftNyl09jNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639178; c=relaxed/simple;
	bh=3iGW3fm0Z/AOAoj0gEvfG7tHoiHYesoOb9VZ3XDreoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG3VcVXRaq38IiTww1tCZN3NwdtJ+5+FM3cAp7bUzp7298C56HcO045S+Uzjs63XYh+SAvEq4wHgEaHEtWR3d83nW86MVdaFpRIjySwXEnTzXTmSv7DOHlK1dBmc3gXRv0vqdeiz4t/istG14Mhk3xfq0tWVllioFoaZ05GKHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPGluZte; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740639177; x=1772175177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3iGW3fm0Z/AOAoj0gEvfG7tHoiHYesoOb9VZ3XDreoY=;
  b=BPGluZteiq0UGOtoL8EbVheKZLZbsWujQA7lq6SIrE+qkNzuMEAsp5Fb
   atNYuI6KT3QwJn24W4mlgbbjCQbdrA8MCVhea4R6Ho8sO2albM7qngCLx
   tBF+PLvsPbH27t7huT36iqJI0unat32VJBfia5Uz11kFoWiicUy/PBt2u
   why6FyJzb2ic6TxwWRjnyPqFfh0bY9HjeOxubMepdQOaYyycnwnWVGtTA
   es7sQzR7+o83UIjMYcXqcNeUYa3+xqKnZdOEfjhRQYlnsR1nIybJI3Lj5
   0RzzLAoqNfmRYzI8vJ6i+Ek4dP0DWHWyx6U2NZil7o3gq1GpJBkLatrt2
   Q==;
X-CSE-ConnectionGUID: cbFyS0tSQWWxrzdFEDhJ3Q==
X-CSE-MsgGUID: /Wg5c4//RR+Z2x34iVChYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="63983030"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="63983030"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:52:49 -0800
X-CSE-ConnectionGUID: HjSS5j02Q6uaMoAGVbUdMw==
X-CSE-MsgGUID: QZ6uRdMZRwe4W0k3303+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117578649"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 26 Feb 2025 22:52:47 -0800
Date: Thu, 27 Feb 2025 14:50:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 7/7] tsm: Add secure SPDM support
Message-ID: <Z8ALTvCGOKwvqZwO@yilunxu-OptiPlex-7050>
References: <yq5a4j0gc3fp.fsf@kernel.org>
 <20250226121323.577328-1-aneesh.kumar@kernel.org>
 <20250226121323.577328-7-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226121323.577328-7-aneesh.kumar@kernel.org>

On Wed, Feb 26, 2025 at 05:43:23PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add secure doe mailbox support
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/pci/tsm.c       | 24 +++++++++++++++++++-----
>  include/linux/pci-tsm.h |  1 +
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 3251dc5eeef8..cb251497ca68 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -194,12 +194,16 @@ static void __pci_tsm_init(struct pci_dev *pdev)
>  		return;
>  
>  	mutex_init(&pci_tsm->lock);
> -	pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +	pci_tsm->doe_mb 	= pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
>  					       PCI_DOE_PROTO_CMA);
> -	pci_info(pdev, "Device security capabilities detected (%s%s%s)\n",
> +	pci_tsm->doe_secure_mb 	= pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					       PCI_DOE_PROTO_SSESSION);

Do you have 2 doe mb instances on PCI cap? And one only support CMA,
another only support SSESSION?

If it is not the case, pci_tsm->doe_mb & pci_tsm->doe_secure_mb are
likely the same one.

Thanks,
Yilun

> +
> +	pci_info(pdev, "Device security capabilities detected (%s%s%s%s)\n",
>  		 pdev->ide_cap ? " ide" : "",
>  		 tee_cap ? " tee" : "",
> -		 pci_tsm->doe_mb ? " doe" : "");
> +		 pci_tsm->doe_mb ? " doe" : "",
> +		 pci_tsm->doe_secure_mb ? " secure-doe" : "");
>  
>  	pci_tsm->state = PCI_TSM_INIT;
>  	pci_tsm->dsm = no_free_ptr(dsm);
> @@ -277,10 +281,20 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>  			 const void *req, size_t req_sz, void *resp,
>  			 size_t resp_sz)
>  {
> -	if (!pdev->tsm || !pdev->tsm->doe_mb)
> +	struct pci_doe_mb *mb = NULL;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	if (type == PCI_DOE_PROTO_CMA)
> +		mb = pdev->tsm->doe_mb;
> +	else if (type == PCI_DOE_PROTO_SSESSION)
> +		mb = pdev->tsm->doe_secure_mb;
> +
> +	if (!mb)
>  		return -ENXIO;
>  
> -	return pci_doe(pdev->tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req,
> +	return pci_doe(mb, PCI_VENDOR_ID_PCI_SIG, type, req,
>  		       req_sz, resp, resp_sz);
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 6ad2081a329d..815da9c3fc50 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -34,6 +34,7 @@ struct pci_tsm {
>  	enum pci_tsm_state state;
>  	struct mutex lock;
>  	struct pci_doe_mb *doe_mb;
> +	struct pci_doe_mb *doe_secure_mb;
>  	struct pci_dsm *dsm;
>  };
>  
> -- 
> 2.43.0
> 

