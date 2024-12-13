Return-Path: <linux-pci+bounces-18370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EC59F0D54
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D12284350
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B911DF273;
	Fri, 13 Dec 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dww15wq3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651F38DE1;
	Fri, 13 Dec 2024 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096882; cv=none; b=bCjtRFu6aEj4OqnSh8Cr1mqR1ZecKrASEGnbDnrxa9rSj5wFV8eQbFFFIKiqpNFZfTLMBZ584rVeKU7YKh0+N5tq/pUoaKUKzpxBm1WdgsxagbZ7xlx6McuDu5+QJQUJh+huNZk7YXnfF3iTx/jwKCPVqEaOxsrSVnTTLnBDXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096882; c=relaxed/simple;
	bh=T4o9xKY2MfS7nK0plKbaiDSl8ZQeDCS+/DIfcQpnqzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjHB18FzslroMiKTDgxDbZ/YIxEEf3F4f+bEnSTdRQAR5BHZI14QK25OTwyhcHBLDlqntAAMbt8s0HP1i2VeHPFZKXlB+Ufst7/pETIxxbXzDpOyGDtkR/9EnwiokAZQsUqnQqrdJ8XCjdkSpaEiVoyW+UYIAPDhx4tFGZ07hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dww15wq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6814C4CED0;
	Fri, 13 Dec 2024 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734096881;
	bh=T4o9xKY2MfS7nK0plKbaiDSl8ZQeDCS+/DIfcQpnqzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dww15wq3lRzLWmN92dqzg2sBPSqaB4jVFa9QRAU2F3x/F5YgszAnLKUzTW+dYE13b
	 CS1xi7gQ1+DPHOIXMcmLPSAczENqrYIi1CvBnS5V3EnDLIy66mklPqukbgsnGd7w7x
	 w/ZKTosm+Qqd/LBokFtO/IqHMYtIO+SabyRYlZ3cnNXkGot3p83SHk+Vy9MPxTuHBC
	 biWAYEm1NPoRXbRD3GJsD0NcEuSSbTy0lYJxzBF7yyK2zhlyKb4lM6tmLIxLrt6UCs
	 0j7YmAoHHcYYxtND5d4O/H6JjFB6CEfP4LEXXkiYik36qNgcINsacBr3GWtvQudAIG
	 6WE4pc1bI6Ncg==
Date: Fri, 13 Dec 2024 14:34:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: dwc: ep: iATU registers must be written
 after the BAR_MASK
Message-ID: <Z1w364da43KCOIGY@ryzen>
References: <20241127103016.3481128-9-cassel@kernel.org>
 <20241204173352.GA3006363@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204173352.GA3006363@bhelgaas>

Hello Bjorn,

On Wed, Dec 04, 2024 at 11:33:52AM -0600, Bjorn Helgaas wrote:
> In subject, maybe "Write BAR_MASK before iATU registers"

Ok. Will fix in v6.


> 
> I guess writing BAR_MASK is really configuring the *size* of the BAR?

I am quite sure that you know how host software determines the size of
a BAR :)

But yes, writing the BAR_MASK will directly decide a BARs size:
https://wiki.osdev.org/PCI#Address_and_size_of_the_BAR

So BAR_MASK is "BAR size - 1".


> Maybe the size is the important semantic connection with iATU config?

The connection is:
"Field size depends on log2(BAR_MASK+1) in BAR match mode."

So I think it makes sense for the subject to include BAR_MASK
rather than BAR size.


> 
> On Wed, Nov 27, 2024 at 11:30:17AM +0100, Niklas Cassel wrote:
> > The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
> > in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
> > "Field size depends on log2(BAR_MASK+1) in BAR match mode."
> 
> Can we include a databook revision and section here to help future
> maintainers?

Ok. Will fix in v6.


> 
> > I.e. only the upper bits are writable, and the number of writable bits is
> > dependent on the configured BAR_MASK.
> > 
> > If we do not write the BAR_MASK before writing the iATU registers, we are
> > relying the reset value of the BAR_MASK being larger than the requested
> > size of the first set_bar() call. The reset value of the BAR_MASK is SoC
> > dependent.
> > 
> > Thus, if the first set_bar() call requests a size that is larger than the
> > reset value of the BAR_MASK, the iATU will try to write to read-only bits,
> > which will cause the iATU to end up redirecting to a physical address that
> > is different from the address that was intended.
> > 
> > Thus, we should always write the iATU registers after writing the BAR_MASK.
> 
> Apparently we write BAR_MASK and the iATU registers in the wrong
> order?  I assume dw_pcie_ep_inbound_atu() writes the iATU registers.

Yes.


> 
> I can't quite connect the commit log with the code change.  I assume
> the dw_pcie_ep_writel_dbi2() and dw_pcie_ep_writel_dbi() writes update
> BAR_MASK?

dw_pcie_ep_writel_dbi2() writes the BAR_MASK.
dw_pcie_ep_writel_dbi() writes the BAR type.


> 
> And I guess the problem is that the previous code does:
> 
>   dw_pcie_ep_inbound_atu        # iATU
>   dw_pcie_ep_writel_dbi2        # BAR_MASK (?)
>   dw_pcie_ep_writel_dbi
> 
> and the new code basically does this:
> 
>   if (ep->epf_bar[bar]) {
>     dw_pcie_ep_writel_dbi2      # BAR_MASK (?)
>     dw_pcie_ep_writel_dbi
>   }
>   dw_pcie_ep_inbound_atu        # iATU
>   ep->epf_bar[bar] = epf_bar
> 
> so the first time we call dw_pcie_ep_set_bar(), we write BAR_MASK
> before iATU, and if we call dw_pcie_ep_set_bar() again, we skip the 
> BAR_MASK update?

The problem is as described in the commit message:
"If we do not write the BAR_MASK before writing the iATU registers, we are
relying the reset value of the BAR_MASK being larger than the requested
size of the first set_bar() call. The reset value of the BAR_MASK is SoC
dependent."


Before:
dw_pcie_ep_inbound_atu() # iATU - the writable bits in this write depends on
                         # BAR_MASK, which has not been written yet, thus the
			 # write will be at the mercy of the reset value of
			 # BAR_MASK, which is SoC dependent.
dw_pcie_ep_writel_dbi2() # BAR_MASK
dw_pcie_ep_writel_dbi()  # BAR type

After:
dw_pcie_ep_writel_dbi2() # BAR_MASK
dw_pcie_ep_writel_dbi()  # BAR type
dw_pcie_ep_inbound_atu() # iATU - this write is now done after BAR_MASK has
			 # been written, so we know that all the bits in this
			 # write is writable.


Kind regards,
Niklas

