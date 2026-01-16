Return-Path: <linux-pci+bounces-45037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5744ED30272
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D94E3045DBF
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B636BCEF;
	Fri, 16 Jan 2026 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBoyDp/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387936920F;
	Fri, 16 Jan 2026 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561916; cv=none; b=pVXeeR2lvx2GLB/xjokjBWwa7Ip9hmyd3uXWjLOd0HGZeF6SQvDkj6BuFyRYZqG8uQBIoQWke0HFN2+ftKOYsqhqEY1sMcmxRWvcj20IAfwdIEapzZbog6ydSrW6K5Qn7jH6qyLEMMuWClgNWp4lwYioQtRiMjdQ+lKMwc6qTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561916; c=relaxed/simple;
	bh=DSlOnTDneF/cIci7EGTLJ5eO7ZkeoiFdIY5ITkDi2pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4lATlSHIkdKNMmrf2k0vCzn7KtAuO3PWyLVLtPegQXEoF+ngdpVCvAbPEF0HeGfAmZKDMvdFbF6qQCjnUc5Hq2/FaA6HFjo8o7TrqSIqjUPYGob0s1J/G2GF/7LFPJ4V8MIqGtguq4Y1P/jitsCA/YZjlPRnrCb3Iw7qJS6uWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBoyDp/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B485AC16AAE;
	Fri, 16 Jan 2026 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768561915;
	bh=DSlOnTDneF/cIci7EGTLJ5eO7ZkeoiFdIY5ITkDi2pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBoyDp/zqACNrmMW6lYe5ImqGxVpNieojKqdDiozAsmx4GvkU1+UDqGWNbKb8d6uh
	 vL5TPULmbJiip6PUSZPd7ODESJHLC0hg6vFgwQAdTPrkSJpU+fb6bapt79vMIHghuj
	 J9SBT6a125pyN0JV9qx7ztNV8JKqbyQGJ5gAbxs2OOG+o2ghxFQQiXfYxZ9AEG4iVf
	 YcR5R84titE5vfos7+oVf8VkEQaQpdqHbWBuS2f83FRy0I6xdXaNZGuo5po7nRNO/B
	 r11/Ceiqp3G/pGwwmQBL4Q0XHgSpE+6MILp4XZIXavSLAdC+TPSrXiI+m2GmIqnUZS
	 n1/8JG8Wf58rQ==
Date: Fri, 16 Jan 2026 16:41:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com
Subject: Re: [PATCH v6 1/2] PM: sleep: wakeirq: Add support for dedicated
 shared wake IRQ setup
Message-ID: <p4cci7cup2breet6pluazfeeekdkmx7xoa3ubiuv2i7dsxkrde@53eh4grfndlq>
References: <20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com>
 <20251127-wakeirq_support-v6-1-60f581f94205@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127-wakeirq_support-v6-1-60f581f94205@oss.qualcomm.com>

On Thu, Nov 27, 2025 at 06:15:42PM +0530, Krishna Chaitanya Chundru wrote:
> Some devices require more flexibility when configuring their dedicated
> wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
> This is particularly useful in PCIe systems where multiple endpoints
> (e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
> line which requests platform to re-establish power and reference clocks
> to the components. In such cases, drivers can use this new API
> dev_pm_set_dedicated_shared_wake_irq() to register a shared wake IRQ.
> 
> Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
> irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
> and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior.
> 
> When IRQ regitsered with IRQF_SHARED we can't use IRQF_NO_AUTOEN flag,
> so after registering for irq, disable it explicitly.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/base/power/wakeirq.c | 39 ++++++++++++++++++++++++++++++++++-----
>  include/linux/pm_wakeirq.h   |  6 ++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b2891f3af490175362cc1a759069bd50..df34a891d54bec8737a3ef174bdfa469c19133c4 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -168,7 +168,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
>  	return IRQ_HANDLED;
>  }
>  
> -static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag)
> +static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag,
> +					   unsigned int irq_flags)
>  {
>  	struct wake_irq *wirq;
>  	int err;
> @@ -197,8 +198,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
>  	 * so we use a threaded irq.
>  	 */
>  	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> -				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
> -				   wirq->name, wirq);
> +				   IRQF_ONESHOT | irq_flags, wirq->name, wirq);
>  	if (err)
>  		goto err_free_name;
>  
> @@ -234,7 +234,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
>   */
>  int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  {
> -	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
> +	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_NO_AUTOEN);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>  
> @@ -255,10 +255,39 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>   */
>  int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
>  {
> -	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
> +	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE,
> +					       IRQF_NO_AUTOEN);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
>  
> +/**
> + * dev_pm_set_dedicated_shared_wake_irq - Request a dedicated shared wake-up interrupt
> + *                                        with custom flags
> + * @dev: Device entry
> + * @irq: Device wake-up interrupt
> + * @flags: IRQ flags (e.g., IRQ_TYPE_EDGE_FALLING)
> + *
> + * This API sets up a threaded interrupt handler for a device that has
> + * a shared wake-up interrupt in addition to the device IO interrupt. It also
> + * sets IRQ flags like IRQ_TYPE_EDGE_FALLING passed by the caller.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq, unsigned long flags)
> +{
> +	struct wake_irq *wirq;
> +	int ret;
> +
> +	ret =  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_SHARED | flags);
> +	if (!ret) {
> +		wirq = dev->power.wakeirq;
> +		disable_irq_nosync(wirq->irq);
> +	}

Maybe it is just me, but I'd prefer the below pattern to make it easier to read.

	if (ret)
		return ret;

	wirq = dev->power.wakeirq;
	disable_irq_nosync(wirq->irq);

	return 0;

- Mani

-- 
மணிவண்ணன் சதாசிவம்

