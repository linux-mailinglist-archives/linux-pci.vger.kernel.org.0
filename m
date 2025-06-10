Return-Path: <linux-pci+bounces-29353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32DCAD41D8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8A21768EC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7746320A5EC;
	Tue, 10 Jun 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Stvo2JtZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8733246799
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579601; cv=fail; b=JS68Q65fdMfPArFnll8G6X9SVy+kXJwqiioO9GwAdPE2hV7TuMxYWxeYIpFJ4xfKVIQ5Pif3u++aGTjrZOpG1/A+rcbsdNRphSqoijz+RPivWMZwMvVWmRwWsDOAleZOsNm48+f+XIwzyqzDH7Pxi19SxiSt+cH3XOxaAZdalFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579601; c=relaxed/simple;
	bh=86gTBOpm8mfxWRAbPk30VKh3UZ3215PZH0ZwgWkckyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S5uRfIIr5QXevN9KPIIk3//IaK6NcYD6m6sQxZupyHVWLbIgvRIGPxhsEVncDoEFZQZhUQtGdcVL7EHRCn9zpK+/7Up9N+X6ahYYS3VndIiS5mSNtysjC3stOWjVHxW8qrh5yGRq3kxnJ1Omi4Wlee13D4Mx11TQGsAKuS5C2yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Stvo2JtZ; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNt8ZhyLZ5u5UsNLTERi6Murch9Nir0/fwYSms/N98IDmPvoUrJL/+7qeJLxx36KyLenHiB/dTsr8cuhbR48AQ1GIlqHiC5u80QyKon3xhQF++E4DMQVzhdhPyTJ5TbUtMYsrqfDx/H9+FBApgvRbK20hizZixTD5rR7W/86/DdLYiaiaGP+j3Q2Ib62YEUNOoqILJkYSrarWU8RVz7kASh+FhQoT8GcYxhzGtDax9k39x+TscIDvSC5W0ReZ3JBJh2uvn7FP9xpFfVBNOmJtw+aiAL+ycxl0Vp17YP+YMpKRoPLIWiRr770JBWGmWLHIDz3mfzgdMg9LUQQcYnx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YoQudrIPvJhzm0W3HiE+iY1mco9ZCVVX0UtU/li/gQ=;
 b=FO4ITfx0/XqksjejqbiNrLfbbWzKb28WDuxidjoPwFVVpy2iYJchlYGe67lezy7hplwQ06Kw7skoMzb/q8IuhOK0urkRTajuy4og+0/dPANT3rrbGAJKvNhPoVstV2hVKWDaOc3n3YU2F6mfD859y86QqyFaUQbxdKAdpZ3vEHnHw7OHDf/+BaR7fOk8L7zLjphYd/Wmo8msKc9YNYqc4YKBZe1Hyuh6y0jp4QhqQqoryKpgvDyFLDpKaIroQbZXQILfbo5xjlabtqhKKz/BLkfGvwDs9Hty0WiJ+oXAKApc9XJFviV0L+rSy03Hl8dq2/pb60NvoQC+xnQkIBR4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YoQudrIPvJhzm0W3HiE+iY1mco9ZCVVX0UtU/li/gQ=;
 b=Stvo2JtZeHJdewJGzD1qrFCS4LOh4CnFLuMHKC8cfN3VzKRF00oIK3zB7GAEKRLBcgon0uNmTMt4sKU3wE8Q2lPe7QPiaAOPQnLAZh4YrvMnm5ET0fhcgd/zDzK8hkmgK5YN5CouPJm3PuNvNpYn75Y8zjUFCNnM7sHNKmj9CJnpb7DFXRcStgWHwENaoYHQ/+RquVl4uuE3Dqhh4LpatrUIK/c7Zby1iOF6WnvZljP7n6qkJvhoFpf5Yp2cF5z79Dzj8SikZa3zKPlrKDPO97g2q+3Ad5IJRkTCX6mbl4V43FjkPPqfwA0i0zCjzVnNcG4F7sOOE/xFlh+/F2m0MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 18:19:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 18:19:55 +0000
Date: Tue, 10 Jun 2025 15:19:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250610181954.GK543171@nvidia.com>
References: <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
 <20250603121142.GE376789@nvidia.com>
 <aD/gn2tb+HfZU29D@yilunxu-OptiPlex-7050>
 <20250604123637.GF5028@nvidia.com>
 <d56b85e7-3081-4c99-b3db-7adf6604951c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d56b85e7-3081-4c99-b3db-7adf6604951c@amd.com>
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f8ee16-7892-4609-df69-08dda84b66a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E05TBO+lMdhhHZEG0TvwGD3ZeNlacsXjrnFI9D+5b4nhsf51Dk9bL97iNsu5?=
 =?us-ascii?Q?TuqfnTQ5MThR3HUJLULV8fUUIO8yNnwSNQT4t3cjRasO8HyZvsx+/sEomZA9?=
 =?us-ascii?Q?pK7mc7sg7sYZBC9gtULj1QJ8F2FYhX95VB3E3K9Ndjvs8BQU3oOaSP87hMqv?=
 =?us-ascii?Q?KMG2vAayo5ogRecEJhYp9G7X8rEISswt5N3dMEV9eqgkxarzX9d4BXWzDwe/?=
 =?us-ascii?Q?nJHaobSJTtczpGm9azQVyNFNFQDlF5ZFGWvB/IR5mqLe8qzqZXKcEW9qVJm4?=
 =?us-ascii?Q?IERWhJqtxPo6dMg272L88PcytDZjJc6G+5/S6qMGk3pSxOZsiJJ7U1UUv/Wc?=
 =?us-ascii?Q?+IEMeBB+Enh+MOPXWCpUhxKTsh6XnSg3eu27jbwZLKRK3kAtOnqvB/j2x3Ls?=
 =?us-ascii?Q?sHiwIQCY/4NeTN3z4MX8OsZUS1OGMgmtkhiVPFHpPY2g5TkS7ZIP3HLKhmWk?=
 =?us-ascii?Q?sE5HQRz/dIV39svCCJhXqfsu4SwCpVPNBmz+MfwvEtb2EN7K7kaTHbStvSv4?=
 =?us-ascii?Q?qfe6uZV+RFe1kwzkacKUWmuNFEgRabDn50AKCedz5TNluMcmu5SPFgF7Cx62?=
 =?us-ascii?Q?AcNP87bxiPOOVC/6tEddZcLw9FN49d4mvQI7vaID2/9T9NnwsoYcEeC7uLBg?=
 =?us-ascii?Q?FBiqOZPFEQyEx3SZNwPRuBkqmRB1LYS7kK0PFViGMngHp41BA6s3c+AFOrtI?=
 =?us-ascii?Q?unMNPSSFlxUdf5sSa9PTSC7A/X4NBnXQA0eiV/i2eOCotejAAzuTplG0O7T4?=
 =?us-ascii?Q?c3fpAweBVJ6ip1Q8A36oKIJKlnsoC4vdoIgUnxGzZ7fqdFgjPSegO9tBl8PY?=
 =?us-ascii?Q?MO9pjOmGh14YIDrYBH66yUQ8Qr9bgnaO25dYTf5+x/LyRNmowZ0Bw11xK2Of?=
 =?us-ascii?Q?3jor8QjKtsQjMg8Qvkk1u6p+GQdZV/4bZtAgpGn5CAN+/Dskvyfoot5NNPhk?=
 =?us-ascii?Q?tV5A7x4OTZNimmlcz/Do+7c14UNguc4YuHnG/uidqQuKBGW7Nwe2rzP0pIfm?=
 =?us-ascii?Q?/UdUwEEOMAj7eEG/DXycci/z3E8cgacMmGeSfy/ndcSVuFcKXNSgKhnxq/ke?=
 =?us-ascii?Q?aRmA7jl5xQrv5jWVAqfqGvMXOg167dhhnBwkiKxMAWr+AZGD30BHWhtMlW5U?=
 =?us-ascii?Q?cx2pMKvFkVxtFwhbu50Dbpvw2fTq9LNhwnWIotizQqXoDGJtLNKRGIaBimgT?=
 =?us-ascii?Q?zRQfszdPNy+Z5rGpxrck6hd6EltvFuhwWU5QsNeTP91RqHk6D3QX0s82OV2F?=
 =?us-ascii?Q?KNpTukCVpziXnlELGSCPzmn6vbxJniao5IsPQ2Osj7eOshQD88WM3Ug8aLFQ?=
 =?us-ascii?Q?7/GSGNcOwcqxiISVxJuxciTrSLeDEXRPJm7O9Hsio276uijyB7XtxN5lr5Hl?=
 =?us-ascii?Q?RgfAWszYtJJSyMIihHhQz5DLDureWBR1m97twiDIbFelZuLnSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qszk4ZptVeC7xJTbIJ4jR5tLCm2yBwzr2H3YUtvCu2BUJIl9O5Vn3kWgUuqT?=
 =?us-ascii?Q?uXQA67mB5Ngbs6KOkvr+CZEGKbAr/M0nuoyYM20HU1yadvUCLAlNLFSPyh21?=
 =?us-ascii?Q?vgr4MFLP1GRdAVdImYn9h/VrBJ0+dxkqlLCp+N76Zrzh2PGlevGmq6PhFNtB?=
 =?us-ascii?Q?tqObYu/Rzv5u9vIBQwPJyhQ8+wWTiu2L2qwCAYGbCkraI1L8AkTnW2oQNH3p?=
 =?us-ascii?Q?tymYE/icAfkgZ85F/O13IVWl0wqBRICcBYqAyZZ4qcef8prjDfP49p8Lg3jN?=
 =?us-ascii?Q?V7PlqSJtT/r+CU6Ha53mT1Urh3Y+362Ukk9j6E85hxLwdY8uFKLMuTaDirKu?=
 =?us-ascii?Q?ocAHunXRJGXWMtr9dreiN2fo+ruS6uQ7OJL9Pj66xICanlkfFP4/7iNCPSsW?=
 =?us-ascii?Q?ND25q7CseEdmO7CgmebPRrtUHxbV8FP37umXeCuF4NuCy0sUFT8Cf1kIlcBt?=
 =?us-ascii?Q?HBh8CnsYGYoDf5BnfF4QzQkIHMHsAktyOf1absZmYLOThi2k8izdRtjEYkuz?=
 =?us-ascii?Q?KKCCJuehNio5uKsTtNpyeIv2RykitN3OUr6t2J9UoMsDwxnJgMlE1iYvkPmI?=
 =?us-ascii?Q?cgiefK3e0UzKdgLOVDQLBT3Hz0h/rSfvhGPgKMTE8a42Q2k9S3SaX3QaEOZX?=
 =?us-ascii?Q?Y/DZMgTNTYXBFaaGKM6dDELOFGQ5qR/93feNX8eu8JeeRHixeEYE75NCPDJv?=
 =?us-ascii?Q?cJ5U3z9lx5u072ohohLSflBtVCd75dctGACgc+Ujk3w+pIlXC/wth9Yr3/PK?=
 =?us-ascii?Q?OOP+EtqSCOOBpIdtE9NL0IXzSHkTPQs/Aa7TbfdUNQURf1S8+63TkhRcUDy0?=
 =?us-ascii?Q?e8LlhT0mNKje4TK5Zk+/y4DFnpFW+x0odJIrhgZpyuooO6noozyFQHsT+PnK?=
 =?us-ascii?Q?hw7YOX1zZr7LDdxLHmrsLtokMtu3h75ACJZ6bBZ8XvbJdIX4bDLf2KwIRpZE?=
 =?us-ascii?Q?wUUuJclF7LJa7ycT8OXN2nJXkfTlM8WwY0lA0Tbb3kMdLanXyIAxgScGBXN4?=
 =?us-ascii?Q?HMCIRXaI89bCXwKXX40OsCc8sDe076CUG5ylVpHLrry7xebUWjD7uZZkVLTH?=
 =?us-ascii?Q?xeJQJ1OszzGpyDe1ce9tir/c5qufuKX9Xc4vnv3yPbXeEjxlIxiGB9eLPM0k?=
 =?us-ascii?Q?FK2bDKBPy8t03LuSLbu1mWswTgIMpTVBkdItC4jAZCeu6C8hmZKAlk0EINw+?=
 =?us-ascii?Q?kgva2RyS+MPWsekw5YfKlpOiQkgl16Hqd7D6f8Nu/m8x49AHCNWAF5GbRJ3S?=
 =?us-ascii?Q?OjjY4l+8OOmd8aSor0bKD1aZdOCzLET0j/w9FcVLP6sS1bw8gAqnoTW8oU/t?=
 =?us-ascii?Q?nZHeySXF62qTTKzy3vCQQkjiv2Nn9uMVEUAyq2w9nquxfFFxzTt9s1DziyX9?=
 =?us-ascii?Q?5bTygKONaR/YLSFl/oeIdIAx7QnrTvrdwCnvisRJy8lY4k9BaSI8OSSJAVh4?=
 =?us-ascii?Q?Vr3QOFLsIsnYrl2bkzlPESt/y+cEGA7dvPRXBJkhMJD5DIb9E40Y9x4sVkXR?=
 =?us-ascii?Q?IZ6ZLdAHemt1XTbj/z9TFuucNFbnHXYv9IIjHJG7sE2GbKLSt/BwUBbVtZ4m?=
 =?us-ascii?Q?4PyFdsxLi9vIlKRkqfzhlSYnTRgAeXGyCMcYJbFw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f8ee16-7892-4609-df69-08dda84b66a2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:19:55.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heN27be+awZpa/4dxa7Q3qoeYAwid4K5NeXOMR7UsPrlR2kn4QQVtEFcK8QQiTgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

On Tue, Jun 10, 2025 at 05:05:21PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 4/6/25 22:36, Jason Gunthorpe wrote:
> > On Wed, Jun 04, 2025 at 01:58:55PM +0800, Xu Yilun wrote:
> > 
> > > But the p2p case may impact AMD, AMD have legacy IOMMUPT on its secure
> > > DMA path. And if you invalidate MMIO (in turn unmaps IOMMUPT) when
> > > bound, may trigger HW protection mechanism against DMA silent drop.
> > 
> > As I understand AMD it sort of has a single translation and relies on
> > its RMP for security.
> 
> Well, two levels with the first page table living in the guest
> memory + RMP for the second page table in the host memory.

Yes, 'level' is a bit unclear here.. Intel and ARM have four levels. 

 T=0 S2 lives in hypervisor memory
 T=1 S2 lives in TSM memory (S-EPT)
 T=0 S1 lives in guest shared memory
 T=1 S1 lives in guest private memory

So compared to AMD both the RMP equivalent and the secure S2 live in
TSM memory and provide protection..

I've forgotten exactly how AMD manages to secure the IOMMU S2 in
hypervisor memory, but it seemed unique to AMD.

> > > "If a bound TDI sends a request to the root complex, and the IOMMU detects a fault caused by host
> > > configuration, the root complex fences the ASID from all further I/O to or from that guest. A host
> > > fault is either a host page table fault or an RMP check violation. ASID fencing means that the
> > > IOMMU blocks all further I/O from the root complex to the guest that the TDI was bound, and the
> > > root complex blocks all MMIO accesses by the guest. When a guest writes to MMIO, the write is
> > > silently dropped. When a guest reads from MMIO, the guest reads 1s."
> > 
> > Sounds to me like the guest has to do things properly or the guest
> > gets itself killed. I wonder how feasible this really is..
> 
> What does look especially worrying? So far the process has been
> pretty straightforward. 

I think it makes debugging guest bugs hard if the guest explodes on an
errant DMA.

Jason

