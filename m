Return-Path: <linux-pci+bounces-19603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7136A077E1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04FB7A1E7F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A521D594;
	Thu,  9 Jan 2025 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oSCB82nU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E336218AC2;
	Thu,  9 Jan 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429901; cv=fail; b=HDgTjLMX83IamsKRwQD5+Q9tDllNEG/dGVE6uDsFWwvzFkMx/8/DhPmBtuhccVpRG2fZB1weH8KLq9KbddVrWHgiZysg3B37RcSh+8SF2RhQSLtUT/m4Y5Vi+Gmk2pkIC4szg6WrhqBbcgtq7XrLucyWnff4zW4mUKOYRRdAqp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429901; c=relaxed/simple;
	bh=5pVMbY+umyNo24XyGFHYKbMZEYhOgmdIeUgQIjJHme4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e/mWlX38Qamw+5KHmuB3zTxMg5F+EpuS5TspgImh2HxkJe3nx6Uj4tHP5jTWMIZ5o+AiMuse0+nE39WsA8JG7O/RmR9rScGiIKGei90LhUgnH3RAzHoUiAs7l9lM/2bqnRBElQe8oKsZMmO5FYuPalGhL6Gek+iBk/YVwTsuwSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oSCB82nU; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niiz+VpPLz6vwF/AdT8VhuUWfnHspLa80vbEgmbANtzOYBj4klgRnqNmuljR3yIf2IeGE85+RZbdevL/So/EfxgMN2Kx4xc7dvqqO/0DQyF2CGDl6HIlrecdirsg+6dGdLYMcheXcfD6Mq+sPNNWJGfA6nfssGQeTqtwZHCXnEXNYax43nL/3WN2cWXpvw6vlqZYyxiapkRNh0Q9EmwoQa0VlVLm9IGq+uLOTw58Yp/viPbqtni7WzwRgSt+CZhErZclCGRWRtvtzoWJ/HBflKZIhxLA5hs/UJNV0E8T2XE9ZBc1ORNftL32A5HTWiXRwtbNtowxGZ43bJezL2iteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOpq6ykjwweqGxQezZEa3yH+icaaxnYitGLrh2jZXaY=;
 b=yTHMl3mLhoLuOZZYvoZsiv8hjre51mmcZ2WskoG45VlBCcPI4dPRpvho9JLQl6+2CggEl6worixcTb/Dy8yWMCfPrzl2hetjxSRGRI23TjMWiZ4CqjJ6KaUrQMKmW+oDUhg/dUyUYDNc3hex2GRHwiT+nImaG7LVcr3VK1A911dir4xiyrFK8uCIekSzl8ECX/+2aEH1s8MnJTjRLY6lVc+heCRiC7Wa8LoF5aFcv2z8pOYuD3bYEtmADOqBGBesghQNm8nDu8iLjCIah7jO17TQP6MQZzzwSCdRt7U8HEJFSPEfvfFDUdwnGL90Hj0LsJJy2t0DZBDkwgsfsVWQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOpq6ykjwweqGxQezZEa3yH+icaaxnYitGLrh2jZXaY=;
 b=oSCB82nU6yuED7POWwOB7Ed2PxE5BsixSkMNu9HrRjIT8inU11dT9il32l5nkWXvGLq365ge62dlbAMiK3ml/vT/33FQp2izph0A8vma3BsFNta3jFes9sSwMLMRJIOau2abVEgqe8Rwml6MoJG/Dt5r1shGiL6J/rpXLlGjgq9JZlmmtQOnx7BCc+GGsM7GhGL96K554NRS8y4aOeKe3jSeHvB2jMOUC6SpAhykb2aGdHjEvk830iRe047eJIDrniUFaVs5sMcVTDKqc8eM4pi1v9hmeW1L8Ti4zbZPaDQZqfWWEnGzOJ0d7faJvpImzNeCwc2JBOvSIkyJQEcaZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 13:38:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 13:38:16 +0000
Date: Thu, 9 Jan 2025 09:38:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
Cc: Jeremy Linton <Jeremy.Linton@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"robert.moore@intel.com" <robert.moore@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"wei.huang2@amd.com" <wei.huang2@amd.com>,
	Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
	Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
	Rob Herring <Rob.Herring@arm.com>, nd <nd@arm.com>
Subject: Re: [RFC 0/2] GENL interface for ACPI _DSM methods
Message-ID: <20250109133815.GV5556@nvidia.com>
References: <20250106163045.508959-1-wathsala.vithanage@arm.com>
 <20250106180140.00005132@huawei.com>
 <85fb2b19-9d15-44ea-8f76-b3cac14e2810@arm.com>
 <20250107174842.GN5556@nvidia.com>
 <d35924de-a560-40aa-a99d-7278009c5ff3@arm.com>
 <20250108205030.GU5556@nvidia.com>
 <PAWPR08MB8909F2373F84E4951F74A79C9F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR08MB8909F2373F84E4951F74A79C9F132@PAWPR08MB8909.eurprd08.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0939.namprd03.prod.outlook.com
 (2603:10b6:408:108::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 75290dc6-21ab-4222-4fd8-08dd30b2df4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?keNj0S25F+x0XAYhj4nKvYQeP2fBD7+B340ca0y8O2hwM4w7/VwtTQr/+zZQ?=
 =?us-ascii?Q?yAa5W+0Tq+Z8Y7OU1n2nRdcjVsDpqjw40Xq4xFwyy9HRL4np4jaPRVAguXBh?=
 =?us-ascii?Q?flngLqNN1ZULdiXcPX82qyrsZ2jk11KO69roG2cMkMryLpGnebAOKZXXbkZW?=
 =?us-ascii?Q?PQ8uuKQZB+Zufb23IxVSeub0+x1juZRNW00oPMmyprDzFNgFOhovloWEAgcb?=
 =?us-ascii?Q?gvFFPjhUq7T4Q461Q6xnx8f+LA85ejz29bdaE+A0TrLlV2K7Xg3M2umHvYcQ?=
 =?us-ascii?Q?Jne9lHSH1kDllFydhrZLAPuqSPTY6w5FM1o4SNRm+pi/yAw7kREK25M949+8?=
 =?us-ascii?Q?KSZhRZaCZj0w/jJWla2rW0BEK2Q4GbFAu+PbiqXCBI0VqimxZ+VPWUUFNLK/?=
 =?us-ascii?Q?0+BHU4bKFaHDoqy2GFVRlUvti5vEb1vAAqNiVzGeShJedZMddOqAKct+QWzg?=
 =?us-ascii?Q?q5lAfTRSjyJY/IRt67zDiYaLtMBOZMABzTtD1Y1UDHmxnagNeQSe9XWJWiOr?=
 =?us-ascii?Q?uXLZfwzHwrUmSGzPVdiI4+EaQW380YHEwBTs02UQFuyvXv9XEY6m9K/6JbGa?=
 =?us-ascii?Q?S5uQQ0DAN1EZOopdGfowIBhrceEspkqmt+ACvR/GJqHuJNb3sXbTvpm+pbsJ?=
 =?us-ascii?Q?h2ahyf/XY7LAHVLbckeNYWwkTgrgarc2XMnQblr3KLua/o4sX6F3SUIYozM7?=
 =?us-ascii?Q?aakbyyUa2WcCMUWgO38SespvH6r4si6ck9fAsX3JUykLHZqOA5+bGfcTun55?=
 =?us-ascii?Q?K4pGFIz/Z8n339v4u6qTx3tRqixwwAad1nlVhVMUb9g1TEyJi/Dt7MFlJwyv?=
 =?us-ascii?Q?7pm1/oBVdTsuYM+4qJ703FMyP19WF/QkYTQOqaiECL5KCSiDLHNDxNKHdwyZ?=
 =?us-ascii?Q?VJhoZs4c4qFNs7PibOA3XDs5oA6rSgFDcQ5m55uSXgVTb69h3CKedltG7MBI?=
 =?us-ascii?Q?7s6M9cvApZZLvn7PDJLOpvvECTNy/vnSvEcxMrY0EP8phFrrgGtThOMp8crz?=
 =?us-ascii?Q?oNiKIz0imXDbYv1oL5Vjs6+1PqLwTdcsZv9q+5Ncq71SvrOWkTuPhVcIfPd/?=
 =?us-ascii?Q?Z32I+0IWxGfUWklMa0EDnj2D8S7DF4k2ZPegn3R4Np9ohut5EwUG97EGjTP7?=
 =?us-ascii?Q?8s7PNsPZ1jJf733SgPDS63qP8vWcNRecsq/dy6/m+TufQBTtFfNuvzlz81so?=
 =?us-ascii?Q?dwHeQzuYl2tYhCay3LIltD7rNN54KZLQcWCTpRIdzZVewBH3fjnvJkEdzYZP?=
 =?us-ascii?Q?uo2fW6uDTxB7Hk/v/bkCbM/jJiOwj/pBvmQpVzZMxyVIRo8qtUKYqPf7hRi+?=
 =?us-ascii?Q?dwSbXZOq1h9w0CJuzGrtP5i0uStecDdbeiy09hxvFJ87ZP3DfEIBdOtOrvyO?=
 =?us-ascii?Q?EuZj9S5/QzjykZBmsiohXct5Jv/Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L69dnntU9b2b2+lVCLWG7jqYYf3KsrEkaDj99p9DYKlm6GBS+aanq6IpYum9?=
 =?us-ascii?Q?GEixqupnmgEheVDuZ6S84tMKsGJrZkR3QlN5RNfJqkdkhFq292pcPoTGJU+0?=
 =?us-ascii?Q?aY+kcwcQMFDVJdbQtz/Gpk6dgFXXMaqHAmCA7hTGnkAEyPUvktBXvmg3BKJi?=
 =?us-ascii?Q?A8B6rgw2mfw8f3iLB5nNbF1rmFzWkDag2AtjkVdsFtKGmQyKR/1nWu3T4o3m?=
 =?us-ascii?Q?hB9kIIDdJmo6n5tf8wyrPS/9L93pybGZfS987NpNBeRAk8Rk7cmwToM53Rqp?=
 =?us-ascii?Q?yh2/Z2MBKQFvAP/lSG40O4+iAM9khh5HGJI8eVb1quyz+HPY3HaQSwxnaGB3?=
 =?us-ascii?Q?DbV9OzXIxrBVoGL68om5Y5xLmA3Y55QKp3YZJHFAoJEoOf5zLR7W4dur8l4L?=
 =?us-ascii?Q?EA8L+YvCjsvmS4OrqS8VA1qQmFPgH9Gf8q6jdv5lLGwamrkJeGTJlBzRL4wS?=
 =?us-ascii?Q?KeUD9De6Xz4oT1q2KQjGVPKokSPHGN6DWLwBIBLNwDaylWHiDcG/14elieFZ?=
 =?us-ascii?Q?foR638P7bhDK8bJs9j3nrtYptT6x1EM1EUhO1yYApYiSKrMoHBIwHn80eC1u?=
 =?us-ascii?Q?6cj+R5iW32e03Ez0K7w0Ui2DJqBiiNrD5HJBxlP3D87D3G+30Pz43jVhKgS4?=
 =?us-ascii?Q?HkoEPWUKb6c+jRZ/mN+o5/iBXH+//RgWg6Oi1+LpFtJv5H7OQ8rEvpYPlHA3?=
 =?us-ascii?Q?sPEEVRv7QPMfqF52mOGmsEhYahkiRFqkj8YpcSNOlVirSxfnOH0ro2u7hr2N?=
 =?us-ascii?Q?luQtNhZjKf6hbLznErZbjb0ez/b/+70heft5c0ZD1LV/MfVTgUOEoZALkIe3?=
 =?us-ascii?Q?DbKNy8fJGqNGuyj1D+oR2S2CpMHSJNxzfpi/q6C1v+Py26VXCA7Av7dCwgEk?=
 =?us-ascii?Q?DrqE6AvdCIK/FcS0N3pSdUGv63pAz/vxYGoiC5VfeLhnd8Si5nija4zbTM9+?=
 =?us-ascii?Q?LOR7HCm6cmwogD80rIyfF+8rm8m+49a3W0OS9iYtt9IiJPzTfe5zAQsvN6LX?=
 =?us-ascii?Q?dnbB/2KPnuX7wZuxVfm3VrlFrcZiWighukwQv4+MKQS2AvvP7vKVvyp3itPL?=
 =?us-ascii?Q?pnzOVJZLqk3x7SKEyKTMJ1ZE1Vzz5Evua+ngsoNHKd8y1aqrWB81wb7Pb3af?=
 =?us-ascii?Q?EsTePCyG5Uxknv3sIVI9J4O9w68LJUuEHJCb/3MgqKKr3AEsqbxwQeruv2Fu?=
 =?us-ascii?Q?KCPzzPDT9k5xElLyKCLYKsFDYBSjA1otZfh6Wt2nMOo68ld0HzcHfNagbsPe?=
 =?us-ascii?Q?ivIa8TW+SWF16QkyzABDAtLRZ9oALR9DB/W3M7d6NdmaPY9YuYKNucqTx2xm?=
 =?us-ascii?Q?eICsKOMXHVs3UZyIwArOSxzBUEIW4zslBSUTG5u9fNFlvru8wCryRfAzTcUN?=
 =?us-ascii?Q?hPLNOGxuPpqNqhifadQv7tWgTyIffwb53fYw+IrfkYv562RJfBnkcFW1pAjM?=
 =?us-ascii?Q?LoecuYbxaT+TLob+qSvR6zSvvMOoIwR8aY5wyX7kBAljljMQwMtKE04W1vKJ?=
 =?us-ascii?Q?UaDD+c234eIkNpFVFVk0nw1i0QxZEm1ZpBq3TdJCbOYvxoMwRoa0NjcgnoxH?=
 =?us-ascii?Q?+uxjW49Kost5uLB+i0U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75290dc6-21ab-4222-4fd8-08dd30b2df4f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 13:38:16.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8rjPNVLmMWylbqZq1e8ichePdqH7hnVZUUSkeDhq+JfSfrD+k51lQauwDVbnmiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318

On Thu, Jan 09, 2025 at 12:34:31AM +0000, Wathsala Wathawana Vithanage wrote:

> > > I'm under the impression this is a similar problem to cpu/irq/numa
> > > affinity where the driver/subsystem should be making the choice, but
> > > the user is provided the opportunity to override the defaults if they
> > > think there is benefit in their environment.
> > 
> > Which I think has been proven to have been a mistake. Instead over overriding irq
> > affinity though proc/irq under the covers of the driver and hoping for the best the
> > driver itself should have the opportinuty to set the affinity for its objects directly.
> 
> Do you mean that the driver should handle affinity requests from the user directly
> as per its policy?

Yes, not every driver has tidy mappings of objects to interrupts
vectors.
 
> > Lets us not repeat this mistake with steering tag. The driver should always be
> > involved in this stuff, if you want it to work with DPDK then go through the kernel
> > driver that DPDK is running on top of (VFIO or RDMA)
>
> This RFC is only about acquiring the steering tag from the ACPI _DSM, which the DPDK
> user space driver will set in the queue context of the device it manages.
> Setting of the steering tag part happens in the DPDK device driver.
> Are you suggesting that I should instead pass a CPU and a cache ID to VFIO and let VFIO
> decide what's right for the application?

I think that would be better, yes. Get VFIO to give you the steering
tag information, and any related control of the config space you may
need, via an IOCTL.

Jason

