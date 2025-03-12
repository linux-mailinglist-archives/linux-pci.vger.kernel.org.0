Return-Path: <linux-pci+bounces-23509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E229A5E06D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 16:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377EC7AC38A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C12500DA;
	Wed, 12 Mar 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thbSx46f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED22033A;
	Wed, 12 Mar 2025 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793630; cv=none; b=u0B4CA6ErjUhq4zgEJ53fEITMeTGnXMtrxORFWanweubq3e2DPnzMy38KvKE6uC+gmoz1g+/7zNzd+rgSER1zb0+8OeXh37rSqkKnQOgCo6519ob9IWQXGgpQ9bl0U/axc/BYFqV+ZhWuFUtqTJ8AmFoOLmKMOJn1GL7dJSefX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793630; c=relaxed/simple;
	bh=ba1USVVp9UuTOENNH3I2YWWddlRcgnuL6Zm1RQg77rY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vg2dJozgfhMD8qn5abyUTSHXyCIdI0ObB8PPE0KrNARUE3k/0OAGIBfVUINbV2/Cl/BWBV3t9zFNyrxDR9Lb3gGL0ezuqaNoAwmgd7VJ8mtspztEs3dBUMmy7R/TrRs2bsRlTdienp9CT6AN/W/w5u08bBYWVFepcfqZ2Mj/3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thbSx46f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA8FC4CEDD;
	Wed, 12 Mar 2025 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741793629;
	bh=ba1USVVp9UuTOENNH3I2YWWddlRcgnuL6Zm1RQg77rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=thbSx46fzJkSAsVKZtt12iw14naC/Y54ON75c6rL6KzFDe9ETOCKxRMlHNE070zSa
	 xr5Gq7K8QBdmXE1gdj4mfurIWR5zq9cKObdrmLThGxbYtkN13yc7fW+dBD6L79Lwkz
	 2BY+dQ+fzcMUZhNw3aQrgEV+pbvoZ0cTtJgJ2RpvivC0F+Vo3pbV+9UsMypwWIRs8F
	 vtzu1AhB4Bm8OzcrEFGslZlj9N2J5c7BHxCURuThhLCm9t7IKvKcj9kZCVdT4FDARZ
	 RvUCQIs+OJIR4fwpmLUYQbmIkoz8eDS1u/NjNbW2WwQ3Av7N9aMobjz0rx7BjLSElE
	 TijEJOfDdO4cA==
Date: Wed, 12 Mar 2025 10:33:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: "lpieralisi@kernel.org >> Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicornxw@gmail.com>, kw@linux.com, robh@kernel.org,
	s-vadapalli@ti.com, thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	wojciech.jasko-EXT@continental-corporation.com, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev
Subject: Re: [PATCH] PCI: cadence: Fix NULL pointer error for ops
Message-ID: <20250312153346.GA678711@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB10393B57EAC99498561CC30FAFED02@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Mar 12, 2025 at 10:08:43AM +0800, Chen Wang wrote:
> Hello, Bjorn, Lorenzo & Manivannan,
> 
> I find your names in MAINTAINERS for PCI controllers, could you please pick
> this patch for v6.15?
> 
> Or who else should I submit a PR for this patch to?
> 
> BTW, Siddharth signed the review for this patch (see [1]). Please add this
> when submitting, thanks in advance.
> 
> Link:
> https://lore.kernel.org/linux-pci/20250307151949.7rmxl22euubnzzpj@uda0492258/
> [1]

> On 2025/3/4 16:17, Chen Wang wrote:
> > From: Chen Wang <unicorn_wang@outlook.com>
> > 
> > ops of struct cdns_pcie may be NULL, direct use
> > will result in a null pointer error.
> > 
> > Add checking of pcie->ops before using it.
> > 
> > Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")

AFAICT this does not fix a problem in 40d957e6f9eb, since there is no
driver that calls cdns_pcie_host_setup() or cdns_pcie_ep_setup() with
a NULL pcie->ops pointer, so I think you should drop this Fixes: tag.

I see that you probably want to *add* an sg2042 driver [2] where you
don't need a pcie->ops pointer (although the current patch at [2]
*does* supply a valid pointer).

So there's no urgency to apply this until you post an sg2042 driver
that doesn't fill in the pcie->ops pointer.  The best way to do this
would be to include this patch in the series that adds the sg2042
driver.

Then the commit log can explain exactly why we need it (because the
sg2042 in the next patch of the series doesn't need a pcie->ops
pointer), and it will be easy to review.

[2] https://lore.kernel.org/r/ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com

> > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >   drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
> >   drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
> >   drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > index 8af95e9da7ce..9b9d7e722ead 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > @@ -452,7 +452,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
> >   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
> >   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
> > -	if (pcie->ops->cpu_addr_fixup)
> > +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
> >   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> >   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> > index 204e045aed8c..56c3d6cdd70e 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> > @@ -90,7 +90,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> >   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
> >   	/* Set the CPU address */
> > -	if (pcie->ops->cpu_addr_fixup)
> > +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
> >   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> >   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
> > @@ -120,7 +120,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
> >   	}
> >   	/* Set the CPU address */
> > -	if (pcie->ops->cpu_addr_fixup)
> > +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
> >   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
> >   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> > index f5eeff834ec1..436630d18fe0 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence.h
> > +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> > @@ -499,7 +499,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
> >   static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
> >   {
> > -	if (pcie->ops->start_link)
> > +	if (pcie->ops && pcie->ops->start_link)
> >   		return pcie->ops->start_link(pcie);
> >   	return 0;
> > @@ -507,13 +507,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
> >   static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
> >   {
> > -	if (pcie->ops->stop_link)
> > +	if (pcie->ops && pcie->ops->stop_link)
> >   		pcie->ops->stop_link(pcie);
> >   }
> >   static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
> >   {
> > -	if (pcie->ops->link_up)
> > +	if (pcie->ops && pcie->ops->link_up)
> >   		return pcie->ops->link_up(pcie);
> >   	return true;
> > 
> > base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

