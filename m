Return-Path: <linux-pci+bounces-27746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9FAB71BF
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E544E03AB
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995F2868A4;
	Wed, 14 May 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V76k7bJI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B0280CD9;
	Wed, 14 May 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240750; cv=none; b=UJ2eUcg4c1J13LGHZ1rdXuljv78oF9Ui5VUu+harZuThMITzJ82syRvPWZirA+MXDBku9C70TmFePVHzZgJnZBnpLhipbZdB6ZCCTA8NIb6sHHmBkQgWwoye1aZEHur3xozAsZinEbvAtFwUulBXpbhoDSCvDo0lJxiaWE5OFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240750; c=relaxed/simple;
	bh=BQxpe1gKe+N60hkJWYTw2nQy3pGjcVIp7WcxAHzbnzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMiTAknBxNIen+2TVY9hr7ToPCXcSs6pF/G+NTInBM61jHsYgatKbamcmPDPf4TcInrcvPtLDnC/jsZRIEek2wOqeXrFC37hMao5OXQTX9AK4nNNkpwPeZcertl4tn629irAlyYTzbbgLeiP9UKLKnORgI8OL0we3lWvf/KE5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V76k7bJI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747240748; x=1778776748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BQxpe1gKe+N60hkJWYTw2nQy3pGjcVIp7WcxAHzbnzc=;
  b=V76k7bJI695UACFv8aY83WK0uvv2KE3+tKztSwMCLoC65k0tyfgo4BAw
   zFfyFsmuNRCmq4b3lGhv39slDdJ4yAumwo6v7oI2M42rNAp9LzzZKwO40
   FTdIYdWmm7DGEcVc3rMt44o8M44o21vcfCIlnxwlHd1eGdddBAl+4L+PW
   dkxtPDMeJdpTu3OIbioYnG+TSF2+XYKZz894kY6zU0TWJwZuksuSnRVTh
   54sRdArih3E9WBjpV734c1+i8T07OHw4+vyaSE7Y6c1c5HCmVhQWHOU3Y
   2ImYdlcMC5SNufXfL5zZxicZ4Z0hTgAzree2xuANpRohIghlsorYNOMKt
   A==;
X-CSE-ConnectionGUID: 6+owG774QI6LsKcfQHTQoQ==
X-CSE-MsgGUID: G10WDY9oR7quijS9GMLb/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49223612"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49223612"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 09:39:07 -0700
X-CSE-ConnectionGUID: dL1HJHziTNqYT0Ugnl+VeQ==
X-CSE-MsgGUID: HT6VqRyKSneRimqS3nA3iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="138511665"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO [10.124.222.100]) ([10.124.222.100])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 09:39:06 -0700
Message-ID: <d46bd014-02d9-44ec-a29d-b925f268ee03@linux.intel.com>
Date: Wed, 14 May 2025 09:39:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] PCI/ERR: Remove misleading TODO regarding kernel
 panic
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
 <20250508-pcie-reset-slot-v4-1-7050093e2b50@linaro.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250508-pcie-reset-slot-v4-1-7050093e2b50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/25 12:10 AM, Manivannan Sadhasivam wrote:
> A PCI device is just another peripheral in a system. So failure to
> recover it, must not result in a kernel panic. So remove the TODO which
> is quite misleading.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/err.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffcc94e15ba6e89f649c6f84bfdf0d5..de6381c690f5c21f00021cdc7bde8d93a5c7db52 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -271,7 +271,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   
>   	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
>   
> -	/* TODO: Should kernel panic here? */
>   	pci_info(bridge, "device recovery failed\n");
>   
>   	return status;
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


