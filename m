Return-Path: <linux-pci+bounces-43951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B1CEF7D9
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 00:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B0FF300CAD8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6A253958;
	Fri,  2 Jan 2026 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbsna8ki"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1957229B12;
	Fri,  2 Jan 2026 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767397235; cv=none; b=F40wBBGH+LbOD3cI4ENL0rucyaER1YkNShoPEAplt7gVgfMKLnM7xRjK2G3yOQ3zZO0Rk6e7Xy30VNQe6kAQwsQH5nEadMsN7LDB1QBiLR/TXbd+hYfDtNMPk4tCHRD828xm7bG55UBz8B/xP1whssKqSWginFycO8rl0RiTeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767397235; c=relaxed/simple;
	bh=x7f28/Ng5b88CEmwpvA5V4VQtQ0Qc9WqLA9Qn0FPIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kYESK3gyrVPyLVsu0TAMels+2yG+6aWKHFx3bgIZp6cWxipe9lx4G9PHeuPSTrUnZ2QA6nOYYT7a9JTHLQBrx1vvLMR4KzatmQ+u+ttQlOO+yKwDYsUpOYmBQJcRWEvrgxgFe14pJwOxC7/q8+7Lx9iJ7D1a6/zgjKjIF9Daj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbsna8ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60008C116B1;
	Fri,  2 Jan 2026 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767397234;
	bh=x7f28/Ng5b88CEmwpvA5V4VQtQ0Qc9WqLA9Qn0FPIHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sbsna8kiBrABW6jv0c/5jPiwrg0tzr1BUsxLcg7YYvSHLkHPQZVofjK9zYjsBrGOu
	 OetF8Jz/BiMYv93k5Qn+8qxOEW7eTklnZcR999dT+89OPYttQsKwhIo53wNCOLGFkH
	 NFfjlp6EdC/7nFhAsyqF0WpC2ZlkKY8Cm7xvbZpAlffz8+d9Jrd+TG+rbl8NDt8IeA
	 CwDSp7z1lm85knFQ7txYZPVM5RDPth4+WGj1GP9fjBjuvdOPgWI6mtEq51cpD7Z6LT
	 To1P1Khuf8zh5ntGhLIHT0R/eFMByz9p333QY+ag0n8reBgqAki9zNWXaKy2NCxYL6
	 dMDivF2vh78eQ==
Date: Fri, 2 Jan 2026 17:40:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 01/11] PCI/P2PDMA: Separate the mmap() support from
 the core logic
Message-ID: <20260102234033.GA246107@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-dmabuf-vfio-v9-1-d7f71607f371@nvidia.com>

[cc list trimmed]

On Thu, Nov 20, 2025 at 11:28:20AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Currently the P2PDMA code requires a pgmap and a struct page to
> function. The was serving three important purposes:
> ...

> +++ b/include/linux/pci-p2pdma.h
> @@ -16,6 +16,16 @@
>  struct block_device;
>  struct scatterlist;
>  
> +/**
> + * struct p2pdma_provider
> + *
> + * A p2pdma provider is a range of MMIO address space available to the CPU.
> + */

Already upstream (f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap()
support from the core logic")), but this adds kerneldoc warnings:

  Warning: include/linux/pci-p2pdma.h:26 struct member 'owner' not described in 'p2pdma_provider'
  Warning: include/linux/pci-p2pdma.h:26 struct member 'bus_offset' not described in 'p2pdma_provider'

Repro:

  $ scripts/kernel-doc -none include/linux/pci-p2pdma.h

> +struct p2pdma_provider {
> +	struct device *owner;
> +	u64 bus_offset;
> +};

