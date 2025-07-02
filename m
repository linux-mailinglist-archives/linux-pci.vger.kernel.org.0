Return-Path: <linux-pci+bounces-31270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A8AF5A9E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F30189C0DF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66BD28640B;
	Wed,  2 Jul 2025 14:09:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A22275846;
	Wed,  2 Jul 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465354; cv=none; b=dnGpZu1bmM8Viv2TkwLN/TZck5fTUCj7TyHKmSq8VeeTaik/2G2l7KpqT5/MO6s8gF5SJ8sE6/PecVzXe70RV06thWMP5GYpB1NZLdTqb0q1bNxAWcscPv1oteiWWs3W3QYyYB+Nq5zqVBsyxD4j41pbmoVmv7oTB+MOSIf8ZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465354; c=relaxed/simple;
	bh=KrByScEse9zQAz1mFpAbnHuiASOxgUN38QwBq7EKRwY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHxzEPZC7eDPjgeSc6/nAqQw/+m0Me9Onkl0kEoWPU7frGOShvPeGYDwv2zdf4kgWZ4DF7m875mjzKWPMsag5D65ubf2r4P4D7SRyZCkGLSe2T3HMvS0j3yIiSC3Wa8PaxB0QjaLcwx7FPW4I/uxHeU4V6/oSSwLLxn+O6cKLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXMDt2j8gz6M4dR;
	Wed,  2 Jul 2025 22:08:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 155B41402EA;
	Wed,  2 Jul 2025 22:09:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 16:09:09 +0200
Date: Wed, 2 Jul 2025 15:09:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Sascha Bischoff <sascha.bischoff@arm.com>, Timothy Hayes
	<timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 20/31] irqchip/gic-v5: Add GICv5 PPI support
Message-ID: <20250702150907.000060d8@huawei.com>
In-Reply-To: <aGUycEuLadcG+IfV@lpieralisi>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
	<20250626-gicv5-host-v6-20-48e046af4642@kernel.org>
	<20250702124019.00006b01@huawei.com>
	<aGUqEkascwGFD9x+@lpieralisi>
	<20250702140022.00001c65@huawei.com>
	<aGUycEuLadcG+IfV@lpieralisi>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Jul 2025 15:21:52 +0200
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> On Wed, Jul 02, 2025 at 02:00:22PM +0100, Jonathan Cameron wrote:
> > On Wed, 2 Jul 2025 14:46:10 +0200
> > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >   
> > > On Wed, Jul 02, 2025 at 12:40:19PM +0100, Jonathan Cameron wrote:  
> > > > On Thu, 26 Jun 2025 12:26:11 +0200
> > > > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > > >     
> > > > > The GICv5 CPU interface implements support for PE-Private Peripheral
> > > > > Interrupts (PPI), that are handled (enabled/prioritized/delivered)
> > > > > entirely within the CPU interface hardware.    
> > > > 
> > > > I can't remember where I got to last time so if I repeat stuff that
> > > > you already responded to, feel free to just ignore me this time ;)
> > > > 
> > > > All superficial stuff. Feel free to completely ignore if you like.    
> > > 
> > > We are at v6.16-rc4, series has been on the lists for 3 months, it has
> > > been reviewed and we would like to get it into v6.17 if possible and
> > > deemed reasonable, I am asking you folks please, what should I do ?
> > > 
> > > I can send a v7 with the changes requested below (no bug fixes there)
> > > - it is fine by me - but I need to know please asap if we have a
> > > plan to get this upstream this cycle.  
> > 
> > I'm absolutely fine with leaving these be.  The mask stuff I would like
> > to clean up as it applies quite widely in the series but that
> > can be a follow up as no bugs (so far!).   
> 
> I am certain that at a given state in the development I used the
> FIELD_PREP() on the hwirq_id and then was asked to remove it because
> it does not serve any purpose - this, for the records.

Fair enough.  Though on that front the code is inconsistent as
there are places where it is masked.  Anyhow, no problem either
way. The bit of feedback I gave on patch 22 might be more useful
to address (comments not matching code).


Jonathan

> 
> Thanks,
> Lorenzo
> 
> > As Marc said, these are in a good state.
> > 
> > Jonathan
> >   
> > > 
> > > Thanks,
> > > Lorenzo
> > >   
> > > > > diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
> > > > > new file mode 100644
> > > > > index 000000000000..a08daa562d21
> > > > > --- /dev/null
> > > > > +++ b/drivers/irqchip/irq-gic-v5.c
> > > > > @@ -0,0 +1,461 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Copyright (C) 2024-2025 ARM Limited, All Rights Reserved.
> > > > > + */
> > > > > +
> > > > > +#define pr_fmt(fmt)	"GICv5: " fmt
> > > > > +
> > > > > +#include <linux/irqdomain.h>
> > > > > +#include <linux/wordpart.h>
> > > > > +
> > > > > +#include <linux/irqchip.h>
> > > > > +#include <linux/irqchip/arm-gic-v5.h>
> > > > > +
> > > > > +#include <asm/cpufeature.h>
> > > > > +#include <asm/exception.h>
> > > > > +
> > > > > +static u8 pri_bits __ro_after_init = 5;
> > > > > +
> > > > > +#define GICV5_IRQ_PRI_MASK	0x1f
> > > > > +#define GICV5_IRQ_PRI_MI	(GICV5_IRQ_PRI_MASK & GENMASK(4, 5 - pri_bits))
> > > > > +
> > > > > +#define PPI_NR	128
> > > > > +
> > > > > +static bool gicv5_cpuif_has_gcie(void)
> > > > > +{
> > > > > +	return this_cpu_has_cap(ARM64_HAS_GICV5_CPUIF);
> > > > > +}
> > > > > +
> > > > > +struct gicv5_chip_data {
> > > > > +	struct fwnode_handle	*fwnode;
> > > > > +	struct irq_domain	*ppi_domain;
> > > > > +};
> > > > > +
> > > > > +static struct gicv5_chip_data gicv5_global_data __read_mostly;    
> > > >     
> > > > > +static void gicv5_hwirq_eoi(u32 hwirq_id, u8 hwirq_type)
> > > > > +{
> > > > > +	u64 cddi = hwirq_id | FIELD_PREP(GICV5_GIC_CDDI_TYPE_MASK, hwirq_type);    
> > > > 
> > > > Slight preference for not needing to care where hwirq_id goes in CDDI or how big
> > > > it is (other than when I checked the header defines).
> > > >  
> > > > 	u64 cddi = FIELD_PREP(GICV5_GIC_CDDI_ID_MASK, hwirq_id) |
> > > >         	   FIELD_PREP(GICV5_GIC_CDDI_TYPE_MASK, hwirq_type);
> > > > 
> > > >     
> > > > > +
> > > > > +	gic_insn(cddi, CDDI);
> > > > > +
> > > > > +	gic_insn(0, CDEOI);
> > > > > +}    
> > > >     
> > > > > +static int gicv5_ppi_irq_get_irqchip_state(struct irq_data *d,
> > > > > +					   enum irqchip_irq_state which,
> > > > > +					   bool *state)
> > > > > +{
> > > > > +	u64 hwirq_id_bit = BIT_ULL(d->hwirq % 64);
> > > > > +
> > > > > +	switch (which) {
> > > > > +	case IRQCHIP_STATE_PENDING:
> > > > > +		*state = !!(read_ppi_sysreg_s(d->hwirq, PPI_PENDING) & hwirq_id_bit);    
> > > > 
> > > > Technically don't need the !! but if you really like it I don't mind that much.
> > > >     
> > > > > +		return 0;
> > > > > +	case IRQCHIP_STATE_ACTIVE:
> > > > > +		*state = !!(read_ppi_sysreg_s(d->hwirq, PPI_ACTIVE) & hwirq_id_bit);
> > > > > +		return 0;
> > > > > +	default:
> > > > > +		pr_debug("Unexpected PPI irqchip state\n");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +}    
> > > > 
> > > >     
> > > > > +static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
> > > > > +					  struct irq_fwspec *fwspec,
> > > > > +					  irq_hw_number_t *hwirq,
> > > > > +					  unsigned int *type)
> > > > > +{
> > > > > +	if (!is_of_node(fwspec->fwnode))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (fwspec->param_count < 3)    
> > > > 
> > > > I don't care that much, but could relax this seeing as fwspec->param[2]
> > > > isn't used anyway? Maybe a tiny comment on why it matters?
> > > >     
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	*hwirq = fwspec->param[1];
> > > > > +
> > > > > +	/*
> > > > > +	 * Handling mode is hardcoded for PPIs, set the type using
> > > > > +	 * HW reported value.
> > > > > +	 */
> > > > > +	*type = gicv5_ppi_irq_is_level(*hwirq) ? IRQ_TYPE_LEVEL_LOW : IRQ_TYPE_EDGE_RISING;
> > > > > +
> > > > > +	return 0;    
> > > > 
> > > >     
> > > > > +static int __init gicv5_of_init(struct device_node *node, struct device_node *parent)
> > > > > +{
> > > > > +	int ret = gicv5_init_domains(of_fwnode_handle(node));
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	gicv5_set_cpuif_pribits();
> > > > > +
> > > > > +	ret = gicv5_starting_cpu(smp_processor_id());
> > > > > +	if (ret)
> > > > > +		goto out_dom;
> > > > > +
> > > > > +	ret = set_handle_irq(gicv5_handle_irq);
> > > > > +	if (ret)
> > > > > +		goto out_int;
> > > > > +
> > > > > +	return 0;
> > > > > +
> > > > > +out_int:
> > > > > +	gicv5_cpu_disable_interrupts();
> > > > > +out_dom:
> > > > > +	gicv5_free_domains();    
> > > > 
> > > > Naming is always tricky but I'd not really expect gicv5_free_domains() as the
> > > > pair of gicv5_init_domains() (which is doing creation rather than just initializing).
> > > > 
> > > > Ah well, names are never prefect and I don't really mind.
> > > >     
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +IRQCHIP_DECLARE(gic_v5, "arm,gic-v5", gicv5_of_init);    
> > > >     
> > >   
> >   


