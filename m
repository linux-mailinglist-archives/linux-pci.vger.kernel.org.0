Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66460731E73
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjFOQwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjFOQvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 12:51:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC52D56;
        Thu, 15 Jun 2023 09:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUVfrejbCqtz3RChDBT3XsQ4q0sc5iyF9nS7IAa/Yi5iVGkVccvCe8RFAXzvjcW8EIzBY9ZU8r0NGZ1BVENNyhVsjH4f9VbfULeRfi25P1ty7coPpZlEITCnqznTQoZu0+SgtPc3OVhQEOaAmufiqAEtpd6PtJolsXCPtOp27V9r03JCKTNj/dZdaGHXg4V4f9AA3WiYbN/rFnTqXfWAvr0tyKUvoZkQpk1XcW/CbkHh+owjFC17j8PjJujUY5LWT+qnTtDtdMqAjl9XKcbl1Sh5/wiAuV+jRS7WKSB3rMKD2+G+lnaCUaUFLtf748WB155pKMB2mYWArQ1Z1a7aZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbRAEU0ydIk+yRXKTFpfuJ7L7MRT7FeoO7IPAvGUDis=;
 b=RzANSO/AS4FB+VWS4/KOANQo10Wwu0JNSDFshoSsd1hgj+z5h8lwR182wzU9oSYVKeOe/gSOzp5RKB69+pA0tYOb3emgMHKghabXOis0/43xQLodQoCWGlQveybDWNCpNbdR+SsVbxaH02AYOCVzCvn8PGbBSelPbfnsksf/dTjlD8eCesysz7xTsXil8lh8mB8Mv5er7k5H2RhbFjYWHlZN1ia8CCK0YYA3//MYslVJGEhLYtC0LgC5ylObz76OgDNTfYtjscSxfFMRYoKQnKAdqxcS0SWU1vFBG19pIiIPBHzhgdWPC4otTaB/Fb67DLYdA9dGV8xbsT+EOydngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbRAEU0ydIk+yRXKTFpfuJ7L7MRT7FeoO7IPAvGUDis=;
 b=X53/oJ/A7HDmF30dQRCGSgv7E9TqHLs56rvceRHmBl2uQlNxn9nqco+q5bY0Jk4ZOhZc7jBsLifc4US9oZ69Nr3waXypuYFxn50nO/EkqhJ0lPQbV/kQdlaQsJsLIzVpiGCaff1LjDpS50MDL27cGi+CA2AYL5kc7nq5ErdsZ1A=
Received: from SJ0PR05CA0153.namprd05.prod.outlook.com (2603:10b6:a03:339::8)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 16:51:15 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::dd) by SJ0PR05CA0153.outlook.office365.com
 (2603:10b6:a03:339::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.26 via Frontend
 Transport; Thu, 15 Jun 2023 16:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 16:51:14 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 11:51:13 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Jun
 2023 09:51:13 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 15 Jun 2023 11:51:12 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 0/6] Generate device tree node for pci devices
Date:   Thu, 15 Jun 2023 09:50:36 -0700
Message-ID: <1686847842-33780-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|CH0PR12MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb86066-fa75-4640-8b80-08db6dc0bb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voQt7Nj0NGz9Veb9XD4qcJ3R6QZkCactKh2GjCwK6zODdV0RHqn+OAYAtLY4hq8AqNi8w570KFLw2j20qGKZgrygR9bHd2EsYUYRi/mdVIwmlSMAAyPLQ5HMLCKph+QhmAUoyXZfjPlV/WLEixq7KXItSs/em53KuSkn6SZwIcd57sNa9w9NLwkx6HYeftAwmKEQmhRaE99Q1NkeJGX09PQJuZTdsZnFr3SqetmnYE4SC2Rv3pEXvHfvcJrDM1wpdvGIrtKZEILV7qS3yZXJQjHj1Mf5knfcj8ySVbLW9rblwlxOUXnYS2vfFuTiENPztNe/JU6D3suzbeZrrqIjyx67Q+c5hRfnUP5C17S9ikGBKSjhCm0LxPSeUXjfnC023rQQfLzA6oO771JDTnvGGALy4XBav0vPbKjim1QO6lxJrKcdlikQ5VLM9rEbmxvZEOGSqT4MKUoJ/adhWs6NWvOJZLF2MYGUwJ6Mi1kAC0YBAPvVD7qM4G9p+1jZ2z8PhlLWk1R3yKruy0jV05yRU06nNZhseL+kbFNQm70j01x6fRFVtRMGWlq8gN4cx4S70lSR0fUNqordqKLM5q8QOUBhZ+VzFepBV+WxrwY8tPS6nfaMDeGkNJiuVQbZ5Bi8Ot1rA8b9C8MSdkQ8OWENQiD2Qm7+I+PUcTQ+lEpAf0U+VZXNqayn5Kh+Y4rmI5gmicGwVTUAVAqC3XsU4Hp+C7XquItyOQatLb/wISlZdmuZdkKl6E/Jhc0xllvRIFjhn1sc0cP6VRBC0AkqfRRTD6iBWxUG2NzPi2Yxy/Q5894=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(2906002)(86362001)(82310400005)(44832011)(40480700001)(966005)(47076005)(6666004)(83380400001)(336012)(426003)(186003)(36860700001)(5660300002)(26005)(82740400003)(81166007)(478600001)(356005)(40460700003)(110136005)(54906003)(70586007)(70206006)(2616005)(4326008)(316002)(8676002)(41300700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:51:14.6375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb86066-fa75-4640-8b80-08db6dc0bb61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
           +-01.0
           +-03.0-[01-03]----00.0-[02-03]----00.0-[03]----00.0
           +-03.1-[04]--
           \-04.0-[05-06]----00.0-[06]--
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
|-- msi-map
|-- name
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
|   |   |-- pci@0,0
|   |   |   |-- #address-cells
|   |   |   |-- #size-cells
|   |   |   |-- compatible
|   |   |   |-- dev@0,0
|   |   |   |   |-- #address-cells
|   |   |   |   |-- #size-cells
|   |   |   |   |-- compatible
|   |   |   |   |-- ranges
|   |   |   |   `-- reg
|   |   |   |-- device_type
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
|   |-- ranges
|   `-- reg
|-- pci@4,0
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

Lizhi Hou (6):
  of: dynamic: Add interfaces for creating device node dynamically
  PCI: Create device tree node for selected devices
  PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
  PCI: Add ranges property for pci endpoint
  of: overlay: Extend of_overlay_fdt_apply() to specify the target node
  of: unittest: Add pci_dt_testdrv pci driver

 drivers/of/dynamic.c                          | 164 ++++++++++++++
 drivers/of/overlay.c                          |  42 +++-
 drivers/of/unittest-data/Makefile             |   3 +-
 .../of/unittest-data/overlay_pci_node.dtso    |  22 ++
 drivers/of/unittest.c                         | 210 +++++++++++++++++-
 drivers/pci/Kconfig                           |  12 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/bus.c                             |   2 +
 drivers/pci/of.c                              |  81 ++++++-
 drivers/pci/of_property.c                     | 190 ++++++++++++++++
 drivers/pci/pci.h                             |  19 ++
 drivers/pci/quirks.c                          |  12 +
 drivers/pci/remove.c                          |   1 +
 include/linux/of.h                            |  25 ++-
 14 files changed, 768 insertions(+), 16 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
 create mode 100644 drivers/pci/of_property.c

-- 
2.34.1

