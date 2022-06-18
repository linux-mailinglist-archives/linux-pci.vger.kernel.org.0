Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2714550219
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 04:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383945AbiFRCpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 22:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383935AbiFRCpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 22:45:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C76A00E;
        Fri, 17 Jun 2022 19:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAUSmPFqgsxVnU2k7eUeRJLI7dkq2IkcNECu3YtAPsfUZn5hhW5eShkVg6zB/RRSYaLP2FTt/Pk2ke5FHSiaVpIh7W8F9iBrTgmuUiRTwRtqPiZE0yNSV0j7qmHYGLCF9YFrPZilQPQ1iK0wXtKs806xGep6UUL70QNMALpnu5A2dQtJkE7LkcUYKg64JdJsfSVgQFsTjf3g6vqX7+ZFINicEgLa4B2zFB67NFvyuVVBAQD96m8BvhvsfQf1dk7DDfk7hJiraClP8sOQ9kCBSOMoyZRf1doJDDUykMXktZyiiOjXueWLe+FT/fzcmGG5dOxSV+K26jtW7/idpQ8izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNenaDrZYEkFAQHcjYIh7L2D9Wouh6uO2jzRMK+XK/A=;
 b=R+dmGjLG8lbBGCnHOyOQpV8Tz1VgxEx/2yRV7/l72gXUtXa+AnGwtLG15cm1N4UtywmysH2IwMZysCaWFbKUZ4D17BvPOGi7MR5CcwXTow1MLffWWmlmm1SVe9ZnpStXCu01FvEVvgFNVkBKRSEfWj6CzyQsIz+YW6QuVcLcemaUxNTUC1hX7lTij0LzDP8Lcw6CXTpsBeTII+9D7YIszxfWxQf4zId0RQNZLvAbkQtNLElLen8/JaQGaPR087x8pcAvCtiqu5i0iRfRVlzxWCqjr1c0+snUMZ4zarnDPvk05EA64GUQUkCZWGhqAtmnr3m8gVQIN+4jatHdmepYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNenaDrZYEkFAQHcjYIh7L2D9Wouh6uO2jzRMK+XK/A=;
 b=VgmzpB3NQdsp2FWjxZt0xJbg+gTEw4FBaqW6G7Bh6Mj4BBvROgJ3Ofa8rywByezaORqsvXSkCOHADRexkJ/aDUHZ5doYG/j2uu69CqKb3VGc14mKMo4bSXqKsJXQXdik9hjGaFil0Us05D1EnyNJtTwTMiuB7QpFPBtL4NnCr10=
Received: from BN7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:408:34::14)
 by BYAPR02MB4581.namprd02.prod.outlook.com (2603:10b6:a03:55::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Sat, 18 Jun
 2022 02:45:16 +0000
Received: from BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::d8) by BN7PR06CA0037.outlook.office365.com
 (2603:10b6:408:34::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Sat, 18 Jun 2022 02:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT021.mail.protection.outlook.com (10.13.2.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Sat, 18 Jun 2022 02:45:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 19:45:13 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 19:45:13 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=44908 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o2OSN-000FZO-38; Fri, 17 Jun 2022 19:45:03 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v5 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Sat, 18 Jun 2022 08:14:57 +0530
Message-ID: <20220618024459.7554-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8497b8-82e7-49e4-8e73-08da50d4935f
X-MS-TrafficTypeDiagnostic: BYAPR02MB4581:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB45817DFA67789C0E2A4B3958A5AE9@BYAPR02MB4581.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbYmFfhG871z9I+TvTar09SbaAje+2Er8pOJcmrAmHdSV30jrH48d3rI7VB+6VwoanT/CA0SzUAy9UR3pQGgGV0LUF801bNtCWvd36KDR7wVlJ4wdAyVu9A3TEwu7Qs1aXK9ikz1zlje6xEMm7wmPXWENjwiZPF9pAfHJGO9afncIimzIQ+DvgOg2HvW6hfh7HtrNoGFEmolV/4L758BCqGebJPx0JBKmrCFmtY5YDQjSVhzaboA1sKiicntFwlduPcq9d3UbpEa9ID8RsaAwunXZ+XNeQlsjiPhTzlDsvVJdakk8faLkUFHtAMv6YEeXUlwMF6RFeBl6HIXsRdg1pAPWUywjthA4xB9+T3IACO/WDQOvn0ehXogIhIaIuB0tmmXDyMQ7BM9sTNISSKjm7Zn3iuvY80LgNDFtaNLnCbI8P6huI52qnP3gyfXkHKvQyfj3A6fzKb5c1XvECwlf7b831GDTYYEWY0vbIkj3ajBAdTjMkrNNyORSvpvZ+gM3w70uuyP/3/9pQf7JZ3n/3dyyk+hmGCpKnYz/Nz+ZwIP5Vhkqar6qM/t1he5ViOD81Jr8jlzIfmICPEI2D5QBANhK0Ukactp4dNPABQ9gNpbRApZoHoETM+hOaPoBdVjmXgtbH3+rXGrvKVIbwemd43TZmv8YyUWt2RaexhlqhK55GlQed9y/nDXSm57W4yIVRmk3XXHgl+F9ZXou7aA5A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(47076005)(186003)(426003)(336012)(7696005)(36860700001)(1076003)(316002)(54906003)(40460700003)(110136005)(36756003)(70586007)(107886003)(8676002)(2616005)(70206006)(4326008)(103116003)(6666004)(2906002)(8936002)(5660300002)(9786002)(83380400001)(82310400005)(356005)(26005)(7636003)(498600001)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 02:45:16.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8497b8-82e7-49e4-8e73-08da50d4935f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4581
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

Xilinx Versal Premium series has CPM5 block which supports Root Port
functioning at Gen5 speed.

Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additonal register bit
  to enable and handle legacy interrupts.

Changes in v5:
- Added of_device_get_match_data to identify CPM version.


Bharat Kumar Gogada (2):
  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port

 .../bindings/pci/xilinx-versal-cpm.yaml       | 48 ++++++++++++--
 drivers/pci/controller/pcie-xilinx-cpm.c      | 62 ++++++++++++++++++-
 2 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.17.1

