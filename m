Return-Path: <linux-pci+bounces-28045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC7ABCBBA
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E9C1B62CA4
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DF220F45;
	Mon, 19 May 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGnfdIER"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143FC21FF45;
	Mon, 19 May 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698530; cv=none; b=Rj0g+FKOIUhx15Q4mAD1U51M5yo86H25/JY+EVfsOXUqTgb1u6P024FDxiwJgeBFJEPl4s+E0guO8N45nPL4BSh2fc9CjvmDVDkxp7e9J8JbjJO3uznQUy4OaZaWGc9utxuLzqbuReAsQvwKfa6IDHToJRspgf7y4UkQickkljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698530; c=relaxed/simple;
	bh=LJOuant5C3INJ16GsM0ycGuMue6hzGDfnJVPCWAo/VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7QdYw6zbwamUnuku60ZyOxmpVHxr2y3CSho/Nw1/H92nSzKFvF5v+KkkVZLX4DcX0cfK9Of70XX3Z93QzdtJQD2D+kufg+/r8FB8XfWdzmsNhllDFGNmjg+cO8HA3UXe6MkQRFTZcehA+KMecHc3GAtnJ08RTGjUvI82fgRqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGnfdIER; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747698529; x=1779234529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LJOuant5C3INJ16GsM0ycGuMue6hzGDfnJVPCWAo/VU=;
  b=VGnfdIERP7lalJ3NFdH8E3VR8vQW2/YVMaGpy9AQNPpOUrIhmg1uUTvp
   1plaqfwucvPhVSzSc4QAPyybCvxq4x4SRvfyL8DEjhlU0rIz2Us5DPi8+
   Tl/7GzDWepw5aSQTuTJdwT2H5ntw245D44DjOTCuegsZNDqJd05W9PxTK
   uqBuBOh2o6yePjeOYh0Du1mVRlfYZB9IKi2BgTeqCDArJsVU/HE4LkGeU
   6VFBwsEwDUHmnvL3MWfV02lZ9X4Go592368oXFSn7EKz8Nx/d+6GBf7L0
   OorNfcxEEyZshWemKGSPwfIJqVZYnEpuZ4hWGmO10dgk8tg9UY0MmpdSf
   Q==;
X-CSE-ConnectionGUID: 4cBWmqhiRsq14BGjQNSg7A==
X-CSE-MsgGUID: sajXz5ipQqCXFN2NoLfpZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52245949"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="52245949"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:48:48 -0700
X-CSE-ConnectionGUID: F8EwIusvRgytG6VTL3CYQg==
X-CSE-MsgGUID: AH2P0i/EQZa7HbERW4MxuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139421191"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:48:47 -0700
Message-ID: <e8cf0a90-638d-446a-a5df-2dff3d091e38@linux.intel.com>
Date: Mon, 19 May 2025 16:48:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/16] PCI/AER: Rename aer_print_port_info() to
 aer_print_source()
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Martin Petersen <martin.petersen@oracle.com>,
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
References: <20250519213603.1257897-1-helgaas@kernel.org>
 <20250519213603.1257897-6-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-6-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Jon Pan-Doh <pandoh@google.com>
>
> Rename aer_print_port_info() to aer_print_source() to be more descriptive.
> This logs the Error Source ID logged by a Root Port or Root Complex Event
> Collector when it receives an ERR_COR, ERR_NONFATAL, or ERR_FATAL Message.
>
> [bhelgaas: aer_print_rp_info() -> aer_print_source()]
> Link: https://lore.kernel.org/r/20250321015806.954866-5-pandoh@google.com
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index dc8a50e0a2b7..eb42d50b2def 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -733,8 +733,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
> -				const char *details)
> +static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
> +			     const char *details)
>   {
>   	u16 source = info->id;
>   
> @@ -932,7 +932,7 @@ static bool find_source_device(struct pci_dev *parent,
>   	 * RCEC that received an ERR_* Message.
>   	 */
>   	if (!e_info->error_dev_num) {
> -		aer_print_port_info(parent, e_info, " (no details found)");
> +		aer_print_source(parent, e_info, " (no details found)");
>   		return false;
>   	}
>   	return true;
> @@ -1299,7 +1299,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   			e_info.multi_error_valid = 0;
>   
>   		if (find_source_device(pdev, &e_info)) {
> -			aer_print_port_info(pdev, &e_info, "");
> +			aer_print_source(pdev, &e_info, "");
>   			aer_process_err_devices(&e_info);
>   		}
>   	}
> @@ -1318,7 +1318,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   			e_info.multi_error_valid = 0;
>   
>   		if (find_source_device(pdev, &e_info)) {
> -			aer_print_port_info(pdev, &e_info, "");
> +			aer_print_source(pdev, &e_info, "");
>   			aer_process_err_devices(&e_info);
>   		}
>   	}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


