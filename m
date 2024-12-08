Return-Path: <linux-pci+bounces-17884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75EA9E838A
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 05:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D191658C3
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC7381AF;
	Sun,  8 Dec 2024 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fpKxK//O"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16F20B22;
	Sun,  8 Dec 2024 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733632797; cv=fail; b=l2WKWrRH/L3IIV73rYrc7LnNCxwPEXuaMsioAfYMJHokW6tH1q6zfPfi/r+5tZecYlZ34p6Dsi3KfNN3LEMQsRBLsm5DPRcybXRGbxgR4++M3EKRIXv7tOSYpJ3E3cWasiHQ7ftYoLBObCyROGEVBr5Y01uekXYwZAonoObp4VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733632797; c=relaxed/simple;
	bh=V061oBFHHdLp7jlGcAQ1o8Z5TQhPnPInVfL7fYSs3LE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o5AjEMGZitMCjxq/YOCqOUaH7EfKA1eGrDaaVwXr57id4sVr0VGPXOkEBemadRbnx7n1zhnXFbfXHHqrHhYqBoSDYG/SH5y64Qi2RyGEAjTk1RX1B4xXXYfUSn/Ae+Kl7R9yjkSYcX13nLLQxyLrqOi5TZ8u+SYzpqaSOUaXpK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fpKxK//O; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAiIqCRL+1XNzxpiGbf18aDZJrG5G0LdEFzkqzzXYtLi07WJc32qKVYGoVXOYGQW9uozsaLQAqPkIpN/qbdJxj+m8605N6L1zPkTIxmhnUf2EAlF6Ruxa1KQw2M9At1V9kZeAdKW2Pi+VoPEhz1xh3yD1TjGr9i6cG1qEYUvlKIaubastB9MA6z864OBHiq+xElZ8V7MHifQN2rhdOQqeifwCLtEoGyW+YtmQcSAz1BsVd6JakmFF9hd/xRRLXXfnEXiTk3JgTzXOrsJeeAYs1TIMo/izKDLCJGQpz5TJhLYbLhdXoGlRnuyzkIMJYhwdDfDgwNqXD0hA2W+QpgGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=grZ2gMN61feRyeRJAqOQbbHYK1XjpD8gon/L1pykPFEatq/8mDct/kWqu0BA1fkEbq6lPwquDTZK3vlPAqe0RBkYxaBeFRj/tua6J33H3SgIljm11hwpOVZuwAIGVzmM/wR1zBE5EK+9zX6tAJ+nW4G+KS8rg3ireRCwzr6SEfJgu32P0Y9UJbrdW3XaX9ZaUHJIdZd2EkvwS5AWyNj55hawGPp9LG7EVT6/Fbg2IeylIDCjo3LLPbsyNFyUoNke04KEmjoGXMGUFo8iYefFBMQy7BCK3V0evA2wMc2fg9KbfE0brwWYh9lbaiHE0Zzzt0QLiekkqEJ+Nm1BcRtLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m02f2/2AsUPomL2Kqnwz2/k6uTiueWOZI8zM+/ReIA=;
 b=fpKxK//OPf+KMp3jplWo1oms2NYqfGklDOn+Q5kIpQHdm2LCx7Tw7ARWUJFhCMqFo4MGfs9D4Y7mYnvIBuaT0YOrgGr9Gi/NsM0Hsaphi1sJaAKIP4++MJ4J1tZgcPrqfluFfwxVmKU//uxDecj6pKsm7hvQb7fBcjokcxyn18c=
Received: from BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38) by
 SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 04:39:51 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::61) by BYAPR01CA0061.outlook.office365.com
 (2603:10b6:a03:94::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Sun,
 8 Dec 2024 04:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sun, 8 Dec 2024 04:39:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 22:39:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Dec
 2024 22:39:34 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sat, 7 Dec 2024 22:39:31 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v5 0/3] Add support for AMD MDB IP as Root Port
Date: Sun, 8 Dec 2024 10:09:25 +0530
Message-ID: <20241208043928.3287585-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7265f4-6d8f-4da3-bc72-08dd17425a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uho8vGophtH2eBVwiOMHSo1xwWJUW46gc08tTb9sH8FEqcBqc1CfxOZQIFoN?=
 =?us-ascii?Q?JqCOn0Kl5EnruWm4Ni3BlRZ1INsxCn6oXIprPAujg2n8s5FuRsSp3IRkFRAT?=
 =?us-ascii?Q?SLCs7IaC5HPP0tKY5LtSPtueBeOVnwIHYqpja4p4bQ4bagf6pCTCrI2gla4u?=
 =?us-ascii?Q?eijSKP0HqewabWTFamgbAy1MqpuGvpUm6CbGSC8nYDmQFVSX6RnQhwiw6SC5?=
 =?us-ascii?Q?VHwyZf2FDD/qqWROlocAORQIbMJZo9z8agOyI+4WzALnIUeGj13vkhpAjorR?=
 =?us-ascii?Q?Q8UvB8AYVnKNLf1rvr/onvdlSjBOfSxd2BCW7D52wOJl77Lmvu8g5rzGIVJU?=
 =?us-ascii?Q?wh0VEsTJfHo6p8fs7eKJG+LvOqagoSJf5vvWJ4dPpZ5hLPgvGMRSgqHStQC3?=
 =?us-ascii?Q?XG9++lO/qmGs301CmNjbYFYhUh8MgesZPZtNyEyWb23ngIxlJgVobquJsygK?=
 =?us-ascii?Q?0vqP7hpN6kBT6LCcd6G5sAvY75FopezBFIpq2UPy/kuDCRIXvZW0or1jgTDL?=
 =?us-ascii?Q?VGJ1oa/afHIRbIkuB0NPsLoph/MSVh+YBuC8lFQWzEgxd6MRgoeiDoG9uZHU?=
 =?us-ascii?Q?AknibmBSCU0DjnU2/rH4zkL7MjrMNqigyVYuxYjdlGFvgv56UFnj1sDpQ/CO?=
 =?us-ascii?Q?1VtP7yD4A0mWPF6ySFmfc1MCVCa9pIYClJ3pgACYB+AQ5RuQVds90HgLX5x7?=
 =?us-ascii?Q?BFcwwoOuQ3SSrwZE8auEcQuPle1DAnk8mRjQZKhzRe5vI6jHgS+U8evYJQzP?=
 =?us-ascii?Q?RC63FIyxtKqefd+Cha8+Jqs1tiRuaC9AxQ4XL4+nZppD4XZYBnYu8jxsiDp9?=
 =?us-ascii?Q?iJK18sZzgSRzxrxcbvrCrQFjsrNuoP/XXEtKgZM2sFRXArKS2OzcdQVbDcxn?=
 =?us-ascii?Q?szeWI6DOne3vv1IuOpL+3KvNyckfXTH0jJxomWLymvWdHqdrpPAo2iXaQl3/?=
 =?us-ascii?Q?LxnROdaNICS0EeTtRRIBqNTTpRaRlJrlkTRSAn57KOfSy8SBVkvsaj8LdmzY?=
 =?us-ascii?Q?6VnH2BjKlyZ2I+gXflJZJcuU9Tz5KhGR2FHYZTpYMlmezPsGjZrEyslxrImi?=
 =?us-ascii?Q?/tSrQbTi+GHcsOp4z92LKkLPZSQC1m2EtyklEOtHfxs2AALJdtSUSVQj/oxg?=
 =?us-ascii?Q?oggI0tSqT9LgVZJaumeCoB56fTI+fKCgowV8H7kmwDgT6esoKyCzwq4o+f24?=
 =?us-ascii?Q?Ee/N5ey91Md1yZnlH2PuDGtL414sS+G+90Y/VL2lDYJRrhGrksgCLVeiYbEa?=
 =?us-ascii?Q?Two99w/4nfhbTrLdBJ+D+vmkcWa6C6vp1BGzIj1UR4FW5Sb3b7Z3rynBemJp?=
 =?us-ascii?Q?FoGgjAMoJgIshW3UuDG69eKLTkEMp68xJrjAzUILRNd4p8SSdixrYEC0B0LY?=
 =?us-ascii?Q?emKRpxFA+r1BB/CfR102QVlOPLPhij6RHggdfWNDnxxNXr6brWDIGQCjleDz?=
 =?us-ascii?Q?qg5W5ep0lHrUnyGROqGgvUVBEgr98bs3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 04:39:51.1239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7265f4-6d8f-4da3-bc72-08dd17425a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (3):
  dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 +++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 439 ++++++++++++++++++
 5 files changed, 573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
2.34.1


