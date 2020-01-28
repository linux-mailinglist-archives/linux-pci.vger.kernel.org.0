Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA19C14B466
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 13:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgA1MpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 07:45:09 -0500
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:6167
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgA1MpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 07:45:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+3tMCf99v/wXsSvzPwtkQlhbJQyqi1cqv2ChV9jVv9BhUpPufBlnXJ7T598fZcBwLwPs8jOPQ6ejzQv5kbDBAakrahrparzDJs28VS2+rwfhz4X36mP7W3BiIOACxvBNnhlr5ZYhw6XYfNSVx8jx81wzfmlAM+Qcti78bh84k3Wbi8JI8QFLOLcCUHZ9LlySOQldnhRM+Z+3LnTrt+oo/aivAEgi3UeoBbIFHbILgEU1ZZAl5F7Spd7X2tei/Ex9wLl6Jog/p3RzkHNxw+cG2FGiSpXuNNYqQ9IH+AaF68+eCzJy3CHqP28dSSDXbRSOctelMoeOcgEMvrA5hkfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=422ZksD2qtj8kZOJfFkot1HYa1vrDLwdrBy81V30CU0=;
 b=g/X7nCR6CdNjGvrhQtKc+Y6WAwy04wmzCZ1IHYJWae9u4VUrdmxxqWR/BEprpfArisVDS4RYBmXIijbUJQNy6bVgeHgP11ks24vyGWBDZC8vWGqtpA/iqEBusWgZtgHhASEB3sop6xbGAfx4U9y+mmurAaAgFn+HV5Puf7+SpovtUV1hTl2Ewhx5ZUn7Y9pj4IBKCBUbyTT6SqLOnSqSjbi72Qadib1nlxo8CtXizBjVy5NnFfgWAdtVE9lmRzk19QexUiGdPtkSQ5CG+FN2kqu2GiZY+r01Ce0kfXytT852735MOimxmbw697gsaEJ+S1/79R/oo5GRfB3nImYA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=422ZksD2qtj8kZOJfFkot1HYa1vrDLwdrBy81V30CU0=;
 b=Kd7apfQLEc4NnAKYTS+W8XTQbOoWQiQ2vbAN8dGVt+sZEfVsdZI0alFjIehSH3cekpNlInWFWRuBRgNqyl8gdGbO8C95AlsETqX3ts46LJGbFUW+yDSJpac9z6Rv/Fxt1knqm1hI/xCiq4NWSD5XuWUTAP/VrX6392bVKVJudWU=
Received: from MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31)
 by BN8PR02MB5954.namprd02.prod.outlook.com (2603:10b6:408:bb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Tue, 28 Jan
 2020 12:45:05 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MN2PR02CA0018.outlook.office365.com
 (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Tue, 28 Jan 2020 12:45:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2665.18
 via Frontend Transport; Tue, 28 Jan 2020 12:45:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEq-0007b8-Mh; Tue, 28 Jan 2020 04:45:04 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEl-0006rI-Iz; Tue, 28 Jan 2020 04:44:59 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00SCiphB016792;
        Tue, 28 Jan 2020 04:44:51 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iwQEd-0006pq-0k; Tue, 28 Jan 2020 04:44:51 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v4 0/2] Adding support for Versal CPM as Root Port driver.
Date:   Tue, 28 Jan 2020 18:14:41 +0530
Message-Id: <1580215483-8835-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(6666004)(2906002)(356004)(8676002)(4744005)(7696005)(186003)(36756003)(26005)(426003)(2616005)(336012)(107886003)(4326008)(316002)(81156014)(81166006)(70586007)(5660300002)(9786002)(478600001)(8936002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5954;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a82f6a-a205-480d-ebbe-08d7a3efe64f
X-MS-TrafficTypeDiagnostic: BN8PR02MB5954:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5954B0528B501797D4C2ED1FA50A0@BN8PR02MB5954.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 029651C7A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWhvAF3hrksp0LpriNrNHRJHGedAA5qnBVNAdiugGRwWty/XNwSNltBTbuBW/SvY+5QmI3p5b+u2BnFr6/Oq5RurRxcAHIItzvxlr8McZs71i8HUCGnoKvXk8qFPgDBvJG/xR2cLq0BfxuoQBx+8H9YZRXjtxHindj+HtJGpy/8/n+Shwvat0F1+I0s5MnQFU9mTJX8A+IvEKaMjf+HySwNM49j9pGsd2VNAGAv0TseNMhrR9cGY5sKwQRWNnYmF0lDa5Amboy3zVpcYbeSUuSPO9Sm3XYteYJQtaUG4HVD29/JQ/kdjSQ7PPF5Ijz5+Yzy0aYGGi7YuVYKlf9gL2jbsW+7kMJZbyRVUmOrEw7w7l5Va5GzbItkiZz4YpD6qtZno2Wba7bOSBb2lnHL3tQ5Hl02dyFDqHZzMnWRT+h7kmyVNvVUDa8zPUrEsV+kd
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 12:45:05.1442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a82f6a-a205-480d-ebbe-08d7a3efe64f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5954
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Add support for Versal CPM as Root port.
- The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
  block for CPM along with the integrated bridge can function
  as PCIe Root Port.
- Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
  vectors and handling MSI/MSI-X interrupts.
- Bridge error and legacy interrupts in Versal CPM are handled using
  Versal CPM specific MISC interrupt line.

Bharat Kumar Gogada (2):
  PCI: xilinx-cpm: Add device tree binding for Versal CPM host bridge.
  PCI: xilinx-cpm: Add Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.txt  |  66 +++
 drivers/pci/controller/Kconfig                     |   8 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 506 +++++++++++++++++++++
 4 files changed, 581 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

