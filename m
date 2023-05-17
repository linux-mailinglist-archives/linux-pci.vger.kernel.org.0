Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E8707804
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 04:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjERCXI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 22:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjERCXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 22:23:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2533C02;
        Wed, 17 May 2023 19:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwaEM3vBTuSwXXm5Yoi4Wq82jNnDfNdPj2PoZ3Fq+aa1iTwCtd5CKg6bsWcqpuEuHT37V18fFd+0Rzur8Had4sv6t5Z31oWdLd2pB5SXU7zwLcjqcT5hyqVEjPROSY+gaI6XeGu/cRFwITrqMePZTYlMKQ4OcLaPaU+ScplwwKDnaPwfdrkJbC6t0fliNfumFvU59zvRLyhuiX1x2AF4ovXDOofA/xFah6+72H50ZKoF3cWpPAnbAfK9xxkm0IlfwVmO0Pntew+IADra2fX+22vg8mUTk2ofPhDQQ7tbhHPM8mUP36czCmvKdX8LZZk8EPk/yDcEZQBQj22BLfMkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbGF+htYPBWIH+dOZaaS6XNlN1YI5wjIp9k8BvnMQ9I=;
 b=E06dZeF4dWu16TFhgSRVNup2kfqzoXEQNoCMnZb+o9eC9VQZqSRBfM9poBehBvVX/VBaslrsne+dxxpm0EjC9BksOLEgSPK2BkNOYLc6POAIQIn5ky9u8ZW3w4SK8nkQzkV0jpjHjNsAlyILw8rS8khjFzp4sB5xR1FPkoWahXJdLVxuakmH98PAbLDHA0O0Z14NY9BQ3XvkjsWX9dkAbnbhPDvpnRWH4U2XforSF9inE0ZiewvNEmCdwDe9F4Qb9snbjLkH9fJLNseKbKMpk+dhlWeLWOe24hpKo7rbgJnOSOGCHhH/aVQ9+aHBQmxgfJfphO1VFHAm5YTsMgkXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbGF+htYPBWIH+dOZaaS6XNlN1YI5wjIp9k8BvnMQ9I=;
 b=HbXY45xZn5umFJD9LeNhjKvd8yCIMarctsy2/TTDP/BwFQJuFw4sqLxRHXoLrC4TIosf9LiruGQGfVaA//xOKZR3s4a6HL01naUOArPL2o67cEtnsqkB+ONd+M/1X/U647JV6+8ankxnm+vfmQDxNQ75QmdQeVzot2/F/nYM6Kg=
Received: from DM5PR08CA0045.namprd08.prod.outlook.com (2603:10b6:4:60::34) by
 CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19; Thu, 18 May 2023 02:23:03 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::47) by DM5PR08CA0045.outlook.office365.com
 (2603:10b6:4:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 02:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Thu, 18 May 2023 02:23:02 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 21:23:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: [PATCH v2] PCI: Don't assume root ports from > 2015 are power manageable
Date:   Wed, 17 May 2023 10:08:27 -0500
Message-ID: <20230517150827.89819-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 67598d32-0edf-4776-bb05-08db5746ceb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/8/Etjgok0L2y73BBjGZGnH0KpR0ppoD3ELSx/wNwSSTGraYb/SGKILKYPLEC8dh4sOT45pVJ1JuDs+scv9TOpiTH+Cr6yk/CjpPV/u41bnsT7fKleJYGAkYpDL3xPvkg9TomE85IjP7GiCTJQNsaoCtVxN9so90EqGGGD/FtkeRc1MjzNzQ8YxUZ+qZWjXNH28c+ex7+AvLWARQyVt0muTJIe+pOIKH4zVCCM+xAAAzROtWbC6HQW/QKuXM+pDgMzrwdlmlN0TwedfS29PQp/qiqAoVdjGW/4kb7ngYAbmLnJMvjD0qkGg/OARc7vDtnJdH5aVO5FWqNQJBxFJdEUcXCGF9JbnqvaV7UcLh3MszSexoUR9Gb17ij7LjSsa7sWaeXBYknhcyigRn6/LcsWgmbb25DptMHoOHPHKmu0BjZU20NoFO3xb3MTcKU6yu41HxudiiyXRrz5X4QmflgmcMFOyoap53lBOe96xkv6KuTJe+sjuzVIiQdNvH5yjtC7iFZAfLb6pzjFlMGRU1wmL7SawBSn6a7TjsGO87Qn6mzq7zbOqbo+RhHk5IFLn+ahMnzyDQsENWzZf9jET9yzt6qO7/fw1xCkUCsPFNq3OCfCCHtGq9sCCNSgI/ROIhVV1zCh6ukmFORGDeMNgwsOoBJWwpeIaxEMWxMCuBtOmhrtF1qwlIi8bYgug3MV5fBkuRysOGdT5JsOmBk7jw7s1kd4DE594TTs5feduDIJsjZolauNI2C5LUmal1Q+uukmo8lUXTi5ngwBNuUi7fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(110136005)(54906003)(70586007)(70206006)(966005)(316002)(4326008)(478600001)(41300700001)(40460700003)(5660300002)(186003)(1076003)(16526019)(44832011)(8936002)(8676002)(26005)(40480700001)(426003)(336012)(83380400001)(2616005)(47076005)(36756003)(2906002)(66574015)(36860700001)(82740400003)(82310400005)(356005)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:23:02.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67598d32-0edf-4776-bb05-08db5746ceb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using an XHCI device to wakeup the system from s2idle fails when
that XHCI device is connected to a USB-C port for an AMD USB4
router.

Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
suspend") all root port go into D3 during s2idle.
When the root ports are in D3 over s2idle it's not possible for the
platform firmware to properly identify the wakeup source.

Comparing registers between Linux and Windows 11 this behavior to put root
ports into D3 at suspend is unique to Linux.  On an affected system
Windows does not put the root ports into D3 over Modern Standby.

Windows doesn't put the root ports into D3 because root ports are not
power manageable; they're missing _PRW and _S0W.

Linux shouldn't be assuming they support D3 just because they're newer
than 2015, the ports should also be deemed power manageable.
Add an extra check for this to ensure D3 isn't selected for such machines.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..3fe27aef09e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3010,6 +3010,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (dmi_check_system(bridge_d3_blacklist))
 			return false;
 
+		if (!platform_pci_power_manageable(bridge))
+			return false;
+
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.
-- 
2.34.1

