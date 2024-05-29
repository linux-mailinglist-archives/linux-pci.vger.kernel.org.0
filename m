Return-Path: <linux-pci+bounces-7956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11818D2E57
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 09:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753531F22385
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91316727E;
	Wed, 29 May 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/bsRZTl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1EB1E86E
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968149; cv=none; b=XqwDrnF52HCFdLt5GQId+nJ/NXcLqAzeff+rOuiRmSUDnCVB8/mY2yiArDEbK52Q4A7XR6i2DWQIiuazHA10nfIZ2B+0PJeJnBZXlNJqwOzH1a4cJo3U7mD9DdrGmwm7400qnoFcZewljmZUSGE+4pW1Cf75Eb43RqBbI0HQjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968149; c=relaxed/simple;
	bh=gSuYsHGYmkp2JXaadHiei4qfV+q6Jb1eL3nO3QMxJVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8q231APF8eKbfDAukP31SipQBcq2zEM3YqTc6xinFOjmeuGyRSZMXoZUZxEuo3lf6MHIl96Hm3te0cJIXdHNTV0qxC2PuJaR88pBGKdQLhEql6y8K+nDDkLZJo+zZdjUD2uoJBSlWviSAVKzp/C/cBOS6z52/m2t3ZGM6H2iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/bsRZTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CB4C2BD10;
	Wed, 29 May 2024 07:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716968149;
	bh=gSuYsHGYmkp2JXaadHiei4qfV+q6Jb1eL3nO3QMxJVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/bsRZTltQWqhJ3zxYgR9zBfp6BfiaDs73evaueptpuea+8EwqjFMpUygjt2vlGoH
	 1ZJsRw52RUZZp3X/8vEyz7F51EM/+kdeSMG+MSKQy6irkkou8317bmmtfjQo/iK9gg
	 79J5qi6Jz/GFxsevh82LG6q7kMXya3XpwQ4PO74j4rpf7/IQCyTLQUIVL9bE0yuQnX
	 /AsYeErAzQs98VPRp+bfckZa2+d/iGAShHNhRfSpKXxAtHazy3QLpeXGuDF762Zzrt
	 M6HqJcF8D96Hub31PrLVlDlB0wLix1mYextFcrHfTXVAYDhj2zWQNDHqcp6MQYCvTc
	 KS8R8w73s81/w==
Date: Wed, 29 May 2024 09:35:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <Zlba0OfNCGecFYj8@ryzen.lan>
References: <ZlYt1DvhcK-ePwXU@ryzen.lan>
 <20240528195539.GA458945@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528195539.GA458945@bhelgaas>

On Tue, May 28, 2024 at 02:55:39PM -0500, Bjorn Helgaas wrote:
> On Tue, May 28, 2024 at 09:17:40PM +0200, Niklas Cassel wrote:
> > 
> > > What if we added stubs to pci-epc.h pci_epc_init_notify(),
> > > pci_epc_deinit_notify(), pci_epc_linkup(), and pci_epc_linkdown() for
> > > the non-CONFIG_PCI_ENDPOINT case instead?  Then we might be able to
> > > drop all these DWC-specific wrappers.
> > 
> > The PCI endpoint subsystem currently does not provide any stubs at all,
> > so that would be a bigger change compared to this small patch.
> > (And considering that the pci/endpoint branch does not build, I opted
> > for the smaller patch.)
> 
> > Your suggestion would of course work as well, but if we go that route,
> > then we should probably add stubs for all functions in both
> > include/linux/pci-epc.h and include/linux/pci-epf.h.
> > As long as the DWC glue drivers use the same "API layer" for init and
> > deinit notification, I'm happy :)
> 
> The cadence, rcar, and rockchip drivers use pci_epc_init_notify() with
> no wrapper.
> 
> A bunch of DWC-based drivers (artpec6, dra7xx, imx6, keembay, ks, ls,
> qcom, rcar_gen4, etc) use the dw_pcie_ep_init_notify() wrapper.
> 
> ls and qcom even use *both*: pci_epc_linkdown() but
> dw_pcie_ep_linkup().
> 
> Personally I would drop the dw_*() wrappers.  It's a bigger patch but
> not any more complicated, and the result is consistency across both
> DWC and the non-DWC drivers.
> 
> I don't know if we need to add stubs for *all* the functions.  I'd
> probably defer that until we trip over them.

Hello Mani,

considering that:

1) Bjorn dropped the commit:
"PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers"
which means that you will need resubmit your patch.

2) Any changes I would do would conflict with your patch.
(It probably makes most sense put your patch as the final patch in a series.)

3) You are the PCI endpoint maintainer, so you are most suited to decide
which functions to stub (if any).

4) Your patch only affects tegra and qcom, and I don't have the hardware
for either, so I wouldn't be able to test.

Thus, I do not intend to respin this series.
I hope that is okay with you.


Kind regards,
Niklas

