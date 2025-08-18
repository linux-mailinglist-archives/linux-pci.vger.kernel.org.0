Return-Path: <linux-pci+bounces-34194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D9B2A1A9
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1600820674C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973C320398;
	Mon, 18 Aug 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XDiIKcA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965232039A;
	Mon, 18 Aug 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519792; cv=fail; b=TInq8/lNxRyaOaXZvu3OBN4xnAR7ulf9DN3ATN3mm8lVRhYuN0BDYVc6lQCLff6QxY5pimDzWA7h3Vj/e0JH5HV/KmqXUbcfP/tkmk4rdNyMbCrFguE/yQm3TkHMJmmahY65V5J8VH4J3MQdaLgEDiTLZaCPac0uJLZffQp0RuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519792; c=relaxed/simple;
	bh=ndRH8R+b/pS6IrW78qh2MenMS6dT7JFNSIwFcY60mQg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=lgs920eT/7L9JKPYhM6bhUWFzoGFcDCtPf3xECT5mDoo1VXQlLEr/vfQM8CsnA5YUkSeLiHuh2psTCiZGLuV6iL4A5KpPAuh3+Qan+bNroej3p/1+REg/ZmeqC8nVPN3R5Zn0ko9HSCRYHKOEsNgostCy1r14ARIHyI7MPzuRkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XDiIKcA2; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq1rWsUae8qRjidgSwh0vbK/Y7ZAw7azp2RrT2qKEpOinkqdPDIJteisKb1EgyvPbe1IDVl4uVsX7IeTvrFoFgF0fDQMoHFITRpyLNCTiNfyY5i5JoAZuaW1UvBZGoHI94jtG/qK1NXiVbldoIxOayk9dAITjje5q+MENsoHnaN4TBXcrxvvaAZfZxqsQq8d/SB0yHhqOVqWmUnV3NQWAP9LVkpm47saQrg40o87yO+2GIdnYTCUAlcNAYWqMRVysmY3LHfcKvz4jGPdmjVZq/37tlXRI5jf0+GCQSKAGqi8c53jPpI0jt6kdI+8cBw4jk3AWSyBi4CL4U3eEtektw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V0cfEFVUxxUetCHuKsOovxC2r9sVdhNcTkS+/aIScs=;
 b=hW2walgGNyFsWh9ODTF05b4zyKsQZoBxZJFbF+qI0qGTQAn0EHyl4mU9Moqw1O4LhUTdVU9mIWmrE9cjaTgAwLKCHHnd0z7DhgmzkBYSic9bAWVAlqDVYlBZd1Ed+m8YDrIyopGWw5Y4/jk/MocgDkGh3w7K2hRFlBGv6BbXOUyVH4mnoXNmgAQxcTYSE5EKhsRXtpqXNRS/0eV4S/M6EAVDy5Rly5Hu78ksT3k7jnDUDZo7yWbR+2gOjmC2bKYLAr2W+J8McNWZage6qvphkf6D1XZ34y5ZKDI78zqfaXDaDUrRWRnSxpkfROz2/POUdx2QivBI5eQTdvUAsd20Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V0cfEFVUxxUetCHuKsOovxC2r9sVdhNcTkS+/aIScs=;
 b=XDiIKcA2qcyPjSybbV7CtaM3glUBtuKr5hiCp3skBM8RWLFabazRFjb7IDLzug/AeQUiK50t6jodLpU3QqAJINUGMINYD4q/E/5E6eGLV/esGQgXi6K01SWM57C31ptHB6y9qmB4X2D8Qq9tz5zI8P2pwSfCw0x/SJupwCnTQOOwrFuzFt6nDuIl9odkpl77fcXNNBXh2fK9tFIeXrPEpqGc9jYNX1gfsPnP9xyj50piOJFpqZ4yFTte3p68oCiG0NuyNHB2EYM8zwP66sFeWMpeLucBoRZCb/Tbh+h9fAsOyIlI56MTU+W2fBxOnOjQij49hqrjkATZf23put60XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:23:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:23:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 21:23:01 +0900
Message-Id: <DC5JTQ7VHA65.2SNDMXYIKB9GO@nvidia.com>
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
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] rust: pci: provide access to PCI Class,
 subclass, implementation values
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-2-jhubbard@nvidia.com>
In-Reply-To: <20250818013305.1089446-2-jhubbard@nvidia.com>
X-ClientProxiedBy: TYAPR01CA0020.jpnprd01.prod.outlook.com (2603:1096:404::32)
 To CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5977178c-c77d-4032-6bd1-08ddde51fb54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE1NemlRWmdZVk1TRUY1V0hDWWszYitGK1FQcjF5UURuY3VTTkdFd0M4dDYy?=
 =?utf-8?B?NTlXREwxQnZSZHZMYWhKd09IM0VzTE5hT3dkbzFEM0lac2FydnEyY1M3UUV6?=
 =?utf-8?B?cC9YK3ZrVDdqbUxVVmlJL1ZJcHNiZExqNmV0U0Q1Z3I3NmZDNVNXME9mRzVh?=
 =?utf-8?B?eVpvbEFZQmJ1UDZGNWFHN2JPWXJMaThBdVNrdzB6QU5aRmN3SlBWT2hkanND?=
 =?utf-8?B?WkhQc09rRjBWNjN4M0RHRnFpQXNGaEQ3UnNlSGw2ZDdMTkozeEpXWm13ZEVS?=
 =?utf-8?B?aStxdE9FVjlKRCtZNXp0ZEZNVFY1YnBPTTNYNWtsTUlQVGNHKzR2a1orZ1dR?=
 =?utf-8?B?RlNWQlRYWjMyL1JDYlF6RnBUY0J4amFLYVliVktXWUg4bTRDb2Y5c25WZkxX?=
 =?utf-8?B?L1A2Y2xibCt4c1c1akJvWVBQbjloVXRRTVBVcTF1cVhLRjVLYUdTeFBrdG1B?=
 =?utf-8?B?bUMrT0I1UjlQcWFGQ2FRMlJKOSt1bGV0cjFSRkdSVmRyVm5xdVdCWk5MVW1h?=
 =?utf-8?B?emRpN1dhUVZQWlNhWERKNERvT1I1aFZqVjdIcVd2MjIvNDZsSnR2NmNSdTBs?=
 =?utf-8?B?R2E2RjBUQlJ5NkJTWmo3S081aVFsZHZSR3dYaEkzUzBVZndaQ1BFRXNmTFk2?=
 =?utf-8?B?dTJvblVaZzFpTERPMzJKQmZlZ0d6ajdoTjE0MUFncHJDNUZGRlRjazk2WkF0?=
 =?utf-8?B?M1JZeHJOVDhlKzIyT1VnZGZvaTBaVlE1QWJCdzRlTDRoUmxYRmh5MzVWZ0FR?=
 =?utf-8?B?TERnVmNqZUhESFE4Mk4yL2JNWHlra1cxTVExR1pySExBeVlPeEZjM2hNZ0Nv?=
 =?utf-8?B?N1RiZUloWnVUcTZoUExLNlF3d2llREY3am1ncHdlZHBUdWtJTFBzR1dwcGlr?=
 =?utf-8?B?VkhhOGVNVkVMQkpLSFB1cWZ3U2hvMFBNUTQ2V3pMZWxQdHpUdStGTTNzeDhB?=
 =?utf-8?B?NGdQblhBazhIZk83OXBuV0JFM0drbitaZGZqeTBqcWNwYmpMTEFINXNvRFlT?=
 =?utf-8?B?TDA5ZFBPeVl2UkcvZU1DVEJ1eTRDMS9YVlMrbTE2cHVjRmJXVmU4QW0xS3Vy?=
 =?utf-8?B?VGkxRnBtbnl2dlBlQzNlRmgyTkRLWWt6My9mbmtBN0pHUDAxeHN5UU1pQTJ6?=
 =?utf-8?B?a3l2NFRxcnUweWtwakMyOEdxSWpsQndWWUxUaXVHNVdadklFdjkrWXpNWGd1?=
 =?utf-8?B?ay94djBLdmtSY2RUeldUOW1vOEd1Q245NzlGOWlsenlDV05EWXZvQmRIR2lD?=
 =?utf-8?B?S0hrRFd0bWxBanRobTNEa2tFa3o1VXAxaHM4d1MrWjZXeCs0S3lhZ1pYY3B2?=
 =?utf-8?B?c0ZBVDNONHZBM0svUjhjT1ZpdG5uS2xINzdQWjNnL2NjVGs2SCtRT0s2YStI?=
 =?utf-8?B?WGcwRlpJMkdPaEZXdjUzL2dIcFFlbWZ3Z1dzazJ0RTZkc01IVDBqT2pSU0to?=
 =?utf-8?B?bFNtQWFQYms5UzBNdUJqYURBMkNlTWpXaGk5aStxNGFQVXBiZCt0NUtKMFVz?=
 =?utf-8?B?T3FLTE9BWEx3ZTlWTGtuU3lweVYxUHdDeTErcTB6Kzd5Mk5oL3ZCbjF2blBw?=
 =?utf-8?B?S2t1Z3FlVUNjVGZ4Y2ZQNkdGQjFLZXRBNDAwc09YdDJURVFHNXAvaWF2dGV4?=
 =?utf-8?B?aUxGeGoyWFlRNEd6TEUyMUpPZXg1TEZCZVlGMGVDKys5b2RiTStKK2FTNGM4?=
 =?utf-8?B?RTNCOGxVenRFQmk0SkRrNUJsR09ZTXZiK1NkamFYb24rQUxlUjdjOWF5cmJM?=
 =?utf-8?B?YmJ2UzlZbjZQOEFzeXA2am1YWitFQnM0NVY1S2Y5Vy9PYnY0eUgvUmZXMTJ2?=
 =?utf-8?B?aTFIVVBSYmIzRXdIMzJFR3NNbXVYcEJ4dklxTzF4SHYraHJ4SjBDZWZSWWVB?=
 =?utf-8?B?bGhXajhNckRoTjJwM2RrZDVTNmpwRWJjWnNmNTArdDVqVHZWZlBCVHJwbmNh?=
 =?utf-8?Q?sgzhmvBMyvA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWpaS0NUUC9SdnZUWEcwc2NRaTZEeisrVlNNZHdTbFFxZ1lJT0hKWUpjWVYx?=
 =?utf-8?B?bkd3WWYxWFZQNG5XL0d3TzFuK01tYVVaKy9HamdlL01yN0VRSnVGUFNBYTlq?=
 =?utf-8?B?NWh1YXN3YTQ0ZWNLeGVRd2ZNR1ZvMUtWRkREbXhRRGFEeDZEc0tiSldZVUdC?=
 =?utf-8?B?NFZ2TWNOR3huRHA5TjRGancyM0xHeUFrbDJYbE1PN3AzQjg1TGVQeVc1bDBy?=
 =?utf-8?B?S2RMRnFUbHN2ZGhmQlNJYUNiRE5VblRDZCtVTDZINXQ1OVNRU3FvaksvcXF0?=
 =?utf-8?B?TnBGMFp6Q3VGNWxpd3luV0FTeVRwbUFkMkxxdk1pMlFsb2Q0R3N2a2ZtaDhZ?=
 =?utf-8?B?ZVZQbzlmS2c2elVkeFc2M0dpUmJIbUZDNTVibm14cXNTN0ZLTW5CR0Z1L3Rl?=
 =?utf-8?B?TDU5b29QWmgvN2h0ZDNXK01aYUJKdjZwOVFwSUI4SnIzalRGckhzK2JqbjRY?=
 =?utf-8?B?WDhsVWg4V2RYMDFINjRCdldTeCtpZDQyc3FPYVFmWEZydEFiWmVYV0NWOVd2?=
 =?utf-8?B?NGdwMlRMVlFFRm5VS2tKWWFDakRPNFZaVzBxQXkxMlNNQVFmZS9pTkhwZlBM?=
 =?utf-8?B?ZUxpQ1VFNDdXWjJ2WVJRQlk0Y1duQ25BMC81eEJTbnBmalJpSkFMMktDMk1B?=
 =?utf-8?B?VXkzOUptbWpVQXZPOVpMRTZHTHYrQ3pHNU1TNUUzV2RnV0FwWDNwZ3NYbVBn?=
 =?utf-8?B?U0g5aEVnZXJIekN2aEVOcUc3ajJuekdGdlJLNXc4dHVHb3Q5WkYyVlR1QmhY?=
 =?utf-8?B?NklYb05VMEc5NWdQdzgrL3l5ZjVMZUJmTkhyVks4b3UyVG9vTEhUVGNWWmI1?=
 =?utf-8?B?Qzg5VmNLL0tPa3doemFYckV6L3ZFaFV2MVJzTjMrVzUxaVl5SDc5VVNQc1ZU?=
 =?utf-8?B?SG5LUE85TGV0M2hNWEdPZmFvSTFqUkJham1OVnk5bmprbE4xaTgzTmtSVVVB?=
 =?utf-8?B?WGwrOWFldXdieTNqTFhrSlJMZzFkRmcrUnlBbFVxM2hmNHJ5Sjl1RzZQVmVC?=
 =?utf-8?B?aG9CUm5pLzdhVXFlMkNUSVY4bW02UDJndFVRVXM3Vk1YWTVXd0FsYTlsVWxn?=
 =?utf-8?B?NFc1QVFkY0x4ZGEwZ3B0djlrNmxHN1lJMjc3WWVGZDBwckV4MnRQeTBJcTFI?=
 =?utf-8?B?aHNkekx0Q2doS0wzdFpkdlBvWUdmcDV3TC82SDRxa3NEZzRrS0gvNnZCMHA1?=
 =?utf-8?B?ekpsVlVqb1RJRG1zTDMrYXJ4TFVEeFRiM0l1Z2VyOHBheFdnR2lwYVlqNVFn?=
 =?utf-8?B?WGNzNmF5UDVVRm51OTJHdytPd0tqNTd4K3lNWmQ2UGRnbzVXK0VJSDJOZXha?=
 =?utf-8?B?QnJKVEtidEJrQndOSTZhc0lQRDM4UEllWDd1WDZsS2ZEVEJNekhpaHlaMTNG?=
 =?utf-8?B?NnVRMmtIT2JjeHEwSzRzQXJ0WFVxTVlMdE1NODlvKyt1SXdDWUVHSUpSN050?=
 =?utf-8?B?UktZWVdHd2docUpNQ2I4Yzc2UUVsQkhJVU5ZbkExbkNMK0pJTFRScGFsMzBi?=
 =?utf-8?B?NVVJZ3R4UnVld3p3OEtMNmtlbVpnNVh3MHcwZWFENFhyQ3dUaitZNHlEUm9M?=
 =?utf-8?B?QUJ4S1EzQmhTWndFaHh4M2xXd2h6dzR5SWx0SzZTYmdyZ2wrdmZIQ1dDZmx4?=
 =?utf-8?B?ZjFTMWROdXUzL2dZNEp6MkdHc1ZYUnpac1JaVTE2MktBK3hFWEhKU2RhNUVi?=
 =?utf-8?B?S2t4dGs1TlFOWlR1Yk9mL094OVVWSTIxTkd2U1IwOXVubEg5MDdYMFJ6YTRn?=
 =?utf-8?B?dzg2OVNnZkxhQ3U0R0dUSTAwaG5RdUluSmdycmFEclRWWXJoZUY3Yi92RmdE?=
 =?utf-8?B?ekhOaVBYY3MxcG9BbkdpYTBMK0xMRXRRWENHdGZQZVd6eFNwVmx3NjFYWTh4?=
 =?utf-8?B?SzA4b3VHRHhGRkMxb1FacmlZcmZWem9CcFRiU3h2a3Mrd1V3UzUyNkpRV2Ji?=
 =?utf-8?B?M2h3RGNKRWZpT2g2aEhGQmF6RXN6NTVYa3Z6ekhsa2NOdlgrNkl3RFYxZHhi?=
 =?utf-8?B?d2NHUTYzekorZW9EZjFyblRMbFhDVStjbWhtRHBRR09NcW5HLzJsU0VsbU95?=
 =?utf-8?B?RUdqZXpCUElxeVY2OFpUWjBzN1ZjRUYzUForSVdFSDlDUDJkc0NEZTdYRnB0?=
 =?utf-8?B?WlhJOXI0WHNGNy9zR1RnL1QvcXJJQW8wY3c3RmdOOVljNC85L0RucjQ1UEpB?=
 =?utf-8?Q?CL+XJT+mDPqEZxqLTafdmJ8lEGEKOq0SjW2QIxlgM2VJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5977178c-c77d-4032-6bd1-08ddde51fb54
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:23:05.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE9CBgFdMwW5wVM7Jy6xzvwViiXiUisowdrqeJRQ7mSP3+z7YPTbJ6/2hrHupgAx69ogf1RHa5zPqxnVndziog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

On Mon Aug 18, 2025 at 10:33 AM JST, John Hubbard wrote:
> Allow callers to write Class::STORAGE_SCSI instead of
> bindings::PCI_CLASS_STORAGE_SCSI, for example.
>
> New APIs:
>     Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>     Class::from_u32(), as_u32()
>     Class::MASK_FULL, MASK_CLASS_SUBCLASS
>     DeviceId::from_class_and_vendor()
>     Device::class_code_raw(), class_enum()
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/pci.rs | 202 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 887ee611b553..9caa1d342d52 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -23,6 +23,179 @@
>  };
>  use kernel::prelude::*;
> =20
> +macro_rules! define_all_pci_classes {
> +    (
> +        $($variant:ident =3D $binding:expr,)+
> +    ) =3D> {
> +        /// Converts a PCI class constant to 24-bit format.
> +        ///
> +        /// Many device drivers use only the upper 16 bits (base class a=
nd subclass), but some
> +        /// use the full 24 bits. In order to support both cases, store =
the class code as a 24-bit
> +        /// value, where 16-bit values are shifted up 8 bits.
> +        const fn to_24bit_class(val: u32) -> u32 {
> +            if val > 0xFFFF { val } else { val << 8 }
> +        }

This convenience function doesn't look like it needs to be defined
inside the macro.

> +
> +        /// PCI device class codes.
> +        ///
> +        /// Each entry contains the full 24-bit PCI class code (base cla=
ss in bits 23-16, subclass
> +        /// in bits 15-8, programming interface in bits 7-0).
> +        ///
> +        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +        #[repr(transparent)]
> +        pub struct Class(u32);

Same for this struct.

> +
> +        impl Class {
> +            $(
> +                #[allow(missing_docs)]
> +                pub const $variant: Self =3D Self(to_24bit_class($bindin=
g));
> +            )+

This obviously needs to be part of the macro...

> +
> +            /// Match the full class code.
> +            pub const MASK_FULL: u32 =3D 0xffffff;
> +
> +            /// Match the upper 16 bits of the class code (base class an=
d subclass only).
> +            pub const MASK_CLASS_SUBCLASS: u32 =3D 0xffff00;

But these two definitions (and `as_u32` below) can again be part of
their own impl block outside of it.

> +
> +            /// Create a `Class` from the raw class code value, or `None=
` if the value doesn't
> +            /// match any known class.
> +            pub fn from_u32(value: u32) -> Option<Self> {
> +                match value {
> +                    $(x if x =3D=3D Self::$variant.0 =3D> Some(Self::$va=
riant),)+
> +                    _ =3D> None,
> +                }
> +            }
> +
> +            /// Get the raw 24-bit class code value.
> +            pub const fn as_u32(self) -> u32 {
> +                self.0
> +            }
> +        }

So I believe that if you move the declarations that do not depend on the
macro parameters outside of if, the macro's body could be limited to the
following:

       impl Class {
           $(
               #[allow(missing_docs)]
               pub const $variant: Self =3D Self(to_24bit_class($binding));
           )+

           /// Create a `Class` from the raw class code value, or `None` if=
 the value doesn't
           /// match any known class.
           pub fn from_u32(value: u32) -> Option<Self> {
               match value {
                   $(x if x =3D=3D Self::$variant.0 =3D> Some(Self::$varian=
t),)+
                   _ =3D> None,
               }
           }

Shorter macros are generally considered better. :)

