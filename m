Return-Path: <linux-pci+bounces-1621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBA822B76
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 11:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15562B21987
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B9118C10;
	Wed,  3 Jan 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aB53Y5wQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54BB18B1D;
	Wed,  3 Jan 2024 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etFb5U9zd8lNXVIYKS3U43QRdf69d25Xe31LHNkMHZpjqrUV4x8KYW0+dgIHYTwVA/DuvrxVvCKPKRSnvPCMckc6dc1HvV+YwlVCpB8XFVpQL4yStkq9Z+ZCO88Xz5LWTNgP68sNHQ0oouEVWnVO05f/7ecKmA7NHi4QPt2oXVV9urVz+x42NF4Y+Cj4scivHCjOlroxovAd7poNzWkftEXtOgxVa0F5UXkxmOoDNq3r1Ht04QuWFoiC4oxHBAI5m4hsZZN6oEQDAtM6ldEJevkbKaV6+4HXPbS7OyCPwyXpILoP2GMv/H8yCQx85UovKYOWzms9P34sOYubtBT5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UciI90ypQgNLEcM6Y80A5YO5QoGG0T/C5M6DP9jdkc=;
 b=RW5B+osY3i3yNhjAL1MZyIwKXJ/0SsF9sFglDXGGj9gWgFgn9wBBB0CMWi7ygbpMARquBWbWsoX0+y+8DP5MMPe1ECO8kATwYTX6vfQhXzL6hZ6L+gg8m+24NZ6vblMI8aglkjOmZGCPx8bJdD47ujuM/F354chA2n+kvROFhULPB2Sop95MCS3CnRDaeF+SyTh2kVEAInaMO0/mwd0HgpO3i83PBji07gVvMkTJzaQp9iuQoOyOsF1kXZtjpwdjL8J0Ij7E8XmoHRFVoyXrvvVlkZ6UnSbmoI3uG82m7Qup1YLCXZRofd8EvToLCWasGFibuwtK5uely4aWbwA5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UciI90ypQgNLEcM6Y80A5YO5QoGG0T/C5M6DP9jdkc=;
 b=aB53Y5wQCskNQzvnqQ2PRowGZyMIM9ejterKGQu900ykEmAJS7v29LZm64Oqf1aDq/U7F0lhAJCyu8C2aPRQh7d2T0utgxvxE7zLXutKi8YHyg7SMPee968CEbuneNYT/gZQ6mGZ2kBf5NuuMruwShjYXGcGRN3uic5BuHoqrl6zqh2ZeJUKSKGzrKoAoWpZkjjottKTl1NwHOhE3uknvpJlVCNjF1SgjytJEmTuQgynmXirKhuD5mwEu+lPldtdMQg6FmK/sv9dNpeRYxnvMH4FR0c0HHLyA6JSQEtrswrx1yZcNFtp1Z6ypy8kdcijaaRkRpq2s42qWKbMJv5jDQ==
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 10:35:18 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::38) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.5 via Frontend
 Transport; Wed, 3 Jan 2024 10:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 10:35:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 02:35:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 02:35:08 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 3 Jan 2024 02:35:05 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<rafael.j.wysocki@intel.com>, <kai.heng.feng@canonical.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI/ASPM: Update saved buffers with latest ASPM
Date: Wed, 3 Jan 2024 16:05:01 +0530
Message-ID: <20240103103501.2428197-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125133830.20620-1-vidyas@nvidia.com>
References: <20230125133830.20620-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 099ed0b0-7969-4e7f-8ab2-08dc0c47adf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QA43OmhgRPlfxZiZ2tEl8OtCEShu6/OOYPSO7O9VSfWqYLLgd6mQFo+8M2nn2gzBa3DVUtfxtPYsXOMpAqwogizievbQq0ijq8Th9COT1/WjZqxUN5Wo/A1t53K7MLrTuA+kEJp9PphRIgkyQRs0ilMm+nCRePP2KGDm0wxWX1YXB+uYH6qCYKBIVL7iGQapXm+81cPHGErDHA5/g3gDBRGq0zUfDz5dqztgurOTpbdW6gdGEv28snRbp+3xX5tfUBXVev31tP2CD/3Q0IROou5n7M6Gjca2ywDonswBRTCgBUtQW8GHACz2Hp/P9XzNkkJOr+MDDSpP2Dbfoh/879GGikX63IVtakRZLmyFO5+kz5eFS0ilh4Rxe2Hc/J7GdRu4HRE4fSJdp2b3RxzEceWO17iXzx2SN6FAvWxPlaXg9Rp3sVLzWrDsIfXAM5UstM4+jvJ4g2S2T8cIsMyGVJ7AwbgVVfxOlx4GPf76LVPaho8+Gku9XyRFPSJJobz6OxgRaY9afTsO4IVEIiPdpDI37B1WfumLyMQVqlTghW+wuB6KTfGIeJ0hwxhfnovgWEF9wqrreIH9K65hguj07ePjMsEzaX2XJIPJQs812mLmXFmZqw3Wma+WdZ9S1CFt6qU9LLiPAUdErv5ueCu/Tar1Q7qzQK313imp1w7HtCkM4mKxPmIgr8FYa8U7lkgoRTsOIEuKmyzKAWL/lguy4jPuJan22nKiKvBpEwMJaPRd+BWbxzoaQi4sIA04KvZ++AeY9qBVq4qVOleTrxO8Og==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(426003)(7636003)(1076003)(26005)(336012)(2616005)(356005)(36860700001)(70586007)(82740400003)(83380400001)(70206006)(47076005)(110136005)(36756003)(316002)(478600001)(54906003)(86362001)(5660300002)(2906002)(15650500001)(8676002)(8936002)(4326008)(40480700001)(40460700003)(7696005)(6666004)(41300700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:35:17.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 099ed0b0-7969-4e7f-8ab2-08dc0c47adf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

Many PCIe device drivers save the configuration state of their respective
devices during probe and restore the same when their 'slot_reset' hook
is called through PCIe Error Recovery System.

If the system has a change in ASPM policy after the driver's probe is
called and before error event occurred, 'slot_reset' hook restores the
PCIe configuration state to what it was at the time of probe but not with
what it was just before the occurrence of the error event.
This effectively leads to a mismatch in the ASPM configuration between
the device and its upstream parent device.

Update the saved configuration state of the device with the latest info
whenever there is a change w.r.t ASPM policy.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Rebased on top of the tree code
* Addressed Bjorn's review comments

 drivers/pci/pcie/aspm.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 67b13f26ba7c..d247cabb5e4c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -138,16 +138,36 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 	return 0;
 }
 
+static void pci_save_aspm_state(struct pci_dev *dev)
+{
+	int i = 0;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
+	if (!save_state)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	i++;
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
+}
+
 static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 {
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
 	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
 
-	list_for_each_entry(child, &linkbus->devices, bus_list)
+	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_CLKREQ_EN,
 						   val);
+		pci_save_aspm_state(child);
+	}
 	link->clkpm_enabled = !!enable;
 }
 
@@ -767,6 +787,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		pcie_config_aspm_dev(parent, upstream);
 
 	link->aspm_enabled = state;
+
+	/* Update latest ASPM configuration in saved context */
+	pci_save_aspm_state(link->downstream);
+	pci_save_aspm_state(parent);
 }
 
 static void pcie_config_aspm_path(struct pcie_link_state *link)
-- 
2.25.1


