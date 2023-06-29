Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C986742B3F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 19:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF2Rbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 13:31:34 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:4704
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbjF2Rbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2023 13:31:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fmk5SlTF7gUsy3IqiPuEqa8cCbiDi363fGI+PjRVU1x581DIhMBWNIFs3b5xT2DV+D4zcRf7Kv1wpakgJGh32YClMdSuIL2r4Z0TGGDXXVoARLHIjzEeFnsqy2MAw6BbBQfXLIIA+smj/PeUQwbWT5RpYOkB1if1rbh1FtmAqbP1AYGNzjGtGCrL6+mdGZ0T4KQlW8YPA1Zfzq+z3wuCs86xh9cYdPueWlsmEmuOeqxfHyjwKsH8pysTVOJ+XCSkG+pYA9oZEjo1t+BiBGj09Ci0i5xfvjr4kpriW6WlwIZBAOBigIQuO3ug5HcDoL26JMJWuDpQiGWIZOYsEq6Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k6LxtRgXOdpE8TJie7zXStF/R42/EHQRtwd+NhLunk=;
 b=MW/exDlswZrcpFcjZoFttv4/qZ1gYj/R8YOCP/QR6SUx+prOdjfBjEXHG9gXH0z0Re/yCN5kkuVe6BvzFpZgqO0Zqh97Ut37IUtin4R+3twpggICQOO8FHiCNVGbL/Yq1GyjW9wyy28sdlS2PEjb5ofJqwjr2KGKwenppvEJBWnoMlZsbTVRJfHuXErGvFDn3ZOhrTeFXnZ7unXLu7JHq+Aq+iDw07388FKnrfkpgN7BtjPvJfQUKkL4glNUbV+cOYGhr7RPpbI8kRdnYFjJy+Q6eAeFW5hv/QAvZht6qRO+1O1XQC1mCSZpznsL1h8di/ACXq4l5jIzqe93mXKNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k6LxtRgXOdpE8TJie7zXStF/R42/EHQRtwd+NhLunk=;
 b=20Fmh03/3vYIDxkYEHvVeuTKExGC/SQgGgCdK/Lc86qzp/KeBFxuvRFVzRiW6r1R7RxD9uri8rK5/HoEC6LvEaPT1tDnO8IZU6bixIRBwh0IQ7mi5EDMHoZKIr2OgKjEkuE3Skz9dL676cyANIKdM0EDqcG5zaojDhI0j+d7Rfw=
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 17:31:29 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::e) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 17:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 17:31:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 12:31:28 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 29 Jun 2023 12:31:28 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V10 0/5] Generate device tree node for pci devices
Date:   Thu, 29 Jun 2023 10:19:45 -0700
Message-ID: <1688059190-4225-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|DM6PR12MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfd35f6-a9ce-41ee-2989-08db78c6ac87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thjjEo0Fkl2rUZGkxt9ssC14dMuAoQ0l+Lop/hTUhLVa21CKHAceduhTLUBYCduXKCG4aQUj4BwE92abUrwCaEV164spRmtYFRiZ1zTEfTeoD9tJD1Fo8W3SAFvocDmvrpopNQI9ovYsqfzWopxRXbdsxOMXE/hECGL32YAg+Uov0gofVe185Ob1foFxjSoJymK2eD7yDIr0u/GY1OowzczmHkrqx4Wi+NLDD0jEbOu15uhTOB33HAbBhbPVt7viHUXJyH+SamDZCn3XJxBQWO6nljv2GAfDF/6tXzyLk7+o+8X3RD8wRM2355COOWrIoOuaXWVrG2N4U2WWfxEnLfFzcoEIR58PEMTFqBYcwAjQSs4PB+Vah/ihfcyIrN+gXeAQ5P2EvsqsUh0IhWmugudpO2v0e28OBVkss8BKSLU1lEHBCsrljw0HhQeXzt6qFcUAjBcW0+uoQ5E5jEGTPuqzOX2s4BkMwMKrKH/o4xH7Ax8/UCecNFZlf9+cDlUDUB0seq3E+24i571HCuguHvpLse1Xk05EtYsFemz4xkeySoIDlCdM+8O4+V/JPpWxnwp9yKc2Nox1ERYAqcANAQiDiBOc6ywVQ5IIGL7lQQ/Yk7NRW8l2FiQizMyZMW3p/pZCG4+6f5juoQ6eashT0ndaBAbC6rG+2pT9P6XfQdzKdyVCkpAgDKABxL5eB02l0KyYoSblzXn5O9ggKFxMg/YfX1NSIaOsEWf9ZKWN03u52SCcS0GvMR6T3yicTNaiDY2Vfs2EJ7v+lbNe3b0m/ZaCR3XbXIczgY0vEGYUoOk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(186003)(2906002)(70206006)(5660300002)(26005)(6666004)(82740400003)(36756003)(336012)(82310400005)(316002)(54906003)(8676002)(86362001)(478600001)(966005)(81166007)(4326008)(110136005)(47076005)(2616005)(426003)(70586007)(41300700001)(44832011)(8936002)(83380400001)(40460700003)(356005)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 17:31:29.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfd35f6-a9ce-41ee-2989-08db78c6ac87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series introduces OF overlay support for PCI devices which
primarily addresses two use cases. First, it provides a data driven method
to describe hardware peripherals that are present in a PCI endpoint and
hence can be accessed by the PCI host. Second, it allows reuse of a OF
compatible driver -- often used in SoC platforms -- in a PCI host based
system.

There are 2 series devices rely on this patch:

  1) Xilinx Alveo Accelerator cards (FPGA based device)
  2) Microchip LAN9662 Ethernet Controller

     Please see: https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/

Normally, the PCI core discovers PCI devices and their BARs using the
PCI enumeration process. However, the process does not provide a way to
discover the hardware peripherals that are present in a PCI device, and
which can be accessed through the PCI BARs. Also, the enumeration process
does not provide a way to associate MSI-X vectors of a PCI device with the
hardware peripherals that are present in the device. PCI device drivers
often use header files to describe the hardware peripherals and their
resources as there is no standard data driven way to do so. This patch
series proposes to use flattened device tree blob to describe the
peripherals in a data driven way. Based on previous discussion, using
device tree overlay is the best way to unflatten the blob and populate
platform devices. To use device tree overlay, there are three obvious
problems that need to be resolved.

First, we need to create a base tree for non-DT system such as x86_64. A
patch series has been submitted for this:
https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/

Second, a device tree node corresponding to the PCI endpoint is required
for overlaying the flattened device tree blob for that PCI endpoint.
Because PCI is a self-discoverable bus, a device tree node is usually not
created for PCI devices. This series adds support to generate a device
tree node for a PCI device which advertises itself using PCI quirks
infrastructure.

Third, we need to generate device tree nodes for PCI bridges since a child
PCI endpoint may choose to have a device tree node created.

This patch series is made up of three patches.

The first patch is adding OF interface to create or destroy OF node
dynamically.

The second patch introduces a kernel option, CONFIG_PCI_DYNAMIC_OF_NODES.
When the option is turned on, the kernel will generate device tree nodes
for all PCI bridges unconditionally. The patch also shows how to use the
PCI quirks infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device
tree node for a device. Specifically, the patch generates a device tree
node for Xilinx Alveo U50 PCIe accelerator device. The generated device
tree nodes do not have any property.

The third patch adds basic properties ('reg', 'compatible' and
'device_type') to the dynamically generated device tree nodes. More
properties can be added in the future.

Here is the example of device tree nodes generated within the ARM64 QEMU.

# lspci -t
-[0000:00]-+-00.0
           +-01.0
           +-03.0-[01-03]----00.0-[02-03]----00.0-[03]----00.0
           +-03.1-[04]--
           \-04.0-[05-06]----00.0-[06]--

Without CONFIG_PCI_DYNAMIC_OF_NODES

# tree /sys/firmware/devicetree/base/pcie@10000000/
/sys/firmware/devicetree/base/pcie@10000000/
|-- #address-cells
|-- #interrupt-cells
|-- #size-cells
|-- bus-range
|-- compatible
|-- device_type
|-- dma-coherent
|-- interrupt-map
|-- interrupt-map-mask
|-- linux,pci-domain
|-- msi-map
|-- name
|-- ranges
`-- reg

With CONFIG_PCI_DYNAMIC_OF_NODES

# tree /sys/firmware/devicetree/base/pcie@10000000/
/sys/firmware/devicetree/base/pcie@10000000/
|-- #address-cells
|-- #interrupt-cells
|-- #size-cells
|-- bus-range
|-- compatible
|-- device_type
|-- dma-coherent
|-- interrupt-map
|-- interrupt-map-mask
|-- linux,pci-domain
|-- msi-map
|-- name
|-- pci@3,0
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- dynamic
|   |-- pci@0,0
|   |   |-- #address-cells
|   |   |-- #size-cells
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- dynamic
|   |   |-- pci@0,0
|   |   |   |-- #address-cells
|   |   |   |-- #size-cells
|   |   |   |-- compatible
|   |   |   |-- dev@0,0
|   |   |   |   |-- #address-cells
|   |   |   |   |-- #size-cells
|   |   |   |   |-- compatible
|   |   |   |   |-- dynamic
|   |   |   |   |-- ranges
|   |   |   |   `-- reg
|   |   |   |-- device_type
|   |   |   |-- dynamic
|   |   |   |-- ranges
|   |   |   `-- reg
|   |   |-- ranges
|   |   `-- reg
|   |-- ranges
|   `-- reg
|-- pci@3,1
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- dynamic
|   |-- ranges
|   `-- reg
|-- pci@4,0
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- dynamic
|   |-- pci@0,0
|   |   |-- #address-cells
|   |   |-- #size-cells
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- dynamic
|   |   `-- reg
|   |-- ranges
|   `-- reg
|-- ranges
`-- reg

Changes since v9:
- Introduce 'dynamic' property to identify dynamically generated device tree
  node for PCI device
- Added 'bus-range' property to remove dtc warnings
- Minor code review fixes

Changes since v8:
- Added patches to create unit test to verifying address translation
    The test relies on QEMU PCI Test Device, please see
        https://github.com/houlz0507/xoclv2/blob/pci-dt-0329/pci-dt-patch-0329/README
    for test setup
- Minor code review fixes

Changes since v7:
- Modified dynamic node creation interfaces
- Added unittest for new added interfaces

Changes since v6:
- Removed single line wrapper functions
- Added Signed-off-by Clément Léger <clement.leger@bootlin.com>

Changes since v5:
- Fixed code review comments
- Fixed incorrect 'ranges' and 'reg' properties

Changes since RFC v4:
- Fixed code review comments

Changes since RFC v3:
- Split the Xilinx Alveo U50 PCI quirk to a separate patch
- Minor changes in commit description and code comment

Changes since RFC v2:
- Merged patch 3 with patch 2
- Added OF interfaces of_changeset_add_prop_* and use them to create
  properties.
- Added '#address-cells', '#size-cells' and 'ranges' properties.

Changes since RFC v1:
- Added one patch to create basic properties.
- To move DT related code out of PCI subsystem, replaced of_node_alloc()
  with of_create_node()/of_destroy_node()

Lizhi Hou (5):
  of: dynamic: Add interfaces for creating device node dynamically
  PCI: Create device tree node for bridge
  PCI: Add quirks to generate device tree node for Xilinx Alveo U50
  of: overlay: Extend of_overlay_fdt_apply() to specify the target node
  of: unittest: Add pci_dt_testdrv pci driver

 drivers/of/dynamic.c                          | 187 ++++++++++++++
 drivers/of/overlay.c                          |  42 +++-
 drivers/of/unittest-data/Makefile             |   3 +-
 .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
 drivers/of/unittest.c                         | 211 +++++++++++++++-
 drivers/pci/Kconfig                           |  12 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/bus.c                             |   2 +
 drivers/pci/of.c                              |  88 +++++++
 drivers/pci/of_property.c                     | 235 ++++++++++++++++++
 drivers/pci/pci.h                             |  15 ++
 drivers/pci/quirks.c                          |  13 +
 drivers/pci/remove.c                          |   1 +
 include/linux/of.h                            |  28 ++-
 14 files changed, 845 insertions(+), 15 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
 create mode 100644 drivers/pci/of_property.c

-- 
2.34.1

