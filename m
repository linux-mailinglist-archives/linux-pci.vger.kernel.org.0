Return-Path: <linux-pci+bounces-26627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DEA99DA6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01681946A18
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D013B58A;
	Thu, 24 Apr 2025 01:04:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022139.outbound.protection.outlook.com [40.107.75.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B962701BA;
	Thu, 24 Apr 2025 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456696; cv=fail; b=b3mAQYexiKeie4cHakimzXZV0VM77CXdIDA5+pED8PQ2mRbUVTf+Y4PTyqP5yt6uewZZjfpV1tpEUj74qrRq/geDOkBdjkWR2kVZju/+LcpMqFAVjnuPZuIdHwtCka3U4tDpH2FRQFO0HLSfQ78M7Azj2OcUOWOvpqVtSB+HPbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456696; c=relaxed/simple;
	bh=JFCpliW96HV3c5JMXf7mGtGEenEHmFczUhl4kkI+Gjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BxXj4j/dk3RTGXx5pGkGs7qwtGY+e+cuf1h8nuc+ujBaR5VaOyfplkH2H3tM2JJC3HUrpS89xQIWWCQyyDTX6jvWtwsn3CY4RhCVLjp5V08EWiSFppqiR1uULtgdHGyszPOlpS0EiaCozEm5HIKqTVVXRO4qVsSRpqggd2xXl48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4CJLWprYEpURMXBIYEjwgoKZm+zpZRXosNfmUW3XMSJ8Tuw6wN/bVVUkASHL1W24PT/9UERXXfdChw0L6NVau9r/jlmp92XQ+8+i9rM4+G2n7W7MsuptIIK/qndcaBS4arwct4bSfidVZw6/WRmTETbUv4lw74XqwaaTul0188piN0y5L6ehSYcxTexQHqq9BrcQQYMXh4Vx1XrolGm3zBkKCAF/KJbUE45olLb8AmraOmlxP6ZJ73NqLEavIPLLBRE83BTWBpe+l20SJx7El5hkgL8ZaXgPWYRHdHB8LZlxcTIK5HgvBxq4fdYrgBxj0tWYH5JqOvvlMU8rh1wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h83M5q3L2zQODZaf0cw+iVLwq8X2RsB0UhZ6IW17NtE=;
 b=htOeWWtpO2Qszj+qZZru9pykcXEwakCneSOoY34H0Z82nPF+2MNBxOYhumoGf51K9j1gbyY0oRuhPc0Zf6CV0oZ30EVyxKrvF259XF/oROp8VgmbN/ma24Sf/xS8EBFuQP4nKBUcVkbzdskCaFdei8+f32rMB6fTmNMHZYZdwBRs/FN/Y1Zuhv7FsniUTuH7j2/cIbJJO0MpyjoOenvBGdSJ3gDBlKk+U1SntTRL4XODD8RsGm6rKOP6Sdj1XBHFzpaitZQFnYRzou+2kcqAMfrgOmjYbfKv5BuaR1MzPk4vDpqRfFMwq3B2s2aVPEmOSeBOiXSqx2wen7uIZKRDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:404:e2::34)
 by TY0PR06MB5681.apcprd06.prod.outlook.com (2603:1096:400:275::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 01:04:48 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:404:e2:cafe::8b) by TY2PR02CA0070.outlook.office365.com
 (2603:1096:404:e2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Thu,
 24 Apr 2025 01:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 01:04:47 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A79CF40A5BFE;
	Thu, 24 Apr 2025 09:04:46 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: peter.chen@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v4 0/5] Enhance the PCIe controller driver
Date: Thu, 24 Apr 2025 09:04:39 +0800
Message-ID: <20250424010445.2260090-1-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|TY0PR06MB5681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87b94f69-0e23-42b3-cb82-08dd82cc0223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Xsqqqk1STS9cqBn0npUaBbyRKpXMHAYyTXa8gdvtLoMV1v3dvDDXsT4AE7U?=
 =?us-ascii?Q?O03Z9QUiYnYYmoA1W0r8aBP0uf+PqGI/WQsQAUlGxHxqcs4qyTuNlTPP1z5l?=
 =?us-ascii?Q?1cK4KJd9RJ/p/O2x5BjBv3Rm+ZQ6L1rAAcsWTc6XaaBJbsiRNqweSucr32+Q?=
 =?us-ascii?Q?K7s8ZSK/AXZYYZWJbw462BEamhN8Q/Pm2k4Gu+qSa6BDnS3ohmYTQGVaZeS5?=
 =?us-ascii?Q?Jy5n6xjABVcsSZqcWrhlpw1bcxakdhpzoFwHAaTA5L1bCZn/tJJDI/+1PG8Y?=
 =?us-ascii?Q?mPq0+tbuM+2ds2xZVfHpSJmQrHnhMwKqfbiNq7x1iHb+vRlFTU1fBHPvs9gT?=
 =?us-ascii?Q?hNU976hXIm7B1sWbx00tNbdGqCtKLfXgzjQEG583eocSvXEWt2sOtqBI0NGp?=
 =?us-ascii?Q?O3960RkYIhi9sB9VVE+IPPoVXTsPIfbpwCHDTWWXSl/RtW8TB7W+0BrCAk85?=
 =?us-ascii?Q?d9+dAc56sOCB7W7T6I6zPb6hnJ8jeu+EnNE70tJnj5KV3ReMJDscFrYTNsyW?=
 =?us-ascii?Q?hvv33yO5C8K1lh62CqhptmZhk7/SXo2d9B/IJy/7c0SEnwGMRmyEAfJLPLRN?=
 =?us-ascii?Q?05Vq59e91sB14W44FSzgzKR3IOp24jUfefkjFNf/zOs9c16YZ1FUFQihSMaD?=
 =?us-ascii?Q?BXn6aeW0ug68bDv1TDJ2BYO+8yQNQRr4XZXNvodMoX9NtLvruMqSMcoR+cL3?=
 =?us-ascii?Q?xQTuD1F4pvKk+urVCZgA4O3H8g40dB7uKoKqIt3Td1uXDFPEYxTL89TZTPt1?=
 =?us-ascii?Q?3VQl4WvffspLWDX8A5LNN9nrsWmxiSoRCHkQ/GOUzf6BNo89oXYHBcDJD4fb?=
 =?us-ascii?Q?YAvHzQF+xfuWXmP0VFuE6Eyimh4+sMuXeoqVWYwb0i4u8ylSZqxU536/akq6?=
 =?us-ascii?Q?Dyc3bf39b09Kjl9lfrUBvCV3JxP67/gUg8A91JOfttupdtNBxGgg5kPrCXBx?=
 =?us-ascii?Q?6uy8awtSfkdtOSzuRyhKZvZMIZmZjH16A7Z1YN7tzvBGFkPIdqCZJ/G0XSa4?=
 =?us-ascii?Q?JXJKsgKrORRa+mtS/vbW+TUP0ZLZXpi7xrVy7fVwubeuSLd08MhzUV1osqWA?=
 =?us-ascii?Q?R9x3Leva8E6SMOcqf+tTvdC/xqEXUd2Ml6V1edYQBdbhZ/RouX1UlxEfwQNT?=
 =?us-ascii?Q?tQy2KF2sxIm70moyomrL0XODJwC1LSaCSbJCph0FWTqDdied8CKKlxEaSIRi?=
 =?us-ascii?Q?FRgD4eWE157aP541JkkFDLNgyuLMORPFIVQMhWYMTSsDgMq8Ie9CX0orb/bi?=
 =?us-ascii?Q?QAzbb3n0538vOSSX5F4bYBE1tmnYvw8lYtZMFqlNEmEHCb3N96GMVhTDiEQu?=
 =?us-ascii?Q?Td4a/URAGzwMvTgP/Ad2KPE6R4awlrygZ6rfp00Az8Qr5y+KBoDFJjRCg9k+?=
 =?us-ascii?Q?wN68JtjCuaooZ/J3o/cvugo6xUW8iSPcXAdYOcJrR6O3u7A13I+AIKUCGkJe?=
 =?us-ascii?Q?LWtXrSGM3mTJe7n51/DX5PHmKz/yJKbMt5xrZbsLRidxZ/CVU30hNzMcDCjI?=
 =?us-ascii?Q?E9ffZP/N4AE9P+jgyNdCz/vhtXWJKiJRgGJu?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:04:47.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b94f69-0e23-42b3-cb82-08dd82cc0223
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5681

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

Changes for v4
	- Add header file bitfield.h to pcie-cadence.h.
	- Addressed the following review comments.
	  Merged the TI patch as it.
	  Removed initialization of struct variables to '0'.

Changes for v3
	- Patch version v3 added to the subject.
	- Use HPA tag for architecture descriptions.
	- Remove bug related changes to be submitted later as a separate patch.
	- Two patches merged from the last series to ensure readability to address
    the review comments.
	- Fix several description related issues, coding style issues and some
    misleading comments.
	- Remove cpu_addr_fixup() functions.

Manikandan K Pillai (5):
  dt-bindings: pci: cadence: Extend compatible for new RP configuration
  dt-bindings: pci: cadence: Extend compatible for new EP configurations
  PCI: cadence: Add header support for PCIe HPA controller
  PCI: cadence: Add support for PCIe Endpoint HPA controller
  PCI: cadence: Add callback functions for RP and EP controller

 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |   6 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml     |   6 +-
 drivers/pci/controller/cadence/pci-j721e.c    |  12 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 170 +++++++--
 .../controller/cadence/pcie-cadence-host.c    | 276 ++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  73 +++-
 drivers/pci/controller/cadence/pcie-cadence.c | 197 +++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h | 340 +++++++++++++++++-
 8 files changed, 1011 insertions(+), 69 deletions(-)


base-commit: fc96b232f8e7c0a6c282f47726b2ff6a5fb341d2
-- 
2.47.1


