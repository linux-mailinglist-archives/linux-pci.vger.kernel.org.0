Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28064D2E94
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 13:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiCIMBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 07:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiCIMBf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 07:01:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47089129BB8;
        Wed,  9 Mar 2022 04:00:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0wcd6lrtnbs5UHAWc0k8PQfDcmT9tB7FX3qGsBgF9NPeKdSuJyw+faKl6PFQMBztZSrQ02EX8qncauh0b7eAVq9QEgxvi+kKjXwCqKzpBbNXNlqyOyBJqRwYJGo5CEI/pQNae5HgcVveDXtnE0QCQKrHBX1nN0003PaXVUGBc0IOAeu4xie1Q2nfSXC/njvtDlLd/zIBfx7s+40qFw60h306dZF/iVETGPOhvzqBgdJIo7pu2HKbgizaKnR519XbVZyl8I0d5m0279NeD9lVuaiFrHMDliwbduhxYP470YmFfxpZjObvvCCKaI/H+cGoaQtJcwM945fifLrFtr4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njh2e3nlm6g5RknyE5sAnGc59k2MyJk3XaPDLw1CZC8=;
 b=iSTE54piiSgJUAHVnh9nmIEnKN30We+pyg6r6zLbBVVv7Ilqe7xeyIeU/4FK3jNIPgeYsK0j1fGDf2GdxHZ029bLPMHmS+swzZ7P1wKyviDW/mb8lAozjonnFsEVY3/IBfxrRjXGaI2SSC6rKppKvKcILLNNlbycm0Z1bx49hAFuQpJaaQXkTH/SgoK6s/MYGcHqga4EEWH1d2PizXp61KudHLwrJrhpT8byrM3uNLIQFW93sZ8yhNm50qsXNqNfIL3nb5nfh8sy59eRuj9JnySMmzZepIsLD52BFJpOivHDvjbPkyl1RyRzuCVjKGddBjZHsvRwOgo0019WeI8MGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njh2e3nlm6g5RknyE5sAnGc59k2MyJk3XaPDLw1CZC8=;
 b=YwsMKth1M4GwX0SOJ269eMyCxXwwgF+W5w+9iNTofMe5eureXaUHl7udnGJt2B9Uunbm2bkxb2pwzHleIF9X6gsc85E5ThgvuJXqZ3yxEMMXz54OjEjbX6u1str1KhmIkZ6hx8htqG0m7AtGhM+X8dxXV67IQ+kw9U4oLWVCy1k=
Received: from SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44) by
 SA2PR02MB7562.namprd02.prod.outlook.com (2603:10b6:806:147::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 12:00:35 +0000
Received: from SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::91) by SN6PR01CA0031.outlook.office365.com
 (2603:10b6:805:b6::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 12:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0033.mail.protection.outlook.com (10.97.5.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 12:00:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Mar 2022 04:00:29 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Mar 2022 04:00:29 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=47618 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nRuzV-0008Ca-Be; Wed, 09 Mar 2022 04:00:29 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v3 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Wed, 9 Mar 2022 17:30:23 +0530
Message-ID: <20220309120025.6721-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e6a699-0c3d-4789-2300-08da01c46b32
X-MS-TrafficTypeDiagnostic: SA2PR02MB7562:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB75629796DA7BA4FD8956CB60A50A9@SA2PR02MB7562.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONqyR3gRO8kjOf1mcofUOIxvPguKy9AkkfCrcLhgvHYRry08go++Cx+lD3BKEZH0vQn6AeNkdZkLM5aLtLfICYBrBnvqDTVzdKcA6S0UIod+LKnCMlHetUVne7lIj413qDbW0aYWKThY8tWfQ6NnPG2vScpoWwsbvMeno8WaAgcwGXL804ftCEqjsFQD5K1CD3YpUrY+u4UtHETvdydoSZEKWzLMXiusNUm/AMTcBL993UqPw/G7BY2A5xIZZ5VbO1nEXYnSps8xV03KZwPzUXWFEIfYAzETUrYbXhqlkY855l6OafVdzoCmesQBa7RAknpZj2322fhrHoP3bDPhPars3Dbsfm+If5BLeSgShhyj+kaXjl8tQUlFosjPRxUpQCKQwIED8gi/QXqIadR5iuWLmikvQcQlNR/SCJIpTPNdy+9NQDS8eqCCpb96b7By7x+aHQ0uaiwD5CsyKXhJY7q5g9JAbWdmfM3Psbq7MpIsjRUrhpb2zW4aT0B0+cWmzHvtxlUSy71t5nwTHIlUsk+fZDCnzaoCvWAa6tisOnxszosP/KJ0x8uELVD9GCXZg6cn/PWu0r0CvBsuhqa5+yoq0P7uPVBFKr4N8SFsTc48kPLP70Ruj1flvLphyDwQ7insrOOdgU6cCUIxCl601cVWobgysonomTUvOkF9zxmBFjfgeDvQPPvYO4UlimmsH4rcV+ayRJ8EpwJvxcNzuA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(70206006)(36756003)(83380400001)(40460700003)(103116003)(5660300002)(82310400004)(70586007)(4326008)(9786002)(4744005)(2906002)(110136005)(316002)(54906003)(8936002)(6666004)(7696005)(426003)(26005)(2616005)(186003)(107886003)(336012)(1076003)(7636003)(356005)(47076005)(36860700001)(508600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:00:34.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e6a699-0c3d-4789-2300-08da01c46b32
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7562
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

Changes in v3:
- consistency in is_cpm5 flag check expression.

Bharat Kumar Gogada (2):
  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port

 .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
 drivers/pci/controller/pcie-xilinx-cpm.c      | 33 ++++++++++++-
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.17.1

