Return-Path: <linux-pci+bounces-3323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F41850277
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 04:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF1A1C2619C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D43FFE;
	Sat, 10 Feb 2024 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3G+UN4d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9F1370;
	Sat, 10 Feb 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535341; cv=none; b=Wn+w1Hy+lLNAdzEsNVBuWDkIAT3BOpkRVbdJy6TjmncebFX+JVueJEp/VJCAQu1erHjTd0EhyoqXg2UWw+4hdnk415ctNuoM7DeuZYRXYzr21qppNeu0cPD313zxqjZfVWcBsFLL703v0MpY2zjfXrS1YtvibdDnOotnPgdPTpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535341; c=relaxed/simple;
	bh=xUXJPXsKc7TxHTCdJ+qu0RbaBHZWIuQ+OLNtT4PEDWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X+Hf8qXUBAJe9ik20E19WM4do/hK9uTLnRJz9HU0xr+Xf7qvgtPlQDJM0AnSBUS8zGGcDQSXzl6mvTRXj568hX5dT4UztW7/mL1YTohN9q6szbbCSeiHJ1fhgeJkhYVXZEzpmF4quwaAzlg2IsT5UFM52wSVoa1rAWMgkGM+54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3G+UN4d; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707535340; x=1739071340;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xUXJPXsKc7TxHTCdJ+qu0RbaBHZWIuQ+OLNtT4PEDWY=;
  b=Z3G+UN4d0vwItsHGgYzjL9A2Rt1Z7gzh1FXPxzws8auiKqlpbYpu6W5A
   GppGfCXsMuDqi8ThtEpK7llZPP1ChCAstQp1fp/LM4PjCMcSQcpLGEHU/
   TBH4dc3SC0c930IRIG4LeVqngU+Ih4AGVwtolBvzI4NRwEO0AGgY0K9qS
   Xte1o50VZ/s4fUwiNpcFg9Sk6BnQVCIWTCnQ/Cj22mVjjmiabIJGx+XYz
   aJ2Dx+v8Q40dat85NmER/CHUa/BpuQ56dwGi8BeBRHM0mqhWLOAfoNfnb
   UTfBmVmAcv7kZ2Qxc53oKFRKsaQk5+gTbBIwd1t7heHhPlJwoFWpUM1CS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1671257"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1671257"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 19:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2086653"
Received: from ticela-or-295.amr.corp.intel.com (HELO [10.209.25.188]) ([10.209.25.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 19:22:18 -0800
Message-ID: <d9c89ad1-990d-4a4c-a16d-27d978673e57@linux.intel.com>
Date: Fri, 9 Feb 2024 19:22:17 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pci/iov: fix kobject_uevent() ordering in
 sriov_enable()
Content-Language: en-US
To: Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "pierre.cregut@orange.com" <pierre.cregut@orange.com>
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20240209235218uscas1p2d0978af6623037fa1b9358a2ad2320c5@uscas1p2.samsung.com>
 <170752273749.1693615.1293677023514112939.stgit@bgt-140510-bm01.eng.stellus.in>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <170752273749.1693615.1293677023514112939.stgit@bgt-140510-bm01.eng.stellus.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/9/24 3:52 PM, Jim Harris wrote:
> Wait to call kobject_uevent() until all of the associated changes are done,
> including updating the num_VFs value. This avoids any possibility of
> userspace responding to the event and getting a stale value (although
> probably impossible to actually happen).
>
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---

It looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/iov.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 0ca20cd518d5..c00b0f822526 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -677,8 +677,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	if (rc)
>  		goto err_pcibios;
>  
> -	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>  	iov->num_VFs = nr_virtfn;
> +	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>  
>  	return 0;
>  
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


