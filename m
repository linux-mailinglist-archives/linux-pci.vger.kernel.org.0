Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149C7543939
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245574AbiFHQlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245603AbiFHQlU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 12:41:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272EE703EE;
        Wed,  8 Jun 2022 09:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLkI1xMiDtmIZGXB+jHITJneNK4eWoij5oAr9yla74KqE4m0EklzEg+75ZCzPt+bA85SeSBlJMZhoqn7/qjKsCrFuXMYlNKUXCdraLb42MJsWEE403pB94iDxYmH7AEh6nRbkr1qFwOOkOaYt3LTXEa47hvWvyZXSOHv7wxCAyRyfxOKqjcEjNIqJGhwXLK2pKenOw3w0v6ljEHx8yCcnMGq+GGFfAuaykxdRi5cAKDa0noas94Gohq0X+dhXgtIhL522jMOnW2ls4Nq5L1qbod1K7r+mebysyHp43knTkV3z3IRWL/cYYp/WhM2541uM54scklNGC57F8xLYQMc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK3gAbjU3ktpcHy0PAx7UQ3kM2zL45e1nWXjhPkcTkw=;
 b=kUTFiAGfMBLVc00Ydm9AhkfP9r1ARypJy/U4axP+dzmampQ+nK+2GeYLTaA/18Sn89vL9ILBE4mbxGDySelH0kDlAv26t3TdZnYgljEBEmTGh7ELSi2us7oLjUVxjkVySR5hRJS+M3K4c91AS1pz+BChWAN1sgdS/s1cQBRapBAWlluSUn/cLVswMqKQGgkOTHW8/5IX2CACOzxssTTuRo8PDTOR2AuRse3XvEF1vilm9Mi/MzyG2juP/Akxj6UMffToHbyPPZwXMpYDbpB/f1JvXWdd53UUKxGPVg1n6klWNSbKsYiUt52dV4bH3/zxyjK6XeGdDzkWdXHcE+yhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK3gAbjU3ktpcHy0PAx7UQ3kM2zL45e1nWXjhPkcTkw=;
 b=bbdbPh+WEeg/ZqEuRNt8FV8uz5Vr+0BGQ6W0IA1BMJGbdc0TGs9rpFkR/04/M+aU3hKXxk0CTTeIIsGnX/AM5yQbqjAZdgFVyPAlhvPRahPeD2HsTrS4KcARR0dvQCe9Bq5Mp7+minKVPp2V7vk15T0XL57lgvzi4LnMwPe0UTI=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by MWHPR02MB2509.namprd02.prod.outlook.com (2603:10b6:300:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 16:41:16 +0000
Received: from BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::a3) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17 via Frontend
 Transport; Wed, 8 Jun 2022 16:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT011.mail.protection.outlook.com (10.13.2.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 16:41:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Jun 2022 09:41:15 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Jun 2022 09:41:15 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=41368 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nyyk6-00016D-IK; Wed, 08 Jun 2022 09:41:14 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v4 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Wed, 8 Jun 2022 22:10:44 +0530
Message-ID: <20220608164046.3474-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44351418-1db3-46c3-c3df-08da496db517
X-MS-TrafficTypeDiagnostic: MWHPR02MB2509:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB2509F070A0653152944FDEF6A5A49@MWHPR02MB2509.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4te2S4jIpr4NZm2XCcParodE0qffZOrX0z+oWmYWcRCJuHcYVt8GND2zY4SA2BD9xiy0lpLIK3PYqhYEliE7ivHUN7WNerxiKpwYSm9oYCgDs43pobVBED6moJjp6CalUhjq/uBmAPZjz0hHu00vHHCkMTKnCKLmZFbvxInl0TLJI//ozYqNh/838l1s4pStAMhxpE1Jb7yGQaAoQPhGJnL3doooeDi8/Gq4WnaMxazNqf4tj7Qr2KEstBEyIr5AKxiPbX1i8/6B6on3Q5MDDc9wTMJgk+crXLrUaT4B0fukLKK/NpKWfJuoU9hFoDLkAmMBTLRDjYOnV+dvenqqq16sBqneW2LM2hWouB4xa9EW0HfjYA2WXxTVD17xrNyrptZnPfcFMLL792CVflopk2+BH6tgiUEv11b1yyK0UuIT9NCdM7KkAhHoKHPoS2BRDlMYf3KX+OEpXvSJJyaOyzknIaPe7ANfzPFZk6O/9bjdeMfVDQ45Z8fCNPTyl9bGsNlrxmau/2Zzrkq/F4klG/ewhGs/d7APcPt9a/vb4R2R7xuU18+xzPSEebln5tnv4/C68gDzIOyPWdFTs9JFumw5ublAtxrP77QbQgTGgjM2C1TeUb5ZJorH95dnD7iqp1uTFKizRMc41jsrMuO9FyWJ27kiWz+CK0tvl6Lwmugz8ReuvQkw1gbjYLu3dFlA3oAO0LJyVjs59yjwO68Urg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(7636003)(356005)(83380400001)(36756003)(36860700001)(40460700003)(26005)(186003)(7696005)(6666004)(47076005)(336012)(1076003)(426003)(107886003)(2616005)(5660300002)(8936002)(4744005)(70586007)(9786002)(70206006)(103116003)(82310400005)(2906002)(316002)(54906003)(110136005)(4326008)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:41:16.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44351418-1db3-46c3-c3df-08da496db517
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2509
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root Port functioning at Gen5 speed.

Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additonal register bit
  to enable and handle legacy interrupts.

Changes in v4:
- Removed versioning in compatible string
- reg property definitions are added


Bharat Kumar Gogada (2):
  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port

 .../bindings/pci/xilinx-versal-cpm.yaml       | 48 +++++++++++++++++--
 drivers/pci/controller/pcie-xilinx-cpm.c      | 33 ++++++++++++-
 2 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.17.1

