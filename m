Return-Path: <linux-pci+bounces-2027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781B82A744
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 06:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A22893F4
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 05:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52C1C31;
	Thu, 11 Jan 2024 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="latpEwyV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BE1C2D;
	Thu, 11 Jan 2024 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7FXCBSu9yr9q2CxQxKaxmJ+IQBkitP1zlwhYjtTKsO2zNqpOP3Y4a9imEcwO85FXgcqaMILgtlTDwMT4UbY1Ye6TqT3cin3s8hb3CJPhGXcYosIONH48Ed3aQ7IYAjugNTbDnfGwHqpu/40rHYxhwI0LI924jKIJ8yBp9BLbXupdSOmFacebdGafzyg87vA6QsEwmht5bypwFI9pzlaFHWLj9ryQRvlkrbdn+l32PjpB+JTSTqDq2m+mCrNGG2eLrY+ztshwrHtcueXEPxYqpY3jEmLdiBH4PhAobaFAcu77J47kDxp9fbyZu+HKByyRja489avDrkOPcdKUqHMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuusK+rSHgfQHrvE/vKPF2tKIm7FMw4/PCJMHbdTp+0=;
 b=M71NpB+LZvmYt3bUgB34PvhXvytFBT0Cnt4frKwwGGh1iH87WaNb742+dx6rWTwoTLJmaH4biAsjy5hMloYxLhHYorW3QfoJA1zt+0FHEFvtXqOHnrjcxVrSsdZZblwZKqxuVQohmFlSJfBqxbasSilDcAg5fZr+zME/Exqg91/daYriHFfbLmXwdtAe0TwMludXHgBWrJbdI7Wx1GRXLsGYPbKLo3D26HyJYAoFRKubvjQ5py9qPjYqvh0u1IFeVvIe2LvGsg0TFrs8uAi/w588nSkeEgH2IYcpIgyuTjv1T9Y4bv2wWXwIxTIzgQ2sv50AZHOZHVudhc4Xln9rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuusK+rSHgfQHrvE/vKPF2tKIm7FMw4/PCJMHbdTp+0=;
 b=latpEwyVS24XYlao5qB9R6EMYntPTyy8tgnD3YWWWHmOy+ujv0If34GzDx8df3xxdW7/lY+ulK2/VJRrpIUnjIwvdTEErpNdVG9KyFKAY6zM99zB22MghrpKKeW1svzxsgBdRxnU1XN6rZ9FOtoFX1x4b5bhzpxztAOrEVLRe8vooHJz2EI4E8NhTm4Qi/xyV1Nyakt4qM5fn+IALoL7WN6QJuGxBhIrvoAr6SrRAkiqcizu/YLACHLdcYQ7IurJbna9dBAX9uWEj21j7D/OTx2d07aUNNFp1RmaZ7diqrqErq7Qrs3krC/6FMSg12TxbBIkP1MOa29it0Flk1jtsQ==
Received: from SN7PR04CA0218.namprd04.prod.outlook.com (2603:10b6:806:127::13)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Thu, 11 Jan
 2024 05:28:29 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::6f) by SN7PR04CA0218.outlook.office365.com
 (2603:10b6:806:127::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 05:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 05:28:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Jan
 2024 21:28:21 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 10 Jan 2024 21:28:20 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 10 Jan 2024 21:28:17 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rdunlap@infradead.org>,
	<ilpo.jarvinen@linux.intel.com>, <tglx@linutronix.de>,
	<jiang.liu@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sdonthineni@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V3] PCI/MSI: Fix MSI hwirq truncation
Date: Thu, 11 Jan 2024 10:58:14 +0530
Message-ID: <20240111052814.713016-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108120522.1368240-1-vidyas@nvidia.com>
References: <20240108120522.1368240-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f80660-673f-4428-4bda-08dc1266248b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PLSH3Ay39/dXf2qAWRNwE+zExJRA7hOUfZr2c9H2sn/bMSoas9a8w+nu9SMblOTxlsX0QTnmAWafUDSZTdenbcJgEPcLg2cVG0psgsmW2riR7j0g43QUbzPZU/Gvx3tgowx+9JflJWy866tKkkXh2FgAzhCTZx/AKqfCOfTDK2lWInkGdiIHdoLvHGhyVN7A/h09iYkVuP0cfZCGI1xPUD1mZuMUNX+rjaOa1UGYkvQxKCU/ZVK7jmF6k4ATa/rHXyj64ikiPAIce8m20U98ihgdHHX+uMv/yqGxlMh6lpXwCB5TTZyUD4A10luLLpJtxlH1UhnKGkJ0VxoiDrHpX0nI7p/Fpu+DChcvg+qShKZbDhBgQiJSFTqMesywBlZW8z1CPzVuwrgGXNt7KtNummeO5SdwWSTvA9Po0jyzZVZTxkP5VIpHEWQyIJR6SFvKKV+pZHufG3/3L7uzHPkY+xNyfDdjSw85NQJ8/c12Tnjsadp8mGt5EcwX8/ppjzdLENi8lViIRf0uW18V7bDqJN2UrF3ANPFlFyqNukgNpGc88Z3c/LwoQqhQ+lsetbvY+ALiu/bTFGxhzSGTuIZnkbik8bjifGxpDNIRxzJrpaUCHJU6eVdRGHanc7gN/6F3iwjuZ6NjHTf7UnKRz9975W13zUF88mYbyBS6g37NiQ57EKLKAorzAzHdR7l+hDJQHin2whP0b8X7SzhBOp4C8uJDLOxKcCRQJUmnxdzEBLEzBST/rR+GoYZazcNYNiis
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(82740400003)(5660300002)(86362001)(41300700001)(356005)(7636003)(36756003)(54906003)(316002)(110136005)(336012)(36860700001)(426003)(8676002)(47076005)(8936002)(70206006)(70586007)(40480700001)(26005)(478600001)(1076003)(40460700003)(83380400001)(7696005)(6666004)(2616005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 05:28:28.7590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f80660-673f-4428-4bda-08dc1266248b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493

While calculating the hwirq number for an MSI interrupt, the higher
bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
number gets truncated because of the shifted value casting to return
type of pci_domain_nr() which is 'int'. This for example is resulting
in same hwirq number for devices 0019:00:00.0 and 0039:00:00.0.

So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
it to calculate hwirq number.

Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
Tested-By: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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


