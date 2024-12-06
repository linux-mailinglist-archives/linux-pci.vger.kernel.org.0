Return-Path: <linux-pci+bounces-17851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A29E7558
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E2816A4CD
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763620FA92;
	Fri,  6 Dec 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="shpIq0CC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94520E6E1;
	Fri,  6 Dec 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501558; cv=fail; b=hInsC6xcwoZMgvsnsZmvAbZQGXN3rtUrevFuJ6NVCdNA3cVW/HWdy8j7O5cJi3IFmGU4S7nIC2PjJ19rBSS1MAV9Hsvafl1AL9KKKdOJAVxBO6JBfWr7KNoJgStUQMEsYiGQt4PB81r1T2kS5iqd3zrco5c5/Rm0N5HlDHCDMYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501558; c=relaxed/simple;
	bh=10H33gWO2syuo+yhGQ+pwePLCcGH/oR7AHPbUjCC/Nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5I3HXXeJrenYPsSDWkbfWAQquKD/k85Ij/vDcrrPdmE29JEUb4lR+SS3dX6X0jonJLua6ar5DzOWu3lt4V1jjfmNpxr0CPxRSuH9SNGyZxKiYM6mXZKEjx7rG6boKNR9PGtdoOSzlo9e0R4G8akJuhsTdlvXeuQiRjXLM9o5BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=shpIq0CC; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkQG3euG2zzOSAEnqLFIQDPiFD8lqXBHTEMIYHghH50mZe4GVsu/yt9Xntsuqefd5U+RuD0zaq3h+KwiWhzMfyvOg7MXPcYOISRU4rAshk5VNUfM7xPhOXwF93SLaY0coXh+LNI6b7O6FQ6tcl9ajVgL8Vp453k6g5mEnkhYUtJrW+fPqwZDIcktuPbM7cEUN1Ft5NoIrM8eYS9HeYWMDAIaWOnl1OmOmwepZsGK5rVshA3RDXYaop+5tjj+3swwRsCWUZJ/UpOuX3v1MupP3vq1I69JTPbZnqJVm44pC6wadddQcb+s7e0dMd2gQCaQ9fGZyedQ5mVX9EFzrG2xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrnxYYazJBRdHXhleU3iLaaWal2T1Gpzc8rEorY2Ygk=;
 b=jgHZ3QJDJGUaLSXs+48RI1ILBphz4b/sIPlR1EVvv/frXZ0Gu3jyTj/kQ2OkbyGZVzjW8HPiUfbI7fyRPJ1IpVNxPMkuC5FGELSODbWnkvxezXzZbQtHNgxkcPDK1nGlYEwgxyQmPWEA8nA00bp9GWAQNF1nkxPveW2a2090TVgmyegA276eBR7lrY0frkUe9sERrJdtalGyYTn3q6GmlXoNDAFQosLnPOLEXatiJPqbAMqY4A+gcI8ld5pt4s2tB40lIFspzjkwmlBGpktGM9TOScKd+JYGYb08VFvJmF5g3V8DHtkIpZl9bSnPBlnPheTfzfQQHHfEaapwJX7xEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrnxYYazJBRdHXhleU3iLaaWal2T1Gpzc8rEorY2Ygk=;
 b=shpIq0CChN/LmwdXdHeJUupiEjZ2AfXxXlpBVbv2Y+fG6sYFsUJhfrqjd7aexCM3rv2czfVZmYCflrhBCwNH7pHD5h2dtH1FRI36Q9b4x3DCYBIpJsQSnr62wQCs1tzLf8SFapqy5FcTQMhaGGuC+vqtGLAjO8P9z3RxpHko5WM=
Received: from DM6PR02CA0143.namprd02.prod.outlook.com (2603:10b6:5:332::10)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:12:29 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::fc) by DM6PR02CA0143.outlook.office365.com
 (2603:10b6:5:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 16:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:29 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:27 -0600
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
Subject: [PATCH v2 05/16] x86/amd_nb: Simplify function 4 search
Date: Fri, 6 Dec 2024 16:11:58 +0000
Message-ID: <20241206161210.163701-6-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 7053fc8c-dfe3-46cf-dd03-08dd1610c877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/mj/NId6U1sifFwSRWhNgkum8sSDrn/S7tNeiPTLxnRntIZlDPVSum8nOlz?=
 =?us-ascii?Q?ioVJlGBznUfUmtfhUxSU8OEp9NsOAChRjnJaSfNeyImmFN5nKN03Vur6EfZG?=
 =?us-ascii?Q?0tHMqLCCijS/tVfeeW80PlYXHfT7jLyIPWlrmrUgBkRmvZMYIdFw848RZHDc?=
 =?us-ascii?Q?k5ajGnlyGelkvzvVXWSKLsIVckHmb76JFZZ+M8MnEwf756kmJlcyZz4chot5?=
 =?us-ascii?Q?nhZt7iQ1fXfCCYIxpwoL45bReV6Bmgm/ngpWKM0WshLCAFGg53rLSaolsze6?=
 =?us-ascii?Q?KE6h8UhbFTa1rTCF2os167fg3J6L0fg21JdhnBeQy4q0QY7fJdypGX+Ps7xr?=
 =?us-ascii?Q?XL1FUT00tnMb3TnFDCz04SF17FwTBINIsCR5vLrZWV4XzAe2tiRVovzZEi7j?=
 =?us-ascii?Q?AXX69El8Xeb3f+ul+FczcryHdJfVZ78ckWLx8ULJqvFnWFXoBY2s+tnMtXlA?=
 =?us-ascii?Q?27o2XPXDrNvIYgUYtug7+EdoYo56iYSo4jN06Hk2v7nBMnOtUDPPa1DfreiC?=
 =?us-ascii?Q?i+gRvdCwcWoE7g3/YkCJvx51wTQ0pX2dFimy1fwWO5hlGuAXAXkOpsXpDOCr?=
 =?us-ascii?Q?Yj+fHAMXePGkZP0f/CqDe0LW8GXw5+qjMtocly1pbr9UqP8ij9QnhPrwDJqF?=
 =?us-ascii?Q?Nkl+EcJVcKmur8ItJtwdhDvAcSJN+B/qSuGNzQXHWeWcpwJmoSvbTeqZMv9R?=
 =?us-ascii?Q?lCzs0yjsUAuFVNrut5y72Jqzetqclvhrn+9wEIlmDoRvzueWe0ZKXQyQbhKh?=
 =?us-ascii?Q?yFJgkEOT4e2+v6mTDMV4sAYT79zJAmd+pgLWLP5qYHfKDgc3ya1RGRDQjhP3?=
 =?us-ascii?Q?qpQlIwOcJMevEBqq0f3Z3xh3MBF1wOLIMToVr3SErlUc2mJdWcXrRuLJk7+H?=
 =?us-ascii?Q?gwVvxztBzq+J9Oul4lp9crhq6o353IailsD7Y4qvuQPu74YWcs1kPa443agQ?=
 =?us-ascii?Q?dhz+nb9geMAmknrHmXdWDYgYtIP/0juGqAbyBW6Ski4B+wIwgvxF56kVXkIJ?=
 =?us-ascii?Q?RZ0hK8/iOgU+pYLFTArO+k09xWuqvIUmO8JzpoqN0KKWViDcFSLOT0ImucXn?=
 =?us-ascii?Q?DUidShl8LH9Mt8XMG+jUkcSaQcYBr2Sn2Q8EeLfQehr3QupxxgJfGW61Bjk6?=
 =?us-ascii?Q?pq5ia55+xad+V4Y+3+BIv51rHO/tVnp2UNWznG6PKrBAnQjvoBwRFFVfyPIa?=
 =?us-ascii?Q?AOHcfoCQht7veQwtrDIboWUW7oYXJl82nm+K5OXnbZEhSYKHBOWFKxsvknBM?=
 =?us-ascii?Q?p9qR3SU6+tnYDCo2GvxzgXGudlcqn85nyrwMbTKH3Jog2eeP5mx2iJxSGxZC?=
 =?us-ascii?Q?FKmiX4M+cHyDb60n4XQ2BCCftWbSGAUcU9e1vqcaUS5i6xBHXMU7UqvH1gx6?=
 =?us-ascii?Q?Z3QJTS8EpsRqJMx4/i/NmtnOH6SsdkoVLhbQsHjEAXKAh9Sd1BMgMZAd9Oq9?=
 =?us-ascii?Q?Bk39qGwQeJvyD2wnHO0CyxaQR2fnJog9VGB+5oPQ7vYkVCW5/xiKcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:29.4127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7053fc8c-dfe3-46cf-dd03-08dd1610c877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

Use the newly added helper function to look up a CPU/Node function to
find "function 4" devices.

This avoids the need to regularly add new PCI IDs for basic discovery.
The unique PCI IDs are still useful in case of quirks or functional
changes. And they should be used only in such a manner.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-6-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/include/asm/amd_nb.h |  1 +
 arch/x86/kernel/amd_nb.c      | 66 ++---------------------------------
 2 files changed, 4 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 4f586fc699fd..31547108de1a 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -4,6 +4,7 @@
 
 #include <linux/ioport.h>
 #include <linux/pci.h>
+#include <asm/amd_node.h>
 
 struct amd_nb_bus_dev_range {
 	u8 bus;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index ee20071ced99..7a62c5af2531 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -30,26 +30,6 @@
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
 #define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
-#define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4	0x1494
-#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4	0x144c
-#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4	0x1444
-#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4	0x1728
-#define PCI_DEVICE_ID_AMD_19H_DF_F4		0x1654
-#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4	0x14b1
-#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4	0x167d
-#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4	0x166e
-#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4	0x14e4
-#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
-#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
-#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
-#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4	0x16fc
-#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
-#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
-#define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
-#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
-
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -73,8 +53,6 @@ static const struct pci_device_id amd_root_ids[] = {
 	{}
 };
 
-#define PCI_DEVICE_ID_AMD_CNB17H_F4     0x1704
-
 static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
@@ -107,35 +85,6 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id amd_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
-	{}
-};
-
 static const struct pci_device_id hygon_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{}
@@ -146,11 +95,6 @@ static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{}
 };
 
-static const struct pci_device_id hygon_nb_link_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F4) },
-	{}
-};
-
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -275,13 +219,11 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-
 static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
-	const struct pci_device_id *link_ids = amd_nb_link_ids;
 	const struct pci_device_id *root_ids = amd_root_ids;
-	struct pci_dev *root, *misc, *link;
+	struct pci_dev *root, *misc;
 	struct amd_northbridge *nb;
 	u16 roots_per_misc = 0;
 	u16 misc_count = 0;
@@ -294,7 +236,6 @@ static int amd_cache_northbridges(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		root_ids = hygon_root_ids;
 		misc_ids = hygon_nb_misc_ids;
-		link_ids = hygon_nb_link_ids;
 	}
 
 	misc = NULL;
@@ -328,14 +269,13 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 	amd_northbridges.num = misc_count;
 
-	link = misc = root = NULL;
+	misc = root = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
 			next_northbridge(misc, misc_ids);
-		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, link_ids);
+		node_to_amd_nb(i)->link = amd_node_get_func(i, 4);
 
 		/*
 		 * If there are more PCI root devices than data fabric/
-- 
2.43.0


