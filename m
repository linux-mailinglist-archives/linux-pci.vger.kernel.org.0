Return-Path: <linux-pci+bounces-12049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A038695BFD5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575E1284132
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729581D1F4E;
	Thu, 22 Aug 2024 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b1rODSUN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE61D1726;
	Thu, 22 Aug 2024 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359413; cv=fail; b=av/Yuol/oo+K7GXH62s3HdryU6/bNak4tVcpSng0zCfHTUyghwR8nVrrPeNePKrY8z2HwvG2NJ2FDWsRP+lPxgs+4DeogFOmyZTHPgezvbY+sy6GIgI0qKcI86yt9LxgXfd2atiL6RndqAoLsxZcL1TUMjou9O0JawvDxuIqO04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359413; c=relaxed/simple;
	bh=UgB7UbuKvXBpdONd15kK//IZLjtAnTlhoGrNWvF8ayA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgalKlME7UvrdPla83ouV5JcidYkJSs5HBURy6B1di8fkq4/9lrDsyH0QSqSxYKuj9lYfDUKEibTRdRcGTSIrAg508WmCk6iZfsgVYBx4B6DECasu8qnKbdu1kKB0U6PzVgRntHU7JzKl4T69S4adV9kalTVuZ1HcWFlRDTfMO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b1rODSUN; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cu+GZFKFr7Z9YxlsmwZtbjLF1chBN8aMp38f5Fx3oyetrHKgp0voNS0WvthAz9SwTe/G0qaQlZeve5QZ+43KOq4TsX8EEITnI/L+nKTxg5vqSfga+1NHm7wlOdo8PIClLJmAhOptK9rkSRUa8hvjLMZt+77SNxRsafpX2byWOMVG6BR+FGA1UZELOkAfR/XjCYQxwZzYkbbWh+NlmXkMHnZxlEtdA/5kjzNCJne/5ZLXJS1kOQpcrTYLO7cFIkTCbzlyz+LLtMgQ2i2BTUAyq/zCr8PN9Mfo0yofyR4K1mrVjEQVcw/0FT74ORZtj4n8wtkyous/jcqB8fuvfweKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzVoIMKuwHwM4kRfqn+mcm06D5WgK0PdGib+32oNs6A=;
 b=X9fpVTA5B5lQu31T0Dnl6vTFDgM6atXMjGOO8xSt57rua8xL/vPgJG9JtRMsYeBTELQsxG+DxTtNlG5ePMJLb+/I9ypwJJUyqJsqtiAb9ZPjNgZQJVfzKbsegAzHZ8vrGPGP7ZkBNSujrZxNeBJbR8dAamIxJjkU7wZHtHempfR127fRqZh1ca12xNX6xdKNN41gVjGGsoNYeSJw4JsuNKCogkT6tlUxabiMtaGWSqH7WMCLmZnRc+P6mIsDfsQ7IT2JZJhMQBTI7y+i1hjQ6P1VUcQ4m1k0+8w39x0+Dupv59X3qepFhO6GVhfPrK4QFLJKtvXADbAKavBTAsnDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzVoIMKuwHwM4kRfqn+mcm06D5WgK0PdGib+32oNs6A=;
 b=b1rODSUNRPn2mI2hxJMazxObdhNiBBSfI6710u6+MLkhv9UEYZgbrOXaIiA/j9eUjMOgSbzPtZKa8TPgESbu1gjGlEljWyMYhgTuk+qtOCgFJE//pnqanDF+iax/g9CYNCITkShkKbpfYI2/u3xvfIaACiQuxkppp3ViBCtxLpE=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Thu, 22 Aug
 2024 20:43:24 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::bd) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:43:23 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:43:21 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 10/12] PCI/TPH: Add pci=nostmode to force TPH No ST Mode
Date: Thu, 22 Aug 2024 15:41:18 -0500
Message-ID: <20240822204120.3634-11-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 600e753c-2e11-4817-d178-08dcc2eb1118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aAqEPtYLkJxV19IVKBEcczZuy0HODJn1neK1DEPxUuWEBt8cpKUdG5KzRbmz?=
 =?us-ascii?Q?o4BHvCv3XAejgGTRZcfoFPJVARSn6lQfBiUPyCbxy6UsLkrcLUwGgCRM2cjd?=
 =?us-ascii?Q?/wSIVObQuYffGgxWhDvoEEaKt9E9JhWb5cKAx7fRScj4txmBfnzHi0ly0VVy?=
 =?us-ascii?Q?fLDnVqw8fym+mPRtiFuVD5Dx/4ZNWvPqETPA4u4fWtN7bgII9IO4S6DZZLzr?=
 =?us-ascii?Q?fQlvJEY69UyHymjIZoKooPs5e7fz7SaFUy5nsGKQjiS7R3cROoRGMMCq5sSl?=
 =?us-ascii?Q?kQXQdG0zPXFKeySK8ze1q4tWcafZPeo4HELAv66a2c3nGBz/O9PSQ9QzZA09?=
 =?us-ascii?Q?WG0e+ahls8GDxLudtMqkrdAtLmOw1GdzfBiEinMcbfN57YcTfNXLYxV1419R?=
 =?us-ascii?Q?xZsiJ/JQJxdFLW5TeGvhirNbFm7BWt+QWkHHKkN40JK8OIPR5Kkgv5M7Tgvx?=
 =?us-ascii?Q?2DMzmthsbn+9K3Yavx8NMh/iswJ+TbyJiY5Rh2HT2ah6IRfzKy5vfxh1NOzE?=
 =?us-ascii?Q?zHIAQEz04VCCZcoS/h0jttfFZ4LNdWGRsngqh7euMaqdq4WPVEodCAkKjIJO?=
 =?us-ascii?Q?dveVpl0nSfgOHqxdWIUGkL8xEjYOigMpSuKaYTH1BsLASRLLTRDjIKHtyCrA?=
 =?us-ascii?Q?q6hk+A4Z1p0fW4K5K07Qm5Ago6I94cRigsJqf8sbBK6gNaSjSW5vNvnr6Git?=
 =?us-ascii?Q?Gv09Hz77/d//16RTscEC9i+3ThZ004LoPeFxxADi2jF1KChne7Dp24OadJ2l?=
 =?us-ascii?Q?CDeVT5BoHjU5MWjwJ5g5zWEOn9EiOaM8+diy6xqtvjGQfArgHs2tdldG9346?=
 =?us-ascii?Q?KQC56NfNy7BPFlG+sRmG6pdYUAJ5BMSHc2XwRHpB0/Zr7ab7Y1sXwLlWl1Ll?=
 =?us-ascii?Q?xj1mpqnLQeqt2asQVcZpf59XsdjYB0P7NkET4LvCiGjUZDnSxFBZTSbEgTcz?=
 =?us-ascii?Q?ViHOxLuH48NARGIBBTHc1JZNAmDz/A5hzgqaqRqmCdDZGTMIWTTgAV8pX5sp?=
 =?us-ascii?Q?eG5yhsZBTq+u7/evRTn0/vFCig0N0bftWWZ/5NcK+nGSYzeVK5Xs9RzZ45L5?=
 =?us-ascii?Q?NNSCa5aHkbPxkQQzQdtSl9TqJPKTq1WHy4W4i7OxhuEZoSxMCpAPQ96gKVmP?=
 =?us-ascii?Q?AbCubi3amAfyRj2h9+E0mNL46s0UVc2aG8OZO8YkKgfzOYsgU0thrD1eTGjo?=
 =?us-ascii?Q?yh9sW9af0LNt8QPZzs0TAaF2dn53jpsI8p6WfQI2KYFEbrTTV7Te2SeDF/nU?=
 =?us-ascii?Q?MK+HkQsz2vYb2RLAwxSZvZoObT0qxrArJogO6HCUZKiQHIPEnzXj01torLPB?=
 =?us-ascii?Q?TAtPrIq6ASog+5vIcgmg1V8aCDB/kmGk+WRUPopNyCeijt6Ls2h72VA8r3Ux?=
 =?us-ascii?Q?6GItGitFY6eCuRbVK1hX7S4AVX12MBrTJFjwzt+yE0cGzyG7Wt0ihbwKFvLb?=
 =?us-ascii?Q?qTg0vzI6O42KUOne3h5IqLm3VCtB/wso?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:43:23.8147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600e753c-2e11-4817-d178-08dcc2eb1118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089

When "No ST mode" is enabled, endpoint devices can generate TPH headers
but with all steering tags treated as zero. A steering tag of zero is
interpreted as "using the default policy" by the root complex. This is
essential to quantify the benefit of Steering Tags for some given
workloads.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/tph.c                          | 12 ++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..ed2ee97cf7fb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4617,6 +4617,9 @@
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
+		nostmode	[PCIE] If PCIe TPH Processing Hints (TPH) is
+				enabled, this kernel option forces all Steering
+				Tags to be treated as zero (aka "No ST Mode").
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1e4960994b1a..88aabac354c0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6870,6 +6870,8 @@ static int __init pci_setup(char *str)
 				pci_no_domains();
 			} else if (!strncmp(str, "noari", 5)) {
 				pcie_ari_disabled = true;
+			} else if (!strncmp(str, "nostmode", 8)) {
+				pci_tph_set_nostmode();
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d7c7f86e8705..54d74f5ff861 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -574,10 +574,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
+void pci_tph_set_nostmode(void);
 void pci_tph_init(struct pci_dev *dev);
 #else
 static inline void pci_restore_tph_state(struct pci_dev *dev) { }
 static inline void pci_save_tph_state(struct pci_dev *dev) { }
+static inline void pci_tph_set_nostmode(void) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
 
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index b228ef5b7948..f723352adcf5 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -48,6 +48,8 @@ union st_info {
 	u64 value;
 };
 
+static bool pci_tph_nostmode;
+
 static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
 			   union st_info *info)
 {
@@ -433,6 +435,10 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 		return -EINVAL;
 	}
 
+	/* Honor "nostmode" kernel parameter */
+	if (pci_tph_nostmode)
+		pdev->tph_mode = PCI_TPH_NO_ST_MODE;
+
 	/* Get req_type supported by device and its Root Port */
 	reg = pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
 	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
@@ -545,6 +551,12 @@ void pci_save_tph_state(struct pci_dev *pdev)
 	}
 }
 
+void pci_tph_set_nostmode(void)
+{
+	pci_tph_nostmode = true;
+	pr_info("PCIe TPH No ST Mode is enabled\n");
+}
+
 void pci_tph_init(struct pci_dev *pdev)
 {
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
-- 
2.45.1


