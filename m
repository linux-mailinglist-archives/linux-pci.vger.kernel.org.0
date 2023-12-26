Return-Path: <linux-pci+bounces-1391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C5B81EA51
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 23:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC151F21704
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27945523D;
	Tue, 26 Dec 2023 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbUue7oI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052485234
	for <linux-pci@vger.kernel.org>; Tue, 26 Dec 2023 22:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C23C433C8;
	Tue, 26 Dec 2023 22:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703629036;
	bh=pKmEOi611KsNmpYDsc3dAo7I11XlWdRDjQpaNXp7amk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lbUue7oIN+5sWp7KOwmKOJxy5NiLIzT4Yxwh6mYkefykU8QQSDFvmRKn67nc3Gxtw
	 QZPE4N7P2ZXflS7Vu44CFSGCFjjyGBZ9DxXmMuAGG3NFysta/uIkx27wtA2MRVH5dX
	 oChN2YpaiZaydzfzjGKOc6or92QF7BMrTpKL20WxXPCjAld+i1s/lYEXrlEgpC3ey9
	 x7S8RpTmyehyAAURvyXCvz5tmMnp+CPkjlvH1tfgHw+aYxpjaSaIOQTC1tMr2C8ALP
	 4ish93C67LCeCnOM0SiLtAuwRJ+GJDOyB4vKa8xM7IbBecVAg3OOZABkPdl77gxSdx
	 1X3kuZIQXV/YQ==
Date: Tue, 26 Dec 2023 16:17:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <nks@flawful.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Message-ID: <20231226221714.GA1468266@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128132231.2221614-1-nks@flawful.org>

On Tue, Nov 28, 2023 at 02:22:30PM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> support iATUs which require a specific alignment.
> 
> However, this support cannot have been properly tested.
> 
> The whole point is for the iATU to map an address that is aligned,
> using dw_pcie_ep_map_addr(), and then let the writel() write to
> ep->msi_mem + aligned_offset.
> 
> Thus, modify the address that is mapped such that it is aligned.
> With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> dw_pcie_ep_raise_msi_irq().

Was there a problem report for this?  Since 6f5e193bfb55 appeared in
v5.7 (May 31 2020), and this should affect imx6, keystone am654,
dw-pcie (platform), and keembay, it seems a little weird that this bug
persisted so long.  Maybe nobody really uses endpoint support yet?

But I assume you observed a failure and tested this fix somewhere.

And the failure is that we send the wrong MSI-X vector or something
and get an unexpected IRQ and a driver hang or something?  In other
words, how does the bug manifest to users?

> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Changes since v1:
> -Clarified commit message.
> -Add a working email for Kishon to CC.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f6207989fc6a..bc94d7f39535 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  
>  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> +	msg_addr &= ~aligned_offset;
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);

Total tangent and I don't know enough to suggest any changes, but it's
a little strange as a reader that we want to write to ep->msi_mem, and
the ATU setup with dw_pcie_ep_map_addr() doesn't involve ep->msi_mem
at all.

I see that ep->msi_mem is allocated and ioremapped far away in
dw_pcie_ep_init().  It's just a little weird that there's no
connection *here* with ep->msi_mem.

I assume dw_pcie_ep_map_addr(), writel(), dw_pcie_ep_unmap_addr() have
to happen atomically so nobody else uses that piece of the ATU while
we're doing this?  There's no mutex here, so I guess we must know this
is atomic already because of something else?

Bjorn

