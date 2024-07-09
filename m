Return-Path: <linux-pci+bounces-9992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60292BB7E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50A64B2549F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32615F33A;
	Tue,  9 Jul 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dgJ6Gd5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E915FA7A;
	Tue,  9 Jul 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532198; cv=fail; b=LyBGXINMdocmvGUA5zWAQfx+srJveBg5ctVs+wdIQdeOs4tE+hsCm0aJSrxy3b5ug1DH1hPaAARhfWK5CHB3040vSaWE+/XRYBxecqxDO0cUrKumJ2IrfC83jGRs+YSDlscIsf+cQb2qu3qqrQcRvasZ76SLSaJQtFkJgzm/jGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532198; c=relaxed/simple;
	bh=vxtvWHPyRVhvNgs66Enc9TPVaygo0DmtzG9io9TFr9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhzT9HdMY2eJ2Ua8yg/tHb6XX78CzqyTIg0UW6inwlwr+gD4QZyX+DoteFtM+KfJ+CO45bGVgppnla73BzLHCg5YbdT8Z/x5ebYBFSW45cphUMeL2SadYaHTVdoaTAF1H6Ijo/4CAZ+L4CPUjiG3cBSIHNGyTVWKrKfZi8i4PE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dgJ6Gd5w; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3liVPxogasXJpjVyyMC7L0qzQ3ym/mgj7wUiNKagr04CuxETkvEoDmtWcUjydSKkxSBYPopQr5WHYvM5ON577wruM6xtFE/1lPAZ+L9vhRKtns+r++nUQpkbQ3YhNSTHT1oIMSSh1qDvOXAmNoFgdGKVJnjMSZ/Labnu1h5B2MO/uN6mlRSSv/B44I0/z8KLVxwPLVMQVpE/WNm5LsxHHsii2Ra7S/SZrv7EqhnHC8H3IWUDBMO2IJubZxgv6ff885XDCNDaWTYbahQaGaMtyGmOVDf9OFq6UgA+XCsebdvTkpvWN2gPwxNqNyJo8uwKk0gfsDtGkWWHv09VCmVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBlcKeoM4qlgbFBaVp/z+WcbXhW5YGax/FrfVME6w+Y=;
 b=ZCgc2VhrVbGHoQNtJ1wx18lVPwJmx+295UAtUGu/BOiSbbSc7bK5LGr8Wf0RvAqon8InFqI37HlYaR511jDMoHBoIBks/XlFghaMvUs+AhN0+reb4z0LNDWzNhcTS8sMeuHJDie87cgMQ4Nt2zTDhU9m5VLyvdOg3MlAaCWw4FIGDveKb/MADdArAs1eN3oOJNRtEznZnuAXeKtdHhoqe5hcbrh6YeKZ3iw2kNUlssKLEiEVfpgBUPwSatJ+6KC9lZINKSzX8snu/NqQ3EwldtuNmc0SSG5yYNDo+2uCUoYSrw6sLQkKqYLZCfxREBhQi98xUBZydD43yK+bDQ+CkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBlcKeoM4qlgbFBaVp/z+WcbXhW5YGax/FrfVME6w+Y=;
 b=dgJ6Gd5wYkBFn/rLraVyMKLXP+k8HtQyIW/U3q5447SxAuowhj53Lt1qLt4hfuT0IhwjxnvcfvykzCZUk6/1zIDAKO4X9bOzf3m/1PYJH7g8Ccg97gHtvBXhRy8XeTbmUTruN2esP2w4jjMPVZgb2gycK4bnoHkw0jQQ3312jgc=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 13:36:31 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::9e) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Tue, 9 Jul 2024 13:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Tue, 9 Jul 2024 13:36:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:29 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 08:36:28 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] PCI: restore resource alignment
Date: Tue, 9 Jul 2024 09:35:59 -0400
Message-ID: <20240709133610.1089420-3-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 14190bd5-dd53-4dff-b9d0-08dca01c2468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kx/Siyw8H9pEAT3v4ReHCa7GvxYIPNJ8O6T3a1Th++P1SnZDhyp41aMTFzN/?=
 =?us-ascii?Q?Yb39gnWBLm6CrBCS4UB+y/UC3GBkKjLzsWN5uPSDvquwjy/BdUWo3i1qSvyc?=
 =?us-ascii?Q?BS0vOaz3O7bjUkXASTbpFMh5SaUL8Do9+rUeL3HeqTgvzqzf2Ynzyj2OapsP?=
 =?us-ascii?Q?TWNvKc7F5kLOIxlzvCVaLWXsqOHruBKtGUZFerl5jdWNudhmgBHbxHKWudfS?=
 =?us-ascii?Q?4/YcsxduM0/iEd3DDndBPQR579GLjiShgvev23jEVG8t+ncg2ZrFFO55Ulqs?=
 =?us-ascii?Q?idy2sB86m08a8rUJwDGo8h16XBFYFS+feDVYdlD9hShNHHhMvy74HjbkiDtx?=
 =?us-ascii?Q?4CxttRsNnid9jp2rBsEtks6+PTFs5lXaUAWBI0fP9SKLvoydkeeuaiu1y8Lk?=
 =?us-ascii?Q?g5wo/nDJFU3Z3MMMs1QA6x6GOpnfnYQKoKRrNWbvJIYft87MXgHm9TVmL5pM?=
 =?us-ascii?Q?L6i20hK2QkTOpgMSovyQuJzjLpr80b3lNIo4cyFao5G0EYFfIyS18RUPcbvY?=
 =?us-ascii?Q?zXDGgGG8+FuZ63UuNencan/3ZtWhRj9loMuKav9b30LFAobdeuw7Ct2zOQh6?=
 =?us-ascii?Q?YSBhQJzs2zZjOBFoIQNymUfjtWo5nz20KqFIONXFeEMLwryIJ4iDUHgdoB0f?=
 =?us-ascii?Q?8psIP378bJUcUxVewfMjHP7NtdyNwNnyR1fYcZcvzslxk5PZQYkKDNbsh+SY?=
 =?us-ascii?Q?O1OYjoy+JJOAuo1U7DBOyi6//W5bD78ulbmT0kMDeIavOJkmx6frtwYYex9w?=
 =?us-ascii?Q?927yO7OPsADJFSPe5lsYGQCrBh9QwXBeHG8BeEqmuSWjp0WqGkZMMRQsLopd?=
 =?us-ascii?Q?I3etagmAFYCd2Kk5sa35gfxAlA4kqgv/HDO81+vZ7Hk72qCeoKYCjPHfazN6?=
 =?us-ascii?Q?Hxej0aFgpp5rsH2vX8xfWa1MLSHW+kryyXXfzMgj7VIqvrzGVWUB5b+Z5y+F?=
 =?us-ascii?Q?PoKjg1Xg3FAcZ5Zsg7RbpqyA6GhZZwH1KjNI+SgVj4I6h/SVG34sSD8dHjq1?=
 =?us-ascii?Q?h49C3FKv9d8w3KuPsr2qhiiyXvoXlVooyWusvBziDBzE/jEAnL34XYST7T0p?=
 =?us-ascii?Q?OKNO5Fa3rRjp8NiZg3BRVVkkWF33rjnx5vcCYtAPauNQdaPfnnQcyNqPDVeV?=
 =?us-ascii?Q?81/Yq0lS3gJRcpbq3c9NgsCV65YnXtY3vV4A1yHy1KposQ/LLVXslMWuuIxB?=
 =?us-ascii?Q?3b0IRG7DiECxuw4584EOuL1iGyMkYOEyWDZFzHKsiga2YT5nB47//Mo3XTjY?=
 =?us-ascii?Q?BRSG1NTmO0E2eaCWhRcNyv6jlmU1302ioiusgTPMIGab26TPWESUr3vDqB4b?=
 =?us-ascii?Q?NZKSdd3cs17iCDr00oGTG5JHWDiSzYWUZjq/fm/1IG5nZKNbazHku/pCrlQ2?=
 =?us-ascii?Q?IOqg+H6JZeR1vOrNTsKI9+ctIdFWq7FJ/BevgvIq/eQZ/pMNnnTfw/usiLZ9?=
 =?us-ascii?Q?D4IdPjwFqrDVwvnEDHwk2olKlCcXtfP7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:36:30.7326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14190bd5-dd53-4dff-b9d0-08dca01c2468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

Devices with alignment specified will lose their alignment in cases when
the bridge resources have been released, e.g. due to insufficient bridge
window size. Restore the alignment.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
 drivers/pci/setup-bus.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..ab7510ce6917 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1594,6 +1594,23 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 	}
 }
 
+static void restore_child_resource_alignment(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *b;
+
+		pci_reassigndev_resource_alignment(dev);
+
+		b = dev->subordinate;
+		if (!b)
+			continue;
+
+		restore_child_resource_alignment(b);
+	}
+}
+
 #define PCI_RES_TYPE_MASK \
 	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
 	 IORESOURCE_MEM_64)
@@ -1648,6 +1665,8 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		r->start = 0;
 		r->flags = 0;
 
+		restore_child_resource_alignment(bus);
+
 		/* Avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
 			type = IORESOURCE_PREFETCH;
-- 
2.45.2


