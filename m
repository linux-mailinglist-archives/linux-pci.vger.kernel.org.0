Return-Path: <linux-pci+bounces-44794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B61D20C62
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C690303399D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16090334C35;
	Wed, 14 Jan 2026 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RB5UT9sV"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535002FFF8F;
	Wed, 14 Jan 2026 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414891; cv=fail; b=HDNEsbuAovsjLGsylx0rFDNbMrfRqBHh7Az5xV9kV8gn9IUC4YxXNPUTuaspJ9PBwU+9bn1hiSOkxSnHgY65D6iWzFL28iJfYA8gGx8t2yZ/clgDE4hyhDFWIdhlK9HzNYFSU0wQqL4tO20ydf/nsZvSGjODiYU4uKt8YH7nYYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414891; c=relaxed/simple;
	bh=26H4bawW1i8wg0Y6+jJTwIwhQc2XeRLsHEvJ/t95Zp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1gFNEItFoXevj8gxtK2/cessifRgQySAy0GIYvTpih3M4/PrRcZzYKwaLBAj/nkvS1mASNucC15NtaaXL+vX7LyGWR5xs5Dpl4JPUhdVPEd6ZyD8NjoO0pP2eku9jU5Z3kk/WH3KjBZPkCJP1SYxmUlZY9OPEplBT5ZzAsbMIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RB5UT9sV; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpzQo41qjk4naY+O2Iy0NHDIGUtOws8CRGEIisDABwbQ+CoSm9TaBW0MKWmzSPZEAkG+E2QttbNrpgAQKm5093HNyKY6OJ7J4RrGHNkxvl+u4OqEQSZR+hdIhZq6B9c+w5UYocM7fOaey96CGWkiRy3U0cl29FrfgJtBPFwII9mh9vv14veblpsjaq27lJ7hHOwHgHsIR+TNwez8zZOMX2tKb9cm1euMWl47F9c+9XjBWyy7+GtOr770VwLYBA+Q6SRrGQx+tRQ9LkIx0QHM+krtAA0uIFCUYaSZL4srGmF6+kHbtWmajdobSqkCkBH5eQhdmIGvqQY0Gzc3cv8OiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4gyAinWQpjwlo945AzP1vhuYOumSINUE9IY99hkoCE=;
 b=bqGiyQzj7SIyj2u9fS8YioHCkcEtOcFUxcyDeU1PuUpSQd/RQpozJbNuw0n4SzfRHrCpUy+8DrBRLXJnVAsekqr1RwGA36wytixxxc+5geVKE5xyz1YZ5NQ8Yk7nsBzOCwbVKc1+v2pV705LpAdE0OwE+JA8CydcFxbdhYUpbPqVGEFhHioj9VoCfjs+kdkG40VMkao9d9Spw94H0hyqxvkxUIdrKJdtonneOqNCsztPR+UfpsDOoUimk+6y2Ls1b4ZWme5tNa1kqX000kaDVfsDBYbPxXDQ6qrmInXQVk1oma9y73S43IQr7ed5gQ0nXiXRYPX61L2ijBgQSMnKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4gyAinWQpjwlo945AzP1vhuYOumSINUE9IY99hkoCE=;
 b=RB5UT9sV0E9VANxBhmifZTpCYqpSuaVy3U29EdMTcSwrkA13ylx+BNhcpmAA334caFxyPQ3IcLtitDJvEIO6bq4x+282vMfKvqaXskzJl120SaLFpYqWgqj8J4lEzXZJvtzFvFwDPmmvbhjSe1OhZw6ugQ5jJzZsiUQ5wxU9ykE=
Received: from CY8PR11CA0033.namprd11.prod.outlook.com (2603:10b6:930:4a::10)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:21:21 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::ea) by CY8PR11CA0033.outlook.office365.com
 (2603:10b6:930:4a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:21:20 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:21:17 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 01/34] PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
Date: Wed, 14 Jan 2026 12:20:22 -0600
Message-ID: <20260114182055.46029-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: a034ba28-c9ea-424b-6c41-08de5399b7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdSmhQd9K3TvnrXptwmKPU0oceZcXAYO9dAxlPXCMBn4VK9KRQYiZ/oHgzpY?=
 =?us-ascii?Q?CQ/KJtTBI2aMZ9xOkpZXF8i/++dxYXKPNA7+k9TkAzGbvxO/lUjz7OswpRs4?=
 =?us-ascii?Q?VNuZPvZISDD3ZwrrJlXzIx+ae2PsI9IJq/PWc/RCuXo21p9LFmUJaYcrjh5h?=
 =?us-ascii?Q?QvAV1Mia1TtUIKArcOjvkV81tamm7Zby2wPPg0b0p7gayXT1uzo8xtatckJ4?=
 =?us-ascii?Q?OwSlWUMyu8EC2ABtf0qruW7doPkb0R8RK1mYGEg3m942yUmwN/DDitSpGidW?=
 =?us-ascii?Q?eYRuoGf3ahz82IYujp0qNGI5FKEMm/q6qPrZ3bE8RYrzBp86DUA0f0tPVMaD?=
 =?us-ascii?Q?Mz7DVpz2uPI5/Aaj3nB+L0oZ4gKMFyaU1owOjYR9h0FKm5oNN3GNlM3oDaLc?=
 =?us-ascii?Q?x5NvnqV6MSYZfSW/3HlTEbFQefMgYE5oRCIoZN0AfZR8gSK89JP2yf+NEl+m?=
 =?us-ascii?Q?PK1+6+diZGDZeiWvLX31JpcCInZgVO5vVZvOOOI+5uKiNvLdynitVp3hQm8f?=
 =?us-ascii?Q?Q7SiN7Rfjv4Lwhb3uEStdN20TonEic+GRD1XyLTGrmUzBbZ0WlOPA+OGdZWD?=
 =?us-ascii?Q?OxSc6e/kXVz4bXDOavIZCj3QTSOrmGjLJSLPmySSzUy5iRdpvFyD9Te8YDfS?=
 =?us-ascii?Q?OrsIQBlvfqKjARvEHLaXuy4GVdFgXAq62IvbAbtbWQuAyrqPxNEPlN6kn4XB?=
 =?us-ascii?Q?lO15TL+WlAJPeIF9mbtL/JYwGSXJobVufcTGmWlEO8XQiZSTQMI/MugpiaLG?=
 =?us-ascii?Q?TVxHm+Ce3TT6HzOYjW/D6SjnBOh0LlNfzXzHcdTYrELL4UXZPFafn2d2yAUD?=
 =?us-ascii?Q?6AxaWiw7O0sGptloMPppPoNs1WNJCDPnQa/679S09j13ywif7ZYeDsjGFyT9?=
 =?us-ascii?Q?SQMe67jeGBtUbGeeNulA1B+wiWJir38xALcZlh8cQgKBOS4292xaGORURqR/?=
 =?us-ascii?Q?IdeycQcRlFZN+NXO6r0mtjm1XryzIiLzLxiiGWXJUhtYALoh/GZq0lxtgqyh?=
 =?us-ascii?Q?ABX0NyNj7eGjYSX50mIuaFLMWAUBmDlHmMNSHP3rV1SFK+A2OFM0oVjUX/oh?=
 =?us-ascii?Q?DH44+RV2koJYL0tEu0yTdRwCBPwwvJ5Ppuo/VJIDOz2G/VgQELnLbUj2OLXy?=
 =?us-ascii?Q?/grkkrey7vAtY/LlNihoZd8xlFdXdJf03+woyYcfhbdQUXTyB389dDDorJqD?=
 =?us-ascii?Q?sQj65ci9IbYQ+E1XjZUyqoOcNik8Sxy5vxInFyS0aXzO66ofobrpO6rsPuax?=
 =?us-ascii?Q?TbkuklKzXCpRRnZ197ivIDb5c3RyuS8q7SjXVFhwspY24Co0H4qnkfAn5m+Q?=
 =?us-ascii?Q?F4T580annLZpxy2lZAYNzNwAGRWeAeVuXUEiIZIkqnUpgOxswQ7k9q7gHNbG?=
 =?us-ascii?Q?ZA+e/NLwEBU7uaGBh7ja955okHyNaf1yxWNK7+ewrIiapUs30buEyMTWBOyE?=
 =?us-ascii?Q?rXv7HuVLITh2xHdHI9fclQn3K3SBoI4BBSHBmA+akc+jW+hw7Cx8mLWhCN/f?=
 =?us-ascii?Q?37DM89MRPDXtB+tQFMdzBmqPWV/x4fbii8OtXYOeXcvY6At03pCABKplxOFx?=
 =?us-ascii?Q?Ux6Jv85vL4FiY6ime1uMzb8arHbJBDHysnyXS5iSk+Wof6ec+VwHO7EzGb3b?=
 =?us-ascii?Q?0CZU+sW7Rx0VxS98wW3rcXK4Tc3o3SQNcxbIdr7JDMiceMWGilOC22RjyNeh?=
 =?us-ascii?Q?Yj6H3RM864k6XTvh6Tt2oNasd6k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:21:20.8862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a034ba28-c9ea-424b-6c41-08de5399b7a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
accessible to other subsystems. Move these to uapi/linux/pci_regs.h.

The CXL DVSEC definitions will be renamed and reformatted to fit better
with existing defines.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

----

Changes in v13->v14:
- Add Jonathan's and Dan's review-by
- Update commit title prefix (Bjorn)
- Revert format fix for cxl_sbr_masked() (Jonathan)
- Update 'Compute Express Link' comment block (Jonathan)
- Move PCI_DVSEC_CXL_FLEXBUS definitions to later patch where
  used (Jonathan)
- Removed stray change (Bjorn)

Changes in v12->v13:
- Add Dave Jiang's reviewed-by
- Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
  message. (Jonathan)

Changes in v11 -> v12:
- Change formatting to be same as existing definitions
- Change GENMASK() -> __GENMASK() and BIT() to _BITUL()

Changes in v10 -> v11:
- New commit
---
 drivers/cxl/cxlpci.h          | 53 -----------------------------
 include/uapi/linux/pci_regs.h | 64 ++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 1d526bea8431..cdb7cf3dbcb4 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -7,59 +7,6 @@
 
 #define CXL_MEMORY_PROGIF	0x10
 
-/*
- * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification. Names are taken straight from the specification with "CXL" and
- * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
- */
-#define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
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
-
-#define CXL_DVSEC_RANGE_MAX		2
-
-/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
-#define CXL_DVSEC_FUNCTION_MAP					2
-
-/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
-#define CXL_DVSEC_PORT_EXTENSIONS				3
-
-/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
-#define CXL_DVSEC_PORT_GPF					4
-#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
-#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
-#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
-
-/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
-#define CXL_DVSEC_DEVICE_GPF					5
-
-/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
-#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
-
-/* CXL 2.0 8.1.9: Register Locator DVSEC */
-#define CXL_DVSEC_REG_LOCATOR					8
-#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
-#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
-#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
-#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
-
 /*
  * NOTE: Currently all the functions which are enabled for CXL require their
  * vectors to be in the first 16.  Use this as the default max.
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae2594..6c4b6f19b18e 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1253,11 +1253,6 @@
 #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
 #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
-#define PCI_DVSEC_CXL_PORT				3
-#define PCI_DVSEC_CXL_PORT_CTL				0x0c
-#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-
 /* Integrity and Data Encryption Extended Capability */
 #define PCI_IDE_CAP			0x04
 #define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
@@ -1338,4 +1333,63 @@
 #define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
 #define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
 
+/* Compute Express Link (CXL r3.1, sec 8.1.5) */
+#define PCI_DVSEC_CXL_PORT				3
+#define PCI_DVSEC_CXL_PORT_CTL				0x0c
+#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+
+/*
+ * Compute Express Link (CXL r3.2, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
+#define PCI_DVSEC_HEADER1_LENGTH_MASK  __GENMASK(31, 20)
+
+/* CXL 3.2 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE				0
+#define  CXL_DVSEC_CAP_OFFSET				0xA
+#define   CXL_DVSEC_MEM_CAPABLE				_BITUL(2)
+#define   CXL_DVSEC_HDM_COUNT_MASK			__GENMASK(5, 4)
+#define  CXL_DVSEC_CTRL_OFFSET				0xC
+#define   CXL_DVSEC_MEM_ENABLE				_BITUL(2)
+#define  CXL_DVSEC_RANGE_SIZE_HIGH(i)			(0x18 + (i * 0x10))
+#define  CXL_DVSEC_RANGE_SIZE_LOW(i)			(0x1C + (i * 0x10))
+#define   CXL_DVSEC_MEM_INFO_VALID			_BITUL(0)
+#define   CXL_DVSEC_MEM_ACTIVE				_BITUL(1)
+#define   CXL_DVSEC_MEM_SIZE_LOW_MASK			__GENMASK(31, 28)
+#define  CXL_DVSEC_RANGE_BASE_HIGH(i)			(0x20 + (i * 0x10))
+#define  CXL_DVSEC_RANGE_BASE_LOW(i)			(0x24 + (i * 0x10))
+#define   CXL_DVSEC_MEM_BASE_LOW_MASK			__GENMASK(31, 28)
+
+#define CXL_DVSEC_RANGE_MAX				2
+
+/* CXL 3.2 8.1.4: Non-CXL Function Map DVSEC */
+#define CXL_DVSEC_FUNCTION_MAP				2
+
+/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
+#define CXL_DVSEC_PORT					3
+#define   CXL_DVSEC_PORT_CTL				0x0c
+#define    CXL_DVSEC_PORT_CTL_UNMASK_SBR		0x00000001
+
+/* CXL 3.2 8.1.6: GPF DVSEC for CXL Port */
+#define CXL_DVSEC_PORT_GPF				4
+#define  CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET	0x0C
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK	__GENMASK(3, 0)
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK	__GENMASK(11, 8)
+#define  CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET	0xE
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK	__GENMASK(3, 0)
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK	__GENMASK(11, 8)
+
+/* CXL 3.2 8.1.7: GPF DVSEC for CXL Device */
+#define CXL_DVSEC_DEVICE_GPF				5
+
+/* CXL 3.2 8.1.9: Register Locator DVSEC */
+#define CXL_DVSEC_REG_LOCATOR				8
+#define  CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET		0xC
+#define   CXL_DVSEC_REG_LOCATOR_BIR_MASK		__GENMASK(2, 0)
+#define   CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK		__GENMASK(15, 8)
+#define   CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK	__GENMASK(31, 16)
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.34.1


