Return-Path: <linux-pci+bounces-27197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CBAA9DE7
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9191D1A80269
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 21:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58CE24887C;
	Mon,  5 May 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDJlR430"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB21D5CD1;
	Mon,  5 May 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479762; cv=fail; b=Ysmw5QbCMzWJXkCNa+jyYwC2fCkBr9joHbHmmNKa/6AwLKkf47lJDmeiA80bLy5pAy25Fr5hRlDXGanXN3UsPhDFMwc7dcsmlLa92qvBbEMecH8mfzWPh5krSQhKTvLMZi2Gw334ssP++ybQT/e2IUhzoHPDod4VuQuv9eW3jVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479762; c=relaxed/simple;
	bh=IF7s19lmZEi9Eybc8UxlZUy5A04/Hu+hc8IlLfTluXw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PbI0AKhrBRee/12bRehlMaylZdlsCSWwo05uMjf+G6KMIDZ1rugekPIP0Iyq4DseE5dYEXwi8KsEMgpnPxWSL9WZxkJaRk1Ov8R5vlm2wl9CQGMuHabRDRQPys+35mAztbpAlPq2pHhV8nUWhJtVUJSA1VImrdBJ0l6naV3Xeq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LDJlR430; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGq7WNUCZhYflLBQHaazyNniFXoic/FqDLfoi+x85QHSXRyD4Um+ujjIZWUNO/qAZL/bJpv+NoehRnzwg5DCRhvXBe9PXLCz9IA8M2D6VGWjXdRRxfbgOSjJWOSPtuhIWNd1OK0JYzJKIFCD0+jI3uvJ3kXmvg47CaWANpWeIvw4/dO29C+xC33j+cHkNOzNCoE0EGR+h/RSuR0/J1bJuFcEiq+dPIB3xtgwuV/ykbadNm9Ut4GQF4xloLx4Vi6ZQrwZXiVlrE+uND5EsQS396UB3uGylUDJrGJcCjkzZpYzq+PGRenL2uRHBka6a2p+jUayF5X96ot7a1IJZ9fDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D4+fHdFYTXidxx0/VJibPSky3URrhT/5Wu/TOeGGCM=;
 b=DN7cm9cv6iAXTkIgalnEezqzDW3tfdWG+gdWYeeG4/NGzWZSiIYgE5g1rwfsCXEYSqkCk6mJp2Ra/1OBeyy6Mmmk6QhrIRw/bCSzKpRMVFnJ9blffO6fyOGRszxwtH8EBThOvzNvroCuktDzxay63AfvX4aljSSMhsNJXHIQ1Z+5gbAbYGyl0VCJUxw7WGtwOLkVSKfv+lFU8K7ESA4DNYZf4StZn8iV1pvoAorxIp7ls4OT1LtQy6TLuzvo5CWu9n15JCKEwRl87jxkzRSdZU+a1ahMx0p/XOK1ZYEKZ88FEWrLzt6xJf0+QFBo5071V9x7oVq6bnygr0tiKO77oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D4+fHdFYTXidxx0/VJibPSky3URrhT/5Wu/TOeGGCM=;
 b=LDJlR430CR2egktDkrZG9URqnbwZyz/DILKvW0ufe02EIQGMEc373n0Ck/s9C5YB+atX515ZAJV6GtF7MyGyZs4UGU7eNXgAdRDOf+sQppf7wF2Kv9qYqjwwl6TXm5UrF4/HymDAzTgSQw6opDeRqrvsTxWT4prbzOzBdJaNxTr9FtBLhBYHVTlfNytkXtjYqslv+NNsreSlvQh68j7WKC4/vA8RsCQBDFF8O95t8aD+id71exVSqXFI8qce7KQckJ2PK+xs1mxyvAe8X6gmhX19S/57wsxkRn5uOdcDKdjXig/NeUC4c83852BrnPTj9SA+N0EBg6CQaMj62SCstg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 21:15:57 +0000
Received: from BL3PR12MB6643.namprd12.prod.outlook.com
 ([fe80::4c5a:f9d8:3aa4:4d2f]) by BL3PR12MB6643.namprd12.prod.outlook.com
 ([fe80::4c5a:f9d8:3aa4:4d2f%5]) with mapi id 15.20.8699.012; Mon, 5 May 2025
 21:15:57 +0000
From: Tushar Dave <tdave@nvidia.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	jgg@nvidia.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 rc] iommu: Skip PASID validation for devices without PASID capability
Date: Mon,  5 May 2025 14:15:24 -0700
Message-Id: <20250505211524.1001511-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To BL3PR12MB6643.namprd12.prod.outlook.com
 (2603:10b6:208:38f::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6643:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: af81f54d-146b-4689-52b4-08dd8c1a074b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uCEzhOtOzGSKAE4iI5Q4QdwvbO2WqPd97ZIa7rmFy+LgfeiN306AN8y0F5yf?=
 =?us-ascii?Q?Z9QoJmNA5iG0Mtg9EBBnTqaN61cDgXq5zMmCGWPJVEaVG7QNLbV2sgbZd4wa?=
 =?us-ascii?Q?1lH7nJd2UE7MTcR3G0kv2HN47bmBF6QgkG0vOQ956gh3kPJNP1C5sFbl0WNs?=
 =?us-ascii?Q?5C+31I4jje3uRXzFhD9YoEi59Ho5P8UbUZ1IcGUTrn4/BX1Tn3kEws1osqZg?=
 =?us-ascii?Q?sDdcI2rylhQofEgHcceOnMcbgLBfsLf0i0vYR2ws92V/XllplzB3ewCc1uQV?=
 =?us-ascii?Q?EnJ86uqSxUouMBn+XYHzxUnc7vcKitpsh7mI6FGwkFBP+TrLJJtiAVsJjBG2?=
 =?us-ascii?Q?2MrRv+KdABUoF3dOEcyl8bHSbdL0/Co7UKKMPfglYX4nOErem3TklIPdN4Xp?=
 =?us-ascii?Q?2vsHkYWBzbGK9EId9KRLFUAScZmxEnDfpn4Lfbk2b5DQ99bWoIz4k8HZGLkv?=
 =?us-ascii?Q?EZJ+s4ErtIdt55sp7p3fBqs2FXiKal/wswmy0Mr7hCfjFaXiC76yXpIabJJ2?=
 =?us-ascii?Q?x8ATadurTIvEEjUDPgZI7ZeFuzE+CYeRtz+0uTP3ikqaTsrcdNrN63iqf3Y4?=
 =?us-ascii?Q?kfE+XwKEsrTBP2e+NC0RWuEbQI26BYRYBUaFSPu+fFQgyzRGiVFn0DdYgUCI?=
 =?us-ascii?Q?X3gJSB0bDaAJK3zuDzJyxxugrkhZ4BWkasFYQcAXHTud67qprNC0ydewKjMt?=
 =?us-ascii?Q?L2pKzqcSZp5pAsQWyQ3OPpNGLXRls+J1qZz4xJP3LIPc7qKitrzsUmtTolJo?=
 =?us-ascii?Q?Dl2na7UhU/NI7+nWX8dFFrgKnnBrCz/qJcN6mKeGM3BQv1ZlZj8gIHM+/6rP?=
 =?us-ascii?Q?s4jhv4afqXsrRkkjdbSgPy7x9TWnW8eY+LRR+JRRfVADQzVoYqciHfF5bxPt?=
 =?us-ascii?Q?473eueb+NXJgSbarzQFJUIY0Z6sBma8/CY7TFKSoVhkCLiGeWMBTgfrFG3lg?=
 =?us-ascii?Q?pM+3Vlt2Zw7ObEiI8vResEue6vjpZPaEwH4cUhMT5aW+GlttxIuXZWgXgTZX?=
 =?us-ascii?Q?NanfUhBgs2Umis6Zcz5ZGAdHxp5ZtUDHuVpEyTCv3/K8xhdLmzrbfl1OpnZz?=
 =?us-ascii?Q?QmIuQ+A/0C7brnPHQV9rCAGqEWXFHql1/FHEiZFIFbSzSC2STQd7vPgLYRIp?=
 =?us-ascii?Q?DCw48FfJbzyQ7ohetkp3fq8Kz5qICr5jKd6DEqD0/VNHqgtt/ElgR+QkeUoy?=
 =?us-ascii?Q?THLs6YWr9Vuebiw67SoxG8dPbE0+DjpYEnQ/00LOc1kz3vz29uHdsjDGVmGE?=
 =?us-ascii?Q?G40qTWJEyAzD34TWbR4fTX0T5TwZ/6/z5OUzISyP2yW2gzHslImM6XL0j9Mo?=
 =?us-ascii?Q?vgjLi1fmNFPa997+ZNZz5z3TaRubxvPcYULygu5LgeZPhRYDM0aRz5lut0A2?=
 =?us-ascii?Q?Ol20yuWhHyN3acd0tH4idSNl5nhLOmdIBrPtHGRhIXIUgVken3yJ2BDYy3ni?=
 =?us-ascii?Q?OgN4o3Nll3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6643.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Ibjaa03mnq5rS4M4OShUkLTZgxt1q4eVUrH6ECKtaXUlcEAH5mglvWXFJFu?=
 =?us-ascii?Q?SVVZGPhOxw9A1GDMkwKjJMLjBHB1+WElrnGFwV4QQTNaDUYIkjUyxQ72Cnw9?=
 =?us-ascii?Q?queX3SXcFieMEWco8KUTsdsZdgMuvZHNGSj0dcgWDY0NmJ40ea3wDpB7bQ38?=
 =?us-ascii?Q?YXR1OdD1qgn5r/KryPGILhIAkGDfA5QmbOu5T10XsRcuW+Upxq1mrZpuYvjC?=
 =?us-ascii?Q?j1ClYbkgBet9QBuOYftrjvD5qlrxStUN147MoexLjrJGF7+yWFnwv0q+4gB1?=
 =?us-ascii?Q?frfnAtstBtDKvynYY9LO4ssffeiexTMCEptftf+vpoNzz8JHRYquQGth3QLb?=
 =?us-ascii?Q?285STnOF+PBzS0hXULB+KrA1J7nwBSb/1D9UFyFwHMIMdfN+nkU0aTDhJqG3?=
 =?us-ascii?Q?loa+iBA+Uq7E7wkAOM67y/UDbPTj7N5/M+la3a6d4noQELeCYWyr1V1fkFgB?=
 =?us-ascii?Q?y8kjC8L/ymktX7eKMehAqvQdgLd7fTG1+LoWXEL/Y316EEeHrdFRQ+fgMvJl?=
 =?us-ascii?Q?XYDW9AQDehvCqMvziOUa72PwQWMC6V+14uvuc1VHPsacu6Aq0eQPfAqEhRRn?=
 =?us-ascii?Q?VF/kxiLFQOTtQof6Ba9njuYs1AkpXhRlYvC4FsamwTk5YF/sZIxYkR4n0jrJ?=
 =?us-ascii?Q?ojWufl3S924/boyduQgd4Vk8OcxYIj6VcaWO7IbVOgwv/ur9U6ZySrk7hnbk?=
 =?us-ascii?Q?TCXNZ+dthNa9Z4e7YBfH8s2Qr9hM9vZYhZqhXgxoXG/2GAvWG1KCeBbbapiD?=
 =?us-ascii?Q?kc95O6YpGI/Hc4rk3JyibAaE1X4pi8najufDIpOgx1TwxG6V+c44bmoPAo8M?=
 =?us-ascii?Q?rFP+y/iLuCwXQkUxeOdqfsG7NLLB3c52d+Vw9EYe9W7+M3n0npf33ZZFTamC?=
 =?us-ascii?Q?yErVT6CMpLQvN148M8OU/xp1SrA7O13dp5+crSq0E0FnkLfOlFudkH6xT/nA?=
 =?us-ascii?Q?ZcubeVVcRMbn4nfecQPNm5Gf8dkNY2SVIHnMgQpFGRrtNzNz2+F92PPdpaDC?=
 =?us-ascii?Q?DzuKGmI4O6c7DiYPPQlC7C4yFTQcAAJQH/SYJT6e6xl32dGeA+2Kx7mw87cG?=
 =?us-ascii?Q?iXoPT4OFBKSookMfCX2g5wahjMf53kfnbJEWbPRuDHbi9GivPmMmYn6mqsO/?=
 =?us-ascii?Q?ePCKG9BfXSDQwhhimLYs6EffXiznMxJ+2euxENKyvul7tGCbDsQuSRmrMt+S?=
 =?us-ascii?Q?+j6ueFvIB3oK7+kbRy9m8+lrx+BIEGxZATCMN1luOQaxBR/pmQ8gKKtvpKog?=
 =?us-ascii?Q?H+SK+BBYgWYFknI5/HQc9nQjdelCiB0L7nX8lCjl4plEwCv8/MWf3b6SZ2IR?=
 =?us-ascii?Q?/MdFIZmRZTe4D9IER/Ebv0h49UfAjd7CAHRrf05e6GEHt8y6Q2m9XoDWSvQ0?=
 =?us-ascii?Q?2XZl7h03jBPzYoa4DEkzdzCCZSvzbXei5We1TzzILiKjlSVS4OUA4mQ6Gk13?=
 =?us-ascii?Q?Dlm4+o8VjNbqOVVKT9IY5s6sAsfca/muHQNiCNLUgRc3LRiYB65xIzmrl6G9?=
 =?us-ascii?Q?QgxxjVEiqcsbi0slavNPIqACLnU8j/NdM7NAL4KEj4RJwav5+9OQCqICFT+f?=
 =?us-ascii?Q?jJShcSnZ827kbEIeF733PVMeej8PQQs7C2ISTjsO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af81f54d-146b-4689-52b4-08dd8c1a074b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6643.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 21:15:57.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MH219jFJ7jBbCQjxIX/ZZk8YdiThigtRHeeVUtAp5nnWKID13BGIYPV5ONIy2gPvlbzmo42aGJszGM2wqPlkjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426

Generally PASID support requires ACS settings that usually create
single device groups, but there are some niche cases where we can get
multi-device groups and still have working PASID support. The primary
issue is that PCI switches are not required to treat PASID tagged TLPs
specially so appropriate ACS settings are required to route all TLPs to
the host bridge if PASID is going to work properly.

pci_enable_pasid() does check that each device that will use PASID has
the proper ACS settings to achieve this routing.

However, no-PASID devices can be combined with PASID capable devices
within the same topology using non-uniform ACS settings. In this case
the no-PASID devices may not have strict route to host ACS flags and
end up being grouped with the PASID devices.

This configuration fails to allow use of the PASID within the iommu
core code which wrongly checks if the no-PASID device supports PASID.

Fix this by ignoring no-PASID devices during the PASID validation. They
will never issue a PASID TLP anyhow so they can be ignored.

Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
Cc: stable@vger.kernel.org
Signed-off-by: Tushar Dave <tdave@nvidia.com>
---

changes in v3:
- addressed review comment from Vasant.

 drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 60aed01e54f2..636fc68a8ec0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3329,10 +3329,12 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev,
-						 pasid, NULL);
-		if (ret)
-			goto err_revert;
+		if (device->dev->iommu->max_pasids > 0) {
+			ret = domain->ops->set_dev_pasid(domain, device->dev,
+							 pasid, NULL);
+			if (ret)
+				goto err_revert;
+		}
 	}
 
 	return 0;
@@ -3342,7 +3344,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	for_each_group_device(group, device) {
 		if (device == last_gdev)
 			break;
-		iommu_remove_dev_pasid(device->dev, pasid, domain);
+		if (device->dev->iommu->max_pasids > 0)
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3353,8 +3356,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 {
 	struct group_device *device;
 
-	for_each_group_device(group, device)
-		iommu_remove_dev_pasid(device->dev, pasid, domain);
+	for_each_group_device(group, device) {
+		if (device->dev->iommu->max_pasids > 0)
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
+	}
 }
 
 /*
@@ -3391,7 +3396,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
-		if (pasid >= device->dev->iommu->max_pasids) {
+		/*
+		 * Skip PASID validation for devices without PASID support
+		 * (max_pasids = 0). These devices cannot issue transactions
+		 * with PASID, so they don't affect group's PASID usage.
+		 */
+		if ((device->dev->iommu->max_pasids > 0) &&
+		    (pasid >= device->dev->iommu->max_pasids)) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}
-- 
2.34.1


