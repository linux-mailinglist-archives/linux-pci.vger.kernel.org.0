Return-Path: <linux-pci+bounces-23098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74303A5656B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4AB1899E4A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0431C20E035;
	Fri,  7 Mar 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vf012oGj"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31504213246;
	Fri,  7 Mar 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343520; cv=none; b=OvK6B4a2rKS0E5kgDrOz/NmHlzW9sGxJovNtAqJMhjccvB2MsJwZITZ3AgQ14zE1KIPdyLqENIfvd3df1dhtn/N5dSKFkZn963l+xGqUPdwQ9MMdySGDLlSsNfUHPnuDRFUt5zGGcve5EQ5sQ0WeJyeEmu/BvLR26ZyNVAc5Nbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343520; c=relaxed/simple;
	bh=OKBAf6irmnU5/d+0U4T3dEDZmAxUVrX5t+/ekGw1Gd4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QIYx05Ni10++VVAI+edubnSlQmyfXz4wD6ymF5l+3CU6y1jQr+k5pAU6Vl6oXnOXHA+DCOP5H23jNUGR5DJxeMOMQHIoSTi/H3da+rwDxG4NYEJDTHRW/sYhWGCqaLtiIs3k8/J7DO/1brAsoBNBHjzWzxTTG3bsbyfM5F9sGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vf012oGj; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527AVYRl243376
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 04:31:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741343494;
	bh=L8uOvoVLDeLOL1fDGRqGNDMqZxmbAi0wKgSFV9Fi1vY=;
	h=From:To:CC:Subject:Date;
	b=Vf012oGjFcG9hNrgbt4V3FRaWISgjJEy65aGrdFrjn/SN0YmbXfpFs91jqq6n2UiI
	 1qT8m0N9Dm/WUfzJDTS5zLsYzzr4lXN43u6Mssy/zHgsy2PbA1omcpszd1bgNFVTHx
	 ig981d7OJGsXFCxYkPPRtYmCISYCE/GQONw/L0fE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527AVXIB016599
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 04:31:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 04:31:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 04:31:33 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527AVSQ2016876;
	Fri, 7 Mar 2025 04:31:29 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <cassel@kernel.org>, <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/4] Loadable Module support for PCIe Cadence and J721E
Date: Fri, 7 Mar 2025 16:01:24 +0530
Message-ID: <20250307103128.3287497-1-s-vadapalli@ti.com>
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

Series is based on linux-next tagged next-20250306.

--------------------------
Series has been tested for
--------------------------
[1] Loading and Unloading the PCI J721E driver when operating in the
Root-Complex mode on J721E-EVM with an NVMe SSD connected to the PCIe
Connector. "hdparm" based reads of the NVMe SSD have been performed to
validated functionality before and after a module unload-load sequence
using modprobe. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/085fd24d416bab5dc7d798156ce130b3

[2] Loading and Unloading the PCI J721E driver when operating in the
Endpoint mode on J784S4-EVM with 6 Physical Functions configured in the
Endpoint and connected to the J721E-EVM as the Root-Complex. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/1ec568a76bc3ebc1082d434aab4ab00b

The following changes to arch/arm64/configs/defconfig were made to test
this series and will be posted as a patch after this series gets merged:
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3a3706db2982..0ca073141c3e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -209,6 +209,12 @@ CONFIG_NFC=m
 CONFIG_NFC_NCI=m
 CONFIG_NFC_S3FWRN5_I2C=m
 CONFIG_PCI=y
+CONFIG_PCI_J721E=m
+CONFIG_PCI_J721E_HOST=m
+CONFIG_PCI_J721E_EP=m
+CONFIG_PCIE_CADENCE=m
+CONFIG_PCIE_CADENCE_HOST=m
+CONFIG_PCIE_CADENCE_EP=m
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEAER=y
 CONFIG_PCI_IOV=y

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
 drivers/pci/controller/cadence/pci-j721e.c    |  37 +++++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |  16 +++
 .../controller/cadence/pcie-cadence-host.c    | 113 ++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.c |  12 ++
 drivers/pci/controller/cadence/pcie-cadence.h |  14 ++-
 6 files changed, 194 insertions(+), 10 deletions(-)

-- 
2.34.1


