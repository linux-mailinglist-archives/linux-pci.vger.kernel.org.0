Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE55623907
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 02:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKJBme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 20:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKJBmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 20:42:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671D26ADF;
        Wed,  9 Nov 2022 17:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq1dhCXP2mkojOzgAJEexJ7S8arJgDvfLRxKWpRwCW4xw6XJk6VMC/ln8cQxjnIe15qUNWO4xqpDC1zHlhLAzwqh++qIst1ZZNbSWYfspccqgnZLQDLTFMBAuFAf5XxBJpO6w70Zd2XRBSCJ34Px2nBQ7n+Jz1S+zQRy5uJedFA5e6i39KMoM5JiZNh4vbjawpNr3kE5BSR3q0Op2MZWYksayB4IN2aYfQ/hE3yyxRbqvJfN4bMdMuw6ALLYWftuurc/HAZApxSsiNpMoxutiKPg5duNO5o4D7QgfAKghWmJLT5jhUp3olsn1FLdb/ujEcUQB3JC29/biFuzWzIOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP6WE7OnGPFXUNA/vZK+CoBkzMLoe6wIpkhmqMtrkGk=;
 b=hguoqZ0/Sf1uuchwF/x/BSaLEOjzWpG92EloBKSpYz5p6OLeYai+OLFUPmyQQs9z/6xuN2M0bWk9c96eJGtgOnoChPBlp/NvW4B4ewbqTtMr3cki76xmmUHNUlaiRrqEkGnpO5BziugH3GItsdbZbWxCkW4VzRxA6p1ZGSscd7P9A7jg32vK//u4lace94Whid2p6yL/vh1nOV5/CU34oWM7pwyiklbVf00fupEHZVg0T6CAVxCDfYsImMj1nFta9WKu8MRLbhnfmlozJNrTZBvqtjF+U9zHbYqvvBqjfN8o4Rsw+irloTd9ZQapyxq2NzkYjdoh5ODz7HP7WOJ3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP6WE7OnGPFXUNA/vZK+CoBkzMLoe6wIpkhmqMtrkGk=;
 b=bbQd5E7YICo1+jYjOtszUGlFXe1s4rhM1kKuRa3cqNMYRoaw6Mn94Q+amyGWYenmhUs4SgcNQC7h5wJHzzwEt3YHWK0oa+QZeLHfGAo5C8CjZ7wQDNMxeYIKL6aFYYqkXOxqXovxyTDwRzMcUIwlEmDst0MIhA1++9bEUGCAf9Q=
Received: from MW2PR2101CA0010.namprd21.prod.outlook.com (2603:10b6:302:1::23)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 01:42:27 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::ea) by MW2PR2101CA0010.outlook.office365.com
 (2603:10b6:302:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.2 via Frontend
 Transport; Thu, 10 Nov 2022 01:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 01:42:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 19:42:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 19:42:25 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 19:42:24 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V4 0/3] Generate device tree node for pci devices
Date:   Wed, 9 Nov 2022 17:42:15 -0800
Message-ID: <1668044538-27334-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf7d6ad-7ed9-407b-9530-08dac2bcd2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dI7UDeElEN3uNwL52+3wtjW0lfdfeGJE0u0fvx/EhR46QzJfH8ICO6iCUbYyLl9Qsz4vh/MP55VdMDlXYc/RwR7JeJuenaKNO5gMjBLQn2DiaTCE5lhwJuTDj+fTVIz5nEjznFXq0sFL4coVXP8DCS1RvJgzkTfX31H0VaWImhC+d3L9AD8Shesw0jqHWeNetoWtZ+qLzJyhJmksEn6xGlkpCkjomSTopm+iyBpIgfn6cXgTwdjf+oL0CkmuqrXPcucy/E9gjbzxWvMr7dRiqBQSnYzOleF73AawHdowNdcIIX/GTgoShs41XHEPL/4c4lCsyRYpEm6h/e23aCsSqA8TMTGP74YIxF+L6cbN9f2Inzo3D8L4XwPJ7Ga702MqdyefnNiNiE8RH5pR8wtXfh0UAOstRG07aTgwrLirSRwLHa3MbSuKYGABQAnYWdp2+dDosBO1FhKIpmdlrEGQgQJHFvTeC5jLSeMX+7grbwAK9s60a8ECWnqvTC7/mmRZMhEM5KJsvdFq95SaYyrA9kYRmg97w1GIySevD14X2ff97D0es2Xs4wOmj6iNC98ZXt5l8rg/JKv9zKaxh5N5RRR8DQq5NkGIGcQvKAlSE+WhN23rWW0VeL2Qy1WwXVHqjQij6hhI0UVAV87pZtHpKjl1JYkRMRnZ/okecFjd8wMuIFHlX+GbbS/rzla/tDizQjayojMTJAKcp4ImqrtMc+vH7KMjogo9meGPkShxgXhUrdt5/znO31WJsOCEzeiO4rAP6paTk1EZsJ85pYkhZA2idLu+aHB8yD9dtOAASx5pA+pwyu8zfjBgv5tEuSoAceiHci0r1XxuycykN2sRZfz5cv0CM8wIEi+CWT/+HkKmvp461Idr4aVP15NY1QAQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(86362001)(36756003)(316002)(40460700003)(8936002)(40480700001)(41300700001)(83380400001)(356005)(426003)(336012)(186003)(2616005)(81166007)(82740400003)(47076005)(82310400005)(5660300002)(966005)(54906003)(110136005)(478600001)(26005)(70206006)(44832011)(6666004)(70586007)(4326008)(8676002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:42:26.8597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf7d6ad-7ed9-407b-9530-08dac2bcd2a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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

