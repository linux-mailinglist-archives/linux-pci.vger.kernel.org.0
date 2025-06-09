Return-Path: <linux-pci+bounces-29266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D22AD2961
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 00:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3471890AEA
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F561FECC3;
	Mon,  9 Jun 2025 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqnioY//"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D4194C96;
	Mon,  9 Jun 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749508386; cv=none; b=XG53fCFSvS6jFSjoLpn78ma+SsBBADip6Z2FaK+uuZA7phO8Bu3Y92yTm7BF3f7L6zGGaRFhhMkyxoyi3LnC7l5P/JsCXjpf88Ea4QUSigN3NAzrHKn90hg0QO+LcQMx586J4OP9T+Q8PmKAVaG/uCaXj7E2MVXniwS5yGlP86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749508386; c=relaxed/simple;
	bh=B5RTP5TEqx/43XoEAFJ63qL0/SGvM6bAn37nrX3ZvJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og4y4peM+fWmUClDfPVHgVlwOOKtakTTPeo7Qbk0olo7ugB4YDWWISVfB1QPsDRkN5iBKTY1tOQG5N/p9wAlTRnNRLtmbTfb3KOm+Aec8h3HbYQVsoZFZMlDONJZpDXkP3q9HqJ9AVmCUHGLFO5wlSSE4yY9UYqv67aEc+5sfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqnioY//; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749508386; x=1781044386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B5RTP5TEqx/43XoEAFJ63qL0/SGvM6bAn37nrX3ZvJQ=;
  b=KqnioY//b8V4OE1rxV0p6ha3Pi+x7BCFyj5X/S3aKE1qCDacNEbf/dRa
   s0DnA2YaPT+pRwmm0OQd2u1zqrZdk/y829bHvHUrxKrrnrzatE9GMhXEY
   JCsFNPDw73hhgjcaEIJYQB+Rf/Sk/ywg4kf0tzAxH7wX5uk2MxSZsJP1j
   w8ArFxY74kYTpUZVhNsiBoA4VcAGeKeAh9TngpA6MwcwIkNrLX/F8Lust
   g9gUnXw3u9pJZq3wwILJ9N1vppNATmao145rlVNbrDefZdWQceMmkhTK/
   SfsP9x1UiamKGrWVR0pzDcqKHdKBYzDlQoHVXnGUe1orvLSaSWiu+REYy
   g==;
X-CSE-ConnectionGUID: v9IpdkDGQFKrtJBRLFMDFA==
X-CSE-MsgGUID: 6wq+su7lQ5ihfQUto1ed5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51311540"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51311540"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 15:33:05 -0700
X-CSE-ConnectionGUID: G6iSwhMsQeS6WC/DZEsJqg==
X-CSE-MsgGUID: QC2jJJg+RlCEgXHXUxYifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="147158328"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 15:33:04 -0700
Received: from [10.124.223.148] (unknown [10.124.223.148])
	by linux.intel.com (Postfix) with ESMTP id B08DB20B5736;
	Mon,  9 Jun 2025 15:33:03 -0700 (PDT)
Message-ID: <5cf7045f-f199-492b-9e4d-8de9664a585d@linux.intel.com>
Date: Mon, 9 Jun 2025 15:33:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is
 enabled
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Biggers <ebiggers@kernel.org>
References: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/7/25 8:33 PM, Manivannan Sadhasivam wrote:
> Otherwise, the following build error will happen for CONFIG_DEBUG_FS=n &&
> CONFIG_PCIE_PTM=y.
>
>      drivers/pci/pcie/ptm.c:498:25: error: redefinition of 'pcie_ptm_create_debugfs'
>        498 | struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
>            |                         ^
>      ./include/linux/pci.h:1915:2: note: previous definition is here
>       1915 | *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
>            |  ^
>      drivers/pci/pcie/ptm.c:546:6: error: redefinition of 'pcie_ptm_destroy_debugfs'
>        546 | void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
>            |      ^
>      ./include/linux/pci.h:1918:1: note: previous definition is here
>       1918 | pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
>            |
>
> Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20250607025506.GA16607@sol
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>   drivers/pci/pcie/ptm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index ee5f615a9023..4bd73f038ffb 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -254,6 +254,7 @@ bool pcie_ptm_enabled(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL(pcie_ptm_enabled);
>   
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
>   static ssize_t context_update_write(struct file *file, const char __user *ubuf,
>   			     size_t count, loff_t *ppos)
>   {
> @@ -552,3 +553,4 @@ void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
>   	debugfs_remove_recursive(ptm_debugfs->debugfs);
>   }
>   EXPORT_SYMBOL_GPL(pcie_ptm_destroy_debugfs);
> +#endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


