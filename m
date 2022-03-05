Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B964CE2C9
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 06:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiCEFYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Mar 2022 00:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCEFYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Mar 2022 00:24:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C015DDC6;
        Fri,  4 Mar 2022 21:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR6l2Lt+D3QVz2t1mLYQ17y+uqhn0JnodrVFuX9m17uNeeLu9u392vujGRq7XXJD7y0W3loU0BdtjVoH0YNmkpJWbVzi3ROn0VXEpHOUHVq42a2frDRvM9SKqkLbfR7ZveHH/rkUaTM7On0JI3gBoeXPKy0M1tdx8LaI2RWmw4s+YiJzqoftYBl1GeAJOHtOx67xDfKkqUJUEVtRyf2jMl/UGsW/qhqi0Z19Xxa3BBjwoAcIBnmrgUKExs5ttZNL1LFvTaGK/Gw2Vdyenh1TPHBKGJEQNDFG6TUVltfBD4ltSg2T8yE0p5tEQrlHP/Dwh81DuGNZQy/bG9wwWc03Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3RZfQfbzp56H7JxrSTQKwKzWHkNw8aoinzPf6a2z3k=;
 b=CHnTLOokre5Z/gR4EueGyuNKyJbNJT4ok5woKOVwJCf+ZnEYhInd7dYHv6cTqc5rl1tAqz1+SkMF2CknEuGMOR10j/i0UmSXsMGfSeZ2ySsFsWgAtJlWrxg0kMyKslDIT7u8CZTRrJXpPwBWUuRVRYHZIAd038D2OUGFU2nRM4CBqR334vWJx+4uQh/nawazLIkjoAXzNG/tRvrF5Ri18RH7a/WfzT+IrUOfGTau0QvIZGUDZO+yDvvvlCewX+wSqVRU27i3SQvmbtCLcBdCEHBRu0bif5Ms0+KlTjcvYpXuqfn6Mel6oAzxX95/yxH8HTXJMwTJRJ24u2SgbcaKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3RZfQfbzp56H7JxrSTQKwKzWHkNw8aoinzPf6a2z3k=;
 b=b0+RE/zk7N/prMHk7gjJU9PMyU8TeRegeqIOoFHZTMLMrz2T/K+4RnV+fScip//lnUQAb+Cwku3CnaAY3lCi0gol3HW/FIP1CwvthHd9Qv0kIBs4YNBCK13rgGWWdQ4Q3bSjv99sNKCP4i0ynAuvazi49jn4zyKduC8LXvZhIIM=
Received: from SN1PR12CA0085.namprd12.prod.outlook.com (2603:10b6:802:21::20)
 by DM5PR02MB2476.namprd02.prod.outlook.com (2603:10b6:3:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Sat, 5 Mar
 2022 05:23:11 +0000
Received: from SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:21:cafe::59) by SN1PR12CA0085.outlook.office365.com
 (2603:10b6:802:21::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Sat, 5 Mar 2022 05:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0032.mail.protection.outlook.com (10.97.5.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Sat, 5 Mar 2022 05:23:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Mar 2022 21:23:10 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Mar 2022 21:23:10 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Received: from [172.19.72.93] (port=44426 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nQMso-0002XZ-1x; Fri, 04 Mar 2022 21:23:10 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id D8C4E600155; Fri,  4 Mar 2022 21:23:09 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <yilun.xu@intel.com>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 RESEND 0/4] Infrastructure to define apertures in a PCIe device with a flattened device tree
Date:   Fri, 4 Mar 2022 21:23:00 -0800
Message-ID: <20220305052304.726050-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e33ae53d-6781-4846-bbcb-08d9fe683d90
X-MS-TrafficTypeDiagnostic: DM5PR02MB2476:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB24762C29557893BAF70E15DEA1069@DM5PR02MB2476.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 165WegotESVhGnc00/tfCOEucUFVRKiw8R7dg0c2NqjRGrYu6G99Y+5/zbIqB3sBwUhZOFVyMbSBZzoCJZXAkgiCu1WyuUkfdFYkvWdYo92w3LQg8YRxly7tMddoOoA4IhPAbVKsQcjk+gsUlFFX2Xia44nqn+hX55oFtMwlR6HShDYno6x1mUxyA9dD3POWziGhaF+GoXKS+q9w8v1IntnT02T0x6chOHfiuFj2eX/pJBbzZktImJb4c38ykh8IeFr9R1hegr2/c4QkajC8v4nx7iHBwHMzNuJ8R4jFbtJjw6reeQDi2P6EvrNLVOhcWRGnjCew+Qy47CYFug4H8gtNP1zypO9RzDLr2kAhJIIdjmN280qXMVuR1293UilEXwG60f5O+jiAVsW7mAOc+yU61ktz9FWYGyimXqEYTeXxcpycpeKLrMFiTBqUTnD0HVhQpzCGYJCe87VA3+kZMprPWetJkRJbb2sS3xOHvMCNPZ1RYvwBlyAZIIDlESMzU578K8Ii/os5cX+sTsDbXToufjzNhRrJNsrm4QcTCAvHo5dNz9MS3oStOchZ4TbDg4y45IZw29x2/isuaYCldg5SBl0jLqfoc4xlZcqly2qAGSErbGT7oFveqv+Bt7PyGI5WvTh3rv4FEdS7//GmV4bLATZi0s1Jo3LvKJ1osw1k+p1wiXteG3yalYLn8bQPW3EOc6yLRNwzWj8EbT7dil59Ro5bawjXoxnhxsR7PEo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(7636003)(42186006)(8936002)(316002)(82310400004)(110136005)(356005)(54906003)(5660300002)(6266002)(186003)(26005)(426003)(336012)(83380400001)(6666004)(70586007)(1076003)(36756003)(36860700001)(44832011)(966005)(2616005)(4326008)(70206006)(8676002)(508600001)(2906002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 05:23:11.1803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33ae53d-6781-4846-bbcb-08d9fe683d90
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2476
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

