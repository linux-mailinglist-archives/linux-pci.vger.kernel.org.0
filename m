Return-Path: <linux-pci+bounces-32749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A2B0E306
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F0C56597B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269DA27EFE1;
	Tue, 22 Jul 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LxZCtP7n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEB3B29E;
	Tue, 22 Jul 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206668; cv=fail; b=FKOLgykJOVibEZYk9vRpsnSsfBkR3uwWjX9LVOh38kjghPeFZ6qFu4lqZ1FFhFkV0sk77E9oES53lHEAbBcvglhcjTG50+2qDTaRJ2ZfdS13EP1xDUE0Dujz7nu+pGPyrMicPTgw2fCQEJ1b0Dii4rq5JIKC3IFS8TSziwPuo/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206668; c=relaxed/simple;
	bh=tup3kQ6qId53aXX4g+ejEgNTDC13LjCzjYunkpjP9b0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSekpW0qoKdool2YIhw5VKYIGaP5W/WSYc26nTd3/y6yRWpAk0G4EECa7wBC0ml1/cClhR7WB2t4vG+cS2CUJ80eLb2T/MkgpPG1Sr1AhEL/VMn6p2hXZuI1GSvyD04KvryNDf0SeAEPJiLcs+/qmYMvqvkSKuwsvGXyZbyoU58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LxZCtP7n; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAgVpAL52FfFXU8CTG/dqJhZ7CY8MciHbV++/kxVjnSWDmeHmskVW2wZtA7uOLsMO5FOyz+ZWW5eyWSViF/YBW3nv/9HqPsjfF5vlSvgxRntDpFEaD4iaBqGid0igN6RrjCBTjAlrZrFrdwyJ2lNOyVaR4cjYyrfd3NlkQcJMop9VjE/6TQ+ccWRf/MLvlqEB7PYIqcDZomXe6aU5FpP6qsDEEuY4B38iJu2H/4f6+oLr+TQZ/1Gbo5abh8AczcH2QqFxUAmbdAm0swo3P8UbvKykAHMaNYUEQ6uO5pFAr9s6jRKhLSbi0VjWc1KeGzZdYTiZ+Zm9N2WsPMKi+j6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFlrgGwD3Zf74YC+2NQ8gyCirDJmUOKmgHhM3e2yFS0=;
 b=saEQVtNdKiur6MgzjDpgp0rQU5NcSGTSh8BgJWrq0BJNncv5ZiAwvKfQS8u7ps1kAFmKGVQJ0oa2SZWzAwsGn4Wi+ol0nWVEjScCKS23y2X+vtQ8FOKyNssTEfN12Wka/YJWoJ27UcqDQDolHW94tx24Y42pJXEITyptBkFejFGbyTI8wIl4M5TP8Rx14xyG/XTUh4U7zAUfe/ciUuIcRsa6D+cV8Rd7VYHzRkEy5y5hIvQs4aDurz+mGFFNh7UULfAYrxXoGeQiISvhBrq6GHKvqhe/1u8TZPl2+VRZdnxE3Uk4dhmblScbhPooAz2Sqy4GTMjuCcUb9gjjJ1s9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFlrgGwD3Zf74YC+2NQ8gyCirDJmUOKmgHhM3e2yFS0=;
 b=LxZCtP7nrl3Dmk8tul7xB21oLx8w08yQbnwv5WF+JpsE5pLe7nuqHTOQS8S27lsMUA9M6XWrBrPdlAB9vzRCb/9rRihObBtI1cmRJ0+M5RXqifgQmh0DQ0ZAx853v0LWyiws2TNhTeXQ7p+IURfOq7yhPGkupHm8ZaF5PG6DEnA=
Received: from BN8PR15CA0039.namprd15.prod.outlook.com (2603:10b6:408:80::16)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 17:51:01 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:80:cafe::a1) by BN8PR15CA0039.outlook.office365.com
 (2603:10b6:408:80::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 17:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 17:51:00 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:50:57 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
	<westeri@kernel.org>, <YehezkelShB@gmail.com>, <bhelgaas@google.com>,
	<Sanath.S@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH 2/3] PCI: Add PCI vendor ID for ASMedia USB4 devices
Date: Tue, 22 Jul 2025 23:20:25 +0530
Message-ID: <20250722175026.1994846-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 51036a21-27d1-4f82-610b-08ddc9485227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n47wZGT5CNPsG2+ntnGjQSzZwQ4pmaDEv87smI6uVH9u11Y7XIhW10njU0hX?=
 =?us-ascii?Q?5VXI2HxY787Qtu494fWez8GobfFANPiKqPSzlWDwKhIWryOUlpp5YZej4dMV?=
 =?us-ascii?Q?o78jYp/bBo3e8tQvA81JbvyS1G9yihMebC8vdbJQACjdobiH+agnxKQfi+KV?=
 =?us-ascii?Q?deU/HHEoInsG0uYPA9W+xd/UaroZb8xi4iojmaNjThvms3Ao93aPqZqe/ffM?=
 =?us-ascii?Q?YwwTO0PJDH4laCkRGWOjuRIRh9IG4/8E3HPeLfilResYTugznmdmeW28DjPe?=
 =?us-ascii?Q?wUOQurBRqk7AVnURHIltN1lc7lfkh3QdV9KQ6j3HgZG/Okh62RGfuxTmL2zS?=
 =?us-ascii?Q?Xop+R0Pyz9Ptj1v7AknlAxX06kJBsicfVJ4kJ0JaDZQlRIv/xhY2kUyW0x3+?=
 =?us-ascii?Q?PEYoKdz2op7AZrlFCW3iAJpBZ9I+g89hXkzPoFITzSr0Ao5nMTTMjLF9KUC4?=
 =?us-ascii?Q?5jdcWilECpS7Xw8RNC/5vMqjnP/Pbef9O3hiW+gOuM7LQrYKLxT0eOWd2jsu?=
 =?us-ascii?Q?34ofLgpWW4Q7QmGowB75h0H+ixLmTZvMCWPoBsDK+kgqo9+89BD0DUWtbg/j?=
 =?us-ascii?Q?f2nR/lKr7bfC3BnQlKdwuBd6m/iXbKfAGLch3XeKUbrIbNV9kRDx2/8Dpgyk?=
 =?us-ascii?Q?AWttBQTpBRFv2pYTujeBWZRQdUH2/Oka3bjUPb0DcKo3mPmCCkvby/aUaSjC?=
 =?us-ascii?Q?nW6lH98GOI+Doh9lmDIGUDdmsOsxyUXXWHT+ILNE4ByxmbmzIuMuYNJ7NXAR?=
 =?us-ascii?Q?a5jlGcdRR+OpFNQJ67I8GYrcgp63WXbq2LmSuNdMkVYz8inudxi0wF3+/lc6?=
 =?us-ascii?Q?j6abG6ye1MDJN49BtVtDX/udFILoeTp1WjntjKgQn8nww9om4ita2vhWSvD2?=
 =?us-ascii?Q?H/Inv0UPc9BFaGc7iLJYneEMmSb77xuWMpD8D6SzwvtAxJyDulbeeQxWHFg1?=
 =?us-ascii?Q?7F9e8Zrl4xpcc23J2yXyYWZNP8rCoue4LL2ghIX+IonrU/IP0PryWQ6gaYNe?=
 =?us-ascii?Q?8+4sS9ExjQqlEXlxmwtfrO77F6aP8jIyY6CK46KKoEVC7rcG40cxK4hdWtAg?=
 =?us-ascii?Q?ATG7mC6LP9+JgK2u71rIsZTkbYgOqWhv1eYIhh8nb9UDaBr7L9j7/P6lLi4C?=
 =?us-ascii?Q?fKrni5NEMnh8O1A32UimPk707UcB8Da5BeIi+n5beK7WHXAFua8F2umClF2X?=
 =?us-ascii?Q?J5ymkNPjdM+Oh0Wk2Wg1RbofkNMx0NSuAnwJbESoaFskUq8jBA0ucXDnjMFn?=
 =?us-ascii?Q?xDE5mfSJ7uJf8KxMVCW/GhkNg7WEfq0py0uAxzNbrYTe/4F/7Edn7rFVy0/0?=
 =?us-ascii?Q?PR5f/gj+navZaZfRL5ULv2rZOG+hXt8gfZ+ZJjyat/BkPzmTpXzKdHQnHh6I?=
 =?us-ascii?Q?3tPOI1BkHBhK4+fTWVw70zdlfhtzwirxNXbRXT+6F3w2SkZFmktm+mHKf6ML?=
 =?us-ascii?Q?/oLyC0Xma78Evb523EKO2x8FsJ3FWWbIDTvrdNBlzixjQsIibjW0+bq+B9Fa?=
 =?us-ascii?Q?KC8JPOAmt+hPRto7KqI3FjLRdC28RBYY/sU9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:51:00.9185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51036a21-27d1-4f82-610b-08ddc9485227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

Add a new PCI vendor ID (PCI_VENDOR_ID_ASMEDIA_USB4) for ASMedia
USB4 devices. This change enables proper identification and support
for ASMedia USB4 hardware in the kernel.

Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e2d71b6fdd84..3397954ce96e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2592,6 +2592,7 @@
 #define PCI_SUBDEVICE_ID_QEMU            0x1100
 
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
+#define PCI_VENDOR_ID_ASMEDIA_USB4	0x174C
 
 #define PCI_VENDOR_ID_REDHAT		0x1b36
 
-- 
2.34.1


