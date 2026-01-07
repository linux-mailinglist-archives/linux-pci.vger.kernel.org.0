Return-Path: <linux-pci+bounces-44152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFB8CFCB29
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D178230248B6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BB2E8B94;
	Wed,  7 Jan 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3KV4wp9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B392E6CD2;
	Wed,  7 Jan 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776293; cv=none; b=klGdC5VUcwV7BGbMEEh4G4+nft+hOIOyiSEzUOGtVokvTtwe9CmARMZUpVSLCgRNKjBkvsoKgDsMHPROBXhPSdbCxvsOkOyaZHMEUl1E+kS3i7FtdWJJWBsbCCVpNnb5scnPuOxvUwc9XEilGnaPpsPHRjFCT/vHecpN1/lk+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776293; c=relaxed/simple;
	bh=YfscGlzjoPdKa2cHm3kbuvdCSUSLTviahPedm8Ok0YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7cqTVx1DDdl/YB+HdOttVdH4t2RmxuXvsadg1ARBAw6U+zYo5+zzv5Dnn67OSVVT/yw4pA6bSIQg2rD29BM+lmr2XeG3j7f0kgRnI3kRpxI7J9854x6oa9HRdo9/McOl/6Hd2S6+4iS6zKCjR2inSnscfABG5lXj+wFxyRiM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3KV4wp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA3C16AAE;
	Wed,  7 Jan 2026 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767776293;
	bh=YfscGlzjoPdKa2cHm3kbuvdCSUSLTviahPedm8Ok0YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3KV4wp9dk91PRYB7pSFMEbNdL+dcrw9T9h0nU6RHPagQoOpSwUQaA6XkF70RKuTc
	 xtM+n1DqXdbGgVpHLeptVTFwu72Nkld3CNTXiX/Gl/SY+9PZdCNwjudheqAIuSX8gQ
	 rDsEai9kpQPI/dQGZFy+mfY7cwZFOIBH7BsKpQAgi9SCqUqibD7/mr0ux9qWUL5IIf
	 CiquSLDMBiYqU0NDSwQVpQ/PndVbOsLhBcaIbCeQgv57QIR+/aevsY6w44Qfvh5xb2
	 l73d9ClDxHXKajAgoxdtaZm+L396NIIZjfxPXxUw5oBcdXAD2iHN6VAx5VcXtjbbkz
	 Qe3rWcWrHegjw==
Date: Wed, 7 Jan 2026 09:58:07 +0100
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
Subject: Re: [PATCH v2 3/7] irqdomain: Add parent field to struct irqchip_fwid
Message-ID: <aV4gH/yHaOmOtK0J@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <20251218-gicv5-host-acpi-v2-3-eec76cd1d40b@kernel.org>
 <20260105120108.00002016@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105120108.00002016@huawei.com>

On Mon, Jan 05, 2026 at 12:01:08PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 11:14:29 +0100
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> > The GICv5 driver IRQ domain hierarchy requires adding a parent field to
> > struct irqchip_fwid so that core code can reference a fwnode_handle parent
> > for a given fwnode.
> > 
> > Add a parent field to struct irqchip_fwid and update the related kernel API
> > functions to initialize and handle it.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> Hi Lorenzo,
> 
> Happy new year.

Happy New Year !

> > ---
> >  include/linux/irqdomain.h | 30 ++++++++++++++++++++++++++----
> >  kernel/irq/irqdomain.c    | 14 +++++++++++++-
> >  2 files changed, 39 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> > index 62f81bbeb490..b9df84b447a1 100644
> > --- a/include/linux/irqdomain.h
> > +++ b/include/linux/irqdomain.h
> > @@ -257,7 +257,8 @@ static inline void irq_domain_set_pm_device(struct irq_domain *d, struct device
> >  
> >  #ifdef CONFIG_IRQ_DOMAIN
> >  struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
> > -						const char *name, phys_addr_t *pa);
> > +						const char *name, phys_addr_t *pa,
> > +						struct fwnode_handle *parent);
> >  
> >  enum {
> >  	IRQCHIP_FWNODE_REAL,
> > @@ -267,18 +268,39 @@ enum {
> >  
> >  static inline struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
> >  {
> > -	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL);
> > +	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, NULL);
> > +}
> > +
> > +static inline
> > +struct fwnode_handle *irq_domain_alloc_named_fwnode_parent(const char *name,
> > +							   struct fwnode_handle *parent)
> 
> The name of this makes me think it's allocating the named fwnode parent, rather that
> the named fwnode + setting it's parent.
> 
> There aren't all that many calls to irq_domain_named_fwnode(), maybe to avoid challenge
> of a new name, just add the parameter to all of them? (25ish)  Mind you the current
> pattern for similar cases is a helper, so maybe not.

Similar cases ? Have you got anything specific I can look into ?

> Or go with something similar to named and have
> 
> irq_domain_alloc_named_parented_fwnode()?

Or I can add a set_parent() helper (though that's a bit of churn IMO) ?

If Thomas has a preference I will follow that, all of the above is doable
for me.

> I'm not that bothered though if you think the current naming is the best we can do.

I think you have a point - as per my comment above.

Thanks,
Lorenzo

> Jonathan
> 
> > +{
> > +	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, parent);
> >  }
> 
> 

