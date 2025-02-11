Return-Path: <linux-pci+bounces-21231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24998A3177B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE671694E2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310B25335B;
	Tue, 11 Feb 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqjGnMRH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16B266581;
	Tue, 11 Feb 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308710; cv=none; b=frHowoPM7NTmsNxiXxPyCf5REdmutFwEpOqUBvYAhm0+9WY+0sXu/WZSDJIbdwDIPqwntu5W3yylo6uLzCvrRH3kj3X8TpodC77Vhlj9oUa+MKj7wTis8Qw350UwY7Mu7e/M7XJ+jIk+3btvs3WoJnvC8K/Ji6ueziAEXV46d6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308710; c=relaxed/simple;
	bh=/okSp1SamebmoZvprrOXat3uYAeyx547q4FKA2bMGnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgsqDBEFipCLMRiR3ylOEKiBouvrfFFUeUCdThg8BMEu8yE+3YZkWiMlOWgvLwGBp6M8oJJtDUb8w9ezRgOw0O/iw6kMU5ins6hWgmouDGx4ItKb+4knMXjwkY/os7xicMt2N/zMBoFNNlKsvo2LlqTzaM3/Es0lK5LCmwzHFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqjGnMRH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739308708; x=1770844708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/okSp1SamebmoZvprrOXat3uYAeyx547q4FKA2bMGnY=;
  b=kqjGnMRHqkPWIF91GNnqSKtqOgPz7L3gyVFAMjvbnfKn08JOf+XVxhbu
   2TPG+VZzbmlfIJcDUHDdg9qe3+SjiTNG+MZIyHEHfa2lly1io5p3PcQwA
   leGfBIPbmEklkli98FcX/ShQn93moEVt+keTx254f/htwGUpElHga9DSx
   unF34shwn3WNc7+KgV52nhxFmU6hcI1T/cH1lJprv2OUpAmnm5TYojE19
   b2UYCV8EIPcouyYZ3UUr0hsjOEHbxUCRPyE+4DCt9SRtnJg6Nk9TYLvx7
   vWQJ3ity+cKeYKcU4lzYOWzPp6ndiQqyCJ3GB9ZCQ1n5Awmz6XsdzAd0I
   A==;
X-CSE-ConnectionGUID: 66dIsW4uS0e/1QNZ6CN+HA==
X-CSE-MsgGUID: 2xQRvvhWQPGw3oe8zONdBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50584179"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50584179"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:18:27 -0800
X-CSE-ConnectionGUID: 0FhQfMmPSm26Lwx7eLDwWA==
X-CSE-MsgGUID: FS4r2JZIQBuZVRFR80ozcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113516411"
Received: from jdoman-desk1.amr.corp.intel.com (HELO [10.124.222.44]) ([10.124.222.44])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:18:27 -0800
Message-ID: <f4d2579c-97ab-41d7-a496-7c711243517f@linux.intel.com>
Date: Tue, 11 Feb 2025 13:17:55 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] PCI/DPC: Rename pdev to err_port for dpc_handler
To: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bhelgaas@google.com, kbusch@kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
 terry.bowman@amd.com
References: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
 <20250207093500.70885-2-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250207093500.70885-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/7/25 1:34 AM, Shuai Xue wrote:
> The irq handler is registered for error port which recevie DPC
> interrupt. Rename pdev to err_port.
>
> No functional changes.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---

I think you can combine patch 1 & 2 into a single patch. Change wise, it 
looks
fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/dpc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 242cabd5eeeb..1a54a0b657ae 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -346,21 +346,21 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>   
>   static irqreturn_t dpc_handler(int irq, void *context)
>   {
> -	struct pci_dev *pdev = context;
> +	struct pci_dev *err_port = context;
>   
>   	/*
>   	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
>   	 * of async removal and should be ignored by software.
>   	 */
> -	if (dpc_is_surprise_removal(pdev)) {
> -		dpc_handle_surprise_removal(pdev);
> +	if (dpc_is_surprise_removal(err_port)) {
> +		dpc_handle_surprise_removal(err_port);
>   		return IRQ_HANDLED;
>   	}
>   
> -	dpc_process_error(pdev);
> +	dpc_process_error(err_port);
>   
>   	/* We configure DPC so it only triggers on ERR_FATAL */
> -	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
> +	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
>   
>   	return IRQ_HANDLED;
>   }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


