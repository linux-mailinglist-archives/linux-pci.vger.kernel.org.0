Return-Path: <linux-pci+bounces-2149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1082DAB7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 14:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE118280E8F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164AD17550;
	Mon, 15 Jan 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZA5ACCj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932821754C;
	Mon, 15 Jan 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFnP9jWqKX+/rGz+HfT/EQt5AMb3ZvM1CAt4m/fGgp0g7lqXZsLQJBQw3xDPNhODq+j8fhxFqSMhUn/+WgmI0MV4FHm39pBVX4SLYYtxZ1d2xCuY2BcnMDG1lMeGpzmyWsGcWpm8iCvvU5AhKjyHC9LWD+wWcvkj14zp2JHXx1K03BMLWh3XF1PDhPiuGmJWVAFmB1skctyLzBiJVsEn/J7IBclpZ6y+PYC9r/sj8wswx4AvoNQfQEswGZViVFkXvdTiTERcWonRGsFoJbQGzx9j0nitdXnfc8R5EUdKyq1+s6ZKWrVI+1BlAts34ChupuC1Kqcrx1cmOt4eKJ99lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK34ZKqKDlUqCk2ZpO9Fwx6cd/5UWQ6FI6dB+/GvFzA=;
 b=K03ceaTPiwqLQAixohEUbeqe/E21+eo417Po+OJ4WEae3mrn/0QhOvy8KWetAdHTD6jCFTNvtSAn3Et5QrnXZIiuscxSubLe7+/4VI8SRSVvpV4ZQS7ngtn0zci4l5UN2+HwCxUriN4hRZQQXmEbAZrWIkN4yqcQwdFY5tmGl8/t/U1/o+NZRtgD8gNjhYEfd7OwzqbEXoEC9SVAsuhqEBCNjm9zGDbrYDZZEmLiW55hdzDGgsIBI+C2PUeG5aVsd0GVKisleh3nmYCzKfQL884McXd0A0meiw1TZD3A2NCWgS1hhPx2JDFHS450sLOBu1bTSq/9Xb8QaUmH+A8yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK34ZKqKDlUqCk2ZpO9Fwx6cd/5UWQ6FI6dB+/GvFzA=;
 b=JZA5ACCjSPup9Gd834hkX+Tammlx7uXFVF0delJr4QMouFlySl84JsHojNvCqD8n09XCe20hb3DUn0QJgEi0w6TzHFg8Y997jGcs5UhA861iirk28qcXhK6aYe468gJ45j+K0XwoiAb5Ss2z4LOGpNSp1NkbvykGSabPcyKS62RawTS81cBUQLaMAmhYTiYQf4raHklJqScrmlfrYUIIfBUYO0cP8Y0NCm2/Or40ns7IyeAnk3pqJFb1iKGQRxz+QXhmi6r7Ob3JgOJTPEiRK+CDuwJK+0MrxXUvqmgpJjyE9RanFAwPVQcn3fwgId17pFevbvqf/7vvxir0wuTaSw==
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 13:57:00 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::c) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 13:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 13:57:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Jan
 2024 05:56:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 15 Jan 2024 05:56:55 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 15 Jan 2024 05:56:52 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rdunlap@infradead.org>,
	<ilpo.jarvinen@linux.intel.com>, <tglx@linutronix.de>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sdonthineni@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V4] PCI/MSI: Fix MSI hwirq truncation
Date: Mon, 15 Jan 2024 19:26:49 +0530
Message-ID: <20240115135649.708536-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111052814.713016-1-vidyas@nvidia.com>
References: <20240111052814.713016-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: e43b50c1-718b-4840-2e40-08dc15d1d86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uA++PuQQ126KySYPf1STiDarV3NLMVsXJJb6VeQP5cgyleRUx1+GqgYqAgnIpDpVtWk33lRR+f6miuG55d2Saqi9TPB8kGHkCPd8gdHWVxZkG0Vp/mAl9byXdDmdr2k9E1zeNmEqUzkBNs0HnGOTbPfqiUNiy0nAt4sgaeineRH4WOcGUbQq9662BShJwHE/+ufvHvll6YyxFzyrwkbe+CD1X5f6MSCmB0Mnso3k3egJtoOHz6z1EzThkF2hQW9lHYjcxGbdx/CrLZQ6M/3OfuO/JmBV+NTCSlT1mgK3LGSex3hsLGq7Fb/iP3cFyrBeYxT9qo14ycw6TTQYNG08KHaEnGQaTzhkmOemj3Um78/zOiTOYPwR08uSVhqmel6EaF17pX57mmlVsTTqrEs/2A8bSU+dj1VzQlV8krH7vHFpq0lb+zpKQVCVgf7X2ADbqV/BqG4IJ+Ppj1odIQ5W9zmaFRSCAUOglB28rWEMFK4tW9iWuX5dXyR24aScYIkMDTf8C/9A3xEutuDu4Iia2I/Mmruje2EeJ8PbanN0nuWecHS8bYATTSzn3zo9Io/i0rBmjxQahYWiKROMMVc1ICSQQVSTpteOz3lNT7utwzGu4J69rPBSEa7bDOFVTo2p+qeOYddKJpzkff3cl+FgFAt24SHFvRvz41ATxgawtpBNTRGqlzecAyFdu04EFFcGo/vgWm/oprAthB62x/1flnhpxPtOyt8bzN76rP5XgLVEV4i1jfwKsu0dgzs/JIET
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(478600001)(6666004)(7696005)(426003)(336012)(26005)(1076003)(2616005)(2906002)(5660300002)(110136005)(70586007)(70206006)(54906003)(316002)(8936002)(4326008)(8676002)(36756003)(86362001)(36860700001)(83380400001)(41300700001)(47076005)(82740400003)(7636003)(356005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 13:57:00.2434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43b50c1-718b-4840-2e40-08dc15d1d86e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

While calculating the hwirq number for an MSI interrupt, the higher
bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
number gets truncated because of the shifted value casting to return
type of pci_domain_nr() which is 'int'. This for example is resulting
in same hwirq number for devices 0019:00:00.0 and 0039:00:00.0.

So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
it to calculate hwirq number. Please note that this fixes the issue only
on 64-bit systems and doesn't change the behavior in 32-bit systems i.e.
the 32-bit systems continue to have the issue. Since the issue surfaces
only if there are too many PCIe controllers in the system which usually
is the case in modern server systems and they don't tend to run 32-bit
kernels.

Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Added extra information in the change log about the impact of this patch
  in a 32-bit system as suggested by Thomas

V3:
* Addressed review comments from Thomas Gleixner
* Added Tested-By: Shanker Donthineni <sdonthineni@nvidia.com>

V2:
* Added Fixes tag

 drivers/pci/msi/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c8be056c248d..cfd84a899c82 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 
 	return (irq_hw_number_t)desc->msi_index |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
-- 
2.25.1


