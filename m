Return-Path: <linux-pci+bounces-17068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE409D231D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 11:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86A2283581
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E941C1AD1;
	Tue, 19 Nov 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XO45J2ln"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66731C1F38
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011093; cv=none; b=fkuD3lkbiaBy9HxauNTxLXd42GC10xY0B5IIYdZzN5SuXhLDnMF96lUO8z7kGotqlN/qlz1wVw780vOYeD/JBvL/1Ofpv2AbWMKIvshUYfyV6AKcTA+K9xxbUgPfr2iPEV2lDQhv7Ym3P+ygY3oJrHXhbjdtigObCkcONN3Q1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011093; c=relaxed/simple;
	bh=PlG7ajC4HIproRyok2uR0kaxQChqGXyTvCvbDgTqby8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVue3tvrlT5ZUzkYZUBSn3ROzG4bbY3R8YvbN2mco2bCXD0FZdl3e8uixpWZjwGHgk7xSZCHl/4Lbm7V+Evzsj0xQ0nASDNrEKa1/eUj/7tP1LU5v0ah2D9bXtejtj4CS62VRn8VrCWK2NvUxPZBN8v4kiZQpvu2l583r25MQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XO45J2ln; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724a96f188cso1077611b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732011090; x=1732615890; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CnyTQoucjCJF6wmIwhYG5inOePLfmtO8FEJdC34/wtE=;
        b=XO45J2ln9NbAgnYcH1F4P1ICNplmt/ih/3Ylv4rdxbfib6tMVaMDTmJTmpTodC4ms0
         6nTMHUgUzzQcNnJEjOvKDj8jLt4pbR8NpmPRvKPyhfRJFLBsh9pnbxCgffOJ6IRpF6Ur
         BVIGIJSWJ9NLGf1ierBxN/iFs+fRvj3wDfzVX2LvcveFUMftFzBNf8X1B0rtf2Q0bN5h
         BXivYQJd1AB10Kra2zukpsclzW0L8rUQSRl4oyYlYqDi2kh9dB1UySWeG++KCSTlgmQW
         gf3bE09B203NZjhQr9yCGNblRq8L3Dk0Q5LdHiCMg6QzHrY1rIlkhPStejsB18VzIA/i
         8TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011090; x=1732615890;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnyTQoucjCJF6wmIwhYG5inOePLfmtO8FEJdC34/wtE=;
        b=kNCBWUEar3/2/1Uc19lhGr80BWTCfxMpOmO8OjtXp5LH2MX5nDEcANS16VJV8n/31+
         qr+AIKljpnnhkEU6Eau0zT9HqLQORq8K24TejI9fuoCbW9S0qf6prqirAVsWn0rMTRRs
         UVaUSsxZ8YfiHbaivAtJPrnr9fClNHXmDMN2GOPetByvE3A8CehnRad6s7esp5a0QHnk
         RjxswN9S0K7FaC4IMoEEM7f4BiwprRi/6fqBRQnnBvv5HEzG0pmM00qm4RHQ9z5zuAWM
         ZkSlheKqbHFJAQFASWUuPAUb0WIP2JpAUwKmW2ig9FI+NI17uZ1chpiUVOowulJInDt1
         nGAw==
X-Forwarded-Encrypted: i=1; AJvYcCWrFnrpPoLrdLgpbSXDAwfOgEQG1vg47X1eTQCl6vSA6Kd/SwVo9enrWKRWKJr4Km4+RS0o+uWEDa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHd76BVGQD2Gakzr3b0bOQMa36mBWuY7ibAsf3E49COxkPyLZW
	xPtKpxvAg+V+WJQqbS3lS7RtnIFx4feBDpNoThLl47g/BhuWfVSmbOhStFwW7g==
X-Google-Smtp-Source: AGHT+IESlkjEE6zH0kn+oCxIKUTmqhbcdMhskn/HWsahaCPc0PrMTVIaTfJQLiOkn57Z+JD1MOMz3Q==
X-Received: by 2002:a05:6a00:9294:b0:71d:f15e:d026 with SMTP id d2e1a72fcca58-72476b7271emr20918708b3a.3.1732011090344;
        Tue, 19 Nov 2024 02:11:30 -0800 (PST)
Received: from thinkpad ([117.213.96.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477120a13sm8051655b3a.60.2024.11.19.02.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:11:29 -0800 (PST)
Date: Tue, 19 Nov 2024 15:41:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v7 2/7] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Message-ID: <20241119101121.t4kaaeuvj37scmxm@thinkpad>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
 <20241029-pci_fixup_addr-v7-2-8310dc24fb7c@nxp.com>
 <20241115175148.tqzqiv53mccz52tq@thinkpad>
 <ZzeejnBC4KrJoHqm@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzeejnBC4KrJoHqm@lizhi-Precision-Tower-5810>

On Fri, Nov 15, 2024 at 02:18:38PM -0500, Frank Li wrote:

[...]

> > > +		if (pci->using_dtbus_info) {
> > > +			index = of_property_match_string(np, "reg-names", "config");
> > > +			if (index < 0)
> > > +				return -EINVAL;
> > > +			/*
> > > +			 * Retrieve the parent bus address of PCI config space.
> > > +			 * If the parent bus ranges in the device tree provide
> > > +			 * the correct address conversion information, set
> > > +			 * 'using_dtbus_info' to true, The 'cpu_addr_fixup()'
> > > +			 * can be eliminated.
> > > +			 */
> >
> > Nobody will switch to 'ranges' property if you mention it in comments. We
> > usually add dev_warn_once() to print a warning for broken DT so that the users
> > will try to fix it. You can use below diff (as a separate patch ofc):
> >
> > ```
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 6d6cbc8b5b2c..d1e5395386fe 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -844,6 +844,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >                  dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
> >                  pci->num_ob_windows, pci->num_ib_windows,
> >                  pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
> > +
> > +       if (pci->ops && pci->ops->cpu_addr_fixup)
> > +               dev_warn_once(pci->dev, "Broken \"ranges\" property detected. Please fix DT!\n");
> 
> How about "Detect use old method "cpu_addr_fixup()", it should correct DT's
> 'ranges' and remove cpu_addr_fixup()?
> 

Hmm, yeah makes sense:

	/*
	 * If the parent 'ranges' property in DT correctly describes the address
	 * translation, cpu_addr_fixup() callback is not needed.
	 */
	dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n";

But then the drivers need to be smart enough to detect the valid parent 'ranges'
property and then only use the callback. Because, callback has to be present to
support older DTs.

> >  }
> >
> >  static u32 dw_pcie_readl_dma(struct dw_pcie *pci, u32 reg)
> > ```
> >
> > > +			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
> >
> > Can you explain what is going on here?
> 
> Because dwc use reg-name 'config' to get config space,
> of_property_read_reg() will get untranslate address 'parent' bus address.
> <0x8ff00000 0x80000> at example address.
> 
> cfg0_base is used to set outbound ATU.
> 

Ok, please add a comment like this:

	/* Get the untranslated 'config' address */

Same for other usage of of_property_read_reg().

> >
> > > +		}
> > > +
> > >  		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> > >  		if (IS_ERR(pp->va_cfg0_base))
> > >  			return PTR_ERR(pp->va_cfg0_base);
> > > @@ -462,6 +505,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >  		pp->io_base = pci_pio_to_address(win->res->start);
> > >  	}
> > >
> > > +	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
> > > +		return -ENODEV;
> >
> > Use actual return value here and below.
> >
> > > +
> > >  	/* Set default bus ops */
> > >  	bridge->ops = &dw_pcie_ops;
> > >  	bridge->child_ops = &dw_child_pcie_ops;
> > > @@ -722,6 +768,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >
> > >  	i = 0;
> > >  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> > > +		resource_size_t parent_bus_addr;
> > > +
> > >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > >  			continue;
> > >
> > > @@ -730,9 +778,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >
> > >  		atu.index = i;
> > >  		atu.type = PCIE_ATU_TYPE_MEM;
> > > -		atu.cpu_addr = entry->res->start;
> > > +		parent_bus_addr = entry->res->start;
> > >  		atu.pci_addr = entry->res->start - entry->offset;
> > >
> > > +		if (dw_pcie_get_untranslate_addr(pci, entry->res->start, &parent_bus_addr))
> > > +			return -EINVAL;
> > > +
> > > +		atu.cpu_addr = parent_bus_addr;
> > > +
> > >  		/* Adjust iATU size if MSG TLP region was allocated before */
> > >  		if (pp->msg_res && pp->msg_res->parent == entry->res)
> > >  			atu.size = resource_size(entry->res) -
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 347ab74ac35aa..f8067393ad35a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -463,6 +463,14 @@ struct dw_pcie {
> > >  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> > >  	struct gpio_desc		*pe_rst;
> > >  	bool			suspended;
> > > +	/*
> > > +	 * Use device tree 'ranges' property of bus node instead using
> > > +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> > > +	 * reflect real hardware's behavior. In case break these platform back
> > > +	 * compatibility, add below flags. Set it true if dts already correct
> > > +	 * indicate bus fabric address convert.
> >
> > 	/*
> > 	 * This flag indicates that the vendor driver uses devicetree 'ranges'
> > 	 * property to allow iATU to use the Intermediate Address (IA) for
> > 	 * outbound mapping. Using this flag also avoids the usage of
> > 	 * 'cpu_addr_fixup' callback implementation in the driver.
> > 	 */
> >
> > > +	 */
> > > +	bool			using_dtbus_info;
> >
> > 'use_dt_ranges'?
> 
> It will be confused because pcie node alreadys use ranges, just parent bus
> 's ranges is wrong.
> 
> 'use_dtbus_ranges' ?
> 

There is nothing called 'dtbus'. How about, "use_parent_dt_ranges"?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

