Return-Path: <linux-pci+bounces-21139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC5A303B2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234A91626EF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CEE1E5B83;
	Tue, 11 Feb 2025 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gm9lJXBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56E433BE;
	Tue, 11 Feb 2025 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255946; cv=fail; b=ahOMHVMA8UoHAKQryFxQAdvOZWJynNkJDeibOMdmHhhuAmkJblJW0Iw666Z8S2/EjAUmsIw8dCwFj5OhD68kC8Hvqip6NS4DFQK4kzJ2exA3T3lP7HVsPbknz0u+0QHkGZilQcO3O/Q5/J8vSBNpt5+UD1kapDSVAgvyTxoTeAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255946; c=relaxed/simple;
	bh=VG9bRhRhIlqX1Ch1bHCLLKcmir5cJIlQBF0xfNo1bEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UW1jpHsymA0t59Gh6A9okkEmY1JNRAPkWtzhnlMKhGNykbWr7X6nIdR3V5EV3uMzktloWKAMYeDwZ0pueUGpO3sAh44acxMxpjtVWD2eSn4dbVECafCH7BhDXiFOg8woe3Zdxr7CU57RTG0obW/ZjozEVLQli/by24n7bJIp8Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gm9lJXBj; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWXfoE2cSC+h0wUjMbpqL7AsOLTLj/GpOzxmIt6zzeRVjZP0MG4OPMkje1C7ItnX9nzp5AYByb5qD/0n7vNo7pLKdDKNRkF1I+GH4zSnA3lmXaoGYv/YtfWE0JZvC4Rh7gwSMQkBZaR6/Knb+0JvzDmfVCrkoDI1n74tmWD5kHA1U7ZhcP6IbuhwdjBIL1hW6BJfh96/xcMWcyiAolhChAIsH8M9CQcijPirp9K4uvJCGn4SdKPR9IsM7qaiaZSs7mR5VRTI0UYG32ifkSdjSLS5+alqQCThQtW8+Ec9MFN1GbS+nWcQ8i/FdZHcGNuUMQD41VL6rPWiYZGYcbbUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gDxeiOge7Jbw+yQzZaj7Pp2YflprI0DLC8cM2pXRV8=;
 b=JBl053NskpDjwyMuow8s2/7VzjfNdGmDmps1KuCcA1dOje9lpSJH21bbQga3UGUUf3OAmTBJmSJGOWAxfU4Sr+MA7UDU+AH6BFj6YMX6B9PnwazwxPmCj96uTwzHNgSpKqf4LH0SPVrG1kU2tsloe7r1xYhj+U2aayK0XJgp8wsre7F1LIUOIjj3Il/ddf0q7oka42c2Z4VAt5FPcoHsoMstoGRihOLyIw5roVcuZz2hSjYBssnxiISsk9bgV+et+2UKl1FfHFH0a2ri4pJzpvtTqyjNbFfwILcbA/Cg6hJMA9turV4+SR07x0IhoCaIVFUrWZJ2c89jsXtikHo0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gDxeiOge7Jbw+yQzZaj7Pp2YflprI0DLC8cM2pXRV8=;
 b=gm9lJXBj6tfo+97g4eJ/RUKfnGNn8bhR2a1DRkgZ2JkFh4mmM/e48uYyXovcRDOM8bCZq2bfqebcJ6wZt0a4gsUnz0w4GprvS2H3xwDDRxIxCF2L1t9gFuIds4/dQDz5oMuxzeN5g3hPqlafMHpxixddALSzhWTadflspiagKtM=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 06:38:59 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::ab) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 06:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:38:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 00:38:58 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Feb 2025 00:38:55 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v10 0/3] Add support for AMD MDB IP as Root Port
Date: Tue, 11 Feb 2025 12:08:48 +0530
Message-ID: <20250211063852.319566-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 071a8d0c-ba7b-45e8-60a2-08dd4a66c421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5iN9POQybpzHxPXzk65IOzyU1/VxpwlrPH5mbRXLnouws7cyGwu2Uo0TOekU?=
 =?us-ascii?Q?ViR/kbK7GJ4BEeg15jdcueC7CLvpjXn0ssG4lxyrNXv0yEAwFwKv/7aKYGU9?=
 =?us-ascii?Q?zSJepnKZj2GFi7ZoJo7nMVs8lPRjwGx+d4IElYKqKYhXRF0iluOJ7IN6lJIB?=
 =?us-ascii?Q?yvA0TKbkCUsEWVQh1k746l6TVZyvbBCB3DzQYyjwz78eEkvPl9vbbD6Vq3CQ?=
 =?us-ascii?Q?G7Tp6kEKtrJ7UWQZ0ESljZNV0Zh1z57hACTYrHO456Eytatm5FDp3mINwFb/?=
 =?us-ascii?Q?3RAA/yQbKB0EgRtZZhLPa3zDblKfWnH8bVMac3rFeQsG81G4D+VKhn7BpVIW?=
 =?us-ascii?Q?PWC1Q8F4a0L83m4CrCDA3rZ31No5lxdJqqhh6olz/vPTWlo1+HdgOugeriWM?=
 =?us-ascii?Q?cv3dTuki4fLkup55VkVN7Qw+QHUDkzN3wUHRpJbP1aUd1zXINpvEAU5Y9Qfe?=
 =?us-ascii?Q?ZexZSkvcJaSHQjxiGEnMKCAuChWREqComjUPBgbXRH/8HFw5XF6yvQ5eGbhJ?=
 =?us-ascii?Q?tYRSDTlkouJnbRTNg5yxYdKxygm95yjxfkZg1C+zef8QRFcbRnfmfHT3a0b8?=
 =?us-ascii?Q?hSiLzaUz3J/UEMr4x9c5Y4//lMcEoKsdOV+q8RDCgp+A1BmF2UY0G8E4xZWO?=
 =?us-ascii?Q?qsZllFU8Dhi2Hzm2mCvK/0KF3/OdKz7wKCieu8iZvj6C6peIJJD7KbB83qpR?=
 =?us-ascii?Q?KO2LV7WgJ/LFx8MalGOU+YVEszn7Yet0BhmrbcmPMUK/3LKRszD3hr8r4vNo?=
 =?us-ascii?Q?KUJTY3CNMQIJt05nFivRWvYc5MOUOu2iUm13CD1du0rZo5wCGHw2wLiCBosA?=
 =?us-ascii?Q?Ei3QJLPxLpifjuQ2CVR1LDzxXQroyuNGYa4aWhdXqZDPqukwcnWT6089DLxW?=
 =?us-ascii?Q?wLeKWMguMZCVS68kZyEb6OE8c/THf5YSJS10nAB+mCR8L/eOt918AFy6Fc0f?=
 =?us-ascii?Q?7UJImSLlxw6R1LNEGWTN7N6kG9fAzXVF8mG8rhcsKQkH3LM33DArZkAHXsW4?=
 =?us-ascii?Q?20Bu83WxS+X8ypay5SGZDHr20Jzio717rWBLgeugWwVUONqAZWP+4QgN8OeD?=
 =?us-ascii?Q?fCgC2ecXmb5dD/1i6kaPIciWBUNWHzXzeL2k/oz4dbA08pQ7Y2stxc8z7d3v?=
 =?us-ascii?Q?q+J8J8xX1hnu/uQ2SzmkCc83arQUjF4vG1cmZKf6chL7YnaO1saz81/3Zqhm?=
 =?us-ascii?Q?D84A8KOnP1qDB4qDkfhicURzAokGAjuEwRHnKCj26+rpMqo/WhjsMStlyTlr?=
 =?us-ascii?Q?Mn3cJAl6VVXPKEAN5VknSrUSPAv/RgCTwDh5tcujVaFaJaUWZmsyFgIJMEGm?=
 =?us-ascii?Q?6bt08CwteYo8tGjSyam/qS47Q6UaNCCE+8bvDYLF/HRDimPfoXwdF0FanGtZ?=
 =?us-ascii?Q?tVOGCT8Q0GDGjNiOLFGIlMZpsOQU4g9fW2yS9xX7WcyG4eJzUebTPKTZfIh1?=
 =?us-ascii?Q?OTyaEUlMVbrfRJAsjQqUk+RY1cAH/y0n3XntyBl5ztrOTLVngi9gQhEFJ7X4?=
 =?us-ascii?Q?Cq1oEHJ+63Tc4xM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:38:59.3338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071a8d0c-ba7b-45e8-60a2-08dd4a66c421
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (3):
  dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 477 ++++++++++++++++++
 5 files changed, 612 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


