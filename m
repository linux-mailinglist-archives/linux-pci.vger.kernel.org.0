Return-Path: <linux-pci+bounces-17572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5C9E1C44
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 13:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1E161381
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7D1E5717;
	Tue,  3 Dec 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X3ajeqSr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BB1E570F;
	Tue,  3 Dec 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229381; cv=fail; b=sVsADYot5wXlr5e6HJVFIqy4ONO7K+0luC/lp2RIiOXTeDDTURRRzFFw8zSI8WkGJsQtckqnOVpCcOxt531m4iYM/AYFbe5irpM0mzJ/tRF2j1Fy/3A5hYNeRpswP0SXLfIry/PBfbDmez2mUPhntzqt9bunRTs49qmq9PIMtOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229381; c=relaxed/simple;
	bh=MxbXoRfK53+cSQHxwyc8g4aDa8+vgJoc9pbKQAZabOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZS+Aoofh20mAMwDN4qrEk0VbDhcnhRy6vyCzeetXJV7ZyYoBOdofLHJ6SqBFRSYklbxs4nCRv09qQJCLpzHUE2qvjlEjYcL+qbzYRk+81/Ln/KX1ivWLHn+pUWwk7NRMQx64oaUSDDbls5F28LCZ2ImJSDwtUXcN2RZf3jmhetg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X3ajeqSr; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2jjFtPWy3iN6u/MjYg7CwofCA33J46TGIeawiegOXsJ+0FEBQWAAPCqWxiK/P0nnPHRUfsljtAolcfbXiRJ/DzPfWFa/r2o4mttTWPXp4MKi6e/RfADtYpXwj/5onLa7Evr8bFFZxQw3IX6JfkWZgVw0fdTyTF7YPWPAQZ38gOl8AJ8uKuXaeximXdyKLv7yROfo8GHiwYPmFZAfdH36bfswDTYTBVy9wDecoSxLQYA1xtYultPDuddPf61awbSBomBSCRAcXYhUMZPyY4eporbXrUnSzmP/xg5mdYxHZn34HIBWtbHDSxyjUGzDk0koS4OKJw7m4xVU12RWuoMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55dni7nu5iuGrZAJQFmig4+HW+y4ceIiKOAVmITVbqE=;
 b=ZGtuSkl0UcUBXCVXpdo67OCRQ9bZeK/94bgLcJU9sU6sULxcGmndIrKDyOvEpyqyx8nNJWVrheBS7wJb+x/Q/VhR3AbKSCS+mBxP21g/BZO2QhlX9r/uNdOJBcJjKTm2tHWF8ryDh7iAGtmS2u7QVXhWwkMYyJI+yvjv9Re9O+KVxkG4wHxweKxow2rfUHl4gyOCCUJ3wcvQtfuJdxnJV9o/DjfKfOZK8aZ+nN7HcN6l5r0eUYDSBuiZ+IoA/hmwKpM3ct0GTnjx+wYFWejQWJiVOWMFXm+XFZxqO3rPKITEUxqM4vnxXHn665cHtLnw1AsSF6QC+lZdNcWm4BIjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55dni7nu5iuGrZAJQFmig4+HW+y4ceIiKOAVmITVbqE=;
 b=X3ajeqSr/JLoSEFiAJoHoChpv3B7n66wdApnSi3E7F5eqVlNGZ3+d8qqUGw9hvvkH3VB9YipQzE24x4Ic71S5En5bJdVfDlt2TVOGcwi9Cdy2Bow8pLbK42cM63KrIrejKGAdPN+BsNUEUy1WaSHo4mUsUKv6cwPngBNt9LnOr8=
Received: from SJ0PR13CA0095.namprd13.prod.outlook.com (2603:10b6:a03:2c5::10)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 12:36:14 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::4f) by SJ0PR13CA0095.outlook.office365.com
 (2603:10b6:a03:2c5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 12:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 12:36:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 06:36:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 06:36:13 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Dec 2024 06:36:09 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v2 0/2] Add support for AMD MDB IP as Root Port
Date: Tue, 3 Dec 2024 18:06:06 +0530
Message-ID: <20241203123608.2944662-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6947e809-3846-4242-89d9-08dd1397139f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMVzutjA94l8uEMMc+SyMMClX48dcDoeJ/9Ws6VVOSGnbKwIdCUHN2KLdWKG?=
 =?us-ascii?Q?+8/QtlG6ZqOZNG78EL/Ytz837r+4fJ/kkmGHQNK/X/OYnK4+Fa9vooiE8g++?=
 =?us-ascii?Q?7ciM6cfv+tIfXUjfWIXxMzJbPKUAjaweEVCPdRmtl1VA5Ak+8RIshqbHxYEr?=
 =?us-ascii?Q?PWYS2R6lGIV2qEtc+Z8nX2NgUMXx4IxA6eg4BvhRgH82FgBGy5UTI7773hLL?=
 =?us-ascii?Q?HPscJUqI32aS62DiuQuluMp8D3cqbTKqb/mmo1wrTXT+BDwybbqSnXfk9EJE?=
 =?us-ascii?Q?H0PeLN56MjoX37PBfcTVfLG/GCnGuq0IPGCuHZpZ3bfQXzIxqNZBwk1fKRU/?=
 =?us-ascii?Q?+0pWD6bcoXyD9p2EAkiHPz/lkyfe3MQZqyTiuxOCZ1K+Ufpd9YMafhL/bqOE?=
 =?us-ascii?Q?aR+6F1WSHu4X9cXL/vISLLj3GkSfNDjWFm3YgG7Gur0a68oC4XxEX5PXxVCj?=
 =?us-ascii?Q?SuQS4xlFMGxgrWae573iXmerR1KlikSgZqrhugHbqI+h+m/K/iG3pArcRGfS?=
 =?us-ascii?Q?YSowqBprmoTITRCIuFn8TpvO2eQOiZxVHoAcgaqmm96C3GEAQrO9vZ9qyCKN?=
 =?us-ascii?Q?SJs+qIeAFSSSf2v2LKHe1lJECKGYMWtQE5MXRPiNp+EkYZbjjhk2v1mLRdUj?=
 =?us-ascii?Q?wcrz6x+6UHAG9l0iLtC/PkJGxSb008wl6taKPGqZ1uHjM2q6CVGh+yYVc9uv?=
 =?us-ascii?Q?Uc7VrjxsyxY3JCseTf3sme4+qr//qIYyYX8w67vXMua1B6VGhcREIrXXZswK?=
 =?us-ascii?Q?XGfhVYAvTzkgyX4HtmcIZbcQSUuHGjyvM0nmc0eHUf2Ql1u4HER8Fb0WMci2?=
 =?us-ascii?Q?juGU7r085arjTS9Dp7h9sWCFB5KpxiVp+pr4oOOgsHGb6JJnHLsnKK8U4Ui7?=
 =?us-ascii?Q?NK8TzGmiWdctMd3+9aTZ11iYdUwM6GbT5Su2DwjrENAsOsZBeanGZpYxkfg1?=
 =?us-ascii?Q?AuT8SCaREf1xH56RkyzTr9ztCw9Iwn7RFfD06w6hczcIM3QyfSvv+qnUtIBk?=
 =?us-ascii?Q?Cvk/1gcNxaFlY9TgCrQc5nNDLn9lLY8kSVMk3publEgd87eOjFUHfxIl3BSI?=
 =?us-ascii?Q?2obwh3/XySPe9zWMhzHa9+RoIu+0pXEzUv58bseoNQwdDWyQwAqXCKRxHoR9?=
 =?us-ascii?Q?eDVvYLM36SM3akBr49o7rx9rt9wcxZG7lZnDrObzUrRLtVnVGEFsbtHDUX9C?=
 =?us-ascii?Q?llWPOgtEF+IwOOeWQjAi2zZXPSqGHl6Q7OT3RmCsfhJNhI6Jx+ZzhbqjwqYX?=
 =?us-ascii?Q?rcbsKWqslU8mCRO7CXIOuQyxuT4NShdxzxXlTYO7w1Sqo2pClbqX5TycmRru?=
 =?us-ascii?Q?4muKhnrDGbWFdIKp6wayF7iRdPKB8OgdqWPzt01TMOYKH7JRUiV8cgdR9ntD?=
 =?us-ascii?Q?EbQWeDIYE5NIocIhftR+jcWNpmM34W5aHssabM/fkUszRyy87jsI0eqsDrZ7?=
 =?us-ascii?Q?Pj+arYVEaWhO4Q97G9GVbgfScCF260N/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 12:36:14.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6947e809-3846-4242-89d9-08dd1397139f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 132 ++++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 439 ++++++++++++++++++
 4 files changed, 582 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.34.1


