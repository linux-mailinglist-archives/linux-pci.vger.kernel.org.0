Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E7C138E7B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgAMKEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 05:04:06 -0500
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:28096
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbgAMKEG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 05:04:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkOLIccrA8RgGRvHrU6/6DUCFcGqk3tm210UWGPrQyOtJ2cAuRgwIwTr6iM5Cltopq3EVa71IAD1S+bJhZlwI1u6CVIiWpKm5LldnNYw7ARtme5W2XWXaUzztAyQRdkiBBufVvxp3wlHLQbbEZULRpAPsi28Zu1hiwHSTwwG2X34yAS3e8duWL8WhkPfYr+92hoR8e0zUMYjTEbAimzyQBqc8TL6MIZ3lilSAr93C6P1SGhsY8RhCVSdG9OgAcnhbQiUwaQ/KEVi+78by8NyXhptXEah95oQL07wFBbOg1ZU46D3JdYdA9khPfoSdd1k43FNnbYHN+YWFh9t0uONUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5zHngbkWyYuY1iUrN1UUCLewEbJc3dtlVWzTQj+3N8=;
 b=G/ETSQ39s2ImUQ0ftXTrtcU1dQWba7BTrW764e3tLK5ciKLmPUqqDLNQ1AU99NVT6RaBPK8EKgAfP8poW/83tAvFCGV/gAaAR3h5YMLd866IcHVMd+xunKLNfTImi0ylE9p77AIoHRRyjF6McHxE8POcZ2jxHzaKSJVbdj1d0w2T5+HZTAotSWr6wA3Wg7gwZa9HY7Hr1i5biYMSgFEbACDnyKoPhC/4qER8GopzOI6zACqtv9cquowG5xHWg/yyZQmaH+97P8g6nTXVgNRvTehZwYaSX8lfersFi1yynafFzpSscav9L9KBm/zImLZzr7iwycQ/NYp/mp6o1xUwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5zHngbkWyYuY1iUrN1UUCLewEbJc3dtlVWzTQj+3N8=;
 b=fFDbB+EzaxiEKvxRPuj8tRqNkx2dIamprFNlocCgHOMNDFpqAOuO7zDvwZqf07UWI3GrB7tL/78Z+jVsGVVdx88hAUYqTlXfmcv7b/3qftEJeLVGWQyphuIKHOr5RWYNw9OCRCFl+ssyIz0XNPnnNjka1vp6glLoTflITeI8Ouk=
Received: from BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47)
 by BYAPR02MB4101.namprd02.prod.outlook.com (2603:10b6:a02:f6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.15; Mon, 13 Jan
 2020 10:04:03 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BL0PR02CA0034.outlook.office365.com
 (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Mon, 13 Jan 2020 10:04:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 10:04:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iqwZm-0000Rv-C8; Mon, 13 Jan 2020 02:04:02 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iqwZg-0007Wa-Ur; Mon, 13 Jan 2020 02:03:57 -0800
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1iqwZe-0007VY-2j; Mon, 13 Jan 2020 02:03:54 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v3 0/2] Adding support for Versal CPM as Root Port driver.
Date:   Mon, 13 Jan 2020 15:33:39 +0530
Message-Id: <1578909821-10604-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(107886003)(36756003)(81156014)(81166006)(8676002)(316002)(426003)(8936002)(26005)(186003)(4326008)(478600001)(336012)(2616005)(9786002)(70586007)(4744005)(6666004)(356004)(70206006)(5660300002)(2906002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4101;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75ab98c8-5ad0-4638-2f1d-08d7980feae7
X-MS-TrafficTypeDiagnostic: BYAPR02MB4101:
X-Microsoft-Antispam-PRVS: <BYAPR02MB41015E14CDBD466150A9764BA5350@BYAPR02MB4101.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2YJxLYVdCRm4YNaSQrh7SQeQP4KXPIjcYbwo1tqSDh+cRTpsJja4EM5c3720flr2wXGXpOdPeXUDYMsmhlkRBVuZkUy2ppzlpbQWJjIrKs2pZGEVrlnx/XNJvue5PUjl2MIBgJrT2/dakSbq+kMzLMZ7YlqJPYkQOGvsRamN0lHeB2d+jlAQvothJkP/h1i4zFfYlusDoZ6N9BvVs1SlI+u3AGeQsC7qPkTfDX4RhNil0q1PDFMvKO6bzYP+Pia2p5jhgak++xe8CmY40vZSGTU1gFtUgcdWdSr4roiv4mB2j2OiI0hsMgHIAfn7ZGkaVjW/QYSVOpHMO8tCrp3PVGYdheLLha5nO7thd62FE211yRTKdivQj/s5Y4bBbm6zt7UTpLtTeo4S5jTA3SCPLwowBuDTOAyHLDZoKFoYOz1TGQAObYxtXDuwC7MSlMw
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 10:04:02.7524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ab98c8-5ad0-4638-2f1d-08d7980feae7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4101
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

