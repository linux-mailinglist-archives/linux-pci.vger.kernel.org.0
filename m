Return-Path: <linux-pci+bounces-38895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E85BF68CE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F6C18A74F8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166B32B9B4;
	Tue, 21 Oct 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRjJ+BvE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA5322C99;
	Tue, 21 Oct 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051123; cv=none; b=YRnxlYjEPqXwkRLZfAPQwam/7XMADkdrNFyFqbRfnF+G27xTmcJSz1jwnGdAJOLNKkKkK7aVvjHcFCoFRXVe8o1qnmaH2fVXl97xTSC+AUHV6NJKvcwAd0MvZzD1daCcVSbdtHce8pIuC2qAcc3vqd+I/eVHZywrarRhqsK3Ipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051123; c=relaxed/simple;
	bh=xl5f2KWZjnQ0VT+pwG5gNrmtrc3seJnlxSjRbDKcWN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLSMwmxktW4CPuMCtL46n+7cYpjL4ofSesrk87F3iMU3469icif5OXuO2VuziyHUNjB1be2XSQcnYxU2MvQIv3O5ZLfe6XmhB8daqISnDvzPMrL2FhHhV10ensnHeM4NORrlp/kfgPq0NEa4Wtnx0VxRU/DcAyY9G/EEw47O9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRjJ+BvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80339C4CEF1;
	Tue, 21 Oct 2025 12:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761051123;
	bh=xl5f2KWZjnQ0VT+pwG5gNrmtrc3seJnlxSjRbDKcWN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRjJ+BvEoDGSHu34gpVnNaa44gGA0cHKta96VRDLRlAf5tNR7ZIjaJ1DSPYzgxhza
	 pwhIu22SSHWCUbrb5Ywk0kena7WF6W8i3r5QZicFutmPrxn/kUAJt/822j7fMvCR8P
	 mmdltnpqYakNtNQhpJQPXt/rjU39SRIGc0AjX+RatiX5Y+MERgucXaLx4xKGPkMKT1
	 Yw1rRfN2/z9rjlcTe9GI9DEY19tHfLDpAVQqsL6oRNfXHwzPBiqVHHUXPwGwFbH26n
	 99Ux+gYEzaPkqjIvyFH/Tj3GGIELr4L5wZ6HdcBElUIn+ovpoxSOM2fI7Py/K6392r
	 jPLlXwa/DwmCw==
Date: Tue, 21 Oct 2025 14:51:55 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 1/5] of/irq: Add msi-parent check to of_msi_xlate()
Message-ID: <aPeB6wQKC27gKyQv@lpieralisi>
References: <20251017084752.1590264-1-lpieralisi@kernel.org>
 <20251017084752.1590264-2-lpieralisi@kernel.org>
 <20251021115517.GA3713879-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021115517.GA3713879-robh@kernel.org>

On Tue, Oct 21, 2025 at 06:55:17AM -0500, Rob Herring wrote:
> On Fri, Oct 17, 2025 at 10:47:48AM +0200, Lorenzo Pieralisi wrote:
> > In some legacy platforms the MSI controller for a PCI host bridge is
> > identified by an msi-parent property whose phandle points at an MSI
> > controller node with no #msi-cells property, that implicitly
> > means #msi-cells == 0.
> > 
> > For such platforms, mapping a device ID and retrieving the MSI controller
> > node becomes simply a matter of checking whether in the device hierarchy
> > there is an msi-parent property pointing at an MSI controller node with
> > such characteristics.
> > 
> > Add a helper function to of_msi_xlate() to check the msi-parent property in
> > addition to msi-map and retrieve the MSI controller node (with a 1:1 ID
> > deviceID-IN<->deviceID-OUT  mapping) to provide support for deviceID
> > mapping and MSI controller node retrieval for such platforms.
> > 
> > Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/of/irq.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> It all looks good to me other than 1 nit below. How do you propose 
> merging the series? I can take the first 3 for 6.18 and then patches 4 
> and 5 can go via their respective trees for 6.19?

Yep, though patch (3) isn't really a fix so not sure it is v6.18 material
but that's up to you.

I'd leave patch (1) brewing in -next if possible a little bit - it should
not cause any issues but it might.

> > 
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 65c3c23255b7..e67b2041e73b 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -671,6 +671,35 @@ void __init of_irq_init(const struct of_device_id *matches)
> >  	}
> >  }
> >  
> > +static int of_check_msi_parent(struct device_node *dev_node, struct device_node **msi_node)
> > +{
> > +	struct of_phandle_args msi_spec;
> > +	int ret;
> > +
> > +	/*
> > +	 * An msi-parent phandle with a missing or == 0 #msi-cells
> > +	 * property identifies a 1:1 ID translation mapping.
> > +	 *
> > +	 * Set the msi controller node if the firmware matches this
> > +	 * condition.
> > +	 */
> > +	ret = of_parse_phandle_with_optional_args(dev_node, "msi-parent", "#msi-cells",
> > +						  0, &msi_spec);
> > +	if (!ret) {
> 
> if (ret)
> 	return ret;
> 
> And then save a level of indentation.

Fixed - sent v4.

Thanks !
Lorenzo

> > +		if ((*msi_node && *msi_node != msi_spec.np) || msi_spec.args_count != 0)
> > +			ret = -EINVAL;
> > +
> > +		if (!ret) {
> > +			/* Return with a node reference held */
> > +			*msi_node = msi_spec.np;
> > +			return 0;
> > +		}
> > +		of_node_put(msi_spec.np);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * of_msi_xlate - map a MSI ID and find relevant MSI controller node
> >   * @dev: device for which the mapping is to be done.
> > @@ -678,7 +707,7 @@ void __init of_irq_init(const struct of_device_id *matches)
> >   * @id_in: Device ID.
> >   *
> >   * Walk up the device hierarchy looking for devices with a "msi-map"
> > - * property. If found, apply the mapping to @id_in.
> > + * or "msi-parent" property. If found, apply the mapping to @id_in.
> >   * If @msi_np points to a non-NULL device node pointer, only entries targeting
> >   * that node will be matched; if it points to a NULL value, it will receive the
> >   * device node of the first matching target phandle, with a reference held.
> > @@ -692,12 +721,15 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
> >  
> >  	/*
> >  	 * Walk up the device parent links looking for one with a
> > -	 * "msi-map" property.
> > +	 * "msi-map" or an "msi-parent" property.
> >  	 */
> > -	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
> > +	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
> >  		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
> >  				"msi-map-mask", msi_np, &id_out))
> >  			break;
> > +		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
> > +			break;
> > +	}
> >  	return id_out;
> >  }
> >  
> > -- 
> > 2.50.1
> > 

