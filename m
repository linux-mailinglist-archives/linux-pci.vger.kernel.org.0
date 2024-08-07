Return-Path: <linux-pci+bounces-11444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A283194ACAC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65CEEB286D9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4B12B169;
	Wed,  7 Aug 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Ef+V3VR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95579949;
	Wed,  7 Aug 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043887; cv=fail; b=I5mkeB4CSip+H5hxMNO3YcHZsiCUv/RYEWqX+w/m7Hhn5IAvNjV4VaFF6qPxEy2mzHu13DCYcrnIJAsBR6ODhiXLAwH7L/KzmJTt73DWNtUYowTEikPv/Ewn4MRxuVEWAOhNKI+vv14QSz/b/noCYaJiMeLrmAkYH+4PjIPCx2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043887; c=relaxed/simple;
	bh=cVBsiHAWpw4OuQ18rY2DwAlgjomXyaaiypMVy4lCKug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKuTgu3nvOvbF03v3/vQQA0MetdXPM4Hv19RC2EYPfblfLdJDIhXou9eiJiqcaEnssUPKhGmMF327fZs66ruIiZnlgjw7Zx7nG7+ObjvhSgnvhmXnGEYtSHIiVblv+2Nqoo/lsnj9MqP874TJqYqtXhw2oMoP2pAcgSzX5IteB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Ef+V3VR; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Soy+P84cVw+1Ml+rKxgVXET9Pi1yPjoEVxkhGNVMey55nF/EtcXlkR6NfttBL5ctkTyapIC5SEdhQzhutUzmKqAYhoGaD73T2eOCoWTmGsUku5NGD2aiD8XBrf4fcEFUlcnC3SjbUKczP7q/jcRW94FHFHy4K7HW0kjmMsylh8S0G4SVkZZT2NKbeAe5MH63LULAdS4csGJaYl3Skxnbk+FRLiaUiQlt4ba9IdpvvqRTrJ/FqwmMwLHmB7iWNgqAJKr4a+D4NjIUXDahmY6s9mhjX9RyH+gZBDWBbLXcX91amE+Vi25ovKtJXqT2dO1S9fxR/HtXYJ621R/mCFzFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3wIVH/Wi3pxhDbWAVJByEUW1uhpVaxbPDKzRrzajk8=;
 b=LG4ImkmMs1Rt19H+1OiUUjMMlLHHITObt106fV3UhxYHzFEnyNMsH0GfZtUUPtfckBIT1FvpkWaW5gQn1mcJdizAsyZImvy+gCo7g85/tTOfkz/FQtokfx9A6gif5bOQ5cW/bBZ9+ni2I27JXkpKsnA+cF7RZtR+21DcBqtIpwgYn9JvJN4Konnre1pC7SyYM1nyEA1VdQQIIYAfKmHaIgPsx6NtbTTE3krc96t0fBM/Zl4kay/HAK04ETWerxvOgCLzwksmC2yYTvEtGtVtkCnQIqPhvoVLnhg/RUZd8Tm5c2ps+aRC1ZROSMXIBt4zafyoMgOJWJdnOy9GJOmTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3wIVH/Wi3pxhDbWAVJByEUW1uhpVaxbPDKzRrzajk8=;
 b=1Ef+V3VR4x7lnk70aE4vJUuZ1hYcHdcq/5tWe7ue+LbtJIcZd1rPbIuOyhO94SzS3v6OaeFycSokkpuiKTK6VYaitLyZm3wmPnQwENKyJucKPBNasdS5JHr+/sR+Y5HYjvLvJtQxmtLWHn6IJSl6vXkW7ZQZ52qYB6b2FsiVWAs=
Received: from BN1PR14CA0020.namprd14.prod.outlook.com (2603:10b6:408:e3::25)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 15:18:02 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::d2) by BN1PR14CA0020.outlook.office365.com
 (2603:10b6:408:e3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Wed, 7 Aug 2024 15:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 15:18:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:18:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:18:01 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 10:17:59 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Yongji Xie
	<elohimes@gmail.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>, <x86@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/8] x86/PCI: Preserve IORESOURCE_STARTALIGN alignment
Date: Wed, 7 Aug 2024 11:17:14 -0400
Message-ID: <20240807151723.613742-6-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807151723.613742-1-stewart.hildebrand@amd.com>
References: <20240807151723.613742-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 319bde24-8e79-4cc2-8d0f-08dcb6f420e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07LKOlNka9VkwSer+P7P7XRoP3I6uHq5zon40mUYRulUB8UYzN8l/OJP0bBn?=
 =?us-ascii?Q?qms/p9RfS6M9keyKZZuO4AkhZAnNjbNMfQx0gAEYfTvoajQt6Rwk8Xli7bug?=
 =?us-ascii?Q?qj08qINfAbdYZBm5aAoOBw2epSepMOgR21+Ukco+el8jf+utEAO8U40eDBAG?=
 =?us-ascii?Q?D63GhkspDETgRWQ8PNCUAXJ7xgZb47GOtigAdpCQVACpwDJBHM27gYk2UME7?=
 =?us-ascii?Q?u3Vl50nX7AL9UbC/MphEg1+3wrgg19uzS2jBzQkcJvYNvT5ETYm0nzCbGKtx?=
 =?us-ascii?Q?k7/b1EdPxrMnQ9gkdeVjx6xJY8oX2O7HxatapfMPQ1h6oA8HiR9b6lnWG0wJ?=
 =?us-ascii?Q?l91eI461Hwh+MvIE3Y6eMC0GtL0uFs9af2k9bdouCL6SvF2nCXCzXWtTJvwJ?=
 =?us-ascii?Q?J/AQPpRjCCglm/zIjMugsD5hajyzedd5WYcdyDQTlssOEZ5aLelHoeD/VrII?=
 =?us-ascii?Q?KywZ0Az0Qwh4od4zEZI9RutSLZbSZIzJQZtVLfJm9K0CdyRlWbuZQX2ZbVRn?=
 =?us-ascii?Q?pXC1+GOjLgea/zL7ywRzvLK7MnhlE2LyW7LsgufbX2nQ/e6KEKDYJGs5PEOM?=
 =?us-ascii?Q?6SiX4Oxd7XtXTo/nl2I4rq8gh9N3lbCf+AxJQSi1pehTZ9OD5BEp2cA7L9Or?=
 =?us-ascii?Q?4BqSCM9qtKxeoXJmbVj2/l7J52Wnk4ijyUdvFTDQQzm0JN6rxd8c3Pih5Qb/?=
 =?us-ascii?Q?wFaI9v4v9lkZRiyIL9/QP+ylwN2L1Kj7yaOwuERyutJMDnoOf0FZNKqG2Zuu?=
 =?us-ascii?Q?8FOzEtXvx912gBoNpuRoHnkOCavEWpMKL/KkUNIJjCok7opZR2FReGBbxnbI?=
 =?us-ascii?Q?266O3TEAChQvQPNmH7RLr92aIOQLHc1PpEkJf4A6JMLPV7ygKVcquFoL49iY?=
 =?us-ascii?Q?9p7w0drJ309egpG1/15iqQhaTBYpMkO6z3polOXDw7KRta2Fdq5MZrStFHUB?=
 =?us-ascii?Q?lt7NIpznhyEGBB2M++V5uWa5AE38djA34nixlvxobz6szGkNHukhHZ8on6xI?=
 =?us-ascii?Q?ee7bxQNI198MAupe5lBCaWsJ/4Tg/bbRs2EkYV9CMP32X2zWJW4VW7pErj0e?=
 =?us-ascii?Q?yb55xOOeE5WobewKl35C8aczB4RYkktLGwcxuypvF72+J6Ed3+ACKm3b2fBq?=
 =?us-ascii?Q?khr3OYS3q4qK89GTL1NyyqXEmg12rIcdL7qMsgM07yi7Itp9GPVo19iNYMkS?=
 =?us-ascii?Q?Rb6ho01cGWiyvwka9o4DL+lA88t5+7y1Fx3dYMyJVQwzRZoczzjnCHKf2U/p?=
 =?us-ascii?Q?JUtXsDyqm1jLiwpkhkfuQx6fG9QLbVTwxzqIMvGjgEiVD8NZltBw1MOZLUC/?=
 =?us-ascii?Q?YynfAHoactTR47XlnRhdHK6+VcvaBJ2RWZE94fCKQuoPK/RvqveJPq9QHQSF?=
 =?us-ascii?Q?23llYHeb9GvbCtAT6ga1vt1nl6Ni+54bqWjzsqJcfmtc78V8BhojZO0VHopH?=
 =?us-ascii?Q?tFF5bVQhJByMdMgRal2hXsymu6eTIrWZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:18:01.9045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319bde24-8e79-4cc2-8d0f-08dcb6f420e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

There is a corner case in pcibios_allocate_dev_resources() where the
IORESOURCE_STARTALIGN alignment of memory BAR resources gets
overwritten. This does not affect bridge resources. The corner case is
not yet possible to trigger on x86, but it will be possible once the
default resource alignment changes, and memory BAR resources will start
to use IORESOURCE_STARTALIGN. Account for IORESOURCE_STARTALIGN in
preparation for changing the default resource alignment.

Skip the pcibios_save_fw_addr() call since the resource doesn't contain
a valid address when alignment has been requested. The impact of this is
that we won't be able to restore the firmware allocated BAR, which does
not meet alignment requirements anyway.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v2->v3:
* no change

v1->v2:
* capitalize subject text
* clarify commit message
* skip pcibios_save_fw_addr() call
---
 arch/x86/pci/i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 3abd55902dbc..13d7f7ac3bde 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -256,7 +256,7 @@ static void alloc_resource(struct pci_dev *dev, int idx, int pass)
 		if (r->flags & IORESOURCE_PCI_FIXED) {
 			dev_info(&dev->dev, "BAR %d %pR is immovable\n",
 				 idx, r);
-		} else {
+		} else if (!(r->flags & IORESOURCE_STARTALIGN)) {
 			/* We'll assign a new address later */
 			pcibios_save_fw_addr(dev, idx, r->start);
 			r->end -= r->start;
-- 
2.46.0


