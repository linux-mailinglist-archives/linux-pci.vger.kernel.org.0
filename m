Return-Path: <linux-pci+bounces-43524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF86CD6142
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 14:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C037A300284D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76C1AA1D2;
	Mon, 22 Dec 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omBz6ROg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1572D738F
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408437; cv=none; b=tgJc3RL5z1CLrY5QE+N133gpv0m7Nq9GGY9oIq9vGdC5aQ7sWE0ygZ+OJvuQuvHv2MZLYba40zLOA8YHn35qSWwNY9OtNSC5+bjTkf71UijTlPQ7fb6qomkZAKXYFTWqg51Oz8BLMdepA0MZVOY8WkH7oW000vZCbKq5vRH40fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408437; c=relaxed/simple;
	bh=1yZQMwvHldKEIkAXJhzaHK8Ci8rw+NL3b2dxbNyRH2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBwqPe3D+uNY4SByE+MLQsnzz6cimzTflLdD7n6yd/4axxqN4sw9AO64SSlQw0PWhem7Y+Iv2CCeruJDKXA8+NdW48JWj78F0dZk3ORzOQHoyzc4VZ1Znhudwcd68m9Ue7ZbOCFuJnaVQYPqS8TqT2+ih2oLtc5XvWUVO2JjCbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omBz6ROg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1ABC4CEF1;
	Mon, 22 Dec 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766408437;
	bh=1yZQMwvHldKEIkAXJhzaHK8Ci8rw+NL3b2dxbNyRH2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omBz6ROg0S+cdnZXOmMQg9a83AWOcCuQcdSNDDMcgO4wnmu5cthxn5ci/FhVvaiEo
	 b1QPQ4QNaUqFs0Ddu983K/8hSSaY9MB+pBlEmmS2AgeK988QU//EK05toLwxUfQnqr
	 qMVF+umIpj3k6dY3N5Ody9ZIh5QXhlCf30nCIlPllGULzq95MD7MEeVz/VXyn9+r1c
	 6LukpxdtAO5jANTo4QcCtG4i+yMR5pMMjLUQN7lri9c9UBB4LG98LFmSdZ3OzV5POm
	 kb54BvEyErsqtsxEVleREHSs6L/mNT6QeybticVSN570a9G9TStiDfHVySlLFYA2zL
	 PKyzRIGEdKqDA==
Date: Mon, 22 Dec 2025 14:00:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <aUlA7y95SUC-QA4T@ryzen>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
 <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>

+ Shawn

On Mon, Dec 22, 2025 at 05:53:27PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/22/2025 4:41 PM, Niklas Cassel wrote:
> > On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
> > > > Use the MSIX doorbell method which will not use iATU at all,
> > > > dw_pcie_ep_raise_msix_irq_doorbell().
> > > > 
> > > I think this is the safe bet since this feature doesn't seem like an optional
> > > one.
> > > 
> > > Niklas, if you can just fix MSI in this patch and leave out MSI-X for the vendor
> > > drivers to transition to doorbell, I'm OK to merge it. Otherwise, I don't know
> > > how you can reliably fix MSI-X generation with AXI slave interface.
> > FWIW, I did try to simply change:
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 8f2cc1ef25e3..00770f9786e3 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -319,7 +319,8 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> >          case PCI_IRQ_MSI:
> >                  return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> >          case PCI_IRQ_MSIX:
> > -               return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > +               return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
> > +                                                         interrupt_num);
> >          default:
> >                  dev_err(pci->dev, "UNKNOWN IRQ type\n");
> >          }
> > 
> > 
> > For the pcie-dw-rockchip driver, but it is not working:
> > [  130.042849] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, completion polled
> > 
> > Without this change, things work.
> > 
> > Perhaps this feature is not an optional one, but at least we will require
> > more changes than a simple one liner.
> Hi Niklas,
> 
> It should be automatic only, no extra configurations should be
> required, I believe your
> HW doesn't support this feature, from spec 6..0a, sec 3.9.1.3
> iMSIX-TX: Integrated MSI-X Transmit (USP)
> I believe your HW is not generated with MSIX_TABLE_EN =1. In that
> case you can't use this feature.

Looking at the RK3588 TRM, it does have register:
USP_PCIE_PL_MSIX_DOORBELL_OFF
Address: Operational Base + offset (0x0248)

Port Logic registers start at offset 0x700 on this SoC,
so 0x700 + 0x248 == 0x948, which matches:
drivers/pci/controller/dwc/pcie-designware.h:#define PCIE_MSIX_DOORBELL         0x948

I don't think the TRM would include this register if the
DWC coere was not generated with MSIX_TABLE_EN=1.

Shawn, any suggestions?
For full thread, see:
https://lore.kernel.org/linux-pci/3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com/T/#t


FWIW, Krishna Chaitanya, I did try the dw_pcie_ep_raise_msix_irq_doorbell()
change above also with the pci-epf-test EPF driver, and it also caused the
pci-epf-test driver to stop working.


Kind regards,
Niklas

