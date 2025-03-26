Return-Path: <linux-pci+bounces-24718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EABA70F08
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 03:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F24A189D3EC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E13713777E;
	Wed, 26 Mar 2025 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MOyqfjPQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF05440C;
	Wed, 26 Mar 2025 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956150; cv=fail; b=KSyq8M36Lj2ZVgrTyXKYsii889ANB8i1U7IqwkRU7ZfIApNoJHMmp9jkmKYAhCuJasv3Ot8GXhQK9MN7JenriKCkLpnPvyC3AFKFODM24lj84Wm/Bf8Sb/goV9NwkmluU62WKqxD7Jpew+/WV4qdFnEPfdy1yWgPbQoHD6gu1RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956150; c=relaxed/simple;
	bh=Aa15qh9b7bylKTgGlSF9nqVD3Ab12+glVwA/K6utTLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZmmwSFW7AaVnH/gGwA7CI8H7faxRxxCTUfNeFHsHQQFYF2wjDLRoW8j1MU6YPZIMoVsYzAwzRkECoJaWr9wAN/vj/4S2MD8j7SF9d+Wm+qT8/HUUi/2INXrCWb86FjuVe7C1fCkaA5xHG0BgK6JsHzxjJABLvckrs8JvSvieO+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MOyqfjPQ; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIl3Cb3WnIDkGJzGDz5Yg9dBVd99ADVsV5wGAfKysNgONGi3WAEOL4zPSUtEPxxZGVeABooOuTkM75FQrewyb+skAKq1qtuByNAtcxdniSx5W8h1uCStvvtemdfP2XfO2IyQTb2MOmBCM13rri/J22fdGm5cPc0oDg5VkpJFVAaztc/oW23mjn/CSU3LpG1z77eM60GOaxzV8n5p9yzSCIIK9VqvYZILyhjNK0UzQcRzeGejLrlPa8cyV69XdoetU+R/ogmlZfATEhVgpN4ug1ah06HukjzlQbRpcFlKnuUp2JCKALpYU814bsTySdqJTl9gvrKUYBeRr/tITycwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8tN34BgOUg9jeWXhGJ7Uc0bSgPnPdmnzP36a7ltn2g=;
 b=K/+P+S1C3hCzaE3gaVVwJoqRYQGhRbF16yn2ja19VfG5qOkgkQCum4cMRmmFVGs805tddR9UekmhGxhKfJBwiEnvSZ/BKJQTZtOXk/bkYPIfDp2k3l+Ve8e1uTavoL4T7B9LeyK8Ty197T//+mnUWhC9s9xEqhwe4aqWSpE0y2kx8U/WTC2MX0FxW52sYaCWvZidwtR1Wxpan0+zta5eiDzGfwOU+DEHmHMh42vnjA7VkKJ1gvLnzmrZBD3QDiaD8HsGQqlAFfOlWiPsT2SYjaXtcSPwubY6v8RY7YrCxiKZMHkJ/s1vmKewUuoYTnnAJvfil3DpA0a3Hl1EyoQHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8tN34BgOUg9jeWXhGJ7Uc0bSgPnPdmnzP36a7ltn2g=;
 b=MOyqfjPQK0TUc51KTe0MM0aZGRvWtDR8JO6jBIct7jIS+uS5RnNpK4zYzMBppSqEtFO7WVcgpa8Lm4SJuQKBhx5fY4mhb3VJz4igAOYnvsorJEymtb/SK4wwK7mKWSvW3haCgkqISmkrKlpCIahMVZD3HRTB1PEE5HfQIy2jbko=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 02:29:05 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::7) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 02:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 02:29:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 21:28:17 -0500
Received: from xhdlc200235.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Mar 2025 21:28:13 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v6 0/2] Add support for PCIe RP PERST#
Date: Wed, 26 Mar 2025 07:58:09 +0530
Message-ID: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f96c565-9292-4c61-cd9c-08dd6c0dfa3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tls1wSZ49BsBsr9MMiDAqF1DaypwhgTWe2Um6gIIXJtA0hOFY7m4xep6RZBZ?=
 =?us-ascii?Q?mlugE0TOPcQU1AweGGFiXa/pwwc0F31mWDpdn7OEVfa5yWakLwuwjmWf5nU/?=
 =?us-ascii?Q?+2o6fM4i5pmv72U/J92YtBAE0ZpL7t1AP58wrImgquK4fzcF9yX9PrQsDu7o?=
 =?us-ascii?Q?9Ge0sZmnH4r1OJVwI4I1adIBtcYYZJMaeli4A+ppKI143ak+43B2mb9UaWIs?=
 =?us-ascii?Q?VcDYtapMhdhTclK1ttBOetQxqA0FCYiaGujyUbk1lQSPYV3/McRloVndtO44?=
 =?us-ascii?Q?4bjHC6X2Nw8kaDAgc8VR9e2QQQAqFe0PtJWSU3dPRF1eJGTilJrDW7bSg88m?=
 =?us-ascii?Q?/DhixhjiO/0HIo/hk1+Ld4BFO3DUGrPJDCu6+AybNeIeHINEs7KGAHwXKoQr?=
 =?us-ascii?Q?ja1NA3mnP1aaEpnuMvGN123URrIGKyjkHxbrQ1Bi8xoC2UA39z4PdpAjaneN?=
 =?us-ascii?Q?x29KaVExLUZjYxkBCUwgmsT3yGVf6s+5AMEEPRQ4Us55bJx5ooonYWVHNBQA?=
 =?us-ascii?Q?J7dVpr3CC+yN+iWq3nk7Q6iKbEk1gaohi61sIqgBXDlQLdJSQY+62n8v1Lbe?=
 =?us-ascii?Q?5t8a/IYj2UnLFyzHt7l3YMxAv1MeJLVZwlWjutGWhV/HQxTyhUSYCgXSUVMY?=
 =?us-ascii?Q?BbjovN5Agn360RtbuFUu5oe42z8gKVI8DdxpbJ4wvkFn4lZA8mZG3Q+vlQ+P?=
 =?us-ascii?Q?GyQNEGXNv5it0zTX9alx9KIuO9tXZBC7iGTI8pFlMHh6vdEt9gJOUGvZ5ZEB?=
 =?us-ascii?Q?Av4T8zDHObbFezxQEljDzVAvPUkOzxNgGulryXIW+G00kYx/h9ixM02e8IeJ?=
 =?us-ascii?Q?09LkWhHVj6ll5fAPMQa2YbXpyTBoz+AaCJnMgPOynJjJVH2wQbtkIMDBHrcA?=
 =?us-ascii?Q?qhC6dC5Y/nSzNZrcRXlCNSdJQfZ9XqHVt6FqErhSkLc+lFnuJUvsQasB0VRB?=
 =?us-ascii?Q?GRvzXSnEZh9Ib+ZGZHme6vlIc2luRDgsDm4x8KgqozYx3pRZgPIjpqHp4RqD?=
 =?us-ascii?Q?tsnmXe+EZxWSaYK8MC1C7hVcuzghj9Lm8Bdx7ttWVMkQP/mpmhGDVlrGkTqW?=
 =?us-ascii?Q?g/bw4LjjgHdcCoApP+k5Hz5DxCBsoCsT0f4qNayUAIZBF6MnBmxJ635pRQtE?=
 =?us-ascii?Q?pCRl6sTsKaP30g6jzOgB6ojW/7uRTi17DkFt+o5I/N6vIcKX6v6jpEJoTQIE?=
 =?us-ascii?Q?oiRo/Wqka7SmNXGT2EbCFvVmVsaX8xvXxambyLl36qVUmIfpzBKmSas0voBu?=
 =?us-ascii?Q?fN1cwlqyK2WbPufCqid5Lq0Ak/8GcNfNe2oOorBhy+A6sDwjclxeo2GKUrrz?=
 =?us-ascii?Q?FlrLTwr8T5mYbrCIkwrNjB+lB7YdFHjijj522rpxgAcSipV+l2L9UMwipTLe?=
 =?us-ascii?Q?4Jp2A+4crOxWO6wIdZ1o0sHvlp2u6VMqZiVooXxAVw5xUfepTsD6Tk8TGyYO?=
 =?us-ascii?Q?9Ya9XNIUyPm55TFB7+WxRO7bkJdcqzsgSAv1W7BYLe0zy19SdmAAiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 02:29:04.3932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f96c565-9292-4c61-cd9c-08dd6c0dfa3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller binding.
Add CPM clock and reset control register base for handling Versal CPM
PCIe IP reset.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       | 72 ++++++++++++----
 drivers/pci/controller/pcie-xilinx-cpm.c      | 86 ++++++++++++++++++-
 2 files changed, 137 insertions(+), 21 deletions(-)

-- 
2.44.1


