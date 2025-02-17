Return-Path: <linux-pci+bounces-21615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EDA38433
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 14:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C2A3B6B20
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1F521A420;
	Mon, 17 Feb 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="adzXJKhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EE21C186;
	Mon, 17 Feb 2025 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797719; cv=fail; b=T2z6BYh1tF5MPQkvu6zHf5t8xrYsoh3gygG1RF9HSah6UgkG7Ha5h82ZgBjkd9QF3DKiCtEic2DdbNCMCkwSFNhxqxt5mMseDOAdQjmxPY1LnBcOnNigcRYIPnHRgxdd810MuUay1oPzOymLckxtbRovBIOjL72Ev9Mlt3gXyuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797719; c=relaxed/simple;
	bh=SlHA42N8vicuBD0LsTxSAFmTG3EZwu+qT6RkjjaZ2x4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t5ebsZg8naUIvVUagWFErjIQG3gqlgBkOi/vhdSYe4FT894pDgH6XPDJeIX3jry1svG1qMaJqUT4C/VNaMwmMCk0q8gwwOwDuGXrnJsFxqy0pziaFcyvrpeIRu4i9ANUjFOWoUFhoZKjEdZMsra1mFOifOdqpl6Zwkm0TezwsaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=adzXJKhJ; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es/UPAaWCdjeY5mc5vRxjmTerNSzW3o6BbGNshLl5xKgDKXvJmTA1aNnvGATfjsy6gBJ4vePRW6q+NPkWTr4OFX/R2w/yzRw04jO93InIaTPqgClLxICO5bPgMNbxKqJk3FZ+OSCb/aWfRAMq3Laz2mynuevxnca7tV7gyCdZLDhg1sFkfGV+pAJRJTxrzCSBUMkIVmjcLkcCe4dzNqKjscO/sc4w3gvaZSOHkbXWdELbtIgARAOStEcwm+OjxkQiCSPfJXlh+YS8J6f6zf4r65q7doGSiMduimN2/Hb9w87GYxWLm/PK7JbVWA51YVifuxjessYX+hOVuBM9z3pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xST5M7eWYTybAdc12g9e0aNkTCugsa/UJlxUFutlZ0M=;
 b=wIAuD+rYp0z/wgBBHScBRoFEibwhQN1rm4fa3ZcrvNGmoOtk7f4fKX83P2REwbE5U4aL4Hvvxw23xv5iExSS9gIVv3GLkxkpyZbQTmiODN/1Zi2mLj2AubaoY/v9Rhd+0MUeDS6wcOFnmtume4t0fbgqhJSXs/yQd9cd6cgz+e/6MlSt8HWoR73v6w5GU9U9i8AxhwSovMdU+pkqVnQMymUjxpeXnJ3kRv1DE/SDxLrum+zJRix1FrvzC4/IZxwkv5nRcN7jceljxk7svDVO8e00z1r5BJJs6ad5po9ZBvM9boMSZcKrjuc/ajMXgxomDExMrSXrRUjXWxuhzzd4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xST5M7eWYTybAdc12g9e0aNkTCugsa/UJlxUFutlZ0M=;
 b=adzXJKhJIb/fD1OqTptxfrt0NWhLclIaBdCUkkTabuRzlk8/Tv0hSk/gJDzBdsC1bNlVaceoMD2XAXESOKqi4sp1vLx//sqi9A2uNEgboO9gb2xKFrrgKV/cXyhA8p74g+xPcGH1tHUUxprNGb+/7pCyGB2XEw2zW4lVgdHJX4I=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:08:35 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::45) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Mon,
 17 Feb 2025 13:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:08:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 07:08:34 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Feb 2025 07:08:30 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <jingoohan1@gmail.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v11 0/3] Add support for AMD MDB IP as Root Port
Date: Mon, 17 Feb 2025 18:38:25 +0530
Message-ID: <20250217130828.663816-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: b09cd82a-12b5-4bb9-44b3-08dd4f542fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xT81QHQLC8xt5U9VTZwJ1MgEzcc3UXy9acfLGiFlpw6mshNZPy3RoVZbvCJD?=
 =?us-ascii?Q?v/2RQD18zXi5okMoaZAJauZrO0QXMZtkSOW7pTvOS7IjkQtf29i1fVhBulCH?=
 =?us-ascii?Q?1lYyF4fOIKr/iJKRNevbHC88by4phPeJd60Ajy+vU2zt0Xr8QW+a1eKDUE0I?=
 =?us-ascii?Q?Hlv8UaApEpLyx4JnnAu+mgz+8OUFkj5K7261Z9ZM7v+BjFfcWc+Zg9OdJqub?=
 =?us-ascii?Q?dJ578VMWOIubgCZq6o6Q5pfxPBd24glpEGmcx6A14UwqsEWLXCTl4qa4c18r?=
 =?us-ascii?Q?9+XyP62k61XgNpUe+ZetH/aGO4xX682EcNprLGD5IcRHm8zRPFGbjZZCIbdd?=
 =?us-ascii?Q?SfLDBsAOlNPKevos/GP8gYEaIFdDsSMzoCQMNehr8Wh+WcHCF1ONMUITp5ub?=
 =?us-ascii?Q?EZOG5ymZdj2/ikT9dKJcZoS1i+eA/SkcV1icf7RnP7Jw93pXBxjtVZVTYTnS?=
 =?us-ascii?Q?zx+noH5Oro0dmVG3r5C+0sWgd1onZatFxbMddYwjDiiWQAyYlF8zEebh7IXx?=
 =?us-ascii?Q?Z5AcuXLU9qI0639gl68C74m6Uii1nkI8MHXD/Dw+B9ayymbDmCrspoKzTxJ4?=
 =?us-ascii?Q?6eeC0aduMNoluwbjn9uoz/wywkpPsXAjctDkLpUN5x8lhjjRIFhRas+1nn13?=
 =?us-ascii?Q?u1FmWQPjAVIYHKWlpyXrG52WbjEtAsbETYP4iFsaYBmDGkyqPP74dfATjAYQ?=
 =?us-ascii?Q?7i40vamXSAGplKE6Bd2aDccu6X7ONhZCf2X4/6PE4YvOiL3ovgho0cwuUq2P?=
 =?us-ascii?Q?d1cyi5Ebg8RmPIIUyrXPz3PP/tsTh280Ay4ze42x9I41cnLEuh+LQf60OUZ7?=
 =?us-ascii?Q?9OzHRRireAbSXd0Hy3u4qAN4teg5UrU7W0vEb5XOyFzvxUKVCFqNnv8hjYCR?=
 =?us-ascii?Q?E2hE273GsNB1BZmMlYHOK0JEdPcADbWK3b/rhBgJwRiNv+HaIkDZIuZiVrx+?=
 =?us-ascii?Q?SGy5U+dj/KWBCwxVy4JByqy0WlsLxDde/i/3XTiR9BpMt2Uf4YtiDf+OgbOp?=
 =?us-ascii?Q?1PeNPO3/2EFGawLoMjmb6BnyRZvvu6MjX3359I7A788+opTPA3iCX2QU6+l+?=
 =?us-ascii?Q?qih7F7Pl4X5Fw39SWjQsgpEUkG9qtrG9i0hvBkTiDupdwJUqO9SiqniBg/VW?=
 =?us-ascii?Q?yraouaLL8x2YQTvukIK8MAEXgf/bwpia00JI2AQs8SP4I0fS+LqoobrGgoOe?=
 =?us-ascii?Q?GrxLxTrtZT9rTGJPZXCVfOUJT+AvDLK+Ttw4R+zzmgJzoLN/ebeGyrbB8w+Y?=
 =?us-ascii?Q?oiY5Hfwlrjc37+n2Q9VyjzOowabMXyG7AZS/lig5c0fM6Pyu1WuX8yAhqXZQ?=
 =?us-ascii?Q?psWrUKp1QHfR2dPbvidTHHDiCFAJE2dFbO6kwgqFcAcPylJNO2qKJGLMTeNw?=
 =?us-ascii?Q?0dQTwvkmpaTHV/phvmoL4gsEH5hV19b8GMqbYcFXStGGSIZKUUL9ZlIJ/KwA?=
 =?us-ascii?Q?mbKT3XvnjYSaz3xq6JGxv8gowzAYXcgx+ko9UozCjooca4lLPZpWHVcX/dse?=
 =?us-ascii?Q?NYUfHfhr7Qz8R7o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:08:35.1867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09cd82a-12b5-4bb9-44b3-08dd4f542fc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480

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
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 474 ++++++++++++++++++
 5 files changed, 609 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.43.0


