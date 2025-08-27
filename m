Return-Path: <linux-pci+bounces-34916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DCFB382E9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD31461AD1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13A34F463;
	Wed, 27 Aug 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaG+3S5s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771B281368;
	Wed, 27 Aug 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299328; cv=none; b=ljjtoQ0QDJ3OdFX0H7KF8ajcutzypGxOuzIQ/dY6Hsnz4XOOsCLuKeBu9TwJ5ATgHQz1j3Ft5UGHWSXDhsvIUSPubBYtCt6S0syxHrRnjjaO3OWU6AB9WmM3Xbgs1bKVptfq5Qv116U2ZzJjPIJ9uTlUlRf2Yxpi7vV3SwpH2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299328; c=relaxed/simple;
	bh=BHwnAktr1BCqCNpsESapR93VNAWo6oZo8xjv4L8onms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e90jjFKyLtdgIdpiMhw7oAEBIDeA6iGVC93NGq/KsP4hGhPYxi9zC7NwiJa0ZLlBQzzBbFljARWFFcw9x/FtMYJA3Hzrrh/5myiiBbi8mlYMLrFt1XB7BShj5gFPBk41t8KSBKdjkvNLG5nzKhN92ebSyFktreShLr7tROmEd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaG+3S5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64408C4CEF4;
	Wed, 27 Aug 2025 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756299327;
	bh=BHwnAktr1BCqCNpsESapR93VNAWo6oZo8xjv4L8onms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaG+3S5shQEKUrF+c0P6V+pqiytDXqmkN2LiC+N0PhkullB8pa1QUY6ZRLIj7x2fE
	 zSJDnvYxNxcFOAVw+WBsz228mQ4CrxpuRG1eKY884kc5nLNT5HXrZ0a8um3ds7fGxG
	 6rN5TnM0vmGG/W2sqmstUdAcAunKZ/QeCBdmsR2KnDRf1wf9tjyWW1f6+RM4KIi4p/
	 jMj6mqBy5Fy+NHPVObdW1DlbPu9aV1uqaVC3eN3rWeV+jiV9vDfIwoVmHs5uctSwnX
	 mfDb2fllYZVG8nvDBBFj/kOLlkZRED2i/YLzxxCD5AeH52rnR77YD3+Qm1gDuWP8W/
	 gb23EsxT4YTUw==
Date: Wed, 27 Aug 2025 18:25:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: huaqian.li@siemens.com
Cc: lkp@intel.com, baocheng.su@siemens.com, bhelgaas@google.com, 
	christophe.jaillet@wanadoo.fr, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	diogo.ivo@siemens.com, helgaas@kernel.org, jan.kiszka@siemens.com, kristo@kernel.org, 
	krzk+dt@kernel.org, kw@linux.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, nm@ti.com, 
	oe-kbuild-all@lists.linux.dev, robh@kernel.org, s-vadapalli@ti.com, ssantosh@kernel.org, 
	vigneshr@ti.com
Subject: Re: [PATCH v12 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation
Message-ID: <yhbjfg7dqx3xud75rhwlhq7ayqa4d6wrsan2j7ki7ri3uynpeu@hdv2o33x4hdn>
References: <20250728023701.116963-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728023701.116963-1-huaqian.li@siemens.com>

On Mon, Jul 28, 2025 at 10:36:54AM GMT, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> Changes in v12:
>  - Fix Sparse warnings by replacing plain integer 0 with NULL for
>    pointer arguments in ti_pvu_probe() (patch 3)
>    (Reported-by: kernel test robot lkp@intel.com)
> 
> Changes in v11:
>  - Improve error handling and resolve review comments on pci-keystone
>    driver (patch 4)
> 
> Changes in v10:
>  - Move restricted DMA initialization and cleanup to RC-specific code
>    only (patch 4) as it's only needed for RC mode, not EP mode
> 
> Changes in v9:
>  - Update commit message (patch 4) to remove ambiguous extension claims
>    based on upstream feedback
> 
> Changes in v8:
>  - remove patch 8 from this series to simplify the patchset
>  - fix dt_bindings_check warnings (patch 2), 'memory-region' must
>    not be a required property
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

How do you want the patches to be merged? I see that the PCI controller driver
has the API dependency with SoC driver. So that will go through arm-soc I
believe.

But I can take the dt-binding through PCI tree if you want. Let me know!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

