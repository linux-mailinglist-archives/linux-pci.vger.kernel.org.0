Return-Path: <linux-pci+bounces-31952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C016CB024AB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F95C1E2C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3791E47A8;
	Fri, 11 Jul 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJkX7hqO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8D1DF270;
	Fri, 11 Jul 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262545; cv=fail; b=Oqlo+4FsOF6QPKJrhxK/XgqZVKdmAVpAivqZwPqp7NHiuFXCAW/IhpkRJpUettOzA1GPGTki9XBMl86BgZMjp6D6tyKhz/AbxXAdpyP1nbwrQLFBToeZG5p5qryNqo1lMUYD6Y2Bo4TPM+MFwyXretwdMJR3MPoJ1RG/ATTcBlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262545; c=relaxed/simple;
	bh=7BvbN0FjgIC9dV8YOQWp0pZ4gaLZy0JeVVwkAkDdTcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GAqXSOIm3NlHS9i2058kUspmxd2+PxwUM3q6YGpmZbZ0iVqeJDisNJvlN5HWu78U9v4ah3pTUB7Fr/yKZoo9bcqXiS5qJX5lUzoYK0H2A1EgIPDMXF+z8b7p/XX+3QpAGkmvARXUkbE+F2NVqoyHXIpO2ZPitjyPD/Dj8G4SyUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJkX7hqO; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVCNxUtar5NnisWilwkZZ2b6yNDbWS5QCjkVS+C3WSf55etT1o+XJFeSKPCJWA6FDhoZb9MPkYCl6Oaqys/TGq5bN056DU5PGoO5b/AHlUHsAnjjepVqCMHoC5uxknOs1n2W4lJD24WstSnkCQqsA/VVYlIy861yMW6NykXk6YXTX9OO4ng031e6CBgBgrtDKDdtdByp0yrjSJnZXlycX8lda12XClWdePos7yxzomohBAPRzBqh53fjI1aRAzGzd/Ton+FyfMJBvjSBXMuOlaOB4YEH4tm8x9K1pyMaBZdVoGferrSysHnxjKCHvS/FJAHFKpdELCZJLdfPaFoCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVbTQq3wLwaEy3YmWo/OPeinHhjXqx4N9B82yVI7gl0=;
 b=SqfQMEc10J+Hj3Wi1GDidQpV236I7xbze4e9atOHicGX+JtR3IQf6kW1XHBipDOaoLd6yaFwN2IPOjfVD3N+eEXe6OFCxcz4EdLQ/5qJhO5lr/OB2zmCy0/aelinQc2rn3916tuEthtRvBwFGbL0UNV3z3H8jnYc27/FObY0S1dy5l9S3Ntks7j6hAutnKW0aeixWjqwWhvnf9Yz2SmzA/CYOdNIVFx6llF/N6fSJm7n2cn4AsF5TNSRyWruOB2r/DurK7o0BvfktJFaef5bXEyOn7U5wl2gQW1u4i2ETCj9HacSGB0sQy85bp+mR8B0Kd8HXZ2d3jb3djrVN8s0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVbTQq3wLwaEy3YmWo/OPeinHhjXqx4N9B82yVI7gl0=;
 b=JJkX7hqOvcxxpDqm6yShJJh8RPzWEZp69YZa45L/d7Ktdu7RlBY2gQP3U/UhQXs8daKEA4UQ+qj3J34soljTuH9DW5qgm850FPBOPP53T+T9JQbBbzsmmVTMkD7XJXISOBpAl1SqBEWMLPYs0v4CxEwGUqcwUyj8hd6scWNO+EWuM7M7R3DuFt/q4CtFMXHV+7ejrvgctXwrjzgSoGHaaIvi+1lOANY+BCTdOiE2pHabSlVNMh5bvNYnuhKDyQjdNgrT/wxNUnknEkbwWPK1s58JBzgRbbTDWz+bBx3yYcWRlj1t5sGTx3QCFNwQ1pXDmSLVwnzPq6ALzjycvcKJBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 19:35:39 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 19:35:39 +0000
Date: Fri, 11 Jul 2025 15:35:37 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
	robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, bhelgaas@google.com, kwilczynski@kernel.org,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
Message-ID: <20250711193537.GA935333@joelbox2>
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710194556.62605-3-dakr@kernel.org>
X-ClientProxiedBy: BL1PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:256::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: f51b3fb6-347c-4805-1216-08ddc0b21da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19bGvFOCeYmkUb4e+0jg8P5cUEwZi06+ieza9IXQ4Acxnd9y57nD24WWFFYF?=
 =?us-ascii?Q?h9zZyMM0AdVjzuR1W+Zs6PZjWWBysKxFC9yQculslkcYz5XK0O0kByb4++8a?=
 =?us-ascii?Q?0Oqxw5m/7KuU1ma0R/Q0eS4BoN5JKaZN624MRA7ygA2NjBnwUH08ch4rytiE?=
 =?us-ascii?Q?X+KKk5TgmO/jPpEoEp5M53j5bUMLP7x2SgB3gPvjAcV/U7KtlKW3l0/GMqF/?=
 =?us-ascii?Q?l3xueEvi9I/n0kbT7dvxK3dk2hcIToTgZYIIyn50O8tSe+FwMrid8TNeNlxm?=
 =?us-ascii?Q?jhWo4gQUO/VM5/EasBLYeOca+pWxWI2b6UUnn3dO9RQdyuMHyjC4E8jTbACi?=
 =?us-ascii?Q?j8XyfKCCCkVmZvatG3H9e077Hv4TIGl5iSJQ/zadmLA9rfKwlLpg/Y7fbgFH?=
 =?us-ascii?Q?0UuwpZ3FXeFUYI7zUSpWgirG+OXOOw/lLYPD3xAgj0nOUxwvYxQskd8c37pX?=
 =?us-ascii?Q?YHjIOYnxvVQa9tL80IxX7/+xHgx1NvGs9qB/WbZTH8OazxD58KWHUcjvv8JX?=
 =?us-ascii?Q?hf64ee5i/C9fklFeK7Na5tq9fmWp7vRIyzZ8ZOFPUBsfZWSL52Q0//Dxt2/e?=
 =?us-ascii?Q?8RUf0eBlB5yfxkzuKX6yKer6Aa88KQVxbzxhof848KM8igEXjWHUZsdIEsyy?=
 =?us-ascii?Q?9qRYmSIYdw/48DlCMYnsdGs3spuyudbU77bWcF2rE8oEnxDkvr6abNEfzmYX?=
 =?us-ascii?Q?VJ+hngESHbPrINiKYOiVlTy+u5Ur+EJcgKrfHcIzZidf6un41L9Mxoy5COoO?=
 =?us-ascii?Q?VM7HgplyjRQ9FcVBV9zAnsumEhjyobaC/HZYzcNIu7XzXVg1QsEVfXXVX5ZC?=
 =?us-ascii?Q?tdGk5QOi447UmAhSdRrq9gv29g8zkO4akx3nouec1dkKhsF1at3ojyo4NIvQ?=
 =?us-ascii?Q?blH3phIS+7H310fI7BMv4Qr222Njtg6Ayy2t2mdF6Qap4Bgii8Od1p7o9u3C?=
 =?us-ascii?Q?XlrVBwq4Jl9fZlOsvfhW+0N3K3C0R7DRDtA8u82BpKupuCCkSr1ehIZUs4Kk?=
 =?us-ascii?Q?Q8N+WFPFwJ3fFrZqOEtSa7/LPslNnAUb7ibTvJRih2eTkhvUBZjdUaew3239?=
 =?us-ascii?Q?O/amwm6SbTkdhbET6gmeIkqy6YYyW9eSbXbPvt+a5P4UHx/g4PCq8V5O60Dt?=
 =?us-ascii?Q?RNOuT/6PaqBRrf8LzVgTw+5vS6dokImDtFOIz+4PLQC00440t7eYDSx0PSc6?=
 =?us-ascii?Q?yGWaSF6xM0t0cGbh1GIcSGJqLf0xzLaIrWgZKf6axeFf8Z1knwCG78El21O2?=
 =?us-ascii?Q?RhkG/VvTwPyEjLDxwiT6NU28nYOyZAbdpmTaaXwYout9ARjsERcnLryosdlr?=
 =?us-ascii?Q?oaxaFgzFTkDO3+gKJ274TSj3Rwat7cmNY7efTjjL4mBEt2qulttcy+o67t8U?=
 =?us-ascii?Q?AlNULxoBNuO7L1aSfintZTEkVLVpcSNbm25zRb7tJVJPJw8+z6LNyInrGglq?=
 =?us-ascii?Q?7GJ+JHj/Yi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ce8B2ieM1vJ990c9Mdc2ynMfZe523LXs4tf5Nzt7DC6vW5AWpIh2D8Y+BwXQ?=
 =?us-ascii?Q?6BKMbfNywsMH8hMnkkum1voN0RjTS+nF7x8id2Pdvj34v4aWmO4lHRMIieQZ?=
 =?us-ascii?Q?hsrh5BuK1C9srgMZCsACHrfNi9hgC7MrpWNuoZHNiU4DBXjYs/ByjdvkGT6C?=
 =?us-ascii?Q?gKRbYqU+d0jeafOblt86Vu9jFsXGMV19oGN1kxO3wLPCpld4Qv1/tOG0PyLW?=
 =?us-ascii?Q?l8ur92VQA7x1MjqqxTNCpXK9+SLjvTa0F42XbBp01yfRhibfNNEEPAEVbddp?=
 =?us-ascii?Q?duQQ2JvD2AsJ1UOc34ajrebncnfonvwYmfEnP3Vd54P5zlEBgx3lYLb022T4?=
 =?us-ascii?Q?hWeb8U72vXEbWfSLP3TPwjiJgVi7sQJKuaJX4ha3QDRm3ciOy5WDtwROx3cj?=
 =?us-ascii?Q?KKV/mBhbZbca6sNDWKKRXtwdp984Oc0QXS571NUiI1wNWn+GKGdj5kPE9pd7?=
 =?us-ascii?Q?4Vp7ZjILsMqROwJINET/ycloILAmkyKbvl+9mprd/RBvGhG9257ZLeki1sJp?=
 =?us-ascii?Q?z5izH9AYPocMKPy5rxLYDMjaowuS4B08EcT1hCemt4tn1At4dG+Py/7MiA1S?=
 =?us-ascii?Q?gSNLe2u0AYUmFtmbp9iGiel2NkUbR5WtnJQfcA344ZxjoWmvECEPbmivZIon?=
 =?us-ascii?Q?WGUs+NFKkAJX+PF9PLcGMmo/i3/BHt7etsfo5yWz2btGnrkIjkwuTHI5rXkr?=
 =?us-ascii?Q?vVjquo5wR1zk+6LNwGhamiQ5T3rmkXMIPTdG/M0JE6dU8/a6srwyPSUnF60e?=
 =?us-ascii?Q?/nu2RckF8DQBK5wAccKroZEd/crARRJNU1SFyf7RqRqaovJFavOJlvEg2MA0?=
 =?us-ascii?Q?lB54pdGjIeYL9Y7zWGYNOdYBtd4mLAnInA+ySbxo0lUMT/AxMRrsP8vj/EIY?=
 =?us-ascii?Q?u6MxgrzV5J8ruazmEYUrEJXCveUS2x554Wla45g2ruAneYV6CO3K8K88wnEw?=
 =?us-ascii?Q?klSnbjAtTV+ZdIIKie+AKxzXQEz2AQzurdmUjKUgo2Hw1EQza8BJSQGtRJBW?=
 =?us-ascii?Q?5p77z8xlP23GaaZvgXtHdoVWyutuB6Yagmt947BexkDH9PoqFZ2AylAvT/1T?=
 =?us-ascii?Q?1Bz2WtaD9s/bXXuDGk7TUbaam7+NJqLeM/JV/seiG8fDnY7mses+vpqHYD+e?=
 =?us-ascii?Q?DNC3CqYyCIf6K7DJLW2fkmrpfwIcFY5JdWiCmktKOJeKejHKW+6IEmpGBsS9?=
 =?us-ascii?Q?XKH6e2k6q6vqKnnBoV8vTzgSkOzWxRVOZhBN5KtxTPfujMXJW2m6x5AWfpuq?=
 =?us-ascii?Q?xC7WxR64ptfE2gcpxzzAAFiJieCpUz0xg0Nsc8C1kKU/jypQjmIiMa0Nxdkg?=
 =?us-ascii?Q?4MXbpJRdsLcO/2auFXLM4pV5UoWdfz7YYDs84KAIxWlhCPTzwKl9G/NssbRW?=
 =?us-ascii?Q?AFzq9fOhu3GjPmAcSo5vBWBsqspy9CqYHdGvtW7He4Sa6QbgAT74/MpSAXyT?=
 =?us-ascii?Q?y2rflJhqv9opP5KC4nCY+s5fUtpXTuV26Ad1X2LGy9rALyPBIb3pA6gF5V85?=
 =?us-ascii?Q?/yHIFX12CTDHT+ihKPu+ihZ6qPWUSKeCrmXbYVtZj0bnKMAYm3qlCRkKW2G3?=
 =?us-ascii?Q?VZ0VoSyH6k3iMC2Wwvn2zdxxozRK8xIh6bMUoe/+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51b3fb6-347c-4805-1216-08ddc0b21da3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:35:39.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTRh/d8mAehVr3RftFc2yEv5/3bqUwdqn1mqi/yReaiHNA/zQlWNdySJdGL9DwI+gNESCW63iyhDa5sYjhfdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

Hi Danilo,

On Thu, Jul 10, 2025 at 09:45:44PM +0200, Danilo Krummrich wrote:
> Implement `dma_set_mask()`, `dma_set_coherent_mask()` and
> `dma_set_mask_and_coherent()` in the `dma::Device` trait.
> 
> Those methods are used to set up the device's DMA addressing
> capabilities.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

It looks good to me. A few high-level comments:

1. If we don't expect the concurrency issue for this in C code, why do we
expect it to happen in rust? 

2. Since the Rust code is wrapping around the C code, the data race is
happening entirely on the C side right? So can we just rely on KCSAN to catch
concurrency issues instead of marking the callers as unsafe? I feel the
unsafe { } really might make the driver code ugly.

3. Maybe we could document this issue than enforce it via unsafe? My concern
is wrapping unsafe { } makes the calling code ugly.

4. Are there other kernel APIs where Rust wraps potentially racy C code as
unsafe?

5. In theory, all rust bindings wrappers are unsafe and we do mark it around
the bindings call, right? But in this case, we're also making the calling
code of the unsafe caller as unsafe. C code is 'unsafe' obviously from Rust
PoV but I am not sure we worry about the internal implementation-unsafety of
the C code because then maybe most bindings wrappers would need to be unsafe,
not only these DMA ones.

thanks,

 - Joel


> ---
>  rust/helpers/dma.c |  5 +++
>  rust/kernel/dma.rs | 82 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 84 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> index df8b8a77355a..6e741c197242 100644
> --- a/rust/helpers/dma.c
> +++ b/rust/helpers/dma.c
> @@ -14,3 +14,8 @@ void rust_helper_dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
>  {
>  	dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
>  }
> +
> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
> +{
> +	return dma_set_mask_and_coherent(dev, mask);
> +}
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index f0af23d08e8d..4b27b8279941 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -6,9 +6,9 @@
>  
>  use crate::{
>      bindings, build_assert, device,
> -    device::Bound,
> +    device::{Bound, Core},
>      error::code::*,
> -    error::Result,
> +    error::{to_result, Result},
>      transmute::{AsBytes, FromBytes},
>      types::ARef,
>  };
> @@ -18,7 +18,83 @@
>  /// The [`dma::Device`](Device) trait should be implemented by bus specific device representations,
>  /// where the underlying bus is DMA capable, such as [`pci::Device`](::kernel::pci::Device) or
>  /// [`platform::Device`](::kernel::platform::Device).
> -pub trait Device: AsRef<device::Device<Core>> {}
> +pub trait Device: AsRef<device::Device<Core>> {
> +    /// Set up the device's DMA streaming addressing capabilities.
> +    ///
> +    /// This method is usually called once from `probe()` as soon as the device capabilities are
> +    /// known.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
> +    /// such as [`CoherentAllocation::alloc_attrs`].
> +    unsafe fn dma_set_mask(&self, mask: u64) -> Result {
> +        // SAFETY:
> +        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> +        // - The safety requirement of this function guarantees that there are no concurrent calls
> +        //   to DMA allocation and mapping primitives using this mask.
> +        to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask) })
> +    }
> +
> +    /// Set up the device's DMA coherent addressing capabilities.
> +    ///
> +    /// This method is usually called once from `probe()` as soon as the device capabilities are
> +    /// known.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
> +    /// such as [`CoherentAllocation::alloc_attrs`].
> +    unsafe fn dma_set_coherent_mask(&self, mask: u64) -> Result {
> +        // SAFETY:
> +        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> +        // - The safety requirement of this function guarantees that there are no concurrent calls
> +        //   to DMA allocation and mapping primitives using this mask.
> +        to_result(unsafe { bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask) })
> +    }
> +
> +    /// Set up the device's DMA addressing capabilities.
> +    ///
> +    /// This is a combination of [`Device::dma_set_mask`] and [`Device::dma_set_coherent_mask`].
> +    ///
> +    /// This method is usually called once from `probe()` as soon as the device capabilities are
> +    /// known.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
> +    /// such as [`CoherentAllocation::alloc_attrs`].
> +    unsafe fn dma_set_mask_and_coherent(&self, mask: u64) -> Result {
> +        // SAFETY:
> +        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> +        // - The safety requirement of this function guarantees that there are no concurrent calls
> +        //   to DMA allocation and mapping primitives using this mask.
> +        to_result(unsafe { bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask) })
> +    }
> +}
> +
> +/// Returns a bitmask with the lowest `n` bits set to `1`.
> +///
> +/// For `n` in `0..=64`, returns a mask with the lowest `n` bits set.
> +/// For `n > 64`, returns `u64::MAX` (all bits set).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::dma::dma_bit_mask;
> +///
> +/// assert_eq!(dma_bit_mask(0), 0);
> +/// assert_eq!(dma_bit_mask(1), 0b1);
> +/// assert_eq!(dma_bit_mask(64), u64::MAX);
> +/// assert_eq!(dma_bit_mask(100), u64::MAX); // Saturates at all bits set.
> +/// ```
> +pub const fn dma_bit_mask(n: usize) -> u64 {
> +    match n {
> +        0 => 0,
> +        1..=64 => u64::MAX >> (64 - n),
> +        _ => u64::MAX,
> +    }
> +}
>  
>  /// Possible attributes associated with a DMA mapping.
>  ///
> -- 
> 2.50.0
> 

