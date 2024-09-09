Return-Path: <linux-pci+bounces-12955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85F971FDF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A541F2412C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667A170A27;
	Mon,  9 Sep 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="dkxEF00M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CA16EBE6
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901447; cv=none; b=dcaqDoZX5BW3nCGqnzRJxhobTqt9EOV7l6gC9kW2MxqWEmi/O7QrA+svwviITqmvuuauO2/4P/cbWMveG8+IlQTbDzu2ZdNVC3oxdlSzWBriGKeoHPriplb17QX3EoGKIhGgiQcdU71wTQYfUQ7Wy2ceEuPfqhJpmjX+mUO3krs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901447; c=relaxed/simple;
	bh=B0JXziQ+mjss6TqCnA0okPgS+sSm1J3gMSu3cM1o6yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QmJdUHrz7roxwDc91Xh7ptMMqvPQ2ww2z4EpqZOfmcrzajG691cRKMbgvPWUJXnOwDFPorQ4AFka2cb/vT1A96CqvuhjMkwlVk5yJXZmCCwatfDmV/YwGSS8xGH+Ju7O9LJ1iPxoAgYET5duc5Ix6MlFkCTgiKaIeM7v8IANPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=dkxEF00M; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240909170401304043ad620166ef95
        for <linux-pci@vger.kernel.org>;
        Mon, 09 Sep 2024 19:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+IMJaH4Y488cxMrbbzQw5ZPi7CFHeJol2NGr8fzTx7o=;
 b=dkxEF00MQXR61RbV6uQIrVK0CafNTE9gFjgHUeK+0coC1gYXa8GchjLkUusJAqcJ1+lZ1y
 c6qZQaYvIISzt8KQVVU2fCD5H74vxTBKHD50PgWla++NoA52caQUILecXDqyzLiY4eMr2TIn
 YVsecPwvYtA0BDG5hpYajeuBuAncPTKMgDaps9Yrx9JD0oy3pmfpp5CUBu7xWUxLhwIfRQL5
 dBWB7MikOa3Lr5ojUjVxqTdopoUlRk2EO5kftd8KmZbalY9taAK9uBmr9YY4XNtEsLHg9tlw
 3Mmdah/HFADb7KRcLQfnrzNX5oIg+O1JpD7K1PoP6epnI4tfcgwYwFLw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v6 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
Date: Mon,  9 Sep 2024 19:03:53 +0200
Message-ID: <cover.1725901439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

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

CC: Bjorn Helgaas <bhelgaas@google.com>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: linux-pci@vger.kernel.org
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>

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
 drivers/pci/controller/dwc/pci-keystone.c     | 108 ++++
 drivers/soc/ti/Kconfig                        |   4 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/ti-pvu.c                       | 500 ++++++++++++++++++
 include/linux/ti-pvu.h                        |  16 +
 10 files changed, 777 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
 create mode 100644 drivers/soc/ti/ti-pvu.c
 create mode 100644 include/linux/ti-pvu.h

-- 
2.43.0


