Return-Path: <linux-pci+bounces-9068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B79123A7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 13:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64AF1F29179
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC06173343;
	Fri, 21 Jun 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O33VUnSd"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1035172BD8;
	Fri, 21 Jun 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969402; cv=none; b=XnZ8MvLX4NjPGxQZvg/adu3jzqUPbSvdWAbIMMyC7bIVrqr21iAMag81Macg0aXEWWiqO+SvyPzTJidRrxTKJ1AjiZLg+Vtrlo+da77gEY2RmaDf+5e6yHY1wgp12/uLZpt6AakT6a7B/NneSNZTYmOICXXz6DBtmCWh5UlsH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969402; c=relaxed/simple;
	bh=nSoRDj0yx6wVsUVNtfU2C12w3vLi7Xav+I6btMpWrzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rwuiy8ra6N7Md9ES07EK9qMqbXnQWG2EPjVpvFvW+8hx6yDmcwnA/qDWkQo2dAvKj4ggU8LM/6CB1vRQhYTkUHb129xpo1q+Dq7jSv/KcJKz+RA1isS2JUEQEIQsRKAfwL/qQ3Z3eErit6PorrcpSWv5TGZnHcGfzDndKGES5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O33VUnSd; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718969400; x=1750505400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nSoRDj0yx6wVsUVNtfU2C12w3vLi7Xav+I6btMpWrzo=;
  b=O33VUnSd+3ahKgj4+Fed+vhtRwZs3I3+UEgYUDRngIGn6q+AdGlBE5A6
   acyxOi3NLuxGrZZiqyQ7AFhhrbT6WcJOMkO3D6Jjguo/tT5vh0YsX/6U9
   a8hoI1HoTq8Kh76XQFPxrt9r2cceeiHUIERPMx6DGnR7a2p48ndMIgFWi
   9818LBoFYT8HiCnN5DHPaHJIdQQkanjqjW0DHNstAaPGiTH6w3mdrwYdb
   njbZfOCp9JdHmy+ASbLgwwq9i+mEFsEreW53Z1pxhqPQW6p1amNc4uVF/
   NjvD5L8mdpaRIhL7Zc2ev9UdgBemT8Zo7rz1BOCJlkgn1v5yFWYIPhTvU
   g==;
X-CSE-ConnectionGUID: OY1EIogCSZWH3lfFjfiKrA==
X-CSE-MsgGUID: aPEgXs8TS9CGaILqwtRO7g==
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="28970651"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2024 04:29:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Jun 2024 04:29:28 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 21 Jun 2024 04:29:24 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/3] Fix address translations on MPFS PCIe controller
Date: Fri, 21 Jun 2024 12:29:12 +0100
Message-ID: <20240621112915.3434402-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Daire McNamara <daire.mcnamara@microchip.com>

Hi all,

On Microchip PolarFire SoC (MPFS), the PCIe controller is connected to the
CPU via one of three Fabric Interface Connectors (FICs).  Each FIC present
to the CPU complex as 64-bit AXI-M and 64-bit AXI-S.  To preserve
compatibility with other PolarFire family members, the PCIe controller is
connected to its encapsulating FIC via a 32-bit AXI-M and 32-bit AXI-S
interface.

Each FIC is implemented in FPGA logic and can incorporate logic along its 64-bit
AXI-M to 32-bit AXI-M chain (including address translation) and, likewise, along
its 32-bit AXI-S to 64-bit AXI-S chain (again including address translation).

In order to reduce the potential support space for the PCIe controller in
this environment, MPFS supports certain reference designs for these address
translations: reference designs for cache-coherent memory accesses
and reference designs for non-cache-coherent memory accesses. The precise
details of these reference designs and associated customer guidelines
recommending that customers adhere to the addressing schemes used in those
reference designs are available from Microchip, but the implication for the
PCIe controller address translation between CPU-space and PCIe-space are:

For outbound address translation, the PCIe controller address translation tables
are treated as if they are 32-bit only.  Any further address translation must
be done in FPGA fabric.

For inbound address translation, the PCIe controller is configurable for two
cases:
* In the case of cache-coherent designs, the base of the AXI-S side of the
  address translation must be set to 0 and the size should be 4 GiB wide. The
  FPGA fabric must complete any address translations based on that 0-based
  address translation.
* In the case of non-cache coherent designs, the base of AXI-S side of the
  address translation must be set to 0x8000'0000 and the size shall be 2 GiB
  wide.  The FPGA fabric must complete any address translation based on that
  0x80000000 base.

So, for example, in the non-cache-coherent case, with a device tree property
that maps an inbound range from 0x10'0000'0000 in PCIe space to 0x10'0000'0000
in CPU space, the PCIe rootport will translate a PCIe address of 0x10'0000'0000
to an intermediate 32-bit AXI-S address of 0x8000'0000 and the FIC is
responsible for translating that intermediate 32-bit AXI-S address of
0x8000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.

And similarly, for example, in the cache-coherent case, with a device tree
property that maps an inbound range from 0x10'0000'0000 in PCIe space to
0x10'0000'0000 in CPU space, the PCIe rootport will translate a PCIe address
of 0x10'0000'0000 to an intermediate 32-bit AXI-S address of 0x0000'0000 and
the FIC is responsible for translating that intermediate 32-bit AXI-S address
of 0x0000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.

See https://lore.kernel.org/all/20220902142202.2437658-1-daire.mcnamara@microchip.com/T/
for backstory.

Changes since v3:
- Added nice cleanups suggested by Ilpo Jarvinen

Changes since v2:
- Added <Signed-off-by: tag>

Changes since v1:
- added bindings patch to allow dma-noncoherent
- changed a size_t to u64 to pass 32-bit compile tests
- allowed 64-bit outbound pcie translations
- tied PCIe side of eCAM translation table to 0

Conor Dooley (1):
  dt-bindings: PCI: microchip,pcie-host: allow dma-noncoherent

Daire McNamara (2):
  PCI: microchip: Fix outbound address translation tables
  PCI: microchip: Fix inbound address translation tables

 .../bindings/pci/microchip,pcie-host.yaml     |   2 +
 drivers/pci/controller/pcie-microchip-host.c  | 112 +++++++++++++++---
 2 files changed, 100 insertions(+), 14 deletions(-)


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
-- 
2.34.1


