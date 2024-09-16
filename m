Return-Path: <linux-pci+bounces-13238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040A297A605
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B3E1F23152
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED613D62F;
	Mon, 16 Sep 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EM0qNuC3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F3A1C28E;
	Mon, 16 Sep 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504300; cv=fail; b=p0e0oT9s6/HIlZXcFNQkEqpF772ursr8O6lXyOjDZ9MDdi6uXmc6bullRT4UsZmV1OB9lF/GSw5flGg+ydHTA6w+GVRBAWkscT3SS+hpfwIWpWhbUorzDhO6bCoI+po1ZA7vYmW84FRsVilnxbBNaNC5IplFWDr1SlszAoz5cuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504300; c=relaxed/simple;
	bh=OjU5SpAah2/tPZzSFxY4kuJRVGrpYfrrsN4ELUwxa6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IyZrb18LskpyZNMtlYZPX7X6l4f8pESbDy3oKveEvybTkHgVqHsbbQZ8+CSTNa8o8ZfmzaMmILaXPmcHWqBoE1lo43NCHqTMdHYzBxcOfOqC23ciFlYSuQSI5HUvJkUFDrZVaVqWrj0pyRtGQfJHn48tjETv4vKJGfKKgHD236c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EM0qNuC3; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMBuwNDC3ATL9RYs8RQR7UcQ/yqFdcxrLwLbu9fbwUvZR47iNwWEmJewYxFvKm4DNhSiKiBlvsbcu/lu452oa3yff9t+DYD4HGn3mPiv3DK4EGAR7FZ1ap426wZym8cPZcaTpblV84YVl27bN16ExrsCtUmobBvFOAJdn1KyetAY4yK8LYHYLKQ3vHXOMyrvyrWQwJP4hP/AkfDQC9ATEzU1aWQlEH924DCvHLz5XjMIKnH0lXgOPCK4veWj1zCuZrPmh+qRpayYE/I5dsiZ2yD6jcsjXQ3IGFSaYTFR2av4TZC6xFJkLVprz+J3hgE0POopchN8anj9o/UbgxZ83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl0I8K/WXO1xg8v5mOQUv+HUH5Qh7m0+R2TY2kG4YRo=;
 b=xX8o5ALZClxNzd0tMoyuQ6bMWNMcqhtc0WPQOSpg3TgUknEgNnKtC152BamMqdoyAzjUxKtXFLHGzwkG85snob2zCfxSIjWo9PQTCy/ngFY3ITFb5LZ8teAz/U2IPYG1IpWWyOIWP54eYiC16CEznzuTLb6J32P82i1BQ9dwE0rLoHCPV1rrRjxwKdwa4bX/FNFWTf8eBm81zGhfNNBt8B29fQ+/iWVZzBTYt0uku/ndcogFpVdVj5hIRpZJZ63LugW2zyRKOXr2NBOueWq0ltaZ9thB5C43IlAnrHA5JeHg5I2pnkeDTNlyDS4UOzsNC6zQRQRm8L0LbB7voT2j4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl0I8K/WXO1xg8v5mOQUv+HUH5Qh7m0+R2TY2kG4YRo=;
 b=EM0qNuC34oDJNJkGYaMmGk3ZVG1DRzRRmDmA39xn2oMaoSGqN++9apaZVmyYu4ni+uwFjtepSb+0if04JZmr0NdjZwBxkqx/+z5nvHS2ZCynN+bZoLllmaNm7vGScBe9wmTn+lx3xftdikRp075JTWnp5i9vR5sPTtt0Yff5/C0=
Received: from CH0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:610:e4::27)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:31:34 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::33) by CH0PR03CA0202.outlook.office365.com
 (2603:10b6:610:e4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 16:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:31:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:31:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:31:33 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 11:31:29 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <bharat.kumar.gogada@amd.com>, <michal.simek@amd.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, Thippeswamy Havalige
	<thippesw@amd.com>
Subject: [PATCH v2 0/2] Add support for CPM5 controller 1
Date: Mon, 16 Sep 2024 22:01:22 +0530
Message-ID: <20240916163124.2223468-1-thippesw@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f390d9-febf-4083-4584-08dcd66d0771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dAXWu4mN6GR8WDjIQnwUYmP7SfZXf9bKjZ3zAEs6bJ7iAnxRx3xIrcmwve5G?=
 =?us-ascii?Q?SNWQddn6cMIPpNt8j+4NzNO4BhKm8G8EIvYXabXApaVwZ12leX2tc2nI632Q?=
 =?us-ascii?Q?WduP06K/z6HhzWTBcNIUO8ROKCCY2OEUnEKDy/7zv6OtmjFCFVSlMqKN9nqr?=
 =?us-ascii?Q?aZ/5ZXnJPBk2Spd7aG08Yg9Ef7dQRo1O83Xz1tqRh+4qMqfGaGtGXQ8Q1oCM?=
 =?us-ascii?Q?Lr9EiA96wUAYC2pj4VO3k219KRHqoq/XZDFtKOUjMOmBbyuuH3p+c+zcSjfx?=
 =?us-ascii?Q?53fxE59N62PWidMyRAAotq/61H2XzF1OvjNZEfUnkijL9xTba3nTOznl6WtS?=
 =?us-ascii?Q?MOrLKGbeN8FchYOEKgiPyi1stukg4XqN7xZ0JD2mulggirVg87oADiozMijp?=
 =?us-ascii?Q?1SL7eJN8pbeqKnxebDa/Okg1Dzu8KbE1Lg1wA3vq5Qj78SI3rGkZGBr9gO0T?=
 =?us-ascii?Q?pROiOM2TDzeE5rHEoLLk730UfkPC67NLQi/Cmsk2KqKO0JFmcf/S+m/iRp44?=
 =?us-ascii?Q?eWR5QFVALjKJdsIUVmhiMGp5cVCiOpZd9gAp7nhmzO64v8jaYhFjgtUFrLy/?=
 =?us-ascii?Q?AAF+1SMa8EgbAYHIi45xEkj7I9ptwT2Vj2+piMxodfK1x/eER5fp6g4BKcMR?=
 =?us-ascii?Q?hIDMSo7YPYWOEjlHm0/XVyF4lSGk5/pNUepAGtVmXZfssThIbqZcDJxMbPwb?=
 =?us-ascii?Q?d9BBGW1q3IlnTkhYTgrKZ76v32bd3QvKgrEVUy+MPkOrd7OERRbGD3nibBfw?=
 =?us-ascii?Q?OqhVCou63PUl84B3iNwrGdP1SNJ8tb3XRFpbA2skxsJBRy6oLN16GI0doN3l?=
 =?us-ascii?Q?6+Wd0vHKTAZ6wSnFSSd3Ai3cr2Zlgj/QpZc3Anki0VNQZ/JQiTEV7cr5Q122?=
 =?us-ascii?Q?GHY/WFvhvI5WMY3RRdJaU29qYdaPg7zOBETzSByC1L6BsPxCz9DiB9VHjsm3?=
 =?us-ascii?Q?i1GgnC/eAkvernn6ZkZrvPGa06s8Ino5MKfdI055Yh1AaP1cqMCyGC6MYq6Z?=
 =?us-ascii?Q?5d2yZGrfCMUcgXrdbfAKKNvdjKmBWX5uauP0/pKhXqM3mP8k2i4GEUDkvGen?=
 =?us-ascii?Q?BBmFCYNVQqamHNzLpr08DBrQL6/gNOftYRhneDDywTgt4Y4nA8bjxzcQ6m7w?=
 =?us-ascii?Q?/ctjaAaGuC5xVWlXHnunLgggc5c8oqSCj5VT0lvdCUMuCEb78n4j+RF2UBlq?=
 =?us-ascii?Q?h/U2mB4hOb1e5PUd7OzeMRvJoEfyGFwY8uPNvxLrQAv9COXlOlgAYGHdszSS?=
 =?us-ascii?Q?SALgZxmELHkonrejNfSSpBV/v4DOQLI0arPzwk1SKy7Ff9wWdn/82fDVjO9c?=
 =?us-ascii?Q?RH4m22Q25REJlfvj1JE1E4pCDmleuSMC+pc3kHu7Oty55u99zcUU4KKSG8Nl?=
 =?us-ascii?Q?/rzUNJp+knNplI571SluVMV9HLBZZlRBxxFxsbBSzK8rNGICkwcRaEynvegD?=
 =?us-ascii?Q?6LVupoBdNbogc0Nv4lWBCgmp2bGlTveQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:31:34.3317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f390d9-febf-4083-4584-08dcd66d0771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

This patch series introduces support for the second Root Port controller in
the Xilinx Versal Premium CPM5 block. The Versal Premium platform features
two Type-A Root Port controllers operating at Gen5 speed. However, the
error interrupt registers and their corresponding bits are located at
different offsets for Controller 0 and Controller 1.

To handle these differences, the series includes:

A new compatible string for the second Root Port controller in the device
tree bindings.

Driver updates to manage platform-specific interrupt registers and offsets
for both controllers using the new compatible string.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5 host1
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port controller 1

 .../bindings/pci/xilinx-versal-cpm.yaml       |  1 +
 drivers/pci/controller/pcie-xilinx-cpm.c      | 45 ++++++++++++++-----
 2 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.34.1


