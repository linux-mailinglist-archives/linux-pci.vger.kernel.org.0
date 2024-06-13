Return-Path: <linux-pci+bounces-8705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC6906390
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C604F1F20C3D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6922C137921;
	Thu, 13 Jun 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIIcwVQ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997D136E3A;
	Thu, 13 Jun 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257372; cv=fail; b=Mte09zXQsNPEZRybrRg5yyrQyyBIyWQpQeRNVbu9f5PKpQReAc0rU8bxd64tdoQ13NzHYdpanulkagwo4vvH02uYb9S+jdMNgleUe4nnnweH32Xzw6XF5SGHI+7TnUeqppScLmAddd4OmlqC7IPCO1JWziMfkvexM4p3vA84UKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257372; c=relaxed/simple;
	bh=BIWtnfvMwFhza1IpWLfkDcPvVVJ0VnMEgUXFdQ9s4pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBa1qweMsnN8VtqKk9tOItVfmVnoFe+82FARdETwO0eA5+e6P/ctuDO6wp5vyrx92epenBYBvmjjNBddv+FEyxGmUxnOThXfLjyQxB+/eiHHO876ktDOcuYrVr7xdSaQUPIsMelH/IYWWvLth4fLAgtxTQaf+eeeQWz0yz+HOC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIIcwVQ9; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1V94Zyc5UrIn0V8XkUw1DmhthaD6KYfocOqq5neOPrcDrzyGFPO6fkKfnPluT3VjPPq3VO4RMO/NbJbO9HN8kvjZ1+z9XGAg+wRsANiJEKSdNxV41uBEk1GTcWW5KGUs5++mDdXtO3At5AhWmytpqJYXp7utPTIDRfajpMACQpcLZna+ZErF9Mw4pYQpu99CjQg0602ezopidqO6JU1PrXOqEXMMolRG9TnEzeYT3d8lMw0OFidV2jLUBpwMo/sKZjXfzJ3ZHvk340D20o2aMTEUUtFwTF4zb3dzjwDZ9Qgs656YaQg2Wrx2o1DqvRcbb0IIn+4JsPOiKB060xaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y8LrCtQGg2zUiTkHiOpl/2FOTu8eIkcZpCcb+HmIYM=;
 b=miDTfpgXu6EKsZ+kDEVF5aECEYjSytZBeuPgRQIJB10oipRqiBM2zctoG9yAmB2haM9nTchVGoSmDwR5FTmjpKX+/kZhT1Dmyz4l3hXmPQmDWzEs7FlCq7Lu8jw1vbPTXAMhzwyeS50G8uhq7wNr0GknE73NqK5NdJcFmg6tnWFdTMEwE/eEBjQ1LfNcZO5ImWX5z9qAJnOb6+6W8gbpwYVCy0EB59aKBzs/8GBeL+FbmLumsjbdTPvTnhRO6LKnG0KTjNFq4cp6kZ2QFhTyonBX8UtMOEkZeMt8nbMXfv/pOGpOHzfxqyTUKTWkKdAYVDhhz9xdR0uRWV+1XiqdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y8LrCtQGg2zUiTkHiOpl/2FOTu8eIkcZpCcb+HmIYM=;
 b=NIIcwVQ94jC7VXldCwzwRxThavHxmRJRZnQR7EYwQqE4U5N1oJsCxQ6gl8ON9cf5fBZNZZHhMmM6pa33XzF942buDUsB6GYFHur4amw2vVabCHuZWwUPhTKoC6XdfIyZa4jAXP8S70AXO1qylSoh0YpM17AozsmYk9HA+5i4w94=
Received: from PH7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:510:339::30)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 05:42:46 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::c) by PH7PR03CA0004.outlook.office365.com
 (2603:10b6:510:339::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 05:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 05:42:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 00:42:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
	<mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, Daniel Drake <drake@endlessos.org>, Gary Li
	<Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 3/4] PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
Date: Thu, 13 Jun 2024 00:42:03 -0500
Message-ID: <20240613054204.5850-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613054204.5850-1-mario.limonciello@amd.com>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c80735-630b-4164-8a53-08dc8b6ba72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aflFCo2bilFf7JeqqwNqv/2i+iDPvGaq36m2WJoIEkURpeUOznfehbWA4Hvj?=
 =?us-ascii?Q?5d70bvg7ywkBVNEFnmkrsB33N2FAbuB/TVJtF4QPq6gJMbjMDIC9m9ZZHrP2?=
 =?us-ascii?Q?dg/hKqfGWN6Qfgoo1EHzH1NIDA+WErcfW+XsbLnddP8V3OCzjd+1K+z7SAeV?=
 =?us-ascii?Q?z0ZFSnebVJ+vCzAJ2zhF4ZY4ta8dDsPZ1RR3j0IWUNlvLRweYNmTCCMLy21V?=
 =?us-ascii?Q?Lt3Cjocf0jLJ8xnTPS7UFre0z+Kpi5F82mzVRvA9kD2iN8+tPBtE0Br9mvya?=
 =?us-ascii?Q?2h8OcgqYhPDDOOff1usXK267HTYrl6BnWaS6S2X3PV2baZPKAVFn2UA+8lFw?=
 =?us-ascii?Q?X7xxPRMnuK9qrN+qQ81vyJuX5ftEgcBkVbuYKyN4tzDtE8RmpNiA78/EdD7F?=
 =?us-ascii?Q?XlHDY7gBBDejn5Cz8tflsePDnnEw5hhmm+gbqOAC5dGv7rGZnGXeVUT9a5wP?=
 =?us-ascii?Q?nkbQqHVyxzsk9XuKFIb/MVFEbS7yUl8ou68O+fCc9SXxh9UkgeGdM0BsuICS?=
 =?us-ascii?Q?4aaX/gk7vwVR9+KRApfNGkTIqdxQz82DJFwY1vQiEKScYoEzK22xCeXkH5eU?=
 =?us-ascii?Q?7hSyhE69CQ/LvvnbAp0t6AognGsxhYphWrszcjhSijDPXrru+80yt7/L38cd?=
 =?us-ascii?Q?JF5Zcp6gWProibQByIRpq4AVh1bQp1ZYH7o6kpQVLncyVfi8dUw0lmNwTU5P?=
 =?us-ascii?Q?Iq8+9fSTrbv+b/a4kht73s3oJdECB3glHVeWpicw0LsxzhZ4em9LoXJzMVOJ?=
 =?us-ascii?Q?9JwMMnUvtD0EY5jAYPtG5B9umaa/YL/wCL6nfcT4w+7ZLnv8IyK8Bb593cw0?=
 =?us-ascii?Q?wqtGbEQZQVMRQ76yeOIr3j9LBZsRZtRym70QsUhQh+WekniM1iSA6jyrwlFv?=
 =?us-ascii?Q?NH8ZwK2OEPCYqkU4uhJrKVAxwap7GGI+VQ4+XdzCQr9uVju/cy+sUul0Jegt?=
 =?us-ascii?Q?fpAdrEEn5K17GTk6SnRUWzd71FX30hKgOILxXpdnLeYrcf3tK1ryAyHo0a1X?=
 =?us-ascii?Q?bkrOZ0RAYDsdNepOWnuWTvClemCO07hDsX7qZeMqHwzxYxDPk13pZAg2fl4+?=
 =?us-ascii?Q?4XSQb8gazjt2+4RS1Soa9GJkP85cOQKta6FHqn/XHiBRchHBIWWXzKFdZPof?=
 =?us-ascii?Q?p6FGnEXjVLqYzfZf/5db+OTHfeUW2PyNpiNi3FBEaPob5ZSjYx5wVo105mR1?=
 =?us-ascii?Q?bOvqshkfGEg1siMbVIoEYoV6WAJqxZXzam8PQad6WNbTc8FRDW3PhtoIhHiT?=
 =?us-ascii?Q?cu7V0ZxO7PZnY7X+Q/E2ulWl2rnIvJofBvVwmII9Jva1Brx3YHW+GRH86m9c?=
 =?us-ascii?Q?xo2+ptw15mAeSc7xY/Qh5uiwYlGXE+9aFi3T0u1tMLU6Nv+RnIDzXwlMnZAU?=
 =?us-ascii?Q?1q9TCu4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 05:42:45.8871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c80735-630b-4164-8a53-08dc8b6ba72d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

As the PCI core now waits for D0 after D3cold exit, the Ryzen XHCI
controllers that were quirked to not use D3cold and to add a delay
on D3hot no longer need these quirks.

Drop both the PCI and XHCI sets of quirks.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/quirks.c        | 17 -----------------
 drivers/usb/host/xhci-pci.c | 11 -----------
 drivers/usb/host/xhci.h     | 11 +++++------
 3 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 568410e64ce6..942d0fe12cb1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2059,23 +2059,6 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8,
 			      quirk_nvidia_hda_pm);
 
-/*
- * Ryzen5/7 XHCI controllers fail upon resume from runtime suspend or s2idle.
- * https://bugzilla.kernel.org/show_bug.cgi?id=205587
- *
- * The kernel attempts to transition these devices to D3cold, but that seems
- * to be ineffective on the platforms in question; the PCI device appears to
- * remain on in D3hot state. The D3hot-to-D0 transition then requires an
- * extended delay in order to succeed.
- */
-static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
-{
-	quirk_d3hot_delay(dev, 20);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
-
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
 {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 0614d002aba1..ae330d3df6de 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -314,10 +314,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		(pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_1)))
 		xhci->quirks |= XHCI_U2_DISABLE_WAKE;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-		pdev->device == PCI_DEVICE_ID_AMD_RENOIR_XHCI)
-		xhci->quirks |= XHCI_BROKEN_D3COLD_S2I;
-
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 		xhci->quirks |= XHCI_INTEL_HOST;
@@ -743,13 +739,6 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	if (xhci->quirks & XHCI_COMP_MODE_QUIRK)
 		pci_d3cold_disable(pdev);
 
-#ifdef CONFIG_SUSPEND
-	/* d3cold is broken, but only when s2idle is used */
-	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
-	    xhci->quirks & (XHCI_BROKEN_D3COLD_S2I))
-		pci_d3cold_disable(pdev);
-#endif
-
 	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
 		xhci_pme_quirk(hcd);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 30415158ed3c..b84b1c48c517 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1621,12 +1621,11 @@ struct xhci_hcd {
 #define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD_S2I	BIT_ULL(41)
-#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
-#define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
-#define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
-#define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
+#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(41)
+#define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(42)
+#define XHCI_RESET_TO_DEFAULT	BIT_ULL(43)
+#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(44)
+#define XHCI_ZHAOXIN_HOST	BIT_ULL(45)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.43.0


