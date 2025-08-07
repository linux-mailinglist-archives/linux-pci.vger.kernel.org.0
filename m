Return-Path: <linux-pci+bounces-33527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A4B1D37C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD693B193F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947423BD13;
	Thu,  7 Aug 2025 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tFqz9YM1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486332AD32;
	Thu,  7 Aug 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552430; cv=fail; b=ncvzQbFKVuO0H339JdsuFG+mBXj1GtwRnRF4Ry9J4g+bWj13yKMW80ltgOB4YZJB+uiuX9mW3BKuIVKwSEIyqmbRqDzweJ33mR+qq/nRlS4E+5vVZLwzIxrzAY2wNB/sRwqkGxR0XVr5C/SXDUK5cFYo4cVLH2Eesr9ejOQMhRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552430; c=relaxed/simple;
	bh=LVvQ/m1RBpJiTV1UAu1eehjNrpU57fB1YDGM6uONXPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNf4JtpnXJC1zm7rzqFx8tGfrwv2oTDGhuNEsoZJTWG0isAnWTI54vxh6xzyjFhXo1trh9XVUHxBnMMaJPbooQIMytBIs//HmIwWruEGlVJMoW0SixT6n/eylvdCXVDNPh2wGgb0WcVEsCld0gmBUlJxURhqFxxA0/cxiK3uti0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tFqz9YM1; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4/ELAz31shIXEn1wi4cfUl0fc/HpOPG1jB3zDWAGjH69AK/jKdXxb5gZTjqYUtn+LNt4OSjd7DFGeTS5LOxjG5/idPkZ5dZRB/st0rmJ59+uPFwqG54kzn3xyY4ukyf9tAHMsVBUvNr5eM7aGxtFt1ENRJLxc9rXCMs0Jis1iFyHOTVpO21X7yGrHXs1dLn1rNdZ4G2w+FjcC81GJccHkaklPIQ5WqRjldGeFEvtZg4/aBGIHnkcnn45fNygbJhjKbneVfI/WJ9vDqMLP1UuJPwC4UTdi54Z+Kn3EJn3DwPAn//mQMRDNePsdIEx+fcHLKPymcw81/0rIrVCb/neA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvoRPbqhkqIQOpes+hR7/d5lg/zvD9zmNyU3zNj3D7w=;
 b=y92BeJKhm3hN7rhql4CHVGgPP26oFKWKuuLuxf+vbaz4gZ1KtF0BeUClWVKb913TW2+eUBxli/Lp5J9y4nx8Ejz3ukJ2gNCPvd4x47AmKfZA5dKADcIb8vaehPeQzhkO6D54fd01ak32LSBTjeiq58atdQjtqEEsQUMeXpz1oSwVy0BsA1vt42EcIzMQonWYyKbRpFhSZoe35kmvVkbh+VdVfptw9B2AUYhG9RFU0vShV9JhDWpt9nBDqUrBju0QmAP+ctBT0IV2AJxp0zXkYDjL68xFJWAx/bf+tOtaTfdRCCnugG6pXfqx7xBYtwDtaDL03oeWWDxAXbE7l9fLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvoRPbqhkqIQOpes+hR7/d5lg/zvD9zmNyU3zNj3D7w=;
 b=tFqz9YM1eOAo3japcUN23HFdG1+vO5z5H6SbHB3fHSpxy+MSxs/uDGmxmtrGg3MjI6CWJyBqHLkUR6GQ4gLl5+n3Y1S+H+QcbKSpjAcJdoIJTJV2JB0TnUKoOkUvMbGfc0ZIWRZvizzEjFok8uwWCjrs00vuIiG2Im9dSYjni+A=
Received: from BN8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:ac::35)
 by CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 7 Aug
 2025 07:40:26 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:ac:cafe::b1) by BN8PR07CA0022.outlook.office365.com
 (2603:10b6:408:ac::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Thu,
 7 Aug 2025 07:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Thu, 7 Aug 2025 07:40:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 02:40:25 -0500
Received: from xhdlc200217.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Aug 2025 02:40:22 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v7 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP PERST#
Date: Thu, 7 Aug 2025 13:10:17 +0530
Message-ID: <20250807074019.811672-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa45c63-4b52-4e9d-f0bd-08ddd585acbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmNdCYf1Ali4XrmERPbQIzG8qXI1uvvPoOkVX6TUuqTAgQiRBXjrO2inXY4S?=
 =?us-ascii?Q?F4H1rlRClUvn8f6S6VmRzOdWynJC1jA0qAv/E5EAIxNGgG+1gt+VaMTS/6tV?=
 =?us-ascii?Q?8PwM0/XjyjqfDHKMRC0/sEWiewXIaNS4V5Uii29C/1XXoRCRwWPgn2e5ac58?=
 =?us-ascii?Q?WQcWrrNFRK1CxTuXnVaJSvPRlaW/2wKcBWjIiEropGNODZfiq+h8f8pmev9b?=
 =?us-ascii?Q?JnzxAEQZBeICkb7HqewnL8RVUkhyNYaZQYKHWhCAdSGlHL/Wq5j/xbGTlkzX?=
 =?us-ascii?Q?P1jLSjEAxTuwQRMG5SO03VoAf/cMykzlIolnDQTHTdlwDopIZ6AE/yeZ179R?=
 =?us-ascii?Q?yIuMaxy+lQq4oT7lH/FVgRqLZXTIHXVudnUXtsnNuxRvo2L48J1HbKFhxt4M?=
 =?us-ascii?Q?ne61BTZhRgv9181lwIP3vYVFhxPKOt1ULM4AzJBy3jpW38zGwAgF85vLjZTg?=
 =?us-ascii?Q?bzeVOe28MFO+v6bUuUplIhgl7d/aXAKiAAHeX8o8o1mRbR+C5fVwTVF4gWym?=
 =?us-ascii?Q?hufryB7sjcUoGwlIz17Jky/NTQfkUKynio4mcGHQC7qI5LuSdLlymYRlEf/W?=
 =?us-ascii?Q?MC7JwbnA9kZZyGF5JC3gJzCkSRnhIaUbO7AmwOH5O1dP93CAOL43DeCQ/Cpm?=
 =?us-ascii?Q?s09fKOmDNwPPlL6jDV7myrIeaxkVVcKKda9g0yIhbknkNJqZPlZtNihRoMxp?=
 =?us-ascii?Q?yjYD+knIsNxnDwcRoI6Y4UrHV15tS+oqTbpD+xO2u5qm9PPqAxjxPgfQSJdt?=
 =?us-ascii?Q?XzfAoRkTJTi9/Zj9nUIKc1fri9tGoih4DyXcRGxVzuduOThSLr8Mh8Y7r7GF?=
 =?us-ascii?Q?J24ZNVqRnpkZxOiLK9+VVesBXDgqiUYKbyVZkDrYLB5iOJKZrFvfSTVhzWUz?=
 =?us-ascii?Q?rBeg8XNH6SKjCbszpgD4xcO1GmmJCeTM2IzrSwIuy8ETVpetg1j2MHtylV0Y?=
 =?us-ascii?Q?cCuRMwqZfi/y5qnKYB5phviYP2urXkMHQfl3M6FbaH8dAvRaRIrEsfdCzUuH?=
 =?us-ascii?Q?Qy64YJ8GTg+4MKIdetGHfXsbb54sxx5obyvpXhXe2RrJdddBCgyALXiEFuJ/?=
 =?us-ascii?Q?FbpJnoZfm85kqlLfzJ0i8AtsDqyfgzDKWNbcJedWyCq9qO479FVpHLTncpQ4?=
 =?us-ascii?Q?bZSX1gay/+GY3PHjM+sfwGdc2STOSD2DeSQPqZ8SVRnhoml0hiEaFKuryK0z?=
 =?us-ascii?Q?EOgiPLbDrXtR0jci8xV+3erSsCwd+OZnBrudSVA7ykB9mLmXySD36mv6zdtJ?=
 =?us-ascii?Q?XhWQZJ50sj1C7Sb62xoizgNgILfHs0YijO/cbO6iYEAQc0/G5X/F7wv9OH54?=
 =?us-ascii?Q?n3QrUVQzlzk7y82roki+OSWfl5dHtUnIwf+VrEXnMl7fzY6davgHIlnGDlf+?=
 =?us-ascii?Q?RJj36ZDxqY9RE5w5hFHlri7BzvmzhrnIdbN/VL2esQ4jXF0cNm+eM38U+NcU?=
 =?us-ascii?Q?KeOXhsSXBgn05x38VmsJlysfneRuOt29fTzSQ5WimlbNQafGQqGpbh6ZHCkL?=
 =?us-ascii?Q?DyN6x/vZWnDnZRiVzAhNDsfwbWdX/oiJvnTO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:40:26.1612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa45c63-4b52-4e9d-f0bd-08ddd585acbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627

Add example usage of reset-gpios for PCIe RP PERST#

Add support for PCIe Root Port PERST# signal handling

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe
    RP PERST#
  PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 ++++++++
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 52 ++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)


base-commit: 0bd0a41a5120f78685a132834865b0a631b9026a
-- 
2.43.0


