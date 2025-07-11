Return-Path: <linux-pci+bounces-31904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60961B012A4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 07:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8BB588270
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 05:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97A1ACEDE;
	Fri, 11 Jul 2025 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SLbZ4Jrb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E4190477;
	Fri, 11 Jul 2025 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211453; cv=fail; b=RGzhdMluMVE1wTu1ddZj1Lhr2ZJ+UGDHZvBupGR/J53RTz/GPzs14MJTNbxRfSJk3TXEDfuW+RXtyboBckoIu7SGCiIGljKHJumiTU/pJJPrEyDwvoi2aI1JZJf04p7hKsmBhqJtfM48hlcsvEqko50hCWGfh4spYaKk1PAxfCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211453; c=relaxed/simple;
	bh=p9CsUqlG0L2bdGZZUyyI/TBFJi5DEuUwK0dTDLZjMmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=enqTVMtjbyOJhXsbxZf2EtqhmVlMurX0sf4NG8IyqhHgqAvjADQPXh1Qf3WnZIKhFe0xXoeKVrS7lyXe6RCGYZ6j6kXVg3ItBmFZ6jADfCdnLCyQSeRDXOo+s1tWSmG9DbnPvh724S+/SwjinS+140EbYBTQ2K7GiUSPnaAhwW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SLbZ4Jrb; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgIwCj3+9DfqGmO1gn7tW/6JiFePdFMdKi6mupmsMoR89H5zyA107+hVVuTEHsin6jVQADhW9S77+STQXqcMLPByTiStyx5Tjc2EAPJ+7BzSOFTNOLDe3KMTWQ42GEZXEqyq/RI62wV5ZBWabmLmm+uVrenHhcoWZt2XQwF0wJfPhg5dWOUMYPvAo6mQt1LP4fwMmA1cXrO5i8FZ6WOT6JTUIKoYxa34z6Sp1JFOaj87MGwhXqorxdO8yfW/C//FD1Jbt19S4IRa32xPZ3uavbO81Rzajk8pU1Ky0jOBhtIzIyJU7eoImoR47N16kATelePOpIJ6YiQQ2wGPZKVXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPlDeVz1Llppxp4OCIJ7DX4nx3Weqyf0yNgDMfWqAe4=;
 b=V1AzLUHF44/axbdp7Z8sAuR2EHj9xNUQrxbpKVDRDfrULBwyzZSnLcQiM9TZ0hn/cGiV4QWnj7VdPH6K4OeDzGJG5nOUmFckkxrKRzOo++N3nLxsIGjG9y6q0kSbqCcQrBO+cWmO65pGCONowYEyfOrZHjh+BjTcQXI/IIks5gnq6YFyjjSQzkWOn306lZYGbAyRCmVEcwcmZV8THGffl6C+NVcbmcGAJ17uXOmKb5iQbonSUNqSw3qRREbHES93J5U95si3NFZEKFA8+Y66BXREnRjf1KzagQrGxFtkYE+QDQW43TIMgzzygTs9v9VgpvJ2N/mbssUpW/g2PxUlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPlDeVz1Llppxp4OCIJ7DX4nx3Weqyf0yNgDMfWqAe4=;
 b=SLbZ4Jrb1fWrEAx3sQ79rMfniigy7udIyFQDtMfQuCB2zTlqkL958KV9QrVugyw62ceDsth1cjLDZMjNlblHMIGmOHb1r41jbkP3iwgQmiL9Y4Yz0lpTgOuaKzhXG7kf60ZQ41RQL61j0mah0XE/5OAKF2cj+zQ2js/XNqvpqUo=
Received: from BN9PR03CA0609.namprd03.prod.outlook.com (2603:10b6:408:106::14)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 05:24:08 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:106:cafe::91) by BN9PR03CA0609.outlook.office365.com
 (2603:10b6:408:106::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 05:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.1 via Frontend Transport; Fri, 11 Jul 2025 05:24:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 00:24:07 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 11 Jul 2025 00:24:04 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v5 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP PERST#
Date: Fri, 11 Jul 2025 10:53:55 +0530
Message-ID: <20250711052357.3859719-1-sai.krishna.musham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 87aba79d-0b49-4874-f018-08ddc03b298b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUNmamEIERVCElW11smkXWGGGPO8QLJx4cVC4aU0mSPHo5qQm4oQiuIviMOK?=
 =?us-ascii?Q?fjilS8z0Nkvh+ddJBBT04c9bWAGbcTIdwyU4n8kjVB3zF3CAtnKhiwwzGtRi?=
 =?us-ascii?Q?MMlqGHAhpWV8ardDD2X17eZgR9bWOeIw8eTSQB0o5P2sRlrFt1O/ErYwFCQ2?=
 =?us-ascii?Q?bx3amQ5pmtjIVKUcJDITfJZdT00/et5DMGeKk4MO4ltuz9CvoYNnwgBSNIDj?=
 =?us-ascii?Q?sj9g1mymgdU42iV77mq2Nrk/WKc3wud6IWFcynwdT+Rav2wCkj3eYTMAY0j0?=
 =?us-ascii?Q?LXb4kyBB5SpMeIIBnP3vPN9xNkZiazBhUEQSG1ApM/QUgLwvXFaNXLLbwkb3?=
 =?us-ascii?Q?RnIzKVDj43s+Q64DnXfvvEGtis+sl1cCs4kv9JvuzQ39/cmVL00wRPuOU2aD?=
 =?us-ascii?Q?dbw6OiVgflTBKOgHAwaOhZOiS4eba9zEg1Z4Dy7GqyTtEcm7XwyqKuH5Te4Y?=
 =?us-ascii?Q?Aj7o3A1H5Zuqy/DeqbGzCQ9+jY4br0zwCMSHSWLF9mRTq3iaRuuY4eYHJZPv?=
 =?us-ascii?Q?Nr6vob37y/xllduR9lqFVqSUMWjEc86u8piYIOBf6wy06YYFkUpHfNKSpeju?=
 =?us-ascii?Q?tSWmMpOYZNyMvNJXm6VCqy7Hj1fSR+o9CfzV2CnIkm9AZ9uR4rFSxih3d1pw?=
 =?us-ascii?Q?bYN7jfiIGhWT3pU9+SxQFIM6ASgJZPo1UrLNYumFlRnMs/XVD5DEP1Nrnp6+?=
 =?us-ascii?Q?Krq/uRLNaCJG6WWq0kVPRhDeE1tUkDJ5x5804r3h7plkXzWkELcgUNI+C6w+?=
 =?us-ascii?Q?/uQxh/YXur5NKXLCptZpOCPqqQ4MYMpCdm1sVCbfz4WgKeLtaxq5ukKqykIs?=
 =?us-ascii?Q?6emoUTBdqSuOQgdejk1s6bE6+J6nVN/neO9SCp5wRk/5ai0pTbJCVfYfbNL4?=
 =?us-ascii?Q?/bDGeOXU6/7xdXhSKY9RHl3zadNzhnbqDNs0G5Dthp/owJTS7V4iKSz+Xx1V?=
 =?us-ascii?Q?zRFCW+TRHDMIbylkuHKdMMgniUL3/v7A5+PZJb2jzbKxSFs2TOYDpTwzM5ho?=
 =?us-ascii?Q?HnzjVtBJnbfaYDDT8p+pvYxp/+8NPM56ajv6YK8ZCwN+CmCBfVxnouD0jaEf?=
 =?us-ascii?Q?emb40lwYatJNBvYfimLbGOZk3L34D9gACEWWc9iHTpWAU8RqZD6elaOqaNLC?=
 =?us-ascii?Q?fDY/1+ODMF7Sa4fszDNNNTcotyoziRBu7Z82zaEd4hOKRePDaiyg4Av3DM/H?=
 =?us-ascii?Q?WgBC62yz1t2KWJRasrt96BcnzWPveF/8zvq6f2oEeaCuoK5qfsrau4cFWY+z?=
 =?us-ascii?Q?8+LKvMcQd8kRP956Wr+1EYhqA0iD/C+3e9HEBv7xqG5RRhz0OHR2RIP96xKh?=
 =?us-ascii?Q?EmibRH8omFqnbtmWw0+bx0btVyLOdusO2pInCUv6NaCO8BfMLNVYu9ash0Vl?=
 =?us-ascii?Q?TEsJs97kHjXjTOuSfkyvuO2zn0HSoQVkjHbU6Qvu97qoX+7zn99inLSDlCFN?=
 =?us-ascii?Q?MwXPQ4yXiVKXjBkDyCbXZ3QjloqvMe6aW8mmf9EDFaKly8C4MqvL+Rkwky6a?=
 =?us-ascii?Q?RItnZM4DfXuBprEaIrllFrYdFBYUaji4XVo1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 05:24:08.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87aba79d-0b49-4874-f018-08ddc03b298b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784

Add example usage of reset-gpios for PCIe RP PERST#

Add support for PCIe Root Port PERST# signal handling

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe
    RP PERST#
  PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 63 ++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.44.1


