Return-Path: <linux-pci+bounces-15649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F39B6BAF
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF202811A4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346581C3F0E;
	Wed, 30 Oct 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCQfUQc5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE681C3F00;
	Wed, 30 Oct 2024 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311765; cv=none; b=K96wc6qZWUeirq0R9VYtHDPuO3KMMWXW3vhxopFpw1DSpksFYqDXirLAQqWAxbtCdLCDw1AeB5WVl8Fp7uEczShRErCnZql2c5QQadG1DZJ3C87IQPGBUQp5JG9q6uPdfQ95qUEv85EENKvWKOPpF/bNzEp1bHIWa8YJkqAqkkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311765; c=relaxed/simple;
	bh=J+D38Y++wLZFZ7gBnMBrr82e/+4yn1ZFl58LuVnWe8U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p4d96TlkI9hFmBuyi7Uqs7QNRborqTe6as/l/0NsQC/3uW4+AkDUskaUnXyYbd/N3xcKQN5aEc9yXyzVA/w8aHzzUYR4GlgvTuaZ2BP1erToqDxuRTCGRQ8AOwRkjXLRzhUqKRLk20sLteqae0mUUBQxhLWmKb1j67O9sr4SY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCQfUQc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F825C4CECE;
	Wed, 30 Oct 2024 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730311764;
	bh=J+D38Y++wLZFZ7gBnMBrr82e/+4yn1ZFl58LuVnWe8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uCQfUQc596x9T88iYcBrR/Nx9qqnXcoJ7ex0HlrxaxOZ1FMvHc998Kni/w376UxwY
	 YdCePETd5+O1O0rF5O5acvvq6Q8FTjmfXamFoNrzee9VqJZZLVpXm2dNy8Jdqo7ncq
	 yyjPJXSd5WDfgLghTq2yXSWTr03Jc/v3XsfHQDY7tmV3yC7IJuu1Uo0cCP08D8GL48
	 QUzJRurD+39/cJM47lpwJa4xX76Vde/bYliu4/PkVrSAcv38PuRQc75RS3S/mW+Bqy
	 /NVCVxZS3tvKOnJhwPWD4saXLGiDuL68C/hCOzbBlRy+X8NlOKy0uPTCxja2oPkvm5
	 RZfq4Ckf/PbNw==
Date: Wed, 30 Oct 2024 13:09:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI/bwctrl: Check for error code from
 devm_mutex_init() call
Message-ID: <20241030180921.GA1210204@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030163139.2111689-1-andriy.shevchenko@linux.intel.com>

On Wed, Oct 30, 2024 at 06:31:39PM +0200, Andy Shevchenko wrote:
> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something. Add the missed
> check.
> 
> Fixes: 9b3da6e19e4d ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Squashed into 399ba413fa23 ("PCI/bwctrl: Add pcie_set_target_speed()
to set PCIe Link Speed"), thanks, Andy.

> ---
>  drivers/pci/pcie/bwctrl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index 3a93ed0550c7..2a19e441a901 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -299,7 +299,10 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	devm_mutex_init(&srv->device, &data->set_speed_mutex);
> +	ret = devm_mutex_init(&srv->device, &data->set_speed_mutex);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_threaded_irq(&srv->device, srv->irq, NULL,
>  					pcie_bwnotif_irq_thread,
>  					IRQF_SHARED | IRQF_ONESHOT,
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

