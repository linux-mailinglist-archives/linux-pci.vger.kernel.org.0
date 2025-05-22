Return-Path: <linux-pci+bounces-28311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F1BAC18B6
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7877AD0BA
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600324DD02;
	Thu, 22 May 2025 23:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFZtcTbK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662124DCE8;
	Thu, 22 May 2025 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958246; cv=none; b=o+gj+wlNNxhZ2DWaEyi3nP4CEiDW6XF9VvDE/z/d0JkzqOUBXHB3ZkawWlesvEbJ4dflBjOjQrb9RecA/27WIxL5mkwGfwiGHgi1KzL+fMKeSoHv9ozU8BtjfiRfooVVk0lfOALCXv6sFEbTTTfJtDUhkwBfipP1FHM1BKn119I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958246; c=relaxed/simple;
	bh=QYOWZ2FwAxXVY5zAUVw+08m0cpSZDQFAL7+izIDHNig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHF+kcGBH/urEPk6of00AmKcAKN1bbJ0zlJlcW1r79zk/VNqGSue4fhfCwMhT5jQMKEgM5AuNbjZwYUTzYaAPZ4d4C5gwpfDDq1c8X1e10Umr6co7D6txK+DN1eajLncp1Z/oFNqiVySuPylODy9bGT3KA0nsqzHM5CX5b6HXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFZtcTbK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747958245; x=1779494245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QYOWZ2FwAxXVY5zAUVw+08m0cpSZDQFAL7+izIDHNig=;
  b=AFZtcTbKaMnMtDphzxx+GsHim3vTMJWvPX1S9rbbL9Ye1Zpa9u/YP9YJ
   Af8djXw0yjfCKX/nyntsK1MJibS+0s1FrI9MEQ7sbbcryD8I7Gw0zDddK
   qaZDepXmP2IwviSmmYKZzk4wl8ClwebeDI+iQYZP5diWIzfnVleJ18/Gd
   2aV4l+YEG+1+mDwD0da+aBXWglV3BT5s2lDz95X5XtW4IF1Yu6uJ5S30D
   kquDzceXGDjhwx44rLA/+ICnGeObTW7eKB6eMU9+muv568gShLmbbezz8
   hnJS4pzjPlWQsnqKCiBjTSm5q0o8frtjbwR9t5XGLa542oulyS5is2rSr
   A==;
X-CSE-ConnectionGUID: I22QoPZpQDyXAV7/AYCT/w==
X-CSE-MsgGUID: I3E6FySoR6yalJWQ3keqhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60643725"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="60643725"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:57:24 -0700
X-CSE-ConnectionGUID: 7lIzCNAVR6qR2FCNCi9FFA==
X-CSE-MsgGUID: jsNCrqeCRwuHtFu3GzGzEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140657810"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.223.120]) ([10.124.223.120])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:57:23 -0700
Message-ID: <2c79c6b5-db40-4e54-b058-a95c56f735fb@linux.intel.com>
Date: Thu, 22 May 2025 16:57:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/20] PCI/AER: Simplify add_error_device()
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Weinan Liu <wnliu@google.com>, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250522232339.1525671-1-helgaas@kernel.org>
 <20250522232339.1525671-18-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250522232339.1525671-18-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/22/25 4:21 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Return -ENOSPC error early so the usual path through add_error_device() is
> the straightline code.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 237741e66d28..24f0f5c55256 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -816,12 +816,15 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>    */
>   static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>   {
> -	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> -		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> -		e_info->error_dev_num++;
> -		return 0;
> -	}
> -	return -ENOSPC;
> +	int i = e_info->error_dev_num;
> +
> +	if (i >= AER_MAX_MULTI_ERR_DEVICES)
> +		return -ENOSPC;
> +
> +	e_info->dev[i] = pci_dev_get(dev);
> +	e_info->error_dev_num++;
> +
> +	return 0;
>   }
>   
>   /**

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


