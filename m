Return-Path: <linux-pci+bounces-34797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A708B374C6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 00:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511D81BA378F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F8C285418;
	Tue, 26 Aug 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJk+3Sxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAB26CE0A;
	Tue, 26 Aug 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756246207; cv=none; b=WrZZY6I61qJBZ+IbIs+9TIZRU5lXCEDCykF4FdNyNDZwLyaWn2rh3AauK+kPRPfwkullgqB9TfOzkiDogROmGlCz+l3VrqFfHOd0a5eS4GChcBfZrk3JHVh0bfLZ4nh/nrVazxgJos+MgoYFfPTBfluwmfOgstUVEt8on7jk3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756246207; c=relaxed/simple;
	bh=fioVeqhXNB9Fxx0/JBG7Xt/edyDhgxPlIFy5Og5p0OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmRkDgEeu61e1KhE1KMcNzNQg5/CUa8NS4NrFr3h9qyPLbpUq7SWMibZDkoXSZQBBLInujrFto/y6wdo/y1qKIeH4gudQSRyuZ8NuhYCTNg7Pj0GatbStFUL9SK9fKruZqnulpg5CNtpb8eGfoox1DsPUoIn14PEm7B816ycEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJk+3Sxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21115C4CEF1;
	Tue, 26 Aug 2025 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756246206;
	bh=fioVeqhXNB9Fxx0/JBG7Xt/edyDhgxPlIFy5Og5p0OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJk+3Sxv/gNM9s2ymXEAgMEo/4Q6+p9e9IZExcg2d6IvBe/d10vPtfqIgwgQv70FH
	 ED5m9jC4xK0JecdtQKVWffqWrXcw737m5QStsQdU2rkJxJyFKxvYlDar5Y/hP0Ubec
	 C6YWhDP53rmMgiiSHlVTt3rUS4hBBDDHTdZ0ipqienuCu7Hc7vKR7KeTIV/fkdn1vb
	 x3kI9lSjfYQ75pPPSFxkKZq0yluEn5A22/f3dWQ+4pFt7LHxgy5yVXxKT85c4ylMvK
	 MQz9dhkZInJK/lZ+/WAqXz8CmeQ/SdMUvrhzvYTXIsTw4n6NF1y1km0BQ7IEc3U8zx
	 jmcanHhP74vtA==
Date: Tue, 26 Aug 2025 15:09:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, regressions@lists.linux.dev,
	linux-next@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, arnd@arndb.de,
	dan.carpenter@linaro.org, naresh.kamboju@linaro.org,
	benjamin.copeland@linaro.org
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <20250826220959.GA4119563@ax162>
References: <20250813232835.43458-1-inochiama@gmail.com>
 <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK4O7Hl8NCVEMznB@monster>

On Tue, Aug 26, 2025 at 09:45:48PM +0200, Anders Roxell wrote:
> Regressions found while booting the Linux next-20250826 on the
> qemu-arm64, qemu-armv7 due to following kernel log.
> 
> Bisection identified this commit as the cause of the regression.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducible? Yes
> 
> First seen on the next-20250826
> Good: next-20250825
> Bad: next-20250826
> 
> Test regression: next-20250826 gcc-13 boot failed on qemu-arm64 and
> qemu-armv7.
> 
> Expected behavior: System should boot normally and virtio block devices
> should be detected and initialized immediately.
> 
> Actual behavior: System hangs for ~30 seconds during virtio block device
> initialization before showing scheduler deadline replenish errors and
> failing to complete boot.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> [...]
> <6>[    1.369038] virtio-pci 0000:00:01.0: enabling device (0000 ->
> 0003)
> <6>[    1.420097] Serial: 8250/16550 driver, 4 ports, IRQ sharing
> enabled
> <6>[    1.450858] msm_serial: driver initialized
> <6>[    1.454489] SuperH (H)SCI(F) driver initialized
> <6>[    1.456056] STM32 USART driver initialized
> <6>[    1.513325] loop: module loaded
> <6>[    1.515744] virtio_blk virtio0: 2/0/0 default/read/poll queues
> <5>[    1.527859] virtio_blk virtio0: [vda] 5397504 512-byte logical
> blocks (2.76 GB/2.57 GiB)
> <4>[   29.761219] sched: DL replenish lagged too much
> [here it hangs]

FWIW, I am also seeing this on real arm64 hardware (an LX2160A board and
an Ampere Altra one) but with my NVMe drives failing to be recognized.
In somewhat ironic fashion, I am seeing the message from cover letter
repeating.

  nvme nvme0: I/O tag 8 (1008) QID 0 timeout, completion polled
  [  125.810062] dracut-initqueue[640]: Timed out while waiting for udev queue to empty.
  nvme nvme0: I/O tag 9 (1009) QID 0 timeout, completion polled

I am happy to test patches or provide information.

Cheers,
Nathan

# bad: [d0630b758e593506126e8eda6c3d56097d1847c5] Add linux-next specific files for 20250826
# good: [b6add54ba61890450fa54fd9327d10fdfd653439] Merge tag 'pinctrl-v6.17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect start 'd0630b758e593506126e8eda6c3d56097d1847c5' 'b6add54ba61890450fa54fd9327d10fdfd653439'
# good: [968d16786392f6e047329f5eff66acc131636019] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect good 968d16786392f6e047329f5eff66acc131636019
# good: [042e9f528d5362c499b5d8e2716cf6f64ca53add] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
git bisect good 042e9f528d5362c499b5d8e2716cf6f64ca53add
# bad: [beebb75399dc36e7c244db0a08426053b4581ecc] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
git bisect bad beebb75399dc36e7c244db0a08426053b4581ecc
# good: [62df8fb299358a45a915381de09025cf5e6a4a8f] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
git bisect good 62df8fb299358a45a915381de09025cf5e6a4a8f
# bad: [1e6d2dcb13c8d94b56de1eff60235ca90587046b] Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 1e6d2dcb13c8d94b56de1eff60235ca90587046b
# bad: [a0daa9e939dbcd7767090151771d94ade75a4fd5] Merge branch into tip/master: 'x86/build'
git bisect bad a0daa9e939dbcd7767090151771d94ade75a4fd5
# bad: [d147a3db0dfa15c8e460f007128bd0fe2e1b877f] Merge branch into tip/master: 'perf/core'
git bisect bad d147a3db0dfa15c8e460f007128bd0fe2e1b877f
# good: [be5697d7136525a91e7f30fdca2e7de737d9a8ed] Merge branch into tip/master: 'irq/core'
git bisect good be5697d7136525a91e7f30fdca2e7de737d9a8ed
# good: [5d299897f1e36025400ca84fd36c15925a383b03] perf: Split out the RB allocation
git bisect good 5d299897f1e36025400ca84fd36c15925a383b03
# bad: [7fb83eb664e9b3a0438dd28859e9f0fd49d4c165] irqchip/loongson-eiointc: Route interrupt parsed from bios table
git bisect bad 7fb83eb664e9b3a0438dd28859e9f0fd49d4c165
# bad: [7ee4a5a2ec3748facfb4ca96e4cce6cabbdecab2] irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044
git bisect bad 7ee4a5a2ec3748facfb4ca96e4cce6cabbdecab2
# bad: [9d8c41816bac518b4824f83b346ae30a1be83f68] irqchip/sg2042-msi: Fix broken affinity setting
git bisect bad 9d8c41816bac518b4824f83b346ae30a1be83f68
# bad: [54f45a30c0d0153d2be091ba2d683ab6db6d1d5b] PCI/MSI: Add startup/shutdown for per device domains
git bisect bad 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b
# first bad commit: [54f45a30c0d0153d2be091ba2d683ab6db6d1d5b] PCI/MSI: Add startup/shutdown for per device domains

