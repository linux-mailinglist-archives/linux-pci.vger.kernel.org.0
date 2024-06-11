Return-Path: <linux-pci+bounces-8619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B9904769
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04C1B245A8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DEE156F4B;
	Tue, 11 Jun 2024 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC/lBgZD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA77D3FA;
	Tue, 11 Jun 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146605; cv=none; b=jl6Wog2WKVPFVebTUjEDfuLOCep4ZO8zPPA+rf8m9dqfd/G4liAHhToG8AFhJp8s1HSPsP66zMbFkG2fUrIBdbmxyitzlD5fscmfvU6qhR+yfSxvti1sq0ylVDBML2ACUo0K9LCea3SHWNySuWzb7zI0R1EoMtjl5i3N9ha4+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146605; c=relaxed/simple;
	bh=4jBM6mXHjYlJoMIZWueS89ZlNO+AUiWEJRKWxa04gKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rKOimdtNyca/DoKvpEkzL/vcAYcRQ+fOWgjNoQKrRFqGl2/DcA4RSEOktHiIIZJmZt5qSMSpW8AwDm5Aek1m5ZS5t3S8wWl5Aj/M6qNYrRSj1spaXKzKW9Iorsb53c3zCVnXLDe2NueUUczZ7t7FiOKR29DpRo5VPdSfIyemf5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC/lBgZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61873C2BD10;
	Tue, 11 Jun 2024 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718146604;
	bh=4jBM6mXHjYlJoMIZWueS89ZlNO+AUiWEJRKWxa04gKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jC/lBgZD6SkKl7787/66Mot1OAxtctUITyf4UXOQ2JVSa8o2lpp+iWq8ogS7UENCo
	 yqzTumDF8tEtMA5L412KbnAWTlEICUYUaB6WQxi/iZq3KK051i9I3hdCqNPejgIY4h
	 Ke9p24cUfRX+tKJ4QPj74HGoZDGWa82+//qPfAT/wSsLNiBhD00oQF6em+0sTCo9Ey
	 T00111RDYHGIANzLOKvQl9jG1tiRKNY+avJse/GePnxuyh/FbgNapR/wc4e5yK42i4
	 A9QSPKjwn8ZsN2uOR8Yxm/hvF/Rk0wTUKHu9VUqckeSElV62zzJn/RrNGm/MKg0ARp
	 fgy3tmBrEJCJw==
Date: Tue, 11 Jun 2024 17:56:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 16/17] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
Message-ID: <20240611225643.GA1005995@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-16-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a PCI power control driver that's capable of correctly powering up
> devices using the power sequencing subsystem. The first users of this
> driver are the ath11k module on QCA6390 and ath12k on WCN7850.
> 
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With s/add/Add/ in subject,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pwrctl/Kconfig             |  9 ++++
>  drivers/pci/pwrctl/Makefile            |  2 +
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 89 ++++++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+)
> 
> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
> index 96195395af69..f1b824955d4b 100644
> --- a/drivers/pci/pwrctl/Kconfig
> +++ b/drivers/pci/pwrctl/Kconfig
> @@ -5,4 +5,13 @@ menu "PCI Power control drivers"
>  config PCI_PWRCTL
>  	tristate
>  
> +config PCI_PWRCTL_PWRSEQ
> +	tristate "PCI Power Control driver using the Power Sequencing subsystem"
> +	select POWER_SEQUENCING
> +	select PCI_PWRCTL
> +	default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
> +	help
> +	  Enable support for the PCI power control driver for device
> +	  drivers using the Power Sequencing subsystem.
> +
>  endmenu
> diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
> index 52ae0640ef7b..d308aae4800c 100644
> --- a/drivers/pci/pwrctl/Makefile
> +++ b/drivers/pci/pwrctl/Makefile
> @@ -2,3 +2,5 @@
>  
>  obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
>  pci-pwrctl-core-y			:= core.o
> +
> +obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
> diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> new file mode 100644
> index 000000000000..c7a113a76c0c
> --- /dev/null
> +++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Linaro Ltd.
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
> +	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
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
> +	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
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
> +		.data = "wlan",
> +	},
> +	{
> +		/* ATH12K in WCN7850 package. */
> +		.compatible = "pci17cb,1107",
> +		.data = "wlan",
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
> 
> -- 
> 2.43.0
> 

