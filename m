Return-Path: <linux-pci+bounces-37046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9DBA1D48
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFB67415E6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C4F323F5E;
	Thu, 25 Sep 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QYtRezhF"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A1323F5C;
	Thu, 25 Sep 2025 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839829; cv=fail; b=R3dsT+6YvYBlGgJ524JBLlekS9f8wMPKEA4x2TGUdwKcZlLFU7douqtAL5DtGaOBh4Lx2tKZyYD03lhEvUZjqA3GUMlaYr6QyHIKqP2ng6IrwJ/r6E7//Tk47X1n5n1xXtgJy3F9QX54IDE6H7Fy1LH+Mbp8UmtHWZLnESzBdqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839829; c=relaxed/simple;
	bh=mpIcKoLfM9a4mbgm+7hcaygnOqoCZmim4/NU08nKNAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVDilxepJKXC2pRNQpCXpL6ka/lGxkXqCxUpKyb1oCJcxI+HpKqKA5geCqRTrqrj+xmwfi4pjnyfCD+b10vKF4PnLqmDlkdGisIohjZPKIYqvx6EXSK9uin8gPqWj94MBVZ0KC7D3+b+DMkUMZf+JnjejRRJJG3qtehqVHgwVX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QYtRezhF; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSK9FxWjiHV74NPdKvtSEI+LLewwFDuPIluKM6E4HWGwDPKjLZooV7oWADeCcbKRk4YUbNyqnL0kTb5MyuFvMr+6hgRYEH9HWn6c+lJP3UCX+s9iEeWaXajEQ6iq3QQwqi12IW47Wce1T2KBEjKX0vdauGqJF805ymigmS8AIheDGBznV3xsxOkrQKP0IrHvy9koSAp8f2M7+UPttm/CV7X3f4wmeZYuFuCID3MwIVdUE9e5NMtQIhAkLbAjYHyLMDX+aDMCmHf8TkcuI5UiOEnPcLdlui/aaFLtFI3hz+VMvaIf0EI65TsGN7R9HCD4IXFFflrfNLRiI8tfqWsVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16TnI5oYamae3xlLVuyAK+xa2oHoycK3aUU51JDTlz4=;
 b=F11/iizVA8i3dIhJ3JRVJwSSDY6Q0/eJxvBesvGOn776LFfpwhE7zgNawO1RESa0Ct5XHqH/oAv6LtIqsQsRa7nrSmZV1LjcoagGv0CUtDAyn/ZXLQnxILH1BH3Wkxtauq2E47qmXm2Jz82BvatkzHcx+aiBd5A6HrizTqTYa7Jawff0tTsymcpSan9nPgLfwqptEZU0QeCNXtNsc+lstPWO/tlfyh0gB5JzNPfAiI1A4VaHMuPSmZQn9OpYmwSpCgZ/PvbdjSPqkx2/ELb8v7PtVQBoQ9TozHMO8thDOjv2fHimSqNC+W4uX/cxPsPo6+Oo10eCAu10KMbldspK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16TnI5oYamae3xlLVuyAK+xa2oHoycK3aUU51JDTlz4=;
 b=QYtRezhFoOYh69k6N3R7dTeIWDg02lKCZix90q7vCSDM2X7hPDb6U0HPGKI1cQaFHNLC77yMOwcEBKhMdrp8suZxd30AU2Wwce+104eJhP8wuRDfCMAxmfxJovYDfFzwucAQO4lrwBoqGU6tZBjaQqiWt8KqlnEGupcK063NOjE=
Received: from BYAPR08CA0030.namprd08.prod.outlook.com (2603:10b6:a03:100::43)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 22:37:02 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::68) by BYAPR08CA0030.outlook.office365.com
 (2603:10b6:a03:100::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 22:37:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 22:37:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 15:36:59 -0700
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v12 12/25] cxl/pci: Log message if RAS registers are unmapped
Date: Thu, 25 Sep 2025 17:34:27 -0500
Message-ID: <20250925223440.3539069-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925223440.3539069-1-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a481b71-fd95-41cb-13c6-08ddfc840bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N3klP5QiiiFGfQq7cfFKKhaHSmgx3F1lsmlRWqpNujIWN2xokgYYfcd1Fdo2?=
 =?us-ascii?Q?R8+rg3ue06yk87ud5IBJ66vFBE2xYQP9TNDb6WlLJxf9IxZRPaQc/HvnkAXa?=
 =?us-ascii?Q?5UzgF+dTmB4Cg1KpWJivH4lD7jnOaIfmnngEPXIV0as8Pc988S7eWI0uY7Ek?=
 =?us-ascii?Q?jY9rBSccs6JVFEn58wlcRAKUIbpRyX1jsv00mBbXE2tN5HVsoYqQ18H4GBz5?=
 =?us-ascii?Q?+IspHQliuMDj8MEZkHa5P6uX71QLiQ06J7ux06zMXJoLKRnbySbUUcuwoCVp?=
 =?us-ascii?Q?2BEVL0wtVrbUy7fMNE6ZqP1g2TTAWoY576R9Yv6nvCPTnlfZNmfyS748cFnn?=
 =?us-ascii?Q?EaZUatZpcvg5/hiVDn2dN3H3wXAcxHPGyUuGuklT+Qq0EpK78EEDv37R2SUq?=
 =?us-ascii?Q?LTP5zhHFEhfmd9OR4TZqF9dwZuUNopYF33L78ACv2UcwQ6SzaIbJoMo0WTZ7?=
 =?us-ascii?Q?fPWrx+bTQfxMkB8hMXOiPOgLH7ZsFzph8lTzFENaVYlOqNyZhngdaxU9SXkR?=
 =?us-ascii?Q?0z+Y+/E4seJPcT2U5pKo47g+9ngi1k4qhIQdkaO5la67BwcxQmbM8KcIKpoH?=
 =?us-ascii?Q?bz70XNHCqDS1uW4nd7PTI1BeARcu5E8q//pCZ32HPDFN29p8uNss63rv4mkH?=
 =?us-ascii?Q?93GQehSt5jhDvzhJFoO469qE+jdkvA+CdrLzoX6uV0zPv71oNSH1xZ+RgHyK?=
 =?us-ascii?Q?15qnvjbFNMUsDdgWV79dr+67Xy8M9YemG5pUsgP0IHUM0rWBECqaWkDAqXTu?=
 =?us-ascii?Q?L5NFrL6OTyX//JNYw6kSNKrrlTbbKoNSA0yEcG98GZ8aZI5gnHIrOZyUhSk3?=
 =?us-ascii?Q?toeRSBWg/6HWuPJWqZbWBYm+FkhpqbK8Tr24ncuv/kF8FBx5eTR6aVUyPOaK?=
 =?us-ascii?Q?x95CgObtCFCXS8LdWzYqulIiTptJgZN2KwU5jEYXC6Ec3HYhZ/kk463uvuLD?=
 =?us-ascii?Q?mqavSq3cZ9ZIt+qBWGZngFm80ps852fRmzMVd/JjhG9oxR0zYcI8cUiYvQLq?=
 =?us-ascii?Q?XGLpv9WSSf2HhpLpuXutWIZz7f8dMMTgKwUO17Zh1fWeHgBjTDC30h4XguA2?=
 =?us-ascii?Q?4105m/lundcw8fLgnt7UQOwdbg46zK47UIMPArU60Zow/m1P05eT8JPG3fBy?=
 =?us-ascii?Q?IRS+adeFfNIwOXthxprOrX9S0J6UjCBddhxyyfCW4eQFpF6SzE+zf6KXb/ul?=
 =?us-ascii?Q?YjjofVA7Ohp6aTHGGnnJSEW2PWJdHWxjpjNkTSG/6q9P0LA67wzHKDgBDF7w?=
 =?us-ascii?Q?Mr9KPT7fwrFyPNQmQrkJvEOBN/SCT+SWhhLH0IgPLA1Y8Um/PNgA1pzfXLOi?=
 =?us-ascii?Q?3r4UYItxsEq9A7za4jWjCg2PHpwvY0dwSzrxG6HI3ZWnwmFEO0m6+k25jSfr?=
 =?us-ascii?Q?YDUcDhHUAyKPrfKRWHs7yluFRSxzxjgl9gYl7qLgPk9kH69xEf8nhnl8DraH?=
 =?us-ascii?Q?UdEHN24Pw4/bpi+IN/9K6jZ5RiEv8VdAIbl25Ytb6pySgFj51WYbNg3GGGcl?=
 =?us-ascii?Q?FZ8r9fuptmofjEloSn1bIjkChN4prYg7D4O8S5TH3bs3YBGoz9x6d3kh1Byc?=
 =?us-ascii?Q?Xf6IHxUor7Mt/LBx1jo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:37:01.6786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a481b71-fd95-41cb-13c6-08ddfc840bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425

The CXL RAS handlers do not currently log if the RAS registers are
unmapped. This is needed in order to help debug CXL error handling. Update
the CXL driver to log a warning message if the RAS register block is
unmapped during RAS error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes v11->v12:
- None

Changes v10->v11:
- Added Dave Jiang review-by
---
 drivers/cxl/core/ras.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 152550bd3547..c66d37d65241 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -286,8 +286,10 @@ static void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -325,8 +327,10 @@ static bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	u32 status;
 	u32 fe;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return false;
+	}
 
 	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
-- 
2.34.1


