Return-Path: <linux-pci+bounces-41072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76626C569BE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DF964EAB52
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB02DAFB9;
	Thu, 13 Nov 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XOc2CDFs"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2F2D1F7B;
	Thu, 13 Nov 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026043; cv=fail; b=VMVhNMNtt9wh5QHXNQV8n0KtlcggH4KIgIuoosvv2wvpWGDqZ4VSfjUueneCtKFkfuz771zNfXzin/WVYK7qESWKc6/IL/NFtcDy3cuIJdSh2n3o1N9HVoBvYuDgw6i7xn57CzkPsHy99HM9cB3L5XU4CIXBv/SZAzv8Xq2t2mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026043; c=relaxed/simple;
	bh=tWNN8QIKQBnkrEJpPwtOGkqEBNVgBU/B8i/2JsUrKAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HRsY5q7Ziv90jkdupJN3Kia+VoYjVyeN9NqoawQdqiU6bFiLSqeJTVubT+GrwncJDsLy0HUkI9+y5IXRbtl2fqmeLFyDIrxTiU8U01K1C+KEZ5sW5HdhtTB1lc/XuFV2u6oTNBjwX2h+NruK/9rAuajnJBfg5VFGmbBsauPsEgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XOc2CDFs; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHb8CMr35BC+8vNqPzWedotN5NKfyew/zF9adEYfeO9QBXshk+TGiHcdPEzrVnMaN6LwKBrfLkNco+bXFWzKuMEJePN5hysPJc7Fp/7L5e1l+mIcOle1VVjD16zUuunj/UGD3mfJjF7tgkWHGB3ehAsFqCVCtMZXf1Y1G+DOHSTvtreE1/gTAlNE4ggkwWU9ly1+3TWDn9O83ebMz/4TMHYOeGdmUPAkZgvj2IdK0qRRZYK81XMxvMsN/EUixBNq95MQglSA3SKWHgcYzcWtqQhxXtaJQwzBw11iW/StrH4KwXLeFYNkvfSwukE2UQHUhkjJbzR4wdbpu0cEsR1n2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdRSHxlGS74JO/oURTcuVIbvsA/EO2eZ5Gq9re+VK4k=;
 b=lBAB9frgWnjjuQJQcvPH44shJtvFIUyoV1R3L+x/bVoIxU8rbXuy6Q1jmb4AaGudYaEDvNaac6Z59y26E62J2oa0Yg6DdmXPtbJfQKeuYoZcRgBgLKA2mn+29phcuxwpxs9pqqXrLfUpzF2xh7bqBzuyEJ0uWU518JiglDN3KEiyhjaaq03DE9R5s1odzj6cXJ2MVy4QDY4nq1h8MXB0HvD9oFR0hiWNSqbQ0rom2DW9rVt+85uuySEMQ0z6H2O2UtPpoQKEs1ZVO+svSUYjRpLZwPIOthbZJ+Gj/3Tn8M46JDZl0+L/bfZktSJxgZj+7y1wgNTb0HG5XxH2KvYvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdRSHxlGS74JO/oURTcuVIbvsA/EO2eZ5Gq9re+VK4k=;
 b=XOc2CDFsso4ti0uKIRSLoupe7GkyqufxbJcSsdkrDifq9zQ6kFIJLxnaT+MhzsRmBueVVXj105ryKoHx3IGGUiG311Q24rjBOPRufiRzzVB7qSgccsgIbhYnw2BDGVisKzTUOsc1fp9cjH8IhiIIzIe+uczAu0Npl4horaKUNTI=
Received: from SJ0PR13CA0126.namprd13.prod.outlook.com (2603:10b6:a03:2c6::11)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:27:12 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b8) by SJ0PR13CA0126.outlook.office365.com
 (2603:10b6:a03:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Thu,
 13 Nov 2025 09:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 09:27:12 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 03:27:10 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 03:27:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 03:27:09 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AD9R5TO4193020;
	Thu, 13 Nov 2025 03:27:06 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <unicorn_wang@outlook.com>,
	<kishon@kernel.org>
CC: <arnd@arndb.de>, <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from tristate to bool
Date: Thu, 13 Nov 2025 14:57:20 +0530
Message-ID: <20251113092721.3757387-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: b06bf77e-baad-484e-2884-08de2296d381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700017|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PkpGETsYmpP9MZsspr10Un0HwtARDC0j1NfbQE4IVxXj2hGumedF/AoAFp5q?=
 =?us-ascii?Q?yaM7jhoeyTf2y0Sl0paU3AWsveMV0seh1ygRnHcqq2NWagAWYegRrrCjOGvl?=
 =?us-ascii?Q?Ol4fsWMs8GiwkPgiGNlZg5PcAXhjRu263/W7eskHzZO+45PkCq/0fb6yUhgV?=
 =?us-ascii?Q?JFjUM2I4bsdq3tVH7LVe42ZvQhVsBGO3P5LZn68rBA7Luvx1fGBjK3GhV9AQ?=
 =?us-ascii?Q?cJPGImMMjKBYFloGD+Mi6ZLoH0rRM6pH1B4tQq6W6GTlGksStfHAjWjkNSig?=
 =?us-ascii?Q?E1vflyH14VUbA+qjPPe8tllz1mjjfL+BMkopAp91m+naPH1g37RNcUa3b0+D?=
 =?us-ascii?Q?6R77cZPzbJCI2gYEyHjbGCufXQklgAKshf+1pPczf2RtKmZZ8FrxD1Ezyjmf?=
 =?us-ascii?Q?4Dr063XK4rz3OygHVGvsyYwwtHMZbST3b2ecYDbtBGQEb0E8AjkMUSoCYyQg?=
 =?us-ascii?Q?xn1/fiDVK8kWVr6heqO/+Ik0HwnNJ+rYfHtKgbvrlOJCe00TsLvlf+Cb4DGR?=
 =?us-ascii?Q?XJYRVoNCTzlpwQoNBguDHWtUfM2pJfzLuaN2yO6w9Z1HDVom9oL5kzAS23gp?=
 =?us-ascii?Q?yUEWu0rRaGGAc8X1kzsg8dfk1DS6kkL0+pTcqrZoSkPghiXX6IV5F6gUZncm?=
 =?us-ascii?Q?xflFMdXYyVHyMZAPmdmIWQy/v9i77LhV2iwuY/yTTA9KS3Q/kqDlyw6Y+FNU?=
 =?us-ascii?Q?/EATGI/x7PAP/7zOEblKaPUekw3sJe5HOc8Q7yOa8ZHq6e4fVDR7rYXaY5BL?=
 =?us-ascii?Q?K2qmd9OLNWojropyVLUg+C9WeU0Rt2GrW8RwuXb5l0WGbVcbo327c/vZQM92?=
 =?us-ascii?Q?EAt0oC7lrFhi9RDLC7d/bKDNlmoEdgJd+6LmLHtmyxoDZ4aiex8Bh0f8wqGb?=
 =?us-ascii?Q?AtUkqRD8Qa64A5KMt6fOvP9tUp2MKYH5Xz5WUU8YHuuI2lXhySk2kdkGY7aV?=
 =?us-ascii?Q?f2WHVh3sBwz+Ss1aU+/mHhv2MsiOspgK1E93P6yJP4a9N1oVSW2qY2/lGTcp?=
 =?us-ascii?Q?nArv8LjVjnRsb4f+V5hWlVJwt7KqStEAC4JRdMXSq02wKoQmYgXWgVFI4U/P?=
 =?us-ascii?Q?vIOmXzl7O1z2h1c3zj1KmCwywMQNFFveNTI+hHr4zWBIiDibJTFTZC3O6aof?=
 =?us-ascii?Q?HEUcBRTfyYPGGTcHlRAhkBtd0Xr3qnxOQj2Qz/7GPSmSkrsNwIU/F5oitfJG?=
 =?us-ascii?Q?kUhYB/xNgN/vdEigVTBuhZwj3sNINyKVfBpFK2j9YUEsloKaiRf+CYD96uTA?=
 =?us-ascii?Q?mYRpRD0sVqcHGLJJyQiSBacL7SHW+EC3gof8Q1SG9HwHX8hRRXJHxnQFqN8H?=
 =?us-ascii?Q?KrWgC9VnubQKnSkoG7HWW7OOU7LK6fQ8v7vaNfBxDIJzlaNsMgfxc4Fqis/x?=
 =?us-ascii?Q?xvajF0+TbrItP15lAJQTi9uDkVrGaGjU5QIF+OH30yjnGNZfbxquoaot8zBI?=
 =?us-ascii?Q?7nlt6uHNU3EzTrVd3dCThxD9cnKzz2OqIPmGqB8uoF2a5QfFujbyAZgJ990K?=
 =?us-ascii?Q?WxnebXahhe4DJ2FQdVVWUo5p1uc3jxLdB33tHfZ1l8SycRKd90eUbjBDjuYa?=
 =?us-ascii?Q?nueXYvNMVWGBz/rMzVo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700017)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:27:12.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06bf77e-baad-484e-2884-08de2296d381
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348

The drivers associated with the PCIE_CADENCE, PCIE_CADENCE_HOST AND
PCIE_CADENCE_EP configs are used by multiple vendor drivers and serve as a
library of helpers. Since the vendor drivers could individually be built
as built-in or as loadable modules, it is possible to select a build
configuration wherein a vendor driver is built-in while the library is
built as a loadable module. This will result in a build error as reported
in the 'Closes' link below.

Address the build error by changing the library configs to be 'bool'
instead of 'tristate'.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/cadence/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 02a639e55fd8..980da64ce730 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
 	depends on PCI
 
 config PCIE_CADENCE
-	tristate
+	bool
 
 config PCIE_CADENCE_HOST
-	tristate
+	bool
 	depends on OF
 	select IRQ_DOMAIN
 	select PCIE_CADENCE
 
 config PCIE_CADENCE_EP
-	tristate
+	bool
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
-- 
2.51.1


