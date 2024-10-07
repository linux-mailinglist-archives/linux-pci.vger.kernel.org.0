Return-Path: <linux-pci+bounces-13946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFB9928E0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D97283D29
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344211B3F30;
	Mon,  7 Oct 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3mmBNwX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE61B2EEB
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295973; cv=none; b=IJBChYAoCrktYwrf/bUj67zVJFgaQJCq+w5tZj+fCohuFZWiUwLLD2Zv/51wBKO4mMVlmg8FnyAUGQSULhd8zDxeVmuZU+zHYXhfma+C88BT1YHGfUtF+un8ZzPWJs6hfk6I+ONkgGpNTRTMqRbuu/haxB5ANsRdpnHBEGP5wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295973; c=relaxed/simple;
	bh=A4mVW+NY0i2mTRbjd0MsKzvQOK8+Z8feayyGgEKqI6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJeCRytGRPT/S1J/wilvJlccF1XmwaT9oYM/AhVGr1wVcjeZ9dDzfAKhbAZpgyfj3ii6rKA6/cGR/0O8ZvVDEr7hDkmWK8Xi/3czk7CWJvcqtaKRxUGsI1llz2N/c0U3QspkTBaecaaqcyZowdINuiuvrwJOUD+DY7Hmasw05yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3mmBNwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E505C4CEC6;
	Mon,  7 Oct 2024 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728295972;
	bh=A4mVW+NY0i2mTRbjd0MsKzvQOK8+Z8feayyGgEKqI6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3mmBNwX9c1Z760gy2vCO1/3tfZCVfWshnX6r9NvN4ckQ1+3ti5NS+viE43QbapBX
	 COc9hAuSmjjRuSo/r9UT8KCC0YvouzLNRGxLRy/a9SRZMRv29KcHviKeOidc9khOiP
	 4388oV8+RHUb37Kn0+vhXj/ddhf0gkwctBnDHsIhFvLCBEF653gVuV4iUJtOBZOFgB
	 qtKo0OVJPbGCt+d+3BBWwXzxuCThhDndwwgqDhf282/YiZGwJ76801dBATzR3er62V
	 sx+yU+qzhrOiaSocVDmyUlA4gZkwn52k0aqddvuzAsTGgiuTC4T3n0/rBM2UvuER3o
	 AdD5nM7iZ+UmQ==
Date: Mon, 7 Oct 2024 12:12:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <ZwO0H0WCnORq9EzQ@ryzen>
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007044351.157912-5-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

(snip)

> Early versions of this driver code were based on an RFC submission by
> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/).
> The code however has since been completely rewritten.

Here you state that the code has been completely rewritten...


> 
> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/pci/endpoint/functions/Kconfig        |    9 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 +++++++++++++++++
>  4 files changed, 2506 insertions(+)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c

(snip)

> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
> @@ -0,0 +1,2489 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe function driver for PCI Endpoint Framework
> + *
> + * Copyright (C) 2019 SiFive

...yet here you claim Copyright (C) SiFive.

*If* the code has been completely rewritten, then you probably should
put yourself and/or your current employeer as the copyright holder.


Kind regards,
Niklas

