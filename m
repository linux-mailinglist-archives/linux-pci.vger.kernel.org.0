Return-Path: <linux-pci+bounces-13930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22509923B4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E1F280C6C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8A739AF4;
	Mon,  7 Oct 2024 04:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwNvKDhH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE53C0D;
	Mon,  7 Oct 2024 04:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728276316; cv=none; b=OS6ypbvPmwT7MSg5wc79EC4aLky8cUQ7I3N9T5RgkO7QvS2h239qgoDB5raMiuL22oO8km8996b6EGEcnshhkijmj/+F4o+qCvzFLUgzPJJ71Q3dd4GCDDjHXVqsm8I1kfmv3w81PzgqyqkcBpN+WJ7ONjSy5zr4GpBlslEW00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728276316; c=relaxed/simple;
	bh=k04oc/fWDIrIeMBDIrXtt1NeFQpylQYkdcFR85dDJVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=P48JxsywrGV6g3nL4G1HrUXqvsC7WGaTRAgBlQFrN8MAJWNBsvkNGO4z30pMuaSlC1VfUvdJdkYT0m5aEe9EBUu+Kg1tN0jUIV/K+Ge6QsZ5fNy2Zv3wvBq37SvnJ7lKIneBL/+BWediCOjTbxUOB+8PZoIpnUyTfe5Fyw4AsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwNvKDhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD0BC4CEC6;
	Mon,  7 Oct 2024 04:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728276316;
	bh=k04oc/fWDIrIeMBDIrXtt1NeFQpylQYkdcFR85dDJVc=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=WwNvKDhHG4XPUO4b11u+QhSWcbCwfrNSuMCBkSxja3Bibqz5WbFlLsz7AVOgOH35b
	 NtKFd5aWObzPEOmzm9abv3fqfjBxAVJCY6G1qe3e6HdBaRzRVLD4saYjBjnVCq8bj9
	 n4t8/5w1CGSSnWVlZEs+aYypPSYmIBgj848lF1Zocg9wTzvk1BtJ7DcrHyfrxCdUrv
	 N9tnSwX52gVzXjOamw7+Qz8TCCOKaCvAI0ulzLkNNkNgKt76T9O9ZgCzQUHSu2ojlN
	 VdNS+eRZaXI2nu+Lhf9/og2ZEM/cWKaVJu7vy2R5Nnp8H2/eoV5kGFkMPIhwL07+BI
	 GbJq3MmL36EyA==
Message-ID: <6b3ee603-a745-4b24-ab6d-ecb63a746917@kernel.org>
Date: Mon, 7 Oct 2024 13:45:13 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12]
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20241007041218.157516-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241007041218.157516-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 13:12, Damien Le Moal wrote:
> This patch series is the second part of the former version 2 of the
> patch series "Improve PCI memory mapping API". This second part is split
> out as it deals solely with the rockchip/rk3399 PCI endpoint controller
> driver.

Missing series title. It should be "Improve rk3399 PCI endpoint controller driver"

Sorry about that.

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


-- 
Damien Le Moal
Western Digital Research

