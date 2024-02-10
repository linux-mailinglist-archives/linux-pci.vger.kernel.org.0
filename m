Return-Path: <linux-pci+bounces-3322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE36850275
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D806287A95
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EBD3C2D;
	Sat, 10 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMq6HdU2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FE1370;
	Sat, 10 Feb 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535231; cv=none; b=NT6puFOzNsTAxjH3pXbKf6WvnIRkPKX+yhsuRWRGERTKhCnOzzHNrud71iKQ3AY6r8pfe1DxYeI4BXR6sBAreVzUQ7t5s0tICTZ43NhFlcMpfIh2Mmkgg6ewHsmCE2qLUhNm9sLiFkDKJIuPdXWTk66TF9NBDNPDK3c5McuV4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535231; c=relaxed/simple;
	bh=inh8wpC7E3QmfuR6VOWyQAlRN6uFRdc+6r3sM41j+P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KStXAnuueXugwXZF5ZxHzVi/kHbrSZBA0a6JJQcZeMnnSSMS6XcTBMmZ4AoFxtcLw4X07a5w/+JMM6UlSQfRyfW0RnyXW9U7Wm6TLW3W+Zi8CXhgKSUltMtraMaRJuevyFUB6Fom4/Yw5Vh0qAaDSxqd1i6Hu3JfFpHRY9g7nvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMq6HdU2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707535230; x=1739071230;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=inh8wpC7E3QmfuR6VOWyQAlRN6uFRdc+6r3sM41j+P0=;
  b=QMq6HdU2BBq/a/boN1Q8yBUT9uWjvL36VVBiYqUJ589QON3PRM1wXEvB
   dUx2JX2fexGFWWA/JCfLlI7hvyZxrursoJ5bBchOtdIUH2N98PbPipY2z
   RvWvtbkEZziokL4gzBg2U7dNKeXlfeVpyH0YuQ5+rsXdo+fOkq2AHz324
   Wu52t77EgpKmJDlKX8Y8NtQysP/WOpjc9eGNkURzwP7FT/d7WGk3xYpfE
   +jY16BzPwj4DSQYR0/TGYDxdENklKLnozWgb5IF3nHpK9JpwEL7NZwoOF
   BV7Zoei2f/OKlKP7QgCE85Zh72LQ5jsJ752LRWiddRn3IOQ5mg0JTqxaP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1671197"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="1671197"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 19:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2086323"
Received: from ticela-or-295.amr.corp.intel.com (HELO [10.209.25.188]) ([10.209.25.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 19:20:28 -0800
Message-ID: <10d63412-583b-4647-bb5c-4113a466324e@linux.intel.com>
Date: Fri, 9 Feb 2024 19:20:28 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Content-Language: en-US
To: Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "pierre.cregut@orange.com" <pierre.cregut@orange.com>
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4@uscas1p2.samsung.com>
 <170752273224.1693615.11371097645648272257.stgit@bgt-140510-bm01.eng.stellus.in>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <170752273224.1693615.11371097645648272257.stgit@bgt-140510-bm01.eng.stellus.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/9/24 3:52 PM, Jim Harris wrote:
> If an SR-IOV enabled device is held by vfio, and the device is removed,
> vfio will hold device lock and notify userspace of the removal. If
> userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
> since sriov_numvfs_show() also tries to acquire the device lock. If that
> same thread is responsible for releasing the device to vfio, it results in
> a deadlock.
>
> The proper way to detect a change to the num_VFs value is to listen for a
> sysfs event, not to add a device_lock() on the attribute _show() in the
> kernel.

Since you are reverting a commit that synchronizes SysFS read
/write, please add some comments about why it is not an
issue anymore.

>
> This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
> Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
>
> Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jim Harris <jim.harris@samsung.com>
> ---
>  drivers/pci/iov.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index aaa33e8dc4c9..0ca20cd518d5 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
>  				 char *buf)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	u16 num_vfs;
> -
> -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
> -	device_lock(&pdev->dev);
> -	num_vfs = pdev->sriov->num_VFs;
> -	device_unlock(&pdev->dev);
>  
> -	return sysfs_emit(buf, "%u\n", num_vfs);
> +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
>  }
>  
>  /*
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


