Return-Path: <linux-pci+bounces-26335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E5A9534B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 17:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75147188E631
	for <lists+linux-pci@lfdr.de>; Mon, 21 Apr 2025 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4981E1C6FF9;
	Mon, 21 Apr 2025 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJBMGDNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5514AD20;
	Mon, 21 Apr 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248051; cv=none; b=KtO9Z2VcOkfvE2e71guSC4XJ3TWSNpyG2Lys8+2FzKGgA5jOsIf1E6X3hb2QvHv63HeFxZ6SnEDTud7c8pZJAxree3jZAjwfLYBsfGbCR2lSwtFfpuF8zvEd2+kpWkhR4PknEU0bPVDzrGJ9wo86HGvw88bikUW05zlnlHCE96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248051; c=relaxed/simple;
	bh=po7Jc+hppAfgmCAjsxpSgRbNiUij6SS676p735sVSTg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JgjflnxgfTQkgfWXxw4GDemerlC767n4Gi1Kr+Hxmz4Jq4DANkIQq5S+ijT8aWEabNqlHyXMukWQ6Lj45DK370JJJYi3ldFvuUVg0Zfm87IoqGo31vWG9Uw3b/+XpfWlVgiuMvpAT4OwvDXVBfyRJfIhl+Z1MoM9BGdl7ub1Sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJBMGDNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C44CC4CEE4;
	Mon, 21 Apr 2025 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745248050;
	bh=po7Jc+hppAfgmCAjsxpSgRbNiUij6SS676p735sVSTg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lJBMGDNVO4uBX9LI1VO13H154IJ7lr6SHJlYGRo6ifKVh/jTu3cda20YLccPpQT/Z
	 39LJfcGcsQIh1ieQeTOzWSGyz/IqvTnwvmkpIz+j5wycCU6cB++33OvxUcRRIR58MS
	 XTkUR250eMUAbK4E/SY0HsErnxC+Gf55Kcmd3dvPF6Y8UGRKOuNebNivoh5v26ILZi
	 nJzDGuRVPch994rFyDfXipqrb6XzroPj2RUW0Oom11qx45goH6Op/VdlOledHISwV+
	 fudK0Tf7Vzga2GtiK2KAKFz5pyV10MmCDFK2Bk1ZtKDPQClSYl6K2K2y8Vmd6Km7Q9
	 9yD8P07nFXXQw==
Date: Mon, 21 Apr 2025 10:07:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: helgaas@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, vigneshr@ti.com, devicetree@vger.kernel.org, 
 kw@linux.com, iommu@lists.linux.dev, nm@ti.com, bhelgaas@google.com, 
 baocheng.su@siemens.com, jan.kiszka@siemens.com, conor+dt@kernel.org, 
 lpieralisi@kernel.org, diogo.ivo@siemens.com, kristo@kernel.org, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, ssantosh@kernel.org, 
 s-vadapalli@ti.com, krzk+dt@kernel.org, linux-pci@vger.kernel.org
To: huaqian.li@siemens.com
In-Reply-To: <20250418073026.2418728-1-huaqian.li@siemens.com>
References: <20241030205703.GA1219329@bhelgaas>
 <20250418073026.2418728-1-huaqian.li@siemens.com>
Message-Id: <174524751981.2425537.9075012529757899431.robh@kernel.org>
Subject: Re: [PATCH v7 0/8] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation


On Fri, 18 Apr 2025 15:30:18 +0800, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> Changes in v7:
>  - add schema expressing dependency as suggested on pci-host bindings
>  - resolve review comments on pci-keystone driver
>  - add a new patch to make IO_TLB_SEGSIZE configurable
>  - improve patches based on checkpath.pl
> 
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
> 
> Jan
> 
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
> Li Hua Qian (1):
>   swiotlb: Make IO_TLB_SEGSIZE configurable
> 
>  .../bindings/pci/ti,am65-pci-host.yaml        |  34 +-
>  .../bindings/soc/ti/ti,am654-pvu.yaml         |  51 ++
>  arch/arm64/boot/dts/ti/Makefile               |   5 +
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  38 +-
>  ...am6548-iot2050-advanced-dma-isolation.dtso |  33 ++
>  drivers/pci/controller/dwc/pci-keystone.c     | 106 ++++
>  drivers/soc/ti/Kconfig                        |   4 +
>  drivers/soc/ti/Makefile                       |   1 +
>  drivers/soc/ti/ti-pvu.c                       | 500 ++++++++++++++++++
>  include/linux/swiotlb.h                       |   2 +-
>  include/linux/ti-pvu.h                        |  28 +
>  kernel/dma/Kconfig                            |   7 +
>  12 files changed, 801 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
>  create mode 100644 drivers/soc/ti/ti-pvu.c
>  create mode 100644 include/linux/ti-pvu.h
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250417 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/ti/' for 20250418073026.2418728-1-huaqian.li@siemens.com:

arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb: pcie@5600000 (ti,am654-pcie-rc): 'memory-region' is a required property
	from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb: pcie@5600000 (ti,am654-pcie-rc): 'memory-region' is a required property
	from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dtb: pcie@5500000 (ti,am654-pcie-rc): 'memory-region' is a required property
	from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb: pcie@5600000 (ti,am654-pcie-rc): 'memory-region' is a required property
	from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb: pcie@5600000 (ti,am654-pcie-rc): 'memory-region' is a required property
	from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dtb: pcie@5500000 (ti,am654-pcie-rc): 'memory-region' is a required property
	from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#






