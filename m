Return-Path: <linux-pci+bounces-42359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C6C97276
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 12:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 986714E2937
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D542F5A37;
	Mon,  1 Dec 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4MyJXYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C028DB46;
	Mon,  1 Dec 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764590240; cv=fail; b=Wgx5gn1CzGoFNa4JgIfonA7mnSFfM0ZBP6a95PyMp4W8FAveX6NRYWO8g2HP3MTkw7GGrfNJZ/Uhsy+g0UL35JsRpozVAFEaeJT9POsbpL7jNdwMv1AiQxFP0gpL1YRPCIfo2lb0M1aocIdeo67Cj/GWqOKZsz0Ka+tMrImQZxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764590240; c=relaxed/simple;
	bh=44pBIZZIfRaQgZoBKbz2YDSrvWocdWOKvTITT5j1SuE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=P6h2Yg3hoV+k2Xb+HcGnbwDm1k36xev/81r4b9OYGpwY5KvaVq+xx2Bj2jANHNV2JY6eA8atlWLATVI32AHs63AZWOd+pxGv3iXXCNv2EzAs5SZNFRDymidSnY05oc6RHXH0u89dNCGzeH54J/+uLdPXMe+jSYkylhdjGg8YQfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4MyJXYB; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM0JSAmLo2JrAMdaoeThwxTlBzP5ZEiTVItyHd8eN6nMecvpOqmmr6+HX1in5YKWMvt1lI1rPeNHbBdEuapvjUTdyW2A8VksYxEJKurEfbgFC5qtcZjjU5pLoQ0IJrcblrdy3EG/rE4ZAebAvPZ6wkmc/my5EJBguw3g8fIaU/GBvrijFempCXArkyT9/Ym00pT0XL7CwRAMW7bD58vWjySf9gA2bmqtSc6MujgUuLlrU4A50jiCHi/Ql6gOOXStYHYULXITq4RP0u4FSL5F23neP3PB5iff57wl6Y2yg//zUZySeOTWKxvgEGYWWc7cQWJziCnOFuH1rgjttaQaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6yyu1a/a74oaOEdSoMzSvpOxeV8b0rG2j3KNU3mwJo=;
 b=XiPM/2NgLxuCnXAVu6ujrMQbtj13FBaRTwjooKPmTGkYwEYVNZWBPPDNWG4lX/qDWDzIbU1LWZ3w34uwG3dJLMiGWKpP3PP6+2k5eynE/FOP/ft3xc1sTQJlbK+ayi81i6oOrfayQtTZ82FF9SAffp1wcrti9LyF7Dy/5qqdr9r2rKDq5Lgyc22sLl9E+ZJaxdHeCsWr5KkNZajCRECHk+jqj9DYmbAwhCWM13qKG7jbEZxI39ovX7OSoFw0J8gTR6Y3YcSB1TQZN9VQq9R2X80XMtY4YM6HTv413/5EJMj0zrhWjJQwTi/25EvXPIxBcqu2MBKlEfcJVpbnPh8vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6yyu1a/a74oaOEdSoMzSvpOxeV8b0rG2j3KNU3mwJo=;
 b=O4MyJXYB6QOeokgvaq3ZDKPAblnrXpTOciUrrY9WmGqW9TSMeumWpaaRLqr4mQJeT/ao3P6zaPrJMhKyeraZIw1ab9XMcDm2xfjyQ9sT0rsLFN533rzftgZXVv/7KGmh2MouJrGfQHbKeD8NwLV3stdYRU3gPDEd/72Oo8kjrS0Mp2kdeQB985cYwxYspgQ/NKVq0YhBuofuPQOhspV3bvQVsNGJBaZ51VvImpqcsGURpmO3GKFb8De/8eFWftIJK8Phm6HgIDBEgY6pSVfO81z4aXLi2tPsuJAeDdf49WRDcG0NGv6AL4HTXPVx3PGEa4sYEhGY55fJ1WBv0V4TPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:57:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:57:13 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Dec 2025 20:57:09 +0900
Message-Id: <DEMV14GBQWMC.28TXT8E5YO5NW@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
 <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com> <aSXD-I8bYUA-72vi@google.com>
 <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com> <aSbNddXgvv5AXqkU@google.com>
 <DEIO1A8N2C66.11BXTCZW4MKWZ@nvidia.com>
In-Reply-To: <DEIO1A8N2C66.11BXTCZW4MKWZ@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:3::24) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 35af7d19-3a2b-4172-8ebe-08de30d0c3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V05uSTZKSTdTZ1ZaN3l1eldkNGxvcTF0MHRhbW5xbnNiWU5DN1V1WEM3N2h1?=
 =?utf-8?B?NDRYN25TdmJvVkcrL3RlUWJSNE5KZTVHNjBhWnJjdmZvZ3ZGTHUwc2FYaXYw?=
 =?utf-8?B?RXgvR2pvMkFSanBaMWkyckhZYS9kMVUyWk93QVRjRHpxL1FoazJaejVySit2?=
 =?utf-8?B?RHhVdi93UnZ1L01OTEZCdlpIaThWMGgvTS82SWlTUmFyd2k5bUlON1ZvSFNt?=
 =?utf-8?B?M0FQZC80UjFCTlNUQ2l5RWRVT2Y4S0hsS3NNajBPT0g2QjJKM3prRlh5L1hn?=
 =?utf-8?B?Y1c3UzMwWGJ3cGdZNHZkb2pCUURRZzE1TjFnR3ZMRFJTdHRPUFk1SmR6aUlI?=
 =?utf-8?B?TEtlaDRFSWR2eG94TktBMlJlWHBuSFVOZ3RaVGVKdzVhaWZ1M1VpamFWcmNs?=
 =?utf-8?B?cWlpMFRVamk1blhxSVVPYmdhZ2Qvbm9FSnN3blFHazBrdnRmTW5LM290WE5Q?=
 =?utf-8?B?YVNUTjhSaVoyaW9paktqWlVzbFlHZ04vOElMRDl2VVM4SU9UZWlLWjFwc0lL?=
 =?utf-8?B?Z3gyRytzYkdUdERYWVJyNFBMbU5UclNBSUFjTm1mUzcyYUJQRHRWajZLVEM2?=
 =?utf-8?B?d2owY0sxOW5vZGxHRmI2REVROTRnWnVraHR2SGFLa0d4Ui91K1pjWnJwTzAz?=
 =?utf-8?B?SlREK29vNlF2SkJIY3lBcnlUNUNLcWpVazlJK2JQNXhYOTlPb3pxMkRlMDFT?=
 =?utf-8?B?aWthSm4yRW1HcU5UZHpkajc5MjBNNzl5ZlhPSXcvQWM4dDBhYk03b0FNL0dr?=
 =?utf-8?B?Vk5tUXc3M2J0YnIxVVRQUGgzdlR4cm0xM1M0dE9Mb0g4cFNqenNZdVZZNnVy?=
 =?utf-8?B?MU0xNkQ1ck1DRUYyOTRBZkZwSHcrSFg5TUEwMlVpdTgzbml0QndBanJvZ2Rq?=
 =?utf-8?B?ZEZ2UVlrYk81TVIxUlgvYkhjVk52M0Z1WWRVRGR0Nmd2MUZpN0VIWXJoRGZG?=
 =?utf-8?B?WXdyVmo5N05RZzVlNlY1NW84RjhZQnNkMEpudk1oRlhhSHk4L1RPdXlYMlZY?=
 =?utf-8?B?bVoyQUhmT0ZaamVwT2NoeXZaMXFyOEl3NlRDNnBMa0VuMlp3TjlFV3NpVWF1?=
 =?utf-8?B?RGFWWGpOaWxuWGxvTVc1M2U1NFVMZkc3cmhWTFBCTXE4cC9UZFNiZGpQRGNP?=
 =?utf-8?B?Ri9HY3hieVJVc083MHVtUEw5MFFzdC9UcURCOXYxNWZmUHBvdUgyM01zOXVU?=
 =?utf-8?B?VE9GYTB2a3VWeTF4TUFibFZDekdzSndGMlNjdDNBdWNaazFNOHV2Nk5NZXg4?=
 =?utf-8?B?YncvQzVuOVByZlJkRWR0Wmh4eDRLdGtCTkZjS0hWREM4TmV2NzBPYW0vQnFl?=
 =?utf-8?B?UHZtWGh2UnhOZDBnWE51UXpGR1p0SUlqUURJUjN5anF3a2hFOWFEK1VEQmdv?=
 =?utf-8?B?L0hlS1hCMXB5WmxySnBGRGphcTlLczh1dVRybXJsZTZ4UERCQUpZRmc1UDBM?=
 =?utf-8?B?T25HRlFKbmIvS2h4R2xmYnRwVjlnV0ZJMWJEcmg1V3VjbUYwRkdGYll1RmRJ?=
 =?utf-8?B?L1RwR2NuVkF4REozd2g3RjlmZFQ5VG0xalhBa3BYTW4rTjBtV2hpZTRwWUVR?=
 =?utf-8?B?WXdTY2xQMDdNaDBIRmUvMjVWL3gzd0p6VXZWYVlsRTQrVjNaSW1mSzdRdEVH?=
 =?utf-8?B?T3VzcnZqYUZkU3I4OHNZSmJwQUtSaDk2N0c0NzE5em5pVDl0QzQ0QlNWaTY1?=
 =?utf-8?B?Uk0wTnY3angzVUxhWVM4a0N1cU1paUc1UXBTNmx1aDlOSGNXL3FmcGxMRTNK?=
 =?utf-8?B?ejltZkdCMGZrdmU1bFpaQS9HQ2lsS0pucjMya1RPMVREWi9INUl2cU5KZCs2?=
 =?utf-8?B?YVZxdDN4eEVkWHNNOW5SSzViZW1SZTFCTDBDem9xSmVLZVNqeGIwd2phei85?=
 =?utf-8?B?N0tCd1RaemRyeXJpc0prUGNVK2lCbTA5dUtxYmlDdEdJY1NrTTd2UXI5V2sr?=
 =?utf-8?B?Mmd0REtLNlZwYzZLVSs1WnVET2VITkVXeVMyQ3l4UkFvenRzMkpVQXd4TEw3?=
 =?utf-8?B?ZXdUSXhzWFZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWd1dHRDd3h4VkQxQTVxN3hya3pLVUl2Wk5BWUY4eWladzFWNCtaNjVyMmVS?=
 =?utf-8?B?bFAvUlJLV0tVU3BvZ3pEQzhQZ1RxeVRQRFRRREtCeit1dUh5V1RQSmNWb01E?=
 =?utf-8?B?emgwRFU4RzFqTHRKekdBNFRIRVZkc3Flbzk5LzhMQmRoVDlWcXpncmt1SHcv?=
 =?utf-8?B?L0pSY1VlTVpmbEpTeTRlWXdZOU1EeE5lTnpYdDRiUnNvZWJXMFppRU53SG8x?=
 =?utf-8?B?K29vcHh4UkJ5R3VFVkNaQU05OHRxTTRFWDVLVmJJSjBhd3RVTktmalhjVllC?=
 =?utf-8?B?aFkzUCtaVm5KRjZvWjZmd3FhdkE3cTBHb3Y2YnplODhHNFpRUndqMmxMSWFG?=
 =?utf-8?B?UzhmTTNZYWgyU1lud2xJRitUV2N6WDlmUzhyVzVpSndGRDRnMWdvdlR4OWhR?=
 =?utf-8?B?ZGlYVDYyTTBwR0tJTERZdzFZaU1CQzMyaE1QT0NWaG1lZTlZZVdxOEVRYTM0?=
 =?utf-8?B?a2duaWJDelNyUk9mNE9SQ0dKSWZMazdlK0RpbVRlOHhYSzFhY1RiYUFaNHF3?=
 =?utf-8?B?aGtLZGFHeGxNNHZubWJKaGN4RjBINk5EYVlERmFkd2NqejlzcWpCZ1V1Nkp6?=
 =?utf-8?B?MHFrODZyb293Vno3UlhzSFFpS0dmcWc2bGU1SERvRU54bSthU0prc2x4c2li?=
 =?utf-8?B?ZGxKbHRjN3VCSmZwTm0yZUE5cjMxQXo1NjdtTjBYbWw2ZytwOURhYzkwS3hl?=
 =?utf-8?B?bGNQeE9kR2NzancrNDB0OUJobkR0WFFDbnRYaE1GSWlkcUhzbWw2RlkyMTRk?=
 =?utf-8?B?N1lQL1BPeUZkQllTdFV3cDR2akpaRE5kS1B1eFlOYm5pbWJlT1k1RitKQmxy?=
 =?utf-8?B?VFhTeUM0RzA1ZjVISWJ1R3VReldpVStCb1B0NTJYcjBoZ0pEU0pGODJ3ODJC?=
 =?utf-8?B?VTNhT3VSa1ZwdEQwVXpxZ2cxb0ppMUdOZE4zdlFDMHY2ZnpCeW01Sm9LRHJj?=
 =?utf-8?B?WlhSVEh1MnVBMVlWcHFqdzNPZm5QNU9sMTJFNUJnZmd5aS82VldQWlpzbDRq?=
 =?utf-8?B?bnRySXh4SXptbWJIRnRGUHlLaDIvS1dXUUpSS21JM3cvcVNNYzkvMEJWVGYx?=
 =?utf-8?B?OHN4THVkVktBbTEvM21FSS9qS1dLekM4bmliaHdrTVVRUW8weGVENE5LeE9Y?=
 =?utf-8?B?WGtPWmRwQ2M2K2Q4LzZVV0hDWkM3dDF4SEtHTlF4aE0xa1B6WG1pMkF1clJV?=
 =?utf-8?B?bVlMTTE1MW9zOGo4RUNKZzhOdTFqRHZIL1Y0OU9RaE5abm1DVWxuQUEyUkJB?=
 =?utf-8?B?WU5nbks0L1gzUUVNWjQ1dmZQa3NXK0JoQmtZMHRBamZSSmF6RldCVlhFQksy?=
 =?utf-8?B?ZWhsTlAzQ1dHOHFkWUFoaXdlZnhMSlNhaEZUN0hLMU9LNWZ6ZXZzRFA1OERl?=
 =?utf-8?B?a1d4MGRMUVRwQVZPc0dpbnVpTXpFKzlaSlJ2M3AvM1lzUHhUeldTcnhxdWVs?=
 =?utf-8?B?NFhYU3g4SU5nc0w5THM5UEpmTDZKZTM5aXFNbzgvN0V6bGNIMkJWNWtvSnN3?=
 =?utf-8?B?QVVLcXlGNEIvVHIwZ0tLQ3JrcDRKeGpORHMzMDI1NXZJZHovMWFHcUxSL0Fh?=
 =?utf-8?B?c1dzcXRYeHFENEx2UnlaVS9LUk9hZnVhSTF4Q1VVYktyODg1UWdDb2hPZnM4?=
 =?utf-8?B?cU9tTDFycENnL1I1QVVSMFFPTkVxNHYyWnM1Nm1xNzFMQVRVWmxVUmduZ2lv?=
 =?utf-8?B?ZG5kZHgxL0dVbGlFSEltN01JZTE4bzV3UktEb2daUDk5eVluTU5nR1paeG84?=
 =?utf-8?B?eHd6UVp0aWpZU001MWU2L2R1OEhuMzU5c3RLYmFyZlVaSUVQYnpQTVM3MTh5?=
 =?utf-8?B?VVczOFdnME9abjZ4Z1MwaEJ1YnVxZURmdkpOcTZCTWlqODl2Q0crWk1MTk1x?=
 =?utf-8?B?M250V1BqQy96cEp1cWZIbmJ0cmVYMXMxZnNuNGNXUENCcWFpVElXbEsreldE?=
 =?utf-8?B?VUQydFhoY053d29jaXRCYzBmZTMvQlJJNjNuL09NZWh2YVFoMGFLMTRRS1U1?=
 =?utf-8?B?NThmNExqb1lyUUNhQWtOUFA3VWUrSzFJSGY5ZlRxYzdmZXF5cFdVejR0Mm9h?=
 =?utf-8?B?U0JtRnJ1QmxoWGV0OVJnZm5NeGR1dUZaS29UN0JLbmpnZ2tOTXcyZ3h3bFll?=
 =?utf-8?B?Vi9FZ0p0c1lOK3AzRjJqd2NFc3lKNktRY3pWMmwzWkNVdHZ1R0FFcStydnJU?=
 =?utf-8?Q?M8Uw3cYWOO7B3szF2V3RYxDmqsZfjv7FEcOLtmU0nKyW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35af7d19-3a2b-4172-8ebe-08de30d0c3ec
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:57:13.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jauC8X2Hxs4tnlj5Pko1ZO/9CiQLx1iH9H6VwpJUaxIIdoPEOoC1e9WvHhb6HFK8MpPhyX8pYJWztIexrsATNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

On Wed Nov 26, 2025 at 10:37 PM JST, Alexandre Courbot wrote:
> On Wed Nov 26, 2025 at 6:50 PM JST, Alice Ryhl wrote:
>> On Wed, Nov 26, 2025 at 04:52:05PM +0900, Alexandre Courbot wrote:
>>> On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
>>> > On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
>>> >> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
>>> >> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
>>> >> >> The previous Io<SIZE> type combined both the generic I/O access h=
elpers
>>> >> >> and MMIO implementation details in a single struct.
>>> >> >>=20
>>> >> >> To establish a cleaner layering between the I/O interface and its=
 concrete
>>> >> >> backends, paving the way for supporting additional I/O mechanisms=
 in the
>>> >> >> future, Io<SIZE> need to be factored.
>>> >> >>=20
>>> >> >> Factor the common helpers into new {Io, Io64} traits, and move th=
e
>>> >> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing=
 that
>>> >> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implem=
entations
>>> >> >> to use MmioRaw.
>>> >> >>=20
>>> >> >> No functional change intended.
>>> >> >>=20
>>> >> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>> >> >> Cc: Alice Ryhl <aliceryhl@google.com>
>>> >> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
>>> >> >> Cc: Danilo Krummrich <dakr@kernel.org>
>>> >> >> Cc: John Hubbard <jhubbard@nvidia.com>
>>> >> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>> >> >
>>> >> > I said this on a previous version, but I still don't buy the split
>>> >> > into IoFallible and IoInfallible.
>>> >> >
>>> >> > For one, we're never going to have a method that can accept any Io=
 - we
>>> >> > will always want to accept either IoInfallible or IoFallible, so t=
he
>>> >> > base Io trait serves no purpose.
>>> >> >
>>> >> > For another, the docs explain that the distinction between them is
>>> >> > whether the bounds check is done at compile-time or runtime. That =
is not
>>> >> > the kind of capability one normally uses different traits to disti=
nguish
>>> >> > between. It makes sense to have additional traits to distinguish
>>> >> > between e.g.:
>>> >> >
>>> >> > * Whether IO ops can fail for reasons *other* than bounds checks.
>>> >> > * Whether 64-bit IO ops are possible.
>>> >> >
>>> >> > Well ... I guess one could distinguish between whether it's possib=
le to
>>> >> > check bounds at compile-time at all. But if you can check them at
>>> >> > compile-time, it should always be possible to check at runtime too=
, so
>>> >> > one should be a sub-trait of the other if you want to distinguish
>>> >> > them. (And then a trait name of KnownSizeIo would be more idiomati=
c.)
>>> >> >
>>> >> > And I'm not really convinced that the current compile-time checked
>>> >> > traits are a good idea at all. See:
>>> >> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
>>> >> >
>>> >> > If we want to have a compile-time checked trait, then the idiomati=
c way
>>> >> > to do that in Rust would be to have a new integer type that's guar=
anteed
>>> >> > to only contain integers <=3D the size. For example, the Bounded i=
nteger
>>> >> > being added elsewhere.
>>> >>=20
>>> >> Would that be so different from using an associated const value thou=
gh?
>>> >> IIUC the bounded integer type would play the same role, only slightl=
y
>>> >> differently - by that I mean that if the offset is expressed by an
>>> >> expression that is not const (such as an indexed access), then the
>>> >> bounded integer still needs to rely on `build_assert` to be built.
>>> >
>>> > I mean something like this:
>>> >
>>> > trait Io {
>>> >     const SIZE: usize;
>>> >     fn write(&mut self, i: Bounded<Self::SIZE>);
>>> > }
>>>=20
>>> I have experimented a bit with this idea, and unfortunately expressing
>>> `Bounded<Self::SIZE>` requires the generic_const_exprs feature and is
>>> not doable as of today.
>>>=20
>>> Bounding an integer with an upper/lower bound also proves to be more
>>> demanding than the current `Bounded` design. For the `MIN` and `MAX`
>>> constants must be of the same type as the wrapped `T` type, which again
>>> makes rustc unhappy ("the type of const parameters must not depend on
>>> other generic parameters"). A workaround would be to use a macro to
>>> define individual types for each integer type we want to support - or t=
o
>>> just limit this to `usize`.
>>>=20
>>> But the requirement for generic_const_exprs makes this a non-starter I'=
m
>>> afraid. :/
>>
>> Can you try this?
>>
>> trait Io {
>>     type IdxInt: Int;
>>     fn write(&mut self, i: Self::IdxInt);
>> }
>>
>> then implementers would write:
>>
>> impl Io for MyIo {
>>     type IdxInt =3D Bounded<17>;
>> }
>>
>> instead of:
>> impl Io for MyIo {
>>     const SIZE =3D 17;
>> }
>
> The following builds (using the existing `Bounded` type for
> demonstration purposes):
>
>     trait Io {
>         // Type containing an index guaranteed to be valid for this IO.
>         type IdxInt: Into<usize>;
>
>         fn write(&mut self, i: Self::IdxInt);
>     }
>
>     struct FooIo;
>
>     impl Io for FooIo {
>         type IdxInt =3D Bounded<usize, 8>;
>
>         fn write(&mut self, i: Self::IdxInt) {
>             let idx: usize =3D i.into();
>
>             // Now do the IO knowing that `idx` is a valid index.
>         }
>     }
>
> That looks promising, and I like how we can effectively use a wider set
> of index types - even, say, a `u16` if a particular I/O happens to have
> a guaranteed size of 65536!
>
> I suspect it also changes how we would design the Io interfaces, but I
> am not sure how yet. Maybe `IoKnownSize` being built on top of `Io`, and
> either unwrapping the result of its fallible methods or using some
> `unchecked` accessors?

Mmm, one important point I have neglected is that the index type will
have to validate not only the range, but also the alignment of the
index! And the valid alignment is dependent on the access width. So
getting this right is going to take some time and some experimenting I'm
afraid.

Meanwhile, it would be great if we could agree (and proceed) with the
split of the I/O interface into a trait, as other work depends on it.
Changing the index type of compile-time checked bounds is I think an
improvement that is orthogonal to this task.

I have been thinking a bit (too much? ^_^;) about the general design for
this interface, how it would work with the `register!` macro, and how we
could maybe limit the boilerplate. Sorry in advance for this is going to
be a long post.

IIUC there are several aspects we need to tackle with the I/O interface:

- Raw IO access. Given an address, perform the IO operation without any
  check. Depending on the bus, this might return the data directly (e.g.
  `Mmio`), or a `Result` (e.g. the PCI `ConfigSpace`). The current
  implementation ignores the bus error, which we probably shouldn't.
  Also the raw access is reimplemented twice, in both the build-time and
  runtime accessors, a fact that is mostly hidden by the use of macros.
- Access with dynamic bounds check. This can return `EINVAL` if the
  provided index is invalid (out-of-bounds or not aligned), on top of
  the bus errors, if any.
- Access with build-time index check. Same as above, but the error
  occurs at build time if the index is invalid. Otherwise the return
  type of the raw IO accessor is returned.

At the moment we have two traits for build-time and runtime index
checks. What bothers me a bit about them is that they basically
re-implement the same raw I/O accessors. This strongly hints that we
should implement the raw accessors as a base trait, which the
user-facing API would call into:

  pub trait Io {
      /// Error type returned by IO accessors. Can be `Infallible` for e.g.=
 `Mmio`.
      type Error: Into<Error>;

      /// Returns the base address of this mapping.
      fn addr(&self) -> usize;

      /// Returns the maximum size of this mapping.
      fn maxsize(&self) -> usize;

      unsafe fn try_read8_unchecked(&self, addr: usize) -> Result<u8, Self:=
:Error>;
      unsafe fn try_write8_unchecked(&self, value: u8, addr: usize) -> Resu=
lt<(), Self::Error>;
      // etc. for 16/32 bits accessors.
  }

Then we could build the current `IoFallible` trait on top of it:

  pub trait IoFallible: Io {
      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
          if !offset_valid::<U>(offset, self.maxsize()) {
              return Err(EINVAL);
          }

          self.addr().checked_add(offset).ok_or(EINVAL)
      }

      /// 8-bit read with runtime bounds check.
      fn try_read8_checked(&self, offset: usize) -> Result<u8> {
          let addr =3D self.io_addr::<u8>(offset)?;

          unsafe { self.try_read8_unchecked(addr) }.map_err(Into::into)
      }

      /// 8-bit write with runtime bounds check.
      fn try_write8_checked(&self, value: u8, offset: usize) -> Result {
          let addr =3D self.io_addr::<u8>(offset)?;

          unsafe { self.try_write8_unchecked(value, addr) }.map_err(Into::i=
nto)
      }
  }

Note how this trait is now auto-implemented. Making it available for all
implementers of `Io` is as simple as:

  impl<IO: Io> IoFallible for IO {}

(... which hints that maybe it should simply be folded into `Io`, as
Alice previously suggested)

`IoKnownSize` also calls into the base `Io` trait:

  /// Trait for IO with a build-time known valid range.
  pub unsafe trait IoKnownSize: Io {
      /// Minimum usable size of this region.
      const MIN_SIZE: usize;

      #[inline(always)]
      fn io_addr_assert<U>(&self, offset: usize) -> usize {
          build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));

          self.addr() + offset
      }

      /// 8-bit read with compile-time bounds check.
      #[inline(always)]
      fn try_read8(&self, offset: usize) -> Result<u8, Self::Error> {
          let addr =3D self.io_addr_assert::<u8>(offset);

          unsafe { self.try_read8_unchecked(addr) }
      }

      /// 8-bit write with compile-time bounds check.
      #[inline(always)]
      fn try_write8(&self, value: u8, offset: usize) -> Result<(), Self::Er=
ror> {
          let addr =3D self.io_addr_assert::<u8>(offset);

          unsafe { self.try_write8_unchecked(value, addr) }
      }
  }

Its accessors now return the error type of the bus, which is good for
safety, but not for ergonomics when dealing with e.g. code that works
with `Mmio`, which we know is infallible. But we can provide an extra
set of methods in this trait for this case:

      /// Infallible 8-bit read with compile-time bounds check.
      #[inline(always)]
      fn read8(&self, offset: usize) -> u8
      where
          Self: Io<Error =3D Infallible>,
      {
          self.read8(offset).unwrap_or_else(|e| match e {})
      }

      /// Infallible 8-bit write with compile-time bounds check.
      #[inline(always)]
      fn write8(&self, value: u8, offset: usize)
      where
          Self: Io<Error =3D Infallible>,
      {
          self.write8(value, offset).unwrap_or_else(|e| match e {})
      }

`Mmio`'s impl blocks are now reduced to the following:

  impl<const SIZE: usize> Io for Mmio<SIZE> {
      type Error =3D core::convert::Infallible;

      #[inline]
      fn addr(&self) -> usize {
          self.0.addr()
      }

      #[inline]
      fn maxsize(&self) -> usize {
          self.0.maxsize()
      }

      unsafe fn try_read8_unchecked(&self, addr: usize) -> Result<u8, Self:=
:Error> {
          Ok(unsafe { bindings::readb(addr as *const c_void) })
      }

      unsafe fn try_write8_unchecked(&self, value: u8, addr: usize) -> Resu=
lt<(), Self::Error> {
          Ok(unsafe { bindings::writeb(value, addr as *mut c_void) })
      }
  }

  unsafe impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
      const MIN_SIZE: usize =3D SIZE;
  }

... and that's enough to provide everything we had so far - all of the
accessors called by users are already implemented in the base traits.
Note also the lack of macros.

Another point that I noticed was the relaxed MMIO accessors. They are
currently implemented as a set of dedicated methods (e.g.
`read8_relaxed`) that are not part of a trait. This results in a lot of
additional methods, and limits their usefulness as the same generic
function could not be used with both regular and relaxed accesses.

So I'd propose to implement them using a relaxed wrapper type:

  /// Wrapper for [`Mmio`] that performs relaxed I/O accesses.
  pub struct RelaxedMmio<'a, const SIZE: usize>(&'a Mmio<SIZE>);

  impl<'a, const SIZE: usize> RelaxedMmio<'a, SIZE> {
    pub fn new(mmio: &'a Mmio<SIZE>) -> Self {
        Self(mmio)
    }
  }

  impl<'a, const SIZE: usize> Io for RelaxedMmio<'a, SIZE> {
    fn addr(&self) -> usize {
        self.0.addr()
    }

    fn maxsize(&self) -> usize {
        self.0.maxsize()
    }

    type Error =3D <Mmio as Io>::Error;

    unsafe fn try_read8_unchecked(&self, addr: usize) -> Result<u8, Self::E=
rror> {
        Ok(unsafe { bindings::readb_relaxed(addr as *const c_void) })
    }

    unsafe fn try_write8_unchecked(&self, value: u8, addr: usize) -> Result=
<(), Self::Error> {
        Ok(unsafe { bindings::writeb_relaxed(value, addr as *mut c_void) })
    }

    // SAFETY: `MIN_SIZE` is the same as the wrapped type, which also imple=
ments `IoKnownSize`.
    unsafe impl<'a, const SIZE: usize> IoKnownSize for RelaxedMmio<'a, SIZE=
> {
        const MIN_SIZE: usize =3D SIZE;
    }
  }

This way, when you need to do I/O using a register, you can either pass
the `Mmio` instance or derive a `RelaxedMmio` from it, if that access
pattern is more adequate.

How does this sound? I can share a branch with a basic implementation
of this idea if that helps.

