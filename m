Return-Path: <linux-pci+bounces-29366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68AAD439B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 22:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5551D17A24F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456A261581;
	Tue, 10 Jun 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MtxlsQEj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C942459E5;
	Tue, 10 Jun 2025 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586787; cv=fail; b=Dwy18PYnNiPYp9YjvengZXhedn9jRknR9Wwrfw5dUcoyTeAwMrE8naH1FsYN6MvEPmIGI84+OCwckq1j7/COS6ABW++CquSu17NKf/vmUlhS71Uc4/F4fg3xZRmqWGO1VK2Hf2oARL/GfdtMarGESk6FAsCceuDLBa8oO0Gi6eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586787; c=relaxed/simple;
	bh=7iNdxONYy1Y2H5t6IFKnsZsnO6+X3yHLLLFe3pECxf4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqBKIcTBpayqr8CZu3GQmFxdLWPdmLthW7THEHnIh6RndZkv7ldgKV16pC+QJPZpL6tUIr5s82Q2qfdhfQ13eZjmyh0CXkJC+Mb8NCZjrOTFUAE6P30wWich4NwJ9tpT0kD+I2yXGbJNkDNm5uyx8MsNl3lNMx/BvN51+JW3Bj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MtxlsQEj; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhM71axMruA7HcBixrBVlxpD478YIaaQANHsufiFVZuvQkWKc0k18h5NCq8WLe6wfHmt1C9eBpN8fm0/UgPpuWVOZygqLE5rOqYVmjHPUHOoJIFp9s9AJLUwDbGWkc/qiRcRjoYEvGFx5EietvQKWWvIgpX0msG0NFGI8rRbZO+1S3YEyXqMjjE4qEzhmu3WJn48RoVG/2DSlWJorVUv79Ih7S/usFw9mtFtm1k5knkqE5qqYFvHR0vQrIhs4mIsKdkZgKEgSwqQXtfFmN7ZQ1fuTiuatyyhvit+xB0X8Olb8Dgz+cgQSDruemHqJP0xVsF4ELJY7Q1sMox05PTPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuI19yv7nziNbmilD1Ped2qXIOUkj5tpAU6xapT5kPw=;
 b=OaPPdSRn0PRKo+Ncq1rvyVq0Uq0GHxqB0SMuyPefDeJ+XcXydcbG9YqSTHOUoBrQwqzboix+mf65a790qV0vagr354IbdLubWA5G4tzZLzOhm7fT6xVdnUk/dRjS2AUh/8IoqL0E4G1z79mBtl1j7nMMnfoE2shhStPYqcU0uMaqd3ZPFEw8qY9bKkjrY9b4NXlMfbhHYmK0nbRGh0nlmECp5+F4BvfvHOVb9umWdfSCgAXU/IR7TSke27DjTxNKoi5kz5rDVWJDqayrDh8iMMa0OeE1T3H6lGJDFg65Kmqcoinza06oL48C/YwJUGgso/UhLdNsXpjSX1QJHT63rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuI19yv7nziNbmilD1Ped2qXIOUkj5tpAU6xapT5kPw=;
 b=MtxlsQEjFOUmtDz2UFEyha0lRNGDJgh2y4Xny7IeoPryP3NOmV0GeNUoyDQ2a9hrINJuEUsfpmHQk7/46gU7N3ST1hiIUdD21IeUV0OmaUxDaUbuehzlKVNi7oaAB8rSCOHM6de4Ul0ijSHdox5fHL9H6rYz+CfiJBEwECtk6G99KR3qsDB1BwISWUJaF4QGQ0IpKaqAnSvkSyAxoalSFvmFPlEPsViYygu4HjwUpZE2rdzdBMzrC385OqxQhKBSgd/3s5LQ5Zj1IL/C+DLT3cg8Mpgmz1Snq55M2uBKUhet6JvWEdWxEUFYFqza3IyPREoO45PK/2EEcnIB6Kh3gA==
Received: from BL1PR13CA0261.namprd13.prod.outlook.com (2603:10b6:208:2ba::26)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.33; Tue, 10 Jun
 2025 20:19:43 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::52) by BL1PR13CA0261.outlook.office365.com
 (2603:10b6:208:2ba::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 10 Jun 2025 20:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 20:19:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 13:19:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 13:19:27 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 13:19:24 -0700
Date: Tue, 10 Jun 2025 13:19:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	<joro@8bytes.org>, <will@kernel.org>, <bhelgaas@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <aEiTSgK/PLVJ1XEz@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
 <aEfZlKNk4xfb41RR@nvidia.com>
 <20250610130416.GC543171@nvidia.com>
 <d22320dd-2695-4f9b-bd72-38eabc1d934f@arm.com>
 <20250610153646.GH543171@nvidia.com>
 <f66bf027-5dbb-473b-b57f-ed3ed7914800@arm.com>
 <20250610164306.GJ543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250610164306.GJ543171@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c99511-d9c3-4993-8fdc-08dda85c2245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U8vFC7QaiaRsodspuSeWnJqIzVbhaXB8qXAA6s3VRTvgf4tgqaHayVOhzIw0?=
 =?us-ascii?Q?mnmlnyBNXEmrAsi+r7G4si7zHUkGw2eDfHERLy1jAL+HUB6bZQ5wOwY8lciI?=
 =?us-ascii?Q?Odq4EwJsen/1GTBazlbxqBvYqncl6cJH9YsNbRHZxCrF0pMXqjczUiu+JY0o?=
 =?us-ascii?Q?s2L/tJXP2wsfpqKulmQ31kd9c8pAp7YqjZu0c+wh48aulzTxJiEbyGVxC+YS?=
 =?us-ascii?Q?c+XyR8r4Gl5qH8pCLP8vqwKDIU+oxXSxZxbvxaxOxIahbNpFr11zG+vlZ+P3?=
 =?us-ascii?Q?y4TWYuCrS8jK6tzYRXfqbkqYBDFPpA7xXWK5t2gYB0nuEU/XuEDBpq9YqaiT?=
 =?us-ascii?Q?Dfe5X6I1dE7QoaO3EaM48EKlGz5iNE6Y5xJLFR32hvpdWN1gvGeQ/1hx3ED0?=
 =?us-ascii?Q?abSmjPW0qkUna22KPqufXbxvaIqr/MLjZMHvXP+aPGEf4TCfGJRKyiDTxk+D?=
 =?us-ascii?Q?OkQOnwt0XosQunBdPG2x44Ci30SOim9z6PXvyUc+i/LyBTXmyHkmKTa1+sPt?=
 =?us-ascii?Q?G8M8JY8Y1r8/d1o0KdmaFnheBjkJUY04RGGbkM2+zYKoqVuSphmGXmVJ/u7T?=
 =?us-ascii?Q?kIqUK10n47JGLR5RuAxTkhF2vGlLJ5/+QLJxE+DlMyMwFVhves5HEKiJLiRL?=
 =?us-ascii?Q?vgelp5U4GrJJafMXWxZZLggvJuoQGBuG81Gospb62iwpQw/R2SdSAqMIIj6u?=
 =?us-ascii?Q?/Zg35Wttedhv8RGHT7fHKd313au9dufoo0I90lyJ0YxuLNYlNs0xG5OYrN0X?=
 =?us-ascii?Q?EMjF3a9Ld3LaD2QNDDVAoD+y4OepFMpBVHdBH6gu1iU1J8hm9WEnGDaIf68s?=
 =?us-ascii?Q?ShkqFtb+Ot0ulqLoqcz9gwnfr8lhJEJNnnDxO8wynmBLi7GZKDhozE78yRDl?=
 =?us-ascii?Q?laA1l4CFm5aTNotsyPU2AAL0EFrDusB/zF9AXiZyKDTGjpCVeaHIO0msxb0I?=
 =?us-ascii?Q?WICoADDj/cvvX7v2EO9F2UR1L+JWQ018gLUemPK8OG9iG6EqM+iN9t2DWjZD?=
 =?us-ascii?Q?Gmfnbz+pAP3aT6avT2sz55bqIYMWX+oBKcijVJ5K8KOLn2e3EoHxPUJ0QGSk?=
 =?us-ascii?Q?NqNYA3Ie7KF4Zth57Z/qbQAEGW1bQqce0YPDdYCUePnpjqwhf+d8+Eoc7L2B?=
 =?us-ascii?Q?tYHvZOhShSsaxGnlV4lDJIpVI39m3/jzTwHhRTFC69oX47PVKUehz1UtwCC4?=
 =?us-ascii?Q?EivYpU+nvL5M0d1+ZyQWVAo6UpdeqWDAKXppiW8owv9wd5LqKWjOKVWyHKGi?=
 =?us-ascii?Q?vLZP1kxtd6o+SPPlWB7cSR0XHfjhaiaElbW2tqb0IRzTSG98QR9wtkICQDRA?=
 =?us-ascii?Q?ER5lpyAhFb2ZUGMkRmxKf6vc986I9ePAsKW9IxPyha0MkuvVr6WRxSty+bCW?=
 =?us-ascii?Q?U62/+IDcpBR/OPHw17ONkxN9JoeErrnj6hcRxtisk+aqTen1vVHY5oXzmHf1?=
 =?us-ascii?Q?FQh4JbRW1FEpnJzWurBAdNYBln2eIH43vGJzp16nE5IWH5SvutC7sOcNRywt?=
 =?us-ascii?Q?oeYI0OsP+AymjY3MaY4GlzNG7ErQKesni8Lv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:19:41.9922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c99511-d9c3-4993-8fdc-08dda85c2245
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331

On Tue, Jun 10, 2025 at 01:43:06PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 10, 2025 at 05:31:09PM +0100, Robin Murphy wrote:
> > From a quick skim I suspect it's probably OK - at least device_del() gets to
> > bus_remove_device()->device_remove_groups() well enough before the
> > BUS_NOTIFY_REMOVED_DEVICE call that triggers iommu_release_device().
> 
> Make sense, Nicolin, a well placed comment explaining this would be
> good

Ack.

> > And on an unrelated thought that's just come to mind, if we ever did FLR
> > with PASIDs enabled, presumably that's going to wipe out the PASID
> > configuration,
> 
> I've always been expecting the PCI FLR code to preserve the config
> space that belongs the iommu subsystem. PASID, ATS, PRI, etc. Never
> looked into it... Nicolin??

Those are the flags in struct pci_dev right?
unsigned int    ats_enabled:1;          /* Address Translation Svc */
unsigned int    pasid_enabled:1;        /* Process Address Space ID */
unsigned int    pri_enabled:1;          /* Page Request Interface */

And pci_restore_state() does the recovery of these bits.

Thanks
Nicolin

