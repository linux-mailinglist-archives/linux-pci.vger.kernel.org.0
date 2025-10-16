Return-Path: <linux-pci+bounces-38407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1ABE5C18
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 01:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E13B8EBC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC525C70D;
	Thu, 16 Oct 2025 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jw5/gSB7"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7961917F1;
	Thu, 16 Oct 2025 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655765; cv=fail; b=Cs6dU4TUa5KD+N/DGkvEvwipi9ehhBJGdxxsz0o3/8LySaggDdruT0QaVthnep1TkaDXd4mrdvqgBD7z4JglIQwPhY6ByA4YsWPBJtA9Rn5nVKQ8sit4auPW85JI1v8mAOL8iucGBYuU7LPNnnx+i5aa/dvuQVWFj3NXTGEo+G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655765; c=relaxed/simple;
	bh=OD5f+Rn9Lw6zjAnn3HqXG9TJ5U7r8NnX+MBTSEwMAGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=beMvYYWBoAmNx6v/DJgEaE8fEKw7G7Yrs71SvjnzH7XMFZ0AgxGGoK7m1SDmWL3tqlO+SjMtFS6MphXSbeXzt1o2JAPdVOcPrlZm8ujv/bUa+Se23Ccc6r8BZuhKOVxySyPExDHtx2zKy/Bo6tFE9fBYNKGeUNbtNcyNchhHoRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jw5/gSB7; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuUu5MxbrlSKHq5Egrop43p/jXLwbiTRfSh7OWf1j37Jg3mmyQerh7ELFGx0AIrcXII9+b1KIF2yladnTKNfJ2Hqg1YFEP76/B85keTP8Drnusq5E0/tMDG31H48b3OeX32Fb1r5ukJAoKWWrB+oz7TKR9yB7MKLTu5kyXSs/pdgBvVsqNiBFbWWB5fSrfqx3JgG1OPu2VzJJhqnOjb0fb70ViUUr98jpE72LVT/ZIU7wyBsoUmtzjNlxYopJqIGxIg3vR0HUJC0AU9x+dgF6eiaEKYrEkwWDJLA798Y0nIRre10OM5caa2zqVLDyzTyWaBv4Aq21P5r0Wx7qPFPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kismvsNEufypGCJVN/tT1SvB6mxCWfVgvricajZexAI=;
 b=c97AtjNj1HxYOy4ybAKRpcfyGZSpH+B79hJW30WLpPMEKpTmNFqCrYwwbVY5keGy0SVcsesibMsuiIfnKyq5uQ7+MOe2GpMh1lRT0pVlZB0T6APUkHiPKdzopb8B71PsYcSptMMpdNC/JC71NURGcoBOi0cVnMhvqKWKGiUXTCVavn/QTLbSptPMXVHZED0Wv1PVJGBInXxJAq/YoMY81HjmkGhftvele9h3A/x9hU/xg+6LX1NTUV2oT2cFgBlXpUqHPxYFLB7gX0853kF0cncs/oi7RRxCAqmUoKOuHlPBfjDHkZpienwkvQWLC8eBTSwZgx8yzW9Qovuga02Bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kismvsNEufypGCJVN/tT1SvB6mxCWfVgvricajZexAI=;
 b=Jw5/gSB7mY8WODITl2LEajkNgzQ/SfKzya64EyBlh3rgfbrORm+o1xoVGCwZ6pj3GRDNtXpsGP2UB9NU/+RrD618PVeOYFeaENHQhVJGrc852ztuJlvwKwjOIVz2jSufeaM2/g63V+iXjl13QjnHU/JOwpj2dMwjCc8mDKHKx/i6QeaSGwUt2+hMEs68f9kZlMkbY8Jor3Nd6ykF6I5erm8ofaOAfRWe9BcwPO3+mXfWjGeEgySj57+7dE1F2/r3go6qd8l3pKJlL3OzSrzDm++CdxO8/yL1iAmSQot2EFX8rW+bmXVOxVkbLVus7zfYOkzHbZMsd5VNIUliC+DPDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 23:02:40 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 23:02:39 +0000
Message-ID: <9643ecf3-7f55-4f4b-9e5c-26c2608fb4d3@nvidia.com>
Date: Thu, 16 Oct 2025 19:02:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: pci: implement TryInto<IrqRequest<'a>> for
 IrqVector<'a>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015182118.106604-1-dakr@kernel.org>
 <20251015182118.106604-2-dakr@kernel.org> <20251016222420.GA1480061@joelbox2>
 <DDK49THLLA3Y.242R8EP6IDZJ3@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DDK49THLLA3Y.242R8EP6IDZJ3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0652.namprd03.prod.outlook.com
 (2603:10b6:408:13b::27) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: c37ef4c4-795b-460c-b7fe-08de0d081b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elBIWU5ENXhlTnIxcytWYmRYZ01EaHJNUFV2dk1VdW1rT0QzNjVjeDZ0TzlV?=
 =?utf-8?B?VTM4MWo1SHpNaDczWHdxdERySFBhT3NhVUtibSt5azBiaWFiejN5b1JJVlc4?=
 =?utf-8?B?Z2FNSldVaUZZWVdUV0t3NjhKVVVFRzJQUFV1UGJPTHJTTTBaR1JvekgzQjJD?=
 =?utf-8?B?VVpndU9RTFpKeW5tRzI2R0FWVW10ZmJKbGc3SUg2MXB6Y1VNYk1xZjcvUGxt?=
 =?utf-8?B?MHpVcU1pemg5VkNSWFpQL2w1YWZBeUU1L3YvUS9nV0xSdVdRRHhuVjM1RWdN?=
 =?utf-8?B?MXVrSjhRZmQ4ZDdIenE5NlpVU2FERUhsbmIzcHhaLzdBbFpWcnUxUGdvd3Vj?=
 =?utf-8?B?OVg2TFBMbnNtM0pta2U1bDJ6UUVHWFVaQUtzcjBGNnE0bDdTN0o4QVZ5VnQ0?=
 =?utf-8?B?Uzh3ZGIzMUFWU0UySG9WTk45ZVZJOHNFNmIrRkZZM3hyQ21TNFowVVpvQ2h2?=
 =?utf-8?B?Yi9wdXozMUw0MjFmdmRXR1FyTjl6c0lMOUhZdkJYOTBmeHFmN2tDR2RkSWZh?=
 =?utf-8?B?ODJ6dkxMaXVpeit5VnhXOWNUNzRCd0dGYWEvclJyRXhxbEwwMEE0VTZ1R29V?=
 =?utf-8?B?MWo3aU5lb2pnd2t2YUh3VFdkVmpwMElqRVJheXU2VzZNUXNMVFA3VGVIeWNK?=
 =?utf-8?B?SnVZWG41MFVDcVpmSjlVbXVkaWNjeDVSU3dKcy9TUFdSL2w2WllkZGp4Umds?=
 =?utf-8?B?clppazdYUDRjSWtYQ0x0SG9vejNBZllXTnlpVEN5K0xiaCs5NW56d0dpOTdE?=
 =?utf-8?B?SUREdnBVZVhKdXJZT2N3NjJCaEl6bVU3bFRnZSs2QWVEZHFtVVhJa0lremwv?=
 =?utf-8?B?N090RlQ1NHYyamtMT3ZhRFVRdG1UZUhMTHlaMXo3bWkrb0orRnNydWptTVRh?=
 =?utf-8?B?UGdsUzBHWWJvdnltVW5EazJldlRJeEMzRWUrd2xRbFdwbDYzUHhwWjNOOHoz?=
 =?utf-8?B?Z2laVFozVWZxRnlwaGlrZEY5UWlQdXRueU9EMGlIT0Z2dU9tNE9INnd5NXZP?=
 =?utf-8?B?SHpDbmpuekNZdU5JcndWbnBhbnNHR2JYV094TnFwUXo2ZXFyVXl1M1ByNFo2?=
 =?utf-8?B?OWZlR3R0Z2dJcmRXc1Q2azl4RXdKS1JyUE94WFBzZFZyYnBHMnQ1V2JXSXpa?=
 =?utf-8?B?Uk95djR5bFlTOE92OTNoZGdmNjlqbTZ5L0ZDVm91OElpdWZqNnc4N2xoMEFn?=
 =?utf-8?B?VWJpRVdzbmRjQlVWNXNkY3dOOWRBaVFkQVVMUjgzZXYwNTBnUHBLYmdnRmJ3?=
 =?utf-8?B?bmJBellNMUVBOG1QRDVrQzRFMVVXOHBhRGsrTDlQUnh6c1Y1cTRnRHBKdC9w?=
 =?utf-8?B?SnAxc1VZQXZwRFdNcXRKWTE1MGp3V3RhVHFxaWFxWUNRa2phOFhyMk1abGwz?=
 =?utf-8?B?SnVuRjd2bkZiaXBROFRIR3d5NXN3NGZpZi82UDNqNnVrM2pqSythQXcxcENn?=
 =?utf-8?B?YldLazJHWU1kMGpla2l5cmVSbk9PeWFxbUJiK2RmNFZWY2hMd0N0eE1SL3J3?=
 =?utf-8?B?dFVHaUVwV2t2Mm5qVVNQZkMvM0w1dGY0K1hOaVA1aDl4eVJKVkNEeHFlRm1w?=
 =?utf-8?B?dzJJZWFWb1M2SUd4MkRaV0d4Qm9TZjAvdWxsZExRQU9VUWpCYVJyajJkdHZv?=
 =?utf-8?B?dzhMZEVTTEp2azV1YS83NzEvUTM3NnpOLzN3QytzSXRLbHNxdDZ2SldPbFNR?=
 =?utf-8?B?aDcvRVcvSHNyd1JhNFhGZjJ3Nm5idlovaGxqdnY1QnZtd29iNHFraW5GejdQ?=
 =?utf-8?B?L2JIN2hsSE42Q241V0pHbSs4a0JoM3dHY0IvVC9qeWxwSVBrUjFQa3o3bW00?=
 =?utf-8?B?M3pZalZJTW1icnNOb2kzbFVsTU9BTTEzL2xpSE5WMng1bDFLNEhadzJITnNs?=
 =?utf-8?B?RXAzUzFPdElWUEtsa2NLVGMwMkEraTZBaGEwc2VjSmFFdk10U3FVMkhhc0dN?=
 =?utf-8?Q?VZ8C3nu8mhsgp+rWxO3uGAHtOodAGqie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmVmTG9mZzJSRHV5Z0JaYkZ5dVNtNW9ScXBMc3dqOWdEYy9vUzZGV0VrZ1BT?=
 =?utf-8?B?VXVIZ1JhdWZMWEVKdXE1OWhRUWR4SW9vb1l6Y24rNkRDaERzaFFmcjZFMnhG?=
 =?utf-8?B?V09sTnR4VG4yQllQNXp3Uzh3dUs5cnBMU2JTTjhlYXpNZ2QxTk56T1NVY2VG?=
 =?utf-8?B?S2ZuREZ1TGhCTFRJNTJ1TTh6bk9RajhJZE0rUWFUMHBlTnBaaDFaY1B0YU1m?=
 =?utf-8?B?TDNPeWxMYmd2TWFRQjlPNVA1dWk1ckx2ZkhxK1dobDRYQkszYVpJOHdhdU9E?=
 =?utf-8?B?enVwVWlYekYySTFTYml2a21TckxuejZUdHRUWEdDTVlwRDVkell1UHp0dXFj?=
 =?utf-8?B?OTJuTGxrUmVuVmp5amNyVC9kR21oRHVabWdRNFpta0hzbzR5bnRrSThUT1Zj?=
 =?utf-8?B?WnB5bndXOE83ajhkQXRLcFRjN3NKRlhvRVpnUFZJRitZbFFpVTlocnBqK1lB?=
 =?utf-8?B?c1o0aFlRWE9jZWpQR3Z5dDZkVHhoUXNINTdxT2NsdDdCdk9uemRhMm40WTdo?=
 =?utf-8?B?ZittUzhPRUJpZjJnK0ExWW1sVEppZm5OWkFyNkEyajdRMlpYQWNhRG9LaUdG?=
 =?utf-8?B?allQOVc0RVVTMW0xMnhGYjNPVUJsalhkYXNwa0Y4OEE0cEJ4ZFBpVkJBNzJj?=
 =?utf-8?B?Q2E3b0pKYUJUajErK3RCc2lKMGdzS01GWkczSURvTFFZK2VER2NFTXZtcjgy?=
 =?utf-8?B?NnFiaERkMlZudTdsdTZVblYrbnc1d1F5cmJlcTZGemdXRTdwanhnTWFTTk1F?=
 =?utf-8?B?UVBrMCt4Y3JVRFhNMzdHM2tvQWZtbVFVSmwva25lSmJsZHl5NUF6SGV3Y2Rt?=
 =?utf-8?B?MGh1eHRtc0Y5TmdicU1xVlNORnpOamF0cDB1MGt6aXZjMm1nck84eUEzNEJy?=
 =?utf-8?B?aTFSRjEyS3ZWOXJySG1CN3lDMDhTZFQrK25qYXlMRExRZjNNQVNEbHFZd0o3?=
 =?utf-8?B?UEUxQ0l3TG05eGtlY1VTK2dvOVdBNlBKSHQ1MloxQ3A1TXkwWXNRd2JaeXFj?=
 =?utf-8?B?WG9NRlpUaHN0dGFiTVBrMTRmNGxQdTF3VDdHUTBUNE1adUdrSng2QkZpR0Zu?=
 =?utf-8?B?YWgyV05hU2MzNW1vcGZLWm12VWlIZ25QOU4wWUllR0RleEJXR1hqOElPcUN6?=
 =?utf-8?B?dE5MdGRyQkJYYS9OSlBzNHhKbXJNd1g0MzZob0FoTHU2QVRQdTUxRFRlTVBN?=
 =?utf-8?B?Rzk2eUxDOHN1L0RNQ09OTXdKYkcwRnlFQVhPeThNRDRzVlBXYmtpdTBOSjhC?=
 =?utf-8?B?K3h0S05HdEtPVGJxb2RCRE82MkFZWjhqODRrTTA1ZVdTRWhmMStQUXl5Ynlx?=
 =?utf-8?B?amZOUDhqNWdVejgwRFB5NjgzdVE2STNDRmJxTjNHNForM3ZMV1RxOW1vT3VU?=
 =?utf-8?B?ZE9TUUVCOGlCY0Ercm5OYUI1YmNtcDNtMHUvTVVtZVRqSStwKzl5K1hPWkll?=
 =?utf-8?B?aDhQU3RlQTJ4Q3JPNFZ1S2FkSXNqaUFIL1RCZXlURlRoNEcySGlXUzFLZDdq?=
 =?utf-8?B?cjhLdTRMN3lDQ1R6S3A2aU5tOHR3QlFKQUUvWXFTVkJWWHd2ZjFDYTBOcHg3?=
 =?utf-8?B?akpweWhlbmw3bDRTeXZhYmFSMVVVaEh6VU53RXVTcWw2VFNKbGw4bkVickNl?=
 =?utf-8?B?dmE4ZnYweXhzT1hqN3ROTnNoMHNvYmdSV05QYUJCbjlwYnBBY1EyajlhMnpr?=
 =?utf-8?B?cjdtYS9IakRyRmlZVnI1KzdqMldIeUJzRnpGRzZpMDZ0Rm1LRjlnMkZwMEk1?=
 =?utf-8?B?eTZ2Y2lJdGZDQmRKNW9ycXVwWHVSREQrZ2d0bjkySHN4U0IzYitVblBLL1Nz?=
 =?utf-8?B?QWhLTzFpRjFZUElqU0JuNENMalhuSDhISDhTcytteWxmd0pKQWh6QWMwTDF6?=
 =?utf-8?B?Z0pYMFd3eDQ2OEgzVXJQNlFOTVFNeG15cmRaejYyQjZvN0YzVXNNVmF6Zklj?=
 =?utf-8?B?UW1GQkFWNk5wck5JTnR1ZXdOTlR4QVVWbmFpSk5vak9Kd3NBOExpSmxkU1gy?=
 =?utf-8?B?WWd3dUVMV1RCeVh1WHpKL01qMmVvSkoxYy9RMnVtRmR2VXVRZjA4a1l2NExT?=
 =?utf-8?B?T1hxRHh2SXNaQ0Jid3VSdkEwRzB2c1VIcHhDS1pFdDdIc3VWVkk3Q1dHQWY2?=
 =?utf-8?Q?nS76aNxDs4H5aJh4fMil+g4ri?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37ef4c4-795b-460c-b7fe-08de0d081b0d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 23:02:39.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHRUBxyG1ACFFALdrOb+2SxeCwCUu6AxzFjiwYy+r03iUVxv4ymWbUh8UFvVUHu7BVXdIVnDHTCLc5Ihb3yUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369



On 10/16/2025 6:57 PM, Danilo Krummrich wrote:
> On Fri Oct 17, 2025 at 12:24 AM CEST, Joel Fernandes wrote:
>> On Wed, Oct 15, 2025 at 08:14:29PM +0200, Danilo Krummrich wrote:
>>> Implement TryInto<IrqRequest<'a>> for IrqVector<'a> to directly convert
>>> a pci::IrqVector into a generic IrqRequest, instead of taking the
>>> indirection via an unrelated pci::Device method.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>  rust/kernel/pci.rs | 38 ++++++++++++++++++--------------------
>>>  1 file changed, 18 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>>> index d91ec9f008ae..c6b750047b2e 100644
>>> --- a/rust/kernel/pci.rs
>>> +++ b/rust/kernel/pci.rs
>>> @@ -596,6 +596,20 @@ fn index(&self) -> u32 {
>>>      }
>>>  }
>>>  
>>> +impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
>>> +    type Error = Error;
>>> +
>>> +    fn try_into(self) -> Result<IrqRequest<'a>> {
>>> +        // SAFETY: `self.as_raw` returns a valid pointer to a `struct pci_dev`.
>>> +        let irq = unsafe { bindings::pci_irq_vector(self.dev.as_raw(), self.index()) };
>>> +        if irq < 0 {
>>> +            return Err(crate::error::Error::from_errno(irq));
>>> +        }
>>> +        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&self`.
>>> +        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
>>> +    }
>>> +}A
>>
>>
>> Nice change, looks good to me but I do feel it is odd to 'convert' an
>> IrqVector directly into a IrqRequest using TryInto (one is a device-relative
>> vector index and the other holds the notion of an IRQ request).
>>
>> Instead, we should convert IrqVector into something like LinuxIrqNumber
>> (using TryInto) because we're converting one number to another, and then pass
>> that to a separate function to create the IrqRequest.
> 
> Well, IrqRequest is exactly that, a representation of an IRQ number. So, this is
> already doing exactly that, converting one number to another:
> 
> 	pub struct IrqRequest<'a> {
> 	    dev: &'a Device<Bound>,
> 	    irq: u32,
> 	}
> 
> (The reason this is called IrqRequest instead of IrqNumber is that the number is
> an irrelevant implementation detail of how an IRQ is requested.)
> 
> 	pub struct IrqVector<'a> {
> 	    dev: &'a Device<Bound>,
> 	    index: u32,
> 	}
> 
> So, what happens here is that we convert the vector index from IrqVector into
> the irq number in IrqRequest.
Ah true, I think the naming "IrqRequest" throw me off. Sorry about that, so this
patch is good then :) Thanks,

 - Joel


