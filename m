Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD75530F3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 13:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbiFULhD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349366AbiFULhC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 07:37:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84241286C9;
        Tue, 21 Jun 2022 04:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLWuj5TCVFq19kFSNRasBtXNPo6TMZhvnGs/PIdoa0JvPcG/srL3uE26iS0CCuPwHzRc0Z+6SiPFf3/Ay6oMXfo1SQ+B9oQ6HEPWY4LGUxyppaRfgtkcyD/hNzMKbjNvRWP3Kl12R8Uuzh5LX0h628DhvSyZV00IePvTPUdlc41rbuFbKChgHlxi5uZAqFABMsPz4RUOiirvkvnYwNlaczCRF/nPsu2hAsEKSmsb+oLBQzh85gwEPta+GV/P/8bLPrhVZpqaKeKRLX9gBoKxXBL4WjIjRCEyQOjpVFv+Fke7itQyKNkKfYbXSF1Rr5dIqmX/EZl6n/cc0aNAn0f+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNenaDrZYEkFAQHcjYIh7L2D9Wouh6uO2jzRMK+XK/A=;
 b=hS7403/ngEn4X3mhrREoqiqbVBjurOIghH5woIrlnBBXOoEwi81s7nrJj9aKHARWoAUy2ywvFBaa7hUyVHQvytUdH326mJguotttN0FPorXjAuykaDGVRTrkCw883QafBJM+pKWAW0RyQP/vDuLlEBi0pNueyd6X37TmCY6jvNnW53XtgU3mih+8DJd2oHyn6dCp1kRfC2kc+Ti0FyJNW13TVARTI/MSzw7cRx6QM/1Vhn424Bml0Ky510WOd0NZkkXKWzRX/7kXPAqeA+F8YNpRVsRfAu08sJbuVdkzscsbCln7fNPteNSAWTiTTwlk3vuk/SwxOK2SPBDJVMvUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNenaDrZYEkFAQHcjYIh7L2D9Wouh6uO2jzRMK+XK/A=;
 b=Wp5hvVa5tE1vJnv+rFaZmOhEdNGNXf6J03TnrKJj2gh+TmUi2LuwXDeA6YLFaeydnN9e2EkY4k0xxF6JvY/0LLeZ7QSwQUuuqbBvbTrr4PVHHcvOujRKpOPKER+P9RwdWhK0hb07HQMngAsRDeSmB4h3NCgykO9MJwbhwU1yH7Q=
Received: from DM5PR16CA0036.namprd16.prod.outlook.com (2603:10b6:4:15::22) by
 MN2PR02MB6432.namprd02.prod.outlook.com (2603:10b6:208:181::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 11:36:59 +0000
Received: from DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::a) by DM5PR16CA0036.outlook.office365.com
 (2603:10b6:4:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Tue, 21 Jun 2022 11:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT035.mail.protection.outlook.com (10.13.4.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 11:36:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 04:36:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 04:36:58 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.24] (port=39508 helo=xhdarjunv40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o3cBl-000Bco-Hu; Tue, 21 Jun 2022 04:36:57 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Tue, 21 Jun 2022 17:06:51 +0530
Message-ID: <20220621113653.2354462-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 643bc552-cb0d-47e9-d71f-08da537a5a97
X-MS-TrafficTypeDiagnostic: MN2PR02MB6432:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB6432FB03A747FE06C7F570CAA5B39@MN2PR02MB6432.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W35EnO4Z3HOmp6vjP2Ok8Jy41sMAiSVmOB5A91WrQwG5ucYAAdV1RGFqINSEetqyibSEXCyUEjYBDRr6ZH5fyR/e0QtTCV685zWx5GUDm5oAxa8QO0+1g3c03c06iO8mhpkDkMBCGm1l9q9rK0+8i+RWD9x0oZN2qIGdghm94yFKc+FyCidiR2f7IFJVR2Qunmz1ZeGRJ1G6u3TgC1FJV5hCWH81EWjA41IEnAgEX4eJGliqeB5hgwU9Ua5WmYgNAlde6vFnizZDqIVy5V7ywSP+rUDTikukK0N4nWqNdRr8uzWQqONEWy64f6VJL0vpluXnxE+HhfW8VCTYgcsmJcyiKrVn3RIio3uYMjOeqQPKShvvoMT0ykz4MHZO3sxZhbPary+kIezpiT5FcANbx+3dYJ73LDPMSakNIZg3kAqik9Tx/rHYOIlNQsYPHuzGPsvdBVRcBu+gsgribNkpIZytpGF2ZNox8M5lwiKsnBCdmhAMjgRtX6vUxi3bBQNZghDZBnHZxf0iXhO2pdzBmcQt+nxq12w+JyGmmcbAUwDAN4EyrlQPaMznBYkGjdvMi/WZnKV6InYNbGCXJp5Iec0WrDHLtu7a6wkRZnz4cEGgGvaZ5Vllx/mec1EsFeJeEWIMqwLxziHgLvqlWOGby5qALTDUFtH3BKueTIGEiWKhhwBYMRDrKnYcvEk8EoKH8ozHh/SyLNLe7cVP03xrn9Y6DJ3yKTW81u3yIw+lJetQ45BY9G3fNv6+Gr5j230P
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(107886003)(336012)(47076005)(82740400003)(186003)(1076003)(2616005)(41300700001)(426003)(70586007)(478600001)(7696005)(7636003)(26005)(36860700001)(6666004)(83380400001)(356005)(70206006)(8676002)(103116003)(4744005)(36756003)(40480700001)(82310400005)(4326008)(316002)(2906002)(5660300002)(54906003)(110136005)(8936002)(40460700003)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 11:36:59.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643bc552-cb0d-47e9-d71f-08da537a5a97
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6432
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root Port
functioning at Gen5 speed.

Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additonal register bit
  to enable and handle legacy interrupts.

Changes in v5:
- Added of_device_get_match_data to identify CPM version.


Bharat Kumar Gogada (2):
  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port

 .../bindings/pci/xilinx-versal-cpm.yaml       | 48 ++++++++++++--
 drivers/pci/controller/pcie-xilinx-cpm.c      | 62 ++++++++++++++++++-
 2 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.17.1

