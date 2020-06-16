Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE591FB14F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgFPM5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 08:57:25 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:39616
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbgFPM5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 08:57:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3IK405vB+EDTIXSu7itysh8bY8P/KqBxx+Jidi6qBtG9cPfqiHYaAQESn33Ei+I/8f86/7mGDhNumt7m+K5xrBTPFsuSrQjSi7Zzg06YONcla99Fo5pCvN2XAh9nxvlj1CUqe/INrpYlaGMgPfajalwksajvjJeUGpJuR3NB8ra5WbfcnHj9mXU5eYlu3HT9ELjunBuTThZ2yU6yiNjisJ98iLE9ZDAfXdF5CHQTLKBrXgMF7HGk0ARSCXbZQeoAxJYinQCEL3xdEbn/rjcWgrGneqbVjvoY5Sm7EMtifrgd3wQ/bKjd5H4NDa1xE2QUbUkgBS1QfGOIcQBXPNnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZJqt47qMEpHojUviZ7JZIu3ZBMFjF8n6md8YzdOm6M=;
 b=CySZDGkChvtb1QA7zO97ZFaa1KK1sDBOpzXHP/+DLFV2DNSHOyg8JXRieMt5XCKCCsXbyhWS/5tp4qOFWxX8EsO88jhaX4X5secUIsSyuhQ14ZeojuxpBkUG3eBLfeli8rDOz28JIND50ACu4o5/XU9H5AoTd1+l+FWL5xIJZYOKZkHtGDWYaNyd5dsp/HR0+TVrzawduw1cWxO+KajYv1NGggfOWBo72Q3omA9jfyTTXJokWRviQwD9tMh2XxgM1Uh2ZvaMmftxe0Yb3RcBSj2l94KZT/PYXpIQOYWGqpee/Js4Ty2GzaXb6ZICaMwSx7boKUKeAMIkwOhBDgS8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZJqt47qMEpHojUviZ7JZIu3ZBMFjF8n6md8YzdOm6M=;
 b=Pb2BAT5A6tG+fuM9eFdMdqA3zOEOhTVeioN3n0N4yUXkOU3czy+EvlzzcgN1MgpfMdhlGyMb60wKM0Ri0sDQ8PxFvwbLXDuJFoGZLlzzpHvrE2dgnd2TqfBWNKJPwv7NppT0wZcLBUiE+GqP0iuoIbXDpV2JSW6XhdKTWTGFiEg=
Received: from MN2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:208:236::22)
 by BY5PR02MB6081.namprd02.prod.outlook.com (2603:10b6:a03:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 12:57:10 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:236:cafe::44) by MN2PR05CA0053.outlook.office365.com
 (2603:10b6:208:236::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.10 via Frontend
 Transport; Tue, 16 Jun 2020 12:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server id 15.20.3088.18 via Frontend Transport; Tue, 16 Jun 2020 12:57:10
 +0000
Received: from [149.199.38.66] (port=32775 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB8I-0000xa-LM; Tue, 16 Jun 2020 05:56:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB9J-0001rZ-No; Tue, 16 Jun 2020 05:57:09 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05GCv0vp029825;
        Tue, 16 Jun 2020 05:57:00 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jlB99-0001oA-OL; Tue, 16 Jun 2020 05:57:00 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        maz@kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v9 0/2]  Adding support for Versal CPM as Root Port driver
Date:   Tue, 16 Jun 2020 18:26:52 +0530
Message-Id: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(136003)(39860400002)(46966005)(70206006)(6666004)(82310400002)(70586007)(81166007)(5660300002)(4326008)(426003)(356005)(2616005)(9786002)(336012)(107886003)(36756003)(82740400003)(478600001)(2906002)(47076004)(186003)(26005)(8936002)(316002)(8676002)(83380400001)(7696005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1ba286f3-65dd-4550-2dfd-08d811f4c835
X-MS-TrafficTypeDiagnostic: BY5PR02MB6081:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR02MB6081806E69AB27EAA5379493A59D0@BY5PR02MB6081.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPVIcVbVW+Oqab/kiMJW5UsmddS/+u48PH5vO8s5Z9WgIVYCxZSUhDzgWuOg4YKWeBWCNX42fJ+/yuIM09B+pfzVkKlqeGXG3NMCca9/GolLluVRYthEpWryWhdtrTSeGiW/fkwkgoimj0bMWfmAklyvaDR8r4fIs+OXjlfjs6wtKdGx2dVOU6MocqL+ToCAvIUWRP4w2Wea/xOb8Ey2N9r62Ztd+eiiAjPzTzxZmh7vewgP9T4HN/49onkVzDsWIHZO30MNCokOyhtXV24zZaK4igdmDBiIQwej+1ZzdeBm4NHGeWV8C0tOKyndLRYSisnjWjXSUaN4cVPG0CH+GZreUiToNybRmuM9FbllqTIm98xxLlEauMzUwzsHWI0LLYGujKMk7Tlx/dGNi47uxQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 12:57:10.1466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba286f3-65dd-4550-2dfd-08d811f4c835
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6081
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Adding support for Versal CPM as Root port.
- The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
  block for CPM along with the integrated bridge can function
  as PCIe Root Port.
- Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
  vectors and handling MSI/MSI-X interrupts.
- Bridge error and legacy interrupts in Versal CPM are handled using
  Versal CPM specific interrupt line.

Changes for v9:
- Removed interrupt enablement outside irqchip flow as suggested
  by Marc.
- Removed using WARN_ON in if statement.

Bharat Kumar Gogada (2):
  PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
  PCI: xilinx-cpm: Add Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |  99 ++++
 drivers/pci/controller/Kconfig                     |   8 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 615 +++++++++++++++++++++
 4 files changed, 723 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

