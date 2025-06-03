Return-Path: <linux-pci+bounces-28857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D83ACC654
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A5716ED43
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9D2744D;
	Tue,  3 Jun 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bqjzp5Bt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97638B
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953144; cv=fail; b=R5PvPXSgY/lkwmxKpYIp2r8mFlHk6B/KnfRZo9vHxbPSGAXVuzjIqpHjWSGZfvlj7Q7GF9tLRm+dFe9AoKfxLq6vLdpchMJ81rV8rwBJJFl4NT8/d7yefwJc4oN7Ku3JF9KMIIN/Mq6JtJRfopVgMcTsDdS52ElGZEgA7ky++sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953144; c=relaxed/simple;
	bh=8si+HTy04GRnROVVbqHKlnb/nbPqhJB0fLvktUM5U+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CPxvyUKmRhrsk1vmie2m6MYPA9e2luwK/4OHO7a9+t8OHo4ruiamb22Z5x8EMP7kTBKjeRxLJr7XNSbQGcz1FDSTLiZEktSIlX4VW0T56CYxb5vAXWv3oFLihsaoob63mTc/jsylFRwBKqFxKqeeNQyl3hngM1gLd5TDAmgrnTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bqjzp5Bt; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyGfdfflXLHRZaI7DPQlzqL9a0Ou6exCMOcn3rYzvnm810bybWNJMnPtGMHIRIpm4ZU9wJEbu3uYzEtmrp7aPwQVDnD4NsXRbwtxawjFnwjCw8aJc16Qu4etU/Jp/gEINGfAX2cnPVuLXh5ZFOg1vpCPr7Nuzz3MZ8g1aEHEJj5N44pNErkg4mQU2kyHUNNdIoWVARXs3zzllpbe1HfRQIYzV27Ur34SiD7LePtqnH1iHnOd64ZShFVzgtZXwgtil2r8P9bsOzcBd9OwSr0HUCgFuezlckuW3eNm6yigc6Ra3vfZdyDSuDEjQGlzKFhM689yZWSs1IHVZstiSID1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSPwUABMAfFn1kfvjTpnRHJinTgip4YtV9y+AzHpffY=;
 b=xxSPmschE3qUAOnP1QL4BaeqOjiSbrtOzy8fn81C7SrcqR3Sw1df9e2eNIXsB4hHpcxKaTVsMFAGKCGzgAPOuEelQil5zx9PLC6Y8Iej8Qy3XxVUpfaID2hNqSuxxOX5u7HUrWkK3O7XIMIx+psEihBCj3gtealvQCSgb+QDvN99Ciml+yMRTyQG8ILCSsLQDwbF9Avc1k5D+M5TV2j/TfwfeKPvest6H2w8d3zghXYhLl3wsgb8yBBDwjvggWKoJMw8nRSLLZeSiORBydTlCg+M+Fyic2Ie5ReFgLg1oJraPcK8G0Pb5+rkE9Onn2WpUnWA8opvhABro74Lk7Y3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSPwUABMAfFn1kfvjTpnRHJinTgip4YtV9y+AzHpffY=;
 b=Bqjzp5Btc1bffBaPxlyiSoEy0KF8S3YrPOkqxLDh88WXEhWuEMsWe64XOvLMAhj9VckxOSh5x7o4G8a2rVVFSj1E79szbIfoNzx/IHz67k34HAYzwA4xBMXEHebcGScaJF/uQP8gbIFERA6jT5skhW2J202gAOPD0BoZYC+pWUdMUx5XBGvJ1zXjBSWQwihLgmI9alQyJSILZtgfU1G1yYrSz0Jj6IDJSP/3j5svFvtEmPj2SxjtPksGt1u6GP4mDgbk0lcxjqXTv5e03RXH8bLyqEw6WUTY+ZVhMiakHYeLKk2pGwejxrmHpCyUBT895jMNkLgFQZj+dvaZ+lnv/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 12:18:59 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 12:18:59 +0000
Date: Tue, 3 Jun 2025 09:18:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250603121858.GG376789@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ao6v5ju6p.fsf@kernel.org>
X-ClientProxiedBy: BL0PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:207:3c::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c810bd-be39-4477-7204-08dda298d1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?67vW3S0lT+vpVEpNvj+Em8BP9s898jf/2z1nGe0cAk1xPZg5YsFAt1bAJLWy?=
 =?us-ascii?Q?AOBuUU2lDZOpHzBYNpTpe+MOFqL81vMJXgCnml+N/h2JTIXUMBlH8BSS5RH5?=
 =?us-ascii?Q?ZnYuEITzUUsUb0p87mAjNAjKYhdXzdxwsUM13SivRgP7LV6XBIzT656MTqtt?=
 =?us-ascii?Q?689FEJgsVI3F8U74uBMHmrU/Q3o5IHq4LxyCtVgyhrvyP+BwW2eZnflyc8OQ?=
 =?us-ascii?Q?uR7LSKci09qXx/8RClrO7zWBw8DstkFn6b81SdHxMnfoh3D5Nrc+YmV3vKxx?=
 =?us-ascii?Q?L3gbV0pEHF/etDiR7cicSapJPnFqkN87i56UCnOCdnEsAGWzAZyC5iTHonN3?=
 =?us-ascii?Q?d+BhwjnGEwGvOUxl4zba44nfQS1wSAeQ0/7Me8flX3U6drh7yUOtWOgDJGp+?=
 =?us-ascii?Q?fmBbYUqOQEzGQTokZ3GsHuKLEbMibQg0SwH1Lr/LbhEefQtGlClfpFgU2YnC?=
 =?us-ascii?Q?Ahd/7t1F57Kafc/M3XGrNC40YEVImGbE106n/e98WUTh2tgeZ0uLF7rQMCGy?=
 =?us-ascii?Q?26oNL5KEvcgPut0/tkm0uwlDKQaQ0BYOT+aS5G7TRlBB7LM3I+NcFfz15e3X?=
 =?us-ascii?Q?Sf1/KZ5C+LcBG9mamQrCI3csJNcvhPZ/3gn1wyllOKNcMTMLdYt+wm9PrZIK?=
 =?us-ascii?Q?cJQSc1jXdJSHhUGwS7iuSUsYVy1Au+7pN5daoMxbtc/hDf9RTVpCfw3XfB9J?=
 =?us-ascii?Q?Me5avY5Ar5t13jEpDEFb5UbQ4F3KNt0Wj5daOtEs9xFF4sK+heNfGXyjkzHo?=
 =?us-ascii?Q?xYnWBrrz//kgWGu+VCqZnoA4l0zmdvIimLz5awy0CMHAigp2uS/0IWfEsPZJ?=
 =?us-ascii?Q?roJ1eHB32+O4Y9ODET5F327yRoQPVgD/5ZKJIUBjTiTIfqF6j8cRRVehfdLg?=
 =?us-ascii?Q?Qwctrg8tDY3NzftdZmB2w8U7BcW65pXSdM3n4MSHXvgXrKmsVYwSBbbl3N7E?=
 =?us-ascii?Q?USz7P+dmACaUR0qcD94am3JpKV1mv6pk6y9hrSTqx7HXe7a9PIgTt2pP09JJ?=
 =?us-ascii?Q?BDM9dafYVr8dGouVzoG/E5FYrjxKiQzzcEP4TnQUJ/taBa+jPcYLqvQuEKQB?=
 =?us-ascii?Q?2bW3/zMudvpKlXD/24tGMiuo1owVy7bkFD+UReECSSmIP6N+ryu9eXr9qmgH?=
 =?us-ascii?Q?0S/A0KCWH1yow5lbFI4B5lGyelGyJ6QFWSC24qKaZnWaBwNeVfRN38veYd58?=
 =?us-ascii?Q?LrFNbRw3LTg7PBmj7VVR4HcqxrTbEeoryoXZ9Bb01SYIPVNsNzCehQmcCAfk?=
 =?us-ascii?Q?qBjb+hLYdiVn4KfehUcguxylvEKMyGg1/lls8lgWfJNobzFkGlObdEcoP2SJ?=
 =?us-ascii?Q?meTwdzPIv07YC4r84shlSNbFOaKnm+ORIWjhOhJ7mfc2yvSZvopn1Pow+Lxw?=
 =?us-ascii?Q?0BcQLtIS/qCkSLLt32sT+DJoG0+/lRD9f5+pSPA0LyKZf+W1CzuzKZOkjpGy?=
 =?us-ascii?Q?w1qxgCdZ3pY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtwG0J/+puUlEzsHXgzzKTEKnEbZvrZCAiOd5EuJrcQ5ONJ3HDcqkDxxD/Iq?=
 =?us-ascii?Q?QtSIeDVfE1GVzpnu9r6cHbXBkxjF8L6oA3HukEWy9Wuiuk2kfJo1maXMn7sZ?=
 =?us-ascii?Q?ZR3BrOpvGdKR+jtuOsjM9ixBeFayMhMqWpQgw+xa5zaFvnLq126ZAhZCO8U1?=
 =?us-ascii?Q?f1Q6fwfZ2oBadv21J9AR+OYJROQFLdMdjx8FcAu1zJzgYVHlaUAPP8mb+TXz?=
 =?us-ascii?Q?QteE2bvPmWfbca8vekzckAFj4ZPLJ4kn3/QSrG5Gb6dH9ub2FwAImLKqZCL9?=
 =?us-ascii?Q?ZFXmjk392u9WuV1Dr5dsxAtJYF3oTS6SHAGQJenx7nVEu8V6QKx4YTXMtsXX?=
 =?us-ascii?Q?FCiL8z8giMgGvmS2FtE1qOH10mR61b8SixgPmqmZsThtfmP2U8Rq272TlAUw?=
 =?us-ascii?Q?CtqGQ0MKE0EUMD1eGiESJZs8HFr8p4f0/81TDrXtmE63rIom7ZAWXVgloAyi?=
 =?us-ascii?Q?J8PYe6fqD0sbDW9PRj2kAG4UYGOajo1VxMZhImtvduKi8sbtrFOqi7R73Z/G?=
 =?us-ascii?Q?uVjDbHz1hWLr8vjhacEWIkmb+anuHUiizB7GyyCnznF9XXSnabNQlBSoOB1Z?=
 =?us-ascii?Q?jfIqX3oufJ0etqKl7pVOBO6iHpZqLMTTZb28zJjIW+fpR2UU04K6enVxEVor?=
 =?us-ascii?Q?SQ4P0hXuzOZXL9cEBQjXA5S4CAo4RlPweRSLJVYodYvN8qYBuycD4cO/zCGg?=
 =?us-ascii?Q?ZSeikc6l6ehplWYAOSJ6cz0Tgs8IPQU1KPKs2DzHf2YkFQse2z1HAzctr4HO?=
 =?us-ascii?Q?2YIy3xOh4MUgz6wB/8FFV/BzpsuOzWtz5GVlOnQoTJQ639KJ0EOKtwCXXQFE?=
 =?us-ascii?Q?onOl0xGVtdNKKocYn5EHSVOkk5RHrePSS9FLH0SlEiJiCrueei8UWZYt5qbN?=
 =?us-ascii?Q?/tblN1I5QyWLpHt7WJ/FamoetOlRL/Su5aQA0TtZ3wVrhDTxY9eRspTUaGm8?=
 =?us-ascii?Q?9OCj8WZzANJ5N6HVCo2WOYshXiP9F4p9aeBgWmCPrV0HJnaM8FuUqWVk0+zO?=
 =?us-ascii?Q?QG7ukIfvQ6Mq/aTfVLeUY/L66YJF29NJAkbiBVwWKwzRvALcdxJJ/0no5XMT?=
 =?us-ascii?Q?eUOXCs6iwHnjj0OG8MJVWUAhzuFPPTr8c0ZjI1ccoQuLZJHR0JAoWxl5qYlh?=
 =?us-ascii?Q?iUR4D2Sc9f4+AwIxR0SvhQnAP+i4A8Exg5w6hVlKR5WTV6r85DV3a2NY2XtU?=
 =?us-ascii?Q?pjvQ3z63yOQgVdjD1kqRpRvFCnrNhc/I5DwwgS6ikLioEU5dAMyjnwCUKyyo?=
 =?us-ascii?Q?gtbksxeMXfSfyaboP91BPYgDmlOKOPmB//6kCHAOMHvsNHrlnD8MWCKKbk5p?=
 =?us-ascii?Q?RNshCoJauyUoWtXroNtVWik+xuBPPwMRILuvbCQeOMZWdckP3sA/Y1ordiFP?=
 =?us-ascii?Q?7r3zv+EvHAN2EurCPay6N3ZFNt1UesTpAI0txcYN4oxG7o513Ur/lu6jXWMV?=
 =?us-ascii?Q?aqnczpBzg+d26FYE5jMKqunCRgYA3YCwdGWM1y0nqlLu4h7q5F7ajAUqeNlr?=
 =?us-ascii?Q?8tGPdUAl2AzoRJD5zCFQQMEPdBGhHpwIlO+OTkojcddsrdhQYlCRnm2x+iow?=
 =?us-ascii?Q?uC8HEnVvOin7i2WJWj/HWZCFX+eBGrviHyly9Jlp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c810bd-be39-4477-7204-08dda298d1d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:18:59.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +k+LnM/N7QqYRsdIoLVKvtIflKRBHefgMhwota3HyEcBHM1vlaiMA6px5O9/jl+c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818

On Tue, Jun 03, 2025 at 10:30:30AM +0530, Aneesh Kumar K.V wrote:

> static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
> {
> 	if (mutex_lock_interruptible(&vdev->mutex) != 0)
> 		return NULL;
> 	return &vdev->mutex;
> }
> DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))

Dn't do things like this.

We already have scoped_cond_guard(mutex_intr) for this pattern and
there was a big debate about its design.

It doesn't make alot of sense to use that here, this is a place where
you should not use cleanup.h.

Jason

