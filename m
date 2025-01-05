Return-Path: <linux-pci+bounces-19318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC451A01B69
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5544D3A31B6
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E161C5F11;
	Sun,  5 Jan 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kee/rKqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022093.outbound.protection.outlook.com [52.101.96.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED40F1C3021;
	Sun,  5 Jan 2025 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736104054; cv=fail; b=ePHcLXs5IYQ/jZQVq5HU7hmwqNYcxFA/ZPiMfDTzN7laNzV9k9FBcSbj8iSIlTRWzwGtQoHcBlCclfcg6Cuxo+t0QvTF2O0RV7nefpXIZh1s9f2SPiKYPI2QdZw7Fl1coV308Za47sDNhRPaLlDvD302XkrcvKLZc9nTZwy2mE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736104054; c=relaxed/simple;
	bh=vpwNskXRTyiEY8F5ipKYWlKcjeuvmDVO4tyxMPCvU0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWM4019+ImHRKoVU8UHYgj0gBkqQ4gu+wrTt93Ls6Mp+bU1O9p5HfhnyqOBLdWTHBpi3vSRR0GTI+5wK+9PvLl9lcrGaqPQO/eAHc9AVrc/2wdeAQLoN4ES4qZafdN6QC7JESY78dpFGl7skJyABPvzwmjdD8vvB7O7FG2phPj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kee/rKqw; arc=fail smtp.client-ip=52.101.96.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z06kTZ9bsIj/CtOpA9nvruMVXvrQO2s0IudLIo0lzqQhOCgneNG+GF97yNCNXpC7o5pgTYfeoXloVV6df55G62g31vHMRdjWiCZ2f+HudGzXepEKjI5z5NiDYyH1ZmPtswVymoA97A8ZIO86M3zqCUSQSyXBL+EN96Kq/loCk9L8NzQsneRBsPmPqAwhlOM4TUTGSMm1k4LmLy0c+Fje2gC4ceGhc0cTa5X9uUMK3bekjkBzxqcLB/pjpxPE1879z2MRJbvFmvxLPkfuHYjHViyP8nZs2B54+49K0i2lZx7ec+Z+W6O4nqgIIaDpCfblTytELN1MB1MX/0ICjeZeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6uhuZycnT5/D50xIkhLwPdqS1DFLTgLHmsagwu5Cvg=;
 b=pmCqmStXhzeOxgUQ1MmPXk/QqYtz5ssdZx4tE26e4EbdHat356hcjZbmezlSFMzzIHYVhPyQECA7ALRi0haUGLn9K2leepQwRN1D0vGCfgo9BHLMEcPkv9GeE1+ti9liJVf3SijVIL5KaV71PlKnzpObQ3KRo3DmJAjsqzlJZKSpj6OTVmXeC92+1VsPAg0FaJiZPGgAKA3PDXNETsRJUgKLvTEAL3gOnVdvlr0UfYfR0uu3yM4R2FgXPCzughzOEWqX/HxF8cUwiPHhjWsFDb6HP9pNCUSeARG9v375CLLe2D2Voskc25zPkDJ9hbBJATbJ/tP6uFLLYQnjUYR0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6uhuZycnT5/D50xIkhLwPdqS1DFLTgLHmsagwu5Cvg=;
 b=kee/rKqwjc+eRAjbLEOKzYOi7bi/AK9zgLi1Vi1xfB0lT/DURLwZFDr9LxwAqzzCQTA5kcMBAsnBvgNbihf2SSmEAzoTqv1kKpM1Jic8Y0zT7UiPJUF04BPefV1EJe77VxpiXCcNj+e9cf+MleWMCZtlagZGkbHZpy4bTdZ2XJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO7P265MB7696.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Sun, 5 Jan
 2025 19:07:30 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 19:07:30 +0000
Date: Sun, 5 Jan 2025 19:07:26 +0000
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, bhelgaas@google.com, fujita.tomonori@gmail.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: driver: address soundness issue in
 `RegistrationOps`
Message-ID: <20250105190726.30a9131f.gary@garyguo.net>
In-Reply-To: <20250103164655.96590-4-dakr@kernel.org>
References: <20250103164655.96590-1-dakr@kernel.org>
	<20250103164655.96590-4-dakr@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0349.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::25) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO7P265MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c86da21-4f16-4a3e-5240-08dd2dbc33ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MiaZKp8Gxb7RLdKpB9diHTrJtfS/XTWTZXeFU5fj70iarhg9hKopZcIcZW7y?=
 =?us-ascii?Q?qGBPcNM5wH0hxFpMBg3e6rRzGFpE65cFY1P4jhRKa/C49zCbtMbVwoG5N5X3?=
 =?us-ascii?Q?FPFDCIAHkhDDBKFtBJITKpym0lV7ODsGdV07wjD8cAkvN4yP086L6bWPEIYC?=
 =?us-ascii?Q?8zwk9quE5PG4cACMB1is2uGTEAtSsqMB1JvFAAdHEI+A+GTKF2ymbh9R7EsK?=
 =?us-ascii?Q?W3KGlrzFNp15oe5HTFv0f9ssxGPT9S2KW1FfUkGTiEmZ1ZutwYlHIeLqo6QY?=
 =?us-ascii?Q?VpSkoNzpxPPsgeUWS/s5+IlE/CqlFOscbhEiE5A24U2k6zAyBQd6bv++w7Ly?=
 =?us-ascii?Q?tAJmTc8Mws1AfrqomOztsH7/da1gi+6hYblxOqcZOVe6+qv77BHIk+LllEq7?=
 =?us-ascii?Q?GTtZa2o9RHS0F8vwdcq3G4XAjIXLlqNt5G6MS+Csh+n4cw1FDsIk53TeBx/Q?=
 =?us-ascii?Q?vjxMCPX3vSwY39pXpb6CQvu1EnsUEQaMAejXj6BgLXA46jyjvhfEnYKKNuHi?=
 =?us-ascii?Q?VFNrPwMhaNuRMeeFhAblQck8G3bPRY5V/KfOGZdZVRR13YInsKpWWkRgGi7D?=
 =?us-ascii?Q?/ktppvI5LDEiLAze7XVmF1/PBHhjkciHugiPISrJwEQa5UlpVI5EnQukuxRw?=
 =?us-ascii?Q?CN91xWrDpjHP+MrUQregJniaoCl3KTjezWFh1/ky/p/9XQnUWB7vUI0IJEh/?=
 =?us-ascii?Q?R3KCr9uuXHI3SWM6Ri4bjZ9Uylql2QSRT9d5lQFTFBn/dcENJMUOtcE6y3qB?=
 =?us-ascii?Q?PitF4tDoYhVQQXSMaFqEvyV73S31a+hfJqO+Uy1/b+cQYcGM6MQXXt8r4YFE?=
 =?us-ascii?Q?g4xPQKQ6ygGB3LEJ9/m3fEfa5Nj1dIOGeEhp9WrEJNiXNnlB0UYZJdPrO3dD?=
 =?us-ascii?Q?VzdGGNSQLqveVIidvkIOOR9mJqGc/k5odRgEjwPAG5Rf/Kd9svJhshFpwji7?=
 =?us-ascii?Q?jGCB5lGcxxGDyLTy6bAYahUaGkufb52g77iM6W8qciBA23ag1xPPehKrMyr+?=
 =?us-ascii?Q?bsikJ3gwUc1wMlhC8npFTq16/DeFd4uM4H+XdGg5AIRmktWYUmhGjZvWwgY/?=
 =?us-ascii?Q?zWcPHfeEcEol+sZpB9WhI6RxHT1kWu6sRvS4fOrFic6bDucca31OEfj1fHdx?=
 =?us-ascii?Q?X6DDnoZefbOQqrs/ylGyYfRN03zWgAWf1/cYmA6+pShswLMtVpuAlfD92Hpj?=
 =?us-ascii?Q?vgdywSEX8Qxo3c7dAjNNIM602XF81/SeSWiBtPCDtBazpSrMSIrxu7qj7OKS?=
 =?us-ascii?Q?SjBSXptwJd/3mZeo3si5JZqJTSNglfsohZIvVz0yW3S5HQ9vjrEUMKDTYE5g?=
 =?us-ascii?Q?eSqzEIAlfOFP3SFkPMYgXzIk+XuVEJKjut3wdXdoUJCJf375LHnYphTyPjW4?=
 =?us-ascii?Q?BelNAulRpSRvP9XooFLQWzNG1iPA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UF5K6qrPnAa9WIV0CmVsh6xZeOSmyUnOvZVrNFjaAA7TIlO3R1DJLcI9Tk4f?=
 =?us-ascii?Q?/iT4yAeilsM9qrsFQIx1V0KWrluq2k3zb/YMjxLzwXYYT+S8ibMnYQFK/uSR?=
 =?us-ascii?Q?wWzdTwxt+p/M83poi1URcQ+4NIXColeIGBF9G26tMjLvh1jQchnlHL1KNPd7?=
 =?us-ascii?Q?TlMnomdbDJHUEC2uSxwj8SB6pQ9rxa1GUe0vSp0nyJtF8G0JsTv6N77aUICY?=
 =?us-ascii?Q?lFlSypHBlLFHvTnxe0RXpNkqdIJXVt7yXa8BcRuO7Dm/uL/CFt06qphP/rSf?=
 =?us-ascii?Q?NY9Gl1z2ABXWReY6lhnAEGtRoycP2h0CVmL3aQw8+nPunOIYTUJLHJHjEZBd?=
 =?us-ascii?Q?QenYIPDV9wL424du2z980ZN2A4oZa71lnG3y+xMPQSPbid7YK9/vQPQ/XKSf?=
 =?us-ascii?Q?vQHz5c33aHrnGsGUxuoKPcel8LA6y+NMBDlNw1IY/f4dhug8Kmv5WNr/9k00?=
 =?us-ascii?Q?yMLQ73WcyV6r4LKAy594b9neebGedNzwU7bcxNeJeOzQgLdqIAbjWGeP/qno?=
 =?us-ascii?Q?rQV2ODGFcFhREhYXoqkCYJnGJhjNDWq2umWkVIT92mhrZqVe08EN8ZU0wU30?=
 =?us-ascii?Q?o9mSNFCTY8U5qwoscYfJdwlmUeEgGFq2qE3GhPUoUYyWHFRFInIv01WkBPOl?=
 =?us-ascii?Q?1ymwhyT0dX0qXKMP1n8B+CJoZfkcXGj8omDf2+bB/IzM3LUx9KlYMJFpN55Q?=
 =?us-ascii?Q?9DmFenTgDeFJJLPTBOaA67XPShSHOzHtbPudHC/a8fB2k40dEPFMkkE+ph3s?=
 =?us-ascii?Q?24QzsEHl90HNvTejxWf84mm5O2VU93BdAMsVTKEr1WZlGMLYvKxfE/WfRr7X?=
 =?us-ascii?Q?fdaLYaGXkRQ3fdS0ZpIr6WiqfW/iSMY+ACvJNZV3Gf4z++kV33WDk1Foq0hH?=
 =?us-ascii?Q?h1kCe2R5kdyMxlfQNTMASYGMKM7TIONA6w3ZAudgqlJUcIbnWs/ADiJeDXn9?=
 =?us-ascii?Q?1tv54czeeYZ37mlzMNLeDdOnERw9F6G1qhGxjp0jgTgpFnFLvKVDUv5mHN62?=
 =?us-ascii?Q?OtqeVPj/JH+yXnhy48Gmv2OXkd6xHq06PlU7w4Ic3OEHjcUjvZWd/km9RsJX?=
 =?us-ascii?Q?dm+fpi29oXg+4aqhjD17hM5aC2HUTxKhcUQp+xjQZrF92y6aH1LR+noz2uua?=
 =?us-ascii?Q?5FMZGsQqmO2LPbz0Zz7n6Dyeot86zLCXue9rlMZe1EgCfGeVuvAdOdlJdykQ?=
 =?us-ascii?Q?DIvGNNQVxUm3mCZEyekd2mO6nEjn0PngGdpQ5TxKHSZVo41E80FaJpfvf+Ok?=
 =?us-ascii?Q?J9JsohO2YWDJEh5zYqdX9n/6kBlV6DRRxsw9roAzoOKWTo41LKHnyaBRXn4x?=
 =?us-ascii?Q?5nx2BixMwH7gpTDgUntxD7EUSfdIAlOyqg7nm0fkjshGJABq1by2TRYUAAHX?=
 =?us-ascii?Q?WPIAGHcD8TXeYo8FUgZDtMVGxdd+31n/PS3EWSVV26gDhheIGuc7DVjRrfiB?=
 =?us-ascii?Q?YjX3ulyz8ElehPcYtPFtJB/xAP7pQ1DNy+g2A1/d8+kO6Rf4+z9cYz094DGs?=
 =?us-ascii?Q?9HNkj+Gt8kl0qX8QbwpgpTfjDCYAvFV3+Kbo5xiihTyEJiFOLd5gz792Srny?=
 =?us-ascii?Q?4nKqAkU7ESZIvcsouDjeJKsfW8Hu554fCnvHrTrNriGUEjZ2C8yQOVfr1mxE?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c86da21-4f16-4a3e-5240-08dd2dbc33ac
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 19:07:30.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7vypS4T13VL5eDEP2xJb+A6pVWy1pWr60kowpKJC6+UyXSAK/rMiJCzdw2lPc4ckriB6nmhOu4U9JCB9/JKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7696

On Fri,  3 Jan 2025 17:46:03 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> The `RegistrationOps` trait holds some obligations to the caller and
> implementers. While being documented, the trait and the corresponding
> functions haven't been marked as unsafe.
> 
> Hence, markt the trait and functions unsafe and add the corresponding
> safety comments.

nit: markt -> mark

> 
> This patch does not include any fuctional changes.
> 
> Reported-by: Gary Guo <gary@garyguo.net>
> Closes: https://lore.kernel.org/rust-for-linux/20241224195821.3b43302b.gary@garyguo.net/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/driver.rs   | 25 ++++++++++++++++++++-----
>  rust/kernel/pci.rs      |  8 +++++---
>  rust/kernel/platform.rs |  8 +++++---
>  3 files changed, 30 insertions(+), 11 deletions(-)

