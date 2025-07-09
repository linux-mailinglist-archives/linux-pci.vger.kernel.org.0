Return-Path: <linux-pci+bounces-31737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1061EAFDD0D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EE23AEDC7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 01:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214BF13E41A;
	Wed,  9 Jul 2025 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iw8Akr9j"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3B20E6;
	Wed,  9 Jul 2025 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025318; cv=fail; b=TJ06AaueC4C4sdPBG2svd3g67a1ZbrPbrn/0s9O7LYrcbY2yNeam8JLE+GGmJ8cFv8QmH7DaxosPBtiwgswgAwcMJ+wJk2h5NRNflwKXOu44ElZTQzaxVVgynz+cvD622U6t9poMfi4B6rWIeiwpE0+0CrKPrMSLVfn9IU/kF0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025318; c=relaxed/simple;
	bh=b7NUqg6j/NegNghJilXIK9ohq7n44Vjt6VV01jOGGTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2/Y3TzEWAopDOax6a6fozJcuOH86i1eD9QfOOr6xDpyVJtnxwZ2/vlw503Xq4PuBuVDns+ianZlYoEEarkFVERxpE1U3k8g0QvihVS//hailEOSPtgoYWUSmNB2wavLkhle6yOGmYL1hTKb5L52UY2mO7AHtgV/WIkd45YStU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iw8Akr9j; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGs1KNl7Mj/Wqfo40vA0K6R+7pZP7BvCdFNJNHVWN64I7jx/A8BW/xQQ6jlMjJvIflBqTUxdX6KK8a4s66wX9e6R+FjFk2o0Mv22xH9l7rt57S3EqOf1JyD/uPn9EcdPfwayr3RkoQ3GdqZ6QHjXXNpGdsBdU3QTMG4APnbHm6pJrO2H8+ziZYXI4nDEpMMvRtJxIzdWBArEqxjmq9t5mqEuQtzZTpjsyzxmTZGVAq81tqogChtqntJAqeessNn6PgH1VSitATgyj9lYwkpxZRSVsEEZ9E3LWRMfpKCI6RffGeLAtm5JVathJ/L7OAe1GvPIoU99WL+NiSpASD+8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TDFRYpb0YyPKrvPwrZL9m+FCGv9gDE2pxSoLhkioek=;
 b=TnRRJ67cwvaUYyfe7J3CW0jrZJjnOrhkJ/wFzETCQBmPRipiAb1QxTnqJ7Trjf73kOdmKRLIURHNXIZ/Bg4WIjyDTQ4H2LamRzophYuNqIW3dSqs7AV4VGkET4FHVM2NMvZ3pwX5zvqOnqQUfdeCADGmkW5a7irjp0P3ECr7HXlymV+PXJI0pU0SMVM1sUdt69ovZkQMgiP/W/bkvOvG986LHYXYb7p3dcSkwTd3P6AIUMvedNUZiNORDwu9yeKxuvr7BWuKsoZGUiwZvV/RTMtj0f1z1UsWxnV+iPupEnMlEbyC8zVerSbt/qyJHnWGYEsBQfo1zV69XzDO98r2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TDFRYpb0YyPKrvPwrZL9m+FCGv9gDE2pxSoLhkioek=;
 b=Iw8Akr9j68dgT8gwYnRUDU7DJLCa2roOafPJ9jtm4VKmVSqTKgacNAIaqD4nuOkycGoKfOxHJpPyZmHxlhVItcJgwnMTCNbc5njkilxPrbq2iCObHel3UBDnzNYRODRBP38iPAGphWMHMChIErRiX8xuClR2MGHL/nf1eqmoH6X5G0fWQnzw0ZPeWvd8TiiaEgn/8oLD3YK7Dx9xlnypmQvQFBvnzxGx41CSl2UQEvl9LYhKh+7h2dpSAxnSNnLkwyR5OeBVQpM4pv4MM3EBkk4/UV/wbFXZxIHkWTgB6kBG3E90or9zOVEITc2JEIba0Hy3mzyZsfniEcU3S1wP5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Wed, 9 Jul 2025 01:41:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 01:41:52 +0000
Date: Wed, 9 Jul 2025 11:41:47 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: Add dma_set_mask() and dma_set_coherent_mask()
 bindings
Message-ID: <77mjv2s3ebgilijr76e3c5ajm7iafqfjwjwqmz3j2zsslby4q3@x6qncv3hwqo4>
References: <20250708060451.398323-1-apopple@nvidia.com>
 <DB6JF2JLZEO8.4HZPDC26F3G8@kernel.org>
 <DB6KV5SVWIYG.2FAIFGZ90ZR2I@kernel.org>
 <DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org>
X-ClientProxiedBy: SY6PR01CA0013.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b50ccfc-f24f-4af9-a3b7-08ddbe89c707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4nO86wDg1fIrKfSe+wzyr56OpY35HbZQqcMLhqRAI6B+lutvW1rToS6GOi3?=
 =?us-ascii?Q?gjQt6tpu4UwBsCTAmwCKnZQJDd/aUO+rRSmBdlsFlBkp4nrLnJkBdvfyF2fm?=
 =?us-ascii?Q?i6oeGUl4FkVxv+6x4MYkK/02lGF+misEfZs0Zmh99feZuBc4S4sQqraE6qxm?=
 =?us-ascii?Q?haN0D4OBDuH7ffHBLysxF8VFMbPslvIF6co6ugOQhlAOobesTMv3Yh0pEVRa?=
 =?us-ascii?Q?zUVcjE99mD04ae0bKf8YX2dEI6iDb/Ts12EePSaut0R33aUZpG9RWCL15LjQ?=
 =?us-ascii?Q?DB5VTDLcKe2+xy1oNIP5PdnRSS6Y9q8sVRwVmmlxbsX88ppxXQ0Rt1tmvxnF?=
 =?us-ascii?Q?2emp8pV6hmrJ0I4fFzVZBW1HDh3y2CKiCxmIXAze2CGm1Q22sPXCH9hRrlsO?=
 =?us-ascii?Q?he8kZSvfczgG+WiBpLSISWYVNpzTI2jq77mYqXta3hRBzYmnGfZRh8wr2NyQ?=
 =?us-ascii?Q?YhU/v9qO79Xa/QJ2Of58b+OMTvAkYuzEeodPVRwlMH7Jx5vmVFmDZW7qOLvU?=
 =?us-ascii?Q?nVNSn5Nep8GjthqsiyAqybN/T9Km+jbLP5p7AubnvHlRnnTGzGywLbCntk+d?=
 =?us-ascii?Q?Y2F1xUG8L0QA7XcnfOKn7Pr7I68p6IxWx5U/SV26wKkj0f8rRFp0oWf1GAlW?=
 =?us-ascii?Q?1MN/AyWBbE4c/3HrR3z0QJOf7UzUiHHcPMZfy7TcYm2lnNs2MNKeP48FtRV6?=
 =?us-ascii?Q?qqxBG6Cv/vuoD8O1yt2Z+4eeOI7SjgH9mrfTol/KpcC9VzyYlXFmO+geZWGX?=
 =?us-ascii?Q?6g5VWEP+fnFZnveyNhGLO5fyUN9YCea+26szhnE2yRKptRpQ8OgTTEyD9t73?=
 =?us-ascii?Q?hFl6hRJ7tCf+xeZqKzl4s0tI1vymRJHQcw37dwnIU8t3Xpimpjwa4u5Qxxjn?=
 =?us-ascii?Q?rgXaUQ6ET5Lbot/whRcvaDxaGsooriWVhlOOLIrqUpMiwLNkRtcJkxedSty5?=
 =?us-ascii?Q?QNaGWFfWQNhhJ7DHdv5W0aw2fcZYWSIeZx9gLh1bN1FBCWWqd3Ubu5wnP5aN?=
 =?us-ascii?Q?sMFWUKwc2c8O4rwsIu2ZsvN15xMcy357z/XZZekcE9PENVsR9E7CpFYyVEPw?=
 =?us-ascii?Q?isGW6NO+aPDaXd3XQ8Oti8+3kXBsdNcj7HpGKYmiSwRT4PMdKVITaZ0HYRN2?=
 =?us-ascii?Q?t8JH8kgQHUTl49vpknaiZIOoZAR6Z5w7HahwDTou1apqUS5o5vwKCGlfWYqk?=
 =?us-ascii?Q?qllSRGf0VuuF2DugaqHDB891lQ6Zp7oukQhRFxfi9oTjZDRVa0DmHW7DghWa?=
 =?us-ascii?Q?UHe/dJ0XB55m9nsLxE5vnANs1lN7H5ieIPIxHilHux8bbHXObERogWxkTI0j?=
 =?us-ascii?Q?tOZ1KBzOpr6i8KoKeH/juxKyBrP1u7cWzj+jR6yC7fG0gUMBJx6H68wqdXRt?=
 =?us-ascii?Q?fSLdMzwtyeO9hNil1KD4PuJuxfarbCq0Aw3a9hlUZay3e9yjKV16QTUYH3C2?=
 =?us-ascii?Q?2YJFX93iyio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7H2XI7igcxzynDSI1rQmLHOaCxZrEoeXlFmlQc7FDs2JeWCLXbFA/M9R0fNh?=
 =?us-ascii?Q?oHSniv9M8VSZIFXp5bIKCcDoVoWrNuhoUk3N8ap/umWWy+wop7ijre8QQVuq?=
 =?us-ascii?Q?Qt56awlm9D1rKZMtYRJ7Ro6CS2ljskc6WbpZfjikpnpRZu1q0jva0T7wpesc?=
 =?us-ascii?Q?VI5bJjKCBzTiukh0yw5kf7CAK45Qvp1VK/Y6Z7H+7BGj+vUS170jxYvaunCd?=
 =?us-ascii?Q?bbziPrfUeTmvZcMDrQ7bXk4ZigoRb72rCvXnW9grxXkCqNbcVTXCyaXAFxna?=
 =?us-ascii?Q?oijp9uI4GLTVnDN1/S32jU+NOz22gRNlT2M16xQUplFvwK9ZgMlcSwTqZo8T?=
 =?us-ascii?Q?px7iwffD0CqprH3RAGzj3661PgzI0zyviSkLciK465JIjLLLtTEaiupVQr/8?=
 =?us-ascii?Q?P4Eg/UUgJxHgyUbv0Yi1QoXE5gJ6AzyeXG5dPkBps14tagUC77P858U0YY9s?=
 =?us-ascii?Q?R6nt+m/ZHL5jOh4AJVCvv/0BZy5SPTvrjJudM6V7NHWJQv/cqkxpqLUy3dT1?=
 =?us-ascii?Q?VqLC/rWnmlXq+/6e93ldVfoOwIQEdfXONiB24aZX4lUrSzvioZb3yf/v2A53?=
 =?us-ascii?Q?A8WwDOj5qEm4bVthl3Nv1U8XNaOwig4nVgmUT3hd8JZDxA3iOUIoU1iYi4tY?=
 =?us-ascii?Q?4xHoTvjKSlYS2aEbxmxVsqtmuJeqnlTyU37T905t8A3uSYdPhjIM8klFzb9C?=
 =?us-ascii?Q?wyknq0iVnHwmcFuQojd+rZGeYJFjtf++X1gepeQbV0ky1oCp/Yd9oK/PYsjG?=
 =?us-ascii?Q?GIeSiPLCTLRqan6ArjA/K9+XZmNTQg1zR8vgwFdmzyqw97QK9F2ZXkWdTAyY?=
 =?us-ascii?Q?6Puao0rFKFQb4zRimeMX7x6Uv4fF3Nw68aL33QcuwFNVNip5YDBiNvZ0As1O?=
 =?us-ascii?Q?76x9Dbt3731kH5c7mX/+WkCTu2kCJbNQlUyRKcKNG0OjPpFjOiQZ4cvjT7R6?=
 =?us-ascii?Q?D2u2LcMWLEfQYbp2vYCeMDtCxrvZHYEI/gUNyhjsHl0eV4WIWAYUrCz8jqb6?=
 =?us-ascii?Q?G5ajnPA9HPtEoV9gIpzCsiClTD9hTacbi5QvbWAPZsYrDL4nIjCz3RkTNfLU?=
 =?us-ascii?Q?CkzNxSyXsNH5agoqBfXS+vljsqTv0pYFEn9n44PhsuKbdpRnJ4vWzKDnIZk8?=
 =?us-ascii?Q?u7iomjTX4xpqvvm4ejea+zsEAqnE0RY67d57Qa2Nw34Q5oRofMoJgxbj6Nvx?=
 =?us-ascii?Q?o3KYR0hQg65N/yGpzJk5JJWBJ3uoTYN90f9jwTf134GFw/KtaCIbj66+JX7O?=
 =?us-ascii?Q?c+QE4e7M22MATLXX/YMWhIkMMa4yGhgaccGeSqC628AE2oOZAw0oiFg5LBw1?=
 =?us-ascii?Q?ReUWtL1tR/la6l8JHdg0Rf0BkFFp93asdZywgLx9A3+dUfeQmDsVscXJhqBw?=
 =?us-ascii?Q?DPDhlRlnmsKerjzXnhi+He0Oat6vCWwY31StVwj8SKqP4J+Fzv95ActU2odf?=
 =?us-ascii?Q?iBxR18k6nphhl59RmqT4Qk1ubo76pdW6qNCuPio9l33av0hkCV4FiaASyBYW?=
 =?us-ascii?Q?gNKx909YNu2s7keziRCFy4H4U7wRpO6yVAPbJ47hdlMqH4B0LMU34IGt6yJt?=
 =?us-ascii?Q?dRg2rFbJps1m/nE4bD+CihN2C+wD/EoiRbZWcLeW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b50ccfc-f24f-4af9-a3b7-08ddbe89c707
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:41:52.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNNinvYKf9gH3wU3MXnhkDPK+RGPgZAJgZf7FEB8dxRVwzzMhMEzWZlDmbeH54N3WfilxLoGe0+4rd4/ybIkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699

On Tue, Jul 08, 2025 at 10:44:53PM +0200, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 11:48 AM CEST, Danilo Krummrich wrote:
> > On Tue Jul 8, 2025 at 10:40 AM CEST, Danilo Krummrich wrote:
> >> On Tue Jul 8, 2025 at 8:04 AM CEST, Alistair Popple wrote:
> >>> Add bindings to allow setting the DMA masks for both a generic device
> >>> and a PCI device.
> >>
> >> Nice coincidence, I was about to get back to this. I already implemented this in
> >> a previous patch [1], but didn't apply it yet.
> >>
> >> I think the approach below is thought a bit too simple:
> >>
> >>   (1) We want the DMA mask methods to be implemented by a trait in dma.rs.
> >>       Subsequently, the trait should only be implemented by bus devices where
> >>       the bus actually supports DMA. Allowing to set the DMA mask on any device
> >>       doesn't make sense.
> >
> > Forgot to mention, another reason for a trait is that we can also use it as a
> > trait bound on dma::CoherentAllocation::new(), such that people can't pass
> > arbitrary devices to dma::CoherentAllocation::new(), but only those that
> > actually sit on a DMA capable bus.
> >
> >>
> >>   (2) We need to consider that with this we do no prevent
> >>       dma_set_coherent_mask() to concurrently with dma_alloc_coherent() (not
> >>       even if we'd add a new `Probe` device context).
> >>
> >> (2) is the main reason why I didn't follow up yet. So far I haven't found a nice
> >>     solution for a sound API that doesn't need unsafe.
> >>
> >> One thing I did consider was to have some kind of per device table (similar to
> >> the device ID table) for drivers to specify the DMA mask already at compile
> >> time. However, I'm pretty sure there are cases where the DMA mask has to derived
> >> dynamically from probe().
> >>
> >> I think I have to think a bit more about it.
> 
> Ok, there are multiple things to consider in the context of (2) above.
> 
>   (a) We have to ensure that the dev->dma_mask pointer is properly initialized,
>       which happens when the corresponding bus device is initialized. This is
>       definitely the case when probe() is called, i.e. when the device is bound.
> 
>       So the solutions here is simple, we just implement the dma::Device trait
>       (which implements dma_set_mask() and dma_set_coherent_mask()) for
>       &Device<Bound>.
> 
>   (b) When dma_set_mask() or dma_set_coherent_mask() are called concurrently
>       with e.g. dma_alloc_coherent(), there is a data race with dev->dma_mask,
>       dev->coherent_dma_mask and dev->dma_skip_sync (also set by
>       dma_set_mask()).
> 
>       However, AFAICT, this does not necessarily make the Rust API unsafe in the
>       sense of Rust's requirements. I.e. a potential data race does not lead to
>       undefined behavior on the CPU side of things, but may result into a not
>       properly functioning device.
> 
>       It would be possible to declare dma_set_mask() and dma_set_coherent_mask()
>       Rust accessors as safe with the caveat that the device may not be able to
>       use the memory concurrently allocated with e.g.
>       dma::CoherentAllocation::new() properly.
> 
>       The alternative would be to make dma_set_mask() and
>       dma_set_coherent_mask() unsafe to begin with.
> 
>       I don't think there's a reasonable alternative given that the mask may be
>       derived on runtime in probe() by probing the device itself.
> 
>       I guess we could do something with type states and cookie values etc., but
>       that's unreasonable overhead for something that is clearly more a
>       theoretical than a practical concern.
> 
>       My conclusion is that we should just declare dma_set_mask() and
>       dma_set_coherent_mask() as safe functions (with proper documentation on
>       the pitfalls), given that the device is equally malfunctioning if they're
>       not called at all.
> 
> @Alistair: If that is fine for you I'll pick up my old patches ([1] and related
> ones) and re-send them.

Fine with me, and I agree with your conclusion that these should just be
declared as safe functions with proper documentation. I think there are cases
where the mask is dynamic and in practice I think basically all drivers just set
the mask in their probe routine before doing any DMA allocations anyway so it
does seem more theoretical.

> If there is more discussion on (b) I'm happy to follow up either here or in the
> mentioned patches once I re-visited and re-sent them.

Sounds good. My motivation for sending this was simply that we will need it to
start initialising the GPU in nova-core.
 
> >> [1] https://lore.kernel.org/all/20250317185345.2608976-7-abdiel.janulgue@gmail.com/

