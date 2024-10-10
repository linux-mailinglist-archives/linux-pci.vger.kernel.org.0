Return-Path: <linux-pci+bounces-14246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32050999571
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E2228662C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB61B5ED4;
	Thu, 10 Oct 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoprVJja"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391A14D6F9;
	Thu, 10 Oct 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600507; cv=none; b=rkAPKIYjb2osilDuLH3BHIbjyFa8KMSG0UOIyiiCv8w1LBY/p3+iOU9yxfyN7o2yi3+f86uHrucuR43rxknzhE/MMsA0WcUgBNhADO5pLHUmwrOW+K+S5Kmtgloohes5nvoA5vj6vlzDqcMMm3s4WPSL4ioPH/vzN4RtzEc5Ql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600507; c=relaxed/simple;
	bh=bG9/yrxcCJCIauROPTKkMfP5DIudZfWyGZnx/vJA8RU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DfDv8T57notv8XgmFBQwxnhqWkPnTGQHVXXO3dLgAgD+AUCdIc6SB1P5eOk/SS+2FoCPEukGTwbHuGMvCxYRPwwpGFj4HI5Tg9ykX7T2oxhrYKjnumnd1rxwq8d4yfzs8ni7XgJIzGCqPZrHtySG53MdenbidELRYeTKpmN6KdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoprVJja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC649C4CEC5;
	Thu, 10 Oct 2024 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728600507;
	bh=bG9/yrxcCJCIauROPTKkMfP5DIudZfWyGZnx/vJA8RU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MoprVJja7xKkmmYrg87yFJPuhWKPlk4RFCFcAtMntQMdG9qIXESLHRkdE1FZxJ0MY
	 GrFdfN7MSkB+dhezzVcMVK59tDfwYGW/8pfcQNzHBNtXlVd7ptf38XFXx8d716xJor
	 pW0smc0yX2CLGm1BNGrtoZu2wib1T505GheJZldchaVyatcEa0IWhU0b5ge8bDdPH0
	 Z+1DSDNYEcBEiXLN8cgt5xI9An6DbVYUdPLTg9jZOwgSbXss0VLs7EMfR7Rp1RN9qL
	 WnykX8alWZMY9oxvb5tA9LzRVazovdXiWu928chWZiZ0dPs+HjGzMcJxKKEnfJfObv
	 f12Ic6qv2qGNw==
Date: Thu, 10 Oct 2024 17:48:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/4] PCI: Resource helper improvements
Message-ID: <20241010224825.GA583421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>

On Fri, Jun 14, 2024 at 01:06:02PM +0300, Ilpo Järvinen wrote:
> This series introduces resource_set_{range,size}() helpers to replace
> often repeated code fragments to set resource start and end addresses.
> The last two patches clean up nearby code.
> 
> For now, this series only converts PCI subsystem. There are plenty of
> resource start/end setting code elsewhere in the kernel but those can
> be converted once the helpers reach Linus' tree.
> 
> --
> v2:
> - Improved commit message
> - Added patch to introduce ALIGN_DOWN_IF_NONZERO()
> 
> Ilpo Järvinen (4):
>   resource: Add resource set range and size helpers
>   PCI: Use resource_set_{range,size}() helpers
>   PCI: Use align and resource helpers, and SZ_* in quirk_s3_64M()
>   PCI: Introduce ALIGN_DOWN_IF_NONZERO() helper locally
> 
>  drivers/pci/controller/pci-tegra.c       |  2 +-
>  drivers/pci/controller/pci-thunder-pem.c |  4 +--
>  drivers/pci/ecam.c                       |  2 +-
>  drivers/pci/iov.c                        |  6 ++--
>  drivers/pci/pci.c                        |  3 +-
>  drivers/pci/quirks.c                     | 23 +++++++---------
>  drivers/pci/setup-bus.c                  | 35 ++++++++++--------------
>  drivers/pci/setup-res.c                  |  7 ++---
>  include/linux/ioport.h                   | 32 ++++++++++++++++++++++
>  9 files changed, 68 insertions(+), 46 deletions(-)

Sorry this slipped through the cracks.  Applied to pci/resource for
v6.13, thanks!

