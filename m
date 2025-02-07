Return-Path: <linux-pci+bounces-20932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C0A2CBEB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88125169E1C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EBC1B85D1;
	Fri,  7 Feb 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PTyCfeaR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806E1B6D0A;
	Fri,  7 Feb 2025 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954015; cv=fail; b=BbF84Ml9EPxt+NpynbGu0ZwBYWlzfAe6EI1GyJZLlrYiRIv+PBv7TL2clu+jkxcQoQSOraWjyyvlGhFxXPlmnX6XNAEGXU2S7PUBk0aNqfvxGQ3bHuCLYllxozdV0gqn7LWAEMlFD5yXzHyBr0jGbG8n9dFXl3WxN9oPP14RJDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954015; c=relaxed/simple;
	bh=P8fhE00RyX/kCOZWMktXaq9RS7Xrb7T6KdZMjRek5Bg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Mj38QmzeCINj0xQSGK1WI7fvEXpysA4dlfImLZ8TGkDOVheRwjouBEvvdt4HgLFLvD4d8dEiXvPskD1P1j+1YRO4uSoXt88l40Cc6RBUMWGS9j2uZ7Qij/JlMBW5az9HyajoHAojINaX9nhZKQS4qrbbyio7IvjTED08JbfhLk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PTyCfeaR reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517DwZ2s005905;
	Fri, 7 Feb 2025 10:46:25 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44njkxrnr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 10:46:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGmGynVQautxpoyuiaahUFMJ8EA+lSNjEOHNouhiMTVL1PUBAQraLZBMtF9uDuUcicMVdc8F3tISNXK3hhIvWQO6+loYph8N/T4G7JLevHKye6+va7DJ3n7wlKfsFm0gneVv5A8zMa3Q1lnwyNk5v7Vsd8gyjLoBmMTQAJvByN8XnO7/d4pI5ZHaeYCLclbDUvJD2thBfDUsftGMs3eovrFkgb1lG+rkQQgVcOC/1UapwVRyzXhbPpqqSQ3W/VLCtJMJ06rjX1fX+Z/64uz6O3TPoSs/g8D1nZE5guo/SKL7S5rN79R/C0Mum3NDYjWndqjGOQjIHncD1Wae4SAyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIXus0HtoNFyFF3GBlGAaXcmKsoUAWKQTKEzwSNvT+U=;
 b=bs/GhyIPur+NNI5Z8BKfZeg2S1+IBiJNvpfv2idJ32gCBgdRNyTDaXqTgzCA5sW/xxRI3tMJ03sP8PGb9/9UlldxorV5+6VpI06lal09ahtfwGjbKiKktUI3zP7Mxa8X8s8R3BwdlciitXaTmFQdRhTSdQTp7vGVikgwDYYDtpV0UIDqQ8tOtNt6wd4b0JRvNFTlj97L/KBSRG0wkg7oG8fI9Khf0n/x4D1c/1v4OKPdvTBwE/Qjc3nSv64BTmw1aLev4zyJZsKBYPKegNR4YkmdC0k4pQGV2hOwW+WfnuI65z+4ys+W1cNEln3OlV2yckjt6De1YNNmGQ0L+Z/FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIXus0HtoNFyFF3GBlGAaXcmKsoUAWKQTKEzwSNvT+U=;
 b=PTyCfeaRYpfBO16ETueV3NIylTDK2y91Q3YqxuZ0QDvfHlIex86/xOKMnlsr+w20PIlelklR1mXaDe0h8REhbhc4/k05NxAulPjeQqmggZNr+99/8Tt0Roe5V74Js7FnNP5HHsReJVzAVSE1NPvs4ywytivJO+/TBMPX3Ctr6so=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by DS1PR18MB6147.namprd18.prod.outlook.com (2603:10b6:8:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 18:46:22 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Fri, 7 Feb 2025
 18:46:22 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "cassel@kernel.org" <cassel@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com"
	<thomas.petazzoni@bootlin.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Topic: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Index: AQHbdP3ZtQbq+OyfdEOfQPFKLWvdMrM8KamAgAALmSA=
Date: Fri, 7 Feb 2025 18:46:22 +0000
Message-ID:
 <BY3PR18MB46738F5857319F9637FA5050A7F12@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112213255.GA1861331@bhelgaas>
 <AD287CCE-9FFE-49BC-B9CA-B5CED4F05AF1@linaro.org>
 <BY3PR18MB46737FB5FDBD75CF31B505B8A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <BY3PR18MB4673207A36B2CD7C3B75EBA0A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <20250207175759.jzmoox5mke3rachy@thinkpad>
In-Reply-To: <20250207175759.jzmoox5mke3rachy@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|DS1PR18MB6147:EE_
x-ms-office365-filtering-correlation-id: c2c802a1-d278-4e82-7e46-08dd47a7b78e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzdnV0w1dEFCNUVxRTlRbThzVk9FUlFQeGVDcW5oeDRRVlc0SkhYa3F1UC9I?=
 =?utf-8?B?SWVNRks2SWowcmtIYXdTUDZJT2YyZTk2S2lWblpsT0FBM3F6cXZkYjJRdkRq?=
 =?utf-8?B?aHhQVUFCYnd1MFNtU1ROQnp2VmVidjlPMythdXBoaGhiNnFpNXZCdUF2MG9F?=
 =?utf-8?B?VXB4UlVnMHhDcy8rREZMc0JBeUtvdHhsMXhYYndlL3pPbVAwaFVlZS9ISWVt?=
 =?utf-8?B?UGpqaFcrRVI0UnRrSzdQQ2JuVUlMT1JISDFrZTNRRUNXdFNqTWUwVEp2NXd1?=
 =?utf-8?B?dlNlUnpwWUVEMUR1TTR4dUtpRHZUc1NEOU1zSSs2by9HQVNGU00xak1iK21l?=
 =?utf-8?B?dEExM0tZWnRGK1ozUnhFTlNLVGlWdFNNaVpFRHVtR0dsSmVORlU1dlNCQ0Vr?=
 =?utf-8?B?SXBiNkZ5U1k3NmpUNDQzWlpEeVJvN3l3ZUhFQVc2Y3ovR3lKN3MvZ1loWFRR?=
 =?utf-8?B?SC90QzB0bGJ4NTJ5UkorNTNUcFdEMmt3eGVzYU5IdTh1bHQwVEdrb1dVMXMv?=
 =?utf-8?B?MUg0QjZmak9HOUJYbU8xcFlGOTE2VHEvNkE0TVVRMllhcml0em5MbE9BdlNN?=
 =?utf-8?B?b3Y5dDRIUjhXSFdtQ1RNcER1eUtNU09MbmFaanNTQlM5ZE9qMXlyYkJQUlFC?=
 =?utf-8?B?OUlpdlF2TWRMbmtOS1lXeE9tQ2FxN3Q3WHRaWFEyMzVXNUpUbG1VRUpVU2l4?=
 =?utf-8?B?SjNxUk81NU9RblQwVWFqR2FIYlQ4YU9EcVFjSy9Iam9zWlA0RkNtRW8zNit3?=
 =?utf-8?B?VkxvdFdKKzdxM1dSa0xiUDFjNlhuSmxEc1F3b2NhdU9Ib040OHdyNWZVV2Yy?=
 =?utf-8?B?MnVOQi9YZlJYNGkvWFZlaVRsU0FvUm02cDFWanl2ZVI5VHp6Z1ZNU2dWalY0?=
 =?utf-8?B?OUdCYlhXdWlzZGk5MkZpOERHU1BHM2RzWDZ2SGpNTE5tUXlWZFRZbitBTFRC?=
 =?utf-8?B?SXFzMXlJaXdMMHN4NFRGMU1IWk5Xd0MxNCsxT0VLSU1tVUNnVDhGT2M3WXBY?=
 =?utf-8?B?ZDdYRVFkbDNYWmRYZkVLM0kreWpMSksvUHdyYU1EY0RBYTB2dFljUFZXZStN?=
 =?utf-8?B?NWtKVW1KazZ2eFJmcytaQmRCZ0MzNXBJUTlIem5jZVBVWDdSLy9sQ3FvK2tU?=
 =?utf-8?B?V2pEZlF3dHhmaXg3aStZN0FGdzlFd2VFZ2xHYTZYQjNMWDJmN1FDTGg2Z1lu?=
 =?utf-8?B?UEZVL3VGa0tGUE9WR2ZSUGllV3c2MEZJK0RMMFRZZXZaeGljanFMU1gxMXdQ?=
 =?utf-8?B?ektQYXpoZlR4dFdmTU5OMSt1eU1WT1pTVDhBNitHU3FrUXpCcGVhSndDU080?=
 =?utf-8?B?blFJSTltNW00U2VobFRCajRTL2QvZ2QyQTNOaFZQcWdRUlZTdWQydisvZm1h?=
 =?utf-8?B?NjdiUk5RM3NaaXV6L3A4SFcyQnNwS2IwdXpqNVhJWkFCUXlFTHVTTEJvQXpl?=
 =?utf-8?B?U3F2U05LQXFuanNlVlpqeURCazNDM3pkbnc2VzJydWdIVXFDWmt4T0NodVFr?=
 =?utf-8?B?VWoySFdlNWpPeHpiLzM2c2Y2K3dtV2tVNU9MazhObWpwTC9zc1lqSEZsTnpn?=
 =?utf-8?B?a2tUejc1djNicTNjOWRYOGtjZWRCQTFOeWloT2pwN0dvNUNQbzN6OGpBYitt?=
 =?utf-8?B?VTR3YkgvMHVKWG5RT1JYNVZMQVlXWkl1aldlakgweS9pM1h2U0o4L1REOWVI?=
 =?utf-8?B?VkdoZE1mWFVUcTRodU5wVGtacllxbjlwYlZqdndsTE40Y1BmRVpYQzBjT2Jl?=
 =?utf-8?B?RkFKWk5JK0ZQekFRSkFFRXJ3VkJYdXV0TXJPbzVTWHk4VlZBVjhhcUR5bGZn?=
 =?utf-8?B?VWpBcUtJT2RYRjB1TDNOWFhQUVJxN21XNzZnWTVybWFKaGxReEVUYnhLS01w?=
 =?utf-8?B?WktXb1VVODVKN1YxN2ErTndyZnE0Z1NWUkNONWRDK2VSSnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUlCemdrRHNlUXlCMWZpRnQ2ekdFY1Vra1hBZGp2bDhKeHkvL3RleXkwZlFr?=
 =?utf-8?B?Y0pBakZvZWlMMW5qK1BLQTFGZzN6Q3krbkQ5UHl5OFdLTTE3MTZjSkFDNkhV?=
 =?utf-8?B?WTRJbDZYNnlsb1FYZEovbUduUTFvVzdBdlh1ai9zaVRPaDNrVllsWCtVUDhH?=
 =?utf-8?B?Rm50VVZWaXV4MnAyNWRNOFMvRUpnSVNaS2w4K3NYUVoxUmxUc0lTdFRxRlpT?=
 =?utf-8?B?MjE3a2V4OVlCNGptbHR0OU9SMGIxd0hvREUwd2ZDendVUmpmTlBYZ1Y2aGp3?=
 =?utf-8?B?eDJXVEJzeWVwU3pkcjkyNTFUd0MvRU9GZStzbzhwbWQxSGlpaU1ZTVlCSU0v?=
 =?utf-8?B?M1p2bjdBUUJ4M0w1MndlSCtFSVpuNW9GMXM2em1YZlBEQi95TWlYd1RCR2Ny?=
 =?utf-8?B?SFdiakRUNzgzY21SbHZiZjd5L0s4SUszUjB0dm1LQXhnUXFwVzFMa2V3YlIx?=
 =?utf-8?B?eWlKZFhyakFNbWZEUmZXZ3FtVFRRa2MxbmZyQ2dFbTRBWXhOb29YTkJmYTBx?=
 =?utf-8?B?QVBwM2h3V1JWWkVyekFHS2NzZGM5QVRkTnR0UEpXekxvTVpCQVl3VURmR3hi?=
 =?utf-8?B?YTlYOStYQTI2UXVqbXNaNVV6SkZKVkJQOXdFOUpQVVJrR0dzQUxNQ0J6YjlC?=
 =?utf-8?B?ZmF2S245NGR4ZjdnTU0wdXJhQ1NRb255aUNILzF2amxaTTJZblJiamdxWms5?=
 =?utf-8?B?azdTbkNzMlllcGIyWmVycTk0aml6c0NBeDVHMkZib3VhT1JyN01OSjQ4Q0lR?=
 =?utf-8?B?SFVScGtpQmp4VDBTdGhScTdPQzcwMGQrOGVjL2pPY29UQUYxVlhZVVhZVC85?=
 =?utf-8?B?d1Z2QXF3VzdxTTdLYmJhM0JRRm5ZV1lqeGNKeEVkblIxUG9FanRGY213S0Fs?=
 =?utf-8?B?RVdhMmV1bStwTER3T3FMZUNJSE0rRmdEZVpsZ0UrS0pGMHM0T2JoMHRHc2d2?=
 =?utf-8?B?MWpXNHhKVzVHL012S1N6eTgza3NJRXFTYnJldldMUkNKNndRTUZnZUZiQzdS?=
 =?utf-8?B?WHBVT3JjYTdLQ1Fya2UxQWtBNWhTZDI3MjlISmFXZjBhOEcwT3NSWVV2YXF0?=
 =?utf-8?B?MlNvR0pqcDhCUVAyZmFnSjVOdFNzcStCc0VwNnhhVHlSbWVIZVBOaFp5WXVa?=
 =?utf-8?B?NGNOZXdIb3cyOU5tV0tFbzFHeWVzUnVZYWc5cW1NMjFpOXVlQndvZ2tLb3Aw?=
 =?utf-8?B?blUxM0hKWWdjNkx6dkFHYVpaaFhPWHUxRlk3SHlZT0dCb2p0bjVHMVpubmZs?=
 =?utf-8?B?eklESkNRSnFEdjB6cmdKU1VaL0N4SFhBb0ErRmZ2RFgxcDhHRnFMOW9yVnpo?=
 =?utf-8?B?cWlsTGRPbWJBMlMzMi9DN0hVQ1BWSlVFd1JzOWJjMU9MVmNWVFg4bm5IaUYr?=
 =?utf-8?B?TlFUam8rblViMCtFbXQxOTBhdXhWNFU0Q1RvZ2xqcFV1SWZCQm1Ba1NHRWZQ?=
 =?utf-8?B?R0lwbi8xZnhEMWVXOU1keHBSNXI1T0F3eWE2NmhtN05DMVZnNjFEdXVQRHBr?=
 =?utf-8?B?MEszQmdnczNyOTEzc1d5UmkrY2s1Wm81WnpQWHlhL3cxR3g4RkJMV1UzcTda?=
 =?utf-8?B?S3BuaXJtMlVUK0xuY1RjdUN6a2Z5aXAzWGlKcVhKUktYbDgrTFBsRy9Id1cw?=
 =?utf-8?B?aXgvR3h5MHBEcVlxbGIzYjhsWW0vVXo4RlJYcFVPRnVGSXJGSXdtYzhzcXpP?=
 =?utf-8?B?aDZ0UnNKek9KNEJNRjFGSXN1dVpCb0ZLUjRVZHVNbVE2ampqUjNEamphSEFP?=
 =?utf-8?B?WWdadTVyNHdqcDJWMGhBb1VqRnZ4cDVpQWdSQ25ZNGRqS1NEU3ZQZTB2T0wz?=
 =?utf-8?B?TEJDb1lXdGd4L0k0OTJ2ZVdQYWFSWUFYeDZKandFaGVYUUs4aE9LNy84TkdK?=
 =?utf-8?B?K1p6T3hsd2VBNEQ1YjFldFI2NU4wU1FsQTJNYnNVeFkyMG0zSU4yVlltM09a?=
 =?utf-8?B?QmpjWVlFdGFHR3FzT0g1WHJVSm1SU29waEZZZDlqZ3RFdVROM09FdmhzeTBH?=
 =?utf-8?B?Uk9VTTFDak5tQ01wd2J1M0l5NUlmZStzcmw3bUFXQi81OUxuRitYaU93bHFH?=
 =?utf-8?B?YzJRSm9jUktSTTFtcDV5M0JZS25ONnA1WUlvMkZMc01KVjFWRThBa0FkcUZn?=
 =?utf-8?Q?2aJiipsltXLHl9VWwhlI4BnTC?=
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c802a1-d278-4e82-7e46-08dd47a7b78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 18:46:22.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Im32cbd4CE1FHslTzXLhWPMIL6rjMmpLYEYWVBL+KeIkUdw5aU5orOXPnBjIpHADS6cZK1DSOu0Kdtad74flog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6147
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: R-hGPdIZePzN5DBJbMyDhFNpVLGV6GWU
X-Proofpoint-GUID: R-hGPdIZePzN5DBJbMyDhFNpVLGV6GWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Sent: Friday, February 7, 2025 9:58 AM
> To: Wilson Ding <dingwei@marvell.com>; cassel@kernel.org
> Cc: Bjorn Helgaas <helgaas@kernel.org>; lpieralisi@kernel.org;
> thomas.petazzoni@bootlin.com; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sanghoon Lee
> <salee@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
>=20
> + Niklas (who was interested in link down handling) On Sat, Feb 01, 2025
> + at 11:=E2=80=8A05:=E2=80=8A56PM +0000, Wilson Ding wrote: > > On Novemb=
er 13, 2024 3:=E2=80=8A
> + 02:=E2=80=8A55 AM GMT+05:=E2=80=8A30, Bjorn Helgaas > > <mailto:=E2=80=
=8Ahelgaas@=E2=80=8Akernel.=E2=80=8Aorg>
> + wrote: > >
>=20
> + Niklas (who was interested in link down handling)
>=20
> On Sat, Feb 01, 2025 at 11:05:56PM +0000, Wilson Ding wrote:
> > > On November 13, 2024 3:02:55 AM GMT+05:30, Bjorn Helgaas
> > > <mailto:helgaas@kernel.org> wrote:
> > > >In subject:
> > > >
> > > >  PCI: armada8k: Add link-down handling
> > > >
> > > >On Mon, Nov 11, 2024 at 10:48:13PM -0800, Jenishkumar Maheshbhai
> > > Patel wrote:
> > > >> In PCIE ISR routine caused by RST_LINK_DOWN we schedule work to
> > > >> handle the link-down procedure.
> > > >> Link-down procedure will:
> > > >> 1. Remove PCIe bus
> > > >> 2. Reset the MAC
> > > >> 3. Reconfigure link back up
> > > >> 4. Rescan PCIe bus
> > > >
> > > >s/PCIE/PCIe/
> > > >
> > > >Rewrap to fill 75 columns.
> > > >
> > > >I assume this basically removes a Root Port (and the hierarchy
> > > >below
> > > >it) if the link goes down, and then resets the MAC and tries to
> > > >bring up the link and enumerate the hierarchy again.
> > > >
> > > >No other drivers do this, so why does armada8k need it?  Is this to
> > > >work around some unreliable link?
> > >
> > > Certainly Qcom IPs have this same feature and I was also looking to
> > > implement it. But the link down should not be handled by this in the
> controller driver.
> > >
> > > Instead, it should be tied to bus reset in the core and the reset
> > > should be done through a callback implemented in the controller
> > > drivers. This way, the reset cannot happen in the back of PCI core an=
d client
> drivers.
> > >
> > > That said, the Link down IRQ received by this driver should also be
> > > propagated back to the PCI core and the core should then call the
> > > callback to reset the bus that I mentioned above.
> > >
> >
> > It's more than a work-around for the unreliable link. A few customers
> > may have such application - independent power supply to the device
> > with dedicated reset GPIO to #PRST. In this way, the power cycle and
> > warm reset of RC and EP won't have impact on each other. However, it
> > may lead into the PCI driver not aware of the link down when an unexpec=
ted
> power down or reset occurs on the device.
> > We cannot assume the link will be recovered soon. The worse thing is
> > the driver may continue access to the device, which may hang the bus.
> > Since the device is no longer present on the bus, it's better to
> > remove it. Besides, in order to bring up the link, the only way is to
> > reset the MAC, which starts over the state machine of LTSSM.
> >
> > Well, we also noticed that there is no other driver that did this. I
> > agree it is not necessary if the power cycle or warm reset of the
> > device is done gracefully. The user can remove the device prior to the
> > power cycle/reset.  And do the rescan after the link is recovered. Howe=
ver,
> the unexpected power down is still possible.
> > Please enlighten me if there is any better approach to handle such
> > unexpected link down.
> >
>=20
> There is no issue in retraining the link. My concern is that, the retrain=
 should
> not happen autonomously in the controller driver. PCI core should be made
> informed of it. More below.
>=20

Do you mean=20
- pass the link down/up events to PCI core
- remove the device or hierarchy by PCI core upon link down
- initiate the link retraining in PCI core by calling the platform retrain =
callbacks=20
- rescan the bus once link is recovered

> > In the meanwhile, I am quite interested the callback implementation
> > suggested by Mani. But I am sure if we have such infrastructure right
> > there. Mani, could you please elaborate a bit more, or is there any
> > examples in the existing code and patches.
> >
>=20
> There is no such implementation available right now. This idea is on my m=
ind
> for quite some time, but never had time to do it. Maybe this gives me
> motivation to do so.
>=20
> Niklas: Did you get a chance to look into this? Else, let me know. I'll t=
ake a stab
> at it.
>=20
> - Mani
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

