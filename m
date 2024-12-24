Return-Path: <linux-pci+bounces-19022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B278C9FC1D0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 20:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A99188382B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C31D90AC;
	Tue, 24 Dec 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="csQRfCTf"
X-Original-To: linux-pci@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020107.outbound.protection.outlook.com [52.101.195.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5841212D93;
	Tue, 24 Dec 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735070329; cv=fail; b=CFHDLVGV5w+Qtr3+sLq71FzDhS5qpJpUUtzs+9TUDs/XZZxBeSAsvHh9quZNPt7zozPPzc7/ZP6b6eZeA1mr/mxeHKHhpefI12Jp0ZHs0UKF2khS+qBj8f3J/BXyqxjvaaDGKKB8R9JtZ8mQYPvVfBma8G8poGwC3eH9FhQcPAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735070329; c=relaxed/simple;
	bh=JpIof5dppT0GY9tT7KcABdixCBrZBrDGczIJ7hNtd4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AKeEgXrhVac6NHpJ0yeiXwdLvYGydhgfRyMnbbwh1rxPv1Xt+NN1FsEUrPglJMCHZW8fmaCxF0V/++XDoMKdDQq/kO1AGIGcJr2Wl9oGVh+zAdSUvn21NOKVlmdlUb8JW7M8yIg9aYePmLd66Oxw6HOhdEAfjsl3SlF9V4DvhoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=csQRfCTf; arc=fail smtp.client-ip=52.101.195.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9k+XNGXHMGUahJASlQiCvN9bI3yoocTyG0ZOJViIpW5O1fL9Fgfp8YIHZLmSxfFAqQpUsFN8Dp5IPZreuFHM/ULGGH02LUOdpD4ZjF0Ha3UgVk/33owJmfNVrXG0eUGzh9DjZvp46xNUws0wR06zMcTGaZbTXDYoF2E0cCNLi+qywYYbUsj+iUbKfQCcY4Kjp6kJrnTVRCK6IT4hwVn3lhRZgEZbr0w5TJvO2b/A2lTktgWJ+0SR6hXkC2cvRLl9vvYz1qS0FaKXfdvR0j0lEnzq2U6DtvQTOAmoW73R4AvKpAz88Sz2xtuYSub1YxKZmx4LplbI/0pfsm7ZIuLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6Zt8u+c0uFKdJIh7lRdRX1p8fQlpIjzKh1ofYo1W88=;
 b=AbUJc5jAQ67DD97cWtVM3TKdouIDM4GhtNaZhBps93JSFtfolN0by+vphqJPKP0eMxf8sjd7AICkB9Kde5BgbIsRagw1kosJ2L5tU4SCVJxFPOaZGn//KbMRexVlRufFDsKE5a0obpJvxk+PSXhqD7q2+so/laGsFfPhKghs6loybNrJXGadrD+Ibd4PGPX0r455c8T0hyKXDYyiwQ57Lmkn5qa0qi1/XOj4HI0Vx2u+O45ChEig5i+0+RhudNL60dopEKFq93UGT+qo17LUzBF/bep5ZBIN79SoUzZQlR78R64iHwcki8kBQcxxGD0db8eF8CpGeQvvhDUhMJXEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6Zt8u+c0uFKdJIh7lRdRX1p8fQlpIjzKh1ofYo1W88=;
 b=csQRfCTfiQmqtaG90eWSRAmt/EYmUE+y8vpB5bdjYN09oTrWHSRK6OpWdw/eKjEHv5gQUnZGzA4oBVmA5zDFNjy2jwLwtrfmlWLiMy0/SOCrFyjODyMy644SsLm98sTRP7JlxPY2aNL9HuTvDqHl73t/++PL/4AYv9x/a0dGntg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO6P265MB7002.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:322::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 19:58:43 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 19:58:43 +0000
Date: Tue, 24 Dec 2024 19:58:21 +0000
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
Subject: Re: [PATCH v7 02/16] rust: implement generic driver registration
Message-ID: <20241224195821.3b43302b.gary@garyguo.net>
In-Reply-To: <20241219170425.12036-3-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
	<20241219170425.12036-3-dakr@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CT2P275CA0001.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:b::13) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO6P265MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7f4e6e-aff9-494a-c0f3-08dd24555e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hstJlWVVTbvMNLTpCpFQx7Ts6ypsWDVKNWh9gXSHZOY5lnZxv5VagbBMVijp?=
 =?us-ascii?Q?cJxnwZjLPm38aaASACsVBArnx7UZVOhZK9Gu4WzTrc6GlQyIOnwmQnn4D1O1?=
 =?us-ascii?Q?J13Bm8+EozF+ve+GAik6hNwFu6EprLAQc22MYe8qvM0UTmVTLFUKFlkNSjT4?=
 =?us-ascii?Q?9o/0fQJR9+ReWBJNsTx7BPyRxrj6DfiMzveu2NbraW+cmP+l9IHSMG8ypC9m?=
 =?us-ascii?Q?JMIbp5oN0x3am2lmWWSfSAiEDAOjiwbvpisowmDWyvzvnYfshjAE6b/UVwKS?=
 =?us-ascii?Q?Dgq1eHIiX9MsjsgHVcZJyo5WRdPICPcQjzlOi62BTbmxjJCDqlPciSTNkIS4?=
 =?us-ascii?Q?+Epb5gs0RGCvCj8Mz47eK2wPaq1Se16Gw73VYWn9nMKPuu5aXAiz6Air3Nrq?=
 =?us-ascii?Q?FHzqRFAvLRg4cpwJg6CDD2apO8EkJMhMQc/opXsWKsHUeOjYCSypuWDrEjrM?=
 =?us-ascii?Q?gRyrcoRzxW0FBWWawLb4UvoWdUqMlSeIayFBvmIKxLsXB+LZhGaRVIGjozvy?=
 =?us-ascii?Q?HnqpvbOK5kGvC3hoXYgZ6l891WSjgLoDOqoxlEEzzx/W4EWmYfg58/UA3WM6?=
 =?us-ascii?Q?fzfavwc8Jwp+r3k+DQkN1/OZmSUcEh7nykjW9OksQnOhshkb00vP9JLI0tOl?=
 =?us-ascii?Q?veUYaS+vFqXzyZdl2gJyFIuH9EV9RQi0OnrWG1z4cahSeyf6bI7/dKnI2DFZ?=
 =?us-ascii?Q?0wnqnlNV/LYfAiax3aTqThKGyLA6YEiIS1BVNQ7HokApI/GPJ2fv254oX7oy?=
 =?us-ascii?Q?CTgUfKzIQUkc8VW2Zb80LLKnZQn20qvYlOFdKUR+UABlOgrSQN7LD4cobAyT?=
 =?us-ascii?Q?t1wBZtL03JSjUVpYIqami4Y/4x1usIB4Bw0BaDRgc/lLo+/f8McCpAY/0nLC?=
 =?us-ascii?Q?zAaHO/agB2Zc3wH3SNFgmXxS0NDp5dbh8KMTXmCgBusi9R9yqXYOpTzeeMPW?=
 =?us-ascii?Q?j0uq+P5hd+bGUKUCfsh3jSi77wvXeS3nsQikk1OG3CPl6paT0oVC33R/YZfg?=
 =?us-ascii?Q?k0iiazA5Oomv4YqBe7lIhn0AiNhxpij9CvYL0i3L1KeF/tW0ypIF4E/buK+o?=
 =?us-ascii?Q?KlMUQXkBuvMTa9AXQsZnUVJXHGLn8VTXEmlrwjJFY32FIA2t4LCChaK0ttej?=
 =?us-ascii?Q?hh38g2+NN2jOUCC+fg7djGRELD+8qoFVLOBACSRd8o/iO3K5x2CSeV4jJAQG?=
 =?us-ascii?Q?PhuVorT/Cuko2VGLxdnuPMuGIvB20NXueL2ASk79QbhUOhee/DZTc+XooBmx?=
 =?us-ascii?Q?ji1T6EsOfmwq+eWilnHrhG2Cc57PugWSrJQ+y6kaO0tu4ziRBBMlY6Vucm//?=
 =?us-ascii?Q?MFvL2UiCUN/XjhYtpwHL0Z4gHIVS+uv8wEOhREp1FRYRCMZ4ts2mN+5QRu6Z?=
 =?us-ascii?Q?0ZQiWXblhxpBlVpsi70vd4pexmQ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VObd8pcklmeRgJo0hJRnPOBD56g+G3wMbRrKaesX+55dpYNXB9bJDKTqZjhM?=
 =?us-ascii?Q?Lc70RYbJ9gIuCEKYdeZlnV1z5JHi8YfJDRtIJ5BlCeQg4ZNi4lLywBDnNKSU?=
 =?us-ascii?Q?I379fM1YB1p3Lb5lZGQxAN6JEMG2qPNFFMR7nPDWR2hOlkWWMcIHntC0VFPS?=
 =?us-ascii?Q?edWMfxCTSyflopUq8fvR4+QcndgYg8gRTBs99PE4XfmH5nQHxRmcBDELG+ul?=
 =?us-ascii?Q?/eQ4LhgGhuU2TcKuELLBG+YLZss+cM79Niid0cPtwb6bI1UbKED241W3oveJ?=
 =?us-ascii?Q?zE6UiOaaRZKc6DhsMsmjc2ysXBtKPjOscmwVwlx52uaHuowyK38ZiryaGaU9?=
 =?us-ascii?Q?14a3PWZCVo+UiS8UOrllDN0g+YooWAG+AJ+xhzxBNBsbq7mWT33cz/q9gga/?=
 =?us-ascii?Q?lVVkfOaA9SsAgG99mJ9HmMI354lCuW4sETOrRCo4L3GfFISmAvjF2qm/FVKN?=
 =?us-ascii?Q?a/9aImOk0UdDLrh6fy5ZU11gSbLWSME+dWKhKVF1zvQl+N3Qnx4fDIWXH6gA?=
 =?us-ascii?Q?zXAiB83NkykR5DjEcNlWoBxAlxUwzihWlsKOs63wnxeV0nKReBvcCETu+yrt?=
 =?us-ascii?Q?CnAPnMmCb6g8UTszvmht8cMe/a1V/Lw6ftsVKgxGJnqmBJf4cIGnKRjSHgTu?=
 =?us-ascii?Q?+JWr/q7/9tU60hW74juJNoGKEkTaHRnFZlYSxZx8yGuzDf/CqSSQ30dLQ6B0?=
 =?us-ascii?Q?ANLhmCxveTwbtCylVFCdykGRfwgn/S2W7AOSnh1xJcR0N5y3CdXeot/qFjEy?=
 =?us-ascii?Q?b0100TiGvYD8DjfzQVN08wrJjt9+ldNOAkLKfN9EC43hANwsN/+uxSi4Ztj2?=
 =?us-ascii?Q?DQpLLTnwXYY2ONmVLJ45EXjt16pMkV7//Mb7K5XrLh1rHk2jGNs9NqF2F/iy?=
 =?us-ascii?Q?+gwGokd3pb7B+bjy2GvOig9Kxlr628jueWUG/JTa4yX7cCL4f72/wPK/pM/e?=
 =?us-ascii?Q?UvPd/+2QHQ0yZ1jenxJcPfsDp5G1l2/LpWsB6kgS7vxwW/MtwXjgLG5MrGso?=
 =?us-ascii?Q?xUWq5HtMhf3vsXZJZGZKvcQDUlkRTRbjNKVVjxETZ9lRIPe/TLrhlqsg3AAM?=
 =?us-ascii?Q?XzyP+t0LUsUkJhwIRXVqXPnJMorljsJxeCmR7bqrhwaLHB4VkceQVR9Yf4cI?=
 =?us-ascii?Q?COQaFCUIejAxhPZHmbKvRVLeNK6hLdilZSz/jIUchA50Ltcj8MuFcw1KvN2G?=
 =?us-ascii?Q?LlAvd65ZQrS3YenIKwkDHLHp+zZWey5IQLniCmI/5RCVNCEb2Ir9w5oRh7aE?=
 =?us-ascii?Q?pxp7EOt/a8mSlD3Ssi26bwAyAPWENx5Kzv2PDJg3iNa6GqmZvFYew0uflim+?=
 =?us-ascii?Q?5c8lILeYBBJ8c8y9oi+paEAAjlRJvRWu3JxvQvsQ9lcIwbviyI8TS2l28RMQ?=
 =?us-ascii?Q?4SNYEgDe/9fWHVRK7BYsW1GOVAmAxGW7bArSYv99UT6HKZsvBW3e2fA5tFmf?=
 =?us-ascii?Q?c1dXOAT83gDt1qrn9B5HQoDs1V2/oCJVkEYbfZU0rXf3KyX3vJWMPS6As1p3?=
 =?us-ascii?Q?mhKRMtumz624xEW9261uPZicwx/s3Jbl9mGYm0P2GPBySBP0Ap8BqNQ9k6aw?=
 =?us-ascii?Q?u/IA94dLQKcqLKeIwC6Ke4uVbT9PvqKhpk4IUyxKPjt2k+K7dsepjCkGNfnX?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7f4e6e-aff9-494a-c0f3-08dd24555e94
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 19:58:43.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ticFExQo3CBbaTHwKTYUyB5TVd8eXNoCpuBj6okuwx+WIh2VaAO61vWd681dWmcR+PbG6BkrILq9qqTwTiFuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7002

On Thu, 19 Dec 2024 18:04:04 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> Implement the generic `Registration` type and the `RegistrationOps`
> trait.
> 
> The `Registration` structure is the common type that represents a driver
> registration and is typically bound to the lifetime of a module. However,
> it doesn't implement actual calls to the kernel's driver core to register
> drivers itself.
> 
> Instead the `RegistrationOps` trait is provided to subsystems, which have
> to implement `RegistrationOps::register` and
> `RegistrationOps::unregister`. Subsystems have to provide an
> implementation for both of those methods where the subsystem specific
> variants to register / unregister a driver have to implemented.
> 
> For instance, the PCI subsystem would call __pci_register_driver() from
> `RegistrationOps::register` and pci_unregister_driver() from
> `DrvierOps::unregister`.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Hi Danilo,

I think there're soundness issues with this API, please see comments
inlined below.

Best,
Gary

> ---
>  MAINTAINERS           |   1 +
>  rust/kernel/driver.rs | 117 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   1 +
>  3 files changed, 119 insertions(+)
>  create mode 100644 rust/kernel/driver.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index baf0eeb9a355..2ad58ed40079 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7033,6 +7033,7 @@ F:	include/linux/kobj*
>  F:	include/linux/property.h
>  F:	lib/kobj*
>  F:	rust/kernel/device.rs
> +F:	rust/kernel/driver.rs
>  
>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
>  M:	Nishanth Menon <nm@ti.com>
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> new file mode 100644
> index 000000000000..c1957ee7bb7e
> --- /dev/null
> +++ b/rust/kernel/driver.rs
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic support for drivers of different buses (e.g., PCI, Platform, Amba, etc.).
> +//!
> +//! Each bus / subsystem is expected to implement [`RegistrationOps`], which allows drivers to
> +//! register using the [`Registration`] class.
> +
> +use crate::error::{Error, Result};
> +use crate::{init::PinInit, str::CStr, try_pin_init, types::Opaque, ThisModule};
> +use core::pin::Pin;
> +use macros::{pin_data, pinned_drop};
> +
> +/// The [`RegistrationOps`] trait serves as generic interface for subsystems (e.g., PCI, Platform,
> +/// Amba, etc.) to provide the corresponding subsystem specific implementation to register /
> +/// unregister a driver of the particular type (`RegType`).
> +///
> +/// For instance, the PCI subsystem would set `RegType` to `bindings::pci_driver` and call
> +/// `bindings::__pci_register_driver` from `RegistrationOps::register` and
> +/// `bindings::pci_unregister_driver` from `RegistrationOps::unregister`.
> +pub trait RegistrationOps {
> +    /// The type that holds information about the registration. This is typically a struct defined
> +    /// by the C portion of the kernel.
> +    type RegType: Default;
> +
> +    /// Registers a driver.
> +    ///
> +    /// On success, `reg` must remain pinned and valid until the matching call to
> +    /// [`RegistrationOps::unregister`].

This looks like an obligation for the caller, so this function should
be unsafe?

> +    fn register(
> +        reg: &Opaque<Self::RegType>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result;
> +
> +    /// Unregisters a driver previously registered with [`RegistrationOps::register`].

Similarly this is an obligation for the caller.

> +    fn unregister(reg: &Opaque<Self::RegType>);
> +}
> +
> +/// A [`Registration`] is a generic type that represents the registration of some driver type (e.g.
> +/// `bindings::pci_driver`). Therefore a [`Registration`] must be initialized with a type that
> +/// implements the [`RegistrationOps`] trait, such that the generic `T::register` and
> +/// `T::unregister` calls result in the subsystem specific registration calls.
> +///
> +///Once the `Registration` structure is dropped, the driver is unregistered.
> +#[pin_data(PinnedDrop)]
> +pub struct Registration<T: RegistrationOps> {
> +    #[pin]
> +    reg: Opaque<T::RegType>,
> +}
> +
> +// SAFETY: `Registration` has no fields or methods accessible via `&Registration`, so it is safe to
> +// share references to it with multiple threads as nothing can be done.
> +unsafe impl<T: RegistrationOps> Sync for Registration<T> {}
> +
> +// SAFETY: Both registration and unregistration are implemented in C and safe to be performed from
> +// any thread, so `Registration` is `Send`.
> +unsafe impl<T: RegistrationOps> Send for Registration<T> {}
> +
> +impl<T: RegistrationOps> Registration<T> {
> +    /// Creates a new instance of the registration object.
> +    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            reg <- Opaque::try_ffi_init(|ptr: *mut T::RegType| {
> +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
> +                unsafe { ptr.write(T::RegType::default()) };

Any reason that this is initialised with a default, and not be up to
`T::register` to initialise?

> +
> +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write, and it has
> +                // just been initialised above, so it's also valid for read.

Opaque can hold uninitialised value so as long as `ptr` is not dangling
this is fine. There's no need to actually initialise.

> +                let drv = unsafe { &*(ptr as *const Opaque<T::RegType>) };
> +
> +                T::register(drv, name, module)
> +            }),
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T: RegistrationOps> PinnedDrop for Registration<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        T::unregister(&self.reg);
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single driver.
> +///
> +/// It is meant to be used as a helper by other subsystems so they can more easily expose their own
> +/// macros.
> +#[macro_export]

I think this is supposed to be used by other macros only? If so, please
add `#[doc(hidden)]`.

> +macro_rules! module_driver {
> +    (<$gen_type:ident>, $driver_ops:ty, { type: $type:ty, $($f:tt)* }) => {
> +        type Ops<$gen_type> = $driver_ops;
> +
> +        #[$crate::prelude::pin_data]
> +        struct DriverModule {
> +            #[pin]
> +            _driver: $crate::driver::Registration<Ops<$type>>,
> +        }
> +
> +        impl $crate::InPlaceModule for DriverModule {
> +            fn init(
> +                module: &'static $crate::ThisModule
> +            ) -> impl $crate::init::PinInit<Self, $crate::error::Error> {
> +                $crate::try_pin_init!(Self {
> +                    _driver <- $crate::driver::Registration::new(
> +                        <Self as $crate::ModuleMetadata>::NAME,
> +                        module,
> +                    ),
> +                })
> +            }
> +        }
> +
> +        $crate::prelude::module! {
> +            type: DriverModule,
> +            $($f)*
> +        }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 61b82b78b915..7818407f9aac 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -35,6 +35,7 @@
>  mod build_assert;
>  pub mod cred;
>  pub mod device;
> +pub mod driver;
>  pub mod error;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>  pub mod firmware;


