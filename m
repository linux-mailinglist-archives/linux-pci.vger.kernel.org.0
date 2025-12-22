Return-Path: <linux-pci+bounces-43519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39310CD5CA4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376BD30321C9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1F30E839;
	Mon, 22 Dec 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY45yh4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C78313263
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402366; cv=none; b=Z4Z6WnLdwn5V6wNLm3/lLbg8rLycO+IBCsBvPiT9H+3SLyQlCSVXX8fZcrZeK/m5f0I6JF4hnFKINt24O0xIzpDMBllC1SFVthdF98y84uCvWSTmx26it1BzE0otNQt4SEEihHosD66V5ARHg0G5g9Zacapj93okRp6vwA8KN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402366; c=relaxed/simple;
	bh=XDrg2laWMKpjEKs1SWtr+H0JnvFjjvR0JzLhz7wp2gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGYD1PYxBN6QuZQKzAkMncpdq8KC0aICyRa0o/xllbVMx3Lnl+BuLreNU3eNnQ3SslMBKSemtpDQ8ZOLYbuiTCJbNWLz/l7fbrZagJgJgjJThHJ+QQkErgGmgEOaBGPH4P2CwnZ7tKQODku6rkKpzQTQh84S22cOvroa4yl056o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY45yh4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1378AC4CEF1;
	Mon, 22 Dec 2025 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766402365;
	bh=XDrg2laWMKpjEKs1SWtr+H0JnvFjjvR0JzLhz7wp2gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MY45yh4TU4GPI2sEfdj3CPZODrDHv5dKXT+n4/2ndkPWErA77ukwPjGK7aGRA42SV
	 TeVHhDv+4eX/8JNydp2UgIBsjNLTHMFlYB1O8cXxFmfatojEK38AeqgIk6g8aLZQkV
	 b3uXRG5uCX5fMHyfP+woNmKPLGLCaSCPSgIoMIOeMvE2HT+orU9+MYMhRHSYVn0yJa
	 0sh88UOSUfBn1Ud9DkTXNk2iL+N4Ubkx4h3WLrogku5h/uOd8iT+RHa0n2RAVKf02t
	 mjKSEYKosIzDa47CD9XbpZuhyVEsPfI4Rt8wTxAoM6f1pjqwsX5UPnyPbUNQBSdeWa
	 r2H6QX/Z10j4w==
Date: Mon, 22 Dec 2025 16:49:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <fwltvrwsramv5pijrjuolsduindhujhcm76bx4qnelwoxii6pq@5jrtcvy3lo3e>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUknSzSpNxLeEN5o@ryzen>

On Mon, Dec 22, 2025 at 12:11:07PM +0100, Niklas Cassel wrote:
> On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
> > 
> > > Use the MSIX doorbell method which will not use iATU at all,
> > > dw_pcie_ep_raise_msix_irq_doorbell().
> > > 
> > 
> > I think this is the safe bet since this feature doesn't seem like an optional
> > one.
> > 
> > Niklas, if you can just fix MSI in this patch and leave out MSI-X for the vendor
> > drivers to transition to doorbell, I'm OK to merge it. Otherwise, I don't know
> > how you can reliably fix MSI-X generation with AXI slave interface.
> 
> FWIW, I did try to simply change:
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 8f2cc1ef25e3..00770f9786e3 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -319,7 +319,8 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>         case PCI_IRQ_MSI:
>                 return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>         case PCI_IRQ_MSIX:
> -               return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +               return dw_pcie_ep_raise_msix_irq_doorbell(ep, func_no,
> +                                                         interrupt_num);
>         default:
>                 dev_err(pci->dev, "UNKNOWN IRQ type\n");
>         }
> 
> 
> For the pcie-dw-rockchip driver, but it is not working:
> [  130.042849] nvme nvme0: I/O tag 0 (1000) QID 0 timeout, completion polled
> 
> Without this change, things work.
> 
> Perhaps this feature is not an optional one, but at least we will require
> more changes than a simple one liner.
> 

Fair enough. We should not just blindly replace the API, that's why I preferred
the vendor drivers themselves to transition (meaning the vendor maintainers
doing the change instead of us).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

