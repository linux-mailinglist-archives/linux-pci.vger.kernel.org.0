Return-Path: <linux-pci+bounces-28043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF2ABCB9F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800AC3AB70E
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775F219A8C;
	Mon, 19 May 2025 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HL/NJIel"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF371FDA9E;
	Mon, 19 May 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747697965; cv=none; b=Pk3glzSyM2W9PZbQADB8PkbYq7JIyC9RtNukRfSUl0mkfZaFW8IZXJpCYPiyUVkHOiXeQw8vcL48yhgRewzJGjCNuwEWf1iLSnBGy0pfoi8dLfIP1LZQTHIikFGxkKKhj5BNrOmRg6z7EaXU1nIzxrggFgTbKIJVyHxqbMi8Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747697965; c=relaxed/simple;
	bh=yJhwSl/hpeMxQzA7iiTB8rCpNN0FxQgYCJXfN813PcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEiTF7ilX7HU8kzkWu5BKbeoz1Wu3hyUoVeHbnfTlVXhoTMnbUpgqFuG52d6wMC0B9zzYEJoKZNb0Xkfdpi/42bLKNicS2QxuG5FcxDG1A4qOyl0jBGVtr4iJI7woW8Ad4DdRjPnHCF/VIj2EcAL7chAb1FmRf2840S6IX03/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HL/NJIel; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747697963; x=1779233963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yJhwSl/hpeMxQzA7iiTB8rCpNN0FxQgYCJXfN813PcM=;
  b=HL/NJIelRRIbep4uulQSSavkDQmpMFQ+JU8nYHiyhM9JRxCNF+TBHZUl
   aQregETMn1HnXQ8iguBAJZEdbhyKL6ZxbhJ2ul5TVYbiGHR5nTL7+vluE
   ZDEBLHcdJ63zmuONS/RMB5q9pNPRiBA6Qh1IUJqRz2CJfLNJb4VrXzu/y
   fZjxZyHy8zI7JvmZ/Q4lN0nVdEG7oytn4396GkgaHozpUR0hitXyonHvh
   pEnTOXMv9V0PNTrVsFvqTOiZCnvKxK+Mgvf9OGv3g+gM25knvETATpPuL
   HC1jDn53Gn6eAa/JH7/+COsp8P3lWncuKbYha2MhPXmB+8ykVIoD6XWzf
   g==;
X-CSE-ConnectionGUID: 1O+H/xHtR6O55zL8vszV1g==
X-CSE-MsgGUID: V74X8mNlTE6509g97sPm6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60958461"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60958461"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:39:22 -0700
X-CSE-ConnectionGUID: ixaNyZ2lQBCj7Dc0Lj0Gew==
X-CSE-MsgGUID: KnT+1naGTc+MgRutki7GMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140420007"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:39:20 -0700
Message-ID: <9ac2bb02-974f-4952-b069-1bcc94682d89@linux.intel.com>
Date: Mon, 19 May 2025 16:39:19 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/16] PCI/AER: Consolidate Error Source ID logging in
 aer_print_port_info()
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
 <20250519213603.1257897-4-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously we decoded the AER Error Source ID in two places.  Consolidate
> them so both places use aer_print_port_info().  Add a "details" parameter
> so we can add a note when we didn't find any downstream devices with errors
> logged in their AER Capability.
>
> When we didn't read any error details from the source device, we logged two
> messages: one in aer_isr_one_error() and another in find_source_device().
> Since they both contain the same information, only log the first one when
> when find_source_device() has found error details.
/s/when//
>
> This changes the dmesg logging when we found no devices with errors logged:
>
>    - pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0
>    - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
>    + pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0 (no details found)
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pcie/aer.c | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..b8494ccd935b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -733,16 +733,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> +static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
> +				const char *details)
>   {
>   	u8 bus = info->id >> 8;
>   	u8 devfn = info->id & 0xff;
>   
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",

Instead of relying on the callers, why not add a space before details here?

>   		 info->multi_error_valid ? "Multiple " : "",
>   		 aer_error_severity_string[info->severity],
>   		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +		 PCI_FUNC(devfn), details);
>   }
>   
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -926,13 +927,13 @@ static bool find_source_device(struct pci_dev *parent,
>   	else
>   		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>   
> +	/*
> +	 * If we didn't find any devices with errors logged in the AER
> +	 * Capability, just print the Error Source ID from the Root Port or
> +	 * RCEC that received an ERR_* Message.
> +	 */
>   	if (!e_info->error_dev_num) {
> -		u8 bus = e_info->id >> 8;
> -		u8 devfn = e_info->id & 0xff;
> -
> -		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> -			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> -			 PCI_FUNC(devfn));
> +		aer_print_port_info(parent, e_info, " (no details found)");
>   		return false;
>   	}
>   	return true;
> @@ -1297,10 +1298,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   			e_info.multi_error_valid = 1;
>   		else
>   			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
>   

Instead of printing the error information in find_source_device() (a helper function), I think it be better to print it here (the error handler). source_found = find_source_device(pdev, &e_info); aer_print_port_info(pdev, &e_info, source_found? "" : "(no details found) " );

if (source_found) aer_process_err_devices(&e_info)


> -		if (find_source_device(pdev, &e_info))
> +		if (find_source_device(pdev, &e_info)) {
> +			aer_print_port_info(pdev, &e_info, "");
>   			aer_process_err_devices(&e_info);
> +		}
>   	}
>   
>   	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1316,10 +1318,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		else
>   			e_info.multi_error_valid = 0;
>   
> -		aer_print_port_info(pdev, &e_info);
> -
> -		if (find_source_device(pdev, &e_info))
> +		if (find_source_device(pdev, &e_info)) {
> +			aer_print_port_info(pdev, &e_info, "");
>   			aer_process_err_devices(&e_info);
> +		}
>   	}
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


