Return-Path: <linux-pci+bounces-37438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF4BB44EC
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94BD188E776
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89311A01BF;
	Thu,  2 Oct 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QLVIj9/M"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB55194A44;
	Thu,  2 Oct 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418639; cv=fail; b=R0oqPH+Ez9dBNrM5Mj7ZvZB/QyPGYyQtHlpeEanMEbKVZnxaNp49KjckOfQnthyK4ac8ZJo8+Y2NTyo7GIg8sRVLuT2SxHpq8JGNA+UI2TTk4p723GLyl355UnGAdRvrNw0LtGgWqamoJvXn4JBb7cUEaYktl+QDJU8pz428bC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418639; c=relaxed/simple;
	bh=7wUK3kjc/aHNHOpEZ95LdKf56r1AbeVAp+jFGPBcn/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e/UmCGzWNHcECiwBPjauyrArUADBPW4jD815w8tHN0av6eHzmCfcX/ij2THs2LgVYu6j+4cWiwUCA9YtMH7g/eTJ/B4ymAsya1rcyd0OMjk/xRvWL87ube/PZbQTKZvdT1OMZYRd6JHkHXXo6msV5E9OuHSOgh8+1QwQwsmqYZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QLVIj9/M; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMsqRSXiRjvdolgkQMJi754xuxY7RnYVXQMCvFx+RvsQetWII8pLOrI20gCGOVAjt3aVjJRmojEkI3yiv5jVkR85NOhSxSyQx0wPFFglbcJRWlOBT34AXYWv+ItmfYS7vGgh/lCBR537mVQsYgS+qWdCf7fnT/HGe8ZMcG+wR7W57JVRilMc9RC8hUs9+LgA/u7Qb/dULFKWOeYz5hPc7CsHRp2PLztUNmJ5X7cb1VTCyUVkHz9JgQlgxAOkJD0Z/K1PdEFl9prUuJnQVQK8FvKiA2le8sSjb9WlFWob59fFPnvYcd42BZwbx+8ZknKfrk4KHdCguXS4VjwFzOpvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rtl/b92gFYWv17GjZGu3p/71HMbO47cpK6IU9WuEcuY=;
 b=S9EJh7RTXFKehMp40RSAMxZSbpxwOfyh6rIYkw6nBtyDbw3Ejmv0VzCTW80GtuhI+91y+gES3l0P0haAPDwFXtENiciXoLH6DvG6nipzNTT9vSqZ7MASL9HTbkZ5VkxYJx8oLkPIIQMX3k0cc3/ZNWuqVyO4iDXcLW4u+0aPyTwEJzXgEXEJhSdkhs/hKjB0/mhjX30c/8A4Ts+QEt8qy3mlbdFt/ll4IThkWcKBa7ljMTB7rxQl/c3tdOdHBT5tigZ2V+VBIPUufW6nNJwOQlMY08tA8FJ+WQn6RnwXLDg72QKK9LqNuYypG9xvsBmOWTflZJ3tZRzrMKy8gDVKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rtl/b92gFYWv17GjZGu3p/71HMbO47cpK6IU9WuEcuY=;
 b=QLVIj9/Mw9BgEppD3P26hIhWHxt9icm75NJ9AED03B8vBCu55fx+ultXdde6M9ONojcPeTfxrsaJkMcIJ7nkf/e0QsAY9gpUPfrYHNtWQJH0bEsRnOd2tqSKcM9OiMDoXzgn3+xwJVo3TUX8+IHmOSFGG7oIfqziV4qxCK/4nT1E0VTfNrfenZfvQzzYqV060pRZkFCkB/9eniq2blxJOa28BcZvcJVfMVX5n8M7Hh4g+utjYI5IElQ869HKLY0u0dIWoBPsdCGCRrTsFYZ0WL9eQ9Y9oQDzBS0saPrUUtPxS6cW/GaK7CsuRWS6ak7nBrlS7DfaiyJZZ019JJUkjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 2 Oct
 2025 15:23:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 15:23:49 +0000
Date: Thu, 2 Oct 2025 12:23:46 -0300
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
Message-ID: <20251002152346.GA3298749@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
 <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
X-ClientProxiedBy: BN9PR03CA0868.namprd03.prod.outlook.com
 (2603:10b6:408:13d::33) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8e876b-8384-45c3-c968-08de01c7af3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IbxbDmUjkt0qzBkHgzcj1lpAXlI72gWt8HxJyYOMKaadXz4ytnut0t9+cTKn?=
 =?us-ascii?Q?dmdFIB7dGbmuMswlfEiX5C09lXNFFd3EH9+3TUIkWmF+Cds0pRS5aJrYml+E?=
 =?us-ascii?Q?ZiJVwcJFfJmL3aTYVeiOMrqrrSVcyHwIX4B0opNzuAWNfGh9aoD+WOAzS/P7?=
 =?us-ascii?Q?XSSzqi/Loasjejg2SQQUDqNNv/ysrWUi+lIu6p1SQg7SZA3PG5T/eAoBO829?=
 =?us-ascii?Q?X7mNM08WmoPZajADFmgnbefmfRd6ANnFb7XpcIDAnmn+klSiEAsKBzVo9pSl?=
 =?us-ascii?Q?pR659Du7jkZbuHN+WbIdB9IovpAgoyE8yu9Ad9gOSXOkGXGnYIAdZhV06Cfr?=
 =?us-ascii?Q?Y/HsShIWsH74PwzoXejGur+GbfShFxiI06LgoX7ReMa93vyYJI2JgF8H9q5D?=
 =?us-ascii?Q?EKZTMrah7DJjJDEQTGVrBnhZFK3jvEOHt3Fd2ojT/oz09Yi7nIRu5Ui1wyZ+?=
 =?us-ascii?Q?L9xB3yBMozl8V74cJKqCNqw0ES2WLvX1nAXiZJkXI0sGrsC8OZBFeTCgWtXV?=
 =?us-ascii?Q?DKfGi+kVstlvRORvINioVNWd1XwloidsCauLZCvENml4x51HLrYEVEsvj6+K?=
 =?us-ascii?Q?z/h9Fa977gczhvYZ7EXZ7Zb/tD73VjkCdFsDyl4jc0lxVHgd98ZTvAkfHuKB?=
 =?us-ascii?Q?xd4POpveOOv5hUNIUzLxSpGuOWE071G3VIVyt/8qCyk0xJTB8q7bu7QqCLJ4?=
 =?us-ascii?Q?Y+/rLq+WiP1a7WRjzQv/1GFakKvhcslv01gVvzCUZLx2lJSM1f4V5OtrghB9?=
 =?us-ascii?Q?R0AcDbRyjEUg68KnBFR2IJ2+XN961Iv56BU5H2HAZ07bm6xkygmA85ElkIF/?=
 =?us-ascii?Q?FLqeACh1iAucr0zkjUG1QhYIFtP+ydDnCN99H2+hZ2MFZLeQJndGLlj9LcKI?=
 =?us-ascii?Q?XRtk8Unt2YVpLU3d17GrnqrNeq2QeFTWjjk3Lr0VRTH4V4BDUY+d+/9s64R4?=
 =?us-ascii?Q?fXB6wLkHJCXLq3MkF8tplH5hFVq+nB2d+9KGFRKq92f5xDbbaxkxhVtvrz3l?=
 =?us-ascii?Q?q+nz8ETSYPDoKYd+dQUMPjuNhbP6DUiFNpB82xSfL6aYky6OJjncOC6/ayQS?=
 =?us-ascii?Q?AzHDhLeolo77pQPss9bZmC9wNShFbQ4Kqbtp5Q6LNPFVKk9FJ9jvkZ9qGMbj?=
 =?us-ascii?Q?zU2GzFY+TwDbq8AT3NuZfmRZ0NrPt4gRgeM7L4YasqquD/oG9yR4gNTfqnDf?=
 =?us-ascii?Q?tKvqacjTM/5K/REOWaN3GT9y7yP3KO0rSbvKP/czdH9Dthv25FGRUXuwGYFR?=
 =?us-ascii?Q?y52vS5/yy+3PvdfnYvjM+o448Xf2ph3Qha0KIEYKBKC5dcGMrGbiRqMGUpUe?=
 =?us-ascii?Q?EdqXjPAzQdtQ38BsVYERk0DbUB2H/BccU6IumUG6BQ7VTIjOa4A8Zf8rs6o7?=
 =?us-ascii?Q?O+D6DBVFejZpdK+2/RMi7sKPWTDcc6GxYjMPj/hhBjgJHZ76IoPuxj7aMa1a?=
 =?us-ascii?Q?CwzFUZtJVt4xiq2QecMdym7dHiMt6ZVt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJKMvMGlM048+RenjUlsYp82CIyUA5DD2FB6kRPyeq5hPX3hLYIpxXkKSRCr?=
 =?us-ascii?Q?eZcf54qtXRuWj5oSya9qJZ+M5+WqcVxxHNAo2N+3xtiSf85whArjYoI2x5yS?=
 =?us-ascii?Q?MU8a6prnWe4D8nV0d3TRYyRQbj0ZC4pB96uVH3NfbDNfxu4+OGne3a/CY6zj?=
 =?us-ascii?Q?AAAZhzOICkDhxa9VYSxVz4vZoBaV0I8MmB9OtQYFwfUtmpEN47ExBXzIvz6o?=
 =?us-ascii?Q?MUrRNYnO31ZP3jA63bCaYJ418BHdeNTi9KEx3T6Rw4sQaKJjQSqVI/Zk5df+?=
 =?us-ascii?Q?k+y4FY3lc1GVN4lhGKBt3h+nMPE6pB+AVeJ+YeqOfmCgfKMPA+AU9/FiJ+GF?=
 =?us-ascii?Q?CVB1ST4sVsnFMdF3aPrhDgxKqJlDYbMTMykBPvatlr+RN+Gxx1/il5rsJMb2?=
 =?us-ascii?Q?0Xa2bWtdIvhDWmDp95ZPkBD5WkWh1goe+tUsZh4265oE763zdN9MmmFbl7vk?=
 =?us-ascii?Q?fsddurrjopjOu5ueWKPosLVJp7j4uvgzsZMq3xla7Xv3GbCU6eAM6ua+F9mt?=
 =?us-ascii?Q?3HmNdCaDL2bIC+vFR9W53nsi4hGeHdZDO+X5/b1iva8Yf/Yu7IkGfjCQ+EXB?=
 =?us-ascii?Q?2QodrVjG2hL8AZHlck8Dc0dfcW6vu1gFvH7S5qwg11ODneNKPKfE7t4FUqpJ?=
 =?us-ascii?Q?jPirVlRcTNzRX+Ti6xczoDMroCwwlmRwZJkKXkW99S81GnCWI8y5BnkE85SB?=
 =?us-ascii?Q?3TKTKIfDekNok4evJON0OO/bvXRrqYzBn77RdljK2yQQTBlO7g95cMcCDwyO?=
 =?us-ascii?Q?Yy3hJt/s/h60GB0SxQQE963IcdLE57Gj33lIAzO89Lw/w8vHID4FRw6p3dvq?=
 =?us-ascii?Q?l9bbE42gpLSpf9jHJEINfY1FRa/KhPJ0CpgkdFUZXXvRf1x3MW9c8hHwX2no?=
 =?us-ascii?Q?veLYa1gFu9p0IyK4RI0QD3Jm2B2CM3pWdyjE5Y52AVyGmblXrfsfH+wzgn1Y?=
 =?us-ascii?Q?wv/R2fHLX/njqxbnExLqYa4BiKgjZEJo/bzlDD2g5kCY5BCuC44ShEG+iaWD?=
 =?us-ascii?Q?Ou8Ppk+eS8Ovksbgq4BCwF14vaalAytyruG8PxhBzb2ctwS4DQ17gC9XiLUx?=
 =?us-ascii?Q?fe9H4F7VMqqTipfvYXB8E4bqN5b/C2KopaWRyg0wSQmkq8oiMViGJ+K8Tq6v?=
 =?us-ascii?Q?03lKw/BXgCxlzRJDjFLvXPKdQ249L68Tb6xPn10x7FUsBOKkv+A5wOIgOPOi?=
 =?us-ascii?Q?pr1itYbLUlA9t9LETKTHqOULZ0sg/HWEHx0lyUnkbztNi/wpTijIN0PI+me5?=
 =?us-ascii?Q?2NmOM9MAhgzVkvE/S/Ao6CqApwnRZBHw30OtflUwiVn8OKciTTH19+irtVmZ?=
 =?us-ascii?Q?HJSISsPXBNsK8dkL55t0ep1ai881AgfLpZSKV6GvgI9/Bxs996eOqZeG9PrA?=
 =?us-ascii?Q?7x6ev7U32uLyHBq3qz2iI2mS8spqAF3RO2nl0+G5/ZoCuf5n0wM0uz7so1SI?=
 =?us-ascii?Q?dIjRhygKzhwSMyDDu9Z96j+GFs6WlSTqGao/jjBXtsth7YE2ftGMIdDtAai5?=
 =?us-ascii?Q?lSW/U47QrGwIiNGLBNaEDAfBrWH6NsIF60KgrZJwYMxHgqUi8o+wgkz/2Cfg?=
 =?us-ascii?Q?vYM+/eNC/2apVlm6jC0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8e876b-8384-45c3-c968-08de01c7af3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:23:48.6259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcoAzIAAXuwL/OwC/l4Nj02/PnbGJ0pvCSTPAoNX/nMRL0W7S2WxReNp9z5aLFtE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052

On Thu, Oct 02, 2025 at 05:11:01PM +0200, Danilo Krummrich wrote:
> On Thu Oct 2, 2025 at 3:56 PM CEST, Jason Gunthorpe wrote:
> >> Surely, you can argue that if they have different enough requirements they
> >> should have different device IDs, but "different enough requirements" is pretty
> >> vague and it's not under our control either.
> >
> > If you want two drivers in Linux you need two PCI IDs.
> >
> > We can't reliably select different drivers based on VFness because
> > VFness is wiped out during virtualization.
> 
> Sure, but I thought the whole point is that some VFs are not given directly to
> the VM, but have some kind of intermediate layer, such as vGPU. I.e. some kind
> of hybrid approach between full pass-through and mediated devices?

We'd call the intermediate layer "mediation", and it is abnormal to
have something significant there because it impacts performance and
increases the hypervisor attack surface. Usually you just give the
whole VF mostly as-is.

The ideal vfio driver is the common one because the raw VF doesn't
need any meddling.

> >> But, if there is another solution for VFs already, e.g. in the case of nova-core
> >> vGPU, why restrict drivers from opt-out of VFs. (In a previous reply I mentioned
> >> I prefer opt-in, but you convinced me that it should rather be
> >> opt-out.)
> >
> > I think nova-core has a temporary (OOT even!) issue that should be
> > resolved - that doesn't justify adding core kernel infrastructure that
> > will encourage more drivers to go away from our kernel design goals of
> > drivers working equally in host and VM.
> 
> My understanding is that vGPU will ensure that the device exposed to the VM will
> be set up to be (at least mostly) compatible with nova-core's PF code paths?

This is not what I've been told, the VF driver has significant
programming model differences in the NVIDIA model, and supports
different commands.

If you look at the VFIO driver RFC it basically does no mediation, it
isn't intercepting MMIO - the guest sees the BARs directly. Most of
the code is "profiling" from what I can tell. Some config space
meddling.

I think Zhi could make it more clear what mediation the actual VFIO
part of the driver is even doing and why..

Keep in mind for NVIDIA vGPU this has changed alot over the years - I
am talking here about the SRIOV driver proposed recently that is
specifically designed to substantially remove the hypervisor
mediation.

> So, there is a semantical difference between vGPU and nova-core that makes a
> differentiation between VF and PF meaningful and justified.

Aa was said earlier, there is a register in the MMIO that identifies
if the vGPU programming model is used, that is what nova core should
key on to determine how to act.

Jason

