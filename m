Return-Path: <linux-pci+bounces-17861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF29E7587
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5EF28B67B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB72139D7;
	Fri,  6 Dec 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B8tOCm2m"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952C2116E7;
	Fri,  6 Dec 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501566; cv=fail; b=JG54JsWIKv6SSCY7TO/llsqRZXKACwc5wy3+RNYOpc/zhOYjiiXnsTs6oJyUlvCADspzGvFF3KutKsjxuZnLVWFdxqOyMfn8Nsj7rPQrDpngCmDXiY0jhNm96VqILeL7ckoBlBc0mnD2Wc7Mj9cdcHlJK68twjsPMiYtT5IYLEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501566; c=relaxed/simple;
	bh=MwEf5gtHST7+XitqXEEhokGYiEmYO6q5w/15Zb/HHMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOcmsLOEVRy7mGWCwv0cTkMxZevFo+FhdeknM+KIj86l+V6TUformNgakHcDGOd/gd+FeiqCQCKQ9KrAExAWx2q99DVqjZhaOuajLRWh4j7XYX0NAYgz1vVxLD4f4mQ8uInrF3KPi38a5zxiUSDUunaImCh5rUEVUGXfNatMa2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B8tOCm2m; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrSz5wNRlTjC1NoVBfwZe7RnbBUry4RJ32gP8485WD1Uxkgmt667WHQdTUFh8MQfyKkrbsKDqHd7HNEynQ21itCVM+GCrLr2FFw+4U2yBGVYPT/mmaxG2VwA6bePEOQzkp5fiKDBzxGd6FTNLqBaB97NjUAXWvARRFewh0cDnMotbxORVD2l77SZjHtJN5rtrtCnioks8XGD2WCbr6pAPM1qGISiZsFcV472yqcZQakj9KimOtQaq3lOEYRXHAfhtlpHSsdGQgZSDAaX36OfYKFXu+4MjbUXKFHlBwKTkeyxckgBj0FM6V569KQ20j+6kOxB5KUlnUVoQ/Bc+1PbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xensgGzD9KbdIJGoXyvlN0pk+M22gE0tYGWOT+VnKcs=;
 b=h1I+H7n1u8cPbNiomBS8iUramPM5Jd0ba4qYxILOi/TywM+xXE2VQalzX6Z5NFsF/mjEhNiHBX1ntawqgy5Mpn3ewHqxXvSGkarVwI3QUImjoyM1TnMyBxEr0JZPFKvDVlogyWzIBBaWWE6+hembObOSGwCgzFnytQjdpYRUCYiFCy0K833obqil9FK0xz7lsEClRaFR+cpCtr38TKX7mTZRbaXf4o9JTp6ilwBLRsa85BzFu7vwCwmG0H3c2M0iCXBnqJcHF3B78aRJ6+iEse6p/wqg429hfqmXADFuxZAfj6PH5LEEukHZL4lpsOfc4Ds+Nx3Py3h3XUT7OLRFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xensgGzD9KbdIJGoXyvlN0pk+M22gE0tYGWOT+VnKcs=;
 b=B8tOCm2mNl+BmJJydP2HSGkppZRv/A/rs8GcrKFy0+Dg7sJvxWQf7NiBacsx48lCfuNmkNj+q0tZ30Boecv0kymrnpGhtpjJbF5RIvMdKuOeAbtBphvjEd0oULxf6M4+PsoLSUVDOxP/h+j+SlmRuFmj6WQxvV7LxOnYHTs+3IU=
Received: from DS7PR03CA0252.namprd03.prod.outlook.com (2603:10b6:5:3b3::17)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 16:12:37 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::79) by DS7PR03CA0252.outlook.office365.com
 (2603:10b6:5:3b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 16:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:37 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:35 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Naveen
 Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>, Suma Hegde
	<suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 15/16] x86/amd_node: Add SMN offsets to exclusive region access
Date: Fri, 6 Dec 2024 16:12:08 +0000
Message-ID: <20241206161210.163701-16-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206161210.163701-1-yazen.ghannam@amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: a22ebeac-19fe-45e0-87d5-08dd1610cd50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TZ0Jy0WJdB3E0NSv9nmqAitDFFoAIuGc/L2gQ5p+qfPQqhXuJ3t+WbLLPyFJ?=
 =?us-ascii?Q?gMgzgtgx8Ybb4gMQ28DAwflNEPO4GWnpK11iW7IrZWSZKlYqGAlPFb+LSUpE?=
 =?us-ascii?Q?RCoPrXIOT87G/QdKBcEmkaFfd3y4HmVAbpniNXIxF6g4P0uDd5WyCXXRCVea?=
 =?us-ascii?Q?RHxJ8YDbH0aZwwoBeUmvUwqWz1Vw/A/DwCODmuZ+DrUzSzhcdIgJ1HfsBKQz?=
 =?us-ascii?Q?JvaFVHqP7h+rluFhsSiHkkZuIdNmiBdB5TYsRxd4D8bx8i12fW9KOzbF4iqF?=
 =?us-ascii?Q?7PK9MJjGA9IHdQJ4V3nAGX6paMC7bvDUCPDPkuIAtBfxWpWW3NDOBM5gV2mV?=
 =?us-ascii?Q?Yeze92Enjys/pqM3HmwpT0RB1BUb9M05xUdpKfD08AU3t4f3PrcALMt5kVkY?=
 =?us-ascii?Q?F2ZxNre5HzO0Buaens+17SH0oHvEiKn6ZKPLfYnqeJ3FyIpm+/SpYSGzAzl7?=
 =?us-ascii?Q?aRgvUqgj+LmIxX32ZXrwIpDRLbnl7pqng5vjKizuz+0ZqjjNpekQsbc1+WuT?=
 =?us-ascii?Q?8UyleIgj5baUkzJT8MzFEdL2L6NPo7w3zvwyHGmJqdxfz75CvroSj5iIq8pL?=
 =?us-ascii?Q?XOyV3XQTiYIU81RlR4X1hw7zLmw6DmgysLNC2MUdPr4HeDRlvj7c09ieNvlo?=
 =?us-ascii?Q?H9Cr+jjRj8QsAN8pJp62hH66sbC4c7VzUW+Fb6YXahZIZjvriN7pJTG8MdGL?=
 =?us-ascii?Q?ViOSABLVtwb9Rr6PSgEVyUlAV+loBNARvmiE1Tiwwqblq34QfQeZqlSgKJnd?=
 =?us-ascii?Q?mWN6M7QATci2d9OmGb+bYQwjRtVBkqXQcb1M0gWS/79Ku7VPrjcgEb/mKmor?=
 =?us-ascii?Q?Oe/uyQCNLfy+u2Yd+FsyW9ZC9nbrmueC6P3XUpgBBWuQlEfFP6TngB2bmAN8?=
 =?us-ascii?Q?ZRF2DWxKtHHISZ7p0Ho89zOTXMe0f/yNAXb7ulQKpgNSK5Eq7QMnjM/zs7eD?=
 =?us-ascii?Q?72p9ZYt7PhOoQWc1g/AVJCssNN5qri2vJ9qdkH8Gwt2UmorS6D+TqbvtQQke?=
 =?us-ascii?Q?NsY4v+FnqlKPuhm6UEdGpEWpEGUmr7eHKeU0FM2DGXnEz5VadpQRcZUIzQkb?=
 =?us-ascii?Q?I48qN3wGCgepdXMZqs0K6EqYwAbpUe3pi/l9n4+Arz2uvlb+7InSSxgKIeUK?=
 =?us-ascii?Q?0HWuTWCCDGOqgO9S+9jP7bjFM3o5ZjNZrxK9v4F5OwBMqNnnZ/pIoX9LQ5cI?=
 =?us-ascii?Q?4rzZuNA3gFpxc/76eq/v+F1iW2DenTz7yIhobB6OP8PDM5n5QUGze0a7Ly5i?=
 =?us-ascii?Q?dvFRiZHdZfTJY0pK4+w7Oz2F0z/3MtGsYdc0MbB21USmuTiNb44NJbdaRkxD?=
 =?us-ascii?Q?8K8Qr+SXhxx1xlxAHT/GtnBByeK/0z77dIl2N4Q+eu/04aUZA4FH+k/qqWsa?=
 =?us-ascii?Q?gLQjdIp04Y6Y/JT51slJ4a4yMaFapLP6vvn6vrzdNmOohic4becVrUhPdTV2?=
 =?us-ascii?Q?DCdzVA6gmACRpXcbtFb+QcezFhsGypTl97Nfc3uWIWtW+ltqBRIfGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:37.5279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22ebeac-19fe-45e0-87d5-08dd1610cd50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409

From: Mario Limonciello <mario.limonciello@amd.com>

Offsets 0x60 and 0x64 are used internally by kernel drivers that call
the amd_smn_read() and amd_smn_write() functions. If userspace accesses
the regions at the same time as the kernel it may cause malfunctions in
drivers using the offsets.

Add these offsets to the exclusions so that the kernel is tainted if a
non locked down userspace tries to access them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-16-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/amd_node.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 65045f223c10..ac571948cb35 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -93,6 +93,7 @@ static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
+static bool smn_exclusive;
 
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
@@ -149,6 +150,9 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	if (!root)
 		return err;
 
+	if (!smn_exclusive)
+		return err;
+
 	guard(mutex)(&smn_mutex);
 
 	err = pci_write_config_dword(root, i_off, address);
@@ -202,6 +206,39 @@ static int amd_cache_roots(void)
 	return 0;
 }
 
+static int reserve_root_config_spaces(void)
+{
+	struct pci_dev *root = NULL;
+	struct pci_bus *bus = NULL;
+
+	while ((bus = pci_find_next_bus(bus))) {
+		/* Root device is Device 0 Function 0 on each Primary Bus. */
+		root = pci_get_slot(bus, 0);
+		if (!root)
+			continue;
+
+		if (root->vendor != PCI_VENDOR_ID_AMD &&
+		    root->vendor != PCI_VENDOR_ID_HYGON)
+			continue;
+
+		pci_dbg(root, "Reserving PCI config space\n");
+
+		/*
+		 * There are a few SMN index/data pairs and other registers
+		 * that shouldn't be accessed by user space.
+		 * So reserve the entire PCI config space for simplicity rather
+		 * than covering specific registers piecemeal.
+		 */
+		if (!pci_request_config_region_exclusive(root, 0, PCI_CFG_SPACE_SIZE, NULL)) {
+			pci_err(root, "Failed to reserve config space\n");
+			return -EEXIST;
+		}
+	}
+
+	smn_exclusive = true;
+	return 0;
+}
+
 static int __init amd_smn_init(void)
 {
 	int err;
@@ -218,6 +255,10 @@ static int __init amd_smn_init(void)
 	if (err)
 		return err;
 
+	err = reserve_root_config_spaces();
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0


