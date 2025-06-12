Return-Path: <linux-pci+bounces-29536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13A5AD6ED5
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FAF189ECC6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA4205AA3;
	Thu, 12 Jun 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTGQ+cJh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A95EC2
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727190; cv=none; b=Hi8VbK1BItPHR4kw/62yfeSwlPrExTY3TvWhChCjVxAGBmOAoMolEP4RdOauQ8qon6S7V8hznD9gnN/o5WQXTPNGYErahWMwqpsrxmzJQ1HKNyi/evO5sDm3HUZkzKLq59cD3Yf2lAojr3t6d++uLF4kAbM3P+EQUSi1g2usa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727190; c=relaxed/simple;
	bh=cVFIRmuMf6og7Otn6VJlaRqnyuBkLItWoFn62vUOnjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3qn1yulc2QNnds2OY09wxe8tC8NbXkicl6luXocFR3O/6xDZCVjd5kGr67qKVNb6qCNKApbowXwiW7W62GRZ5GC+UPqegWI8INH9+vcilnNmDq95xX+x0xRHsa1zP8VJHV4y71+QzVbxHhGKt+Ax3NBX0PVxIN3Il8mvlov5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTGQ+cJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05D9C4CEEA;
	Thu, 12 Jun 2025 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749727190;
	bh=cVFIRmuMf6og7Otn6VJlaRqnyuBkLItWoFn62vUOnjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTGQ+cJhe9eZSn5HmAjgjMOPj+acY3/oeNpoK8fL1gqghvZKVnzxOakX7r+haXSBN
	 EL+jVv9tfs1O8+sZRjzU/5akH1X7kfPsUaVG/m7+4diX4raIdu1nTn1V5uY88eDmIJ
	 ZSBKP/3zmgEbntuMMAdFJ5mE3wK2dGCtgX8VTwXM5y3rGoLeWMOKotnPLAzmTg9cDk
	 KlnALPQd3PXlcdquOVqHkun20NWb5kWerPFVydU52CDPIHseFhz3V4cUYuYo5QFt8t
	 Fc/D0fPHbSfPcAFVGLX8/1QpitP5eZ4jwbsDgJ4rnP5+HU3TcMX5soZtUbMRICprBB
	 IEYp1lSkuM7pQ==
Date: Thu, 12 Jun 2025 13:19:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <aEq30a7vJmKyYWYT@ryzen>
References: <20250611105140.1639031-7-cassel@kernel.org>
 <20250611211456.GA869983@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611211456.GA869983@bhelgaas>

On Wed, Jun 11, 2025 at 04:14:56PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 11, 2025 at 12:51:42PM +0200, Niklas Cassel wrote:
> > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > and instead enumerate the bus directly after receiving the Link Up IRQ.
> > 
> > This means that there is no longer any delay between link up and the bus
> > getting enumerated.
> 
> Minor quibble about "no longer any delay": dw_pcie_wait_for_link()
> doesn't contain any explicit delay *after* we notice the link is up,
> so we didn't guarantee sufficient delay even before ec9fd499b9c6.
> 
> If the link came up before the first check, dw_pcie_wait_for_link()
> didn't delay at all.  Otherwise, it delayed 90ms * N, and we have no
> idea when in the 90ms period the link came up, so the post link-up
> delay was effectively some random amount between 0 and 90ms.
> 
> I would propose something like:
> 
>   PCI: dw-rockchip: Wait PCIE_T_RRS_READY_MS after link-up IRQ
> 
>   Per PCIe r6.0, sec 6.6.1, software must generally wait a minimum of
>   100ms (PCIE_T_RRS_READY_MS) after Link training completes before
>   sending a Configuration Request.
> 
>   Prior to ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since
>   we can detect Link Up"), dw-rockchip used dw_pcie_wait_for_link(),
>   which waited between 0 and 90ms after the link came up before we
>   enumerate the bus, and this was apparently enough for most devices.
> 
>   After ec9fd499b9c6, rockchip_pcie_rc_sys_irq_thread() started
>   enumeration immediately when handling the link-up IRQ, and devices
>   (e.g., Laszlo Fiat's PLEXTOR PX-256M8PeGN NVMe SSD) may not be ready
>   to handle config requests yet.
> 
>   Delay PCIE_T_RRS_READY_MS after the link-up IRQ before starting
>   enumeration.

Ok, I will shamelessly use this text verbatim.



> I think the comment at the PCIE_T_RRS_READY_MS definition should be
> enough (although it might need to be updated to mention link-up).
> This delay is going to be a standard piece of every driver, so it
> won't require special notice.

Looking at pci.h, we already have a comment mentioning exactly this
(link-up):
https://github.com/torvalds/linux/blob/v6.16-rc1/drivers/pci/pci.h#L51-L63

I will change the patches to use PCIE_RESET_CONFIG_DEVICE_WAIT_MS instead.


Kind regards,
Niklas

