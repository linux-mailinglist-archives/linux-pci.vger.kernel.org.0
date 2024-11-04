Return-Path: <linux-pci+bounces-16009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072FE9BC090
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB59282D1A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C31CDFBE;
	Mon,  4 Nov 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz5Gf/nO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848C1C4A0C
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757872; cv=none; b=BAZK107WlFvloaY8DEBavyvglO2U70/hF63dZOSnjMG5vnI24iVsIBhG68ZOVW6tRvFKX4aW7gTfL0aigmLCVSUdEK0QCbYue4dEW+gzT6chytOZ9rOgaVff5sBHa1S5TogEhHNbKG1oQSc161OVoa77nFyYMgpF3o0FX4Cp3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757872; c=relaxed/simple;
	bh=rpQvxNAKO54BaQ7y9JfUYcOtSRlRPeKBYf5D0e3CD/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvoni8PT46UrxLq6/oP7c0tgL1fCcrxo7JdArYsGU5UoJ/aprBMe4Yl78b41LIB6zDjNNANdoTepEZJz2Q7Pz1KUieQW6GQCRAD4kEv+oHlLu1CBl+ls3XX3zPSRbpmtld0YNMtaqYJwcp5Xje/p4zQlD/kVpSmzBuhGr8LBNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz5Gf/nO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB975C4CECE;
	Mon,  4 Nov 2024 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730757871;
	bh=rpQvxNAKO54BaQ7y9JfUYcOtSRlRPeKBYf5D0e3CD/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz5Gf/nO1G9kENkMOwjVKx8Q0kzAu6Z9ZaqnRY4FJOtLUmoPZqMPjsN2cgqFQoWws
	 sImIHvrqfWfsmHbeIHYZavwsmE1/vbQMwGvP3qxUaKhpRtk7iPZqD+BVauuXdNSp/z
	 HcuVBWLvDsFe6Oao5eJWVZc119NW3J1pgK3s06eQaN7VdPwDWoONlHdf0XlHUZJ2CM
	 o8I2wCLKlQuBIgTbnFLy9s0Y3n0IiwKbfIsz7IrDC25431tpyxoZ3RqavPMe5lOZAh
	 PFGHFArgdQoZz8XMmxv/xKq4UeVNYGnfUxWfPpBKa9K7blsZ2shz34NN1jzw7VPMHE
	 aInMsVbiIlRcA==
Date: Mon, 4 Nov 2024 23:04:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Do not map more memory than needed to
 raise a MSI/MSI-X IRQ
Message-ID: <ZylE6ivasmzd7uFW@ryzen>
References: <20241104205144.409236-2-cassel@kernel.org>
 <20241104211354.GB880663@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104211354.GB880663@rocinante>

On Tue, Nov 05, 2024 at 06:13:54AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > In dw_pcie_ep_init() we allocate memory from the EPC address space that we
> > will later use to raise a MSI/MSI-X IRQ. This memory is only freed in
> > dw_pcie_ep_deinit().
> > 
> > Performing this allocation in dw_pcie_ep_init() is to ensure that we will
> > not fail to allocate memory from the EPC address space when trying to raise
> > a MSI/MSI-X IRQ.
> > 
> > We still map/unmap this memory every time we raise an IRQ, in order to not
> > constantly occupy an iATU, especially for controllers with few iATUs.
> > (So we can still fail to raise an MSI/MSI-X IRQ if all iATUs are occupied.)
> > 
> > When allocating this memory in dw_pcie_ep_init(), we allocate
> > epc->mem->window.page_size memory, which is the smallest unit that we can
> > allocate from the EPC address space.
> > 
> > However, when writing/sending the msg data, which is only 2 bytes for MSI,
> > 4 bytes for MSI-X, in either case a single writel() is sufficient. Thus,
> > the size that we need to map is a single PCI DWORD (4 bytes).
> > 
> > This is the size that we should send in to the pci_epc_ops::align_addr()
> > API. It is align_addr()'s responsibility to return a size that is aligned
> > to the EPC page size, for platforms that need a special alignment.
> > 
> > Modify the align_addr() call to send in the proper size that we need to
> > map.
> > 
> > Before this patch on a system with a EPC page size 64k, we would
> > incorrectly map 128k (which is larger than our allocation) instead of 64k.
> > 
> > After this patch, we will correctly map 64k (a single page). (We should
> > never need to map more than a page to write a single DWORD.)
> [...]
> > Feel free to squash this with the patch that it fixes, if you so prefer.
> 
> Squashed with the rest of the pending changes, per:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=d2d9f84914e147d6ee399e0ed8d938fea7f0c35c
> 
> Let me know if anything needs to be updated there.

Thank you Krzysztof!


I do not see any point in you adding my Co-developed-by tag since I'm
the Author: of the original commit (the commit that you squashed with).

As far as I know, the Co-developed-by tag should only be added since
there can only be one person marked as Author:


And perhaps:
[kwilczynski: squashed patch that fixes memory map sizes on
    platforms with EPC page size of 64k]

should be:
[kwilczynski: squashed patch that fixes memory map sizes on
    all platforms]
or just:
[kwilczynski: squashed patch that fixes memory map sizes]

Since I (embarrassingly) always mapped twice as much memory as needed in
the original commit.


The squashed commit itself looks correct :)


Kind regards,
Niklas

