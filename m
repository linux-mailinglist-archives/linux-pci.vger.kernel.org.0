Return-Path: <linux-pci+bounces-44286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E3D046B7
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 17:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 193B4310566F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFB2BB1D;
	Thu,  8 Jan 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9LRzVav"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F09226D1E;
	Thu,  8 Jan 2026 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888756; cv=none; b=BpKgYg9TG6yLNNq4rHxLG/k3iYMTKutwy6N5QXmb0bhvaWDrV+FQXeMVCz8NhO4f/aJcviLZ+hAtjEWiTM6DdtWi2wW2JKPV66O3qsynqpIrxYzeJ9NE6l2nD03ZMPJ2HgTrKUMzy9BirsR/ryd6ftRYSQO0Jh9HAtsXFoc0hg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888756; c=relaxed/simple;
	bh=V8O17syXNsMLoXA54yd13fKCVCjHzEoJ999ub7lM/Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTmEcZLPgDbZJAMzo1Od+5hsg/jzqr9IiSDo4kEUKcxnk8P1YqKQUm8orW9vXjmrRsBBb48xZHthE/JAV5NZigGS1WzQ+k5rgfm/MmEjkdpa13laPcnnApBE43lmg0xa383DePzq8zcD/uTG9AA8ffhyhStNiUHgYUYnX/5ge9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9LRzVav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5884EC116C6;
	Thu,  8 Jan 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888756;
	bh=V8O17syXNsMLoXA54yd13fKCVCjHzEoJ999ub7lM/Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9LRzVav2GO4CMduUYKdZsdpdXOgcXSJqjTduv7EcQ1UIyAY8wCV0GBdpAy3q3C+P
	 bhKc240hjb3u/t7nVUzARqu1oiuDzY5mK/m0x8s86Ag1QG2X4pM1xA0KJezfVtr73f
	 Grb+0t0Zt6S9FwjVht7Z2EiSK+voxc2nzI301ool3EByVIB6bTL2YCaQPOvGT8idp8
	 1zECHh0pS3E0KhVJW1MNZVB0so5vnVZIAyCQeXNMTWwdZhcvhM5lfIKp4tr23d+kBQ
	 EGlmUBW3BiRN+vXsxuV5Q0NFJsWF/08l7R/VYrUy7avgTn7snbgG5O5tOVBmE2y7W4
	 oUA9wpdkLg60g==
Date: Thu, 8 Jan 2026 17:12:30 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 7/7] irqchip/gic-v5: Add ACPI IWB probing
Message-ID: <aV/XbgUrjLVGM40O@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <20251218-gicv5-host-acpi-v2-7-eec76cd1d40b@kernel.org>
 <20260105153521.00007e46@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105153521.00007e46@huawei.com>

On Mon, Jan 05, 2026 at 03:35:21PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 11:14:33 +0100
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> > To probe an IWB in an ACPI based system it is required:
> > 
> > - to implement the IORT functions handling the IWB IORT node and create
> >   functions to retrieve IWB firmware information
> > - to augment the driver to match the DSDT ACPI "ARMH0003" device and
> >   retrieve the IWB wire and trigger mask from the GSI interrupt descriptor
> >   in the IWB msi_domain_ops.msi_translate() function
> > 
> > Make the required driver changes to enable IWB probing in ACPI systems.
> > 
> > The GICv5 GSI format requires special handling for IWB routed IRQs.
> > 
> > Add IWB GSI detection to the top level driver gic_v5_get_gsi_domain_id()
> > function so that the correct IRQ domain for a GSI can be detected by
> > parsing the GSI and check whether it is an IWB-backed IRQ or not.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> A couple of trivial comments inline. Overall this series looks in a good
> state to me.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  drivers/acpi/arm64/iort.c          | 95 ++++++++++++++++++++++++++++++++------
> >  drivers/irqchip/irq-gic-v5-iwb.c   | 42 +++++++++++++----
> >  drivers/irqchip/irq-gic-v5.c       |  4 ++
> >  include/linux/acpi_iort.h          |  1 +
> >  include/linux/irqchip/arm-gic-v5.h |  6 +++
> >  5 files changed, 123 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 17dbe66da804..4b0b753db738 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> 
> > @@ -317,12 +325,28 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
> >  	return status;
> >  }
> >  
> > +static acpi_status iort_match_iwb_callback(struct acpi_iort_node *node, void *context)
> > +{
> > +	acpi_status status = AE_NOT_FOUND;
> > +	u32 *id = context;
> > +
> > +	if (node->type == ACPI_IORT_NODE_IWB) {
> > +		struct acpi_iort_iwb *iwb;
> > +
> > +		iwb = (struct acpi_iort_iwb *)node->node_data;
> > +		status = iwb->iwb_index == *id ? AE_OK : AE_NOT_FOUND;
> > +	}
> > +
> > +	return status;
> Simpler flow with a quick exclusion of wrong nodes.
> 	if (node->type != ACPI_IORT_NODE_IWB)
> 		return AE_NOT_FOUND;
> 	....
> 	iwb = ...
> 	
> Also not sure I'd use a ternary here given it's only slightly more code
> as more readable.
> 	if (iwb->iwb_index != *id)
> 		return AE_NOT_FOUND;
> 
> 	return AE_OK;

Updated.

> > +}
> 
> 
> > diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
> > index ad9fdc14d1c6..c7d5fd34d053 100644
> > --- a/drivers/irqchip/irq-gic-v5-iwb.c
> > +++ b/drivers/irqchip/irq-gic-v5-iwb.c
> > @@ -4,6 +4,7 @@
> >   */
> >  #define pr_fmt(fmt)	"GICv5 IWB: " fmt
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/msi.h>
> > @@ -136,18 +137,31 @@ static int gicv5_iwb_irq_domain_translate(struct irq_domain *d, struct irq_fwspe
> >  					  irq_hw_number_t *hwirq,
> >  					  unsigned int *type)
> >  {
> > -	if (!is_of_node(fwspec->fwnode))
> > -		return -EINVAL;
> > +	if (is_of_node(fwspec->fwnode)) {
> >  
> > -	if (fwspec->param_count < 2)
> > -		return -EINVAL;
> > +		if (fwspec->param_count < 2)
> > +			return -EINVAL;
> >  
> > -	/*
> > -	 * param[0] is be the wire
> > -	 * param[1] is the interrupt type
> > -	 */
> > -	*hwirq = fwspec->param[0];
> > -	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> > +		/*
> > +		 * param[0] is be the wire
> > +		 * param[1] is the interrupt type
> > +		 */
> > +		*hwirq = fwspec->param[0];
> > +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> 
> As below, FIELD_GET() would improve reviewability a little.
> 
> 
> > +	}
> > +
> > +	if (is_acpi_device_node(fwspec->fwnode)) {
> > +
> > +		if (fwspec->param_count < 2)
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * Extract the wire from param[0]
> > +		 * param[1] is the interrupt type
> > +		 */
> > +		*hwirq = FIELD_GET(GICV5_GSI_IWB_WIRE, fwspec->param[0]);
> > +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> 
> I'd prefer this FIELD_GET() for this as well so there is no need to
> go sanity check that it is the lowest bits.

It is a common pattern in the kernel, that's why I am not convinced that
changing just this instance would improve much.

Thanks,
Lorenzo

> 
> > +	}
> >  
> >  	return 0;

