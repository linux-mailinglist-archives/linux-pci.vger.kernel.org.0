Return-Path: <linux-pci+bounces-394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4ED802B90
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 07:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BD0280C65
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 06:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0608C1F;
	Mon,  4 Dec 2023 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WpVtBx6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D6BE6;
	Sun,  3 Dec 2023 22:06:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBsiymB5RLbICgpS9TpCKOt3SG3APBuv0racpvXV/uZo2LWCs8LEDtsZ10eiIn1wE3AUdTzsH3bEFwq/VfZxua1d8pQDjuzg7nvuSBHnNntBXO0c5cn+zR9CGYBpAyoRGyGtav/9BmsmEkDAbzMZLncttxw07shMsWdxd5nbAGOINGnofklp9ScJWahcVuhmcYwrWjtYyjBtM+kYCXZW7/+EF+0RFVwta5APQ5OaAM29c3cnFK6FHZeYW1To2s7mEau61Wi7i1E+XwoW00RgfYhqdONEFdPuyjZ3l1vvOmUW0Mo9N5XTafndAXy8GHMrR0E3n+TEIaB10wyS06kP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBOjnQXqNflC4ItaUUNYlYGRtjErSAnO0hmNpv/7ycM=;
 b=CGXNIENNdCeS5BYB90LHuEIjrw1Jb0PDNT4XhSKMQSPEbj9m6JZtM96i1LBZ6Lpili6Za7rU7n3ctCJXVQ4Pr4F6xF3S2fFrcgV1G6SVMCg+ORGWVQph+TEzQtzfWwjVWqfTXQvb3yx5YOi1KaSbL/GeMvKhWmi9xBHCYPurDGgNvD801WSC5M4qDR3wEUWMCtChbNXIbNUrVTVIco+9wMx9+ngUUKqJnCfUBCH13YG4H3R3ItA/lHqRwObPb1SuEG0p433IM1d/S3A4D5XtEg38bVSuSRksx0HzzDI7AK/hLILyWYkUhrFf+jFKPPF57QqN2IhUVn9faiZzN23bCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBOjnQXqNflC4ItaUUNYlYGRtjErSAnO0hmNpv/7ycM=;
 b=WpVtBx6h9tNCLNJ1oaIe4wWli7q4kp34jzB8fJmBES+O3TLUkxh0xkv9cscAlKyaErezL8Rnq5t/GXyG6D+W3u6/EI2rCOE6qUUK6VHcqrlsrBjd/zM4H+8FAHd26ByYgY+tioQuJ5SPxhG3b8xgdFJzzQljUA5bDGzzzws0T1s=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 06:06:56 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ba) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 06:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 06:06:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 00:06:19 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Hans de Goede
	<hdegoede@redhat.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "open
 list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:X86 PLATFORM
 DRIVERS" <platform-driver-x86@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 2/4] PCI: Refresh root ports in pci_bridge_d3_update()
Date: Sat, 2 Dec 2023 22:10:44 -0600
Message-ID: <20231203041046.38655-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203041046.38655-1-mario.limonciello@amd.com>
References: <20231203041046.38655-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0243b0c5-e59b-4722-369c-08dbf48f384a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IYmBJmvMWaLgQDn+DCrXee+yavy3yJxXK6giTP4TGrldBdMbmENMFcu93XxnLBNwj4JRZiLqjs9vG59deZRz0tCAd/Hw2hyogktYNaKFI4hkKAjnMfcusk1pZIElBA7C0su5idY2ntti+EQpnUvchJP05cdW1jmT1sBf6aSZZDIi6Cnr+KIWRyBxdvlAabWK3HcXQzjHWrGIcliTGMmLpacQ1az1CvKZiNeQWMU9w+61si7sAe+M1UXOtevw701LPtae/W+gR3Bsq/+BVa++gijt0UBO0GZ+bK/G88tU3Uzx6ATMYPYkF24J4j31SgbG4Y7sbE3wx2whvdOGkq7lgSo9F6s+wF5STs3QWkaft8yGmIl/j+JWfoEsDVdfgijCcBgGvyPvykEmN38B7u7t87mDQwUSGtNwzLnIbCs6QRcR4FPb9GMr9R5mFOAiudxxU0kfCgS8O7/2ATrdgI11+NKVd+wWbKUfghG0JQSi9r57qLdDegXve1DbbLmRy7jCGHDa3Rf4fV52xjywU8XDcI9w2kJgDHqPWqXdc0Nr+FRLtoOafMHR6oEx0PPTKVQElmWndao7YW0h33KpDVLLWAKSYgTmBdYzWZsCoUrBYJyv5Q2NWwqyj0eLJeSA2rgau16Sm7+HKNDmTkcp7nvVFpApPQ7p8Q2J0MjWrKGooSwWbw3Nol1U2oWvOO8k1D2SXsSRNlhMa89UyG/PPHTABbJCy751hA9G7VOg+b6HcyLRqe9trEf3foNHfhIbvHSrP4TUOxzps7300qHTt6bxyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40460700003)(54906003)(6916009)(316002)(8936002)(86362001)(44832011)(8676002)(4326008)(70206006)(478600001)(70586007)(41300700001)(36756003)(2906002)(5660300002)(7416002)(36860700001)(81166007)(356005)(47076005)(2616005)(1076003)(7696005)(26005)(6666004)(83380400001)(82740400003)(16526019)(426003)(336012)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 06:06:56.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0243b0c5-e59b-4722-369c-08dbf48f384a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
X-Spam-Level: *

If pci_d3cold_enable() or pci_d3cold_disable() is called on a root
port it is ignored because there is no upstream bridge.

If called on a root port, use `no_d3cold` variable to decide policy
and also immediately refresh whether D3 is possible.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 72505794cc72..3d4aaecda457 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3023,6 +3023,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (pci_bridge_d3_disable)
 			return false;
 
+		if (bridge->no_d3cold)
+			return false;
+
 		/*
 		 * Hotplug ports handled by firmware in System Management Mode
 		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
@@ -3098,7 +3101,11 @@ void pci_bridge_d3_update(struct pci_dev *dev)
 	bool d3cold_ok = true;
 
 	bridge = pci_upstream_bridge(dev);
-	if (!bridge || !pci_bridge_d3_possible(bridge))
+	if (!bridge) {
+		dev->bridge_d3 = pci_bridge_d3_possible(dev);
+		return;
+	}
+	if (!pci_bridge_d3_possible(bridge))
 		return;
 
 	/*
-- 
2.34.1


