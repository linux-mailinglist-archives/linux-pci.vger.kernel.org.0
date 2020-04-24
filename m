Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89E1B7390
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 14:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgDXMEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 08:04:25 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:6147
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbgDXMEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 08:04:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcMyqEozX0sghNaoqdZiAFZPLY8jGotDz2anw31vAdg2G4ylSqDibAqBYBEC4mw9sWkdOBrj+uCx0EnlvtsL8jNu134pxFyL94eCHwXjzHLRxwUYjucWsLiR2+NC403TRaouQPg8gJRcclrLQ1koIq8kku5Dvv6b1MPZ1rsnnZBccf1h2lg58gORv2puFtlPVDn2I8rVDRaiaHg0MIFsnmK9mowS700RcF5/cM0/yKDmGE8EliqLtPScqxbG2E8x+pP3agxPTJLCyuVlHADUBQmNrcF/bL0xb6NBe/0eABNdW/EKa++fB0Blbc6SVrDYjIjnyo1Qhu2QT0Pq5AEWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFjOSfs1PZmaCTHKx0oZjMpmacFCa7kXcMmDl8zA0Jk=;
 b=YuyupxTcSKI8wbFOnwE0689DE+EakYhq67P+0slmiTIgQ0OhNpqhck12aXzhIpMZfFeT/KJHu18+aBGwSRabFbzaMnP8CMHAYM46C5pQsrdCJ3bop1toFSPUNC99g79wxU0K3WvQoHYIOAXWD+hgasg357+x6jZ8oF7GCyFlPbA/YkORl0hz6CM4YPA2LY70JwWQvxFT0nmb/JBmtlNyutuB6Htm/QKEE70dTALLAw9djA4XYf119zbT0bDgw29n18nBBPG/FK0QDIIzi3XOGoXaNXLCJmf4Trnb20sf4cnj8sgYxRWCZ/+vDxIQzzROBxD+YwKRtMjPm/ESACmVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFjOSfs1PZmaCTHKx0oZjMpmacFCa7kXcMmDl8zA0Jk=;
 b=kNkQS/INPi/bELz+BaxrOrOSitqgQe5X0AE06jJnSTr0tVRpSUmXslmSI2B+ZI326J0BrzvzY6V7GVwq9ln1r3R25Kup/s75zsYNW+dukxbalqOP2CPM/+7AJYOBrGWZePeTgVO+pjSdAb++h2Zdximul6XvxIEp8uN15/ZSNAI=
Received: from CY4PR04CA0044.namprd04.prod.outlook.com (2603:10b6:903:c6::30)
 by CH2PR02MB6391.namprd02.prod.outlook.com (2603:10b6:610:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.30; Fri, 24 Apr
 2020 12:04:21 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:c6:cafe::68) by CY4PR04CA0044.outlook.office365.com
 (2603:10b6:903:c6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 12:04:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 12:04:20
 +0000
Received: from [149.199.38.66] (port=50988 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jRx30-0004Sk-Fs; Fri, 24 Apr 2020 05:03:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jRx48-0000zU-Bj; Fri, 24 Apr 2020 05:04:20 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OC4EWd027881;
        Fri, 24 Apr 2020 05:04:14 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jRx41-0000yh-HY; Fri, 24 Apr 2020 05:04:14 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v6 0/2] Adding support for Versal CPM as Root Port driver
Date:   Fri, 24 Apr 2020 17:34:02 +0530
Message-Id: <1587729844-20798-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966005)(336012)(7696005)(107886003)(70206006)(26005)(9786002)(4326008)(2616005)(186003)(70586007)(426003)(81166007)(6666004)(47076004)(316002)(81156014)(478600001)(2906002)(5660300002)(356005)(82740400003)(82310400002)(36756003)(8936002)(8676002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f4b6b84-a5c2-4bfe-bc07-08d7e8479f20
X-MS-TrafficTypeDiagnostic: CH2PR02MB6391:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR02MB6391E854404AF07AB276ED0EA5D00@CH2PR02MB6391.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBv/LAaElXR7qA4gI9KfrhEh1rBB21AqBznDeNZL1T951/xnCYa5ngTSMbCqSmNoRx5Y10RdqkZCHZXNezCMwsTYVZt1hVkU4d2o9rzFpfS9PtvLDDYt6XsVVcZnhPZJrxbI+WXDdwr+QGz5SCxs8lram7j2pzlQMNj6ugsZWXsMUMlHMCuKFZOCtNqP2sPw8VkkQndiJ0+FlIRjytYoYqNlmkCXbIPX6otIgKpB+e2Dlaaes2+t7qbV9n3g6aC/bCCf9urskysv0pYGg0rq05+nJBn4UEZUmKzeDPtm+YS2PbVTOmydZjjDu6uodtih4z1NF3eAdUxcJZozHjoOvb5sQePocXkO+uhaaNeF+HP2jIYVGp70GWiCWyDc7GfSTL/MyGqFUGOXuBxl/vXw6Qpzf22OhCDiWHLiTFlvAT50kHP9MBSOO3xb68j5m8spcfeSWxCNbadPLbbhV5U+ue5DHNi5y3+HTPKX4Un5wQ8GgncHeyXYfs72dbtWjFk7NDGpsmSLoQ4yAEYvb9yZlA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 12:04:20.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4b6b84-a5c2-4bfe-bc07-08d7e8479f20
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6391
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
  Versal CPM specific MISC interrupt line.

Changes for v6:
- Using pci_generic_ecam_ops for ECAM registration.
- Fixed INTX registration handling

Bharat Kumar Gogada (2):
  PCI: xilinx-cpm: Add device tree binding for Versal CPM Root Port
  PCI: xilinx-cpm: Add Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.txt  |  68 +++
 drivers/pci/controller/Kconfig                     |   9 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 521 +++++++++++++++++++++
 4 files changed, 599 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

