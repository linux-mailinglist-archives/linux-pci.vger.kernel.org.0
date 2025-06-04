Return-Path: <linux-pci+bounces-28972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8810ACDE25
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C299F7A9A14
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317628F512;
	Wed,  4 Jun 2025 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qU146Naa"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10E28EA52
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040603; cv=fail; b=HqJCSn7oHaYXcTjArVkhzsY0GY1c0kzBaXVgC1atd95IMI6hSc/A/F9Z5dzKqzieE/2J98wJTmx+kBoAiQqAdBFg0RSPqYuWm4d6T+ovQflDqWvvxvUFI2u+6WzpUIxFYjO+79MN10Zyh8Q5DDitk4In9Ih1dtby9HtWgRCBW54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040603; c=relaxed/simple;
	bh=1F8nC4C3HJdlog1Q9gYhezo3w3cVsPq+Ym/eyMAhx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEkdEb9KjIR23PfJEW5JrgzYkHRr9/8/CYFqJ1VQW4dz5DR/l1INwup5iLf/hVg8BIvUMAlnFf+ClGdfXk3DZSpN8JqmL9USXnl+vH7MAEjIj7Av7XmeSNO/cl0CZQItz5ncfrnuW93BGjnl4L5NC0/NeHqQRA6GrasfHnLZiKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qU146Naa; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcujhB2n40dDL47HdcydOP8SAevVBJK5rv+gEsG0QtYmD4HMfbYJMw4Cbm+Ij2rNbq87DzV49yTd2G5uCp9XBNZ+Lrg6ukleVfVB6s9DsMfuofuRJrvOHwM4/JwRjk0DMQCcnxGN6jgvXFfpHBtQaVKy6Fd1BQGxC4ZhnSBhDyczd+d9DvLJoIsTCwyNvli3VhWG7NygDoK5vjE3DY4yj3v384rNSXn2TZ6Ar08Z1ScjvBzuxubfuJQfMRwdqW7kl681avSk0lnPq8AgU96+tWoKASUWsUaNMUq+IEFK+2ATEKzTT/Z+0y82DxTBsGqIgUosv3n2ey7MkPrgxbbNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/ahacOuOG3VyebXL2hJ3EFIhux60IE9LD4Qo3yX9QE=;
 b=VJOKRPC3N5ysDmf0bFTIzbIr4yFGo7HhU1yvfUznx0Ni6yrY0O438uvAGBSZGDzBRDuua8wWjXqUk9+w8RBwK7HK452sgrxkLRGYohtjr+y1JSFM9slS0TzvrElew8P2iNz+gVhbEv7XnIgOGW4GQw/bCVYZc0+ftjHJSpC09NvyonWMQ4fmtYnWn9m1rl1jfpKhz2/CjizVtMplebtluSBCStLqxTQ43X0ZfVCLnbm9LAt12wu7LjL8JuXibDe74xeHo/+ffopWfREXrmeElGRDA9Ockgq5Bozrwdl5G3HasdIwXm2fHl+WbMv6JMDxZGkuOqaBz+oSV1BYnrz8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/ahacOuOG3VyebXL2hJ3EFIhux60IE9LD4Qo3yX9QE=;
 b=qU146NaaxOkeDM2wMH9KU9GZ1UXQZ5m3CcrgPITWbR2TrBEQiZXduXavbw8XSkTmhMvhAEmKvATUAnMplo7b3prsneKv4sfV7zcpPsP0Qj6ABEIRyWibgD/g/iyt61CVjZKHuzwpxymRT5C1JQp3tHb1lRadJ1ow1LZ1+3JAd4Tj8oquuh3pjEoJZ8TKlp2eHXKBrJWppt3CHnWeUZ+PCKtG6CBT0soYhEYXjjCqQmZym01D98yK+dUgUSTu1TSPy4NTtjq3OECLSR3EJaQ5g9O+bEQ+cQgMOGE/dVZlEb+Yv8kcowYiprtMDgPTQ5YBjrPe6+L+SQmo/6jLH1doEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 12:36:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:36:38 +0000
Date: Wed, 4 Jun 2025 09:36:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250604123637.GF5028@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
 <20250603121142.GE376789@nvidia.com>
 <aD/gn2tb+HfZU29D@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD/gn2tb+HfZU29D@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: YT4PR01CA0413.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff2ef06-2099-4aaf-d9f6-08dda364734f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7dzNV1i3PEdf5tr5zXma5IkF/9k7tAb/NZDhUTiHKhw6hBR/HQNCE8MdM6Mx?=
 =?us-ascii?Q?U/lEpwHYNIy3jwYLQn56pJpBtI2k+n/MSXm4hQOTmDEo0jb+0kQ1r26TMUfX?=
 =?us-ascii?Q?/hSSZltB4Hejp71em/Q42O3t2Nr/je8+X45gePH/4vWjvyku2ysBQ8lTnib3?=
 =?us-ascii?Q?8JMgyswSdd6atkTr498Z/zk1aVhox49FbpEuzvOz/AXLrmwOLzreT98/Mx/N?=
 =?us-ascii?Q?XA7I69Z2cDsT06Gox5wDULJr6Jau8i836HVaArUnPg+HssX8XDkEaw6HzXrR?=
 =?us-ascii?Q?cagmVWfPoILSfiTbfOQFZHJYWXLO+jUwGyGe/7EVND9bmsYkeo6gTRMTwXec?=
 =?us-ascii?Q?m4QJ+ffZ1fQBjSl9MGBRAIFw1eNN6LIfgFO106vIcNqDG67pMGieTqeoQ+mo?=
 =?us-ascii?Q?K7vqExlcESDYvERMuTMMVIUA3gTjDdq9GHVyN09tlNBR0iOHqQKrII3dnjtq?=
 =?us-ascii?Q?cX9/vWGe4Jn2kB0mKlLHosDxbOci0kAs7YEPyuXb/gqY9EzbPxCALQFjQ/hs?=
 =?us-ascii?Q?rkYWTCbia/qsygY7uZgdQOfpNhIVGc5GF5vhdVYiJa61X3zHoGE5vycELw/i?=
 =?us-ascii?Q?h+e/9yCZ65jg0dB64WWrZLvI8TsDmJEwHYQTM/I0mCqH1/HzlrGPVgjz/2Ew?=
 =?us-ascii?Q?wynGf0hSSrNyd04A/kw+neGImK85Q3rfKLLUu+2sV5FNUoEMsP/3d11CJLEn?=
 =?us-ascii?Q?YFl+RVyqH3DHl+mIex8f1T327V+4lYUTGjX2omWPwEWNM9WaSj35Yb5VnZWg?=
 =?us-ascii?Q?mU1tSt3kANM3HQNhVBwIsRH8u4Wry7xJv0TPxl3OAcCqSO009b9I9fEsVZgu?=
 =?us-ascii?Q?nF8f0B4V4siIjVkHN7kdMvYGXAUb2Lp0bECXXGtU6YqDdD2hjl5VwkA5jh7z?=
 =?us-ascii?Q?iip4ZdUonZGZ7ORYgeX+4lndHvu12Dm47U/tfBFD4xOph72VHk1LWwy1RCCS?=
 =?us-ascii?Q?xOdn9EkDxUmxHkj9PDOMGem0nFPrCExyzJwKX5qhsdQioXIeIjl/ysXISakg?=
 =?us-ascii?Q?Md6QecJMc9zrvoW+WOxVx4XUdTaNHHGbnS5YmS2uvQrJkyPsvvFZsSxeoRPk?=
 =?us-ascii?Q?SOcDkzrsHlC86/A+kd5zAkMJj8lQ3D1MubNxHQEy2FS55m7rw5SHFcHgCF25?=
 =?us-ascii?Q?yVWD1iqVMlEo+Y2M1kUbw+DRpIxCAoR1xjREtn52um2FWG2LWwsfW5nSPy0/?=
 =?us-ascii?Q?SaYbatmS9xFnwHi4DbS0drI4L3JwJb3Y8XSB6iWm7E8C7xtqqZGDGqbCeEDs?=
 =?us-ascii?Q?sEDE9PH/CA9cpPqFcnbQrLqFYb0ZZOjVUUpSpoT5l/gC+FvcPP0/thMbHW9Y?=
 =?us-ascii?Q?GgvZHiyE8oVT8CuYpMqYD7wCXRGdnXLlO35qp0STHgp6JLklLcfQDw0CzBp6?=
 =?us-ascii?Q?FjRTQnTPAJjiertQV89Na3UZ585GKx8EYc4ynY6nG9MXsiWj8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EwMM+PQ3N6xG7pIalKCdFgE6jbzz0whruf5Q6X4LId3lw0HR00/V6jlzmXkI?=
 =?us-ascii?Q?w5mfItlBVtDxfMn5svLZgpMwHGpi3uTj7ORrU5H49VF08hDuUK3OZu4cLw60?=
 =?us-ascii?Q?Yaa888Xb962Xc66T1lFGZH0EqgQuGhEhw/xZ7iE+Iap1oOwvyKk10r4CDsZx?=
 =?us-ascii?Q?oT4JvzcB2WJ3aWp3T2/nUnB6TNDhrjPNMxwyYeQAjTqEuKzMqcZVH2ZFSu6u?=
 =?us-ascii?Q?Bd/R4FgArGqhfrvzzmlXLIVx7XUqX9ka+/Nf/dOx7JOGtxdv2iRpGRCtPBFa?=
 =?us-ascii?Q?riZ/pVY0LYmpIXuugQseDjeWEhclWeU6ePGREv/qOh1I3JE6ebveHNhfM5dT?=
 =?us-ascii?Q?pOEerAiQbMIcmw23yiU352OLVJF3OC5raL7vw5PPJhl/EQAulGVkUZDAGAm4?=
 =?us-ascii?Q?toLIJVBT12vmMSQNjZ5waMr7/0LuCtyi6kGkD9TB1NWG2nEKFFpAGRZ7j/AW?=
 =?us-ascii?Q?Hf9Zqu14OHir85S3z5BWp3scgLKgiyDzH3EUUXhdwLnJcDUWjwLX9/VeSpfz?=
 =?us-ascii?Q?95c6dxa5nXA6G2WFLZEqb7szYNlZm4YzBlQOp1hH9mATQglajo0TLD/03D2Z?=
 =?us-ascii?Q?oCQyyROzWGioUlya8OKI6P6DFjKgrek95LpMaYUqfz8UEvEzKUkN5//IeKLI?=
 =?us-ascii?Q?S5VyLj0iv4wHkX7TMk0/J4+car/tqYdR61m1b3nIOEWyHFQ+nHhXUuMbN77g?=
 =?us-ascii?Q?vVwfi9T7+9oM0N19KxI/0vMxTW33mczSguVX5R6FCFYcfwzSRNsMm7h/0HBH?=
 =?us-ascii?Q?+p0QuXQcTfk57AXGFiEINi2pwtaqfqu+RC06VMDOOksexjYxlv6UqidKZpce?=
 =?us-ascii?Q?0k65ehdMdlQbd1/sWKtzJlM36SiExYsHQYQqDLmiOgYImVgAs4ZPSX9149JG?=
 =?us-ascii?Q?kq6qNGtLolj5F4XDGf7Icy1+OAzFHCtik1cj6tBFoDucqnGbwgGCoQ+oIjZA?=
 =?us-ascii?Q?Q2NpvSqJyO5SW5afp/zrbUEmpcETBSy3lNsGcQs0fyO3TSKfBjPnD8zwVRal?=
 =?us-ascii?Q?thUGvbMFLeocnGge2iGp04pVBF9bzclZtxbD4veyjaanr4n3A0WuF5Y1mprz?=
 =?us-ascii?Q?77pxrRktGRXubbDN+Tw0Uh7cU0nEB1BkiXbEHSr/C0fbKDXJKNDuGpWkYoK5?=
 =?us-ascii?Q?NOZfWuM34P4W8o5av1M3Dv8gpv0or0MNyLxIEmEVgR3N5Uwg1XAId1fLBE0/?=
 =?us-ascii?Q?7UCqM3+uzRHcA9BT9rWpTkzyBRxaAUC6sAZ1jYSdS6lLDvnsSzwLiYqLrB5c?=
 =?us-ascii?Q?garkSijA4qEZEevHYB7f/bM9ChefseioGt1f8Qh4oUfS4oJiqMeMiWHNVERV?=
 =?us-ascii?Q?vrTZTtaUsY7zdNzKVx7Q2h09oMx/bL3XnePEXOxqvSNrmD3ROHysbCygN7gm?=
 =?us-ascii?Q?c1mich6onxcbgSDgrbdW9CPHcJM7lWGxDJVs7kXRPevUNLJ4EKeVUF+xZ3r+?=
 =?us-ascii?Q?Nvcc6mx/5A/sZjBe8/vm1tJ9Fi1Ocb1q+0Mu9Vnjk0s7+ZILUYWLaEXzUWYY?=
 =?us-ascii?Q?o7G/dmLLNKVL+FS6AeLE3Y1Qg6Xf7TslD9tUgf9hKZIbHLSENHXmH+TMhfXh?=
 =?us-ascii?Q?1EzDvu/W2LmKhnc7kv9MwlFNRZU0R7r+AzOlc+At?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff2ef06-2099-4aaf-d9f6-08dda364734f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:36:38.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaQDxgRRXo693Nxu1ppKlTVjYiBcFKTzWydj0WyWPJPq/IUL6wOJbc7XQvsQcvf6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

On Wed, Jun 04, 2025 at 01:58:55PM +0800, Xu Yilun wrote:

> But the p2p case may impact AMD, AMD have legacy IOMMUPT on its secure
> DMA path. And if you invalidate MMIO (in turn unmaps IOMMUPT) when
> bound, may trigger HW protection mechanism against DMA silent drop.

As I understand AMD it sort of has a single translation and relies on
its RMP for security. So I think the MMIO remains mapped always in
the iommufd IOAS on AMD?

> SEV-TIO Firmware Interface SPEC, Section 2.11
> 
> "If a bound TDI sends a request to the root complex, and the IOMMU detects a fault caused by host
> configuration, the root complex fences the ASID from all further I/O to or from that guest. A host
> fault is either a host page table fault or an RMP check violation. ASID fencing means that the
> IOMMU blocks all further I/O from the root complex to the guest that the TDI was bound, and the
> root complex blocks all MMIO accesses by the guest. When a guest writes to MMIO, the write is
> silently dropped. When a guest reads from MMIO, the guest reads 1s."

Sounds to me like the guest has to do things properly or the guest
gets itself killed. I wonder how feasible this really is..

> BTW: What is ARM's secure DMA path, does it goes through independent
> Secure IOPT? So for p2p when VFIO invalidates MMIO, how the Secure IOPT
> react? How to avoid DMA slient drop?

On ARM T=1/0 traffic goes to two different iommu instances.

As I understand it the T=1 traffic will go through an TSM controlled
IOMMU that uses the ARM equivalent of the S-EPT for translation. Ie
the CPU and IOMMU translation are enforced to be identical.

T=0 traffic will go through an iommufd controlled iommu and it will
use the IOAS for translation.

I've also understood this is quite similar to Intel.

(IMHO this design is a mistake, but oh well)

Jason

