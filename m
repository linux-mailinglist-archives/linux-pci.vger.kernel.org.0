Return-Path: <linux-pci+bounces-2970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E88258466A6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 04:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D951F25A7E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 03:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA718D2F5;
	Fri,  2 Feb 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWkmgNvs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE8E549;
	Fri,  2 Feb 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846000; cv=none; b=Ckw3xe6E3LymYaBCmkaTJ9EV7ZJDpNgf9F6FKoYxONZmJRBz2AGApRQqlHz7j3ADnreik3v+/jxCidtNMPATfThQKP+bemYzwfgdcjyDlhGvkAvEtsTAQYanxkqU4tfsG/axuOP7RoProwO3YwbGrRpX6hJftVdTvnFpv0QBGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846000; c=relaxed/simple;
	bh=3WcD8DCEvMEUv+2oQxxbFJxN/+ZqIL/ovqG9CcxSabs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9waz9hRbg7KhCYLDDM7bby3X6rika0y3co9jpm1TUivYo3j8Ai+bqtM6gAXuBxwgTdKlRZlSasSGoIqW5a05eAoyrQNFe3UrYcF8R3DUlGToHUit+pffAPWC5VP4eQqsjEtoePKE7Xyc6Rq7MhgWz1foWs4QI5MtdRPR//jMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWkmgNvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A96CC433C7;
	Fri,  2 Feb 2024 03:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706846000;
	bh=3WcD8DCEvMEUv+2oQxxbFJxN/+ZqIL/ovqG9CcxSabs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWkmgNvsGxEWEs9AH7uUpf63vgbNfsgtO4uYq/9bGC12cqwH3Yjz3IXY4dbjzI5ds
	 5X1VrnigyrIEHjPXYWyWQit1F/13JIIfSrBHtlm/Whqu683EglPnHR8c6w8Mev48rB
	 wtT8dV9EoOuLjREBE4RGT4xoyTPzthuUYYIb5jILX2ik4eyva7KY7rYkg6h2f890D4
	 uYxbBgNNoCnS/p4t5nqyvy3U5Fk6Gwl1ZziGuSuPIa3MoLfxeXLgIYvOPN6YVn+brc
	 2pRYiHQiFNMS1JD2WuTkCYDdsoxy8bNYsLZ00dV+t125EDchQaUTR8DKARlGr+IJrO
	 duEdcKDF0pZDg==
Date: Thu, 1 Feb 2024 21:53:16 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC 8/9] PCI/pwrctl: add PCI power control core code
Message-ID: <7tbhdkqpl4iuaxmc73pje2nbbkarxxpgmabc7j4q26d2rhzrv5@ltu6niel5eb4>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-9-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155532.49707-9-brgl@bgdev.pl>

On Thu, Feb 01, 2024 at 04:55:31PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Some PCI devices must be powered-on before they can be detected on the
> bus. Introduce a simple framework reusing the existing PCI OF
> infrastructure.
> 
> The way this works is: a DT node representing a PCI device connected to
> the port can be matched against its power control platform driver. If
> the match succeeds, the driver is responsible for powering-up the device
> and calling pcie_pwrctl_device_enable() which will trigger a PCI bus
> rescan as well as subscribe to PCI bus notifications.
> 
> When the device is detected and created, we'll make it consume the same
> DT node that the platform device did. When the device is bound, we'll
> create a device link between it and the parent power control device.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/Kconfig         |  1 +
>  drivers/pci/Makefile        |  1 +
>  drivers/pci/pwrctl/Kconfig  |  8 ++++
>  drivers/pci/pwrctl/Makefile |  3 ++
>  drivers/pci/pwrctl/core.c   | 82 +++++++++++++++++++++++++++++++++++++
>  include/linux/pci-pwrctl.h  | 24 +++++++++++
>  6 files changed, 119 insertions(+)
>  create mode 100644 drivers/pci/pwrctl/Kconfig
>  create mode 100644 drivers/pci/pwrctl/Makefile
>  create mode 100644 drivers/pci/pwrctl/core.c
>  create mode 100644 include/linux/pci-pwrctl.h
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 74147262625b..5b9b84f8774f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -291,5 +291,6 @@ source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/controller/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
>  source "drivers/pci/switch/Kconfig"
> +source "drivers/pci/pwrctl/Kconfig"
>  
>  endif
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index cc8b4e01e29d..6ae202d950f8 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
>  
>  obj-$(CONFIG_PCI)		+= msi/
>  obj-$(CONFIG_PCI)		+= pcie/
> +obj-$(CONFIG_PCI)		+= pwrctl/
>  
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_PROC_FS)		+= proc.o
> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
> new file mode 100644
> index 000000000000..e2dc5e5d2af1
> --- /dev/null
> +++ b/drivers/pci/pwrctl/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menu "PCI Power control drivers"
> +
> +config PCI_PWRCTL
> +	bool
> +
> +endmenu
> diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
> new file mode 100644
> index 000000000000..4381cfbf3f21
> --- /dev/null
> +++ b/drivers/pci/pwrctl/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_PCI_PWRCTL)		+= core.o
> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
> new file mode 100644
> index 000000000000..312e6fe95c31
> --- /dev/null
> +++ b/drivers/pci/pwrctl/core.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Linaro Ltd.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/pci-pwrctl.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
> +			     void *data)
> +{
> +	struct pci_pwrctl *pwrctl = container_of(nb, struct pci_pwrctl, nb);
> +	struct device *dev = data;
> +
> +	if (dev_fwnode(dev) != dev_fwnode(pwrctl->dev))
> +		return NOTIFY_DONE;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		device_set_of_node_from_dev(dev, pwrctl->dev);

What happens if the bootloader left the power on, and the
of_platform_populate() got probe deferred because the pwrseq wasn't
ready, so this happens after pci_set_of_node() has been called?

(I think dev->of_node will be put, then get and then node_reused
assigned...but I'm not entirely sure)

> +		break;
> +	case BUS_NOTIFY_BOUND_DRIVER:
> +		pwrctl->link = device_link_add(dev, pwrctl->dev,
> +					       DL_FLAG_AUTOREMOVE_CONSUMER);
> +		if (!pwrctl->link)
> +			dev_err(pwrctl->dev, "Failed to add device link\n");
> +		break;
> +	case BUS_NOTIFY_UNBOUND_DRIVER:
> +		device_link_del(pwrctl->link);

This might however become a NULL-pointer dereference, if dev was bound
to its driver before the pci_pwrctl_notify() was registered for the
pwrctl and then the PCI device is unbound.

This would also happen if device_link_add() failed when the PCI device
was bound...

> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl)

This function doesn't really "enable the device", looking at the example
driver it's rather "device_enabled" than "device_enable"...

> +{
> +	if (!pwrctl->dev)
> +		return -ENODEV;
> +
> +	pwrctl->nb.notifier_call = pci_pwrctl_notify;
> +	bus_register_notifier(&pci_bus_type, &pwrctl->nb);
> +
> +	pci_lock_rescan_remove();
> +	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
> +	pci_unlock_rescan_remove();
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_pwrctl_device_enable);
> +
> +void pci_pwrctl_device_disable(struct pci_pwrctl *pwrctl)

Similarly this doesn't disable the device, the code calling this is
doing so...

Regards,
Bjorn

> +{
> +	bus_unregister_notifier(&pci_bus_type, &pwrctl->nb);
> +}
> +EXPORT_SYMBOL_GPL(pci_pwrctl_device_disable);
> +
> +static void devm_pci_pwrctl_device_disable(void *data)
> +{
> +	struct pci_pwrctl *pwrctl = data;
> +
> +	pci_pwrctl_device_disable(pwrctl);
> +}
> +
> +int devm_pci_pwrctl_device_enable(struct device *dev,
> +				  struct pci_pwrctl *pwrctl)
> +{
> +	int ret;
> +
> +	ret = pci_pwrctl_device_enable(pwrctl);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_pci_pwrctl_device_disable,
> +					pwrctl);
> +}
> +EXPORT_SYMBOL_GPL(devm_pci_pwrctl_device_enable);
> diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctl.h
> new file mode 100644
> index 000000000000..8d16d27cbfeb
> --- /dev/null
> +++ b/include/linux/pci-pwrctl.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
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
> +
> +struct pci_pwrctl {
> +	struct notifier_block nb;
> +	struct device *dev;
> +	struct device_link *link;
> +};
> +
> +int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl);
> +void pci_pwrctl_device_disable(struct pci_pwrctl *pwrctl);
> +int devm_pci_pwrctl_device_enable(struct device *dev,
> +				  struct pci_pwrctl *pwrctl);
> +
> +#endif /* __PCI_PWRCTL_H__ */
> -- 
> 2.40.1
> 

