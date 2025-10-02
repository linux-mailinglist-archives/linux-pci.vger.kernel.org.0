Return-Path: <linux-pci+bounces-37386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF55FBB2497
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 03:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D3423D93
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 01:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730927B3E1;
	Thu,  2 Oct 2025 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKPh2SKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27F28E5;
	Thu,  2 Oct 2025 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759369436; cv=fail; b=odztMwJIcVMb4GI/Erkez71m225PKfddiz7z8GPzXb9V9/kyQ8IHjIWAXuVKf0QwPzcyJp786oefAlMjqQll4ZTP770W/DFcapUQEsDrpNSOsOoR7MwKFAJNoL8nAlaKZ3Q3ViuuWduJzJymMfq0bssubyLmTfngpLq5pSOAiLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759369436; c=relaxed/simple;
	bh=VaYeqruUxiO+Ta1qRTqxfplRuKigWOMuA6u3en7lI34=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WaE3TdzQPCepC7G8eMf73bvMimuNRNGejzlEYp4+o/DLdnJD0iCl+DiEIuG11UzQ6QaFR44/JEH0JNTW90qpuTwS5FF4pa7CIpkGKwB0XjZoYLXwlVj8Zg39iPyci64EHr8fV4Dr6AeQgiJ5VWRWc8cWmwS+WJAJWTXpwa0BfcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKPh2SKI; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbRg0B8w1YFnfg3EWvGfiJphZnZhDePldw4SpbKHCyJBXitRJy6wmgb9zoU9j057Q1qIQ18LiclHtFFXPiLwezfO/veJxJkoLA8GKOIb/Jn5SgU9bpW5mPtvsY8NCCifnB7YknK60FBE6vgQiHpNZqT/KHlktXTH7Mwik/89+6C3USlsm4S7leoO+FG40p8eyD9Toe40RLkhfqNsvLcvKhxTdXVq6IXjc0wXJEX9t0J/z7yC3jo3mL+r7736Yd0FR0sexbUSmq84ho45D9YtoEH4bjet7kTuyQW2NkQsjmSyr6CbK/wjFIHrsjF4kopLEWJAgjKqchC2mnpfMho6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaYeqruUxiO+Ta1qRTqxfplRuKigWOMuA6u3en7lI34=;
 b=pHLKN3EFQcQvQD1n2Kwc+saJAnTIdhDPMY/Zv0QsD4GKm0cCEcgsTgUSsT7yYEE85WSuSmdxB6qRmwGF+osA2rlqVG+KRTxY2mCADCmHkg1BLBlCh8lc2s4s46FSEWijtrfcYQJuXGvyPELnAp5vXtXRjd26E7i7yudp725OeqC1rUHtu1abBSXwMLs1Kffvn5XbUh7VmfXzJsn2WTswlEJ/3+PusxsTYytlNuoqY0EHfulw3DecFH6nkNF7wIEy+A2ZYQwwmbbcf8je/jXmFv254bosejab817K2XpM2wimH6eSV2NLKIJhtTqQagls5FY1jM+g3DMXQzt/WZd+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaYeqruUxiO+Ta1qRTqxfplRuKigWOMuA6u3en7lI34=;
 b=SKPh2SKIuZTuF0yvI83wKNWpG/i2gx1R/yOV6u5C7vcoXFp4TahbMSlif+ZvKQeZrUqNiMl9OlJiP8d3pspn3dpbDq7RSOsUxxcYV17AwiP1kwx3Qo/zYfIm41WN7xOJITjxkaTZ9bqgMRN+gwhSSCx9vuCMuSCM2NWGWZ05XT3um2aVp+Eo7iuJatkwE3V81DpzWyuTrgDuD2zqAFbV9RRvBNSNUW9/r/QrRx8uo3daPYqVBWKZ5tneKwVMtbVeRhgvT5RxISlKV7sFuaGBhGMyrYsPMpBubZDtpx9NtOUw7RtSoO/aG0nKU1bKGGQuv4Z3BajfJ7YOLq+X2h8ZHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 01:43:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 01:43:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 10:43:44 +0900
Message-Id: <DD7GERKWFHB0.3919YYC6AJA2P@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Surath Mitra" <smitra@nvidia.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Alex Williamson"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, "Jason Gunthorpe" <jgg@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
In-Reply-To: <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0156.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab2bd1e-d857-4284-3929-08de01552137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ykcybm9DdUE4Vlcyd2FQemxMZXRleS83UXYwTFBoTjRkTktoM1Ura2RwYUQw?=
 =?utf-8?B?RTZjREcyaFczQzNNY2RXd3Q0Z2YrRnFINzFFRUhoU0VXVnVlZzNiSDZoaTBt?=
 =?utf-8?B?L05jbHlVRFpBZGgzS3VvOVpOeldyakNnVGdnQlp0djFoV2tnK0dPbGNYSjlY?=
 =?utf-8?B?UGFubHpRU0t6UFM5NUNVdFJZcEZVUDRmNmc0azh1V09lKzZXSlFtMGpMQjF2?=
 =?utf-8?B?Q29tYWJXcnhtZHAvazQxRkt0M1BRQnlBcE1XaVNTMTFCTE4yMG9XMS9PeVZT?=
 =?utf-8?B?OHYvZ2tnT1Z1N3BIVnZ2ZEpKTUtMK1Rla1h3Wk05NkU4Mm41MVlDVkRHQTBI?=
 =?utf-8?B?OU5FVzJyZ0lOSGRBNTZVMW0ycXB2RSt5UkRrMC9ZcFRZZzMzQm52MW11TC80?=
 =?utf-8?B?YkJWaXNkaGdweURJcjhPOFVJd3BwM0RBb1VEalh1dlNkRytXSmpHN29HUzlx?=
 =?utf-8?B?eDZqaS9CaGtJSDZyVlRkNFA0ODNia0x3b25VeG5tRDk0a0pXaHJxcnhNdlc0?=
 =?utf-8?B?YklGU1Iwb2Uvckw1NHF3ZHZ1MVg1c2puOWxYQWFTRjZXZ3pRcy9BK3RDTTU3?=
 =?utf-8?B?T3ZZUHpGUytUenBtUnVTQU5KMStaVGhpOGREbDJhMzdrdXI0NHZ5MFBQcXVS?=
 =?utf-8?B?WFlRRlRUVTlyUGxLc0ZuVTQ2QndNYnNXcWhaS2s0d2FxRzcreUFEZnhzVVY2?=
 =?utf-8?B?NWh0YVhnTjN6KzJwbUVKZnRnUlJWSnorYThSMHBKU296dzJSU01ZL0kzRWxI?=
 =?utf-8?B?ZThFc3krSG1OOE1uRko0SFhrVzhRZlFmVGJlNzMxUmZWT0ZjcE1PcTNZclhR?=
 =?utf-8?B?RG5FOEJZYzM0NG1CeFZzVkcwNnR4Q1BlZDRxdzdpOHlhZndUMCtsdzdNTE5l?=
 =?utf-8?B?enNpNWJXYUdDeWZLR3dONWx6dG1jaDJLYmxYbU9TaHZTWmQycXdEN3kxbDlz?=
 =?utf-8?B?N2FZVXRRUDFrQUdRMFpmOUltUUFWaUc1QUUwVW5od1IrQTlndXdNaFlSMFpH?=
 =?utf-8?B?YnJnVTZBUm8vbU9PRWkwZHFKUkNUV2RtenY4ME1HVmZnM1NtQVgrUVpRa0dt?=
 =?utf-8?B?WHh1RGJMQmNqT3hzVmNBdUVQN2xud054cUpKbk5wc1pDMDRqd2pIY1I3R3dq?=
 =?utf-8?B?Ly9SdS96QUlIQWplTGtoeDhyRS9MbGVXNk45VkdSdlZaV2NyUVl5eXc3N040?=
 =?utf-8?B?R0dlSTJzV3NNeEZZRmlLVllDTjIxaTJxN1JoMmRFMmUyMUk0K2VnTWxNMjRa?=
 =?utf-8?B?eWVGNC96L3pHYzhaeDVzTXYwS1czVEZ1ZjZNK3FoZmR4MlhHZ2Y1cTk1dFE0?=
 =?utf-8?B?K2hweWQ1N0h0Q0xPR2xDTTdEZGpzVUFhVWZvaWZHeUI5QWdaYWdoZWszVUJ1?=
 =?utf-8?B?U21mZnBVQU5ZNXdVVTZXZEszMHNIamxIZmxTbHZqekFHdG12dnlSVjA5cGhI?=
 =?utf-8?B?cFB1Wk5ER0lQdzVQRGE4TEtna0hvMlFJby8wSThGTEYyai9ZUHpZTzhidHYv?=
 =?utf-8?B?VW5ZeUt1RldjUVpPY2dqTnhvS1I4cFUvZ0pMQ1JHMlFUSTAyWWdpditjRENh?=
 =?utf-8?B?UXpIbC9qMTFYUzZicjNZVWFVSTNJUnpNS2ZDRTMrOVI5OHdwejlmbCtUTUtp?=
 =?utf-8?B?MkMxRW5XS2hsMlVkOGlaVm9YQ0ZlSExuNldZZjdIczMvcWY5TWxyVVpnS003?=
 =?utf-8?B?NmgyaHFvTTliMHVJUlR3Z1FPNlMrK2o0MG9HdmFycEltOFYvTWJiVjdRRUZS?=
 =?utf-8?B?UXBSSWpBQkxkVmZXYktWWGlrbXhoSnJWbDJPeFZYZlNlLzVkTjV1SUQ3b1BW?=
 =?utf-8?B?RlZoVXhsVy9UM3A1Y2k2bmprSzBFSlgyMmo4OEFVdk50c093d0I1anR2eEJj?=
 =?utf-8?B?WUROYVBrNHEvU2tPVkZmUG1zaUt6S3ZZRUdrR2tPakFoWXhycWdldHh3VVBm?=
 =?utf-8?Q?MqgCHZV3HIElaO6sXh3DoxApVSpJOAIc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGZJbXJBb0VvaGMwT2cyeEdMMFNLMmV6NVkyU1RCTHA3QXhFSUNnb1FQWTFw?=
 =?utf-8?B?anBNa3VQbFUzaVdHVmpMNU9xOWVHYWFFcHRNOUlpd3FrQnFtcmVkWk1nbkwx?=
 =?utf-8?B?VDNEUEtYOTRTcmt4WFpYbEpuV2tCN0Q2UWVFSEh5Qk1tZ0lpK1VCc2xHcHhm?=
 =?utf-8?B?MzEwRWs0RVFveE1mZTBOU21aRXkzUTFTK3YrWkpTb2oyN1RYU3JVWllzU21L?=
 =?utf-8?B?UGhGZmh3MGJWN2RqL25PdjIwdW9jYmpXNUV0cGNKNGRZWHJlNDFvVkJEOVZJ?=
 =?utf-8?B?UGlLTUljRlMxQTRxamcwR21NREljZ0I2TGd6L21vZ2h0NkRrQW1sdVJaemla?=
 =?utf-8?B?YTJaUlllRHpsUC8zV2cwRjl3ZWpvcjQ1T0QyNnpweWJROEwwbWpZVUw0aWJo?=
 =?utf-8?B?TFVQdHNWaUZUdVNndGtnWWk0R3FneFN1cm4ya0wvTEcwdEZOczlqM1FtWUVh?=
 =?utf-8?B?ZTR1aitNT2FXb0c1cU11NmVpUmI1VVo5cS81ZHVtcWVTSktwSGtML1FoMGdi?=
 =?utf-8?B?MHU4Q2F0MC8vZ2hxZ2doRTNSeGZ2aU5ENFpuYkN5NW5KaWdNR0s5VjY4bXhV?=
 =?utf-8?B?aTNhTms4Um0rRjRaa20rNkFPNmVLN3QyV2xSRHdiWU9WSGJzTkk4WVYrcE0v?=
 =?utf-8?B?L1FXWXNOWkZCYitaYlZxaGcxR1dyWnU3bG9XWTFRaXZXL3d3ZjFQYU9YS1g3?=
 =?utf-8?B?M0ZsMUdYdVJZME1KTWNRQzFReXhhWFdaYUk2MDdGQWFqNE1RQ0pzaTJTTVlJ?=
 =?utf-8?B?REhkWUpjOE1GZW9aMUxqeXBaN2xpL3dpdStxaHlhbGNueTV0SVlRQ1lOV3R0?=
 =?utf-8?B?Y2VBRFZuNVdmMUIxOHhEcCtsU1RIc0hWbHBEV3NFZStzY1QyZ1BncTgxNFli?=
 =?utf-8?B?eFRMMW5rVW1OdjU0VGp1Qlc3cU1KY1Jha05jS3hpQjhZcENjMW1hZkpCRk5S?=
 =?utf-8?B?TVNKTjNuZVJjeHhWRm51RjVtQjJoblhGU3k5bU5waVFBK3QrcGxXWENCem9o?=
 =?utf-8?B?bHhtekxFak5od25PRnpPeHJCOXN4bXBBU1RhTFpXYjJJMUs3elVqNkhuUWZX?=
 =?utf-8?B?QTQ0MmZXTmg1cCtwSEdXT0F1NFpDdEE5SEFxTTF3M05tODlhK214UUQ2cFYy?=
 =?utf-8?B?eCsyaVgvL2Q3NzRwYkRZV1Jla0lrZmE4U2xzUGNuS0FlZlAwN001blkvNlRp?=
 =?utf-8?B?OGJ6dWFraDgyNXk4bmxhYXoxMUd3bEdGS2d0N1p6M0dTU3JBa2NqbVM0anQy?=
 =?utf-8?B?T0dWYklkNTdBOFF5M0txalhXQlZSQnF1czMrYlZxM0JxTG9LQW8vUXoyZXNw?=
 =?utf-8?B?aU1IT0loMCtaZytodE11aDNZbE9MWUJtMERVcEo4TEUrQVFPQmJuUzFjczdD?=
 =?utf-8?B?WHNvNUNaRVNzeENUQkwzWTlMclpSUWFJd1U2ZU9HUlhiaUo1NjJXK01ldVAy?=
 =?utf-8?B?SnJvZDJYTUhXdXlhaXBxRGIyTVo4ZjV5Z1EwMzN5d05SRVdFcWRDZTE2Sng4?=
 =?utf-8?B?WThXRWZ5MjJPUjk2U3lTREtjY2dTdVF0Y2R1ZHc2NU9pN1ZCbkJQREQ1N1FY?=
 =?utf-8?B?RGpDZ2RQaWNvU3NUdnRZSERSVjFWWmRjS0o1cWxZUloxSXdtcjlCU3FUdlFQ?=
 =?utf-8?B?Sm4yUXorNlpPK1cyK2w4cXlLdGJ3QnVuTzBPdjFrWU1MZjhXSnEzK1kwOHdm?=
 =?utf-8?B?YXhqeHNMZDNub0pLUHo0U1BFdnVab0NsdkgvS2xwdTRRRllmVlM4UXZMdkcy?=
 =?utf-8?B?MmxRckZLSUtoV1JCcHNGdnlld04yWGd4SFZhOU9RZnBlR1R2Q0psRGUxNzZo?=
 =?utf-8?B?dVB3V2NqRk44WXRPRGxuL2JSY0hDQ1dvUHJYZ2FiV1FBTXlQc2NoVy96ZHZ3?=
 =?utf-8?B?TmkzZnlPWEcwZ3I0cVI0b2d6L2dNcE43MlhVend4bDlxZmt3OE5KZlhvbXZP?=
 =?utf-8?B?SEE3V3BPZ25sRzRkQktMR216SGx3QVdSekVLSXF2R0xQV0RjQWhJQ0sxMlRq?=
 =?utf-8?B?MVUxeGZrWHp2eU5IV0RHY2oyOUFvc3RuNHlncmJKbGdDamxVZzB2TTl0NFl1?=
 =?utf-8?B?ekE4d01nK3hoVWhLVk1TSk0wd3U1ZC81eE42WWtvWTM2NFB3VHN3M3ZvaWNk?=
 =?utf-8?B?dE81YTRyZXZGQ1JmS1NCQUE3aXJ0amtmOG1HTUlheHFoU2Ywa01Fa2ZjNHI4?=
 =?utf-8?Q?L0S5wo9pALH07eGoeW+C/Qm050onB0A7XubXoFlGJ0jc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab2bd1e-d857-4284-3929-08de01552137
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 01:43:47.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIkh1QGs/kjRO01jold4LyA/gWSdBgRb1TgGgXZffcUG9935p1QErhiNAQF7eVB1DrJ7cxacgRyewAGYWuxrQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953

On Thu Oct 2, 2025 at 6:13 AM JST, Zhi Wang wrote:
> On 1.10.2025 17.48, Jason Gunthorpe wrote:
>> On Wed, Oct 01, 2025 at 08:09:37AM +0000, Zhi Wang wrote:
>>>>> But if the guest sees the passed-through VF as a PF, won't it try to
>>>>> do things it is not supposed to do like loading the GSP firmware (whi=
ch
>>>>> is managed by the host)?
>>>>
>>>
>>> The guest driver will read PMC_BOOT_1 and check PMC_BOOT_1_VGPU_VF flag
>>> to tell if it is running on a VF or a PF.
>>=20
>> Yes exactly, and then novacore should modify its behavior and operate
>> the device in the different mode.
>>=20
>> It doesn't matter if a VM is involved or not, a VF driver running side
>> by side wit the PF driver should still work.
>>=20
>> There are use cases where people do this, eg they can stick the VF
>> into a linux container and use the SRIOV mechanism as a QOS control.
>> 'This container only gets 1/4 of a GPU'
>>=20
>
> Right, I also mentioned the same use cases of NIC/GPU in another reply
> to Danilo. But what I get is NVIDIA doesn't use bare metal VF to support
> linux container, it seems there have been other solutions. IMHO, it is
> not mandatory that we have to support VF driver on bare metal so far
> yet.

For my education, what gets in the way of supporting a VF on the bare
metal if we already support it from inside a VM?

