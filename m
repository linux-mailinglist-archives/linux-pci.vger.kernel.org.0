Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED67A26B9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbjIOS7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbjIOS7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 14:59:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C5AF9;
        Fri, 15 Sep 2023 11:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hootONcXvIkJMkj4bo9UwN9nvylPlOWitxeOEpiVa7yq4umaOwexFR3uttSu1Knrjk4RM732L/UAw0tEQ2hM2xMyf/1zk2cbK+OoX5YeRwjQlbGtUpsGBOcWK1fCs3S+jtoR0/B+C9c1GD/kZUbPJmXOXpT+9EO/7WwX+o9M2ddmlwI+xFxFkLOq2u63ihyCspCM1bQuqobOyEY0L85PDuTyDcnUs4Jr7zHuCkDBqMvVrqQbw9vEhv2JlsUCmC9fw2JHTQrpz8VGfQHcUbyZuIGxtQqq9L70iOIYxtI6LY4XgBKVNJIIzEC0utnCF7pIcsIrO7YxCZr1DM6Pn4EdPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjyaxVsTLBhP//KKYCPbJ27HdfiX3W3zpkxt1SQlsZc=;
 b=ZXHOW5EJ8+xarP118dU6tIqkN67zFeknzDxQXQISso2CrYLOMNJkSLfpchnGjP0vo50Q4wU8T9In5z9fBtDFZ+OvBtyE2/0krbRysv8hW0bLBku9poOyijaAA1YXVfHc6BgdmK2OpXdggkJO4ceqaI1nLVtKE0DpNOCSaTTEV7Pheew1y1PtCrNKkxrryF8pfwdsd4pdolS9CqEwYLL5mxttFSgzE0vO5/eglPQeBlHNkJNAwenOUFeOmqQdJdys2SmqTrTNf27kqmuLyviu43YC31H0BICphvOufuOcqbgkrBmx5+K9I84XwKj1RMgDrLqV+2Ps3g+YKB1gZKgFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjyaxVsTLBhP//KKYCPbJ27HdfiX3W3zpkxt1SQlsZc=;
 b=xhDGzLyodC7uh79AeF2h+WHQVh3bQTWuQ1kZpaOQyV2bWbT10OZhRuVbhdDn9p6eVTnQNgr8eXg7RRwKY3/QN2GMXy2b4zc/kYk/fzU2cORUdrru+uBmhTDK4lTSBnfg2P/UvLz8VJ8otY93VXneS5BppZ1b6Fo5UdLXRELpdtQ=
Received: from BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 18:59:09 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8c) by BL1PR13CA0151.outlook.office365.com
 (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.22 via Frontend
 Transport; Fri, 15 Sep 2023 18:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 18:59:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 13:59:08 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 15 Sep 2023 13:59:07 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <Jonathan.Cameron@Huawei.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: [PATCH 1/2] PCI: of: Fix memory leak when of_changeset_create_node() failed
Date:   Fri, 15 Sep 2023 11:08:06 -0700
Message-ID: <1694801287-17217-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dad24ac-d755-4ca9-f7fb-08dbb61dd782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emtoL4aaGJ/LY+LTUjwq1FdGkKDazvmqrACL3+9X5RjHvKV4bSoVanYQwW8w+kolpkK+mo+tZ2sOnoNOnvNLn9anGvkL39FzOIGIPKxRX12Fpjv3mL884ra/0NVocMRTcGL9NX9x6YvIN2x29VisIDrcqseS1QxHdZG35E1fA6ZdjSm3qMQAC3Q+v+P5gljeCk5eT4/v3tl2G8wRuTvKmvzMpL+g6+QWC5LU/Vq455MWhNoOUMNfggll69/iEm3Ml77UMB/K49Bi4pIoQBoFyzkYy9xO80USLjdK9QaXZ7+pkNXEMIlwB+BlQweUjZK+IuAhrbSCh6nwB57GzOCJN5OPSn3cV0M41nh71vnJtqy2qbShIcWd2CSgN2bERsE3e34r9bSXBWiF63lPcgTaY9usiVXMDxqWvd0A8JhyDPC/00D6crul4j7De6R3iIPBnzfyxydr5cc//CQ0DVP/B6NvuvlUnBM4BtV1P2rfiwlxzgRYhUunFmQ5TtfiJVT66xiBTrohFdgssGuYjcOh551eUGknbajz0a1g4Ernfg4V6V+7Rv0JJa0RGmX5kVJRlnWKYXkWh+AbshmRtwFvKTbqURkWT2O4esBNvdoEVsy1r+PpUwZ3Cxd9nj0wzODO2z8FIk49Hi3uz9P/AwAGkqZJ2+17EZmv+Rw1LMGxhTXeQKrUN23MgGq6abKVK4Dl1t5s+C0z3G4W3pjLP09chcChss6WXZap4792HCvLESl+1hXV3POBMfk9f77BGWCbgcH7OgHZK/GRkGOpvb4SgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(36860700001)(2906002)(47076005)(36756003)(86362001)(356005)(81166007)(4326008)(8676002)(40480700001)(8936002)(2616005)(5660300002)(26005)(70206006)(70586007)(110136005)(54906003)(316002)(426003)(41300700001)(82740400003)(336012)(966005)(478600001)(83380400001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:59:08.8579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dad24ac-d755-4ca9-f7fb-08dbb61dd782
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Destroy and free cset when failure happens.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Reported-by: Herve Codina <herve.codina@bootlin.com>
Closes: https://lore.kernel.org/all/20230911171319.495bb837@bootlin.com/
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/of.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 2af64bcb7da3..498b5cae8bca 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -657,30 +657,33 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 
 	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
 	if (!cset)
-		goto failed;
+		goto failed_alloc_cset;
 	of_changeset_init(cset);
 
 	np = of_changeset_create_node(cset, ppnode, name);
 	if (!np)
-		goto failed;
-	np->data = cset;
+		goto failed_create_node;
 
 	ret = of_pci_add_properties(pdev, cset, np);
 	if (ret)
-		goto failed;
+		goto failed_add_prop;
 
 	ret = of_changeset_apply(cset);
 	if (ret)
-		goto failed;
+		goto failed_add_prop;
 
+	np->data = cset;
 	pdev->dev.of_node = np;
 	kfree(name);
 
 	return;
 
-failed:
-	if (np)
-		of_node_put(np);
+failed_add_prop:
+	of_node_put(np);
+failed_create_node:
+	of_changeset_destroy(cset);
+	kfree(cset);
+failed_alloc_cset:
 	kfree(name);
 }
 #endif
-- 
2.34.1

