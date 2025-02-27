Return-Path: <linux-pci+bounces-22476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C36A4702D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68CB7A7497
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED051322B;
	Thu, 27 Feb 2025 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SbkyTiL3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52CA47;
	Thu, 27 Feb 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615965; cv=fail; b=L3st99JJQoUVQqQRaGTIl2/QV7bKrm7Ul2J5Z+7YFyHVVatMqQHoCJKLDXAC9DqCIaD5EfvVMqKv5Srfi54Fj6jueaDxGX2DeaptE2oOC7Kgh80m8skC2+g/E0LLcI9ZptO+Ly/IzpHN8VZrgEmMpizeqPruqio1Cb14Jd4ol4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615965; c=relaxed/simple;
	bh=XwxnhaJLFHjjbDfEJPe5h0Fz5KKyqHB+Uqq33Bppxbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=blY1a2yLrZRv6Ivx1gGaX8pTseFn5DiGkZkk2RPk1U5lTx3BVE5VZV2nbn+KBL14LEP4iQG5yYYXlmtIs/F5JthfcAMyWOr2qq8T5Wt315jLXMQ8KJrB712LhpV5EI1OMs9f6A2+vj6dO1yV+mL9QvGohwpSf4SBG//07wSpUzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SbkyTiL3; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n74CpvXlvslPEzkx458SFTJmjiCTd4gN68B1Wta5wclq/c1gK/Hv2hqzO6gSYMbs/Nv+cLGBkGBXsyEaQ9X7sXtiIJqgAKy9n4nmGgK7M5VVDwS19gfOuZlgrpLD29DESy3DAo7OXCgfPTHr8cvtejQk1n0n0WYqC501fzXn8LtWYw8VC1bDgv8eqBnTt1lKuhasJorbZrrLcl1666FE0ezyIF3EUXaOLqgGDKQQ7UmfR73/8aJhxp4G8cBVXdJhjWRK7dKj8zC0oi2GOlHMP4+5yJJL0c7ikf6/odd26BruZQbMaKgItURuJkSXO9kkwJjGuIOShiQBaga+OpJkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9snW3n2aX5WgoiqPe39qoLgIpnW818vhzuYo9p3p1rE=;
 b=WGV8er4nNCqItgzfXNcGr1pYYlaImoNDOU887Ex/IS0d+uly6e8cFZDE9Kw81N56NnfCqvWBFtQPACu1jMIxHF+PPgpYb5tBQGE6vcS2GxI2s3dmOsCfwInBVOKpGj+pzwyXo8LOAFoLev5wvGU2l1u7agBf6V1FeReb6ACjsaUJHz8kOGMTguLMzR8YBoYTnKealhkHzcEMWb5a85FDZh5G3K1bi8vjdOHC1HAGTR/gqAgz5XMOX59aHe1iT6NlPWCiMnI2CvH1qHCZ9SHOd90cETeD7vOVxbO6uH5rj1hBfDOOgTHk+2DAuhJzWSNxJvi0uSeYYxHHn4XNHegmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9snW3n2aX5WgoiqPe39qoLgIpnW818vhzuYo9p3p1rE=;
 b=SbkyTiL3DZvbE/xaxNJcO//DdMsz1g21z3r6/tAt6fTB3TBZjYMlS+qXc/ecAzNSp3YwD7MfnSkozzzij2Cgol9BfmD4Tz1KXHVMlk7EcZBcm0XeD3xl9OduRFm9hZlcymOy76RfMDtuqXYUzH9TUW8jbRRENF0NsJn+vL4lhG6zB8aMWHad7kBBKLK8YNmMz4GKjmoKUU3haY37sQfLreYydlYUa7zQeXv5pyWs8u2hgZPAKNoRbdTkWwsIf/S01rXR4lwi9uq4PUmEriwYOJEqftObPWJh5p3ts0V6sM8/++mqO73t2dUh1nGEjtW4zIkDKf4psK02JvW5iuTtsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 00:26:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 00:26:00 +0000
Date: Thu, 27 Feb 2025 11:25:55 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net, 
	fabien.parent@linaro.org, chrisi.schrefl@gmail.com, paulmck@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <nlngenb6udempavyevw62qvdzuo7jr4m5mt4fwvznza347vicl@ynn4c5lojoub>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
 <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
 <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>
 <Z72jw3TYJHm7N242@pollux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72jw3TYJHm7N242@pollux>
X-ClientProxiedBy: SY5P282CA0147.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a811555-5460-4a86-92fe-08dd56c54fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQfaq6En8t1Xq6tbD9/PJ6CuwBvCOC1BVe9OJSj4GohyZvaW3MyfDP8Kkg6C?=
 =?us-ascii?Q?/N+aBnlkwgU7kqzlEUBMPIFDlV+/HPYjzVALzwGrS4lWDAiBMRqIWUYFEODM?=
 =?us-ascii?Q?T91Vc1MzC6ODIJLZT5A6IQUO6FjO2Zxr9EM1iS03zdvPXxh+3nKPCxy1rIaY?=
 =?us-ascii?Q?PoF0LpjDVa+td0XHq78mNsBTAFLl+GcQl1pzQM2/YvsTVOJhnqLjel0GAvz8?=
 =?us-ascii?Q?UkIo5845Iwt9LOUqU+eHcwSIZTJmEvwXVnJx1/eTdX337LJB5yXssNOJI/Qb?=
 =?us-ascii?Q?3vc7pCJ8tBbsLKU3pfSk9GJGBKAx2BOS6H8+ukV/SIlnpeyYDcrIoJsjWZIk?=
 =?us-ascii?Q?7JeJxGG9us3j48ajFw/RQR8i+Qlp/1lmpj8ExPoex0lRCEvFSbiPmxWMF4FI?=
 =?us-ascii?Q?RflIdyZYiSqYjVda+OFNV96SqITPzTheFCFkKldWAm1NjXO9PZoU7UtqqTuK?=
 =?us-ascii?Q?v6LnaqDN57ccCveHHC3Fmhrxqo6jMSQcJV5cjf8/2vRCMjgbIQa31u+RQ7Vw?=
 =?us-ascii?Q?W+GHLxWr5Ru49F5wUf4qDjax98pVEqFh9qxBZSeYk/CGzJyO7boqdJ1IoIkz?=
 =?us-ascii?Q?dXNv8qnNImI9bti+HeTZiMIosUI5Q9e+Y54uyz1CN/38ZqNb0QMcC17GSQaI?=
 =?us-ascii?Q?zhIQ0wyawtu1V6/v1FknijB41xJzPfbh6JiNU95t2kYxvECQEroT0SQLoEke?=
 =?us-ascii?Q?Yi2YalXP4k4QLQBd4mzzpNa/C9TSwm9uVOBn0G2GiMDzoLLsGPYxTWeohqYV?=
 =?us-ascii?Q?WKhcnubicT5ABl35SGf3zzgra/gm46qGUKAIaZScyXKIKfGgQXk4jTpjh/lt?=
 =?us-ascii?Q?qyCyrL0bsLSSdVc2zfvHmq2FXTEjz+bA1gkdFxesY8eCHghc92Vv7wCVcBAT?=
 =?us-ascii?Q?jdHRvI0yepKsgoepfElsirlJKCVLo5jK1UAj6+rjoVk/Cw5Utua+HkhJi1IE?=
 =?us-ascii?Q?TDhljbIDveGUJyA+cCde1Z1/KV7CDzjXqec8YMY89Hf/MFujbJD7phu8c8/Y?=
 =?us-ascii?Q?o/kh3L3tsuTTU4DnMxuYXNKgSnLtfuhwavK/xW7jAEFu7GIwv83iubJQgCoY?=
 =?us-ascii?Q?OYfVWan0WT7R4k9/+wd9yC6x/v/CYaFbDKUVXv+xXEYp/DcbrUWRdsWp/ySJ?=
 =?us-ascii?Q?R0iLSMvTcwgUd5rYrDiSgRbtLOBEDMXGn3ssG5807Zf8TGTuSrD/K2kjzRvs?=
 =?us-ascii?Q?DXt1oOZb8IqTdO7FK/K0DKsiDwh9J+6lWtIavC/l/9WrZ97DSl9i7ERCXxPy?=
 =?us-ascii?Q?vSKC8xjP8DxQ++9MImQ6Bltrkk2xxr4JWF1OvP/eN5GDkXfaXW0v9YXZ3jYu?=
 =?us-ascii?Q?WT9z6RLrWveDU+8l/0Xj01NAdUCLFJtGxq5aAtQRpmU4KmpcLfcMymtz/Qxp?=
 =?us-ascii?Q?mzRf5lgFTuBWIlroUZ129eLjRTx0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzaruOsmfL5Xi1hj9m1IJei+jo1W4RE44MfAi7O4Skojgy+hJ3rCmW0iBFO8?=
 =?us-ascii?Q?4npzWGe7BgiGh0Ho7SmKL7UW9vsL4wv86C6vEhxML5F0vqmPmdplaLrnrh/e?=
 =?us-ascii?Q?/b0KPSBJNEVAS+7W+Q1tSiQd1HX4B6HHDY47Xxvo26gKwD15ODj11z5GIKSb?=
 =?us-ascii?Q?k6PCwlNPFF88f0Zz1FAPkunUhE2A2Gliwor976e3aG6gp1GFI0kVBUTgyAPJ?=
 =?us-ascii?Q?zWRE469xnj4gQk9qHHCGXBgC/2LjkMMTp8NPwCKZvkz2IEgrZTMriwJ4rghd?=
 =?us-ascii?Q?2zKVc+ab9LPbbTVMVihR1Z6x5zmKAWCCVxjPxpP1pAc21/lR8L+xUIJ7vuWy?=
 =?us-ascii?Q?PCEGzzwvIIgE0RPKQ8lyePi6koD8dZTgGUqxAEPlqZKe1fASciaj0zBz5wHN?=
 =?us-ascii?Q?n6Pw/oYaD73PSAzrr7oj/b5MlGEHR1Us5ik2qeUTj7QGpHkvAimi0mhw3H8q?=
 =?us-ascii?Q?Frr9AgLMUu+27IqhhIPrRbZ7iMxmibnVgWe8art0TF51Y9aLbi3e43hiVYWe?=
 =?us-ascii?Q?ACxhDgiCpJSdpQOjtTVTQ1D/gomD/otE0ef7QIhbdU4dCMGQ7mt4MxaYAX9O?=
 =?us-ascii?Q?0DC90yF1wIpz2P5z010TpVsLGm4Vz5isGoxBS9zYpnkHcmvZHp9PUFwcIjZe?=
 =?us-ascii?Q?C85h4NQGw5tztFkq/s9nxXuA9/biX8hOnrOdaipQljMXiKE/m1YGkz6+tjOk?=
 =?us-ascii?Q?IRMJwngA97ONroykybOsXV7ONeBVvBRnJwSw6CtWlziQsH/cK6iBVUJoV8hC?=
 =?us-ascii?Q?MDpxmvHfMNoJvX7CC0F/rOa5B/975f6ig+s7uu/1KHT/N7Q9OwN/TAlcDffJ?=
 =?us-ascii?Q?gV04/LBRjD+nMcNkfHiwgGbE/6ZPCDrO8M0NOBogogeREIRtuZIlx5eJF1+G?=
 =?us-ascii?Q?17g68X3xONdyP+EDKW0XfGAdPvbEy9NqzWh004EHkBApdVBMDHMBW+/pHKI1?=
 =?us-ascii?Q?If8X/8mgBgnVhC6x7Q88z0s6SCcXGayjfZQR4zfBSfR/bWRLrkF/tA3oYcmJ?=
 =?us-ascii?Q?ls8eEsvUXA/EJNQMMkmYATXIzzA/YYnyY3t02ZEb1+x8kMXMiuM1EbEFnOuR?=
 =?us-ascii?Q?UIlvcxzBJMwTodrclpO+sEtAArDa+QI+8jEIBwUDlVHChMRLuhruxK9lurQW?=
 =?us-ascii?Q?FDeYvypwBNWuXZ4DoQhJhCWp3MgL4u/wVxmZ9PxdXHOGegbUDEnYx2MZCoDC?=
 =?us-ascii?Q?FvmP9510YuTFoDa2ozvJZCtm/6tMrOV1JYEf31b97G5pZrVE1NSlF+/o2I/J?=
 =?us-ascii?Q?njrXiyZZWtugswdEun+dX1hUbALFTzbLr3Ka41P8IgRRQVYXH5pwz/re1T/k?=
 =?us-ascii?Q?Gb1nmpxB7r3XYkPv/8KSb/63sF9zIxPA9NpCclq/02QQLtFE79pknJmFY7Qh?=
 =?us-ascii?Q?wKlsUQyzHN7Dx0xwYimIbCOLYaUtGs20cD7jZYiFvrMrSEpZzTrss+UFIteV?=
 =?us-ascii?Q?eT53j7EvQ+EAeF0iTvsBoO4FfmvVgkRlh3DdUgOaHX1uWXdLfl+VHLDjQWLY?=
 =?us-ascii?Q?holMi34pVu58HnELBoQ69aaPU8ETb0FqJX+n+KI8PRZWbpT8SID3JLYgqF3L?=
 =?us-ascii?Q?I9MLdOQKYx5IjwK+5uL/5tr5OVH4shwIYmgY34J+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a811555-5460-4a86-92fe-08dd56c54fbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 00:26:00.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHPgUn85c8BNUq6tNibQsrvCBR26c92HjtwA9V6ppihUuBmbU604OviO5U/8t3k0rCsAj2l+3EzvPDIcE3VYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

On Tue, Feb 25, 2025 at 12:04:35PM +0100, Danilo Krummrich wrote:
> On Tue, Feb 25, 2025 at 04:50:05PM +1100, Alistair Popple wrote:
> > Kind of, but given the current state of build_assert's and the impossiblity of
> > debugging them should we avoid adding them until they can be fixed?
> 
> If you build the module as built-in the linker gives you some more hints, but
> I agree it's still not great.

Yeah, that is how I eventually figured it out as a result of trying to resolve
the "undefined symbol" build error.

> I think build_assert() is not widely used yet and, until the situation improves,
> we could also keep a list of common pitfalls if that helps?

I've asked a few times, but are there any plans/ideas on how to improve the
situation? I'm kind of suprised we're building things on top of a fairly broken
feature without an idea of how we might make that feature work. I'd love to
help, but being new to R4L no immediately useful ideas come to mind.

At the very least if we could produce something more informative in the output
than the objtool "falls through to next function" warning and the undefined
reference that would help. I'm not sure if there is something we could do in the
build system to detect that and print a build-time hint along the lines of "hey,
you probably hit a build assert".

> > Unless the code absolutely cannot compile without them I think it would be
> > better to turn them into runtime errors that can at least hint at what might
> > have gone wrong. For example I think a run-time check would have been much more
> > appropriate and easy to debug here, rather than having to bisect my changes.
> 
> No, especially for I/O the whole purpose of the non-try APIs is to ensure that
> boundary checks happen at compile time.

To be honest I don't really understand the utility here because the compile-time
check can't be a definitive check. You're always going to have to fallback to
a run-time check because at least for PCI (and likely others) you can't know
for at compile time if the IO region is big enough or matches the compile-time
constraint.

So this seems more like a quiz for developers to check if they really do want
to access the given offset. It's not really doing any useful compile-time bounds
check that is preventing something bad from happening, becasue that has to
happen at run-time. Especially as the whole BAR is mapped anyway.

Hence why I think an obvious run-time error instead of an obtuse and difficult
to figure out build error would be better. But maybe I'm missing some usecase
here that makes this more useful.

> > I was hoping I could suggest CONFIG_RUST_BUILD_ASSERT_ALLOW be made default yes,
> > but testing with that also didn't yeild great results - it creates a backtrace
> > but that doesn't seem to point anywhere terribly close to where the bad access
> > was, I'm guessing maybe due to inlining and other optimisations - or is
> > decode_stacktrace.sh not the right tool for this job?
> 
> I was about to suggest CONFIG_RUST_BUILD_ASSERT_ALLOW=y to you, since this will
> make the kernel panic when hitting a build_assert().
> 
> I gave this a quick try with [1] in qemu and it lead to the following hint,
> right before the oops:
> 
> [    0.957932] rust_kernel: panicked at /home/danilo/projects/linux/nova/nova-next/rust/kernel/io.rs:216:9:
> 
> Seeing this immediately tells me that I'm trying to do out of bound I/O accesses
> in my driver, which indeed doesn't tell me the exact line (in case things are
> inlined too much to gather it from the backtrace of the oops), but it should be
> good enough, no?

*smacks forehead*

Yes. So to answer this question:

> or is decode_stacktrace.sh not the right tool for this job?

No, it isn't. Just reading the kernel logs properly would have been a better
option! I guess coming from C I'm just too used to jumping straight to the stack
trace in the case of BUG_ON(), etc. Thanks for point that out.

> [1]
> 
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> index 1fb6e44f3395..2ff3af11d711 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -13,7 +13,7 @@ impl Regs {
>      const OFFSET: usize = 0x4;
>      const DATA: usize = 0x8;
>      const COUNT: usize = 0xC;
> -    const END: usize = 0x10;
> +    const END: usize = 0x2;
>  }
> 
>  type Bar0 = pci::Bar<{ Regs::END }>;

