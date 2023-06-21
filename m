Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5FF738D2C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjFURef (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjFURee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 13:34:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08934193;
        Wed, 21 Jun 2023 10:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e11MOnV4mAFyyJaSnYuYBWaTymCWjydN62Z7XgfA56Rl5Juh74pP5Pk3Z3ov8s5LeIlfEkuMukNEyFfLghQ52+ImOk6iAgOEARRozlau65VOvD+HKacQPvGNOCm7TJe7IFXY840AxagPDXWg4MIMbMpT7FzTDr1AiJXx2l9MT/wI3VkH+gdXMH4n9BcKY0g2bZdd++R+JI9U/GWDZXLHAhyopVwq6fOe4+PIgceOJBips+fMTJDk6X8T7K02bcm+25PYSMnYZe9Bw5xkVrbYTiCgACgMYY88s62aLeIHJ3NMWsZypnFiBRpS37uOi67M0wUzQ7dpakjb7w7prCjYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63b3Wo/X0Yewu8Sjb3mXlYQC1Rs2IUsAD18qvko+EoE=;
 b=E0XjMVYVBljkBn06U1zjYii5r6cXHglVmDOR4fyhahQSAkkSchQ10OXSa4eo4J3C+yrGSKkPJ0ESf9lQYbUTUPtD5zecNznmlzvoeRzXyLzte8DJv9aMSRLbj29SUvfjfWe6MjXVfieLugnI4YvyiDFu9LWkcR1+L4uBcwS4834mQ/ySFKld2XaliW5pUIWGCzkD/JAe3zb9TO752IHrwk/HO76QEg00gwJ5g+342f29fizcUzeTTTpqq/V4v6PrVIPw1/MrDOn8+unPs4qWPAwke/1vpJDcPJuo7NiaKa+DO0pCcAn64t38aKlJGYjKFddW8Ie3Y2F6UcIvnkITcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63b3Wo/X0Yewu8Sjb3mXlYQC1Rs2IUsAD18qvko+EoE=;
 b=FWHh7JscUhPwptEBzqvVh81KrYG0Ng8xjV9UlkIGb0DijpBCqu6I0g2vfc69xe376GKjrtNkUo0UwKiYhUuNhP45d9cXDgN4uGfk9JZ1O19tg7PvyqHEXjd3I1M9WJDzLI0D3u+Dklf35evPRJgPyb/PkkUu+5r3dNTPHBLpVo0=
Received: from CY5PR15CA0141.namprd15.prod.outlook.com (2603:10b6:930:67::6)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 17:34:27 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:67:cafe::d2) by CY5PR15CA0141.outlook.office365.com
 (2603:10b6:930:67::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 17:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Wed, 21 Jun 2023 17:34:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 12:34:26 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 21 Jun 2023 12:34:25 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V9 0/5] Generate device tree node for pci devices
Date:   Wed, 21 Jun 2023 10:34:04 -0700
Message-ID: <1687368849-36722-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a83d36-3e12-4e86-ed70-08db727dc2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IiC9b/bizweCKYfxPRxW488WXqZ/A3Xsr3rlPZo9m/LiQ/9wcQOLcsm16RhPkfKMJiK3l+AksWsUMfIzLxuAU50xCqpwSB68lGD9wwB5IcxXhdfFiS4KhlH7YJ/udfHXbWVeqagNpF7Eai4Y1RFfBZ89fp4A9nP65sPMCKe0IjpVsO4TymXF3F++C/jrH3C1tfDiaWdRRfwNh3LlhNKu8GKkBIHK2ZtdV0WqaS5bSOSfMv4iknG1sUE9ATL3eMIkxnhFa05mXdYfnJNZaRWUmShvTt2ocGBbP0h8GrGsIPrRp6IHE7n1S2DrwM4iDtPfsJ3Ss5MP6+S0IBX7nw5B+LjNLofOBpwKhw5PnHQKdmfyVvdPag8l5ujEu5B6Gvr3/qDK9qJDYWsUMWQf3ubEGcA3Oc9Ftv1v9zekYNymI0ZrlXCK8B7TcoFxUKMYQNY3lolEqi7L27EVF7hHmqYjqz9FjeTNF7jR11d8fmGUwrq+UMxQGQmWhkKQTCPzhx+JjVMKfSyhJ4taIMrHY14CXcjcvWPA41eGKi/RHyFSjYK0TKljLNYoQH1Gew6NxTPhmp1jNUKEuydo0TfS5Gj7CGmW+9DdQyGfPWljRN2Mq97MxzLvVSdndsR6qhwHKftyRZ2lCENAzCXN3kLuSG4wBJMwXr0HeidoDlGXPwHfSQ1JiioNgDqUYXLfdu84mMsmVMrFQLwLWXeE3mD51bo7g13ORdm1kt6Ttx8lY9buQmdys1dEq36sIAFzItTjA4QEQy4xzQURr0XriToCPbidm2RlphDr+MX4esUMLkkVXxU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(40480700001)(356005)(81166007)(82740400003)(40460700003)(36756003)(86362001)(966005)(6666004)(26005)(186003)(8936002)(8676002)(478600001)(44832011)(110136005)(41300700001)(54906003)(5660300002)(316002)(4326008)(70206006)(70586007)(2906002)(83380400001)(2616005)(36860700001)(336012)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:34:26.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a83d36-3e12-4e86-ed70-08db727dc2fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

Changes since v9:
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
  PCI: Create device tree node for selected devices
  PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
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
 drivers/pci/of_property.c                     | 194 ++++++++++++++++
 drivers/pci/pci.h                             |  19 ++
 drivers/pci/quirks.c                          |  12 +
 drivers/pci/remove.c                          |   1 +
 include/linux/of.h                            |  25 ++-
 14 files changed, 772 insertions(+), 16 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_pci_node.dtso
 create mode 100644 drivers/pci/of_property.c

-- 
2.34.1

