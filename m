Return-Path: <linux-pci+bounces-34287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75BEB2C254
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931CE19678AF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16390335BD8;
	Tue, 19 Aug 2025 11:55:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023099.outbound.protection.outlook.com [52.101.127.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4633314A5;
	Tue, 19 Aug 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604518; cv=fail; b=iE5ux9uT6fpSsH/qocjKIf/N1vUaHenU87EVdO5L4ykWMWnPFaHE+lqFJsadkzNeXo8sGIMIUzpMaq3jBH2u1h3Ly9/tLt/a2mbmir7G922fEdNv+X5W9vV5QL9JxEeYujwEeTrCE+KOsJO3MgcQm2SlMwoqm44PZbOvdk3ljyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604518; c=relaxed/simple;
	bh=IiyK2qPBjroDGUvcHhcfMkvwDVPsa1UErGvXJaKWi/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAtPSB01o7C48RkRf8H9Gl3HrBKZxNCOdXM6Usbla5SDwL6dKdy/bwITwj2YF0fTV6TXL9OOsVxQqmKg8Ae+QiyJliS/hVu7zr0PyVtY3D7LQ3ApiN8/y90RvWUs0WeAtA2i6NXV/L4ifuwnsHzeFN9smbU39G63t20lQoADqQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUYkZrHToPRmUs/p5xN+N7rJc4jdqt+fy51918gu5g7x33Gjs92wSQFHWwLg7MEyhkSANYwO/y7QhKjlx/Itee/LsXsSvX6nTPKBDf3zwmlmRSH3QOJFWG4B+8+A1+SmuNqbg+iDNpggrWOdLuVfIyyPuurwYu7I1RaeusyJfmuOEnj1LX3sw9AUsZdGKX67VfcNT6K5Do+Qcxz7vXSpTqp+6Ck+9wE5i3VQ9c+z5UQqSLEQo0w4aqvx8iOKNQ4VvT4eprLkYOFNZo+GGgqtfM/ATght2VvUrRgo0iuu8CnL8hHcmJPpfanBDI8uVk/i0apfxIgDi3psnYZrvty54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfXqobtBEQe971JM8SVUDDRFv74XbAGga+2dTjNSLfM=;
 b=JnXTMLyB2rsKrmGcTuGEtZhyiepIlznhJMCjz9u/5vTI69NbM45f81bPvDOvQVPgulMR3yCpPjZJrz30R/APo3QekujNDqxRDrjX8r964YqMCJVuMWBnLrUgfsdG0opzoh1RGChuluGdjzIk9z2tPKW44JPwJoFDXdZR6amxPKAm7Wt8eMQqDrTLrOVaujg3pvwStFmdcAg8+m5xmvZQenPvbCBbZdeWXvpXWRkJTbgYkB1Qkwr69crzJ7CIHPMMb2neWmieIGkEL3qiTENpcDMWB73kz3rGsUxuW1JXW11iuumTxa9d9eWYvPYkqVdulXmLt8+W6JcHkR7HpF1vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP301CA0034.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:380::14)
 by SEZPR06MB6207.apcprd06.prod.outlook.com (2603:1096:101:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:13 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:400:380:cafe::17) by TYCP301CA0034.outlook.office365.com
 (2603:1096:400:380::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Tue,
 19 Aug 2025 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:12 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0BBF54160509;
	Tue, 19 Aug 2025 19:55:10 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v8 13/15] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Date: Tue, 19 Aug 2025 19:52:37 +0800
Message-ID: <20250819115239.4170604-14-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|SEZPR06MB6207:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 63851c91-907a-4a89-c16d-08dddf174100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YbnkTVzwIuvNqQX5nEzk6X3jxvgl43ZoMTN94ccyVjSF22yTxd9sQRZqjd/H?=
 =?us-ascii?Q?2m7s3hFDT1m6fqzbxlOov3y+wDrK/7c1pbL5zaR53M2B/PZXmhT4mKZRL1TC?=
 =?us-ascii?Q?ijqs80Srs4NLZzHEh9eWFv3O6HAt3WS7oWPOH6CMsaxXNtVpuIHeTmch48D5?=
 =?us-ascii?Q?76++OLFR9NfeIklYLrXJX/NsZ2k7GXEqWJRwriVElWC5heAhTVdNY7Ft/su5?=
 =?us-ascii?Q?uBnhqCOuyTssvjbTA44xfJ9LL5fbzOpP5M51WYTM+jpq8U4V64NtnJa9u8j+?=
 =?us-ascii?Q?PLXUm8oP4B/eSAS9bYn4mYFOeB2Pmfm5SC1eXFbWDOyhMQJwiCrUuV7jFCcI?=
 =?us-ascii?Q?Q07pp8/y1AC3/HQRmvZQ4B7uAEUsXEhp6uA53s6BsY9bmfrb6CWBq18j8ipg?=
 =?us-ascii?Q?v8RJlaH3mFOFfL6c+m17eyP7u86d+VRFDba5ALUiMPeS/CI/U8bFp8B/2DGA?=
 =?us-ascii?Q?vyeTkb0wzx8N54QAVuj5ri1cx0DNF1DBzd0DVhWOftj0YoShHHeCP7+TGLdZ?=
 =?us-ascii?Q?10unitnn8eseWRntp5x6DmNDBMhTiBB9WoL5tJHFsRqy5LNgO23SLcaevhZ5?=
 =?us-ascii?Q?dlkGWvQhUjjgSiZuf2vB9AY3MEojhj0ejhcxRMkhCiiV6aYiUQQ7GBX2P+c0?=
 =?us-ascii?Q?q3H+tGfkZWDvGjxZbh3YAZdS7+aulSJzvNhwxnhd88BNbCOVxCRcV9hL3+81?=
 =?us-ascii?Q?k/ADrqZ1NpjK9HimPMCZDyBvBAc7QmkXgO7sKkEglxftS14uzAFwjfuT8Z6D?=
 =?us-ascii?Q?X5kh1u5UlyDJWRL+xpDZ6AzKzIrfrguB5Y0Qweg9NdnLNs+bejo6ckkfVkhS?=
 =?us-ascii?Q?ksOoEUDsfEv7R2Sd8nr3l1q6oShwehNNkdN9qqeJv3scazzcH56I+rutuJBl?=
 =?us-ascii?Q?KAb9ClxZKz8hFiNscQPcnHyzYZnUQEXplh7tENSR3jMd6y9TCqLvJHgrpsHT?=
 =?us-ascii?Q?f+Nw0OPpwEHJqqD+WBXOkbudvd263n3Q9+nM8l3ghja1QuxUzxUh+3NK4FkQ?=
 =?us-ascii?Q?RNiGoExyC07EWadVOsKnpG5btEXaol5Bb+GH2oeHODGvykJx3eQfeLyCaRym?=
 =?us-ascii?Q?YLqWOWyi89PUkVbCM4SI4ox/lWomb0GoZsRFuIi8gGr3Esucqd0kjfAP+WY6?=
 =?us-ascii?Q?JiCX5kdxelvhw2zBHAwIW9ld0DnSGqRMEJLmCzd/3djTX3E1rnyMgHozWlHR?=
 =?us-ascii?Q?/mw3dplTpfaLAMOVW6Q8SzbK0/bTyZopIvP8Q9XEwabvd+6j5MnAcHNXaga6?=
 =?us-ascii?Q?e85/qaXgCbaX1LUDh2pas3anUNMti2fmxgKTRin3Znk1B1NA/5PKb5SnQz6j?=
 =?us-ascii?Q?26jEWudOlu4TpHkV51XkU6M9vjBJxuwPqmgrynQ7G64chN5j+LbCwmcyRAQj?=
 =?us-ascii?Q?YlIyImAGJiQt9hILUNj2mD5y/f9aw1lo5KTBY6e5ORW47XF8vDkkLhwdYH8K?=
 =?us-ascii?Q?ylmERmVMwFfeL0sekGv0Xde06h8L1CtrGY20Lkj0y24k2rG5/89KYgjBNHI9?=
 =?us-ascii?Q?UzrQJaHIR8GpN3K1RQ2BPnVAUuFdsygtDZ8I?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:12.2035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63851c91-907a-4a89-c16d-08dddf174100
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6207

From: Hans Zhang <hans.zhang@cixtech.com>

Add myself as maintainer of Sky1 PCIe host driver

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..95c6acbbdda5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19251,6 +19251,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/*cadence*
 
+PCI DRIVER FOR CIX Sky1
+M:	Hans Zhang <hans.zhang@cixtech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
+F:	drivers/pci/controller/cadence/*sky1*
+
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
 M:	Mingkai Hu <mingkai.hu@nxp.com>
-- 
2.49.0


