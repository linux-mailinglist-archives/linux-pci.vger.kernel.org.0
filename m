Return-Path: <linux-pci+bounces-44025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A593CF4046
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 15:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 603A8303DD2B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027B2C234A;
	Mon,  5 Jan 2026 13:55:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774D23D7DD;
	Mon,  5 Jan 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621355; cv=none; b=jjGI8JDqI8XfQKA3GBOAPUfS+sS6bgO77fc4pMXafD9EUMTRIiJV3kmXm4zXW+lXfWO/llLMWVwnoH5qxN+udL3fBfK0A8Kyil4jSBqB5a0awZSXWzTBHVJJsHfELkm1rFIN5GcCPbrSIdysZ+dentIHObMCkFSmwxZZNiII4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621355; c=relaxed/simple;
	bh=6Wi8ccELHgOxaAXh0BIHlKDmzpuP4ORk5/SyOh1Pmq0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcENHQCm1V7WY6YJR2kc2gKCCb/Zt7mT703OpFmcFwunlmYpDTvLU5ysmmVnV9OAYlyHhqtBH6uLwceDVo11pQmejc4jbOup07IxqhwgyvBVvrDQt3hk7rsjRr6FVKgdQGe/f5c1yAIHsWnWGDHGVj7clPeGGeYzz1xgj2PpKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlG6C3s37zHnGkW;
	Mon,  5 Jan 2026 21:55:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D2A4A40569;
	Mon,  5 Jan 2026 21:55:49 +0800 (CST)
Received: from localhost (10.48.147.217) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 13:55:48 +0000
Date: Mon, 5 Jan 2026 13:55:45 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Marc
 Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] irqchip/gic-v5: Add ACPI ITS probing
Message-ID: <20260105135545.00003a59@huawei.com>
In-Reply-To: <20251218-gicv5-host-acpi-v2-6-eec76cd1d40b@kernel.org>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
	<20251218-gicv5-host-acpi-v2-6-eec76cd1d40b@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 11:14:32 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> On ACPI ARM64 systems the GICv5 ITS configuration and translate frames
> are described in the MADT table.
> 
> Refactor the current GICv5 ITS driver code to share common functions
> between ACPI and OF and implement ACPI probing in the GICv5 ITS driver.
> 
> Add iort_msi_xlate() to map a device ID and retrieve an MSI controller
> fwnode node for ACPI systems and update pci_msi_map_rid_ctlr_node() to
> use it in its ACPI code path.
> 
> Add the required functions to IORT code for deviceID retrieval and IRQ
> domain registration and look-up so that the GICv5 ITS driver in an
> ACPI based system can be successfully probed.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
Hi Lorenzo,

Diff was in a rather unfriendly mood on this one and smashing the xlate
on top of the wrong function (wrt to what was being replaced).

Ah well. Only one minor comment inline.  Not really my area of expertise
beyond wanting this to move forwards quickly but none the less,

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/acpi/arm64/iort.c                |  95 +++++++++++++++++-----
>  drivers/irqchip/irq-gic-its-msi-parent.c |  39 ++++-----
>  drivers/irqchip/irq-gic-v5-irs.c         |   7 +-
>  drivers/irqchip/irq-gic-v5-its.c         | 132 ++++++++++++++++++++++++++++++-
>  drivers/pci/msi/irqdomain.c              |   2 +
>  include/linux/acpi_iort.h                |  10 ++-
>  include/linux/irqchip/arm-gic-v5.h       |   1 +
>  7 files changed, 241 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 65f0f56ad753..17dbe66da804 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -595,45 +595,45 @@ u32 iort_msi_map_id(struct device *dev, u32 input_id)
>  }
>
> +/**
> + * iort_pmsi_get_msi_info() - Get the device id and translate frame PA for a device
> + * @dev: The device for which the mapping is to be done.
> + * @dev_id: The device ID found.
> + * @pa: optional pointer to store translate frame address.
> + *
> + * Returns: 0 for successful devid and pa retrieval, -ENODEV on error
> + */
> +int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, phys_addr_t *pa)
> +{
> +	struct acpi_iort_node *node, *parent = NULL;
> +	struct acpi_iort_its_group *its;
> +	int i, index;
> +
> +	node = iort_find_dev_node(dev);
> +	if (!node)
> +		return -ENODEV;
> +
> +	index = iort_get_id_mapping_index(node);
> +	/* if there is a valid index, go get the dev_id directly */
> +	if (index >= 0) {
> +		parent = iort_node_get_id(node, dev_id, index);
> +	} else {
> +		for (i = 0; i < node->mapping_count; i++) {
> +			parent = iort_node_map_platform_id(node, dev_id,
> +						      IORT_MSI_TYPE, i);
> +			if (parent)
> +				break;
> +		}
> +	}
> +
Another borderline comment on what I think is a small readabilty
improvement.

I'd handle the only error case that would otherwise use the ternary below
here
	if (!parent)
		return -ENODEV;

	if (pa) {
		...
	}
	return 0;

> +	if (parent && pa) {
> +		int ret;
> +
> +		its = (struct acpi_iort_its_group *)node->node_data;
> +		ret = iort_find_its_base(its->identifiers[0], pa);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return parent ? 0 : -ENODEV;
> +}



