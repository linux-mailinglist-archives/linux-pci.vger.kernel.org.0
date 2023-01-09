Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C129662F9C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjAIS5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 13:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjAIS5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 13:57:10 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E71C925;
        Mon,  9 Jan 2023 10:57:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYJIU4ujyglCBWNtr2XCqEfGUJrC81zs/Vbtj4ro9VC0JevAcgbVsQd4cQ6zmaPR0sCSX8mixDBJk6xSwJf7yoh9ipD/4MRJNH3H6FBf7hwQtdXU8TLC/lGp4yMKMNS5zaFJIFb//cA7yS+b8Z31rZwS95MAbjdOFpzU21Ec3NLbVMdOqheBpxjNwJrzIvPvdEYychs2nQefD1telrCwzOt3hWNtx+PyCs6PQVgP1MKhJDchkt9YYcn4MiAfQncziHAObqvKXuOYFitQSMxohYyg7n5Seg8YG/6MxkoZKnGKa1hYJvbvY9cwKpqzU4AnoAwVnH85PXVV1GOVbjntfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZoSltY2ZY8miRfPLlrVJgn7wEkvq4tW1pSyWj/ZTJQ=;
 b=R7hngclTa8JewnRvoHHf5LoiuCCNxBAeDEIIx+nuy6C+KLzH32oDsua/6gyFJD2Yy7nLC0vZXVsA6szrDbDO63d1n4PYL4eoAiEegwa1kmsgrTKkF2k8lFT4cSEp44wtKRu/iwD8f5e40xjm6bwHWTh0fs8M0evVglZ2f2fYX16o2uKfOo7st8eoQA+i/rXF5yNRkgv/47U+MBK6ETl53bP7tIRjpH6DnBw1c5vrquwVP0E3+TMMoSNdCFJNBOnK2oy/ojr/Snw2jnJUcRI6VGdH1ZnIbkbGFwQbCPw0XBwh7jEoNtChZ1GPEDLZVDRMkiS8Pqf5qUWyNfpAOVz7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZoSltY2ZY8miRfPLlrVJgn7wEkvq4tW1pSyWj/ZTJQ=;
 b=FrYxbGhj7U+kd4s68IxwW7RieDWLLFsp/buAPVKU/sCtEVlfcfc6Ldlg19pxHpGi8gTnvkWiud1Gn8B8g8vseXVyYengOqj1ERPVJt9LNwrXr4f2JcKAz29Toi4vCSwgPoL04YMF0yHcIpc8OMLqdbPNQ6MZqINVQcJ7V7CCfc8=
Received: from CY5PR15CA0071.namprd15.prod.outlook.com (2603:10b6:930:18::16)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 18:57:06 +0000
Received: from CY4PEPF0000C96E.namprd02.prod.outlook.com
 (2603:10b6:930:18:cafe::1e) by CY5PR15CA0071.outlook.office365.com
 (2603:10b6:930:18::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 18:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96E.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Mon, 9 Jan 2023 18:57:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 12:57:05 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 9 Jan 2023 12:57:04 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V6 0/3] Generate device tree node for pci devices
Date:   Mon, 9 Jan 2023 10:56:58 -0800
Message-ID: <1673290621-22888-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96E:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a858148-7de1-495d-8813-08daf2734dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umcnJOcnMCNivY28K6mcTzp0V6ZFBb/lfevLCIFE5j3l8eUtXFL9RcgY8bhieboqBiG9Db+jjMPAm9hCMFK7iI9CHtEbBQCL+nfDeoiNxqIAbV3qXv/q7QnoiZFm5/Z8pYhu5nyhAWtpX4MlzRfK+Xu/NSiJ7xS/tVDXELOC+HDE/DO/I00zmXOd5zHsbgLmbzMM0Qms8u522U7bbtt5eOd0MtjzSKAFI7kavpooU4SaV3XEv8GIy16ZECkvMstCD64kLqTdWg6aplDrf4Mb5nmWBLRXvdwlMaxAk7Oj5cfVRH9+dW2Zr5BmroQbVNyt/iXqn5DmG946j+bZZgq1y5RWoA4NzCJTeHjCf7pS/Gj2YV6T0WuevX3KsN4sU7T7yFW2h7NRYIa546DuTc0EXuJbHKQF0F6VCJ9FlcJXPF4u878CZmNxenmuFWbgdLq0JzFKQqNeAgyvKSwAgXrPM/qSI1IrSUQcb3pM49xHaHoxpMcjltBTxxGOrfWjyZQrAwkalmXxNAtAdqpI+gSsJn9T8hIeG1Xa8YVhpJuswwMgudzTTKel30W44fBABw4rzoYQOWHfQAUQKdrX/NK/q1nxYmO8O9prUeeBQTApFyUz+nuqgSafzYBC6VLPHbN9wuNvPPtZiqkbgBBwV0hiulxSHDKhZwuOKjtrDVPv473wFaqa9mvSslcsHgZig/cQ/bBFPRYhu0yvLUmjHmnw8DV1mMYVfkdFmB4qWiVN9Q1hS4oy+umj5fDMijb0RQNnt5dF+8aofCTZq0IZykqEtn8rRfksfrLbfDsxiqd/q6oJCiazE1DbdbbFw/+KbOkQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(44832011)(82740400003)(86362001)(2906002)(70586007)(4326008)(70206006)(8936002)(81166007)(356005)(5660300002)(83380400001)(36860700001)(8676002)(478600001)(966005)(336012)(54906003)(316002)(40460700003)(110136005)(40480700001)(41300700001)(82310400005)(2616005)(47076005)(6666004)(186003)(26005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 18:57:06.5204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a858148-7de1-495d-8813-08daf2734dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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

Changes since v5:
- Fixed code review comments.
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

 drivers/of/dynamic.c        | 197 +++++++++++++++++++++++++++++++
 drivers/pci/Kconfig         |  12 ++
 drivers/pci/Makefile        |   1 +
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            |  71 +++++++++++
 drivers/pci/of_property.c   | 229 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  19 +++
 drivers/pci/quirks.c        |  11 ++
 drivers/pci/remove.c        |   1 +
 include/linux/of.h          |  24 ++++
 12 files changed, 573 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/of_property.c

-- 
2.34.1

