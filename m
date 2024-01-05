Return-Path: <linux-pci+bounces-1719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD4825498
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 14:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2FE281215
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803B523E;
	Fri,  5 Jan 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/Kpkbjf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6552DF66;
	Fri,  5 Jan 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNtVdWU5QpJfTS773J4XXai/bxcdQQ0cV5DohqqV9JinpMypx8am2DHKhAENs5QfzgZXLoNGjf12zI87gkJGzdSMwYl3Joxvh+okbEC+A44L2c6YH1mhewZ0O6oKN1T0FwzCkqcLZTHRq02prTTWxi2d6RI/4AiGp2svKKIbDG/5y2T+rBID4bwWei68oL220pGB4gF4LjWoQKsT9V4UfHiV9r6QdLt+KpN7Qc11NjbAoEFQr1dA4Q6duMDH5sIhPGQmWuhpbRn+KH7JAXZcT3+2d0RRVeo5GbwmphGecBYGIb0TNhpLJCoHlj6NAHH39uZFqzTsSDjWOqyOu3tG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F3BJGZDn3xdNR9u7W03V1jQxiqy885YGh/MaPfVAZs=;
 b=UooogvwlwM0aRQi9duiKtqK4BXSW7HEmZSVPErayeTihR71i7vxyc+uI0gm8sKN5JaEoMESF5uicI7/UreMiPW+RTI2nmcwyhC3aGPuTJlzFZrMCx31wvbZ4TNInFlA2gQpGjJAfVUC182YFq+LgNqtJKY3ATcfGqRt5LUHPofd979IzvdtAf7Rsib6Vz7lhz/fzI8lKbBE0dyl1a9lF5fdEE5aI8WpOavAuiLhe8nBEZemeo2IyI2kxQJmR6By2opUL1XJ4buLv+4SZnEECnNWYC383lyt3c6WUjoCXX4Yi7CeVwnHEk5I34e2vOW5VdcGtDjB9jml3a9xfeoQLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F3BJGZDn3xdNR9u7W03V1jQxiqy885YGh/MaPfVAZs=;
 b=t/KpkbjfyPTTUnN4f0uIx4R7FsyPcwvMDu1Rgm4IvNz8IVvGi+km9aqr0rrhLgWi9QZR/km+YpnDbZgU0Xz2kC6bAi+N6TJcVZXcyZxr9UJU6Lk1inPr5X6IfUBPHMzQy7kCOMr9b2yMrgHocc2JyqbsXtppD+tJlWLgWMtDDF+Nl6RPY0PHzyNz1IugwBFpueV+lIXotHXmJdN30SYGoKVLkmsBOZ924XQwqWWzj+dLVWNVN4f4heBS2xoL2MFc6oe1WZ3hcu8em8RJKsDmBb/8wr+V2OR2d8di2J2kqWGDtSc5xSBfhNWhrg0itN+dzNbawH1WFC/4irefmUolnQ==
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 13:43:47 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::38) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Fri, 5 Jan 2024 13:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 13:43:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Jan 2024
 05:43:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 5 Jan 2024 05:43:46 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 5 Jan 2024 05:43:42 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>, <rdunlap@infradead.org>,
	<ilpo.jarvinen@linux.intel.com>, <tglx@linutronix.de>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sdonthineni@nvidia.com>,
	<kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
	<sagar.tv@gmail.com>
Subject: [PATCH V1] PCI/MSI: Fix MSI hwirq truncation
Date: Fri, 5 Jan 2024 19:13:39 +0530
Message-ID: <20240105134339.3091497-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 29788462-7d4e-418c-8d4c-08dc0df457b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TOaL+P15yKWWw1IPiYHzi1OgkNKUvIu4jMjoNy8QUNYQC6mLAU3HNn/+3X4gsEbtWAuve3o/PrEcYe5pgJKJG3qzZuwWeu47N/7Q9dmogLav++lPudZPx5qUvL0NR8U7whowJEtqSLEpkqInpPFh0kgV7b9K4VwpQCdw7HV0L80H4PsM4r+PkfI902XcH58bwWq4R6mpPPQ1FxdHDqKDf/eb8hm+y1nqq8mH1boo3Da/C5TAy7inuXR665uosd3k7hp60Yo7ZmrEr27TQRFb7EsbnuRdYnWd8zP8V540Rbp/FHcng/N3QquWiNKmkmWHfJwW15KU57iXPemnTgJTe+4EMKRtYVMZGgFGx+tVPdLLp689MmTIoz5XzEdC+u2JbtLKpStixZGCvmbx+Jmw4YsLInxoR1fnlnExb5vboBbtnD2pWdkm7T02hMdWpbiTu9/EXtc2hIAIAw6/mnQ20hshis0zzztUI78UeYswD/Xyg0W9psvpS5PWzEwAWYt1BA083o4vVLE13XWn3fXRuzjoeSSdYqgdGGqzhx7UBWNGEgy7Dx7Kv/OZNyIzHsVDlEiJXCVKuV4VvYl9uN1+Z8/Q3Vt+CSYrr/Brgd7GcTKzFe5f4O3bKqdFutUywioVgz45NkzdYis+aVS1VHFXCOcW6hZVAVPKkdFDqYJEpcKqJ2ksif0JSEHFW+zCbp2WgUUxSHKvSGDz2+UothWndLprlxYlqwZ9phELaPHK7KkfoRGD97yx6FVMxgMhG6P+
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(2616005)(26005)(426003)(1076003)(336012)(6666004)(478600001)(7696005)(36860700001)(83380400001)(2906002)(41300700001)(70206006)(54906003)(316002)(110136005)(8936002)(8676002)(4326008)(5660300002)(70586007)(47076005)(82740400003)(86362001)(36756003)(356005)(7636003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:43:47.3330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29788462-7d4e-418c-8d4c-08dc0df457b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

While calculating the hwirq number for an MSI interrupt, the higher
bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
number gets truncated because of the shifted value casting to u32. This
for example is resulting in same hwirq number for devices 0019:00:00.0
and 0039:00:00.0.

So, cast the PCI domain number to u64 before left shifting it to
calculate hwirq number.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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


