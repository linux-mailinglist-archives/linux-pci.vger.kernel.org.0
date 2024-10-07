Return-Path: <linux-pci+bounces-13945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53669928B1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B2F1C2338D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032E18BC09;
	Mon,  7 Oct 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ciazen3U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F0156875;
	Mon,  7 Oct 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295344; cv=none; b=DczN+i0Qf1g6xhnUpuMtG2xkX2eyBWZ//nuMlIJ0UQX3N4aWkouENTfElEpxzErZY1sCefGThXkEKe596EQlE0XED4KgEBAtPGcdt+S1z+95eZYRLFSZEENHA3hDYtkHndzTjbdszTyvRHInYgwKP9zlzKm8/aWE0k1U708fqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295344; c=relaxed/simple;
	bh=gC8kwKS4o4dn68X8nIgu0t96ZK6t8rNnQHjcCJTC4vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubyW23rF9PJhoEeH79e6kVQFvEBJqvMMN15NkN1cmCkPdiZhdOkZ5TdkreKhrOhON/PEXWlFisQs/SODOWv6RD6ymImyRY7MOXNbV5F1u6UzOP8oI6HxYVFCoRNW0zbK8CSMiEZoF6GcLWML6Voi8N098pgSqW8C956qtKEA6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ciazen3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A76C4CECD;
	Mon,  7 Oct 2024 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728295344;
	bh=gC8kwKS4o4dn68X8nIgu0t96ZK6t8rNnQHjcCJTC4vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ciazen3US+Hkutv+NLfNYb0iyvcKICwKcuw1Z3QvDhL7d0pkJ6BTWLDCDP9UjVRr/
	 R0CfmKOdjWNqskRkxybJLmI59yPGg76XVDMaZDAW+bZ3rVNj6CwQInUbflJbfjtDmA
	 9Nn2PyxayDcyJqWYsQjg2lU9NN8ROTvefXs1Ye8gJ/WrMxpcRJzZtv5rOVG6qvcTZm
	 +XKl7sLScmzNWSfCPiKF090mJKZheUnGFP32YKKc/ReefYTfgZySZLFJIsikj1slYN
	 5ntWTyJDA5Imt7NU4cD/MH1NTf8WCtx2QxN2ogOaFzX0Thx2HTyEC1+YG02DirxURk
	 7wIktFyWtEvEw==
Date: Mon, 7 Oct 2024 12:02:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3 00/12]
Message-ID: <ZwOxqvzBG4i_UGKc@ryzen>
References: <20241007041218.157516-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007041218.157516-1-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:12:06PM +0900, Damien Le Moal wrote:
> This patch series is the second part of the former version 2 of the
> patch series "Improve PCI memory mapping API". This second part is split
> out as it deals solely with the rockchip/rk3399 PCI endpoint controller
> driver.

Since this series depends on:
[1] https://lore.kernel.org/linux-pci/20241007040319.157412-1-dlemoal@kernel.org/

I think that you should have added a link to that series in this cover letter,
and more clearly state that this series depends on [1].

(Right now, someone might think that this series could be applied standalone.)


Kind regards,
Niklas


> 
> This series is organized as follows:
>  - Patch 1 fixes the rockchip ATU programming
>  - Patch 2, 3 and 4 introduce small code improvments
>  - Patch 5 implements the .map_align() operation to make the rk3399
>    endpoint controller driver fully functional
>  - Patch 6, 7 and 8 refactor the driver code to make it more readable
>  - Patch 9 introduces the .stop() endpoint controller operation to
>    correctly disable the endpopint controller after use
>  - Patch 10 improves link training
>  - Patch 11 and 12 implement handling of the #PERST signal
> 
> Changes from v2:
>  - Split the patch series
>  - Corrected patch 11 to add the missing "maxItem"
> 
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags
> 
> Damien Le Moal (11):
>   PCI: rockchip-ep: Fix address translation unit programming
>   PCI: rockchip-ep: Use a macro to define EP controller .align feature
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
>   PCI: rockchip-ep: Implement the .map_align() controller operation
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
>   PCI: rockchip-ep: Refactor endpoint link training enable
>   PCI: rockship-ep: Introduce rockchip_pcie_ep_stop()
>   PCI: rockchip-ep: Improve link training
>   PCI: rockchip-ep: Handle PERST# signal in endpoint mode
> 
> Wilfred Mallawa (1):
>   dt-bindings: pci: rockchip,rk3399-pcie-ep: Add ep-gpios property
> 
>  .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |   4 +
>  drivers/pci/controller/pcie-rockchip-ep.c     | 392 +++++++++++++++---
>  drivers/pci/controller/pcie-rockchip.c        |  17 +-
>  drivers/pci/controller/pcie-rockchip.h        |  22 +
>  4 files changed, 358 insertions(+), 77 deletions(-)
> 
> -- 
> 2.46.2
> 

