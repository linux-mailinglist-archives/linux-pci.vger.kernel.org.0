Return-Path: <linux-pci+bounces-24155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D633FA6984B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 19:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DA019C241A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60586184524;
	Wed, 19 Mar 2025 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7eZnJjG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B414AD29
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410024; cv=none; b=JB9bA+Vnn7EeqySs1uJtapSqUx9VI2aedZU2llcnActQgY9g9URjEBkPIr1J8b06xUmc4uwijCWa2RK7R5HOffVvdPLnr7f/6VJX2ZbEyPKEn4EaQBj4ekA6ZNQVNp3oGI3byJsgDCjp5jHWXCfWZYgBFMNVB3rZFzH9FccWNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410024; c=relaxed/simple;
	bh=nUOBL473t1UiwAh22Jrh+3gC83V0sP7DrJsz4diK4y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=onT5Filo7IYWh43KVKui6zG5QBsnwRtZc7EO0uX8DZBhMVFYIYb35I16cOd65Fwo8JpFip+Wei0ZZVAq8IuLZylzCW4YZFPXVSagYrhY2ebgiNF8WuDxkrLmndfNLWmp279+byzbuhzFpe5Ue7kCP07Cn9SLNlwovGhR5zxvdxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7eZnJjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8738FC4CEE4;
	Wed, 19 Mar 2025 18:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742410023;
	bh=nUOBL473t1UiwAh22Jrh+3gC83V0sP7DrJsz4diK4y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r7eZnJjGQcqBwCs4HToeHHilbggU8UElCAgeXis18g5SNMhk8YUXsJPUKZG27/17K
	 U1d6FHW1JuUQjKsZ3tLv3adxefWwo+1h80oWa18HPm+k3edrRgL+zMnEu/Bbw+om1n
	 GWx14XxsEBJzfnUOfq5Nwv91bDSDmNESf2zj6TxwPQrHLBlcrTDS5jae2Y0Wvkee7m
	 RavLFSz3XBrfspVYXm2LbJSx14pberJMSksCw6bm2kYIzRKrmLmI9Fvz9j22m/AK1p
	 heFh0s9t3e3HLwAioMqeVn9AZhW/fTNuXNISJFtNBhUrt8tHU4AaRiuy0inPywL5vg
	 PAJJFSXSbvUaw==
Date: Wed, 19 Mar 2025 13:47:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <Terry.bowman@amd.com>
Subject: Re: [PATCH v3 5/8] PCI/AER: Introduce ratelimit for error logs
Message-ID: <20250319184702.GA1051253@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319084050.366718-6-pandoh@google.com>

On Wed, Mar 19, 2025 at 01:40:46AM -0700, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and uncorrectable
> errors that use the kernel defaults (10 per 5s).
> 
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
> while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
> true count of 11.

I think this is really on the right track.  A few minor comments
below.

> @@ -697,6 +711,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>  {
>  	int layer, agent;
>  	int id = pci_dev_id(dev);
> +	struct ratelimit_state *ratelimit;
>  
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -704,6 +719,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>  		goto out;
>  	}
>  
> +	if (info->severity == AER_CORRECTABLE)
> +		ratelimit = &dev->aer_report->cor_log_ratelimit;
> +	else
> +		ratelimit = &dev->aer_report->uncor_log_ratelimit;
> +
> +	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +			info->severity, info->tlp_header_valid, &info->tlp);
> +
> +	if (!__ratelimit(ratelimit))
> +		return;

  - I think the ratelimit lookup and __ratelimit() call should be
    together since there's no need for trace_aer_event() to be in the
    middle.

  - The lookup and __ratelimit() calls are repeated and are probably
    worth factoring out into something like this:

      static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)

  - Previously we *always* called trace_aer_event(), but now we don't
    in the !info->status case.  Maybe an unintentional change?  I
    think we should call trace_aer_event() always, or change that in a
    separate patch if we need to.  This would always have been simpler
    if trace_aer_event() had been the very first thing in the
    function.

  - The !info->status case message is not rate-limited.  Seems like
    maybe it should be?

>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> @@ -722,21 +748,33 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>  out:
>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>  		pci_err(dev, "  Error of this Agent is reported first\n");
> -
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> -			info->severity, info->tlp_header_valid, &info->tlp);
>  }

