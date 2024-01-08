Return-Path: <linux-pci+bounces-1810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E670826ED7
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 13:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F4C283776
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A808153E3D;
	Mon,  8 Jan 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="skJ86KYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486653E22;
	Mon,  8 Jan 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bse6gIm34R0I+xa5kzn7ET8iwYTaUMp/qwZ3cwj7qCBcB+gBcSKgw9yGxsvNlBbHlTrcnbCyh9x0wFK2bxjo96X40YhempJSAUXarXsnw5z72chMkYG2M5eqROK13rq7VS3k798kstcSClq9qDpvxjqxsvE1L+uDcsLMPJS5EfjVuLWNFEfoltGigei8G19VQm/lt4bD4K3lTfq+cPl9cLCIgVAI8aqX7UvO4ehLw9Pghy69vLziYGTGH3PCsWuXJOAlD0lcDHGnDWoOobi9wM/mhl1hBW3GY3NgWiKGiZ5o4Erux9qxxF4HZENZ1rS0wqj7ZwGKptbrOuNE9T+eCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txhzsa44PZzuAv2oLyXAlhcYvRxn6oh6UuCVoQ7EteU=;
 b=dLsa955aHCJbkM7ljsQe5v9L1Ze8hOpMwkOTeCJm3WOp6GJtySw7UfX+jbBh+j0KxSzbIs7Us6oKVOGXcJokXXoh/Pns7s8YW541/iTvGaFwP6IBJn56J75XpyqRKITepoZznLBSxt+2FZ5kzjpfzVnoByUOJHYUfLXDIWveTlaGBJq9YNoW786p54OdpwOMPz+fcD2+3uRUqAi+YvY9pWOWwjBS6N9ebrqc8bdoWwbj+f66wn0tggc5LFVLgXqgmT1/VDCwOgGpVkGp2DOJvh/EDdaAO1cQdOs2nCowev92oUZTjyYJrtewK7CJxpkO01gQB1gZNPwem2zeVf7KjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txhzsa44PZzuAv2oLyXAlhcYvRxn6oh6UuCVoQ7EteU=;
 b=skJ86KYN+AnIzxuxvCdKdOpwsksASeDXGZkAUqe//YrssOJF3n9z1RC5hoCckZlwtLTUypkq9csY0vzGT/LiYzrEgfZBnphzqqY+MEft1QssZ8LD45cNfsn08PJYqaRqSsmW3QYfMGJb6K+gkP5JtUG96WA428AGFbSjr9K0oiHcLJpGxLJfqicLHLuY6lWX4NinIuqkT6OEFM0xE3fMaHcU3IInefm0rHTJDw4KGphiHumKuzruPOro0JCRch7Oac5DWzXkPaHrOs30bQO+u5FW09fUdKnbpL7dGDfOk6VaY0Nj64KATC4fHewNlhhZYKac5M2jnd9q4aLwvJsrsA==
Received: from DM6PR02CA0065.namprd02.prod.outlook.com (2603:10b6:5:177::42)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 12:43:11 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::bb) by DM6PR02CA0065.outlook.office365.com
 (2603:10b6:5:177::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 12:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 12:43:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 04:42:55 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 04:42:55 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 04:42:50 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <macro@orcam.me.uk>, <ajayagarwal@google.com>,
	<ilpo.jarvinen@linux.intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <hkallweit1@gmail.com>,
	<michael.a.bottini@linux.intel.com>, <johan+linaro@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3] PCI/ASPM: Update saved buffers with latest ASPM
Date: Mon, 8 Jan 2024 18:12:48 +0530
Message-ID: <20240108124248.1552420-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103103501.2428197-1-vidyas@nvidia.com>
References: <20240103103501.2428197-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW3PR12MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: c61fc702-40c7-463f-8c4b-08dc10475f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iIRRfiD7UkcFkct26tGguS+dricf6FKaDVrpPpXbrMMWhnu5O/zA/PVFF6Qr6Z30ceE56AwRUWZhZl7+dUCbq6McIbIycUdXHCwnUvmbMURswKswk0/dR9eqlVewnmk1j0ZSx2dCkc+JfeD1MMMh/5rRGt0h2mAITEJ/bgB7mYJD4J8D/lo4Uy0GpUtA5eSusZBAgcGnKOhi8LTy0+OYKSyQc6cacevEuj4yk7dkQeC/BuWJL5YIpK5Dq5KsreFM1YH/y7kl0YbZmLnWjbRnsfX8JRifAGBwushVUO2QgBxXWkkjPHM8eMRpPhNkxuzVR3khXpEj5cswK3fRhngMWwAUmbvpH7+vROg32Dqnwxm50sifyYCAe8XpZbwC3C93i96/sATNu6060BBJUsIjJYHTlV95z090VUOHSRa9NcaRpoYYPijo9e9MFx9gnUO9iIOt2i/ngTOqVfC5S793c8mYY67DW73uXTYUUwvmDZo44rK1oBCd7O5lwYi53xKpLPzmYw2NUEqAi2UYRoLBQ97nOPP08TyMsdTOwwPcDmWUd4PGqj4AIh4QfaXv2e6lCQckkNl2F62lfWJimBmz+6ME4WIya04AKmx4OAHWg1gMDoWszWdU2gISWQdhlV9/webjeTBmwpMYT2AwIizgkkPdRH5S8afOUvWwsjxrNk6jE7Rj4MoeR0nFJrNh9hoVleTwQ1daLkpsLsPW9ajapb23+kiwXOr+0Ser/FZGdcETOXrlfrAKYrv1XVEqfde/DFfZ+sIZeQ8KKM8/CRVHqw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(26005)(2616005)(1076003)(426003)(336012)(478600001)(7696005)(82740400003)(36860700001)(86362001)(36756003)(356005)(7636003)(2906002)(15650500001)(5660300002)(7416002)(41300700001)(47076005)(83380400001)(110136005)(70206006)(54906003)(316002)(70586007)(4326008)(8936002)(8676002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 12:43:10.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61fc702-40c7-463f-8c4b-08dc10475f7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556

Many PCIe device drivers save the configuration state of their respective
devices during probe and restore the same when their 'slot_reset' hook
is called through PCIe Error Recovery Handler.

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
V3:
* Addressed sathyanarayanan.kuppuswamy's review comments

V2:
* Rebased on top of the tree code
* Addressed Bjorn's review comments

 drivers/pci/pcie/aspm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 67b13f26ba7c..1b4f03044ce2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -138,16 +138,34 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
 	return 0;
 }
 
+static void pci_save_aspm_state(struct pci_dev *dev)
+{
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
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);
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
 
@@ -767,6 +785,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
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


