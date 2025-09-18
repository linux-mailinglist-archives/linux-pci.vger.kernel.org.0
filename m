Return-Path: <linux-pci+bounces-36408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11723B83BC2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CFB3B72C6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D12D24B8;
	Thu, 18 Sep 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ceosfzyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764534BA44;
	Thu, 18 Sep 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187070; cv=fail; b=AVy4Bh+oU7t5BFcQApQWIgJ2rDJt/Nl1hI75K8vWTZ4rOO3G6CPj6DWYnJOK/CPW8wZYqyQT2dSUt3ikBLNv0uxsAnAJhWuTgVxXS0vpIjlXwv2r47RownKZnyxWfAd++tT0VtO3ehNDLLLA7PmGNf8XkSDFfK+ZJNHnHcodyXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187070; c=relaxed/simple;
	bh=QBfDMgkozls+WtzZHNz8iYtoZVUTjTt4UQwmk0p6GK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qiFyQMNT7r5S9Ck1lmqN4AsryaDPztC8JBk4/bMTANcSjJjI/cbrtKFz7V9wkOtU/9jpXSwZsXdcA5K7gJEEfHgVGRMvdju3boZMrthr0C8TOkjLJwJbC6zHm7oRmvaLcv4CmOF10rNyBpvq4t+eEo98ETemtuMNpisvXVDxDLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ceosfzyr; arc=fail smtp.client-ip=52.101.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD78smwtUNEW8y5s68xYfdnCXHswwr8adexYfQa/Z0lJLO9Pqsv5f//IFJ7KPIyirncBoTL+Olf7qbBp4iRjyLrDkPNtXuCwXBKUSVIqiYyBAFghtT3HaQ4G6HFjea6/G2EgKq7caS4ILcgMnyJeAzrnPwkWFHv4ftfYR3/0GkGRQbiCQpb3Yn3uJa4XWSP/DYCTpzyCbkSDGxD1v0aDcK4gHkSjG+L4VzrYjvizx928qNuAk3i5xVA3HzI22waWxNNtR8xqD19QfLxcFO+Z2Zz11NxwXOaGn6eQhLgBSN7tXh6WqysyxOXHkoX4l5CgJ9WJWjd/0hOsvf5H1kEeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp/A9r6vymaxZTeLr28+2TMleu1XYvnIBTYIC4lgXCQ=;
 b=StG2nmayalCkRQFa6/gqm/yTuTZ8ETxuN37ZKDrbg4kWQ2sqSkAaZKI+WA9n+yozHVZL+fwa/ucqq2N3z32hKuzhbjbNijW9IE0u5jr8hyeVIOJr8TK+qI5St0rzse8woG4mWmGX3YdXt0kdR/kbtQZ6/+cAV1BF6ghjLA89LUJ8LYH50FFM3cdFua3CiOQ/lpSduQXot0rj5KWNx8Vn4wkrweGLhoIGFfr6rj35cto92YZ7BXwZZUQ3dfVYo1HEtUlYVHampsciFuk5fPyylMkV6sppKHhDYULYfQZNAOKLu2edPPJvrNbvchMovR1raiabXyZpmLvG2p7mPPZjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp/A9r6vymaxZTeLr28+2TMleu1XYvnIBTYIC4lgXCQ=;
 b=Ceosfzyr+s1anS6ipOBhA69WX7OUs3URbn0NGKDH3FrqeNwSSrBN3l3rLuYigROGht2O4yGsQkHGTtd79jz+YnCqH6bWfLgPy1qb+cNHwSwAbV/ucocuUK0fLbdtJgSRCvR/wUtLYH37huArmFviiR4KKnI9RwQctcI2C7FZIXZ9cQ/A/E0x8ujZqiJ1X3z+7bxrDRpiAfYSxyR/jY1kQUczityo9Tnesf7X4OyosocahBtcg4jr5AUpvZM3V3ML2Ikm2aSCUp13kwINhToNPESre5Zik19yjZjYWYah3+YrmTVab/O4Ef1fwmA8kd0451GIqyVMUkr5obJr+ez+Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:17:45 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 09:17:44 +0000
Message-ID: <8fac00fe-2ad4-4202-a6f2-c5043f7343f9@nvidia.com>
Date: Thu, 18 Sep 2025 10:17:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/2] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 "open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250831190055.7952-1-linux.amoon@gmail.com>
 <20250831190055.7952-2-linux.amoon@gmail.com>
 <a743fd19-d54b-450f-a4db-8efc21acf22a@nvidia.com>
 <CANAwSgS-Oq7iXDtiWM0W8NZ2q=BcCGviJAUdscWJRvyxLsw0CQ@mail.gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CANAwSgS-Oq7iXDtiWM0W8NZ2q=BcCGviJAUdscWJRvyxLsw0CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a1bc81-bf53-4031-7a76-08ddf69439f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnRwOVVGQ3IrRXhSdGRLclNJb2JnbjU0OE9QUjVuNUdSQ21YaHUwSExEUDJZ?=
 =?utf-8?B?aFE3aUNaeUpTN01xNkVZcFJrUi9nM3B2TFdRcE1nZlZxQVZXWTh1QldodUp2?=
 =?utf-8?B?L01tSnN2c05rMTVLSFVOMG5Udkx3dWVsb09hK3pnU29WUVZqeUh3b0hjS2Rs?=
 =?utf-8?B?Ump4SElManRDTzMwN053Y3cyb3VTWkFlY2JZN0ZQNGcyam1iZmlTLzJ1UWdr?=
 =?utf-8?B?aHBCNTdFS3RVTlErQ0szT3haZmFqaldKTkFEbm5wOFdTa1dQQUZac2NRUXVl?=
 =?utf-8?B?VTZ1TTkxRW5MM1llMklLN0xyVHUxd0NUTEVVQ25aRXdJZkRLSzBrN0tCU2F2?=
 =?utf-8?B?b0MwZFVZRHZLM2dabnJQZndJTzB4QTlsckM3KzZCT0JRUGpIQUk1VWRjVFBW?=
 =?utf-8?B?a0FoMmtlTU9wSFc5SGVpNzc0ck40WjFzbjlHUkRVTWRHMVdsZE5BcjRtMC9G?=
 =?utf-8?B?YUNJK2FFRkNQN3hMWUl0RW5uRXpidDJLQ1FQRStEcURzYTIwM0ppNXNHLzlY?=
 =?utf-8?B?ZjBGdUlVU0huRWdhZkxSTmkwQjlwVHBqeU5tQ3U3UVpTMjBPTE5LalFteGFW?=
 =?utf-8?B?dWl3b3JVejZLZjVLTVFMUDhOV21wdnB3cmhmWVBFOFQyUmVBcyswWjZwQUpV?=
 =?utf-8?B?MFpGQytLbktTbFdQVVlma3JIbU42ajFjNzlXZzdkb21rclVjUDJ6b09ULzJ4?=
 =?utf-8?B?UFEzOVRNdUF1NGkvUGJqT2EvaGR4Z1g2NDc4SUQvMGd4MFlmOHp4UzFRNFpT?=
 =?utf-8?B?UmlDdTlpbkFORFVCZU14TGdLL25ab2Q3NGxtRFgzQUtLamFlOHhZSmpvTjlt?=
 =?utf-8?B?RGV1Ykp3djVic0NoWkxmc1ptV3U0Y01zQ0RNMThFWWZRTFpJWkN6RENnZ3pE?=
 =?utf-8?B?L0tFZkk3WUFRT3pEWDdWTzBvV1B4NUowajJSTFN6N2REMDBhRkhDR0FQVlpL?=
 =?utf-8?B?T2JxNTVsdGtQREhId3pxaTl2emtSNU1ta2lqbmYxNW1IeWMzR2pzSllnSlFC?=
 =?utf-8?B?VUhnVXlLZm52VzVZUDJGNDd2amlIZklrN29LVWpqOWNYK09hS2QxUjh1bWRq?=
 =?utf-8?B?d0Y4RlJkVEh2MXpPd2NIK2ExZnhCZ1FBYXdCYm1QQUh6bFpOUXV6TWM1c1cw?=
 =?utf-8?B?cmt3S1YzSEdWb1RPdCtuVDdtSVlqVXhXWDVZZ1RNTUh1Nml1cEFTOE1Rb2lm?=
 =?utf-8?B?TmNCbmpOTythMHpMMjZrOTVRM2U1eUlVZ3hoU0ROMWQ5SGNKUm5Fd0dWaFM2?=
 =?utf-8?B?aUNDMG5IY01jNHJ5eXR0MXdDbmpPYU1CM3FWeTNVemxUVGpxZTZMekpQZFRt?=
 =?utf-8?B?bkhleTdBZUY1UGNLYW01akxqY3dRNlpWR0lycTdxdzhuODJ2dGlmRFBWZUdM?=
 =?utf-8?B?eUVFVktINnRJUGZYOWExOXN2V3daVWFqblRXUWJlK2xHVFp6aTd0ckhZVFhT?=
 =?utf-8?B?Z3NmazlXMVZYay96dmtTRjhvZG05ZHE2dXU5MGhEYVVESjZDczNPeCtUNmxv?=
 =?utf-8?B?bXQvNGhxa3JselVYMkx0blRsN2RZVzEybHNSNlpvUGFkVG5KaE9kOXNONlhq?=
 =?utf-8?B?bWUrY1NpOGV6bURHTVhqeTZvR0I2WkgvQ3JtY0R3c0I3N01SbnZvN0JVaTJ4?=
 =?utf-8?B?MGdUdTVGdys5MTBNeWI3bWRWWjBxYnA4elprb0x3ZTZjZXpoWnk1em10dWJB?=
 =?utf-8?B?eDR2RUlld3RMRTJ2M0EwVnNWVG9aYm5jc2NMWjdVeEk2MkljNmJGWGIvaytM?=
 =?utf-8?B?dzNRdnBpWFV5VUtYMlRvaHg3YWhpS2g2WUtKWCtsb2Y4TXBxUDhjaFdoTWtN?=
 =?utf-8?B?NXpXTHdzcTQybHZnbCs2QjJSZ0p6RndKWEVQL2ZEaTl4SlJ0Y1g5WHphSnBT?=
 =?utf-8?B?UEx6VlhreVROMjVad0c3enBIUmk3d1FBdU9Mdm45SUNabDZIbStqWlQvbG5l?=
 =?utf-8?Q?6NhP+8dwhHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0RQQnd6WWpSUE1kbmg2amc4eTRCUllFbGJROTJlUEtBa2ZibFlmQndnOHdv?=
 =?utf-8?B?bjhoTkRSL3p0ODFQdW9hWkJLNHpQWXRlSVdrcFBFNUxZV3pVRHFNTnVacmly?=
 =?utf-8?B?T2w1S25JUTV5NkdReExnTm1XRm83VHVoY0pCK1l6YUFxUHp0aU8vMUlIaG1B?=
 =?utf-8?B?RW5GeU95eUYvNDFXbFc1NlU4Z0plYTRVdjhOR1h2dDVWYkVBOWMxSUk1dW1i?=
 =?utf-8?B?VXFQdFc1a1ROQTBwQ0h0czd5ZklvRys3ZnVKY2I5dk5YVmJDamJyUFFDMFFH?=
 =?utf-8?B?SzdVdi85Yy9oR2NHZkRsRDl1ZjJ5S1FPaGxYUzdVU1drK0VjdDdZZWRHYVZ0?=
 =?utf-8?B?S3ZDOUtZa0FKeUpmRUtzMmx4a1FldFNKOHRHcHdmYklScHhCbmlEc0p2aEh4?=
 =?utf-8?B?dWE3ejVQZ0ozakQ1Z1d5WVRWem05bFo1cjJWeHNiSEVmaS9Ja2RkZ2N2TWlQ?=
 =?utf-8?B?RUV6cHhFWXNrSXZJcTl0eVhVMVNkVndueUUwUlJ5cVhpcWF0ZVBpaEgzWUJV?=
 =?utf-8?B?UmxNR3ZoZHkyOHB5dktxNjdqTE5acGFqWUh1SFlqWHpwNzg5UzU3V0RoY0hy?=
 =?utf-8?B?Z1VlNFlXUlZHNUNjWGpSckFPdDZrTW1aaEprUGduckpZc2J6RWdMMUpaM1Nv?=
 =?utf-8?B?NzdLSkFjTjJONzMrWmpNYWpGN2U1TFFsWnZtVjh3dXcvbE9GVHRNa1A4c3FZ?=
 =?utf-8?B?Q0VoYUJLTUFWZ2tDN2hQaUdGQ0xreHE2R3pWbXUxNDBtLzAyZUE1MzBIclFM?=
 =?utf-8?B?V092WVFtekRZemxIZmVKMnNmUWw4M3J4dXpYdGlEY083SmNVV0JmUVFLbFNt?=
 =?utf-8?B?d1g2UGpKQ0FXbWtzc055YjJuSU5SbjNhOFBVWTA3WEg3YkpGR0IwYWQ5QXpz?=
 =?utf-8?B?K05hWDdpM3N4bVY1c0ZXMW1YaDE3dDBmOU5VQ2NkdW42ZDRxNmtzaHA0Zm1Z?=
 =?utf-8?B?czdSdHZ3Ui9iU3Y1KzN2TFFyZUplcThvZjVKSHh3OWZ2anFzOVh3YitPRllN?=
 =?utf-8?B?MXVwNStuWEFtL1RwNnhZMEoyOFV6NVhZUFgrdE9EMUl4aWNyRDZQcHV4OHBr?=
 =?utf-8?B?WmovQ2JGaDRXNXlsZmxKc1M1cGxmMVhUMWh6UmZqV2l0LzdXS3BsNmswdnNF?=
 =?utf-8?B?bVd0ODlFWEVpbG5mSEZkNlpqMXgvTU5wY1Q5NDRtcUVDV1JGQVprRW4yWGRy?=
 =?utf-8?B?b0NvSFZBUlpMQUtEWjdEZjh0clkzR1Y5Umlieno0YWgrWVJ0cXRMcVp4eTZo?=
 =?utf-8?B?RjBSdFdRamdaLzA5QnRIUFROZTZ3VG1XK0U2eEM3eHBoVkJWSkgybDVWNndK?=
 =?utf-8?B?V3hEc1Z1dUJwT3NjVnhsbEhSZXl5emhsVWZWOE90MmN3TFZBaDIrZ1o3TFBt?=
 =?utf-8?B?WkNHRit6c2FnMmhIM2dKZ1VFWWdaclk4d2hCUWd0OWRSVk1neGNhNXh1cWh1?=
 =?utf-8?B?OTBxT0RXalhpMTc1UGFrZEUvamVOekRSaHZuTEtNblVBdGJ0QnVSSXFFV0VC?=
 =?utf-8?B?TzNuVEpPc0oraE9EL2k1cTBlYTNsczFhUjBvTVR2Z3hzWkdUMnFYb1VoWWpq?=
 =?utf-8?B?OUZ2T3hpQzcxUzhreUwwY1puYmNEcnBSeVNzSUM3WDlPcWI1N00xQW4wbEVC?=
 =?utf-8?B?UnRkcG1aRVJWMnYzMmVUVUdvRVptamsxVzBKalhOcitVdWxXcFBZOU9jcDJW?=
 =?utf-8?B?STFWWXRyMnJRRFhYQ3VUNVVkZWM5LzJYY0pvV0NTVEVFR3BiRjk1aSt4Nkgx?=
 =?utf-8?B?MnpQekxXK3IzbFh1VlpCdlRDUlZMSlkrb28wM09TZWVhc3hmVncvTTdrLzZr?=
 =?utf-8?B?MnlzcDdmem41aVlvT0hmSUt6cmFaMnc3TnRQUjBKWnBOT09ITmx4SW8yQm03?=
 =?utf-8?B?UWpPMU0xWUVuY3RSVTZ5dHZQOUdEREVTUWNicFdEczJiUkVnYjhYR21rMDdz?=
 =?utf-8?B?aGFyaFc2QlViSytpWWxickZFVVcrbUl4WHA0UUdFSmp2dENpWHdkVVU0VWJm?=
 =?utf-8?B?ODVXNjluL1BwU1FVbE0vUkZhTVJsMnd4ajhXYUh6a0ZkcXBQUVVpU2FLWDNY?=
 =?utf-8?B?SEpZQ1FjS3Jyc1JORnZaeW1sWnRDR2toUlVZbGRPRHJkNXo0RkhMbUYyb1ZR?=
 =?utf-8?Q?D997nVet4U1KRzKKHMHOTM+3T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a1bc81-bf53-4031-7a76-08ddf69439f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:17:44.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0nMerV42PkqKZDDZZi5qxR1xBKMiKCJxmcjRWfQP9IckEnuMCNR/pzeN8vpjtwMRtJJRRlfji1YEr06h8ku7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254


On 17/09/2025 19:26, Anand Moon wrote:
> Hi Jon,
> 
> On Wed, 17 Sept 2025 at 19:14, Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 31/08/2025 20:00, Anand Moon wrote:
>>> Currently, the driver acquires clocks and prepare/enable/disable/unprepare
>>> the clocks individually thereby making the driver complex to read.
>>>
>>> The driver can be simplified by using the clk_bulk*() APIs.
>>>
>>> Use:
>>>     - devm_clk_bulk_get_all() API to acquire all the clocks
>>>     - clk_bulk_prepare_enable() to prepare/enable clocks
>>>     - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
>>>
>>> As part of this cleanup, the legacy has_cml_clk flag and explicit handling
>>> of individual clocks (pex, afi, pll_e, cml) are removed. Clock sequencing
>>> is now implicitly determined by the order defined in the device tree,
>>> eliminating hardcoded logic and improving maintainability.
>>
>> What platforms have you tested this change on?
>>
> I'm using a Jetson Nano 4GB model as my test platform.

Thanks. One concern I have about this is that right now the DT binding 
doc for this device is still in the legacy text format and not converted 
to yaml. Therefore, there is no way to validate the device-tree bindings 
for this driver. So by making this change we are susceptible to people 
getting the device-tree incorrect and there is no way to check. Right 
now the driver will fail is a given clock is missing but after this 
change we are completely reliant that the device-tree is correct but no 
way to validate.	

It would be great to convert the text binding doc to yaml as part of 
this series.

Also if you look at the dwmac-tegra.c driver this one still populates 
the clock names when using the bulk APIs so that we know that the clocks 
that we require are present.

Jon

[0] drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c

-- 
nvpublic


