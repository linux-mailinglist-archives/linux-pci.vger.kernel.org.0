Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5591D14DE9E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 17:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgA3QNJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 11:13:09 -0500
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:22593
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbgA3QNJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 11:13:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfxwuOLCvLlHkx8/Q+nkblnCKd3VxNmZTWuGfMQR2mK1AWnlGdmtSbeVeS1DymCKUgQkNzQB7take47899zKBFa9mA/eJpwuOJwf6pvKXpv22Ywy/N6+bByxpezxWmsuIZL4IklzDeKpOQjIty0losDRaBQJMDRu117ss8ze0av5D6FE+lJNN/SuVkEG3LXFWntzxv21KL759uweAEpOIhICkfo3eAiidQMcirZu7Gh6O1reEXfVUs4ys7mTUBt+TbjOl2fzgPLkEGQigyP0VJ+eVEMzK58i3E9HhBxhBfVMBOfISt/7WfFanc0/FJPTp10rZVfKF77WNebE0eixnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WgPAW32fRAoZ45fqMF04GO8JjVFiG0m/59s21sCczk=;
 b=d/ZCpwvbVROxsOL+oznFXe2W1FrrXkvFhLvZHid3657yaykfju+GEvN9LIOw7LsZn8AiQgSK0I7n1JMlwBacu0hvjSohSgZJUXRr44kSlvTZChZMMjzETvtfI8tMG1BL5HRjYFKxyX70IObkKdKmGquj2pbjiKx6u2/RL3uA4nnrAGBgp/FBJ+bqBwVJyaY/2wtaEn4X1u0IgMyEpEup5kWF/noQfLDVAw3S2SwbUJ7wSvUOLIiYQ3j86vLI1LtJLL5B3wwUX1g9b21k39eQQ8QXADNg2WK0FZ3uTTpuJNKWFryjEzTXiXeMpA+jvAyJz8YYF73cD2/T2jDF52Nysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WgPAW32fRAoZ45fqMF04GO8JjVFiG0m/59s21sCczk=;
 b=WIGETeAXK/D6WVhRd9W2+dohhxQ46TadvHdASXpiZUNFjaUMeVT6+k+lTZJNwC3+q+6Roc5/7eP8EcQGYKt11p7phWpoaZjIyWK8OdVqZ6x/K3UeJ7/mqUmwKm9apI8jm3x8oTkD5JIUgrDoGFAu9kil5du8icm4DFLcsrKhwJY=
Received: from BL0PR02CA0031.namprd02.prod.outlook.com (2603:10b6:207:3c::44)
 by BN7PR02MB5345.namprd02.prod.outlook.com (2603:10b6:408:28::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Thu, 30 Jan
 2020 16:13:06 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BL0PR02CA0031.outlook.office365.com
 (2603:10b6:207:3c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Thu, 30 Jan 2020 16:13:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Thu, 30 Jan 2020 16:13:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1ixCRF-000289-H5; Thu, 30 Jan 2020 08:13:05 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1ixCRA-0005mf-Eh; Thu, 30 Jan 2020 08:13:00 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1ixCR9-0005mP-4F; Thu, 30 Jan 2020 08:12:59 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 0/2] Adding support for Versal CPM as Root Port driver
Date:   Thu, 30 Jan 2020 21:42:49 +0530
Message-Id: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(199004)(189003)(2616005)(426003)(70206006)(4326008)(8676002)(70586007)(336012)(9786002)(356004)(6666004)(2906002)(81166006)(81156014)(4744005)(5660300002)(8936002)(7696005)(498600001)(36756003)(186003)(26005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5345;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62968fe-0bb1-441e-ed43-08d7a59f4a46
X-MS-TrafficTypeDiagnostic: BN7PR02MB5345:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5345FBA0F8E94C9A2A6CAF51A5040@BN7PR02MB5345.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 02981BE340
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tLpXR3CvZH6FAw70oonvHkpxofWo5IdSGPWeYlKIQPlBXY8FuQF3FOYBV53sqIybuTXEbATyD3HZ9TcFWeM+iQ2E9n/WfoJHcp/vHFZ7MomZLYmr74eyy24AK+TaPNZJLD2q/eWLlh+WOSO+PmjXFhgXXLXXrRaoj/DzNWNOCsrBw24UvcP9aU7Xj+fz7mqqd5+a2YmVadbGf7D+qsDAebDYa8vSlL5dzbj3HHVBqzOeBbf6yvch4KpTPl94zyFekIrSZwSc/y9KSyTyKnQdGhkT3lrENSckGEu8eOBipQzZnZr7SdSEqe9KkHtC7jlGCsdORrHM9rSXaOZqba/AdnC46oSwkEjHbNbTtROd0I83zOJqeEBAS7C3bVmndnqwULFC+7pq5MueVEFbGr9jIgXIX1TjkU1xjwJ1cX2mSyFmdV5fM6DOtZAEUq6s8Yr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 16:13:05.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62968fe-0bb1-441e-ed43-08d7a59f4a46
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5345
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
  PCI: xilinx-cpm: Add device tree binding for Versal CPM host bridge
  PCI: xilinx-cpm: Add Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.txt  |  66 +++
 drivers/pci/controller/Kconfig                     |   8 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 491 +++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

