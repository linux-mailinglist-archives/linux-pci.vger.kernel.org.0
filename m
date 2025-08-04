Return-Path: <linux-pci+bounces-33372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FDB1A3DE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BF3A8E5E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0028260563;
	Mon,  4 Aug 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+xRMoLx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C926CE10;
	Mon,  4 Aug 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315509; cv=none; b=aIUAnZEMfgz2EkxDtPIwwAD91TN7oLYtsa5OrpaT5wllWHjCxSJbgwOARH6EmWlwnusRyx6I9WnK3WqxtWBLXWM75ysw86OGuLj/bq8CIQx2i8wxiP1yYaiv5A+VKYxlFVcrcdOPW3+mEle2K1xzi0j9BnvgYdw3H4GKIAx3ov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315509; c=relaxed/simple;
	bh=wAwo3NXJtK1iLZDeAPP1KYlXNSvm8s8ML4jwwp6cXKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2ZtPBTLU4lbH0mlVA8eGPuehU8qGWswa35UiO8xMLQQO4AetKSLHVp4OZCwqCJzQrD5dXDz9jkyoVqxBZgPx1WBLSnz9cGNCTMBoAfg/P2pJEFsuS3Hvuzw8rjGumWjzvwP9CMuT7r13tjGmjS2YoqQ3D8FAwr8wrYHeF+U5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+xRMoLx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754315508; x=1785851508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wAwo3NXJtK1iLZDeAPP1KYlXNSvm8s8ML4jwwp6cXKs=;
  b=b+xRMoLxAaTr6iCY/T+4PNxwtEO1rbrwRhPY6Yf+PueavWZHtCcXBrui
   z46dSKj/Q0c5w6g9ozLCFgC2h10tOaDg4KxZUzDh20qyBTjcGZIpJzGjg
   f1FighVKjTMd5fp2kW5QhtEGnHrhhl9A2kY5u1GTE/sQvx4JBFvFjkO65
   V1wfl+1M0bKCzg1VdgD/ml9j/6NZzdAyO8xjhCoAyM3UATnTSQDZ9hei7
   +rbfLGzeNbJEyBW2gJlmzSB58k7TY9Kn76bxveflqjmKkN22iC1efrl/q
   w7P6j7378l2HSlpmXCjZTQV9+Ii5tcf7sbNnNxNe/FBq2QEiEokHz44Vq
   w==;
X-CSE-ConnectionGUID: p7ztlKNJTTK2aD9UmE3y3g==
X-CSE-MsgGUID: 8iDxkyQSRxixRPHq6zPqXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56448966"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56448966"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 06:50:50 -0700
X-CSE-ConnectionGUID: DcabsRD4Tm63MNlw66PDaQ==
X-CSE-MsgGUID: rjakUT2wQfqFDVRFT7qd+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164494502"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 06:50:48 -0700
Received: from [10.124.223.90] (unknown [10.124.223.90])
	by linux.intel.com (Postfix) with ESMTP id 02EB520B571C;
	Mon,  4 Aug 2025 06:50:30 -0700 (PDT)
Message-ID: <9cd9f4cf-72ab-40f1-9ead-3e6807b4d474@linux.intel.com>
Date: Mon, 4 Aug 2025 06:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
To: Breno Leitao <leitao@debian.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jon Pan-Doh <pandoh@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/4/25 2:17 AM, Breno Leitao wrote:
> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> does not rate limit, given this is fatal.

Why not add it to pci_print_aer() ?

>
> This prevents a kernel crash triggered by dereferencing a NULL pointer
> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> which already performs this NULL check.

Is this happening during the kernel boot ? What is the frequency and steps
to reproduce? I am curious about why pci_print_aer() is called for a PCI device
without aer_info. Not aer_info means, that particular device is already released
or in the process of release (pci_release_dev()). Is this triggered by using a stale
pci_dev pointer?

>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> ---
>   drivers/pci/pcie/aer.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac661883672..b5f96fde4dcda 100644
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
> base-commit: 89748acdf226fd1a8775ff6fa2703f8412b286c8
> change-id: 20250801-aer_crash_2-b21cc2ef0d00
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


