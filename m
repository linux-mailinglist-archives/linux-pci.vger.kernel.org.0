Return-Path: <linux-pci+bounces-42735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC0FCAB228
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 07:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CD830657BB
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942AD2E92A2;
	Sun,  7 Dec 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWBVq6vR"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35E2E8B6C;
	Sun,  7 Dec 2025 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765089335; cv=fail; b=jjnKgsYQIai25dghIhjHp3m1gskAn08LxpQ6I5O/ptV3xiRvBIYp564thKTOi4cl0WR4LPb1KoNB9/OW+SYpX+w8ijKbOUcTEcvcjVY+e0bW9dOdj26XKFMEzZKjJyZD0SsR15jScQLJ+XTJeGLkr38cfPmwj7cQSuPYuWbQ5A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765089335; c=relaxed/simple;
	bh=v814x0oCiG55MC8QMdoy9DHfjWhlAcOcXjt0PJz1i+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LjkDVypmaHpTm6Op98J262stlrY/PNvgh44gvnlzBcxIUjiNs1ccRSUcLRZzGtKIPTOSrkL2qI+0APaZbRsnapSLDh2v87Cu12OkxMbHvMqVr0VWXxwHyDxt/0TTA9irUhexQribyXtfuxy0jOR0owniru8X8TCksk9Jhw61YdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWBVq6vR; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUBzGGD2Yb59ybS/EnOVzm+cJKKUQb4IsF7z/Hz3gPFO89AY2PK197uFw7j1YQMFitajNFvRAlf0jTDFmuKfhir2X00cXKzG8TIDgXGbEmdn8FNf6T38JP4AJlRTpEoZIxHYRB6ioVo6HgnJqJz1/diwXq0AvTVn+GIu1gzIhW/GCjM/MkoEMsmVGMqEOI2dWKE0xbaQpreF8dmxxA3Q7nL3eBt/6LutIJJ8ETTfSkUgvDlz5iS5sJqxT8K4iqNYtmatYf/mUXI81ngrg/unksmXCrRMva25/+Et5ti/DkTBp5N3IzCx9tqPvyh3Nmkg40GBVQlsL5XwCywaQUlQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bovcJs2a+sTBz3FfR4/iDG53qDbj9oS0EgzWagTJ5A=;
 b=JgQZcr6gIFYVfgwrZEuWhghsOgfrmPMY4Ax3WM/TgsGG9kQzvWcEOgN8E1ZPLVma2uDMyPLM5z/ivo1PLZrcAADwjbIjqiLmuE0YcCBLQdGLURdGrSo/NcYS5o67kSp1HfELlaLA+U+lUvl8QlbJE1NRJRY4P3NosDkMjh5J5yMJB8/JfWSnYBh7npsDqdTLw+1z8XZoCiSZ703djcIHPinEyw4v9roQ+pryXoWcdKCCYwVkikP1B8MfkSl+e5x/WUX9kFnjr5J4wdUG4aIEDxOm/t5tQwGm+OYr7TK2gaq2voqjkJEx/W0yoMQ4AvqGihIIsfYU7Vr4TaJSkQBXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bovcJs2a+sTBz3FfR4/iDG53qDbj9oS0EgzWagTJ5A=;
 b=PWBVq6vRrLypr4kXufwV1MmLsFlNRCgJynfihsdx6v1+dFe8346LnZw+/JXDPEBOk1xvkkEEo/wQfxqQt5+INuDcsUH+X9H3rIpxXY0WOaAnalas4hK8w3KWVF/m3kHZc163W9gLbqnxVH7QZsFtenaHAcja/xtTNPiCDPFENEqCf8eoYNYW37DjxCVZpd2ONnKdJXeGkn/8CB7ZObN0uI9ATVFJ31/81pNDUfnOiSfsYw8DJ4NVx7jkYjWYtsfsTC/DwOBOTMnwQAz4WEuo63BhDy+o7KQFYNMF8Qea0M0QaE/caHG5VEO2SAGE6AuedCUZzqpjCw3thsHQmHfSow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 06:35:31 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9388.012; Sun, 7 Dec 2025
 06:35:31 +0000
Date: Sun, 7 Dec 2025 01:35:29 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Peter Colberg <pcolberg@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 2/8] rust: pci: add is_physfn(), to check for PFs
Message-ID: <20251207063529.GA213398@joelbox2>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-2-883a94599a97@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-2-883a94599a97@redhat.com>
X-ClientProxiedBy: MN2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:208:178::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: ca315e2c-a446-4d5d-c191-08de355ad181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CQVJ67qw1ofjbf31u2n8wZPZCORmoNauokEeyChoENyiMQbBASm6nZ3QKSDE?=
 =?us-ascii?Q?wX7MVJiG74cGAFKYLkneb+jc2TrWdYrTyjyNnJEUWTTD9aZK8PdYYXD+90Og?=
 =?us-ascii?Q?j2ETK1q5lbvpCnfp6ojRcpCauv5nC4dfrfID9D8M3Wt+vvsSUMNEwN4u07sB?=
 =?us-ascii?Q?JSl4jphLw+giOv9VBlb3S6I9hgguTgJhAIwkuafCPp8zmPmG2pgDaLxVDERZ?=
 =?us-ascii?Q?uNYIZZa6Bs3+GUtpZHQI6tMdLGIIBGmN9f1erxiKIHBSmVYMXCl65HFW6sVr?=
 =?us-ascii?Q?sZCz4sAsLA9AsZRjmEOexqhMLKiP+xjCYmbQP6lB5rjthc0ZjRmrlTaef52g?=
 =?us-ascii?Q?CbcfDS6CFwKVa9d31rNvShWhm9tKW9UnrdvYBDrMdy+WLOY9hlova2i9bNUj?=
 =?us-ascii?Q?03OowHspBfv2NpfyYK8JokWZPl3ce5aNMD1DMSksurhK7+qHSebaIwm42c0h?=
 =?us-ascii?Q?Lrec3KaIeYYAK1VxfaMR+D/pbwXXt+7LYf8sxo/KRXqyl8PeCyBmP9NkwzRW?=
 =?us-ascii?Q?BWtNlnVwW0MIKvOTlcNZBXbMJ9bx6cQkXal8Kx3hTREaHKynBsjfyK2xoYiB?=
 =?us-ascii?Q?eBvPYm2xuqiohUmP4ZJmKWm9KucXEjNNHDLQG3bRAq02o6Hgjki6J+2MkyRx?=
 =?us-ascii?Q?SPpR1xibPynIXsFTwCufNM8BpfxyV9GXjdXu0EkbouLMlI2STElGRvwXlPUV?=
 =?us-ascii?Q?maLE8ObPBeQrHPXYXvxXcbyiUcncsXLmO5ws7e9hl4X9A73VfZbzfwW3PhjD?=
 =?us-ascii?Q?0QVw4CeQCZfNlngiOuplFRB1NVwy52PgavaX+4HMNbR2qX9wxkbeFKc3Z3gx?=
 =?us-ascii?Q?0OfHpQ2UEZs9DQMsj5S/JQp/i6RwpdNiAHg0tg5g5K6kMFy+FJhoYrwjv6Pi?=
 =?us-ascii?Q?I1R7LytjWO4MRr+WLG2z1Icvthag8xiopoWy20FeaAkYKkTt/M+po1jl9qvl?=
 =?us-ascii?Q?mSOwcGNRbyJhhDa71EijDn8OKrNzpGblb1IPcCpvCV4e2JMKYTTuWd31qVSn?=
 =?us-ascii?Q?3j51XvnVns0H7LKvcRUPak1rckEGPQbMHMqM9YVqsiL1O9tMxdDDmc9ZArC9?=
 =?us-ascii?Q?HL9NnQgFN0hxUxKUn/SJLlw7DaZrNyrpv6OHnQedPxk1vw5HYeBW1Vt51+OW?=
 =?us-ascii?Q?zurDDqpE0y0uBUqrgqaIBRsCPhqGYReaKikzcX2eS23J3h/yFyshxycJBePC?=
 =?us-ascii?Q?1UuhgTwXX2juQjLy9CY1qgaAT8Zk2YV1yYkFliDRfZ3/3F9AVFJAdGcR68XS?=
 =?us-ascii?Q?RTyJwlNiJHyV0w99zaTZkCdwO/BKaPlU0APGlnC5rnnVmBKO0yj4uZgcBA2O?=
 =?us-ascii?Q?jPxzOxgTPw/TRkszc75JrixCBg1snugFQeFZBw940uFb3VKVEFSA4vewVOVE?=
 =?us-ascii?Q?8Ojt20765Lb3kbXXJKmQk025cT8wb9UslJVgvM2fOfuZSn0f9WQ3flnSBWTl?=
 =?us-ascii?Q?ngMiMSpkUBmGHLGmkiMZzvkMWRHvFbtv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?toyq86c3yACWPKzO8t/JqoSKYFCNhJqwvxp3RqRAhC3AxrLLxoBF5YfM/MUy?=
 =?us-ascii?Q?sCZPXuONHlXWgHSYxK5YIpk4cYqT/7B/PqDLrdckTtAKmbNIabFOc8bbCD4L?=
 =?us-ascii?Q?t7N1gFNw1g56eDE7OXBxq4B6G45lfiDkid4dn1PyA2sUSxehPwzZe4sOtuFF?=
 =?us-ascii?Q?nhRfE7B/jdDrEky5KtsEPBpG6fmCASz1UjhOvsphEi0d78qmo/GxK2Dw9aqQ?=
 =?us-ascii?Q?7OUKBXnv4ye3IEKDd8BtJoLKdrzzFTuwCdLum/E6lH2+OtoHdg9NvkmAd/nu?=
 =?us-ascii?Q?BM+gsKjArB2kwVHtNrTMOiJOxAp2epRhiy2wzZtMIq246811eDQJhenh7gTb?=
 =?us-ascii?Q?385MDb5CF43Hl73r2VW/PfUb6JUsE/eOv0ORDX/rg5rK1eW9pDdDmbiGMtK0?=
 =?us-ascii?Q?zVjtqxAQAAnIWpmA8olwf44TYScuNSe4NHgEJTr8hG+2b57Jjqt/mCgpEJop?=
 =?us-ascii?Q?+O1OvkIbxMOQMW0JlJWtNHdVKpS7uwgh5CGQp2+7vsZbHqJzlg4XL8X4i8m+?=
 =?us-ascii?Q?K/skUVgMF+zMkIk2teQ/qBcBC2h4HMfr4Jeh1cve9oGSE9nRF8lhAgUVrvmZ?=
 =?us-ascii?Q?qvzKsQQ5Q3o4mWBO14jR6UmyQ9mdk/f21Qgv2Khmz37c9i7AHbf0swz4jxOi?=
 =?us-ascii?Q?nU90Kb3kbraDQjO8uxSgWCqBZydfvhN5qunrFZjTvV8OOyI6ZlFMKHhDZqNR?=
 =?us-ascii?Q?sRahGOX5ixWeMUo+me/y4do5bMrt89bkmSIWsa3CVAaNJRMxZwHSwsXGiAHA?=
 =?us-ascii?Q?aSvGp49UNWyY8PTOQbcpRSN07GV09Pds95HxZj4sdfzu5PWi0dAsD4LNZ3bH?=
 =?us-ascii?Q?1WNHPUZODOq2KTaXCq5wBtQ0kHStd9lB4ZoScoxx99uM22mrsj7MHvcb6grW?=
 =?us-ascii?Q?+iAi/joGxSGQTi/S8qIO3BOLwsN3VzkBn2J4USbzMg54rOUhAnNlBoI2hOwm?=
 =?us-ascii?Q?doN6ZDoM1fRpJ2mN4BVHGyDofSqlxvwoL0IJuoRnin4GI1VuAlYVKiyiODhS?=
 =?us-ascii?Q?oKBZKSnjW23DmFU8W9Qi1GOSJ+xWeCGaWhmrHOHvVmGxWYqzYmCimTgeCTsB?=
 =?us-ascii?Q?OrBOAFgA0b32jHzfZxwD0jtIsM5edP34ZfnMlnEnIuoNYjIHefVt5WQK2RXu?=
 =?us-ascii?Q?a1r0zwnqCPp/Ege54VzRoWcRWON88EVwTC/Uespw8tpMAvX7fstY3QaZ+LqN?=
 =?us-ascii?Q?00dH8ZDDL8F9qUeBY6ZMT2Xtwh7vehW4EXWgGS8iRZH9DdA9//T+QIRPJRob?=
 =?us-ascii?Q?A3NdC72kG5g5xwYcX6LkLzDoKsrt7DAJvreTyuUwCw516H82nSLoN48m2Oa5?=
 =?us-ascii?Q?53c4V8hcJg768TIK0kSrgvfrUaZkl1JWTngZwFAv6FKyz/wT+xyYlwzo6Ja5?=
 =?us-ascii?Q?43KgsSTbv/95K/frS5t1OXdgP0OtOuUncH1AZBEdjdel9kaRdxTBza5dT4XY?=
 =?us-ascii?Q?G5K7uZ6upKrLf0a/nRef+MDPMwoFuDu36/dFOb5sRj+jcNVBaEWXWd5ZCC+j?=
 =?us-ascii?Q?pl/glk0NT+l/e6s0qofMjoEEX9/IH/NDL1FDLJsILdUwhfHe5iQ1KUBt7cES?=
 =?us-ascii?Q?yzy/VMMH1gc69ELVgoFs2WoRmR+1nAtGaAfTm+Bs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca315e2c-a446-4d5d-c191-08de355ad181
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 06:35:31.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94svsvJrxF9oBNhannzjPvK0nrRkP5Pa+zPaxtNlwqpOkaPdgIT76PfCwNh/UQchacHwm9S9tga7Z6cae5YNBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

On Wed, Nov 19, 2025 at 05:19:06PM -0500, Peter Colberg wrote:
> Add a method to check if a PCI device is a Physical Function (PF).
> 
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> ---
>  rust/kernel/pci.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index c20b8daeb7aadbef9f6ecfc48c972436efac9a08..814990d386708fe2ac652ccaa674c10a6cf390cb 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -409,6 +409,12 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
>          Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
>      }
>  
> +    /// Returns `true` if this device is a Physical Function (VF).

nit:  s/VF/PF/

also, add #[inline].

With that,

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel



> +    pub fn is_physfn(&self) -> bool {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> +        unsafe { (*self.as_raw()).is_physfn() != 0 }
> +    }
> +
>      /// Returns `true` if this device is a Virtual Function (VF).
>      pub fn is_virtfn(&self) -> bool {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> 
> -- 
> 2.51.1
> 

