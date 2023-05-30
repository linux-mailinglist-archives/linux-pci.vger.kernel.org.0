Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E3E7169E7
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjE3Qko (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjE3Qkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 12:40:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFEB8F;
        Tue, 30 May 2023 09:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxbIy+C65SAII1uhNHIv/SmxhrviTH15F2+B/ibqDWs2ZPfoADuDr+1o+reSEJK79s0b5O3m8YKifbdUuaXOaNzA9XiVburcJlIDGLPQ1jMV5pyZqFj6nhjw19DnRiBqHTEcrLu87jkVv4zF22nmBwoSKHgUc9VQMuuTDCTA55va1d5WdFqH8c72XpSQT71w8rPx4bt6dqDsT09xh+uiPWk1YUrEWx+DM52PdIJCbdBRrGc7eMhkzt9q6ws5LZOF7RGFkd31BfMGIRJa/z5T5ECKcnY2BmjPB2S7s3aaRkffU68m3B2rsgzFsezn41xleuRHjKw+uZYOfNgDuTHfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnwLJraND0w6rMhO6KaGzzAXYxKHN1gH83cQi2bGtX0=;
 b=JhQTDxQZ9JlzOG1LUCaBdhXdBgmEn1MvSNyaSyne1EovjBMZzHria8lflmyX2RR1BB8GxD8gC4ppjY2pFzacx1vEToOVddNk83vPk1n13OE01deuKGli5QHqLd/49CxcJ9oSFSe6LRI421UCn0RwnjTtv00/hL8GGWwm2rEpX/ajNlbATJ9kOUsR6WggFf6zHhxta0Nr8cD4kZ9HcE26VDu7vWMt9gl0G5+HaDFU5yZcnUQeSO9IDeDxZssSXK2/TKOKsDw7CnTSJwTWUuns2mnxAazhXEhJRdQWk8BY+o3TSeS+H9u20GD9qmAAlFpnXDPaRtwMSzqCI8qhvTGh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnwLJraND0w6rMhO6KaGzzAXYxKHN1gH83cQi2bGtX0=;
 b=3TU0zT0+LfSWJ48w8wSoO6dz5EtFn4QSQCRPBjNS7uIXXxyPS6naxO8XCrlh9iUD90rX4IUkSR9d3IHjrpNjhTYnvzf9otglDjeGuN3IrHzZV9wRth2dpjG8a9SoLbypCAhCrEFIQKT1lG7T4nXPmV/qnj2J+SVvFX8bby2+8Ds=
Received: from BN9PR03CA0525.namprd03.prod.outlook.com (2603:10b6:408:131::20)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 16:40:39 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::c7) by BN9PR03CA0525.outlook.office365.com
 (2603:10b6:408:131::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 16:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 16:40:38 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 11:40:37 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Date:   Tue, 30 May 2023 11:39:47 -0500
Message-ID: <20230530163947.230418-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530163947.230418-1-mario.limonciello@amd.com>
References: <20230530163947.230418-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|DM4PR12MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5204f739-286f-483c-0089-08db612c99c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Upj25H1hKnxMB2jAXXO9F2wpxJ2soyta2n68xxaN5TZkIMxLiHeAZRCQOc/mkYcSR0WEFZSsozBUxCUCrZCNlpkKu9l5rybDWcCS11jnrP5l9ZuDoKo2JfAGv5zoD57Qh8LxfNiz4jv8dmI2Lmhiuta6ffw5N1KeVON6NukWNRqncklgq9Facz0HHnK87E+aV2hg+hg9e3zlEq4ZZbfkge3Ey4c8ODjBebC2CFkffK2hhcaU4cSmH/DeQ0XLO4YDsjlhS+MXepqKNcKr813MWW39ZPTi5OYIIe6III3scARZagXQAKzT0vzWocqmMSoiF/LZJG7prUZ098yxh1NB4ZFp1VwX81gOZkRhzRWAhhPdk1lIBlf0DiXHFvRU0dxLfnCoZCpqg/LFtDHshle/uglLwfvkaLM/q4BDW+tTvI9GSk96MlRbKR2sSJuQ95Zr2TaTlhUtk8RXPL8dabiNOt3TJMoZ6x5ppbRrFA+ex5pm0ECY0EPhRp41ZftGqoHk3OreBdsPSu4UhPgTa8kU7wKP2Lsqv0AZIQmWWFQgP3FqCag1XhIQEVP/GODyOaODMB+6dE5wslL6SAN1xvI9sVew/MdPccOWLhfFyC6zRgP2VbRHLASwK5HbQBcG0RJIhLkpydf7PxfW4AT6gzXmOGjHaelE7rYiMSfgMmuDJwb9OCNGw6YB5qUWkWC6xN6F1T3x7iQ4be0T4extC43EBzSPGsSgPweePccnbz8me5F7jMTvnA8j2KNggqXF9O1NZws4pOVy+zYfrOAi9bT4gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(966005)(186003)(16526019)(2616005)(41300700001)(426003)(336012)(83380400001)(26005)(1076003)(66574015)(7696005)(6666004)(36860700001)(47076005)(478600001)(40460700003)(54906003)(4326008)(81166007)(356005)(6916009)(82740400003)(70206006)(70586007)(40480700001)(316002)(5660300002)(8676002)(8936002)(44832011)(2906002)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 16:40:38.8934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5204f739-286f-483c-0089-08db612c99c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using a USB keyboard or mouse to wakeup the system from s2idle fails when
that xHCI device is connected to a USB-C port for an AMD USB4 router.

Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
all PCIe ports go into D3 during s2idle.

When specific root ports are put into D3 over s2idle on some AMD platforms
it is not possible for the platform to properly identify wakeup sources.
This happens whether the root port goes into D3hot or D3cold.

Comparing registers between Linux and Windows 11 this behavior to put
these specific root ports into D3 at suspend is unique to Linux. On an
affected system Windows does not put those specific root ports into D3
over Modern Standby.

Windows avoids putting Root Ports that are not power manageable (e.g do
not have platform firmware support) into low power states.

Linux shouldn't assume root ports support D3 just because they're on a
machine newer than 2015, the ports should also be deemed power manageable.
Add an extra check explicitly for root ports to ensure D3 isn't selected
for them if they are not power-manageable through platform firmware.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Add tags
 * Fix title
 * Adjust commit message
v3->v4:
 * Move after refactor
---
 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1fa040bcea7..d293db963327 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	if (dmi_check_system(bridge_d3_blacklist))
 		return false;
 
+	/*
+	 * It's not safe to put root ports that don't support power
+	 * management into D3.
+	 */
+	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
+	    !platform_pci_power_manageable(bridge))
+		return false;
+
 	/*
 	 * It should be safe to put PCIe ports from 2015 or newer
 	 * to D3.
-- 
2.34.1

