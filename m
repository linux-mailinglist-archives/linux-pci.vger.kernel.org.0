Return-Path: <linux-pci+bounces-28167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E5ABE6F9
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 00:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AE3161040
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664A25E81C;
	Tue, 20 May 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4CLArB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25B1E7C2E;
	Tue, 20 May 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780179; cv=none; b=dHd7qVddsAhFwm2wbszZbcS4x3A+rm7eROOLqi9Vg3NRXfJEJcWpGP8NrATVXXTA404w49MZq/47VMHsKu0FRICiFysmquLOG93UnCgclBIW52teIbN9GGucyO4ulqqdkOolGla7xvlX27SX0a+D/agR/AGhKtSp3Oc8yfPvL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780179; c=relaxed/simple;
	bh=wgWpekly3nOQnzx0glseL92nX1qAz0Bb6kjWvhZ76XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Um461PSX4d8ZIE0zzM6hRQu2nsC1lqiaD6ftsGgkpyzXIdvHI4RY7Mb6u/AEhj4roYEu5RB2Gq9obJzyMjBKzJNpxZALzV0GsuYTxxxOEePIr76VzJ8no7CsVMCa1ffNCPEi7EnTTMHkqAKKkPOG8en0jlKLKA6u0ajYJw+7b1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4CLArB5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747780178; x=1779316178;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wgWpekly3nOQnzx0glseL92nX1qAz0Bb6kjWvhZ76XI=;
  b=C4CLArB5dJEHDx8+bwvT9spdEbpVJbCL0622gjKuP0Xdu72nWcg5cPDN
   eobNVVWq4iKHZfuZQqBe06viEmx8JFrX2R6/GC/49K9s5R1pXHZvwF3tq
   Ih4yLCE8nNLMb0Ta6LFH0vrq9GsZD/yNAPSMkpONUVVptOhSUpPL/89vy
   GCxuRTwzM2YsKPFTVlMhCPsC8M8VA4Y094p39GIVOEx6no95MLnsE1P1B
   sL51IfiB2FQTexAIevWipktUQroB94K55jbxtEiXuqVedKwUEWlAL1DXy
   rYfFNZb9E/ubQqqpr4MczEoX+fmq06ToxS6prTJAFugE2s72SYO/Xo4au
   A==;
X-CSE-ConnectionGUID: TuObwucgRdiG4Mjukwh5Wg==
X-CSE-MsgGUID: 4nupyqZYRmizlkHVY+mOSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="52363385"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="52363385"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:29:37 -0700
X-CSE-ConnectionGUID: /+ByA43/TeSBzowsjH/SMQ==
X-CSE-MsgGUID: TGAgNdesQjObaoTcB0oDlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="163108869"
Received: from iweiny-desk3.amr.corp.intel.com (HELO [10.124.222.89]) ([10.124.222.89])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 15:29:36 -0700
Message-ID: <0582ea17-186a-4910-871a-77f2b51e3b1e@linux.intel.com>
Date: Tue, 20 May 2025 15:29:35 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/17] PCI/AER: Simplify pci_print_aer()
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
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
 <20250520215047.1350603-10-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250520215047.1350603-10-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/20/25 2:50 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Simplify pci_print_aer() by initializing the struct aer_err_info "info"
> with a designated initializer list (it was previously initialized with
> memset()) and using pci_name().
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e6693f910a23..d845079429f0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -765,7 +765,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   {
>   	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
> -	struct aer_err_info info;
> +	struct aer_err_info info = {
> +		.severity = aer_severity,
> +		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
> +	};
>   
>   	if (aer_severity == AER_CORRECTABLE) {
>   		status = aer->cor_status;
> @@ -776,14 +779,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>   	}
>   
> -	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> -	agent = AER_GET_AGENT(aer_severity, status);
> -
> -	memset(&info, 0, sizeof(info));
> -	info.severity = aer_severity;
>   	info.status = status;
>   	info.mask = mask;
> -	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> +
> +	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> +	agent = AER_GET_AGENT(aer_severity, status);
>   
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info);
> @@ -797,7 +797,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>   
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +	trace_aer_event(pci_name(dev), (status & ~mask),
>   			aer_severity, tlp_header_valid, &aer->header_log);
>   }
>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


