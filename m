Return-Path: <linux-pci+bounces-27747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73139AB71C1
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EB418856C7
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C51A27A92C;
	Wed, 14 May 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tk1wk66N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BB1B043A;
	Wed, 14 May 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240944; cv=none; b=lJ32OKcCuKAW+UXtYF7iUv7ubw+5W8zFpaN6PM00k5Up8jENy+lAVjxVpXeMoqnl79yrJUCd5twtzqHkabmI1CCWas/LWBg1IPqY0U7e6Sq50jkrTiCZoXWHkgw26RLAJvQJq/dzT01F6rdfqKK+MKNBfadanYlAE/MYle7VaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240944; c=relaxed/simple;
	bh=3a/AGcV2Rv7gzIvog99Z8j2jxhg8+75lupWlsqOGDM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJrS4LItxswKMebNbJA05GitItgwzKCWIB1E8uw3HMB71RJRF2SAw/RoQa+usCRTMqDUztSPqW2t8zBL2zRniWL6M10maGuuBqwm0Ug1ul4HPxlUgJdj30S1zHf8rQBtRXWZklKkTImq6lH55mihkXOQbAh8jvuWWXujTsNYTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tk1wk66N; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747240942; x=1778776942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3a/AGcV2Rv7gzIvog99Z8j2jxhg8+75lupWlsqOGDM0=;
  b=Tk1wk66NiickztNvxpnaBNXlcocHEYYVtBcZp0KO8BNVTTc/ngo7Uw1e
   DFfQzmg3DOFuAKAZpFTBvPASodl8ggB5qpvdC6jvxD+UQUPsUELpipg2C
   juZZP1FJCqpW7KuPi+h4s7V3et1sSzuZKE++PB5tJolMMaJhgnEJBnnbI
   OH3B0TIVNj8KcchHjTNQuRC00CaulEdwquq1nzFhatgXSe6kNNdHtHfsF
   e49PQjAeEw2b49xIdxZy1JXJMQa+z+M49l94N77FyA3JkmtjVVQ4/mzgV
   19OsvbB4lxG7WxAxB4O9clLqyDp7Nv/H8fxY6TDxQx5D89fbBhZd9OLH0
   w==;
X-CSE-ConnectionGUID: 83qnpMfKRDu3szjfHo/8jw==
X-CSE-MsgGUID: Q2pvI0cdTi2dzJ4gQj10Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="48262181"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="48262181"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 09:42:20 -0700
X-CSE-ConnectionGUID: v0zwh2NRShuM7ho+Ce271Q==
X-CSE-MsgGUID: rxO74IssSCOLhS1RUO3Gjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138154268"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO [10.124.222.100]) ([10.124.222.100])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 09:42:17 -0700
Message-ID: <abe64cda-729e-44e2-bc1e-d43d3566980e@linux.intel.com>
Date: Wed, 14 May 2025 09:42:16 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] PCI/ERR: Add support for resetting the slots in a
 platform specific way
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
 <20250508-pcie-reset-slot-v4-2-7050093e2b50@linaro.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250508-pcie-reset-slot-v4-2-7050093e2b50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/25 12:10 AM, Manivannan Sadhasivam wrote:
> Some host bridge devices require resetting the slots in a platform specific
> way to recover them from error conditions such as Fatal AER errors, Link
> Down etc... So introduce pci_host_bridge::reset_slot callback and call it
> from pcibios_reset_secondary_bus() if available.
>
> The 'reset_slot' callback is responsible for resetting the given slot
> referenced by the 'pci_dev' pointer in a platform specific way and bring it
> back to the working state if possible. If any error occurs during the slot
> reset operation, relevant errno should be returned.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pci.c      | 12 ++++++++++++
>   drivers/pci/pcie/err.c |  5 -----
>   include/linux/pci.h    |  1 +
>   3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4d7c9f64ea24ec754a135a2585c99489cfa641a9..13709bb898a967968540826a2b7ee8ade6b7e082 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4982,7 +4982,19 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>   
>   void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>   {
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	int ret;
> +
> +	if (host->reset_slot) {
> +		ret = host->reset_slot(host, dev);
> +		if (ret)
> +			pci_err(dev, "failed to reset slot: %d\n", ret);
> +
> +		return;
> +	}
> +
>   	pci_reset_secondary_bus(dev);
> +
>   }
>   
>   /**
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index de6381c690f5c21f00021cdc7bde8d93a5c7db52..b834fc0d705938540d3d7d3d8739770c09fe7cf1 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -234,11 +234,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	}
>   
>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
> -		/*
> -		 * TODO: Should call platform-specific
> -		 * functions to reset slot before calling
> -		 * drivers' slot_reset callbacks?
> -		 */
>   		status = PCI_ERS_RESULT_RECOVERED;
>   		pci_dbg(bridge, "broadcast slot_reset message\n");
>   		pci_walk_bridge(bridge, report_slot_reset, &status);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e8e3fd77e96713054388bdc82f439e51023c1bf..8d7d2a49b76cf64b4218b179cec495e0d69ddf6f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -599,6 +599,7 @@ struct pci_host_bridge {
>   	void (*release_fn)(struct pci_host_bridge *);
>   	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>   	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	int (*reset_slot)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>   	void		*release_data;
>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


