Return-Path: <linux-pci+bounces-35176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D8B3CA85
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0698E1890D98
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0514923F431;
	Sat, 30 Aug 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frKRPNFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A0C2EF;
	Sat, 30 Aug 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552901; cv=none; b=JkpjUXZp+ZvKyuwYusF4FDqRu+v74TaUfbtmD+shskzahl3LVEvNlwWo5yIQTP0mswUnf2inTyH5qFjqZ6A217fNiB45QBa6TO9TNFQsdyzEBICB4i1OdvJuMAZBY4eptM1WEPPlseroZ17qnJOFOJ+Za2VC1oyf0CMW9GxBfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552901; c=relaxed/simple;
	bh=35X7jMGVgngb0gIJ0oOEDl7iVXT89UTEaOxCMGj1YY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUbq7xFix53K7ycCKYQFF+HLhOnujNm0yFHSWpPMHM7KkIM+h+iFA3iOnoSK/w4hG4nav1koabgOu9Q5Ba8KfBaZud9RF+vm8pHm2pL28nVRPeVsZJb4M1A2RB7rRrevh4eK/eT5oWQhjwbz8ZxjkDDX6ZplIH9N8FAhzfasykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frKRPNFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0498C4CEEB;
	Sat, 30 Aug 2025 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756552901;
	bh=35X7jMGVgngb0gIJ0oOEDl7iVXT89UTEaOxCMGj1YY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frKRPNFQq7ZQ8IlEh1ofF/bY13kMJT2BGzzPUiuZzYbbBmsLpC2uqbnCfPm6OgfSn
	 kmTnrNdnPmTAaUYG6ZSaMn0ILOt75+qQDN16B9VLJwzHdETW21J5GHhOoU4Bp5dCTB
	 NXvUW35p3MfpQdHV7sApQTB2SV+OnCXw33GSIJybD/rJ8bwFIwhgXITa/XhWzJIzaX
	 GaOw80hXgQTzaISAVixKiyAJxm0L4hq8QFuX0DBRmI6vKREn/c/cGJ66Op6b4vzaOd
	 QPxQveJ0dVwhbHvaz9wz6nlD4icPK2lRLlxF3bCzkSucbA8nEuaTMyrFwU2eH12jLI
	 55vwpmLmbsOdg==
Date: Sat, 30 Aug 2025 16:51:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/15] PCI: cadence: Move PCIe controller common
 functions as a separate file
Message-ID: <565vte4ktztuj2k7pipdtftbjzloldsascqhaklsfmxmqx22z3@jp3xmgrvc3kc>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-8-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-8-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:31PM GMT, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Move the functions for platform common tasks to a separate file. The
> common library functions and functions specific to platform are
> now in different files.
> 

Why do we have too many library files? What is the need to split
pcie-cadence-common.c which itself is a library?

> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  drivers/pci/controller/cadence/Makefile       |   2 +-
>  .../controller/cadence/pcie-cadence-common.c  | 141 ++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.c | 129 ----------------
>  3 files changed, 142 insertions(+), 130 deletions(-)
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-common.c
> 
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index e45f72388bbb..b104562fb86a 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
> +obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence-common.o pcie-cadence.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-common.o pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-common.o pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-common.c b/drivers/pci/controller/cadence/pcie-cadence-common.c
> new file mode 100644
> index 000000000000..e14d53d64bf1
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-common.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe controller driver.
> +// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>

We use below style for multi line comments:

	/*
	 *
	 */

So even though this style existed, you should change it in all new files.

> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +
> +#include "pcie-cadence.h"
> +
> +void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
> +{
> +	int i = pcie->phy_count;
> +
> +	while (i--) {
> +		phy_power_off(pcie->phy[i]);
> +		phy_exit(pcie->phy[i]);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_disable_phy);
> +
> +int cdns_pcie_enable_phy(struct cdns_pcie *pcie)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < pcie->phy_count; i++) {
> +		ret = phy_init(pcie->phy[i]);
> +		if (ret < 0)
> +			goto err_phy;
> +
> +		ret = phy_power_on(pcie->phy[i]);
> +		if (ret < 0) {
> +			phy_exit(pcie->phy[i]);
> +			goto err_phy;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_phy:
> +	while (--i >= 0) {
> +		phy_power_off(pcie->phy[i]);
> +		phy_exit(pcie->phy[i]);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdns_pcie_enable_phy);
> +
> +int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
> +{
> +	struct device_node *np = dev->of_node;
> +	int phy_count;
> +	struct phy **phy;
> +	struct device_link **link;
> +	int i;
> +	int ret;
> +	const char *name;
> +
> +	phy_count = of_property_count_strings(np, "phy-names");
> +	if (phy_count < 1) {
> +		dev_info(dev, "no \"phy-names\" property found; PHY will not be initialized\n");
> +		pcie->phy_count = 0;
> +		return 0;
> +	}
> +
> +	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < phy_count; i++) {
> +		of_property_read_string_index(np, "phy-names", i, &name);
> +		phy[i] = devm_phy_get(dev, name);
> +		if (IS_ERR(phy[i])) {
> +			ret = PTR_ERR(phy[i]);
> +			goto err_phy;
> +		}
> +		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> +		if (!link[i]) {
> +			devm_phy_put(dev, phy[i]);
> +			ret = -EINVAL;
> +			goto err_phy;
> +		}
> +	}
> +
> +	pcie->phy_count = phy_count;
> +	pcie->phy = phy;
> +	pcie->link = link;
> +
> +	ret =  cdns_pcie_enable_phy(pcie);

Double space after =

- Mani

-- 
மணிவண்ணன் சதாசிவம்

