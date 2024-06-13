Return-Path: <linux-pci+bounces-8704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BAC90638E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1594B1F216AE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35C013777D;
	Thu, 13 Jun 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OaGpFckU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D991136E27;
	Thu, 13 Jun 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257371; cv=fail; b=mTFzpQYVHP7H1TpRcs9+fbkBcnuR0IJnDHXCc5dG0F05Ba1JyCCRBIeywCENvyyaaqcxmSVBgG2Io0+T1H3H1YjlaIun27+7vOz9vO5N5abmSI/4lo41tGyxOaUEGBc1Bu9UlsNdiKwQ9zw3l6UU7Ew7L0fW6hEHCB/OldFh+Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257371; c=relaxed/simple;
	bh=C2kPEeUrO93MSjn7Ny0iWuHbFheDIMKmnDA+pCiXwB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3/vsmiLRkWjRVp8oKAkghJBE/7Hoj3X+hebQF4VJvW18awInQpM5O4n6vGoPHvThHxUnl6EOB1v/LxOqJ93dzGrhcw2t0kTuh5ygvmVfDD4mZelPHcIPX48o0MdAWyTgeN+FZuW0BrRPwaRtPNzO6B0Zbyk4DuR2JDyK3hcmnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OaGpFckU; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOtTKAKjfeKm6zr7oJZzQoEwnbrJdrObj8DjLDDNmNOl5+XEiBlgu+tzTHt+NXb/kdFywijbq9PlId7n7xQlqcQAn2vFgfGNp//aZCskcHEyqyUI3rjWyb4PIq8n6+q/mHCyKDLNVwbLnFdU9TY0QtYzEwU8oqDzxdKq8okrG1RhXED8tFBmu518dUjjW4LGC6ghGweH58/wrdoaynn2jvl+arHLwTAHmY/tQoEVrZaQo/hnoBDi+68Lz3dNuY4i0HfZfHrMRfcaaPgchwd6cknVFbpzLLU1YJjhpnsF/wBrTmIeVJsBQavhrBNoitQJbXqDw+yKTnmRWwyRRNxOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p4THujH1L2H9U0QBonyDPLu9QLPMKypgE/r1FjQv0I=;
 b=cJLP8X+8+o8DS3zjGIG1RtBiV+OUKyU2NjwlBG65nwDFL3rCG+vZ70yF/n/4ojH+YpAAUdgccTI2/Ckt3YL5U88S4jPdEgqBgns0rV2pHhVZPEeT6j/DniFjdYWmak8237GJFBt3hNsIKNLMI2Oga3L6cZslSoa9XGsqE1gMRAQCy+AFrucPZuqnUBdTgq1TdjW7SDmYi4ETVpeyfFe4b22vV/sDaQPzs78XtvWdc4GIm4QCz3e/Hdwzc1ByWjl4Vu/OnosYhDjvnVCQ5FFX3l1aD3sfS3vE/jfC2RI2Rvten29kYPzFp41MuknN1nbKnwZKQB+ZwpqWjyTp8aNQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p4THujH1L2H9U0QBonyDPLu9QLPMKypgE/r1FjQv0I=;
 b=OaGpFckU80ZM+Q0cdpJGHuwGTCKnIpFVF6tbz2YKnORyXPARLqP36lBv+RUNziMAx2zt0eA2VNKbbNUDDSycdqfhGiSVZ70Jl4AQsMuIMYjobn3IvTMSNzcKMCDNisb3qgszNGmZS7m1sHFCTAP9JziW+69QGDpl8oJkYma5ygg=
Received: from PH7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:510:339::12)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 05:42:47 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::d3) by PH7PR03CA0011.outlook.office365.com
 (2603:10b6:510:339::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 05:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 05:42:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 00:42:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
	<mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, Daniel Drake <drake@endlessos.org>, Gary Li
	<Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 4/4] PCI: Drop Radeon quirk for Macbook Pro 8.2
Date: Thu, 13 Jun 2024 00:42:04 -0500
Message-ID: <20240613054204.5850-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 899f18a8-73b4-450a-8343-08dc8b6ba7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AbmvffzSqcswaQ0oo6Ari7HBF19Tibl0AGInS3UwI1IH19Dm2kFQo62oTDBt?=
 =?us-ascii?Q?UkGFxDAVeD8UCneexhp1a8V6umIa4neYc29dVeVkpr9raj9GeMA9BM1g+X0D?=
 =?us-ascii?Q?sR1nji7cL8BOuwuqtDU+eLqTw7v+jEjoVPT7xvlir7VBUzEpPSKGxsRxEJIG?=
 =?us-ascii?Q?r/245cqLCpd5sCyJXWyz5i3yqp04bdjuTUETMe85UHwskwLhkWcrUg3KZmrq?=
 =?us-ascii?Q?rnifBqL+z6gl8mSY7QTD3r+mPOXfaYJt7TFtk2Ow4ilX3YyjwOvlzRuy0Tyq?=
 =?us-ascii?Q?iD9A1/9ZO/7CUyJLSjcCW5MDC60nQ5ZejClUEC1UH70eNUUvwD0J/s458YEg?=
 =?us-ascii?Q?/szUO54q6/AoKdkAwO0v0DJ7yazOr6wChVMVudlFt5D6BDL6p+mqHo4RBZxl?=
 =?us-ascii?Q?4MYHUo+cB5s8y37eRHaPoziHmOLuQtd10KIhvh6QqByxr20JnRIwhd4EZ8uk?=
 =?us-ascii?Q?7BX73dBGwR5IV4X48/I3dhNvD4uuqroVU4v37+TurXBrSBmXLpfLKxe0xfgK?=
 =?us-ascii?Q?ly/372EQy1LNyl6bX/n7Xq4NjZ395JHhZ8x60qUQ73lwsXHMZ5nQQtsU6bS/?=
 =?us-ascii?Q?XeoIaf3WFfGQuHP2ZI4H9tNDBS+nscupY5QwgL97jyIfem6FclhMGzfDRWkO?=
 =?us-ascii?Q?wvt5Diyhih+E+k9WlN1oV9/FWCpgI6aSS0ZLVHBbei7DDVScmaiyzh3RXamG?=
 =?us-ascii?Q?gT22gAUsTxhOfI9HEnVL+B7nzOPKhiuHFpIZ2zdeV3t+F5V9GhPo6BeQZaxy?=
 =?us-ascii?Q?Ib8us0hdhzpdNj7H5i+3/P1hc0bcsl9L4+idLv5pCuBS6kO82OwtTYvXb5iK?=
 =?us-ascii?Q?Nd2G4LlNzHOxEjFbcUmyMQ/u76aGZmOytRjC6vATeFpiLunOKz/NBT3Izfti?=
 =?us-ascii?Q?dwA/6L+iybE1lX7rkuGeA+ue+F5+oW6RDpn6Mum5Uy+RysM5U1L1EECGelr9?=
 =?us-ascii?Q?WWQ3gr4krLoMOa8AiHNPbYSNmFbMP5TD0PmehDvzHolHUqDejmepNLdii9nl?=
 =?us-ascii?Q?qI/lHVJtyu0AtjS+nwnWSL/3BEGIKI4Uikea1vgQxIZ5SgFCcAamQ5FQHXmi?=
 =?us-ascii?Q?+LMV95cpBJHUGm5bUTejBvt7y3RMi7ROSOJsOSVXTecjDub5IJujTpYkUPke?=
 =?us-ascii?Q?2tQ85agU6gVhvKHx3sHcJ7U9ABeGoZ+Y0YCpnaJ0N/QYYnjMACY+5sX/jmlr?=
 =?us-ascii?Q?8ji/Mhqi+DBKqcujK2B/HDg+fP10ox3dNthARG83udpPhxCTTfl7C7dsdFCj?=
 =?us-ascii?Q?NwZ3LXU6cdmKCf0Z2KlcgEl5KP6jl9+KGOmS14JFXMsKPR0+S67fkiO0RIcP?=
 =?us-ascii?Q?s3jVfEfhPSkbsq2v86HuixLG+PNDweYNrCsRG2DAes0zaIga2MKh+LWqGn62?=
 =?us-ascii?Q?Ynr0RY8wYYek01dNXM5KHLtH37iyIAE7fA20DkSNsUewUVeY0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 05:42:46.9340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899f18a8-73b4-450a-8343-08dc8b6ba7c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449

commit 5938628c51a7 ("drm/radeon: make MacBook Pro d3_delay quirk more
generic") introduced a generic quirk for Macbook Pro 8.2s that contain
Radeon graphics to ensure that enough time had past when the device
was powered on.

As the PCI core now verifies the device is in D0 during power on this
extra artificial delay is no longer necessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/quirks.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 942d0fe12cb1..19be953c9f37 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2038,14 +2038,6 @@ static void quirk_d3hot_delay(struct pci_dev *dev, unsigned int delay)
 		 dev->d3hot_delay);
 }
 
-static void quirk_radeon_pm(struct pci_dev *dev)
-{
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
-	    dev->subsystem_device == 0x00e2)
-		quirk_d3hot_delay(dev, 20);
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
-
 /*
  * NVIDIA Ampere-based HDA controllers can wedge the whole device if a bus
  * reset is performed too soon after transition to D0, extend d3hot_delay
-- 
2.43.0


