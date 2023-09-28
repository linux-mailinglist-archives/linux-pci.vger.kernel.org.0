Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D113B7B22BA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjI1QsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjI1QsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 12:48:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17337193;
        Thu, 28 Sep 2023 09:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G43OJ0orNOHw7cFe03xRnNz10/76U6SMKAwrovrtMK5PobTRYCttc7A0JX7OvNGOCZa3uMantOlBXbgYJwCiZS5QnwVpsLzs1kxI3PbwBuvB7OpWfQ9MiSpsvFgnGWurzpXj1Tno9yI9z8eY8AJnIvlA/02y5L2PKx3zmzRbpiMH6QLQOilu2F4vE8ru1YNdVTUjYo8BaRKN+vRO622gM13HMGBpXc/0bwPrmToiVL3YxMjrIrL9DM/Fad+Z/kdvPelQbMTJ76bi4zcWdFJhA4QsY2D0vJRTzyYl+heVEv+pp9Lim9O9rJpVWNLOO3p88j6yIgJNMEeFxlngon+PvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnGoVz5eJxpJPMb186PhPfpjO4+zF+4bmmmljn1HHjw=;
 b=nZna2LwNJKHUnBvgtk0s6qeH68Inj1A6/KiewrXBIxgpKUwHP8SRNmyMDDPoLHItXXbqz2uLrJd9/cuWpaP3xdGNUTiR7+HLM4FO/vZ6zVgech6zzdmq5GNRvRY4jItx+8/chL+9EwzHDSi+hMpCzFiraddU21VvAA4YUMYLTeC6NK33moybM23Fp89Gj0zp6I5ftuBNQ6iiuHf+kJNwQcLamXJ1If5r4lhcBShtiGSS37qR1ePzAanhFk6KUQ1erxI99ZWp6IEj4TTbPxYbaJVt5HsdfXl82yLPxhdje1ru7FylYWlpgemZEcRa9VVr3+OGSQMhp7cL4zcE7YMKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnGoVz5eJxpJPMb186PhPfpjO4+zF+4bmmmljn1HHjw=;
 b=S6RJG1hzLn7gkW73Pf6o4B/FtRnnIzVELLDHG1cQW6i8aT4WbQXNLwNajuzqJeZ3z27/54Nqp4CrkYg35RzLaYB2UeuXBWXZMifDlVUS/5AmvPDSIEQOau6ZBtJpaPSTFtWs3J9pqFvKzKXW8yTPmA7SOHs174nYvmaD6vDkCfo=
Received: from BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.33; Thu, 28 Sep
 2023 16:48:01 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::2c) by BL1PR13CA0207.outlook.office365.com
 (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.12 via Frontend
 Transport; Thu, 28 Sep 2023 16:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 16:48:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 11:48:01 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 28 Sep 2023 11:48:00 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <Jonathan.Cameron@Huawei.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: [PATCH v1 1/2] PCI: of: Fix memory leak when of_changeset_create_node() failed
Date:   Thu, 28 Sep 2023 09:47:10 -0700
Message-ID: <1695919631-7661-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5bf754-4e81-427d-ade8-08dbc042adcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko/CuEdl1owr1FSb0xvCjzJB3VJTarVZSKlUR1yJ8wNgVhcSnW69nHCNVot+T6lm5G06qNTEWmPZV4XpMxnchS1+ffnvOKuRxLbHWi2mSI4uKFnnf/epf0Sx5JcZgykrEyaboxW5+MByBdrR6yXt5ETlnv97FY3b8tjRb1XWeABmd/LkZcwTjAUi0kDtqkHzsDbKK/thJecVyduZ0DTvamK2Usx8u98DM+ec/eZ6m06Ak6BZFth9i/WSYQLND3UMEqcU6SedRrDhNksInQR5N45C4DQOSf2q+5VQSFENNg+EkdRhHKlznTgwagPK6V/YSXva/hwyNghCOtzyRfikpx95lIlis5QFojgh/zTHYMwatJAiCQRvEZS11tbhb4xvFv4xvrGbVN7X0yU3LnY8ITQqI8a9EksXJ87B+Kseznzqu/TQ9DaaThYLOCbhLXI3jn/YaejGTXqgXuXf95aTT7/ow0XFeRt3ti9nkgmDhhvcc7sU9GwTKdwUo8MJ2xg6RJSMgKmKsnM2PAKSwoTiWIgMwC0vnyP7IpxrcsrApQKjLTIkEdOqKrGBFkUdjA39imtdsOz6UmhJXMrtayYed4cZsZPX9keEtHrb2lv8IVfnucrH5aJxWOlKm0960z24Ni6Xe1dcXuKcK3mL9I0GNAC8uf00A7kHzJiRk4pQU7Og/o9VOGkSjY6MJqMs2YIyBfkJU5RtBpL4gCxvLAFGyoVlFZ4gbedKlHz1tJJhtgQTFwcJs21XE5t7UY+u2E8LN2WG2Xfym7tMwdV014qREw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(336012)(966005)(478600001)(6666004)(54906003)(426003)(83380400001)(2616005)(26005)(110136005)(70586007)(41300700001)(8936002)(44832011)(316002)(4326008)(2906002)(8676002)(5660300002)(70206006)(36860700001)(36756003)(86362001)(47076005)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:48:01.9031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5bf754-4e81-427d-ade8-08dbc042adcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
index 2af64bcb7da3..51e3dd0ea5ab 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -657,30 +657,33 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 
 	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
 	if (!cset)
-		goto failed;
+		goto out_free_name;
 	of_changeset_init(cset);
 
 	np = of_changeset_create_node(cset, ppnode, name);
 	if (!np)
-		goto failed;
-	np->data = cset;
+		goto out_destroy_cset;
 
 	ret = of_pci_add_properties(pdev, cset, np);
 	if (ret)
-		goto failed;
+		goto out_free_node;
 
 	ret = of_changeset_apply(cset);
 	if (ret)
-		goto failed;
+		goto out_free_node;
 
+	np->data = cset;
 	pdev->dev.of_node = np;
 	kfree(name);
 
 	return;
 
-failed:
-	if (np)
-		of_node_put(np);
+out_free_node:
+	of_node_put(np);
+out_destroy_cset:
+	of_changeset_destroy(cset);
+	kfree(cset);
+out_free_name:
 	kfree(name);
 }
 #endif
-- 
2.34.1

