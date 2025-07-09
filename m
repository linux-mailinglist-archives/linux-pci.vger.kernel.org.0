Return-Path: <linux-pci+bounces-31739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A71AFDD16
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885B27ABFC2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF550149C41;
	Wed,  9 Jul 2025 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qr/zrigb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AF2BD04;
	Wed,  9 Jul 2025 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025860; cv=fail; b=fATnK4bDHnBGavXMtGNdyZuW0J08wfQOHqPbbBbSqiMUAFxAUXSaSldiT7Ja2YAxqRyq+YQ9rtatgYHeTWmAidQChfM1GE19gRpqTlXulgRJ86X+dRfNIN9RYf9I20cqlVp8XECAUQVjyda6BXYYOg9DXuLHjBBp4SaWra/Ry3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025860; c=relaxed/simple;
	bh=U95kemtAtoK/AJcYUS3Z9MTVMn0vhubNrQvd1v1nE0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g7KJiYsonT7T+CYfsD8xwYk/uYasX6vbBzc+GV8qkXfDVhKY1jk2lx/cF/m5wUjnJJz7E56j616sFKXy236v3vPjSDq6aIh74yKVA6BA5G5Yg9GWf6UqrKvzVXcojoFugNgjCkpMYujut5xjnYyibThkkOoyR5UW9p0NZi7BIvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qr/zrigb; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbQewTylc1xOy8pRODU53EgTKFBK/Iyy01lBv56qdeEpizWcc7nquzGoX/I7ubqyf74t5Lv1n9NZwgB6ViYSXTgMwnC4/a0YdxsKM3h4WuzxS/OCDks63q6IiMndylEihbkVMVWGBmncbMwLRrbIvtatKAttpqV/o2EM/EK43xrnlwHAbtRp7smPzIjyeU1bD0Gh81grX/sTV5pksUAXh7Om7Kn2whf5hgHUKyaMozVoiufiT/fF5NeNVVv0qCL3s9k3sj57UjnBKZyml2bFu3ykYjRKq9MIon0IWS9Fq8ZQisFM62AFf0nLtXpNMu8MxdOYNGu9qwdq31Io0rzSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeXzx81XGUtESiIgYJsKXM42h/NhWc2EEeyQ5nAfZn8=;
 b=iOzknKLpv9euj1/K9Df537C9yndIqGOM0btCe3rzy6HJgq9wCdw2+Dndk59qJkTA04JvyE1tBdxXwbqELplD98pFCSJfSRL2RAM3ik2Mmu9wfqk5hcjqftWIg9ILoJBwI78Y6lhM0pEapKxCBXeP160mDsPFVQQW/G1X90B3Pe6kQu0ZRG3b9ggZbn5RprGaQr5PyZNsKl4Wv94QEDLCcXzDVNcvPjl0jPs6UwDGw9liyTZQ0Y7XEQAgWCuETU1TooEWCrHQn1tfuNKpUXKkr/YevWbLnLpvPbxXkKFtjbl6zVx46sYN2Bdb3WBdaseWxWRKgM1TIIREAqxOjMbf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeXzx81XGUtESiIgYJsKXM42h/NhWc2EEeyQ5nAfZn8=;
 b=qr/zrigb04/Pd3F8zxeYWSHddZYqWtyxB8lyW/n3nm6XUYBhDOVdtbMBI8qaja0bmMoxKUaNzR9xK7SwPng8x0wWtcSr/7bJPRsE7LlWLOG4moJcfto+IE2fPxIiyF66OjOtmT1pbdb44qxxBdwga2mRftKkOzsZLXX49zhJWiapCUVQZlD0mMdr6qIo9XUKC/DyGGAzoQD9GER+k7OUCTvdTtTOs3z6LroW1wUSCU5g6ctI5hMiHESSXG/e/+Mb2pEwM0LCDjZV85qyC7jFWVe0xaiM99BdvMwLnT18DdttLykGZbr/vURMBmxXfIrEgHlPLhJMMCgJCH/XPp9gFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 01:50:56 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 01:50:55 +0000
Date: Wed, 9 Jul 2025 11:50:51 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: Add several miscellaneous PCI helpers
Message-ID: <ejd6k4r4h6d34ua5m3cugn5mprgabcps5g7srkotgahuthe6e3@qqnvd2jkbwxu>
References: <20250708060451.398323-1-apopple@nvidia.com>
 <20250708060451.398323-2-apopple@nvidia.com>
 <2025070856-ferris-enjoyable-f2de@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070856-ferris-enjoyable-f2de@gregkh>
X-ClientProxiedBy: SY6PR01CA0141.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 782e5e0f-8d84-460a-4777-08ddbe8b0b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Votpq7TpmannT1/sWGxGk/GPa0q6Q4xj+rPvo4qxoDp/tu+6aINc9ceUcT11?=
 =?us-ascii?Q?PBIVdgAoMaL0mYU0qlDFYrD9xoLJaIf9+Sze9s/N/vQsJOyBlRT3RmCtWRlm?=
 =?us-ascii?Q?1A59BJR4Q17/wqBeo0R1rATzdP01qwNZ8GItjSO655ykIbCOxg8Vs4OJeYmP?=
 =?us-ascii?Q?Y6ivqQnuSvr2WhNAuPBaCAYCNwY0qk5OF2928mZO8ymONQiNl8qW3Ze3XAXa?=
 =?us-ascii?Q?0eP/7Xj5FY6nkawW0AgkGad4HFo8N38l/rbHdL4sccFFhF8YTn89Zx8lW4Fm?=
 =?us-ascii?Q?xkocSf8Dd6gf/LeZUSAdN8KkaKmwftWnCOaMqR9KIvsayelQhYevOIpcikZr?=
 =?us-ascii?Q?p3mtdIDWMUj8zwPRkSi6G8aPF/7C5UrcE6ST4R4gvQtNBc+4/Bk62Dbr+tTC?=
 =?us-ascii?Q?+SoaHacT6O0A5RS6cqZHlKYrCXFBXlyk5Pb01AKhuXZ6uC3IDEpNXBY0lGW1?=
 =?us-ascii?Q?kpC24XoXBcKD1ZJA2pJC0aZjE6DtRsVoom/Q015h77xFp7As33naYc/gGwPA?=
 =?us-ascii?Q?ckBiqGSdbgkqhzsT/j+o9+0HgOY9YoqiXDLikMI+DRY5Jd57xQszPSdPEF4O?=
 =?us-ascii?Q?qBdOHez2Wy8Ahpfg3HXYCa0gYtoZRKsiGdQQI9Ub1etJKCFCdbygW3Thtla6?=
 =?us-ascii?Q?SuAnBLoNloRGffxaZEir6GrY/F9ZxPXvJT3mOxDyXa91dPMhCVjZ3GK/W1i4?=
 =?us-ascii?Q?ij7jDWIRvnG/W0R7MmqlCBHO8eYIlmYzky0O3n8MHl6y6ZjJbDb+Y3SONW6C?=
 =?us-ascii?Q?2nOxKx7PnLoBXTLHSS19LzS9aqep30Oz22k/IiCbeugChDcQuVTVO6P34jkB?=
 =?us-ascii?Q?oxZtClNArQwiGwe4SllvThboAXa4tDJW0/kHV31ul72queblkDg+jy8v3NMh?=
 =?us-ascii?Q?2pTyVqhHgmZHYrwKWl/97PzW5DaTKzUnyohoClGvdPpNGJJw2IjwKIETV+9o?=
 =?us-ascii?Q?uLz2paFocpUW12owSwf8W52X6u6/p+hzxytXNEZg1q+kbNO4iFva+sSfBY81?=
 =?us-ascii?Q?TVoLMJiMM4qlhXeDeQhiL0c4AMpD2+cHNKtiygU0intdaiVD/c5ZS1UInep8?=
 =?us-ascii?Q?/cLfxy092XtmwafprBf6DQGHSzZEisfrudjeFxWbf1Gq0si2BnGnHTrNmPUr?=
 =?us-ascii?Q?Rb59WcrO41+4l4wpg85QvPEuaUpyIwGzWmdrEnCeG9lUMmBskUOd98OqFNCt?=
 =?us-ascii?Q?/CJyPrtCU09JO1ZI8aRA4gXQkUjn0eNQC05j319u35CnrmWDAUBd4A6OJuf0?=
 =?us-ascii?Q?Z24KOb65/GoDAnfLN74SkRBpjIlUojRcDQz1mrkOJ+CtU/K750YW//fgWeF6?=
 =?us-ascii?Q?SKM0jO59biHtDP5OUt0xJs0ZpKLzI4hhi5Czc6bdR2hnG9dE5HQQ9ovsJFdp?=
 =?us-ascii?Q?BrcvcvmKkFChPej9Bj/PxrTah6LeFkiqTWlw8pwnGZ+A6ybOoCBEluhD5dBw?=
 =?us-ascii?Q?dqM8ef41UIs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDpCTZqA2CTruscuSC/4KqSfZYbYHggESuddzuDSsQ4cX3pYIwCgZP8vzqRT?=
 =?us-ascii?Q?zEcVy3M9+NiWVq5nUBXAcXW+SDKYrkjPWTojxhUVrXzE2hAp3XihRk4cfEzc?=
 =?us-ascii?Q?ms71ZJOI1yLUwrqHooC/cUw0u6lmNDTGiODcv62otQorndKfJKgHEbFJQIL6?=
 =?us-ascii?Q?Vc6h1SA+oEcKWmYwAtW5rXNi5HEhj0al/YEnRQWXfHPTVxoWgWVq4Zagv5rl?=
 =?us-ascii?Q?w0LhxJ4t79Hwh9TqyqjRqoPjjMpkuRVyzT/Ftm8rLeHllxSW0+PKRVUjIS8/?=
 =?us-ascii?Q?nUdoTomrU8GZM/o1Qznb0shHt00m7+FOnbebv4G9DqDTZFwqnIQ9kG2QuhvF?=
 =?us-ascii?Q?9gU7mKQcEs5f1g9gPAMqJW35jQGukZNsaOyVH/hMQO6DbJjMAHEQaREnogsy?=
 =?us-ascii?Q?kxlh8ci9ykHYUd/10DguaIcm/sreKvIzShiK4Wu+qwgDS0MorUxkraA1nnrP?=
 =?us-ascii?Q?z6hRWU9CeI0HIVApBRrVfjZhFR7ecpgn4IDbvv/djWCvVbsRLOEM91sz+tEK?=
 =?us-ascii?Q?8ClHEIq49JSXdxOGNPJ9rIr/aRNe1AKTsRdjoJ2Xf/CW6MaiX2gQuarRyWdZ?=
 =?us-ascii?Q?7gak98Da4KBzmGR5QAztI4qfYoLgHDDcY8LqkDVpcdD5b/AeQewcbFMRjqUd?=
 =?us-ascii?Q?ofvInp4SdeOoSZQ4cedkGclESMl/Pl7FDSvPET8jnhQpuyj7+QDl/b5py4g+?=
 =?us-ascii?Q?yzRxVLu4f46d6/pGaLkCAeRl13eU9JRH8mzycn66aerCQ34XLptgfRjbb38b?=
 =?us-ascii?Q?0wIXJ/SQko+TA+yJRqi9XT3KdQIKPUaSdKkt5cyJvKy0BnLwnt9J2TUeunl8?=
 =?us-ascii?Q?x6gmPr+9XGhQcqvqnPCsCry2ZqlPWZLUY5+q8cKlvc96ta21AvX/sHz7/pb1?=
 =?us-ascii?Q?rY+fLeQUsdgAGL1svSgmpEg0W0uy828FOCkK35pI8EJL46jrUWNwn+PIlM0v?=
 =?us-ascii?Q?lcBo33gxHWWXwDQH/5D1ZusnWMSEC3tF4w8ucvlfGqK827wLKs0d5mG8Y0M8?=
 =?us-ascii?Q?F1ayHQOFJi5jgWcf3x9Rs1dHg66NSKMtk8azOUmiIwC7crE6G5LGqn2xm/Bk?=
 =?us-ascii?Q?sC7PbjbUxkormtbOEjxOckImUFT2W5+9IK3lqUBOwVQXfufhYnlOJmOuI5wT?=
 =?us-ascii?Q?MpB0JkcS3D1DmrkYom14hcHQKG5+vjTbtZRE7EPxsrIuDEbbA7/NONn+0w1X?=
 =?us-ascii?Q?mU5SjoWkO74abrXtZf5aGT658uYFiuZTe6rYrQwuvFSXOM3GFU7JI2EN3oTN?=
 =?us-ascii?Q?1U4cyj45zqSwiNl9qFxoviOqVo/R0ImBqWCdQu/FOwR0Bcn0qGKlw7cjFg/B?=
 =?us-ascii?Q?IcnUmIMOy8UiR0OkvWeVXY7TcmaPlBc8epp+VEgd0MX+WPt9MX84BYMLRX44?=
 =?us-ascii?Q?5efYXr4uFCQWrSKqob0sNGUMe7QIJ/p2/aAZIHb5ofzGTYzJZLx5BDUkgOc7?=
 =?us-ascii?Q?kyKtkeWuYjLpqGg9meR+De9zbFIDKy04/LuevQakNcnyYlqwKHax8lzzbg8y?=
 =?us-ascii?Q?MBFgqvzBLIHGuu6BdhRQdlPE6p96zTdpSbid8cUHh8MBvJhbh2IyUFUln4pc?=
 =?us-ascii?Q?0ZYgojcoR7uCPo6+n2L88CxDQfGRHayhtFDIy55p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782e5e0f-8d84-460a-4777-08ddbe8b0b63
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:50:55.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T6yU98IaJBMFtIGnsM4aunRkAuwcEKDeZZrIAxTXAUe8yxPYSi07vuwwHdI4FXUffRCs/XBC6CZlcEud8LyVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

On Tue, Jul 08, 2025 at 10:07:11AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 08, 2025 at 04:04:51PM +1000, Alistair Popple wrote:
> > Add bindings to obtain a PCI device's resource start address, bus/
> > device function, revision ID and subsystem device and vendor IDs.
> 
> 
> Do we have a user for these new helpers already?

We need them for nova-core. I'm still cleaning up the patch series that uses
these but figured these particular bindings should be pretty uncontroversial so
could be sent ahead of that.

Danilo has requested some changes so I will note that when I send v2.

Thanks.

> thanks,
> 
> greg k-h

