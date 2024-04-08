Return-Path: <linux-pci+bounces-5875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28E389BBBB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E35DB21BF0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34B47F4A;
	Mon,  8 Apr 2024 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bF5X4zHV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0E47F62;
	Mon,  8 Apr 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568680; cv=fail; b=fCvXbi4Uq21taJrEoHIzFjcq2AVFUDX+DIcU6HxMFENonJqWVkDkJvzFOe4+omjY8kvk8iSj8RfiBTtJrYnrcAGiRjkE2rDFQNtHbQaZPO9mf+xvbLyX1s9DTPtuHTK3HtK8i+fx6jlIv2mH/PlvQ3fRpPBKND6PqeeE7rWXtEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568680; c=relaxed/simple;
	bh=QBHYBB2pIP4QykOU2hnq1x+l/SlYaopmnn2WoEUWPMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPpM4uiruKVoXOe1f8ym2Il5PDW20dlhw7AsgFy5KrqMAQa4qjU05K2FvCT/m0ZaN01OA5KSxRc3ErHrb/CRAMDfsoyiSjy92uNaQWUIfe8pU18dZYQw61aoKfd/xO6b9sR/AmdmKmTqezmXs3zrLzYgVVgv18D9eB31mEDnx0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bF5X4zHV; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqfq3qc5I0Aaxrv/lPiIfW7b/rF+SlGEHL5Rjqjb5qKRLInU1+X28RJlCbuuFOPgFLTR9hj0tW3SFAY+J7lQs5S7MBlFFMuzWSrj8T/erXINGkbUy0bzC7wuTCuzf/Q9rNGjXg1wucrWy3txcGKDZAS6rBM3stZTLBSDRClCr+8w9VZstIyQmJX/JajHIsm7lI8tf20jvdkIILGOzXzwSrcFijyPUdFLFa/7Kw1YzDd3oVQkQ9w1NqS87+5a6QPTwjReBnL2TO06ZmfEdzY67Lx4Rs3i4YwMuJyED/iwn5HP/o/X9+54sTEqeSgu7nDu/3HDvAZAH/jM5AuSFXSekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Tosbp+aFoY9bETkmlR6fsI9EAnGqGZ4yZZzQyPphs=;
 b=cgPVMtuWz5jRYiRXxtiRwJcVAubfBgDon4Vc25YpPKlZl/GfNAOkYczM5VBgKvp0kgr4oj6gahqW3D+V3tN67Hyvvbf67bivl/5IS2kKbZ7ivVomfzq1yRkQds2ess76t/kd6MQyj5pp8NWw/p738Gp1PcNlbfdUUS+B+OipUjcnyhf9IYn9TNU136ro4zUfTaw8xV90MvlXbkb9y254fOTlt3jN+3S1yPx6OJAFEfT9dmi7logTlkM6Zm5X+bilApB6lP6OOnsnqH1CAvSEyyzz27jhl7RzGl8dfmkdNpDvqXyg/RCZVts4YNBycBAmBCANtrALod5VChqHrrTCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Tosbp+aFoY9bETkmlR6fsI9EAnGqGZ4yZZzQyPphs=;
 b=bF5X4zHVT+IeP9dB3BcX8thDOE7JM5BhQojHH9Osshagh3lvXzvK1FRyOyGHqJ0UFGvPrs3UPa/c1tLP+GFcvTaRADXfAScJb6hKDYT+ZEZux/zmhsIrMLRLbkAX20tWqdJq5QBhOP+r1WetFD8ZDsADNJBQjQDbTXglnBTv9DDe/0+5xXzVh5rNwutcfq3HFFwsdn1yYm76YQQmCoN4Ok8PAzhmPZ9biUPFhWnrGC9ZI5nYiEWy04uOlGfYcWwgWTXBCKGT9JLxX5i2rQOay7BFPWjHYtTjssbo+8hTvacNKarpumriCiMDaR34+TaMTlXapghL9vtHjupVcwG+fA==
Received: from BN9PR03CA0267.namprd03.prod.outlook.com (2603:10b6:408:ff::32)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 09:31:16 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::a0) by BN9PR03CA0267.outlook.office365.com
 (2603:10b6:408:ff::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 09:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Mon, 8 Apr 2024 09:31:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 02:30:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 02:30:59 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 8 Apr 2024 02:30:56 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: tegra194: Fix probe path for Endpoint mode
Date: Mon, 8 Apr 2024 15:00:53 +0530
Message-ID: <20240408093053.3948634-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401150116.298069-1-vidyas@nvidia.com>
References: <20240401150116.298069-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: f5228639-2ae5-48f6-2051-08dc57aea3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ifCtHNB1s9SRCJLY84kleKiOUEbiHNP4sNB+bU7LNsPIqRh55OJOm5ZWwE3Or9n+z1PuSERZ4ZbdT/cmnKUDyu5KpmSQzn2t/2+LYs0gyr7SXlKvSI0xfSybkpn1EJuHG3sA+1t8GT+89A5IdNbONGSi+EHobdnyPsnRBxRa2VmvBsHLyJsY6r+vQqKd3Cv4uoXlZ9CSRUueLCded4AUTVoebGkM3pev6XrXfWYZY0H09LWCIAjsa2QMk2QUmyhzLEB5gW0K1MNZB4N8cf497xJVW0K/PzM9u/VoxrwuwDCjk6lAaB2hFih8+xbU4jLZYPK5zNGoxJCva3XKRX2IzYdhppIGCgxxkPYZS98wD3vKBM9o+Ebp93juFE2IQMgXfYuOUypzgOlTKcq5Hm79to+PzXBzWXsONYC2RY4DQPyE4L6zEMR7zbRdL9Tb+f3NEAdTpCp8Z+71v/HE3K/BOZ/c3qxu3ZAplQW9hNkNvBw2hd/MHWcWj+mf7s+fjt111j9t+t8Y6nbFdgJq8nfEM4VzP3/4rAsF4TMcbaEmiCXfGc98tmnzlIna9l1yEn9ZeGXn/uoio7H93+Q2/1rQbAzaY8U5o9fm5NSlzb2DBsqpoH1LX8kjOiA99jrLTM9OAmVQ6jJH8479CPEn1g4rE+ZpE3Xq506zZKYHLI4FEc1M+3u4zdvlXNmR13eQ+rkwUYK8JrYNd4tZQ5fxrXHp88YdQ85paDBpRbYrmNeQjeh1yt7nnAhhUGH/t5KWdh3A
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 09:31:15.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5228639-2ae5-48f6-2051-08dc57aea3a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

Tegra194 PCIe probe path is taking failure path in success case for
Endpoint mode. Return success from the switch case instead of going
into the failure path.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
v2:
* Added 'Fixes' and 'Reviewed-by' from Jon Hunter

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4bba31502ce1..1a8178dc899a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2273,11 +2273,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = tegra_pcie_config_ep(pcie, pdev);
 		if (ret < 0)
 			goto fail;
+		else
+			return 0;
 		break;
 
 	default:
 		dev_err(dev, "Invalid PCIe device type %d\n",
 			pcie->of_data->mode);
+		ret = -EINVAL;
 	}
 
 fail:
-- 
2.25.1


