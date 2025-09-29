Return-Path: <linux-pci+bounces-37211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E388CBA9C27
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A095A178A7F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC9E2EACF0;
	Mon, 29 Sep 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXvpWG2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A722306B08;
	Mon, 29 Sep 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158607; cv=none; b=Y8665Jp+s+/kmeac5d6vAR7X8nwAEswGXx8NiMCacfC2zhWxC9sWhfym/GQ1pc1jhLTfjhUQajnptITl+i6JIDivOuLV8j0+0+vuSSHfKhfRleEjeWgQcWL7SjwUgQKnqxYf3e+Ew3zy9aaw5ppEFSATju+9Hx12pAMaPev7wBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158607; c=relaxed/simple;
	bh=n5QdAwV9GL/hI15XCi4gHWJImJrNkPzAtoinWYP2mKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uerAhwm8Jo02T+NrAZEq1ICxUbgLviEr5mqAJ6siqvPrZ3MlsUEpIriQJ2jYDXhVFGBt1Poej2ZP9bIS/6dcyMU2+VbTtAxAKW9Enp8v2/D0GDVnrTeOq3BX5FAuYbl2Gwamlk+q5nxiAADTg/uIpm1F6bpf8LRxgqXMjuOM3CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXvpWG2x; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759158606; x=1790694606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n5QdAwV9GL/hI15XCi4gHWJImJrNkPzAtoinWYP2mKw=;
  b=OXvpWG2xuXQ5Fzt6BQeCGZQxMm6I6kK/h4pSnXyJtFR981csfNAVIDDr
   n+2uuQJMwC/9I9N6pQ5N22nnlTugQ6eh+XVXGnUErYKRFxEnYH075abAe
   1EFoTH6Qp921LS5n4vJ9KUPAAygEOTX9VB1867rwhvlzLPvvAoZdqrmQG
   UxPCOFFFB5ySvFlpEAwQzSSgKKyCtFRcDzWb7jmP3ZFOfmBY68SidR24R
   i3qPCOkTI0bBAlVplRCj/8YSRduYkVmEDbjKqR/LFtlfgCIfwhwehEoFh
   IfY/LJgnDomphVG/Tv6XrwuPo2u9ByvHMz1o7miU9WGKCEmnW7MuOVgfC
   Q==;
X-CSE-ConnectionGUID: OvI0mQ4ETsedd0SBcQtf6Q==
X-CSE-MsgGUID: KNdx7UbqReSBqBDmFiYvGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65217339"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65217339"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 08:10:05 -0700
X-CSE-ConnectionGUID: /YEP9TeGQ/StrMSbFoGWVA==
X-CSE-MsgGUID: KANyAnmdQYurhc68KUp4Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182544766"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 08:10:04 -0700
Received: from [10.124.221.178] (unknown [10.124.221.178])
	by linux.intel.com (Postfix) with ESMTP id 8817020B5713;
	Mon, 29 Sep 2025 08:10:03 -0700 (PDT)
Message-ID: <7b5c1235-df92-4f18-936c-3d7c0d3a6cb3@linux.intel.com>
Date: Mon, 29 Sep 2025 08:10:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
To: Breno Leitao <leitao@debian.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/29/25 2:15 AM, Breno Leitao wrote:
> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> does not rate limit, given this is fatal.
>
> This prevents a kernel crash triggered by dereferencing a NULL pointer
> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> which already performs this NULL check.
>
> Cc: stable@vger.kernel.org
> Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> - This problem is still happening in upstream, and unfortunately no action
>    was done in the previous discussion.
> - Link to previous post:
>    https://lore.kernel.org/r/20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org
> ---

Although we haven't identified the path that triggers this issue, adding this check is harmless.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>



>   drivers/pci/pcie/aer.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d7167..55abc5e17b8b1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -786,6 +786,9 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   
>   static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
>   {
> +	if (!dev->aer_info)
> +		return 1;
> +
>   	switch (severity) {
>   	case AER_NONFATAL:
>   		return __ratelimit(&dev->aer_info->nonfatal_ratelimit);
>
> ---
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> change-id: 20250801-aer_crash_2-b21cc2ef0d00
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


