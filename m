Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1822296DC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 13:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGVLDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 07:03:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49446 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVLDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 07:03:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MB3Ro5052626;
        Wed, 22 Jul 2020 06:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595415807;
        bh=1raZkMKIg8HyeFaSNe5T8QbrZ+ubuokHpyXLX12R2xA=;
        h=From:To:CC:Subject:Date;
        b=Bv9t8B0DKmqKzoAJU5jkCHdhGRzgmTOBZyRZf/kmOCb7ZJT0YC82gAeefrVF06ThB
         k87c38GwdkuO/WkXHIy+4kF9GC5cSBihCoe8ynXuAiwZXUyfCyCB1dC9OVh6D/rZFz
         eRW1hRNZNAHB/DrYBeCLq/0GqySuEeZZfu1vc4wo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MB3LVF005494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 06:03:26 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 06:03:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 06:03:22 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MB3IFY078616;
        Wed, 22 Jul 2020 06:03:19 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 00/15] Add PCIe support to TI's J721E SoC
Date:   Wed, 22 Jul 2020 16:33:02 +0530
Message-ID: <20200722110317.4744-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

TI's J721E SoC uses Cadence PCIe core to implement both RC mode
and EP mode.

The high level features are:
  *) Supports Legacy, MSI and MSI-X interrupt
  *) Supports upto GEN4 speed mode
  *) Supports SR-IOV
  *) Supports multiple physical function
  *) Ability to route all transactions via SMMU

This patch series
  *) Add support in Cadence PCIe core to be used for TI's J721E SoC
  *) Add a driver for J721E PCIe wrapper

v1 of the series can be found @ [1]
v2 of the series can be found @ [2]
v3 of the series can be found @ [5]
v4 of the series can be found @ [6]
v5 of the series can be found @ [7]
v6 of the series can be found @ [8]
v7 of the series can be found @ [9]

Changes from v7:
1) Replaced WARN with pr_warn
2) Included support for "dma-ranges" property patch in this series [10]

Changes from v6:
1) Fixed bot found errors running 'make dt_binding_check'

Changes from v5:
1) Added Reviewed-by: for PATCH #6
2) Protect writes to PCI_STATUS with spin_lock during raising interrupts
   in EP mode to reduce the time between read and write of RMW.

Changes from v4:
1) Added Reviewed-by: & Acked-by: tags from RobH
2) Removed un-used accessors for pcie-cadence.h and removed having ops
   for read/write accessors
3) Updated cdns,cdns-pcie-host.yaml to remove "mem" from reg

Changes from v3:
1) Changed the order of files in MAINTAINTERS file to fix Joe's comments
2) Fixed indentation and added Reviewed-by: Rob Herring <robh@kernel.org>
3) Cleaned up computing msix_tbl
4) Fixed RobH's comment on J721E driver

Changes from v2:
1) Converting Cadence binding to YAML schema was done as a
   separate series [3] & [4]. [3] is merged and [4] is
   pending.
2) Included MSI-X support in this series
3) Added link down interrupt handling (only error message)
4) Rebased to latest 5.7-rc1
5) Adapted TI J721E binding to [3] & [4]

Changes from v1:
1) Added DT schemas cdns-pcie-host.yaml, cdns-pcie-ep.yaml and
   cdns-pcie.yaml for Cadence PCIe core and included it in
   TI's PCIe DT schema.
2) Added cpu_addr_fixup() for Cadence Platform driver.
3) Fixed subject/description/renamed functions as commented by
   Andrew Murray.

[1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20200106102058.19183-1-kishon@ti.com
[3] -> http://lore.kernel.org/r/20200305103017.16706-1-kishon@ti.com
[4] -> http://lore.kernel.org/r/20200417114322.31111-1-kishon@ti.com
[5] -> http://lore.kernel.org/r/20200417125753.13021-1-kishon@ti.com
[6] -> http://lore.kernel.org/r/20200506151429.12255-1-kishon@ti.com
[7] -> http://lore.kernel.org/r/20200522033631.32574-1-kishon@ti.com
[8] -> http://lore.kernel.org/r/20200708093018.28474-1-kishon@ti.com
[9] -> http://lore.kernel.org/r/20200713110141.13156-1-kishon@ti.com
[10] -> http://lore.kernel.org/r/20200521080153.5902-1-kishon@ti.com

Alan Douglas (1):
  PCI: cadence: Add MSI-X support to Endpoint driver

Kishon Vijay Abraham I (14):
  PCI: cadence: Use "dma-ranges" instead of "cdns,no-bar-match-nbits"
    property
  PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path
  linux/kernel.h: Add PTR_ALIGN_DOWN macro
  PCI: cadence: Convert all r/w accessors to perform only 32-bit
    accesses
  PCI: cadence: Add support to start link and verify link status
  PCI: cadence: Allow pci_host_bridge to have custom pci_ops
  dt-bindings: PCI: cadence: Remove "mem" from reg binding
  PCI: cadence: Add new *ops* for CPU addr fixup
  PCI: cadence: Fix updating Vendor ID and Subsystem Vendor ID register
  dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC
  dt-bindings: PCI: Add EP mode dt-bindings for TI's J721E SoC
  PCI: j721e: Add TI J721E PCIe driver
  misc: pci_endpoint_test: Add J721E in pci_device_id table
  MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe

 .../bindings/pci/cdns,cdns-pcie-host.yaml     |   8 +-
 .../bindings/pci/ti,j721e-pci-ep.yaml         |  94 ++++
 .../bindings/pci/ti,j721e-pci-host.yaml       | 113 ++++
 MAINTAINERS                                   |   4 +-
 drivers/misc/pci_endpoint_test.c              |   9 +
 drivers/pci/controller/cadence/Kconfig        |  23 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-j721e.c    | 493 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 129 ++++-
 .../controller/cadence/pcie-cadence-host.c    | 310 +++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  13 +
 drivers/pci/controller/cadence/pcie-cadence.c |   8 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 161 +++++-
 include/linux/kernel.h                        |   1 +
 14 files changed, 1297 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.c

-- 
2.17.1

