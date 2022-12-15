Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA264DFA1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLORbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 12:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLORa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 12:30:56 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3119C0B;
        Thu, 15 Dec 2022 09:30:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/q/7Impw0FiutdfD6RBouVTUfMNQiBZUVPfckFpvesoCY3gQNHb85T3HCyPcPipaLjytGUfv1IzJUusDNcZr8orQ1kISUEedlqfRxfrIkvjcXsnO3ZqT3n9Uqh2lo+leNXPY7FCkZBbIjjj5wi9bxIHIm0Vx895xuNiYpI/uOI/sgmEJYeyUZU5Grs8HgQ6Twz7+d8iPKlICDXD+27s2loD56Mnpd91WM5eJUgAvQQPQFUG4DQuHFhGosYp+6v3f8V+Mv66Y6k5BwVW/UNENed9+nidiL4vC9ojm4XwpTpIrjVVkF9Ga82zzkgA5C+zIcE7kDXj9pRFqxdyqT1YKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjgYwgkf+xg/Uvk6V45vb6yqrGleoFNZLlEw/luaQKw=;
 b=D4hZ9THMZi8k1NEeAeo8c+oe42cnTQ50TBRlnXBnDXcmqTDj40QDNupBnT5yMB6B9xX9XGk4jmgzcVkeGTXOedcNiFoWdid3Ot2v9apmBSIhnSzwiuGtYO8rgvTFc+RIScs1xan8BX3ULX3ZEbznWXI62aq1Y7OE3f+ZRV9zEgSATfBZU8ePQgjOsFKKO2EJ3/n46KNELvcsnIuYQqoXRK8VXZ4JcRWS985AFnbYmeTGUsMM7YXyR9jebhJnsHqeTpnMwywN4hOiHDDdLnE3thnm4KHq+Y/XCIACctYOH54bnwbCSQurAXeRt4MdMTbaU0Fxl5xofYbB8g8MJ1HqsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjgYwgkf+xg/Uvk6V45vb6yqrGleoFNZLlEw/luaQKw=;
 b=TUfJzSWsWu1VW8azOBv4wF17vdpZoc+P2nb8hlXCu6tkiNJ0GpYAYZEt/HFWYon8bqGsVeNZps2bk+u4C0hJI6m7N08528hmPj7GAgjXtU16sgghMsMvmLf8rj6LOdvE2xHlGuc42Rz9J7cpBO2Xuy1axYA1bc+mt/H2swV08GQ=
Received: from BN1PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:e1::35)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 17:30:50 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::41) by BN1PR12CA0030.outlook.office365.com
 (2603:10b6:408:e1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 17:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.12 via Frontend Transport; Thu, 15 Dec 2022 17:30:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 11:30:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 11:30:49 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 15 Dec 2022 11:30:48 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V5 0/3] Generate device tree node for pci devices
Date:   Thu, 15 Dec 2022 09:30:43 -0800
Message-ID: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8b524a-d7f7-4805-8eb9-08dadec21c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDte5zwLJJHn8qmg+NFF7rogRDFea57632lz/MwaS2uJ3yjvikFKtBwxnbSk2l3F0yiPZn9Wq27A94HAKDS5NgKAFiy6MKEiwg0sPVGyMOtReyFj+aL2rF6BWp0JdPAVw+AxMxeksT1C4p4neGSIVpoYaGpvHysNoQjJ1KBhOvFW7F9HmMdNIi1iAuzkea1wssdoDIHMKj12ATHc1M2UKw7RAk4+a7FSJ0vnkJy7gxZ2Sav3R6CEkux922Wo0h5sL4H2Mv1mjo1JZxFfbBNfuA7Nahs7qpz4n616kjiZ2bLcyDUiml8Ib7/tYOoDruv7w8xbP3Lr7mS3vlQyyaULIYUiJyhakdxGZ6qKxJs1g9sfcb+4EhaEFTIO1ILakac65FC/HhfN0ZVZ8NtE5qA+N30DeR/RP1koT4+MT2fGBZb3yCIzKAi2i6VNbvPfB/flkNfdvliiJpWjKBnGqJ1vnAA0iH2lAr/7dPE1Z8293bOYy/9c1I0piWQuxnPfBKZZMvfAxI9RuzIOtLoDu653SIGFZCS1dToLuJ9rEDnMw32Nnt9ykE96BeCb5EQ+mHGJ6SMFdapHpK1huDTnSGV+jxvR3NvZc2iO6EGy8wBqjt1gb8Drfhd0mYQjIntY73CTrHprfYfjjqHyhobaQbbRFs9K27lxl0/Wg8eg9dSvMaaqyL/C9u09XThjB04UVXuhYVm61D4tiLbeSjslMNJJLYFIFGwBQivcrWkdOXL6GkjUeGyIcY3IaTn+/C+RqX6oVfC6dByPul2dkIzeChm/o5UwAEPU0JYndLsj/YD7u0pwTNgv/0kqLPD86c+x+gs2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(44832011)(478600001)(6666004)(40460700003)(966005)(41300700001)(40480700001)(82740400003)(2906002)(356005)(86362001)(81166007)(5660300002)(36860700001)(2616005)(54906003)(70206006)(316002)(70586007)(336012)(8676002)(110136005)(426003)(4326008)(83380400001)(8936002)(186003)(47076005)(26005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:30:50.1156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8b524a-d7f7-4805-8eb9-08dadec21c07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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

 drivers/of/dynamic.c        | 197 ++++++++++++++++++++++++++++++++
 drivers/pci/Kconfig         |  12 ++
 drivers/pci/Makefile        |   1 +
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            |  71 ++++++++++++
 drivers/pci/of_property.c   | 222 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  19 +++
 drivers/pci/quirks.c        |  11 ++
 drivers/pci/remove.c        |   1 +
 include/linux/of.h          |  24 ++++
 12 files changed, 566 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/of_property.c

-- 
2.17.1

