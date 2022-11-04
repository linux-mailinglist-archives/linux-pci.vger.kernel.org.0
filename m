Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AEC619B7D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 16:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiKDPZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiKDPYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 11:24:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064E2EF2E;
        Fri,  4 Nov 2022 08:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMvW7I9OtOpMeTOPemblicYOG5UD6um2W/xFOufJwwtKByWhgLg1gcc8WscstdR4Ze2Mq2W9xel+QZk3Mk+G8IMP059yYFPNyJM2VWzNIdjBj9iNrKMvkgpMRKqEHYYEYR3nyvS4Sp2opTsXk2nG/TdU0S3Obtsy+1JUiah8r71pRdq6du1tvFcm9Q28jLVCIAgYRC4QoaL7QQpg5QQrYsHOhENO9V/suRJdTOo9n3IHqw6cPAewQonAfuDLUW43yAiGOw2gRCEo7kvQFuvV/PO77E0+lDlCuEpnmjkFgWvP9UgPSaSQCYYwAumvzWTM9d1MfJMm0GgllwJAtVCIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwNVCVDcJyDGdTmeqhFdSWbgII5c7aPC7CbtjgTdCNI=;
 b=OPV8AdLBIGt1TPwWenDK1zjiLIfLh2kZpyfghEl3HbYFy+3igLFCr3pZe9+pmPHTbII5QkhoBUFNir2EAsf2ZXReTnKWvViyn9NAwSmpdO6JEgf8lisOPtwQRMd+cZnmaxmU/82qH2xJ5NkMX33EHWRoyB4aTTKEZlmg1qmz5j0rBE08om/tfDsn2Ozc4wxrWx1vi0qw8Q/OM2aJJkFBCFyQCeTPn4RPqFqzoO6kdPF2I3i7mmtwrv7rfqVhL0HEjm2hB+AfhKFHJp8sGG4zUA4r2sdAxfqunzQpb8opY04K3rx8B40/WCuM5ShxEB7ckizpd3kYVJcFOPnv9zLnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwNVCVDcJyDGdTmeqhFdSWbgII5c7aPC7CbtjgTdCNI=;
 b=nvPuGxfaxlUIC5dTxoabZTq23Ar4clwqYxTfDxFiITTV/c65X1wHnRFqI4tkawMJr1EXrHc0I1r1RPM1ltwG5fo/NTyBPWvTfzw1xA9ZasKLGVDX2ldtZvSo3eBAh8a3B+QovyD2XY+DI/n8goRlQNGWN9aHUwd3IiH6bydoXTw=
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 15:24:20 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::a6) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Fri, 4 Nov 2022 15:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 15:24:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 10:24:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 08:24:18 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Fri, 4 Nov 2022 10:24:17 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V3 0/2] Generate device tree node for pci devices
Date:   Fri, 4 Nov 2022 08:24:12 -0700
Message-ID: <1667575454-18706-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0a329e-bdfd-44b2-b20f-08dabe78a4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKiJlHxMN9t0fxOll99UWnqDMjlgIaRxeoBdA6VrwDL+hC8CtCMq9uq7h15KtAYD+S+xclN7oMCKUZVVzhcBztzDGPEtIs61qQFPhuoONaZUceOHka0fnnvP4g6wr3Xia4oGEBZmFQ1dsDkWm58VOv1Inl45Df5p2aCTvEvNT4JUrk62rLmXP5DQX/hTkBB9vHU2Jx8ho7fsRAjbFBm+Lh0sBZLGvcYzo6cGlTib97JRqEo6augopFMIAYLbZDIqZcPhklcLXvDZNNoqxgI+OMoUrJ8Jjn+n5D4m/s2KVOujJB1IHxnEF93errF0f6Se37SMRqgMjPxxV4OrEEKwbP4PFt7wfelX5DYMwIUMlcB2tk2DKN7pGGjpi1Fp6Rl6ju2DsXcUWUovfKgyqSFnhE9J73bcj41InaNu1G7NyU5djS6Wt930det4DIkhSE7xl2NuwDNI5wtSGSncDKa3yuxcht0BTdLaOXtWRcmu2f9IH0A4kDq0O0j0VTEZxStBg3UoKv85HZkuQ8B0P1kPvpVDmhBJ6F6cFT/Yiromy5GPI+VRcNaNa2bLgNaKngNzvfkTDgCRMGTogdBdlYN6UOvrMLJk+ubnMpxR4d6wtxpsLQQC18II+N5p57Ls9ObgvUL/rbOKtzba8zsl062Qzq87PcoKiKR9T7JXCNXlugLwuFcH3oLUVNNby3PDCnC4qqlJd54cZx8LPzQuZvcwQDYR3jhdk/tjHaXYaS+vVhXQzVA8rJIvwAqm9vnpEqzBuHZIjkwX+KPi1s/BbRKWwG3trAmFg3m0/Zk/U035ibqUowbKE7n7TsckyuAxMreDCWU2gDJTkJy6DbMAq2taD7IV4eG+efFezd5N297GElk50lIV6ftMnTeaeJV0cgKe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(36756003)(966005)(81166007)(40480700001)(70586007)(83380400001)(2906002)(70206006)(4326008)(44832011)(110136005)(54906003)(8676002)(41300700001)(40460700003)(26005)(316002)(8936002)(186003)(36860700001)(478600001)(47076005)(426003)(5660300002)(2616005)(82740400003)(356005)(336012)(6666004)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 15:24:19.7243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0a329e-bdfd-44b2-b20f-08dabe78a4ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

The second patch introduces a kernel option, CONFIG_DYNAMIC_PCI_OF_NODEX.
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
           +-01.0-[01]--
           +-01.1-[02]----00.0
           +-01.2-[03]----00.0
           +-01.3-[04]----00.0
           +-01.4-[05]----00.0
           +-01.5-[06]--
           +-01.6-[07]--
           +-01.7-[08]--
           +-02.0-[09-0b]----00.0-[0a-0b]----00.0-[0b]--+-00.0
           |                                            \-00.1
           +-02.1-[0c]--
           \-03.0-[0d-0e]----00.0-[0e]----01.0

# tree /sys/firmware/devicetree/base/pcie\@10000000
/sys/firmware/devicetree/base/pcie@10000000
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
|-- msi-parent
|-- name
|-- pci@1,0
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,1
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,2
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,3
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,4
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,5
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,6
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,7
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@2,0
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- pci@0,0
|   |   |-- #address_cells
|   |   |-- #size_cells
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- pci@0,0
|   |   |   |-- #address_cells
|   |   |   |-- #size_cells
|   |   |   |-- compatible
|   |   |   |-- dev@0,0
|   |   |   |   |-- compatible
|   |   |   |   `-- reg
|   |   |   |-- dev@0,1
|   |   |   |   |-- compatible
|   |   |   |   `-- reg
|   |   |   |-- device_type
|   |   |   |-- ranges
|   |   |   `-- reg
|   |   |-- ranges
|   |   `-- reg
|   |-- ranges
|   `-- reg
|-- pci@2,1
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@3,0
|   |-- #address_cells
|   |-- #size_cells
|   |-- compatible
|   |-- device_type
|   |-- pci@0,0
|   |   |-- #address_cells
|   |   |-- #size_cells
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- ranges
|   |   `-- reg
|   |-- ranges
|   `-- reg
|-- ranges
`-- reg

Changes since RFC v2:
- Merged patch 3 with patch 2
- Added OF interfaces of_changeset_add_prop_* and use them to create
  properties.
- Added '#address-cells', '#size-cells' and 'ranges' properties.

Changes since RFC v1:
- Added one patch to create basic properties.
- To move DT related code out of PCI subsystem, replaced of_node_alloc()
  with of_create_node()/of_destroy_node()

Lizhi Hou (2):
  of: dynamic: Add interfaces for creating device node dynamically
  PCI: Create device tree node for selected devices

 drivers/of/dynamic.c        | 187 ++++++++++++++++++++++++++
 drivers/pci/Kconfig         |  12 ++
 drivers/pci/Makefile        |   1 +
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            |  71 ++++++++++
 drivers/pci/of_property.c   | 256 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  19 +++
 drivers/pci/quirks.c        |  11 ++
 drivers/pci/remove.c        |   1 +
 include/linux/of.h          |  24 ++++
 12 files changed, 590 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/of_property.c

-- 
2.17.1

