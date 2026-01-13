Return-Path: <linux-pci+bounces-44603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B9D1868A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CDC031A3CF9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6E38B9B4;
	Tue, 13 Jan 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZmfJJdZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5265389DF0;
	Tue, 13 Jan 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302303; cv=none; b=EGfq87qAnyzrkI6c0p+Z/FhHqpHaz5lyQJohHO2OXqY4SaEjfwBbx/pqrahGcIPLtXpAqQt6ZDDpKFHpyiXQJ39lRWma0uWHMu89sj9BhyK45ry7P0n/e+ZL/452SHDp4+6FkqZUyn3e+DGkj6N8DQCxuDukCjHLb0wTaJz5/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302303; c=relaxed/simple;
	bh=qg86Xa1BLPdLqzTfJA9tqL801nqutncRfii4YJPEuuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f46Xl3fEWR+KLHs1gamuF9Bcx6p9RwMQd5wL3zwdM3p34qv62BrddW1yMFlBsM10B6BRKYmdf3Hkmcv9EKZvdHhR6m3ygQ07L0HRe7nssah7Ur3VGySTZZ/FHTZXSTAwMrH0+FFP6i0ORd7IhnpPO524x5uCo849SDPxfucLKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZmfJJdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359CC16AAE;
	Tue, 13 Jan 2026 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768302303;
	bh=qg86Xa1BLPdLqzTfJA9tqL801nqutncRfii4YJPEuuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZmfJJdZF3SDe6dB4zuSGHvr3idM7pNiaM0Yf3tA0tz//+ULA9M+2rq3ES3aN9jPv
	 DcrQ7w4O3nQcEhUG4dg/9+Z5uwRo0a2dlM5HQRcbyKKGWB6L39HIOYdXFHaYPl6tWF
	 PGN2b+vhbVsz+5NbNgXHKd1kDeyGshgCrtDMQm5/9YEimzAz4O7Hpnm6ufTRbRZhMf
	 AA36UqMNCo7RsjFG37oC5Sz1b07qteosje7epoYgcgSW3rRoIGwkH9rJyjprKq7Oq+
	 yf9qfMvKVOh74QaKMR2Jkyti4LLdmHCZXdauGr+Q4b4MKj5jOJFDrx5mqd5Ko3nZlP
	 md6e1ml1t719A==
Date: Tue, 13 Jan 2026 12:04:57 +0100
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
Message-ID: <aWYm2Y8yzns7n8fM@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <20251218-gicv5-host-acpi-v2-3-eec76cd1d40b@kernel.org>
 <20260105120108.00002016@huawei.com>
 <aV4gH/yHaOmOtK0J@lpieralisi>
 <20260107100452.00004b6f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107100452.00004b6f@huawei.com>

On Wed, Jan 07, 2026 at 10:04:52AM +0000, Jonathan Cameron wrote:

[...]

> > > > +static inline
> > > > +struct fwnode_handle *irq_domain_alloc_named_fwnode_parent(const char *name,
> > > > +							   struct fwnode_handle *parent)  
> > > 
> > > The name of this makes me think it's allocating the named fwnode parent, rather that
> > > the named fwnode + setting it's parent.
> > > 
> > > There aren't all that many calls to irq_domain_named_fwnode(), maybe to avoid challenge
> > > of a new name, just add the parameter to all of them? (25ish)  Mind you the current
> > > pattern for similar cases is a helper, so maybe not.  
> > 
> > Similar cases ? Have you got anything specific I can look into ?
> 
> I meant all the different irq_domain_alloc_xxxxx variants that call
> __irq_domain_alloc_fwnode() with a subset of parameters set to NULL.
> 
> That seems to say there is a precedence for making the presence of the parameter
> part of the name rather than requiring callers to set the ones they don't want to
> NULL.  So it argues for a helper like this one just for consistency.
> 
> > 
> > > Or go with something similar to named and have
> > > 
> > > irq_domain_alloc_named_parented_fwnode()?  

Right, given that Thomas is fine with it, I will go with this suggestion then
albeit it is getting a bit cumbersome (_named_id_parented_fwnode..), it should
be fine and I can rework the code to add a parent field to the existing interface
later if we feel it is nicer.

Thanks,
Lorenzo

> > 
> > Or I can add a set_parent() helper (though that's a bit of churn IMO) ?
> > 
> > If Thomas has a preference I will follow that, all of the above is doable
> > for me.
> 
> Agreed. Let's see what Thomas prefers (i.e. make the decision his problem ;)
> 
> Jonathan
> 
> > 
> > > I'm not that bothered though if you think the current naming is the best we can do.  
> > 
> > I think you have a point - as per my comment above.
> > 
> > Thanks,
> > Lorenzo
> > 
> > > Jonathan
> > >   
> > > > +{
> > > > +	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, parent);
> > > >  }  
> > > 
> > >   
> > 
> 

