Return-Path: <linux-pci+bounces-25765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC53A8750F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 02:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCE117010D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 00:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CF4C79;
	Mon, 14 Apr 2025 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3pmyhdz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862642563;
	Mon, 14 Apr 2025 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744591614; cv=none; b=HaB5U1Yns6HkGBP2px5fyTE1yfmX5hLbMsSaiIaytOSrlQdJdWpUGBbKuwgqqR5fY7RMh3OgcfUT63ziFbtn13ZCm1qiCzovEOEKzW9hFyQ3TDt4iIpHPvKBs78vjnSIRWWnufUtSf7fyjGRuimu1BId2s0h1ZubeKoIxKoCboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744591614; c=relaxed/simple;
	bh=zo8VbcTtKjg+2QfYu1HxWcTa83g4OVSzY3dNm0+jang=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUf6B4cH7iRfnmYlmos81Qm61D/eRbFk9eRF7EhE475MfYkdvGznwcD0DS4YaSdvRtKbarBc3Jltm+u56LmYckuHSNX6sl3qrDuuG93fgqHCz0IStydkE6hX3K9evWos++f/i2DuUubUgOxawutr+Q4bFKKO+3Y8ijMBRAno2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3pmyhdz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744591613; x=1776127613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zo8VbcTtKjg+2QfYu1HxWcTa83g4OVSzY3dNm0+jang=;
  b=O3pmyhdzpMhzDeCPeRHgxhC60zTP6xETjFfjbkBu9hdrgMGPn6ZlDLJr
   xGxYrzJPUP0tv8JN8banShae0o0fHZGHqsqt+rQUUnE8u6OTNd9eE41Vq
   39giFrUCIODuBfNeUfluZkdjZZj3MP/d2ONmX1vf6+OY70r4H0OAfvm8U
   cqfr4pxY8A2gV3u9zBNfgJtz7LZXHei48HXUtX+wdDXgtkDtkDsChQIEt
   zP6gwyakWRbsL9mCkQCFmDgvElD0WM6sYya6urmkLysf61uqzXKTDgL0h
   EBaxIoWWXofiLCrXF0gn58NcGIHkqgeHRzY6+ZQgUbaTTGIpERJhapnM7
   g==;
X-CSE-ConnectionGUID: vAnPK8MbSNGBwkBoWY1cQA==
X-CSE-MsgGUID: j+HOge8WQPCNf8rU9lsPSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57033876"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="57033876"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 17:46:52 -0700
X-CSE-ConnectionGUID: 7a02Nys4QWiyFXJhHAUGEg==
X-CSE-MsgGUID: Q0XrIfQgTvmgmjDWe3tANA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="152858549"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO [10.124.222.22]) ([10.124.222.22])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 17:46:51 -0700
Message-ID: <f435b1c3-4f97-4898-9533-3a83f74cc14a@linux.intel.com>
Date: Sun, 13 Apr 2025 17:46:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: fix the printed delay amount in info print
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, bhelgaas@google.com,
 mika.westerberg@linux.intel.com, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: alistair.francis@wdc.com, wilfred.mallawa@wdc.com, dlemoal@kernel.org,
 cassel@kernel.org
References: <20250414001505.21243-2-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250414001505.21243-2-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/13/25 5:15 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>
> Print the delay amount that pcie_wait_for_link_delay() is invoked with
> instead of the hardcoded 1000ms value in the debug info print.
>
> Fixes: 7b3ba09febf4 ("PCI/PM: Shorten pci_bridge_wait_for_secondary_bus() wait time for slow links")
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..8139b70cafa9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4935,7 +4935,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>   		delay);
>   	if (!pcie_wait_for_link_delay(dev, true, delay)) {
>   		/* Did not train, no need to wait any further */
> -		pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
> +		pci_info(dev, "Data Link Layer Link Active not set in %d msec\n", delay);
>   		return -ENOTTY;
>   	}
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


