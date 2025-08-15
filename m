Return-Path: <linux-pci+bounces-34116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972DBB285FA
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 20:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC415661E5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11053A935;
	Fri, 15 Aug 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQ4iCv0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843482580CC;
	Fri, 15 Aug 2025 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283706; cv=fail; b=K8gObVERuR4wMNKTL3VK2Ze22MbNxIOx3rX1M/wH3Iwct0bsj0YdTAhSaj+QgGETEhvgqU87r5lbIGginp2sZLqUO3ynWwJlVyXau5WQNTeI1b42arRP+2uFcAFIuFA466eh7VzDOuaa2VEdm8Fg0E/LeOOU6MLZ4QjEVveINC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283706; c=relaxed/simple;
	bh=jOw0u58SKp98/Px09dQHn/m4jJynN6l+1JWrsoOjqNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb8PukVtDkCqlKNIdwlFX6pQPOBw1zemyPAa+pKTZNHWUd5eomngmygjuVl7wVJMvVi2mJzV9glPEIzBVI1ivHWrSmCMFpwnUWgJdAtjs/NqxcGdPKmjTAAZ2SB3LAa8n5/kw5CIVtZXckQ14okvricoY5TNlSFdObxSSLwJlhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQ4iCv0b; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkUCVIJbgGUHMBhLm4tvlCB4mTuzklVu/Kc6eiXaepBSdmoVZoNz22e630XGBHmoU1CjrkDjYyJpEac9iTR/g6ouIgEf+PKzGuBei0zvvoTcT/SNnzEQzHJBDoHgt7lhGlY+stfuhHW3n7nOLA+oUYMITck2eksrQtqpxLjgufeRh49wCkeMcmY25j8OgpBsP/aWNSvyFWgGPgaKn3/MYn8eZRLU90rd0y4pNtyJVFwFsWxUZVomjczhN3VhgCZjRkg0qo8OcC6C/sKcfZGaszSy+PaEfoSxUmmga8pxv50VUWduoSl46rkCaWaBaDHgzTS+yHSNrkxS9qSEJ13nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyMHw8wyI6rlRoSGSKLDMms6LPQ9d6AaFO/6wZthy3E=;
 b=iZQpIIrhXmUCZze8N8YnV3hI6BkdQnsB9WJaIvqChTWJ5ULn3ceDxO1AVrGrwx+bZ11fI9oS62VK9ChJdGOSAEjXKSmF0gfeh6FnJY8LFAjvQl0HX+u4Ls1Y6ZkkjqxLtAHP5ojTgISnU0qCKoZoHLwM920ucn+hQbVMEWKJvV+hk+OPP8i//WYtIMcdk4VguFghQnkpMfbYptujyrnKntUlfaH0hwvRNypkohqrl4MV6oZy8TXbl4tGwbK7jhGkButmstd1c59Ov9jh75VT+Q+zDrw1ulzZuCGY8AfF5xjf2ZA2hAGuQSQQ1a/tt6sMctVlxexEdb96IE+Y7UeARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyMHw8wyI6rlRoSGSKLDMms6LPQ9d6AaFO/6wZthy3E=;
 b=UQ4iCv0bmwr9/6yR5Z53S9DuAB1ltPT8jD8qMnZe0zIF48Y66R5C9Sje9VfApo6QgkwWJPx0/U/5RhkPvtFMpW0JKP/fmzPuW4P/1DTGEoHVLuXdh6+qMJ5JLKNfT69OetVSv23MKghyVVw7pUcq8+LXvtLb99OXf+DhGEf0ts3o9iSqAdOs6IUk4ip7ewcZizVRP1MrwMN/QXZ854ygYT+kp5F4zprx7iy55HAveNqw1Lv+XNosjhvt7FVLdEZr8FLCW5mOigpr9D2GgzJmH9aoMvBJEhxoejb0j34WthkoDIHwKyC8vlKreIJxDho3zzYn4/RJITYAiZpHyPElHA==
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 18:48:22 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::ba) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 18:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 15 Aug 2025 18:48:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 11:48:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 15 Aug 2025 11:48:12 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 15 Aug 2025 11:48:11 -0700
Date: Fri, 15 Aug 2025 11:48:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>, <will@kernel.org>, <robin.clark@oss.qualcomm.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <etzhao1900@gmail.com>
Subject: Re: [PATCH v3 3/5] iommu: Add iommu_get_domain_for_dev_locked()
 helper
Message-ID: <aJ+A6gc7tdS4ETbG@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <a69557026b7e2353bae67104bbe6a88f0682305e.1754952762.git.nicolinc@nvidia.com>
 <aeb04f91-ffce-4092-8dbc-17d116cd7c7e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aeb04f91-ffce-4092-8dbc-17d116cd7c7e@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: b0264efc-5bdf-4687-b2ed-08dddc2c4f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpFkM5kdSRbRqG9V5sHevsFb4eJg4K0LDS1fNcQNLCXE0OCkYvoiW8WysqNl?=
 =?us-ascii?Q?YUOl/2JPnwwYfSuAm3Sd6XWPDu5aDTwaYLcbqImF9eyIE3Ed3uOdPOFCQ69v?=
 =?us-ascii?Q?LeX5PKpbtld5eHMOcQSmkanjC5NzaFtXgXgJ0Dv0EzeZ/MBNF9OWwkE+jHg4?=
 =?us-ascii?Q?E16ZcQ/jTxAHsHmZSSY7Wwhj1Oq8Q1XVqYX+uk7P8kXzZQnLy36W5SqA9cAO?=
 =?us-ascii?Q?wzD+T/TiaYpQ8ABpT5jnwIl55RFMJjr+YfcZwg7XATFd5R/EsMkMTp5mLJC8?=
 =?us-ascii?Q?amudle1eUu1QNiFnI4U1l8wqnWGMbr16GWzPc57f7FKV75F3XkqfX1GtsDPT?=
 =?us-ascii?Q?YPMNqIcXlOob72sp4whjovvI3joddP2aKRFehk/O8yRGmMOue1ZYc3wfz6yq?=
 =?us-ascii?Q?3mvkqp5MNQBQfVFteDd9YXBu9cYYrUTmO0NFKzrykwGYQuLjuTkpMbbjuLJ8?=
 =?us-ascii?Q?S8iN3mmbHmBo4OUKfaG/VqTAKzPdGeq+whnqVAmyTS6aftWQEkXL96ifdsos?=
 =?us-ascii?Q?T33BKgO7IHpLPx0sGeSgsNnOiz5n0+hx9k1/mMv04x4LlpqdvaBwUHoqtI4s?=
 =?us-ascii?Q?gjBFkUnnVoZMkSYe7Wo8TUV2U8jMfSeIHUUCkpVqAVkrIKTWD6j+GVVds/4w?=
 =?us-ascii?Q?g+wOtqSa66Eu5oc4Os5bd1VGS8+DYPKMLCGP/WyeU2L29nb85aVYDGzXu3zn?=
 =?us-ascii?Q?ThkRuAERe5ZO5UjVDrLnryc0l0vrHutkiCLFbueGoWVbKvFqg+DT2cg+kkBB?=
 =?us-ascii?Q?u6GhsCs6u+G7+3pyaG9Ti1K9qKpperGK6AUsGM8AAC8PWr/IRODzNVh8wG0E?=
 =?us-ascii?Q?KnAYDmzBCAyBIrpbVdBgqMSjr0ik5LwES8U0Q+klf0Z+g64iMSG4F0+Try+B?=
 =?us-ascii?Q?mitGRFIgA8gMS8ts8qYJsTN4rP6rNMT8idrdlidX9O75zEzMmDhk6EsLxuzk?=
 =?us-ascii?Q?paYkdU83SzUBPB5PXH/76UG2wTFJyMMlpM/Xwdzn5ifW+ajzmyh96jdOS5Er?=
 =?us-ascii?Q?XA6OunFbt8oa+yJmiIy0bgjq979V+ZHtCCVFB2ATx4rcmPKMN1QAz3MKnHIH?=
 =?us-ascii?Q?tmu18zJ9aOKYQMCZ7GYyTILDEK67Dz94UeGhj+WVYfuOueMpYNXTcA5aHUZI?=
 =?us-ascii?Q?MgQdeU0qDcx8dYAgLCtR8FaOhu5nsdU5txdrEFfsvVx+BPmmpyMKZ3wA9F6T?=
 =?us-ascii?Q?YfubzKUGzbc6Umn1+bdETEyAtiLoH35pVQ/cFgsAyHshrmoaAz/HAXHnKCaV?=
 =?us-ascii?Q?khW7zVgqkLoRWdH893Fp/X7kuNWiQLsIWfr17yqCbhrsshuvuhByfsoSnPqH?=
 =?us-ascii?Q?QPR/dsA+fmuFDajmDxhDl4uvDvSdUnRMt8F+bJdguEVSBtMqbcu15lPpiCcW?=
 =?us-ascii?Q?6wtoI8Ej7B89L8/xn612g0KRce+gkt8c6ztQsB7BPz3/wsFTQ4VAceYHuZFS?=
 =?us-ascii?Q?W0xxvXDnzG5og5oRlKmqdJq06RnapSRuUU1Xw2rA8Oiy+ikeOAO+/GYzhdD5?=
 =?us-ascii?Q?MvnPvUAjW+ejOzunl21HqqWYGAca/993F6Vn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:48:22.0060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0264efc-5bdf-4687-b2ed-08dddc2c4f19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628

On Fri, Aug 15, 2025 at 01:28:02PM +0800, Baolu Lu wrote:
> On 8/12/25 06:59, Nicolin Chen wrote:
> Given that iommu_group->mutex is transparent to the iommu driver, how
> about
> 
> /*
>  * Called only by iommu drivers in the callback context where
>  * group->mutex has already been held by the core.
>  */
> struct iommu_domain *iommu_get_domain_for_dev_internal(struct device *dev)
> {
> 	...
> 	lockdep_assert_held(&group->mutex);
> 	...
> }

I thought about the "_internal" tag, but didn't pick that because
we seem to use that for an internal function inside iommu.c?

I don't have a problem using that though, as it can be noted like
like your writing.

Thanks
Nicolin

