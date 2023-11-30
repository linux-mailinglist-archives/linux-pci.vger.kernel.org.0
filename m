Return-Path: <linux-pci+bounces-270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9C7FEA97
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 09:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACCF1C20CB2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 08:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03CA29A0;
	Thu, 30 Nov 2023 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXrNq/E0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205130334
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 08:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6127C433C7;
	Thu, 30 Nov 2023 08:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701333012;
	bh=JXw+/07qPmynAM5uFtAvcs7p+LnNUytI/d3NNcIhWE4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kXrNq/E0nljsJeiq60g/3yrXxC5hszSy+VvsWNsZe0Ghl1Ek2JTIq5BGghITw9/LV
	 DwKr5pvgKENYFwrkfns6dymxA6y788J23dYtGO47Py/Nvc5+icToo6RpHgDr5hhmYq
	 B2/7t0n3vQ+94GJzp1tviS3tGhE3av5Jw5A60ihewwLS3AxyZH5D5QpTQ9oNUIAPlT
	 0lCXg7oLIXg2C2AoHc4Z1YXQBi88lM7kiM+5mXnccrmndo2KY7/LRv1u07yLzrOYjU
	 xild5HE1R8UVmRTlmpvrh5j4449FOuMGbQE8yXxW/FfvjhV/68qUNec8PK4rYfMt90
	 eZrmTkPWMx/lA==
Message-ID: <a3ba7a7e-6b2e-482b-83e7-07d3b0f51991@kernel.org>
Date: Thu, 30 Nov 2023 17:30:09 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] Cleanup IRQ type definitions
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 15:03, Damien Le Moal wrote:
> The first patch renames PCI_IRQ_LEGACY to PCI_IRQ_INTX as suggested by
> Bjorn (hence the patch authorship is given to him). The second patch
> removes the redundant IRQ type definitions PCI_EPC_IRQ_XXX and replace
> these with a direct use of the PCI_IRQ_XXX definitions. These 2 patches
> have been sent and reviewed previously but were never applied. Hence the
> resend with this new series version.
> 
> The remaining patches rename functions and correct comments etc to refer
> to "intx" instead of "legacy".

Ping ?

Note that patch 6 can be dropped and we can do that sort of rename done in that
patch on 6.8-rc1 once the series is applied.

> 
> Changes from v3:
>  - Added tags to patch 2
>  - Added patch 3 to 16
> 
> Changes from v2:
>  - Modified PCI_IRQ_LEGACY comment in patch 1 as suggested by Serge
>  - Fixed forgotten rename in patch 2
> 
> Changes from v1:
>  - Updated first patch Signed-of tag and commit message as suggested by
>    Bjorn.
>  - Added review tags.
> 
> Bjorn Helgaas (1):
>   PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
> 
> Damien Le Moal (15):
>   PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
>   PCI: endpoint: Use INTX instead of legacy
>   PCI: endpoint: Rename LEGACY to INTX in test function driver
>   misc: pci_endpoint_test: Use INTX instead of LEGACY
>   PCI: portdrv: Use PCI_IRQ_INTX
>   PCI: dra7xx: Rename dra7xx_pcie_raise_legacy_irq()
>   PCI: cadence: Use INTX instead of legacy
>   PCI: dwc: Rename dw_pcie_ep_raise_legacy_irq()
>   PCI: keystone: Use INTX instead of legacy
>   PCI: dw-rockchip: Rename rockchip_pcie_legacy_int_handler()
>   PCI: tegra194: Use INTX instead of legacy
>   PCI: uniphier: Use INTX instead of legacy
>   PCI: rockchip-ep: Use INTX instead of legacy
>   PCI: rockchip-host: Rename rockchip_pcie_legacy_int_handler()
>   PCI: xilinx-nwl: Use INTX instead of legacy
> 
>  drivers/misc/pci_endpoint_test.c              | 30 +++----
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 19 ++--
>  drivers/pci/controller/cadence/pcie-cadence.h | 12 +--
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 10 +--
>  drivers/pci/controller/dwc/pci-imx6.c         | 11 ++-
>  drivers/pci/controller/dwc/pci-keystone.c     | 86 +++++++++----------
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 10 +--
>  drivers/pci/controller/dwc/pcie-artpec6.c     |  8 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  8 +-
>  .../pci/controller/dwc/pcie-designware-plat.c | 11 ++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  4 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     | 13 ++-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  8 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  9 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 19 ++--
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 11 ++-
>  drivers/pci/controller/dwc/pcie-uniphier.c    | 12 +--
>  drivers/pci/controller/pcie-rcar-ep.c         |  7 +-
>  drivers/pci/controller/pcie-rockchip-ep.c     | 23 +++--
>  drivers/pci/controller/pcie-rockchip-host.c   |  4 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c      | 52 +++++------
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  4 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 14 +--
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  7 +-
>  drivers/pci/endpoint/pci-epc-core.c           |  6 +-
>  drivers/pci/pcie/portdrv.c                    |  8 +-
>  include/linux/pci-epc.h                       | 11 +--
>  include/linux/pci.h                           |  4 +-
>  include/uapi/linux/pcitest.h                  |  3 +-
>  31 files changed, 206 insertions(+), 226 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research


