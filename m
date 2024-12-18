Return-Path: <linux-pci+bounces-18722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8689F6CD3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 19:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA49F7A3BC4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D11142624;
	Wed, 18 Dec 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBLmJnlK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6533597C
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544900; cv=none; b=FfOeub4r9kgWNtV3njFIWovf34MzinWWN9GShMJPsgjEZSmDIzQlsTObE6MbihGlbPNZs11sap/53xU4lm+Ox4/vprfHyBd2DlM13PoKrWL61z1m48cEPt4WXi8kVlaPdDErEln3lyeChE3WQ7d4XN3nin29lLlRRl8CDnpRhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544900; c=relaxed/simple;
	bh=oo1XoA+T2fMiKQK400DKv9gyYOz3DxtC48YXgAsvIDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyndDs+uc1f/9jK15/UeJeGwL2D8ArDmmxIhrkWhyPYRb2UYjvkkTuBioySZ96HVjmioBp3DrrVJsel0o9UUmoyROrVX8Q8Jr3YJ5N3m9ALcIHPco2bsXxhpuKVdwXgHXsaU3zt7Xb7D8b5HxF7h5bez0T7YVEZsQK8q72NXrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBLmJnlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA06C4CECD;
	Wed, 18 Dec 2024 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734544899;
	bh=oo1XoA+T2fMiKQK400DKv9gyYOz3DxtC48YXgAsvIDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBLmJnlKZ2oXOFUv3aCuvXvcIPouWRfNBGB0InZQG68taH/+gRBzEBQl8W4EPqdU6
	 Q9D/Iz+lBClBJwvdejutr39FDguQ8EaBcbIl6RrVdpRKhIHxX/dQ1WpaHclYo03RhX
	 kEXzXxcbsxLsNPWJ1lpJRB48lEFfp0zlV5/665hAucxknJhf0uLH+NN/wYsDy36Yh0
	 Vxl3wXmlzaji1AVLQTqEwMaIw9XbqNIr2lNpPM/Xz0jsD3cBv3kHTeXhzVvqpm2pSm
	 8m2d4dHBeATAfsSwHQgwyHs7xnEKHmnKoF/q0uzL9Vm4ap9gdicVCU7AMZX7X0OMSZ
	 BRTeU1BsjuXpQ==
Date: Wed, 18 Dec 2024 19:01:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2MN_9FJnlUuP7vi@ryzen>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2BW4CjdE1p50AhC@vaman>

On Mon, Dec 16, 2024 at 10:05:44PM +0530, Vinod Koul wrote:

[...]

> > 
> > Am I missing something obvious here?
> 
> Yes, I feel nvme being treated as slave transfer, which it might not be.
> This API was designed for peripherals like i2c/spi etc where we have a
> hardware address to read/write to. So the dma_slave_config would pass on
> the transfer details for the peripheral like address, width of fifo,
> depth etc and these are setup config, so call once for a channel and then
> prepare the descriptor, submit... and repeat of prepare and submit ...
> 
> I suspect since you are passing an address which keep changing in the
> dma_slave_config, you need to guard that and prep_slave_single() call,
> as while preparing the descriptor driver would lookup what was setup for
> the configuration.
> 
> I suggest then use the prep_memcpy() API instead and pass on source and
> destination, no need to lock the calls...

Vinod, as always, thank you very much for your suggestion, it is appreciated!


Kind regards,
Niklas

