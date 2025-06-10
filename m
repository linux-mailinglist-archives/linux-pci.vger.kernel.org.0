Return-Path: <linux-pci+bounces-29350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281DAD3F60
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D897A5AF4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CED9243369;
	Tue, 10 Jun 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvL1KaHx"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717F243370;
	Tue, 10 Jun 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573792; cv=fail; b=OoKyr8uRHOONna8FvTIzAjIEIuF+AOptxHkEKTj9GceBeWlrDcF5Zz/zfNsiijm6JXQOBldK/YkCqnvnlJBLAUqP9NrZvwYypHutdud4b5xukpjsADghqxnGb6xJpPqH13qNNNaQcxnx4LIRJFM5bIfCmw2LH1aDjRt8SvvqHv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573792; c=relaxed/simple;
	bh=mKa/HEqPoN1VVUU1oqeCTVDRSzXjn9KPpo/AtRMogLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RpMnhJJQO18LZ+KVSUlc8SKqGCw8JEXxxXiYquyVglD+S1H0ha6+F7dq7h6k5mxRnmJdxUn4tvwKPpguoPrWhcvSkX+oB0knv6ULh/Uc4zMcPnyWXpCnBJHP3CV7pncwb1kbLack69Qj7NA/cLOh0ylZE7Ze6RZv4HKMW3GWxiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YvL1KaHx; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDQ4RTDfadi29BDe6OOBt0VZbBYCGyK0tpQHGL536lhSDPxE0YzlImms5F4HHrUwYbTrSui7JbJKdGGs/IV0sjFrgbrqI/enO1b3CWq81Zb6vRAzG+IbSYyfE1SAeSuAEFf0qznISngKkhGkjqhJI3BSmLacrW/AJchs+wnPMzOsZdg01LlTBYSaFUctO8uMy8piUuXrdXvrt2u7BXa4falSPyotAPIeXDQK5AxvL+q+0kz7N5br4WBY1jL6QCIQNqKvJL3JahL1DiY8JvohNKwnfrBlKgK73mq43dyyycQFdIGmudUC0bdAm9G0Sk+cmB+5nrlDK/RelGtiC7Terw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfzFZBmwG7/Bwpo7YAs579L208eu/MXJBO7rtOirjW0=;
 b=QnDW6P0naJgS0rxSfcsLw0DdEJrLLZghfXq/Gifet71QkAXXBfWNlyZVKANWfW5I2KyhBBpHC+XeWbUzB/c6p5XEF+4G0ubeVy0SjxfLttHdeczlxcVyhc02pe0AHsl22LY5161R6uizZFtbucc/E7U9etsfVCxMM7P5UvLd5MzdjnabPoCCbcY1QJfvYyJpXKSnuf/fTZ4NXPaHnuQXUysHKveoekyo7iCOL7yPbBhZfl3Lpp5S/pxbAhtptSizWYgpq/GPIXnHzWeKk4EFhmByXCe9tak/YDV0bzGExD6+VtKlhpPa+uzYW44u/++/Myi1N22v3ytogra/5qo8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfzFZBmwG7/Bwpo7YAs579L208eu/MXJBO7rtOirjW0=;
 b=YvL1KaHxBytL+bf8Q74QYjU3MLxHqD1IfudOlIf8Gv6QtQJpa7cOA1FMEq26s0siMx98VyBESiYI0jnu13g+ph1UxBOTVckV09oaV7VeLbNIByx7IlIIbDDDhETPqYQBF1MvPn/0TEU1t/ljcoDRLeEaKRWFWuewneDHoSoh2cTJ0Nz+J3m5mPg+W/EQ+BqztJzfFJz9s3YOkI05VcH1IMhWeE9TR0bUJrt7VDwmkQyTp8wKYvoaZJYe0eDmMbP43qcUZ+94E6fP/4mz9QbHgoDLrbE4Nvdf1vzW6OQlI4Bkglk93eMRubUwP6JBSwcvQ/hzuvLXzrLc3/cM20Yv6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 16:43:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 16:43:07 +0000
Date: Tue, 10 Jun 2025 13:43:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	joro@8bytes.org, will@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250610164306.GJ543171@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
 <aEfZlKNk4xfb41RR@nvidia.com>
 <20250610130416.GC543171@nvidia.com>
 <d22320dd-2695-4f9b-bd72-38eabc1d934f@arm.com>
 <20250610153646.GH543171@nvidia.com>
 <f66bf027-5dbb-473b-b57f-ed3ed7914800@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66bf027-5dbb-473b-b57f-ed3ed7914800@arm.com>
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 033fcc72-aad2-4292-0c05-08dda83de09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bwbqdK27P6uEtNSolZTgoCg3nFyNEXi4v237u5TbPYukQux9zr5kIiJ5pLnS?=
 =?us-ascii?Q?jbZ40q2NLRQy2zFfBCKglbQA3KD8OtjxrFQpzcAEZu4F789YdtLrHrq5/IOy?=
 =?us-ascii?Q?oxpOw336lEU7YrBlIOgvO+/5Jd2EE6bIJbfGsmetKdk9fDUqUazKqwpwKnzW?=
 =?us-ascii?Q?zJq7Ppc7Lruy4c3hCP4MotWeV7p2t1JfM6jpvpX6T5VKISAHOSyOEmKEST2Z?=
 =?us-ascii?Q?cPcjEbPCnhfN0SIqHDBPLu8bQV00XEoXBAbCgVjj4l5EbdSzdorXHqs4DfjU?=
 =?us-ascii?Q?CAHsytj5+l2nqWcIrWYQzP7Qbseo2NlehrEzRtkGQ4Grel3KXZzeSejM6H1H?=
 =?us-ascii?Q?k1oIIUIZ7VGlga5yX644hV+2L2GPiMrDSESkpU9OrISN8wdM5FJDC5qIQ+VJ?=
 =?us-ascii?Q?1zNnaZlg9TLMdl+UD+ThruY0N+0a3YUFVC2rwnegsel5ylpNeTd8w02J5tMW?=
 =?us-ascii?Q?XHlnGli5vpGUNmDAI1hMOhmOnr/wg3xHwNhFNRphcQFMwXijxlHRTtedEN82?=
 =?us-ascii?Q?NgYOIrNnJ9mH0dqxCS6J6KjLmrn5lmvCECxeirOQGv/byYw6Vd2VDi2VRVF+?=
 =?us-ascii?Q?6usgzmqGnsDIticWjJtyeI332purvjuPbSFeVkses26k0Kz3CTPpKZRdrJo7?=
 =?us-ascii?Q?08xHxT5oqXbv3zWxXXWSE+7scVq9Gyk7i9fCHO5H35O9y7ZjqQYwP/4GLXwC?=
 =?us-ascii?Q?MYM/zP7Oz36+t4CSJ5hipDFxFxRU57AQ2fZ0UK1HEDJw6SzM/5GIpqR/uZC4?=
 =?us-ascii?Q?FQyPo5Sxo5Zuk2hWjihkMris3QJ+SSrzBben3EviQdQ2JYgNS08LoDZiwH1d?=
 =?us-ascii?Q?G5ey5lmBgHRIyToQnj/pRD2jdUCDO+UM1vjH3pGbpKmSjfkxuQOyEZXJWD2T?=
 =?us-ascii?Q?yxqbs8ARwoi2XfQqFXRsLVQ32cinCYzpqjBvX8yDQskDPb1n9dNBn9+bEyKb?=
 =?us-ascii?Q?cm9Kx8BVo7sl5XJ8FD2sWeOc190lR79/nsUpA7r5gNfnwBr6H7qj/sxOX1kd?=
 =?us-ascii?Q?6ueWhChSpSQTrA3coOSgIUA4pwluOQ9lFjXOpPSr8jKqVTIPAUHectbhb/Mr?=
 =?us-ascii?Q?s93DoxR+8AcIsZ9cNmV9vyYpU3Dxb6GwtIWtls6jasLuL0EQZORQ4zwUlOBI?=
 =?us-ascii?Q?7eIuvl8MwrOvzI0n4Jwg+mlhMlN8Jt8mD6PZEhnBWt8EbBj8KGVCf8xlJ4LJ?=
 =?us-ascii?Q?7GMcMWftgB0DabCAf25eph/LOlPx4ptUMMuQYMgkhnyWQKpfmHDS+MFIUm/5?=
 =?us-ascii?Q?tr2j4Secb4dUl91mdj8a8c1mZVKBaZoqS0IRYzZ4CPvapm4PVCZe7C95QfHT?=
 =?us-ascii?Q?G6gIJr+s90k8qplQAYN/RFDuq6UFcmV1dW4RS51OHQdWXa0U1SX1JP/UhLfz?=
 =?us-ascii?Q?6t3gpOTbrJRZgoto82egAhwtmsSRTtHAm/XYMTyFlFlMOH/aOhNa4hL3/fed?=
 =?us-ascii?Q?+H5x8EEWVfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYbOQjrNH8TqFiO1qPU4oOSRaRj5kcR0mlBVxfkLoIfaZO5ERi5tfGj9t1re?=
 =?us-ascii?Q?Po7HxGat1qL0nM9uwpZEKZSCZz3zFOrIUz23U3/Z0QP6DQPVOOojzxHCwp7k?=
 =?us-ascii?Q?14Id0C4Yn+rj0vL/ja+12zR01YCgv6EEEVXMDgnaV10jUWHEAo109Sr2cdXB?=
 =?us-ascii?Q?S7MqoYGZ/9X07kZmKZ867HK2aqvRN28pout/vdbFg2wZnBMXI+7DZvnDgKC6?=
 =?us-ascii?Q?dZtChOvd4WU6Xl9tpG9OyAwQGHxQjjbdV7G1kIXXeXowwptOBJX6p15Hx4r0?=
 =?us-ascii?Q?BSs64fn2CDvXKuGTvo2JAp2VxtgboYHOab02VU/VKZJm7krXX/TOlHh1grdT?=
 =?us-ascii?Q?exv55ZHJUPQ96GWA4s3I26LUVdKmb8SK4MM/4L+ygzZzlnAANMNa+VRiGjFx?=
 =?us-ascii?Q?9qOUP6hKnlvIfKiRAPz8Y3imxLT4lcbiOBGO+cQXGERNpvUj5Sgwo4QJCZWN?=
 =?us-ascii?Q?T+KTaiBiEhP7zqE1AajTuiZRfvT/d0A2l2gg6j4WcOPFW8nuYloCTABl5SJl?=
 =?us-ascii?Q?XnqnfAKcTIhuW7MI8pFcighXcwgqTmFpJZONZzDng9M48ZFj8DQEwj+XRTYj?=
 =?us-ascii?Q?homIp/T5YnA28OwLbDf5zLvhzcGqsYQsbpqG5GycoDo8vfG2QRBuJnLwf3dE?=
 =?us-ascii?Q?vJB1rz0A3LRSKupElVViQ8bJ95qPk+JMfqWAvhCRqgxr2M38/S2aSIxrLLre?=
 =?us-ascii?Q?dPOgejJoC5fSayzYGw/1Nfyy9Pu9dt+ea50qZmye9SqNsjC3wwjDiNRcn+yF?=
 =?us-ascii?Q?bL8GpHLn7UrTxAFN/BXhYpsdzVNzKNfw901h3gzXZ8y4lx0XbWuaSuP1yPbB?=
 =?us-ascii?Q?8YKzAIz6/rnH3Hapb3Vtho6kOD3nvykNK7TKOuDBiRwH+l6eFiags3eDJZZZ?=
 =?us-ascii?Q?aETVDuNdfu10fBxJIwpYrYslVQKh9cwmpyzv00SXvTW091wxzm+wmPhkjOjT?=
 =?us-ascii?Q?JWzcjKWa6q6Fuo1GnccaqreUbaF/CMVb/dxQvirqWqG4kudarYWzqG2gK3k5?=
 =?us-ascii?Q?uZuZQOS9/Tle9W+WMCbRXw81YS1hMesaXeLijJSN/houwsb2nrnrQjRN5ptx?=
 =?us-ascii?Q?3eoyVh/3UQvK/S6rCOtaThTXv6OVMmXH0xr/DBDHjwhCj4wrbmH4gWIw2ZrP?=
 =?us-ascii?Q?ALCAgpnhb7fisGnaVMKd+cKqRSL++OXC7M0D3CmkkUy1VIkXEejbyoZmhGDU?=
 =?us-ascii?Q?sG2cDsPGz3maSIDmOaXEgRsqtOU1mfYlNvjh5JffkQiq1dW7oJ+2fa0bhxWo?=
 =?us-ascii?Q?bAghqY+Vy9LzfB6w8QtwpBPbHy0KhTyWKyGGzf6rSJ3iEube+x6/twzIQhhK?=
 =?us-ascii?Q?L8DNALouoo3vj+OGTrU7COndbbvkL6kC4PS/gTjlfbeTXTYzh9q7LozfU1XM?=
 =?us-ascii?Q?p89zEP/UwtdmBdk0/JsO2BmxqFus89ymbxghxBJl2/P96MLBAH8rkpLkEZz5?=
 =?us-ascii?Q?TtIqJal1aPoc7EVYNe4VY1cEJ31inBceaGCElH5dKHO8j9ztA9a/L0+84E3E?=
 =?us-ascii?Q?kD4+ez9JHhzWXCQRILC1x8sHV+vcW3WQytsS2fJaGHFvRqYCVrrUxIUp7b9/?=
 =?us-ascii?Q?Sft5VNPnzEagWFojzznZx/MiTcuFVtkPQR6DQHvE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033fcc72-aad2-4292-0c05-08dda83de09c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:43:07.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gv6Baxv6MtSLPjFEwpWFcGMTWAF62g/84uCai95wYpBil+i3DoQosutKbkLrreNC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

On Tue, Jun 10, 2025 at 05:31:09PM +0100, Robin Murphy wrote:
> On 2025-06-10 4:36 pm, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 03:40:40PM +0100, Robin Murphy wrote:
> > > On 2025-06-10 2:04 pm, Jason Gunthorpe wrote:
> > > > On Tue, Jun 10, 2025 at 12:07:00AM -0700, Nicolin Chen wrote:
> > > > > On Tue, Jun 10, 2025 at 12:26:07PM +0800, Baolu Lu wrote:
> > > > > > On 6/10/25 02:45, Nicolin Chen wrote:
> > > > > > > +	ops = dev_iommu_ops(dev);
> > > > > > 
> > > > > > Should this be protected by group->mutext?
> > > > > 
> > > > > Not seemingly, but should require the iommu_probe_device_lock I
> > > > > think.
> > > > 
> > > > group and ops are not permitted to change while a driver is attached..
> > > > 
> > > > IIRC the FLR code in PCI doesn't always ensure that (due to the sysfs
> > > > paths), so yeah, this looks troubled. iommu_probe_device_lock perhaps
> > > > would fix it.
> > > 
> > > No, iommu_probe_device_lock is for protecting access to dev->iommu in the
> > > probe path until the device is definitively assigned to a group (or not).
> > > Fundamentally it defends against multiple sources triggering a probe of the
> > > same device in parallel - once the device *is* probed it is no longer
> > > relevant, and the group mutex is the right thing to protect all subsequent
> > > operations.
> > 
> > Yes, adding iommu_probe_device_lock to iommu_deinit_device() would be
> > gross.
> > 
> > but something is required to protect the load of
> > dev->iommu_group.. dev->iommu_group->mutex can't protect itself
> > against a race UAF on deinit.
> 
> Then you do iommu_group_get/put() around it as well. 

Same issue - can't use dev->iommu_group.kobj.kref to protect against
UAF. By the time you do a try_get you've already UAF'd the memory
holding the kref. It always needs some other enclosing protection.

> From a quick skim I suspect it's probably OK - at least device_del() gets to
> bus_remove_device()->device_remove_groups() well enough before the
> BUS_NOTIFY_REMOVED_DEVICE call that triggers iommu_release_device().

Make sense, Nicolin, a well placed comment explaining this would be
good
 
> And on an unrelated thought that's just come to mind, if we ever did FLR
> with PASIDs enabled, presumably that's going to wipe out the PASID
> configuration,

I've always been expecting the PCI FLR code to preserve the config
space that belongs the iommu subsystem. PASID, ATS, PRI, etc. Never
looked into it... Nicolin??

Otherwise we need a post-FLR callback to have the iommu driver reload
the right config values for its current config.. That's an existing
nasty bug :)

> so will the caller who requested the reset actually expect
> the attachments at the IOMMU end to be preserved, or would they assume to
> start over from scratch? Seems like there's not necessarily one right answer
> there :/

IMHO we have to preserve everything, and I think we should things back
to working normally overall, if that isn't happening already.

For something like VFIO preserving is desired. For DMA-API that is the
right thing too.

Something like mlx5, that has a robust RAS system, will unregister
itself from the rdma subsystem and that triggers a natural destruction
of the SVA/etc domains that might be there. We want the attachments to
be left undisturbed so there is no issue cleaning them up later.

Jason

