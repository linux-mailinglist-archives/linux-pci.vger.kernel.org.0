Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8E212F7EF
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgACMEg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 07:04:36 -0500
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:6129
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbgACMEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jan 2020 07:04:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqe8RV0y8XRthwRJqDWDLLCMVwlsNivt3ZNmryPMwq0FuCHfjxehc0VGjUFlEnHL3Z+eguTHpD09Mb5y+UV1eVc8zLIiuCgIxrhAIODtnWXtmrC5sz5RWtCMLdYXQRyM0gOOTQHGp5jtS4E12w6nCm91go6uIpSQ1qSVhfEdcIfP0op/RIwdFAVaiLmZffw9Xg5XTIm9aCdk4BgrcpWrxVlr372rbWybC0V3gqqRryljm8nSc0hD6TiXLO7ts21pxkIbaL9uh+BdwnQGAM8GIjl5nRAHSrCbb/zCTuj7IT3EMD2M0CO4UBGmxfWJKr3oigPp/gtxuF9GOF7L24O9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5zHngbkWyYuY1iUrN1UUCLewEbJc3dtlVWzTQj+3N8=;
 b=Ufw0HkWqmxcGz3TfvgSSndwsph58rS0djDOCwGWP1rYj5x+GGY2EC+c4s9+jrgoc1QXXrjJvKU2gTP9XhJjVZpc/sY+3J75OT9L0N3hRs3j8sA1vYutcfGzu8JB2RiMI4RCREwvfrvKfK/XEVVh85wkb36AGFvvBLDzc6OeSQ6ADseNtmNI6TensV9Kg+YPbJlzfRgLg7l0/v+0S0Q4UEpFjd1Gd1TOhoXEROnfLfZ/Q2QbiI/PeI3IdQ/RYj25XUngpBA30ILMDklnmB1PFM9egbm92B9+1B51t/JttY3IB66Mq+k5DgM2JUfEamhNk5VJE539ou5+N6Y8B+LQ0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5zHngbkWyYuY1iUrN1UUCLewEbJc3dtlVWzTQj+3N8=;
 b=RDarOqZ3dM1W/ei/ZW6ohjAwXimp+Q6Ye75aj17JtzAGZboUbuXbX/5qXTNH/c95Z8YNwiFT9zPsGYD5+PdyKZ+pWBIhkVjUeO+KU65dFEcwoC7b53BQXlOPk1NZkHuBdzN5bnRUDLxfXx8GViuZRaz41cc/yustomUXpvlMfM8=
Received: from BYAPR02CA0041.namprd02.prod.outlook.com (2603:10b6:a03:54::18)
 by MN2PR02MB6144.namprd02.prod.outlook.com (2603:10b6:208:182::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10; Fri, 3 Jan
 2020 12:04:33 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BYAPR02CA0041.outlook.office365.com
 (2603:10b6:a03:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend
 Transport; Fri, 3 Jan 2020 12:04:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Fri, 3 Jan 2020 12:04:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLgu-0000JX-8w; Fri, 03 Jan 2020 04:04:32 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLgp-0007o9-5T; Fri, 03 Jan 2020 04:04:27 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1inLgn-0007nw-Pr; Fri, 03 Jan 2020 04:04:26 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 0/2] Adding support for Versal CPM as Root Port driver.
Date:   Fri,  3 Jan 2020 17:34:20 +0530
Message-Id: <1578053062-391-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(356004)(316002)(7696005)(336012)(9786002)(4326008)(107886003)(478600001)(2616005)(81156014)(426003)(6666004)(81166006)(2906002)(8676002)(5660300002)(36756003)(26005)(70586007)(8936002)(4744005)(70206006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6144;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d6f6378-04e3-4abf-ece8-08d79045182e
X-MS-TrafficTypeDiagnostic: MN2PR02MB6144:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6144E40363E28764DF6D5270A5230@MN2PR02MB6144.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xEgXbsDu0EnY2YSL4wntp2ovI9rtrG41Uf226soa2GT5vDGPvVdORud4i/kSkL+G3AqOBikKPW57ByzqABcbTjqbzRcnS6TZs85IkTSwUANtqvQ2p3LXykN1INnPmOdG2SQ+mIuKktthJEHNWmZCgWB6HVWzSK5UKYO9fjBZx6eS0jfrsaZvAv2XEMAFbMG7r37sEQ93D2lw+Cy8mvBT6gwcgWmaHxoLcNdIGpF/IpDHwm5sl4AuaMqb24A7s7cU8P+00uJhAiqZGxnQxlYirbPrFCP+NmsIBt01MjnEAQ4y1gdU6quy+PCLd6gWYCi7Ag9sb53nGCAS9pLekheyOWvxRZlZmDHL7IVsmcpsZseAQrSyIZicYBXBlLnEL50Lxf0MGjDDzqfbukJo/pJ98aRn3X4zDrxXIIcP2qy7t3K8rft6jWroaW4mlOudT5DI
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 12:04:32.7795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6f6378-04e3-4abf-ece8-08d79045182e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6144
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

Bharat Kumar Gogada (2):
  PCI: Versal CPM: Add device tree binding for Versal CPM host
    controller
  PCI: Versal CPM: Add support for Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.txt  |  66 +++
 drivers/pci/controller/Kconfig                     |   8 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 505 +++++++++++++++++++++
 4 files changed, 580 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

