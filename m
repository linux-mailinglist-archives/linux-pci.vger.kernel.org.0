Return-Path: <linux-pci+bounces-33318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41873B188C3
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 23:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89ACB4E01FC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 21:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F35270ED7;
	Fri,  1 Aug 2025 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqYoYIv1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7920D4FC;
	Fri,  1 Aug 2025 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083873; cv=none; b=e3gO1ePRrc8TiDwn1IaZYDbzaoMyWirctwYSs11HNqtua6bkFzcyNkc7P6A0lXd3mvcKqsbXD2nddEBvIs8K4p574NWR7aiDJW0PT0rRKe+yjbSgUQQG1r7JIw6mL15l2yk1jo5ajQUsVfToonzUUEVn+exe/TKpfLr4iiCuWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083873; c=relaxed/simple;
	bh=T0XOE58sdx7A0HVxQITRZ8AZM4eF5OTC0ZCMhPP2724=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VHQAsu+hf4uJl9CV/uXlaxz5P6dK1taWIup2U5mGzW8nIm3AXwAjXBdG0W2YHmxu5EPbyHiefc9OCfum2VjPX3Rx7SOUklXZh0IG0w+BOgOxNGR4Q+FBD18k6r+/yGvFeBFHwsfE34BdH0njt4PhYP5s+WHqmMxOZP0OMHn6JtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqYoYIv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD87C4CEF6;
	Fri,  1 Aug 2025 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754083873;
	bh=T0XOE58sdx7A0HVxQITRZ8AZM4eF5OTC0ZCMhPP2724=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JqYoYIv1FYZTT4cI3RZnOY8yj8B6j3tT5ghkWSVmb1behkdHM9CFs3a2tcnvlKtqv
	 PDXEUAzk3k5/bIvyBRvcNtPmxFkOVqtZF6qbxMqpm+p4Jir9H/YudF1XC9qbwO9v36
	 PD6YRiTNLyPMNBUVwzue1O5J8DWJmkkwkn4uAN1lmZcOlGsHw/O+apc8k362ZPTDxZ
	 Jm7lTWVUGTAogDmBtZ6He/6xb2fEaPkoNnWWzJumfZROnal54j4AemGZ2g68nLq3xZ
	 op4Uy2xj1yzIXE5dZIqGU5EZ9Cy8tNoav5pPabWHY6YNcNwmqB1QiJq4BTg1OeTSbT
	 lOSbjwW10oIhA==
Date: Fri, 1 Aug 2025 16:31:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, sherry.sun@nxp.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PM: sleep: wakeirq: Add support for custom IRQ
 flags in dedicated wake IRQ setup
Message-ID: <20250801213111.GA3511902@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-wake_irq_support-v4-2-6b6639013a1a@oss.qualcomm.com>

On Fri, Aug 01, 2025 at 04:29:43PM +0530, Krishna Chaitanya Chundru wrote:
> Some devices require more flexibility when configuring their dedicated
> wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.

I guess the "dedicated" in dev_pm_set_dedicated_wake_irq() means "an
interrupt that only signals wakeup requests, possibly used by several
devices," not "an interrupt only used by this device"?

> This is particularly useful in PCIe systems where multiple endpoints
> (e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
> line for waking the device from D3cold to D0. In such cases, drivers
> can use this API with IRQF_SHARED to register a shared wake IRQ handler.

Nit: WAKE# does not itself wakeup any devices.  It only tells software
that the device *requested* a wakeup, and it's up to software to
actually perform it.

> Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
> irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
> and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior
> by passing default flags (IRQF_ONESHOT | IRQF_NO_AUTOEN).
> 
> Introduce a new API, dev_pm_set_dedicated_wake_irq_flags(), to allow
> callers to specify custom IRQ flags. If IRQF_SHARED is used, remove
> IRQF_NO_AUTOEN and disable the IRQ after setup to prevent spurious wakeups.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/base/power/wakeirq.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  include/linux/pm_wakeirq.h   |  6 ++++++
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b2891f3af490175362cc1a759069bd50..655c28d5fc6850f50fc2ed74c5fbc066a21ae7b3 100644
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
> +				   irq_flags, wirq->name, wirq);
>  	if (err)
>  		goto err_free_name;
>  
> @@ -234,7 +234,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
>   */
>  int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>  {
> -	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
> +	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_ONESHOT | IRQF_NO_AUTOEN);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>  
> @@ -255,10 +255,43 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
>   */
>  int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
>  {
> -	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
> +	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE,
> +					       IRQF_ONESHOT | IRQF_NO_AUTOEN);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
>  
> +/**
> + * dev_pm_set_dedicated_wake_irq_flags - Request a dedicated wake-up interrupt
> + *                                       with custom flags
> + * @dev: Device entry
> + * @irq: Device wake-up interrupt
> + * @flags: IRQ flags (e.g., IRQF_SHARED)
> + *
> + * This API sets up a threaded interrupt handler for a device that has
> + * a dedicated wake-up interrupt in addition to the device IO interrupt,
> + * allowing the caller to specify custom IRQ flags such as IRQF_SHARED.
> + *
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int dev_pm_set_dedicated_wake_irq_flags(struct device *dev, int irq, unsigned long flags)
> +{
> +	struct wake_irq *wirq;
> +	int ret;
> +
> +	flags |= IRQF_ONESHOT;
> +	if (!(flags & IRQF_SHARED))
> +		flags |= IRQF_NO_AUTOEN;
> +
> +	ret =  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, flags);
> +	if (!ret && (flags & IRQF_SHARED)) {
> +		wirq = dev->power.wakeirq;
> +		disable_irq_nosync(wirq->irq);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_flags);
> +
>  /**
>   * dev_pm_enable_wake_irq_check - Checks and enables wake-up interrupt
>   * @dev: Device
> diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
> index 25b63ed51b765c2c6919f259668a12675330835e..14950616efe34f4fa5408ca54cd8eeb1f7f0ff13 100644
> --- a/include/linux/pm_wakeirq.h
> +++ b/include/linux/pm_wakeirq.h
> @@ -11,6 +11,7 @@ extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
>  extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
>  extern void dev_pm_clear_wake_irq(struct device *dev);
>  extern int devm_pm_set_wake_irq(struct device *dev, int irq);
> +extern int dev_pm_set_dedicated_wake_irq_flags(struct device *dev, int irq, unsigned long flags);
>  
>  #else	/* !CONFIG_PM */
>  
> @@ -38,5 +39,10 @@ static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
>  	return 0;
>  }
>  
> +static inline int dev_pm_set_dedicated_wake_irq_flags(struct device *dev,
> +						      int irq, unsigned long flags)
> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_PM */
>  #endif	/* _LINUX_PM_WAKEIRQ_H */
> 
> -- 
> 2.34.1
> 

