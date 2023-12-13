Return-Path: <linux-pci+bounces-893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D7811C65
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952671C20D53
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840DD5A107;
	Wed, 13 Dec 2023 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="amwEBJQf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB4CB9;
	Wed, 13 Dec 2023 10:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqHaIrehZU5VRXwz+PAitJuocjFdakOdpszCciN9R/rPPBJ2Hb36f3lawGOA+eeqKRIDao01Zr6imYmrEQ9yLDnUE7fcVsiqUaEXlhC9TIsQmIVkNl/8Jo9OOm4NS1g/zMNN6CupShJEMm9At9xFKkCH3UHZ5ADLEw/fx6QvRGJ9lUcxQdkNxxGboKCAN0kVeCOiyvBwBE9rm8HdArDRTXPCcvB20zgkuienkDrejpKRWFX4s7yup4OM7KORcaRdB9fBErjE35ncbaCQHoQRFi9g4fX2uy4sjtGZvBQGsuQkE2zg1AN46oLy2us5uP6q1wSWr7So8jKQEg9SjASFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te3kowBT+jbDEk4VX+EtZh/khotxt1fF/P+qjIC+yDc=;
 b=R1mK9tJneQBq/62C8KRRasPIymJKvWO2gxM+Lgk/WVxOca+6MWkGyncJI6Qe9SeMSn++OInw1Ep6NjJDoZzLCCNhEkkR9EbOuxU3uvHD5V9h9//vo0SOYFLAWX869tsHhVjWlcm1sy2/NAy3irQ64pk4RUEnLG3X5c3BMkOvoor0rYk0GWswvGhaMnzzrpI9ZiJxa544gUu1P/rqYzpBoMGRxetvjSu5TmhJNt0IiwbvQgLB21oVUlUteek4KInkh9HGu5dLumudbAuXuixp1TJ8q5Op94KuayO/zTYDODNhdJQf0WK0xcHpnX3ECBkNUAdDwXAx1OojmzQ608g5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te3kowBT+jbDEk4VX+EtZh/khotxt1fF/P+qjIC+yDc=;
 b=amwEBJQfwTFZS96vwJueBKExEEOrIKdx4fGnrw9T9wZJ323p0mH6Aid8SvLlI2qBwCFasw+noaM3lvDwn1oa930+9c4088oYLbZez7R2WLAgqbYkQEcJ1/DfSGjGgVaMvwwy8wiMUpYZ81+aXcghesan+v5mSaxy3rYvNNbQf3Q=
Received: from BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45) by
 SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 18:27:18 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::2) by BYAPR01CA0032.outlook.office365.com
 (2603:10b6:a02:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 18:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 18:27:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 12:27:16 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rjw@rjwysocki.net>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <mpearson-lenovo@squebb.ca>
Subject: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown
Date: Wed, 13 Dec 2023 12:26:56 -0600
Message-ID: <20231213182656.6165-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213182656.6165-1-mario.limonciello@amd.com>
References: <20231213182656.6165-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd68045-4312-4317-a9c8-08dbfc09234f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KVAOi+hJeynuYf6L6vVSeiLTlOct0HrRqxEYadE94xHq8YUSm+v+6BBYTj4xnfGjcPVK3Ldda9Fk9Sg5/Hie/7pI45CPL2wg+eKgPXbx4piwt5R8BiIKTOfhDG3LBQV3GzYwI0BW5sLrxgPADcrhwoS/03BnPCC5F/LDqWlR0EccXqPgF+D9qcHeORIFqMVajbh/S4H//KeY8jbvtI2Ul8nGJw93y8k1TxCAVmsbPUGzARDtt7q47F6Oh7OtKIwFHsNzGSJNKs9MwqdrDSNJH/A6qw8aELPO2KTaST7xXIuxO/mnn1f0Ac/Xxz9gKZIQYRhGV1brtPxwuzeyWwFAPdhrNV6Lw4+Oyoa04oNVG8prN/cYqBu3LkMs0Qzw9MwfW56xnZ2G/4Xjt4AqGBZ4O9pTHsPNXXRb3W0KOtmOrwbrm/GAYhBHVjnQsspYIPUCvQfKl0S63j70PZOx7qU21RSo1PCgjcE68bE8vXoWGzlYl50mab/3fTWtcNcpY5nseiwlesWgjAqgcN4UMy0J2N34529KqvyWPFxMjtzrjM1E/xTdlG9QeZMccSz9acsmQJTpYv9gbQJ/Y9xiUC6sUETA0GZhqE2rV6oRu4I34ds3YjCbKcSQyXcI9+E6wvhFwu6eIOULBVkoQaFYnbg2ROoKcrJ/CioIQ5qjY0D4NpSo4r9Ou79ufeBicEjPc1EE0exxh7KXcg/OGELZBYh6GtNh7bDxPEg98bUDcBL+daGXl6B1MdO984Vq4uvc0YAr+1uRMgWzocfT4BrFSXT2gLVk31ReROZr8OlhVk2rduw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(54906003)(70586007)(70206006)(110136005)(1076003)(6666004)(16526019)(2616005)(7696005)(336012)(26005)(36756003)(426003)(86362001)(47076005)(82740400003)(356005)(83380400001)(81166007)(36860700001)(41300700001)(478600001)(44832011)(40480700001)(8936002)(8676002)(2906002)(4326008)(5660300002)(316002)(40460700003)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:27:17.8823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd68045-4312-4317-a9c8-08dbfc09234f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245

When a system is being powered off it's important that PCIe ports
have been put into D3cold as there is no other software to turn
off the devices at S5.

If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
power resources may be left enabled and devices may consume excess
power.

Cc: mpearson-lenovo@squebb.ca
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pcie/portdrv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..08238680c481 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
 	if (pci_bridge_d3_possible(dev)) {
-		pm_runtime_forbid(&dev->dev);
-		pm_runtime_get_noresume(&dev->dev);
-		pm_runtime_dont_use_autosuspend(&dev->dev);
+		/* whole hierarchy goes into a low power state for S5 */
+		if (system_state == SYSTEM_POWER_OFF) {
+			pci_set_power_state(dev, PCI_D3cold);
+		} else {
+			pm_runtime_forbid(&dev->dev);
+			pm_runtime_get_noresume(&dev->dev);
+			pm_runtime_dont_use_autosuspend(&dev->dev);
+		}
 	}
 
 	pcie_port_device_remove(dev);
-- 
2.34.1


