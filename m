Return-Path: <linux-pci+bounces-9232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF391681A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEA71F24391
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C981553A7;
	Tue, 25 Jun 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A/5mflwc"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61C14D712;
	Tue, 25 Jun 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319161; cv=none; b=lsE7pI2NBD+F25i/NIoolTxhlgz7ohF4b5wXzmHiF1fj3xQX2nrfnDBXu6fsftPwodxvwNIQnfcjDvajprAZsV9vLv7Lm4p4myxFw0yIIM7vVxWF/F+qQKjXBwjw15hgE99TG27sOwVRqaim9qk8K3OBbHPlEYjU+MCbt7kDcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319161; c=relaxed/simple;
	bh=2rOP1q+19mNvV2pPa905bRuywjshTepkMg4BN7Tkopg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kpCwJOdP877zq8r2RVsItGUTpAW8IRZK1k95yB7v7cMIWNDRLQEryRRuqP/LNsoOp8c49Iw2qYPY1p7f1EYmsgCNZf5m4UO44HwEbtKfS8fK0EGdFwslklYqWJNSxV9SP3doRwyZyEo6ltM/W01BpoOonPzB6wJSM3hvwZaXSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A/5mflwc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719319159; x=1750855159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2rOP1q+19mNvV2pPa905bRuywjshTepkMg4BN7Tkopg=;
  b=A/5mflwcP/f6Ctg+rElc6Vzf2GijjChpvA4gpysg7Us2KLt/AcFXle3K
   BNEUuN0T4/MCiudTnnxHf8W1iMg7xsG4xywGjEPB7J4dRDNTJqLE3nMp+
   nEFbJKTGXdosscA6vsL2NQgrfQtvaO5fU4Oc25rPDoqqjN9lTY+ddF6+8
   RGVQUWb7p2LNDaK9XySM2RDTCFkooHsx4KeWmHd5LVi3fB9KJ3EiXvZvD
   EjxTDOni3hhNAbEl7QbmENDoAvSeMMLcVktLHkh132dMUpgQeXSPJGDjI
   r0i4ZvA52i/pw4/z3+KRfBjE0zNgEWM6GH2ZczODrZ/F1+yEKFwNulIa/
   w==;
X-CSE-ConnectionGUID: XIY+Guk0QYqx1NrauK55gg==
X-CSE-MsgGUID: 3I+77c/wTei5KNm1Uv3qAA==
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="29103139"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 05:39:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 05:38:39 -0700
Received: from daire-X570.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 05:38:36 -0700
From: <daire.mcnamara@microchip.com>
To: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <daire.mcnamara@microchip.com>,
	<ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 0/3] Fix address translations on MPFS PCIe controller
Date: Tue, 25 Jun 2024 13:38:42 +0100
Message-ID: <20240625123845.3747764-1-daire.mcnamara@microchip.com>
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

Changes since v4:
- Added more cleanups suggested by Ilpo Jarvinen
  Added cleanups for inbound v4 and outbound v3.

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
 drivers/pci/controller/pcie-microchip-host.c  | 118 +++++++++++++++---
 2 files changed, 106 insertions(+), 14 deletions(-)


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
prerequisite-patch-id: 18ffa3e9b0f8886d8d173845165d49d7a4a9f1cd
prerequisite-patch-id: 9fc9d99faa001c3cfb2b6617656d186f609d4cb8
prerequisite-patch-id: 29f2d8291454d817b2266bedd343b3126ad2fdfa
prerequisite-patch-id: bde5836bc0d45aac5f4d03e002e560cdb1333c49
prerequisite-patch-id: 632616001dfa9bdd48afc912c694d1111a7e0df8
-- 
2.34.1


