Return-Path: <linux-pci+bounces-19025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD349FC264
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9473116119F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACE1865FA;
	Tue, 24 Dec 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="h8vONGXR"
X-Original-To: linux-pci@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275E8BFF;
	Tue, 24 Dec 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735073492; cv=fail; b=n9s7JewsdJzUr8b2HLxhNqajLwhTnDtH5IWbJJz28H91Pz3PTF9P2orhuuvPde7PoynA91Y0WkglBjH5Evdm1NVxxvorqLEPVZRDXK775+2Cly16Xk3tRIFR4YUrhrT1UJluUPMCptskI5b2Xy28hd7bIisEpt9FMbZ1zsG8RpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735073492; c=relaxed/simple;
	bh=rZxg1xD0jhgxlwj9K1E895oY4ZtjTCarlB0mlE579PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwvEK1oqBPO8HrzzSWyceGLjklclS98MdBkd8vzptOxlhVIPqbX1i8Tr64ox6Yxb1repTO6tRWGxemoLBfRbfli4YJzGLAZB6ySnDIYLz1kcZS6NquJbRVrmgb4jEWT44psIBwGGZ8yxpPIT9fQp/eqhNdZNO9zA6SvsmqXymvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=h8vONGXR; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9XO7gY+xz0IVveZlIM0HO7EB5KL3ianhrd1oR8HxYdU0PnvQ7NfMIZf+W0WPL8rsfPLCQOfH0yNmrnQaVu2f4CbjJ43domEXi75l9htZ+x+u7tiPJjTA4Dfs4rA9FSc4jE0Z8m5m0FZFqHo31xIYFDYFBsX1HzyZl6Mn3e6UETE3J16l56Fi6Fh5/jCyT8IKeV8gY9NNUdJogEw3F/jrPG7tXS3i4cTSLFqbSCvjqgdSgFmOEuStDcp90nalFU2iO07A+rQGjNUX6cGgpysz+iJXQFXTgsbsIt9ItPzwILAs2DIBdaZyW+k2P+iIlmKjrIc19AfHGbiI/eDIY96tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeZQshWyCh1ztRWoIxg4DKLipur37/Ku4XQWFppXNYI=;
 b=Dk0BbIAN7inSYGiAcqXaVUTAMoSM5s7jlMTa6PrSh/d9K/dxCjZceRpJPCzFlfL7tCGiHF6CUVJ1j0AtXW3mVPCHREIoyTkWybmZ1GWNN+fdi/i8BLM3ZXnbjqWV10h2lSOyzDCNEed/UbAamKTMCkXhvzrvKEQZp/oA4V70884GT1Qun+4b+bDesB/eymvKhHdoeCaPk2OlWR0iSp9S+QjkDckBKiX57boPijKmzb+lM2jWkL+if86Hr/X2PQsmta9GuMpsjVUPaX44q3AWl8ep9YdOsFAfjiN55MakhRaRmegtD15i06wrOwgaIJEGAnhUpgz1vqu5ea+ansSyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeZQshWyCh1ztRWoIxg4DKLipur37/Ku4XQWFppXNYI=;
 b=h8vONGXRMuPDZDOtFpzuPWYH6gPSv4COI2GCfmnn/L+ZlVRdVF1J1A05MMkLuY5fp09P7EhE5gyl1AYNvH896+eLyuqRnM0wfBzAfc/drF4lhUFku1QXP0pLhrJXLPLe+dw5kjMiwEZ320GyFxjfCCyNEGtCjtGxjWxmUJBjaZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO0P265MB6421.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.22; Tue, 24 Dec
 2024 20:51:27 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 20:51:27 +0000
Date: Tue, 24 Dec 2024 20:51:24 +0000
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com,
 dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
 chrisi.schrefl@gmail.com, paulmck@kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v7 01/16] rust: module: add trait `ModuleMetadata`
Message-ID: <20241224205124.0f716b22.gary@garyguo.net>
In-Reply-To: <20241219170425.12036-2-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
	<20241219170425.12036-2-dakr@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0266.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::8) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO0P265MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cac18a-1eb3-40bf-bb56-08dd245cbc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZyPIkuXd3j5En5d1HStPkDD6N0LcOHKSpCax/xSuSW1xdmr74H3uC0BzhVX?=
 =?us-ascii?Q?s+b4+ZUVL8uIarh6fbm3d6T5dzYIJ81KN3umh8SYu78DPGvB4u6MPyZs7f3q?=
 =?us-ascii?Q?BDb1q+YsSRkoLwnmyrDV1ST+OZBXJXRxpOh3jdmlwarX0bPgas26HIP/PNiV?=
 =?us-ascii?Q?VZa/uzkRloG/GnjSBiM7q0OHSGD76Y46gvxQ8FfSWvPgyWAOfscb//oMXtYB?=
 =?us-ascii?Q?U3ka5MsuFOpEzY9YKpuIb74qXyMF8Eed1STc5DUA+L5r3BZpbSJju67CqkeN?=
 =?us-ascii?Q?oxs236GDBheaNQVKDJ+0+E1K+9BFzlVs1iKtYk942pMrhJossBZdu0cJ0IqB?=
 =?us-ascii?Q?lSok1cKUzyeWtPjW3O1SqEk3uBXy/lAN4IDe0VfOpVUOEPStZHnpbYzy2MFO?=
 =?us-ascii?Q?2pSHoQTZz2NXFIq2sK77usKBYyWvm4Cf6ruR6MEABotJZr4dMNzuyalpFPOs?=
 =?us-ascii?Q?w1b638M5Ek55XJmtkGMwF/jlY7WIjJkSWqCre0GWCMFXpa57yv6SoDh5AT1l?=
 =?us-ascii?Q?1z/XqwLHAL3KKIGfj1AcLROIfZVgD88ISR+CWsq5dLwlSuC4BWkNtM8/oJop?=
 =?us-ascii?Q?bNujiz2sfH11+wOEFq3nJvoMKR3OkJF2v/evsPRAAQVNTM4C1aYS2zpe15D5?=
 =?us-ascii?Q?8+AKvpzrU/qNB8D25+fyQlvElvF49Ls0+OdbC6IxOW6MVXfVPzmtMODxTRWz?=
 =?us-ascii?Q?M1e2fMjK5ZfZJr8sSQvQzLS+/3JAPqmFHXR15uNK4e9RlxUAuCqIhIKgun7p?=
 =?us-ascii?Q?PELXDiB/fvzi/dU1YkMn7ZpR9Ry5wcEDqJkkL18wprNYMZswmGzstV41sxep?=
 =?us-ascii?Q?mDXf202KbNiw8ZmiSsG+VHl5MINokVSCol1dXub8LtNSJ8qoALflwWleYLcy?=
 =?us-ascii?Q?n8/GF7z+ulIMSHl6AREX+QQlwlRD9swrb/XjSXozI/wN/S8k508WbIm1Ba1c?=
 =?us-ascii?Q?TAQGSWf1DBtUKjdNy8L3ubSO0yd8gZlWQBc8PJvqSdBuFUMjfHbLjBrSwTd6?=
 =?us-ascii?Q?fPUdqH2FiYLkGW/togq4Ldo2FPuVwRt/irNIhNfGuFc2h2CooE84rQoCF4+b?=
 =?us-ascii?Q?m0eYVP4n6BcqrylRQ/qTDXJ7nLgODqpZKc956wl0IUUK9wFTNN6/p5IoElq4?=
 =?us-ascii?Q?SKMZ87nx7JPo/PR8BjO8i2ZIclSBwXeTDD5N6Ozagk5ps72aPDcr0U66CDBd?=
 =?us-ascii?Q?RmDLNIour06pH2bJIkPyHpksINPxL0DlIxSmiAshEdOehvLxq/IaoUAxQGXN?=
 =?us-ascii?Q?LY+wuWrh9f3ObbaRx8jcY1kO5am0xMugqTiYlaVuiayusGHkZFVG4oq7W0uD?=
 =?us-ascii?Q?gYXFz6ZpD0laYkZp4443e2wGkPjJHsps7iYx9UdpnyhflNJhjMeMKEkiNjRE?=
 =?us-ascii?Q?hMe7hhPJXF98PKaO3JQKQJnfaery?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BF3XLiuQn+DjzytlIQrYPsMjXXuxWaUX3JFsEdeNK/wr7E+FqCOdvszp5Y6i?=
 =?us-ascii?Q?S5Asz9DE/+9VBKmNlk4ciDNqDR3def1OdgzwAtvQVdVK6pN+AZPveA0vs4N/?=
 =?us-ascii?Q?kiWDQUKunzIX9WSBZgrWDRj1b9qeyF0/nSP4yUWsk6Q6hBqQzco8F7svUulA?=
 =?us-ascii?Q?Qpvbix+1AijlwkmiPokkd61I7V1SAU2xvSy2C6Y5BVk5pu1+jfkT50LCYrXQ?=
 =?us-ascii?Q?zXoDTk3M9mBLA2cPWXmbS2cRl9HYgylD2+cLxR/sRPkAsrM2864zXvmkEH2D?=
 =?us-ascii?Q?Yal4uSxni/PjP1u9PcI60MXikmRu0y0QHoCvxnsxrbXGF9U2/ai9S0mRPYlx?=
 =?us-ascii?Q?7p0hecANfRu1WK7mt/sd67ZwXN85/21gwYwDYPVGz8mi6mfYTM8qu7jeeFIi?=
 =?us-ascii?Q?3OdnohtgC4zCvzoPZ33TjlOMJXfvMgV4RbxKX8mfH63vbaCXraDMGVrrTY/w?=
 =?us-ascii?Q?CXMVraGKHcdb0gXUY2s/j1AxGjhGUPW+kw+2htUh2KSAcrEB48PnNZb4NqmC?=
 =?us-ascii?Q?yFkk0ofZPzFlUUYem0o9wHTB4B7ez5qe6RQbG/PjJMQccaZZ/Db06z3GrXGK?=
 =?us-ascii?Q?p/NwzdFO0ROxv4hMlvgOEddWDt8mHocZ0Uzd8om+CoMU6rtV6nk1IW+uxHq7?=
 =?us-ascii?Q?S+Tq8b0sV7FTqgEBRlvAkAeIGVWBwmL7F6bBiF0cF0eHcxdq2oRSUqxkd1qN?=
 =?us-ascii?Q?TsEEVIZxpVeNxJmjNyGlnMSaUPKnS55C9Ae/d4X4jjrFymdWPJUBtVm0GRoB?=
 =?us-ascii?Q?AGVik6dzPCU8rVNg4VXKkRV0BYr5RWyV+YqDMr4iEfXjMUNY0Q3xi9rZvcNI?=
 =?us-ascii?Q?dJi4I2xXgisXBL03BOqf5ejyLDfQuXEz+giTZJOWg+2h1J7dvgthazFL5EpN?=
 =?us-ascii?Q?Y38gCmrbG186UqQMrKDgXv0rciizNJattMEZTwql0XczZkme62TPSxDZZR1f?=
 =?us-ascii?Q?nGmwd5Kqz9VavtUm03qX/+UGfsvLkCmAelwldkZrhQJHJWq4mVEBSxZwY3Pe?=
 =?us-ascii?Q?81vyxKqy70Mtr5+evagxq1+76Av9cOTc1DKIoOzJsBoZvGsbQPf+uUwGtpD0?=
 =?us-ascii?Q?teILe6OfLjT8GEibETK6LJSGVL4SS+0LDLFWyXCq36+KBfo0IcmPHsNpapes?=
 =?us-ascii?Q?FxgNkXd28Xg5KKSaGR+k4K+AYL4Rg4LiwuMhEn0PjNOhRX6nzRKYE7vLvuW5?=
 =?us-ascii?Q?n027W5y5xf7vdtR85NKnF40cQR21dBoX/DU4MgoV4szLcmF16dKJxs4gMi6T?=
 =?us-ascii?Q?BO5P491nRXWdmu4wTSrTbQCFgMVxyVxA/6nt1xzKaeUXkZi76jjf2g4zgnEn?=
 =?us-ascii?Q?H8x6EW7rBMTtbxjRAXHnmOHglx55gVGYDDU4SR/0MeLYn25xWCzKpicMQ3zu?=
 =?us-ascii?Q?T77PqSVuXnSvZdb0hnjN3TiXy3hyWkovGTplka0eRyO3Gqu3UA54vkSBADuQ?=
 =?us-ascii?Q?1+zbS9duTc47pZEuEW8j51KwbNpa32Tk/Cj4P986HgdvkaACTL8IUeO3EEBj?=
 =?us-ascii?Q?uxksGKYBotVoNHR5DVyJNdLL+0qnuftwI+il6SCD/OxkWfa0F2mmf+ifLVmv?=
 =?us-ascii?Q?QlHe+5bBqsEsv+rNnG6MTsX8T/aAAQi8eg8OZ/INO99wytsvS69t7oTunt7p?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cac18a-1eb3-40bf-bb56-08dd245cbc74
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 20:51:27.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxo2u33TFy+h9Mzn3F+bbmHizOKYW4ZlK2mXl/Ib4nvpzv02yYCO1oHHRx8GiLLOhueXfDwhI0PgAcyMex8l1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6421

On Thu, 19 Dec 2024 18:04:03 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> In order to access static metadata of a Rust kernel module, add the
> `ModuleMetadata` trait.
> 
> In particular, this trait provides the name of a Rust kernel module as
> specified by the `module!` macro.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/lib.rs    | 6 ++++++
>  rust/macros/module.rs | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e1065a7551a3..61b82b78b915 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -116,6 +116,12 @@ fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error> {
>      }
>  }
>  
> +/// Metadata attached to a [`Module`] or [`InPlaceModule`].
> +pub trait ModuleMetadata {
> +    /// The name of the module as specified in the `module!` macro.
> +    const NAME: &'static crate::str::CStr;
> +}
> +
>  /// Equivalent to `THIS_MODULE` in the C API.
>  ///
>  /// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 2587f41b0d39..cdf94f4982df 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -228,6 +228,10 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>                  kernel::ThisModule::from_ptr(core::ptr::null_mut())
>              }};
>  
> +            impl kernel::ModuleMetadata for {type_} {{
> +                const NAME: &'static kernel::str::CStr = kernel::c_str!(\"{name}\");
> +            }}
> +
>              // Double nested modules, since then nobody can access the public items inside.
>              mod __module_init {{
>                  mod __module_init {{


