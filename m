Return-Path: <linux-pci+bounces-25365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6EA7D6FE
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D8C16B5D4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A26145355;
	Mon,  7 Apr 2025 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SWhOVka+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2B17B4EC;
	Mon,  7 Apr 2025 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012681; cv=fail; b=RU6t11pjv1KvVvFRUA3KEUIeM4TPvYoAgqjJSfShOBKmfLVgfN1gjO8XviqH8pGIejMqfRXMlm7V5T4ZPUhRJZYnVUM5iCLVd5UZPQ6ncvzo7ljWj7wqO4/B49p4a47pKSzpIV8qKy9VRMR4umnh7NNnLPiTMPBXB5L1s/QGOrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012681; c=relaxed/simple;
	bh=rUujQPUeYwZ5K0VOwmMxOmZbECbQTFmsmx0AlzyhPco=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QHl0pkexqIVAkFpCzCEXMxuGk8uYnoArDgfl7HoY2byNnOROuoVY3GaLCmM0Bfv6yy2DjS+nlLKT+zh9sD/pO+1Qw6UKeRx5LIzHSRPHRS3LFBvHkPRLMhsmyuc64cviTpWTQA0Zij4/s95u2RJB9B1ukBlbVAHL2307CA0QEbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SWhOVka+; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfoMG9f3uCYOTmz+dXWVlyJFGjXNir4mH5z3fNsC/5y+1Trj3ZvSMh1e0Pc9tQnLkGChOOy5aWjXQC7OjSylLksCPnX9NvL3apwEH25NDsonXrvVLaD2AIyYFca/TTFInuOMXE4mk8/Q8CCjObTsODqAiaGzGMpr7vMuvTKe+GHF0z4sZe/LflBYbuLic5bCxwWnWIL2Tjteux/FFgewEp+GI/sGFyaiJ6IB6U9rUsueK/kZdK6bcQpiydJk2mDTcAXhT45DtwpmX8O7ixH2P16KTYUjR66RZbZi1XGu/0lN9cEOqSC//50Cv/lKOhRynzFpzd4G9ajVGNMyyoRduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od3aA4w/ssER5ZOhMCo8JoehIPwGsJVYdOEYJhCjQS4=;
 b=eZ+/UeB87AfQG8/4mG0Q9qmIg3cVk6UGEx4avtjQzypBxhv9/crbsFgCMv0ul6xuJTPjAIKXMNeJxWF4NUB+Zcz77invi2FoUa3F1v/5Lq+x+v/njeMxjZYObklD45KvtgY6aId9jvWSSD1H0uOkjJ9XnLARjsXxCCtSdjPdbBOefnXPTWHjPUzsajcTBW30ms1od4B8jQGmtPctnQv/Rdw7lZGPiyptLSsXGzUZFaFH4DS2BTVxg7VsxF5rFDQuGkB6X7x9ow8y/ZVwqVvU40jyhwxNQ1v16TOWZD5y+62cQge2anppIhHW5zH9wCUujy4ON8uBeo/MdiwV/XIYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od3aA4w/ssER5ZOhMCo8JoehIPwGsJVYdOEYJhCjQS4=;
 b=SWhOVka+sC8z3+tIq/jJrmj6eSq2FRxDXsVY+tSrIknyVGWfBaqKWJC63YCt/+OnZ54SmkG2171qHfrDx5d52f9f6iAa7s83tnEjnL2kO9oE1cJOcIu4T0D95wt5qNwFeObhq7byR7TBi+m7pufZGODyez/msGNQHg0paJoU5V0VZdQERTwXUG1+yFHA6qPG5UYukMrdyX8djy4K+N+AtaKQSoq09s4oBE9eN9Dg0HidlQ+NE2mRWnScknvfXuk1/sMGDemmfZjqV1E1sLpWtIRSBzXSqKJ2qDRXxjJkiB1ne2eAQfzF77faGEbNu55y8qwoszx5WFXMbvITxv3F4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Mon, 7 Apr
 2025 07:57:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 07:57:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Apr 2025 16:57:50 +0900
Message-Id: <D908W8AWVRHW.30H6WLUHQ7QZL@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust/revocable: add try_access_with()
 convenience method
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Benno Lossin" <benno.lossin@proton.me>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich"
 <dakr@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250406-try_with-v3-0-c0947842e768@nvidia.com>
 <20250406-try_with-v3-1-c0947842e768@nvidia.com>
 <D8ZVBUTCJXYZ.1X3I8HOSTXIA7@proton.me>
In-Reply-To: <D8ZVBUTCJXYZ.1X3I8HOSTXIA7@proton.me>
X-ClientProxiedBy: TYAPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:404:29::29) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ed6116-1d97-4d8a-9172-08dd75a9e6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXNVNWFWa2FYWlM0bnlSRGRORko3YUpCZnlRWk85T1NuRkFGNktiSThGNjJS?=
 =?utf-8?B?S05SVWVpem9jUTVOZ0hVTXBRY0ZaekJVam1XZlNtWU9TSk1KL1MzRTZSamxl?=
 =?utf-8?B?L0ZIRzFrdzd5blBmejdPTDUyTlp0TWpkclRsSGxUV0xhaGIzd2Jyb0l3THJ1?=
 =?utf-8?B?a3c0VGRWbGs2ZFBicG51OUk1SkluTkppRStWRHRyUUt1aFp5R2FyWHpOTm4x?=
 =?utf-8?B?bC9SOXZlUDRWUWpjUlhhMUtXVXRvd2s4M21IcG45bEQzeWVnS1NsdWdURGhk?=
 =?utf-8?B?RVBDM0Evc2poWlpxZWtJb2tqMXpidEhlZ1Z0TzhCeWdqOTZWdTJwWlVPN1JQ?=
 =?utf-8?B?cFRCTk1PVytNN0w1aFZza1phQVR6MXlzTEVQNGFwMEs3T1JweGlJSlRLSHZw?=
 =?utf-8?B?NHVwYzQwSlNoRk9Sei9mWCtsN0lUZEg3SHNWNTJmUE5iQ2s2am1aM2N5OE9R?=
 =?utf-8?B?NnhGT3JsOGxMbjJhZWdZS2FuRksyMDFOZlhXMS94bysyeXM1dzBBc3YxRkpW?=
 =?utf-8?B?b2d3eVQ3R3FPeW1YdXEvTjcva2FSNlM3MnhtU2hHeUNvOHkzUTUxQTNlcGor?=
 =?utf-8?B?R3ZMOWtmV25CSkMyOTFCcXNRalVHWnBiLytRRklGczVnQk1yd2JYUUVXaXVl?=
 =?utf-8?B?S0wveUFDc1dLYnpqdHNZcXV1TXZ4MDFXQTVhck9ZYmFDd3dibWl0RExDbE4x?=
 =?utf-8?B?dDN5VDh3aVpmS1ZsbGdUNWx0VXVFZWI1TENHeHQzdk1mNk44eVdZaG1qZEgy?=
 =?utf-8?B?RXhOd3VaYlFNSENFZndvV2RpOGQwcGhTWFpKVXl1OEFXZFI3VnVONkhZb3or?=
 =?utf-8?B?V0RVMzhXbXM1NlYvQStHcFhPY21NQmVrTVRYNlRSSTFUdXhxY2dzbFA3SC9s?=
 =?utf-8?B?S1B0cENVQjBVNjdOcUpoYUNlaXBTQ1RaRllUd3h2QVVURU5yUlJ4SnU3c0Js?=
 =?utf-8?B?NENTSldSRWhBZk9RaS9ieFJlVm5zTkh3T0x1V29UYjNvalI3YitWc3FndTI3?=
 =?utf-8?B?cS9xRk0zYzMwL2dGMVpRLzBidEkranY3WGJON05Eek40b3FDZ0JQdWY0eXFY?=
 =?utf-8?B?R0dKTlNqMnpNN3ZtVTJwRytNd0hhVjJMeVVIMFdSNFZwNVhEMU5RNW5NYnV0?=
 =?utf-8?B?c01uQzRnVTRkZVZZcm91aytpWkRhUnQrZ2EzQVBXM2toUHlyL2x3YmpxTXVQ?=
 =?utf-8?B?UWtLeUM1Y1JJa29abFU4QlhoUXNzSDNKcEhwVFZDaHU5c1Y3bVBqK2FsczZo?=
 =?utf-8?B?dEFMZXJua3JrcmJBWXowVjdabWM2cVRqVzNTYnRXMjVvTWptYXFvNFBUaCtj?=
 =?utf-8?B?UjhtOHUrREN3UURCVnVkSW9jQlk4aXdaaDNZalFUMWhKOTh6a2tzTGcveVJV?=
 =?utf-8?B?bEMxNGlBYksrVG41TlNNS3pZRTNrUHBGYmg5VnBndko4TlpLc0VDbVd4L0Jt?=
 =?utf-8?B?Mk1YVUtaeHVvWmR1WGVNWU9PL0hoN01MVDJyUWtqV09PWTVKY1h5emY4eUts?=
 =?utf-8?B?bkRSMThLRHVpZlh1Y2xMM0ZkRGFMZXFheTUwaXhTVGw4L2QrdGJzaU81U3pR?=
 =?utf-8?B?RkxuMy9tbkVINnlPcGpodUJKOEFzVVYvcGhBdk9rUUlXbkpBQi9VNm40QURE?=
 =?utf-8?B?SlIzZmwzZkxIaFA0MHRuckVvSWVxd0Z3Z0Y0ZXlLc2xMb01wcWhsSXZSWWxv?=
 =?utf-8?B?S1d2OFlLMkdjMEhxQVQwc2dLc1J4ekRrOXExaThEVHBqcUlRYVloNzVnQ1JL?=
 =?utf-8?B?Sk5hWkRIZG9ienlncDFZT0llalV1NGZSaDdiNlNlL0E3YzViVVQ5VC9JVEhs?=
 =?utf-8?B?Ly90ak5wL3hoQ29NMXUyN3FkTzRJd09oTW9wWGxsd1lySHJ6SjkrQ05OOU42?=
 =?utf-8?B?ZUdXSHh4cTFTWVBObUpsTlVkaW4xNmljM1ppdkRqN2VUMzdqY05lamJvQ2tD?=
 =?utf-8?Q?32l+gVl0Aco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlhXUjZ0NXdmWjF4UFB3aWd4OHZuMzBvSi9xRFVMbzZIak1TeWRlcDFNaVZH?=
 =?utf-8?B?N3U1OEVxT1RUU3k2bU1lUDNzeWJsUnpjQS9VVThnVStHQnF2eWxTMFZqd1Vq?=
 =?utf-8?B?SHd0SE8wWkRnK044Ky9VQ1FEa0NUZDhwMlAxdlllM2ljSzJVNDNIT3BPOTVN?=
 =?utf-8?B?T3R3SlVCbmFmWDR6c1lxZzJIU0VDY3IwSElVQmNTUzJCemZ3eW5NdU1LSkgz?=
 =?utf-8?B?YjhqNkNoeVNuMUFXOVJvNWpDbU5iYmt4c0xrNE10Z2l2ejArRzFZZXEwaW45?=
 =?utf-8?B?TlZFamZUdDFVb3EvVUl6ekR2aUVHOXY1aWlJNTVmN1ZoTGx3U0Z4S1VNQjVI?=
 =?utf-8?B?bS9IS2d1dnZxR2VYMVVxd0FySjErWUllS0NERHFER2V1bSt4NStyNFA2VVpH?=
 =?utf-8?B?bVViRHFhOXVIdWlMZGJYT2pKMWtsa25uK1FKTktER0RPaVp0Sm1RK0k3Zkdm?=
 =?utf-8?B?WWNpek5TeDlRbVk3N0pQWHpJYitoSlVaVm1JVlRWSEIwa1VyaGUzNStidEhK?=
 =?utf-8?B?SkNqMlJERExCME1aNnNPbjE1aHU3KzY2Qk9tNkNUNjFVdVNvNWNBOWdxTEpT?=
 =?utf-8?B?R05mMGo2bDJZMHZZTHVqVGR1ekNtZzdhZGFQb0szbHpPT1pHT1orcExkaVpl?=
 =?utf-8?B?N2xzeE5WSVgrdThGbjF4VGs3NXpXbTk5aUE1TnlDYmNGTjkzZ3VFVm8zWFdu?=
 =?utf-8?B?REl3Q3U4VTZZVnlrKzJSdy8wdjhUOGRoRzk4QTFtK2grUU1jTS9TTVBQMEIy?=
 =?utf-8?B?NVdyNVF4STFjZlV2RzVzTXNWR1VQdC9PUXVRODN5Y2k2SDFKQ1hPM2dSRGtp?=
 =?utf-8?B?TG1rZlltRkZtTnRtZ3YxY1RnQ29odFhVWU53aDlWbTJCME9rTW5tQzBWaDhx?=
 =?utf-8?B?NWtZN09TMVYwbVdvaGxObU1qajExSkVMOHpzYkI0QnM0emJlMzdLYkIwSUVE?=
 =?utf-8?B?NDV4QjFRa3JhUFNvVW5weWVIdndkc1VTL0hxNE9RL2h6cEtURmZmYnFkaXBT?=
 =?utf-8?B?NlhRRkZyS1RScER4TlRiNWlSeEg2aUI3NHIrdU9mWkZkVFRCTHZjRnBUci9T?=
 =?utf-8?B?dTI0Qlo3Mm11RHZTWWY0bDBMTEh2cURubjBkbEtnU2VFemRHU3p5Q2UxSWxV?=
 =?utf-8?B?QlMzUnJ5WTRoUjUwNmdGOXBtemZRVFF3UW9oTGd5bUFPd3Q4NDRKSEZKdkRV?=
 =?utf-8?B?ZVkvenpNOFVrZmpZQzZ4bzJrcmRmZ2ZxaC9nMnBQOHJaZllpOGs3Q2dnZ2Ru?=
 =?utf-8?B?UmwzWkVoY1R1MlFmVE85Rjl5cTdhUFNudElKNUpCc0lBRC9GNk9KMEJoeS9I?=
 =?utf-8?B?aFYwQmFZVVh6U21QL2JnQ1YwV05YL2ZZSStNdlMxQWUveGIwL2VEdkdOUzdV?=
 =?utf-8?B?VUQzUTRXNW5DN3c3dTUxdDBtc1ROTTlYMXR6b3VQektGZHBJNlloT1gzZVM5?=
 =?utf-8?B?WkdpS29pcytrbEt2SkpYcVJoaHFEWDVtZUsyeityeittcWlya1pSU0dzOTVC?=
 =?utf-8?B?ZWF0a2tLVXM0QzlYdURQa3A0cXZPYTVqS0djOVVnQzdBcks3ME1ZZzZUR0Vu?=
 =?utf-8?B?YkdJWlJVMHVZeUpXVU4yZlB6WjlCNlF5c25JWDA3N3NMaFl0N0pyS0VDd3pH?=
 =?utf-8?B?c25mQmEyMHJRQzRvSXJPQTlGSWIrTEpHRjVMRlJWY1hFQVFIbVRZVmdzM0Vq?=
 =?utf-8?B?Njk3RDM0SlRaY2pVVE9tQ25HZjc0SUtoZ2RqQmlMN0hzS0gwQnZXcGE0NkNM?=
 =?utf-8?B?cjRjdkZlc3YrdUtjamhuQXFvcW5GeW9Idno0cjF0ZXhzVU9WazhxRVNPRU1x?=
 =?utf-8?B?SkRxVWpvNGg3amZHUVM2QytKZDYxemtjTHh6YUh1R3VVVWJLN09VbXUvMDhq?=
 =?utf-8?B?cS9FTDJ5aTRCVlhyZW1SYnVLYVRCYXU2cENId28vQmltV2dxSWJPdC9rZ2V1?=
 =?utf-8?B?OE5RRVl3OWtFS2VSTUJmaDR0ZGNPYUsxeXhOeTFWdU85OU4zd1hRK3BrTCs3?=
 =?utf-8?B?Zm0zS0p1V3ozT3A4Z1IwQmNBUlBqb08rYzlKUVdkUk9ZQ3ZZQStycWxSTkNq?=
 =?utf-8?B?NXZxbEZBTXhTVVVLUW03TnJ5aTlleEtYMTY1MFdYR3JQVTVnK2lPTzNFbkQy?=
 =?utf-8?B?TlF1eENNOXpSYnlQdnd6MTBPSWhmTFllbzlnNnpZTkZsR3JxRUJuRG1kVFRp?=
 =?utf-8?Q?CB3cTDoMVCMZntGmD4ZJDYKYSW60zdd8NUTQmjxzOkM5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ed6116-1d97-4d8a-9172-08dd75a9e6d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 07:57:54.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPRl91v7HScqnpAQgD+HrrXzqxjpqKtgzzEvx9+sWhd6SmyGndpXrDkRCPph1hITqpllQ/Ceen1MWdWqYh/lJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481

On Mon Apr 7, 2025 at 6:20 AM JST, Benno Lossin wrote:
> On Sun Apr 6, 2025 at 3:58 PM CEST, Alexandre Courbot wrote:
>> Revocable::try_access() returns a guard through which the wrapped object
>> can be accessed. Code that can sleep is not allowed while the guard is
>> held; thus, it is common for the caller to explicitly drop it before
>> running sleepable code, e.g:
>>
>>     let b =3D bar.try_access()?;
>>     let reg =3D b.readl(...);
>>
>>     // Don't forget this or things could go wrong!
>>     drop(b);
>>
>>     something_that_might_sleep();
>>
>>     let b =3D bar.try_access()?;
>>     let reg2 =3D b.readl(...);
>>
>> This is arguably error-prone. try_access_with() provides an arguably
>> safer alternative, by taking a closure that is run while the guard is
>> held, and by dropping the guard automatically after the closure
>> completes. This way, code can be organized more clearly around the
>> critical sections and the risk of forgetting to release the guard when
>> needed is considerably reduced:
>>
>>     let reg =3D bar.try_access_with(|b| b.readl(...))?;
>>
>>     something_that_might_sleep();
>>
>>     let reg2 =3D bar.try_access_with(|b| b.readl(...))?;
>>
>> The closure can return nothing, or any value including a Result which is
>> then wrapped inside the Option returned by try_access_with. Error
>> management is driver-specific, so users are encouraged to create their
>> own macros that map and flatten the returned values to something
>> appropriate for the code they are working on.
>>
>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
>> ---
>>  rust/kernel/revocable.rs | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
>> index 1e5a9d25c21b279b01f90b02997492aa4880d84f..b91e40e8160be0cc0ff8e069=
9e48e063c9dbce22 100644
>> --- a/rust/kernel/revocable.rs
>> +++ b/rust/kernel/revocable.rs
>> @@ -123,6 +123,22 @@ pub fn try_access_with_guard<'a>(&'a self, _guard: =
&'a rcu::Guard) -> Option<&'a
>>          }
>>      }
>> =20
>> +    /// Tries to access the wrapped object and run a closure on it whil=
e the guard is held.
>> +    ///
>> +    /// This is a convenience method to run short non-sleepable code bl=
ocks while ensuring the
>> +    /// guard is dropped afterwards. [`Self::try_access`] carries the r=
isk that the caller will
>> +    /// forget to explicitly drop that returned guard before calling sl=
eepable code; this method
>> +    /// adds an extra safety to make sure it doesn't happen.
>> +    ///
>> +    /// Returns `None` if the object has been revoked and is therefore =
no longer accessible, or the
>> +    /// result of the closure wrapped in `Some`. If the closure returns=
 a [`Result`] then the
>> +    /// return type becomes `Option<Result<>>`, which can be inconvenie=
nt. Users are encouraged to
>> +    /// define their own macro that turns the `Option` into a proper er=
ror code and flattens the
>> +    /// inner result into it if it makes sense within their subsystem.
>
> I personally wouldn't have mentioned this in the docs, since to me such
> a helper would be obvious, but I don't mind it either.

Using a helper did not immediately occur to me, which is why I came with
two different methods initially. I'm fine with removing this part of the
doc if it sounds like it is overstepping the purpose of documentation
tough.

