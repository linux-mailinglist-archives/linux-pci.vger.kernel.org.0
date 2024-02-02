Return-Path: <linux-pci+bounces-2971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF28466B8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 05:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96723B2190A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BD12FB37;
	Fri,  2 Feb 2024 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqNVn6Q5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1CE54E;
	Fri,  2 Feb 2024 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846617; cv=none; b=BvUpZbWGCiKZBnEfir9WsGqaGv7S3mGedyxpMtRlsv3+TBRMOQZ9pYvM40cfftGaKCJ7+bKK9rtwuUZLZExQQsum/6je/s/RaTIXdtaKpfY5yvHh2n9k+GaSWsBEuuA0YEgn/YDpO+RcKgvPsb0i7mXsg1LoXIFmnPSBnHDdh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846617; c=relaxed/simple;
	bh=+MM0R6bVOvD7EKq9CIbszzVHDXHuZzK4c+gZTtd5NV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb3QXYqlhROPea5hCuBi2kh8Zqx4a3dib6GuNDzL6kCxcB5j6A4OWCDklr2If6I8UffiXTjnRQ/5vi9k8Wc3/qWADi6FTd8TwHyBx1Eo54LVNTsQzrNTZ7jeU9cl8iJwPDujzUDmUhd+68cMeZhFl/H2rCuJKZsXkcsYTXFE4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqNVn6Q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59117C433F1;
	Fri,  2 Feb 2024 04:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706846617;
	bh=+MM0R6bVOvD7EKq9CIbszzVHDXHuZzK4c+gZTtd5NV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqNVn6Q5OpakF1FEiX+4PR7WJkRyWcexOY4NyKGTviSk1AJBxfTsQa7OxI1RnEvhH
	 Fe85v0phzPji57h6ftfiFcd8eQfzJQ2ks1XwvFm1TtuNpx6+ZWirSwrog1vZVeTDqz
	 f02Ov9yYQKsEFAXVLZ6PIpilOUAch/prN/vPY9SH2tXr6lKkUx2HVeLZ2HZfSS2JgT
	 gT2lZ0+1A+LPwGnqywc7dpQPOBSz3nfzWywakp6Vau0gRE0T9IXz0VnHpNNopaEiTU
	 Pq00Nt/Ec9+OHK47jQ/9z/wPd2aKMd5NiFOHprT/q35gstcY1hMEAqr0j9MdFQ6GTG
	 CJwcl8/jfCvJg==
Date: Thu, 1 Feb 2024 22:03:33 -0600
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
Subject: Re: [RFC 9/9] PCI/pwrctl: add a PCI power control driver for power
 sequenced devices
Message-ID: <jb4hzijjxjv4kiy3cn2fuc5ox4x5uutredbxiwo2fvnkh2xudf@5w65qtp35ase>
References: <20240201155532.49707-1-brgl@bgdev.pl>
 <20240201155532.49707-10-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201155532.49707-10-brgl@bgdev.pl>

On Thu, Feb 01, 2024 at 04:55:32PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a PCI power control driver that's capable of correctly powering up
> devices using the power sequencing subsystem. For now we support the
> ath11k module on QCA6390.
> 

For a PCI device which doesn't share resources with something on another
bus, the whole power sequencing would be implemented in a driver like
this - without the involvement of the power sequence framework.

I think it would be nice to see this series introduce a simple
pci_pwrctl driver, and then (in the same series) introduce the power
sequence framework and your PMU driver.

One case where such model would be appropriate is the XHCI controller
(uPD720201) on db845c. Today we describe vddpe-3p3-supply as a supply on
the PCI controller, but it should have been vdd33-supply, vdd10-supply,
avdd33-supply on the PCI device.

That would provide an example for how a simple PCI power control driver
can/should look like, and we can discuss the PCI pieces separate from
the introduction of the new power sequence framework (which is unrelated
to PCI).

Regards,
Bjorn

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/pwrctl/Kconfig             |  9 +++
>  drivers/pci/pwrctl/Makefile            |  1 +
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 83 ++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> 
> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
> index e2dc5e5d2af1..bca72dc08e79 100644
> --- a/drivers/pci/pwrctl/Kconfig
> +++ b/drivers/pci/pwrctl/Kconfig
> @@ -5,4 +5,13 @@ menu "PCI Power control drivers"
>  config PCI_PWRCTL
>  	bool
>  
> +config PCI_PWRCTL_PWRSEQ
> +	tristate "PCI Power Control driver using the Power Sequencing subsystem"
> +	select POWER_SEQUENCING
> +	select PCI_PWRCTL
> +	default m if (ATH11K_PCI && ARCH_QCOM)
> +	help
> +	  Enable support for the PCI power control driver for device
> +	  drivers using the Power Sequencing subsystem.
> +
>  endmenu
> diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
> index 4381cfbf3f21..919c0f704ee9 100644
> --- a/drivers/pci/pwrctl/Makefile
> +++ b/drivers/pci/pwrctl/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_PCI_PWRCTL)		+= core.o
> +obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> new file mode 100644
> index 000000000000..510598c4edc4
> --- /dev/null
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023-2024 Linaro Ltd.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pci-pwrctl.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwrseq/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +struct pci_pwrctl_pwrseq_data {
> +	struct pci_pwrctl ctx;
> +	struct pwrseq_desc *pwrseq;
> +};
> +
> +static void devm_pci_pwrctl_pwrseq_power_off(void *data)
> +{
> +	struct pwrseq_desc *pwrseq = data;
> +
> +	pwrseq_power_off(pwrseq);
> +}
> +
> +static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
> +{
> +	struct pci_pwrctl_pwrseq_data *data;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pwrseq = devm_pwrseq_get(dev);
> +	if (IS_ERR(data->pwrseq))
> +		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
> +				     "Failed to get the power sequencer\n");
> +
> +	ret = pwrseq_power_on(data->pwrseq);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to power-on the device\n");
> +
> +	ret = devm_add_action_or_reset(dev, devm_pci_pwrctl_pwrseq_power_off,
> +				       data->pwrseq);
> +	if (ret)
> +		return ret;
> +
> +	data->ctx.dev = dev;
> +
> +	ret = devm_pci_pwrctl_device_enable(dev, &data->ctx);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register the pwrctl wrapper\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
> +	{
> +		/* ATH11K in QCA6390 package. */
> +		.compatible = "pci17cb,1101",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pci_pwrctl_pwrseq_of_match);
> +
> +static struct platform_driver pci_pwrctl_pwrseq_driver = {
> +	.driver = {
> +		.name = "pci-pwrctl-pwrseq",
> +		.of_match_table = pci_pwrctl_pwrseq_of_match,
> +	},
> +	.probe = pci_pwrctl_pwrseq_probe,
> +};
> +module_platform_driver(pci_pwrctl_pwrseq_driver);
> +
> +MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
> +MODULE_DESCRIPTION("Generic PCI Power Control module for power sequenced devices");
> +MODULE_LICENSE("GPL");
> -- 
> 2.40.1
> 

