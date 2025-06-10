Return-Path: <linux-pci+bounces-29341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D7AD3D8A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 17:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F6216E680
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD32367D0;
	Tue, 10 Jun 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q1X3vM66"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2927238D42;
	Tue, 10 Jun 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569813; cv=fail; b=PN1vBKDw/M9Exw9gmf42sIYIWMxh2pbJBGdB9c/IpsTw4KvLEPtetOf9xMBhxvgHAiEgqnjnMRU/TuCGSdTJ8g76jVhvvbebmo8BFKrZNHWf10F+Drhnu3K9AYc6zmpfMxFxITT+06G8iAvQwWOeZxjl2m819kkAikC7V+AFTc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569813; c=relaxed/simple;
	bh=lbZTSXRmfSlJn18Rdam7X6PNaST55egb8BBTCE3aROI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JOCoWjl/IVtYwwqqJzrLADWtjhOmj5iz0oh+VVbBItKRQOhDQ68hA88G+MT1jraKLUTPldzAHy6tIxp3U3qtdG+PhGfz5mNn3GrlOBZP3HhcgzTWAaL4/E0iTn/UnalV+UcaBgV5D5uJCdLAb2H1f/SUDoR/jtYPnOkYCHI9ja0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q1X3vM66; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMMnCTBkkK59DcP3CnHG1RcLuQ1FV06RY4AramYBnAl+17fiYgnZ+IjjDWkdUkEopkL6ufU/QloJm9sMfIgofnnLAAaJaqbh4MUvGyeGKwf7GV3WdY0ZsgeltB6haAOP+VFAo928FbGsO+XYdEwlCVSmrgM/OicBh4Ek3iqa8makOG7aiwGYWQ9+J0u++IhG/c2SdzWnNN4+h3n2/OBxIxSps1Imj0r5un0ZKiuY+uUNR4QM+E76Yf4VCIUAX+2LZJTt0sUSUnZGO3a6cfpBfQaQ9ulNQIcq223kS1dkoyAAw6jvx3BndDzNq+yPR09e8fM1oIDI0Gk7omMd62nBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FncmQaXGIbEkWwh73CupMAuHUhmjTn2LwQiZRnLTpQY=;
 b=A4g5gg+zdVYf/dUVQMhxYsd9B2zWu2P1ht12JMOY+kDz0yAaIwZZifhzz2ZniP1qPA4+Vcwhk1H8KQxXIWIoVtikBYi8M2EjJ5BCaGtX1iLRyeI9pkCDqRphdvOW53Jsn9bxdd1HJCvV6K7Rixo+JjCD+Di0beNpR2jRs3jsBzN7pWb1KS65OTu2EBpWsLbIU1Ys59cFJSdQBocma44bLDApVN7ksljLT846MRg07Zti7knaAet8+E5/YlBpypwTUQJT4Gsdoz8Mqn7vPvFRxC4SwmbqDrQTlFWU7QiBKg+N0ycHVqnNg2pBp4xhPS7R5pb+9D3A+l8dLouTe3nEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FncmQaXGIbEkWwh73CupMAuHUhmjTn2LwQiZRnLTpQY=;
 b=q1X3vM66C35zuJCxVmeEQ3lEMoxbjdvuuvSTSyqgl3VP/jH9q5G+hG76d7phf2detfqxVerOGbOGTxIiWLYlXLS6FgNLgQmg+MM4O3AdpbgzOnYB8geRLB7QQzJgC53KkyIsAsJofIVvtpFirE+JXFwFVyx/1QsrNqAT+Bj26BQfhvzoAcKCiJPpCR5B1Bg1Ao35uJ6DQKcHL0xHbUi73hGd8pjxgxSG8b8Df+risiwakNHIG6vBNvV000aonZUxuVuJTtV9Cs85IAxxCMH1xJnGnP41yGfPZZOkiLvO6LrMHtXnpJ09O6BVLEsqdmukysLmgQynvPhDlV+9p4n63g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:36:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 15:36:47 +0000
Date: Tue, 10 Jun 2025 12:36:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	joro@8bytes.org, will@kernel.org, bhelgaas@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare()
 and iommu_dev_reset_done()
Message-ID: <20250610153646.GH543171@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
 <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
 <aEfZlKNk4xfb41RR@nvidia.com>
 <20250610130416.GC543171@nvidia.com>
 <d22320dd-2695-4f9b-bd72-38eabc1d934f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22320dd-2695-4f9b-bd72-38eabc1d934f@arm.com>
X-ClientProxiedBy: YT4PR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: c453d533-ace9-4057-f7c9-08dda8349c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NjFdfXXNyweKngzfXw58yEoh1a/Y1LlWJjZ584AtHUq8o8Ebt9ivHtbaEBd?=
 =?us-ascii?Q?A7GKJcka5K7KvNVmPrkOl73b+t9geTvohHKwA8fABYMMuklmDtho8wCkrzfs?=
 =?us-ascii?Q?jSPGwHP1Yy2auDYDzSnSVDunefGneCbEYzDbIp+Yxlpo3kg+KLkKjU8Y+n1j?=
 =?us-ascii?Q?F6Q2MlGYSrBKAP82p8rMJCsWAQ5DmqPVE3EZWIalxhpYh3W5SNqf8l47w0Vf?=
 =?us-ascii?Q?5+Hg8qZbwAQfejLTqOneAOWzspOo8qSd+L4wq1AKYh9rq2aCGRbyrnWAvST1?=
 =?us-ascii?Q?aj441w1j5uAW0EwD/fM6xEPkqwpABm/BtZuenuFW3GFgIMu930UilRZVI0s2?=
 =?us-ascii?Q?LwezR38psTQV9kN+nlxa/YP1RjLK0+YU//Jrw7vJpUjFSwShlHV1UEzlj4Fp?=
 =?us-ascii?Q?s5eKSrRa8vxnfjnbYDyTa0d0jqJx/DdK30Uhny/U8HH/BLK2HkCbU80gb0BM?=
 =?us-ascii?Q?yF5BHyAcoqk0JFbLFDVnfAWnUdegJTu0XcW4RHyaZw/UO9a389UD8ZMaDut3?=
 =?us-ascii?Q?FXk8MSfKtyoetnpUS1tPWBQ207ccCcitcolc0U88AYcSi9KAfsAM2SD++mEa?=
 =?us-ascii?Q?trrCWPYKCcOeHfn2hetAjsJtM09vd5Os5f1j+PJWIgiXea7RzBto9O0ixVxO?=
 =?us-ascii?Q?MPQFEl6ZfFQDa9n4wv8gVyVupLTzY7OtQopdL0JLR02x99hrE/yqmMr87nN+?=
 =?us-ascii?Q?6rT3HJ9QyhuGDgkfatlQMKc/y0Sto+ZO0WZdgr0FCP16sg84vunTrAgnrg2c?=
 =?us-ascii?Q?+brFXp0Xh6UdYU+OYLGxuaZQ3PqH5kfdUlLcpZ2e2Uo+UGzBfyuZPAlnprrG?=
 =?us-ascii?Q?Mdh5S2D3cOhW4pnsStFLUGdpdLIK7GSyPI3lTgEeu+H8aY8YCEMpHEPThIcL?=
 =?us-ascii?Q?O4G6PsOXOmfLtSILVt0gbEmfpVfZDZICwWVbyngTMLELatbPxrBSwrNlW2Y/?=
 =?us-ascii?Q?BLWtdy4xcCxMWBuUBZpAnswb2zeri+8bZmS20vB+J+DROagArMShZcw+Kdob?=
 =?us-ascii?Q?TpB0lrhsmekyX0W3EiTGegazcz9R64NtlGlS7A/9gb/eUJKVUHXhpXKmsCEJ?=
 =?us-ascii?Q?AhpU/4dUz0ufXx6g/I2I0cMFO/UI2UjUZwb4w3iSY0o7uvcQtOqMuEDv0g/j?=
 =?us-ascii?Q?0E0L9HhTIXOPxanqHj0csRi9+U6jq9IlJ0cFkBsCbmN/4G70CUkshfhm31Ed?=
 =?us-ascii?Q?m2HbI4Nw0x4IqFwioTm9/czchF7658nquPbMzYd/xE9ayB/i/DSh3Ghl0Odp?=
 =?us-ascii?Q?CzJc98Ob/o1L82dhmzOeoFNRpCBJG6EYIOk4ZbW4wrZdJgH5QTCUcF+1vkIs?=
 =?us-ascii?Q?z7dDNXbzV+aluglMeL4eRfPCv8hGR+luAyl+q8suhWO+EWe7yI5YEFP+UzQj?=
 =?us-ascii?Q?VbzwUA9i3RYbREiXAsCrGnld5kwL4h56FsFyOM/aFVniQG0Gpujs1cHv2HwC?=
 =?us-ascii?Q?2eni47mgPKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BA2WsqSgy8YU5KMQxO2wgPTXklE0trKdVZF3ayKccm1JnzS51JYDSavsn5qK?=
 =?us-ascii?Q?OvvV1I7Em/Ii/YiJJLKzahxB+E+6FYVdPScFzolaNfmXl+e5Hgn+FdJZ93Ui?=
 =?us-ascii?Q?XFcALefB1nzKGnZllzvCDX56fb8zcQSQDiBgz4ixlOsA8Qku+HKKQPr09xin?=
 =?us-ascii?Q?txbFUjogyBq8Y+0QH677eg9uIWAiCedhtBwD0Ry1huskfw0yFskdEovbAewy?=
 =?us-ascii?Q?BL7lb26z7+n3pksRVAqX665z7PaHzKaKSAkdv4/gRJYNk1Df2BS+CPMD+FKe?=
 =?us-ascii?Q?ZZAbTzZ4ozbC0zIn2+Kv+hZDn7uhKLRPGwlq92xDMls2P5yOKSR3ozpOhK/e?=
 =?us-ascii?Q?Igrm+a2rs3+JpKLRWyFEPtsaGYKQNh+w6/IJrnx0iAyUXgWTAAiVpVHGRGbj?=
 =?us-ascii?Q?hc7vY+gGCKNPxQt5+6kl/WuMwOy8Be+VUifXDjhch6rfJaGFU0k656yjJXr5?=
 =?us-ascii?Q?bNWdMMZ9q+AIq3qahauFF8arREVD7OkSIdyOpVSfvw5oGQtCMBDcvJKujHVO?=
 =?us-ascii?Q?0/LMg3tE8qUfFGM0eJb9ktz/eNBJGHMw+LI7T2DJcjf/aR3vbagR2Mz5J3rz?=
 =?us-ascii?Q?rBBq4OB/apBTxH7P2vDEBGl0JVzdjbz6OqGHXk4/GAmqb9KSG2yY7cO13VVR?=
 =?us-ascii?Q?PlznNQiES7/mVKFl2UK1sS2KPP8mcF5jNOQSJXWxwMS+Rvq+RrfNsr35KOF3?=
 =?us-ascii?Q?j5ykBo0N85lbrNJSO76G2RGMrh8SUYfUdOfmOh3jstKZOnqCEbQEjwHyhfIx?=
 =?us-ascii?Q?4aVl27k/fFe/fZTB3aWVg8s/VBzUA+RZ8h8/wlQQFdJ7lZOZhfesbKiIoNKx?=
 =?us-ascii?Q?NSaVK6Wvv86tka985gUBV0xogwqdDyKslXl9RDw2H33d+1En0Kw7LahGdzVI?=
 =?us-ascii?Q?P2RV24F69HmopmIFNy/s6fCgt/zXEiYSz+whZF+t5w6UqDvXauIFBUuzwbQu?=
 =?us-ascii?Q?HqpebSc89hFfqmIAdvSIIg5q6o/r/QkaPWplsWLXEGOQBVz0aTRBikRGPKm/?=
 =?us-ascii?Q?MdB0JihvqY27qelZWkT16WAFE+5692K5dLIXgUYTGvE09Xp2djfgB61mRt+i?=
 =?us-ascii?Q?kOvyu27WG+2l4l52AT4z47QmKd6+VFM23pozbVy0C18keDhySIy+Gwbaq3o4?=
 =?us-ascii?Q?H5FhPHaueU4AHuzVHV+84YpFfzLQrVpUhgcq9abFhmtTXmiUwXh/ZsRtcVAj?=
 =?us-ascii?Q?HeY8D5voVYraFGr1Kcs+u+F31ZZ8X/nsv4deg3YKVMvHn+tRaa2TJGnrliBY?=
 =?us-ascii?Q?LuRCqWGHFg5Xo7hRL+sJh2zde/npv1K7kobTohQC3mdJqjWp63H3eW6vn7ap?=
 =?us-ascii?Q?imLv22ot7b4gm5BC3USzAyxOorumBENwb8JkkFzyrRPmzwlrFVisFTTXFpQS?=
 =?us-ascii?Q?kCir+tKuWgcddnuBccHrxqsZax2B7+5zdxHOqNdZDf5XgoRI3z+t55HkXzDn?=
 =?us-ascii?Q?NO429I2y3p9wj2kbC3KMWCxFvmYsE4nypqzBSfgkB+RqOgoOxGK3wM+1Zt4L?=
 =?us-ascii?Q?3y2QqqJ53Wl2/TZhc7F/0b0GhDlT/ohnFDJsQA3ta9vRB0emQh02Uy16ZmLF?=
 =?us-ascii?Q?rtmw4kLVi36HJJ/ZdwV0O8t+WkYFyKYKBLfbW2pY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c453d533-ace9-4057-f7c9-08dda8349c59
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:36:47.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMApg2zFx4CKH81jVXh5gYFp+vhDgptHB7+Fe6Ji/hVhuxPi7RK6aVt/i9qSwCl7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

On Tue, Jun 10, 2025 at 03:40:40PM +0100, Robin Murphy wrote:
> On 2025-06-10 2:04 pm, Jason Gunthorpe wrote:
> > On Tue, Jun 10, 2025 at 12:07:00AM -0700, Nicolin Chen wrote:
> > > On Tue, Jun 10, 2025 at 12:26:07PM +0800, Baolu Lu wrote:
> > > > On 6/10/25 02:45, Nicolin Chen wrote:
> > > > > +	ops = dev_iommu_ops(dev);
> > > > 
> > > > Should this be protected by group->mutext?
> > > 
> > > Not seemingly, but should require the iommu_probe_device_lock I
> > > think.
> > 
> > group and ops are not permitted to change while a driver is attached..
> > 
> > IIRC the FLR code in PCI doesn't always ensure that (due to the sysfs
> > paths), so yeah, this looks troubled. iommu_probe_device_lock perhaps
> > would fix it.
> 
> No, iommu_probe_device_lock is for protecting access to dev->iommu in the
> probe path until the device is definitively assigned to a group (or not).
> Fundamentally it defends against multiple sources triggering a probe of the
> same device in parallel - once the device *is* probed it is no longer
> relevant, and the group mutex is the right thing to protect all subsequent
> operations.

Yes, adding iommu_probe_device_lock to iommu_deinit_device() would be
gross.

but something is required to protect the load of
dev->iommu_group.. dev->iommu_group->mutex can't protect itself
against a race UAF on deinit.

READ_ONCE is good enough to protect from races with the probe path, no
need for iommu_probe_device_lock there.

In this case need to look at the PCI sysfs for races against the
iommu_release_device()/etc that is freeing the dev->iommu_group.

Maybe the sysfs is always removed before we get to release. Or maybe
the PCI FLR sysfs code should hold the device_lock..

Jason

