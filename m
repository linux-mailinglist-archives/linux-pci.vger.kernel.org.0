Return-Path: <linux-pci+bounces-6604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7206A8AFFB3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 05:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971401C228A3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 03:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902E13340B;
	Wed, 24 Apr 2024 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gIWjpBy1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C6126F09;
	Wed, 24 Apr 2024 03:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929634; cv=fail; b=J5Dg5ntyVPan3IeMzmMGFy5s2U7SJEWVa9YPMf3HtSmkVxgHT4o30H9kfZghRbIdrrMqWtKozaaRPpseLxeijZXJ8Fm1RSGR5GINP+4C/iYbOb4uKkfucqREoqPwBFH6DOdhqq7yJsI93r7rx5FbvfjJegQ7fmnU/nsE4APcPps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929634; c=relaxed/simple;
	bh=ClWCAW7dTZiDhZLE9lTqO+JJ6ZnGo2kfwsAJGrMySTg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IBdRuZ/Im8We9rD3uA/6ZtnQHQrfFfntDGetN0BINatIe3fQuUJR4zWbo7L6kYAd+toRPLI6zHeGw2VzCg4qurMhuQgiG1FvpgKY4F9zAmXZhWeapBp6NBsTgqDtVEbBCuBZaJYUp5/Bu1ECgTmgHSBikj3jlsZWIQLe4ShkL3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gIWjpBy1; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jos5wjv9AywGSlvhoD2WbEjcxzj2BqqNVqqCUCxE2sQgdnHso6M9LUHGgSB+gZa1y0kTrfODo2x91fTNzUyida6DKFMHt6MLucWO41QDsFtNWAEWh35Aupz5q/OHjivEOVff9L4eTBYs+eCBXeKQLDuJkJzO+HULOop9uZleQ0XZDETHQSRDIUZpgLiSma/IwUJNZ0buUJibA7gUCT19eH2NIw9D7Mc6brPBixoibjMLYp7WwPlHD/GN9UHothjjttUu/ur25FlSOYj3PQ6hLOUxD2BE6kKh9SJ/j5K6f86WFpTgAhdOF+dfLvOAfmJkR9lccxFEFZ2OlZUwlHAGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ajs2/lDeu4Uycbb8SUbQ599eZbqKCyzPjeSSfbN7sc=;
 b=a17Yn5H9OrGVgDTUoSn71ZhiW+xy3GC2MQFuO9gW6jYy0hq5zkjVolJIS9Ms+pAzG54yySbGpVI1N9boJJHG77jdsxDnLat2nTjDZLxMRoMy/HyrjFNzEeF8SlnKnaXOMxjtcVL7uJ6w7CP86NAEiSErDxEx/dwIJJy6wxdoUESikeZJXCiOQVgyTdiyovd/bkb+njJqyEo2extnzj30S6fwokljEFmXGE1551S4RdnCzQxs51wCTIRQsKNz9e4OBusiWxJXXcdFXFM5Fh1EIy/ewt7W2Wktf8bH3vfyPxatJVV1FsvG5HPUPfvByPdjD8TLUn+hInGEhi2WiWZGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ajs2/lDeu4Uycbb8SUbQ599eZbqKCyzPjeSSfbN7sc=;
 b=gIWjpBy1UaoYovbNQ4d/+35+LXbzjsk4/q2sDVw6RgPQP8xUeL8jwwKc7psGCBBSwsG1f2U+Aim6Kg7jLnIBIR/7SWOUXkqc3vih5kcJ1KEAFm+Gys125aDrbsgp7rssP4mswXJLKUiHeps7UM7/ZqCk18MyHhi2gzQhdJzbXpc=
Received: from MN2PR20CA0035.namprd20.prod.outlook.com (2603:10b6:208:e8::48)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 03:33:49 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::c0) by MN2PR20CA0035.outlook.office365.com
 (2603:10b6:208:e8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Wed, 24 Apr 2024 03:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 03:33:49 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 22:33:48 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Bowman Terry <terry.bowman@amd.com>, Hagan Billy <billy.hagan@amd.com>,
	"Simon Guinot" <simon.guinot@seagate.com>, "Maciej W . Rozycki"
	<macro@orcam.me.uk>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH] PCI: pciehp: Clear LBMS on hot-remove to prevent link speed reduction
Date: Wed, 24 Apr 2024 03:33:39 +0000
Message-ID: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 300bf8e6-24b6-483d-a02a-08dc640f5afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9jBMOP5gplxSgtmsgJfHSFpRaybh6bJcDZD57RwhRG+PiwZbkp48Q/34m423?=
 =?us-ascii?Q?tes/k1hbgsnlxBWp5WvSn8qxLTpalRGIMy2CMYrvzEWgq7xrHUqtn3PSNNno?=
 =?us-ascii?Q?yXXtVv2UV7V6G6li+p0GaC3VT/pPV76++DaEiy72PdgClUbOymB/DMqwYts3?=
 =?us-ascii?Q?i4u5MptBGwfW6Kp5Nul3kH5Hf0mVG+65X+srjBShN9gqzyAoqCkw8TKjCJY1?=
 =?us-ascii?Q?HyOyM9dDGpisrJGPQwwDFTWwYf8GT/gXHkYiZ0KvGI9ThfV0fNSPe1AtbVDK?=
 =?us-ascii?Q?UJz4WYNMs+aynBiqTIGaMcRfJvg3WiwTopCeaPdq4hFFvfKGTUyQ2zNi8O1x?=
 =?us-ascii?Q?E2O3pEe+0szFwRtAwcwaXVvywCLNafysTGevzUli1/V0v8jIoHbwjOpBZaPI?=
 =?us-ascii?Q?wqGMXUT19cZ7AUB7bhWJ3nokksZxBvca8q2DcaSOIsBxIr5KYzk91qpfZfCj?=
 =?us-ascii?Q?caGX2Hy9FE0MrgdFtkxHA5Sc+90Z4l/rDh0C1TRiYfd1Okfu54V5aVabT+HB?=
 =?us-ascii?Q?cFUVkIwKqO5QdQ9CzRsTPPda/JyK15Dr36GfUA6s4x5vGPty6vlw8jJXwe7A?=
 =?us-ascii?Q?8i0git3KAel8eRWedyX1x7sa3hb+O0kh/GXYLN91OacT6a/h7ayT8szofV4k?=
 =?us-ascii?Q?lamhmcX45MYy542axbqXipCZTbOVwd6KrKwlBtUWmx6ZmQuBpFm6KToZo0db?=
 =?us-ascii?Q?JkjrwqEsz6P0d+9sNONAVLsISlCik9JrVZO13py95hH0nDR2nhDsUaNWz4Fj?=
 =?us-ascii?Q?xyyedFNdwD7hGPoGshDYZotKH/pt9O8xF2klgK3fWnF1EUsOWWZ7HyC127X7?=
 =?us-ascii?Q?RENSTlYvn0r8JQfmWrdn82MayXOLjNtZwrIQhzG9zzjkwwQ2fqE7adrD8tz4?=
 =?us-ascii?Q?cpD/T5mU7XSW6v62hEg9KD5OBzU7fTPfDidu1pqZmqmuvL74Ae+J2nY3IblT?=
 =?us-ascii?Q?KC6WBkMwwEDw/jbFViSMdi0Tf/fIbe93IadY5T0zhXqGSMYO2O7s+j+BoLbw?=
 =?us-ascii?Q?7Ne64ex4XCNfGfPN9XqqOiT7yuuHb33GkwSoMBMOiLUa/w7oi0ECclbQAk1Y?=
 =?us-ascii?Q?/aX/sr1D8lPvfmkvOHktUmjePdlxPEqMKOzA/5hEHrTHaYoDmUKXD++Ed5gm?=
 =?us-ascii?Q?dHHPvUZL3JK+PQoVbFEXabZUjZoSFJCXNlhRPZuUDMhufUgSVDEXcMjLpTAu?=
 =?us-ascii?Q?gAH5jkGXYEC7rGLY1/BuyAa0sOg28rRid3BQhAoaNrxOJGsGhozEu7oPplid?=
 =?us-ascii?Q?h+qfDvbJUBzH5nKd6scaRM2Y8HujkQRGCw/rAK6lN8K95oDGICqJW4ZouS1Z?=
 =?us-ascii?Q?rJ+pmWoIeoV6iSiYxyQu4p5VBMmjXjJv2ui7lew378EwATFyVoqItEcdJvuf?=
 =?us-ascii?Q?hIRASYbQJS6wZ5jBBh7U4bIMhQ22?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 03:33:49.3222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300bf8e6-24b6-483d-a02a-08dc640f5afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove event.

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

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
1. Should be based on top of fixes for link retrain status in
pcie_wait_for_link_delay()
https://patchwork.kernel.org/project/linux-pci/list/?series=824858
https://lore.kernel.org/linux-pci/53b2239b-4a23-a948-a422-4005cbf76148@linux.intel.com/

Without the fixes patch output would be:
	pcieport 0000:20:01.1: pciehp: Slot(59): Link Down
	pcieport 0000:20:01.1: pciehp: Slot(59): Card present
	pcieport 0000:20:01.1: broken device, retraining non-functional downstream link at 2.5GT/s
	pcieport 0000:20:01.1: retraining failed
	pcieport 0000:20:01.1: pciehp: Slot(59): No device found.

2. I initially attempted to wait for both events PDSC and DLLSC to happen
and then turn on the slot.
Similar to: https://lore.kernel.org/lkml/20190205210701.25387-1-mr.nuke.me@gmail.com/
but before turning on the slot.

Something like:
-		ctrl->state = POWERON_STATE;
-		mutex_unlock(&ctrl->state_lock);
-		if (present)
+		if (present && link_active) {
+			ctrl->state = POWERON_STATE;
+			mutex_unlock(&ctrl->state_lock);
			ctrl_info(ctrl, "Slot(%s): Card present\n",
				  slot_name(ctrl));
-		if (link_active)
			ctrl_info(ctrl, "Slot(%s): Link Up\n",
				  slot_name(ctrl));
-		ctrl->request_result = pciehp_enable_slot(ctrl);
-		break;
+			ctrl->request_result = pciehp_enable_slot(ctrl);
+			break;
+		}
+		else {
+			mutex_unlock(&ctrl->state_lock);
+			break;
+		}

This would also avoid printing the lines below on a remove event.
pcieport 0000:20:01.1: pciehp: Slot(59): Card present
pcieport 0000:20:01.1: pciehp: Slot(59): No link

I understand this would likely be not applicable in places where broken
devices hardwire PDS to zero and PDSC would never happen. But I'm open to
making changes if this is more applicable. Because, SW cannot directly
track the interference of HW in attempting link retrain and setting LBMS.

3. I tried introducing delay similar to pcie_wait_for_presence() but I
was not successful in picking the right numbers. Hence hit with the same
link speed drop.

4. For some reason I was unable to clear LBMS with:
	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
				   PCI_EXP_LNKSTA_LBMS);
---
 drivers/pci/hotplug/pciehp_pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..9155fdfd1d37 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -92,7 +92,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 {
 	struct pci_dev *dev, *temp;
 	struct pci_bus *parent = ctrl->pcie->port->subordinate;
-	u16 command;
+	u16 command, lnksta;
 
 	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
@@ -134,4 +134,10 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	}
 
 	pci_unlock_rescan_remove();
+
+	/* Clear LBMS on removal */
+	pcie_capability_read_word(ctrl->pcie->port, PCI_EXP_LNKSTA, &lnksta);
+	if (lnksta & PCI_EXP_LNKSTA_LBMS)
+		pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
+					   PCI_EXP_LNKSTA_LBMS);
 }
-- 
2.17.1


