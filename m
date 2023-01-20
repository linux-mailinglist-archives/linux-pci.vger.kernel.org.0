Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA66749B2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjATDDR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjATDDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:03:16 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C936F30D;
        Thu, 19 Jan 2023 19:02:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHPLMdeM15+ru+oErtG1sSdklbC3zTbQB4SHbb3f0Hv4z4k8abiPqOUKHdXvxZej7Ue6MXwACqNi4ToV6wnApZSzRRULKg9/gUa0Dk0ox87VrzQChUQhdyFNZ6bJioX81EMC890xBBMOyLzikDcDbPjnPhMzwmgERxYlYbHOemgwNIJCvnQhIAO0IFOnaAlCJtlZIdmcI5xlPu80VZ34NLnCJOnlEDw5iekAvx/eyOMVpiX0JGL5zgfhpskbmY86KzLYNtbdBd2ID1DQm0LOkh9fmijo3UEq+QxONd0g6lUtG3SViSz0SvZqqKg/MrnXau6ucP3Dr2a7FZWpptUnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsTh5yqBsZMjKGIanT+DdEKMqqB+jawe6RyzlqrqhME=;
 b=BSBvCjKcIb4Y7yUI7hzqYsB3A9tIOuw+uu/O31tPBp/wp2e0suNkeSKBJxUIrqrArPtHIWyauXYyJa1wVlD0UA/32RsCrWrKTiVTS3iAYsj8mLSlO/kYZBZMyDS+1JzxU24xvqlM/pbJb1j+a03oB6ZWKG7rKA7GAAdcdIDhD7oZLWl+5kH80vJcuMojzEM/d5IJ76c97dqGVs49hTj3xpt9LaopujBtgtjxWa/NwqB3zF0jtzxa8KRYxE//hSHWaniOuoq3zL5Bp1gk7qn43FGdaTxsTPZVEcny4udL9RyjzEn8mqw4zM0WWoySebek3yD9e1sZflTK9/r99dxlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsTh5yqBsZMjKGIanT+DdEKMqqB+jawe6RyzlqrqhME=;
 b=EnPlLixiKYFp11qtfVEKs2uDIfQ3nUomFnCC4sdJ3QHlwC8YTx02FPaI4/YZ99x1bCn9xrjkOLqbM3sDo+COmzrhA3eaD8nTmYQ8Q1YrCElLuabIobLPzI5Z8SyPxiwldcsBI1h3wVk14sxSDUtCwOrP3HRDT8Z7YZs4m6JZ5l0=
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 03:02:55 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::ad) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.17 via Frontend
 Transport; Fri, 20 Jan 2023 03:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 03:02:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 21:02:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 21:02:25 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 19 Jan 2023 21:02:24 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V7 0/3] Generate device tree node for pci devices
Date:   Thu, 19 Jan 2023 19:02:09 -0800
Message-ID: <1674183732-5157-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7d11c5-6893-4739-d39d-08dafa92d3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV+gcjCMqrz62JjXtANoqCgRM3BKfC/mEau3qTu1wxEAd0HsDovCt3ZCG9XdnP5gOIc4c/+lnLk2XUmdUE7LuL8BA2iGzn+dwUg/cbfiDWRdw7Vi1IUYLavmKkzypaYFpplsoOtDqS9TDLz5z/Sj60pkkRGyAI7lXrxx6kt6megvwnR9DXLulOSZ1JLFgYk1Clj17EngZraXFlV1zJzR4HKxdUnrfjCK0eNd0kTaW3O2gCK8C2EfUCVW+BPPTXhTo+ACY5bCh2/WKGX6U1Ff4Kvk/xdFCwbxArE0f1rlymlwQS/w7D0rCKVFHcorYJxT6IvK/wTpeNMKUW/cSIqoV29csiraKxcbJY1irCG2dyVsITGHymRJMl4zC9lLKtHgJY1+aJfNfmE4h2DIfmzdi2IaYQEYcJ5/OLhGc+4N/jpvcV/yu59bjVjZ+S9E5NIUKS1X2ZZSEOEIdPPHGMJA+DCUqOsKgGpJYUfiRUddsIrQZWz76J2mkzi+UiCNnplVX7Yx8iZhn4GcE5YgEb76FVemydYOd+u8F0jaFfQ/6J6DNc1+GbZrohLVuARtQOc/7G4q6OPO9Ugtzz7RUwmK0boeEJGw+RHN408ZhnYomYIJIVsSZDtUXuDtpiSP87NrR+3bJySrv29YTtuc5hKQXQdcHM2OPlrCtAA8OYBDFuW54oV0B5AcXIihUAEZY9i8mZstMiM8QbW+7H+4CZirGPWO1Kbw1myu0jR07WzO6S0kzcpL2NpspAgDO6/p/xeV869MYOtFWJc//0kHOBI3tcdGE3hN4v+eD1tx/gyzrZlP9U/7MKcZxGZ4t4ZjOAC2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(966005)(81166007)(316002)(478600001)(54906003)(41300700001)(82740400003)(36756003)(82310400005)(40480700001)(83380400001)(110136005)(44832011)(26005)(40460700003)(336012)(8936002)(86362001)(5660300002)(186003)(6666004)(36860700001)(356005)(47076005)(2906002)(2616005)(70586007)(8676002)(426003)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 03:02:55.2985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7d11c5-6893-4739-d39d-08dafa92d3e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,1
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,2
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,3
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,4
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,5
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,6
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@1,7
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@2,0
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- pci@0,0
|   |   |-- #address-cells
|   |   |-- #size-cells
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- pci@0,0
|   |   |   |-- #address-cells
|   |   |   |-- #size-cells
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
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- ranges
|   `-- reg
|-- pci@3,0
|   |-- #address-cells
|   |-- #size-cells
|   |-- compatible
|   |-- device_type
|   |-- pci@0,0
|   |   |-- #address-cells
|   |   |-- #size-cells
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- ranges
|   |   `-- reg
|   |-- ranges
|   `-- reg
|-- ranges
`-- reg

Changes since v6:
- Removed single line wrapper functions
- Added Signed-off-by Clément Léger <clement.leger@bootlin.com>

Changes since v5:
- Fixed code review comments
- Fixed incorrect 'ranges' and 'reg' properties and verified address
  translation.

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

Lizhi Hou (3):
  of: dynamic: Add interfaces for creating device node dynamically
  PCI: Create device tree node for selected devices
  PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50

 drivers/of/dynamic.c        | 197 +++++++++++++++++++++++++++++++++
 drivers/pci/Kconfig         |  12 ++
 drivers/pci/Makefile        |   1 +
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            |  71 ++++++++++++
 drivers/pci/of_property.c   | 212 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  19 ++++
 drivers/pci/quirks.c        |  11 ++
 drivers/pci/remove.c        |   1 +
 include/linux/of.h          |  24 ++++
 12 files changed, 556 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/of_property.c

-- 
2.34.1

