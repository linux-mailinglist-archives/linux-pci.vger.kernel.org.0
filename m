Return-Path: <linux-pci+bounces-43558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F12BCD85CD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 08:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DF2F3010A84
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B162E03F1;
	Tue, 23 Dec 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNh/3vSg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F12DECBF
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473935; cv=none; b=bNJUfgQKcQ8FfbLT1qXmYcagjgQ0Pw/CQmjboPeDyh7ImbGQVZiubHs7CiB7ZM/Wn/pbPzUn8D16J763DMD9ztHi8WfS5X2bCQlS3UacRKkWpG85P66vJ51HnwMRoUMdUD6N9nCqFSi2gfX+faD1r9sfmhj0XL7mb4ie89oSxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473935; c=relaxed/simple;
	bh=uAeBySv1vdL9FAJYV/sDbV1GgOxW9u8yyePOrf0vwXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwXKxsh+HPQFdBNzUGt7bPx89TmCyc7G76Sb0fz8HgMQAlfSpm8qiEJ4eoGjpuj3bYWJoXUvkU3gQCdpqlAjm+GdQFUvRJc02q2akp63IE1uJb06uga92g/r9juptpkCHRMS4zoTQ4BV/kQQVBv8uZeMGTwM/KX4znvOa6h3gHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNh/3vSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16DC113D0;
	Tue, 23 Dec 2025 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766473934;
	bh=uAeBySv1vdL9FAJYV/sDbV1GgOxW9u8yyePOrf0vwXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNh/3vSg2cPez2YrORpdSgR1iQevb5Oqc3xJtyFr5GhRhF8xBjG0fxV4TOuFkZtP6
	 9jn3PBP4zz49m0BaCkYD8rALyQAwgITYSHGrdlOtGfPPsBwIhDIoRqap+f4rE0b2tX
	 Abjvtc1b1T9rdUAteIhTyZveqmrSRUfKH7f905brHc8+oH95ada3w7Nr/PjBWfJ2g8
	 FatEZiglS54/ADOw99hXtZQGESdm7/1mFY6dk19bihzhvrYFNNyjJ06PkEW1+s+fJo
	 T1SOoXwFoI7o7uOHC3fv+6iAvQmBATKIXAQZi4UvWHRi9nLWVB8N2O8d7KBo0RlCL6
	 zVsn1uLnXUcTw==
Date: Tue, 23 Dec 2025 08:12:09 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <aUpAyag1bJLpOruG@ryzen>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
 <aUknSzSpNxLeEN5o@ryzen>
 <3b34aa66-a418-4f6b-930a-0728d87d79b6@oss.qualcomm.com>
 <aUlA7y95SUC-QA4T@ryzen>
 <a24a5d8b-5818-4e11-bc09-47090de164c7@rock-chips.com>
 <63321b7d-74a7-448f-ab20-08cc771beb5d@oss.qualcomm.com>
 <424133b7-bd6b-4602-96ea-4413ce4f985d@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424133b7-bd6b-4602-96ea-4413ce4f985d@rock-chips.com>

On Tue, Dec 23, 2025 at 02:23:39PM +0800, Shawn Lin wrote:
> > On 12/23/2025 6:42 AM, Shawn Lin wrote:
> > > I checked the IP configurtion parameters for RK3588 DM controller for
> > > sure, it sets MSIX_TABLE_EN=1.
> > > 
> > > Looking into dw_pcie_ep_raise_msix_irq_doorbell(), it doesn't seem to
> > > match the dwc databook. No matter for non-AXI mode or AXI access mode,
> > > shouldn't we need to generate a MSI-X table RAM with data/address/
> > > vector/TC in advanced? Am I missing anything because I didn't look
> > The MSI-X table will updated automatically when host updates the MSI-X
> > table, when MSI-X is enabled
> > by host.
> 
> Thanks for these details.
> I re-read the databook, especially "Figure 3-49 iMSIX-TX: MSIX
> Transmit ". Yes, it's updated automatically when host write access
> it, which either comes from RX or local DBI(for debug purpose).

Shawn,

if you have time to help figure out why we cannot simply
replace dw_pcie_ep_raise_msix_irq() with dw_pcie_ep_raise_msix_irq_doorbell()
in rockchip_pcie_raise_irq(), that would be appreciated.

As you can see, we get IOMMU errors on the host side if we
reprogram the outbound iATU while outgoing transactions are in flight.

Mani, perhaps we should even add a WARN_ON() in dw_pcie_ep_raise_msix_irq()
that warns users that this function is broken and will lead to transactions
to random writes on the host side memory, which is quite bad...


Kind regards,
Niklas

