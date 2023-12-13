Return-Path: <linux-pci+bounces-909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27513811EEE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F54B210FC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFD968290;
	Wed, 13 Dec 2023 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t50l+WwE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E796828D;
	Wed, 13 Dec 2023 19:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51784C433C8;
	Wed, 13 Dec 2023 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702495865;
	bh=ck/wlW7lhdixRCwMQVnEmgl26YYLiC5AomhVJrGXoWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=t50l+WwEfAt/LGh4Ix2wvMwsh/CHAo3nLKe60yRg+3qJWYBp/9vKdQ4ZZ9Bo+afXz
	 0qsXAlRxqeVqvkrSOIdrn3AKeQaXAr/jdXZ+X9LMPyIosDKqE2gxI/XuBXGz7ewjl0
	 nUaCBMhUlqExx00VdlFSxo3dA7fs28UMzU6ATnLQc2uV6He+KOYu6IJvSl/30LFuOy
	 Krpox1tNxidH4FckA5pHM3Lg/OhhZXAt+hMHO713K1ygfLo1H0hT6tMDUMmFjkOQgn
	 W3uvJwvSUKgBXgjILpjz+uE8xxVnfJxBXsD4SXjxdfwQ3YxMHBRn56FIb0ucV/1gT8
	 2cjSXGEudvYZg==
Date: Wed, 13 Dec 2023 13:31:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
	bhelgaas@google.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] bus: mhi: ep: Add async read/write support
Message-ID: <20231213193103.GA1054774@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>

On Mon, Nov 27, 2023 at 06:15:20PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series add async read/write support for the MHI endpoint stack by
> modifying the MHI ep stack and the MHI EPF (controller) driver.
> 
> Currently, only sync read/write operations are supported by the stack,
> this resulting in poor data throughput as the transfer is halted until
> receiving the DMA completion. So this series adds async support such
> that the MHI transfers can continue without waiting for the transfer
> completion. And once the completion happens, host is notified by sending
> the transfer completion event.
> 
> This series brings iperf throughput of ~4Gbps on SM8450 based dev platform,
> where previously 1.6Gbps was achieved with sync operation.
> 
> - Mani
> 
> Manivannan Sadhasivam (9):
>   bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs
>   bus: mhi: ep: Rename read_from_host() and write_to_host() APIs
>   bus: mhi: ep: Introduce async read/write callbacks
>   PCI: epf-mhi: Simulate async read/write using iATU
>   PCI: epf-mhi: Add support for DMA async read/write operation
>   PCI: epf-mhi: Enable MHI async read/write support
>   bus: mhi: ep: Add support for async DMA write operation
>   bus: mhi: ep: Add support for async DMA read operation
>   bus: mhi: ep: Add checks for read/write callbacks while registering
>     controllers
> 
>  drivers/bus/mhi/ep/internal.h                |   1 +
>  drivers/bus/mhi/ep/main.c                    | 256 +++++++++------
>  drivers/bus/mhi/ep/ring.c                    |  41 +--
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 314 ++++++++++++++++---
>  include/linux/mhi_ep.h                       |  33 +-
>  5 files changed, 485 insertions(+), 160 deletions(-)

Mani, do you want to merge this via your MHI tree?  If so, you can
include Krzysztof's Reviewed-by tags and my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you think it'd be better via the PCI tree, let me know and we can
do that, too.

Bjorn

