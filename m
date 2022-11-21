Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13FD6329DB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 17:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKUQnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 11:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKUQnZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 11:43:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5D38B85B;
        Mon, 21 Nov 2022 08:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgYDK66Znmh3mB5mNcXJH9hxedz5LMVMnt6xprglQCKZD8qrC/NF0XLh+NPSmAoenGDsaivGjZch1wh7HosGd8I0rcLdYMgtR+ZHpD3TOlDzCzi36UwBsFWt1ke2N5B8T5TUYqBudQu7ClB8HIK1vq1sE0qnCKa+t3ROKSMmmm2CIQL67vbz8+dxiS6Re7dEftqODANwlq5MPZIWLlFN6ujIB/c7xxRXSVi12l7tsbrsTmMp9qwIRKGscSM9l4G6Ait62iXx6wlHcJcXGrLwKxKeqnjVgscnJK15m+I1iZs+MdwGG0/49Jaa7LlPSVE3L8j+5aRaZGwmwk/9Gd10aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP6WE7OnGPFXUNA/vZK+CoBkzMLoe6wIpkhmqMtrkGk=;
 b=F91vR+N/61QbO1ltTz3B9/ahLbK+nbhuK1NC4Ovau/S4gm/tZow6jVas3SesUUCRXju7fG1JiSOCWaJXY5Z0M54SCX06iMzuvbgVkhYCkibuivq/ulj0REf/JhGP86luM00tiu1qkT94K+/Pjw8b52HSA50tj6/I9/EZWvPSC7A25A7ER4WzCN6LZSF2T0d/KQcry+qI6yQ5xnnOcu9suE5ViknRKWluWVIZQRzZe35sUL0qHDm2Y5jiWSjAGlk9QxtcLsy1Na94eRzlhQPhSfEGwoAcTSkQzLew2GSeEt/D6QKviIt14/I6ig/22+ajGjYEeoiHhm57jzdENV3Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP6WE7OnGPFXUNA/vZK+CoBkzMLoe6wIpkhmqMtrkGk=;
 b=0CLokxR/byPUsePJnvoo5yOWpWR0AGq0pWuvxB+t5vHc8Ig2XdMyvuR1qMI6zN1VPsN3+rDl0s8fAr4VyIIgUmU4Us03cvy+u/ubyp9PD5CXubtLxzRwJ9E4mAAcWRdjt3SNdDlo/n6DeD8yhToZ+uENHmLhAZuoXC25+AMUNSk=
Received: from BN9PR03CA0974.namprd03.prod.outlook.com (2603:10b6:408:109::19)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:43:14 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b4) by BN9PR03CA0974.outlook.office365.com
 (2603:10b6:408:109::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 16:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 16:43:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 10:43:13 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 21 Nov 2022 10:43:12 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [RESEND PATCH RFC V4 0/3] Generate device tree node for pci devices
Date:   Mon, 21 Nov 2022 08:43:01 -0800
Message-ID: <1669048984-56394-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6d9e2d-a629-4f6e-bd3a-08dacbdf7bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/n3cPwef8eigNgDKNUDRcyrWQQngkt7juin+UnvWQ+2Yanhhw2v3O5cLlh2v2sa8LsoR9m2ZrWW8BI7ViWwFnLCAmDixNEGJPKBXMjnpo+CeUc+/DkNQwy6YcKMW9MuEO4yS/SWTLX3uEzEEK5ofQgCr0EMK/gjE4BFJGfEluBoxQ9lvUtfI9rsQBR2XbOh420l/Vb7ymyEAbZl/46ZP8pU9Dt9aB8TbsE6RdQElKog+MAX5L+Me6/RiGWyF0B4RDC4HAZtXuA2z5o7gf5EeBOhieFuf9e+t3y2ABxcHlWGTkj/twYobV/hZzrN9AeNZzXGcELwvUPN/LJ5vuSdrUtgKPIY648q9BLswVkM40jCN4gGwg0SIo9Zw58j7Y/klyvzctSY1SftkCQtFhJYPtfTsHGUf1LUsvoEHTHzgxg8MDuriTn8/Hg3nyxapgUjd3doXJffDVuvaeKHlQO0boLXYzYdrefkIWiZkipHiqYIhp3HuurJmzg5R7YkIUGCD6AVV5Gt/hCa7sDaqSI/F/taneOfqANE3QUxbau11xTtSurgsqD5r7GS3HXlqUWLeCAGOR7tHU8dKvVjfpfjuhu7fVIJpsERgcIa0y/wmahgAKNaK5if39ze9ntxW5ZoYSx62KsZTtozLILY+C9LG5hKEAFlDSHgIpJtE6gefN6IxaqT2Dun9brInoZItjNHWG83MA/z/FOHOydzBMktfOMuWXCpoRb/+YRZnlQ2KDIWigJpp1rJU+5iggQEhJAtWHDmaIhkpbOGZu+xvfTbpxEMfMAYxRTpaztKw4GBjjtrJAYhsdZoD9H+60ZTr0jR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(26005)(8676002)(6666004)(70586007)(70206006)(4326008)(83380400001)(110136005)(54906003)(316002)(40460700003)(82740400003)(966005)(336012)(186003)(8936002)(44832011)(5660300002)(2616005)(478600001)(2906002)(81166007)(47076005)(36860700001)(86362001)(36756003)(40480700001)(41300700001)(356005)(426003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:43:14.1431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d9e2d-a629-4f6e-bd3a-08dacbdf7bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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

