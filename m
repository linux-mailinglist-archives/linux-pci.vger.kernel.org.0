Return-Path: <linux-pci+bounces-34328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBDB2CF05
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 00:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A22C7266B0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B6353358;
	Tue, 19 Aug 2025 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cvDmB0qp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C691353351;
	Tue, 19 Aug 2025 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640767; cv=fail; b=A0uJd78MI47sJ6ubWqUXRKqWuSiO5/XtKMCt1EpsTsCsZzDnCDXTTNqpJweImKMsE3Bi3WFU2FGgb+bMZZ2Ri6AlKPioBbJbCuTOZ2g79WJDq9Tj0+bmmv6G52/GyMMkUDFqkr6XrHihGDKe5VJXdh8M3WMYtEpqHWWhMCHMB2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640767; c=relaxed/simple;
	bh=bIOcHE3QWJMhkSQ+9UKJFxlfsoUHSccGXAzRbD1m0uU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSHp4lV6z+EUfSpuKMfb2BrDT5eD0fA9ADG7dXl+9z22v5DejafqlJo2Js6MX9tdpXOdyFJ+2Vgc1+ENS8N+G4+NR233PG8Mr1iaAKJDKm9sPL2SK50kj0mI4P0FThwwFQZjTHo2wpPlt61qmrNed0o/Lc7yaj4Kb8K8UUYuNuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cvDmB0qp; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clkdb4Z24NJqigfZsni6PzahFMRPOrjz1mOf3wMpV16tLGx2P+Z942M1Dva5PWuEMQYqmmFDYtIAEIUpPnMH8dryy4YDW3E2YFfksdiJt++ojLhSMKdHG9ok2FrWvchnaJUP38AsCKIUUWs08duCd8F1WuRg4iKEl8Osu1uXdNEe5Cd/ZTY17a2XuV6Mh2ja/fX0z//EDaOB4CJsKAMX8tsoFyCRMzuyzXxcx7vHwd4ruTBraR7i4a157XipbL4s4AXBdig4BMxzyfWfIAaqMX5t6Xgt21GiTWroKfzbUUh+d86HQlRsAL02vo3sDP5eT1MlEbljYXtaOn834Dl0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2W8hCnRtt/9ocQ2raLugbtbMebuixGxLTbipGzEyL8=;
 b=lx+NTngUh2g2ijbO4GdMTfNU0fV+sYd5CcEGlWXZPxDZYeoIfmAqwHjmXaKn3QY43kz3vhgRO3KbnTgK6LoVGx/U661c60LLsb8Uz94Ueo2MaNK6EFr3SP1ZH1Dji6rCRxdEk6JaqbNjarGRhcssppRjpG5BeJ8+bR7I7pLBJ+R1t03FBv/fkSRTVB247U6hEK3EWiviHI81P5kQMA8NFdZiS+EK3LbSrl5POVF77piyacxuSRT9MyQJ08KPOdChy7SZmQXXLxMEFC7KVfYQbsh60rpIIEhQQXMaymle/0PtckNB1PB2M9yfCl2BgYIlNqcWjvziz2uGmXZROBKGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2W8hCnRtt/9ocQ2raLugbtbMebuixGxLTbipGzEyL8=;
 b=cvDmB0qpxLO9vjI00R8o0m2MhXJ//aqZLcqaHG6FemiDSOZYbqGRZmkKqy+3hPL8gp93jFq4hGF11XGPQNqynvwMk4wdfueKyWq6YSE0D93imhpNIzt7isE4aG2x6Yqgh00VSXxuPrzAQ9tatLMzR76Mskea6Ul/7YecBlKHIHRIfF48+JZ1z+gowcYkNry4G/91WXAGPR8NL4ln0Y8qog7rJKEI9k070p9L93Fe6f4bhxUl3bZBOkBK/6inkFa2zueGrYTHwKp+t7VbKk+4R4EGO73VCJX68ho1HQlpT74rGsJl1R4lNEUP5tVoxGU2LE/lVo2GYEM7a1vBC/Y/UQ==
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 21:59:23 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::66) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Tue,
 19 Aug 2025 21:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 21:59:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 19 Aug
 2025 14:59:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 19 Aug
 2025 14:59:11 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 19 Aug 2025 14:59:09 -0700
Date: Tue, 19 Aug 2025 14:59:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ethan Zhao <etzhao1900@gmail.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <bhelgaas@google.com>,
	<jgg@nvidia.com>, <will@kernel.org>, <robin.clark@oss.qualcomm.com>,
	<yong.wu@mediatek.com>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
	<pjaroszynski@nvidia.com>, <vsethi@nvidia.com>, <helgaas@kernel.org>
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: fdab2b70-1d58-4049-38de-08dddf6ba7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZKFknxbSl5ZtDjRWvGixQHlYFQJzTxFvEfAMUL7RYPau7eSkc/IihcZWbeXT?=
 =?us-ascii?Q?wW4qiELvgFJ0gqnJaJ+Uc35WQvZhz8jQsec+PA/9EgTMTT6ceEtL4GtN8R2F?=
 =?us-ascii?Q?d2YHJ35kTSmsk6CMoMX956tWKyA6F3+fCpjWYAbygR4eePv2ruPEicqnBfYx?=
 =?us-ascii?Q?OEg55vkl6kEpXtB1ARHLrva+GlNbkIXaPiq6wVP7YLAzcZigL9471dZy0XZb?=
 =?us-ascii?Q?TksSDgvjCyEvjaHRhlx1mVlHk3ZwR+gW3J5CHGU5D0IN1gITVKzobrx7nseP?=
 =?us-ascii?Q?8Woo9nhDu4itTaJZn6WurAbRQeR4H+CKKujOP10VQiQoTwvquZy02gl50nyN?=
 =?us-ascii?Q?I0ZxSKHKB6xC7omFAvGs0698Vk4JsvVHGxhlLTvC9aWNiiSrn4dmjzoNv1vb?=
 =?us-ascii?Q?8nle5Fd0ixVhSc2RfSeUjE56OXAUJa4YqEGann3TFU0ePiLTJvni1NoEEDP+?=
 =?us-ascii?Q?k/OlCL/iHgp4UoaUQZaaRrE4uvRttTNONsHH5vLur7yMdFUIBT84R4xTgfuy?=
 =?us-ascii?Q?ZhXwXhEjOXJuQAKD+UblQwZzoJ33CBbMUi+j2aJ8kHehf9Llyfg3t2//XkgR?=
 =?us-ascii?Q?zYh2n6yeKDpFW5erfoV9m/EKLarhnM9cj+w+fLZ4TOtTmAwsI8zSYAklL1w1?=
 =?us-ascii?Q?eXt4ghlr6BkDlZMPFtAzJgBrrXjfWWpZpreLLLB9RfkI6oGfPLLA/9/UXntP?=
 =?us-ascii?Q?SG7SyDLXO4Qc6mevEI9KvYOKjJwS3TKWIW8fxADLCuy8XLIrHksR2PzPgzYF?=
 =?us-ascii?Q?COD4caK1OLiP/lyDIv4W33t3ptmAFblZGGGZ+i8dkyflFe1F5JfqysZ1iKrL?=
 =?us-ascii?Q?UAIAg+GtH3CbKtK3p97/W3vj0eNJDPxbwdINXnXd2G8oY+5SVvRc29+lQzDO?=
 =?us-ascii?Q?X3i6/vmq9lolWMqNBgqIIv2xtrph8eYCMT90qajkigdVo8DSjjW8MgQtxLf8?=
 =?us-ascii?Q?KL/QiAxAySSrc2Jhwd1wBS19gU3cTQhQq2Ze7jCsnjIUfP0/kwaWJqS3nlH9?=
 =?us-ascii?Q?Dq7z7kbz5XH6vYr3C8ySWp100drL9G2Kel6XT4Q2tFJgqumBKoBEVS7zDZL8?=
 =?us-ascii?Q?SyZCYpO+zUO73pIWLnUQenE4N5W2zCccvnkYuYac8n3+csFYN6kZ+nqaBCVP?=
 =?us-ascii?Q?hAPEE1PHtqj1WxmzaZeKz68hp8plSLiwV4tdtRS4tqL5eFMdrz9bMcnvnBzL?=
 =?us-ascii?Q?e8KSbs3eIgJBM6ey0GiHcByfVVND7a8JUifOdQL2rsNCoCx3HkaNJYuqirE5?=
 =?us-ascii?Q?QiV7zZf7WzwREiH+IsIyEraLH1m8H2j1RSt3g9K/XR0kW9rMs+EeQ3rWkD1i?=
 =?us-ascii?Q?1SD931hQSi9Ux0jfVAvMJn5g6N0fyqCO+xwhVsaUiS0RTO3fOYkZ2Z2TLLLx?=
 =?us-ascii?Q?zaiF0wThR8EpHE36hxNKj7PE9sRUhLgH6GmJFqdiaHsQJL6LJkhQmclWUO5g?=
 =?us-ascii?Q?//DjsadTvUl06xgbCIHtWwEYn+4jWLg5WPNFHQwfSXriyKviluFtvYulUwNo?=
 =?us-ascii?Q?zOWdsG29Jzm1SteSdZ34kc7794ITvXg1CXc0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 21:59:22.4902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdab2b70-1d58-4049-38de-08dddf6ba7ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218

On Tue, Aug 19, 2025 at 10:12:41PM +0800, Ethan Zhao wrote:
> On 8/12/2025 6:59 AM, Nicolin Chen wrote:
> > @@ -4529,13 +4530,26 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
> >    */
> >   int pcie_flr(struct pci_dev *dev)
> >   {
> > +	int ret = 0;
> > +
> >   	if (!pci_wait_for_pending_transaction(dev))
> >   		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> > +	/*
> > +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> > +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
> > +	 * Have to call it after waiting for pending DMA transaction.
> > +	 */
> > +	ret = iommu_dev_reset_prepare(&dev->dev);

> If we dont' consider the association between IOMMU and devices in FLR(),
> it can be understood that more complex processing logic resides outside
> this function. However, if the FLR() function already synchironizes and
> handles the association with IOMMU like this (disabling ATS by attaching
> device to blocking domain), then how would the following scenarios
> behave ?

That's a good point. The iommu-level reset is per struct device.
So, basically it'll match with the FLR per pci_dev. Yet, the RID
isolation between siblings might be a concern:

> 1. Reset one of PCIe alias devices.

IIRC, an alias device might have:

 a) one pci_dev; multiple RIDs

    In this case, neither FLR nor IOMMU isolates between RIDs.
    So, both FLR and IOMMU blocking will reset all RIDs. There
    should be no issue resulted from the IOMMU blocking.

 b) multiple pci_devs; single RID

    In this case, FLR only resets one device, while the IOMMU-
    level reset will block the entire RID (i.e. all devices),
    since they share the single translation tunnel. This could
    break the siblings, if they aren't also being reset along.

> 2. Reset PF when its VFs are actvie.

 c) multiple pci_devs with their own RIDs

    In this case, either FLR or IOMMU only resets the PF. That
    being said, VFs might be affected since PF is resetting?
    If there is an issue, I don't see it coming from the IOMMU-
    level reset..

Thus, case b might be breaking. So, perhaps we should add a few
conditions when calling iommu_dev_reset_prepare/done():
 + Make sure that the pci_dev has ATS capability
 + Make sure no sibling pci_dev(s) sharing the same RID
 + Any others?

Thanks
Nicolin

