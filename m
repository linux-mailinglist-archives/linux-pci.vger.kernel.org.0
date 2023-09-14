Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4154E7A0C56
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbjINSQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbjINSQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 14:16:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA71FFD;
        Thu, 14 Sep 2023 11:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9TMWjLkFguhwsXODHC4KLgJTzyoZbAR24ZQBfO/Z0BFsAS2MR9hWALSWZ7K0zD0pzRLSrPVUSYwDhF/8FV7aZwzY8xA4o3iXh8BUiLOjvK+bBVmLg/AmwT32LATbnyU0akAhRDcTa7aNOv3y9I6mTAmNcUCQIzfXjVZ1L+3j7v6KEzvdBIPnDHqjXAyityiU4XPvRQ79TD7UEDmEBqGpgPJmHYnvDhSFAIxFOVca27ABN/H1weL30/Tfah1RcevvqwWDOV28ZNtEWKaqfZLlcwEO6k0SaDfwarUnGuTsGxJUdrvSewUfUzHPmKXUOMFQRTgi1nHT8JzA5Uh2ryJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SifNL8ODpDDFEdAUcg7nM4MGe88oeZea6j9iF8opzVE=;
 b=fQIIdk/QCHZBBTilTnySU2aDtmxtVh6c8fJs1fCtDVNG5rd3teZ9L4qFIhqQPIInTyBlyptDUqa2VTlev10xBrdg0h2JCTzwWg2rLG7wbzqkI48F3K111iby184GxzkbbKe7mLSQEuZRNXGHdHRzboudNGinHmYhbbQQIRcnKnvjkuljWdJ04NLyJCx+TWUE2dpLk6mXJE5ZxoOLLhPkRGpYRkf0RhGF88jrESTdI4XDW0do3mQZ4KxHJIv5H0wjAUqlA6aZ7395aCSXq+H98ttQ4ag7iqw3/bo8Xw3CxLvpSJlFu5Zf+JjFKfHGg4eJ5++swY6oL1jtRNOvNwah9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SifNL8ODpDDFEdAUcg7nM4MGe88oeZea6j9iF8opzVE=;
 b=0dH6UuO4yPTXsCOxY2P26EqhP3v0Tfbq+X4RtwSoXr2c90P+OUv4GjBV7LclDf10lpuRtiEn5F9EMTC+qQXmG990hHpt9ikYh0oDu+S3IYghsOnaWjxTF+u0e0uBC8XvI4Yh9KU946qINgVfsMYK6c48I5I7l0cQtOOJXrk8b7Y=
Received: from DM6PR18CA0009.namprd18.prod.outlook.com (2603:10b6:5:15b::22)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Thu, 14 Sep 2023 18:15:58 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::10) by DM6PR18CA0009.outlook.office365.com
 (2603:10b6:5:15b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 18:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 18:15:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 13:15:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 13:15:57 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 13:15:56 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: [PATCH] PCI: of: Fix memory leak when of_changeset_create_node() failed
Date:   Thu, 14 Sep 2023 11:15:51 -0700
Message-ID: <1694715351-58279-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM8PR12MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 862b2080-7275-4fa2-b38f-08dbb54ea50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t27ziNgipgt7B4351WWtOcvN0RkCFKrV+/tpMeSz7c3Udh9Mf4wVkPM010UE+6VThGyNLleX1y2o4K9RXlm1CSd9Hu8jN5MJlQSDMw/GHTdKOulGzD2bUdQBKgt4+NZwz9M/aAtnBOCk+y3w9l3YbNEED9f52AeSLlJf+WVoDVghRUpw6bB5Z/opqJ6cavy9b/ADLAgKsYlT9a/UpbxiQYDjX6udo5TurNmLAIjpHAmDCzzKCBvNsFCbbt0GCo3X8DYbJchgDqhSakpnoCjuy97NBTkSEOguwsWWtfxH4KyKQkl1UbtQ66zt02+yOCNzCobNb+OVgjzXIYrlKuSNT4sf6/c7bdeX87GbNKEf3KoecDZ4esAjcZRUMBa1rw9eiXxu7gbOfXY4AN7/tZOXfStWR+OeY3LcwHSPxyTLTAstFri7xXuLpafr6T3pJSlw0C4mHkaXJqK+z5FUrw4/m79AGGb4eBIRThqjN1jHcaGUH13PW/ojHBIyN8ZAjnH1zsmtl36bXqVX9rln2H24yXxPV1CgEbh6vfb5sXuQcttGL2em/rkI/JVnCvewqJs5a0jkTi5EdauRHfQspkwcjWp2Eop1R0+ysinl2sQtu8mHpvyp4IyqNV8/tn7/ZVOK3Y4KYg0ypEUeBnZPyeIt5Co++9Pr8Wgu/GsawbkyJv8MGgGFPaEGUUmR2+61tL81GJZCFlKYSRt0xkCJclwzNWZuj3PPtSJILjbkikPHI8eeJHFi+rOmyd4YP9/ECviqcHRFoJQlXRVQmR8yDZa1Vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(44832011)(36860700001)(4744005)(83380400001)(356005)(6666004)(4326008)(426003)(86362001)(8676002)(336012)(8936002)(5660300002)(47076005)(2906002)(26005)(54906003)(110136005)(70206006)(70586007)(40480700001)(478600001)(82740400003)(966005)(41300700001)(316002)(36756003)(2616005)(40460700003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 18:15:58.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 862b2080-7275-4fa2-b38f-08dbb54ea50a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Destroy and free cset when failure happens.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Reported-by: Herve Codina <herve.codina@bootlin.com>
Closes: https://lore.kernel.org/all/20230911171319.495bb837@bootlin.com/
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/of.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 2af64bcb7da3..67bbfa2fca59 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -663,7 +663,6 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	np = of_changeset_create_node(cset, ppnode, name);
 	if (!np)
 		goto failed;
-	np->data = cset;
 
 	ret = of_pci_add_properties(pdev, cset, np);
 	if (ret)
@@ -673,12 +672,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto failed;
 
+	np->data = cset;
 	pdev->dev.of_node = np;
 	kfree(name);
 
 	return;
 
 failed:
+	if (cset) {
+		of_changeset_destroy(cset);
+		kfree(cset);
+	}
 	if (np)
 		of_node_put(np);
 	kfree(name);
-- 
2.34.1

