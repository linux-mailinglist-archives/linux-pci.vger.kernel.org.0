Return-Path: <linux-pci+bounces-13872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43667991207
	for <lists+linux-pci@lfdr.de>; Sat,  5 Oct 2024 00:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F3F1C2303A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C913A3ED;
	Fri,  4 Oct 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mepyZkYd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AB231CA3;
	Fri,  4 Oct 2024 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079243; cv=none; b=gKzfX2HdcVLik+qAP4saVxCaApwG3Fkje3AUbQyxpngnBx14EQxfkjVy52QBxKNFOoqMqpwbFrpw9kgR7roIahx6DFV6ltypcb771cpULi+ihb3MzS4tl2NeQO0Uh5Fb05Hr0RUwHLqAbjm24TwZyi6BwhOJzHwYBjxx3NU9ORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079243; c=relaxed/simple;
	bh=RZ5naVt379h7XDSVNVXSDrKS20ULBksNQLRLtrjXCbg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RPOtJ6zpm56r05TkfL2l2v/vv3cQF1unVAsNkos8LB6U9opNX17ZO//8jt00lo+uZfu6kf02BR2zgp4sw/FwKsB0G6UhQWwrIhkdJMqwPnP63/4NfrzmcdqjEMczxEuOBbOyMVyJPlr2bOj7erxp1nEGRniQS3+s04x9Vzw0Y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mepyZkYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFFCC4CEC6;
	Fri,  4 Oct 2024 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728079242;
	bh=RZ5naVt379h7XDSVNVXSDrKS20ULBksNQLRLtrjXCbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mepyZkYd4IGkqR2KC40TWAzcWYjH+6x4Hvnywoy7wy5p98XSLLIFAKYO9rJZyPeNM
	 fzvSPh4NGs0z66zQp+VRZ39c+2rwvBgOs54wxFJbsI4iTAQKonyh8p3tPxcLPa3uc3
	 WwS/+snmCbQuweP6dUE2sA+XVpUU+sBFAFEb7GoePGf5D49DOCu4BKoWOOkbEZ0rKJ
	 qVoh3NQYspfFhxKhQZJKjDxZ9HEAA0GGsWjV0KIB3MnGEtNZv/A7Ta4Wz7UMql11qB
	 juDE9R/yV5SSwaYYXuDi0sCprmsHOZy4Ni+xmI8ueLrsn5BoCOnVqaDi2HT7xAVvZy
	 tIM2VvE+Uei8A==
Date: Fri, 4 Oct 2024 17:00:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] PCI/pwrctl: pwrseq: don't use OF-specific routines
Message-ID: <20241004220039.GA363598@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004125821.47525-1-brgl@bgdev.pl>

On Fri, Oct 04, 2024 at 02:58:21PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This driver doesn't need to use OF interfaces directly. Replace the
> single usage of an of_ function and replace it with a generic device
> property variant. Drop the of.h header and pull in property.h instead.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to pci/pwrseq for v6.13, thanks.

> ---
> Bjorn: This may conflict with [1] but this should go for v6.13 while [1]
> is a fix that's targetting v6.12. If git doesn't figure it out then the
> resolution is trivial, just add <linux/property.h> in both and drop
> <linux/of.h>.
> 
> [1] https://lore.kernel.org/linux-pci/20241004125227.46514-1-brgl@bgdev.pl/
> 
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> index a23a4312574b..d3f960612cf3 100644
> --- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -6,9 +6,9 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/pci-pwrctl.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/pwrseq/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -35,7 +35,7 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
> +	data->pwrseq = devm_pwrseq_get(dev, device_get_match_data(dev));
>  	if (IS_ERR(data->pwrseq))
>  		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
>  				     "Failed to get the power sequencer\n");
> -- 
> 2.43.0
> 

