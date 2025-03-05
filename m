Return-Path: <linux-pci+bounces-22945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CABA4F720
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9300E16CF5A
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F2A15854A;
	Wed,  5 Mar 2025 06:30:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023109.outbound.protection.outlook.com [40.107.44.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72614658D;
	Wed,  5 Mar 2025 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156236; cv=fail; b=N8V24kxCesCuPK7+JgpYhMZmfhDkQxXIsW47YFG9bzvaNFpgR6YXB3vA9jpKAxf/1ha8j7B4lilLUbXiWaN+6Foi1o2TZD7M8VXH56xMoAAFaH5EHn+tViI9URR3mo/6d5VJlxX44E0O8iOTQ2OfkjrCs4dtAfCKY1369JrY5Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156236; c=relaxed/simple;
	bh=Yxr1wWDPMTtx7+YalUWp53rMOFzrdSrwNres+oayYnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fIirKC2xluu4pGrI+x1SaZxOZOI54FkQdxC+GqlpSc88O+ozkIF14SRf+j0UyRKcRtfvr3M0+Q/ER1GjNEVSP7tUo4ImTpXJbUiLaZB0iLm+soOsJiyhRfR2UZrPJMpViw7MtpW3HSiSVxKFuGmPpiPif5hfybW22/wn1JFqm08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3OLEzMdVT7BsWCEdTPvfsbGQBSaedRRi0QgAumpU0W16O2YKr6LusTjzQb3ejGGCMMaJlumR7Wv+2vW/n8L5RiCb4xsEoXB/i1bRaZ9AvRKblrLt0Y3QcP5/EZzP8/vECzguyaG7UO1suteb2+Zu5ehxFJcgBPcHMdxjBzGquS65DxhOFfD/Mtqs7z4cp7QtYvz1MtrFCzJEO+KRG3ggyLuFFA+GLW/Ym+UuGfpgjOSnXD3X7/HGAbXBH+A+m5n6PDc5wE36DHyT5dOdQ7XM58xMDkcjJFVFkH1qE4OwDgJEsLcdMgP9FfiVDFm4eRWJmXHWUbzbupExIxUH3FE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+m5Ei+MKXH5bM8SGaOAp0zahuhiGQETPCeoMX18lqCc=;
 b=i3qv0mEfkhCUOiHRdxghqSefKqN7kuIAtGQZKeo5KGjk5isgxuGwFNP3d9upY1oGhv2f77MiCuGgvqUDLdNNKzFQqoMyLRbwragoht6R+riqm3GytVSoeF1gItqkqBlOqWJ+Y05+cECdAVhXqfKNwr0q+BzThdAw//O4Dyq2D7gOSZTXbSQ1NXaVpTINMoYCpJtQKGD3sI5QUddrvZP/X1wdmoN/9rCf+2klUXqWog7nc9YaaNmDuuIpDXL859on8cQ11mYdjQi5ENufoUz2d2/paPsdPuYTW3GyzMfKFPYPQc5hha1SnNyfp6L5dOh8K/ko3hOOOj55Y5yPZl7kFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27) by
 SEZPR06MB6813.apcprd06.prod.outlook.com (2603:1096:101:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 06:30:30 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:be:cafe::bd) by SG3P274CA0015.outlook.office365.com
 (2603:1096:4:be::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 06:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 06:30:29 +0000
Received: from localhost.localdomain (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9BB9D4160CA0;
	Wed,  5 Mar 2025 14:30:28 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com
Cc: cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH] PCI: pci_ids: Add Cixtech P1 Platforms vendor and device ID
Date: Wed,  5 Mar 2025 14:30:18 +0800
Message-ID: <20250305063018.415616-1-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SEZPR06MB6813:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eebdffcc-682f-4991-3976-08dd5baf393c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uY+oWqOt6jnN9ws9RDV613WD2z1nlSDWxfhRwvuun7RlkhTyiaZz2gChgmIC?=
 =?us-ascii?Q?dI80qm6bgJ777nb8u2gOX8wVKzUBug5r8We80BK3urqfef5AFCFJWYy8N21v?=
 =?us-ascii?Q?PCZ0HxJXh/m4JWx0eoBDGoqkKeA3DuSgSsxLBQ27FwuvI1heWV3vhVsgxbrb?=
 =?us-ascii?Q?dhf28KhJqiAwGLFVho0MUWt7JDDFAueNygrXj9QQfhjI4y74kyMS3fy2EnsR?=
 =?us-ascii?Q?y1SioD8IM4LfSIOunHUBVgxVjQWVTqrjGbaORXYKeFsZwJvuIbjEQXMU2WLI?=
 =?us-ascii?Q?Id3dDqbDyHAkWxoOjK+z8hsTknw1BR7Fyjr4WCYXihQthaXugJqD/PzBaVz7?=
 =?us-ascii?Q?y6G5Nh4xyBo0yXpMUNO5k2Lif5cN8eqDgmN+vqYgbzo1ccP2c0Y9pJXONY+6?=
 =?us-ascii?Q?LGrqAgrQudzRHt3jQzbTNeAL9ir1nXQTqU4IocNT4iN+yUkI46/yfS9l2XTM?=
 =?us-ascii?Q?JGGewrovO8hySDC9A18gq8j/rEjGX4V5F0xiVfb/r0gEnr0CZHCeMjGgdUek?=
 =?us-ascii?Q?AU2wXw0M2G4XELpWzOtBL+dMWtBtu/rKlXVlVFBHtdXaeL+Md3captOrztTl?=
 =?us-ascii?Q?cg/4hzgi424is1Bk3ZXoUW29c2PbhRnCVLRC+hnJYwyt3bjQZQYcdcCQoDex?=
 =?us-ascii?Q?qU+Y0QSYXvIyQ15R9IyP881CLQdGSDfGSPMJR6SNMQ5a6bwKq++Ek2MyhWJ1?=
 =?us-ascii?Q?vq9Jck6+NtJmJ2TInGJCf40Z5RxDS8Q+lZbqyx2YsNH0DGnfQf7ptTBfHraf?=
 =?us-ascii?Q?mcfHwEfIRdRj95J7NnplMCg0UULuT7M4/YNhoSx7/Kbhbm0DpTsxmMiWJnZi?=
 =?us-ascii?Q?sQ44flCGCBPxSqj+5Cg0bF+9J00czPrt1DMtScfQlfOE7dfdAaT/gD57QO0Q?=
 =?us-ascii?Q?74YnmDOEZhN92FirAdHHa/tKJzkIBYfYWyjBUDwP7Im5N2wWvuTGAsh0UGYE?=
 =?us-ascii?Q?X4hKcvxGWUjpdi+84CkzoSBflPQ+X9DrLGMpkkqr3mxANI+YZLH+HnE3qMe6?=
 =?us-ascii?Q?erWFDLI4LePwHMX7Ox9dnGXPdxs3OsaZkFba37L4TMy/fMGEgJQzLesAwc/J?=
 =?us-ascii?Q?JbwtBv3jv/Fj1c8pt37h4TLNU79kFwzGdH5oz0DW2innCFNV6HWLfBm5envJ?=
 =?us-ascii?Q?7fJrhT8iGhOwH5h7sYLnhWagViA7n5hSMwmG2NcPLiv5Cpie4obHS2vxKYZI?=
 =?us-ascii?Q?LWoi7tUDqKVJMkalg0HRqTNxPZi8EcGIZ4RhfPqJBZ8aqOQrKJ/oCAUJhL4x?=
 =?us-ascii?Q?fwUIETM8Q1apoENoeyeN7dQiZ3Nq9IPA3j/XKlDkhZPeKaa8BkQHZJmAmFw7?=
 =?us-ascii?Q?CAGW4JqlrTIpxZCnum31r4a44rA+Ux+X4hXs3C9ExlTy1FBMkkmmP5uXFoXE?=
 =?us-ascii?Q?yhdGxQhSnlv79iF47BRYmT60F6S5Cfhykz8KsnQ6Spp0NLgxbbK6vvLZ8PvX?=
 =?us-ascii?Q?Evml42cPQCVG4Te52k0Kg6xQzrN/8iOJsAu1xZSAR4/sNFChZMS7/dddGBVh?=
 =?us-ascii?Q?ZHN9l89pKHQwPm4=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 06:30:29.2256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebdffcc-682f-4991-3976-08dd5baf393c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6813

From: Hans Zhang <hans.zhang@cixtech.com>

Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
devices so we can use the macro for future drivers.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1a2594a38199..531b34c1181a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -200,6 +200,9 @@
 #define PCI_DEVICE_ID_COMPAQ_THUNDER	0xf130
 #define PCI_DEVICE_ID_COMPAQ_NETFLEX3B	0xf150
 
+#define PCI_VENDOR_ID_CIX               0x1f6c
+#define PCI_DEVICE_ID_CIX_SKY1          0x0001
+
 #define PCI_VENDOR_ID_NCR		0x1000
 #define PCI_VENDOR_ID_LSI_LOGIC		0x1000
 #define PCI_DEVICE_ID_NCR_53C810	0x0001

base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
-- 
2.47.1


