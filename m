Return-Path: <linux-pci+bounces-8439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758F8FFF8B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E981C22FE2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F115B141;
	Fri,  7 Jun 2024 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvgS8d5/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9AD15A4B0;
	Fri,  7 Jun 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752700; cv=none; b=lLarsrHcOLWLmwWRq64AlF2TfTuqL/HCNeVw2UsunZvwq+JNP8NvME9y+RFrZ0rBvSWJoYXiL7LxrhHDLj+NgzrA5vt/2St343yNB33WaZoOKQE+GTN67foB1zgmCB35WiR+AZvIGRlq4jagIoFa733UBo/G3kjQj9uYclSPhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752700; c=relaxed/simple;
	bh=rhqvtgLdAjJDetwu1HLnQ9oLmOzc4vfXBUwHh6e/WhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCkfezev8K4nGA56N6RvcrL9PaDLDYaXKcsRUB172F/rGQY/CeK4TQOu3JWuDPyjaW7K8ccUMxhFc1AKNtB3WGg58XUBpwbhBjigjsHc327PEwPVTLx43KPFZqHPpkU3VNO4UXKeTLBCqCrFBMBRegC1Z8xZG2WqdhAG/cuoEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvgS8d5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D64AC2BBFC;
	Fri,  7 Jun 2024 09:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717752699;
	bh=rhqvtgLdAjJDetwu1HLnQ9oLmOzc4vfXBUwHh6e/WhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvgS8d5/r8o92wmID2/l03gbU9QAWi7CUT0IEKy/7vK4blclQl++O0siD+W1pPIRG
	 /s9Z0+oaUX8bOt6GmBL5GhYuGexbsFKFZsuXnRguzAumckCsBKgglkzab0VySUz0tP
	 4/EqJQD5Z6OVOQeETexIJPP/WkAcfu8yg30yYDDU1xFm6BvPkQ4Oud+e5SIiJw4jTd
	 0lD1ADHlCHs7c04IQZIMzrXLNniJTMxbSR4JO+3aL4oTsTCsP9fT1TOfYQrPANoAUL
	 fPprirrsaqFRhHwkKVzNeVkm1xgc/DvgYPVHJ77wqpDhdnaLG0j0wSLMv3CnTJ7yfb
	 ZRogfCZ0zHcWA==
Date: Fri, 7 Jun 2024 11:31:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	mhi@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/5] PCI: endpoint: Add EPC 'deinit' event and
 dw_pcie_ep_linkdown() API
Message-ID: <ZmLTcNz0FxAWRYcd@ryzen.lan>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>

On Thu, Jun 06, 2024 at 12:56:33PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series includes patches that were left over from previous series [1] for
> making the host reboot handling robust in endpoint framework.
> 
> When the above mentioned series got merged to pci/endpoint, we got a bug report
> from LKP bot [2] and due to that the offending patches were dropped.
> 
> This series addressed the issue reported by the bot by adding the stub APIs in
> include/pci/pci-epc.h and also removed the unused dwc wrapper as concluded in
> [3].
> 
> Testing
> =======
> 
> This series is tested on Qcom SM8450 based development board with 2 SM8450 SoCs
> connected over PCIe.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org/
> [2] https://lore.kernel.org/linux-pci/202405130815.BwBrIepL-lkp@intel.com/
> [3] https://lore.kernel.org/linux-pci/20240529141614.GA3293@thinkpad/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (5):
>       PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper
>       PCI: endpoint: Introduce 'epc_deinit' event and notify the EPF drivers
>       PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event
>       PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
>       PCI: layerscape-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>  drivers/pci/controller/dwc/pci-imx6.c             |   2 +-
>  drivers/pci/controller/dwc/pci-keystone.c         |   2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |   4 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 116 +++++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware-plat.c |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |  10 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         |   2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |   5 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c       |   2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c        |   3 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |   2 +-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c      |  19 ++++
>  drivers/pci/endpoint/functions/pci-epf-test.c     |  17 +++-
>  drivers/pci/endpoint/pci-epc-core.c               |  25 +++++
>  include/linux/pci-epc.h                           |  13 +++
>  include/linux/pci-epf.h                           |   2 +
>  18 files changed, 162 insertions(+), 68 deletions(-)
> ---
> base-commit: 7d96527bc16e46545739c6fe0ab6e4c915e9910e
> change-id: 20240606-pci-deinit-2e6cdf1bd69f
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

Considering certain dependency patches have been merged to
pci/endpoint and other dependency patches have been merged to
pci/controller/dwc, perhaps it is best if you split this series:

Series 1 based on pci/endpoint: with patch 1/5 and 2/5.
Series 2 based on pci/controller/dwc: with patch 5/5.

Just a friendly suggestion to make Bjorn's life easier
(and grease the path of your patch) ;) [0]


Kind regards,
Niklas

[0]: https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
(I still have this in my bookmarks :P)

