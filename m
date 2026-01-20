Return-Path: <linux-pci+bounces-45278-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCIFENqqb2lkEwAAu9opvQ
	(envelope-from <linux-pci+bounces-45278-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:18:34 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EF347463
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF8D5944A6A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05BD477987;
	Tue, 20 Jan 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LQGs3mhK"
X-Original-To: linux-pci@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022112.outbound.protection.outlook.com [52.101.96.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBA477E47;
	Tue, 20 Jan 2026 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922782; cv=fail; b=nD0RCkJC2Ctn5rs4LVewmM/tnwPpi8z0vZbXcT6fQkPVqjmHWLHcAVmFhdfeZ4xTB6P5ULUNv4qO9VYQhRsNoftwRfd36Il0kcu8TQRGCIxlmMC4sXs/7AmX6qqKPxRVtTFR2qeRQ1FpGJTjIRiBlALvJuKRy154F0doXsIRNbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922782; c=relaxed/simple;
	bh=aDEQT8P1x4Y0nj9AsT0wrf75Yy0M88zMHnbagBb/MoQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=HaCm3cwSvcUgOsCi0b/thzJc5pCPkyAomq0cqd2SZnp6CCzaF5MxJADjOpJFLEonWfu1ItGYH0muSxzIAQloVZooHst021Cvc8gOETSkzeOnPE95FqmN/QPYKS60yhXJfyLKChRDqTHj/y+aAngrNNtwSGf8QE9bzuomIqSvcwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LQGs3mhK; arc=fail smtp.client-ip=52.101.96.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpQoBSAY08Ayb742m6PfSB2JqGKsfBOrl1XfC5mJ+xKlEEJvV7wXUYftEE1yQg3lsO9dX+gvktLTBiZ6csz1bCcWqF86nBR+4ynu8i53vaLxel4RZwS0Z8SlUcdrvjL+MiVL4TAUft4mWOSAgtat/xfqjdGB//TxzMRE7l/Npfv3hSC1VZ3AinV45vCPGM+nPDSg/l7m9+z9aB1jq7nP7eSGCqMbw8gCTgujfy+cYsGBm52PtVFVqusxBuV4G8fOffpUR7dUAqIBcTsu5dfggDRIntVPCrU1etLb1vtqI0+ivmgoHWigTDBCWcuQOvuUCRi0YvBbS0SOELIfcnVbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIvOSd4daYENNqUBcWI/4rtdSnLyMCkbyaPoxN1MBRw=;
 b=Y/cG9JYGwVAorRvUkCTN92NarT12U832LXZTQeNCTabgP3s4vU88B/6KPHkBl40kwknTG4ah20hRgS3RsK4I5m+eisF4H2y9nkjE2pCr68gg+v6X4nXRBaemPfK2ra44VDnDYDmSluloSFeHKJZk9+2o8jwuqelJI28yKlZIlHA700R8cO/C4sb6bkXg0LwqGuNjzMxMu2LdYK8/mmRlEDHpbBy1fmGnYIGn8QYfqTX9gEi5NtJ+INaqBDjnHGmBrgv0RPMuJbQJs/2/vdsdWOY++BS5EJBXsptQVJGtybZnqCyq3AOyXQgGPZibLJ65DgdidHD4ssdV+7FUbF8Tlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIvOSd4daYENNqUBcWI/4rtdSnLyMCkbyaPoxN1MBRw=;
 b=LQGs3mhK2JuuMmep4QGJ8Zbu5PnVqK9sQHfbJ18mZH8s/esLpUM0JaMUU0FaVWIgkO2PLinYJhVXKpfOT2kOSDfVgD0tg7ZTUD6uiAE3jdoCPYzrZO4zU3FhNzMV1j+rkf9T+KbS4ryoaZ4xr8c6K0Re2zTUMTYc3/uGwUlGlZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6486.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:26:16 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 15:26:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 15:26:14 +0000
Message-Id: <DFTISFW00C4H.174PEJLL5YRTK@garyguo.net>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v10 1/5] rust: devres: style for imports
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-2-zhiw@nvidia.com>
In-Reply-To: <20260119202250.870588-2-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c349c74-e369-4109-009a-08de58383fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWZ0aXE3NlZIZzdWTHhRRm1nVi9keUtDTk0xNy9yNVBxck5ialBVOVIwWEdJ?=
 =?utf-8?B?RkNkZHJMWExsOTc0UjJHSjEydkgwazNWNndMci9KMURoWGEyKy84L2Z6MzZ4?=
 =?utf-8?B?UmY5bUdEdGJ6Ulh2OGRGekRNN3A3VW1Zeng4OG8rTmNicnBvVTIrNThsSkw4?=
 =?utf-8?B?bEUxbG9qeUNvZjdTZUdYUVBIZE83V3pDeWd3VHBXekI0R2QyM3lGNTdmRGlE?=
 =?utf-8?B?Znl3SVpuZXprTkFYc09vOFJBNTJTK3J0Q1VXRENZbVd3NnE4cEh4MmRRTDRF?=
 =?utf-8?B?WDVNREh6R2hua2t3MzhrRTVnUUFoNmJUQWhCN2dpVjM1TzRrYThwZkxUWVVW?=
 =?utf-8?B?QTRWcytQM3lNWkxvQVpKaUllMVVqbStEM3FNSjRQdmV0bGZ5WjVNOWdUTGNZ?=
 =?utf-8?B?b0FDSkJRVysydytQYzFFb3dFZmR1d2NUNE82djZlWURNMG5Fdkl0dTl4akRZ?=
 =?utf-8?B?Ym02SnNKaytEd0dHbTZDcVltaUlFcVBVcTBEWUhzTnROcERTdTZrblJpOVFJ?=
 =?utf-8?B?bjZ4cjRncDZsaC91akEyVWYxVVg0WDFJdkZ1WW5IenN2aWt2QXlVVkNEZmJo?=
 =?utf-8?B?cVJoMWFrYlA3VWM2T055dXV0UTVGVkhCWnNWT3NKK3ozNlBKeU0zN01pMVpj?=
 =?utf-8?B?M3FiUHpGWWExZDMxMS85a0dOa1I0SDNMU1I1YktnMEc0ZzhpYjA2akt6WitM?=
 =?utf-8?B?SFI3WVlTSHhiVkdOdHI0UmJCT3VpSVFmcUtBeSt5WWE4UkZqV0p5dVNrc1Ni?=
 =?utf-8?B?SjQ0RWFad3lmUUNGQmh0RUlpaGdlZ1V2OFJETi9TV29SKzJFN0FvNHpaTk9t?=
 =?utf-8?B?bThIMWVmc1hvU2YwdFhvQllDWnpEWTMzSC9maWRYTGNOTnJtWFI1bEZJRk9W?=
 =?utf-8?B?aGNqZmttL0Q5ZU1OeWxWQkpYV01WRXBmYncxS1BBYVFvZHJHVkhnNGM1aVB6?=
 =?utf-8?B?VmtpMU92ejdIbFdCZ3Q0dTZicXA2RWZ4US9COWdFS1ZiWHh5U010aUR3R0Qy?=
 =?utf-8?B?VWpxOFVXMytUdDhTSjd4WGpUVnMxbjJVT2gra2FBNUNtZkQrWWUxOVhFN2JQ?=
 =?utf-8?B?bG5BSEdhNXhvajk4aVJqWHMwWHJTRTgvamVNc3AxZzdHTGwxOFZmYitqVE9s?=
 =?utf-8?B?UjZUM08vNmZSVVplWTFpSUdkY1hJMGlCUSttM29PTGx2MmVndUpNa1E5OGM4?=
 =?utf-8?B?bXhFaU9kSjlsaXNLZllzYzFOZDUvTEJySXEzQzNTdDAyQ05uK2FSaXJqTE52?=
 =?utf-8?B?YzdyLzA4WEVzMGZHN0E5dUx5Q3JjUjNnY25iRHlCZmNlQ3hVeERhR3lnUVhZ?=
 =?utf-8?B?TENORmg4NGk0aFhPK014aDJKKzRralVyZEI3b1pBaDgvckFOd2lZU1JWRTli?=
 =?utf-8?B?eG13U3FWOFBHTXkzeC83OFpMdkNyd2hKemZYcVkwMlF5blF5OE0yOHBpT1l1?=
 =?utf-8?B?NGtKN0tFcGVPN1Z3dnhmYXN5QjZmSzZrZGNtTGpkUGJ4N0lXQW8vV1FXbzlU?=
 =?utf-8?B?Q3VuYUxLcjNYbCtVTnF6ZmExaC9qeFVBc0NYNGVkZDZOZDJhSFJ3WjlTUElr?=
 =?utf-8?B?S3NZWHBlZm52THYweEEwbmNNeGNTUURQV2FmRGFGQllxb2hCUFhJNWR0VDBG?=
 =?utf-8?B?anlleXkzbHhmNFhnWi9uNmtBSHVkQ1UyL1gvS3U5cEwxa2NldkZ1K0VReDF1?=
 =?utf-8?B?b0JlQVZsQXppWERzT3NPOG9sUGxZN0FqR05qTEN2QWRSeWlFLy9pWThWQ2xO?=
 =?utf-8?B?RVdGd1JmY2JpZDhxWGhhVFpFZThtR3ZGQ1owNC9QMVpaN0JzbTFWc25yS09Q?=
 =?utf-8?B?NlovbkZiZkMrcTNHRzlmeUh5cWVQRmowMW80YXhqSmhacnQ5bzV5SE15eUFE?=
 =?utf-8?B?TWtENkloMnlxRlYyK1Zla3dmWGR2NlBNZVlQQjJpclpBZC8vN0thNWlScnJk?=
 =?utf-8?B?dlVSSy9hQ1AyVithemRXN3l3blJpeFNxZDZxYjd1TUJMelZ3aE50WDE3MUpt?=
 =?utf-8?B?OTlaLzlYQlgzdTVnTk53VVlSM01EcXpQNnRMU0FNc3ZMNHREeHRKQlNhSFVN?=
 =?utf-8?B?OGZyVzZ1bjdCVEZKZmtmRmR3bkJ5UWRDUXhjV3dXbkhORHFKbkFBQ2VSVS9s?=
 =?utf-8?Q?3MP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjFIYWVuYUJ1YlJCOWE1NTkzOFc1dFVIWXZjRTBiWW1UZ1Vpd2pZeEI4U1NV?=
 =?utf-8?B?bnpKN285a1FJS1JOVVZGNzRMK3J0anJLMHFYVDA3bXlSWnMrR2FJNVpTeE9Q?=
 =?utf-8?B?YStwSnNsQ05NcnliQTlYNklzTkxzSElaTGlWaFBnUWc4OTQ2d0hLRlRiRjhP?=
 =?utf-8?B?RXhHNkxCMkt6a3N1MWV2Zi9pSGtYVmhwRHNycmI0a2xHUW4wZGVJYUJTb0pt?=
 =?utf-8?B?bEpYYjJ0dlBaMm9VWk9YeWZhZWxHZXpNZHdaTTRuM3NzakhCM3Y0ZlIvMUlh?=
 =?utf-8?B?WStZQm9DSGxKWEQ1ckY2Q3VFZ3pIOUpNVEYxT1VaNDdnRVI5WHhlMGhhYWIy?=
 =?utf-8?B?YXZyb2dDdnE4SExiTU40dGNwQ0VTd2JRbmZYU0h0bURFbGN5NG9pY3BQTC9J?=
 =?utf-8?B?K0h4cUxJbVF0YlhEdFBrZzJnRDhjL2VsWlhaSFYrY0Fuc0ZwR1cwaW1oV1FI?=
 =?utf-8?B?cWlZK2oyT2tscWo5dzBCSzAweFdPZW5uZU1Na0RJQlBhTTNSUU5TTk5wUEdK?=
 =?utf-8?B?cDRPYXJrL3RJRTRiSTVaYndDVE5BbWgrRzZtYi9DbWo3Z1dpQWYwdnU3TTEx?=
 =?utf-8?B?d2dIY3cyTWJ1MlpMaThWVWhyNU85VE9yU21mUWxIOVFqaGMveFFUR2l2NjhH?=
 =?utf-8?B?d0pxcFF0RFVJS2ZhekNYekh4YmQzWngrd1BvTVdpelJLUllRZ1M5QXN5SXZE?=
 =?utf-8?B?a0U5ZVVxNmx4cjdyQkw4TFF5amNRZU9BdWlSY2dJQ3lNS3pZNHRjZjNRaGJ4?=
 =?utf-8?B?ZHV2QVZyTDlsSW5jUW80cnNsR0Z0SENEczZkSWlpZ09XOG9iSzJzQ3VtOVRs?=
 =?utf-8?B?aVF0elBwSHh3UlV5R1VYUlY2d3pldlZTa2J0WHAyelZLU2h4OU9MOTk5NDhM?=
 =?utf-8?B?R1Jvcy9tZlV3Q2lRNmNtMHRTREoxU1ZaK0RXNXRoOFlvNE9zbi90d2crTGZJ?=
 =?utf-8?B?VHpsQTRtZ28vMXRUZXFBK1FIbERzb0NrRk9QRjZrdmVFa0c2VXNrSzhRL1l3?=
 =?utf-8?B?TzBQNVF3QzNZbXRBQjBWS1VIdG5kQS90U0tqeHZyTk1TR0VtMkFUYitUeHVG?=
 =?utf-8?B?QndJZHkrNEo5N24yNWZSZnV2WjlsK0x2RGJzTS9UOFNYLzEwR2Z2cTZjRWhD?=
 =?utf-8?B?dUY4MGtXeUdZWDdxTHdwclVwMnZmZ0NPRU1SSld3R1dFM3BlRDF4cVNzZXJT?=
 =?utf-8?B?YUt1QVZ4MmdYUFpYWXNObFpNSC82UHU1Mjg5WFAxU1RLSlFuTytEK0pLd0Ey?=
 =?utf-8?B?OEhpeHh3SFNBck5ma3Rsc240bERQTE0vWGRLS3NpWlhhT0l0bnlsNjhpdmxX?=
 =?utf-8?B?ZnVUaXZGOEgyMklxQktTN3VjdU12SEtpaEJUb0JOejd4QjNnUVlCWElPblkr?=
 =?utf-8?B?TWEvb05xTUVIelFWWlVuRVpDUFVJS3FOazZvNXV3NWgwQkZpUmtLOHZRWkRP?=
 =?utf-8?B?bkhFM3l4MnNSVVZLQUYySFRqRUlnQWl2RVZBcVk2RnEzZWVHV3M4aW1oeUpw?=
 =?utf-8?B?VU1vQjFFSEQ1VHNQUUdlK2VKYzQ1RmpKRzBNeWxZOUNEazhvTjRnQXlEb3F0?=
 =?utf-8?B?VmJwTXR0OFFQMW5UaWE2dC9pS0oxeUdTMzdibnNUZmVQcWhiMXVIMmx6SkNL?=
 =?utf-8?B?elRiaTRsc3M5Tzk2dlBibFhhS2J5dEFtM1VWbDU0L2FRUk1pWXVLZUpZeXJs?=
 =?utf-8?B?VVFmTVNCNjNadjZkemo0Rk1pb1NFYnI2ZnBlR0ZlRm15RytJSFUwWmlDYzVV?=
 =?utf-8?B?OElpMGg5ZHFEdFN4NVFxSkZsTEhEeEJIQURXS0xBc1Z3UXlFbmJaVGo5L0VD?=
 =?utf-8?B?NUszOC9ldlNPdTY0VFdkRDhYcXgyS1JneGNaTm9OWGdhSzZLRkN2d3dLbGdO?=
 =?utf-8?B?S21oRGxJR2RsY1B0OEZvR3lPQjZ5cFViZzcxYWtXanFSK0Jxd3N1WHlaVjJk?=
 =?utf-8?B?NWNnN2R0OHhnVm5uMFhPNXk5TERaQmdleGJpN2dWclNtc1dKeERnMzY1di9Y?=
 =?utf-8?B?VGQ3SlNOZjdtVlBXekN1dGM0YTRlYytPNjNGQUtSSzM0RGVReUtHWU1tTGp2?=
 =?utf-8?B?YjBGbkduUklXb2E4Z0E0Yml5MHNJRHd3Q0hrYmxKaVZHTVdXcmZ2TzNRYnJn?=
 =?utf-8?B?eTk4WVR3ditleVgzUmYxaU1GR3dYNFlhQVBXYnNuWUlMaWlkaG5zOUYrQkMw?=
 =?utf-8?B?aHlDcU00aW1HK2l1ZlRQSDBSUm5DOXZVNGJpVGpic0xqMEt6UjFFdjZVNStY?=
 =?utf-8?B?a0hqS2pueWxocVVPb2NRZGxkZE10b1VCU2dUeDJvY0d4UnVESmV5Um1Vb3Jz?=
 =?utf-8?B?L2NEMTB3QVc1UWdCdDZPcG9ycmI5TTVmY0ZOZDJwUHFiOU5ML2x3QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c349c74-e369-4109-009a-08de58383fff
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:26:14.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqgVMZoWFT38PrxcxTUDD8Li9zLqYXoHaEpSb8Oap+HpChDK1KNAacqbZ4aOkV1l6JPrPzbySnqaJyTQ0IBb3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6486
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45278-lists,linux-pci=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,garyguo.net,protonmail.com,umich.edu,posteo.de,nvidia.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Queue-Id: A4EF347463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Jan 19, 2026 at 8:22 PM GMT, Zhi Wang wrote:
> Convert all imports in the devres to use "kernel vertical" style.
>=20
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/devres.rs | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)


