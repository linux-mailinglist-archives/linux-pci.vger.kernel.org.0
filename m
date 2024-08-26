Return-Path: <linux-pci+bounces-12226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31E95FC17
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 23:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C01B23E8A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371519D06E;
	Mon, 26 Aug 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Wti7N4Ad"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1464A
	for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709014; cv=none; b=ePYYEBw4kLgHyZAM+eFntoG73GzgDjhKO09y8cwFjOl5C41L6rcMiIqgO1NJANRl/DnvU7dWFSXyyq2ODIW1CZWYuJYQpWaxJmfYdRlJH90sagI3Y5pvnd+4C6Ky+SR5kChs+SGur9Ik7bJ2l6K3FVl9/H0XFtigb+9MRH3tBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709014; c=relaxed/simple;
	bh=xRH2SBL9rPAA3HtVA6CJmamhJCAFjwAVi6kfCWDQvRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5ROyYR8vbohImfSi5SWfrWKjac6mNt/iw0AG396YyRYxvI5d7m+ru9kOONzuu29aTPK2YD0mX8XvE4TiTNG0vSOfcRWvDHUTUwHaJVS3b8E2JEdIlgHv99LKS4i0unoCY/vIhDk7DJ4x/WWXrWKSgLfSn8EPkiJefitycqm82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Wti7N4Ad; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240826215008cfc3e52dacd072b0de
        for <linux-pci@vger.kernel.org>;
        Mon, 26 Aug 2024 23:50:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=yEquUkxoJfM5uHJg6dzTgpywJBY3hEgVM110Ob7YRJ4=;
 b=Wti7N4AdRaTl0Z3SMs1qgbFFMQmYdLYcRPJE83SPhZZkBF8GoBQrc/XztOqtGhu4OPJh6S
 29SehBjo/jWQcbjwC+k+ulnwCoam5xLqvrh+5qLihohQyg5aPRshIwscqSB25g2B8r83Uxxa
 vYbNAIZuX5pSkxcEidkCox9yPp/gS6281uRP4u3mbEUriII0aUayNVRTfPE9dv+qvKQMHN8Z
 EYOWCGRoH7IgnTQTimti+fMdsKLlQ8243tcUnLeFErU2DqokC1DRrEZBbtJZeUlZbGwhRLIm
 BChH6mExyohk5A7wqU7kYAJzRE8INfWNvkFV4bvOwAfr5lWliBIVwl4A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH v2 0/6] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
Date: Mon, 26 Aug 2024 23:50:01 +0200
Message-ID: <cover.1724709007.git.jan.kiszka@siemens.com>
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
configures the IOT2050 devices (all have MiniPCIe or M.2 extension
slots) to make use of this protection scheme.

Due to the cross-cutting nature of these changes, multiple subsystems
are affected. However, I wanted to present the whole thing in one series
to allow everyone to review with the complete picture in hands. If
preferred, I can also split the series up, of course.

Jan

CC: Bjorn Helgaas <bhelgaas@google.com>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: linux-pci@vger.kernel.org
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>

Jan Kiszka (6):
  dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
  soc: ti: Add IOMPU-like PVU driver
  dt-bindings: PCI: ti,am65: Extend for use with PVU
  arm64: dts: ti: k3-am65-main: Add VMAP registers to PCI root complexes
  PCI: keystone: Add supported for PVU-based DMA isolation on AM654
  arm64: dts: ti: iot2050: Enforce DMA isolation for devices behind PCI
    RC

 .../bindings/pci/ti,am65-pci-host.yaml        |  13 +-
 .../bindings/soc/ti/ti,am654-pvu.yaml         |  51 ++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  32 ++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  18 +-
 drivers/pci/controller/dwc/pci-keystone.c     | 101 ++++
 drivers/soc/ti/Kconfig                        |   4 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/ti-pvu.c                       | 487 ++++++++++++++++++
 include/linux/ti-pvu.h                        |  16 +
 9 files changed, 716 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
 create mode 100644 drivers/soc/ti/ti-pvu.c
 create mode 100644 include/linux/ti-pvu.h

-- 
2.43.0


