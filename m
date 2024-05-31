Return-Path: <linux-pci+bounces-8137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118958D68AF
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 20:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428791C2187D
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6B17BB01;
	Fri, 31 May 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DS1iYW3E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632202E63B;
	Fri, 31 May 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178772; cv=none; b=C7dZfSReod1C6TKn7jQahOUSUE9B3ugjInTrwX+BuIn8xU3nTG+C72Y7x7FQusX96VY0Ai4B5AkA8A3B7p/BXsq8qi6A+VaoOYC2ooP/u6KHf7WLSv+Kq6CNfW90mE39lbwF1oP3xhwmnDotqIxcRyzwleAr5X0Ly0vM1YweQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178772; c=relaxed/simple;
	bh=lZCtvF8bQRqrwqhWq8+XPFYIlYNhxCEhkjGaOrFVAbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0vj5x/wiAGHr4TxNM7ae70o0LBL9DfJqUZ+leglLpAR8wobEtOD4vS1+8PdsVO0v/ZcDl14JbP7EsFR71IsDNZzwWyNG/nir8nDnjjd5IAIZIdLWq6sd3nPoulDI5FXpGzOssfsEq4j3az3s66OjDpStMwgfkHAqOLkMjlaG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DS1iYW3E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717178771; x=1748714771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lZCtvF8bQRqrwqhWq8+XPFYIlYNhxCEhkjGaOrFVAbQ=;
  b=DS1iYW3EoLxKbzs7i0rnC8J7jxG8DktSlx9vhKvXvsl7gxa7amy1Gd7j
   0f4xps24Mk/5vx8Gu95aUZ9E6RdcA22kD2RI8q3ZWJpAy2KB31VeX0o9Q
   s6PAGZtlWfp7Ip6A7om9TAxfvlyvIzzRnBvDBCV8HNscM98et+g5Sjgxi
   lBq+vZwOTL5mu2I4lLaEsaootYPbeZpVJtxKMXUmKGw1a2Mdckx8lEGhg
   9Km86yfhQwIZEXzHat9ZQJPFuGoGt24S7JKiidz6DDKAMXF/hHyVJ774E
   5V0zFkLFts3YLl/DU/xm1P4LNtzsrHj6uc57VwzVyn1Zzn7nysqxcAHbN
   g==;
X-CSE-ConnectionGUID: qrZ8NPYiT12F1Rz6IDJhQw==
X-CSE-MsgGUID: AU3Z+MnLQ1+5oEKul2LcQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13603282"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13603282"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:06:10 -0700
X-CSE-ConnectionGUID: nu6jDm+xQ1OD17Mz7pfHcA==
X-CSE-MsgGUID: J+uyWzaORDG7TpdBgnmCRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36181617"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.72]) ([10.125.108.72])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:06:10 -0700
Message-ID: <5de124d1-8c53-45c7-ab4b-17282c56d1b1@intel.com>
Date: Fri, 31 May 2024 11:06:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: Warn on missing cfg_access_lock during
 secondary bus reset
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
 <171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 6:04 PM, Dan Williams wrote:
> The recent adventure with adding lockdep tracking for cfg_access_lock,
> while it yielded many false positives [1], it did catch a true positive in
> the pci_reset_bus() path [2].
> 
> So, while lockdep is difficult to deploy, open coding a check that
> cfg_access_lock is held during the reset is feasible.
> 
> While this does not offer a full backtrace, it should be sufficient to
> implicate the caller of pci_bridge_secondary_bus_reset() as a path that
> needs investigation.
> 
> Link: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html [1]
> Link: http://lore.kernel.org/r/cfb50601-5d2a-4676-a958-1bd3f1b06654@intel.com [2]
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pci.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35fb1f17a589..8df32a3a0979 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4883,6 +4883,9 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>   */
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
> +	if (!dev->block_cfg_access)
> +		pci_warn_once(dev, "unlocked secondary bus reset via: %pS\n",
> +			      __builtin_return_address(0));
>  	pcibios_reset_secondary_bus(dev);
>  
>  	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
> 

