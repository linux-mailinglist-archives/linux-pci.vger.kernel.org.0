Return-Path: <linux-pci+bounces-20351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BC0A1C0E7
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 05:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E720E1887984
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 04:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859CA205E1B;
	Sat, 25 Jan 2025 04:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrBpmdJR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF27482EB
	for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737778559; cv=none; b=dYS50V4Xrxif2pQHUaMKa6CnQnSems0PZJEfZkL+3IEmlD2cy8EACQcq1iClE1UsWeQwkWRgDjH2Wj8nEE9aoRmZz84NhgTcaZaaZZa20z2PmpZZMgWzKC69MzqdUZPe0X9ShxKlcFh+6/l3bKFxndzj853wQ59VwPcuyjHQAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737778559; c=relaxed/simple;
	bh=kwTIkyS4UCmM2ULab6nrfhTqrECq/aArpDodqlUPP2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dF8nWOSo96MplFSYo2LpbYscQx0qIBODPj/xjUsZKdi4yNF5vdYEodcs6dpoMBomEyzRZ6w8+4gqkslsL5rGKGDWRB5Jv53vmvqqn0yrIiVefd7LbJmF9MmmIDYVVb55Qw4ns1+3qu3WWEAwMRIVz4uHCnU9k4LXJ6HnGNx8rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrBpmdJR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737778558; x=1769314558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kwTIkyS4UCmM2ULab6nrfhTqrECq/aArpDodqlUPP2c=;
  b=nrBpmdJRSOvt30Oktg3cqFboiQLlMX/oaBv7Eq33xOtNU2Y1j20QQ9Tb
   RV0IyMPQLAZs1eyoA/zVV4ll8/zh+vyIYXRAhSowqSzqN8y0RnVP6G2Jj
   P6/blDDYmmfG6brfCzbL+CVnL+eW4FlGZKxzCk79mDXQ5cxSiOVqsxD54
   lez+GIzCOY9yXCpjzd2BEpVi0BFzz+9GC/2xVmYPCK0VxzOeaNeh0I9Vn
   +VmchT1mmY+JyHK0WCnn5yY5IDzYmtDLhVVHVyhAQXR2namUCEWhc/3aI
   RFQlEJA51oEAWcvKvU3h7rHQ/YY/0W+nPa03rPOqyMbBpDy73XrwmnPKz
   A==;
X-CSE-ConnectionGUID: ejt6Kur+R/egVSqZUU5VWA==
X-CSE-MsgGUID: l1fHhR0qSH+cSsyG/101IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="38020593"
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="38020593"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 20:15:57 -0800
X-CSE-ConnectionGUID: sokoM3kMTNuVrwqrMiJQoQ==
X-CSE-MsgGUID: Ho5yXnumQSuL+6I9DivgeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138808168"
Received: from dgramcko-desk.amr.corp.intel.com (HELO [10.124.223.250]) ([10.124.223.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 20:15:56 -0800
Message-ID: <696e0a5c-5d5d-4a58-b00e-7c678290713e@linux.intel.com>
Date: Fri, 24 Jan 2025 20:15:55 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-2-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250115074301.3514927-2-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/14/25 11:42 PM, Jon Pan-Doh wrote:
> Info logged is duplicated when either the source device is processed. If
> no source device is found, than an error is logged.

Any issue with logging when no source device is found in device
hierarchy?

>
> Code flow:
> aer_isr_one_error()
> -> aer_print_port_info()
> -> find_source_device()
>     -> return/pci_info() if no device found else continue
> -> aer_process_err_devices()
>     -> aer_print_error()
>
> aer_print_port_info():
> [   21.596150] pcieport 0000:00:04.0: Correctable error message received
> from 0000:01:00.0
>
> aer_print_error():
> [   21.596163] e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> [   21.600575] e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
> [   21.604707] e1000e 0000:01:00.0:    [ 6] BadTLP

Please remove time stamp from dmesg log.

>
> Tested using aer-inject[1] tool. No more root port log on dmesg.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pcie/aer.c | 15 ---------------
>   1 file changed, 15 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34ce9f834d0c..ba40800b5494 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -735,18 +735,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> -{
> -	u8 bus = info->id >> 8;
> -	u8 devfn = info->id & 0xff;
> -
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> -}
> -
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>   int cper_severity_to_aer(int cper_severity)
>   {
> @@ -1295,7 +1283,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   			e_info.multi_error_valid = 1;
>   		else
>   			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
>   
>   		if (find_source_device(pdev, &e_info))
>   			aer_process_err_devices(&e_info);
> @@ -1314,8 +1301,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		else
>   			e_info.multi_error_valid = 0;
>   
> -		aer_print_port_info(pdev, &e_info);
> -
>   		if (find_source_device(pdev, &e_info))
>   			aer_process_err_devices(&e_info);
>   	}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


