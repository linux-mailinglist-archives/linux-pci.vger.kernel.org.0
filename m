Return-Path: <linux-pci+bounces-24984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C2A7590B
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 10:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203D4188BAEE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Mar 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7021482F5;
	Sun, 30 Mar 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CR6AnNXx"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C274C08;
	Sun, 30 Mar 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743325150; cv=none; b=T1j7hFTAkGWknU8pD3qkr3UyvB35b5rRAMyoZAX4mXw7mF8KtCPUZ7Hs1KzgHPvM+yNELC2Q9icSk3Ib73fjFr/+zC7VXWyR3r7ac/5UU3jUkXkhVV+I/RJqaReYZRUwPDH57Lvm1ewlNvbj9vIxEq3lyDE5XPZa7izi1ftrEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743325150; c=relaxed/simple;
	bh=/km/b3RP7+meUdGujK5Cfjr3gVbfpj8Ix+nZ0yoaw80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=opyOBPoIBA8DBalkPnAKssJsTG/XPXi/dE138ZVavArP9WynyzwF0IQorKR7KBwoBC36SJ9WH3FFvxlSoMIWvJmNLFVy+jD737gNU0Hhc4PD9PZBycMD0M6OM6eiyhH6+ml36QiJtYoK8aFFo0iiEBjV6NUuaw4ODWF0XRjhqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CR6AnNXx; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52U8dKo53063341
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 30 Mar 2025 03:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743323960;
	bh=zVyzdrsq8rwcKEYT3slz18YJ/cFCFrZ4CWV2JbLOQZg=;
	h=From:To:CC:Subject:Date;
	b=CR6AnNXxBE8XeAGt6nNrC2LOTQwIlN7yitDmLdEDpYT3rVcHLm8OfbVxDMLNPVtTK
	 ia1Fp6Jx7t9dFfDjNOQKRHiKYHaP4KM8FJQPdN0JSpi94znarBoF+CqZ82eZkGCCYI
	 qm/hyf4JSBQjIAlLbWmElYreWFpu2mr/RwR5gg+g=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52U8dKrW118394;
	Sun, 30 Mar 2025 03:39:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Mar 2025 03:39:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Mar 2025 03:39:19 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52U8dE4g015769;
	Sun, 30 Mar 2025 03:39:15 -0500
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
Subject: [PATCH v2 0/4] Loadable Module support for PCIe Cadence and J721E
Date: Sun, 30 Mar 2025 14:09:10 +0530
Message-ID: <20250330083914.529222-1-s-vadapalli@ti.com>
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

Series is based on linux-next tagged next-20250328.

Series has been tested by loading and unloading the PCI J721E driver
when operating in the Root-Complex mode on J700-EVM with an NVMe SSD
connected to the PCIe Connector. "hdparm" based reads of the NVMe SSD
have been performed to validate functionality before and after a module
unload-load sequence using modprobe. Additionally, the module unload
was performed while running "hdparm" in the background. No crash was
seen and reloading the module enumerated the NVMe SSD and "hdparm" could
be re-run successfully.

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
 drivers/pci/controller/cadence/pci-j721e.c    |  33 ++++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |  17 +++
 .../controller/cadence/pcie-cadence-host.c    | 113 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c |  12 ++
 drivers/pci/controller/cadence/pcie-cadence.h |  14 ++-
 6 files changed, 192 insertions(+), 9 deletions(-)

-- 
2.34.1


