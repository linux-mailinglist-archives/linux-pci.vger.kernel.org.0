Return-Path: <linux-pci+bounces-25904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B154A8937F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D302C3B660E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 05:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F48A48;
	Tue, 15 Apr 2025 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="VGgXhzj7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71B27467D
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 05:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744695975; cv=none; b=AEi9o2eQNbQc4sml+nb19YCsIry3A/4PG8EQLEOpjjLQ20fv4wEuNZiR8knitAqF/blX6K9DVE8o/8/1ISaTnj+3bAeH9P6U8A6rcC8y5cM4HTtKUjzeT4pMUZopM0eqZY1IQSd37uYLOQzePJXtlOhO3gydVMZEb9oG3YFLqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744695975; c=relaxed/simple;
	bh=DO0c7tz9CQ9GwF0tk3kNMlKgxPwHsvsymFz79fBly0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Tv06ErC6WWpl1n60LUqZmMpMSVsudC3Hq6MjLn/L4y+OsL3XvhrNG5SKt+g2U44IzSZzBDBWQXgMnHZ2VzHM4zjfuyNByMOW7PmkQ4xOdOf1PlnD/jphiFlk1lajQiUImtVJmpxAq1lZJIeiwE109mawD2OiUiltcunZOK1OOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=VGgXhzj7; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250415054609c5f2081ac584d8a2b2
        for <linux-pci@vger.kernel.org>;
        Tue, 15 Apr 2025 07:46:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=D/BR5PX4U0RbN6BcfSHJhZdDvS5/9/IrRAm/0Q+wQr0=;
 b=VGgXhzj7H6lOqUowUFiV0IWndOvxDvpjXHUyHESqjbUmT0NPF1FD1naet0/cu9caqJSkD+
 /wUcnkfuNeMV/Ehz/b57Zdp9GhbYQu7OiHVF6hVUAcvyZyqgQF3tA2afMVEU3b+l5fzTkO4a
 +hbT+Znb4I7jfKVK06FiCrI5ZwYtiAMdKUVS2/NmSnFVKmgRHmyM/3VJsl9/lC32XSVhXFiN
 ipm0FrXPytjPB+EyS9z0lMIK3cdh3bJSZjfCirfzUUMBpik0hk573CVaNXFWiAgRtZ5Ck4xj
 qM67I/1m5N2K4r4cVskhe2hzjCyyGNwtJhROjgv8xjD4gTmUi9OiMUPg==;
From: huaqian.li@siemens.com
To: huaqianlee@outlook.com
Cc: huaqian.li@siemens.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v7 0/7] soc: ti: Add and use PVU on K3-AM65 for DMA
Date: Tue, 15 Apr 2025 13:45:42 +0800
Message-Id: <20250415054549.611747-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Li Hua Qian <huaqian.li@siemens.com>

Changes in v7:
 - add schema expressing dependency as suggested on pci-host bindings
 - resolve review comments on pci-keystone driver

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

 .../bindings/pci/ti,am65-pci-host.yaml        |  39 +-
 .../bindings/soc/ti/ti,am654-pvu.yaml         |  51 ++
 arch/arm64/boot/dts/ti/Makefile               |   5 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  38 +-
 ...am6548-iot2050-advanced-dma-isolation.dtso |  33 ++
 drivers/pci/controller/dwc/pci-keystone.c     | 106 ++++
 drivers/soc/ti/Kconfig                        |   4 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/ti-pvu.c                       | 500 ++++++++++++++++++
 include/linux/ti-pvu.h                        |  28 +
 10 files changed, 798 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-dma-isolation.dtso
 create mode 100644 drivers/soc/ti/ti-pvu.c
 create mode 100644 include/linux/ti-pvu.h

-- 
2.34.1


