Return-Path: <linux-pci+bounces-28458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9205AC5126
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64AF31BA1588
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4718D649;
	Tue, 27 May 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KgcgvX0L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FD17FAC2
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357124; cv=fail; b=RxqML3IabcjBKt+uLeLSbzfHuIUgacqfmpXZZmd5W7lgntmbyj8YEo5UZFW7o1kB0UfTxp9xLSqA0cam4tCZaMUP6w71KfZXgwjuyva9TKtA47pkdBaW4jKln0v2BA7LMk5aeMPKxRCxcbhNSNpx23tj/+XCHtgNNtTCICr5JKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357124; c=relaxed/simple;
	bh=mnvMghZeydebei9XuKlkYoZ4rm+Mwk5BFuXCDkGWqBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jTK25j6PQoTXso1+MKd6y63yFC59SivVL2rw/U2DbdQFuhpNqbG0fp9WiauqMucAQQ9HNszzxwiCfOC9q+iRwjmFYocaMYe/TqCd3KtWNd9KjTso3z84xguMgfu2UXVTKK9BfhbFGDlDzZGa9wIDuqlxyb9JBOq5SP982BK56wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KgcgvX0L; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVyFCzdQz3Ox/pkk6NWblEpcdAfEnquDWPUfLbwrZUUZM8f1BllzsBACdrx/l5hiE8E9pUSebjz5WId/xgSB2JFKsEoMBLONodFE4BM4uR+7XFVD+hd5NzX3qUyssCfRRw0WTmyg2MTlJTvzdZMY1GUNEgzL8okBJl7zeSkOD5TDAg+2akGG9WCHE/UkhE+nTmamu4IWluqum3IktvxOYkJXOtjCwqHRPfLcSLv39Us940j+qscAQQDXgDfEg2saG/O5n/Hd3v9c53kZwjrRMyZVh8UIaW2F7MunSBrNSA0les/bp+rnbQo0IDlMnpVkGzqFqTKS8Pq9hbHhy2xMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OxQYtJXaBwsibKZnWGSXzcCbJQWW10biQjetmX14sU=;
 b=wqChD5ySA15Ae1r577yezZnnSDytJaawfv69y+ax+pgHVC8w8qCUYM9detIN9KyRPYrRuHIlOjquGz9dydgTNPM/QR5ZJceUefmUHwZ2jKXAsH0lrw0VQVNa+iZW6zN8zJWSbCOv7tlOIEcl2UqBnNJm5uTuPZOcTveu3y1q2e8JTDZMBguD9u1c9e1Bqrorzv/nsPlE9cRmADApr0xx7Nn1QOE5YguONWQWxaCaSF0gwa9eJ2QIegd1ZASdxJO8YNvG7GZvktODansnVkzm3UxjrMSsuNq5YQwjXTrNQmCEp1mHwUfLbpjBzIDBjikZUylhynN+ZPeYgrmqlI4tIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OxQYtJXaBwsibKZnWGSXzcCbJQWW10biQjetmX14sU=;
 b=KgcgvX0Le0bgMzePSifWVUpqpyCSuLUWPN9qL0BYaMwMReMKEhQnby88xdIwWAsz5rtZRV7YJyqJjlTnPCO0Z2EDgmgK13GKzhKDb7KARHw9UkMsbtveluNKR+JaTo9weDbaWuFGzMQjCB4VfOgplqvjDUIMlFXLGwbuzN9O3rGlSZm8zzuBEKrhcn13BbfLAERjBTg+FEyW+PFrYKy9uh/lJFy0Rsp1sGxlIWhPR5wUeOU8wuY2zeOcOR4qhHBrZfoapvx12mwr2oXcITh0/vo7QJ+Ot21rW6iPH67kG7sJh3Os3NtusbdJluvn50mXQfD3FJ2uY6P+iEe9RT+6DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 14:45:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 14:45:17 +0000
Date: Tue, 27 May 2025 11:45:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <20250527144516.GO61950@nvidia.com>
References: <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a8qmiruym.fsf@kernel.org>
X-ClientProxiedBy: MN2PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:208:23b::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7cdee1-fd57-4b67-b75d-08dd9d2d1893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89Y4mkCe4LgLcpIoZd1LWBFK3W7LXYQQLcKkuEp8DnnvrA8DPHkV5c9aaQgz?=
 =?us-ascii?Q?kD976h0FdCNQJPgbGMBHL3fE1rXbMwVx25JPsUeR40XOdFpxsrn+bubcRnCU?=
 =?us-ascii?Q?BPlZOxd+PEsQQBNUE3VD6GD7QojgqMOGV9vZdmYYKLtC6CvYqD7YXZ+H0NZM?=
 =?us-ascii?Q?Q7TL+hWeRPIz4atlE5kzWxvnbotxwZADY5hgTQvktAXSSbgAxWEQ3QOsLQdy?=
 =?us-ascii?Q?BwopAzBGz/SMxadBylXXlganWZv+E1QV5mPH74TpoDWkczslfFBLVpvEym5e?=
 =?us-ascii?Q?xtz9qbV9ByrzvmEYOi2P24jMPEkdNMrZjCkEdZtmX7sxELutsyMFbJg55b8N?=
 =?us-ascii?Q?oPPQ8tBy8OcRuritDM3xQUPXij9HJKAZqTxao4m3aufZsD5E+Pl/xFTtfz1t?=
 =?us-ascii?Q?8m4O7ovDPZ1EkoeIU9/y2Y9NljzwBmUgDHdh9J31VwyZtSCfVQb2atG5btDd?=
 =?us-ascii?Q?/d9qgS1A7NEiOoflFLFdLriK2xHRVfTLyDqmtJhUrAMVB2HRjdwA1In818AU?=
 =?us-ascii?Q?JBriXH75uMY0Ihn/mK9YnuEGY7QH2hd0a+Hmfh//6FIsXTp8POlQiB3h7nnp?=
 =?us-ascii?Q?ilh4/ok64v4L5O04h4MxBp1ei4HgpmKbzU19snderi49b1Dr1NE/CphAF4yF?=
 =?us-ascii?Q?kpLavrBiGs5xLj/rPUkPKmZfJ8YbBQZSA54MVIOCE9LMK8ANfY8krxQp0xkS?=
 =?us-ascii?Q?hw9+FnTTX8Ve/0CG0oNVZl13uHl5tzlxowb3/+9pjR2oHyeNGBx73ttqkRl4?=
 =?us-ascii?Q?CsWhmk1OGpPmgF/hIu7hqWSLOldO4pRWdTpwtK+8R7P9oE8fueQYoT+TbbYV?=
 =?us-ascii?Q?btNS6ssyg/QFE31uSbDWiSrVg5R6dWEkJV5tJQFvJRHHOsjlxT3xlh0Wc1+f?=
 =?us-ascii?Q?qKUg62mwfGoePGYiVkJptDqIdWb8jYLS8Sv66ymAQv2A2BrXhoMZv1Ah8miP?=
 =?us-ascii?Q?+SrVEWmEaLekBxXwKfVD9+GsMLiQndB1OI89DzVcfW+I6MJZ62LVcsmOarDH?=
 =?us-ascii?Q?tu8kFNUdIngVywtTZMfb9oaOYXQaUfqQ6mYiWZCzuZO7kkpncqTrV9KZIeZs?=
 =?us-ascii?Q?nRG7dykOhZ3v3Ua1GdWybAslxcZu77hPJqsG/+Mb07Wq2A4w9x3Iig4pns5J?=
 =?us-ascii?Q?WxrDJH+vvLtbowmhNxjpb0gaDZ61Ir2X7lkYsTlRNSoHnXyuabIowc3ENVKy?=
 =?us-ascii?Q?52WeTjdvzrdnLh0+JAUWFuX8qoFYz+OGa9+Tzvm87CC6EGato7/U15jHYpgG?=
 =?us-ascii?Q?oKKFXckByotrb9F8pN86R0142yUGzP4TxbgG7z7LQ8fmuGNYOGR7EqM6N4+b?=
 =?us-ascii?Q?PdY/rMgbL4GGzvUmCco5Egy4FU1cWcg8cq5mikt5btqpczcXNTz1TAoxhzxy?=
 =?us-ascii?Q?1PGNPMcJch7q/E2dIdhLWXhQHFMCN7KkzxNXVHLUbApC0f0zrs1XpLW56zed?=
 =?us-ascii?Q?C5dwNCMHJkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MAyQrsj8fID8eo8/KdyrOZgp/4ahvnP7VV8s5IgrPLZOt0dXY7UkShzZO3JN?=
 =?us-ascii?Q?Pn1iqHv5mT/uHOaT+nBbYowRFnLKQkXTLjhU6Llob6COq8wkU/sQ/IFu8QhO?=
 =?us-ascii?Q?TUBCcmsKHd2Mk/KTDK/FxTxBb7v57oKPSC4OPh7CVQ2C1CgyODHYsZJf9/x5?=
 =?us-ascii?Q?4p8ZZGFedJ92o80m+d9ayjQKcDljSol9KV5CJ/DqFtDatsbkQuCuwnV5MA0e?=
 =?us-ascii?Q?RtdBhLCisy3hgWmGpO4O/mSBhoJd5mpEMUCLfhbaj/BWyf4Yh0MobEXUQrTL?=
 =?us-ascii?Q?GbaeDHb6qPd6RbWDJMxCQwIh6nothGHAGBlm6RyvjD6juEaO7qs1JlNu3tOp?=
 =?us-ascii?Q?bX+vMpL/LY4c3FX46z8VbJX11Mx07zDWq/GjBS8WXzrZ2TSnFmYASIakiCA9?=
 =?us-ascii?Q?nBUEJ2cNgQzdWUxJ8667cSGDxhm+tQ+wpfYAiU2wqHfpUOXGnrlg7xrAE6jL?=
 =?us-ascii?Q?6IMhVqaw685qwC1n/xw/3z18FI5bWwwW5aaZDjjdMAE8H0bKk4SwbRQEuoRM?=
 =?us-ascii?Q?LvqLXpMQ0wwR0ShwSsGyOccaK0YkQ1F2i2qL1JOkp3RL4OXkWtVADM7qCM39?=
 =?us-ascii?Q?V7DBJWvsPh8gdxG2269I0o3xY2UxDEAt6lkvCHWAIAldo3jdPQZ4tiUCGyni?=
 =?us-ascii?Q?YyhKegRgKaZicTBRueezCLX5p/UAsDPAT40oHj/fUziicg/tpnCZEjMSm7ub?=
 =?us-ascii?Q?gTPoqWdH7P9el09D1TRiKox6DZ6Bh6N4p+5c3u/I44GGrm2sUfTqf8rrOQzn?=
 =?us-ascii?Q?c6BHqWoiHpTzp4tZNsAL79qNMPC5Yx3J8tnpddngJGBTO3lYFhxdp/ajJZqx?=
 =?us-ascii?Q?nGD9mlilv3/mh860A1YjByac0TJlWlnS08wKEMhN1W5J4Nh821dlkQM2jgo4?=
 =?us-ascii?Q?1FIqkd7qzP8vT1LFYYLRH/8LQbj5iIQoTPaCmC0fm2dmMEj2ABP/BLbxT1kv?=
 =?us-ascii?Q?JqaRaT3ogku0q4VSRkgu4Wp/1BbhFnKkdS+0baHAFkmMS9SMtvKfsHBHoD/m?=
 =?us-ascii?Q?Th/sX7I30TxPaEx+/vw1LkLU4QFv54qu2df9vuCVZt7cEZ2+2ckzJG0H5s33?=
 =?us-ascii?Q?XoXj5Huc2p17F7AVXZKdhD9Z41F8+ZzkXUCYflZWiwvKlT0pvt4Z0N806gaD?=
 =?us-ascii?Q?IFLPN+lG4DH7ce3/hrR/nfwg59f32uY1L73oaSvbno4MGJsN9CSGA9mr6009?=
 =?us-ascii?Q?A88YaNjV3xcc7i89/N3L51qoBvjeVbkIAe15iEo6l6BB6gB69s6oF2qR1xAU?=
 =?us-ascii?Q?xC9hDlcL3DDSNLKHbS6dfc8e8/98LaNEhv1v0zlnPU1Fa2MOY7fptJVe+55S?=
 =?us-ascii?Q?NpfJdDGeJrEgqh4pOqLwmHtCbs7tjHEGdAAdvAQSSiFVpkP5ka/TB1qjBirP?=
 =?us-ascii?Q?nu7IOWVpFmxa2WQlOUXsaXHBNi8ctUaZlrwLSEacKBheKYxPvGuqw7YN2NDM?=
 =?us-ascii?Q?HyoBArnWRpuBMJh31ROcjNmCO/XjEv+gRaMm//vtBEGBJakEeD+xWyXol6Tk?=
 =?us-ascii?Q?moorPrX1KUWqcK9wiRQFxvrgyhG2sv1Hn2be/+lJuxq1II34/t/ksAycYdvW?=
 =?us-ascii?Q?6E6AvJTcZ89r0yXhC08OOVBIv8QUvOYR81LLsi/T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7cdee1-fd57-4b67-b75d-08dd9d2d1893
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:45:16.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXKcsTW49LtNgpUYsFeagOY2i/fVB32J2odn1B+8qpSXDPG/MciQqy+Sa0H6DaCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758

On Tue, May 27, 2025 at 07:56:09PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Tue, May 27, 2025 at 05:18:01PM +0530, Aneesh Kumar K.V wrote:
> >> > yeah, I guess, there is a couple of places like this
> >> >
> >> > git grep pci_dev drivers/iommu/iommufd/
> >> >
> >> > drivers/iommu/iommufd/device.c:                 struct pci_dev *pdev = to_pci_dev(idev->dev);
> >> > drivers/iommu/iommufd/eventq.c:         struct pci_dev *pdev = to_pci_dev(dev);
> >> >
> >> > Although I do not see any compelling reason to have pci_dev in the TSM API, struct device should just work and not spill any PCI details to IOMMUFD but whatever... Thanks,
> >> 
> >> Getting the kvm reference is tricky here.
> >
> > The KVM will come from the viommu object, passed in by userspace that
> > is the plan at least.. If you are not presenting a viommu to the guest
> > then I imagine we would still have some kind of NOP viommu object..
> 
> I assume you are not suggesting using IOMMU_VIOMMU_ALLOC? That would
> break the ABI, which we need to maintain.

Yes I am, what ABI are you talking about? CC is all new.

> Instead, my approach uses VFIO_DEVICE_BIND_IOMMUFD to associate the KVM
> context. The vfio device file descriptor had already been linked to the
> KVM instance via KVM_DEV_VFIO_FILE_ADD.
> 
> Through VFIO_DEVICE_BIND_IOMMUFD, we inherit the necessary KVM details
> and pass them along to iommufd_device, and subsequently to
> iommufd_vdevice, using IOMMU_VDEVICE_ALLOC.

It is not OK, we want this in the viommu not the device for a bunch of
other reasons. I don't want two copies of the KVM running around
inside iommfd..

> >> +	if (rc) {
> >> +		rc = -ENODEV;
> >> +		goto out_put_vdev;
> >> +	}
> >> +
> >> +	/* locking? */
> >> +	vdev->tsm_bound = true;
> >> +	refcount_inc(&vdev->obj.users);
> >
> > This refcount isn't going to work, it will make an error close()
> > crash..
> >
> > You need to auto-unbind on destruction I think.
> 
> Can you elaborate on that? if vdevice is tsm_bound,
> iommufd_vdevice_destroy() do call tsm_unbind in the changes I shared.

You are driving it from the vfio side? Then you don't need the
refcount at all here because the vfio facing APIs already take one.

Jason

