Return-Path: <linux-pci+bounces-41748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76751C72E95
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 09:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04015348B63
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630182FF645;
	Thu, 20 Nov 2025 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN+JP6aD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1586349;
	Thu, 20 Nov 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627539; cv=none; b=MonJVaK23YXZ0JnoiMK5vJXqJtsHrxFVPtK5oKvxjkvhPWB+MpPx9cnymAUeve/G5dABPMmdijt1y3S3+cHq4ihot8OONTxx5HwIHJ83ct5W/ylA7jFo4FqzsmqvGSo2/5vJQ3Mgy0td8OgVGGqsQjij/A61K+5O+jP3JXY/Z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627539; c=relaxed/simple;
	bh=kqmRS4WCIbg6uAhsPP56ZObLxU0FF0Fan2xpgRuMXTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3tvEakdBvdXyb6wpWTcV4Sp/+TNn1nXZb8Yl5tJOUQPrbnpS0WiC+SgA4MzT0pTyI1vJOjOzbH94PWxYX+hPHDxU9I5Nen7viIrDYkHFqbMUSDWB5ytM+dNbh4TdVDX+dSxGYm6epwx+c1e8vtMcCauqLe62eLxYRBqywdvaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bN+JP6aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BF8C4CEF1;
	Thu, 20 Nov 2025 08:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763627537;
	bh=kqmRS4WCIbg6uAhsPP56ZObLxU0FF0Fan2xpgRuMXTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bN+JP6aDWgr342loADV55ZDFb7oMAMaUHtrnbpKtIcTwkdBYZluJfKBrATu6wL9+E
	 JgGW6PUuJQV6lPqMcK+aXY6AmfeDNYXF2XH8237dwRHSeXeKQ2uHNRy2c2ZKcbatVx
	 SklHj6XVD9puypk8tlEKltNn0Nb5gDnKM4PHqz8ksrvuilFnEzFU7lIfgAhGuV0H9L
	 1GhD96XAEGdHz6brJICbdJtoq1OtsXkQEPFzihJjfL4Kp7L5l2dZMwQLgz0PJShGZi
	 D76FPP8itQxMt7lEfjg6+Xam6TzegBDiL2T/LPycTeWoTu0jLc/dT8Ml/LCUFC0q9z
	 SHet+n/valpyA==
Date: Thu, 20 Nov 2025 14:02:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add Manivannan Sadhasivam as maintainer of
 PCI/pwrctl
Message-ID: <4pfz4sxjy4o3yktsjbyg3aomah7jzoclium6yifowdwxj32rzf@a22d6orubilq>
References: <20251120082747.10541-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120082747.10541-1-brgl@bgdev.pl>

On Thu, Nov 20, 2025 at 09:27:47AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Manivannan is doing a lot of work on the PCI power control. Add him as
> maintainer.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 59b145dde215f..549e51e57c4cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20100,6 +20100,7 @@ F:	include/linux/pci-p2pdma.h
>  
>  PCI POWER CONTROL
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

