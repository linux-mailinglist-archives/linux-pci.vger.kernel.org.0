Return-Path: <linux-pci+bounces-43939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2BCEEB1E
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 14:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8FE3012747
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1DC30CDBE;
	Fri,  2 Jan 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e54d7SAw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD62E62A8
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767361576; cv=none; b=aOuYfh43nltecfh50BD1HvzqFPXKGgZXTBVnDmXjwWUgQmZCrvfSRNV2d+MOo+ZNgTgMJQSosXZzCB2+PKvca1sDZbbeW9BcKAXX81HdxW00KXp8MnaBatjZ6zX+DqjBnd03hI5qPxXZgWXOKFe5T6DBtUIUPyoVd9oev+PB0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767361576; c=relaxed/simple;
	bh=9Nb/HnB0BtWhpKibg4kYBbRAxuNp4KzGBmc6wGzCYAM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swhFFM92uMfhKRz9pLvZhVLCDohOmtGGLv3dUnwYVPv4wrZm5CIAJpQCHzjwh5voBzSs6dME7ZAnCGu/nBQ3chg63X1Va8pKlZqWSfWxT5lEjHj6OyK7gmzdK51eTwfI3B2pPtTQv/oML+OLPqf4mdGfUibPHdOciqicokjXKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e54d7SAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C636C19424
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767361575;
	bh=9Nb/HnB0BtWhpKibg4kYBbRAxuNp4KzGBmc6wGzCYAM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=e54d7SAwxu1mue4uKfvdmqhHq3Y47RYyhtZ73y0kHLWUxajV0pd+bq1CQ2qfy+4i0
	 uMna5LoQwthyIsFCiO8SdVh1CVcnsYYrnID2xm4Lv/hMzXP+pD60F9m1gXRMDDpPdQ
	 UwMNAU+7Ht8XLp+y94JwJXjVJpgImWEHVtkug9XGgCP3zeE5vZKG+OgbGa4wq2ksAU
	 fZtZuFc3d+fxPaiacG4cVKcNYl+2lV5Xbv5Lfql7jEfrU5jG0T/gFpssL8etMigNn2
	 CFdBHN96n+Vn2KtUQzmchbmqcVbagKshtWnhifdwI75zSynqiHP1xBCxA6TxUJd1cg
	 eW8pWbWdfPj/A==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso109621091fa.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 05:46:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtJ+g2zjpaS3vxyr1ecluz9awdNc+R1gYdtdOX+g+23nTe/AK7cPDduf2hwWn0SNk8tV04zXCrJvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAALzuOaNO5A9ml0AuAma+/MZrd2zGAA20WNxTPJO/wacwlzc
	UJnw9FFlDH0tVeE6qh0rzAz2ks9Kc+Jz+Bm/OUQDT/ORhvLNQ4NiC13tJeWEwBSiL4e1QGDepX+
	b2Mb4kB7VxIDwBCYZZQtrJBLQZGlTtsn8LTpPw58IyA==
X-Google-Smtp-Source: AGHT+IFYFmJn3LhNJ2qDjl1p4bOvBXIqS4Z+s6UDWzigXG9Cd6M+lqYwOG+GNqDAE7xa8CJDRnUJZVLe3+VH7sM75CE=
X-Received: by 2002:a05:6512:b85:b0:594:27dd:2700 with SMTP id
 2adb3069b0e04-59a17d4e9b0mr14214396e87.47.1767361574146; Fri, 02 Jan 2026
 05:46:14 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 08:46:13 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 08:46:13 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-3-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com> <20251229-pci-pwrctrl-rework-v3-3-c7d5918cd0db@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 08:46:13 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeRr8sY5UiJ2bJEZq0OmtEpuCFNMkCg-idHpo=VUE7ECw@mail.gmail.com>
X-Gm-Features: AQt7F2pcg8inHSGgMrjMeNhTTzlsZF7E3Lemvzx9J8lHqjc1-evbdosCAlYnJUg
Message-ID: <CAMRc=MeRr8sY5UiJ2bJEZq0OmtEpuCFNMkCg-idHpo=VUE7ECw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] PCI/pwrctrl: Add APIs for explicitly creating and
 destroying pwrctrl devices
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Dec 2025 18:26:54 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> Previously, the PCI core created pwrctrl devices during pci_scan_device()
> on its own and then skipped enumeration of those devices, hoping the
> pwrctrl driver would power them on and trigger a bus rescan.
>
> This approach works for endpoint devices directly connected to Root Ports,
> but it fails for PCIe switches acting as bus extenders. When the switch
> requires pwrctrl support, and the pwrctrl driver is not available during
> the pwrctrl device creation, it's enumeration will be skipped during the
> initial PCI bus scan.
>
> This premature scan leads the PCI core to allocate resources (bridge
> windows, bus numbers) for the upstream bridge based on available downstream
> buses at scan time. For non-hotplug capable bridges, PCI core typically
> allocates resources based on the number of buses available during the
> initial bus scan, which happens to be just one if the switch is not powered
> on and enumerated at that time. When the switch gets enumerated later on,
> it will fail due to the lack of upstream resources.
>
> As a result, a PCIe switch powered on by the pwrctrl driver cannot be
> reliably enumerated currently. Either the switch has to be enabled in the
> bootloader or the switch pwrctrl driver has to be loaded during the pwrctrl
> device creation time to workaround these issues.
>
> This commit introduces new APIs to explicitly create and destroy pwrctrl
> devices from controller drivers by recursively scanning the PCI child nodes
> of the controller. These APIs allow creating pwrctrl devices based on the
> original criteria and are intended to be called during controller probe and
> removal.
>
> These APIs, together with the upcoming APIs for power on/off will allow the
> controller drivers to power on all the devices before starting the initial
> bus scan, thereby solving the resource allocation issue.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> [mani: splitted the patch, cleaned up the code, and rewrote description]
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/of.c            |   1 +
>  drivers/pci/pwrctrl/core.c  | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-pwrctrl.h |   8 +++-
>  3 files changed, 121 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..9bb5f258759b 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -867,6 +867,7 @@ bool of_pci_supply_present(struct device_node *np)
>
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(of_pci_supply_present);
>
>  #endif /* CONFIG_PCI */
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6..844b5649b663 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -3,14 +3,21 @@
>   * Copyright (C) 2024 Linaro Ltd.
>   */
>
> +#define dev_fmt(fmt) "Pwrctrl: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/pci-pwrctrl.h>
> +#include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>
> +#include "../pci.h"
> +
>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>  			      void *data)
>  {
> @@ -145,6 +152,112 @@ int devm_pci_pwrctrl_device_set_ready(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_pci_pwrctrl_device_set_ready);
>
> +static int pci_pwrctrl_create_device(struct device_node *np, struct device *parent)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(np, child) {
> +		ret = pci_pwrctrl_create_device(child, parent);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Bail out if the platform device is already available for the node */
> +	pdev = of_find_device_by_node(np);
> +	if (pdev) {
> +		put_device(&pdev->dev);

There's already a platform_device_put() function and even a cleanup definition
for it. Can you see about using it here and elsewhere?

With that:
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

> +		return 0;
> +	}
> +
> +	/*
> +	 * Sanity check to make sure that the node has the compatible property
> +	 * to allow driver binding.
> +	 */
> +	if (!of_property_present(np, "compatible"))
> +		return 0;
> +
> +	/*
> +	 * Check whether the pwrctrl device really needs to be created or not.
> +	 * This is decided based on at least one of the power supplies being
> +	 * defined in the devicetree node of the device.
> +	 */
> +	if (!of_pci_supply_present(np)) {
> +		dev_dbg(parent, "Skipping OF node: %s\n", np->name);
> +		return 0;
> +	}
> +
> +	/* Now create the pwrctrl device */
> +	pdev = of_platform_device_create(np, NULL, parent);
> +	if (!pdev) {
> +		dev_err(parent, "Failed to create pwrctrl device for node: %s\n", np->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pci_pwrctrl_create_devices - Create pwrctrl devices
> + *
> + * @parent: Parent PCI device for which the pwrctrl devices need to be created.
> + *
> + * This function recursively creates pwrctrl devices for the child nodes
> + * of the specified PCI parent device in a depth first manner. On error, all
> + * created devices will be destroyed.
> + *
> + * Returns: 0 on success, negative error number on error.
> + */
> +int pci_pwrctrl_create_devices(struct device *parent)
> +{
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(parent->of_node, child) {
> +		ret = pci_pwrctrl_create_device(child, parent);
> +		if (ret) {
> +			pci_pwrctrl_destroy_devices(parent);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_pwrctrl_create_devices);
> +
> +static void pci_pwrctrl_destroy_device(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +
> +	for_each_available_child_of_node_scoped(np, child)
> +		pci_pwrctrl_destroy_device(child);
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev)
> +		return;
> +
> +	of_device_unregister(pdev);
> +	put_device(&pdev->dev);
> +
> +	of_node_clear_flag(np, OF_POPULATED);
> +}
> +
> +/**
> + * pci_pwrctrl_destroy_devices - Destroy pwrctrl devices
> + *
> + * @parent: Parent PCI device for which the pwrctrl devices need to be destroyed.
> + *
> + * This function recursively destroys pwrctrl devices for the child nodes
> + * of the specified PCI parent device in a depth first manner.
> + */
> +void pci_pwrctrl_destroy_devices(struct device *parent)
> +{
> +	struct device_node *np = parent->of_node;
> +
> +	for_each_available_child_of_node_scoped(np, child)
> +		pci_pwrctrl_destroy_device(child);
> +}
> +EXPORT_SYMBOL_GPL(pci_pwrctrl_destroy_devices);
> +
>  MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
>  MODULE_DESCRIPTION("PCI Device Power Control core driver");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
> index bd0ee9998125..5590ffec0bea 100644
> --- a/include/linux/pci-pwrctrl.h
> +++ b/include/linux/pci-pwrctrl.h
> @@ -54,5 +54,11 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pwrctrl);
>  void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl);
>  int devm_pci_pwrctrl_device_set_ready(struct device *dev,
>  				     struct pci_pwrctrl *pwrctrl);
> -
> +#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> +int pci_pwrctrl_create_devices(struct device *parent);
> +void pci_pwrctrl_destroy_devices(struct device *parent);
> +#else
> +static inline int pci_pwrctrl_create_devices(struct device *parent) { return 0; }
> +static void pci_pwrctrl_destroy_devices(struct device *parent) { }
> +#endif
>  #endif /* __PCI_PWRCTRL_H__ */
>
> --
> 2.48.1
>
>
>

