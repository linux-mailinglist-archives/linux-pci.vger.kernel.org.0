Return-Path: <linux-pci+bounces-32982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F899B1329C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 02:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FE118901CB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623714C6C;
	Mon, 28 Jul 2025 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NELdebux"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212A7483;
	Mon, 28 Jul 2025 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753661354; cv=fail; b=R2TL6db+723rmH2cZzizDyfRcGIhvCMICHrKnByA80vAu9g0aHv/w3FzFkHLkfJfGm8wxO9gOD03gYqAr7kfUtdV3bW+qm6ONbHXe6HscDBxirskZuGQiNpWs8ChtM4PBa3J52chui0i1B4+Niwr7Bu5dvxE1vQsbcKZxKqPv5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753661354; c=relaxed/simple;
	bh=+PLSt0UWj/rn+Nwgz7MeILpMdtmasPdzbHC+M2JgUY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L4TZhyMfkvZIy7sHoXiCTxlC+Zy0hLN+jURyEmVW8uYLis+W8LLj3maa8hwYAnMZaQL/ggTz2ec0AM9lavV0Ccbq+/f9Lj2Ja37XYaXQeZ/DJosOMIbUJgZlgMNee94foPUq4xwopOsbXl1DZQ0GrYB+vOKV7ow+YnHFMHmnbCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NELdebux; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrs8B1PEx84WCQEC395JLHcgxDXtU8hu5T0mVLT58C1OLGGkXkNkRWBMslrBWtkrRAtElst32Fjwcmuc0NLJOZ4XjxmsXGJRzbT4wSlRjabpeRsI7CdyfvmTkgtHqsNtR0TDmn3tj6LDRdDGFQCxXdUE/KHWtogtznRL3ClMQZ6EcIJXwgWpGCV5+wUmrH8ZS42pv+/zPyEnRBspbN4WAMg7oFdWbOIEXbUZsWoK1nLRPu03d52O/hApgEAM7IHjHFH7V+Y7jSjcwjumWQyXjAnaAoPswGDgonOGTK6lWOpgsI3RouGh3ngBmz61dtAFPlp2L/84rrQ3Hhvk6XxUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHEx1nGFXTSIwcPwLQKsI/eanrGQb/d+W4p3EA1h7WM=;
 b=utUTIDIjB6e7NM1fR+uTAoaM81PsBJXPtzQLCJlkc8iVCE0/QKjoe8kKoU8W0ca/nwsPeXfnsnU8vu1Z6hCVwARFy0AGcOWLfdEH/gvvi6iGqD5Wr8WytS2cZuhffcDW4Gl77AkQNr5majeEDVc3kBpsUOrTagKX5NhAfaAqf7nLXNGbmbYdyn1M0h4wXM7OBpOb9Aq2IA379ixDU8efc3s3H4euphCgAdfSf25Dt31LTrEQQjYnFVf0j4lyHBR5BhgY+/e88K46sapqWlz+c3B3pNlmmMSQb5/0+Fl2RjvwuYOiA2Ux3ky9eLUDfduTAHjM3A4syvjwQPT6yT7uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHEx1nGFXTSIwcPwLQKsI/eanrGQb/d+W4p3EA1h7WM=;
 b=NELdebuxgYyouViViSfeSFq0I9Clf0AD03iRqhGI65UruCK1yu1C6pFA4mrqckLVqMonFQ4XmYz3ZFn3Bpaka6+//XZ9MMY2Sit2Guv/ZlyDfRx3Sz9v5icjtERWGRNv6ZwPjEATLx1noR/ut4z4bDcT+659o0prLRfZFMRtXL2CK7uBBW40pHIyPYo6iyDmkIIyqJ0lBBe0DZS76xz0PLgA6nLWk2loklyRmv9kbURNq5IjdMmwgLsWFWsS5xglRj7xU/FAsMo53KuYmjkG6mOUch04zs3DznDTunzyzFG2Mf/YEN1Pxkrl3bXRClfaONUwNVlkNz4QgUnWFGmtNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.25; Mon, 28 Jul 2025 00:09:08 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 00:09:07 +0000
Date: Mon, 28 Jul 2025 10:09:02 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, rust-for-linux@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
Message-ID: <abk5cp3hi3o6tyfnfz3lq5t6l4vgb5txnmyle4lvf56kj7zhx5@i4rddy5xdm6f>
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
 <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
 <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
 <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org>
X-ClientProxiedBy: MEVPR01CA0064.ausprd01.prod.outlook.com
 (2603:10c6:220:201::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 0820cb00-0026-422c-24f3-08ddcd6af852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFfle6UYHUWs6R3dR1uPLd1FJ4ViYJK4JLuos6tL7Vq+FvrFV2KaVuucD6L8?=
 =?us-ascii?Q?qmx2RIvocAnTQ/qTvf1tbJgJhS6kHKzwbVHO7FEN6QjODspn2PLR1dqGPA2+?=
 =?us-ascii?Q?/n0aVyKxDrLgf2mxAfRD6NmUbDyS5PNTZdgVY3F8gbUjNr7F3H8ha6ABpYtc?=
 =?us-ascii?Q?aeLGyphrh/r9BRWrnvYMqwzdACtIRalm4i17LMqyiRYg1WHMuvrYENsuxslw?=
 =?us-ascii?Q?xTslwFxFnKgv+l6/Ux+MjPOjw6otl4WXydIlvWfQbHO2PtzDtomF4/JaEt42?=
 =?us-ascii?Q?CZIyir3QknMRXwyuhAjl6XYtfHuiyHVYltNrir1n8+rCaaJmDuLaFn7sJ7pI?=
 =?us-ascii?Q?o7IKkoe2Xr7KACWEF47Z4DOegkCBb7Ereon6FWWjNvoyLgf70uYV7E4ADBsQ?=
 =?us-ascii?Q?/GIJAeHFJ6UJR6FY6qGU/yfWq7JJ4ipqvCbPAmw9UFFvcqr/NtOZd3x43PH8?=
 =?us-ascii?Q?Xot7aMKRqQRSg63+Gp2Xq2PjkpvsoEAp0KV3u+S/+cms0r05PrRNOyCp64Cn?=
 =?us-ascii?Q?2xIyqVockSe8cT/vQWm/QAayvvUICIekwoizGqZYt9+K2BfJ6K5HseM/A8qp?=
 =?us-ascii?Q?hQu6wPujGIg0V887UZETbxNsUDB8DYizNmtWa+WRLpk8ohbyAKR8FJAp8U1p?=
 =?us-ascii?Q?KRO3cO6+PsrrMt8kmXZSjG0QZz8BtvjE5aqUM5NO9X036kVPPZOJi1/tn6G+?=
 =?us-ascii?Q?oL8Th7We1+FrnLOJ+vH20QDHX+5SIH9le7KIuqktrXz76C840JMOwKyYM8+7?=
 =?us-ascii?Q?K7+uqKmL9pldIfVewJnD9K44z9l+mmxKMaxQ/qQFbnzKf+S9i1O2nnD1RTxS?=
 =?us-ascii?Q?P/U/6xfps9LPa7v31vp/UUCySwIL2RScDZ6Zsoa6i6WU9W1Y67r2EY/e/xEF?=
 =?us-ascii?Q?wtbEgUzIxgI5hRVHpK0yX5k33Wrj4PACEZInWGjbMNM9zCEBrLEFOiuM4p4T?=
 =?us-ascii?Q?hPFJi94tab/pfoRSrL/iuhBIod5B8jpZVHecIumZJ51qGD/J8FrI0PP4UHsc?=
 =?us-ascii?Q?rrNUZg0M8Q9cWSIq4lvz7BlrCrljI2Fj31wUw4V4Ezr4BpdCsGVtfDAQ/aud?=
 =?us-ascii?Q?g8CYtYUzCFRYeTKaXP6LfoEcYluvHcA8WUEr7/eObDs2c/15JxIwA0f1Gxog?=
 =?us-ascii?Q?fryXgro9OwqqWTnf2PwuDCYHJvOR9SYDVN/vYm+ix7vBlIEM8lpSwy4j9y3C?=
 =?us-ascii?Q?fYD7siop2PQglipF1fqlkz+S5/mFoAvqozJgJNfx442PpcVZP8SOZGVgmbA1?=
 =?us-ascii?Q?7xiWTLVVsVKIivCd9ul+1oIntTw2JeTjIZoVKIeYpsfqxmdF31miMOiKakNL?=
 =?us-ascii?Q?Ai+3JfkQeEYJXUw8u4iOwWhEAngwqGBzMByWYRzmwz+ZQHQtz9qZO9/8igS7?=
 =?us-ascii?Q?L5YiFLj6X9efdDQeYbLNufK2dP4+XiZo2NWTK3p3VjyzpgLwMnwOWBayvtYY?=
 =?us-ascii?Q?nTpp49ifW6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1xbqlIWgcoOMTpzeAEiAegkGQ3eOUR8oDraM9gXa+0GwxBqu2voI2I1YTgi?=
 =?us-ascii?Q?mp3mr3JTG45ieHqqGIRV5MLyunT0frm/+Cgb3mTnMmgYsmdduTA6EgMmBQ6n?=
 =?us-ascii?Q?y4Pa087VqPy2cAh1AhNCeo8L9911Z7rbtAs7tf77yCAMtBVz5/N0ugRju+NA?=
 =?us-ascii?Q?t7lr7YuqMQ54voY+XpHZyJchuCaIY5PU30lonVCyCbzaAYuq/nXdycdDM1IL?=
 =?us-ascii?Q?8I7GhVfljbO7Zv1FY7wSODYw1RGvPGp7ChQ49Y+OXTQT1Na4mPRJLmQndsXJ?=
 =?us-ascii?Q?CPUUEyNj+DCLrAdNTQf4EBIYxld73wL1kQgL40CDHXj6hDssiykJPm4/9Lgn?=
 =?us-ascii?Q?j9PIDfy653CHA7ICGxvRyqZdhORikliq7lvk57OXvtEYdPoJuMNmijNJ6KKS?=
 =?us-ascii?Q?vql6jahMd/RadsLFPDh0eGt5rKk7CeyD7Eh13k3fmXoMewU71qQLy8jMLkMk?=
 =?us-ascii?Q?/QrVTME2QO1NuT5FqAU8Js4jF3LwM+/2ogXg4DRaEhzu0nPB4WRAm0Id4Fis?=
 =?us-ascii?Q?hd0IkzkLztj6su7MMowVZKGZLP8yyEKeVM07rBPFU8/s3guJYj1bVwlJ1U/K?=
 =?us-ascii?Q?M5PTgQumeXv1qVKb8q8d9fvFRTr4cFoTUQUHpmoiPlINqlmkxVlKW4TX6iDQ?=
 =?us-ascii?Q?n35gWtPhnp7A9uKjFZVsbDFBRDzh3m5jZAIteCgKfLU2/B4hsiub+o4yxVqB?=
 =?us-ascii?Q?fJkr1KgilEUqv8RQcwZD0CKvuPnfLHSxuDvnseYzxlI/OBmCHehEQ6Fr+uqV?=
 =?us-ascii?Q?SikJnMbq3eMPRv525A6j9GsnhlJuviCERYq0yuXNYXzYcodUSHyQV/Wh18/2?=
 =?us-ascii?Q?30byrf+kbiQdnom5W5J9JNx39CVZW9A4vSwgjA/4Jc+aG/ih6ZysYUHPlN3H?=
 =?us-ascii?Q?/lxB6Z6LyqKOpASdbut9F+riyH1mOzFSbMN6WP3ManfapYGrqoEDavbX/AxT?=
 =?us-ascii?Q?z/wvxihcJ58a2y8wxCLwB0AIGbDfes0ygT5v3dOywJSJW4RKtfg3Pzn9XHnc?=
 =?us-ascii?Q?0QGPEWd17r/Hc+d44XqZDFdZPwG7yEablnh1dN8TIfpwxvFAXMnrGXQxnuMJ?=
 =?us-ascii?Q?cR6MszQ0L4AjMQaSyO6eTKbfpvLA3Txn2HU+QxzCvsE7jdCExcWwMBgZwJrm?=
 =?us-ascii?Q?zM3N54DVroDqpvDlgX5rHKA42IkSXPJvUKahg4sy0OTP51yzTz6HxkD3VNy0?=
 =?us-ascii?Q?/vedzstRkBVecWqw0uO/XCSvxOtbSsUazN+nDGQYpqdxxHzlosc2k140vtfC?=
 =?us-ascii?Q?gAsAz44ds84aCYtxrKbvUuJzUH9zYn9BgBkeUvX2xqp1WW1cTXAi3b1Zm86O?=
 =?us-ascii?Q?TCPNjC4H9y5jZ5X4UCseHIlaRIlhwh0J/2wlZcuK1Uvi/7fmVqfUnIU1bbnp?=
 =?us-ascii?Q?lJDQGdm6GYdD0noHHijOAxntGLBBkkw5el0+/Mm+4+L2GxSBIMhN+CxrMKYy?=
 =?us-ascii?Q?ad6/0HoQMKoF5Wrmaj5T1CV06xupegcDG2jgNs6A/bKHMHDWNWRilio3NZzr?=
 =?us-ascii?Q?W4WE8UkpAD5DwW+XF6eqpCbNmH6FfUmyqxyhV/nZqluWau3UglKiZWXGOK/y?=
 =?us-ascii?Q?ZPHN8kidjOwX3mQ30AfOKKS8F3KpS6U/KZtpGZQW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0820cb00-0026-422c-24f3-08ddcd6af852
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 00:09:07.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/O6UVmisEDcBOA2V/oWNih01il6EHciplKzXVZkopMhMWzn7WJLFy4SomTCtiIbpJUBMhzzaTYoxMWKIr1+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414

On Tue, Jul 22, 2025 at 11:51:48AM +0200, Danilo Krummrich wrote:
> On Tue Jul 22, 2025 at 7:17 AM CEST, Alistair Popple wrote:
> > On Fri, Jul 11, 2025 at 10:46:13PM +0200, Benno Lossin wrote:
> >> On Fri Jul 11, 2025 at 9:33 PM CEST, Danilo Krummrich wrote:
> >> > On Fri Jul 11, 2025 at 8:30 PM CEST, Benno Lossin wrote:
> >> >> On Fri Jul 11, 2025 at 5:02 PM CEST, Danilo Krummrich wrote:
> >> >>> On Thu Jul 10, 2025 at 10:01 AM CEST, Benno Lossin wrote:
> >> >>>> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
> >> >>>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> >> >>>>> index 8435f8132e38..5c35a66a5251 100644
> >> >>>>> --- a/rust/kernel/pci.rs
> >> >>>>> +++ b/rust/kernel/pci.rs
> >> >>>>> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
> >> >>>>>  
> >> >>>>>  impl Device {
> >> >>>>>      /// Returns the PCI vendor ID.
> >> >>>>> +    #[inline]
> >> >>>>>      pub fn vendor_id(&self) -> u16 {
> >> >>>>> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> >> >>>>> +        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
> >> >>>>
> >> >>>> s/by its type invariant/by the type invariants of `Self`,/
> >> >>>> s/always//
> >> >>>>
> >> >>>> Also, which invariant does this refer to? The only one that I can see
> >> >>>> is:
> >> >>>>
> >> >>>>     /// A [`Device`] instance represents a valid `struct device` created by the C portion of the kernel.
> >> >>>>
> >> >>>> And this doesn't say anything about the validity of `self.as_raw()`...
> >> >>>
> >> >>> Hm...why not? If an instance of Self always represents a valid struct pci_dev,
> >> >>> then consequently self.as_raw() can only be a valid pointer to a struct pci_dev,
> >> >>> no?
> >> >>
> >> >> While it's true, you need to look into the implementation of `as_raw`.
> >> >> It could very well return a null pointer...
> >> >>
> >> >> This is where we can use a `Guarantee` on that function. But since it's
> >> >> not shorter than `.0.get()`, I would just remove it.
> >> >
> >> > We have 15 to 20 as_raw() methods of this kind in the tree. If this really needs
> >> > a `Guarantee` to be clean, we should probably fix it up in a treewide change.
> >> >
> >> > as_raw() is a common pattern and everyone knows what it does, `.0.get()` seems
> >> > much less obvious.
> >
> > Coming from a C kernel programming background I agree `.as_raw()` is more
> > obvious than `.0.get()`. However now I'm confused ... what if anything needs
> > changing to get these two small patches merged?
> 
> I think they're good, but we're pretty late in the cycle now. That should be
> fine though, we can probably take them through the nova tree, or in the worst
> case share a tag, if needed.

Thanks, although I don't have any burning need to get them in for this cycle.
Next cycle would be fine too, I just wanted to make progress getting them off my
TODO list and it wasn't clear if more changes were needed.

On that front is seems like the discussion has settled on maybe we need to do
something in future, but not for these patches? So aside from the minor nit
below (which I will fix) I don't know of anything else that needs changing.

> Given that, it would probably be good to add the Guarantee section on as_raw(),
> as proposed by Benno, right away.
> 
> @Benno: Any proposal on what this section should say?
> 
> One minor nit would be to start the safety comments with a capital letter
> instead.

