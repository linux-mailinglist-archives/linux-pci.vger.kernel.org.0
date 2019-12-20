Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD8127A1F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 12:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLTLlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 06:41:36 -0500
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:6934
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727191AbfLTLlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 06:41:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkQdgF57NpciJ42Hstgstfps754/670MTDL4VjCyVqbBlXN3y3PrPcIWOacEqgN3xMB9J6uxS1pJ+ZZ0jWt2ZdJ40DOuA2qBYhYzYHkTZK1hDdsKJ3dZl3e25rQ5JGQMB89LqJ8VhXTjGIfzlLdY71lp7fVkvgNZPwfQl0mfMy5SuYbei3qxcDCxvlaOpsrdGtgHwNZ99S7KvaDY50EPN3eBVl5/FyPjCHCgyUk0737uBz9rth3sAkV2+dgHOQ3AeWWPVI5ixerpnYy2hz6fznOQwMeGk+FgwpwMAUqRqBDq3b/K7JwppJdtsfbyDag8ML+rURZAyGuo+hXLJTI8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m+bRm661WkXn0+cmEpzLTLtBRXIHj3hYIIqOOhGk/M=;
 b=HqXyAd9TKIdPvtEgMpFGavFxGPpH3ut6JYddpcq/XNMVKh24vyjv4Xm62qkfVH8mVxNDMQjEIqHf5bpM+RM5x7MPulY0td0Q87u1eKAryyGVvZUZlPxKTRiW01Xasv7/wr8uAIG57NTPGYsnGJGDkKss+zea6rDGlo3K6ZZZtlcVb9v3KDuUcMvzM6VVsBqu6fGOC7JES8VDIGTEDrZv39ngL9nh0OwEYVkB1pdHs+9BDILWVGfUO2LC0UbrLeOB2fx3iPNTq8FaXm6yZulw0oQUFy4oQ1fmkEBj9rSXwB7cVHuUYmOW/GeaWC4c4UybPhr7Y/AwinUyLPuvLWjePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m+bRm661WkXn0+cmEpzLTLtBRXIHj3hYIIqOOhGk/M=;
 b=klB2/u4wfvZE1k+6cp9Ujj1CNVBs/uANd/xlmSX0OiLx8AqG3BadBQMyjbcO2rcM+hGockZIJ6e9Uea0ODgoYL54BqqZnzWqQ9TJZNuEoMFMurLTWiwH3KrjdmTm1rRLffxq2HoXp7/5oWxwd42YYU4V0Pjzhj5pgJGrD/byQDE=
Received: from BN6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:404:5f::27)
 by SN4PR0201MB3517.namprd02.prod.outlook.com (2603:10b6:803:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Fri, 20 Dec
 2019 11:41:32 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR02CA0041.outlook.office365.com
 (2603:10b6:404:5f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Fri, 20 Dec 2019 11:41:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Fri, 20 Dec 2019 11:41:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGex-0001Hg-P1; Fri, 20 Dec 2019 03:41:31 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGes-0006Ne-Lt; Fri, 20 Dec 2019 03:41:26 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBKBfHfe001558;
        Fri, 20 Dec 2019 03:41:17 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iiGei-0006LD-PT; Fri, 20 Dec 2019 03:41:17 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 0/2] Adding support for versal CPM as Root Port driver.
Date:   Fri, 20 Dec 2019 17:11:10 +0530
Message-Id: <1576842072-32027-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(26005)(186003)(107886003)(2616005)(316002)(336012)(5660300002)(8936002)(4744005)(426003)(478600001)(9786002)(36756003)(81156014)(81166006)(8676002)(356004)(6666004)(4326008)(2906002)(7696005)(70206006)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3517;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b266627e-ebb8-4df3-4760-08d785418f92
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3517:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3517F65E6CD30517D0228925A52D0@SN4PR0201MB3517.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 025796F161
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3dCzOQYm7tqVc5A9tmB8o+UDZzjK2fwq/RxU2irzU+qTosKZ2jQbNYg15H+dAlE03yrBClGrkn0phceWKAH+hy74ZiqZ0NW1ly3xV1wJFcFts3wQtSCSXoqrHUvGFU2ZVuivOI4pjaXw+xb7qSn/ucYGR6BoA0L2BE1EXrjdm3RQkraeUuamB9LW2wNFVjwlL4KdpnUbwOvLJ3qV5P/gU+UzcmJktcXUr7+eq+8Te6Rd02hAr7qxlHKG4OejOGZQVTSFUaW1bjAA9bFmDt2Y+wpQqzG5rZRHRGj6SF+IqDqPxvzVKYaIP4wphMPQHX5vV3kk7YFb/dqemquIgIXwzaSfNUI0G9QasUm6il3Y4ul+oNztAsNdKQxg2i5lxOpm1PQmhDWetLpAxpSK0AacZP3EDFgacADCzBXWU61KKVl1bcMDP1/WojsBrxTIgUq
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 11:41:32.3030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b266627e-ebb8-4df3-4760-08d785418f92
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3517
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Adding support for versal CPM as Root port.
- The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
  block for CPM along with the integrated bridge can function
  as PCIe Root Port.
- Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
  vectors and handling MSI/MSI-X interrupts.
- Bridge error and legacy interrupts in versal CPM are handled using
  versal CPM specific MISC interrupt line.

Bharat Kumar Gogada (2):
  PCI: Versal CPM: Add device tree binding forversal CPM host controller
  PCI: Versal CPM: Add support for Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.txt  |  66 +++
 drivers/pci/controller/Kconfig                     |   8 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 511 +++++++++++++++++++++
 4 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

