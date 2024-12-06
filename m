Return-Path: <linux-pci+bounces-17847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687E9E7542
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EA828B446
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F9D20DD66;
	Fri,  6 Dec 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nqVNUxtg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167420C499;
	Fri,  6 Dec 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501553; cv=fail; b=pgdKXRwxYejjWqpSAg1KP3HWqQgloT0zDbEi5tFicxYk/K6SAF1Rw996m59rob6o69gwsB3PML3kfjV8aO41rjBQ4yfAvw3aYw9wvLlQqBNoLQFbXEGf/Rnhhh1LcZ7M9umWOxjdtdRvlg5iFWZH75On6zyEFYtMRZc/t9S/6wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501553; c=relaxed/simple;
	bh=5Yd4gh+tqsCLFJaziDb7PnDCE1qiYJUXMonvOwQEoqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn+xb2Jc0hzXK6sYHSzIVVht9Jn2n08V7Pt8ay1tgunquDFjgYZfWoo0+oh+SuYIPFW3DxLzO7z9tqQorNriL9QRxlEHb7mE9jomz2NkApuMxhch04bg1OgN4tqjpNp9AHSm34XqsqsQb38j8gEWw9DXeajjJKKsW75v5bylyMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nqVNUxtg; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFmuI7w0kxMlHXZbImJtHv71G+nCj0SNudigv69pFpvkF+T1hIMu/4cmIukxcpQcniku1nIJ90LoV/2hnW5nyDjKxmSdNNhob1mGW+HMgHogvkjjVpEO+tO1ICav+sq8xnXh/pBvA7aHUshHLx/bW6l3o4ocnBgmUclC93KDR42er/gR7kXYRhh1Ya2mHGO5yNepSeWOyOK6hHXC95m+yFyL7yRDQRko886BcO05lhy4GAd6Rqy5yIt7ueMDYKTXBepiJuYB+Wl3dRLxbzYCciOCwNPSBM71wEYA/OkwGgpY9/+LvwSK8fTxWwlrkmmOHtEWOVBLChsnkal6BFZFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxy0scJa0jmvC+OPAtX0lMo6y/mirVOnOMz4Fb6Ai58=;
 b=xFMiykP2iGlJHsnsoq5EBQcuvlr2kGrQ3EarQORxDiVx8u5+HjlTL+6/5u5nD2j6MiDKVtrND8oqvvzffqZPdhPklUg6O59S7z7fJXs3DCPZ7SR0iBLvgIjyFukVDgTbAnzWb7YzXwW+44fOVa4EkEOmGDt0EA6isH0849s3gu24ry4WjfMlq0zDQqYRPPikXJIcCAF9szTZpj1xF12fAVnLzgYpS0bFBSkl1IDPLkOVDUtpBKXieBWtM8/e5dQXfEV6QqtWjGYJBacG+6jd2RTGiQ7O5O0imdyINZdDQV1FAa8ppql+8sGn2SkXzmylncMEY8dDQKgh2CODbiBalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxy0scJa0jmvC+OPAtX0lMo6y/mirVOnOMz4Fb6Ai58=;
 b=nqVNUxtgImzQWeWCwEbVY2xmOfTDgQtHb1OYy19fu4vfl4SZ7ztp2sBJ5vU+xHj2dhjy4P064YaWLYZWyh9ao04oKGUsGFQ9i0pPXK5K8RcGNMvH2S9SP8hrNCpHQDA1GqzvTso5KQmUJzcVpdMz7rUJ6ydod5IIG52wr8z6VGo=
Received: from DS0PR17CA0008.namprd17.prod.outlook.com (2603:10b6:8:191::15)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 16:12:26 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::47) by DS0PR17CA0008.outlook.office365.com
 (2603:10b6:8:191::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Fri,
 6 Dec 2024 16:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:26 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:25 -0600
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
Subject: [PATCH v2 02/16] x86/amd_nb: Restrict init function to AMD-based systems
Date: Fri, 6 Dec 2024 16:11:55 +0000
Message-ID: <20241206161210.163701-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1e842a-8d28-49ee-57eb-08dd1610c6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fL9P1mo7p5/ITuPWvEjgp+6eMNwb8zG2kCH+awI9b47lDD1aplsblIC9kAnO?=
 =?us-ascii?Q?8S/NI/59pO5bqx8sIylx0y3RaVqSM7IjO6TXHFmByNEuggr1ZeJ/1NPuLYXk?=
 =?us-ascii?Q?Px9xY4nghAHFV2Dlu7tahqMWtv3z+bPiIhVPBp8MBp2suUeMgeb6ccWXXPIj?=
 =?us-ascii?Q?hWTy/w99+5Fmij+v4QiyZWEwiVzXM1uJGjJRoq9iyhVT++6NAUEq1puf9UZB?=
 =?us-ascii?Q?BK7kinrvF5KMX0FXGHRwmKUQYBYvHji2//hsqMbe4Qa/HKoZRB0ZoUCTbNtd?=
 =?us-ascii?Q?upP6btw/qiNjbCnU2LfvxZYQCXxYWIWZYCLKGGN3eAC3mbCrujjkSpFJWu6E?=
 =?us-ascii?Q?BzbvF67VCzxjhB15mQW6zHWTiAVlbDlwlFJd1NMqZv9gvdtq80hqIiESyYdX?=
 =?us-ascii?Q?IL1AkX0y3+R9yK/98us4C4nb6C/7mx9g0FOqu0pi8uG25mvLUnJ4AgLSrpLS?=
 =?us-ascii?Q?Gg/QjNvTemebteTheaLauL0LLLgFiSR1i5YdA4KUi1aiGzAtrGIAC7wYO7/C?=
 =?us-ascii?Q?F5oKYzOZzLg4o6RnMUNtbCn9j00RpGzbzU3zikChU8clHIetNBbi6nhEnByT?=
 =?us-ascii?Q?Y/M5XE6I79/1rwcEv1/pBkW1gvAzssLNCTt/9PL8G0IOipph0tz6IprTJXRL?=
 =?us-ascii?Q?hpSUX5Imr7r41fMXfMQ6Q9zIoWNy7hiP86e9SFZTBwTAOcnooF8RwDewchHt?=
 =?us-ascii?Q?tkTJJlweKNvdb5HYrtqkV1y7CI+MNNp1p8Z8tOEDAqirNw4tXOURyVPk/AWb?=
 =?us-ascii?Q?ffS92q9frB/Tdrq/2fGVKFitzU21yZasiGW+vmCWRgQM4BTfONI5D88mzyYA?=
 =?us-ascii?Q?OhdPprzaRPaIqLHgv5EBzR4Q7Jnn2139pcRO1C2iVw0K3j6nbQtQO5D+9oBo?=
 =?us-ascii?Q?nFtvuD42rD2tWmskPZxbEOGV2hQkI9fH8ZHehqDBXEW3r5RTaWh4QSUAKCNK?=
 =?us-ascii?Q?P592LHYdDJbaX6F/LkCHqJWK60+i7LnhazqYh4nN1zc+ZQqkg9Oyl7XLX3xj?=
 =?us-ascii?Q?64c89wDN7YbiFPM/1Q2DjPfmAl4QVxZ+4zIxaH7/lfUHXh2+jdFb0yWvWkGm?=
 =?us-ascii?Q?Z5DGoYCzUmYJqGottAVQ4em+wSR7/6F97E7550SoNqKXHWX1BbGmnyDbmAdP?=
 =?us-ascii?Q?E3C3QM+qbiL74rNNWBjCe3CwtwZaYCWyq7hzAw1V8jxKnw3VueAUjg2bGRWk?=
 =?us-ascii?Q?VepNCmjT9UgbFtsiG7qKWsm6yiN/B0gDpFCK4BdD0JIxmG64tE4i9G3/QRgt?=
 =?us-ascii?Q?p2Ef9fcQYazclWOZgYkBT852KBmMOiRoNrR5vO1+cfC6t3XALcUKl4Wcv4TK?=
 =?us-ascii?Q?jlMSf3R2FRf7wJ2o+p3nxi/KWGBnXcD/j3d9ufCfj5UTZCuqCdBIz2bXUf6A?=
 =?us-ascii?Q?/Q0Jmt02dphU80dpuFfGRSYz3py30YPaNbtdVG4V2I8HLv+MYwYDXbdbreaV?=
 =?us-ascii?Q?s64GXOaCMczhTdN5gVTlvohd60ufzwrvFh5o2w3fIgxJCT1uPGx/LnSrUyF5?=
 =?us-ascii?Q?TVrrmf+3wSgy+X4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:26.6018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1e842a-8d28-49ee-57eb-08dd1610c6cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-3-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 9fe9972d2071..37b8244899d8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -582,6 +582,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
-- 
2.43.0


