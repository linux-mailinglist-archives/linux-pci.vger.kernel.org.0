Return-Path: <linux-pci+bounces-36994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D6BA08E5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165107B2BB2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06670301718;
	Thu, 25 Sep 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwOkjw5J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6119EEC2;
	Thu, 25 Sep 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816597; cv=none; b=JSWUkQX2lnNo6YU6wzKLlfBm+2tTQTHLj2XnMMLyo6eCOFtbFesHPOxGWKkD04hSlOLks9Zr0XFPALObUbZ8ElVZIO6EzVteSKi44NvA4UaMV9oTCIso8K0ACLyGLVrogFYKJYRxtz3Ho51CosJpMH3eYY9L4SKCCE+qpSos9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816597; c=relaxed/simple;
	bh=bC9Ji/IqcBnINVQco0aIlsNkjuCLB8waAAlmgiPhwf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN8JjcSIUenRvw4lthTEC6J9uKt3O5rqLyKA3AJO1dgtofzGJawSUYPMLP8j3ksyKf6Ic9F39m2jCpK88j1wBICqxrsz7IZxVe0BXh+/A1v9UDKQyqo5EFMu5Z8Kd+7+4nHtngTjCndv96rrrWesFn1NgXe0qAFwUGBCeQ+d+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwOkjw5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154F8C4CEF0;
	Thu, 25 Sep 2025 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758816597;
	bh=bC9Ji/IqcBnINVQco0aIlsNkjuCLB8waAAlmgiPhwf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwOkjw5JdrfQ88fNWqEHmFXBNEdFbsXbX7/S3Zb5CMlBKAoGMvpBgn9MAFDwX5Tfk
	 jmvFoI+gln786L05fyAi4cXDWurnTPoCSy0uFQKKbapHDfeBY5089+CN8ylBJuFItP
	 mxIHtlwg/GnYawWoopvtplk3e0FWGJ/UqJ0b+GMXTxBuCyL3qQLMrfU3eridXfGXLi
	 88VzQKRDIYu0fyhCKTkQwlrKWtTnqwU3l3ZUVDYmzg8/R8l792G1NRjJgnBOXQ7SJ0
	 +9Aabu6lNzvrD05M2iLphWTPeEEJt45B53+O+P7ijyhzDZuk7zT+o7PLHRkAivh0KO
	 1iUl0EfpE/kTg==
Date: Thu, 25 Sep 2025 21:39:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Message-ID: <ex3lip5baeop6pj4bjq5z6icq5eif3t4ss57kllplgzbaoubjv@dsn57mraytfs>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
 <20250915-vntb_msi_doorbell-v2-3-ca71605e3444@nxp.com>
 <ejhs6fb2nmfhnjswhrvd7iwyddwvvr5nv6bu7dt4aypbiecyfb@wza667q2x4qp>
 <aNRZxAU0n1hvYeEZ@lizhi-Precision-Tower-5810>
 <qm7jvvvywqmegynkghxbfn6pwfdlkboowa45sqbvygpetkiyj4@ovve44f7qvpr>
 <aNVe9UIbFE3/1Rql@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNVe9UIbFE3/1Rql@lizhi-Precision-Tower-5810>

On Thu, Sep 25, 2025 at 11:25:41AM -0400, Frank Li wrote:

[...]

> > > > > +static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > > > > +					    struct pci_epf_bar *db_bar,
> > > > > +					    const struct pci_epc_features *epc_features,
> > > > > +					    enum pci_barno barno)
> > > > > +{
> > > > > +	struct pci_epf *epf = ntb->epf;
> > > > > +	dma_addr_t low, high;
> > > > > +	struct msi_msg *msg;
> > > > > +	size_t sz;
> > > > > +	int ret;
> > > > > +	int i;
> > > > > +
> > > > > +	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	for (i = 0; i < ntb->db_count; i++) {
> > > > > +		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > > > > +				  0, "vntb_db", ntb);
> > > > > +
> > > > > +		if (ret) {
> > > > > +			dev_err(&epf->dev,
> > > > > +				"Failed to request doorbell IRQ: %d\n",
> > > > > +				epf->db_msg[i].virq);
> > > > > +			goto err_request_irq;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	msg = &epf->db_msg[0].msg;
> > > > > +
> > > > > +	high = 0;
> > > > > +	low = (u64)msg->address_hi << 32 | msg->address_lo;
> > > > > +
> > > > > +	for (i = 0; i < ntb->db_count; i++) {
> > > > > +		struct msi_msg *msg = &epf->db_msg[i].msg;
> > > > > +		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
> > > > > +
> > > > > +		low = min(low, addr);
> > > > > +		high = max(high, addr);
> > > > > +	}
> > > > > +
> > > > > +	sz = high - low + sizeof(u32);
> > > > > +
> > > > > +	ret = pci_epf_set_inbound_space(epf, sz, barno,
> > > > > +					epc_features, 0, low);
> > > >
> > > > Should this new API be used in pci-epf-test also?
> > >
> > > Needn't, because pcie-epf-test default set system memory as bar's space.
> > > switch to MMIO when enable doorbell and switch back to system memory.
> > >
> > > size alignment already consider at bar initilization, and we can't change
> > > bar's size after bind now.
> > >
> >
> > The memory and size are allocated during pci_epf_test_bind(), I agree. But
> > that's for memory allocated through pci_epf_alloc_space(). So if the MSI region
> > has size restrictions (as taken care by this API), it should be handled in the
> > pci-epf-test driver as well.
> 
> pci_epf_alloc_space() is not only allocate memory, but also set bar's size.
> 
> But we can't change bar's size, for example allocated 64K at
> pci_epf_alloc_space()
> 
> but MSI map only require 4K. Current framework can't change bar's size.
> still have to use 64K for doorbell even MSI just require 4k.
> 
> >
> > Otherwise, we will end up with different implementations between EPF drivers.
> 
> pci_epf_test is special use case for doorbell. No one switch a bar to MSI
> as doorbell dynamtically. Generally, allocated a dedicated bar for
> doorbell.
> 

Ok! I think we would ideally need to expose doorbell registers in any used BAR,
not just in a dedicated BAR. But I believe it is difficult to have multiple
inbound mappings for the same BAR with ATUs.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

