Return-Path: <linux-pci+bounces-21801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49980A3BB8D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 11:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B1218984A9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27291DE4D0;
	Wed, 19 Feb 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ACcMxofU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD51DE4D7;
	Wed, 19 Feb 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960497; cv=fail; b=H6dZ02DvDB6cxKhCgHCbAfolbgbB3HW74zjJ5IBr/pGB32dDoEqCLyhpNbzdUPQFUlVtX/Ucar6QHUTgmP/uA3GLmf+K9sW6MEziJgb6KDQiBUNmn60mg3iddpszKs854R6qoHFm+Ehy/VxI3MksnbUJ5ZENEQ1IHJ5cGRKxBCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960497; c=relaxed/simple;
	bh=ja9GnQGnvV5c26tywkC4rrZ8iIIccDPh8qIXNLlkNVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvI5b/quC1zKuYCGGw12SErHsuSsG1pmUJORJt79/W8qJIq2Fs4EiZ0MJcEIOVOhAe35aN5K3MZAY0Y+Qnh9TmLWPzPrg+KrxjYpULQN77eUAQ3+9KoRwESOM8gpO0p36ZTDcu5m0eIEdpfe5HJJrKUrfwOT4oRZfFup45Rla28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ACcMxofU; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLbpgcPhrvJ8dvCCr+MnbJwqWRJg+lIy3jduFNcpAzsKo29X0nE89MQZyORy9DP+8UqXCYqH1ndAlywNlRKlrtAb7+3AJw3cAQofKQo4dQ6RceqvaA913c90mt1EaNTBYV69hbfSMXcRPG2Rn1LbCWhtNWJg9gzGZGTM1aak/eBBaWG0g1z9v2R3c8byXakcH6Ke6w0pAIDBeysZ8Ui6pSgjCLccWY6njIWkUyu2w+j6tNDEjrndl9L4R1nc5TUdTUIduwLygvwvsM+OR4pV5e8MB2qI/nLTq3XA+8LESvDV5D7eILKhEPo1r21GEN9/N+LW1+F71TBxLM2DExI0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTfoQZV9hBLigZYLSr2Kw5t3/YwCkEfPqlbm2d0i1V4=;
 b=VyUR05xEv6qOj66HxHxco+1TTIp80isuHZwAdFarpP7rIEtH3I2a+JTxTMtAYwrMb4lweWsf4eVbGpPc3C8GgbylvKldmyLR0dLRvd3ARYjVLQIKT5GBUhT+KLoPchR2t+sJ00uWLlQH57A27+bFnN7oVOi+EvGwjTmYJdcdZ4z0cJMjig8V4JnXUpLr/uhwZDmyoMvEYrOjHbhuEtZBdfmFgY2o/SCYZoRf5S/vLerNSzPB6OV8S+iR1RDFmHod/MNiRrX/B/N+a4IZ8sGxdeEIqxaonvk7l5m+kULdxuAJcETyQc0ibLIuJ6zGzYuykuTJTwowozBvOkPxGIDLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTfoQZV9hBLigZYLSr2Kw5t3/YwCkEfPqlbm2d0i1V4=;
 b=ACcMxofUWg+mvu1+7Cjv0I0oq7Jul8tsHLTM8CAGON+chouUGeFYEnYfVvGmQJPzqPOM2SU0uuBDbScLjkvYjBvrQsLhRQZOvMqU7WD36TvPFF3VH/lgjLf2L7OYs6+zKPb4TOrnC3MvNjzmFfjtjRXoVKDEZoLcX8rP0IvIRAc=
Received: from PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::24)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 10:21:31 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::57) by PH0P220CA0017.outlook.office365.com
 (2603:10b6:510:d3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Wed,
 19 Feb 2025 10:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:21:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:21:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 04:21:30 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Feb 2025 04:21:26 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v13 0/3] Add support for AMD MDB IP as Root Port
Date: Wed, 19 Feb 2025 15:51:21 +0530
Message-ID: <20250219102124.725344-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 723bb22e-b1b6-406d-d7ec-08dd50cf2dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9d/WUtDouck9SwLxiZNS33kciInpX6ILJ1iobFmaKUOhisfJ9N6xadgYLG2?=
 =?us-ascii?Q?h36tVwK7J3g/S5mts5/njoD8+gnqfKc57vY4qnX23SXfddvhudlIj9g3WD5n?=
 =?us-ascii?Q?xVqKvFuBXOeJZJml+hyVupIouEzg1hagRojzhni2lCGCaTTSmLtXW/zoedqx?=
 =?us-ascii?Q?7C1xLfR02z25zvQguLmbPDp/G/qlqANG5OSR6PQDgM5PiSGEMY3QwL89Nq8j?=
 =?us-ascii?Q?/4vKkYEXWX4iE6EmJcg3CmVnizcjzXEucj5CKxwkPLUH78p09D2tlQ8M0wz4?=
 =?us-ascii?Q?kXhnbD5gL9q5SE25yb4DwUcmzraMEqTrG7zYngKlf1HD8mUk9D1YtPC6zvBt?=
 =?us-ascii?Q?GrJlNJnp+3g9Zc2grW2qIRYP/NsOdvZQ4QBKinkxRcTAHgOGGx/8KzdBSqNd?=
 =?us-ascii?Q?cyBx/kIBsk26hQeCdXOh0zqGt/1sq2Kh/57l/HqTzqpdLXFz1C43V1mnJXg6?=
 =?us-ascii?Q?kPvgr1AYg6cO/1n1OEFmIC0S0O8OG4X4ssG35inZyQkRmEUdJtc/S7ZT2fK6?=
 =?us-ascii?Q?v9V1I3uPwqq3a1FQZxQjlm8JoZgH2Eh2zicfFtvutcWdUagqUM6M9O+6Dr44?=
 =?us-ascii?Q?Cn3g0zQk5GoJuJP/FU0X7J6dOHErbZItL+cFCYuCpDrna/BHQrQp9n/tqF7k?=
 =?us-ascii?Q?mPtvQcShz3hTML9U5kGOI4YMBv265CSuu06v1H7RBDNZgxS1WjSHIDjkI6Qv?=
 =?us-ascii?Q?wMT870lzllrlntyJBmI52P+3hyNWuWzFlAiB1tsnDJXzUWw6pL8rFZzGCs6V?=
 =?us-ascii?Q?HL4D41dNjLRjthcl1n/JfW7gtClm7W+HOn2q4aHEDgt3KNbSz/zniHJX8/4N?=
 =?us-ascii?Q?8NmDUOwEetbq+pK6iBD+6w1K1LFYzURGVve7omnIA4Qmocg0L4gVbyoj5BIA?=
 =?us-ascii?Q?KyVYwIaDnyx2lrdcaYxmVFxqW/KbpISS5TFkuBK4CJgQEVeW8kUzVpVIP4OJ?=
 =?us-ascii?Q?eF9OG1jc6z7s5Y8a5YpGXlyXPgMopXZ6eF4ePPCZX6EmHCQN4yhUSOtZlsMF?=
 =?us-ascii?Q?2AArmUsUDbiLE02E7VVOU4TkwsR8cLtAfw6/md3a97g29TKnT5efv7li/TA/?=
 =?us-ascii?Q?AY4N++evTXliHG7xVh398Y4MjqL4rpoUw01wPLamoh+ag941zALiJJqPGOSY?=
 =?us-ascii?Q?eJkBkF8vXQtBxGpn9wh1J5dbZ0hrLjmeiTPUHIbswmZFmo22UMB5lHjCied0?=
 =?us-ascii?Q?ut2x/LvzoXfj81VN+11LoyM0vx7IeM3OU2p3tdfV3prApqvUyyXDtN9Qdumy?=
 =?us-ascii?Q?KTtzxpUXYDKqRBf7NTX4F2xXETTZX0O3pX98/vEMLV+v0OkQn39xVq/9hJuv?=
 =?us-ascii?Q?9uOVdi+UXkyaVKn0nfk6FkCxQcszL+tTwvYrfMt4I1dXfbz4nJT31B3eoPhr?=
 =?us-ascii?Q?mlKwdNbkP1tZEKjNypX6pSmDUBmwUiz6U84VQvdK5nUzTLoAScztnXMkqryG?=
 =?us-ascii?Q?R0JQRXWX/MtqE1BFUsoV/D2fyuAzIqtlByBhQfnQFXszcYKkzAR8XER4EhJk?=
 =?us-ascii?Q?L/hvSC5rAosk53I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:21:31.2397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 723bb22e-b1b6-406d-d7ec-08dd50cf2dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

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
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 470 ++++++++++++++++++
 5 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


