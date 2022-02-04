Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9684A99AE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348794AbiBDNGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 08:06:12 -0500
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:6753
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348009AbiBDNGL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 08:06:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQQ+5p4Txp67tE2OnQCwe0sXTrnztrvzKVQlikg1fAD7DGjelw26KXufl0rAHWrxLibb7WJIrYO+bL/faey1CwaJ6GxqfUfqQtfronVcQFrJx6JOVqG0hEH5JmdDaQ3I1xLmSSsjrh9KInbfH+5kgg+oueZI+9p7SoUTPuHYfkzyC9wdvHVKajES+xP000nGk/ViZwXcs8JPBaudAps4Jur6lNXF66/FcsvNcHXZx6BD0vNCIgAVmkir/ri/wlDa3ZjHULHkgdoGZkYVeQwtjVjYBjjJ7pGFyDlBN07ET5aJzutQm8w49Z4Ppwhilb2P0yDpEwVHDPHiBrwo51iDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svqj+OXpJNEBSKlWzrxDj/rz1V7xMHE3HSuZeNhhZmY=;
 b=Be/uCAb3skbf2BNZLkXj1RnrEWo0C5Yk4XRqII1NmXJFzDW+cJ9/fo2WfvQtk7hUSMT+Omxhd+bXDdSVpj7+JhYU1UcU3dfp4kNLZKxsdPFuYJnqO4l/KnCSTmauIqbvhvqWRp35Tb+7HUDh5wxb71Ms5SbQ9m2EM0cEf9Seeljb1VTvjYrOzya/lfYbRJjG/c/CGIOFXnudRgQT1BluyEJXtQHV/pnFYtV1lRoeRngDClGWs//ZMSv3eCc4rVq4XLcZA1QgXPUIm4hca7jKQDKpEkUo1sMduzfTcrVNHxzJl9QWWTudi9xgmuN6vU9n/IDAHdFDz1TbBqe3g4VEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svqj+OXpJNEBSKlWzrxDj/rz1V7xMHE3HSuZeNhhZmY=;
 b=cRXGtm5xpoiznJCTlRzVdhtxhIi+MTxngoi8laGeSUnWVIvitT3RYKnR7L0wy5EIZ5RZZqBK/2GzR4jeCOmFwnYvTIzV7j6+qYDNlpu5+ManP62usdk7Y0ZIZvCP6RmqJ4nYRi0Y4jMqb69/9ULAL3TRmhPRoAP3SgcCLuCyIBo=
Received: from BN6PR14CA0033.namprd14.prod.outlook.com (2603:10b6:404:13f::19)
 by BYAPR02MB5718.namprd02.prod.outlook.com (2603:10b6:a03:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 13:06:08 +0000
Received: from BN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::84) by BN6PR14CA0033.outlook.office365.com
 (2603:10b6:404:13f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 13:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT043.mail.protection.outlook.com (10.13.2.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 13:06:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Feb 2022 05:05:54 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Feb 2022 05:05:54 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=44286 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nFyEG-000Bmk-Mm; Fri, 04 Feb 2022 05:02:21 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Fri, 4 Feb 2022 18:32:14 +0530
Message-ID: <20220204130216.2206-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6426eab6-8e16-4310-cb1a-08d9e7df1b68
X-MS-TrafficTypeDiagnostic: BYAPR02MB5718:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB571800A3E7B07AFA3405C772A5299@BYAPR02MB5718.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhof6dphPfTDyZPS7Oe6QwB40SOCsKeYZS8W0tZS1mgoVBxduEADRucCy9wcZM22si8HFySMpsBIQwfR1IzvfPiYVM1epLCwdahG+5oUklyuTiocIFRukc6F0pskh3h3QGUHXZ5A5cM9P1v4l/CW3z5hfi4KYRATyR9e08iJcK+M4ei+cHqFMiWcUr8U4NpHmEuzldKJyQAHbAL9C0/fc3Dlr4MsDOxjhkGZqCN+20qQhA5eTA7I5qCtsqmGQ9lzMUjciCYOYbrE4gIK/7SXs/sN/WU/ZXYkdseI9ZnzJ+Nkg8TkxvebjHR2zKQNE52oK+1ZhN82wv+tJ+A/Qz8h8fVyuRUSD/EqVtuiHxn0lFs4XWEFgkvxUtzIuXqLl2yuz/O59XtvKVyUAoHQDjlZtB3tqUcuqZhFmecBhS8EGFdQP5PzeCzZYpPf4iIoszgB0W4pnSkyo7vpcPg2MzQlQG+9cET14KymLsvE+YySiWBSZlNiLxGtiSZRACkQ6OieJnruYEKVQrhGcX6zPgdjWkBE1+QZG6SfeX5J8doDre4x2VVPcNOT8qYdazY0iGkWyYY5v3reE2COB2mxkuevQSkF51fca7o7I/avqVK1QKhs1MX5e8xlbpGrz/bqjXV+8QFZRtz4IqGT4BiLlHQNmEaZzoXT69/Lsyi7n/xdF8jBaM+0xTq5GKCFni5wIdPY
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(47076005)(9786002)(508600001)(4326008)(8936002)(2906002)(83380400001)(107886003)(7636003)(8676002)(82310400004)(336012)(1076003)(426003)(2616005)(186003)(26005)(356005)(7696005)(6666004)(36756003)(5660300002)(103116003)(70586007)(110136005)(36860700001)(54906003)(70206006)(316002)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 13:06:07.1805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6426eab6-8e16-4310-cb1a-08d9e7df1b68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5718
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root port
functioning at Gen5 speed.
Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additonal register bit
  to enable and handle legacy interrupts.

Bharat Kumar Gogada (2):
  PCI: xilinx-cpm: Update YAML schemas for Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port driver

 .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
 drivers/pci/controller/pcie-xilinx-cpm.c      | 33 ++++++++++++-
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.17.1

