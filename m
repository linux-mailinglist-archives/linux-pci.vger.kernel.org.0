Return-Path: <linux-pci+bounces-30348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49167AE372C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E72C3AB07F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA581F542E;
	Mon, 23 Jun 2025 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHl251/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BA1957FF;
	Mon, 23 Jun 2025 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664643; cv=none; b=Xh2xaOgWv6KJsmoHpNm8Opk0wha6k0p3F0xytMb8VhVa13QVq7lntN8f+qnTVhZvEp3xLccsd4QUNC5tI8Gg3Q4+BLmdTFMaBre+P3ighfiY6a2uRYiRP+3ytHB6+4j+bwXPTuxgXcZ9RJ93ThT1IU6F9PyXjSpwxfFwS96aVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664643; c=relaxed/simple;
	bh=FvVZWSxbxCHHvArP/ksDKZe8srWR5WNbNBaWxp4Q1Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghNlQWGTZIj/SmVzEbRgaPPByCiyhZXO9yGDRryFGxmBkce//CYFMZehM2zUOokIavcSi10aYe3cr5hTi6gu1hA0Z99L0nivOV29eJmB2XIWki6VQwSYZym7XOF6gCMzi0nWDNkoaOecErhUaPRmMKlwy0hv76SSQu1YYd6+BVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHl251/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177E5C4CEED;
	Mon, 23 Jun 2025 07:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750664642;
	bh=FvVZWSxbxCHHvArP/ksDKZe8srWR5WNbNBaWxp4Q1Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHl251/wXN40lIxPpKuiJLq7g+cRz0OPuZjvkBC/xMaROyDdQ8w4ZrZ/Jm0YFW3B0
	 mOLWWQvceF45KymGEVE7huhiVsitvfvHZoqe9cLRWhFQa1h8Xq7gyb/5t7qcKADrEK
	 XPNOJcoTrNQyyyS6RTkFIj4cWsqzhujE3Bf3xMCGOBxu1Mein/CGPhzl0rxrcglnu3
	 HiEzJCBfhvIS9si++V+jD7MCmeGmvszcG84dSFsEWCX0GVnJFRY6h9VRHWLjXjGroh
	 n/d+u4osjwOnWk+14GQaPkcuA7kpeSpmiNNkZzW+gVhdMoNGbIv3g0V1iM6jMIEOe8
	 hsFP1L+eIkm6w==
Date: Mon, 23 Jun 2025 09:43:55 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 24/27] irqchip/gic-v5: Add GICv5 ITS support
Message-ID: <aFkFu9j56S3fagHd@lpieralisi>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
 <20250618-gicv5-host-v5-24-d9e622ac5539@kernel.org>
 <87y0tmp6gn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0tmp6gn.ffs@tglx>

On Fri, Jun 20, 2025 at 09:18:32PM +0200, Thomas Gleixner wrote:
> On Wed, Jun 18 2025 at 12:17, Lorenzo Pieralisi wrote:
> >  drivers/of/irq.c                                   |   21 +
> >  drivers/pci/msi/irqdomain.c                        |   19 +
> >  include/linux/msi.h                                |    5 +
> >  include/linux/of_irq.h                             |    7 +
> 
> This are preparatory changes. Please split them out into a seperate patch.

Done. I did not do it because some maintainers require changes to
be added in the patch(es) that uses them.

> >  ...3-its-msi-parent.c => irq-gic-its-msi-parent.c} |  187 ++-
> >  drivers/irqchip/irq-gic-its-msi-parent.h           |   14 +
> >  drivers/irqchip/irq-gic-v3-its.c                   |    3 +-
> 
> Ditto, i.e. the rename and code move, not the v5 add ons.

Done.

> > +static bool its_v5_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> > +				     struct irq_domain *real_parent, struct msi_domain_info *info)
> > +{
> > +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> > +		return false;
> > +
> > +	switch (info->bus_token) {
> > +	case DOMAIN_BUS_PCI_DEVICE_MSI:
> > +	case DOMAIN_BUS_PCI_DEVICE_MSIX:
> > +		/*
> > +		 * FIXME: This probably should be done after a (not yet
> > +		 * existing) post domain creation callback once to make
> > +		 * support for dynamic post-enable MSI-X allocations
> > +		 * work without having to reevaluate the domain size
> > +		 * over and over. It is known already at allocation
> > +		 * time via info->hwsize.
> > +		 *
> > +		 * That should work perfectly fine for MSI/MSI-X but needs
> > +		 * some thoughts for purely software managed MSI domains
> > +		 * where the index space is only limited artificially via
> > +		 * %MSI_MAX_INDEX.
> 
> 
> This comment is stale after Marc moved the prepare callback into
> the domain creation, where the prepare callback gets hwsize for scaling.
> 
> The only valid caveat are software managed domains, where hwsize is
> unspecified, but that's a different problem (and not used as of today).

Right, I should have removed it. Done.

> > +		 */
> > +		info->ops->msi_prepare = its_v5_pci_msi_prepare;
> > +		info->ops->msi_teardown = its_msi_teardown;
> > +		break;
> > +	case DOMAIN_BUS_DEVICE_MSI:
> > +	case DOMAIN_BUS_WIRED_TO_MSI:
> > +		/*
> > +		 * FIXME: See the above PCI prepare comment. The domain
> > +		 * size is also known at domain creation time.
> > +		 */
> 
> See above.
> 
> > +void gicv5_irs_syncr(void)
> > +{
> > +	struct gicv5_irs_chip_data *irs_data;
> > +	u32 syncr;
> > +
> > +	irs_data = list_first_entry_or_null(&irs_nodes,
> > +					    struct gicv5_irs_chip_data, entry);
> 
> Let it stick out. You have 100 characters.

Done.

> > +	if (WARN_ON(!irs_data))
> 
> WARN_ON_ONCE() ?

Done.

> 
> > +static unsigned int gicv5_its_l2sz_to_l2_bits(unsigned int sz)
> > +{
> > +	switch (sz) {
> > +	case GICV5_ITS_DT_ITT_CFGR_L2SZ_64k:
> > +		return 13;
> > +	case GICV5_ITS_DT_ITT_CFGR_L2SZ_16k:
> > +		return 11;
> > +	case GICV5_ITS_DT_ITT_CFGR_L2SZ_4k:
> > +	default:
> > +		return 9;
> 
> Magic numbers pulled out of thin air?

I will add defines but I thought the function name would be enough to tag
the value with a meaning.

> > +static __le64 *gicv5_its_device_get_itte_ref(struct gicv5_its_dev *its_dev,
> > +					     u16 event_id)
> > +{
> > +	unsigned int l1_idx, l2_idx, l2_bits;
> > +	__le64 *l2_itt, *l1_itt;
> > +
> > +	if (!its_dev->itt_cfg.l2itt) {
> > +		__le64 *itt = its_dev->itt_cfg.linear.itt;
> > +
> > +		return &itt[event_id];
> > +	}
> > +
> > +	l1_itt = its_dev->itt_cfg.l2.l1itt;
> > +
> > +	l2_bits = gicv5_its_l2sz_to_l2_bits(its_dev->itt_cfg.l2.l2sz);
> > +
> > +	l1_idx = event_id >> l2_bits;
> > +
> > +	BUG_ON(!FIELD_GET(GICV5_ITTL1E_VALID, le64_to_cpu(l1_itt[l1_idx])));
> 
> I assume this is truly unrecoverable

At this stage, we mapped an IRQ and we are activating it, this must not
happen (like any bug out there, granted). I can remove it, I understand
it bothers you adding BUG_ON(), if something goes wrong there we will
notice.

> > +	l2_idx = event_id & GENMASK(l2_bits - 1, 0);
> > +
> > +	l2_itt = its_dev->itt_cfg.l2.l2ptrs[l1_idx];
> > +
> > +	return &l2_itt[l2_idx];
> > +}
> > +
> ....
> > +
> > +	return 0;
> > +out_free_lpi:
> 
> It's amazing. All the code has a gazillion of empty newlines, which just
> take up space and have no delimiting value. But on these error labels,
> you glue them right at the return statement (not only here, noticed that
> before).

You have a point here, will change it (and I will check other error
labels sites).

> > +	gicv5_free_lpi(lpi);
> > +out_eventid:
> > +	gicv5_its_free_eventid(its_dev, event_id_base, nr_irqs);
> > +
> > +	return ret;
> > +}
> 
> > + * Taken from msi_lib_irq_domain_select(). The only difference is that
> > + * we have to match the fwspec->fwnode parent against the domain->fwnode
> > + * in that in GICv5 the ITS domain is represented by the ITS fwnode but
> > + * the MSI controller (ie the ITS frames) are ITS child nodes.
> > + */
> > +static int gicv5_its_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
> > +				       enum irq_domain_bus_token bus_token)
> > +{
> > +	const struct msi_parent_ops *ops = d->msi_parent_ops;
> > +	u32 busmask = BIT(bus_token);
> > +
> > +	if (!ops)
> > +		return 0;
> > +
> > +	if (fwnode_get_parent(fwspec->fwnode) != d->fwnode ||
> > +	    fwspec->param_count != 0)
> > +		return 0;
> 
> Just add a MSI flag and set it in parent_ops::required_flags and extend
> the lib with
> 
>         struct fwnode_handle *fwh;
> 
>         fwh = d->flags & MAGIC ? fwnode_get_parent(fwspec->fwnode) : fwspec->fwnode;
> 
> No?

I did not know if this use case granted a new flag. You cleared my
concern.

> > diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
> > index c2e7ba7e38f7..4a0990f46358 100644
> > --- a/drivers/irqchip/irq-gic-v5.c
> > +++ b/drivers/irqchip/irq-gic-v5.c
> > @@ -57,12 +57,12 @@ static void release_lpi(u32 lpi)
> >  	ida_free(&lpi_ida, lpi);
> >  }
> >  
> > -static int gicv5_alloc_lpi(void)
> > +int gicv5_alloc_lpi(void)
> >  {
> >  	return alloc_lpi();
> >  }
> >  
> > -static void gicv5_free_lpi(u32 lpi)
> > +void gicv5_free_lpi(u32 lpi)
> >  {
> >  	release_lpi(lpi);
> >  }
> 
> Just make them global right away when you implement them. No point for
> this kind of churn.

Yes, hopefully someone will not point out that in the respective patch
the function could be static :).

Thanks a lot for your review.

Lorenzo

