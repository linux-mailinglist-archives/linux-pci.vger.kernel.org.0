Return-Path: <linux-pci+bounces-34661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9E9B33F8B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 14:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1CC205541
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE37FBA1;
	Mon, 25 Aug 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ba7VuUic"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF99274B37;
	Mon, 25 Aug 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125209; cv=fail; b=MCtGjYuDeG72D+4+80KvKaJxd/7MlsDO7PbVZ7vvJknd93IiS8hWDc3BNuzmaGXmwsvwn8q1kCiUM09Gn/SzKCXYWsX+EIe5G7mj0R4AeQArcGpeJVMkCVRjRCjdHfSu9RjZ12tYuDyup+x4j/k2p3ip33y8tzztQCyoLohFvKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125209; c=relaxed/simple;
	bh=QFUnxv0GIx6bUUQKCAlLPhldhROHR2YFhgiFzXdxl3g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=roXLRFeBJQPvJ5p5cJJVdh7/Bmy92tRJfCxBTDAmOhpb+SeUDEe8VIzk4GZMAcSaFx7cHLqZ9+Wthj5XaHv4X+LEJk+TRZ+zeCtsAG32FGkDGhooleyWd+sLaSwWp4dEWsex10UT5alg4beoEOwBNz06T1OTAwghCQkJ6SLzAYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ba7VuUic; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlO3/jsils9kCa0V3sXkYOFRGuV2FJDBRghQJUbyvRTxAgwb8dwMivIjuyGglJ/e7owHQ+eO+Nl5yfuOTyDNnQVjJL6BN6yziv407yUa3AJ/yZ5BtgboYQ+WOiVDbTBg9t3jz/V+8u6/KBrey18FRMfH/lutggcXnwy9ELxKJ81S1yNwD6vh6rP8tvRMglBq2fns+tDaQ3vMGvW7DA87lk4VV7z+ySl9W6BldFWbK5rqtfR17lMoaJeku5HAvhtK3K7Af4yobFZKW54bXA732GPLKtHP5JE/D3jo28WwjI52zo6DSQK+HhmZI/pMADoxtwBeXVKNq15Bm/SxTmUwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JDxYdOKr1wEMC81NFdy1XkmozjhF1um+dYuQUPw0wA=;
 b=n+iCRZQJcmDlkldpT2YpDNJ+HIjhjTspZMz13bhqndClfFpaRuCI99ueqBPs4maxIHhATE827t9XcextCkjOgVIYKPobOYZNAXAVsD7MEkjkjfq6tF7IVOqvroFtGucZMYlOmHzCuL4gBrkMZ7uyPrxbTmxtfp6Vih9UIqY1pkIasHJS8owol6B983wQRE6IoIZs6nY87MP5RSYANTdhwh9DZMF3LT2OvUQeXAV1HtGWlBTG1hPziJWXE5fNYKwFOqP9x/2c9/AvZTs4jQF/7VLcKJ40IbrstphSiIUzVi5+eQ8wI5HX/qblMN98+WS7hP5yxHrkrouEeyOjtxEwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JDxYdOKr1wEMC81NFdy1XkmozjhF1um+dYuQUPw0wA=;
 b=ba7VuUicFi9Pq2dTKCiW/K65rSMdzlS4MSfTOwt3gPjj7MhPoxamCyrO5dEdhaC7Da7BtY/MiplrwcgEaSAzxWhUzISiCWlxihyBlochisPo3Vey29kRsCH5uyoJY4WGKgHpzZcinRXP6KfiFh+hE5XXE21dpqUh11dZorRzrw5sd2dj8sRIod39jCuOFtMrMJinu46cD+GIaLfe763MzmiVBZB+UH2RzjXz31eYmZEOP8Y4TvWxAy5MAAIvo3LgdbvWZNQ06BZGeTZ4cUwdvsRVOXsqWTIB7ISndS0iW5zkA5XQbVw5Y4+N33o/0v8sUAg2qQCUAiZ82hc7qfA53A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 12:33:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:33:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 21:33:03 +0900
Message-Id: <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <nouveau@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-3-jhubbard@nvidia.com>
In-Reply-To: <20250822020354.357406-3-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: c13def6c-cd5d-4c21-5179-08dde3d38b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTlzY1p0V0FwWnlwTjZTU2JKT0laQWV1M3pWaFJQZmdBekluY2xJL1djOGli?=
 =?utf-8?B?b1RhOC9hNHhOenZvbmwrOUYySnhQT0JiVHBMdjZEUm41NHZoblR6YkNwMkNL?=
 =?utf-8?B?akFocXMyNXNmZ1hSUHdURldXeTJFUk80dU5zR0I0YzF2V3duR2dRL2FBbmtF?=
 =?utf-8?B?d1BRU3ErUFFLeDUvL3lCZnZjTU0zV21qcEd3WFF4VExzUm5LM0w2QnpSNUp4?=
 =?utf-8?B?cEtianN4WnpyeVZWa3YwaXRRQkVqQVdtVTd3eXh2THRmT1N0WWp0bE4rcEQ2?=
 =?utf-8?B?OFNONGFQbjhWU0tlV3RLK0tycmZZR2JvSE4rQWswczcxVUgrSEk1TW9jbWJG?=
 =?utf-8?B?Mk9wb2lkWEVyS0I0bEl2ZDNubFJ1RUQwclNrYkxoVmJLSisrckZpL1BwajBM?=
 =?utf-8?B?ajFIUzg5dnJ2bldQaS9qOFVnY2NXQkJodjUzS0ZYOVA5WFFzSEhucG9vM3Rn?=
 =?utf-8?B?VGJXcFBtTXVjSDl4RE1DWS9NU2lXblpKQ01aSU1wVDhUMzloSytLY3FZQk9G?=
 =?utf-8?B?cWRuWm9CSm0rZEhKZjAwSlZ6b1hBRXhqYjNlYThBamd1eWwrcUtvREdieXBV?=
 =?utf-8?B?c2lEYU5kenJ5bnd4UlU1NlhkQ2JPR0VxZ0N2TWpURkhYUFkrdVdtMU4xWG1w?=
 =?utf-8?B?VUFiYkNZQ1pHc2tZWk9naTQzRDZCWTliUmJKQ1pIeE5EU0VwMXU1dDhKMzR2?=
 =?utf-8?B?U0UvakVnVjBsZEtBa0loSnkyOUFKeFBTYTJqOHVvNXdDb2xzd0VMYm5BWkJ6?=
 =?utf-8?B?QWxQMnBZVW9TTjRKRldqdXArK21DbXN5cHlmYkNxSWRJeVQ4UEkvV2E0V1Nr?=
 =?utf-8?B?SzQvaUVINFFYdndiaWFtcnJNVzhNaDV1MGV4VjlPUmlZMVI0NnYvQUxwR04w?=
 =?utf-8?B?NEYvM2JMRjlpb1o1Qm1sbG9GNFZaQ0Jodmc5a2xxV005Q0FJa2J2c1JRVm0v?=
 =?utf-8?B?ais3QU5TL24zRTdNaytndkdBb0lNbEZyK20zVWtKbFYrTVFScTEyTmR3Mi96?=
 =?utf-8?B?MEZlbi84NXBySUtOM0RMNWdLa1VRL1cyNFYwaERoRjBuSFMwSmwrWTJqYmUv?=
 =?utf-8?B?U0JEN0RMQ1dXZmdtRThZTDVlWjhkbTZDYlZqZ2s4bEdxd1dRTW56cXlHRjVQ?=
 =?utf-8?B?RzRNSjlXWjE3MkFUY0JyaXJ3Y3M1U0RBWHBiYWJMeFA0V09hV1FFWnlkVUxS?=
 =?utf-8?B?dnBkZGduSFdCWk5QZlVKKzdLZG5IRUR6Mkw0V2haYm1NcmRaK3RMRnZENVFN?=
 =?utf-8?B?andpdHVQUzNZYXpzakVydnJNZWxKdEJCeWRVK1BUSFBUdkNsdWptMVB4MkFX?=
 =?utf-8?B?V2pXVlRaeU1iM1BpckYyUDUrU3F0b3NOZjh5TEZlTDQyUFlMOEJ3c0VnRkJ6?=
 =?utf-8?B?QTJDMzJDdlVUUkVmRzlIWURqdGNMYURJbEJ2R0J3eUhGMGxMZFFQdFZLRHVQ?=
 =?utf-8?B?eUdleXFKRzFUU2JCa2phL0w5alhna1M2TUJibkVuSFdOUGhJdGVCQ0VDVGM4?=
 =?utf-8?B?ZDBLWG1RTFRGTkhqcGxlTkYzMGhHZ0hRbUtjaUNYRjRMUjcwZy81a3VIZ3dW?=
 =?utf-8?B?aklQNmtiVnhzeHd5ckg3ZE56OEpDYndDUEFOLzh2RTFBdC9rcUtsaENtZSts?=
 =?utf-8?B?NE1qTk0ycjJiTVplZ3RBb1BHWW5VMXdkVjFTakVXc1BUQVFlalkxVi9sNmMv?=
 =?utf-8?B?UEt6bjM5YkhNb3VIMldWWnFhNmVlZGsydGcvaDYxOHJuMTV4SkxTdU1TZFlz?=
 =?utf-8?B?ZVppRG9GMEFaNTU5YTFsLy94RVlBQXltdi81cm05Z1hjUmgvak1NaXlqbWtm?=
 =?utf-8?B?RTJpRzJ0OStFa2dwWVdkOTNtcnNINHVUdGVwWGpDQU0rQmdBYkxtemtNODVz?=
 =?utf-8?B?SWpZOWVoSkpHSll5RVN2VXhnQnhtWTNwYitGcjRZaVJrby9sZkoyWXZaMzZ3?=
 =?utf-8?Q?xHX9r8D25VQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHZkZk1vR0IzOURUOUlscnBxdzJia1VzUUlkdk9TdVRRRXdYcExvTmpGZ2k5?=
 =?utf-8?B?YnZWcXdFMWZYTDZmdEM4MVYzQlpPN3FtZC9VMXNmdkRHeWhhOHhsK1NzRzN5?=
 =?utf-8?B?US9KVTNBT21UVHpXdmYwcGx1ZnF2T2NldTdtS0V2ZUFobVZaYVpYazZoWE5M?=
 =?utf-8?B?R0l1UHg3dnQ0NVNKUFJCZ3hxS2gxTzBoY0ZmRDhXMFA1YXVRME52NEdyZGt3?=
 =?utf-8?B?Q1JSVUpBblhCY3YxNkUxZHVnWEFMWi9lU1V1enVQaHNPMm91ekc5c0UrRm0w?=
 =?utf-8?B?dDQ3by9UWEZsZ0tBbDBtRnpXL3plVFh0MlVmMjhUUEVJS0daSXo4czg3amJB?=
 =?utf-8?B?VDhXOGtYRGpTcW5TbnlMYlUrUEMzMDB0NkxIcDZnK1VEbVlYd0cvSlRpQUJW?=
 =?utf-8?B?RTFyeWRMYkFjQW9zZDVqV2hxWHVrcGQvUlppUzZaWWxnTVoyN2lHclN5enBp?=
 =?utf-8?B?OU9JKyt5bnpVOERqWnlsVkVtU2s3dVhQVWcxS1RXS29tSDlpUUNaVUFJN1hj?=
 =?utf-8?B?a3BodTRtU2RoVk4zVm95L01QL2RIN0hUcFNuYXh1ak5iQXpBa1d3RW00bnJV?=
 =?utf-8?B?VGkvZXFlNTFleFloMjhuMDdKZmZ4dHJsSzZOaUtaYUY5aGVVeVJ0b1NNR2dB?=
 =?utf-8?B?a3Bub2g2N2FGbG5ua1hvNFhnb2dFOXNJdXNiQUtoRXZyQ3p1ZWhZZVp0dXVx?=
 =?utf-8?B?dXMwL3RnWmFtMXpuODZ6VUF6bGhVQiszUHdZM3JUc3dRaGlNbDNrbHlodUJo?=
 =?utf-8?B?bGp1Z3BrMjJPNU5jcHdjYzdZUTdnYkpOc3hVajFLYS9uYUp1MDhCMFRvc1NO?=
 =?utf-8?B?bm5zYzZLRVU5L3JBTWNoZjhDazM0ck5HT2kvODI1YnpmWXVCcGExbmhDcmlR?=
 =?utf-8?B?djlkdDBoWFdUY2dSc2phcTdOelMrOG4xMC9xdlFJcGhUQTA5MXJFWkFjU0hG?=
 =?utf-8?B?Mk5qdnBrSTZTYkh0SDZVMnZRRDlCbW5OUkhKMU9IeGZ3M0wxR3hKZUdOcjUx?=
 =?utf-8?B?NTNxdVBIc3hUVFhCTGdnbUVsTUZwMFhqS0pUSkFUd2Q4WXdhRE81QWQzWkhi?=
 =?utf-8?B?SWxIdUdIZG1yUy8rZlpTSXlhdlZIMWdWN3BzYXkxRXRlaDdHam1LMHZSTThK?=
 =?utf-8?B?eEQxbE0yNFJ5Q0xBL2dWa1M5Q2lIRDlPdjF1TDViRWR0b2l1TU5DT0I0WlpN?=
 =?utf-8?B?ei9ldHFCSXBoTUdQdTE3YVZhYnBhdzJDRzdqa2N0cU15bUR2ZWtiTUIzK0xu?=
 =?utf-8?B?ODBqMW5JSXVqTkpkdkhnbzZpVjJHYmxQR0ZDc1ZBVGxXTEhQbnhIekVBTm5L?=
 =?utf-8?B?bTFURUs3ZTJ5NCtMQTMwTFhxanRUUXdsaE1KaXVLUXRJdXo5NDBRcE1ocU1V?=
 =?utf-8?B?OWZuR1M5SFZVMG1hS1BMamh5MGFXWWhwSG93NG45MDgrb0s2akZtNERhOE8z?=
 =?utf-8?B?RU5vSDFiWm5tVE10MC96QVVHNGtQbm9YRDJscjNZMUNaalF5Q01Uakh3NDkv?=
 =?utf-8?B?UWVRV3gzMGVPUWxadFpxcW8wNVVrM0RpMUdVZWYwMGQwZk9GYlF0Nk9QcGNM?=
 =?utf-8?B?dkgwNXhORXIyc0dlOTZvZ1YxUk9RbXJJTHlORk82dEl6YjBTOTJWVkYvSGo5?=
 =?utf-8?B?ZDUvc1dXbjdIaHlaWVh2dWVTOXhseU5UL1pGNXd6Y1ZjT1VLYjdzbExqb1NZ?=
 =?utf-8?B?bzBmUklvaGZlYVZpTXVmdHRodE54L1N5USs4YndVbDl3ZXErQUEvQytsb3hi?=
 =?utf-8?B?ekZ3SEVNOW1qekNzNDhqTVFpNjJkbzBLRy9qQWVObm1WMUY3cnkyWndOUkdC?=
 =?utf-8?B?ekdTOHZ1cnAyYnZVbTdzQmRsR3BGOG1uVzZpWkVBNE15UzNCbEY0YUd1MUZC?=
 =?utf-8?B?QjRPWVgySXZVbStVcjdOaFNscy9OUDc5dWt6MUNSc3kvTnhzcjd5Y0RDR3Z4?=
 =?utf-8?B?M0l1K1k1VGZtb0ZCN3VtalZUN25EdElaanhxVW11MkZyais1M0lzUWQzVHZN?=
 =?utf-8?B?eENNcCtoRll3UGgvQm96Vnl0VzZoQ2pSVGhOR05QYU4vdDBSejdRcnlEZjRL?=
 =?utf-8?B?OXZ6TTdhUE9MWjlSaWtIaDRNaDRJOThhUXZHMVJMVDU2TDJWdW5UeGlKSlVT?=
 =?utf-8?B?WU5tMi9VOXdqVnZ1VEFySWtIaGVJcW9CZ1JtWDZCaWs4Sm5WVlNXREd5bGRH?=
 =?utf-8?Q?Dw1JsGJh8jK08odiunmVhkbqvLOJMkwD2OtcKa+D/Iyn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13def6c-cd5d-4c21-5179-08dde3d38b3b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:33:07.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfzHBFKF/LwYGmLQkohMq6YxgaVrw5fExBr+s55LYtLi+8/+6RGRK4mGxPISXYJZMibriIzYZcW4oSOml28wow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395

On Fri Aug 22, 2025 at 11:03 AM JST, John Hubbard wrote:
> This allows callers to write Vendor::SOME_COMPANY instead of
> bindings::PCI_VENDOR_ID_SOME_COMPANY.
>
> New APIs:
>     Vendor::SOME_COMPANY
>     Vendor::as_raw()
>     Vendor: From<u32> for Vendor
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/pci.rs    |   2 +-
>  rust/kernel/pci/id.rs | 355 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 355 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 0faec49bf8a2..d4675b7d4a86 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -25,7 +25,7 @@
> =20
>  mod id;
> =20
> -pub use self::id::{Class, ClassMask};
> +pub use self::id::{Class, ClassMask, Vendor};
> =20
>  /// An adapter for the registration of PCI drivers.
>  pub struct Adapter<T: Driver>(T);
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index 1291553b4e15..dd91e25a6890 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -2,7 +2,7 @@
> =20
>  //! PCI device identifiers and related types.
>  //!
> -//! This module contains PCI class codes and supporting types.
> +//! This module contains PCI class codes, Vendor IDs, and supporting typ=
es.
> =20
>  use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
>  use core::fmt;
> @@ -115,6 +115,74 @@ fn try_from(value: u32) -> Result<Self, Self::Error>=
 {
>      }
>  }
> =20
> +/// PCI vendor IDs.
> +///
> +/// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI =
SIG.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
> +/// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
> +///     // Get the raw PCI vendor ID and convert to Vendor
> +///     let vendor_id =3D pdev.vendor_id();
> +///     let vendor =3D Vendor::new(vendor_id.into());
> +///     dev_info!(
> +///         pdev.as_ref(),
> +///         "Device: Vendor=3D{}, Device=3D0x{:x}\n",
> +///         vendor,
> +///         pdev.device_id()
> +///     );
> +///     Ok(())
> +/// }
> +/// ```
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +#[repr(transparent)]
> +pub struct Vendor(u32);
> +
> +macro_rules! define_all_pci_vendors {
> +    (
> +        $($variant:ident =3D $binding:expr,)+
> +    ) =3D> {
> +
> +        impl Vendor {
> +            $(
> +                #[allow(missing_docs)]
> +                pub const $variant: Self =3D Self($binding as u32);
> +            )+
> +        }
> +
> +        /// Convert a raw 16-bit vendor ID to a `Vendor`.
> +        impl From<u32> for Vendor {
> +            fn from(value: u32) -> Self {
> +                match value {
> +                    $(x if x =3D=3D Self::$variant.0 =3D> Self::$variant=
,)+
> +                    _ =3D> Self::UNKNOWN,
> +                }
> +            }

Naive question from someone with a device tree background and almost no
PCI experience: one consequence of using `From` here is that if I create
an non-registered Vendor value (e.g. `let vendor =3D
Vendor::from(0xf0f0)`), then do `vendor.as_raw()`, I won't get the value
passed initially but the one for `UNKNOWN`, e.g. `0xffff`. Are we ok
with this?

> +        }
> +    };
> +}
> +
> +/// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
> +impl Vendor {
> +    /// Create a new Vendor from a raw 16-bit vendor ID.

The argument is 32-bit. :) Which triggers the question: why store these
as u32 if a u16 is the right size?

