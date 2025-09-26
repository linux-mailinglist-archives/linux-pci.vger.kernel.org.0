Return-Path: <linux-pci+bounces-37107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA2BA4606
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E286212FC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED511F0E56;
	Fri, 26 Sep 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWuJplue"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B81E49F;
	Fri, 26 Sep 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899824; cv=none; b=l09tUTZU9gl69JMPFN3WsPwYll5yRz4oEYaLURnvX2OmkPSvIzEoBKwEOZVtDmREakVD9pfHYweaNextK4LTBJM8xr9UNrx1XXFMYR//Opdjw9i5Z0vcwYzyJe02QKo0OcpNOOEc7Zh4ccOsg5s6fMOOx7XBUYZ6W7OgJFq2h6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899824; c=relaxed/simple;
	bh=YLMoQzOUJNaKuOTa+LoWHem/a/laxVDksgoIRV1Ffuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huNhTy5qKwe1TJl0Ar2E3wtrFsGNCEf0P9eEAdNFru7XLJNjR7rdb4WZY2hqXux63V4ZyKmd+WZAmmf1t+kZz5iXenUJuJNvSYCWNsuq9KWKuIzaCwBveeUsaG7Q/3HqHm+R8JgcBTN38OpdZpZ5CiEvMuY09GsbAnVyC8nITh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWuJplue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B939C4CEF4;
	Fri, 26 Sep 2025 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758899823;
	bh=YLMoQzOUJNaKuOTa+LoWHem/a/laxVDksgoIRV1Ffuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWuJpluex8LEXh36A5044YENdjNzk7yyT/SnfU6e1en+PSJfKgP9MZ+lEZEVZFIKt
	 Ea87xghmhG8itN8Yo9edR1qLt92uMPFTr3t4PlaZV7s3PRxB8vaja4pgAIoe97fLm7
	 06Xmq6ePJ/ofYDprQV8UjM/JcQadv7BF7euYjVYBHEiLkwR+qBjKfmkrcFPLRCV6RH
	 LYlQkI8ZHRymmOEl+0s3iat2zzPVIkRJmwzWBr2xtM+jhF832zR3Q3gbElsj2dIxsJ
	 U2Wo8Nd/tvkypNoJuNMghz2oyei+tVJM7bzFgzuO+hHOyamRqjHCBUqz5mQaxyCz6j
	 dgH7NICqp94pw==
Date: Fri, 26 Sep 2025 17:16:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Message-ID: <aNauaSVs5ytzsVFt@ryzen>
References: <20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com>
 <20250925-vntb_msi_doorbell-v3-1-ae0b0c93caae@nxp.com>
 <aNaHrj0rwLTtSRS3@ryzen>
 <aNaprpfaeXIcqeGD@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNaprpfaeXIcqeGD@lizhi-Precision-Tower-5810>

On Fri, Sep 26, 2025 at 10:56:46AM -0400, Frank Li wrote:
> On Fri, Sep 26, 2025 at 02:31:42PM +0200, Niklas Cassel wrote:
> > On Thu, Sep 25, 2025 at 01:01:47PM -0400, Frank Li wrote:
> > > Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
> > > size and memory size. Prepare for adding support to set an MMIO address to
> > > a specific BAR.
> > >
> > > Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
> > > confuse.
> >
> > s/confuse/confusion/
> >
> >
> > >
> > > No functional changes.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change in v3
> > > - change return value to int.
> > > - use two pointers return bar size aligned and memory start address aligned
> > > - update comments about why need memory align size. Actually iATU require
> > > start address match aligned requirement. Since kernel return align to
> > > size's address.
> > > - use two varible aligned_bar_size and aligned_mem_size to avoid confuse
> > > use 'size'.
> > >
> > > change in v2
> > > - new patch
> > > ---
> > >  drivers/pci/endpoint/pci-epf-core.c | 84 +++++++++++++++++++++++--------------
> > >  1 file changed, 53 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > index d54e18872aefc07c655c94c104a347328ff7a432..2cd0257831f9885a4381c087ed8f3326f5960966 100644
> > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > @@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
> > >
> > > +static int
> > > +pci_epf_get_bar_required_size(struct pci_epf *epf, size_t size,
> > > +			      size_t *aligned_bar_size,
> > > +			      size_t *aligned_mem_size,
> > > +			      enum pci_barno bar,
> > > +			      const struct pci_epc_features *epc_features,
> > > +			      enum pci_epc_interface_type type)
> > > +{
> > > +	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
> > > +	size_t align = epc_features->align;
> > > +
> > > +	if (size < 128)
> > > +		size = 128;
> > > +
> > > +	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
> > > +	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
> > > +		size = SZ_1M;
> > > +
> > > +	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
> > > +		if (size > bar_fixed_size) {
> > > +			dev_err(&epf->dev,
> > > +				"requested BAR size is larger than fixed size\n");
> > > +			return -ENOMEM;
> > > +		}
> > > +		size = bar_fixed_size;
> > > +	} else {
> > > +		/* BAR size must be power of two */
> > > +		size = roundup_pow_of_two(size);
> > > +	}
> > > +
> > > +	*aligned_bar_size = size;
> >
> > I think this name is wrong.
> > The BAR size has not been aligned to anything.
> > The BAR size has to be a power of two, but that is a requirement of the PCI
> > specification, so that in an inherent property of a BAR.
> >
> > Perhaps just name it size or bar_size?
> 
> there already have 'size' for input.  It should match epc required's size.

Why do you need both "size_t size" and "size_t *bar_size"?

Isn't it enough with "size_t *bar_size" ?

The user can supply a value, and the function could update that value.


Kind regards,
Niklas

