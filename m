Return-Path: <linux-pci+bounces-310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4ED800092
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 01:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508F8B20E26
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 00:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA7387;
	Fri,  1 Dec 2023 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjf4nZl1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F715B2
	for <linux-pci@vger.kernel.org>; Fri,  1 Dec 2023 00:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DFBC433C7;
	Fri,  1 Dec 2023 00:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701391958;
	bh=FTamGyxZ6xkif9xcS2LmFYrrjEdc9OE8YjXQybQDZhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Sjf4nZl1pBHEizgOMqxKB3NuBcpQgj3LNkkhmBjMeU+uNttBzIguL2MjBht3up2aC
	 8DoQxmSkSIR3dOd4Pk3pLAzgYJnzkgSD/958G320k+tzHkLFo9OO/KHlW9FgdjQHgc
	 uOhuUpiTynFM0xQnDMGmGaMz+cRhi0l2yH2oixmKjCllNpdwtnzYhaAt58EjxNKWO/
	 ciwFlJGoxUAjD9oowd6GYtQ5GlgiLWetY8bBpBhFKOVRdEbd9hjzf5+kJSufZSksIr
	 +f2vnQDeoh+VSBdvARecW0xr2zTrMKj4E1EvTfcf8DIFdL5i5lvAl8oSLSgx3q7c+6
	 e5vfkiGGehLuw==
Date: Thu, 30 Nov 2023 18:52:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 00/16] Cleanup IRQ type definitions
Message-ID: <20231201005236.GA504435@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>

On Wed, Nov 22, 2023 at 03:03:50PM +0900, Damien Le Moal wrote:
> The first patch renames PCI_IRQ_LEGACY to PCI_IRQ_INTX as suggested by
> Bjorn (hence the patch authorship is given to him). The second patch
> removes the redundant IRQ type definitions PCI_EPC_IRQ_XXX and replace
> these with a direct use of the PCI_IRQ_XXX definitions. These 2 patches
> have been sent and reviewed previously but were never applied. Hence the
> resend with this new series version.
> 
> The remaining patches rename functions and correct comments etc to refer
> to "intx" instead of "legacy".
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

Looks good to me, Damien.  Thanks for doing all this work.  I think
Lorenzo or Krzysztof will pick this up, and we'll get it into -next.

Bjorn

