Return-Path: <linux-pci+bounces-28722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5302EAC9277
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0CC1C07ACD
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C31494A9;
	Fri, 30 May 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKMX6Jkr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232AFBF0
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618481; cv=none; b=trFVCtjL53ED3tf4uTEBZM/ec0gK9iIadpwcduZDZBPeK0kzJgk0nZ85VH49rOSLUW4ZDJr05oImwyGUOOnP0szQgDdQaH/unbY+Y1TuK96o1FEK6sFbe4HqOOH9Dmm3/qWN/PAs7M1WXl/QHqzaFvwi8Pxh3640veD4zcQpmPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618481; c=relaxed/simple;
	bh=SiP/PmZazfxbyJmRDRcM0CTDd+dhG9xAFjjnfdmUn1E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZUXjZvjcSzNHxSWkPphxoYvxZ93Tmxk9dzqw+8ZypEJvC8YrX5v45HjJPe1UyOMy6qXswgoEx4G0FiUeBeAlf8dk0d9Gb2QNR/DtNkC/HH5H8raErSKkXlX9M9zB1QE/+PzDiD1S/46/w+MOXlvyIh9Og+EgMdvRjUGGWA/KDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKMX6Jkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E92AC4CEE9;
	Fri, 30 May 2025 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748618480;
	bh=SiP/PmZazfxbyJmRDRcM0CTDd+dhG9xAFjjnfdmUn1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NKMX6JkrU2+697Aud1vEUya2Txa/Mtx2yEuVUIqz00k2pKaoJ5MPParaRNRA/kXYq
	 225g0OLhRuY6dVEuEgC26AqVSignocKK57h74d1dXlKIi8nbapJe7x3BjwZ0Nq4nYl
	 HoOWRCmCS29vkWU+X4pqJQRft5iTCevVaJc6OU29A/GW6oo4atgFO0bJfSOgYoMTo9
	 XazzNP+0pMzT5hQZS56J/uyPib105RaFXoZgkhODAsrooWOedQWHGm6zEQqHrHOxxI
	 aHUJiFOZMaeCJoGHU2u6mJQnC2UFpItTnCpBsM4KtbzFAbkTLDpGoS/ulxgz0hBPGR
	 41cJ1N4Z5tDFg==
Date: Fri, 30 May 2025 10:21:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <20250530152118.GA148072@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDm5Osv_k-yK6Lbh@ryzen>

On Fri, May 30, 2025 at 03:57:14PM +0200, Niklas Cassel wrote:
> On Wed, May 28, 2025 at 05:42:51PM -0500, Bjorn Helgaas wrote:
> > On Tue, May 06, 2025 at 09:39:36AM +0200, Niklas Cassel wrote:
> > > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > > and instead enumerate the bus when receiving a Link Up IRQ.
> > > 
> > > Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
> > > no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
> > > dw-rockchip: Don't wait for link since we can detect Link Up") makes his
> > > SSD functional again.
> > > 
> > > It seems that we are enumerating the bus before the endpoint is ready.
> > > Adding a msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
> > > threaded IRQ handler makes the SSD functional once again.
> > 
> > This sounds like a problem that could happen with any controller, not
> > just dw-rockchip?
> 
> Correct.
> 
> > Are we missing some required delay that should be
> > in generic code?  Or is this a PLEXTOR defect that everybody has to
> > pay the price for?
> 
> So far, the Plextor drive is the only endpoint that we know of, which is
> not working without the delay.
> 
> We have no idea if this Plextor drive is the only bad behaving endpoint or
> if there are many endpoints with similar issues, because before the
> use_linkup_irq() callback was introduced, we always had (the equivalent of)
> this delay.
> 
> Since this will only delay once the link up IRQ is triggered, it will not
> affect the boot time when there are no endpoint plugged in to the slot, so
> it seemed quite harmless to reintroduce this delay before enumeration.
> 
> But other suggestions are of course welcome.
> 
> 
> Since it seems that we can read the PCI vendor and PCI device ID, it seems
> that at least some config space reads seem to work, so I guess that we could
> try to quirk the PCI vendor and PCI device ID in the nvme driver.
> 
> The nvme driver does have a NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk for some
> Samsung drive, perhaps we could try something similar to the Plextor drive?

Looks like NVME_QUIRK_DELAY_BEFORE_CHK_RDY is used for Seagate (Vendor
ID 0x1bb1), Samsung (0x144d), Memblaze (0x1c5f), and HGST/WDC (0x1c58,
annoyingly not shown as reserved by
https://pcisig.com/membership/member-companies?combine=1c58) adapters.

If we can read the Vendor and Device IDs (and, I assume, BARs and
other things used by enumeration), it sounds like possibly an NVMe
issue, not a PCI issue.

If we can use NVME_QUIRK_DELAY_BEFORE_CHK_RDY for this drive as well,
I think we should because it at least connects the extra delay with a
specific device.

> I don't personally have this problematic NVMe drive, so I am not able to test
> such a patch. The user who reported the problem, Laszlo, has been doing all
> the testing.
> 
> 
> Perhaps Laszlo could try something like:
> 
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6b04473c0ab7..9c409af34548 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2865,6 +2865,12 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
>                 .quirks = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
>                           NVME_QUIRK_NO_DEEPEST_PS |
>                           NVME_QUIRK_IGNORE_DEV_SUBNQN,
> +       },
> +       {
> +
> +               .vid = 0x144d,
> +               .mn = "Samsung Portable SSD X5",
> +               .quirks = NVME_QUIRK_DELAY_BEFORE_CHK_RDY,
>         }
>  };
> 
> 
> .. with the .vid and .mn fields replacd with the correct ones for the Plextor
> drive. (Don't forget to revert patch in $subject when testing this alternate
> solution.)
> 
> I don't have a preference for either solution.
> 
> 
> Kind regards,
> Niklas

