Return-Path: <linux-pci+bounces-26353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F923A95DD8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 08:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5113B6455
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17D1EF099;
	Tue, 22 Apr 2025 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="KdMPXG0U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424C1E9B3B
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302469; cv=none; b=E2N+1RGV72vX13Tfp76/O7ayTpolACHJ8duNvI/7dA3OxbHVXnIkoKCLq3sfJYHkif61mTQ1P1oP047Hg29PxdyEU8RT7fl91PVPX7zaFJxy0jnm1nXjhSJ61uC6D0D9GIkpd/cm2MIamyv1vks8mEVSBhX5Lpd08wO00oz5UUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302469; c=relaxed/simple;
	bh=k76J4N3tpRxkQiTM9N5mJl9SvbCP7Rd+XDLyZnXS/k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQPKBZrVJGD9+WZOBkXnWh6xyXy5+6IN30/+9ctFh8x+c44ifaRXL89QYlldt1Un6FlFlyT4IpA7ZwXvSMSeZEQqvHmqwHvDG6MyWgcKZbf2Hh3s6HnDL8LnX/2BcIJTmeWmqc8mWCh6tZv4gUsf7DeFqsc7eEKp+h3y0apCohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=KdMPXG0U; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250422061418b63bcfe0dea5c25018
        for <linux-pci@vger.kernel.org>;
        Tue, 22 Apr 2025 08:14:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+UTSSsG+8WtOQHPmAJe+rsYM12ki9cccLWC6Gxd4wAI=;
 b=KdMPXG0U80elzuYOOMqlaNeBjf5q504Ijr+lUFxVuAG4OCp/ir2QZefHfsj1sSHtlP1PT/
 r7qMKLq+IDQb3OrXnpZwjcjvgDYoIfGgScR1Sea2HQb8PUdzHLCBthcYQ+oVjTTp2FEQnG/O
 QZbfQ0TIuibSINNyXrj59wzGTk4HioQ+2dAu3kk6cOOZtc0MSmvqv50JTKJHwGOibP+SMUsQ
 7wrH/e4Y4b2TT7/vKgtiN/XsegA3DpuJV8GZpGgk+MBp9KPxIv6jZWU9szMebJs3tlBMdxUs
 FQiKxVTXn2bjW52gppk5vO8hLm0KYrnaayI+rtkYDrdeK9dT8rkQRqzw==;
From: huaqian.li@siemens.com
To: helgaas@kernel.org
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	ssantosh@kernel.org,
	vigneshr@ti.com
Subject: [PATCH v8 0/8] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
Date: Tue, 22 Apr 2025 14:13:59 +0800
Message-Id: <20250422061406.112539-1-huaqian.li@siemens.com>
In-Reply-To: <aa3c8d033480801250b3fb0be29adda4a2c31f9e.camel@siemens.com>
References: <aa3c8d033480801250b3fb0be29adda4a2c31f9e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Li Hua Qian <huaqian.li@siemens.com>

Changes in v8:
 - remove patch 8 from this series to simplify the patchset
 - fix dt_bindings_check warnings (patch 2), 'memory-region' must
   not be a required property

Changes in v7:
 - add schema expressing dependency as suggested on pci-host bindings
 - resolve review comments on pci-keystone driver
 - add a new patch to make IO_TLB_SEGSIZE configurable
 - improve patches based on checkpath.pl

Changes in v6:
 - make restricted DMA memory-region available to all pci-keystone
   devices, moving property to unconditional section (patch 2)

Changes in v5:
 - resolve review comments on pci-host bindings
 - reduce DMA memory regions to 1 - swiotlb does not support more
 - move activation into overlay (controlled via firmware)
 - use ks_init_vmap helper instead of loop in
   rework ks_init_restricted_dma
 - add more comments to pci-keystone
 - use 2 chained TLBs of PVU to support maximum of swiotlb (320 MB)

Changes in v4:
 - reorder patch queue, moving all DTS changes to the back
 - limit activation to IOT2050 Advanced variants
 - move DMA pool to allow firmware-based expansion it up to 512M

Changes in v3:
 - fix ti,am654-pvu.yaml according to review comments
 - address review comments on ti,am65-pci-host.yaml
 - differentiate between different compatibles in ti,am65-pci-host.yaml
 - move pvu nodes to k3-am65-main.dtsi
 - reorder patch series, pulling bindings and generic DT bits to the front

Changes in v2:
 - fix dt_bindings_check issues (patch 1)
 - address first review comments (patch 2)
 - extend ti,am65-pci-host bindings for PVU (new patch 3)

Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
against DMA-based attacks of external PCI devices. The AM65 is without
an IOMMU, but it comes with something close to it: the Peripheral
Virtualization Unit (PVU).

The PVU was originally designed to establish static compartments via a
hypervisor, isolate those DMA-wise against each other and the host and
even allow remapping of guest-physical addresses. But it only provides
a static translation region, not page-granular mappings. Thus, it cannot
be handled transparently like an IOMMU.

Now, to use the PVU for the purpose of isolated PCI devices from the
Linux host, this series takes a different approach. It defines a
restricted-dma-pool for the PCI host, using swiotlb to map all DMA
buffers from a static memory carve-out. And to enforce that the devices
actually follow this, a special PVU soc driver is introduced. The driver
permits access to the GIC ITS and otherwise waits for other drivers that
detect devices with constrained DMA to register pools with the PVU.

For the AM65, the first (and possibly only) driver where this is
introduced is the pci-keystone host controller. Finally, this series
provides a DT overlay for the IOT2050 Advanced devices (all have
MiniPCIe or M.2 extension slots) to make use of this protection scheme.
Application of this overlay will be handled by firmware.

Due to the cross-cutting nature of these changes, multiple subsystems
are affected. However, I wanted to present the whole thing in one series
to allow everyone to review with the complete picture in hands. If
preferred, I can also split the series up, of course.

Jan

Jan Kiszka (7):
  dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
  dt-bindings: PCI: ti,am65: Extend for use with PVU
  soc: ti: Add IOMMU-like PVU driver
  PCI: keystone: Add support for PVU-based DMA isolation on AM654
  arm64: dts: ti: k3-am65-main: Add PVU nodes
  arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
  arm64: dts: ti: iot2050: Add overlay for DMA isolation for devices
    behind PCI RC

 .../bindings/pci/ti,am65-pci-host.yaml        |  28 +-
 .../bindings/soc/ti/ti,am654-pvu.yaml         |  51 ++
 arch/arm64/boot/dts/ti/Makefile               |   5 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  38 +-
 ...am6548-iot2050-advanced-dma-isolation.dtso |  33 ++
 drivers/pci/controller/dwc/pci-keystone.c     | 106 ++++
 drivers/soc/ti/Kconfig                        |   4 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/ti-pvu.c                       | 500 ++++++++++++++++++
 include/linux/ti-pvu.h                        |  32 ++
 10 files changed, 791 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
 create mode 100644 drivers/soc/ti/ti-pvu.c
 create mode 100644 include/linux/ti-pvu.h

-- 
2.34.1


