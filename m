Return-Path: <linux-pci+bounces-26235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98604A93AC9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 18:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD7A1890969
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8117224B1E;
	Fri, 18 Apr 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgpLl52k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF7224238;
	Fri, 18 Apr 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993280; cv=none; b=amg+MWGAiDzFZUNIlhyaGUtC1B2+wsTAazIF3GRO1IgpWn6FdaIcumY2HsIhvWcrSsUyvuiUPPGP3KvN8O7OTYRbtd28zL65uhAS8HIF6fPF40Fr2R7mSRyOlICEsfAVMz4QS5yFYBZKs1GmNewaPH5sDtQSVhGXWOO0M3Jz22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993280; c=relaxed/simple;
	bh=TQ/708/coALojgpWmh+0t6Mj6T+sMBImBICy+uR2XLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j0rlt3T+xSG7k4hCW89Urf9sVq3wgQvLW4xHiJjQLcY0OuxsHnrfE0XTHhj5nv9ipEBAVkrJc1nNco646qsjBUK7ab+wObg/bDqgBzEEqRg5wYiKPen+Kjrq9TbRI14n4k2VhO0L6dGg+PuxNJjxg0eWd6v+xN6+4oYGMAquLhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgpLl52k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BD5C4CEE2;
	Fri, 18 Apr 2025 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744993280;
	bh=TQ/708/coALojgpWmh+0t6Mj6T+sMBImBICy+uR2XLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IgpLl52kf7whl27FA+ydUhbR8qEmPOQvu6RMxO7oNvjpWuvfTSMEDm/eI/9tCQrAd
	 HnmsyCRKAmHWI80cBIfaEO0xfC23uAIwE6UVZhVZX+4JzvNDxHp8DRRYPrx6KCii27
	 sCm35sgDpch7kfBa/K1aJu6AfA8rxfL3KPn9yhBcjBf3qe2A98lzjHaM/PL/Ddu5VI
	 6mlj1oli4S9Ed9IxYZs7QL/kUXVF1xS+PIVM3CgstBfMrfWPR4UUArTnyFM5vaEKpD
	 aOn40n1fbMtG1TFm9Vz1mjhA/vKXeTCi5ZaW/1pTGayyutHmfIKKWMpfZUhMrc0/cR
	 ozGKYIPF0e0jQ==
Date: Fri, 18 Apr 2025 11:21:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <20250418162118.GA157636@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225CC628-432C-4E88-AF2B-17C948B3790B@kernel.org>

On Fri, Apr 18, 2025 at 04:55:13PM +0200, Niklas Cassel wrote:
> On 18 April 2025 14:33:08 CEST, Hans Zhang <18255117159@163.com> wrote:
> >Thanks your for reply. Niklas and I attempted to modify the
> >relevant logic in drivers/pci/probe.c and found that there was a
> >lot of code judging the global variable pcie_bus_config. At
> >present, there is no good method. I will keep trying.
> >
> >I wonder if you have any good suggestions? It seems that the code
> >logic regarding pcie_bus_config is a little complicated and cannot
> >be modified for the time being?
> 
> If:
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..2e1c92fdd577 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2983,6 +2983,13 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>          if (!pci_is_pcie(bus->self))
>                  return;
>   +       /*
> +        * Start off with DevCtl.MPS == DevCap.MPS, unless PCIE_BUS_TUNE_OFF.
> +        * This might get overriden by a MPS strategy below.
> +        */
> +       if (pcie_bus_config != PCIE_BUS_TUNE_OFF)
> +               smpss = pcie_get_mps(bus->self);
> +
>          /*
>           * FIXME - Peer to peer DMA is possible, though the endpoint would need
>           * to be aware of the MPS of the destination.  To work around this,
> 
> 
> 
> does not work, can't you modify the code slightly so that it works?
> 
> I haven't tried myself, but considering that it works when walking
> the bus, it seems that it should be possible to get something
> working.

Thanks, Niklas, this seems like a reasonable place to start.
Hopefully we can drop the controller-specific quirks since there's
nothing controller-specific about them.

Bjorn

