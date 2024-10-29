Return-Path: <linux-pci+bounces-15518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A89B46FB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 11:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17371C20C4B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E02038D6;
	Tue, 29 Oct 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lINJNvTY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74E17A58F;
	Tue, 29 Oct 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198150; cv=none; b=Qp0LKYMq6hlriJ0QbDZk19nK3sieUEFOiSOTge0dzk6whfsrXAbPckY9PD2vvSSlsllRsVX0Mk+M/GcOUTDykr7yQ9jJkAygmtr2G+KybtpaDIIYc4hlnHvt5EJAIlgDl7oGY+97FS16iFn+3pzL81ZFVvMPsiRJvgP7s2giimQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198150; c=relaxed/simple;
	bh=aq++cbQ+5AGHbOH23ddxpmmWU7ItL0ozXF/spT1zIqQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M0CMAjr7LdbpXomCE3Aq7UH50LoHU4+IlW5pZl4Llu4zkamKFNXeQz8exoYDYnOAewqubyguREl3CMsRkqLFgFnI8sLVNKcD08K5UUovwdL3dzlt2n3KeFq6TjxTjkRbRgHqJjtc4L3568HmkCPg+zXqruJVjN9F9RTfvUVnaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lINJNvTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E27C4CECD;
	Tue, 29 Oct 2024 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730198150;
	bh=aq++cbQ+5AGHbOH23ddxpmmWU7ItL0ozXF/spT1zIqQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lINJNvTYE/MQA+aEHXCGgvKMbjanAAMEmvibck+ZDLWf7GCTVNos9nUh6XhCQX8oj
	 vcEJC/aGe6jDQEF9ZzNx5I9QPt08llSlb89dJafrUro3j5hznLe3GcCm6C2OQYW6Fs
	 uhiMzKZQG+Z2If/7pJ+5k8OggaUo/wWTxnSK4lErmJVn6K4TJCGsMy6YrOxRCW7QC+
	 5iNvZeTAfFq9vTToVnvkkMN9mm4lKwIggbGztau5AjJxynLzus1FjjbrjFK6FvNY7+
	 BzJEzn/nREkS2lhQ0AtuivJbdw+H9aJ3QuNOg+coF7bu2wPUMT1gWWPeW00u2NrFlk
	 CrQNz84M6ySFg==
Message-ID: <117828c6-92c4-4af4-b47e-f049f9c2cb7b@kernel.org>
Date: Tue, 29 Oct 2024 19:35:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 10:58, Damien Le Moal wrote:
> This patch series fix the PCI address mapping handling of the Rockchip
> PCI endpoint driver, refactor some of its code, improves link training
> and adds handling of the PERST# signal.
> 
> This series is organized as follows:
>  - Patch 1 fixes the rockchip ATU programming
>  - Patch 2, 3 and 4 introduce small code improvments
>  - Patch 5 implements the .align_addr() operation to make the RK3399
>    endpoint controller driver fully functional with the new
>    pci_epc_mem_map() function
>  - Patch 6 uses the new align_addr operation function to fix the ATU
>    programming for MSI IRQ data mapping
>  - Patch 7, 8, 9 and 10 refactor the driver code to make it more
>    readable
>  - Patch 11 introduces the .stop() endpoint controller operation to
>    correctly disable the endpopint controller after use
>  - Patch 12 improves link training
>  - Patch 13 implements handling of the #PERST signal
>  - Patch 14 adds a DT overlay file to enable EP mode and define the
>    PERST# GPIO (reset-gpios) property.
> 
> These patches were tested using a Pine Rockpro64 board used as an
> endpoint with the test endpoint function driver and a prototype nvme
> endpoint function driver.

Ping ? If there are no issues, can we get this queued up ?

> 
> Changes from v4:
>  - Added patch 6
>  - Added comments to patch 12 and 13 to clarify link training handling
>    and PERST# GPIO use.
>  - Added patch 14
> 
> Changes from v3:
>  - Addressed Mani's comments (see mailing list for details).
>  - Removed old patch 11 (dt-binding changes) and instead use in patch 12
>    the already defined reset_gpios property.
>  - Added patch 6
>  - Added review tags
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
> Damien Le Moal (14):
>   PCI: rockchip-ep: Fix address translation unit programming
>   PCI: rockchip-ep: Use a macro to define EP controller .align feature
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
>   PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
>   PCI: rockchip-ep: Fix MSI IRQ data mapping
>   PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
>   PCI: rockchip-ep: Refactor endpoint link training enable
>   PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
>   PCI: rockchip-ep: Improve link training
>   PCI: rockchip-ep: Handle PERST# signal in endpoint mode
>   arm64: dts: rockchip: Add rockpro64 overlay for PCIe endpoint mode
> 
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../rockchip/rk3399-rockpro64-pcie-ep.dtso    |  20 +
>  drivers/pci/controller/pcie-rockchip-ep.c     | 432 ++++++++++++++----
>  drivers/pci/controller/pcie-rockchip-host.c   |   4 +-
>  drivers/pci/controller/pcie-rockchip.c        |  21 +-
>  drivers/pci/controller/pcie-rockchip.h        |  24 +-
>  6 files changed, 406 insertions(+), 96 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso
> 


-- 
Damien Le Moal
Western Digital Research

