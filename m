Return-Path: <linux-pci+bounces-41998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8BC82D3C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 00:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CA93AC4FF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 23:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7A2D0607;
	Mon, 24 Nov 2025 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoSre1+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7482777E0;
	Mon, 24 Nov 2025 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027573; cv=none; b=tOD2Vdq58h9KFSd54iPo3tUXibfriz+50s1QiCIbMe547Dc5rbNGOmzdHSAGZcki+xxtn1AV2SFG8LcP+U+8eHbqbVQpengfzbEI1ybE1dVS3qpRBLysrlGT4PhCiMfFQN3/D1iNbpNB54z/HQw1/AeHH4VN+VGXPVLpoo/OIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027573; c=relaxed/simple;
	bh=ES5aQYT6ve9fmwHttXapFqTQXlDFpic7nVN1uIgkOws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hRf9BkU43iyXcqIGG0Oy0NGOc1X/lwtFFQPIk17NSxKkLpuLEFeRtp/oxhOfAz9Sx4syJc+TIDlv3VxTDEufQ0325v1n/0FxLcPxuvrbKFxTY32v7vfMw7VZT2RoGGXA6rBX4L3+DeYNAWS5KMSSJCkBwCZOCooVfqEbPVmYtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoSre1+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E96FC4CEF1;
	Mon, 24 Nov 2025 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764027572;
	bh=ES5aQYT6ve9fmwHttXapFqTQXlDFpic7nVN1uIgkOws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VoSre1+eDk9kmhPwZZGpSBcsgHO/66dNw5XF8kMq3Zm7sKuBUYsi3M5ufhHQyyczn
	 SSmUtLld5eSylyDUqsb/9pK1P3C7fZlXE9Tu6a11mHHOPQIrrmv/oDF6HrwHQhLPRy
	 AsTBXVk75b4llJjnR8IX39YGYf+1cEKSYOBAj1pTGknrzohWSi4g8G2+voG13zBA2H
	 kp+3Af3Myc2xce0lapzkKO1x37vTsBsSro5Hi+tOzp6yHl3vhUkeWKA7Khe8ubC9G5
	 4woA+AvT48urE72lmDt/CSp7Mja//j8w4KB6o4ybnG9H1TiHcS6RBCrA8g89DWvwsZ
	 rTtdN2benwGng==
Date: Mon, 24 Nov 2025 17:39:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 1/1] PCI: Check pci_rebar_size_supported() input
Message-ID: <20251124233931.GA2725583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124153740.2995-1-ilpo.jarvinen@linux.intel.com>

On Mon, Nov 24, 2025 at 05:37:40PM +0200, Ilpo Järvinen wrote:
> According to Dan Carpenter, smatch detects issue with size parameter
> given to pci_rebar_size_supported():
> 
>   drivers/pci/rebar.c:142 pci_rebar_size_supported()
>   error: undefined (user controlled) shift '(((1))) << size'
> 
>   The problem is this call tree:
>   __resource_resize_store() <- takes an unsigned long from the user
>      -> pci_resize_resource() <- truncates it to int
>         -> pci_rebar_size_supported()
> 
> The string input to __resource_resize_store() is to unsigned long and
> then passed to pci_resize_resource(). There could be similar problems
> also with the values coming from GPU drivers.
> 
> Add 'size' validation to pci_rebar_size_supported().
> 
> There seems to be no SZ_128T prior to this so add one to be able to
> specify the largest size supported by the kernel (PCIe r7.0 spec
> already defines sizes even beyond 128TB but kernel does not yet support
> them).
> 
> The issue looks older than the introduction of
> pci_rebar_size_supported() in the commit bb1fabd0d94e ("PCI: Add
> pci_rebar_size_supported() helper").
> 
> It would be also nice to convert 'size' unsigned too everywhere, maybe
> even u8 but that is left as further work.
> 
> Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied to pci/resource for v6.19, thanks!

> ---
> 
> As this is so close to the merge window, I assume this will be routed
> through next but I suggest not folding it to the commit bb1fabd0d94e
> ("PCI: Add pci_rebar_size_supported() helper") as this should be
> backported. It will fail backport immediately as pci_rebar_size_supported()
> is only in pci/resource but I'll deal with it when the time comes and
> create a backport for it to the older codebase.
> 
> ---
>  drivers/pci/rebar.c   | 3 +++
>  include/linux/sizes.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
> index 8f7af3053cd8..a84165a196fa 100644
> --- a/drivers/pci/rebar.c
> +++ b/drivers/pci/rebar.c
> @@ -139,6 +139,9 @@ bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int size)
>  {
>  	u64 sizes = pci_rebar_get_possible_sizes(pdev, bar);
>  
> +	if (size < 0 || size > ilog2(SZ_128T) - ilog2(PCI_REBAR_MIN_SIZE))
> +		return false;
> +
>  	return BIT(size) & sizes;
>  }
>  EXPORT_SYMBOL_GPL(pci_rebar_size_supported);
> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
> index 49039494076f..f1f1a055b047 100644
> --- a/include/linux/sizes.h
> +++ b/include/linux/sizes.h
> @@ -67,5 +67,6 @@
>  #define SZ_16T				_AC(0x100000000000, ULL)
>  #define SZ_32T				_AC(0x200000000000, ULL)
>  #define SZ_64T				_AC(0x400000000000, ULL)
> +#define SZ_128T				_AC(0x800000000000, ULL)
>  
>  #endif /* __LINUX_SIZES_H__ */
> 
> base-commit: bf0a90fc907e47344f88e5b9b241082184dbac27
> -- 
> 2.39.5
> 

