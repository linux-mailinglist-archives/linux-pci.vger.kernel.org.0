Return-Path: <linux-pci+bounces-44811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9FD20D4F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435B030CA662
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5355C3358B5;
	Wed, 14 Jan 2026 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lcMZq0mm"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A956335065;
	Wed, 14 Jan 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415104; cv=fail; b=ATIXU7lOX92cvFkoz6NjKNN24MP8jm3JO8cdqUn4kHeQlAyz8/XbtPTNL1WAxCuQ4YarXS8PbDzNzADPde/R2MHisDR/oxjEsgZx5pPA9veGFhhqw3TtE9TxPQLVuhvUpdIH7bYnp57Wb5yOpLVUwPvjGsaGH0djeEA11Pv8Yu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415104; c=relaxed/simple;
	bh=VES1MNlNf5pkimylgFoccF1wQuGjghYCOwER9SQ+TBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pV1fMpR3Mc5okqL+GR8/psoiTc+yhu8SPv4r4JPq7kIBiA4viP0GliSirJKg/hgn1ddnuH2DmpXBsv0nqDtQYIPdJWeqTrQzSQOY+3kYqrDYbgXeT70Mc9Eo04ivAt5xLRNVOhGsTosvq7tx8JVCfyU2jIcIVco23x5JsRPOO7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lcMZq0mm; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WycS7vOsy2ToAydRk4t/wXHCgf4d/AYgFR472zRKNPkOREnN45GaWpIva0ppqSlEqD3N49f5DDJZ2ddEstRFnw2rGS9lUokrPhbJiyf2KIw6+ZtpBM6+b7smAEMZWmbLw+1d2ekC7gC50T3D6C5bUqzhQN/MEopk8DVcelcSbueXCfg4FZxBKUwOECsxdT63jNUk+jt+1AXiYSsF72Ng45o3q/KxF+t0guu4uGdfXKgYmCh1E+2cbVQGk7mF9XzsDrLVrNBb2p33BefcxrAtx4yEZgjtlFQ3MUpMp9grZAhPNeAEDVePaBqtrs5yRwH3t8qEzz51GQfu6k28LBnuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZrLW6g5nZwyBm9jye3yEIPp42eFhye7ljLj7xUfiG8=;
 b=i3jxmysJQKCegXVHycsH0p5FD+de7f0vGOYRrvN8+JmFOtxSkeA4imxloOq6hToV9RbbaNhsoOkDQAMVZmuF5fGSyEPug5N24vfc56IP8SxbJLG2fL3P45qKIutetkGfuCiTqK/pQdpbyp8BmIackrl6RtOXc9tgUPX+SJ7OaS86AbCFciqFlS/BoAOc/ThwT7gyPbdv7Q6SyuwldD9+Jpy1SRDbtw84yMRMu5PQHFi+4ZP3ttzA6d5y7Kg6ks+V1hzw9CUZNBDi9Sx839a7czYn3cYkKrhTN4GHDIihU/EtOWA8u5JfE1a83RkYUWvyHNMkmYVeFTgLBtURUvz7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZrLW6g5nZwyBm9jye3yEIPp42eFhye7ljLj7xUfiG8=;
 b=lcMZq0mmT8WEZd7EL80YVf0rxJvZaLMck8j4cc6JbDk/Nu6Pc4U3aoDTHwSRQiTf645XUB0+EwCRTUEZXP0249PNbLl+CQRsQ7JTw9WpV9o1OmU1ADLEZC9hLsh9GY497Ku8ozmi9wiNuYQoDW6YcDc2ErzbvnXli75FdtrIAI4=
Received: from CY8P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::14)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:24:57 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:6b:cafe::50) by CY8P222CA0012.outlook.office365.com
 (2603:10b6:930:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 18:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:24:57 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:24:56 -0600
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
Subject: [PATCH v14 18/34] cxl/port: Remove "enumerate dports" helpers
Date: Wed, 14 Jan 2026 12:20:39 -0600
Message-ID: <20260114182055.46029-19-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a716f0-9f90-4f63-d4c7-08de539a388b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4KOWpNGcIcw8pBpWmZnn/sWe5LEFMBWndxT+x9LaKp96NYWP3J4/rqKPdXlq?=
 =?us-ascii?Q?WcdoWUmkp7v5u4vbpIPYZAD5O5y+u3Sl1Fq6trfXtsbhTUZ/RhmjZf30jx4N?=
 =?us-ascii?Q?JzdpsOiPOFD1omoK5ShzXrrPkCJPuojsL92qfQYHtXZv8zZXrEcrl9qPrUZ1?=
 =?us-ascii?Q?NfxNkIPToOb4js3cYFtbLQexlzVndpO1Oc1S2h1ogQh78WvWybIL1uIEHA4O?=
 =?us-ascii?Q?+ZYRRhF5eOauULgzoGLk8/jWnhrxvSFI9viMp5+MexA7SJIam/LG5ddOot88?=
 =?us-ascii?Q?toMtru5VSdq4QtRmnj9lPRqeqWd1t8QESvvzbOm8zkowGNcB7eai7FJADl83?=
 =?us-ascii?Q?gkmWxVV8JUf5GvOGvo5RTZnI8xWLY1x5S51jtdo8Vd24bJ8uMfr3Y054D4pJ?=
 =?us-ascii?Q?DEhNbUKrwScWShw62T4v+VseeIo/Mx6x0Q9KYDnE3jDKmslBGabOnLzFOEe6?=
 =?us-ascii?Q?40qxpKQX+bxeQ9YyJZCYkZ+S5aWEDGu5lL0hwHccdzbZOmv64d5A0tMTHc5U?=
 =?us-ascii?Q?1PQef+dogthEx43SWZt7g/NSAYRE+a8o8dISmt2+0GAnklxkMZH28Fkh5nMg?=
 =?us-ascii?Q?J/J6Z5qrVl0ljb+qA5kkL2MNqI6liukNF4toqdlVck4WbpKQcZW0wxlYZFM6?=
 =?us-ascii?Q?tMP0Nga6L8aNxy2b1JSHwx7BxVHLJ+d76xEo8mpq/w03JJ1fP4HBwwn54jQI?=
 =?us-ascii?Q?tR4Fi+++WGSOc1bifSVDBRu9jrxJ7JtUzs9bq5gG2rNmmtVieqHZBilbfDEr?=
 =?us-ascii?Q?z0oTPAOqMcGihDOP8Auz5J7hmKAxXw2n6xNwZ2qGgOkji0qOso/LPJdt2DPU?=
 =?us-ascii?Q?ShAVaO9/hPK6AP0YyhPXBMTv2nn5rBjDjYSxbGIGWCakkWSCGA/9s2sJ+f3v?=
 =?us-ascii?Q?IGvwefs5xDyacY6A3ApxGNg/axo2QuPM6jANGtmO1pQ1XELV4Va9FLVM571E?=
 =?us-ascii?Q?hK8JmkV7f7jUr+3Iei6g2C6mOZwtvxnvq/RTaYuaP91VemnT4/eDPWL84KXS?=
 =?us-ascii?Q?uErwA+rTf9W7aZq+xpzrAKAvoqtNqoLJPivB96S6iwm8LjOSlX/gmfY29QWq?=
 =?us-ascii?Q?Zsj5S7M8SkJtsWH7mXEVoo6qCJlw5pFOwKdiKr9CNnDCDhYxR8GhBSKcKnI4?=
 =?us-ascii?Q?Q1d9/Mb+OEIkmxJhaL1nTyVF4Fnf0fd9RDJaRULSp/suHVOlWJS2fM0vhlxL?=
 =?us-ascii?Q?dpH8ADkYBtqrveCdSQuQRUy0juopXrCsvcHiQUNKqH+QbVTKVSof+Oc5Wn2R?=
 =?us-ascii?Q?T1NuqFXr2NgH0NOTbeS12cdOgBRTSyighKqqjk6fQY4B/dUcwVSTMRaYaK2c?=
 =?us-ascii?Q?3a7Tenjs312KbqALwprTzJwabhF86p9fb18MGec4x2aCO5Q1wzT2QQ7DNWuR?=
 =?us-ascii?Q?ZBx1WigUMzXfjabqt7JISBkhjeSiSe5+nkFEht7KeWBg2z4/eTvOpvo5UJti?=
 =?us-ascii?Q?QtKg2cNV7vI2A2xy6paiGoKjfrfziRbKtQ3YYRawT20d0r/SQX/+3tGcvGr2?=
 =?us-ascii?Q?mk68nXoH6OiVbFASO1u84HwT5aVxjcWNt+TjZANZAsJppb8Sf4qNtzJ9sF2t?=
 =?us-ascii?Q?K2JQ2v36xVIL7CP//IHhQ6+EIzbHRFDNo8tBLSsatWrYfYnjwieA2iWTCfzu?=
 =?us-ascii?Q?Ipd/NNzN2HQYjF4DeZsAtzhdhlqh5zIAZU9afqD/zbcoQb82oR+3Spsj9WNK?=
 =?us-ascii?Q?xhn0BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:24:57.1080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a716f0-9f90-4f63-d4c7-08de539a388b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

From: Dan Williams <dan.j.williams@intel.com>

Now that cxl_switch_port_probe() no longer walks potential dports, because
they are enumerated dynamically on descendant endpoint arrival, remove the
dead code.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13 -> v14:
- New patch
---
 drivers/cxl/core/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b838c59d7a3c..0305a421504e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -71,6 +71,14 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
 
+struct cxl_walk_context {
+	struct pci_bus *bus;
+	struct cxl_port *port;
+	int type;
+	int error;
+	int count;
+};
+
 static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -820,14 +828,6 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 	return 0;
 }
 
-struct cxl_walk_context {
-	struct pci_bus *bus;
-	struct cxl_port *port;
-	int type;
-	int error;
-	int count;
-};
-
 static int count_dports(struct pci_dev *pdev, void *data)
 {
 	struct cxl_walk_context *ctx = data;
-- 
2.34.1


