Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859B17672D9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjG1RHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjG1RHG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 13:07:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13553B5;
        Fri, 28 Jul 2023 10:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQSyqJ/gnS1BZ0140KmsCaAj66/DdYKIJgyNoTz39sPbvNGmepZU87qkMc1nxX3x9uirL1bmz51HIACx1v5NYCMHchCXNc6bQSDNYzj6as4J0fcsaM5x28yVNrV9z6M9kxr007YqEj6eX5BI2HvIA+tw6OgM2u/gpw8r6vTomX0G9I3GoVBjPJZNQVOBmyI5YIbQQD9uSt2sHKGfotkFw0IFfVEAeeZT7QrLP5P0X0Eur6kVEPjTiiW9JXAAXy4As13B2whJu7XyGJyVGOHKYYVBzZA/5jkk8etkus3v3lunXwjT8lYP/08EFhnm0BeeVc8zPOycm1l2iEkWl0Fo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzDFPt/aHfMAsfidd/1AosN6zA6sV1BIECAFCEv3pnY=;
 b=VDAdMa2CtfM1PbCadH+YQg/3A7f8CUf5owdzwwrKv/+cFhtmTNED1MCX1rM/GwLJXzxSgTjX7xxOPXjBNBYEgn0hw9oLRoBBLOlGJWQtmD/w3MrJJOSljqTdmOIbDakUXuQEm6uW1SaOlqP7bhrpiakTMlhOnbafySTotMY734EusHx9y+raVLqmd7QB66rvBEpsVbX1DMi4Vk+PgPMj8gAQ3bdwSqiauqM0m5PcL+dqJbruch7/tjVjn8dgxCfOiz0GpZVJcm9Q1ibGLXlC2xvPCmBXy8BJ2wJ07zpwX25dJI3/yxMlf+IIer6c346VFBKNEqSwyqhrapRdnf4/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzDFPt/aHfMAsfidd/1AosN6zA6sV1BIECAFCEv3pnY=;
 b=2Eqsrf95++HsfOrrCTlQHHnlWZdBTvz5T1T7AfRbI0L76Q2tPsVCaHQNUlaz9BRDDzHobZYH8Xn7TEFKhg+hbOCjyJqvKILck1Jwp4//lDlYqz3RmwrFcZvjwlsuqVoc79ueiRM4C4SrUFmHv6mxMeorO/ypa8Xxspn2UXe34k0=
Received: from CY5PR15CA0258.namprd15.prod.outlook.com (2603:10b6:930:66::29)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:07:02 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::41) by CY5PR15CA0258.outlook.office365.com
 (2603:10b6:930:66::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 17:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 17:07:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:00 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 12:07:00 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V12 0/5] Generate device tree node for pci devices
Date:   Fri, 28 Jul 2023 10:06:53 -0700
Message-ID: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d091456-0d0e-4bb3-7aba-08db8f8d0fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk5wqqVDg76sIypTes51w5if7y9OarsdD6EJBZ6CBINM6R3jnmWyyc3VvVknPomSOvvtcMyU/Ta3K2T3UCM6Qx3nly29qonH/iHterybhnb1wQ7g/iwNZlhwKzYxre6Kl+qkwLaLthznMADg1tmuRw2KvYGbK+RPOyvLK5Wsd+alelMgGyaYsxokC7XB8fi7a8F+Tkjm4CQoheV91fa0IzXIspauZCj+0roIWzVoq3Zvy5Jox2jA5l4m9N2bAo5BoYSCdVENkJuTVcK1W83pC5XCqeb9jC+XQipKdpsY0a+zxssNiH5OnWPwfUC15oklQ1F+pT8a2tmHuUDeha9xtqvJf1WZqCIhPBR/gHoNu/e17NrSYubrXqJfX85/XFVqgc8xUlLQOSCYMaQ5RyD7UnhbSKFdDEgdbaw7f+uTW6IEkjQmEMdWLTzewRzTBFtLPFiPD+zu8KG+9vvp/XDYwBS8ZQ6qVLyTdyTZqEFdPtFBJZgOewUXvPhF7cICuASQuf6tPV8YL6H9MID8OoAfNHJ4M67NkI42dUxdN+G9CVyq8gRsWcoLkrtgXbt156G/OeLHZRPSiY4eZrf4I7jmKOppzBG0y2Ee5a4qX7TV6N1B8WH00k96vzJwf+XVaugfhIsgbXaYhoQw/YpyeqRTzcWgAoAtRI866Z1Y2+1jUZHiuhwOVyOHG9WZ+6rnQeQiBZkJc9JPmheD7EL+2UO1wSP6G8kZuKWiLoFgmonIWkzRPPu5bWKuvIBHuRASIgsMm+CMcWsFKOtQKkWZQox2OsXdL+RlFrG/zg2V+HdcE1Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6666004)(82740400003)(478600001)(356005)(83380400001)(47076005)(36860700001)(966005)(26005)(70586007)(70206006)(54906003)(110136005)(81166007)(186003)(426003)(336012)(2616005)(4326008)(5660300002)(40460700003)(44832011)(41300700001)(316002)(2906002)(8936002)(8676002)(86362001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:07:01.7652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d091456-0d0e-4bb3-7aba-08db8f8d0fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
|   |-- #interrupt-cells
|   |-- #size-cells
|   |-- bus-range
|   |-- compatible
|   |-- device_type
|   |-- interrupt-map
|   |-- interrupt-map-mask
|   |-- interrupts
|   |-- pci@0,0
|   |   |-- #address-cells
|   |   |-- #interrupt-cells
|   |   |-- #size-cells
|   |   |-- bus-range
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- interrupt-map
|   |   |-- interrupt-map-mask
|   |   |-- pci@0,0
|   |   |   |-- #address-cells
|   |   |   |-- #interrupt-cells
|   |   |   |-- #size-cells
|   |   |   |-- bus-range
|   |   |   |-- compatible
|   |   |   |-- dev@0,0
|   |   |   |   |-- #address-cells
|   |   |   |   |-- #size-cells
|   |   |   |   |-- compatible
|   |   |   |   |-- ranges
|   |   |   |   `-- reg
|   |   |   |-- device_type
|   |   |   |-- interrupt-map
|   |   |   |-- interrupt-map-mask
|   |   |   |-- ranges
|   |   |   `-- reg
|   |   |-- ranges
|   |   `-- reg
|   |-- ranges
|   `-- reg
|-- pci@3,1
|   |-- #address-cells
|   |-- #interrupt-cells
|   |-- #size-cells
|   |-- bus-range
|   |-- compatible
|   |-- device_type
|   |-- interrupt-map
|   |-- interrupt-map-mask
|   |-- interrupts
|   |-- ranges
|   `-- reg
|-- pci@4,0
|   |-- #address-cells
|   |-- #interrupt-cells
|   |-- #size-cells
|   |-- bus-range
|   |-- compatible
|   |-- device_type
|   |-- interrupt-map
|   |-- interrupt-map-mask
|   |-- pci@0,0
|   |   |-- #address-cells
|   |   |-- #interrupt-cells
|   |   |-- #size-cells
|   |   |-- bus-range
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- interrupt-map
|   |   |-- interrupt-map-mask
|   |   |-- interrupts
|   |   |-- ranges
|   |   `-- reg
|   |-- ranges
|   `-- reg
|-- ranges
`-- reg

Changes since v11:
- Create interrupt related properties

Changes since v10:
- Remove 'dynamic' property

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

 drivers/of/dynamic.c                          | 164 ++++++++
 drivers/of/overlay.c                          |  42 ++-
 drivers/of/unittest-data/Makefile             |   3 +-
 .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
 drivers/of/unittest.c                         | 211 ++++++++++-
 drivers/pci/Kconfig                           |  12 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/bus.c                             |   2 +
 drivers/pci/of.c                              |  79 ++++
 drivers/pci/of_property.c                     | 355 ++++++++++++++++++
 drivers/pci/pci.h                             |  12 +
 drivers/pci/quirks.c                          |  12 +
 drivers/pci/remove.c                          |   1 +
 include/linux/of.h                            |  25 +-
 14 files changed, 926 insertions(+), 15 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
 create mode 100644 drivers/pci/of_property.c

-- 
2.34.1

