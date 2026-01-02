Return-Path: <linux-pci+bounces-43948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF0CEF2D5
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82B723001818
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055C279DCC;
	Fri,  2 Jan 2026 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M85jvj8t"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854022157E;
	Fri,  2 Jan 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767378304; cv=fail; b=RB2EyTFrwqeJr1HotOdOlC1MoKbZdfhjcrqUmRY6g7unLaWXFDL5OV14KC6UNpLeC0EIOi5Gg/EOqQypaGsGIPPb+hDGYMx1o2r82yrB2+9lE5ZqU+cg2cXKIBrd6Y5j1TDswJZ4vq6Sv/M77Dopv6dWB+1JeS/A7OTrurbg5j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767378304; c=relaxed/simple;
	bh=rr5HvEVXIeyEe0suIzpgpDJWMM0G4OTELBLhtwHR9mw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O31FytIIRXyw6BF+xgLDUff76XbZEAQkBQ2QTNkf4uyUY6yqc59rwnPrT2QLelEaP2FDpi/KDUD43+dbJ7uPRb6eZFczEEQyIGU2Sd9Vf/xS+avjzHMdpCOqbwABHcYN8iqKbYFD85Rk3XxXqZxLu8rGGgfxg7plkv9LU/t38J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M85jvj8t; arc=fail smtp.client-ip=52.101.48.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWLSz4lCVY5kJsmxYLLtJ0BDndQYI8wr8u58J5fAX/bX/BpcNG2SbYFCDq9IwXUeEcGeTnknTu6mAd2YH3rOVNzHj92qaMOMouqI2uVkqYS0GaaX1Jla/SW7Tt3L9fazVrHKrzc4dp7RYGL5n5l3k1iHjP9rhHNpq6Pmix9QS5lwOJOcInqaj61+W5DvfD4+025ygzra5HF2RjFq+6TLrtWVqZ4B4rfTgyUawruwlCNLkMsRVoHRveLMMnWyLjR/7dRfBPWjZqfJve8Lwd/PIHZYtKzN24A3k8bivH/2ucGbxHeijX+QIDKRr8WbT3/ti6yqhsekcZQqxxO65rZ4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXLP6LJmsZs1XxIT6XqJdXygHb1GFelYOfNFtptQls8=;
 b=CMBJWnjepIUzwhWOiSKfayGDNxts/gdNGD58JYFr4JEpSYBhTqSUj/X/20SdoJvajM151+kdSkn43Ow12moSCRkeACWcUGiSVtrtotdtnz4p5U9Pwmhd75Ccm4IsFNmWmVudwGXtVcA+u7bjgmfHJseX8x8xrWGZQjtLpHsbS3a+w+xX6K7UgAo3R2hRlDBpQT7uzSpyKmHgdnweuez60l23HsNl8wNbrLzNOqXJaSHpBzTGdOhbpFD6pSUVW2g93p6sDUM5KUvQdfbrNURI7/T4BqkPQSQekIAoiQQoeFaq8r6MT1CdJNtp5XM4kydQkcT1CYtijBRBsfpXIG/2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXLP6LJmsZs1XxIT6XqJdXygHb1GFelYOfNFtptQls8=;
 b=M85jvj8t1LT6Ylh9NHkgq0c4/e3YTWgauW2vM0LORsFUb4H/wqUvKhu3Ddne/j0EOQpitsrtWF4Y26kLEAXf5m5xzm25NODo2fl0O2H6H1VIgh6fjG7XAs9h0Wsv93GH6+dI5jNkPWVz9R259g4DA6nNNxSB6QXy4ijV159/Wm3JB74I/7D2Lc2hn2nzylz0uaqOo4dX6J6f6lRIj9vlqlFPB/9kebDcxnAsSHt0q7mvQczXblpYRgcKsZ5NX68DWDjkPopyOOAcT1IZTiZrTuvrbvVvV6FsbpkiY+wLva33zTzIsfB9f8aL1VhGRlCABe7oyRxhSXRY6OAtoGjl0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 18:24:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 18:24:58 +0000
Message-ID: <f0344520-3234-4285-b971-f8cd9955ba90@nvidia.com>
Date: Fri, 2 Jan 2026 18:24:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT
 schema
To: Anand Moon <linux.amoon@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>
References: <20251215141603.6749-1-linux.amoon@gmail.com>
 <20251215141603.6749-2-linux.amoon@gmail.com>
 <3cd7943c-4d35-4ec9-8826-c20a5d213626@kernel.org>
 <CANAwSgR7UPrPSHB9RL5newKgWksyn4MoP03ykRQcP2eRSK2SXg@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CANAwSgR7UPrPSHB9RL5newKgWksyn4MoP03ykRQcP2eRSK2SXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0423.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::14) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4cff85-ce7d-40ca-42dd-08de4a2c3c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkpKSTQ1b09tMnZzcW5URWlqUlVpK3hWOHFMQ1U1dzhGS2R4eVp6Vkh3ZHpw?=
 =?utf-8?B?WmlFZk5kcTNYc1Jwc203OUttVGwyS1JvMVhaWDBpRUVSa0szb0kreHpDOTZW?=
 =?utf-8?B?NWhnRi83REZKVHJqdCtSL2JBbE5ORG9hZFUvYWR0MnpBT1VtS0xhSm1tV3JX?=
 =?utf-8?B?SHcxa29tenE2aWxGQ0dYbk55Zkd4VTB6NXBTeUh5NThOUHpialRrRVFQdHNE?=
 =?utf-8?B?WnJKS3hSbDBsMWw5LzhZbUpmUWNBT2FzOEFINkd4L2Y1MGhpUzFiU1ZrcjhM?=
 =?utf-8?B?S1FlSFgzL3hKdjJwYmY2Wm1ub0UrL3o1WTR3a0YyeHVnemNnb3BVa3pxYUhH?=
 =?utf-8?B?MGRySFB6bkhMWnhKM21wZUg1NlVpcTh5bk13ei92T1h4Q3ZoOFJJNVAvcHdG?=
 =?utf-8?B?Y0FnWmhyRlFKdytIY0RMZjFIclI5ekR5Y0RkSnZ6a1lCZkYyVTRXVHp1OVZ2?=
 =?utf-8?B?VFhFTkcxVjNmeC9Nc2l1YnZnRWRxbXJCeXgyaUVCempaTWZqSkludi9kelRa?=
 =?utf-8?B?THMzZHc2bW5hclFWc0V0Wlhsc0VQR04xdm1rOHZOblV3WWVsNXNPWk5Jdklo?=
 =?utf-8?B?QlNaeXNRT2w4Vm5CR3FVYUdsRXYyS2Y2Vk1hb2RWYU4yZUhmZ244VGR1UVJm?=
 =?utf-8?B?ckFtbHdxRmJUUlE2bFV1bnBFUUZnVUpVODF2UDM5Q2phSjlWVFYwM0wxMStl?=
 =?utf-8?B?RTI1YkxTRHN2cXdPRmdoREJXTWZZNDFiM1MySEdjdnR4bVNWRnNUc1VSZjcx?=
 =?utf-8?B?ekJjZTdSVFpRVmpQclg2ODZub1NYNVhUaU1DTm4vZ3UyM2FkL1dqUW1pS05s?=
 =?utf-8?B?YUV6NUoxUDg4SVhUdVh6VkRseU9aNWVldTJMdmQwaU42TjR6UW9uRmpYbW00?=
 =?utf-8?B?cklhMHRJbTFvTmVhdjFWTW9mM3huRFFvcXA4Z3lWNGRNQmxDQjk1U2t1SWds?=
 =?utf-8?B?dE40QmdEM0Z6cmdzSUFQSVExamY4R0Z0dEhxdGZESUd2UW9HUHhNbE9TVnpu?=
 =?utf-8?B?dCtva2U4bHgyUmFaOFlQRi8vTFVpMDBaZ0FlVVNtMkp5enY1ZVJFZFh0MHpu?=
 =?utf-8?B?Uzk5Y1FoSzNjOFpoTC9hU2YrZW9KeTJyVFNzME1HcThFQkpoTXJ6MjU1R0I1?=
 =?utf-8?B?U050a2RPVE4zbVpzRUVRZ2J0OHRSS2FWZkJ3YjVINGM5ZVpJajJJY1BXUUNY?=
 =?utf-8?B?QnFZaGRxRTR0M0kyZFNFUkJJcVlvZGkxbmJOeUljc0VMeldZRWhoeUVyczdo?=
 =?utf-8?B?T05pZHZrTStGd3J0SWtKQkNTNWJrTG9aOFRRMVRvMDhvTVhZUENwYXhXaHpt?=
 =?utf-8?B?OC9qL0RnemRiTUQ4QmljeVJiaUdQOGlJNG5OL0tUdVNzMzVBRk1ndFJRT1o1?=
 =?utf-8?B?V1pNdm9LOE5Na1NLUWVqZmdYYmRNekI3WE9Nd1lKR1dzTldVKzVKN3pQYmVv?=
 =?utf-8?B?c1VaQjQ0VktPNFBrdGM3c0JIVFlHOWRENnNHV3I0anRTbHRkMVViYlMyeDkv?=
 =?utf-8?B?VEc3VWJTTjU2eFBmREF5NEFnU0hBUitZT21jb2UwNmNqTWxEdXFwQjJ5Qzh5?=
 =?utf-8?B?Q0tlNEo4UDJVaWZxZUREYURHZ282ZjZ6YjgwVllCVE9vRVcrOUg0dmNrUlVq?=
 =?utf-8?B?V0VEVE9EUmwzN05RL3pyNEdrc2R5cnlxWHR6SndueSthSHFmN1dKcTNQbFZw?=
 =?utf-8?B?Nnc2ZmhLdUJQbHcvRE5XMThaS0VLaVh1YkVVekY3aTI5MXAweVdpZ2tiYlN1?=
 =?utf-8?B?NDk5NW5aS214OEdkb1c1cjA2dlMvVmlFZ0tTLzBMNXpYREU4Q0VSSW0ybE1K?=
 =?utf-8?B?TkdGRkxLS3oxRDBpd1RLVVNlMXpyL3g4ZU1TUHJ0bnQwR3RwbG1aYjdHOWJ5?=
 =?utf-8?B?c1NDK3hxRFV0QjFGOE5OODE1ck8rYWRCMGs1eW16QUhVSFRaRzZKLy9WQi9m?=
 =?utf-8?B?Ujl3b2lwRkNyUHU1TVFvS0xWMVd6L1hwUzBDU3JvQXVFTkQ1NllCTzN2SlVn?=
 =?utf-8?B?NmpCTmtFOVZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVFlZEp0UGpqNWxRTytyTFhkdlVMUjZLSUs3eVN1ZlArVFhXNVZxTENVTEpZ?=
 =?utf-8?B?OWI2MFltWTMzOHVHTitzNjJCOExGakhXTmtFNDZBVFFrRXVSS3J3bXNVRG1Z?=
 =?utf-8?B?Q2NSS1BXcTJTWW9vdmR2VFdwc0J5Mm1SUjZmZ3A1dW85Ni80L1EvZ0ZQVjNm?=
 =?utf-8?B?M0RZYkNIRGRtUjliTUNEVlB2QlBHbjlqdmtRTEl3amFXNDQya2RYTFlyL0hq?=
 =?utf-8?B?L0xHNUdCaW83ZTEwUGUxOHNHTTFDUm1oNjFDYmFlcnk1VlVtbm9jNWZVc3ZN?=
 =?utf-8?B?TTFwcmVWRm1keWNVdk4rYzhyUUp3d0JCbWE4cVB1WXVqRllXT0VXM3VaTW1V?=
 =?utf-8?B?L2g3cXBROS9mZS92VjA1SVZsWGpRdkFvU2ZmUWZDNWZ6UmFBNjVlU08xZ1E0?=
 =?utf-8?B?Y3prb21IS1pjM3RSR2xiOWdVZzRadVlybjRTRHBMa2gwSVQyYWs2RlhqV1Zh?=
 =?utf-8?B?ZnQra2F0VG4xLzdOUWMxbjdRZGpoM05ySUtVdDFJSmV5S2pIR09CZWJlMlUw?=
 =?utf-8?B?ZkNndWxESUpleWNZTC9zbURtbVN2dWJaTW5SOEV5YlBBRm9Uc3R3K0dWQ3E1?=
 =?utf-8?B?T1FmL1Z6bE1FUkFGeEppZ1phU25HWXNuZE9lS1ZzYUhBeEVjQll1elp4UEwy?=
 =?utf-8?B?d0lVR3o1SHkrWlg3YjA2M0pIWm5FTjQrenEraitNQUlnRDBZby9TbGd6aDNU?=
 =?utf-8?B?VVJrT0FYdUh1ZTA2dGZjZm40NDUxaWoyNUVQN0cyYVJ5WEVhVVEzNGNTTWRw?=
 =?utf-8?B?VEJaem4wa3BFSUhBQ2c1SjB5d293bUJOTllXZ3hkWjZSKzByL2Fka0Fva3kz?=
 =?utf-8?B?WWZmWGFjaXdVOWU1RkhrZXlNRi9DNUoxMjdPWHU2QVdBNHh0cFFFTlVBUEVO?=
 =?utf-8?B?WVdDUXhLSSsxT01vWDUyc3hWWU0vNUxJaDdBcE5sTFlTVDh0anFpSVNOcm5o?=
 =?utf-8?B?TndoMUNQRlNrTjYzaVhWRmN3TzZvbUdVV0d3c0orZndva2xxRHltQ2tGbVl4?=
 =?utf-8?B?eklISmJKTmR4L3pVU2luNUZYZ1hXSlNFQ3RVZzhERjRGZzhnVHFFNldxbW1y?=
 =?utf-8?B?Tkhna2R5TzFyc0lQeXdvVzBQNHpXZTluUjNzUGw5azB4THIyQ1YzT2hpck0v?=
 =?utf-8?B?K2U4aGZid2dFSE0vVjBiVTQ1MjJ6WTlEenFYSzVDN0U3eG5CelRveERBQ3B2?=
 =?utf-8?B?c05McU9GSXhPditvVVpsYlNSMUJwM2lJTFNQVFNqNFlJWmZiOGlEa0JWM0lZ?=
 =?utf-8?B?cVBLMVA2azVVWHBPU3M1Mi80NU16UGlrOCsrVVBObjFZZkgwTWpQUXFPdStJ?=
 =?utf-8?B?eEJsMENGdjRBRXQyWlAxQzZjY0lTLzRYREQwY1NxTGVXVldoengxdTBVVnRS?=
 =?utf-8?B?S3RqT3l1MEZ6d1lNby9maEQ1cDJVeDdkM2dZcEdhSE5yaEJTL3VrS2gzSFhk?=
 =?utf-8?B?YkRLZWJhdU5ubzdGQnVUNUVkeWFOZjZjSE1jQ3Z1Q0lvaHhMdlVmVFNxTEZs?=
 =?utf-8?B?N1dWQWxmWDAyNzNLdVd1cHBkTm9VMWtWakU4azZHeDRhTGswdGVRWmdOby91?=
 =?utf-8?B?VCtwT1dkVjd3OTN6REhDQTgzTFFyeENYaXVzRmJoNm9xY0hnciswbENPUG83?=
 =?utf-8?B?WG42cFJaZlhJVklVUzV2QVJaSmJpVEpqQXQ5UDJCeWR6VFZJdE1Lb2hvOHlu?=
 =?utf-8?B?TGZqUVNxTDNiYWdSSFdOeVNQVzZlNGNzY2NrSUx1YjVrYUZZcFA4SWM3bkhG?=
 =?utf-8?B?U0JQbzk1aWpXZk4yclN3aXFMZGlWNVc2dUp6aFNZR01BY2JORVhFV1YvQWg3?=
 =?utf-8?B?MXAxUFYvRU9ZRVIxY05DN3l5TUI0ODA4b1NpdVFZTmJmRFgxK29YWVBpVDVI?=
 =?utf-8?B?R2R6RnZZMXBic285M3N4WDBHODQ5d3BVWU8xcklHcVFZQUZnWkFjZ3MvYUF1?=
 =?utf-8?B?ZVYrY0gwNTJnRWZzQWV2NEsxTTZVMy9NaG81UjR1UTU2YUZUSWFncHlpNExH?=
 =?utf-8?B?M3VIVW5pRzA1bzBhU1hTSkR6c29ZSVVybHVrd3BqbXM0VVJyV0VNRUZPUlFK?=
 =?utf-8?B?c214alo4c1Z2TWpENHR6bERYMzdlV1BiUStmTkNxVVltZ0VWUWIrS212d3Yx?=
 =?utf-8?B?S0FyUTJTcGlaNURTUXJ5ckZvUmhLM0daMlRyM212U2JsN0RMVWVQSVRjY1py?=
 =?utf-8?B?ak9VSENNYnphemlKdjJoYVA0amRQTDlFZXpiakY0Z1BLb0lsd283ZTVjaXBs?=
 =?utf-8?B?dHNLLzI4ajd5V0d3Y3gwWjg1bDkwRk5OY1R3ZFMyUEI2SElyaWxaNkRNZ29R?=
 =?utf-8?B?cVZJTyswdGV0c2xPZ3ZpVUFiNTIyNWdjekFQQnczRUptMUw3UFFCUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4cff85-ce7d-40ca-42dd-08de4a2c3c70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 18:24:58.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPFARuXf1iUowJ9rJXw7vrrjhHQz82yAc8zyx8fX1vbejehZK6YSJydSTAE84QpgjYggV1D1oljaN8PB93ltfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523


On 24/12/2025 12:41, Anand Moon wrote:
> Hi Krzysztof,
> 
> Thanks for your review comments.
> On Tue, 16 Dec 2025 at 11:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 15/12/2025 15:15, Anand Moon wrote:
>>> Convert the existing text-based DT bindings documentation for the
>>> NVIDIA Tegra PCIe host controller to a DT schema format.
>>
>> You dropped several properties from the original schema without
>> explanation. That's a no-go. I don't see any reason of doing that, but
>> if you find such reason you must clearly document any change done to the
>> binding with reasoning.
>>
> Well, I have tried to address the review comments from Rob
> [1] https://lkml.org/lkml/2025/9/26/704
> 
> Actually  /schemas/pci/pci-pci-bridge.yaml# covers most of the PCIe binding
> So I had not included them, as it would duplicate

FWICT you are missing all the Tegra specific power supplies and so those 
will not be found in the above file. I have not checked if you are 
missing others too.

Jon

-- 
nvpublic


