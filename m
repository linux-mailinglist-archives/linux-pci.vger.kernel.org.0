Return-Path: <linux-pci+bounces-34615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7BDB32273
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571BE1D647EC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C22BF015;
	Fri, 22 Aug 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjEAWOvJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40008299A90;
	Fri, 22 Aug 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888689; cv=fail; b=JHl++kcOezy8Rvp1KP5yLVN7yYkxVeyi/luPakHa2nV51Rtoz1A53dDpGDyhyc4DZjVjnxv2zjLGfVKQAmxUBbNTlCtbH58E2c74ZMevBj2XdrIhwcuTt/9rCocKAitij55HcXme2tTV2t/q7wRXQRP9EVwOqtNjXAnxDlr8JwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888689; c=relaxed/simple;
	bh=1rAnXX0H2ON1Lh20LfT2X+K0gIMJKJ2V63+5lj75nhk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTS17zXqRFeictWaXxY9mXc5N8PWaEqaqpoJNgJ+YEIo9FMBH9EvKa03b+0twgQmBtssfpFBacLUQ6GE42w3/jIgGAMd6KYAixiXMLRN5mcqr/cS9eRs5lAfqByNy39AiYud1hl+J4bcbOXlhq131MpQzKDraEqAzWQ288SjBn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjEAWOvJ; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTWsjEZ+/0EndzCwcvH9w6ArGbgEdDKdzl8eSaAz9xg9deOnQc8GD6vZfr57eVu6Bs3eIqxRb1/aKZVR8mQk87Vd42HkAZdR7FPEh5VJA7/+VANH6thE6t5o6NbjgL2dnmDtctI8CYRzq+M0F33TGcTxvuuzA8jnMV+zVHE+xyR5KQ39J/DTbRHlmguo9vtaeLQ35RRX2lG821oyXn2J5xZKnRm4uIesM3dTDf5UOLLVO3qXZzamVx6PcTv3y6ZpzvHWausFWi/jSXOgG0MykGgncousvTyAYgi3ixAd1HfwOq4mB+8fj+N9w9L6Mlmd2p3ZoB+SpHg6G5pBcz72fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqsAVqx2D9fPf18hSHoZHOjMqFsEIFJD0EpmkHZBGjU=;
 b=c27a7TbfigbI4OkO9I8N9C2JO/JOKOvX1ua9M5DKDv2HlqcBo2Y60l2KGgUMt324hS/s14TETlul9zfFaTxIJ49oTaBfsp/pXg+wUhpWgf0BaEV96nG3JLOeNv4ox8WP/v3UAPppt/vS3WYqva09z/J6epa/xrf8Xb87p4DUIQpARhkro8GypH7dzeTza4AC2VdylJfwMW/p1/JSBMHVWAiV4ueuHq+Z33ckc+uYJT1EuI411KVeHcQSD/a8jqEca/jdpwrvj5uBqiGhX3eF0pDW58+A1PzcFTmtnM6IOmXaedeFkIVPpcxycPVrGiyOsjoTgcsm9l10gC9iwp9U9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqsAVqx2D9fPf18hSHoZHOjMqFsEIFJD0EpmkHZBGjU=;
 b=RjEAWOvJg8Fu0AGHqv+UtRlOiU6BrBAXL0eiEP9HETxmxyKg1FirCZ3DCqgr2cNRpIfkSFWJ5Tcuvwz4ZuvfGBbaorj1SbO/ohnpal6UNvxe+M2esQ6e1kLOf+j16B3QpDgZ9HBBt+B4ICzLRDA+RBPk8M9EStpY8PpHC4E+BgTk0yfYDtEhXzh0b+GriCuEgVVIrkfM6Ex8ybGYWxbJcRvtwvrt41NhRhhCdwK1PkSaPrGjmeyhia6RiKHDaSLLE8NulPDTtQtAKIg1UHce/nDRzUrnoGdL7kiSAIrKkkD1YChuuL4JODJbaB1gDrNaMWlJBB4zPksOjW+AkUW+zg==
Received: from MW4PR02CA0003.namprd02.prod.outlook.com (2603:10b6:303:16d::30)
 by DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 18:51:24 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::92) by MW4PR02CA0003.outlook.office365.com
 (2603:10b6:303:16d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 18:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:51:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 11:51:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 11:51:01 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 11:50:59 -0700
Date: Fri, 22 Aug 2025 11:50:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Ethan Zhao <etzhao1900@gmail.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <will@kernel.org>,
	<robin.clark@oss.qualcomm.com>, <yong.wu@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <aKi8EqEp1DKG+h38@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
 <20250821130741.GL802098@nvidia.com>
 <aKgPr3mUcIsd1iuT@Asurada-Nvidia>
 <20250822140821.GE1311579@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822140821.GE1311579@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9d1356-26f5-4af7-21e8-08dde1ace464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9NqNtOQk/XokkfZEOw6E09rWDMnPzWrkLZ6Zy26tNzb2zWG+yZ4ZOOGIrRy?=
 =?us-ascii?Q?OOVS2vR4nr+G1oykLPvNivO7z6tk1VXYdCJ1W18Bl/pdQiLWYKMpn3rPAyrm?=
 =?us-ascii?Q?uaC6jKfNyV/fZnNxixvPafcSanajs0v6R09XpmTqhknpqolCjSX4CU7tpPGk?=
 =?us-ascii?Q?oSKOTdHpk/VbaqFmPqpAsyKgR2AnNBP1s5rB3gNFhuKd2ZigIhztk4kcbHeU?=
 =?us-ascii?Q?OVw3HQoBtfXHjyG3b/dZdqLsLewLy662iLMl1sPof8pehXLKizpbVpH38Eed?=
 =?us-ascii?Q?1Mw/4RGVExlN9DFw1AsZADwsaTuTbveoG5mY9D67fhWqeok+kP94xTPHm26+?=
 =?us-ascii?Q?hJyxjqpviUuHRH2uinFZ8u3yrk8ARIm3WfVMI8PCiO8HBJ4qnUK624XmiYa9?=
 =?us-ascii?Q?jK2+KEtGG0ISahiZb21ThzLHYb1yeCeJ2Q3InPDinCOYXxRe5jUJekJq5jxR?=
 =?us-ascii?Q?TX7L27YG7IWbrhhg6R7wOMrgO+0UL638+CiQEzHfhCF6k8hpwoP0YeM8nkl5?=
 =?us-ascii?Q?w6u0rgJNaAG9tfZL/ayj8apoNyBgh9FDhw3kkFBBYJ7kmSde98fHd6QqFB8C?=
 =?us-ascii?Q?hP9mNsfr2MP3g04ziDFRHFGZgpGOtsVV/YRcVEznkCLpmVU3cTHazsffRlsm?=
 =?us-ascii?Q?cLuYSyUBz3e1ApMnrsTQiq0vwwX5I6Pw8NeL2L756Fmute1bWDPcsK8Vb+VK?=
 =?us-ascii?Q?BvH9scCS/MmC5zHUpP7yYy7jgknbU/oSWCmxhvRoUT3YrEjQEYALeDCVPlV9?=
 =?us-ascii?Q?4CghCW1RdptgsTmxzQ2tcctLOUYKLww6GZgx6yD+EzCmqcU5p1BMQ1GsiLJ1?=
 =?us-ascii?Q?wRUUtFfzH+lAoSqoOwOXxqS5EO7PPttMbQoKsiXy7TZ+vYBben/2fFIFg7yn?=
 =?us-ascii?Q?LhjZEG8UdWJVFZdFCyMmVWSoWovBtJCZ0MX49nu2lNxPKfzyMFIy45WjNBQQ?=
 =?us-ascii?Q?fniVgHXEiK+Z//uQt41ySM0rRAIE6gkQna/qIn71Q1rzjZoY4F30bKuZ4OK6?=
 =?us-ascii?Q?Xn0PHAzPmhjLQ3JL43pam/dIfu3UPm1zh9cE24Vn+Y53WfrN/QvptCGxUKvu?=
 =?us-ascii?Q?UBte+0EYMC6QFf+b9Bebp7bgW4rnURFPlJz1JJ8+zkixrIMNdrLqXD99eDSo?=
 =?us-ascii?Q?qzmWtmeQZHAInMnBA7BMhtVoa/jxuKMe/BKqSjuhJ7FmYbjtygKyYpqHBnFY?=
 =?us-ascii?Q?ne9eeGVNIaSG6JVMcyMmSH7OriOQI26hs2P+vm1zXvAQf4SphbH5BPuZcojq?=
 =?us-ascii?Q?5FH7h5pt61bWEWF4sWawU0I0dgakZHD8gpw7RjC7HKWldEqJjWpFw9WP61Oe?=
 =?us-ascii?Q?NDZSqKHn2sLb54zOayn6YfsCbZYV72yskXUjBU8ehdWjrZdTquFChsU/Av9e?=
 =?us-ascii?Q?FgL8e1NbhFB6U8RihNEASIrZBZEklNQH9xYtpvUVNU2fJCSWgp4UtAlNMlyF?=
 =?us-ascii?Q?qNqZqSIzERLtTvX478NZ5iSq9y4llOn/7i/oplz+MZm44nH4Gz7Y/gdqDk89?=
 =?us-ascii?Q?qka5toPAmz3+MnqmSNI9mGWa9TN9WeYWtDY8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:51:23.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9d1356-26f5-4af7-21e8-08dde1ace464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658

On Fri, Aug 22, 2025 at 11:08:21AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 21, 2025 at 11:35:27PM -0700, Nicolin Chen wrote:
> > On Thu, Aug 21, 2025 at 10:07:41AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 19, 2025 at 02:59:07PM -0700, Nicolin Chen wrote:
> > > >  c) multiple pci_devs with their own RIDs
> > > > 
> > > >     In this case, either FLR or IOMMU only resets the PF. That
> > > >     being said, VFs might be affected since PF is resetting?
> > > >     If there is an issue, I don't see it coming from the IOMMU-
> > > >     level reset..
> > > 
> > > It would still allow the ATS issue from the VF side. The VF could be
> > > pushing an invalidation during the PF reset that will get clobbered.
> > > 
> > > I haven't fully checked but I think Linux doesn't really (easially?)
> > > allow resetting a PF while a VF is present...
> > 
> > Hmm, what if the PF encountered some fault? Does Linux have a choice
> > not to reset PF?
> 
> Upon more reflect I guess outside VFIO I seem to remember the SRIOV
> reset to the PFs will clobber the VFs too and then restore the SRIOV
> configuration in config space to bring them back.

Yea, I see ci_restore_iov_state() called in pci_restore_state().

> > > Arguably if the PF is reset the VFs should have their translations
> > > blocked too.
> > 
> > Yea, that sounds plausible to me. But, prior to that (an IOMMU-level
> > reset), should VFs be first reset at the PCI level?
> 
> PF reset of a SRIOV PF disables the VFs and effectively resets them
> already.

Yea, I was expecting something like a SW reset routine, for each VF,
which would invoke iommu_dev_reset_prepare/_done() individually.

Without that, iommu_dev_reset_prepare/_done() has to iterate all VFs
internally and block them.

> But reaching out to mangle the translation of the VFs means you do
> have to take care not to disrupt anything else the VF owning driver is
> doing since it is fully unaware of this. Ie it could be reattaching to
> something else concurrently.

Hmm, and this is tricky now..

The current version allows deferring the concurrent attach during a
reset. But, as Kevin pointed out, we may have no choice but to fail
any concurrent attach with -EBUSY, because a deferred attach might
fail due to incompatibility triggering a WARN_ON only in done().

This isn't likely a problem for PF, as we can expect its driver not
to do an insane concurrent attach during a reset. But it would be a
very sane case for a VF. So if its driver doesn't retry or defer an
EBUSY-ed attach properly, it would not be restored successfully..

It feels like we need a no-fail re-attach operation, or at least an
unlikely-to-fail one. I recall years ago we tried a can_attach op
to test the compatibility but it didn't get merged. Maybe we'd need
it so that a concurrent attach can test compatibility, allowing the
re-attach in iommu_dev_reset_done() to more likely succeed.

Thanks
Nicolin

