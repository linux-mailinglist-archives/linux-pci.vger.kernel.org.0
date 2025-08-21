Return-Path: <linux-pci+bounces-34470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832BDB2FE75
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7D11C215AB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F0277CA2;
	Thu, 21 Aug 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0gS56na"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE5277017;
	Thu, 21 Aug 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789748; cv=fail; b=eq5HcUpA6xQhCCusXpY65Idw838CMoOFpLYdnK4TW3TJosl/0YMgP5232E9ILpYJFDJY/SRH08TL/awsblP9yzGpeFOG8dvfNhGxm7EgOFUmnR0BOMu5ImMvSKOa1fELXb6eFIeh+mAV4feg79kfAQs/zT1NQ8N/B7ar0Mv2NM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789748; c=relaxed/simple;
	bh=jbdzGgH+rY16fvgiBSg4Dzh42XQm9Bl3UQZa9yiO/d8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5u0FUnGcLJQaM4a1Nc+mWta+K89+sS8k5zemTM1cIWXBWVlLYoehYtywb+gE2g4DDev2IRxOOX7exXjqqoybeuQ+z9NAeTmZIa+EWTVSXNNljOreWJHJCwbUFoyn2rKM25OrBVNpqirCzlC7EzVqn+j3S0ljdXyS37YQPxMvbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0gS56na; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrVWBU0A8tfwtVsqeHHBXW3qT16FCEkQlIvuE5aXwRy2bLqDfXjq1G+asA0bcmu2qwUTXH5rpmM7g0Zih73lZH+hnmm3lQpdJA5ZeErDSxzkHE727C0SlIDNOOH6pU9lGFsDla2vXTaqrlYrUpyqPyHtVtARLMjmSjKyiIWCHQ+iVEExCgXQ8gm2QFrL3eUjVFoUGTUzKl/2gjXtfwRir7k3H/sZcXiOstCvJhjRMRjrAFVlMomwhFiq0rS49c/ySppxZZP75+JPtLE2OC5PJdp0QW22xOiFz/xDsA8e4dhqsrIIpd2iH06lQlawpDeDiiSrqKqeW1ExMnMGmOoMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUqfvz8d9K9ODltIL+LeaCIsA/d4p1xyaHIX6SU9BUk=;
 b=bLUxD8jrtgop9JbLIilOXe2v1CQfQN3mWWJGApbrDD5K18UGzSXEwPK99UU86RZ2cIfNKcg0yxNh/VKONIPqn84OuI8xNxPQsd5iL3AHW+YeiC9Rx+kzV8NvH6lzQSl3mIXwLVB2hPnjS0Eo/SHCFLFlS5KG534dkbRsLExQteOacB4LBwEDI+V1u68iURIn1Tn9MzwEb1r/Tg7NNIUWqfyrHL0c6EeKu119pja721ksbSaspB0Y65EFMSJn6ZVuAEVxYenZAt0g8/dQK/ju8/Jh9FMdQB6dYhNGkC8hXFx3d0Is2FHawey2l9S7WZipjUGS1N+NIjvsRQsRcwjfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUqfvz8d9K9ODltIL+LeaCIsA/d4p1xyaHIX6SU9BUk=;
 b=e0gS56nawReNppy5OTvkhCLiwDrilBYOLlC18blDKLpY9y23925184TDgXbH0ZZmqffpHzCK3GDdLQ/8LtA/e4Ar0HdzhS181cVXE5wI5YBrIn3q7XGiFsx5UbdPHn8z1J/BzaxV65WpRxIlD50w6KDv6lijyc2Wi001sIaDA3mbg1QVHYBiv4JVejCCdY/mNnsQ2f4dv86SftTZ8p0gVgPe6BmwtvTztkVMno/Ujf822u4Y+RKkuava9F89DbM7RK5ehdTlz4vwD5O2B9fSCGSHOtAI3KQZNfRkeHlR/SAfjHsW/9JmpmFwoBxaC78jGLJkifC1te1r9nwpdeBcaQ==
Received: from BYAPR01CA0007.prod.exchangelabs.com (2603:10b6:a02:80::20) by
 CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 15:22:23 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::d6) by BYAPR01CA0007.outlook.office365.com
 (2603:10b6:a02:80::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 15:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 15:22:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 21 Aug
 2025 08:22:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 21 Aug 2025 08:22:08 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 21 Aug 2025 08:22:07 -0700
Date: Thu, 21 Aug 2025 08:22:06 -0700
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
Message-ID: <aKc5niDWTwaCInH2@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <20250818143949.GO802098@nvidia.com>
 <aKNhIr08fK+xIYcg@Asurada-Nvidia>
 <20250818234241.GF802098@nvidia.com>
 <aKQG9/skig6F8LdQ@Asurada-Nvidia>
 <20250819125249.GG802098@nvidia.com>
 <aKSyzI9Xz3J0nhfk@Asurada-Nvidia>
 <20250821131304.GM802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821131304.GM802098@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 915b38c3-4cdc-4ff6-6f14-08dde0c68744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0utZ2LvmVrNGPlF499/MZ1M6jAdl87UEMGZGIydoGkZBt+Y2lXzYFcrRnWgT?=
 =?us-ascii?Q?qatAkIhU8DwHYy/oN0owuRJoS+eeUaCYT6R5N0gpen3sJKNunRQaEr61azuJ?=
 =?us-ascii?Q?JMJkFkVRUdRaxwlRQKCvu4Devr8gNiUsRhgQPUQ3ujJWBuNPqMQ3Asog2dA0?=
 =?us-ascii?Q?ZrLQApwdXTWEnQadbYgOo8vr2xzE/Wvwv9YKk0UFBKqaARfGefMQw/dW1mOp?=
 =?us-ascii?Q?7HNEmAqAeTIyZmxVqKodb1YGQs9YDRzQVOI/nSlozf47h4WWbRuNrRvuuu9A?=
 =?us-ascii?Q?tQKi3xq27hsPfbs4i7wrD34hUdekLx7mWcpxdLBK83eOoxqDnMMbFf0kWrtd?=
 =?us-ascii?Q?4RN1U0EgfP/3lFN752z0bBNO+KhETkVjbeBjYqUkBrgNKoPRyLwDmkGDiu6S?=
 =?us-ascii?Q?GKbFk1aeOzBPYCOVjNLmvnIXKQ1CzyWmqbs57/04Ly8O0Ubheqhb7raKGFr8?=
 =?us-ascii?Q?g6CfrMTqPhoC0HWAnn7oEfHARPzlIBIVnJsmKHq4AEU6MbW+17p3dmO3IYer?=
 =?us-ascii?Q?awl96rV4FNogVH91+8c6xjIGWvCRg2wh0wtHDTQQ1f1a2DssVmoAz2rlUsq7?=
 =?us-ascii?Q?GsFmZeZkx/tO9o1P0s5bZDcIYAMcOr01PErsJcErApu6fPBxEF7VyDxgDycD?=
 =?us-ascii?Q?7pyqIKW7z+uVUo/JTddSiqUTqJlp7PGN8I86uh6j9XmKQFKUHoZyVtxSnLhz?=
 =?us-ascii?Q?unoEMgzh2Sx5ntlBwt3GOuvEupI812XNe2kFwqPNztNzyJrALHIvm3xGt7Ef?=
 =?us-ascii?Q?cxAfhjVvQyreZmt0mMGWhC7ekuSB/KV2EZVR8fQm7ABUkLYHy5XbLWMxfM5b?=
 =?us-ascii?Q?xbGpNibLzZYlyLe/THdQWC+MrL+NlfjTx7h4NRswDbaolnAGmo3KkVhkNffN?=
 =?us-ascii?Q?xQ3QXt+BtatTcIQBAisLpxInIB59TOu9b8MluvMNlpwfeDECVVMQvX4U1P9Y?=
 =?us-ascii?Q?ZH2MPbIZK+wL1tRxKINJmWtdAxSzICj7sPdVmQWCMMhgORl7VfrU6KQ2Ikr1?=
 =?us-ascii?Q?l8m9GWSMHKBD/TatRi7sRxJMKSDfniW30aoOynVjsTPqXmSxx2yHAZHqhQM3?=
 =?us-ascii?Q?+hIR30Gpd7gqn0eatma307rK4iR0C+xrmB4fbScaQhEN9hXH+ua/nhuc2ZkK?=
 =?us-ascii?Q?yrvWx4Foq9l5LroAfsgBJZuuuREh0SFKo6QfGSEflsxSZxyVkO7wnr45kIG1?=
 =?us-ascii?Q?2xFIGdGkJeXun/5b98IIqPosdfPMvRspia/KSEDKa4gLMpK6zrOiXQuTYz4E?=
 =?us-ascii?Q?p0fEyJT1ndR0Yewv8IMBGvT8m3MT0TqHZTEOwO2pgj/cgaVVBulhXi/h1nx+?=
 =?us-ascii?Q?Da6/YV0doV4eYl0cJ4h8zAYOJjz6YBycopoenDfDxZj3n6B4o1fch0x/ztVt?=
 =?us-ascii?Q?Td1mrCqbk3p+u/keGxzYQewA+YaWlCwF3gI3Cfk7sa4YhFf7foaSwWxccvmc?=
 =?us-ascii?Q?x+WQOrWrmdMoPxdQleW+14GUG+DTJpkNYueFZkbIIv0q3oTuhbZMMPId1FcF?=
 =?us-ascii?Q?KkNQ0Nzj9t7doczcmaCPxUPbIzHCPXjpmtdx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:22:23.3610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915b38c3-4cdc-4ff6-6f14-08dde0c68744
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

On Thu, Aug 21, 2025 at 10:13:04AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 19, 2025 at 10:22:20AM -0700, Nicolin Chen wrote:
> 
> > Yet, I also see some other cases that cannot be helped with the
> > type function. Just listing a few:
> 
> Probably several query functions are needed that can be lock safe
>  
> > 1) domain matching (and type)
> > drivers/gpu/drm/tegra/drm.c:965:        if (domain && domain->type != IOMMU_DOMAIN_IDENTITY &&
> > drivers/gpu/drm/tegra/drm.c:966:            domain != tegra->domain)
> > drivers/gpu/drm/tegra/drm.c-967-                return 0;
> 
> is attached

I should have pasted the full piece:
drivers/gpu/drm/tegra/drm.c-960-	/*
drivers/gpu/drm/tegra/drm.c:961:	 * If the host1x client is already attached to an IOMMU domain that is
drivers/gpu/drm/tegra/drm.c-962-	 * not the shared IOMMU domain, don't try to attach it to a different
drivers/gpu/drm/tegra/drm.c-963-	 * domain. This allows using the IOMMU-backed DMA API.
drivers/gpu/drm/tegra/drm.c-964-	 */
drivers/gpu/drm/tegra/drm.c-965-	if (domain && domain->type != IOMMU_DOMAIN_IDENTITY &&
drivers/gpu/drm/tegra/drm.c-966-	    domain != tegra->domain)

So, the check is two-fold:
1) is attached
2) is the shared IOMMU domain (tegra->domain?)
  
> > 4) map/unmap
> > drivers/net/ipa/ipa_mem.c:465:  domain = iommu_get_domain_for_dev(dev);
> > drivers/net/ipa/ipa_mem.c-466-  if (!domain) {
> > drivers/net/ipa/ipa_mem.c-467-          dev_err(dev, "no IOMMU domain found for IMEM\n");
> > drivers/net/ipa/ipa_mem.c-468-          return -EINVAL;
> > drivers/net/ipa/ipa_mem.c-469-  }
> > drivers/net/ipa/ipa_mem.c-470-
> > drivers/net/ipa/ipa_mem.c-471-  /* Align the address down and the size up to page boundaries */
> > drivers/net/ipa/ipa_mem.c-472-  phys = addr & PAGE_MASK;
> > drivers/net/ipa/ipa_mem.c-473-  size = PAGE_ALIGN(size + addr - phys);
> > drivers/net/ipa/ipa_mem.c-474-  iova = phys;    /* We just want a direct mapping */
> > drivers/net/ipa/ipa_mem.c-475-
> > drivers/net/ipa/ipa_mem.c-476-  ret = iommu_map(domain, iova, phys, size, IOMMU_READ | IOMMU_WRITE,
> > ...
> > drivers/net/ipa/ipa_mem.c:495:  domain = iommu_get_domain_for_dev(dev);
> > drivers/net/ipa/ipa_mem.c-496-  if (domain) {
> > drivers/net/ipa/ipa_mem.c-497-          size_t size;
> > drivers/net/ipa/ipa_mem.c-498-
> > drivers/net/ipa/ipa_mem.c-499-          size = iommu_unmap(domain, ipa->imem_iova, ipa->imem_size);
> 
> Broken! Illegal to call iommu_map on a DMA API domain.
> 
> This is exactly the sort of abuse I would like to see made imposible :(
> 
> If it really needs something like this then it needs a proper dma api
> interface to do it and properly reserve the iova from the allocator.

Yea. This particular case is forcing a direct mapping for a small
piece of memory. So it should probably be described in the Device
Tree v.s. the of_match_table data in the driver, so that _of core
would allocate an IOMMU_RESV_DIRECT.

Overall, I feel this would be a big project yet arguably for a low
reward..

Nicolin

