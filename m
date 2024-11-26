Return-Path: <linux-pci+bounces-17329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306999D94A3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 10:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4CF283631
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D21BC063;
	Tue, 26 Nov 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i483S0mZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7061BB6B3;
	Tue, 26 Nov 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613780; cv=none; b=qD86TGTK+N47KHUjnGZ1l40faNsneEJcHhU6u/DLJFzoJWpGft0fjiRDpTpfPEt67HKMSXP6WYJ5c7tNRb/5VaUyaWjbaP5rmUeSiPpkdQOvWhv+ovcIVgWyJWjo7KXmHGuZ6tZbjZkgb4Q10J7d8ywRRdt1Q4di7MX/oUEFQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613780; c=relaxed/simple;
	bh=KVIfCGQmDp6Zc3maWEFRnxe4bj7QJ4bEIv2RSq4VTCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmRDIWb3xLft6AfZSwqndAzaiuKR7AwrBMMnyN8SAdkMiVcllkH7/gfbeMHZjzeP3OeJpgULtYeLduqGa4Asqv6dMKNGtyPLXxcR2VwqFql4TVoF96Gu7vdDkq3DfBjHLz9p2vq3GcCrZAVyUegFWa8BUE700A5QGMyvl8TNebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i483S0mZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B88C4CECF;
	Tue, 26 Nov 2024 09:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732613780;
	bh=KVIfCGQmDp6Zc3maWEFRnxe4bj7QJ4bEIv2RSq4VTCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i483S0mZ90NIOez44lmtrk07Ib+MFFXS0ndoi0HcksmC2pemfEIJ0sWA+wO+4bv9X
	 iTKq3YFgrWNF1eYgCesIo1VxYaJnn/EtyhLlGLybxSkeBFUnuDRsQJymBWMbAoAceo
	 j7/wIK9Iu2AG2lCnSbiQToGKNvsy8sMxe6qlNgIWHs/V14AD2N4BXvHciQcjs14cuD
	 k1AYLvqRRUXaXKegtZzlxzyFqSuMP6aR4gpXDuTfJplxGcDVJFQ+R+6ltNT4JNRk6i
	 NrvtwUcwIHDSELdeUDEhnFRg3S692pOpWxv+W1Eu+xjf8/CLCAanfreCv+qxxkGAbS
	 rL9mxFS35Fgqw==
Date: Tue, 26 Nov 2024 10:36:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v8 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <Z0WWjiamjkWfQXKk@ryzen>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-3-6f1f68ffd1bb@nxp.com>
 <20241124073239.5yl5zsmrrcrhmibh@thinkpad>
 <Z0TOb0ErwuGQwF8G@lizhi-Precision-Tower-5810>
 <20241126041903.lq6zunvzoc2mmgbl@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126041903.lq6zunvzoc2mmgbl@thinkpad>

On Tue, Nov 26, 2024 at 09:49:03AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 25, 2024 at 02:22:23PM -0500, Frank Li wrote:
> > On Sun, Nov 24, 2024 at 01:02:39PM +0530, Manivannan Sadhasivam wrote:
> > > On Sat, Nov 16, 2024 at 09:40:43AM -0500, Frank Li wrote:
> > > > Introduce the helper function pci_epf_align_addr() to adjust addresses
> > >
> > > pci_epf_align_inbound_addr()?
> > >
> > > > according to PCI BAR alignment requirements, converting addresses into base
> > > > and offset values.
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > change from v7 to v8
> > > > - change name to pci_epf_align_inbound_addr()
> > > > - update comment said only need for memory, which not allocated by
> > > > pci_epf_alloc_space().
> > > >
> > > > change from v6 to v7
> > > > - new patch
> > > > ---
> > > >  drivers/pci/endpoint/pci-epf-core.c | 45 +++++++++++++++++++++++++++++++++++++
> > > >  include/linux/pci-epf.h             | 14 ++++++++++++
> > > >  2 files changed, 59 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > > > index 8fa2797d4169a..4dfc218ebe20b 100644
> > > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > > @@ -464,6 +464,51 @@ struct pci_epf *pci_epf_create(const char *name)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epf_create);
> > > >
> > > > +/**
> > > > + * pci_epf_align_inbound_addr() - Get base address and offset that match bar's
> > >
> > > BAR's
> > >
> > > > + *			  alignment requirement
> > > > + * @epf: the EPF device
> > > > + * @addr: the address of the memory
> > > > + * @bar: the BAR number corresponding to map addr
> > > > + * @base: return base address, which match BAR's alignment requirement, nothing
> > > > + *	  return if NULL
> > >
> > > Below, you are updating 'base' only if it is not NULL. Why would anyone call
> > > this API with 'base' and 'offset' set to NULL?
> > 
> > Some time, they may just want one of two.
> > 
> 
> What would be the purpose? I fail to see it.

Currently, the only user of this function is the call:
ret = pci_epf_align_inbound_addr_lo_hi(epf, bar, msg->address_lo, msg->address_hi,
				       &db_bar.phys_addr, &offset);

Which doesn't send in NULL as either 'base' or 'offset', so these NULL
checks do currently look meaningless to me. I suggest to just kill them.


Kind regards,
Niklas

