Return-Path: <linux-pci+bounces-25663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7ADA85A26
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A704A07AD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A045221291;
	Fri, 11 Apr 2025 10:37:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48EA278E67;
	Fri, 11 Apr 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367829; cv=fail; b=ar08ahQuqlzEXcI9mWKAxOmHF5Oo911KfaK/Wkv8EQJ9AtfjKSK49Gy7vryi9CQKnET4t4z52/RjtKyn1weF9WqkAjnjNRRuxbnncY1LOCNNv2jLhNC26Bgk4xBdJ+OgDKUFpJVyMn/7LXSHn6b1BfVKb3nfsMSkSmeKMQnQtpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367829; c=relaxed/simple;
	bh=BLpfo6b6oiDl55a7cUn6S9fzd+63ylpyH9UqhGGEA/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ryykV/ZauJ3P5W5KqPrHbvgCgc7uQsOsGBSyZCThdrsRRC6nrfBKtK2fq0CC2KFB4mvIGU4pTfT2BnQrGbXLCbCpn9xe89XR7KlAx9Xu7zsBoCTjxQSoWbdTvnSdvf2TZ6lnFfvmmgaszYyS6243EVAWDOsw79ZuSJor+S5JufQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHGqmwkXc/+QJhp2dcXXHyZFaAeSAi4A/rf0GNCXw8mkYMAMdZzJlebcm8bvy36kViDbs0dBSnD6+c8BssRbKpvz0Dyr1MtwSt27wZ6k2Fs8vKG4NKx/JhZTw0bjOyQMAgt4BrizWiH3y8I5s27kNesJeE6NxEDC+NTYJ7DLUMl7HOH+pAeoJCbO1dhTztGTrJnvhT2WwdbkKwr/pPi1gAHeQpFjKuZEFfwqw9e+WzPPEo0S2MRCGTOzug2P/6/k9gbY5xMK58F1Fr9WM/qMGHqUnvXnceIq7ZdJeVd0Gtds7+xm4/mdIVuPciZ0sd5wLH+kALkZOSZknGBjeiltOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8Kvqvid3GyfKAyJXYJNuEgattACWvp9m+hCkOhoSWo=;
 b=wM3TRYcja5A26fO8m20HXE89m4WwA83gfq7ipH1x3aOmQ5b388/+93836NtsdD2OxzYRsQQL5WJk5Ya6S4RNrvT/KlK3BY7PEqQFJTRBXRNpfZfxhRd6pRdQfXMfQosbJ1d8FAiREcoYBJXkCmynXE1jUju6jBqdtbNgneor0sUSPyyyF5xtd01VUfI60mF/fnAtf2s4P8Pc48dgLaXe90tyS2kjEEECwwK4DNgZZQj9mmENZEWg60qH+pmoXsy6DOGmhQC223HGAQBdyTK/CzRfi0uEOO2OERjEN6V0aQs5B/OhAgfaOHYwoN5DyiqKDnuJrmlRA/UraqTHq0kKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0029.apcprd02.prod.outlook.com (2603:1096:300:59::17)
 by KL1PR06MB6111.apcprd06.prod.outlook.com (2603:1096:820:d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 10:37:00 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:59:cafe::a8) by PS2PR02CA0029.outlook.office365.com
 (2603:1096:300:59::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 10:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 10:36:59 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2CBB54160CA0;
	Fri, 11 Apr 2025 18:36:58 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v3 0/6] Enhance the PCIe controller driver
Date: Fri, 11 Apr 2025 18:36:50 +0800
Message-ID: <20250411103656.2740517-1-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR06MB6111:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 173d5106-2b6a-46aa-7d79-08dd78e4ca20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nreKXmTiQPOiJUkKyGK6jyi36nmps45B6bNL3xWligMtvqkHeM7r7ls0leY?=
 =?us-ascii?Q?bsy6YQjFAKv2nxZ0yK2Yib0JjHgVFzjV2THzbnp34v2NiT6Dyd7cku0IRBLr?=
 =?us-ascii?Q?/9k2CwLvMYZbchxxYEtVXVZwluWhHLyWFZuxyR2sN53Bc5To1WJPp2Jsap93?=
 =?us-ascii?Q?IOTBDMYyF0hQo8lqFG7D2HA5SFnT9P7SR+LsRLyn0j+Au20WF5nD8I0Nt7fx?=
 =?us-ascii?Q?xDQHa2U9lmkTI2Qhk1MAHgj0gqtouUZNQtLrK8QRBVmOtZ7oIiqLZ4YFc1ns?=
 =?us-ascii?Q?vmu8trxVM80O8aT3Mw+lqjTR9Cfu5HZg/BJPq0lBCFn8PDJu8Lc7zC5RO8BJ?=
 =?us-ascii?Q?2KrFMYwbTakJkww8sYuve6c/VcSgJrPYRUY1MNpAME5i63X82d/wMK1KwPm0?=
 =?us-ascii?Q?QUhwjdWyE9ZXV6vSzwn4Q1tj59QcLed/m81Krjr7u1tuj3zyNzt0cSWjoZCp?=
 =?us-ascii?Q?6BqG41Pnxt52Ojm9t59NaCshL4wZY2DtPwStMmMlF6idtqrnbBnaX4EFnHhW?=
 =?us-ascii?Q?x1D3D2dBTXAOG4G8fnIk8ih+iSqkHkJ3fdI/2I/3z91K6PyZJbeNgNYorKUR?=
 =?us-ascii?Q?S26QX6ZDQHRjxJ2/iFjy+b1jU/MtXcD0uoeUdHsOq88456YMRsnv89mwiMeL?=
 =?us-ascii?Q?Mc1BHC9Lg2Be1sSkTVcCEdQtjubtcIwvOPMVOCZb6GSPw48ppGq2mhsI/22m?=
 =?us-ascii?Q?ssr9WpZVNd1OZQPiEX2n9IAPf+RKhrAMZmG1SH0xyABmiaMCmFtmWtWpLwgt?=
 =?us-ascii?Q?rbt1dHkosNmfJs30cfp7w5wwYsQGESkAfSN3TbVvInCDUiFSbTlyxY7dlOr4?=
 =?us-ascii?Q?m24uevd/RGoZnR001oMuMcv7sDvdnRE+rRBOBkqmRghQO3JsS+sZAPGKBYYi?=
 =?us-ascii?Q?DBEqrLh247qqWybMianLQkKQP3efPZPuBu/Q75FrXFoIrK+15uSDfJaE/jcU?=
 =?us-ascii?Q?VtcMR/9dKKsQju7a5OJn5lWwdHEQm+N6h9GtUNYiEK3OX5dD1KhaG5iEqpr2?=
 =?us-ascii?Q?VDe8ayPmjhepOWvEWPlrkNpoFw/Ch4ICnXoZ+FUc7uxGrB3TX8cYw/4z+O5i?=
 =?us-ascii?Q?rW2bWwvpXnih4MIRtg7irgfKu55cOWfgA4tl5YnTRMb3k6dmQi1XsUs1gsFX?=
 =?us-ascii?Q?GY651EA+AQK8SvQLvjamkDX7z/bj3u8tM/5Th3VqEgjt3B0ezJB7GRiAeM62?=
 =?us-ascii?Q?fqLfAlRlYUCU8Bf7+WEnrRzVLD+/Yocrsonwz21R/AWoXIcE6QL6ZX2EWP6M?=
 =?us-ascii?Q?G1Nh9HPL1DG4WNmvy9q+vggMV3ByU3Ctda67MGV/f3i2K9InGJy3g1zaUznS?=
 =?us-ascii?Q?p58Qg/uz+I+ifC29RVmgktcy9W51pMt5HSdX/rqynMTVbX9Ru+pXFFyB2n+Q?=
 =?us-ascii?Q?kd48vVi6me6w7xUdCBZPzTNfH1ub6fyWTlzYTjQqBUBnqAdw/Ysxhuvs0JWc?=
 =?us-ascii?Q?XWgqHxfDLy8MEclJ8ac4qow65i5TM9Xenqw/Zc62m3eVuTUqvNURpfQC6p/H?=
 =?us-ascii?Q?wmLFpOfaEiarODlbt4xYrQ5GG7I411jcMSQHjlNA4uNQrDYuQWjui91kHA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:36:59.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 173d5106-2b6a-46aa-7d79-08dd78e4ca20
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6111

From: Hans Zhang <hans.zhang@cixtech.com>

Enhances the exiting Cadence PCIe controller drivers to support 
HPA (High Performance Architecture) Cadence PCIe controllers.

The patch set enhances the Cadence PCIe driver for HPA support.
The "compatible" property in DTS is added with  more enum to support
the new platform architecture and the register maps that change with
it. The driver read register and write register functions take the
updated offset stored from the platform driver to access the registers.
The driver now supports the legacy and HPA architecture, with the
legacy code changes beingminimal.

SoC related changes are not available in this patch set.

The TI SoC continues to be supported with the changes incorporated.

The changes are also in tune with how multiple platforms are supported
in related drivers.
 
The scripts/checkpatch.pl has been run on the patches with and without
--strict. With the --strict option, 4 checks are generated on 1 patch
(PATCH v3 3/6) of the series), which can be ignored. There are no code
fixes required for these checks. The rest of the 'scripts/checkpatch.pl'
is clean. 
The ./scripts/kernel-doc --none have been run on the changed files.

The changes are tested on TI platforms. The legacy controller changes are
tested on an TI J7200 EVM and HPA changes are planned for on an FPGA
platform available within Cadence.

The patch set has been version v3, though the earlier two versions had
issues with threading.
The previous submitted patch links is at
https://lore.kernel.org/lkml/fc1c6ded-2246-4d09-90b4-c0a264962ab3@kernel.org/

Changes for v3:
-	Patch version v3 added to the subject
-	Use HPA tag for architecture descriptions
-	Remove bug related changes to be submitted later as a separate patch
-	Two patches merged from the last series to ensure readability to address
  the review comments
-	Fix several description related issues, coding style issues and some
  misleading comments
-	Remove cpu_addr_fixup() functions

Manikandan K Pillai (6):
  dt-bindings: pci: cadence: Extend compatible for new RP configuration
  dt-bindings: pci: cadence: Extend compatible for new EP configurations
  PCI: cadence: Add header support for PCIe HPA controller
  PCI: cadence: Add support for PCIe Endpoint HPA controller
  PCI: cadence: Add callback functions for RP and EP controller
  PCI: cadence: Update support for TI J721e boards

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |   6 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |   6 +-
 drivers/pci/controller/cadence/pci-j721e.c    |  12 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 170 +++++++--
 .../controller/cadence/pcie-cadence-host.c    | 284 +++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    | 110 ++++++
 drivers/pci/controller/cadence/pcie-cadence.c | 196 ++++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h | 332 +++++++++++++++++-
 8 files changed, 1054 insertions(+), 62 deletions(-)


base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
-- 
2.47.1


