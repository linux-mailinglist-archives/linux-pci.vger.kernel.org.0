Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA831F19C7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgFHNTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 09:19:17 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:21984
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729284AbgFHNTR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 09:19:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPasqLRWuiphjOSxxMjrWkDptpL2Htv++DCCBGLpxZmuOtYMumpv/0BKiV1DHoSqNeZyYaQ/cnC1axqBkPiEaT4JZ7OcgKQsbnlzuNoP3cxzdgY03CRXaMVQ6fn2+/GMmaN/CKnb76dJtLt3o1DB/C86tV/lJQ+UCyr48b0wfxnitYPZSCy8XNAlI80sR9xZp1/BYOATqQUHlZiS6WViNgXBSnXcq2gZcQkXy559KAZaRuCQi1DlcB5QOUQLpntdS/++iDQP8JWHCWFEBLxVWBSsMm+sPBxDoFRDgEAVEw90wGzPePPiI+FdKBS9A+jtkYytIK8Dz8MF7Hs2WBMAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4YuzJ65zaTy1AKmZRL2J78TbxAzbJQ4P3dtVPvBHoI=;
 b=iFLl6gwZA+DS+KdsTc67sbVVjRh83eo2MCoMEHH8oR6V0nMfpfSNzC7rJ0Mx5GsRDkdOziR/ZUwHGk/RhnL7ZxgFLdH/haN4NFkUJKJC0lBYn1lc2rWF8BW6nCwqP0/Bt5cYfdBMFRe1CZEhn8rWPOEwnMKHH5qyRPwF3T39y+xftYssWzgrNVpzk7lIz/0CHNLolXre048YAqK3V7p04CQ9jisyy7aBmAC8d2ICaHPJyAP8q/VhvNqn88wqu0rrt2U075A5r2iJ7eiksEx5C8+n7BnuGS624LOdDO9Q8zJFF0862qVg+JBg4BohEegSqsG9uJHjGBUwmuMOjSd3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4YuzJ65zaTy1AKmZRL2J78TbxAzbJQ4P3dtVPvBHoI=;
 b=Fb/eL86wTHF1XaTwWL/LGVxYVWtZWUDCnOwNTdmBSJQnKObOovxAeVt+X4bPZuPhVU3wy16WTvs7+pfzUx1n6UroRIgqWPLpEQoIEeuMi+7nHD77hibLqvYZOWebO9Dv7RyjTYczNabIJg//Rn8LY7x3Bu+2/auPsw/atDG5hOs=
Received: from SN6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:805:66::30)
 by SN1PR02MB3710.namprd02.prod.outlook.com (2603:10b6:802:28::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 13:19:14 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::ba) by SN6PR08CA0017.outlook.office365.com
 (2603:10b6:805:66::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 13:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 13:19:14
 +0000
Received: from [149.199.38.66] (port=47815 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jiHfR-00061I-Gb; Mon, 08 Jun 2020 06:18:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jiHgH-0006Gi-T4; Mon, 08 Jun 2020 06:19:13 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 058DJ3YX026110;
        Mon, 8 Jun 2020 06:19:03 -0700
Received: from [10.140.9.2] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1jiHg6-0006En-TO; Mon, 08 Jun 2020 06:19:03 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v8 0/2] Adding support for Versal CPM as Root Port driver
Date:   Mon,  8 Jun 2020 18:48:56 +0530
Message-Id: <1591622338-22652-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(396003)(346002)(46966005)(36756003)(83380400001)(316002)(426003)(336012)(82740400003)(70586007)(70206006)(5660300002)(82310400002)(356005)(478600001)(47076004)(81166007)(2616005)(6666004)(107886003)(8676002)(8936002)(4326008)(9786002)(186003)(7696005)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5fd56cb5-4749-41f8-05f5-08d80bae8a1c
X-MS-TrafficTypeDiagnostic: SN1PR02MB3710:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN1PR02MB371089BAF3D567836C6DC7E3A5850@SN1PR02MB3710.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dIq/CYHKnZLssWP/j/yUF/lnL2ibUID3kfo/aulPyhbwGr0yX6LaloP4HO2Dx+OsBw0rTsPLoydGZySKgvx/csRaYzK6z8RflFMuop0mD2sepnUCd+0hCXOyPUR6tX3ba4cVrIFxERqH2cbskGNa+TvcpyP2E/0zyVnjHHUF8NcC+sY85aY8rJ8wk255iNhElD058RvygfEw5vaXFhiO2hJ1hgG8+MwDD+5lBFQerw9ZMISdAkzPwBupNWrnFrpbOBbEpthljLBbZykaHyVpkSxZBRvJyHfhSFQjuwnRdp34aHMFxrqbo/NWN5ntGxwuPkDZtv9E5/qD23b0YEym51MQHeLzfc4y/JXOAqvoBFmRsFLauomeokBx5LhoKMTs4YTFxs4FFKQjfdW/zNOmg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 13:19:14.1992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd56cb5-4749-41f8-05f5-08d80bae8a1c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3710
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

Changes for v8:
- Added support for handling error events and INTx interrupts
  separately using nested chained irqchips.
- Added support to free allocated resources in error cases.

Bharat Kumar Gogada (2):
  PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port
  PCI: xilinx-cpm: Add Versal CPM Root Port driver

 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |  99 ++++
 drivers/pci/controller/Kconfig                     |   8 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-xilinx-cpm.c           | 621 +++++++++++++++++++++
 4 files changed, 729 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-cpm.c

-- 
2.7.4

