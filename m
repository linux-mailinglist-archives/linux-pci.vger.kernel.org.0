Return-Path: <linux-pci+bounces-1808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF1826D65
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 13:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587B71C219EA
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C1D1E497;
	Mon,  8 Jan 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cVSJztDv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419D2940B;
	Mon,  8 Jan 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXvzJrQEv8+DXkto+5FvU7hJ/YCT4Y4ur/e0M4EAAOJanEZcRl6mFjP0FooqHKhSJIa3fGqSvN9oPBNUCz2KUfClYR43QvJKofsiztkV7K23joDqIydIDR24ZlOhLF6MbTHuv9hcFhUDngPXELBK6u3DsRJFYvptwNzfeyCNWtbwNHJvKjcL87h4LBZ5NmrAKSG1Af46Z22kby8X3MpQtwYCYljlALaY5VAyqM/dAcG/IN1mJ0kQTh34vCatw2TR7JuVdA786YwqMnDD/NgN1iN123/LsxF9GH/sRxlHIU3JUSZG0pkiSqJw3E+apwosj/Z1k8KylhwFWKLshSk90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueBJFiL0xSdEP04GePajUj0y9LSbBPwyXFWbks23tTg=;
 b=Ei4VzWFQJnbFQAuRurYXlm4r+njyMHaBn1DzXnkytk7sIesAA8HVWmx4cMYu8jBLfZ4dPtaoY1QHynxaBqaiL9E5Nxpc4m0iHezZhrt7sXhRhut3Qiv77b7IsxVN15qHQFIm/b9Yxh2pFmkR+nS3DwcgjaTu8+rBActYoXv/Y1izGBrqXH6Wox4epPaw/yw556LpT0imlVCE0TyW9FXbOM+VNO8mPWZteGA94LSrbsFV4Jgc46icWMSoh7QBPS/gAkamR9RCYjlAf5USzGOIZVloGNnzFfOY3d+nLrsJbZ9CmKu3wnvl6lISSizGZqQObxtw+el8m/Y7Otw204E3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueBJFiL0xSdEP04GePajUj0y9LSbBPwyXFWbks23tTg=;
 b=cVSJztDvsyMyqKok7NLILd30BoxHa4nCTerZmpWVRa9pYBxU6JrbPnBZhlsVJ4Ee2YM1DNMYyxc129W7Tqm7//bDpuzrsu4kpFt3bE3jeT2Km9c7AtNHIqPp/+5fhLzsuoxyCek0XhXywctS+Exy74DJxQoUxbctlezFf8NxWd00vSN98z9f7YtScuWuIpudKkgdrSqg3KNgNEnASFI9AuAkqQMxTSNbt5Dh76O+Xz6a2+HT57MXEVBAu6Fm1TREUdJ5nZYAPZyp7kdTANldEvIPjFfeg5wBHn140wgkvMTs8ULEKE1bMOkYwUq7g1VkhTjVQGq2iOPsyK+2KXnyTQ==
Received: from MW4PR03CA0181.namprd03.prod.outlook.com (2603:10b6:303:b8::6)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 12:05:50 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::84) by MW4PR03CA0181.outlook.office365.com
 (2603:10b6:303:b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 12:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.2 via Frontend Transport; Mon, 8 Jan 2024 12:05:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 04:05:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 04:05:29 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 8 Jan 2024 04:05:25 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rdunlap@infradead.org>,
	<ilpo.jarvinen@linux.intel.com>, <tglx@linutronix.de>,
	<jiang.liu@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sdonthineni@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V2] PCI/MSI: Fix MSI hwirq truncation
Date: Mon, 8 Jan 2024 17:35:22 +0530
Message-ID: <20240108120522.1368240-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105134339.3091497-1-vidyas@nvidia.com>
References: <20240105134339.3091497-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 992b9061-ad0d-4bae-a245-08dc104227e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8rkGlBI1ZVW5BeCVMGttaIcw496pFSIgYijas2OD5jTp+wmkKupA9/ygP7M37y9HLi/nUK6EglnvIsmthRr4uaLVKrWVEbfq/r6LXT0cOzUSspaGgapHveptjUEXaEWJ4SbIufzlZZfO9c2n8UftGpzItv7uJkwg9G+/IN+H+Tyxy5hvuzoozmElQtQnddh5bjof3JjnfaJUQluLEszbr/COHLWQdX/q2tdXl9qwQzI/CWdaFmI3u1R0G9UhmBB4MB4sgI4nN2O3j/I2rJBPpbSC4ONmKV9lt1Zgzpf/ibaoJ/2vgRkt8sNgClzztKNvu3F+DxgTr5Nq99OPKpWwn0v8W37Vu2LuUpC9Gy1tsLEcRPKo2T5Hcs4COWnh7lAk+Jwnu6Vuh9WQ3+cyvgu5yD2DLmtrfS6L/eGRzA4edpduWgT1Kqx4X456HLBrcIjB5nv4+iOVVdkL+g5YLL5LTj0ViXo6EMBk73V3Mlmt3tv6jAKUNPHJddDDLNYL4K941qRV9MbqTDMg1L5TclzGcg3BLnA+22mQ7sJ/I3+JyPefimcL2klUrTxXNTta06kbEPTUKTbDT1fCTq/Af/Ps77w1flEGJJkvGBLchUu+Ky0YH1FR31aoLggvyG9/srJ3swjQ/iIjyfC/DeHVb++GURRAFujiYBbDH49gPSfhx9bvPNv+VRQyR1nnHgEzJwGVdmZK/osMXIQCue2X65rigsb/jZCBeyJVHkY9bTm3fcU+gh7upv1+EdqsGa5glUoa
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(83380400001)(40460700003)(336012)(1076003)(26005)(40480700001)(47076005)(36860700001)(5660300002)(4326008)(426003)(7696005)(2616005)(82740400003)(7636003)(356005)(6666004)(478600001)(110136005)(54906003)(316002)(70586007)(70206006)(8936002)(8676002)(36756003)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 12:05:50.1542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b9061-ad0d-4bae-a245-08dc104227e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858

While calculating the hwirq number for an MSI interrupt, the higher
bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
number gets truncated because of the shifted value casting to u32. This
for example is resulting in same hwirq number for devices 0019:00:00.0
and 0039:00:00.0.

So, cast the PCI domain number to u64 before left shifting it to
calculate hwirq number.

Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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


