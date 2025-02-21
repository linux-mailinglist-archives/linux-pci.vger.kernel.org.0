Return-Path: <linux-pci+bounces-21962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A2A3EBE7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 05:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0896163CB5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FFD1E5739;
	Fri, 21 Feb 2025 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="thyW/w8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B71D7E4C;
	Fri, 21 Feb 2025 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112800; cv=fail; b=WONYumbZFhCOuhbraN2IslWUtF/8iv3VlaRQj3svjK3kvXst7mQscHOBuOUcHQfvKYXa9mvZzodrS9amTr3Sl5erS9TqmCfuNTzkVV1HLWhxsxXMJsREE6OJSTbd7WAhZMcxPQd1oKJL/H8brEFkVCv15y7pXY/AE9UqFZmB9b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112800; c=relaxed/simple;
	bh=IiI81QJGyWyW0DBQpltN44E2OHujjMtXQsJRkWNx2A4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c175BOojmxsvXBk6BeEG0fcMVP9/KBbOegPO50E46gwoQbwApCPunt1jKUtddhJFGrhxHolQGcevBVmJgdmrh+xVD8tdgC4Ouf7IHh2r19EHSBbrkryv3/OBLm6pdprLIPUKkhgMbywXIfTn5hrUokDizf0fGcwepCb4bOF7UV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=thyW/w8I; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrPi8H/X6m4hr3grYRsoCMJw4NKax2uSH3UHpTaU7UKkNI6BaEHMPtTzgnbokNYwrSx85QoO2wDPW0DfhRjNk54ICRYhPoSrLKMbq5t1IWqYXBMkltEOMpw6Ofpx2Lrntm06TcM3FzDlg0quHPfxdNxXrqrSzCK8SC2AEgK1iMaFgeZvJp9h6+DcGK/y90ttzABqtX3iC2OxjgcXi3avFoV4MTvU8K8wdctHhDWaL8FW8u7Za+YerOzYEM001PUzGiD1QBlKlqwSjMplfEQtJfz0A9de0TL7fZ6WUZrPWUeu9Pti/CeXmat71Ppbg2P51p3BbwczXPQZUtEla4YZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/HAGFRmI/Ut0B6l66jcUB991cw5sj27ZsCOeXhSnVY=;
 b=ZWtXVE7zq93RkRVDLJCNAPVRTRYA51jsjiCD8BF2dnQEuEJdyTp7BleLDhQ7ZrhSTbzY+9M4UjKXzGJ2M5nACQCSfKVgPqIWn9IFIZ9LPS4hRLgUntla2YIlKcOOKeAGf308xieacOSHQuXL61Gqjou4ygyNVK/cwIs13pKAJhgYtYOFk4YVjUndrpisOeZqRcoEvdEdQfxBDL9kKLOmyTrI3pLE9CATNho4v7VJMIT2+K6zVgg76YzWELAdk57m9uZvifU/aKpRUGoKOfi4ssBMnMf/M5N8E4vDFFwLRVCJapStHG4mYIL6zoDpavuMakvqSwtkjTdkjreS9ZtpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/HAGFRmI/Ut0B6l66jcUB991cw5sj27ZsCOeXhSnVY=;
 b=thyW/w8Iat3aUD1S0BZdJ4q6hobOt2Sk1Qfe5GY9SzxPel1cLSdQs4Bs0hCfnK8BEqvcWV80ISTMkS5/zeiWQwRy74P3H3P5V51NlpaZqUhI9z/3vP5XUIdnWq9bzPhwK9zFJIohgdN4zfJ3zvBfX0+PXxEzF41pBbqWJhRGyE/ug5qq1bnKp+jePRAL+CQ8C2WkZ+2+dYieSDoQ/DThEc0b8eO5KOnitwRu0hii5dFoBZyzMGFr+qzoK7SoPD0qOyLxtNEqnoUKleswOnWE6crtdUhKP1nigE47/9+L/R730xbNTxrSZ/03KwJjPlq4ruSckaLcu4rEea50GiE8Eg==
Received: from DS7PR06CA0048.namprd06.prod.outlook.com (2603:10b6:8:54::24) by
 PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 04:39:53 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::63) by DS7PR06CA0048.outlook.office365.com
 (2603:10b6:8:54::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 04:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 04:39:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 20:39:41 -0800
Received: from 181d492-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 20:39:41 -0800
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, <linux-cxl@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/2] cxl: add support for cxl reset
Date: Thu, 20 Feb 2025 20:39:06 -0800
Message-ID: <20250221043906.1593189-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221043906.1593189-1-smadhavan@nvidia.com>
References: <20250221043906.1593189-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: d574f478-116c-46fd-71fb-08dd5231c86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LaWKX85W6dNb0EupzlPhsxgymdlidnyPE1ydzOjZcKOieDDub9NFwCgowJwC?=
 =?us-ascii?Q?F9qKyqBfV3fuX/3w9DvCGh7FdMyrjoZqgeFjRUSG8sK4hZ8rNVQSl8zY7lfq?=
 =?us-ascii?Q?liNPMmKXpI5gMi1ofdLCWrCUF6tR2rOU0B82jr88HSlhrsMZFfRlmpeFBz5+?=
 =?us-ascii?Q?gMneLmb1FT4ifA7pDqNGfebRj6Vv06NdeSoK5AX+vWQSrPYkrTNyLVF6Y8VL?=
 =?us-ascii?Q?MriVMxkII+PvOVBY8CwU3yfremNt+OUgSEThUzK9y40Amtzm8JdoJ2ZUlueZ?=
 =?us-ascii?Q?CK2S3pwGlqe7Ohvb+X7edPqAJGLmxLnkxIovrTDemZ6GDIfQo/++TEuM3yNs?=
 =?us-ascii?Q?Wn6KczGp3n2WBosfVfwCNyi9+F5FAuAXCNr6RYhfxdkk6xwylPaUnAMsfxkc?=
 =?us-ascii?Q?old00FEwwiDtF0/QbVojXA/IbkiiRSRYRLRoSAldmOROVhw55N36tLxYRYV7?=
 =?us-ascii?Q?lAR4ClxPnkIeqPPQD5NEXvmgghgNAvb4lm10+5gMBrRabeXzGly9adeOkghd?=
 =?us-ascii?Q?x5a8TyJ9+NhhKGjnKVG7j9DUxEN+aQufjVkENzuxOiHQH0NbSkE7viQvImSI?=
 =?us-ascii?Q?NNH71z0+7tAGsa9JE7XuVFSrstf9m6S57Zqjc5ZUk6HK9Y5XPAODRJs14aEU?=
 =?us-ascii?Q?7wbW3LqAnMUCB82YugnEoBbP+KPSE60vcb304bG76m/ufkRVkJJpoCt+y+cR?=
 =?us-ascii?Q?8AQaqY5NHdqhS1FRnf8b0TK2WdAXrkr6Q6iNUOE3Pjl2MbaR0gnrrHBe5AzO?=
 =?us-ascii?Q?frYUwwABIxVYy02yYXrYzyw72IZzZjKoYuPQk6+sbQkleTG9K3kub6mZoN4D?=
 =?us-ascii?Q?SUDeXPYN574BQwTKhrACMqPzv9rdLGDWvoL50JicX1Qwpx3OAARgeEuquDYi?=
 =?us-ascii?Q?EjreIjUZz3A2YybA27byg8yH/HeXMNeA/3BfwJACXSnTGMjZJC/QsDv/LYV/?=
 =?us-ascii?Q?HqgRztmgjvgKz7bBlPKs0OXDU5rvnvZvzNHmeggP6n4MpL9RHaypau/K4MK2?=
 =?us-ascii?Q?Ty397KLCVXEdcgVUYfRlA5Lt7jBjbi3TsKDYVo8hTibOJl9JA1RDLgB3/9OC?=
 =?us-ascii?Q?UgYAQGZWxGGPBAOEUkGj0xA7es9TY45y+LqyKHaEpI1IV8OgIFZ9ooMCJ518?=
 =?us-ascii?Q?VPq567VWII1v+dN7mJoDDMYUvyk6IPfygecgRLl4fWR0x4n4Oc8/kirKI5y2?=
 =?us-ascii?Q?MGa9BZ4fCSase4uPY20LjKHPhqIFHCUu+b9WHO4SpjApDfxbCW2urQI5Ullz?=
 =?us-ascii?Q?bNV2WgsAJfXoKSGCRUeyu6e/pUeBod8PWSxR/FJda/QsaNX1a7EFEKKxgXUG?=
 =?us-ascii?Q?twBcECSTuuBMHmuiD4zQl9lD2G1UTsucE0rTJotnfN1LjmoWOdVL4ndpmyxt?=
 =?us-ascii?Q?H2a6/Won6LVXSbJGmvElnucWkltHdf4UOIK+AxaNG04N78R+scW9EwtpY7J9?=
 =?us-ascii?Q?mlSX/IfXZcFmMpB6m9I1GjBFnzbrrBjCUGEHayHGjGV3UEMBkwS2blBMAI4k?=
 =?us-ascii?Q?Glco36StYDO4+rM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 04:39:52.4966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d574f478-116c-46fd-71fb-08dd5231c86c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856

Type 2 devices are being introduced and will require finer-grained
reset mechanisms beyond bus-wide reset methods.

Add support for CXL reset per CXL v3.2 Section 9.6/9.7

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++
 include/cxl/pci.h   |  40 ++++++++----
 include/linux/pci.h |   2 +-
 3 files changed, 174 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3ab1871ecf8a..9108daae252b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5117,6 +5117,151 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	return rc;
 }
 
+static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
+{
+	u32 timeout_us = 100, timeout_tot_us = 10000;
+	u16 reg, cap;
+	int rc;
+
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
+
+	/* Check if the device is cache capable. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
+		return 0;
+
+	/* Disable cache. WB and invalidate cache if capability is advertised */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
+	if (rc)
+		return rc;
+	reg |= CXL_DVSEC_DISABLE_CACHING;
+	/*
+	 * DEVCTL2 bits are written only once. So check WB+I capability while
+	 * keeping disable caching set.
+	 */
+	if (cap & CXL_DVSEC_CACHE_WBI_CAPABLE)
+		reg |= CXL_DVSEC_INIT_CACHE_WBI;
+	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+
+	/*
+	 * From Section 9.6: "Software may leverage the cache size reported in
+	 * the DVSEC CXL Capability2 register to compute a suitable timeout
+	 * value".
+	 * Given there is no conversion factor for cache size -> timeout,
+	 * setting timer for default 10ms.
+	 */
+	do {
+		if (timeout_tot_us == 0)
+			return -ETIMEDOUT;
+		usleep_range(timeout_us, timeout_us + 1);
+		timeout_tot_us -= timeout_us;
+		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+					  &reg);
+		if (rc)
+			return rc;
+	} while (!(reg & CXL_DVSEC_CACHE_INVALID));
+
+	return 0;
+}
+
+static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
+{
+	/*
+	 * Timeout values ref CXL Spec v3.2 Ch 8 Control and Status Registers,
+	 * under section 8.1.3.1 DVSEC CXL Capability.
+	 */
+	u32 reset_timeouts_ms[] = { 10, 100, 1000, 10000, 100000 };
+	u16 reg;
+	u32 timeout_ms;
+	int rc, ind;
+
+	/* Check if CXL Reset MEM CLR is supported. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return rc;
+
+	if (reg & CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
+		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+					  &reg);
+		if (rc)
+			return rc;
+
+		reg |= CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE;
+		pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+	}
+
+	/* Read timeout value. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return rc;
+	ind = FIELD_GET(CXL_DVSEC_CXL_RST_TIMEOUT_MASK, reg);
+	timeout_ms = reset_timeouts_ms[ind];
+
+	/* Write reset config. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
+	if (rc)
+		return rc;
+
+	reg |= CXL_DVSEC_INIT_CXL_RESET;
+	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+
+	/* Wait till timeout and then check reset status is complete. */
+	msleep(timeout_ms);
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
+	if (rc)
+		return rc;
+	if (reg & CXL_DVSEC_CXL_RESET_ERR ||
+	    ~reg & CXL_DVSEC_CXL_RST_COMPLETE)
+		return -ETIMEDOUT;
+
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
+	if (rc)
+		return rc;
+	reg &= (~CXL_DVSEC_DISABLE_CACHING);
+	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+
+	return 0;
+}
+
+/**
+ * cxl_reset - initiate a cxl reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a cxl reset on @dev.
+ */
+static int cxl_reset(struct pci_dev *dev, bool probe)
+{
+	u16 dvsec, reg;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	/* Check if CXL Reset is supported. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return -ENOTTY;
+
+	if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	rc = cxl_reset_prepare(dev, dvsec);
+	if (rc)
+		return rc;
+
+	return cxl_reset_init(dev, dvsec);
+}
+
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -5203,6 +5348,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
+	{ cxl_reset, .name = "cxl_reset" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 3977425ec477..05d4b1a63cfe 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -13,19 +13,33 @@
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_CAP_OFFSET			0xA
+#define     CXL_DVSEC_CACHE_CAPABLE		BIT(0)
+#define     CXL_DVSEC_MEM_CAPABLE		BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK		GENMASK(5, 4)
+#define     CXL_DVSEC_CACHE_WBI_CAPABLE		BIT(6)
+#define     CXL_DVSEC_CXL_RST_CAPABLE		BIT(7)
+#define     CXL_DVSEC_CXL_RST_TIMEOUT_MASK	GENMASK(10, 8)
+#define     CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE	BIT(11)
+#define   CXL_DVSEC_CTRL_OFFSET			0xC
+#define     CXL_DVSEC_MEM_ENABLE		BIT(2)
+#define   CXL_DVSEC_CTRL2_OFFSET		0x10
+#define     CXL_DVSEC_DISABLE_CACHING		BIT(0)
+#define     CXL_DVSEC_INIT_CACHE_WBI		BIT(1)
+#define     CXL_DVSEC_INIT_CXL_RESET		BIT(2)
+#define     CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE	BIT(3)
+#define   CXL_DVSEC_STATUS2_OFFSET		0x12
+#define     CXL_DVSEC_CACHE_INVALID		BIT(0)
+#define     CXL_DVSEC_CXL_RST_COMPLETE		BIT(1)
+#define     CXL_DVSEC_CXL_RESET_ERR		BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)		(0x18 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)		(0x1C + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID		BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE		BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK		GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)		(0x20 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)		(0x24 + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK		GENMASK(31, 28)
 
 #define CXL_DVSEC_RANGE_MAX		2
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..efcb06598f26 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.25.1


