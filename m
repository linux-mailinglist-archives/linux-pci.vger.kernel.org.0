Return-Path: <linux-pci+bounces-27022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE2AA412D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 04:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9244A8790
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 02:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00D13957E;
	Wed, 30 Apr 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+43FHXX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA22DC771;
	Wed, 30 Apr 2025 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981696; cv=fail; b=elENGCoCm6guI3DspTHyllwbDdWDzbRk5rlJpRj5frhtpdvYm3jfSWHRCyZr4PxwY8iTGtNE5bpm5FKKAl+Sdv2ftAVBg6OnENRWXqUUElKGh6cWn1hW/vnXLUfZrXV88jVE3Acp/6RuDJabTi4UVYLkw0xz5QkQ2g1sEgqIp7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981696; c=relaxed/simple;
	bh=C23zHjwihnNFHKuPLP+/H0NorRi1zCg7M5IJ4urWJeE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hm/GLT+6oDVquIO2AeTlfqM52igaMPexd1ZTeM1lhtSlKDAs0ieETHmOoQyWZJRMh3zkk5pSpIFEZ4UnVIgk+suvobRxooyOnEl1PKU2ex85XFxrkQDOJs5hEZ872PsfKner66ueHhO98oc9b0z+zTKX0eill6WcxsrLjgeIc5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U+43FHXX; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNsuWkJ5tSlvY5iRNihnuL1R0Svlns8kouhzrNLUWNIv9X4yuec9rFuYVD2735nQ5jg3fnFgWObp567oe4mPSREZiVFLTL7J4aNEmQUtppUqrRZXKQqFLe9IuAwcnPCErwUrEphwKtaH4vjLdwTdKkN4Wx6tmuZRg4WzBTkJBaBXQTLrV05UBTHsFUiOS/u9FirVrjNSAajs/MlGLF9Hn2ZlITNBAhcgROUm4FySL/VtQ5fZO+FAvVOwfX0X0qnyXytcaqUssBM5r0UuNTdoOBXM4yMjrpd6B7oI5blbnDMpebAnj68/6mV0q9JBenqd9/gf5sCGOsCNbVoveFuJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMLsainZozu7P4+Dt6QFYmjazzIJA9fwgWlUpyF7P2E=;
 b=MNwrTIUAFAVJs8JCK54QZewZnZ9pwuhQ1H49IrDg9WD2A09hn8NwbSXfZOvcKMi5qbFio953lS21FyJSGQDX80ZSAXDqAfP0htnornH9KuD8QaTw6kfO0F/vqzt+sB132fdj6olwMYv6hgf2dJPW0F7yR/qyvdlUOZVL9w1oqGfAuug137Ywo0lJemD/fwc/Hbgea5eNnjs+kmnRJ2NFFS0Q5iO4PIIZ8Hz3H6pj0f7nf0JDaiQSdT9cPgqbua+ATzHSj48JU6VMRHoxVwysy92Jutu+YX60rPgXciEWVYfHIrsmpIMkygEvisyAzySRYTiaYFmW2qCfYRSlzZ39mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMLsainZozu7P4+Dt6QFYmjazzIJA9fwgWlUpyF7P2E=;
 b=U+43FHXXKjuM/zxcj7jMCT8wew2KTdZVDxp8+NGeEdXLqLzCzFSk2zNUJa/xUWJTWQ3pG1JNpblb7YOfRYpGcgKtaf3A/SJKeeNSNCuCDShq4zh4WUmGelgPRShD1SUR0+Dx/lkoijI2//CsLISLWdur25AV+OnVFJyMLTljJnL1YD5XvWrfTfmnYLMQDDNJyj3U58w6/dZ0wYcqSPKCso4TnZb0/f2R84wjCU+fu/Q6rCo1U9roVkTL9PP/BBl+PoWOvGC4lr5knYywKsBasMZTWp3CCV/x4SLr1bhHDc8v5MHaduAZbcIP3qsANBrJ9Zoysf7M+t3hltBV+8CdWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 30 Apr
 2025 02:54:51 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%3]) with mapi id 15.20.8678.033; Wed, 30 Apr 2025
 02:54:50 +0000
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
Subject: [PATCH v2 rc] iommu: Skip PASID validation for devices without PASID capability
Date: Tue, 29 Apr 2025 19:54:26 -0700
Message-Id: <20250430025426.976139-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b67803-886f-41e8-49f3-08dd87926041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?osWBfFYvIJxDAKyhjt2suOVp2eDdb8GoWkwmsoT0FlhQ9atMpc86ITiGRwD4?=
 =?us-ascii?Q?LcBL+nYeFjy0kMkewEv7EXF1p2U3P2lkgD+VjlUmRCH5M33vvcce/ENMS38d?=
 =?us-ascii?Q?JWx1Jc7Lgm94xvelTKKpFZdZwzGFQnBDrbPvwr/cTlmKpD993KoXwo3vxPIf?=
 =?us-ascii?Q?iEK7NhHXKWUTSX87YZ+saExW6dE000u5obp0FPednNEB1LdafGtfn/3ZtTuo?=
 =?us-ascii?Q?fcf5qAjtEj/YSb+Pqk3t477wbNsIMddjpa3G3TH84PCZtDIgtA68b4BR7uIx?=
 =?us-ascii?Q?lznvSJg4rtqNYms6/QIKLxagPFQJVWBxEKyTNswTZJNONOthbdW+YKZ5zGyo?=
 =?us-ascii?Q?oXm1X1ngPc4J7WgKmsqga6AJPsidLLcykTa1sRG/z/G9CxQcWPwjm4Tn2dc6?=
 =?us-ascii?Q?KxCdOjuKLk95OkfK0gkcaIdGocwV58jBX+5b9BMn9cEdWwdKw2KobaDVTdgU?=
 =?us-ascii?Q?vBeyiJDNiX9YT0PPn7rbiMNCD1FymJP6Ij2O5Db/m9Ii5RubgOTwWOUcXFy4?=
 =?us-ascii?Q?4mkNZa5/ZBOxo1/g/VbBUnX67qw8D7DxHD6PqcGDM7OVm6JVLlA3n0HeQYns?=
 =?us-ascii?Q?mYci/3izEPhHAER5wFwkrMajIO6LZq5g+ZSg3yZD0SmAxSNFVlq2GQhBre0U?=
 =?us-ascii?Q?lZ9uPHiZJyCL8J/dkT7G4cJyO4+XOOTcyalo029hQMcL171owipDOUMEwJ6S?=
 =?us-ascii?Q?fF4OCeIxXUlbOhRnNJ5/2wJt1ywll4A1Bj+7n7NBV2bYDYR+kthbfOXijEt1?=
 =?us-ascii?Q?NVCNfUiZ0diX9P1OuBjsHSnLXzb6zoa8XODuEXFSCY4tbpNoR+wKNTK8SjOC?=
 =?us-ascii?Q?72/vFwYK4eiubIp1K3DMc6vu5zUMaqTQKJiGvfh4O/uXe0UGU5WZk6P28lK4?=
 =?us-ascii?Q?jAFc9dT/zgyj2TC6FesPXVSp470ka2/vvGfms+7Sr+qurQP6mJW4WklteRyv?=
 =?us-ascii?Q?xkiUhq4gi74FeNiJpAlvPFEy/vs5KrFATkNrx3fEWNa8T5PFzl9JNa0yTvf6?=
 =?us-ascii?Q?C78lVUW4lXq4Dr8JhKgfQCaG3cZSCnBtOfnCvi/GSL/VIjcldecTy5zHXBtn?=
 =?us-ascii?Q?j+1MLeEWOD+CuIbMGki/DS41fQIgy6791fZAB5QdODf0XqG+49taIT9H80Vf?=
 =?us-ascii?Q?0kTPRR0POvccpkzY7w5e59kMx9nPX8vVdJjubTKTF9woyfYJKizICRIRQGvb?=
 =?us-ascii?Q?+pHAeuof+V8pJEqyhGuqKPqO0zfpMZvqDJLJSDPPh+0keLTrDV0iW3qtOpsr?=
 =?us-ascii?Q?TjyXKzIqSW4bq2hd8iG6yWt+IsTYN8BMqd/2FWtq4aKv2Dz+9iSeVzEszUXL?=
 =?us-ascii?Q?Fq4TNaj3jkje02Q8XOR6dMgYHBueI+M/c0HyZAwdUwf3hr0EAqEL13MzDkBH?=
 =?us-ascii?Q?hXWHO/RBuaLy/vDWN4yw9+q7cmLxJ5Opx0AGl1+5apGbLUWwI7PlhGWzG9wm?=
 =?us-ascii?Q?TmeE3AEMD24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1bn2JdL5CPQDJ6ulSuP0V0UGLxnAU0CG/KEXC5AxGh6jZVgl+TIhdUgtTjo?=
 =?us-ascii?Q?FmT638Urj+mJkEuGOSvotHNyA0nMJ+WUmGM7JanYT0Bo7ZenFWMpyrwUgvp5?=
 =?us-ascii?Q?GstsqjElapEqyBpD1XzBRTnTdu1zKZCp3I0AESJlZb+ERxfyZcMnOroA8hNp?=
 =?us-ascii?Q?q2KilaI2ahw2xH4fR+Brkv4Qk2kMyKl12Bjx/1rsNOJf3FnJzsjX/Jab4r75?=
 =?us-ascii?Q?0V/VQ8R3Ufts4vsj1aurRoReaqOK9T72I2+mzVmzb9w9Al0T31/Cg3DWxzz3?=
 =?us-ascii?Q?DZ0VpS9GLIPCrDyXAsgNBahuav08zGtwQ2iILUSj0IImipyZSkOg65Pw68qr?=
 =?us-ascii?Q?vEkVz1gOnDSIPm+NQJSQWZF62mhi1eGt/7lR56y7XxJ21vVmkuUp7QXF8QNh?=
 =?us-ascii?Q?IkcU2P0lFOKSbuDAoNIp/G54cyHjv9FAqlf02AKvPXb2n8EoBVzkGV9Aqtgm?=
 =?us-ascii?Q?5+encU7DROhqBKPP3oDOV9ac3RwYhKPN3Oh/iN3ccsIWR7ONCJ6yA9cZRr31?=
 =?us-ascii?Q?sFDsQGC+UNluvmbwVjYVDeDMJwn117PMxvIEpEAzytMAwE9W5YGL9rDnieG7?=
 =?us-ascii?Q?FD0XSPtrPIDIPYMCioh04OI1S4XsiiorfA1Ye92mgapeyR/IjqytqwX97bvv?=
 =?us-ascii?Q?1Mk9prnbTMfTsA2/O3QFC+Ie7gDQJYYbikgfqVEsGZguPzPOvWcu193rcoNG?=
 =?us-ascii?Q?NYLxAzqAA5gVx9knBrUHRtKkBY1uVRb7Vp3pyLMmdEUsdahY1bCODRbw7fI7?=
 =?us-ascii?Q?kweh+px6j1vqDuF7AXnR6ApyR626FFV8jS7uuHVJmGpUz4ptqmFxZZjCgBJF?=
 =?us-ascii?Q?k2fvaCfEZ44Iwwv5CiyyBQKkugSwySpkldMuHKV+ifx61b/fDRE1jn+NzfFP?=
 =?us-ascii?Q?7ZTuVEPwu6x7JxdmkgnmPMimSaaw/lCRGS+xlkZrkguf1Q/K0WPS9wB1fdyp?=
 =?us-ascii?Q?xLerKJZFdbAEIWg+BvTH3fIzvDg5Z+0MWSmq63ctIr8o3mwAfp2aYiVNl35y?=
 =?us-ascii?Q?RotF8tgmc1mP5FByvWZS6ix7L9Bkt4YySBCmc9WWetgeSnMWJnZaBGFT319g?=
 =?us-ascii?Q?LuDg2x+i1kcrvTKyYuf7I613KdnbVoYFrmQY+25IUwtBpC+9k4TYGGz28YN/?=
 =?us-ascii?Q?Jlf2TPi+z13uuGKWu/VMASvxXksqBfywOnCKqeCY88yxw609EbdELZ8cH7Ee?=
 =?us-ascii?Q?BZEbBjiHqJM2vNxJcLd3GdaK7L1EjgdrxOF6dCAL3wU3mqB3a9VyxNqMG8vR?=
 =?us-ascii?Q?NCSLj4WmmsWMFuviyaXYgd2msS97AwLJoPX6bYSqv2SE1YlcaFCKmRbb161P?=
 =?us-ascii?Q?Ioj1NmczV40or+C4Ku7acK4YIUcig91L4txp1R9nzDKuseXSFkIUtaZVu4U2?=
 =?us-ascii?Q?xjprmPvApJVYozx1JR4b5s5rS8SpXn6GD5aUGmA4DIcZ3IMHE0xEEJPSzjkh?=
 =?us-ascii?Q?DPs29ZMJGUzreyKZ3ZhXc38YZfTKoNlIc3ePBXGhFdNdG0b2UoaM7mHuhH5/?=
 =?us-ascii?Q?cGndHNQ5PCamNTElPlTr5F9y92WokRxYYF084aYCyIEKRkdzFmHfS7UQ8lXT?=
 =?us-ascii?Q?y8Ww81hPfYgBHhEFKVSyUDPpRP7nrWhtEBx0Bskw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b67803-886f-41e8-49f3-08dd87926041
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 02:54:50.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot5GaQiLn5U7eUMV8TS0x1DrATfDHqDLL9Zum75w1NTpwARFtfpurIAJ/3gmbLqCLiIJQL0TpG6LE7CSqYYFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020

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

changes in v2:
- added no-pasid check in __iommu_set_group_pasid and __iommu_remove_group_pasid

 drivers/iommu/iommu.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 60aed01e54f2..8251b07f4022 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3329,8 +3329,9 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	int ret;
 
 	for_each_group_device(group, device) {
-		ret = domain->ops->set_dev_pasid(domain, device->dev,
-						 pasid, NULL);
+		if (device->dev->iommu->max_pasids > 0)
+			ret = domain->ops->set_dev_pasid(domain, device->dev,
+							 pasid, NULL);
 		if (ret)
 			goto err_revert;
 	}
@@ -3342,7 +3343,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 	for_each_group_device(group, device) {
 		if (device == last_gdev)
 			break;
-		iommu_remove_dev_pasid(device->dev, pasid, domain);
+		if (device->dev->iommu->max_pasids > 0)
+			iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3353,8 +3355,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
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
@@ -3391,7 +3395,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
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


