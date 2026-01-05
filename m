Return-Path: <linux-pci+bounces-44037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266ACF47D9
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2407D310F8AE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9F33506D;
	Mon,  5 Jan 2026 15:35:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7EF334C1F;
	Mon,  5 Jan 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627330; cv=none; b=YjYECEU5cdy0rOd6ovM7oGiPV1YwJk+1uREjyCkMx4L08BcZtE6RTkf1bIynDNOwXdsblar/qH1Z5hQK/RMRgi8J7venNORp1JUozhB/oNQde+EYURLPI4xLhxmU/11kqyfD0DCAHWhQlnShYPsTYCjARR6Ax8k4cX0fCZOJvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627330; c=relaxed/simple;
	bh=fWqEL1fSDMOi6b55smNYwKDSz8sNbgwB2f+osIIeNeg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnJcvxFRmXbG+5muTibhNjDeRgjsDxHmBpv7K9lSRxRF7ABmbtaA4oUv/8I2r7mE6hcVETIQsFU4fVTPFhT7tOTw6nHKn/strI/keIQ9tTNS56ggZkckNhFVaBNW/R/ljlNj1MZcwwAh3hIhHtS8zA4pH5JwAJUiSDv0brucUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlJK53RhWzHnH6S;
	Mon,  5 Jan 2026 23:35:21 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E523F40570;
	Mon,  5 Jan 2026 23:35:23 +0800 (CST)
Received: from localhost (10.48.147.217) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 15:35:22 +0000
Date: Mon, 5 Jan 2026 15:35:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Marc
 Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] irqchip/gic-v5: Add ACPI IWB probing
Message-ID: <20260105153521.00007e46@huawei.com>
In-Reply-To: <20251218-gicv5-host-acpi-v2-7-eec76cd1d40b@kernel.org>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
	<20251218-gicv5-host-acpi-v2-7-eec76cd1d40b@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 11:14:33 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> To probe an IWB in an ACPI based system it is required:
> 
> - to implement the IORT functions handling the IWB IORT node and create
>   functions to retrieve IWB firmware information
> - to augment the driver to match the DSDT ACPI "ARMH0003" device and
>   retrieve the IWB wire and trigger mask from the GSI interrupt descriptor
>   in the IWB msi_domain_ops.msi_translate() function
> 
> Make the required driver changes to enable IWB probing in ACPI systems.
> 
> The GICv5 GSI format requires special handling for IWB routed IRQs.
> 
> Add IWB GSI detection to the top level driver gic_v5_get_gsi_domain_id()
> function so that the correct IRQ domain for a GSI can be detected by
> parsing the GSI and check whether it is an IWB-backed IRQ or not.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
A couple of trivial comments inline. Overall this series looks in a good
state to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/acpi/arm64/iort.c          | 95 ++++++++++++++++++++++++++++++++------
>  drivers/irqchip/irq-gic-v5-iwb.c   | 42 +++++++++++++----
>  drivers/irqchip/irq-gic-v5.c       |  4 ++
>  include/linux/acpi_iort.h          |  1 +
>  include/linux/irqchip/arm-gic-v5.h |  6 +++
>  5 files changed, 123 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 17dbe66da804..4b0b753db738 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c

> @@ -317,12 +325,28 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>  	return status;
>  }
>  
> +static acpi_status iort_match_iwb_callback(struct acpi_iort_node *node, void *context)
> +{
> +	acpi_status status = AE_NOT_FOUND;
> +	u32 *id = context;
> +
> +	if (node->type == ACPI_IORT_NODE_IWB) {
> +		struct acpi_iort_iwb *iwb;
> +
> +		iwb = (struct acpi_iort_iwb *)node->node_data;
> +		status = iwb->iwb_index == *id ? AE_OK : AE_NOT_FOUND;
> +	}
> +
> +	return status;
Simpler flow with a quick exclusion of wrong nodes.
	if (node->type != ACPI_IORT_NODE_IWB)
		return AE_NOT_FOUND;
	....
	iwb = ...
	
Also not sure I'd use a ternary here given it's only slightly more code
as more readable.
	if (iwb->iwb_index != *id)
		return AE_NOT_FOUND;

	return AE_OK;

> +}


> diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
> index ad9fdc14d1c6..c7d5fd34d053 100644
> --- a/drivers/irqchip/irq-gic-v5-iwb.c
> +++ b/drivers/irqchip/irq-gic-v5-iwb.c
> @@ -4,6 +4,7 @@
>   */
>  #define pr_fmt(fmt)	"GICv5 IWB: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/msi.h>
> @@ -136,18 +137,31 @@ static int gicv5_iwb_irq_domain_translate(struct irq_domain *d, struct irq_fwspe
>  					  irq_hw_number_t *hwirq,
>  					  unsigned int *type)
>  {
> -	if (!is_of_node(fwspec->fwnode))
> -		return -EINVAL;
> +	if (is_of_node(fwspec->fwnode)) {
>  
> -	if (fwspec->param_count < 2)
> -		return -EINVAL;
> +		if (fwspec->param_count < 2)
> +			return -EINVAL;
>  
> -	/*
> -	 * param[0] is be the wire
> -	 * param[1] is the interrupt type
> -	 */
> -	*hwirq = fwspec->param[0];
> -	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +		/*
> +		 * param[0] is be the wire
> +		 * param[1] is the interrupt type
> +		 */
> +		*hwirq = fwspec->param[0];
> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;

As below, FIELD_GET() would improve reviewability a little.


> +	}
> +
> +	if (is_acpi_device_node(fwspec->fwnode)) {
> +
> +		if (fwspec->param_count < 2)
> +			return -EINVAL;
> +
> +		/*
> +		 * Extract the wire from param[0]
> +		 * param[1] is the interrupt type
> +		 */
> +		*hwirq = FIELD_GET(GICV5_GSI_IWB_WIRE, fwspec->param[0]);
> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;

I'd prefer this FIELD_GET() for this as well so there is no need to
go sanity check that it is the lowest bits.

> +	}
>  
>  	return 0;

