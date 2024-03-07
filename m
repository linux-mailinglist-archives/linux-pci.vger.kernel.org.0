Return-Path: <linux-pci+bounces-4606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A554875446
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC57288FE3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF312FF67;
	Thu,  7 Mar 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eLMP+qid"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4012F393;
	Thu,  7 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829451; cv=fail; b=DdnDQ7nSgu7TSeOMYA9fdYuhAy/yi5Ufh3giHPHEFJWBvPZiLWkm9PUcizu2Wtb7rIl8ujuHs56bMgR1KvaZqZmtyGCNAhLB1iTHbI876KA+l5fve0uUgHGl4SbBI+jbYw0DtobeUb/6uKDkESsPeFmOSBEhe2OELVdlE1izlZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829451; c=relaxed/simple;
	bh=qMqLdflvLJxtBNr3GLuufLcfaitlqmGL9Bkj7aYE6MU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZD4XKcdxn+/pkqMKwQoYeZkP97PFUovYmmKkh5Lf1UYAy4ulAFAXyr1eA7aFH1OJ5H9Npp9pMd2F+lKstdsnHyfBTWr0vgBcFwI26u8QURXa73aWg4mKzojoieCYNt+A3tJ4sFSchWS72UrHJ6lJbGgai948jqCu3KALbzqW5ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eLMP+qid; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lexNCBUbRdFr+c91nCjQ0UsS2TquKZFkajGchkzQdcCFjd5VQqodF97dm8MG0HuKqV9+VCdz2dxJKb8GCtB6o/G3ZQ5IDyA9RDxRTD7kjYZ7Cg9KlkHTo+nyVWLdnLAJyp89mRP4UOUYV7PfluaxHSF3zGcGibVhPUGn7UQcXMOR1CyQ6qk7Q+tkmC7kPTdpJlsf7k9/5Zr99kbby3LXtcZRu9I3VI9r9LVw61GW/dJVhZWCmvMchvshdgfHgX8wHY5nq9xCyMQehr0+0WvZvuHcR3kzC5nN/7xkyw8/NEZLmCGNurNg5HS6S2PCIIKTR88HSI8EebduCbCE1qSrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9q0yxDkkhrABhBbI+0EPppL5nIFwZNqwUTND1q3o2g=;
 b=hBN/8th+uoWQjjSz0B60jF37GEtTDIBJ9idx/bKwi1nYzWjvO+RNsIfPDmSFhDLGQ1plTlDBktG9KaOX6i0jqbfYwikWcQ9Gz8KL1PXz71lbNEi9OtesFtT11jtXuUB4AsRDZcsy+Ggl56ECBYgOmyC46EUpiUth/aaaOAhWXWXK2Z+6nJLTgXCk31sjdRI7l7kjUd8mSLoiCr/PyONzOXhtHAV/a7taTIOhQlvqMfU54RsPTdhqEa4sqItztsoJArlnGpNKJWwn8yaWx81/Fc0s/jD/pspmeqbE2fvKnlEJAD8U4Li5QG2IDThJecN1vmfn/bbLBpEaHLNmqfulUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9q0yxDkkhrABhBbI+0EPppL5nIFwZNqwUTND1q3o2g=;
 b=eLMP+qidF8Wat95NtradcZjxoEGWgen437FAVDO8f1kxgsE0QQsVfsVHF6wKZ0a1dI89QzFfcDpM+LddNLOVICqgUXRgKXBabMg5tFMzej/8yJ1DmUYCSpVyXvEnFh/DjbwcqXWwaJO6GY3tPDq5FEJsLBfY9gaENuGpG2YNtvY=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 7 Mar
 2024 16:37:26 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::e5) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9 via Frontend
 Transport; Thu, 7 Mar 2024 16:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 16:37:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 7 Mar
 2024 10:37:25 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Eric Heintzmann
	<heintzmann.eric@free.fr>
Subject: [PATCH] PCI: Add a quirk for preventing D3 on a bridge
Date: Thu, 7 Mar 2024 10:37:09 -0600
Message-ID: <20240307163709.323-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 580ceaee-4ecc-4928-ff32-08dc3ec4df7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bwGXRqb2szzxDpZ+nl+mCYK9OZe7LUsiowRGo7jay9y4ZrYqLGslOrgOXd9iiyjXL2kBIuTivu6zyCwy4mJyCcm9ZAb093GWqE86PHKQbm26ylwI6ZGKZI8iYQQg80squFNpFMeg3HSuBK2/rW7vVTUt3jhWyhrhtfxZHhCytmf4K7+gJ2KRB1vjuC4zLfkSBtXbKnWJ+avU7bRm2+AGe6O4s1Vir5OarGd/QEd1mcvJPk6QfpsBelqgkdXhq8ijJa2lhP2pVD6RT/6f9SsQDk49dTpHYRfiwuF4o7CCYldpmEUIDnXjiyeUk4+BFWrC1od/k5z5Yh1aSxBBW4mQjHidsMRGn8EEdJGwX9KC45V/gUQ5hQj8x6eUfI7G0tYTfZs4ZrjF0JTFX2WgeCTBfrJxO62uBW5BnK9Jm/saa5sQgjep43ADgrtmlhnuM19AGhszMOIdPw2uy4s2Ob/ZSmChcSViUmecSbUHJC0FvRsjY7rp8KIhlzrwu0t/b1AlYcPsweEo+q0zawyq6j4Zh0k5AcnlTuW4ATVBOe+CWHIBzMkgnQdujon4wPg2v7T/sE07yYFuMG0cNLC10HNnadGGS+BGBxb+H12Q641Yr2j9rep9CStrxxi6fc/hblZt5U5MU+MncR5IwFva+f4R6SeddoA34nGi9Z8e7Uc0F+R6dUW21zi2S2Xuw2RgwYytSVZcL3c0OqDIz4KnOpHAHuvySrFMTKMM3P7ouh7nFQsTp6scUu5GiiZs1L6zEBGPAVS/2PaZLBLeAbhrSBQcWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:37:26.3100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580ceaee-4ecc-4928-ff32-08dc3ec4df7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

Hewlett-Packard HP Pavilion 17 Notebook PC/1972 is an Intel Ivy Bridge
system with a muxless AMD Radeon dGPU.  Attempting to use the dGPU fails
with the following sequence:

```
ACPI Error: Aborting method \AMD3._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
radeon 0000:01:00.0: not ready 1023ms after resume; waiting
radeon 0000:01:00.0: not ready 2047ms after resume; waiting
radeon 0000:01:00.0: not ready 4095ms after resume; waiting
radeon 0000:01:00.0: not ready 8191ms after resume; waiting
radeon 0000:01:00.0: not ready 16383ms after resume; waiting
radeon 0000:01:00.0: not ready 32767ms after resume; waiting
radeon 0000:01:00.0: not ready 65535ms after resume; giving up
radeon 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
radeon 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
```

The issue is that the root port the dGPU is connected to can't handle
the transition from D3cold to D0 so the dGPU can't properly exit runpm.

The existing logic in pci_bridge_d3_possible() checks for systems that
are newer than 2015 to decide that D3 is safe.  This would nominally work
for an Ivy Bridge system (which was discontinued in 2015), but this system
appears to have continued to receive BIOS updates until 2017 and so this
existing logic doesn't appropriately capture it.

Add the system to bridge_d3_blacklist to prevent port pm from being used.

Reported-and-tested-by: Eric Heintzmann <heintzmann.eric@free.fr>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3229
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c3585229c12a..9d5d08a420f1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3102,6 +3102,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
+	{
+		/*
+		 * Changing power state of root port dGPU is connected fails
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
+		 */
+		.ident = "Hewlett-Packard HP Pavilion 17 Notebook PC/1972",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BOARD_NAME, "1972"),
+			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
+		},
+	},
 #endif
 	{ }
 };
-- 
2.34.1


