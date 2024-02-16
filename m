Return-Path: <linux-pci+bounces-3618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84BD85849B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 18:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690A01F221DF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C3133401;
	Fri, 16 Feb 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfQGC+s2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14A1332A0;
	Fri, 16 Feb 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106023; cv=none; b=NneeMsP7oVQED+T6yzhJedQgcPaAx+XJ3vwesWMqRFi7zY1mQ2G4MWTihWJcu5jIu+MNqe45olUvtpVG2DvUtAu48xng9Nw8cwujttc8q9E61JY1VNMvKpdiNwFguBkmBozgrk4Ax+mX2KDucWgRZfFQgYgZ9a5B301IQ2qKPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106023; c=relaxed/simple;
	bh=JPbrPrP1ijVSXKNmyURydafvZaHC6pe91ZQgbIkuRYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyXyfDiKRunjfMw/gYuFaVDB4HX3258WwCdwnp/xlHnU25rgwxiTKusG7n7QMs/cKltKGNqo4BR3jyrywe02bnDXPSsghIu4ALlmk8nTNrFB5U59tmwJmfIgeSB4s4VucwJv0fTGqfK6PRh3IJHCdrs81C26bhOUqheNcvxBMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfQGC+s2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708106022; x=1739642022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JPbrPrP1ijVSXKNmyURydafvZaHC6pe91ZQgbIkuRYc=;
  b=cfQGC+s2whq7zOLn+SMUOtrmFy7nn9LZb4H0T3laC5F/x/WtTZKtUK7X
   uGIeXnmtNRYclVQiX6jxW8iKD4Nhmb5HlBskLdvGqI/0l6gwz8BjFr8WM
   ZmRAem2sRAK19oy+zW+mbQaRl9aN5XlEGrIdcmtAwX2ZHAUSzHRfY0Ocz
   pxBpQvYKwJfKtIr9chZp0kexg2HOjVyBj9Q+Q4rIr8H0mwnY/NelFhRHc
   WA3EEKaQl0es+jtjPQ2wWwLPt38EfqLppXefIwILZiJrBL6H3A1UBBmLv
   PoeKF0rI1u3Wl5L3dXVDJefohW15ritt3OTNNXfNBmEBcgnRiWLRvpW0V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6018250"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6018250"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:53:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4180210"
Received: from bfraley-mobl.amr.corp.intel.com (HELO [10.209.109.53]) ([10.209.109.53])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:53:40 -0800
Message-ID: <93c91582-ae3b-47a6-98f8-d3a7cf74313e@linux.intel.com>
Date: Fri, 16 Feb 2024 09:53:39 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Increase maximum PCIe physical function number to
 7 for non-ARI devices
Content-Language: en-US
To: Bean Huo <beanhuo@iokpp.de>, bhelgaas@google.com, schnelle@linux.ibm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bean Huo <beanhuo@micron.com>
References: <20240216172449.8052-1-beanhuo@iokpp.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240216172449.8052-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/16/24 9:24 AM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
>
> The PCIe specification allows up to 8 Physical Functions (PFs) per endpoint
> when ARI (Alternative Routing-ID Interpretation) is not supported. Previously,
> our implementation erroneously limited the maximum number of PFs to 7 for
> endpoints without ARI support.
Can you include the spec section and revision details?

I assume it is section "Alternative Routing-ID Interpretation"
>
> This patch corrects the maximum PF count to adhere to the PCIe specification
> by allowing up to 8 PFs on non-ARI endpoints. This change ensures better
> compliance with the standard and improves compatibility with devices relying
> on this specification.
>
> This adjustment was verified against the PCIe spec (reference specific
> sections if applicable) and tested with a range of PCIe devices not supporting
> ARI to ensure no regressions in functionality.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---

Since it is a bug fix, I think you need a Fixes: tag as well.

>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ed6b7f48736a..8c3d0f63bc13 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2630,7 +2630,8 @@ static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>  	if (pci_ari_enabled(bus))
>  		return next_ari_fn(bus, dev, fn);
>  
> -	if (fn >= 7)
> +	/* If EP does not support ARI, the maximum number of functions should be 7 */
> +	if (fn > 7)
>  		return -ENODEV;
>  	/* only multifunction devices may have more functions */
>  	if (dev && !dev->multifunction)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


