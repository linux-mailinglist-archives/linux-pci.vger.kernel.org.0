Return-Path: <linux-pci+bounces-15652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C74CA9B6E30
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 21:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBA21F216C2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E411EC016;
	Wed, 30 Oct 2024 20:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3JtQJax"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6471BD9DF;
	Wed, 30 Oct 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321826; cv=none; b=rRIL4Jn/Yg6xAr8AsK8qUpiUh15h9CaxA+Rfj76OhFcfDORcFpwf2GuoL3Gm+EFnt7lKf44w7U+eZvNJauRG5rlYK0QtCuqCaiimy7mZ1ETmvxq2DB2Gfo9IePhZT/DWqq1WeKxL4JnwpyyBFc9diC1JIxIZHPZT/HW9VEC10Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321826; c=relaxed/simple;
	bh=XPLETH6IvogiR50LRg6ev0FzS09rdHbQJGqQIAlUxgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rSxvD4gfMhthYYx0Q0XAqvJ9ReeXKy6ygl3k+YQZ51IU8o2l8QxmXj161nn0k11WRERSa8ITv1XoaEbgD0LoMw4GeU1NPMdnroRqxWVMGqInCnHkF9TlEZna7R/ssIdPlZXQ4xvvVf0FH7wL8aQpdUaVybooSembj6flcuCBvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3JtQJax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9470BC4CECE;
	Wed, 30 Oct 2024 20:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321825;
	bh=XPLETH6IvogiR50LRg6ev0FzS09rdHbQJGqQIAlUxgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k3JtQJaxR5Yk2wmxCZsDMiosrnNJmzWeCK7TqABeoRViZBcgxSR/Aj8Vb7FWRk1zG
	 lxwqpBuqAYnnxDiaM8rCrhtZGb86GXYELynmh4xutm0dndQ3iBvycoAJw4+H8e6V7F
	 ZRjtU1j9MqXPqxAykncoxHfLxYdv5OQipURElOwL2mjO21q2ICwVnTavLIx37ISErZ
	 4jtVLwQDzAmKCx6DpFF94BwdToPDVGrzRJvelwX7Q8+aMM6PzysovbUrD5Osg01YO+
	 Zs56hWd5drU+1q7H46BkMxfUq5qfTrQMwPgGFb6nUsfBrS8BK3Fpyd6wWrsHobhiYF
	 F0BMRSSiCRMgw==
Date: Wed, 30 Oct 2024 15:57:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v6 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation
Message-ID: <20241030205703.GA1219329@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1725901439.git.jan.kiszka@siemens.com>

On Mon, Sep 09, 2024 at 07:03:53PM +0200, Jan Kiszka wrote:
> Changes in v6:
>  - make restricted DMA memory-region available to all pci-keystone
>    devices, moving property to unconditional section (patch 2)
> 
> Changes in v5:
>  - resolve review comments on pci-host bindings
>  - reduce DMA memory regions to 1 - swiotlb does not support more
>  - move activation into overlay (controlled via firmware)
>  - use ks_init_vmap helper instead of loop in
>    rework ks_init_restricted_dma
>  - add more comments to pci-keystone
>  - use 2 chained TLBs of PVU to support maximum of swiotlb (320 MB)
> 
> Changes in v4:
>  - reorder patch queue, moving all DTS changes to the back
>  - limit activation to IOT2050 Advanced variants
>  - move DMA pool to allow firmware-based expansion it up to 512M
> 
> Changes in v3:
>  - fix ti,am654-pvu.yaml according to review comments
>  - address review comments on ti,am65-pci-host.yaml
>  - differentiate between different compatibles in ti,am65-pci-host.yaml
>  - move pvu nodes to k3-am65-main.dtsi
>  - reorder patch series, pulling bindings and generic DT bits to the front
> 
> Changes in v2:
>  - fix dt_bindings_check issues (patch 1)
>  - address first review comments (patch 2)
>  - extend ti,am65-pci-host bindings for PVU (new patch 3)
> 
> Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
> against DMA-based attacks of external PCI devices. The AM65 is without
> an IOMMU, but it comes with something close to it: the Peripheral
> Virtualization Unit (PVU).
> 
> The PVU was originally designed to establish static compartments via a
> hypervisor, isolate those DMA-wise against each other and the host and
> even allow remapping of guest-physical addresses. But it only provides
> a static translation region, not page-granular mappings. Thus, it cannot
> be handled transparently like an IOMMU.
> 
> Now, to use the PVU for the purpose of isolated PCI devices from the
> Linux host, this series takes a different approach. It defines a
> restricted-dma-pool for the PCI host, using swiotlb to map all DMA
> buffers from a static memory carve-out. And to enforce that the devices
> actually follow this, a special PVU soc driver is introduced. The driver
> permits access to the GIC ITS and otherwise waits for other drivers that
> detect devices with constrained DMA to register pools with the PVU.
> 
> For the AM65, the first (and possibly only) driver where this is
> introduced is the pci-keystone host controller. Finally, this series
> provides a DT overlay for the IOT2050 Advanced devices (all have
> MiniPCIe or M.2 extension slots) to make use of this protection scheme.
> Application of this overlay will be handled by firmware.
> 
> Due to the cross-cutting nature of these changes, multiple subsystems
> are affected. However, I wanted to present the whole thing in one series
> to allow everyone to review with the complete picture in hands. If
> preferred, I can also split the series up, of course.

I'm not sure where this ended up.

The pci-keystone.c patch looks OK to me, and I don't see any comments
from the PCI folks who normally take care of host controller drivers.

I guess it depends on the soc PVU driver, so I'll ack the keystone
part and whoever takes the soc part can include it.

> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: "Krzysztof Wilczyński" <kw@linux.com>
> CC: linux-pci@vger.kernel.org
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
> Jan Kiszka (7):
>   dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
>   dt-bindings: PCI: ti,am65: Extend for use with PVU
>   soc: ti: Add IOMMU-like PVU driver
>   PCI: keystone: Add support for PVU-based DMA isolation on AM654
>   arm64: dts: ti: k3-am65-main: Add PVU nodes
>   arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
>   arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices
>     behind PCI RC
> 
>  .../bindings/pci/ti,am65-pci-host.yaml        |  28 +-
>  .../bindings/soc/ti/ti,am654-pvu.yaml         |  51 ++
>  arch/arm64/boot/dts/ti/Makefile               |   5 +
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  38 +-
>  ...am6548-iot2050-advanced-dma-isolation.dtso |  33 ++
>  drivers/pci/controller/dwc/pci-keystone.c     | 108 ++++
>  drivers/soc/ti/Kconfig                        |   4 +
>  drivers/soc/ti/Makefile                       |   1 +
>  drivers/soc/ti/ti-pvu.c                       | 500 ++++++++++++++++++
>  include/linux/ti-pvu.h                        |  16 +
>  10 files changed, 777 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
>  create mode 100644 drivers/soc/ti/ti-pvu.c
>  create mode 100644 include/linux/ti-pvu.h
> 
> -- 
> 2.43.0
> 

