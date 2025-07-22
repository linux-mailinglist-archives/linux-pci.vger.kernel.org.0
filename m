Return-Path: <linux-pci+bounces-32750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E15B0E309
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 19:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80561C85ACD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B83B29E;
	Tue, 22 Jul 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kCXRWmgV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064728002B;
	Tue, 22 Jul 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206674; cv=fail; b=UROUnvf5Wqf22f4Nso3iSpkiWs0JZRFykuRnVbSgi4jqOWxdWBxpvCyendaQ++I1TTO6zbf64Mla+b3D+mchKopJZxWlzSp+hV1uTqPKTU73EahlXxfA4rzgoP+pQDWbjL5CydhudAXjaL8w0JYRm7OMb3Zi0CmCh7XZ/u45XKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206674; c=relaxed/simple;
	bh=cAgJ+xeo01yVUEhp6LoJn/KflGIKN3K9Q24COJL9adA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+rbtlzZywUxmeshRpuRkP1EzaSTXqcimZpDtIAQB+84IzJhAbLSHTiE+PBYLwIeSwnsDIvHW0/68kGThFh0f12D6K91v/EP3Ihi6cHFGGuJDcBLtHZ9L5Zc9sxCgGy2yr+0mpJ2k6DD8Gg62S9wQacZrffWvew44+2zG0Q+Vpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kCXRWmgV; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MczYkBgM5fVCs7lCMRqPxLaSnpiQKTsziTBpJk8EQqaZGJyXtYkuZfElMh6DFLPGBVxyjsrAVucv888OEYaqQlY5TqdQEcnS3KCmwF4QcdUaz9CoWPuurvx7+Nd3x4gHPdfVMrSnGbtUJ5oxw1xAsW6S3jNzhXs16apq6U/qooiYtHlHcyLpzJNwUbkHDGKy6Sjq5o/Y4qoxghx6rLyn4HFBq5J7reB30PdRBfuOYw8zJQAlZgVaHF5m7z6T8wFd9Pzm+l2rlsi2mCKEb3rMnmnYDxpEsT71ssjlHhZrmrkRRvaiYq0m0JUHdXIoyuP9tcFKCc4YUBEK25fxOAAqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUO5USJoOjLM9JO9AIg/c6Kj2BFHYiXozeVJCeYWGsg=;
 b=o8yR9gXFjfDY5zhASKkIRM3Dm1IeVXm4cWJokmSe+keE8pv+HqpgarOgNG8Yj9JrTzA4ivPh7281n7az1WUTfTgy87rn2qbYHAmftrf7LJa9IGx22NWSCadJ0IzoS1GhZD5SrrQVFB/bsZatcQz8XLuI7ZpJP3j2q66asx5fdknNA5hnlwbKoyfzHI3/jYASFOCw1xjqtUoG1l6DyZOiH94ES9q2TzCj/8mdm7M497CMEu36LcoBySaLKUXN/OFL1ybslCwJyBsEOpevlM8Ch0JFMptIQv6jvoYizVXRdMD1KMvbxxlITgLSbFuLQb1wmrm40wOlesMRBnCKPitLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUO5USJoOjLM9JO9AIg/c6Kj2BFHYiXozeVJCeYWGsg=;
 b=kCXRWmgVCQt1/OKpxGiyxyxSojGayuHe9NcOZEHzqsdhk9Lhkozbm1lVCooyBv5t6jLQq4aeEBIWUQ0y8KAArNQiBZdseTltMsldPkQRQ0GO3IiGhl/lOKf2MYK9ZF0qm6ZRK2yJxMwSXYwj88JrH5hPUKMIqEB474aU9rqPDmU=
Received: from BN8PR15CA0056.namprd15.prod.outlook.com (2603:10b6:408:80::33)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 22 Jul
 2025 17:51:06 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:80:cafe::7f) by BN8PR15CA0056.outlook.office365.com
 (2603:10b6:408:80::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.30 via Frontend Transport; Tue,
 22 Jul 2025 17:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 17:51:06 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:51:03 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
	<westeri@kernel.org>, <YehezkelShB@gmail.com>, <bhelgaas@google.com>,
	<Sanath.S@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH 3/3] thunderbolt: Add vendor ASMedia in update_property_block for XDomain
Date: Tue, 22 Jul 2025 23:20:26 +0530
Message-ID: <20250722175026.1994846-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: d21f0f9a-d358-47ae-e01b-08ddc9485593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBgSeNFKzejqFiGNCams56OSh7Vxx5E5gllg2zcg5aQQP1ueI8yIQVgGm2ne?=
 =?us-ascii?Q?1PWT2Xqsu1kNq3urZUSVtkPqUrsj1lkRT5KrCc9K9upaHxV8V4+c3sPTxmej?=
 =?us-ascii?Q?JUt8rAWxpniwTJXHqLljHvAwwefJtT2OtAv7mmqLucmT/tXfmwjfyQ6NXpcb?=
 =?us-ascii?Q?wA0hRqk3o46cxeWMpzx365CCMJ2cpH9TIPdjdXmlCNAKzvDsaf2OGnUBKlfD?=
 =?us-ascii?Q?Do8Vd55MrifYRgfjDPHRZxzkynlkY9jNBlftlr3Xr70vhOgs2jIAU65GieJT?=
 =?us-ascii?Q?unU99LeHH6rVldJJQuLdho2fx0a31nHReXjhO3/GG+w9POJ65F3It8YrEscm?=
 =?us-ascii?Q?nPBta5mju/pOGxf473YZv658iXdun6hC4SsQikHV4emTHyzFgswOQGXi1hYn?=
 =?us-ascii?Q?+BsJcXdCh3tjz9HvijQ6wVKc1Mn/KCdVXQOUUwxovhGX5SiZjkYu95Gf63Bg?=
 =?us-ascii?Q?6aA/phm6ZJZJGXBZORJ6K1kyJQo+rCUeXasyCUAnAtpGoCY+WX9h7/eespzk?=
 =?us-ascii?Q?gBJLgOOXVHoWjZT4FiIDcuoJzfjScB8NlQng7uk7bJz4GrawQTVhueQOdnPc?=
 =?us-ascii?Q?Q7651m47jk0j5nVGKxh/FWhd7J3t66AioYBmh+X8dmvLpByueWovpqHINOpv?=
 =?us-ascii?Q?NSjw2HG1Is6xyOeHXN5yUFu7a2RGJL1MmLty58NiW6jZF/DLIN5Vfzw5UHMG?=
 =?us-ascii?Q?ilOVqEb51L6Gn3GJP7GhPwfbeRSqtUj+rPfBU7w0edhv4S+4JzIsfRckGWB9?=
 =?us-ascii?Q?rhgm1QxrgSwA0mzAawOJHMAkxPgm0kRsBQXjF68uCO+/AvOfs3clu3VR6usL?=
 =?us-ascii?Q?hWOyHY1D5dTKHhqaLI3xsWMwCrz84PuTzn8TTsbupxcc4vyIE6PT7u9P5SWo?=
 =?us-ascii?Q?97GE04/Va6E3gpb7E6+NSKy24oucdNe4ftI9zvDUQc81QVyYk5zcvAGf6kBM?=
 =?us-ascii?Q?3UjM7Mfnz5YCs68dQZeLOh0ILY4Eo+X4xSuhh1MQPnFUu/H7XFGA+Ff6KNQd?=
 =?us-ascii?Q?rY6FRp6Y/6y9olvX9xuHzOD1yOy/zddZ8MmN4F2/7KNLL8yW3XdYME8HBiIg?=
 =?us-ascii?Q?5O1sQ00Og8aqBXxX2pPCEIuhMDVnDyrfP2L1XzC+TZnB+C5LXA4hPwokW5X6?=
 =?us-ascii?Q?eqyqmcli2sEuGzdaE4o+Krg3cjgFRHd7CAJufeR5ibGBe4duxkNrRfpHhPA2?=
 =?us-ascii?Q?udo5ZtGBCYYj6n85nhq85QIiD1OPcmVIZ/mXk5/i5la5TAlSIOdJaBZp38Z9?=
 =?us-ascii?Q?lYOU+IZovpBI79E16TySLgu/nJMxf7tH+52tFzw9oh1N2LrIYz9N/1GvmLBW?=
 =?us-ascii?Q?r6CUnU3HG/AmvB3G85HUu6MY9bD9/De/WNd7qrZuLfY0DbpsZXv0TrXxdXOQ?=
 =?us-ascii?Q?YAcm/WofrA+DEbL+SA506wjakGZkqbkdLe2n4J3prMEMk0MS6mEyxH28nK8i?=
 =?us-ascii?Q?znk9/m1Rn//y+jOiK7SdV4yki6bEk4YdohAPTHCZYW+1Jy62qnSBse9086Tj?=
 =?us-ascii?Q?M/ZR6Ybkn0emvrFeKqn9iJpyv0qIeR82Lp5C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:51:06.6639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21f0f9a-d358-47ae-e01b-08ddc9485593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488

Replace vendor ID 0x174c with PCI_VENDOR_ID_ASMEDIA_USB4 for
better maintainability. Add vendor name ASMedia for XDomain
properties.

Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/thunderbolt/nvm.c     | 2 +-
 drivers/thunderbolt/xdomain.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 8901db2de327..b6ccd8ea16a4 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -191,7 +191,7 @@ static const struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
 
 /* Router vendor NVM support table */
 static const struct tb_nvm_vendor switch_nvm_vendors[] = {
-	{ 0x174c, &asmedia_switch_nvm_ops },
+	{ PCI_VENDOR_ID_ASMEDIA_USB4, &asmedia_switch_nvm_ops },
 	{ PCI_VENDOR_ID_INTEL, &intel_switch_nvm_ops },
 	{ 0x8087, &intel_switch_nvm_ops },
 };
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 749faa7c487f..f512aacb5f60 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -674,6 +674,9 @@ static void update_property_block(struct tb_xdomain *xd)
 		case PCI_VENDOR_ID_AMD:
 			tb_property_add_text(dir, "vendorid", "AMD");
 			break;
+		case PCI_VENDOR_ID_ASMEDIA_USB4:
+			tb_property_add_text(dir, "vendorid", "ASMedia");
+			break;
 		default:
 			tb_property_add_text(dir, "vendorid", "Unknown Vendor");
 			break;
-- 
2.34.1


