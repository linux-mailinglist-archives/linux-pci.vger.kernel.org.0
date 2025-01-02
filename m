Return-Path: <linux-pci+bounces-19178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452409FFEA0
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 19:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A903A16F9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAB4D528;
	Thu,  2 Jan 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZCteCFN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF706FB0;
	Thu,  2 Jan 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843219; cv=fail; b=TnUmcZ7QOcnxf97uqlJoDi6RVWAWFxCTnVAyL+79Nzj8IgNwfmsjih9tYXddJtlFzMowGNgu+rVCGqT4UpyL7wXMI0On1GGtOePs2qpeZhmaWozSC9G7XQ+aZf4TrNhKj8L9re5yhJngsqApI4+w+UQEXOyHvrmRJCZDzVtojMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843219; c=relaxed/simple;
	bh=ScRqpJkVWXsQnUbL2186txfC9kjuZ9Wg3j5E9OemCRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gYc2Ku4TrF1cfRkjwqcLO6ZMl3dvzlrTc4VBnnTAm89sD7nEYM8oa5PkJMZnIp9WhdMUbMmpeNnXOpp0lI9fbXRYJS4xEPYzABpBKKKXgurarb0RH1virqicGxI25+LjsStca/9KTZ9AAoW2vq8nJ/K7b8h0MK0MPtmdBfccPRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZCteCFN; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMoKRgP1rkDVWRT1EZPN+VQkrDgQ/oXcGso+iOs+oOGYwMQ964HrrdU53rVAIJP5eXPUJyW0e2BYqRqBpajLrScRV4J/p3SHqjw6p4a/BPe/3+G2MbtaBytd2hxy6Z9S5QbTXJ9ZCtp1ZXbkSnvm/MVQ50zlUMV2yAwEnUfRi1XFlc40WQ+syRsNh2Ws5A9AmfYBjOoJTo7ZppwpsKcC1RjCvAlBtXk3Psp23ts5xg4efaGGbAMqkw3JKPN6elCnlXm6n+HUzozZzjLT1tozx2Hqw4xfuj+VswYS+BrtWN/B4iV+71X/ufCHQV0OWvyRQgwd1EJCoaNOz0tNJLm0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbo3m2pcldWssff69TSsxwBdJ03AKjSw66BvCnImHkI=;
 b=lGNxpisEfkd4qQFyEDxirG/tYzP1R+OT+xLylBJOoDbPeOJzKruuS9hVeqt79cY07qlGQk6inZFddhARgi3Ra2yzHrAfXa0mpluSw3wPKttnpQsJPkvdc1umJ567X0aWTSFoKW9xgRmH1DuVnvx5987VlmfNdiJqE9HBfMKkErxwBlZiWeXGmXWVqo1vVLB6ds696M7ymH5AtOYxGbhBgdE9g4mVgDhry/LnsjkzJtzkoqnmUIjW0JP2Z1PF3ZP2Crgyn8Xt7HF1VpMA9miPAez6pS+2jlke7Ukp+SF9+cYoLf2FwF6KM/MgfBWA98XsqSd+pbfPsMKXoPmBzwiUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbo3m2pcldWssff69TSsxwBdJ03AKjSw66BvCnImHkI=;
 b=gZCteCFNWR7zO9w94VHANenEikY5iasaEPZo/GdMgW48GqUtFb+AO/i8WqY1PP/C4KYXr+x+nbSzWkcFP1L39h236f4TKYJCKUNDFD9Q2KnuXOvBM/lTILWax/y8datyb3S/GfqBKjBFz2LVMS+Zi8H1WqTlB/4loll432OuPbX2XQ4BeHwYxZ43BG3IZ1AW24bEOsC7q/YHfMgXZBMrMJRsA2SMo+1RMiXiE+ykDb1TulC4yUDFa6B0XezD5kyu+AOq4lxIWP2VBBTyADppvhhdd1vaLjRpQ2Zzt/20QuWC17H6Lhf0Re6iXlo8U5weBHRb+JgDND/H4xqHghV4+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 18:40:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 18:40:11 +0000
Date: Thu, 2 Jan 2025 14:40:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250102184009.GD5556@nvidia.com>
References: <20241213202942.44585-1-tdave@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213202942.44585-1-tdave@nvidia.com>
X-ClientProxiedBy: BN0PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:408:142::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ca5e70-e6dc-4566-1939-08dd2b5ce34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymc4emNCbzlnWUNVc0lBNmxVVkFOQVZLcDRWRnc1bVNiZ1hNVCtHTXRRQzFk?=
 =?utf-8?B?M1k5bHNBQ3FZNTVMK1I3NmUvSTkzUnRRV1ZjMldUUnlDS1F6d0VRamg4czVO?=
 =?utf-8?B?UFpPV2pHSHZSVEQxMzZobHVzV1JEU0JNODFGbFcyaVA1cmwvQUVXVHFUcVhO?=
 =?utf-8?B?S3Y4UHVUbkIzM1l6NXZDd0lTcjNoSmFpa3dvVmE3ZCsyMUlKNTFWZVowUHF1?=
 =?utf-8?B?RVoySytyNW9FOVBMcDNBbzB5TU9YSnlDQkgyY2dKT1BkdmtUT055VXpXZVU1?=
 =?utf-8?B?c00xM1VzajNlam9aaXBWdm5sN0s4eFlETG1taUFjb3NBOTJ0SkUrcFZxVHlm?=
 =?utf-8?B?bmNWaTJNU3ZpbVJWUU0zNE51enY3bS9WblNma3Rwd1lCVGNrRWR4VHJMeU5i?=
 =?utf-8?B?UzdJeHR3N3BoOVl4d095WllZa1BLZE1TTlpydTBWWGxLMCtQdWFFdlFRS2Mr?=
 =?utf-8?B?OUNkdnZLWXd1VEl0SEZKNDVhYklQOGp0cER2R1VjbnJVZXdGWC9Pa29WakZB?=
 =?utf-8?B?eTk2dXltVWZIQzFZemdvUFZ6eVYra1IvTXBiT0ExTmh4Q1F6UXpZNFU1azRz?=
 =?utf-8?B?SVpVZ0xmbVEwL2RrUEN3SXpTMktGeFpkc3pySFRySjZTaWhCRTNQbS92ckFw?=
 =?utf-8?B?OW1LL3lRdktkajFUbHRTNnhzVTBMaVBvam5RTWNackJzcVlJSldIWVNaK0xT?=
 =?utf-8?B?c2RkdWVtUFVsQVg2dEk4aGRyd2VTL0ljTmFBUnNmbkdKbzlwRzhUWStiaW1y?=
 =?utf-8?B?ajF1VjVwSVc0cWdhV28vSytpc3RNTzFYV25zTWlySW54VkJWZWdRbXNxWWtF?=
 =?utf-8?B?U1lTMkpScEFEYWhNRUIycG5ob3RvWFFheUluNkRjUzE4dUpkcHh1NWdxMklE?=
 =?utf-8?B?Um82Znpsb2NtMnRaUCtuVFpWQnV2Mmx2d3l4MEZuRmNzV29BM3hyMGNNSGQ0?=
 =?utf-8?B?N1BCM2NxMWZQeklmWVVZMGR2V1B2K0hqSlBWbk5GRjZxVGZJZlRNbnVJQ3JK?=
 =?utf-8?B?L2dzZlJLcXMxbElQYVZyR1l0LzkyZEpOckdSemRYQWdpc0F4L1BzMVMwckw0?=
 =?utf-8?B?UndzVFk3a0E0eldmVjhnQU05STdoOEErci9USlRENGRWNHpIVnZNZnNvdGw5?=
 =?utf-8?B?cUFIaDYrcmxPcGl6UXJ0TlIwa0tmWkZ5MjZ3clJNZGJQb1pmYW9zWit5Skt3?=
 =?utf-8?B?NXViYThWZUZSK2FOakJ6OEdlR2l6azN2YlhndWJwNmlSUytpaWpSeXVjV3lI?=
 =?utf-8?B?THAzV29SNzhkU0RrODFJeWc3ZjNuTEtiZk5jTEZDTTV1UFRXbXQvZmR0MDFG?=
 =?utf-8?B?ZytSc2RoRjlkTW1PVjczcGJnaTNYc3dzc2JNMTJPb0xFMThTTWhUYXByTWVN?=
 =?utf-8?B?VEsrMzd6VktXQ25PS2s2dGh0KzBSMGdTSkwwY3pPaXdTMkFwd2M1Rk9SaXFs?=
 =?utf-8?B?aW5aejVaOVhlYm9vWXJXZmR1SGpWckF5RiswYnFxa2JPb08zTU5QbUtyL3RN?=
 =?utf-8?B?NGRIQSt5MGZRZ1hKZzhQZ1NtWUtLUExTaElqaW5TOGt4R2YxbXRROGpIeGNs?=
 =?utf-8?B?QzYwTEMxVlcwT3N0RTZ1M0E1azROdlZua3diem9PU0xmQTQrZmNLUjdyMUYy?=
 =?utf-8?B?THdac0dydUFBNklLbEt3OHp0S2JzRmthZjJaOFdQbjZxTFgyRjlhdDZxV0Yr?=
 =?utf-8?B?MnNDSWpRMHVCVVhJN25sWFRRUXZ3YkhoYW5zamJ6RlpkMXlVTGFaNEZlUDlt?=
 =?utf-8?B?c3ZCcWNOOWNaZUc3c1dDM0dGbFFZUDMvVlE4Qldmb3lnUXVjd3UxeHRZRHBB?=
 =?utf-8?B?OTJvM2Z6cWRxZ1M0a3F4eU1Cbkw4eENCenpjc2hINGI5YTJsMlBtWjVueEVY?=
 =?utf-8?Q?x0CfQJ2p2+0lL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzIwMkdPQTQ5alFKbmRFMTQ4T0x0Z09oZmZzQ2NSdDVjOE5ZZG9pUmNqUlpG?=
 =?utf-8?B?bVFCL0U0T0lNa2hMenRZYU56ZFNGWTgzUFAzQUdSVjMvVnY4OTJNZGQ4RW5z?=
 =?utf-8?B?SitiSUs2TEtqa3ZnblJIR1J4dDRiVmkzenBwWXV1a1krY2JJOE1oWGY4NE9S?=
 =?utf-8?B?VDZ4OHdRV2hOdFJNUTRwUXNKVHdKbytIMGIwM0RwMTRJa1dvVjlkbDluaTBv?=
 =?utf-8?B?VkxDRkRRTVFRc0NCSjB4R2IxRWxHRVFXZWRUVCtvMVQyQWJwNkRKMFBCU1M5?=
 =?utf-8?B?V3IxWEZweVNVK3hWcTBlOW5mdENpcGE5UjVUUW1ZaFpWMGZBa1Z1ZDY2TDdO?=
 =?utf-8?B?OHpSaEROeC9pcGxxTVZjT1ZVTzB6bExIYmwvT2h3L2tHa0lPZHUxSThTaU1I?=
 =?utf-8?B?NTNXOWk0VHRKWkt6VFp2cVhXM3l0ZVFYaEtuaUFybm9uM0xMeHVsQ1hjTXVV?=
 =?utf-8?B?eERUMkdocjcweUxLNlVnZWNiRXhJc2Z4Q1g1WFdwQzZrc05veUlXRXpMYk1x?=
 =?utf-8?B?ekNRVGtYWWhzNi8wQzA1QnF1MEpzdXkvdG4rYjg2d0tyaU9KTzV0OXJkRDhM?=
 =?utf-8?B?Q2NSNTE3WWdRckdYaEptZ1ZGbDdMZUU1bzJPc29FU0JiblZmNXROdS9oL1E0?=
 =?utf-8?B?Szk0VWkwTmQ0TzNNUENoWWdxS3RJMXFaeWlnTjRreDVvS3VSbFJSanVxaXY5?=
 =?utf-8?B?cExFcGVDZG9QZ0ZCWDV0azJGak0yTC81Qk5XSnpndUNJWVJyMU9vVzBJTXFw?=
 =?utf-8?B?V2dxTTF2L01jVVp0RjNnTThkTXFrMzd2UnhjMUxWb2EwMExWYXVmUkpRRTVU?=
 =?utf-8?B?bzRyaUZVeXdlMEE1a2p0eUFHcEtPMTVpYkptRzJSd1FvVTVuUVc1MWtKd3JO?=
 =?utf-8?B?TGdTREcrVWIvdFBWaWtnZlJESERMMmEwZ2ZnR0FHaXFySy9RWFhSYTVibG4w?=
 =?utf-8?B?T2I0Zzc3VUZ0R2NVV1VIZy90Ky9jVkxTa0Yycko5OGc3MEdHRmsybXlnczNU?=
 =?utf-8?B?VFRiOU44dkJTZmhvVk42QnhrT0JSVzk0WXdGY1pZTlZSOEp6OEhKN1laMnZn?=
 =?utf-8?B?bjhDM2NWdEg2RDk4d08yZ3kyWlkzTEFoZmo3QytkQnB6L3RieE9TZGE0azdh?=
 =?utf-8?B?Z0NyTUpJOGhVYVNncFJWeXU1YXJJOVhVRWlNK2NxeWpJRDhhZEw2aER4K21Q?=
 =?utf-8?B?Mko2bzU3Ty9SWWxPajJBQ1BCU2xFYkpPb2RKZEVJNEFFcSt1UEw3eGJTNjg0?=
 =?utf-8?B?NmxrRXBFMlBoTGNLbUVxeklEeUdHOUNsbVcyTXRtbC9wZXFHa1dFMTEwVzV5?=
 =?utf-8?B?KzM0Z2Vzc2htcExCU2VteEZjV1dpblU2YWhicXp5S0o0WExmZGVncVIwOTJm?=
 =?utf-8?B?aU00VGc1QW4wQ1dTNWhCNlBWR0pDTy9tc1M4OWRXenZDUE9EL2lWMTREbGIz?=
 =?utf-8?B?d3ZQclBkWXNmSXBiY21GVEl2Z1JIUDAybzNvekRzYkRBcnNxNlVMc1lmMDJS?=
 =?utf-8?B?ODVJMkYzSnQvQVFqSFJxRkx1MGsyaGR0T0pHc29oV0pXenNpT1ZobVlTcmgr?=
 =?utf-8?B?KzAwZTZUUTUyd0Z0anVwaS9jY3kxeHZTV3ZLWjdFNS9EVEsvMENmTDNaOGg1?=
 =?utf-8?B?U2NMYllXOXpvMlFBSFVtcWV0MkZpVmJ1RHoza2E5R2xRNVowMU1mREF3K2hG?=
 =?utf-8?B?VXdvaldMZFB1cy92NHZUdGlrY3RqZmFFamx6MTdWekZ1S1R0TXh3Rk9EY3dJ?=
 =?utf-8?B?T0hTajBac3NjT3RwM2IxT2NrdDRyTG9ZdCttK0dSenJKcjROUmd3TTBXM0pS?=
 =?utf-8?B?b3E3RmgvWmpGOU5YV0JHNk9tdE1pcENNeXd0YVRXT0E3R0R3emdjaXFSNTFP?=
 =?utf-8?B?cUN4L09oanFLelcxUUVXdmQ3NHBjY0lDUEdKU1oxSnFLZFd1aG1wTzV0blFC?=
 =?utf-8?B?Q3dFSE5WTmp3SGZSTWJ6RHA0dThmNFR4c2ZoaWtQamNDTkRYK3BEblZRSHE0?=
 =?utf-8?B?K0NreWRyVVFtTDBtZ1l5TmVYQ1JCcTNGTzZ1UDIwb1FEaUNJNEFYM3hsTGdx?=
 =?utf-8?B?S281UmE5MzlaQUhYaFp2VUljSGlISjZQOUZOalhVTnYvZW1YWFZWVDlOSWlv?=
 =?utf-8?Q?Gx6pGyFqERbtPDrdtS6oN/h86?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ca5e70-e6dc-4566-1939-08dd2b5ce34c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:40:11.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZbOfo+EWaNVYUT5rWPET1Mzqw8L1a21RPUk/xGsT2wUj2lOVVMfY+omsC4pQPpt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

On Fri, Dec 13, 2024 at 12:29:42PM -0800, Tushar Dave wrote:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dc663c0ca670..fc1c37910d1c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4654,11 +4654,10 @@
>  				Format:
>  				<ACS flags>@<pci_dev>[; ...]
>  				Specify one or more PCI devices (in the format
> -				specified above) optionally prepended with flags
> -				and separated by semicolons. The respective
> -				capabilities will be enabled, disabled or
> -				unchanged based on what is specified in
> -				flags.
> +				specified above) prepended with flags and separated
> +				by semicolons. The respective capabilities will be
> +				enabled, disabled or unchanged based on what is
> +				specified in flags.
>  
>  				ACS Flags is defined as follows:
>  				  bit-0 : ACS Source Validation
> @@ -4673,7 +4672,7 @@
>  				  '1' – force enabled
>  				  'x' – unchanged
>  				For example,
> -				  pci=config_acs=10x
> +				  pci=config_acs=10x@pci:0:0
>  				would configure all devices that support
>  				ACS to enable P2P Request Redirect, disable
>  				Translation Blocking, and leave Source

Is this an unrelated change? The format of the command line shouldn't
be changed to fix the described bug, why is the documentation changed?

>  static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
> -			     const char *p, u16 mask, u16 flags)
> +			     const char *p, const u16 acs_mask, const u16 acs_flags)
>  {
> +	u16 flags = acs_flags;
> +	u16 mask = acs_mask;
>  	char *delimit;
>  	int ret = 0;
>  
> @@ -964,7 +965,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  		return;
>  
>  	while (*p) {
> -		if (!mask) {
> +		if (!acs_mask) {
>  			/* Check for ACS flags */
>  			delimit = strstr(p, "@");
>  			if (delimit) {
> @@ -972,6 +973,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  				u32 shift = 0;
>  
>  				end = delimit - p - 1;
> +				mask = 0;
> +				flags = 0;
>  
>  				while (end > -1) {
>  					if (*(p + end) == '0') {

This function the entire fix, right? Because the routine was
clobbering acs_mask as it processed the earlier devices?

> @@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  
>  	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>  	pci_dbg(dev, "ACS flags = %#06x\n", flags);
> +	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
>  
> -	/* If mask is 0 then we copy the bit from the firmware setting. */
> -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> -	caps->ctrl |= flags;
> +	caps->ctrl &= ~mask;
> +	caps->ctrl |= (flags & mask);

And why delete fw_ctrl? Doesn't that break the unchanged
functionality?

Jason

