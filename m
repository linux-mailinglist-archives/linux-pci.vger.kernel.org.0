Return-Path: <linux-pci+bounces-14444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F271799C963
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88BEB250CC
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9E198A1B;
	Mon, 14 Oct 2024 11:38:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0F194ACD
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905898; cv=none; b=VF7kJqfeBSTldD08IFpuNVuZ0/GksAyJCsSYQxupUMLLftgMzKORcK5TdokG+R3yCyQu/sV/TBEuICE9ava9YfohcsH5iXqQ4miqyTbyxz3OSLVHDCnGnSvhJU/EW03h5n03WdLQHAJydrZbUSdI3Bpubc8fcGWzYfx/Gv68F5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905898; c=relaxed/simple;
	bh=rcNxwhja1d6ZxUloaCnQMXN4Gr1EsCJjv4jijpJzu6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA8jSgb6H5ipYEPhSUH2i0TtfRVnMKJWSy206wSdfNgcGTvkBIp++XV2Lgw0/V+m1lE6nbREB8vB014h6jyrIWZHa4nvZbrKTYPA3Sny4Qw2C2lRHctu//IWJ0++Q60j342ovtjnlNWJFx7JmFmrWCsQuphxyvTfj0gUnOAmUDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C13CD227AA8; Mon, 14 Oct 2024 13:38:09 +0200 (CEST)
Date: Mon, 14 Oct 2024 13:38:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <20241014113809.GA31551@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-5-dlemoal@kernel.org> <20241014084424.GC23780@lst.de> <79e57ebb-eef7-48b1-b337-845d2ef6ff49@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e57ebb-eef7-48b1-b337-845d2ef6ff49@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 14, 2024 at 07:41:18PM +0900, Damien Le Moal wrote:
>         |    | PCIe NVMe endpoint driver |     |
> 	|    | (Handles BAR registers,   |     |
> 	|    | doorbells, IRQs, SQs, CQs |     |
> 	|    | and DMA transfers)        |     |
>         |    +---------------------------+     |
>         |                  |                   |
>         |    +---------------------------+     |
>         |    |     NVMe fabrics host     |     |
>         |    +---------------------------+     |

That whole fabrics host here is broken.  The PCI frontend needs to
talk directly to the target code instead of doing a completely
pointless roundtrip through the block layer.

> Unless I am mistaken, if I use a PCI transport as the base for the endpoint
> driver, I would be able to connect only to a PCIe nvme device as the backend, no
> ?

No.  Any fabrisc transport (or frontend) can you any of the the
backends (file / bdev and passthrough).


