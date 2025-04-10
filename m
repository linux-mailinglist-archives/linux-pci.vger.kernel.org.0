Return-Path: <linux-pci+bounces-25620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B638AA84112
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 12:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E427AEC9D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF640281369;
	Thu, 10 Apr 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AtAy2HqW"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE06281358;
	Thu, 10 Apr 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281898; cv=none; b=Yf5V480L7ogD55Z2/NGHvRWwz7jsSDpK7QxsmzSCuIneZNIBwF5SF0HPF6gPBWONHYfpezZQ2oDlm0X/YBc8OwBL5qOkGOyd6tR8aaKLCEWiZMMlbumG733Z45OHNqjpw9p4HC98ohkvzU4xygMggc6Z2eiI9uGiPFRoowplAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281898; c=relaxed/simple;
	bh=D9azXRd3whT0sZ/tEJGdHeUd6oPxzgT+qjSLkLxg+cM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WIVcbukTqYgoVrSlEAE0rM0FMwLewR1Ye0BiEWwK/BA1idXju94Hnq4EAHUEvp1y9kiYlrcoZnPfhsUHC5Ungt2JCdzPekpVBVT91Y8fztE+jGjyeoc7s0qCcHtp92BFUb7x5Kl0c57ioDayEvAyxLyTG7fNHRID0/WjVH899mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AtAy2HqW; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAiXbE1262907
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 05:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744281873;
	bh=yBwjCE/ol9udunO14kPmHxK0DtgJno2/PYAg0Wha9Xo=;
	h=From:To:CC:Subject:Date;
	b=AtAy2HqWLz8qefBuGawfiptxV1cSHk5gL+zMPGPy7kElG1XcLhdftKlVfKncABt5G
	 AuC7YMe8s21r7YN82e/ub1L7htCnLBjCjm1ESDasVzgdG/YOs8axofs8Rqzx17fp7n
	 uZPefPGqob4EXfqKywMZKgM3RhfvBu6UQQwNsORA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAiWLB109020
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Apr 2025 05:44:32 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 05:44:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 05:44:32 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AAiRfb029210;
	Thu, 10 Apr 2025 05:44:27 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <18255117159@163.com>, <cassel@kernel.org>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/4] Loadable Module support for PCIe Cadence and J721E
Date: Thu, 10 Apr 2025 16:14:22 +0530
Message-ID: <20250410104426.463453-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series enables support to build the PCIe Cadence Controller drivers
and the PCI J721E Application/Wrapper/Glue driver as Loadable Kernel
Modules. The motivation for this series is that PCIe is not a necessity
for booting the SoC, due to which it doesn't have to be a built-in
module. Additionally, the defconfig doesn't enable the PCIe Cadence
Controller drivers and the PCI J721E driver, due to which PCIe is not
supported by default. Enabling the configs as of now (i.e. without this
series) will result in built-in drivers i.e. a bloated Linux Image for
everyone who doesn't have the PCIe Controller. Therefore, with this
series, after enabling support for building the drivers as loadable
modules, the driver configs can be enabled in the defconfig to build
the drivers as loadable modules, thereby enabling PCIe.

Series is based on linux-next tagged next-20250410.

v2 of this series is at:
https://lore.kernel.org/r/20250330083914.529222-1-s-vadapalli@ti.com/
Changes since v2:
- Collected "Reviewed-by" tag from:
  Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  for the third patches in this series.
- Dropped a delay before PERST assertion in the driver's remove callback
  in the fourth patch of this series based on Mani's feedback at:
  https://lore.kernel.org/r/zsxnx7biwogov5dw5yiafkgk6tsrtspac75bjbrca5uevweaim@ly67hwfyk7qh/

v1 of this series is at:
https://lore.kernel.org/r/20250307103128.3287497-1-s-vadapalli@ti.com/
Changes since v1:
- Collected "Reviewed-by" tags from:
  Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  for the first two patches in this series.
- Based on feedback from Mani on the third patch of the v1 series at:
  https://lore.kernel.org/r/20250318080304.jsmrxqil6pn74nzh@thinkpad/
  pci_epc_deinit_notify() has been included in cdns_pcie_ep_disable().
- Based on feedback from Thomas on the fourth patch of the v1 series at:
  https://lore.kernel.org/r/88b3ecbe-32b6-4310-afb9-da19a2d0506a@bootlin.com/
  the "check" for a non-NULL "pcie-refclk" in j721e_pcie_remove() has been
  dropped.

Regards,
Siddharth.

Kishon Vijay Abraham I (1):
  PCI: cadence: Add support to build pcie-cadence library as a kernel
    module

Siddharth Vadapalli (3):
  PCI: cadence-host: Introduce cdns_pcie_host_disable helper for cleanup
  PCI: cadence-ep: Introduce cdns_pcie_ep_disable helper for cleanup
  PCI: j721e: Add support to build as a loadable module

 drivers/pci/controller/cadence/Kconfig        |  12 +-
 drivers/pci/controller/cadence/pci-j721e.c    |  31 ++++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |  17 +++
 .../controller/cadence/pcie-cadence-host.c    | 113 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c |  12 ++
 drivers/pci/controller/cadence/pcie-cadence.h |  14 ++-
 6 files changed, 190 insertions(+), 9 deletions(-)

-- 
2.34.1


