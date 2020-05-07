Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58E1C8913
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEGL7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 07:59:44 -0400
Received: from mail-eopbgr750079.outbound.protection.outlook.com ([40.107.75.79]:29590
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbgEGL7n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 07:59:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4DQNQG8B/n5C/z1FW7+rE8RG78au61c+3ahZ6xq5aXkCU+PvMOahQTuRswFAV+kXXzXXao7ERHXYDge9pJWzd2ZvfUI301THkSf7F81TZhTqfxaJtP9qm8JO2d3p7xm9kQa50DSfXWt8xChunkBYKnI1aWKf4XoGJOp7IFLvHh1QwFCgThOdEP1PQlO/NOA9VnhxyjJNKkafBFkKKhUnVnm2LmlzNQqctfo1TpC10A9S4vnOG5T29jMxoB2V29w3WyfqqzWLcR2o7MQfJivT6vlTX8BS1FLUPgyS0f9oGwUkLY+M/PosjSfK9egocQmCo2z4C/Z1/yKNHfaDw6YrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip4pGvK3wOFNUxUA/CfLA8r2aqEcFAy61eQ3BEWSWOY=;
 b=NbEu0Bra6HYbfa6ilOe/UYMqvZZHwZGZj+AFJFtTsiT1CL5COQ9UWRkd3MSO1py1fT/2PF0AIPO+kueQ+xUryAvhJY4jRBt+o+6OCwm1M7w55m9zGMdtBJ6Cwynzmp0UuevyX6dC2wq++i0877jcU7GHZqjVZr0D7vXZYUsyRlpdYFNzxL1hGcUn/hMUAnuey5I97ZQXtN9NWnnKmgbu5uoYYv82ncYz5EEkWl02QEfdmgq3Ea7LJtTwiqZiXrFXCWZLVAoFLx8b5ur+z1dYICIcmj3NPH2OuzrZdFOyPv0Resod7jElHIl9jB6b8tZgdDBTJkTVi89WoOrbZBz4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip4pGvK3wOFNUxUA/CfLA8r2aqEcFAy61eQ3BEWSWOY=;
 b=hikBo6eXAAcVPBn+0+p8dbvq0n0Boy+KW38zvc0ltDW42dWLmqUtwxdpCPSbdn2fv4YJHF+kXqmodg7etxEGsfJp5CRFjGz5hzhSBAeokCXuF1QP30P1ZCXTrep4Ah19fNHKXQZCh/zLe6KGd0Bfbomqipvg0RZbg7pxndSq2Hk=
Received: from CY4PR2201CA0010.namprd22.prod.outlook.com
 (2603:10b6:910:5f::20) by BYAPR02MB4725.namprd02.prod.outlook.com
 (2603:10b6:a03:4e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 11:59:40 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5f:cafe::9a) by CY4PR2201CA0010.outlook.office365.com
 (2603:10b6:910:5f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Thu, 7 May 2020 11:59:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Thu, 7 May 2020 11:59:39
 +0000
Received: from [149.199.38.66] (port=60023 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBZ-0004yO-WE; Thu, 07 May 2020 04:59:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBj-00082j-Gk; Thu, 07 May 2020 04:59:39 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 047BxU5D028291;
        Thu, 7 May 2020 04:59:30 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jWfBZ-00081d-UD; Thu, 07 May 2020 04:59:30 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v7 0/2] Adding support for Versal CPM as Root Port driver
Date:   Thu,  7 May 2020 17:28:34 +0530
Message-Id: <1588852716-23132-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(39860400002)(376002)(46966005)(33430700001)(478600001)(5660300002)(8676002)(82310400002)(186003)(336012)(70206006)(316002)(426003)(356005)(36756003)(4326008)(33440700001)(82740400003)(47076004)(8936002)(81166007)(70586007)(2616005)(7696005)(107886003)(26005)(9786002)(2906002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0fb02f1-932a-4879-d56b-08d7f27e1f18
X-MS-TrafficTypeDiagnostic: BYAPR02MB4725:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB4725A14D48E8D69F064FBDCFA5A50@BYAPR02MB4725.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+qh2q5/M0pSwYgAwzAMkgfXaC2VBPXn4I2ICXcw3MIJtkryDQRZQHYlsed+8f241T6zKbrO882fFa9qMbR4XDSzAtf6d4o0lEHsU8YhlBinOUCVgDDjOwd9sb5QnEJsIv5T6IKr1c2E1jbiCvW426lnuOxF2hFF7C51WX+8vvQOS+yKrhdClkgK6YY/i8yO9k/ulW2vjBMfnQTblKgfGwz1Q9rh/Huq+NxDi/M5jLWZJF+CXP/OsApzq7x7J2As9BAAuYiPd0+mMladaaDs3LGBfucP3AYxxOc04R9RQIK8kvMeC6Xye5Nr+eAHTfrMWHPKkgsxqmZrgkARAuPNsgK+m7yfnB9OLnkp3ubUn/PHDT0OQA3zmv8GIIkTM0yuT1NAznysLfjcVVfzOAD0WqpCVMd0AfxFq+bYNs5hIMH7aV+GPrlyv76Oo+tgb4tnXil0CF4KZufMLADVSy3Nb9Lu6gwcwCrZ2itUMvHWANRiIKesN08fN37mfU4mOw8gQUgs+vLPLVJFbTc8Xh7A02qDyC1wn2r4VrSg+aIVCFUdq8eijetidG9ne0ipb6JZoPrPMNFRpTXVLBXcX15QUA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 11:59:39.7656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fb02f1-932a-4879-d56b-08d7f27e1f18
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4725
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

Changes for v7:
- Adding device tree documentation as schema.
- Using pci_host_probe for registering bridge.

Bharat Kumar Gogada (2):
  PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
  PCI: xilinx-cpm: Add Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 105 +++++
 drivers/pci/controller/Kconfig                     |   9 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 506 +++++++++++++++++++++
 4 files changed, 621 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

