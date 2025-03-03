Return-Path: <linux-pci+bounces-22792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACFA4CD30
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF25188C5D9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7422F3AB;
	Mon,  3 Mar 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzekS9eI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205F1EA7CB;
	Mon,  3 Mar 2025 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036118; cv=none; b=i9VZ6nEbemVuf30AGBM5oo2gpBR6TiU0aBptormdM8iyqEvj+ziSuLo4Whf2KqNQIlhVrhiAmadEhyQtEvvEMPFtKPZl+DTetAtd56lxfKyWGkWSkVaIXGykQxIeHgQ1RpFl0zoa0OTSrzXX4/5oSHLmqVNOdJOsV1aQGITIlmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036118; c=relaxed/simple;
	bh=Q/K/8K9/IVMQ+BwkrMtXHGOTssfEL1BOg/FvXQrYS5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2yClBi5t62w76b69Ft1QhOgxRXMN3cTqrglon6/uDVSUnUrIqS0ZDMcAI5isu6jyEtEoK/Yeouqo9xLj2YK39ZRH49GkJGpA7208xxtCU4qbuFbFBrRfyJdp/SjqAiFUa4XOOIpO5unVB/CXup7WG0chJmctC4DkQwzlFcLLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzekS9eI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741036116; x=1772572116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q/K/8K9/IVMQ+BwkrMtXHGOTssfEL1BOg/FvXQrYS5s=;
  b=lzekS9eIo0pdjsRHxg868P2AReSf6FM1DV1Ah0wE3GZ8PNUL+1LC0ApZ
   gl+fNYG+wCaUfyhkodRHEsN1dLJoxBn7bQetS+gUqXAYqnzWjxddsPpC8
   SyABBgapEroUl7WYNhM8FpQbQcB5X1Hzm84xgHpG817k2a82SkDl7ajit
   YuEx4wKR/BWCCn6jHwPJQ4ERM+DFzbb0EvP/b+KyPIHBsy6fj97eRnpyC
   3M7fUT+Wyb5+g4fpHf5oQeJqg1CZ72i5sixyynW7UFuG2gczjdM8CP4o3
   dKP5jWjTNxBWVYSs2dOgQYdlGB9ZHD9OQEx7lH2fn0AZ1ntn5eOd9wbnc
   w==;
X-CSE-ConnectionGUID: dinN5mpxSNSvGKWbjUFODQ==
X-CSE-MsgGUID: bDoVdQN2SwOQSDl5J3RDig==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41175041"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41175041"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:08:35 -0800
X-CSE-ConnectionGUID: mYy76fXAS4uq1Fpy/wETQg==
X-CSE-MsgGUID: cA2rMsFiS8eM1Gl6IP+nGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118643569"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.29]) ([10.125.109.29])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:08:34 -0800
Message-ID: <df490330-287c-410d-a041-3290ab38e9e7@intel.com>
Date: Mon, 3 Mar 2025 14:08:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Log debug messages about reset method
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Todd Kjos <tkjos@google.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250303204220.197172-1-helgaas@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250303204220.197172-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/25 1:42 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Log pci_dbg() messages about the reset methods we attempt and any errors
> (-ENOTTY means "try the next method").
> 
> Set CONFIG_DYNAMIC_DEBUG=y and enable by booting with
> dyndbg="file drivers/pci/* +p" or enable at runtime:
> 
>   # echo "file drivers/pci/* +p" > /sys/kernel/debug/dynamic_debug/control
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..3d13bb8e5c53 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5230,6 +5230,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  int __pci_reset_function_locked(struct pci_dev *dev)
>  {
>  	int i, m, rc;
> +	const struct pci_reset_fn_method *method;
>  
>  	might_sleep();
>  
> @@ -5246,9 +5247,13 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  		if (!m)
>  			return -ENOTTY;
>  
> -		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_DO_RESET);
> +		method = &pci_reset_fn_methods[m];
> +		pci_dbg(dev, "reset via %s\n", method->name);
> +		rc = method->reset_fn(dev, PCI_RESET_DO_RESET);
>  		if (!rc)
>  			return 0;
> +
> +		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
>  		if (rc != -ENOTTY)
>  			return rc;
>  	}


