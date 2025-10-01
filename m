Return-Path: <linux-pci+bounces-37314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5BBAEE37
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 02:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3193B6B76
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF321D9663;
	Wed,  1 Oct 2025 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PgGuVCrr"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20C19CC3E;
	Wed,  1 Oct 2025 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278811; cv=fail; b=DjEc5pdDfy862gQfHMFJZnBtZes7gfJfJ8TOwjVIetj4AryoBsyGOuKccnWYi0X7+bZB8Jc5TyLWNcMa6bdxiUyv+1Snb8iiGvek4LKcxwsDkF6ufwQcQcZnjMqxdYzpJ+q45IORnZMCKmaMWJZtEWn6Y4bpMog06EdTgcnBAYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278811; c=relaxed/simple;
	bh=+MoJ35gvHRUQRz9H0yq3ZpGHnqAPOpQAMOVnV1mrzi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VlZPvcWgsW3SQ7Vvhhu3DOMPBPF+/UOsk5bjtPHcY0cd18Aur763IeBJ7vYxsORKOVNBawX5o1EPWZ80abmRXdXORV5kyetnRIGj6DFOMutjzxRnNF9sY5Cor/yILkUwbCPo3YMCZ7IXOZn3E6MGGUtmOSBIkMfCVnAeCQVX/y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PgGuVCrr; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP3hjR6OVMGyNC7zxBFZa4+dIbIHlfF5xFGuBA4PTfsDbd88uR/+zY8Lvn76QohIFn+CcKcJI8vZCaWhVlppneb8y4OUEUD/aGLQqZug9gGhilAt0FY5lSRXvRwJozYzmAoDxDSHLkB02r867B8aUy80PqyiMbeoS9su/aoKVuDYti9nBpwkWHVejXJFNyg81XtPi2YZhcGxFj50qMna48jMWxF5lIUs5ZJeV8ZgQbXdLmDr3/QALeSgEXdKabEOma9N83QbgbCs+k64aJO9gVdnRQDkB38NEpuhxr8fdwsSe9n+KuqLyL3Y1hG+2gUTf7dOBp6pijXPg51GqDKUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/TP4vYr5/CcWXhyce/43utnf1fYCODM4+/tfsyFd44=;
 b=AKi58oHpVBX75qCq7SENvQN/A9lRjkuNAEDyOBbz2+/94I/MenOhwFAEce6FhFC46WElo92Dy8gRSSIit4OMf4MWqVDZzdO4Lvy3OyRjOHaoAzr9Cr6WBjyXqDjyt/UumtcPgI9i+Yp0cPbfnLN7WzqcFruUpk6FA+EOqjJw0R88NPvm1xMVXK5+lRgfkIm9s3zdBrHYO1KP561OrFOiqcN7GPhjjfI5hjMGKeIPE+aRcCpMUXEP6fL1YzTDRq1h5ZA0mqs4YoIwbpC2e70kBKr6ZvZqzMDZhHOr5GMzFXqqnFgupa02O1aIPtm21YAPO9sWp6QTI26M8vRrpCno7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/TP4vYr5/CcWXhyce/43utnf1fYCODM4+/tfsyFd44=;
 b=PgGuVCrrV5L0/1kRv2A4I2L+METoLnQwY08sBm62rSvT3OPa2E1K604upZ+WPD9BKL569vApeJQF3X2EiztZR3Mp+ShYzZWuTWD4lWxQBABM6dL+G164F3F/MS3KRmtjQ7x2V73Bmd0Md6gShziaAwUEjVyiTl9VsdZG6LdqsC61zY/uzUMMTM5y+vlIxFl/SLNi5sPJ1SJ+j8BDEv9TiLuuFDDeXoLf04TxJ5cRcnUKB1KHV5E0x9h+BNmMCXAV/FZnsz92mcsXvjPYbwtB/D+FyIyveF9kRasJivWDXSqVIdUtCXSVHpdFs6taEJcsNIW5icMXI2vfl7fI3kXOqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 00:33:24 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 00:33:24 +0000
Date: Wed, 1 Oct 2025 10:33:19 +1000
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: reject binding to SR-IOV Virtual
 Functions
Message-ID: <d2yft352u4p5goqqekbpngqyv4k5bopaof5xm75zg3npbobny2@73ojw73msjl4>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <20250930220759.288528-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930220759.288528-3-jhubbard@nvidia.com>
X-ClientProxiedBy: SY5P300CA0021.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: a82fb0b6-8eb0-4cc8-1cc6-08de00822147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4HSsnWhylIQhTlnGRfLnGc21DwQ+oUFkfY7iNMauKdHupZPZ8M0MlHZDXMnP?=
 =?us-ascii?Q?ZbheUi/vvz7NaSmTRTk8yK7YzLFNxdW+y96QW5ZcaZQbeXs/0/kyIbiEb0LQ?=
 =?us-ascii?Q?ymY0QPsdh/LhTxIAZnEiLt6Mwk2Qvv78w8oHLk7YP4plcveDgwg94GZXArgt?=
 =?us-ascii?Q?WgcEARb7stHqx3utU4XcZ9pMbAVHv6zfZI9q5K0MYcsK2L6+kxML05Ou4CoO?=
 =?us-ascii?Q?OqNit+903terWyltUpFIIavSyW7ay6lTGhV26Qep1/Kcmv7UNfgTmh1dF+Cz?=
 =?us-ascii?Q?mj9dHHa+oxuS+IBa7VfmRKK7SNLxBQ7BAqI9UXPAPPHrYfnHwvwn0K0N/Bwf?=
 =?us-ascii?Q?IMQrdsRi0kR+dB8NFr8UC6yKFU0KJeNyzZXcNYB+lSZEeZxW321SnEJymDiX?=
 =?us-ascii?Q?05jeGKDXQBEG7DdiFX/eOMVLDfhvWWa0rtHFmLYUmOLRwswMEVAt41XulTYu?=
 =?us-ascii?Q?VnA7IOXkbOlNL6wpUtKA/ufAiH+thQsagb0tx3OYkytRxYqTaLi0wDst8Bxq?=
 =?us-ascii?Q?QuM61YRibw6RAHbGn3wIYJRrhbSKKsXl1c8gyUbG3OD/+5tE3IG2audyjxXh?=
 =?us-ascii?Q?cr8vV5j5ZGJWFDus5BNFHKIoRHbOHhLKa8zWWAF/+sidP5OMBPiZRwK+QM+c?=
 =?us-ascii?Q?VqKNzL1Pe9odmU3GECqTTJmy4Qr/FmEclKJYVF+6pk8knDq1dxtH5YcxD2ph?=
 =?us-ascii?Q?fMUd8P0KAH2kxk97t942qTtQtpM2ibiLWayU7NrglzCJxA2McSpXAF3AvXUr?=
 =?us-ascii?Q?84bWzl2p77BHPRSi2oz0lKDHrtvP5OFtw/kKa1jDT+GzuXnBWVJ1E/3abWF6?=
 =?us-ascii?Q?vrdSS4DNE7vV29p03S6Xlv8lNz5IHx+SQuB2IDghaxgmFAmiaWfgSN1tOSsC?=
 =?us-ascii?Q?WfeDL37p5RZFvGTD/G86jHp6id1OanSpQNrJDckyTuVuvYjLZ2LmkQirWpuu?=
 =?us-ascii?Q?eVw4LoOjiFCYoGEyy4ZZgf0R2BnfuUAFXy5U4AhkRxnnvIqYX+21ix6/aZHO?=
 =?us-ascii?Q?5XAnghNOwfa3Eo2q9/6wfUPeuE+vmnQJuqjNkV/dfsVgrFcoh8ljn7nYdo9n?=
 =?us-ascii?Q?L5cG41fhpSWosiJPg3UxpM08KejVcmyUW6dy1z7IrU8erj1OYVzg06moP2lD?=
 =?us-ascii?Q?KwRrgkkgcBl+zHrLfouHRo24mz8m3z3RZZLMu6jDfHaK05iqgK7JZ2hyKpzm?=
 =?us-ascii?Q?YoO80eXlW8rpJbLTfip+c07tWcPEkWEEprEpbYdTAAzwOiNYVg5voYEGC7c5?=
 =?us-ascii?Q?c2D3C0pzH2uQESYSwzfgeLoyYo9jeeQMAY5XAiAzmJCl2oyVseni0dp+YCbL?=
 =?us-ascii?Q?OunMpqFo9vxoKoprwm9GDiQflCUaotmjKq0TtdJTpZL4401uCjaqH+l0hiQB?=
 =?us-ascii?Q?eqEd3hoMEC2+0dwttMbdecqSdi+Gk2PQdLcCD0wa9e4DK8OVHdndJd7KMQej?=
 =?us-ascii?Q?JzL5cDgv3omH3ffPdEW/RKr25RMqmGlr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VYnfKwIQ//sPUzXN7+8z+8gpZLXSu0yvbHi44dLb/+eUBD2dxriBRYl4khMO?=
 =?us-ascii?Q?LxURc1ig0wqkrH2kWc2Wo0XVE/jcVwJOH1KF3JZi1jkDe3dNnw4AXKXp6ojH?=
 =?us-ascii?Q?Vm7kzFZWZq0XtpPL154MNKg06gc1T/JgQEpaCILVXl3B0ANN4WR15/qVpoTt?=
 =?us-ascii?Q?fTi7aC5J+6rVHWB4e4txPdCEe4XQbgPwoP8YUb59/ctwkFIBTKaRbsxcQ6mV?=
 =?us-ascii?Q?D6RzZKKI0+KTIB80csj4gt/LLLaOArlXMzkaVhc4eNFDOZQe+4XKz7CyjrE2?=
 =?us-ascii?Q?s4GrHJ3Wn7kZuad8ONvFscyKPcoENWLhTTxB1GCUCBGcEAmmGwOR3N5RfCbx?=
 =?us-ascii?Q?rb71F695m1MUKKf6gOIQ770DM+PFkqGrN6e6OMcThgeHXuQIPTzRHTH81zCn?=
 =?us-ascii?Q?48aBq6PGdexIH8hywj3DNttFDObQgYZbrQSs9xnf4WP0Cgbv3QWIAdKc8dKU?=
 =?us-ascii?Q?h6TdEFna/TUcCl+/Ni/9UC6XjGKDPeq/YQVKB/4ax53+islx9/ESpvB0utH6?=
 =?us-ascii?Q?Yugzh8xXnq3XQjhupBRWljFxbL5HhOcLgNxwhhxh4h4l7tOFvnncJ1KX8O2k?=
 =?us-ascii?Q?0XOpA2asguIplMR/WHETREBS1iKJd+3b8sNbTUOrQJsBa/5VngTEn5wsXKvL?=
 =?us-ascii?Q?44ziRIw0uvgoKxqqismOAkPkAerr1H5gKxjubZI0lXhhKtv1zaAoU00jTuB7?=
 =?us-ascii?Q?hxoBDMqeFJe8RgHFUDZIpOEdUmyvPlXyhjeFyXsdM26vcJSwQVCAJkD75Pa1?=
 =?us-ascii?Q?c3AI5A2nhPxeuItUd/1p/Xl4XtRbLSG6iyvMloEdvtyd6ivlnMAd9RnHXdNI?=
 =?us-ascii?Q?j0HZSxaPbVFw+QkWaDGtJ/zYVV/j6nTocECZfuSRthnBBiBFTRxQq2FO20pr?=
 =?us-ascii?Q?Sjopy11OOkEW1PkhVFbhnKDPph93l1a47ldbnTHwOSInxhnhKis7bB/jq3Om?=
 =?us-ascii?Q?nuuTB6gFhP0SNIQuuhTz8FGjwYzoTbLWYpyzvhdJFblLVHyeWJ5IaRBOPCM0?=
 =?us-ascii?Q?P9ssn7OHoMmnKRwK14ClR67SqDKgODh/9hyZkzW4wo6tXEHxLJ2Tv9H3Qcbd?=
 =?us-ascii?Q?SQd9mEPRVLTxJ1w4gehmSVE37VYkubOR3v5gGk9yyj1VMooMQki+SMbGg0WT?=
 =?us-ascii?Q?fuHNhHzW9aX9jWfAFDWkiHcoupoBHMQh6v+3fm/p8wTQDc4f/WzazL33VY8o?=
 =?us-ascii?Q?SJ858SWrkaEsdVo8wmhyDdG35Bci8yCNGX73yQGE1hemfVtA+PQ1MgHLzgIo?=
 =?us-ascii?Q?coYZY8KxBi8yYhnBrTHXQRq/4nNJxpZ2OoaWdK5dQo5CvhxOG861qixiWV+y?=
 =?us-ascii?Q?saSPoaKLc1YllduziDCX5/DEToeDSc6yaLYnUib24EZT7ti9QunX6p6PdoEH?=
 =?us-ascii?Q?uWhFk5jZP+2ALCq3JpdFw1d5mtPf6XKrjWpWkF8uaAq5eq1JhmuYdArIV3kW?=
 =?us-ascii?Q?OE0zQr6ZO0ytM7t5qHAAtu/qeBTXFdaNE8PLD9QjGb+jj2Y7VsZX6ddGogaN?=
 =?us-ascii?Q?KUh0uqZZuSUfw1zmt5PxktGeShVAHkat7LxSyU+c4IZg5y6FpCQswOBwyKRT?=
 =?us-ascii?Q?4R8zzD4e2Tu5wTqG9KRu69A4MyxXtnAwKQ83FDez?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82fb0b6-8eb0-4cc8-1cc6-08de00822147
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 00:33:23.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhb09YX6IdMdrntg0gUjVfSOBot5S9VUAtgOqMfF5zsChfqUGzxVRFLRVYDL3AEyyn2TLrIz9kdDuY4hm9hk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
> Nova-core must only bind to Physical Functions (PFs) and regular PCI
> devices, not to Virtual Functions (VFs) created through SR-IOV.
> 
> Detect VFs using the newly added is_virtfn() method, and leave them
> unclaimed. This allows a VFIO kernel module to claim the VFs instead.

See my comments on the cover letter, but does the kernel driver core continue
trying to probe other drivers if this one failed? Or does it just give up? If it
just gives up I'm not sure this really helps much, although I suppose if
NovaCore can't use the VFs for anything useful anyway then it probably should
fail.

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index 5d23a91f51dd..004c15763694 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -54,6 +54,11 @@ impl pci::Driver for NovaCore {
>      fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
>          dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
>  
> +        // NovaCore must only bind to Physical Functions (PFs), not Virtual Functions (VFs)
> +        if pdev.is_virtfn() {
> +            return Err(ENODEV);
> +        }
> +
>          pdev.enable_device_mem()?;
>          pdev.set_master();
>  
> -- 
> 2.51.0
> 

