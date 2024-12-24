Return-Path: <linux-pci+bounces-19023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC29FC207
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 21:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE7316579D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 20:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D868212B2D;
	Tue, 24 Dec 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KDGwl+pV"
X-Original-To: linux-pci@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020088.outbound.protection.outlook.com [52.101.195.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301361CCED2;
	Tue, 24 Dec 2024 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735071011; cv=fail; b=UpKLRzTkV3J+sEIB49B2A2J/It7AUze5vVI6joYdNbMKzFMVFbcgmOmzKGdAwPzke3RhX42IjMH9Mm/K+MK3cZZFD0VItJ4w/SfmRar54v8zlS8i2lL24j3cU3i5NNOKwc2kgadaDrnmmWo9wM8qUmip/gjKBAcrysMUyZZE+Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735071011; c=relaxed/simple;
	bh=S0hcSNL4qJCScxCkKBiOQKk8Gs+idfys92R23iUfWR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H51Y4V95pJLrnvOKAXq8W1IAA2mwBz/H2GGMibJIyrLMMQfxsrXGC2Cofp1ngk7bbrZD8qD9OwNxtvAywMJWZN9n/hmWBBuygUPMS3MUU7fkKfYlGWbJcX8K1+bwtbT7Rh04fNYp1VuE1N2T7b75AepzHyar2gkQNLatnRZ9xcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KDGwl+pV; arc=fail smtp.client-ip=52.101.195.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLbGAT1+2nMjF8xjauJb/VoPYqDxlfc7VX7DdBoEOycHFsTxmBd+QLeRCDbo4e7r8Pb7q8ziyaquXXBujRO7jixxlSSNzgEnL3YY8TShRxy/rjFi2LAhqRklzSaElYPeJcnrRXA9T/RCgS9xVh5p0nB3A5SfPUsZJ/RhwVMyyjDvDOAvQmnN0tNnNKff0xMe4CrUQOW2EbpcvRpRnAfmLM78v0Ja9LnQGiwLCqJADpMAia1q2gr3K+lwnSK8+zl9l0/FiAvaa42jmhmmvq9B2+59+Vyfpr7YmxUnsKg9TPKa4WX/QFksxbxQC1J2XPPAZ3xEEVpMYD2WC+xcWRYhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKJRqD1+eNY/LWOR9X1jPMGVv0oW+nFX2yRU/+dPPFk=;
 b=Ku8yJJ7EuHaK780PQLKJHN3L7k81v7gSHcQTlrp1cvwUY+XDpNmxEkxnciBZT3s5Ek0ohih8uF5kNCEZhrJESZ/7gyvJ9G7Y1r0tnuNt7q6hujSq0yiKGUOu/dY76F1dL1Cmzltw9O5X0YLT959eJYzCE13qH2Y/MNJjPOpxiMyAXB1BbJpfanMyPn7MccFeHI0IAS4iSRVU95spXv5zmqRszkSTj6N+EFnAosJE5sXsXg22QICd6XQDnh1AjQqprz/k3Nj9GlbPXbB9yO14ntWeMTe+gXttbrN2LFNP+efWwqukwOD7FC0ylN4me78EUok5WkdJARRvC4M3w6jNJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKJRqD1+eNY/LWOR9X1jPMGVv0oW+nFX2yRU/+dPPFk=;
 b=KDGwl+pVhclrfhSFtv4Gtn7Ka/R2EZc4a79Rbpo41MiNkT/tUDlo9gItsUl45DHSzlAQIbUAFBtRnl8dCTYHXsua5KvTMVXyFlgDxyK8k0K9g94EsByYXGVNEwVi1lLo243js2gmkQTPyf1PFivCNyCeZKJNHS82Wg5ubYX5hJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by CWLP265MB5524.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 20:10:06 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 20:10:05 +0000
Date: Tue, 24 Dec 2024 20:10:02 +0000
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
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 03/16] rust: implement `IdArray`, `IdTable` and
 `RawDeviceId`
Message-ID: <20241224201002.6a69c77c.gary@garyguo.net>
In-Reply-To: <20241219170425.12036-4-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
	<20241219170425.12036-4-dakr@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|CWLP265MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 8004beb4-69b5-4430-3e02-08dd2456f54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QgVkS+Pn47tSiXEktA5qzwmclZVV2w1TGf8ePIkVU7kjYRkaSQ0a+7Iaj9+Z?=
 =?us-ascii?Q?2FBhGniaqBmXSCuk+vEOzIMlppeToZPtotqR6Qz7iJPjXDPS7sThoaxyQ1Mn?=
 =?us-ascii?Q?WBCg0T90fzMAPxtxR9/UxID1oIZh4hXQTCrMZwhRPA3HVOWkfWSEeHzO2qeg?=
 =?us-ascii?Q?nY9XsaxOeuFlsK/Vqszwz3T2tkQ67SMLCL4b6CWdn2H1z1WTsqphb1XSApH/?=
 =?us-ascii?Q?pgWP6hS5U7lq3bH8tJrVZ81XYbEzxe++reCTj1JCP14CHO3CtqJ3WqHhAqkF?=
 =?us-ascii?Q?h7IzdaF/WfH4i3rLzwQmPzoZxb8ztJB5PmWxlNxo67euIMECrIi6p0u0ngfh?=
 =?us-ascii?Q?6nPfHYz42wi7aEsE9d/WJLzsLf6450QlqcPy9WpRMv+FiZzKcW/qC2ruC2zY?=
 =?us-ascii?Q?8Fy9pUaSES/ORug1IuUO/nu1N9cnnisUzQwAnLxmXM4z7MCGs6SZiNnka3ZI?=
 =?us-ascii?Q?eqyEWM4xwtXuAOriWXVlI1NNgub7ne92y+2PkfF3D5+8XDnQHHkbVkMYMEL8?=
 =?us-ascii?Q?InGllrQ9AP/hvtiUWrRqzeLLE3JKe9EAW2E41fh8vv909R/+MEZV6pVE1Lk0?=
 =?us-ascii?Q?mWHDtOSWuyWpaE/vAvxYo6daHTdzaseluORcD1pZIwNxn/3v8ZWp4Ysvboun?=
 =?us-ascii?Q?j6sIASktG1pA2cGjMq+jJyq/uAZ64uv71IZbqFRxcnJ+bnjfN1Hn6MNR7a37?=
 =?us-ascii?Q?gOx60dRdyM6LIlkYqMEbWvSmdhAqaamrvJ6WWfJ4Qm1Pzuk5SuBQazEoBE0u?=
 =?us-ascii?Q?7ilgYyen9snEi7RNhnNpcqr1/kjhkuPqJ8q1s1+eOVHiD7ZDFj2EAF4WArkF?=
 =?us-ascii?Q?aBpSV7yGQkqGv5TSZeDMr0cYiFvlj0Ouij+teC9ZY8Z8nXC07xFjHMtI0MVb?=
 =?us-ascii?Q?2CVd8eFY8yXXtMu+/qAxra7AtcffEL2YrAAXP15Os00t39cTgA7S+PmMd2yZ?=
 =?us-ascii?Q?CrW1a8I9BwLleJi0xmwhsWrdF0JJm7P2MLWfx4guc2lhmnRarYJCU+UQbe3I?=
 =?us-ascii?Q?7Jeu9ToNXpc972QoH1MGgh6ghrEWOFElDbUYstIdX+HGeyLSq0+InWSvgfH3?=
 =?us-ascii?Q?6bmqAMWj3L4XAiLkzJ1AWvPp5Qo80FgRdpPBmjjywr+g8oPNp2XXjfNOAcA3?=
 =?us-ascii?Q?0kb/1KPvBxhmpLiSgJuOPMWeiKzr9tgEe4PfdpW578ZcPiSehmXSscqpIRHf?=
 =?us-ascii?Q?l9emPXlkmoUSnloLNiRJEUMQP2CTOxnIPPOR7cGmX6O2nWg083nF+Sr+9fi5?=
 =?us-ascii?Q?uNjphbQzJpvEcM/fEAo8nEGI2GJY0QgSzOp6g9XRusmaWTBleL4THmqMU12l?=
 =?us-ascii?Q?gV2JtYRgxlUxNTmXhFcLygwqp/Eg92u99ehNRrkFLQNOLH66xnape5PO36Lz?=
 =?us-ascii?Q?TpSk7Pkp2+9sSBPEzq6fDv9GDnou?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CamSSJg8TXrD8rDH7s72YJ95LkKD2xmfjMPATmSnN0hCWOMxSy1MCeXbAh/?=
 =?us-ascii?Q?mdbR5b0yXtupIQjoN1XOQ4aqe9hj/mYNwzhDkRb6vQs5mi/rn6vI1kb+aJ2j?=
 =?us-ascii?Q?JnUiMEYBudG2NpXq5hUE6QmaYGtCHN0f+eASour5bPtPQXXfmAwjBYeNZGDJ?=
 =?us-ascii?Q?MMxDhGb1z0w4/JVHhq9kgSVu0HAHQBXTN8c4jhMk1eHvgZDucNG6LXuDJFFR?=
 =?us-ascii?Q?0NI+p69xu7iza5Oat8CIBH5rY033SGWoe6e/EMnJFh0W2LvxBAou71395pbL?=
 =?us-ascii?Q?CY/F8g3cEwBLIt06NMr+qga0Jme3k+iwJ6c2ZXGweSIP3iVl8E1s/UA/U5Cp?=
 =?us-ascii?Q?VnE4VO5UAe6tetqf8NQxDXuFvyNO2xFf78+rqlcx4DK612zqyj/sGEKO2Vpc?=
 =?us-ascii?Q?hOwm2e8zgESTSf+fIIB+WmyMupj4MhnqAS2Y8zwFBULdKpWP+CgoK1T3pS6P?=
 =?us-ascii?Q?AemuEI6JSqTMuuunwF/rEtklmlnYcFbn3MSjnU1ubstL/tUuumdo903QSh94?=
 =?us-ascii?Q?btbCB63cHmVZaDc/s0aR8xuDxAaYVxK2ew3X92U2WM7xiNWSfzTFeBUcNkBM?=
 =?us-ascii?Q?ZneQIRBRmDE/Hn8P20wPzdtAFSJTjOQ6PTvMNfxm4cbvQzMPnK8jLXbwLqJe?=
 =?us-ascii?Q?6OqwA1fV5dG92sLc9Ewswa8DXmDDoaJTCOFHDZ/6qdpzZgwiBdRJi4iKDbLL?=
 =?us-ascii?Q?uFbgp7PIqZ+s1J6mGXTGBaB1rNTJfs7iD6NfSVj1aBOt6A8sUkk9KpSILaBe?=
 =?us-ascii?Q?PP0NAS89jSrTl9GEPh/wqQiA8/wW/4R8YoUF/sdoyF5flvAH2PVCicpjifXo?=
 =?us-ascii?Q?sTQiv36WKAqCvEI+OGD4PrODVhYsFwqmNgNR8S3OzzrR5EDV3xJ3YnsNx2lN?=
 =?us-ascii?Q?hBiGqR9wGeFmIW7qmsUNDPgBhzNJsjT4PCDjGF2y3zm1K7M9Hgr4Gv2N0v/V?=
 =?us-ascii?Q?tsSbTbTQhigTC+0TuH7o3TXDfcCwl5TwkexfYXdRwAtuTZ/+rZSdAyvgpujz?=
 =?us-ascii?Q?QsYnMruD/kFI8sKn/6t8XCd7sxFt+YpAlo1UziELjYCr1vYpncoiXGNrfMJT?=
 =?us-ascii?Q?sooBa8RVHtLCnlL+isbIHVIeYSyF4DOpiHY8nMpgB81IjY8aRmgQEWlwZQJF?=
 =?us-ascii?Q?gQusfGiKTFLwWFDqX7BVmEuQv0v9X0FLA+D64q8Gk0oZN+a7y1jxHlj9B2Lb?=
 =?us-ascii?Q?i1xCOEmciBRoA3Km0NUFXZrJjXmHkY+dMoS1Rl3CAo5BtzOIqdmSPGYsE6L4?=
 =?us-ascii?Q?e2zHnL64iY9YevDMKYx7RotEvQSXznlITXpe5NGXWt2DzMhDYoyveVWn4X3s?=
 =?us-ascii?Q?x26+RvY1W/Tg5aFSnz6PXY2MlgZsWWcjAjHPXjmt09fhmT5p58cmBH69PQOU?=
 =?us-ascii?Q?g6Rq5QupWaAEznSMkEAgerSh/VxZVmDVhpcH9ZKcN5AS+1E5twGtRTg/ni9f?=
 =?us-ascii?Q?cXVLi5ien5KXayqBUjS03d6RM39maAsp6FZ5WdiAa31OEm5Tp0rmkfEzktkz?=
 =?us-ascii?Q?NCUrw+x09ZvOexHp7XRxPihcq9mvIFGURS1qq1n1ag+KT8cSDPLjFgTDawUf?=
 =?us-ascii?Q?LKR1fxOP8ITUmu0vkK9g1infUwNbcY585TNszPoHNnLIofbtZx9n4VvAqbEt?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8004beb4-69b5-4430-3e02-08dd2456f54e
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 20:10:05.9082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6XjiVHFm3/t+07DIbmF2fQUAXhnskDgEDe9amY8wzbKclLlbwEhBoR77dQCow5Xua0u2zrZPPa8piWGkkQSlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5524

On Thu, 19 Dec 2024 18:04:05 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> Most subsystems use some kind of ID to match devices and drivers. Hence,
> we have to provide Rust drivers an abstraction to register an ID table
> for the driver to match.
> 
> Generally, those IDs are subsystem specific and hence need to be
> implemented by the corresponding subsystem. However, the `IdArray`,
> `IdTable` and `RawDeviceId` types provide a generalized implementation
> that makes the life of subsystems easier to do so.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Fabien Parent <fabien.parent@linaro.org>
> Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thank you for converting my prototype to a working patch. There's a nit below.

> ---
>  MAINTAINERS              |   1 +
>  rust/kernel/device_id.rs | 165 +++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs       |   6 ++
>  3 files changed, 172 insertions(+)
>  create mode 100644 rust/kernel/device_id.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ad58ed40079..3cfb68650347 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7033,6 +7033,7 @@ F:	include/linux/kobj*
>  F:	include/linux/property.h
>  F:	lib/kobj*
>  F:	rust/kernel/device.rs
> +F:	rust/kernel/device_id.rs
>  F:	rust/kernel/driver.rs
>  
>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> new file mode 100644
> index 000000000000..e5859217a579
> --- /dev/null
> +++ b/rust/kernel/device_id.rs
> 
> <snip>
>
> +
> +impl<T: RawDeviceId, const N: usize> RawIdArray<T, N> {
> +    #[doc(hidden)]
> +    pub const fn size(&self) -> usize {
> +        core::mem::size_of::<Self>()
> +    }
> +}
> +

This is not necessary, see below.

> <snip>
>
> +
> +/// Create device table alias for modpost.
> +#[macro_export]
> +macro_rules! module_device_table {
> +    ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
> +        #[rustfmt::skip]
> +        #[export_name =
> +            concat!("__mod_device_table__", $table_type,
> +                    "__", module_path!(),
> +                    "_", line!(),
> +                    "_", stringify!($table_name))
> +        ]
> +        static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
> +            unsafe { core::mem::transmute_copy($table_name.raw_ids()) };

const_size_of_val will be stable in Rust 1.85, so we can start using the
feature and 

static $module_table_name: [core::mem::MaybeUninit<u8>; core::mem::size_of_val($table_name.raw_ids())] =
    unsafe { core::mem::transmute_copy($table_name.raw_ids()) };

should work.

> +    };
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7818407f9aac..66149ac5c0c9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -18,6 +18,11 @@
>  #![feature(inline_const)]
>  #![feature(lint_reasons)]
>  #![feature(unsize)]
> +// Stable in Rust 1.83
> +#![feature(const_maybe_uninit_as_mut_ptr)]
> +#![feature(const_mut_refs)]
> +#![feature(const_ptr_write)]
> +#![feature(const_refs_to_cell)]
>  
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
> @@ -35,6 +40,7 @@
>  mod build_assert;
>  pub mod cred;
>  pub mod device;
> +pub mod device_id;
>  pub mod driver;
>  pub mod error;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]


