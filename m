Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE35009AE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 11:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiDNJZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 05:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbiDNJZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 05:25:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA16F488;
        Thu, 14 Apr 2022 02:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvCt6ja9ypS2vCEUqGBI0ULHUv/wg56eGnLdOAYBcfy/zdUdRcWhXr//+h+x6nj6XJexOddIOkBGWLQJ5yQ0fGyc6pzfj7VB42wfn94qANLKdPcDlKoOVJMfi06P9oAfN2loAMSmGlLjNWXQh3xWXTMIZPiTppxM/CnwOw8eD6+QyUmDcVIQCk1x9eawEcD229n3DphnSSCZFINeHnqYiA9XZNcGdTcoJjeGMCg3o1IX012DFxtfk1+Mzyrid6hGUwul6uZwezpLoTVoBJG0PPwsvYW8Ys8TNKEDvbit5d2G9NDJMtopDZWOM0DtyhJwyAKSJ45p+gWW1QJ/q6s0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKCFekQVonpSQR2YKHvLD5Pwtw/4uei54TMdo23UCVc=;
 b=Rojvu/5rzedBTRZp0Gnn8dPfZWroDlTmuMZt0M4PMmOkeoBCDnyEB6u3tSG34Op7Mi4b5N7tcDPgxgz1dRuo0cmzFUZ7lYP0WRvY43N0SInz8kxk0+n5hWmqQVKLIkJxCXYhqZwSbY1uixIkm6IXyIM3+UifAdKNk/qLwjbqgVWrkfRL0fCI8PHqUg2p+b+6NwI1IdHWFCdIP8cvWG0D4H9w7FA9ivNNlRN5aZmSlgXAdF8LYG92lQjd62stukoixonx4KxLgu71nyGXgyI5VLupKWaQ3D2E0mApGshTRxKtmXdpgfyW7CwyGm4x/O9EYvw57XiEvcCrkKrxrjqsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKCFekQVonpSQR2YKHvLD5Pwtw/4uei54TMdo23UCVc=;
 b=osotZQu2QjJVcRC0DjMbixibPs9CN1pw8Bw90rHY3JBgCdZrSU9wvLS/dIfK9h8+vh/6r2OUKgDa551JM34z+E+boPFfGOyBvetfXzsdFDPRQS6YRPckaWWSTR6VnsZC4Br8llnOSLX9jqZ2FpZuAKRk+RjBUKOkvBd9gsRotXQ=
Received: from BN8PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:d4::37)
 by MWHPR02MB3277.namprd02.prod.outlook.com (2603:10b6:301:6a::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 09:23:17 +0000
Received: from BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::65) by BN8PR04CA0063.outlook.office365.com
 (2603:10b6:408:d4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 09:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT063.mail.protection.outlook.com (10.13.2.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 09:23:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Apr 2022 02:23:04 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Apr 2022 02:23:04 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.140.9.2] (port=38782 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nevgu-0008Tv-6i; Thu, 14 Apr 2022 02:23:04 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>, <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v1 2/3] PCI: xilinx-cpm: Remove version number in compatible string
Date:   Thu, 14 Apr 2022 14:52:51 +0530
Message-ID: <20220414092252.12174-3-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
References: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cde12ab-6011-491d-6ebc-08da1df868b2
X-MS-TrafficTypeDiagnostic: MWHPR02MB3277:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB32770AABF7A0EAA67FCAD26BA5EF9@MWHPR02MB3277.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCTUit5G46BbG8S+uS26Cljl8SLiEw1/M1QD0woC021vue36z5irXUku91SC83WjNboMJx6oBDICxXW6g1O0x4Vn6cn5+e7Em6dnWE0LC9uc3wLJGvwq0tcOyL5k8m14owZdF4NKM1HTtBD1LSOMRHPEuLMljrzb7NumNuoYsJq1AfkdO1iM3nJYvKNG/wWw+4dJDq9ZZOHvCyagKzQe0Cw9kuMUwZNC0scy95+UUkKnAkBZULj9HIidJGnXV/bP1w4G2hqO1pXDzaxeGLHmz8dNkxwVQUTDN34MrF/YApLZZTJzMRr5vq+4EZ8U5Hk1EO1f1KvPZY+O+ulRWVANhSjNp8XgOAoXgLFDdN+RXPypDJyCGS/FJr05omUcvB9aDamkup9+tVZw+Rx4t5zALQ0XkS4JTgJAyohMfF7Enp4PLPrIH7711kV0F+WhZI9bkkPdUoXlcQiTiEdbxAp3Tjmomnk2sPGHtzLfb7ygf9wKX5/jbIlNG2te2ASwwYKrkyS0qFoV+zjZNE7/n47RYjECmsOVJPuyTE7W0sPP63WNIxdMF6lkak7NOrkuglMJfdZEaMKl6uSeTG490Mk0B7iMZCEIq9RH3Rz/LP1aDm6IaFGW3DNIiqRfPXxgYlRSWBgsdfullV4tBX7+cDZSlknN2c3ZzuGyLk5HXwIIUReEClegoMFPZA5E0uDMm8M1eBQjMTMy2O5tt/R5ncmWnA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(36860700001)(1076003)(186003)(5660300002)(356005)(82310400005)(7636003)(6666004)(7696005)(316002)(336012)(40460700003)(83380400001)(2616005)(426003)(9786002)(508600001)(110136005)(2906002)(8936002)(4744005)(47076005)(70586007)(8676002)(4326008)(70206006)(36756003)(103116003)(107886003)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 09:23:17.0559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cde12ab-6011-491d-6ebc-08da1df868b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3277
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary version number in compatible string.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index c7cd44ed4dfc..52bc74335584 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -592,7 +592,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id xilinx_cpm_pcie_of_match[] = {
-	{ .compatible = "xlnx,versal-cpm-host-1.00", },
+	{ .compatible = "xlnx,versal-cpm-host", },
 	{}
 };
 
-- 
2.17.1

