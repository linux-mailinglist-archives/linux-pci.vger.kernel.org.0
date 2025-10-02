Return-Path: <linux-pci+bounces-37424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB574BB3E8D
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF8719C7E6D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2E301007;
	Thu,  2 Oct 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KhUNjStY"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4922EE5;
	Thu,  2 Oct 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408767; cv=fail; b=LrMlwR4sl5o/HZnkbZBECnQ5TR1EJ6iqYtbt0WEYk//XWuAvdMc7zHPZwc0zsPWXDCbckREA39viJmC7uSZ1wjiBD13I6p5tKeGl9XRVV4NHxRCvoMSj/b479fRr7Hftz2KYhGb9fGegnKXJa28cxHK3RY8SikYQl6rUfv5j34k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408767; c=relaxed/simple;
	bh=/8PgicbM19+A3w8tftQJwRRmY4xXqHUdlrqvXCRVd+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QdFIoxovDniOvGKEO7o2s8+Wms01UVnUa3UBgmpo3jwUq6goG21W82OuYdqYLeNlx5JTVJ3tJZZ81yTzrB8eHe/L/T13otkHiYCTzD5/lXWl838eLHg13QwLsh9VNT1jH+ktUOhhsAXGlDxAoCvKmiiDrIE/76g/Lxm3WbBiKtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KhUNjStY; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GItE1XbIetdSxp+q7tZH6IsxT8JRwulN38CqilNXf2nDgt7+Uj23Zh79zzrlm/bEcYdlpkjUNeCwFz8h+9iWiPdtcZ7QcEayRlMpyUUBli2Pw17wQKD/C/VA4ihQDBY8ux5tOr1cJ9d2KEHGJr5tnGFoGdSnabj+CNjHCF5UiERNN/N14pB7kr5dll/wg37LkaflnCAwJf7rSWGG5yJfUMVXMagy+AeX7qHzhyZOVCYIahlehoG9XTNU1QxRXyEhbU07jnmLsvn2WjvBJ4O+rn7ztkUWuH43SwOYqyXon18Rp2ZgEqI/fP4oSO/O8eOTyO9TlsIOF4XzRc54wajzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmhAiPykpOC1iB3OA5Tt76h5byoVdFgIJ0eWGSl0xeg=;
 b=E5sUEKtaeIiqyuDa/4QxTaPfgd65Vq7ExGe2Eucgdf6TWJ67+yGQvGv4AJ0ZC0a5qEDu/GmRb/5AihYTWHdJMn0EG2/47mAY/VefRjFn9E69c/VNMIk0QdBt41KQNkhdlYDggi/NFxbxcu1skWzOFv7m8FKoHWUXYDM07G2TEDkQ5SP37Xr6PbKnUe1xs5Ex73OcCmJuiwyjXahIP5eMngYARYe/x2+Szm+n0S85u4VF0i3/OkqywhsoOHgGPJz/r2oIb0JXDrVXblwhKCv0eeyvTyEkn39CSECAzWDF6rcv5xj2Lg+EokwbOnWDD7O4hOC12oCB9BigQeFu2HgUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmhAiPykpOC1iB3OA5Tt76h5byoVdFgIJ0eWGSl0xeg=;
 b=KhUNjStYAnr/A62oMk85XStQG/KEkaL4R7DTK5IMEQIlGK8ZQQAKiP8yA+0zxiCRtBNizzVgZmHBpRyRhIOYDeYTH3hha/QT5QfBRB4+RmKpl5BAAYN35W2tJmvxOrptJEOYVLyp/U8VDO+D+JFkQryyUPdq+wOBJUZ4SzDKnf4iAWPUczc3yPBvqHDKCAvssCZ8100AYUkNM0jIFNbfSGrfoy/T8QhhHhg/00aokYLjXtoxRhEjhIvjO1mJbOjp9aEUH0Vg+T0OTULgN9bhT5B85BFAtLKY3A/sGuRUq599pQXBno003/fV5p8u6U3EbWa/CfYwZHjM7TqbMXzwIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 2 Oct
 2025 12:39:23 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 12:39:23 +0000
Date: Thu, 2 Oct 2025 09:39:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Message-ID: <20251002123921.GG3195801@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
 <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
X-ClientProxiedBy: DS7PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::35) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS0PR12MB9726:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bbc03d-f427-41ab-6d6e-08de01b0b72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A4NhRPDH42/1ygq5P2kPNn1+5jmqfrTSE0azYnObt/J+EEDyAh7FFITAav5W?=
 =?us-ascii?Q?2zzhDNXVDJBC29RxuliMKsQHNVCbL/azKOU1HU9a1XSckkaQIfhIiBy3HBZY?=
 =?us-ascii?Q?t544qaJzXX1bwk1t6RLRZq7lW23qBOqs6/3HEMY2ZkQkYkVk3VDzYcAWSWz+?=
 =?us-ascii?Q?X/IEDEfWieyYLQKxY/HYvymQTnWtcB9TwalFflPOBu57rbMt2NFjw94rhR7G?=
 =?us-ascii?Q?niA+Muyac6R9wqgf+98Oyqj19owtOMIphGXyVrfj8NGtbIZ5Xvwbr0/Iv0dn?=
 =?us-ascii?Q?ZiLEXxn4/K82T+W/l81+2wzr1yLMz/VwaTImSEQqH5z6wZqsn0Ub3sK8nahR?=
 =?us-ascii?Q?rbDnVdFQx2YJw7GRkA3ZiGhsVrsv0qRKdB5IpcX24haySbvdWNfJ96LqsLhb?=
 =?us-ascii?Q?YMOjjq2WK1uBDDshn01vTJV+jFmqKDRaKZRVVx257kQRtO8Hvk4vDfqKKFyl?=
 =?us-ascii?Q?GwT9pPhucQG+f3tDpJl1bjFuTwT0jnf12vw3p1D/D3tfFm7JJvf9N/yiw7bt?=
 =?us-ascii?Q?PMW4eHQhs+LdK18VJsSfchjv2wD1JpoC23gqdCGXDkhhpm3fG79h4ixsrMBs?=
 =?us-ascii?Q?4/6kO96n2VsmouJQj4I6JIIE2RTHxdr6lix4E+Kbht06q1xfTqntPqM6MaDL?=
 =?us-ascii?Q?fhBQ72JGkvh9bfgp2KR/OhBCj1yRmpMIQtGVB4LIGvKckpPV+V6H7uN0qP3f?=
 =?us-ascii?Q?cjuqlkRIH5LC79yd09854MiLB+/lwLxfHi/IvcO2qXhYAmFASBD1tMjAjV5F?=
 =?us-ascii?Q?nUupxfeWmG7nYNFlk3cU+OsCyHufrVH9xA9TviYiwWxIoziG2xVScnKVv560?=
 =?us-ascii?Q?hdOqnZbq3ohecCM3NVAMqlCZdgIaNcqZ46cv1xv7/9PdhZccC8C8v6cjRCrl?=
 =?us-ascii?Q?OnV+g12JtQfIIehgOxd3ab2kDZ8IHmsjZ48Mva+v3WtN/7SSWHWa5ygjee9O?=
 =?us-ascii?Q?XzoQTocqL5Q2bvqfMejQ7DGFDieMFtQpBSWcw7be4KFvdydwM+h95lQLJS1E?=
 =?us-ascii?Q?/cZKr5q7T6tG6AxaxFchbNAUbAsUfxcuvLDblBh3L7WZAY5NXO+wgBgZKIR1?=
 =?us-ascii?Q?IkXF/8v24NQZzCE/4eld/cDsTr+MI6XjrZSMMHd7pLopy85GwBhyk+LWVZbq?=
 =?us-ascii?Q?AdjVGUPjbtEeZdaMd5rB8W0xLUijtjxHT6iH6ULFkFWTKQSu/CA6hZbz1APa?=
 =?us-ascii?Q?scztF8ZT7NZxnbpS0Ifvsg8PqOe4wBQNYVB0Ul8W9Yc1N4pz4wt2j/ry5nKr?=
 =?us-ascii?Q?PH1+7hV00kFf4OwmAl/XgZ1lqjW9h0Pz+FFFSPf8LOtoUlhNC5ehnvsJkQBD?=
 =?us-ascii?Q?O6F8B3A+dgsURR9bVOqrVCuastANFsGd1oxSBO9K7o68CqGhzHFllj0qys6P?=
 =?us-ascii?Q?2g0CU+EYFU6WuXHr1izv2OzgN4mBuD/UxDeiNsRuJnPnhm0gfA9lQnJQsaOe?=
 =?us-ascii?Q?0lZt1+avUqtqh5pF7tiCyYZweeEX3two1SKUPovxbhDz5FTsmdKVGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O9FUKqSyPTwH7jPXSXLpYrR8MTNU2F5kvTZJukRy3LA3ShVCJTUQJgl821nX?=
 =?us-ascii?Q?7gWy3FA8nm8b3YhunCvxzN6Z3P3nyG0P53kAL0WphDLqPvnTA9AoClJUXoNC?=
 =?us-ascii?Q?5K5mICPS6BvRqF9rRpSgAllQ3Z6Qu1P5PaWiyoe+3C5cMLus3dOPthXEZQQN?=
 =?us-ascii?Q?STcDculZqM1q7kfB8zwgruT3tOOh7Bw0tts/x8UdisPIf/i+oYBN6CMSLpJd?=
 =?us-ascii?Q?YdvMmgxc1dL7VjCFIvSX0TTL46PFW8JP0GqIyci5J6GoUJ4UXXh8/BzIUFeb?=
 =?us-ascii?Q?8W89yrwut0O9AyYSk6zN1Md/uyToX8QfAEB9u5mUZayiybMm/eYf1juJ0Qxk?=
 =?us-ascii?Q?qHPHcyOGZjMDsHcaUyvpMHab971klwE1g/zNkFP6On1uC2cnwjNB7QzRpsJ7?=
 =?us-ascii?Q?A4jxH9AGGd48LDmJY02R1M4ct7/i737ndavENlG4PFObNXnYAe/2qYrQWc1K?=
 =?us-ascii?Q?ceL7AvezP7kmZYt7hlPbr67TMXNTY8FYJ2dpyMryDMz289rabrVS3c1N7hhC?=
 =?us-ascii?Q?rz2Vngd1SkE3eRre4ypSmpw2YUy6BWC8qWCf43UZwHAIvyNCyUYqEoZuoSgq?=
 =?us-ascii?Q?Grp2aZgizhgfWzlOQVDkK8Igephyh2X+3Cs/5A/ekCWkvw5mxvtkeDRYFK41?=
 =?us-ascii?Q?RbS41KZM+AT2u2O3AVYwBZfsASF7kBB3S8AbO6VoGhfQbwINnJl//QAqqECb?=
 =?us-ascii?Q?CZs2KBNnePxvWWumYaWVXCw+aYq545U6fbYjQpnUcd7yW1znu5u24k3svxTr?=
 =?us-ascii?Q?KKudnCyAmalcrzJhUYqNZikyztRLYbGhLzWSsLtEsbW4SG+GXrQ/SOLGno7D?=
 =?us-ascii?Q?jn2UgOZYloDlTyDn3qld8+yai7n/K5GJ7paxYlE+IlDJbjcbifvJz/HIJ4y1?=
 =?us-ascii?Q?0sMAYzLFzWi7K+GCtJb2o1rvgEVwdbVpDs6D/KncuPuPr+E9FjeVQoA1r2px?=
 =?us-ascii?Q?uEQdz2yIOXCsy6yn//Lg1+9LK36pH9yLnpqd83kVs/xr1SpzsHv67+s6cxL9?=
 =?us-ascii?Q?n0id73mDzxMYw0Whcv3V3KmfGVaTKdqndTSY92y+60idzTR4BrQZ8ygCf31E?=
 =?us-ascii?Q?61kvo7YB8puGgrTjT4Xrq9jFp02dWL4g3JEyDp4TIv8SPh0UiCTvo+e+D1S2?=
 =?us-ascii?Q?c7/2uYhrLaIP0GZ5xozAw0Gq9TcSX5oo7lhTp+SPvrxsSp8L27FNYXgxgJeR?=
 =?us-ascii?Q?XoTpsQ95AZ5QxAPy/mKL1/nuc8snm8pPsA7nU5EijDr3PIMECaVEIBHhkezB?=
 =?us-ascii?Q?sYZfSgowiUorKFytVzJ1LmUqi2R7zlKuP9yYgwm43sQ4wdGt5DMEtfzteEOS?=
 =?us-ascii?Q?q8PipKDCZu8n+V31xz99TQZ9/OFtbXLOWQzAFhaqvBf7jSTjXHAJkiygxPWk?=
 =?us-ascii?Q?6AxagXWw/PmcKqlKu6bW72MWZ7T9x4KUoO9Thmztg7NVijRbF/o2AuWAx/f/?=
 =?us-ascii?Q?LmJjw9ltOEki+d7nCJ0eHzMqBhIcwoKJeuHCkZeqggTpckNxUhdB1K/vStN3?=
 =?us-ascii?Q?Bs8WKEwxT8HRL0/Dvaa/kpg6sPbxTcZomTsDgtuquaN57KFei4UGeHPhkZhF?=
 =?us-ascii?Q?sCmyJQOGYFXif06URU+QqGkbt4MYtxvi5hmVTLq9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bbc03d-f427-41ab-6d6e-08de01b0b72b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:39:23.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFr0jFQI3qQmkT04ISZu/V3lokrd8wJjXVBr+11rnbLyQozPRp3FuQY8bzzdZUFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726

On Thu, Oct 02, 2025 at 02:18:36PM +0200, Danilo Krummrich wrote:
> On Thu Oct 2, 2025 at 2:11 PM CEST, Jason Gunthorpe wrote:
> > On Wed, Oct 01, 2025 at 07:00:09PM -0700, John Hubbard wrote:
> >> Add a "supports_vf" flag to struct pci_driver to let drivers declare
> >> Virtual Function (VF) support. If a driver does not support VFs, then
> >> the PCI driver core will not probe() any VFs for that driver's devices.
> >> 
> >> On the Rust side, add a const "SUPPORTS_VF" Driver trait, defaulting to
> >> false: drivers must explicitly opt into VF support.
> >
> > As I said in the other thread - please no.
> >
> > Linux drivers are expected to run on their VFs.
> 
> The consequence would be that drivers for HW that can export VFs would need to
> be rejected upstream if they only support the PF, but no VFs. IMHO, that's an
> unreasonable requirement.

Not rejected, they just need to open code a simple isvf check and fail
during probe if they really have a (hopefully temporary) problem.

This not really a realistic case. Linux running in the VM *should*
have drivers that operate the VF, and those existing drivers *should*
work in the PF context.

Drivers that work in VM but not in a host should not be encouraged!!

AFAICT this is even true for novacore, the driver should "work" but
the VF won't be provisioned today so it should fail startup in some
way. eg "no vram" or something like that.

> > This temporary
> > weirdness of novacore should not be elevated to a core behavior that
> > people will misuse.
> 
> It's not just nova-core, please see [1].
> 
> [1] https://lore.kernel.org/lkml/DD7TP31FEE92.2E0AKAHUOHVVF@kernel.org/

I responded there, I don't think the reasons those were added to ICE
and then cargo-culted are very good, not good enough to justify adding
it to the core code.

Jason

