Return-Path: <linux-pci+bounces-44742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A2BD1F4F2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1234830CDB79
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725A2D9488;
	Wed, 14 Jan 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GamcmtOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49F2D8371;
	Wed, 14 Jan 2026 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399319; cv=none; b=XQiOvRnxHTqWGontaEdcXhPAfLJ/mnWZBkE6Yydz3EhmCDEOxV4VqudEDm4VMxUt1EG3QfQyUSm1gmivjb805041wQCV+/Xc7NVmU4ueyi8kFqD4Jl6JsPClIpyrhjXdXXMnGDyHFBAon/NHbSaQlKUso5hUmrFWzHlXRIHReXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399319; c=relaxed/simple;
	bh=YThRr+SqFQrj1xWYbkZyAQfpTQhSxOJrEz7Vmu8eYO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9vQBa5OfCgazENkjB0mwTCmeN0N5uI2g4mu9qPFtlpNLEV6HFB75GGCyg/5BUd6MTRQ5LDeH9DJJ3Y6e3u1euYS/J+ItnsGT/UDxC8TUUInzeIA7jD5i8GjoE8c91cpVvlT0eEWvV9vB3tg5VQTFyqwg1y054cJ75T+RaoG//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GamcmtOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62176C19423;
	Wed, 14 Jan 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768399318;
	bh=YThRr+SqFQrj1xWYbkZyAQfpTQhSxOJrEz7Vmu8eYO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GamcmtOMZjUjnBtKP0uhc41XsMqZ5fSe9+uXZ30TVeZpZSpRIIMXLIZ6LSMmqmxZJ
	 NMpWBOrVCw5ay9J9pII8Hg/QzzTF8slSB/w2unqe4TNoWuGWzngFiEoJoUAvAmqFB5
	 Iwga7pBiI5Zhqw1J+tOTc30FaWvGC89yLrq+JlbFxL2kl2s3LxRjEpWvdFoSPyfKHh
	 jTw7x+USzU8jCMBBzyudL54Ry+Ze3oj0BmfkDgneM6dbU0fXZXjVgZ4iNhOuJykciN
	 khzGT4OdT3Wu+wQV1jAF14IH2be73WBLizVZPZCNbT/eImzvDLUXbcLvK5UdivHV/a
	 mq/qzYKU6Fp5w==
Message-ID: <2a44e967-ebae-4641-88d7-ccb4536ee3b7@kernel.org>
Date: Wed, 14 Jan 2026 15:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
To: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-acpi@vger.kernel.org
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-2-eff84d2c6d26@oss.qualcomm.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260112-pci-m2-e-v4-2-eff84d2c6d26@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mani,

Thank you for your work in this.

On 12-Jan-26 17:26, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Add of_find_serdev_controller_by_node() API to find the serdev controller
> device associated with the devicetree node.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/tty/serdev/core.c | 16 ++++++++++++++++
>  include/linux/serdev.h    |  9 +++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index b33e708cb245..25382c2d63e6 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -504,6 +504,22 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
>  }
>  EXPORT_SYMBOL_GPL(serdev_controller_alloc);
>  
> +/**
> + * of_find_serdev_controller_by_node() - Find the serdev controller associated
> + *					 with the devicetree node
> + * @node:	Devicetree node
> + *
> + * Return: Pointer to the serdev controller associated with the node. NULL if
> + * the controller is not found.
> + */
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> +
> +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
> +

This new of_find_serdev_controller_by_node() function needs:

#ifdef CONFIG_OF ... #endif

around it, to match the stubbing you are doing in serdev.h

>  static int of_serdev_register_devices(struct serdev_controller *ctrl)
>  {
>  	struct device_node *node;
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index ecde0ad3e248..db9bfaba0662 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -333,4 +333,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
>  }
>  #endif /* CONFIG_ACPI */
>  
> +#ifdef CONFIG_OF
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
> +#else
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	return NULL;
> +}

stubs like this one should be static inline to avoid warnings like this one:

In file included from drivers/tty/serdev/core.c:21:
./include/linux/serdev.h:339:27: warning: no previous prototype for ‘of_find_serdev_controller_by_node’ [-Wmissing-prototypes]
  339 | struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Regards,

Hans



