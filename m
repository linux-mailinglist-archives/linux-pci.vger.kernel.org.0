Return-Path: <linux-pci+bounces-7584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74928C7DCE
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201EF1F21784
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24114A612;
	Thu, 16 May 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nbXAqneo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC915CB;
	Thu, 16 May 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892484; cv=fail; b=FSVV7g5AaRlUaBDhJsjiLrcAOTxUiRorDS7lBD+EE+w3jW3FRa7lJHTfLOR4w38rV3zQUT65BD/6ByBJ+JhnS8bZAagsgi7agZANqj+pTqYWkBayTrlVg0om6lLnDJ7Pz9NjLbcXg4bfljOmhnnJJLVL7eatgzKbU+8vp/inMlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892484; c=relaxed/simple;
	bh=C82fyrvn+D4OEc5UyWDvEzid7OtZjFVsOeyV45hviow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfjZx901cHejqVCGAuBYw1Wrx16NxhjyvDaogNS+DRbmiSX2Gkfcl9at+6fEl99lgfwOsGqyqxAaBNWMAtCFGUgS0hbzctPGCDN3i1URMXiEDDkgMYOsXDVWTY6YRr+VHZfMWWlyQavnMoZa6dSOI9PV35fgztK01IDEPjzt68Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nbXAqneo; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocbRBdw+imcOiNGWtAzQk16wQWcAZLRna638K6bsPbmAHuRCQRH11R+8rMsPZKqmg4Msyif9XdI/dZPrILGClkFo96Oj4Ly5KTWfJAYuUhs4hNmb69qQhKRQhxRL1AHRd871KrZAdNMjznftnZECLi/p647a+DZcj4zCVh9DEOnm9OsgTjbraKmKxsPywHkeFFyGt4GsQFpD5XsHPSm7Seuc5cYvZdNZV2AdJqQn2tUNgj4lJguskP9IDyMNu9fxHskdRbCxbilDmVozYrC8yQWCFiMHBveSPOX0SsmUKrtcxsLFXayUyki/NgmyivgPd0FEBg8lpAyD4/CEAXHXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkmJ9RjbgrFrsLjOs3qq95zvSQPfgll6u00AZb5OAYE=;
 b=ZHNglu8kjZWrga2JaFMuXfDgIru444onVICcu13ResC6c0MTjZoE4NtzaHa2lU1LykhbgWEFpNRiJuD1qLZwEqR7YANosBLQuFVHlwHy67shU+nZ9nDHQZYDft7BU7lsDhz2/FHIwqVCU1+wsy6KoaIZSn7QODz9t2sjz/EpqfsBOZFs8NLwZ64gwiW2mP+n31hNHpiVy2bx8F8UwHLiZ/JvTYt0EFmlnXOZwYIZF6fkXrBJHxdnCtpDeTigdU9sWxrjwWgNLDwQhfP3ESJNvOHvykXjukpf7Pn5GIcFcr7g7ErHolOooMkl4svUGfyNzNL5i906cxpLwV1msLSqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkmJ9RjbgrFrsLjOs3qq95zvSQPfgll6u00AZb5OAYE=;
 b=nbXAqneoMhVB8UsvcPwT43EIUC94OH4V3Cn2ImEAs1yhOqYFb3RdblYS9fht5JXzL/WV/iEUx2K5MhZtKYLbww4AbrYgYcYy+k/9lp9pxmgzm54loQsxDpyfFO+qEDWwcbzwpl0wgmcSVEi9dtWFTSw0hpfTfAbkPhAjz4ROC9c=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 20:48:00 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::5b) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Thu, 16 May 2024 20:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 20:47:59 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 15:47:58 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
	"Simon Guinot" <simon.guinot@seagate.com>, "Maciej W . Rozycki"
	<macro@orcam.me.uk>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link speed reduction
Date: Thu, 16 May 2024 20:47:48 +0000
Message-ID: <20240516204748.204992-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8e12c6-c537-4877-e4ea-08dc75e978c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HfYeNyYSAQ7RzlJZIeNmbiRI98fCjzL/F5NtyWrlOqYDFL/4ZUP6k9zGSy9U?=
 =?us-ascii?Q?lurbXjdh7JFSugzM44Ate1MLt+QAApkQkKyVAkGVXVcUMSLYo5HtjJHDkRz1?=
 =?us-ascii?Q?Z0I+w+hel8q1Zb9i3ExeOPIpGsP38N/QW2alE6yDg2iO58GTx9/B+RDm3g2H?=
 =?us-ascii?Q?uHkkt9qvNxFNauC7lQAINvEdoLavJsMYX6ifmr4CfucE62gL5XlxRSPBqLQH?=
 =?us-ascii?Q?ZAGmDXrC3WUidXCbYTEqOf/8RCFMH4lDnqECHBO7mnN+2IZV0W2APsuDvbB5?=
 =?us-ascii?Q?jkRYljaRb6sMPMuYD6HoPcgK0SHbfIapIddb6PiMbWgb8V/k3SL3QK6C9+pj?=
 =?us-ascii?Q?ha+seC3jafUlpywaXKaHHGtBxJ7aknHTi0/gsrjquIV4Kbg1L4rZwQKUe/lN?=
 =?us-ascii?Q?D7UoMEJkeZlZP4Iqb2tl3clTgDBtNTU/FjngNEPF/d3zqkEJFx6/NopYfnad?=
 =?us-ascii?Q?NdUvXRswLP7hr2VTHSSmihw9iKrt4MPk3yb227ITRD8YJbmL1YmrpVINmDU+?=
 =?us-ascii?Q?O49kp7gHdyiBcl91XFrB2Mi+pircUv96wAZ5n5UR4tx0mapovKVd8fzODQ8+?=
 =?us-ascii?Q?ibqEd3Edj5K8ij01YYwCrmkLyE4gR/7ANNPMLNmLF20lZh5s0jKej5HFn2W7?=
 =?us-ascii?Q?FhJxUG92aWEiBOXNwYHz6Xz8wFbX9WULBe0SUGZdfLjMlAYosGTH0+NCsJIC?=
 =?us-ascii?Q?cMycjARHB0Z09UcZGz5KpXWAl6FPDZnk94mqt0yMJC9hk7MsJFzLTtO/Xegc?=
 =?us-ascii?Q?6V9rEsDU71HWiRv3RZYUkNd7EywUPkArYFGWE1ExxndBi/Uc4p6p7XkK0yV+?=
 =?us-ascii?Q?wiO0s8aC8nzUrPhMKwYnS50uIz3h7k/hG8pJ5ujg1HsGbgssZrn5dp4Bps/U?=
 =?us-ascii?Q?1U6LCdnZ9xNugxMrnchuFFbJSZxU16riWywIByZ+2N9XstlmmpgTdHbazsfd?=
 =?us-ascii?Q?wnjgiEMxYIrV/H3MswrHYrZ5GsureyTVuLA7zB1krUYAyKfN6JZE2h3jVsba?=
 =?us-ascii?Q?Ru75SZQYSibsMcnCVsjaP3neU/v7Ax1XWtmDwoiZCQm3zyDpeCUHOrRBUlV+?=
 =?us-ascii?Q?yvRy6xI9/IGk2307eWi1lq5zPj8e1wWCY31EQ7OqvEwqLhWD0fhBZ5o/5sQ5?=
 =?us-ascii?Q?/8GdVLmfcbRjzwVGPgSc83emFFLfw4eYK3XF8Xm1l2Die7FH9TWuODiZT/fc?=
 =?us-ascii?Q?cqZ2c8cBoj16WFIJoueka3MdvdiCfwNDt9jou2mv7ZHC6gUR+/1eLdmfWy41?=
 =?us-ascii?Q?yEcs0Euw5hIHZEpRYFO1n840Svt1Gj+PVM8w2eOMmsZAP8dyEklzSDHE5w0Z?=
 =?us-ascii?Q?FtE1pRvCZE/3PZzuNzlWZfSi2A0Xuxv9bV3GoLfl56nSAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 20:47:59.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8e12c6-c537-4877-e4ea-08dc75e978c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995

Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove
event.

The hot-remove event could result in target link speed reduction if LBMS
is set, due to a delay in Presence Detect State Change (PDSC) happening
after a Data Link Layer State Change event (DLLSC).

In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
PDSC can sometimes be too late and the slot could have already been
powered down just by a DLLSC event. And the delayed PDSC could falsely be
interpreted as an interrupt raised to turn the slot on. This false process
of powering the slot on, without a link forces the kernel to retrain the
link if LBMS is set, to a lower speed to restablish the link thereby
bringing down the link speeds [2].

According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
be set for an unconnected link and if set, it serves the purpose of
indicating that there is actually a device down an inactive link.
However, hardware could have already set LBMS when the device was
connected to the port i.e when the state was DL_Up or DL_Active. Some
hardwares would have even attempted retrain going into recovery mode,
just before transitioning to DL_Down.

Thus the set LBMS is never cleared and might force software to cause link
speed drops when there is no link [2].

Dmesg before:
	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
	pcieport 0000:20:01.1: retraining failed
	pcieport 0000:20:01.1: pciehp: Slot(59): No link

Dmesg after:
	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
	pcieport 0000:20:01.1: pciehp: Slot(59): No link

[1] PCI Express Base Specification Revision 6.2, Jan 25 2024.
    https://members.pcisig.com/wg/PCI-SIG/document/20590
[2] Commit a89c82249c37 ("PCI: Work around PCIe link training failures")

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link to v1:
https://lore.kernel.org/all/20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com/

v2:
	Cleared LBMS unconditionally. (Ilpo)
	Added Fixes Tag. (Lukas)
---
 drivers/pci/hotplug/pciehp_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..dae73a8932ef 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -134,4 +134,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	}
 
 	pci_unlock_rescan_remove();
+
+	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
+				   PCI_EXP_LNKSTA_LBMS);
 }
-- 
2.17.1


