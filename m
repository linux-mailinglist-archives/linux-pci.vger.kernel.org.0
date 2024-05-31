Return-Path: <linux-pci+bounces-8109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DEB8D5D35
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F64F28178C
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E36155759;
	Fri, 31 May 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qEhx8Cq8"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9E155758;
	Fri, 31 May 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145662; cv=none; b=PDqm0KIbe+Pmqddm/wIY8JQAYE2w++2f5fDtzpZIzucxOagPMJkmtEFwo6GGU78tFx/isld9kUTskscceQtujCn/H0o08+qwhc2NB4TrItXhzbUnjidsq6eHxouDIb4zThNqbFvd3CgzPjVmGCCymNjzrZYBdjiWiLEQg3OJxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145662; c=relaxed/simple;
	bh=tCHprlLlnw6uDZ2ngRA1f3x4YFwg7beapb8nxZV2la8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wo6w3CQSO2uTSbJlWC+81uGgtdjCZ/WOTbxEtpTgoiv/XG+cmh4cxGVZgrbYelh0jMnVJ4+b6GEOVQRJu0wh9g0CrZLapcqRLFh/GaTV2jANQJjEkc/BAwjWHLK8KAQ8oWOKSV2Pdy5q4xd3YDjALK836s192r2RQRs4QH5UIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qEhx8Cq8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717145660; x=1748681660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tCHprlLlnw6uDZ2ngRA1f3x4YFwg7beapb8nxZV2la8=;
  b=qEhx8Cq8oJ7flPnwo0GSrL0NUSmx7i0Icv0b9Tfr/gfOrkqlDsJOANBk
   5bWFHaobYlNgncMg4dCpRkyBUk0Lzjx63ilNI7A1ADYsU2n2axjCMC8oP
   /LZlpKQPx1xMhI8OA9p+mrZWrzh++tKm20jrag0HWExtVzSUA1mT2iIjv
   ciWQsBfOiKxa4Df+CfKUwmMtq1hYhGz01HR89YFfEmmwaYmaramWT3i7Q
   G6fuV4mLdDaPJIQbTUjMpDLZIe9yf6ZQNErFAiUihQiHG91QCqrSan1wy
   iUd4J4e8xyYY8P0wc468WsHj2abFSbgZV/nAiNQ7jxmM7Km9Bt9W4SdqI
   A==;
X-CSE-ConnectionGUID: l/lpyU7jQm+PQYj0dIm0ag==
X-CSE-MsgGUID: B88xxOsDQdusAgOLtg78RQ==
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="194194712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 01:54:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 01:53:54 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 01:53:52 -0700
From: Daire McNamara <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, Daire McNamara
	<daire.mcnamara@microchip.com>
Subject: [PATCH 0/2] Fix address translations on MPFS PCIe controller
Date: Fri, 31 May 2024 09:53:31 +0100
Message-ID: <20240531085333.2501399-1-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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

Daire McNamara (2):
  PCI: microchip: Fix outbound address translation tables
  PCI: microchip: Fix inbound address translation tables

 drivers/pci/controller/pcie-microchip-host.c | 104 +++++++++++++++++--
 1 file changed, 96 insertions(+), 8 deletions(-)


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
-- 
2.34.1


