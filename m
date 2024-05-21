Return-Path: <linux-pci+bounces-7717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4308CADCF
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 14:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D09CB21234
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F3757E3;
	Tue, 21 May 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8osWtei"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A955C29
	for <linux-pci@vger.kernel.org>; Tue, 21 May 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292876; cv=none; b=GjAAF4MiRh4YLL6s3wVvfpdC44a095vEtUj/NtXTcNLkbyjMa/G3yOGXSdaeyYIDyxPcixSYLmJjy8/nsTwoUlHFauHtFN0rWaFBgjvsNWRvLU7szuocJyGNdbp88jVw41962t8NKztU6BswzoYw4wt56x4f3Fu/HLcUHtZeNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292876; c=relaxed/simple;
	bh=5zWWMpzNmFYgn31na2G/Lr9+d+AS37F1YH7AF5iGG10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVO/EfcNCB0jU3ZnUWr7GFM98vwREyUiJES0D7F/+6kcLYY6vxe8UdRNG9TXOTvEKBfhu8BavDaXGzwCmbC4WTRUbm19zHbOHYsDbsyPC7kcDfzQcWHLVNuIuGHnvSVTvb/7KhQCLXZ6mC/2Lfo2+P7mMn2CxWvoaloNTXi8WAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8osWtei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C907C2BD11;
	Tue, 21 May 2024 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292875;
	bh=5zWWMpzNmFYgn31na2G/Lr9+d+AS37F1YH7AF5iGG10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8osWteiMiJRQMNTqKhqQHnw9Eqb5MOhugUTNx+IV6xAIjyh1SgMy5gWZ+3wtWBje
	 MpdZLVSzYaQY/XOcuKSuEOsNAgJ1ZvgdBjJiKMMD64jZkAI7LDXJPMh4x2H6NYC+oG
	 6sPbKejwdU4xN1ZTLq379gSf5+e6RpL+5Z5OqlyhDOf83vb6mN0yFB/e0SOcYCyRoK
	 Ek/BjEOO5QKpSiAHHSn/A4HL7Oduv6rI3fESDfAgWnFjPr6blxJ7Cqdw4j9Amsxfuk
	 OlOhhBgZWRRdyjxAs9pvuTlWKgI4nJXKNMKOVwyoUH1B6XrUNZdx7gHJnMjDUuZEJZ
	 V5dilVRKSP0CA==
Date: Tue, 21 May 2024 14:01:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 7/9] PCI: cadence: Set a 64-bit BAR if requested
Message-ID: <ZkyNBpnEWkMN6Cnf@ryzen.lan>
References: <20240312105152.3457899-8-cassel@kernel.org>
 <20240516204907.GA2253008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516204907.GA2253008@bhelgaas>

Hello Bjorn,

On Thu, May 16, 2024 at 03:49:07PM -0500, Bjorn Helgaas wrote:
> [+cc Shawn for Rockchip question]
> 
> On Tue, Mar 12, 2024 at 11:51:47AM +0100, Niklas Cassel wrote:
> > Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> > is invalid if 64-bit flag is not set") it has been impossible to get the
> > .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> > requested to be configured as a 64-bit BAR.
> > 
> > Thus, forcing setting the 64-bit flag for BARs larger than 4 GB in the
> > lower level driver is dead code and can be removed.
> > 
> > It is however possible that an EPF driver configures a BAR as 64-bit,
> > even if the requested size is < 4 GB.
> > 
> > Respect the requested BAR configuration, just like how it is already
> > repected with regards to the prefetchable bit.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > index 2d0a8d78bffb..de10e5edd1b0 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -99,14 +99,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> >  		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
> >  	} else {
> >  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> > -		bool is_64bits = sz > SZ_2G;
> > +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> >  
> >  		if (is_64bits && (bar & 1))
> >  			return -EINVAL;
> 
> Not relevant to *this* patch, but it looks like this code assumes that
> a 64-bit BAR must consist of an even-numbered DWORD followed by an
> odd-numbered one, e.g., it could be BAR 0 and BAR 1, but not BAR 1 and
> BAR 2.
> 
> I don't think the PCIe spec requires that.  Does the Cadence hardware
> require this?

The PCIe spec does not seems to require this:

"A Type 0 Configuration Space Header has six DWORD locations allocated for
Base Address registers starting at offset 10h in Configuration Space. [...]
A Function may use any of the locations to implement Base Address registers.
An implemented 64-bit Base Address register consumes two consecutive DWORD
locations."


> What about Rockchip, which has similar code in
> rockchip_pcie_ep_set_bar()?
> 
> FWIW, dw_pcie_ep_set_bar() doesn't enforce this restriction.

The Synopsys PCIe controller does have this limitation:

From the DWC databook:

3.5.7.1.1 Overview

Base Address Registers (Offset: 0x100x24)

The controller provides three pairs of 32-bit BARs for each implemented
function. Each pair (BARs 0 and 1, BARs 2 and 3, BARs 4 and 5) can be
configured as follows:
-One 64-bit BAR: For example, BARs 0 and 1 are combined to form a single
 64-bit BAR.
-Two 32-bit BARs: For example, BARs 0 and 1 are two independent 32-bit BARs.
-One 32-bit BAR: For example, BAR0 is a 32-bit BAR and BAR1 is either
 disabled or removed from the controller altogether to reduce gate count.

So dw_pcie_ep_set_bar() should probably be fixed to enforce this requirement.

(PCI patches for DWC appear to have a tendency to be redirected to /dev/null,
so personally I'm not planning on sending out a patch to enforce this.)


Kind regards,
Niklas

