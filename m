Return-Path: <linux-pci+bounces-30017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3350ADE537
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF7D189A67B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA332475E8;
	Wed, 18 Jun 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oaTkkggP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42FE8635D;
	Wed, 18 Jun 2025 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234183; cv=fail; b=pE81/nvDqqWw5swoZigHe7QgW62OuVBTzA1s01w42TlvF/qOB7cEfgylMZHcgGoUsGCTbYXDzIQRq8gor92XH5v08yhU1A5CqGimaSds5WN6FagxpEsZFMhtSEtbTBjXXfYsfgcjC5DfU9RD42rhG5Wv3FEYo3r4qvMGWvswWsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234183; c=relaxed/simple;
	bh=SW6dSSWkr317uYEFMQlacj1rdkK84mwiVQ/FLBWrJPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sbODIQ0SJYA5TkrMGiONVGG1i6YYI0qKuY+VawximLFiCLf4m7Mm6AEaOuGyjlLrRLo/Lr1UThZzVpj4MtSFeagu0SevhAIhJjvt/i3UOveG0B7qIXQbdMzR19YS4bUc8jYWgO/HIdG6vgVM4rhG6GlDDXx3GGCBuNt9pZvPB60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oaTkkggP; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgzzAHuthoN36g4hArttZtKhwKhJZXDsi7DY0hepCLR76odoLJLKt7bbVTe/k24z5h6P7FD7PMJwo6NL4qTfp0SxE74zTsFvDFSlxMRu2EgXpRnLObRJmu7EtExk/QrCCqiPzqnfRTSZz8T7Di/xplmWIOJp/Ah0mlV5n7viu55hwp8B+SKxcjuG5m8QQJGM02y1lz1l7XIF9/tSQkXGtVmtoYTAg8wKKt/d668+emSzFb8dE1k3R86NzbdMy+CjgqqjK5bza77qBqETO0a4mPPfxWt3JQ7i1UA2aoi8OP8iTlkeVtTbae2IYXlLJVAwY+pZGQbSVu8w92kiA7tqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL+212zrru5RUqVZnlMUVEbIp0GGA/DKS75nDb5eszs=;
 b=M1GCL/CKJE7O/oWGPFdS85sLwaOz9q7WWYxwM5lk4nsQWD55hvptOngqj/KhY4yeAnZie6TrFywKV3mDZ8lsIdXWRfX+lEJ+HzYPjZZOILO6+pR81lAvzPk2y2B9o1mshRPgFG2rvogFJ8TrESKyyBu5+kuPJNK52yNwvy1FN6jjwsi1p0GRhXB7KJMe4c51o+/+bgsKwm9mWHZuwno0+NSj1in5YI85EmD1hgSaNUIIAECFeWOdNaK0FzE6oyLWRwvcVcYlv869kIwnVBt1KJIBxhjIOa52Z+wGmAmfJ17NRBaBCaByqb3XNevMfRZlNROsph2B+JHJ6iZUBXnU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL+212zrru5RUqVZnlMUVEbIp0GGA/DKS75nDb5eszs=;
 b=oaTkkggPSfd7T0pjBmQc3IIFeBkMD43u4N51ra3NXv7R84Gty0R0uy83H7KWCNPNzzOHC6u5/6IdJvpPmpD+YoQLe6xfF5EgtM+3Z8DUFF444hdxopopDsrXruLyjIiCspAN3n2KjFGxHYjswOO/ItG/yxsb7HXP3eJmdJ0svlM=
Received: from MN2PR22CA0010.namprd22.prod.outlook.com (2603:10b6:208:238::15)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 08:09:38 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::bd) by MN2PR22CA0010.outlook.office365.com
 (2603:10b6:208:238::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Wed,
 18 Jun 2025 08:09:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 08:09:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 03:09:36 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 03:09:33 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v3 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP PERST#
Date: Wed, 18 Jun 2025 13:39:29 +0530
Message-ID: <20250618080931.2472366-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d66620-5e0e-4c2e-4577-08ddae3f785f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dFrqCjgAb5dGnPQDAjSpzzY9oQtr2RJLqU3E9cbhdV/74kCOjpw9PSCnGE0U?=
 =?us-ascii?Q?h5jK7xxkS1AhbuDKYBdcbQ9Ay6ofOFX+f2Lv5ImKT395Z9gb8QNG1s3a2wbr?=
 =?us-ascii?Q?MeRQ7HfDD79aOy7Juky+eXoYYMNkE1rmc6HAlug+1FU5i7YohSS2BEc24jgk?=
 =?us-ascii?Q?hOWZuUyI8lrBUzkz0nzWZFJNA6WXQ9fd4AeCWISb9WsfEDUIQD/SIuNvHTVq?=
 =?us-ascii?Q?4baVHR4skvk3+uOELGUu6YR5Gg15XCMPM02rG1qOpahunnJq/A5NwtRdy6fT?=
 =?us-ascii?Q?49LYiilwckkJXV072OQO00G6Z0+s2K2nq4+BDJGXT9Q8mHF93UzCDeFankK7?=
 =?us-ascii?Q?wfcz1eTk2qrjOB94UmmjCe58XeC15qOecxurOmUI+YyyiY1/ERGP9Sw+ebrE?=
 =?us-ascii?Q?NJhtaghBF5Q5ut+Z5BluZRE9/7KsSh+ADL0IIHb/fTcdEgIOzTkVYxvqoxX+?=
 =?us-ascii?Q?8f7Zdkj5msoXwyuZAk/+weqj1vQLTUV5D6c/B1Pg/pTrzdVrHg5ICTSJHo5Z?=
 =?us-ascii?Q?hdgm+bbK8M9JFHwO7Q3Ws967+CEYMAgvhSJKFSwr47acG4rd9012h+6NUbzk?=
 =?us-ascii?Q?kewEDN3OOZM4sW8n8SWKRze0cAWIcboVQuRDPpXM4VZ2KvyHgyYUsphPz+EU?=
 =?us-ascii?Q?Kvtbs6jFhdXt50vKVUA5j1ZBxR0xHfCmMudbR8ZnzpXQVgGkLdanxoESbFAp?=
 =?us-ascii?Q?dlzpup7k0J67kDpVtBnNWMqeYgeOWz7DkYdbAp0mgI11sD+KXXBfgxRY9+Eo?=
 =?us-ascii?Q?kGbEgtl41P7fqcolNbMyk4/JpNDSJke+MzWZs9qbyA0MPBBK7h+g5qPmfoWr?=
 =?us-ascii?Q?8YDyZw84BdMjuUOGEjG9gk5wZHEBj3cPqkNapI5777y2RaJD7tdMmpGIwZU9?=
 =?us-ascii?Q?QGoR3g571nv9Qqi5UjQxNLxNRL4ID9y3MD6dD8oJW0cTPYyEC8pXKpBz/Cov?=
 =?us-ascii?Q?1L+b3iDd9CMX8EzSw1gTLfT0uBM3UdW03b8j7lRLq7LEQ/jpoSyEu0vVasPL?=
 =?us-ascii?Q?f1YAIYUdCPPR0YCjsIVTjbRpjnNO6AnFhoS8ywJvS0SDbxx4NhaMW/cKbH4B?=
 =?us-ascii?Q?U6BxCkrEZdIJRWqq8lIBNYjkh1a0drjBLtf5No7kWuZ7QW/PtWi1uRsskrww?=
 =?us-ascii?Q?ltex8XA62uYu1FLzwYciGuXo8oyR0O+ZoatMf3jxUkR1DsAlQ5MvZ7kxUf5E?=
 =?us-ascii?Q?TOl/6koCgWqVcmCfDjhkPQ0G9LR0B31Zot/K6RKmMLwhDng+309XIqlVfWkx?=
 =?us-ascii?Q?44o/2EpDrdSkBY/L7ci0sxz9H8IxN8bYk6qKoa9N+XwoPNX/IeAdpkzVeT4w?=
 =?us-ascii?Q?mn5HpP4bI3jgAqwlYtCcdaqVH5TESS6eelV/OUacF9jwmHa+xAblgLyBNnwJ?=
 =?us-ascii?Q?UNX9nTmkXh9vC2Umn9lJyAuO4kk8eAlG7aTwSGgRXfWF2NxVf0Nd24PKVF6S?=
 =?us-ascii?Q?+yghp5DH+uTOcBfu/yqXNmjIoFbDWhFeEHzR+d8XCky8vAMSlLrt2PCyflJd?=
 =?us-ascii?Q?e4kuYs1ze3+PzGmFdxwfTEjA6Qy8YtLAqaVg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 08:09:38.1729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d66620-5e0e-4c2e-4577-08ddae3f785f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843

Add reset-gpios property to PCI bridge node

Add support for PCIe Root Port PERST# signal handling

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add reset-gpios property for PCIe RP PERST#
    handling
  PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 26 +++++++++++
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 45 ++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.43.0


