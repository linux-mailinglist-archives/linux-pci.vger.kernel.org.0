Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6945A5659
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiH2VoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2VoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 17:44:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B50878BF0;
        Mon, 29 Aug 2022 14:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZXmTZZFY+q9u8ZZx7Ec79e8rMbWeskn8F7I/ox2RcL8xqABXeunOqxjw1YbdzWZOz4dxAlt3vQRI9DmBcWXbgT2stVq5EuML66YVao7DYg3Y9pWu6WnEpcTLCgiJV0jyWbt7/Ilfzf/UHaytenkGSy0A27AJ0inYCACtW85TkvZKCCK34bpHT5VUqW/KvgDKD7rhHVeGaXnZZ64HU2/hpKPrW+2G7UuVH8F/NPiLTWN+/ftG5verNAfLfyX0dz+iB9Wx5jYb+/h/oMWSu1Xmn2MMK7Ei7izjOKXF+PMVjiGZCJPvUJago+gPVHfRRcyfs545ZyeBGqD8u2IH9758g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC/4I2GxASgD96zhxjqdSIxAAJi3po4yCt0rVsVFG84=;
 b=S0zxVRVcMJaY1pGs9LUWFnR6zTBnawmG4nuvbuR2kwTUkuUIjgxKnVrTaZUSi6bU3u6Vfq3vVNi/4pB5tPPNaL3K6+8lsrM+r2MZefivzKbkMrNJkCZvxlNAb220Tm3daHU/xfypmZ+Cley8+7yiIu1GD37cClDJhPuurw6FgIms+4IwcSR3vzLKCTiWFESmZz3gweFDJnn0yGyRjh2t/mrJbgreA+S5psvKdR/BeYnkrbitPY7DuZeJEvqt38OwBgcVktbIH/xUWbF27Ealz2kLlhoYjXqp9xkDt2XSuex0d+MnnnmfQMmHtGprCagTxBY9u3YfrZo953lHuOB28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC/4I2GxASgD96zhxjqdSIxAAJi3po4yCt0rVsVFG84=;
 b=Qri4dtjjdoaIIJgNsjCTd7Dd6evdNMu6/hMqDW2syRmpDUCL+92Pm/+4AsxTvrB2pZaMM6KKQGz4gwIMZzkTUz54ywJp/TuW3wfz3g7+Cnt5mhe4bSwgYu3JebmjjOx2QBtIgVwZQt2i02GQpa6AP0Hy1Fpt5agT/adoOjX+9H4=
Received: from MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27)
 by MN2PR12MB3135.namprd12.prod.outlook.com (2603:10b6:208:c4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 21:44:19 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::59) by MW4PR03CA0292.outlook.office365.com
 (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Mon, 29 Aug 2022 21:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.7 via Frontend Transport; Mon, 29 Aug 2022 21:44:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:44:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:44:17 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 29 Aug 2022 16:44:16 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC 0/2] Generate device tree node for pci devices
Date:   Mon, 29 Aug 2022 14:43:35 -0700
Message-ID: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 225f8d8e-d371-46b6-e53c-08da8a07a06d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJhlT1/UFd6ZXT8RLB5WhPjNmPceA9TQ2vNRmyn0j8ibMPBeuoPg9SXGovAao+V2pngX7CcLfjvOZCu4PoftfsVdTuIwxxwykyLb0xJJmZ/y7B7yE8KLiJ+ukPEVNBwySfzekHoCNeYVUWiGsf9BH5WQMQkDVvXIRh8xHjcn/JqQ/8/Ew/P+tHqxfcWbkjK78y/fIQ+kgRotbJc42ypAz1IneQd4XGrRbFnv0bxKcTg4bKvlUyTlebvtSWzLOcXmB8/i/A4sS3fK7Dd7VQADJ+3iBiHzwRE1D5FGwbTe3E8CJvHVzQRKR6fZtXqg/ElTZk2/4aEj/qNqBjSlMj0iuyi5u7jQ/s4vlh7x7ppHXXcnxuFGz9WVahedm57zDGGWqSJX/eeLc0KDBEY6sTCcIUZ6Z519rNUUv2ktKtJbUbCmD6Vf4swvUQPiNucyvXIyLCZMBjWknXjCucdL93PWhh7R5PbQCZDly+ra4ugsB1dUjjMiS8crg2zBjBAlBwdb/ECCJKlhcG+bMSDeKEouw4d7HidnMv7op6U84qNJWbEFbOwYxA/YRhdFk51+UdVh/WfWhpXQp4CBw2Xl3jfy+K3V2hBU+5vtOn8kNApdiSI2bX1RNL6zmZSwR9UePCPwvOHcDGZ8AVk2D8MWqiySkYjO0WBwz8h1bzMHKHqonXKfdT/OvXlk5WO4G/TH4+z4BJW15FTFjo3OtLT4JftFne3rGFyZjEHJNAt/AEImhEH7f0Qs4hi1ymqQr94nBE+hmSpLGghp/KwsZdQsjL+z94dw4tj73/SViTPcHT9y6GqmYPTH7Dkwhr3wNbyhjvNFzBPKsYsxb1Yug4s1fdSFp39421oTt+oSEBum3JC8PqnWHRrwJsLsf9KjK6l5YMNE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(2906002)(426003)(86362001)(82310400005)(44832011)(40460700003)(336012)(110136005)(47076005)(83380400001)(186003)(54906003)(82740400003)(8936002)(81166007)(36756003)(356005)(316002)(40480700001)(36860700001)(70206006)(5660300002)(8676002)(70586007)(966005)(478600001)(4326008)(2616005)(6666004)(26005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:44:18.5432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225f8d8e-d371-46b6-e53c-08da8a07a06d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series introduces OF overlay support for PCI devices which
primarily addresses two use cases. First, it provides a data driven method
to describe hardware peripherals that are present in a PCI endpoint and
hence can be accessed by the PCI host. An example device is Xilinx/AMD
Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
driver -- often used in SoC platforms -- in a PCI host based system. An
example device is Microchip LAN9662 Ethernet Controller.

This patch series consolidates previous efforts to define such an
infrastructure:
https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/

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

This patch series is made up of two patches.

The first patch is adding OF interface to allocate an OF node. It is copied
from:
https://lore.kernel.org/lkml/20220620104123.341054-5-clement.leger@bootlin.com/

The second patch introduces a kernel option, CONFIG_PCI_OF. When the option
is turned on, the kernel will generate device tree nodes for all PCI
bridges unconditionally. The patch also shows how to use the PCI quirks
infrastructure, DECLARE_PCI_FIXUP_FINAL to generate a device tree node for
a device. Specifically, the patch generates a device tree node for Xilinx
Alveo U50 PCIe accelerator device. The generated device tree nodes do not
have any property. Future patches will add the necessary properties.

Clément Léger (1):
  of: dynamic: add of_node_alloc()

Lizhi Hou (1):
  pci: create device tree node for selected devices

 drivers/of/dynamic.c        |  50 +++++++++++++----
 drivers/pci/Kconfig         |  11 ++++
 drivers/pci/bus.c           |   2 +
 drivers/pci/msi/irqdomain.c |   6 +-
 drivers/pci/of.c            | 106 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c    |   3 +-
 drivers/pci/pci.h           |  16 ++++++
 drivers/pci/quirks.c        |  11 ++++
 drivers/pci/remove.c        |   1 +
 include/linux/of.h          |   7 +++
 10 files changed, 200 insertions(+), 13 deletions(-)

-- 
2.27.0

