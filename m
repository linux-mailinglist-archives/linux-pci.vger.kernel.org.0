Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C606D7B3860
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjI2RKb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2RKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 13:10:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3D1A7;
        Fri, 29 Sep 2023 10:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA4b7bAKi7lxsPsa4OZHmt4DuyAPrAb8ML9AT3fgCIqYg3ZshwFyh5zZn23iCXiP4S2YhtGrbMWeJVPf2aCBrEPKZBZ2CUx3x3gerhnn2Jw1GH2FQAfEFztf5N1X86coXKswba4AVbOaDbVvIFUHgvoeqKp5/F2qS+oPP1OLcklEwAyXUnSxgCnzIA5ASvhAhb39HcN2c01Ou+F3X1cyLF1UET71CJNho7chYkUaAAi9unsmUKG5gt27e7hmCkOZrIvAaRHXZgqRv2GjDO4AnULp4PxrNwzVHwW07lDimWjo6qHsCwb8AKk/lNclpKQcO1Wa8e72V7axlUNLCAAAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxEutrolUb6/qDHDV9PswzvG2rO++gzfjbhEOUv9JGQ=;
 b=kxMBIJYMa8fQccUnoRdByCbLjyIKoaDWQvA5hJT/QTZhKiB/gUPYiD70qKtlKW2jSPEmR+K5q/kZLM8J6bcAKMcfueUlvM65O2O7b1oJqx9zzV1SsQ0phPtdKqaEe+oCiByifbWTIF8IQWiB4CEo/tlGJOmZ8J/lxN09UkRz47BQb2oFzxIR6fnEi/zMobNAVm6T51+B0gJZ0NIZyjn3HGOxMKAqV5pSXhMxa/bMduxRocVyBW8oBFNlTH1bHMXfxeT7muIVcfjoKOYeH6a9zZqHVDpuEVZol3115cG0RA1oq4i4KyjhpKvQyBIkUvVuDErDuyjZej2qZWU4/2/WfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxEutrolUb6/qDHDV9PswzvG2rO++gzfjbhEOUv9JGQ=;
 b=PGE0iwKds1f6giJgIGhwoOJjNQYsb08XknJhAZobexqR0xIV8EyUy+2Fx3G/NHIW7WAPIqEYI4yigVf2cRAWdjchxlkQurX3PdYiJ0PprWwGkWHCbzFPwCqM37JElvVxPIvOUEuSSDEhgf5+/BRqZ8MLG4Xp6ynkFUokrDrCQjw=
Received: from BLAPR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:36e::21)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 17:10:26 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::a7) by BLAPR05CA0012.outlook.office365.com
 (2603:10b6:208:36e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.15 via Frontend
 Transport; Fri, 29 Sep 2023 17:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 17:10:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 12:10:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 12:10:25 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 29 Sep 2023 12:10:24 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <herve.codina@bootlin.com>,
        <Jonathan.Cameron@Huawei.com>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: [PATCH v3] PCI: of: Fix memory leak when of_changeset_create_node() failed
Date:   Fri, 29 Sep 2023 10:10:17 -0700
Message-ID: <1696007417-42059-1-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 11aba9dd-6a8e-4f23-18cc-08dbc10ef934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbV99/YWdE1gto3K+KhJ7AhcyMn7bQrU99EPYr650WCuWUEU5U3525+lhP5W7NmNiGvzSP5tf4v3zLq+dQHqaHJX36sT2EA+z2+H57Y0Yq6giukiHH5oS5UhXjGDPoaaF6KabzRTnvAtWdbjd4+KYmZaBm2r08PRQ0qKuJOiDBwdxtjTyaRLwTlswjCzjRnuj1l3S7usyogPmtSe07eJctDzDax9nqRkFSuGVDH3zx/WbBddFIixaorsnWLBjDlIb5HkMQlsOF/rkhJc95bnUXPbxulDtFk9ivjtuBnXpm+hmqPNCi8yo4THNLW/h8P6Su/CN+8Za57++lXYCOTQE+vEfA58DUDY7pa6bGWgjQXRc73cQg8YNVvrl/HM8MC+YJsXYx1bXZnxJtw4X6mkKbToc3gDSjNDJrb82gVdUhY2wV084Io6fhfV+G2g7VWAuSB6Wo0OKaiEn9XXfKDZVwQCVSBAWrYa2ssr77xoD1CxdHnaIhIDQe+PMGeC3miwIjySBPUrjWrd60l1X7UtZunCO23f9s/LPKJZevcw26Jypw8BXZVUiRD/z/7uWZ7WX4OL3t4ne21YcS5OWZiBNgnr3k7Y+F/gnAy3iZQQ+JjNSvCPEzTEfw3Ej658QUbMSL6mHVlzlSSrsh2kjp192+sO5iez8C50Kk7m8w+sr0Ix9+fk+xz9bh6uN1auQi3OIle6mzN13/IEPCIjSuGyOhRVJSq+yI9amGaGcPfeWuZv+Mc4NeZFjNIc2k10p7HvMucy2mhtzve4uixUK6GYjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(44832011)(4326008)(8936002)(5660300002)(8676002)(966005)(478600001)(6666004)(426003)(336012)(36860700001)(26005)(83380400001)(2616005)(40460700003)(356005)(70586007)(70206006)(316002)(54906003)(41300700001)(110136005)(47076005)(36756003)(82740400003)(40480700001)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:10:25.7388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aba9dd-6a8e-4f23-18cc-08dbc10ef934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In function of_pci_make_dev_node(), the cset needs to be destroyed and
freed when of_changeset_create_node() returns null.

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

