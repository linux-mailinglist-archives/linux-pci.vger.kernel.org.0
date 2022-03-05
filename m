Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6E4CE2B7
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 06:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiCEFMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Mar 2022 00:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiCEFMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Mar 2022 00:12:01 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B0660CC1;
        Fri,  4 Mar 2022 21:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfbaFsMvZ22CAkUXbNGyzyBJ4kH2zdyFcytbA+/1hKB4lY3/g1QH+XvHOtCIT3RRbuNT0Kr1YdFMhA3Or3Ga0WddDcA2wv/VJMDwsreimCgrnnnO3+OskZ+fKj1DB7EiwkBPiny1womON8QMgZ+ja4J7gQj+MTlAm494aD4u+tJEuoEcM6Y3bZil3bel3JAx3WyvIlrD+I9aNCze327K5rUT3Oa6E09WoshAVa8BVGVDpOn624ebZHJkv/tzK6f2AjDEYpHfPki1IuJDj9NttXg3qkWA198jU7LE0F9eKXbVWRhkfYpEXgMx66rN7q2oe9hPYxCb1sslGYkxJA5gGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3RZfQfbzp56H7JxrSTQKwKzWHkNw8aoinzPf6a2z3k=;
 b=C404GEdCu5huK6ckgbSRzVYP89WEv07UDYI6zIOBgXU/EKmhpGSHow956o4KqmUqoFcu5GBgKQCtZvC+nxJtWItix55N8TjfZGiqHmGnpJKtBE6uIBzv0vb+3ZiM8r43zBZPKDGbtUOX/h/lCrkav4PSAtuVmp6HqTLeu4ugPHeFgwKmYQGMnZqBbK87YA16wW4Qjs7hFEs8gOEF2R7RdfPSJiHsyY95SUKGEkCI7NoW1rh6LGna0QHZiAy73Bn2YYSteRhUgSORFdvtOW2NFyN0tNm33BRcCpws+0KrMyc+rViQi4VPBrTNnsHc/+0V9DRaLuRWjAPH59+8Qm3DxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3RZfQfbzp56H7JxrSTQKwKzWHkNw8aoinzPf6a2z3k=;
 b=O4WT0HKMwJcjyW4CDl0J82LVrI6p4cST+xxFq8VcGImWEqSeWJ/BJKzw6S8Hc9zIUo12yyvtNCHH88gbELcD0QdA8n7LVeq9zbWDXvXCRT9Bw6QuvsEFRwLxxrrgttL5IOLCBmuyeG8iiVTWWJUTzn19XHefKM2X2/OUA7dRM+0=
Received: from DM5PR1101CA0010.namprd11.prod.outlook.com (2603:10b6:4:4c::20)
 by SN6PR02MB4973.namprd02.prod.outlook.com (2603:10b6:805:94::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Sat, 5 Mar
 2022 05:11:09 +0000
Received: from DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::f8) by DM5PR1101CA0010.outlook.office365.com
 (2603:10b6:4:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Sat, 5 Mar 2022 05:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT056.mail.protection.outlook.com (10.13.4.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Sat, 5 Mar 2022 05:11:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Mar 2022 21:11:08 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Mar 2022 21:11:08 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org
Received: from [172.19.72.93] (port=44410 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nQMhA-000Gpa-69; Fri, 04 Mar 2022 21:11:08 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 0B409600155; Fri,  4 Mar 2022 21:11:07 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>
Subject: [PATCH V1 0/4] Infrastructure to define apertures in a PCIe device with a flattened device tree
Date:   Fri, 4 Mar 2022 21:11:01 -0800
Message-ID: <20220305051105.725838-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a46ebc-ef2f-424e-c843-08d9fe668f32
X-MS-TrafficTypeDiagnostic: SN6PR02MB4973:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB49730DA3DDBE0DD570976F40A1069@SN6PR02MB4973.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvkrP6kGOvCiguEV0lxsViqK5cWLBvzYC2msuv8rpdUfhQRdcoosce3KhqEV7f5r4bWhc4UVbYxIi0uijkOl6BxcJor7Zs/nAcFIavph7hf6Q0LKjohwW8y4clZj/2u6mMslhx0gB1PH21jtyEEPif1k4H5BNBqKdJSiV5sMED94A0ZU9Ztt7y6hf5Q4DyfJ0P6LbXyjuOzk/kuc1YKy4imCtRp2yZvOnQyNUHIP1qX7/Ax8/MGXpipn4eEDkHKQKFMz8se51Dm+2RZ0ALYApqo1QZfZGrANi6Vlv999x+jRTkJiVP3JKQFaKvSh0Vaw+VGc7+tcAKG1LXq3IUVqY4nsRVSw/bU1ju55AAXpncUs1VamLeVncXU5CBehaMDVBO1yGDKEhax1ugKNVAzKAKrAaPYaT6frh63B3F1lxqEQOENf4HbvujDh+VtQkEYDfvzaCNSDj3/Ytd9HODXtnvESDjifB3SNbWJSN0WbY72jsoCZ71rrApFAbq0FkFhT7Ud5an9tYMjYu70uItbKUQaXubfZHTsbT8fsDotDckH3E5LOEhezxpMijxpzMnzV3hXxz4yZb2cX8rT6dgPMOeTRKM8jmPOBDWShUA5PAqT754xQfyjfIxF2ZSgKWcI0fIDO+2DQg5QzX2QP9XiR2yG//tnun/gvPWaDpt4s87Qm3UsjnvSxPb8xs5Yr301vbot0Ux6ov4SyHj0mYpaoXEC4flUiiZKz8cGrLT/3TnQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(70206006)(70586007)(42186006)(316002)(6266002)(8676002)(110136005)(54906003)(82310400004)(4326008)(426003)(2616005)(356005)(7636003)(508600001)(1076003)(2906002)(6666004)(186003)(44832011)(26005)(336012)(47076005)(5660300002)(36860700001)(966005)(83380400001)(8936002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 05:11:09.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a46ebc-ef2f-424e-c843-08d9fe668f32
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4973
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This V1 of patch series is to provide the required pci OF interfaces for
the PCIe device which uses flattened device tree to describe apertures in
its PCIe BARs. e.g, Xilinx Alveo PCIe accelerator. This requires a base
device tree which contains nodes for PCIe devices. A PCIe device driver
can then overlay a flattened device tree on the PCIe device tree node.
There are two separate parts for this to work. First, not all system has
a base device tree created by default. Thus, a patch to create an empty
device tree root node has been submitted.
  https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
Second, PCIe is self discoverable bus and there might not be a device tree
node created for PCIe device. This patch provides a new interface to create
a ‘pci-ep-bus’ node under the base device tree root node. PCIe device
driver may call this interface in its probe routine to create device tree
node, then overlays its device tree to the node.
For the overlayed device tree nodes, each node presents a hardware aperture
implemented in its PCIe BARs. The aperture register address consists of BAR
index and offset. It uses the following encoding:
  0xIooooooo 0xoooooooo
Where:
  I = BAR index
  ooooooo oooooooo = BAR offset
The ‘pci-ep-bus’ node been created is compatible with ‘simple-bus’ and
contains ‘ranges’ property for translating aperture address to CPU address.
The last patch enhances of_overlay_fdt_apply(). The ‘pci-ep-bus’ device
node is created dynamically. The flattened device tree may not specify an
fixed target overlay path in front. Instead, a relative path to the
‘pci-ep-bus’ node is specified in the flattened tree. Thus, a new
parameter is added to point the target base node which is ‘pci-ep-bus’
node in this case. Then the entire overlay target path is target base node
path plus the relative path specified in the flattened device tree.

Lizhi Hou (4):
  pci: add interface to create pci-ep device tree node
  Documentation: devicetree: bindings: add binding for PCIe endpoint bus
  fpga: xrt: management physical function driver
  of: enhance overlay applying interface to specific target base node

 .../devicetree/bindings/bus/pci-ep-bus.yaml   |  72 +++++++
 drivers/fpga/Kconfig                          |   3 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/xrt/Kconfig                      |  24 +++
 drivers/fpga/xrt/Makefile                     |   8 +
 drivers/fpga/xrt/mgmt/Makefile                |  13 ++
 drivers/fpga/xrt/mgmt/dt-test.dts             |  15 ++
 drivers/fpga/xrt/mgmt/dt-test.h               |  15 ++
 drivers/fpga/xrt/mgmt/xmgmt-drv.c             | 102 ++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_of.c          |   2 +-
 drivers/of/overlay.c                          |  37 ++--
 drivers/of/unittest.c                         |   2 +-
 drivers/pci/of.c                              | 180 ++++++++++++++++++
 include/linux/of.h                            |   2 +-
 include/linux/of_pci.h                        |  15 ++
 15 files changed, 479 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c

-- 
2.27.0

