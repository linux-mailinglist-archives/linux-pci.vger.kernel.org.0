Return-Path: <linux-pci+bounces-44167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72ECFD18B
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B687C3011EE0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6D301010;
	Wed,  7 Jan 2026 10:05:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9B35975;
	Wed,  7 Jan 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780307; cv=none; b=rE9eFKY98W8uFPSbTCOXgZMip6u9fSTQBX+eDX+pUOZBB6h9MqL6DNnhdTzpukyF7Tf8SkGO4DwBZ5auOX7cWDRUUxysrFqTHmBQhSdQK7OJ1i8/sY5dRACziKCZ3uAsXvvEo545I782dxYwPW4QLFCRCTGZeWjnhkqPcf7aYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780307; c=relaxed/simple;
	bh=lWWZJRAbEF6l2cm/20EgNwcIJKjs/oxEPtr5POOy7Pk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEDJmI3wg3/lGqrOEJMO+z8QAiyPcsEiOcD7DlHg8vlj1abB/7tp2yf/Tn7T0JQOeILgHtmMFSdKXdIJKgh6r7AAbwbRsVvGf0iEH4rKPZx3pJqtIjpiKHyUZV67FWvBbTpR+Z30VUHIxZYE3UQ3XeW2MfJ7EQJIXAGb+gg3J9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dmNtr3skPzJ46DQ;
	Wed,  7 Jan 2026 18:04:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D57B40565;
	Wed,  7 Jan 2026 18:04:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 7 Jan
 2026 10:04:54 +0000
Date: Wed, 7 Jan 2026 10:04:52 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Marc
 Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] irqdomain: Add parent field to struct
 irqchip_fwid
Message-ID: <20260107100452.00004b6f@huawei.com>
In-Reply-To: <aV4gH/yHaOmOtK0J@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
	<20251218-gicv5-host-acpi-v2-3-eec76cd1d40b@kernel.org>
	<20260105120108.00002016@huawei.com>
	<aV4gH/yHaOmOtK0J@lpieralisi>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 7 Jan 2026 09:58:07 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> On Mon, Jan 05, 2026 at 12:01:08PM +0000, Jonathan Cameron wrote:
> > On Thu, 18 Dec 2025 11:14:29 +0100
> > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >   
> > > The GICv5 driver IRQ domain hierarchy requires adding a parent field to
> > > struct irqchip_fwid so that core code can reference a fwnode_handle parent
> > > for a given fwnode.
> > > 
> > > Add a parent field to struct irqchip_fwid and update the related kernel API
> > > functions to initialize and handle it.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Marc Zyngier <maz@kernel.org>  
> > Hi Lorenzo,
> > 
> > Happy new year.  
> 
> Happy New Year !
> 
> > > ---
> > >  include/linux/irqdomain.h | 30 ++++++++++++++++++++++++++----
> > >  kernel/irq/irqdomain.c    | 14 +++++++++++++-
> > >  2 files changed, 39 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> > > index 62f81bbeb490..b9df84b447a1 100644
> > > --- a/include/linux/irqdomain.h
> > > +++ b/include/linux/irqdomain.h
> > > @@ -257,7 +257,8 @@ static inline void irq_domain_set_pm_device(struct irq_domain *d, struct device
> > >  
> > >  #ifdef CONFIG_IRQ_DOMAIN
> > >  struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
> > > -						const char *name, phys_addr_t *pa);
> > > +						const char *name, phys_addr_t *pa,
> > > +						struct fwnode_handle *parent);
> > >  
> > >  enum {
> > >  	IRQCHIP_FWNODE_REAL,
> > > @@ -267,18 +268,39 @@ enum {
> > >  
> > >  static inline struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
> > >  {
> > > -	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL);
> > > +	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, NULL);
> > > +}
> > > +
> > > +static inline
> > > +struct fwnode_handle *irq_domain_alloc_named_fwnode_parent(const char *name,
> > > +							   struct fwnode_handle *parent)  
> > 
> > The name of this makes me think it's allocating the named fwnode parent, rather that
> > the named fwnode + setting it's parent.
> > 
> > There aren't all that many calls to irq_domain_named_fwnode(), maybe to avoid challenge
> > of a new name, just add the parameter to all of them? (25ish)  Mind you the current
> > pattern for similar cases is a helper, so maybe not.  
> 
> Similar cases ? Have you got anything specific I can look into ?

I meant all the different irq_domain_alloc_xxxxx variants that call
__irq_domain_alloc_fwnode() with a subset of parameters set to NULL.

That seems to say there is a precedence for making the presence of the parameter
part of the name rather than requiring callers to set the ones they don't want to
NULL.  So it argues for a helper like this one just for consistency.

> 
> > Or go with something similar to named and have
> > 
> > irq_domain_alloc_named_parented_fwnode()?  
> 
> Or I can add a set_parent() helper (though that's a bit of churn IMO) ?
> 
> If Thomas has a preference I will follow that, all of the above is doable
> for me.

Agreed. Let's see what Thomas prefers (i.e. make the decision his problem ;)

Jonathan

> 
> > I'm not that bothered though if you think the current naming is the best we can do.  
> 
> I think you have a point - as per my comment above.
> 
> Thanks,
> Lorenzo
> 
> > Jonathan
> >   
> > > +{
> > > +	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, parent);
> > >  }  
> > 
> >   
> 


