Return-Path: <linux-pci+bounces-33083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD5B14267
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 21:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2847AEE01
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 19:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827B277800;
	Mon, 28 Jul 2025 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mFfijBx2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1C2777E4;
	Mon, 28 Jul 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729703; cv=fail; b=g04aBlxjHZgtwruyCU6qBPJ7eVWZsgScq2no/H0aznWRMXClZmEcbWFjALKHE4HorEVpWWQAcZ965d/GJrtzOtteupUbo2dbqgcvIftCXzCLmiU1Tcn7VETHqR67HNEx/KqLGSwRamNqkszwz126BBcJzXaR8PtGRFBnE6AKpew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729703; c=relaxed/simple;
	bh=jBokoy+KaLMMpzy+/kgbrKHb4VbfkB2Sv33bKxAcGuo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLV9q2zNno7inCePOcFtHgX+uK/8KDliZRd8FGanwyTRfr0SgrCFb/76KyqW6HW2Q3fYsxGJVMRx6Xu0JxEV2IaDCzu9QFil9O6UbzYg36X04HvAyg78d4Q3yy7702vdcwTiaHdyEv1Uqiur4f9ESa8afPnicflz+JotOa6Y2f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mFfijBx2; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzCB7arfk5+HsZLqxFCwUzUXQPPncJpb5bPTi+zsguftYJu6wQqXSm7ChYP+2Llr5uoP3QK0CITbwtsIyyG1ljNN6SD7VohPdhx2A6pNisnKrpqdmk/oQ90e8D2iE1XbKWGBPBgjCGVNn19AWkuEWTYw2Z0n4CLbVR5MM0iPReU0zT0viXuYTlkApDTXPfEb8nYqMgRroyhcD26ODKRuYeSCEObrMhcjgzPTA7dUKXUTEV8VU1fKtpPSPj5Q+YZBgMOMZaOn6IhV2Drs2xUXVg08476B3mrMHQN85fBdElJqZQam8uerXtLQOufMvMB4EQqW+Euz+/f42TD6bxVkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwKHUUHmY+2y1+A48AQrEmXRcvrBpdBpVX99sonaiA8=;
 b=f/k7Q2w22pbgwGxhwsG7fGn1yZHn5mxBL1YJwd/0OTiC2lwxJZIt5Bzwkny+6IdvsAXTEbNpWZ9XfBGStjo5Y9mox8zlttGB8WqZMHqxXVcXMyuw5AqRhnhtZaaJfthjBA0ETqNNAIMxjtjZyqpeG69Al7p5jNmvKokQkQIMYJn18KenrN5SvwiMMR9SvdoMWGaJWuqJl7TyswnoJKHKp65vtXKTLm3JP953fawkhJQlVL29sTjVokf8WDlOce+q6AhRZDipQj9A4AnmfjK3KHIXhJRHZDjTCka0WF3PfxLgWto1//a0q/ICpg6shCMB6Q7J46OkqCSeF9VXlkUOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwKHUUHmY+2y1+A48AQrEmXRcvrBpdBpVX99sonaiA8=;
 b=mFfijBx2u6gIpOToe/c0HmjJ/My6VMtotGpDT6bJrSN6iiXMcMBQ2TAtRUTp778c+g9xzQ/fPMt7hK2BMlzECLbMhcqyL2Tov2gckPlIDaHQO0tpF+/zUdCxlcppUEMu+NJyrdud/Dyg74Fdyg+KFb1CMGGkJI+92Skmbg/XTiFJQ5c3I8U9KBNerqn5xVtC352GyU4fI4EiT7a/Kwd+PxK77sOehxqykQon4vnJUP1qhW9jNv3uxCHJ3KcmJ6pkMspooz5QSOShq06oI8smxahJyqX94LOeBR1noV0vlnuCmEle+5uYPEDmctQEETNYZGHunN5uT6UolSyLeklJzw==
Received: from BYAPR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:40::37)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 19:08:17 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::fc) by BYAPR04CA0024.outlook.office365.com
 (2603:10b6:a03:40::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Mon,
 28 Jul 2025 19:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 19:08:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 28 Jul
 2025 12:08:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Jul 2025 12:08:01 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 28 Jul 2025 12:08:00 -0700
Date: Mon, 28 Jul 2025 12:07:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<patches@lists.linux.dev>, <pjaroszynski@nvidia.com>, <vsethi@nvidia.com>,
	<helgaas@kernel.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <aIfKjyvMeIYac23A@Asurada-Nvidia>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <20250704154342.GN1410929@nvidia.com>
 <aIAJfYMKYKyZZRqx@Asurada-Nvidia>
 <20250727162501.GD7551@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250727162501.GD7551@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a59a7a7-8ea4-4c90-4618-08ddce0a1b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sUDxyXKBJj7I19nv8YB6OcQOJ9Mr72e3LlEqCzbOLjyz8JDa/ULyoTBwWzha?=
 =?us-ascii?Q?CAR4uFG1g+zEOcmeRFT2xf5z8yAJaS6viq3sZLdl2yk5mOMjpMOMSMKQ5fO1?=
 =?us-ascii?Q?+EjgL81wJeWFFf3uegHGzK3QVqKXR3J8S2YBs/IcrzQ4maaogamQZ8JNoz/D?=
 =?us-ascii?Q?rsxhJyFP2VNoAHdIt2RDuHkLz/RLwUlYLww0G/L5ONdHQc+IqAMOuVA3sc/1?=
 =?us-ascii?Q?KRjIrK4eT0FPJ/31CTuGU/JCF6mtGhGhJBP4vsSHj3bZAid4NGVK0YCMBq/w?=
 =?us-ascii?Q?MV943lBBunGgnYApKX5sbMO4b9myTJYLILIXzD5kOtVto0E8ecQvr42WzK+c?=
 =?us-ascii?Q?SYEL1x+6pD+HkUlstGjYWb4ShRiFBNOuaOJeiagsYRO3ChXooAnHv2IlwY+K?=
 =?us-ascii?Q?xhHrAmvOmM40440cFrXO2i/o0q5f4RJ2ZJzBPQjWwOTHCweYQA4SqfGZTjNI?=
 =?us-ascii?Q?BhZmzhWopLBfzI6aPRuJ6XJDLbfhfuuSE9zVlttDMEmaphLpxG7/9sjlhMOz?=
 =?us-ascii?Q?u2lmWWznAG3DIQdRu00jhwJeG7jnceQXrexGahWhj2eowUUgOK3MUQ63XRy+?=
 =?us-ascii?Q?F1UpwJ/ZM3riDEGB2izvvf5mLmSNheax0Hpr5fYAmsvslr+0JKqMFxAR4BKA?=
 =?us-ascii?Q?oE4grPOmrSbW8htWm25wozH6dyBusFa9UMKgw0Ow1CnDeZfS/Iob//T2RNCN?=
 =?us-ascii?Q?Pe65Fa44PGVfkCspg3L/lO51cJTb7rERvoln/fI7SL84axEaRyJwUGe1X1PK?=
 =?us-ascii?Q?b9K47PFnzq1zDzdiIFuyjA6fSxi5TYLpmwLVjD8T4eDZJThqcz+PnrqCY3sj?=
 =?us-ascii?Q?nM99oUthsLMiIx2q1kYq/rrLG9wGpNxHM+DZBznR21YbGx8DXIUgTE9F4h2E?=
 =?us-ascii?Q?zDfjUGBySjhYV0WT0AuflEhv91EDnrXG6QmGCNnnteGxpvUB+yvJDOLEorcP?=
 =?us-ascii?Q?UFGvmTo++kkN+UD01okl9+79Te9X7xm9K+pzqg6uNtI8OaXGD4w0rW7Z8rwR?=
 =?us-ascii?Q?mURMBVnNX2AaxvLdZObG1jrskj+hiS3PikDk41xWdRUe2m+H++VMwdc2DoCi?=
 =?us-ascii?Q?J7r/wKprV73x5GqlSLK0zmBe7n+RZBJ4G2IYofY9r5OhkB/Upbv23b7jtSfj?=
 =?us-ascii?Q?/iQ5x2n7ykKHNtt6UYxW/t9sbsG/1ZzkRpojQB8tSHZc/etR2dOzmzsZ+bsS?=
 =?us-ascii?Q?//rOkaxK7AJs+UMeV3trEKV2aPOFWi6ywbDlkSkarSpjy75s5xYUW8PR6Js7?=
 =?us-ascii?Q?37mUSg1D9XLdJbLzdWQ2k1NHTqeBeL79xvpmuiWpAiAxakAbJawVE5cbkxGd?=
 =?us-ascii?Q?HWYjF927nyKKvWfqualqtPqd0EZMPg9PywgL12vCNgtgzOImK6RfSQee+m6H?=
 =?us-ascii?Q?Hj9lFrgdvwzd5DflJxto/5kCmVEHX6RFoYRj0V9waKrYb9jeFN4QYkMAiqqd?=
 =?us-ascii?Q?NqhyWVvGzRWmmW4UY0SnWwUQBaLMP1gRLZZB9svc+z2HkSZ7eK65aH+4TGEs?=
 =?us-ascii?Q?BBIdImG6pzF8vlS39FdQePXCLlq40G6LeL05?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 19:08:16.2882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a59a7a7-8ea4-4c90-4618-08ddce0a1b90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On Sun, Jul 27, 2025 at 01:25:01PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 22, 2025 at 02:58:21PM -0700, Nicolin Chen wrote:
> > > /*
> > >  * This is called on the dma mapping fast path so avoid locking. This
> > >  * is racy, but we have an expectation that the driver will setup its
> > >  * DMAs inside probe while still single threaded to avoid racing.
> > >  */
> > > if (dev->iommu && !READ_ONCE(dev->iommu->attach_deferred))
> > 
> > This triggers a build error as attach_deferred is a bit-field. So I
> > am changing it from "u32 attach_deferred:1" to "bool" for this.
> 
> Bleck, that seems undesirable.

But inevitable for READ_ONCE :(

> > And, to keep the original logic, I think it should be:
> > 	if (!dev->iommu || !READ_ONCE(dev->iommu->attach_deferred))
> 
> That doesn't seem right, if there is no iommu by the time a driver is
> probed there never will be an iommu and this device should be running
> in direct mode only.

Well, the current function does:
	if (dev->iommu && dev->iommu->attach_deferred)
		return __iommu_attach_device(domain, dev);
	return 0;

So, matching to that logic, it would be:
	if (!dev->iommu || !dev->iommu->attach_deferred)
		return 0;
	return __iommu_attach_device(domain, dev);
then add guard(mutex).

I do see your point. Yet, given that it is an exported function,
I think it'd be safer to have a check. Perhaps it should give a
WARN_ON(!dev->iommu).

> > > And of course it is already quite crazy to be doing FLR during a
> > > device probe so this is not a realistic scenario.
> > 
> > Hmm, I am not sure about that, as I see iommu_deferred_attach() get
> > mostly invoked by a dma_alloc() or even a dma_map(). So, this might
> > not be confined to a device probe?
> 
> Once you do deferred_attach the first time it is done and won't have
> any further impact. So long as the dev->iommu->attach_deferred guards
> any changes to domains it is unlikely to be racing with FLR.

I see. The existing callers are all in dma-iommu.c. So, we can
assume that iommu_deferred_attach() is already done, when a PCI
driver calls any function from dma-iommu.c.

> > > Either ignore this condition with the rational that we are about to
> > > reset it so it doesn't matter, or we need to establish a new paging
> > > domain for isolation purposes that has the RMR setup.
> > 
> > Ah, you are right. ARM MSI in a VM uses RMR and sets this.
> > 
> > But does it also raise a question that a VM having RMR can't use
> > the blocked_domain, as __iommu_device_set_domain() has the exact
> > same check rejecting blocked_domain? Not sure if there would be
> > some unintended consequnce though...
> 
> Sounds like it needs some sorting out.. For the purposes of FLR I
> think the blocked domain is OK, so maybe just move some of those
> checks around?

These two new APIs call the lower-level __iommu_attach_device()
that does not check require_direct. So, we are fine, so long as
we don't check it in the new API as you previously pointed out.

I'm worried about using blocked domains in general.

Thanks
Nicolin

