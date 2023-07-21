Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB0C75D6C0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGUVsU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 17:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGUVr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 17:47:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7DE0;
        Fri, 21 Jul 2023 14:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fruDMy4Aj80DYPlf4aHvhyO2iPATvl6ZUxAWYOFDLw4h3U1Rwn6Tb0LJv4exN0lHFIpYLNfU9hxXa0B5TjIHby9pjglGfWO31Z6vEBbsH7E8o7ijyYL8y2b1q14ANVd4Kn33X2QmYNreHgfQHTi5eR8v0avMRqjnZOsr4v8DA9evtxu3t2BxviZVKaOLf8CHpyE74oQ+gD+bxqiAS7Mzh7et/7HrIYyn7vTAe8QZOcE0tiqjaKrD6DETSZxYj8ECAH9hkJeiUPdlu5lpdeMnBsxcS3UGU245nQO+iQps6/cdaLKAVV2wjlfEaABc6jDrZ4bx6XbPQ6lyIXXuF45zXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBqSQSeJaZhURC6kSm/1FIRVRGLRnc87GbbNLDQTA+w=;
 b=bVzEfJjHdNuyJyFXCnnT+U79UMbUzIDDyR4OpA46I5zPRwrDYmAQgKS/iKqZ6qCLUrf5rFo0HqESxHcJY1Mbxwb51JPKJbsTEGFBsEIBOu2YyWiOYREmxLxJZLnP7Kps9abz2hgmHXK2bbrhoQoX9alcj6s2rXHhSATmFBSw2LqgT7JUrNC/4bGA6zmOyzC8NRjl0qrVK5QCDwhv5AHKb/f2vxr31b2aaeCg8kz8EPxXUOCyXHdNvytc212HLTN0/6m0wXvDy0obGrTQb7zpZ6j7nDTgbikGX/2yPmCj6w7kfepLK4Tuhu5HMDbJkna4dgO7z6evHoI5LVUSwYsZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBqSQSeJaZhURC6kSm/1FIRVRGLRnc87GbbNLDQTA+w=;
 b=5iSFX6A+UWNWItK7g5SbCenVbgdPfqKMv+oLi+SvkfLA8VLQpBZKdCOBknddfxrBbswJ48+aIUeieIRNDx8FBLYnCTolSm7WHIykmpRdJI7jDQkpy1y0XuPYVce+Q40DI4J76WHZGLYxOo2c20FYEJ6lZx++DwPp1zZ65nL/y3c=
Received: from DM6PR06CA0014.namprd06.prod.outlook.com (2603:10b6:5:120::27)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 21:47:56 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::7) by DM6PR06CA0014.outlook.office365.com
 (2603:10b6:5:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Fri, 21 Jul 2023 21:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 21:47:55 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 16:47:53 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 3/3] cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()
Date:   Fri, 21 Jul 2023 21:47:40 +0000
Message-ID: <20230721214740.256602-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 510d81fb-1c0d-4653-cbd9-08db8a342470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA9mzmPUCA7lZZ7o9gtHFr0WTA0C9CM4pM3iNvTlu9pYZHPD4ThFSiQCAcLnMp477LzHl20gFef7wlqf/EqtEUWRLD9PjYirDJRjCZz4Fd4f80WKND20TgBVrdlIBioIPT+Uh5TkqpwGPqfijZwwOn00F+oWPURYr8jeAaW6exffdaFAvKRClGQ8h6XEAj9C9r9aGWzIaPcRkR90frPMm7LqudcD3MH4YjLExznDBJ9CP62+GmZszJn5qDympn37KAuKoIUiYlFZFa8qoyjMZ5iGtmlxvookr635Xl2llzLiQ1b4Liqp6rerwtCwdUmhPJsG5tSjWxUhFXBY0ZP+UgFhX0TwVDo2pyVq5dbz7BQR9Gq2ft0eFeu3R5JJH6kz/gDnj51JmT/6STEcnYwW4ar0v7jt6zEmesQTctpN9wK+SUEXJZeFN/RRlphtexYZYy7J7hqYkmBo1EWCZnDlZlVwVg1NcJv4gVIsClegTCDa5zWLrIdm/1odPIOLFrr8BuJWcyXtO8zDX/CY0ID9h/ERGBau7ALkwdW8ADW3+bD2avaPteWxNi1+LhY+FtOZmHdgU6ncR2P27vD1g6EVnwTO9f0A9xGaHM3eGcWfwwezrlwp7OiJYNkD8tsw3V7QP0bvuHiY1JfoHz+j9hRMjPv1N65Xs6doS9P8DFngFuJun7X9neHralGpCF/Zit6Za8TOuWA4D7MZ1qnrh/UpQJ5VDdt7OtAjWQ3OmOVF1era6czr7noUdowwA1TkyP+Tjo8rRsDuKMhC4LmInPWbzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(70206006)(36860700001)(7696005)(6666004)(81166007)(356005)(4326008)(7416002)(316002)(8936002)(8676002)(40460700003)(2906002)(36756003)(5660300002)(82740400003)(47076005)(70586007)(16526019)(2616005)(426003)(186003)(1076003)(40480700001)(26005)(41300700001)(336012)(86362001)(478600001)(83380400001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 21:47:55.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510d81fb-1c0d-4653-cbd9-08db8a342470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reuse pcie_aer_is_native() to determine the native AER ownership.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Replaced pcie_aer_is_native() at a later stage for automated
	backports.
---
 drivers/cxl/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2323169b6e5f..44a21ab7add5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
-	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	void __iomem *addr;
 	u32 orig_val, val, mask;
@@ -542,7 +541,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 	}
 
 	/* BIOS has PCIe AER error control */
-	if (!host_bridge->native_aer)
+	if (!pcie_aer_is_native(pdev))
 		return 0;
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
-- 
2.17.1

