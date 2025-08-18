Return-Path: <linux-pci+bounces-34216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EBAB2AF52
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA1918913A2
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709AB34573F;
	Mon, 18 Aug 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWv1V1YX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7072271453;
	Mon, 18 Aug 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537795; cv=fail; b=u4YuI4z9hOvG8erpLQHi5xt0fsVGr4CoO+8P5ezQbnrirRHRUSmKr+852adO1+vH7jRan0R86SFtmkcgn0vcXI70qObLrTEGYLiDUAP1JLDqggdGsl7M+dgBDpPOoLlRfW71yuKcdqpLHZYbkoqEwFSPBqS5vpfq1Ir6du6xFSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537795; c=relaxed/simple;
	bh=BvlHZemIF1A0y8+7UM4zrKDdLwycZ6JaDO2nAoMY+WQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE8JudefC96TiVXkLYOotjO+pftlK1cI/KTo8IrKC0+7IcvtFyJuz3JWfWbhZuPkkGS3xusRVLogsLk/jHkgA9ElkXcEaUBRJrI2H02GWauYGmHOg9+Tv1BEDzm4MauwSmdGND4DX1zwQl/aYKT/0ak78m7siJxWuwZX5Xo3my8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RWv1V1YX; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2xU2lQMenqoRmpLpUNH84N8SfiZJtlYKF81kId7+Hlfj/qJkN/7WX1YX3q99ItamCbcPD0Qg9OrBOh1PzikZfT9YNIHE5scfFPZKuC0mE8dgxymAftQUqUqLlZet0+3z3hrLedPQXD+obcMDvYE48UD3/l2NIZm+79SB4L5bjmj86SHvDRJiFkkScoHVSkqWvB9MHKl0OSeBUPU+yZEk2/qy5KG4D6yjf+bFxzLXwituj9xIY4xlZXqZeefQ5Xdp3zCDJt5c4yp487XemKUDcr1E/2ZqcS81HE4vfplfufuunfBsyPmkyPxLCZvHs7xHkrgZfoLh/oGAdle5P1uPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ/1GKX7I9jcaqtpEj47wb1wdwU57Htk1dbDHuUN1RM=;
 b=wJjKqxcPJipfsDm4BLUL6DqD9FDHRq8X8enb6sTgpgpI+2E7607LwKi0KMTjDJbX2zNRvU92QQkN9iasacUWmeHJ1a5jENtP3/jIUzW/NpjWGAT+Bi3Seg7/TYDAL/YolPClnB4fgQyRbVsBTKVJn/K1rRunWNkHiGXTiGx70qqlDgZ4m1/Ns9+HdZt5WlNHAGx3XnPJrgl5XvftxRG/bpRlLCxYwuxNe21GsFKvmPk7Rp3IRosrbjTK3eP0xvWu4Eta1yyH74ASG5aAjhf4Dp+/uvE6uWd/XUPA0GpSiLme5Lu6NSNnOJSEw0ccDyhprgdl+x2vIf9FMPI4+UxNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ/1GKX7I9jcaqtpEj47wb1wdwU57Htk1dbDHuUN1RM=;
 b=RWv1V1YXdlePE1FFsxbPsY9pMzbVpGBU5n/1NCj6IjITe1dzPVvOk+rB1jkgRfjbtuQn9rf++dNAYtyttph6iV0gExTa3qF85s5hv8ZYH0kOK0tUfQOy///0KGhSENjVC4NbxZDA95q83rLhpAMB6HfOnF0sfn767y/EohLPtvft6XFVsdsxKx5VXy7aVz2uNxNvDjqkNPfMTEw0Mv2GZumfXTXrjPm7eoVli3TZWWsFe8qlO+HhjMrYf0j7GSpkMenhHcRdk5+u5lsOTQHmhegxNiMkIi7Y/x1cZxb4sHGx+mMPOwSQcSrCANVtlpLUD4eaaVYJ8FM1E/Iy1gIqvg==
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 17:23:09 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::52) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 17:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 17:23:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 18 Aug
 2025 10:22:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 18 Aug 2025 10:22:55 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 18 Aug 2025 10:22:53 -0700
Date: Mon, 18 Aug 2025 10:22:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<will@kernel.org>, <robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aKNhIr08fK+xIYcg@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250818143949.GO802098@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cad0fd6-25d6-42ef-cca1-08ddde7be731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tDalc923Lh4Zk2pnvFZNIhqkaLGYpx+VeftIXcKV/HUvqh7Z6fXpGFy0E4GX?=
 =?us-ascii?Q?6FvQ4N+ysC02DzkMKu9ZM6WprVtdx6dJCniTUSg1fiw16QSeGv259m+cwzY3?=
 =?us-ascii?Q?eFf7cuZPj5WUmy+9SPEcn9WyPwE8CM7bPRrfG9n9Bxsf8LikbZScGdtBBHJX?=
 =?us-ascii?Q?Chk2zHK8Tf9ZrkOcWV62ciur8P/3vRwC+5/l38g4TUC5AyANi9gV0ye+Wz0s?=
 =?us-ascii?Q?yoeumB4irDWj7OZSn9o3zaVhdrlf8d78PLTRGLkrKmIAXQJTkj1JhB9qzNuj?=
 =?us-ascii?Q?7UM8/lSLxD9sXOR9Yaoags2lFwFpGbgjPTp+8FNjzECPEeslRsdwjel7NkI8?=
 =?us-ascii?Q?qqN2VaFRLbqsaHe1iLszPlRLQzJ5pxbUdCqXeS2TVzk0O87WiWYiGikaG9lW?=
 =?us-ascii?Q?G7G5tyhm6gHAIG62erqOYlv1Xwy2KFe3w3NXMBmlsbF3Txj4MlsQSjf4qilD?=
 =?us-ascii?Q?ajxyBf6xdncrX9h9EbBGt+LjYgRiE3nmlheR/XvAXv06PspQZyXY9di1q/nM?=
 =?us-ascii?Q?bD0VsbQvbLhBimNIrEX1WKmTaakYeKsLBR7hJQTKbG1bdkBuy4h8NuZMfbXq?=
 =?us-ascii?Q?mhL/3VnzIv3cYeqiXBBCBmKkJSGuipgluCf8r6OhcvB2lmjSFYe6bzpkvwX6?=
 =?us-ascii?Q?HLdMAiFEbrMEqfVA33iPcOtMQkuoc9Ny09M/fOfRjpiUPhSRDXCfFFnZC7O5?=
 =?us-ascii?Q?5YOhdOqQptuuoqW7O3iyCooPdzj8yRSWvlGoC4OvGkxejDdI4hwq37g3uCgX?=
 =?us-ascii?Q?C73iWyi16e+k729JGjlxX6Rpiu0E1wkcrO9VwVdFmCjMvKxtDt/P3CmpHqO/?=
 =?us-ascii?Q?i95AU1UbRwR4hOs8gGEgZMlfeIWviOrqqXqaCTwUr/8fFn4EODTitTNkAmmF?=
 =?us-ascii?Q?tyFhvNdPJ16Lv9AuRRyF0j9bVORVO6ioH/qLTt+wVeuHCNt2NNjE8x4zp6/s?=
 =?us-ascii?Q?qi1wNyf9f9Qe25f3iCQ2RvUyuViZuSqqYurAjGpKxrwiLsctuTPLur5GOfHh?=
 =?us-ascii?Q?R96jjF6gTYRReY5QiFYIlMURlBRt+odsnKhhgb//uHszmtiWNyQF/6RdhMee?=
 =?us-ascii?Q?k0sgfpp0IGK7IznYhjVrfe5ExBYu/Jh+7dbg4ZCrS71K/MEBaGCypWgAqbLV?=
 =?us-ascii?Q?yTrLS2hgCEL03fJ8a3jESHp4Vi+mJ3oF6JPffw2nkvz0NxSsYOKmgR2YULPi?=
 =?us-ascii?Q?crcqSRFFmFxPkDtlt7mE5VvKB8EkDw/A/g6RT4MUGNKM5Ku+MV0oWfVD8+1O?=
 =?us-ascii?Q?5HzanDpKAJL1mCyg9ROsODR8KVS6iFvMFK6jop5iHgNtj0Vrv3kiYQUROpvw?=
 =?us-ascii?Q?epN+TnDsh1nsfRqSqq47zKfTOnHsifAcFCiIWY1yn777uYLV5VEn2qpGdcuE?=
 =?us-ascii?Q?K9XpiN9VNNl5FX+XS8ziFlCCRQre4FkKSIavbck5GkgvNzhmskvr/AbU18br?=
 =?us-ascii?Q?rGx7k8gT2TQPptw7uBztkoerKcd/S0o5NgzziDV1x0oCqICBUygzGpqU9FwD?=
 =?us-ascii?Q?zEWJ6OjEJ7zLl1UkxTse/IoGfC2tlftPCCvi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 17:23:09.5831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cad0fd6-25d6-42ef-cca1-08ddde7be731
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

On Mon, Aug 18, 2025 at 11:39:49AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 11, 2025 at 03:59:10PM -0700, Nicolin Chen wrote:
> 
> > Introduce a new iommu_get_domain_for_dev_locked() helper to be used by
> > those drivers in a context that is already under the protection of the
> > group->mutex, e.g. those attach_dev callback functions. And roll out the
> > new helper to all the existing IOMMU drivers.
> 
> I still don't much care for this, I think it would be better to
> approach this problem by passing the old domain to the driver callback:

Hmm, that was my first attempt before making this patch until...

> > @@ -390,7 +390,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
> >  static int qcom_iommu_identity_attach(struct iommu_domain *identity_domain,
> >  				      struct device *dev)
> >  {
> > -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> > +	struct iommu_domain *domain = iommu_get_domain_for_dev_locked(dev);
> 
> Because this is a very common pattern in drivers.
> 
> Once that is done we can see what calls to iommu_get_domain_for_dev()
> are even left,

... I found that in SMMUv3 driver, iommu_get_domain_for_dev() is
used to get the RID domain for an SVA domain:
    arm_smmu_set_pasid()
    arm_smmu_blocking_set_dev_pasid()

These two are already given an "old" (SVA) domain pointer, FWIW.

So, we may change to passing in the old domain as you suggested,
yet we still have to fix the iommu_get_domain_for_dev() in order
to reflect the RID domain correctly for the driver that calls it
(or even potentially) in some group->mutex locked context where
the RID domain might not be naturally passed in.

> arguably we should be trying to eliminate this badly
> locked thing...

Any suggestion?

I see it inevitable that such an iommu specific flag per-device
would have to take the lock..

Thanks
Nicolin

