Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460BF5FCA4B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Oct 2022 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJLSOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Oct 2022 14:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJLSOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2022 14:14:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF98FE753;
        Wed, 12 Oct 2022 11:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuEkcufm6+UZNlrGQnDyWdN19dqooqrtFuNCUvJMuBQWNy4+vOzGOVW5voh8z1rRtavgR8DlcPBzWlBTXkv4W2kfNw1b2juupgixEVsssiBvMr8l26mVH1+axtCWx+KC0vXZnG8jhs7AgAiCWEL+O6YLYKpn2Gkmzyhhd8BqmcrugboI+xtQsmobxt8+inNmwjftV5NEJ7QKC+XV+VYJBqch1dPMOVtXfVQRZVulO5jgteuek8yp1sldAZ6G8WXF6rfzMfGAA4uWib+zwPlpmYF9z6tZ+FylOc0ddesJst9jJ+tdzmOIVtzBicQOQGITo0sMoNcrA4y88lFdpv6rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwUky5xzCZdLokAp9ICIRIBgt01TVBb5+zih1zRv8P0=;
 b=QH41iUa0Tsc+49yFTXW2JuwVQzsF9jTzBSc+9OKBf/yNUqgKX2tMrw6iK3CL8wkIFawLCQqzpOMjvebU0XgNRyaGAYDifC2vSGNWWtDwJ7wdQBKi3IfZEZa3GO+dOB0q2UfhW1z/lC/Fd3QAvR5O6Qy0FV5cVI4+myI9XC0SIQ6A+2I6VJFuGFkJd6fVussuHRMGXbKrqSlX6r5nvMyyMo1hN+we0uZBRoOFw3/dh4sXP5AJnY/WAtg8RsIdqL9olOMPqeMsSC9fKCI9w2bzqEeTjWCv6bzK9WSrQnefFU+CPz8DNJr7igwqStQi6YeY/t++cMRwPLt4vx/iWoFHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwUky5xzCZdLokAp9ICIRIBgt01TVBb5+zih1zRv8P0=;
 b=Wx0xHRnhN6k4qnhEHFs/dywAEj3wywo82ixEyjWE/ufGSf7zB1rkdS+kT9WiMvP4vGfffqsDcY47nosib8umKkkeKU8JhyC5MQWSrU2iZhN6NWGkwe3CFeEV6mfNCjq22Ncy16JTnbStgeQsk+7Cpm11mmyVIDNI5NN8fJnD/Ok=
Received: from DM6PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:100::37)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Wed, 12 Oct
 2022 18:14:30 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::29) by DM6PR03CA0060.outlook.office365.com
 (2603:10b6:5:100::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Wed, 12 Oct 2022 18:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 18:14:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 13:14:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 13:14:29 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 12 Oct 2022 13:14:28 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V2 0/3] Generate device tree node for pci devices
Date:   Wed, 12 Oct 2022 11:13:57 -0700
Message-ID: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: be2a687c-da4d-4beb-c98f-08daac7d9b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRJXtFeeBwEhiDtDtr4qiBqqmWCW3GLuEKXLst8ejHrvxUXMDDamFXP0hnbyNt3lfkypMsdHJzZoSf45lHNIZTfETtXRQLzayOFlYitvVk26OUMzrtBE2LAW+yJ9e/R6rogrFXwXdFGE/mfrDdxSPi2voa0HaGjTIccJop9EMku+ZZGxz6sOqKeJCyE3842mBtkmXhJuIv1ot62OA1AAYMylXnOgeJIB64UfkrjUezyiQlVInWsC24PNYSpC5FhtiVqaLB36kFJNfnC7JGDP6v/xoqUohIbZl5m3SodiYiAW/yP/a70hMCSchNqhkrFwmbyjLaXdR9KVs71LzYX2i8FUoppFqR5Y+8Ft8CyknZgbdVqDaMGzKPrS4wNMj3PbkhMf7VUvdWzElw3hJkYBSYdPTQDV/XeDAuRY7lkx+kzelCye0sbZlnJl236VhevPisycEXzkABMd8My2YmU+xxUWmkndi/hvCe2xB7YhEp+uUl+I4RbmgT2DFJ0v5vDsJYbHt+BnRPUUfa8TeDinKjaSOcaqlkMzTwte5rKg8oZdQSf4Z9+p2o7lWp00d59jdAhg36Ptg9H+Ja7bsJFpf2kcIRH082sWzAPf6GhgP02zBy8D1VP7klA0of4icxtcRhlIINK2icf/d3EM1+esH7DewgnDJOZA55FdofpZCNrQF5JpytY/v+6XD68qvESi3L97wki59Sasaiec37Rmg1fkk5DvzryGJkTRAuhK7MEdRN2A70l8A9RawYk8s1XhgVM2jBMs/cSAmjih1Cml+waS49eMKN6vNFwz7peCGkm0SMS6M6k5A1K6vJyTdEHZqIz1qgIsh7cC3jaxbBtaRFuDX2zxBZWb1n2HoTSk5oIo2fd3UPLAE8DVVd4fb+kK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(966005)(8936002)(478600001)(40480700001)(44832011)(41300700001)(2906002)(5660300002)(356005)(70206006)(81166007)(70586007)(8676002)(4326008)(26005)(82740400003)(36756003)(336012)(110136005)(54906003)(36860700001)(40460700003)(2616005)(316002)(426003)(6666004)(86362001)(83380400001)(47076005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 18:14:30.2021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2a687c-da4d-4beb-c98f-08daac7d9b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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

# tree /sys/firmware/devicetree/base/pcie\@10000000/
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
|-- msi-parent
|-- name
|-- pci@1,0
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@1,1
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@1,2
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@1,3
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@1,4
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@1,5
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@1,6
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@1,7
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@2,0
|   |-- compatible
|   |-- device_type
|   |-- pci@0,0
|   |   |-- compatible
|   |   |-- device_type
|   |   |-- pci@0,0
|   |   |   |-- compatible
|   |   |   |-- dev@0,0
|   |   |   |   |-- compatible
|   |   |   |   `-- reg
|   |   |   |-- dev@0,1
|   |   |   |   |-- compatible
|   |   |   |   `-- reg
|   |   |   |-- device_type
|   |   |   `-- reg
|   |   `-- reg
|   `-- reg
|-- pci@2,1
|   |-- compatible
|   |-- device_type
|   `-- reg
|-- pci@3,0
|   |-- compatible
|   |-- device_type
|   |-- pci@0,0
|   |   |-- compatible
|   |   |-- device_type
|   |   `-- reg
|   `-- reg
|-- ranges
`-- reg

Changes since RFC v1:
- Added one patch to create basic properties.
- To move DT related code out of PCI subsystem, replaced of_node_alloc()
  with of_create_node()/of_destroy_node()

Lizhi Hou (3):
  of: dynamic: Add of_create_node() and of_destroy_node()
  PCI: Create device tree node for selected devices
  PCI: Add basic properties for dynamically generated PCI OF node

 drivers/of/dynamic.c        |  80 ++++++++++++++++
 drivers/pci/Kconfig         |  12 +++
 drivers/pci/Makefile        |   1 +
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            |  69 ++++++++++++++
 drivers/pci/of_property.c   | 177 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  17 ++++
 drivers/pci/quirks.c        |  11 +++
 drivers/pci/remove.c        |   1 +
 include/linux/of.h          |   4 +
 12 files changed, 380 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/of_property.c

-- 
2.17.1

