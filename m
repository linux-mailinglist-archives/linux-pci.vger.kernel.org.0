Return-Path: <linux-pci+bounces-31095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999EAAEE5CB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D791316D10E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3529C33C;
	Mon, 30 Jun 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PyNhdClM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0AA59;
	Mon, 30 Jun 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304572; cv=fail; b=QXn0gZYFaMnoqprS01s/UU+zX+E//RkjZt0FdUZG9sU18cKyOD1EdK6Z06mxk0sU67DZqEBrY6RaEH1TS4VyhHSGVlHNG2kM1+7OI6vARGuNwxVaqGx1InpaWDhKadVuY3kodboI/+JPojGwtBzyKt2U1yuhDHDX+Wal7PSUqT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304572; c=relaxed/simple;
	bh=wpNxn/y/AI823oWvfQAig0e7fjoc196Yxdtcov2RluI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CedP58BM1th3+ezPWhNxy2XT46QQ9vcJnaILHtjvScj0QC0ANHS8B9KDhpDXRKobHusLEsZbkMxITWSvK9pz1KopOG9KCBjME7S/rfAD0OARUXQ6BdtLM9P7839t0Uu0f1aqjPNBaNQaPhuWCyWR8vpntldT9O0fO6NaB6YNZt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PyNhdClM; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC4OyAHtqzFPqc0LTne3TLr0sL7SWjkUK8ZBm59BnrDOq/Z8V41fjhaAPEOpib0njMeMBSJ9L9TZOmHlryLTrpWRIpt26Q7P3cuADJwjOxOMm9EyMQ+f1rtAscM40LlWTrO4lIEJ1hcK60RsH4ut1dthvccWQqUxkntbJqfK1N8daK7JVfLE2bozMljfSvaxMbtIiX2hnMhsORNmpy+ciOeoRe9FlfsF1A2mZII4UA8RYrQG7CDJ5vOiYdAvpwyGATWa1oIEnsDo4mEfm34qMUASbBmvuYx+ZWjObCzxIykyl7tZLtxsRUUEaAlFLkDDjoqHbOedr+IhysGQ12ltPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR0NOwXmOzvSHeFvRZD+dS3FjsJqs2bN1M93RvUsTc4=;
 b=uvMgeMpyKKVrIGKMc85T6O4ILssYJASI34K8NUuI9l7aG49Cbs2DgrRXfqSCKHKYCoQ3ttFCw5P4S2LL4aYnC6I6UyAWl4a+YuLOEQOa8cA6KiFg4hyRq9p8hNxhCqhJfTntwVeOTCSzKx7LNEybQcohowLTC7tOk2iWcIb6+B/l7TtHwMlQ0qMgOSomh/J0bu0PmuV0pv/SckNklrPOHxDfyAOkzi6/CiEnu3njlTC/neJD1TtM8OwFVJQcpL0athsNNkKGVICXB+DWnEv39kp1ZMmXCu1vlQgFQ+YLcZzMeEJd5YReLA0CJZfOodXgRDk7r5vsBC3E9ILxWIB/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR0NOwXmOzvSHeFvRZD+dS3FjsJqs2bN1M93RvUsTc4=;
 b=PyNhdClMYG3JjQS/5ICFLdqgzRHtUCuiv5NOkvQ6dm/Hs+Y8XolrY/YWJjZ0KWFGFV20qQ8wE52gQtgB36vyWNSFvgnoaOFCR2QjUjeLbxRowDgt8pmFB05ibU75STKQkjP+v2jiUMb3F0ekgldaBh9KbyyJWePTOzURCZVr5eEP0YscGsi3EIEZ58XpxAlthEzqZNb1AgJmMM0xmoYpTqZX2ivCF1Sfib6HXv3dN8BLkgL6MFYNfnakPbkdJ736/S56Wc8j/LPVBeCUbFdGubgsoGKdr3+1WyZ8Eb0L2/WvsyabXYwJz7J4Eezj0YEyDR+Kj/eYTtLzCa6Gr9uq8g==
Received: from MW4PR04CA0179.namprd04.prod.outlook.com (2603:10b6:303:85::34)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 17:29:27 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::cb) by MW4PR04CA0179.outlook.office365.com
 (2603:10b6:303:85::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 17:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 17:29:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Jun
 2025 10:29:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 30 Jun 2025 10:29:14 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 30 Jun 2025 10:29:14 -0700
Date: Mon, 30 Jun 2025 10:29:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>, <helgaas@kernel.org>
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <aGLIEhoIiUIjI/MP@Asurada-Nvidia>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
 <e505c970-e519-44c6-a316-e5d186f216ca@linux.intel.com>
 <20250630123814.GS167785@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250630123814.GS167785@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 791fd3b4-8515-4848-cb23-08ddb7fba9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wc9+eeHUu1bSVvag5xdGMbB+OSsviQpFAhCcfluyPA3J/Ssfs7jvrHFVwdt4?=
 =?us-ascii?Q?uhKwJAew0xJAgFxaWFFAnZCrMTpwyQDd+3PIF3TK3CPPUJg/TI3odJoSckEQ?=
 =?us-ascii?Q?w1Xgber1NM35Ir0Za5Q9Zya4OCb9HfKDOK6TEnFgGg9HmRN7J1fzpnxoQed7?=
 =?us-ascii?Q?CDkWHmfeE3+ohVUCni5P7X3xT+dNEBplexdHI6I4mvkz4F34Ie1QnQrVokg9?=
 =?us-ascii?Q?qokW1IFk9e3rBMl4cL0S4wPokcBqY82GQrUf+ffnTAWUOVelA7eV0KcbUF75?=
 =?us-ascii?Q?TchaV1JfxmzoosBRqTofbyc25bIZKhTStx5tSAPkgBTZMCSikfYKjYslSW4I?=
 =?us-ascii?Q?Z9IuyUG8HZNelhV77s5qWMQAxd/dIZOip5MIfPPhSF7j0slWtIc6ST0lA+FH?=
 =?us-ascii?Q?tmC2YxdKGyuSn8CM1tHNe21Qt7i9mMCgWHLA1ULLnjo6MhDvi9lEsYEdGKWx?=
 =?us-ascii?Q?1iIasyBWno6YCvBIEAlHTIOFhDaKbMvKW8q1q7aOvw9E/rOzondsEnb7N9Wd?=
 =?us-ascii?Q?lJDMwIu3jtFPpTG4PJ3jf1Jh88iHwZaU0BShalpuLg2QFh14DSE/N6gSvsHY?=
 =?us-ascii?Q?ubVs4Gg88zM7/5wV13RQLELFfX/TA51Ahoypf8GnwoKsaap6BxEc0+IEKDht?=
 =?us-ascii?Q?3mfWQu5k+Age3Bq81eeZEnBHzsK9NhxwNi+48l3ThOOyvJIRigKu92lmDPLT?=
 =?us-ascii?Q?5WisISyP6OwNJWUL2IA3bpbBGv0ckOdHywjA8mwt4B9p+Efa86ZH2rZuTn34?=
 =?us-ascii?Q?TGe3ugKBA6gqkWXVn65HnvhbnkathOKgp/R9GFG9fJgSVO4BRpyhzvyBd69T?=
 =?us-ascii?Q?VwiBhA1ZdJIFxEUvWBdHu0B1Ga2SkbkXmMURRQEcX8WSzkVmBvwQiEXOz//s?=
 =?us-ascii?Q?AulDce4ZcYi4La1Pq8XwWWF2YoRyYE7QrwiQ5s3Iy8JQZ72tK293hEbhB07p?=
 =?us-ascii?Q?MkfhrRecDU5PXMDrjSKkVuz46s5/RR9eH/Jeqthu57vf7VTwX6fwwCErgo0P?=
 =?us-ascii?Q?bfIsgYBugXymuIe7bR6unRyBeKMqXl5i+ZSKuS81cBYflf9d/12uYIKg6ykO?=
 =?us-ascii?Q?Y9CJ3hkw5vWQyAo+dxCXpaFrgB79dFhl99GriL6p+rtTzQBwaNrXLRIeyJx3?=
 =?us-ascii?Q?cvuwchPNa/r9munbj/igznNkgyIEgObroFQHpgrN5av99aFPlP9eetiLhSL+?=
 =?us-ascii?Q?OGEmxCBxeRVhWBduCozy2zXeS7LlD5gJm8nDd9XQ+PFtkcCQFiaOjr345uxz?=
 =?us-ascii?Q?Qu9t/S2Vl4EWzPjTjx+aXWM3Uobz4ld5AkIlnEgfqFxBRXcm5IKJgHeVB8he?=
 =?us-ascii?Q?hzjU0VfVW6tQ2WuJX4+9q/raZ2lNpNCMutMRou10A7xl+5JhKFa21p6mJfGi?=
 =?us-ascii?Q?Dv96A6XYjIysJV8+AaQRhQ7sFG3DG+2HZ2a/FktZSHreAaElKlkayvX7rLEn?=
 =?us-ascii?Q?/T5EeAe9sjeCY92jcT4o/RxPCoTfUjb1as1Qx14m4f5lSaZ3NfxhbxGnxrqC?=
 =?us-ascii?Q?Ee5IvTlEGfOdxgjMbRUn2559Cbi6RZYEaU2P?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:29:27.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791fd3b4-8515-4848-cb23-08ddb7fba9e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

On Mon, Jun 30, 2025 at 09:38:14AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 28, 2025 at 09:28:12PM +0800, Baolu Lu wrote:
>  
> > Does this mean the IOMMU driver should disable ATS when ops-
> > >blocked_domain is used? This might not be feasible because ops-
> > >blocked_domain might possibly be attached to a PASID of a device,
> > while other PASIDs still use ATS for functionality.
> 
> No.. The above should be setting everything, including PASIDs to the
> blocked domain.
> 
> The driver doesn't have to disable ATS at the device, but ARM does.

Oh, the code is expecting a pci_disable_ats() call, as the next
patch will check if ats is disabled on the PCI side..

If that's the case, we'd have to leave the ATS enabled but only
trust that iommu driver won't issue any new ATS invalidation?

Or should we ask driver to be "must" v.s. "doesn't have to"?

> > > +	/* Device is already attached to the blocked_domain. Nothing to do */
> > > +	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
> > > +		goto unlock;
> > 
> > "group->domain->type == IOMMU_DOMAIN_BLOCKED" means that IOMMU_NO_PASID
> > is docked in the blocking DMA state, but it doesn't imply that other
> > PASIDs are also in the blocking DMA state. Therefore, we might still
> > need the following lines to handle other PASIDs.
> 
> Yes, we always have to check the xarray.

OK. This check should apply to the RID domain attach only then.

> > On the other hand, perhaps we should use "group->domain == ops-
> > >blocked_domain" instead of "group->domain->type ==
> > IOMMU_DOMAIN_BLOCKED" to make the code consistent with the commit
> > message.
> 
> ops->blocked_domain is not good, we support devices without static
> blocking domain. But yes, using DOMAIN_BLOCKED is not greap, there is
> a group->blocked_domain that should be used and will dynamicaly create
> an empty paging domain if needed.

You mean we should use the group->blocking_domain, even if it was
allocated to be a paging domain as the driver doesn't understand
a IOMMU_DOMAIN_BLOCKED yet?

Thanks
Nicolin

