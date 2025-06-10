Return-Path: <linux-pci+bounces-29281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D6AD2E51
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B651D189165F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA00279782;
	Tue, 10 Jun 2025 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jj1OO71T"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979521B8FE;
	Tue, 10 Jun 2025 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539247; cv=fail; b=Ap5/RppdDkefS5WzgazaevfAFvHTDRH5NUBmOraTuvvdw9p+M0S6ma9B0CCYIk6AFzsABX1PTvxNO6RaADHYNcljxhXgS4T4RZ88R6JaVx77VkqwldRCmO1+elPVkTXWSKLuubr02ruPseCKb1SU5IGPadg7ryFSAX0rjP7cPtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539247; c=relaxed/simple;
	bh=a+pugF9QQYNs9IhncboohRgF6RJiRrGWyhFsdhhd0Rc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7e36ZqrDz9l7H4HforphQpx40ylFRM7rG2E/7dTqclCX2Vp/1J0jTo1M2Xq+YzVH+4E3t4GvSIlRW9YSvYVqxenswSVF08rKHQvYbHeFzpSHk8AcKQJjOXWezwcdgCAU2b/ApOphPvj5UG+p6R6YHXL0HcjHF9EzBB5aVMAAmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jj1OO71T; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS8uSxo3PqSuFZrybxKchBpkEDtjfdiHX1w3IS9awzjbnc2aEUFbOVAUmKT1/Hyx3OfLY+2exJD4rSAvtmmy3TQlAN7/XZ5DPAtFxtnDuF4et8196q+mcvkQ3kAhbDhDr7/kbM3Pud/+yD+yjWI7APOuGGu4WYvNj6NC+nhgMa30+4/qM32kaptrCZG5eALi4sCIAyOPGZ/oq5Y9HoCaZALNQPfDCSULYPC/f6yO8em54T0ff+IvgkMF6fxQNACv5LZyzJy0XIbkfLCNhmBmwp47zUEO7wKuHCfwul7+oIdAfIq+z5wYAJulBHucoK0Rlg6UC7xAKgMjw7COjZXV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbxJt8DqejroFKu1nW6zJybfaXzL4yUztnRGrOHbDP8=;
 b=JsuyP6Tv8m5o6jtoYnsZJ5KVd73bhO+qnlEa8pX+OtRNP+XlbveArT9CNhN+X3iXdOvpgo6KWbahy5mxatd+iWxKHLTCI7iNmTLheBwgjJlti6OmJ2u49Bo/e6Kt8joIodRZCB4ZEnxOMfrpUF8VF7FvCsquOTWmGZp2KyWUx8c1OTz81fPZPUixxGxGJ4YAuc8jiJNBji6jWREsK6zDoTU31d2lxfVewo2ugf/rnTM7/ispvYyQg/O8/Y9F9si2ifsx0M1NiBNaNBkzdBRYID5cbygPSRzbbSgMZn/0SN1F/lbtJXYwb5fQgzYtw9JqkG29hXqMlBGmtwiNKlHtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbxJt8DqejroFKu1nW6zJybfaXzL4yUztnRGrOHbDP8=;
 b=jj1OO71TJUKqdytY62EbHziJEKtnlGfbNriOG2q8oGb6t3gq3zXv7yNyFAwtTiByj9tKnr52K8lubqxwMQefStKfbB8kzjsPkjuCTfGOdoi7j0FvBUa6yO1OWIkjlbVGjxUIX57RXNs3wd6gG7mB8cnR6NvLZLTaAVyP5EXLp68/DeSKurmKI0e28FqQzuMCb8fNSHMDB9zm/FXvGQo4iKS4g12bJ/1cNa/t73wo+Tt3KpG3NuKzlhhRl8frx1siq7suovbRlqZIl7oRoSgMsb5T/MsU6qTalzOPtObDPRwu83fUL1FIuSwjYvmY5+Sm6F1dgQr1ae3HmAouJi+tRA==
Received: from BN9PR03CA0902.namprd03.prod.outlook.com (2603:10b6:408:107::7)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 07:07:20 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::3c) by BN9PR03CA0902.outlook.office365.com
 (2603:10b6:408:107::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Tue,
 10 Jun 2025 07:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 07:07:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 00:07:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 10 Jun 2025 00:07:05 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 10 Jun 2025 00:07:03 -0700
Date: Tue, 10 Jun 2025 00:07:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <bhelgaas@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <aEfZlKNk4xfb41RR@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f7521e-e1c4-4343-dad3-08dda7ed70a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zqY9NLaLOpYhuZrveKdGlRrJCjictjg15FJCbmGF2EQaY2dfGszq5Ifwbo91?=
 =?us-ascii?Q?/jjEjv0dD53fiT3mYUesues5YfZidvJdxRFzwooFHzxqyQ7tEo0P3rH0Ikml?=
 =?us-ascii?Q?PXzEVErfsHD1w3HIA3EsecPCdwZUSpW3F+LkW1nZCFuXqz0lm1zrWfcxzmax?=
 =?us-ascii?Q?94xfQDNXQQ1r9eXmjOHZbRwKgeqO6Pu782qTAJA/IaudojorJ2bnM49/wpeY?=
 =?us-ascii?Q?lxXRB7cTA1rD5vHlXuC/ZHO+UI1TFVEmHo3mzWUwqI1ZC6oeV8I3fO4h60p0?=
 =?us-ascii?Q?ScwmalA3zMkOmJeTkKpBjo3TdhwRbnwTlpqlzhCuLHLtGxkr2TGDccskGNMt?=
 =?us-ascii?Q?M3yc63HZfYesGT/k0m+SJDySGAhtgIhjhucAeMEeLFkzu6kBxOuLUaie5yWR?=
 =?us-ascii?Q?Z2i2/MaTQLjGpFGAkO/I7RCrmpZkyzTXtbd9qpU+vG+hNUzJfxW6O/ycIeMh?=
 =?us-ascii?Q?bo2T9Eyd/nq/uFB486g+GNyuNxYQD5JeJwTUG+pz3RjCiP2689zCXGgwwpRs?=
 =?us-ascii?Q?gGNU52LEM7BQB2IRdvpYCYcaMjHPcZEDT3GzJq9h/lusScpBZwfTbjJs/q1/?=
 =?us-ascii?Q?FMZjd3sP/6dV/O6ulOdb+sBQkueIxqyOopdC55NMQp0bAVmoYSM6Lx10baej?=
 =?us-ascii?Q?Fo5vVeDK4BtswI6uiD2AkqKgiNt7FyY3SDLxb0HO6hJS1yhVhQdwWl1Vwlsx?=
 =?us-ascii?Q?jhoZzsqRkvTZIJRka6oXlufuAUzBjUna4VOqaRGcqUFQF5MOlGUhzpWkDHSL?=
 =?us-ascii?Q?NFBNb/Ok7bJcXcVPwNd0oh+ALIB5cSSdS8w08s/NceC1nivsz5cfEi1RkkCw?=
 =?us-ascii?Q?jSXPkHWKM7UqrXEo5bF7MT6biJpclcM78mv0Qa6Y1LwHFqC6vuMD4x1ZxyP1?=
 =?us-ascii?Q?dF6/Cel3bEEesUL2DaCMp6Wk81eOqa1k2xhwar7bYBiEURpzsky8CfVd7ja/?=
 =?us-ascii?Q?/DpA1FREG5XDwkah7BGPPOCd4zwXZOgPmxo2EVQdqgPTGRudGARNWtKkr3yk?=
 =?us-ascii?Q?VJp/GSLkHrSeMhOn4X3z1ZaHO0hK0UfU3y9qBYfsZCPc1kcegLlw0sTWSH/5?=
 =?us-ascii?Q?TzhSFsOJToYYmcgFDy2ulk6CZqjgBkJKzoAwI06sULv37Gml+ZBy3dbdZ05S?=
 =?us-ascii?Q?1wDy6gI3hdWZUvkuUdUaLC4YG35cGZtQRKZ0DtPWtlMQApGfOp8mFcjPYCwN?=
 =?us-ascii?Q?hdiAxT1wNJZyYPDRDpZ+UeYhO5kCP2AfYqCuvGB6DSc6bMKe6L4pWDY2hg3p?=
 =?us-ascii?Q?uR/rcFw2/0GQONJa70KOz3CjX7a0dqvfK/gIIm+hoZNNjvbZ/p4BT+6Nl2rY?=
 =?us-ascii?Q?1iX01epqIA4giDeIv2IK0vXrtn597yOBDA+1KH0o6zjWiMR6YH1BEd/wgUaK?=
 =?us-ascii?Q?eM8YiRofcaj4PZFUcm7uDDsBwx3QM646fXfOxUW1VIySDaWLI4QFF0v5hPiR?=
 =?us-ascii?Q?++iliLAzRJr0dz2lvFxMesAYqq48r/jj8urgD5KvGh+e4LVAcggels5IgAwQ?=
 =?us-ascii?Q?5Nk2d0kLWfhANTPYr82kkCidHV6KnpGd9HPM?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:07:19.3523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f7521e-e1c4-4343-dad3-08dda7ed70a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

On Tue, Jun 10, 2025 at 12:26:07PM +0800, Baolu Lu wrote:
> On 6/10/25 02:45, Nicolin Chen wrote:
> > +	ops = dev_iommu_ops(dev);
> 
> Should this be protected by group->mutext?

Not seemingly, but should require the iommu_probe_device_lock I
think.

> > +	/*
> > +	 * group->mutex starts
> > +	 *
> > +	 * This has to hold the group mutex until the reset is done, to prevent
> > +	 * any RID or PASID domain attachment/replacement, which otherwise might
> > +	 * re-enable the ATS during the reset cycle.
> > +	 */
> > +	mutex_lock(&group->mutex);
> 
> Is it possible that group has been freed when it reaches here?

It doesn't look very obvious to me which lock we need here. But,
it's a good point that dev->iommu_group is unsafe here. Will dig
a bit later.

> > +void iommu_dev_reset_done(struct device *dev)
> > +{
> > +	struct iommu_group *group = dev->iommu_group;
> > +	const struct iommu_ops *ops;
> > +	unsigned long pasid;
> > +	void *entry;
> > +
> > +	/* Previously unlocked */
> > +	if (!dev_has_iommu(dev))
> > +		return;
> > +	ops = dev_iommu_ops(dev);
> > +	if (!ops->blocked_domain)
> > +		return;
> 
> Should it be a WARN_ON()? As proposed, reset_prepare and reset_done must
> be paired. So if reset_prepare returns failure, reset_done should not be
> called. Or not?

Yea, I agree. Should work like that.

> > +	/* group->mutex held in iommu_dev_reset_prepare() continues from here */
> > +	WARN_ON(!lockdep_is_held(&group->mutex));
> 
> Probably iommu_group_mutex_assert() and move it up?

Yes and not sure (will take another look).

> How about combining these two helpers? Something like,
> 
> int iommu_dev_block_dma_and_action(struct device *dev,
> 		int (*action)(struct pci_dev *dev))
> {
> 	prepare();
> 	action();
> 	done();
> }

That's an interesting idea! So, we wouldn't need to worry about
the pairing.

Thanks!
Nicolin

