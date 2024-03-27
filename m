Return-Path: <linux-pci+bounces-5269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A688EAE4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 17:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EF61F33A1F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A112DDAD;
	Wed, 27 Mar 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afq6nzfs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CE42A91;
	Wed, 27 Mar 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556177; cv=none; b=lO5vQ9Owg8p3Hvs72DSZ2x9lICrOs3YR8ckJc2bP73d1q4/bllIw7U1Ui0ZVxzoXQoreGubZEKA2QLXh2+mrzc2TFV76RiZDYFX+pkXUkE22JxgrmF4LcO6S6yo5br8RgePjGBe6ArrBQtyKLGnAekRgQqyyEhB7/L7PXyJqDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556177; c=relaxed/simple;
	bh=On495Vosho8yghuPe/ZcVehrvgix78EySfxCo6i6kY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+opMG5L+mMnnm9+EZpVPLYvhXkM+TZ/Oov3Wea/FE2H7hUd1ojdSGt5v8+H6bwfVo3t/puUXt43JPM+5EDVaLj9maqkM70U2YpEhaLpcRItvHrvrKsGJqNFGJVleo0Lg3jcwUWewKJJ4kARuqSHbt6p3IIsE1imUxEmbZhM2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afq6nzfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CADC433C7;
	Wed, 27 Mar 2024 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711556177;
	bh=On495Vosho8yghuPe/ZcVehrvgix78EySfxCo6i6kY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afq6nzfsTajwNl8LvbUonLyvoZy88ahtEF+Fkmr8Gp55VWkjLs02RvASLRTcGlPw9
	 A3k0+c1v5Oru+8yj3BFHimVUIVe4OlixbdFKebF2ujjugw6eNhDo/O9u9W8H8tIN3l
	 YydxW0Vv+8AEQLXDLSm04PLqYwyGSDe6yaspn7eTWUW80gV+PCVCEWC7il7Ul4mNrY
	 SwqO6F0OkjmS2ihwcJsLxTCZShaQsiShwljjoSa214PxaVDT/DjdHpGCmWS9dlAORe
	 v7dPwEHLncbOl4VOkta++OzMHyOOBBuAXEiCm2WRsWW2f74aR42cEmKBCqEIFLKCDP
	 Q2VEXR1vc5xmg==
Date: Wed, 27 Mar 2024 16:16:07 +0000
From: Simon Horman <horms@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 12/16] PCI/pwrctl: add PCI power control core code
Message-ID: <20240327161607.GQ403975@kernel.org>
References: <20240325131624.26023-1-brgl@bgdev.pl>
 <20240325131624.26023-13-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325131624.26023-13-brgl@bgdev.pl>

On Mon, Mar 25, 2024 at 02:16:20PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Some PCI devices must be powered-on before they can be detected on the
> bus. Introduce a simple framework reusing the existing PCI OF
> infrastructure.
> 
> The way this works is: a DT node representing a PCI device connected to
> the port can be matched against its power control platform driver. If
> the match succeeds, the driver is responsible for powering-up the device
> and calling pcie_pwrctl_device_set_ready() which will trigger a PCI bus
> rescan as well as subscribe to PCI bus notifications.
> 
> When the device is detected and created, we'll make it consume the same
> DT node that the platform device did. When the device is bound, we'll
> create a device link between it and the parent power control device.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi Bartosz,

some minor Kernel doc nits from my side.

...

> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c

...

> +/**
> + * devm_pci_pwrctl_device_set_ready - Managed variant of
> + * pci_pwrctl_device_set_ready().
> + *

nit: @dev should be documented here

> + * @pwrctl: PCI power control data
> + *
> + * Returns:
> + * 0 on success, negative error number on error.
> + */
> +int devm_pci_pwrctl_device_set_ready(struct device *dev,
> +				     struct pci_pwrctl *pwrctl)
> +{
> +	int ret;
> +
> +	ret = pci_pwrctl_device_set_ready(pwrctl);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev,
> +					devm_pci_pwrctl_device_unset_ready,
> +					pwrctl);
> +}
> +EXPORT_SYMBOL_GPL(devm_pci_pwrctl_device_set_ready);
> +
> +MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
> +MODULE_DESCRIPTION("PCI Device Power Control core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctl.h
> new file mode 100644
> index 000000000000..ae8324ea7eeb
> --- /dev/null
> +++ b/include/linux/pci-pwrctl.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Linaro Ltd.
> + */
> +
> +#ifndef __PCI_PWRCTL_H__
> +#define __PCI_PWRCTL_H__
> +
> +#include <linux/notifier.h>
> +
> +struct device;
> +struct device_link;
> +
> +/*
> + * This is a simple framework for solving the issue of PCI devices that require
> + * certain resources (regulators, GPIOs, clocks) to be enabled before the
> + * device can actually be detected on the PCI bus.
> + *
> + * The idea is to reuse the platform bus to populate OF nodes describing the
> + * PCI device and its resources, let these platform devices probe and enable
> + * relevant resources and then trigger a rescan of the PCI bus allowing for the
> + * same device (with a second associated struct device) to be registered with
> + * the PCI subsystem.
> + *
> + * To preserve a correct hierarchy for PCI power management and device reset,
> + * we create a device link between the power control platform device (parent)
> + * and the supplied PCI device (child).
> + */
> +
> +/**
> + * struct pci_pwrctl - PCI device power control context.
> + * @dev - Address of the power controlling device.

nit: I think this should be "@dev: " rather than "@dev - "
     As is, "./scripts/kernel-doc -none" complains.
> + *
> + * An object of this type must be allocated by the PCI power control device and
> + * passed to the pwrctl subsystem to trigger a bus rescan and setup a device
> + * link with the device once it's up.
> + */
> +struct pci_pwrctl {
> +	struct device *dev;
> +
> +	/* Private, don't use. */

I think Private needs to be followed by a ':' rather than a ',' to keep
kernel-doc happy.

> +	struct notifier_block nb;
> +	struct device_link *link;
> +};
> +
> +int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl);
> +void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl);
> +int devm_pci_pwrctl_device_set_ready(struct device *dev,
> +				     struct pci_pwrctl *pwrctl);
> +
> +#endif /* __PCI_PWRCTL_H__ */
> -- 
> 2.40.1
> 
> 

