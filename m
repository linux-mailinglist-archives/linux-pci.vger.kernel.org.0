Return-Path: <linux-pci+bounces-37351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0E8BB0CDA
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 479EC4E1675
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A8F268C40;
	Wed,  1 Oct 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EG7uD/Jj"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F25748F;
	Wed,  1 Oct 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330102; cv=fail; b=TP2MRwsif7OVX+8vuFbifdD4LwrWNXRCHDKRwqAf+JYrkqVlpWnH9rZHoz9c4pio3vsYAwOXxf2OSxsI/5G6raGWvhk2ZmJxk4juzXQwyj+rUZ/ZiZvOZsVBBIQfFPzWAUxPD+ugMB7vOThA8Jwf0+uiVE/WSzb5Esw5A20dMf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330102; c=relaxed/simple;
	bh=rLVefKaZLmLIoJy+uK9b5gGHkdoS8//nsYinamY4k2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqSyzjtYEUQLh6mKG1k1fsVZ42KKYyTefXQi1VROsmJEf6vtRXbD0szlgyEjVf8QcNhCfH9Ot54nWv6eKFVagEhPbf+R4/KUWBOr53Z5GM35FTKCoWG3JY+G+/ugc0SErM4qmtSfW2VXLYJQh+lCcHgykuzDjWMVpMhGHRvrc1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EG7uD/Jj; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6QFmatbePzj81uIPfavsemztWfmweJdrlUvH2edF/4TTCSXbh2NeTmFv+JLJOg8AkI9TzJ8dW1YaNvR9BSjqfBIpzD4495u9f8AoN3iclal/2OOIqjRHrAGQa23SaKVlsF+oh/ebPiODsybX3htKRQnOWaa9GRE7nu6jSkDKmWSCziiHEq4ZfXGJn3kgCOyC7vqfrbyQghTyU1fbdSa/00O19BlXtzTVX6C9lmYlXbhEoyZhzY23iI8IBSORjNF1UseQxxCMvKi8zph6tgBIGQM22HGIhI8z/8C0ZyBh42X4mIDrEexzr8w9ka7QPnbNoPOHyhB04Tr7cvHKQpRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4aSx2dKce7p4VQH1vt85ladi8zS6+pg4VdyU67/Dzo=;
 b=k07YG3KcH3o++oYaZ7sMVVKSRsyLjnMgJ+T8jAtivTeMNH9GnXPsz9L2Z2XnIkM7pQjmkfXsapdJRxZK1yKMRRefNzhp0pI/f7t4EarvLRYl4X8FjuyZJYUl+KM0x4vw8jwJOg6IEuThS16Qh56SCtccKgrpxuiAdVsPItyzjI2VWlaD4uNvaun+zvTIBEyQ3M0lw7DE9bVjxRVgedUhLgKxXcdqDQLR95J2Z45jyw2bP70LBlCYYoKYNSm+9B3GWASmcLH/22Xyl4v6x5UC+tAKs4Uofuo1mxzVRnkaSOQjayJ4VHOgyEzcnyTOSjuWLhziij9l6ZIF5mCAXG/wcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4aSx2dKce7p4VQH1vt85ladi8zS6+pg4VdyU67/Dzo=;
 b=EG7uD/JjmYdujRf1vnz+3mOOth6AqjT2d1/KWzDeObg0bjsDtKkntwtHD5iH877fZ3fCzEqIWQ1i0LwlkiQF4kKhVdg7OQVPZAiofb0lpc+KD3k4NDg15bpGPXGnxLBiLx0f5wRa8nYHSj4aIWBjZtf8KaYW9WrGZyPt8rtFAFzFHt6TckFTVo32Fdm7lRnriTblzPpt9InFLrjWUPb49qZ30BT8GWQ6g5tQ61cAgAGApoEBi9+sOyxXF4Q/Flns/3ZRj77EcYtvTID6CaV1upCf8K3MfZKrwn36oLS2/mAhLBhs31f0wjjiSJZqtep0vevPHKYBcyPc2M30l+8WbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 14:48:16 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 14:48:16 +0000
Date: Wed, 1 Oct 2025 11:48:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251001144814.GB3024065@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b1d229-96a1-49e6-4719-08de00f98da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PCazTHd7MffI6PbMsdzZchbb0RecIrQwuP+zkZiepN/tELr+Iebm4JJWKX5w?=
 =?us-ascii?Q?Dc6FGWg9LfCWehaHI7WJsT//jWsdwB7b0ZP+r+JyDHYiXKnA/D+hgCFGGKOE?=
 =?us-ascii?Q?4KgqefpqWA2PzdSyCGKgJJ8XQaZVfVVpDG8z2dvk1TVuNGVk0gHIq1BtN8XN?=
 =?us-ascii?Q?Zgy9H8QaUFDYhBUnYRWjnQAcqRe/N41SRhKZurwOlMBgh5iiwjiWMKKBW6OX?=
 =?us-ascii?Q?Zgi63EQ4D+Iaj+YJzQFP2I1im3umVYoQOf+vDAQj+FPp8ZU3DtRnUh/01cdg?=
 =?us-ascii?Q?Tk5g/TQbYDXb8EToc35K2DkNKLs1rfBYvn/uhafAhwmFSYpmFoYLziNoIdgo?=
 =?us-ascii?Q?cvD/LHfkVPavsEWYZqYqZjPChS9E/f4SaDWZ5BtkYNCU2gSkltCI7pZJqDZY?=
 =?us-ascii?Q?2lRqE3VIf2yD6GVkSrWqO1TK4Zipn1JcS/6iHfLKOsh0nidCjoBkCaE3U3Ac?=
 =?us-ascii?Q?6luD5KCF02leAyTZ0JPYdKsuZSW73EAOquMjcaXzhNL7KSXBnGjUdRtsJHI/?=
 =?us-ascii?Q?pElhujVPJ+HcopJJ4/Hv9wl9EaffnYDNDovy7bdbsqyD4dM0hygQKctzpEip?=
 =?us-ascii?Q?LVWZM9zEiRyJcYZ536vO2JcFrDE8MAqRruoqybClUv/njQvDaopT5xm2nhYz?=
 =?us-ascii?Q?1d3M8wv/L2QFoER30D4APU4VHdxk4zQriFT+RynBhL4YUr+M5ZQADGQdq6/D?=
 =?us-ascii?Q?uKZDYnJvL29T+tpdkD+jq+VAjwwdU60+rPKS6P2PtI3GZqI1QvSdY+8K8Yfy?=
 =?us-ascii?Q?mLqo5qJ6PvBFEznb9/19AbkmeQ2LYR/pGH5dm7YSy4WlYsQ0CmwATXdfD/Iz?=
 =?us-ascii?Q?VeXvL4rzqRufwwlHT4m79JFhP9McGyjalDi1AXOUPHrmkziXy39LcwCTg/qJ?=
 =?us-ascii?Q?HxyxupH5z79e5b89QNEkD2yNKYcNDtejiI9ipA5bH1wa0+0KY055r5kzTs2K?=
 =?us-ascii?Q?xHLjNI2uIA6tWQDhH6Y1+InK4k5RWaiHU38cNKFAuyMj3VfJWoYeAxReTnyU?=
 =?us-ascii?Q?uollGwlnY6cV2hYTvnjovWBcxgOX9EfguyhtXFnE3jAA2nJk273D4pLYxLPV?=
 =?us-ascii?Q?NkshSP01GyfDhtO3hpd9TUCY/fBFUeZzh9vo+WtP8S3jeklGMyF3H0H+fsWy?=
 =?us-ascii?Q?lQ88qBx8yvvlqhNW3nNMnvGOavpWbrVJ3pSTgKqyOVyQd3QnuyKphhbte5c+?=
 =?us-ascii?Q?lnQHCjPtmcwdPnGJnPEa3KzPc24K8HfIS9qgp3QRYV4Ymy/Zp9U+CM3b91Db?=
 =?us-ascii?Q?IRWIs8p7IxppVBhFgM1l1ti39eaGpeME+uO/d2bDMd+H7FtvwdlcVDUY7LuR?=
 =?us-ascii?Q?7YvQHA0xnvGFz3EDCzNlrTV/myQJAZH9WbccWICAU76/jCnJPFtTP8H5P8z0?=
 =?us-ascii?Q?dUVOvEiUnAkoqitb7iBKfUit+X1H2mgQHzRZF8cDIc4+xUhlS/I/hhj5VGPo?=
 =?us-ascii?Q?N61WeVTbK6d5DTCwoN7PJUrEpJsdrJg/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+QspEI3bJbZHjglVHeXUObAmG0fyBHUoqGGttKrFt7InLUzDbi0X7UT/NLLT?=
 =?us-ascii?Q?x6GhuaKKandraV9j7xZz1KVGxyu6gEAsQs2z4wUumJQdpwwnse2Dv8v8Fqow?=
 =?us-ascii?Q?ZfO6rwstis2DqAPIiSw4f7D+YayXsPdAHrBxWgR2fFYwekvew2q22BZJKWN3?=
 =?us-ascii?Q?gGHy3jG21QRiqmYfu44fmzgvno/P01o+zcb6LcXzjVtSZs7BrjBRLitZieVR?=
 =?us-ascii?Q?w3CtIpQbgIyWo1bYcmrRiYMNuS4q/KneS1AvB9Dakh0pMLvHDv6Hh8HbqUIe?=
 =?us-ascii?Q?uY9lqf7HOMBkvYAAh/NFjKMErmmfH7Gp5x+tk1lnoeWRhdf3fgm5UsAWp49D?=
 =?us-ascii?Q?M/326BoVdbo0RqX2SFKO/GNs5N5kjZD1Y9+pGJYdprZkZ/ufAX6S2x0ZrXWw?=
 =?us-ascii?Q?CbLqHiKAlFefjEjKYqf1g0Uqo6UrYYSgUl4CygyAj7XKtxsk8qmk9TvDqWLq?=
 =?us-ascii?Q?dqjH90vdm7XSb7uG5wAUS2JBSdAXhvLJOCahnOb33U2lSr+RW4hA/fJFV766?=
 =?us-ascii?Q?g4KHGTLsAg0TwLkE6QHcKMC/r7F3NkH7JnyArpZoC0xA526MoChEXpwfJ1Uh?=
 =?us-ascii?Q?PP55IFthZSaRVCdqKxkeYeIGpLoYtbic/5YiXRaLLn/NTbMYcjO/8R72wPGW?=
 =?us-ascii?Q?Tz6UthEXh1h3S7XC/AxCKglkE24A0zPLLrTm6h/Gydr3x0BZuss8ftVkn6fh?=
 =?us-ascii?Q?Q2MmWecq88vDJo+v+K9MmaXuVHS3B8QLGKps0QtGkIs5FuAlgWpwEl1e+ArU?=
 =?us-ascii?Q?wXC1DCihwUStMh3mj5rQ6gD+QQyHrNA5uydfCe/BSvHCz173eKkONiedGEZ6?=
 =?us-ascii?Q?10TZBq9YSj48/NevBHn62HbrKyShXwAYQSNCxJyF7k+ayl0pv8HHUcyUcFr/?=
 =?us-ascii?Q?24/ov8cAcW7Tjrzi/YpZ5BDhP3cLn4V3I+I2lLNQ0u77lSDILjIcv4m9mQvD?=
 =?us-ascii?Q?fSdG9VK+c57PcTzlK6xMxDGaWMUuAZ9MJ2pkjzc7cMyBghsOtNQFbcD9IDf0?=
 =?us-ascii?Q?D9LBHQmNnwub/6PvfvIpjBGPzap7v/x6DJ3z8YQgKXFDAauF/lUYimmTz5oE?=
 =?us-ascii?Q?wJZi3LK7ZKWhjwvQNwStn/oQsx49uQv5j2911xMpENkdqcKyl1xOwZMWKWM0?=
 =?us-ascii?Q?Pdf7ryWf/UMFZVcKXJk0HJjhtF/laAnkAdtJzjmPxYh77KQ82etWJ4n7STdz?=
 =?us-ascii?Q?auHkgSeDF4R0lPuU59yjL02RFgQDq5eozYZ5f1XnJYoYLrX3Ob0xvtx6gw7D?=
 =?us-ascii?Q?xQwt5Ga7SO7dKGr9fAgkanQosFVJ8DlTsLjVDR04h64naOYIGDg8CoLjDZLG?=
 =?us-ascii?Q?vgCHjjlgAb1aR4phC2/AxAE5PXQGbctaDS7iktFm+swLFqtU+Z71fJK6aM/a?=
 =?us-ascii?Q?J9FmO8azM8ahokGVmhevTfXKAhc0ovs6iq1ls5VRCPpaN0NdK7Ei0fFkqXiX?=
 =?us-ascii?Q?oEgRF7OxjqIWBU0s1SHQNrphjVTF97rFE/TQ/oxgWr9SE33W2xfVP1abXCNs?=
 =?us-ascii?Q?rhiLAswlk7EMiNHxV/Cv5JX6RGtt5mSynvbCilZuRbEAdzmNbV3gJkqv93zr?=
 =?us-ascii?Q?lY3vAwzt25G6z1uSMsMDTCSK3n9ArU0VxbKFdD5m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b1d229-96a1-49e6-4719-08de00f98da9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 14:48:15.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qxaEAmCkmIw0o+YBMsPysdiB1oagdh4JhXdbBEEkTHOn1D79faTw9Ic/egQQfbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842

On Wed, Oct 01, 2025 at 08:09:37AM +0000, Zhi Wang wrote:
> >> But if the guest sees the passed-through VF as a PF, won't it try to
> >> do things it is not supposed to do like loading the GSP firmware (which
> >> is managed by the host)?
> >
> 
> The guest driver will read PMC_BOOT_1 and check PMC_BOOT_1_VGPU_VF flag 
> to tell if it is running on a VF or a PF.

Yes exactly, and then novacore should modify its behavior and operate
the device in the different mode.

It doesn't matter if a VM is involved or not, a VF driver running side
by side wit the PF driver should still work.

There are use cases where people do this, eg they can stick the VF
into a linux container and use the SRIOV mechanism as a QOS control.
'This container only gets 1/4 of a GPU'

Jason

