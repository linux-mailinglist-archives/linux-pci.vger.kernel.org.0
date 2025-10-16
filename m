Return-Path: <linux-pci+bounces-38405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E2BE5AB4
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 00:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A92B934C534
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86F2D94AF;
	Thu, 16 Oct 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ezyyjeSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1633469D;
	Thu, 16 Oct 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653467; cv=fail; b=IXKoTlQz1/JZsQkvp9+i+1hSqDUpeuOAHoST5WMSHm9wERp9gAwj/1paHFUjuIoTP/OO8gXNNOcVo0ywkSK0uLRf78jBfOntc2H8IiLCIqzfIMST1QBY9ncHlecuo0adcpUOa+dom3sPM6UM3/iYuqugN/8RiXNitSYdjyrou7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653467; c=relaxed/simple;
	bh=FAbeJjREKRgdTHZ2C8ZznScRcEuT8I4xQHodlYrzG5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PilRDTkMTzfNgacAzC3bvI3GgtCay7pLo1Mmu5HjyAGYEm7avL4JxEyTluKksQT87ox2cT2YvNlq52+9QfdhR6pEp5VATpKEC6n1iMwnUGIl2SY4nbQ2z117eauk0cYUsw525evhzslgz9wnlSIA633L8mVbXUyJ6WcBt1O5hw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezyyjeSM; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqGbDf8JJwlqPUva+j9Z4qai0ZF4mxmUx4JZiqA9wmldrIQvGXIe7JcZdupXC2IcEp9K6wF4pE2IbD68Fs+y0wNHZlerN6PeFd/AMQVK+o067EP4nfWFAW/175yensfXbQGh0XY34xldq58b4gQnoFrLhGc7uWNjEfbIYJXfOQeP0SCcq5QIg3R8ZPddUwvdK1eJoAAimQtJXVKZJsSYwZL6yJlx+a4JAVCzjAnm7tGetvAGG/4Hcldq16V1I3KiU5y1nN1pMPBwc8AR1khZLWFXSAe/+oqisM1HRZ/o8OBgEZm9Gqj+CS9AhrjscdXkCv+VzfxfPTr6xfWX3XTuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LguBcRSjlJ/JBOPweqA+x03XTH+ZAPXREJDa4N3qiYg=;
 b=knKsB4eDbj2iiAGrTB0KSZXDDiIY86+5d/8Z2f/qa8mJd+KcDyA6l9RA9hrM2dhaaLw/ZasrV0F3rfYnMGT67IpjjKJ5B82l5unk2KaXJg7oNSJvca9Q9w1dJwJNrUYY/pRVfgHK7MEHC8+ZraszvqckEUNXNbh0zSwsYZCfryF1yNkfV/SD3mRskhzmOfFwY2n68eX/VG/qQMbi0UoTMRnmTwKZwlObOhWyt5BFW1Q4tmLkgar0qEPVmMn4vxh5hpe6VvPqa97VOfNQFF+7SUtgIVLW4BOMwCqZzkTCIj+wZ9qL9DeBSJDgrheKckX39I+CuXzoluTuo8HGVlJb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LguBcRSjlJ/JBOPweqA+x03XTH+ZAPXREJDa4N3qiYg=;
 b=ezyyjeSMkJRPcgeuaWkuhyNQEIuKc0yEr5vuJpPQ7iRbDKn4Q4jfhRtuEFPfd41P6cU3BxnNyY28oLbR3TQUOUtb0YZfe51fG1ZQonrXTle7uK3mdtsb5qDa40QUgjdxLYWptHCIEqRBPa4QLExn+9Fjljq/YtN/1MVNeBS+2ZIsdxaAtvOlFYiuPofnpkY76TYeBK4CA//GSGXkJX5go87nxyaRh5HcHkrrIz88uYAMNOszwGiQwHFDPAoKOVEaJb8d75G03q0rNenqsjjy4ERrVDvaXndB03s3E+hJ6raNtGWQZCNMR32yynn/iZ/9knuhB2J8MNE/8GrL/YHxWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 22:24:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 22:24:22 +0000
Date: Thu, 16 Oct 2025 18:24:20 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: pci: implement TryInto<IrqRequest<'a>> for
 IrqVector<'a>
Message-ID: <20251016222420.GA1480061@joelbox2>
References: <20251015182118.106604-1-dakr@kernel.org>
 <20251015182118.106604-2-dakr@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015182118.106604-2-dakr@kernel.org>
X-ClientProxiedBy: BN9PR03CA0763.namprd03.prod.outlook.com
 (2603:10b6:408:13a::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdffe5d-fe69-4b95-e94c-08de0d02c17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f18JToqoUO0D3cThJ4+e471KkBbnXDoIyYXLkZjwFXkrJoCSt/vzJlrREcGy?=
 =?us-ascii?Q?s19q8YKFxnBBdFiM6eYY5ir4SkN2sajI4e/0w/ZlxfrHCm1m0n5Y5nMw0P6G?=
 =?us-ascii?Q?vnMZrMxLClF03vhmcWVhj35g+JyKHeWVK7S3CVOxhm3zGrvmOepkXqbPU4SM?=
 =?us-ascii?Q?XDRWb1OB48+S4jOzIXKipouFaJ+t/huoNa9yl4Blqhn2NT6inDlpMm3/hJuT?=
 =?us-ascii?Q?9aNswS3i5sqjErth6gS9zpWEJi5VFCM2OYZ8p8TAkjMD4wBmrlzGMTB2r5xK?=
 =?us-ascii?Q?Ew0MU1by8bRleeBJnXGDtgpQXtKp3IckQcJVU/jyH+XadrAWFubbRGmvDjhf?=
 =?us-ascii?Q?DUNPArF6lhR1jGTJdoez8FHvlVLtFMD9s2EnjulWP64U+w90LpGOHGyOLv4S?=
 =?us-ascii?Q?OJhrAV8jvlv1BodXX2xkH520Nhp4L+Wud+CpdKXXZEwIItfX5DFwac4wTJHR?=
 =?us-ascii?Q?fFMDhLMVv9/It/DsFrUjIiRR1U3K2p7NbQ0hFgl32tiDZ7JVIjhUK8ceCSL0?=
 =?us-ascii?Q?YJDfpEeQivybuevY3bK45QBOSlv2BD8Uvw7b4rAfuPwksfeakgb9ELdQeXq+?=
 =?us-ascii?Q?+YPYnRzc7NEsj8UoA3VSGdDGEnieq95ybfpr2irIqs2o6r2BUMDhm8ANPtGO?=
 =?us-ascii?Q?w3WbOdO8ictQgJfd6AHwbjYL+CVK03wyRe5BZ1HI5MZpqMbHKeCz0V/Sk7Hd?=
 =?us-ascii?Q?nKZeLB8JqrFVcd0UAPrzUbn21D7V9aQ3az9pYgtaMLlyzK6wLEZS5Mt3uSfq?=
 =?us-ascii?Q?p/SiMGJU1SJjnwwfk5Y/xzsQXHGoxNhuC6kbSkGjBjtSe0Tg7B/vKykDRAT5?=
 =?us-ascii?Q?vAFyi4cJkADS7R20CiJuCT31Pxko4K0Rm3aFkF1rW5y5QZha4IIV/LNbs/TT?=
 =?us-ascii?Q?wJaLoMYxBKfCZAS3KRhQAnKeqkcw3LhK3P5uJu9DUteECokxzJhiwv9iH/Sk?=
 =?us-ascii?Q?qZ3Ol2xInW7AT5C87t+RjSpkUVy7spN+eRMgWWajBLHA5rBhLIofGLMgoAVA?=
 =?us-ascii?Q?CfWpvpBVh7E7kYp4HbJckYH05XQYKcQ30K0ptF64DdqMOYcqHgGP3NiT3w1U?=
 =?us-ascii?Q?hDRobvdZW+HH7u5agcXGURqBrrOYEf60SzEtc9DlK8TQxY7d+TIV088lx0Nf?=
 =?us-ascii?Q?vXs7/HeyTkycj1QvGFg6fxebs4svMkZPR/14tTS5n8ZxiBXbyjughoTkMF/f?=
 =?us-ascii?Q?GXuZAKy+psJxzkGzqk6uD+OAaZVh3Ir5WFFU3UySn5DPP6qvrUPE0rp2J4nj?=
 =?us-ascii?Q?0pXxhb5wthjZtFViubxGfRBa8Kv2nk2ht9NVUNa+RKJ30iX9N+uGlJp+nCLq?=
 =?us-ascii?Q?yocupu8YLDZPw31YujTFkfwMof76smtGvVXiDhohvd3xJ9QbHzsEdiMZVjPo?=
 =?us-ascii?Q?w1UnomE4uz/uF3ZycBQujPOXFRMVtoZVvQA+WQsWlB5Y2ubypRZ/Juz7ksYo?=
 =?us-ascii?Q?op6AZU61fB+FXMyTx8Yu6H5m0Uu7VVqg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ddHn9fqym6yjaDpnLl6P1wQCrXAQn9fENKiFXU3xejhqulLYgjEiyjC8YOPO?=
 =?us-ascii?Q?NWJOxERqFQMlTOlRqLwQ/6gwtCHrlhrbK869XAQMLY4c7edZ1VM59+OO54gl?=
 =?us-ascii?Q?tvX0+0lf8SXlR66s730xKoJMfRZfTMukmAfGWdMAgc1CKd8Pv7SL0V8xw0W0?=
 =?us-ascii?Q?eduW6FNNjm2MIJOSETe6XK7/d/Bf8JX3aLZE5dWZxSiTciBxVRudgbNkXN0c?=
 =?us-ascii?Q?Du0VnWzQbmwFk12zuMDPmm7nIYHBRlKaLV5VtJ2fLXrxmGba5DzK9PlKViep?=
 =?us-ascii?Q?dWUdjWPTNDxZDwOv7yEaW5yvJqdveP8NUJx2+wk+mojp9aibl7Litz6+7JAB?=
 =?us-ascii?Q?NDMgxos5K+Qq82/mEo0jDDoweJPnArFVB31dqBHFdF/S5KCUS4wjk/6ORM1a?=
 =?us-ascii?Q?ZXSR6tr88CnLxNOeISy7QWOh+WOREb37ukcMm0jvzVfODtp4c8N1xDOIieHP?=
 =?us-ascii?Q?7SWg+5ckbv5sXx9aB0bcHoYkEfGHYPDU1/0VsocMsmEiWFKaDs2YVZh54ftK?=
 =?us-ascii?Q?6T7dWf1APdhIo6FVdc4aVBHN0UmI8OSbHdLa8cvzAuUrrbO2FLBNIQ1qxxrb?=
 =?us-ascii?Q?pqmVHdUHeyUOzucU8k0k6wGyYyoZ5/XYbY6gksAg+YRTTwTLSrfwCEl9gO1w?=
 =?us-ascii?Q?vVOK4AnQfWNvUB25RthcyZT3NUXJiuXAHbva30O/u89Jfow+TVWdIwvPT1Fn?=
 =?us-ascii?Q?YoMnFC3VE1f/vUVAx52kEo5MhYWZwBwCXK/tmlP9kTbzizM0eBEP0SjOt39N?=
 =?us-ascii?Q?8jd8PwviVEh9Pv8Tvp+wKpt7kMT2/dMizy7+MILCK8Mr4QGl6PAA8gWTHY0J?=
 =?us-ascii?Q?RQ6hdx65WTDirq4Dr6WvuCtLYmnOGbLCXb3nW+K/x+jRm+Q4Oomtxadj3OBR?=
 =?us-ascii?Q?rasWT8O9HMJj8buezIiKZ+iNPSXLGMFnkRb4hGDid8ExTX1cE8VdOVGvX6ab?=
 =?us-ascii?Q?/idm3sJ5vjA93AGCF5Lh/NAGlzPt5UCDLoGO5/ktAuA3IORChEbk2AB+UN3M?=
 =?us-ascii?Q?D3ca20OkqbMTP1YEPxvdaCxQR2yqmfy/11smY1iitBit+L18fGmaev0c41Ll?=
 =?us-ascii?Q?BY2BI7mdRyPN5l1hfp983zYAB/8FMOZVRH8lF3TCrWv0BAt5fDiWHg+b2ARe?=
 =?us-ascii?Q?jre7UJ7Pwa14dDiEryx8Xt8pUjHHYHrcdc6yMi/7wkAaE+DCvE3kOcWq+EFx?=
 =?us-ascii?Q?ZzImlTIsbagqp8e0SgcFn8uaIloej/kjzq922akgDCrgmEQIKpc1oNz3DW7C?=
 =?us-ascii?Q?UYpnGSivKoIDFC1ID0cUI7gjrdqH/MYbFWTUcIb7k5vnhwzde2qc/DtdzUrl?=
 =?us-ascii?Q?YDz/Z3Ua/j1LclDB+nV/eXQW5naQ4wtyg5biRBDQop1lVSLshwugaQ6KVkcV?=
 =?us-ascii?Q?shWUxcNbmoB8ZtfRcr7mAylwKeUInz2B5oJ2T9OO7VRbsKebAyvWb9OzbCld?=
 =?us-ascii?Q?OVAcguVgq5VB7zNDjXYlDoFJ35KXXHY2uBADwGDmWjtexweAFQM/Q9xMqRcb?=
 =?us-ascii?Q?YwJsF9fDmuGD3VFnFmGeoXxuzh4LtSws08rvKlBd7BWv23shAVkSRpirQO2D?=
 =?us-ascii?Q?nRw7d2vaHK+nYBEOayrBaKnEXa8NGJbnzfykMPn8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdffe5d-fe69-4b95-e94c-08de0d02c17f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 22:24:22.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvQSdQAtE1Rg/YNxCe67/4ToIGh6+eIMcdpx9wrREmz49sg32q274/382iXm0IdZrNq3rPtDi1ErXx8YaSAdYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890

On Wed, Oct 15, 2025 at 08:14:29PM +0200, Danilo Krummrich wrote:
> Implement TryInto<IrqRequest<'a>> for IrqVector<'a> to directly convert
> a pci::IrqVector into a generic IrqRequest, instead of taking the
> indirection via an unrelated pci::Device method.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/pci.rs | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index d91ec9f008ae..c6b750047b2e 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -596,6 +596,20 @@ fn index(&self) -> u32 {
>      }
>  }
>  
> +impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
> +    type Error = Error;
> +
> +    fn try_into(self) -> Result<IrqRequest<'a>> {
> +        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
> +        if irq < 0 {
> +            return Err(crate::error::Error::from_errno(irq));
> +        }
> +        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
> +        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
> +    }
> +}A


Nice change, looks good to me but I do feel it is odd to 'convert' an
IrqVector directly into a IrqRequest using TryInto (one is a device-relative
vector index and the other holds the notion of an IRQ request).

Instead, we should convert IrqVector into something like LinuxIrqNumber
(using TryInto) because we're converting one number to another, and then pass
that to a separate function to create the IrqRequest. Or we can do both in a
vector.make_request() function (which is basically this patch but not using
TryInto).

Actually even my original code had this oddity:
The function irq_vector should have been called irq_request or something but
instead was:
pub fn irq_vector(&self, vector: IrqVector<'_>) -> Result<IrqRequest<'_>>

I think we can incrementally improve this though, so LGTM.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


> +
>  /// Represents an IRQ vector allocation for a PCI device.
>  ///
>  /// This type ensures that IRQ vectors are properly allocated and freed by
> @@ -675,31 +689,15 @@ pub fn iomap_region<'a>(
>          self.iomap_region_sized::<0>(bar, name)
>      }
>  
> -    /// Returns an [`IrqRequest`] for the given IRQ vector.
> -    pub fn irq_vector(&self, vector: IrqVector<'_>) -> Result<IrqRequest<'_>> {
> -        // Verify that the vector belongs to this device.
> -        if !core::ptr::eq(vector.dev.as_raw(), self.as_raw()) {
> -            return Err(EINVAL);
> -        }
> -
> -        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> -        let irq = unsafe { crate::bindings::pci_irq_vector(self.as_raw(), vector.index()) };
> -        if irq < 0 {
> -            return Err(crate::error::Error::from_errno(irq));
> -        }
> -        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
> -        Ok(unsafe { IrqRequest::new(self.as_ref(), irq as u32) })
> -    }
> -
>      /// Returns a [`kernel::irq::Registration`] for the given IRQ vector.
>      pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
>          &'a self,
> -        vector: IrqVector<'_>,
> +        vector: IrqVector<'a>,
>          flags: irq::Flags,
>          name: &'static CStr,
>          handler: impl PinInit<T, Error> + 'a,
>      ) -> Result<impl PinInit<irq::Registration<T>, Error> + 'a> {
> -        let request = self.irq_vector(vector)?;
> +        let request = vector.try_into()?;
>  
>          Ok(irq::Registration::<T>::new(request, flags, name, handler))
>      }
> @@ -707,12 +705,12 @@ pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
>      /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
>      pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
>          &'a self,
> -        vector: IrqVector<'_>,
> +        vector: IrqVector<'a>,
>          flags: irq::Flags,
>          name: &'static CStr,
>          handler: impl PinInit<T, Error> + 'a,
>      ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
> -        let request = self.irq_vector(vector)?;
> +        let request = vector.try_into()?;
>  
>          Ok(irq::ThreadedRegistration::<T>::new(
>              request, flags, name, handler,
> -- 
> 2.51.0
> 

