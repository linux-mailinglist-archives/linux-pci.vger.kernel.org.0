Return-Path: <linux-pci+bounces-17854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F899E7563
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93E516A4EB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0E217A58F;
	Fri,  6 Dec 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Sl1mJbN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193620C499;
	Fri,  6 Dec 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501560; cv=fail; b=ZfGoZKk039h2geVfLnQVkQgmV2cWj+bBpc7O0NwVhlPAEip5vh8zQ4mT+TJsWlfmN+D6aliKLx35hxz6IDNhjo/Jd5KiiVwOqvSoorQG+JDTi1Egtkm+dcJ+XTV1dsd99x70ZKShaSs7fZ9SyIWt5oF690rqaRCjDFjdCTDn1OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501560; c=relaxed/simple;
	bh=d/9HDBSR0JtmK7V5Upv7zq1fRY0CHrxc/r1Sr+bBv9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Weng6dmY993vrWYRvaqikqTx6OkP8zVSPusW7LozLT9MNQPW1Chp4b2UbQWL4nX6h2fAdipSKjY0lQML+fiJRLB42fc5U+oKfROtQSF21B5OL5UiTLq3GKKEgLa0AsbfTdmq891tA/xC8aeaFHhslT8WgMMd1Lm5fytq35MGKVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Sl1mJbN; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHysRqGGbd4Qp8RwtGF2Bn2W9DX7A5yBr3T5yj1fNS+jtNwpmr1i8ciPtiIw5HUV6DFIPGAPwG264RI1hRmZCjfh+NeKMwhyG5eGqogX8kNwNSnqX9oudJ/gXRmit70eKXXVSwp6F8xp1d6qp/v347Vk3pNm1a86n4/OCg/SayJhhD64QjK3fIgvqWRGYcrjBSzp9VwVR3yG76Ctx4l79KIlLe6vWJQb5MnCGQGTKk1eXmkr1hSOUF+J/uDb0WxhyQPvV66E6c19E9BF+Z0ENWdtSkN9HLqRCck/UD6ZSUpuhLd8cd2KzVZ7Jv+DRhdpLKlRd3HWZDuGmxmaynfpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYoNyCkN29Tmhbj42lp0Gh4DMmmSHYD9oli23mlTHtA=;
 b=Ujl5EZ9VA3Dp0uLgCiKexAHVq9q5sSDTgigokIzrj5WLiw0kfVo+GbAbYaaaHKIN2OuHYxqQCMIlKYzbVf6BqUeioDwly0JXKkkrkLR+pWl0hinxk0J+xupJpJ+5jFUvxJHS5gGyX4wjea6juhnUZ4SOJO7Ll6SNy7WXwhdvj0p959qckAIkc52kvv/WWTUWR0JLdQlTOQUuILSeScPfMpRFTQy/+5wrYrKY9nrOv6lDZ8UBM1p8pjYyl7dZxpMnOfRFKXnT6Ir6y3Gm/Noq4xSQPXJriIr3NwwBqtlRME09nvNQ+hUo7rg3c3ZfhUyqliGparsIb5h+i7f7BIJbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYoNyCkN29Tmhbj42lp0Gh4DMmmSHYD9oli23mlTHtA=;
 b=1Sl1mJbNhWRVVOLIcqp15dBuJGEaWso/w/Ro6z8g4hk1Jed7NVc+mr1bIy2vaVXQ8J87E1DWOEQcRDSZtLv/+U+06bNWGA3l7cVowMLYNM8uQl/WHqoEBioJovQQd9CGzRDgD15LKTvrLmjvzwl4UCAgHNYvIhzWlqFMP4TBTiE=
Received: from DM6PR02CA0063.namprd02.prod.outlook.com (2603:10b6:5:177::40)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Fri, 6 Dec
 2024 16:12:31 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::17) by DM6PR02CA0063.outlook.office365.com
 (2603:10b6:5:177::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 16:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:31 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:30 -0600
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
Subject: [PATCH v2 08/16] x86/amd_nb: Simplify function 3 search
Date: Fri, 6 Dec 2024 16:12:01 +0000
Message-ID: <20241206161210.163701-9-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: ee98584b-bc78-4ad1-bb77-08dd1610c9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WmHjzeckOSz3wdmcL28fyC00+ATUBVcldsaTGB1Rwg7hEoOgvrpC2hIv9H5H?=
 =?us-ascii?Q?SawqLGoGpcXoSSTOAa4AketHUpy+zae84buMQX/r5wnS50Gd/XSe02LDJGS2?=
 =?us-ascii?Q?kp/6zciqRdxjpd0S64i9LPe3a51USVid3vec3FXgjTgMyFTZ2UZPUZvRsDDy?=
 =?us-ascii?Q?71jGY+RvIQ3vsJPu/ZsF2bu3usDQTPRKfRrpu57Ookur8s9zuUjBmAccE/Cb?=
 =?us-ascii?Q?bSWw6I2QtWXZ/Hi1mGJofffHvZSR/h+r8Sn1oIOBtVRjYN+lXt/3Wd7tnCuP?=
 =?us-ascii?Q?wB4Mt56ZpD1v69J/cOUZ+i/yKjF/U7x9XlrkLIOksyvAPcgzLrILsq5W63U4?=
 =?us-ascii?Q?dJJDUewYXB7pOLqTTFK3itpsxx9rqB7wh3IWuH3H6Zn9a/Ey+QIUzHpAQYOx?=
 =?us-ascii?Q?fRnYyDk73qzyc0vQOppmu5hAw7rCcjWBpNhi/MKArooMSpnV+Sm8nzOwiI9f?=
 =?us-ascii?Q?IrzPMN/hU0/NKdQINYdOFGjrpSNj60F3rxX5gQ0ZI4aN3ui2bbCwddxVRbyv?=
 =?us-ascii?Q?O7PzToNSPE3GNV2OJQJWk3KxCSeCe6d3vd9oLtSf1u1dA/+LUp6ahXjm6jPj?=
 =?us-ascii?Q?6uVXMU8I2zeIQB/eNU/CM3TxlwTAZP4dgodQkvWrs8f55wD8u6PutZ33FP4G?=
 =?us-ascii?Q?phS9epf+MFrZOSfY3j506PqtMGi3gxFsTw9LApp7dOUHA/2pY4p5LG2PMKcS?=
 =?us-ascii?Q?6s6UfBRnrMdY3u3p4PV1J3rI99MOFB4PNN6oAqE3SUm2plHsPZwg3uR5JXKy?=
 =?us-ascii?Q?PgiYQp7sLoE+nF7p5qvpnJ4Bure+zTSDF81YTZ/cvFRlTITYv7T34BKP77Xu?=
 =?us-ascii?Q?KITR+tGWKzkANlCIaCvpBQ3ahvkQcZgLHrZKO1LrWd/k9eyYFMo6OjQekbcI?=
 =?us-ascii?Q?Gcyc0PIkuefN5vHUC9qBSo08pEib5exkQhJJqpnibeiTfdoR2qvcjPGM1Ht5?=
 =?us-ascii?Q?Qb4x+Xpur1CSyLkhjCMI8y3n/o77FhOP0h7AB7tOCr0//alqn0yjSAbY5KlV?=
 =?us-ascii?Q?kruGbUK2qJxbnhH3y/JctnOCc32+msBLXhC5EKaYAe1HIwfA2OvKIDz/FO2E?=
 =?us-ascii?Q?/bwL206IL9yrayBHWr/bP8zeFDgLErk7mtrB7d062pjcYn8htrnPVEmXvXd3?=
 =?us-ascii?Q?at9d+nhoR7EtSIwpXspBW8BAmZhJ+OpjimNTHIKuT4irBi9StC4Oj3D0t/0U?=
 =?us-ascii?Q?l4bV4T7A2K2KLTuuHI7PjmFYo9QEJpLrpUYI/6Lafmrwf4KQFTA6lYnLC9nL?=
 =?us-ascii?Q?JMpoEbICxVf8oZ7Zt+fz3u1Kq5N4e6xE3ejdOPAIkOmDmfaxeCkkRf1wtLyS?=
 =?us-ascii?Q?a+1E3HGSKSUlugH3fadgdFF0rACIlkIcl7S4oXadnR4kBWO06GE2VA4QJq5b?=
 =?us-ascii?Q?S/0c5N4kdXTvxhWSJMkQDnb83JLnP9vHDyyP9VEZfgCPipdaVX0ZkJvVrXpH?=
 =?us-ascii?Q?auABUSNoOdvje/5oM9Qq6LziBLxly+Y8t6vQ32c5+dLYL0EnsjmQWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:31.5327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee98584b-bc78-4ad1-bb77-08dd1610c9bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

Use the newly introduced helper function to look up "function 3". Drop
unused PCI IDs and code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-9-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/amd_nb.c | 46 +---------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 371e33abbdc1..2ad67efe9032 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -29,31 +29,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
-	{}
-};
-
-static const struct pci_device_id hygon_nb_misc_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
 
@@ -84,17 +59,6 @@ struct amd_northbridge *node_to_amd_nb(int node)
 }
 EXPORT_SYMBOL_GPL(node_to_amd_nb);
 
-static struct pci_dev *next_northbridge(struct pci_dev *dev,
-					const struct pci_device_id *ids)
-{
-	do {
-		dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
-		if (!dev)
-			break;
-	} while (!pci_match_id(ids, dev));
-	return dev;
-}
-
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -183,18 +147,12 @@ EXPORT_SYMBOL_GPL(amd_smn_write);
 
 static int amd_cache_northbridges(void)
 {
-	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	struct pci_dev *misc;
 	struct amd_northbridge *nb;
 	u16 i;
 
 	if (amd_northbridges.num)
 		return 0;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		misc_ids = hygon_nb_misc_ids;
-	}
-
 	amd_northbridges.num = amd_num_nodes();
 
 	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
@@ -203,11 +161,9 @@ static int amd_cache_northbridges(void)
 
 	amd_northbridges.nb = nb;
 
-	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = amd_node_get_root(i);
-		node_to_amd_nb(i)->misc = misc =
-			next_northbridge(misc, misc_ids);
+		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
 		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 	}
 
-- 
2.43.0


