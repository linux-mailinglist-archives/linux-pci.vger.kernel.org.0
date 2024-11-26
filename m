Return-Path: <linux-pci+bounces-17306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9549D90FE
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 05:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96EF168995
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 04:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D358222;
	Tue, 26 Nov 2024 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gni/sJ8F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29153AC2B
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732594753; cv=none; b=dHsdlYazBT7gW5ycHJk7bwF0OiJSWbJqzPHv+aEf+j78esyWe+D+vPqL2xXnTLcq3DdjOMP0G9jjjCe+Sh/S0bzl4u6Db139+oUTH18P387+CDMEsg8OAyhOyGmDJCGHnF/1zb3mqVHA97nS60zjClMz9pj5lYWOTfs5yS7jyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732594753; c=relaxed/simple;
	bh=djTrfHJy2jTW0h23W9EMmSGyU5NeeZFYyDVmlB+tCAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6Z3bTjO8I/1z0VPFh93Oyu1ja9rg1eJ98m1dE8hOhb2wt+RGE09HJeBYYiakZmCPxpyyIj28ARV+tN34vyf86dTS/02Godew10y56j45bJdJZFjUsnXHNa+vfaugVyoDF2gTmHVXlelhUOY07sxkFLKVjWRqaTY3qgBEuK5n+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gni/sJ8F; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ea68cd5780so4377160a91.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2024 20:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732594751; x=1733199551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32yv9U3MHbKA5g6SKYOspudfpgCw+b2fRyb6d+JDStw=;
        b=Gni/sJ8FQWvLEHQZXTxbgRK7M+NHmZrGXYRmD9BpVy5B1gbkGMU/pnIGYxq0dzqljP
         RlVIVumv8AHift7PHAW2Wu2eYT6BUuIa4uXNVHkOees63Py+4HiIwllAGzcejiet76HL
         /YkGUT11jFjPLlMN9BmkkA+KXO7izNfKVee5b2LVUJeW4Tye0y+SwpJAOjGXTwArVc+W
         M+t4JDkFylKpV+LWb5XDt+W5sXtnYBguqk9U9XdjjkFFjOVUf5t84E1Ta9tp0x9my3yk
         tR3fJbQKg+clQAaT831ULvTOGDKLGwV1k55cBg4EfjHprxF9VJhszFcLJTt1VDvQMdFL
         xF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732594751; x=1733199551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32yv9U3MHbKA5g6SKYOspudfpgCw+b2fRyb6d+JDStw=;
        b=TFomt3VA20OXs/fzNGsyStFFn3o/GCWwNZbkNDnwQudTmufFPslu3bt0ti2r2+7hR+
         sHb0L6iIi5vLwjGYtEWpip2P9Eo1U3AbnwnaEm6OooV+Knr12/+tugQ8eCQyPFlWXA5P
         AQ+gibmevKGYvMpGb6C9y1wxe0lDl10NLbyjrun5KvGsOJV5UzLuLxh2cDoy3jhsVSJf
         l88+4oH8lxDRt7gT2lRMrcr71+6qKOLLnwYcuMT4+8pZoc0dhgLHrpc1vmkQO1lakHnF
         JUV8vOgqF4OVkkpTr1Z/b6nPishWy1WFCffH8Xbv+7NIMS+5smu06Tsh5U7lJxz1aKxU
         OfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5QTUQVyTQOTzLKccaFMmFccmN/zPp5B3uHsNdhLz99zQDCUgFpceIowV+ey4yxx5zE4togSjU650=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fNhyglZkd78alYsoL+ClxUNFmP8jNkVXmkkrbNJ5uQR73u0y
	hMlWntnB0BL9Zs7HV1cc1uGBRFqQYG0hMvO/giIOlO4nIRNCox3b+JgHLaPuow==
X-Gm-Gg: ASbGncvkYeYXqcpFmgQrC0kRAV9wbUvKEOr8yCJxOtPQzUUJHxlyJ/VCIPRXlpd+EFX
	PTJz3LdQ9HRa2eptqX02tv956d+iYwhIWcpua25SE/lwaHEc3jwl4TRKh+PDiGsZrOiuSR3pqXQ
	XTf7WAfaPIK8QXHf1xWlvP9e+QwzigeSS1t6xF9Rla1s/5iuT3sjpOmTcUk+UP0LsRkRQ9zfEal
	892k8CYGT/hVHuodNAv8C+5mX1pZsKjdeX7RA+SAb+RG+sNICKimZzYtP+T+Kw=
X-Google-Smtp-Source: AGHT+IE+yzC0PaH3Y6jUjXUzf8RGMvfOIBBzrsutyUt5UIDXb1PN+T6ar+55HRfv+bWkSxgmJ6EbtQ==
X-Received: by 2002:a17:90b:4a51:b0:2ea:4e67:5638 with SMTP id 98e67ed59e1d1-2eb0e884761mr19717246a91.35.1732594751012;
        Mon, 25 Nov 2024 20:19:11 -0800 (PST)
Received: from thinkpad ([220.158.156.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea3f4sm11254028a91.5.2024.11.25.20.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:19:10 -0800 (PST)
Date: Tue, 26 Nov 2024 09:49:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <20241126041903.lq6zunvzoc2mmgbl@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-3-6f1f68ffd1bb@nxp.com>
 <20241124073239.5yl5zsmrrcrhmibh@thinkpad>
 <Z0TOb0ErwuGQwF8G@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0TOb0ErwuGQwF8G@lizhi-Precision-Tower-5810>

On Mon, Nov 25, 2024 at 02:22:23PM -0500, Frank Li wrote:
> On Sun, Nov 24, 2024 at 01:02:39PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Nov 16, 2024 at 09:40:43AM -0500, Frank Li wrote:
> > > Introduce the helper function pci_epf_align_addr() to adjust addresses
> >
> > pci_epf_align_inbound_addr()?
> >
> > > according to PCI BAR alignment requirements, converting addresses into base
> > > and offset values.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change from v7 to v8
> > > - change name to pci_epf_align_inbound_addr()
> > > - update comment said only need for memory, which not allocated by
> > > pci_epf_alloc_space().
> > >
> > > change from v6 to v7
> > > - new patch
> > > ---
> > >  drivers/pci/endpoint/pci-epf-core.c | 45 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/pci-epf.h             | 14 ++++++++++++
> > >  2 files changed, 59 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > index 8fa2797d4169a..4dfc218ebe20b 100644
> > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > @@ -464,6 +464,51 @@ struct pci_epf *pci_epf_create(const char *name)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epf_create);
> > >
> > > +/**
> > > + * pci_epf_align_inbound_addr() - Get base address and offset that match bar's
> >
> > BAR's
> >
> > > + *			  alignment requirement
> > > + * @epf: the EPF device
> > > + * @addr: the address of the memory
> > > + * @bar: the BAR number corresponding to map addr
> > > + * @base: return base address, which match BAR's alignment requirement, nothing
> > > + *	  return if NULL
> >
> > Below, you are updating 'base' only if it is not NULL. Why would anyone call
> > this API with 'base' and 'offset' set to NULL?
> 
> Some time, they may just want one of two.
> 

What would be the purpose? I fail to see it.

> >
> > > + * @off: return offset, nothing return if NULL
> > > + *
> > > + * Helper function to convert input 'addr' to base and offset, which match
> > > + * BAR's alignment requirement.
> > > + *
> > > + * The pci_epf_alloc_space() function already accounts for alignment. This is
> > > + * primarily intended for use with other memory regions not allocated by
> > > + * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
> > > + * address for a platform MSI controller.
> > > + */
> > > +int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> > > +			       u64 addr, u64 *base, size_t *off)
> > > +{
> > > +	const struct pci_epc_features *epc_features;
> > > +	u64 align;
> > > +
> > > +	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
> > > +	if (!epc_features) {
> > > +		dev_err(&epf->dev, "epc_features not implemented\n");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	align = epc_features->align;
> > > +	align = align ? align : 128;
> > > +	if (epc_features->bar[bar].type == BAR_FIXED)
> > > +		align = max(epc_features->bar[bar].fixed_size, align);
> > > +
> > > +	if (base)
> > > +		*base = round_down(addr, align);
> > > +
> > > +	if (off)
> > > +		*off = addr & (align - 1);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
> > > +
> > >  static void pci_epf_dev_release(struct device *dev)
> > >  {
> > >  	struct pci_epf *epf = to_pci_epf(dev);
> > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > index 5374e6515ffa0..eff73ccb5e702 100644
> > > --- a/include/linux/pci-epf.h
> > > +++ b/include/linux/pci-epf.h
> > > @@ -238,6 +238,20 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> > >  			  enum pci_epc_interface_type type);
> > >  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> > >  			enum pci_epc_interface_type type);
> > > +
> > > +int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> > > +			       u64 addr, u64 *base, size_t *off);
> > > +static inline int pci_epf_align_inbound_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
> > > +						   u32 low, u32 high, u64 *base, size_t *off)
> >
> > Why can't you just use pci_epf_align_inbound_addr() directly? Or the caller
> > could pass u64 address directly.
> 
> 
> msi message sperate low32 and high32.  (h << 32 | low) is quite easy to
> cause build warning.  it should be ((u64) h << 32) | low. Avoid copy this
> logic code at many EPF places.
> 

There is absolutely no overhead in doing so. Also the concern for me is,
pci_epf_align_inbound_addr() is exported but only used within
pci_epf_align_inbound_addr_lo_hi(). This causes confusion. So I'd prefer to have
a single exported API that is used by the callers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

