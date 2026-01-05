Return-Path: <linux-pci+bounces-44015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA4CF3954
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7C4A302E3D5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876733346BF;
	Mon,  5 Jan 2026 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cVS1JXEq"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A53334698;
	Mon,  5 Jan 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615802; cv=fail; b=upmOdlC7v38EqA6VYfSlJNWar4CdiNBG1OuOH4pU9j0XxXhS9akZqVq+YSm8vhD3DAgbRRXevIfAQDPlRTV/vEVCND5+41PGMgtCmilREPAI1OqurqaOdiGMQMV5MCH6JeXVtZpNLRVoZuZe2eigWQXMSpp2O6jL0v7T1urf1i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615802; c=relaxed/simple;
	bh=sgbXF9qkLpE2x6oiFguGAt6F/02HgLkSFd73aEyJk68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N2fnLFXCzk3Ne8jE5wDimScmnKii/2roVi3sEZ9KjvCm4emYItJI9WtmymzO7/y8XTq+bDeF4/11SGWndAe/GrKeS2ikfpWs79ZWJiPA2g83A3IkWWhYPRT1B5l+D/ZHgeuD9p0V+MW5hJjRoiKSKeg4pAPuR3YtTud+haN5Gvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cVS1JXEq; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYH3n6ulik3AW8IkM7M2I2ArA1rErwuyHOd1b4okEC2iH4nxTTtiYHoXCJuoyFnGo6dbReYNQRJedZuG+e5egF5WVMWJQHjXLMdgcyg9Ly4UJ3WAME3rU4ScJwuNs4SWJQpntBilzwxsEGLYDVY/QJXwMOif33175IMdPJSmL3GxIMsDQ/VJHWSB5WVEF+sSYC+kjb2O6M+XsJZ23nwMSAyQyAtGxS9jvAD7bjLE0xgcIXwp3N9mN+VQXMi9JQ2d97mgUrqTG9+f29GnHZytSjQNfCTlPLCw+aSojYX3IdHKRUxOBFeT4wKhn4azRO0t2aKbmdwGPhJ1rIwh3/3ycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUZM6l/IT7CxZUu33yjzHA5mOr/Nq2m5XkYJnCdTFQ4=;
 b=Z1dqPJuRHMPRowjrj2oSfpheOiyqyiRssmENBb6Z06t26XNuzFkLGIosf4Gz9uiHw9RbBFcTCribbMgkDavQTXgeYeCDYSLhjZFREubS5VgRit/XdTD03ifvtuBtCG2G9RkKYvwkahB7YhvH4ujNTEiGo00JRR2sW8q9a8zHuN5BQEOwP8sbt/OkLJsTtSUiKo7+EL9MbL3YjARUfQbsg4uhC27XLlGGt5IriWQdZIgmNAcNlY3iPM2JpjKDgJ4+xdCYZ8GoxXVuQRppgUUcvm8SbpRdKRT7kUNua7kXo3VoVLu/liFkcNHJDvYNV4BmntqXf1Pz0FhYgPytV1IXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUZM6l/IT7CxZUu33yjzHA5mOr/Nq2m5XkYJnCdTFQ4=;
 b=cVS1JXEqMZ+h+28PR0Kit0nI+uKGct6RBLMqP60PxAPcH13uBYkvCDqfiv7hweiDIV7WYjtnuMb8Sv1WYhUNxUVuqtWrFaMC85UqTeod5pm6A5mkyNxVNKv6tKajbdbMo7EgaYu2iZ4DwIxnxzil3oClsQqRmjmJ2Cdi0cEJ0ItujYRO9iUUXB+fdeY8/pgpNwhcahEWE0C3ClmoGTYvoorTcU1hNyzLR8rWkyjbCLKfGHiZpAF9lweVdo72RQApKy8i90gC+xo8QFFbKqXxBFZUi9y9ga5GQ+5d8LkyO4cc0I/WFMwTUYfOjaq5wWeC8ujOatg0RUangdH6C52iUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:23:17 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:23:17 +0000
Message-ID: <9efcc80b-b8b5-4eb3-a5c1-75957ac86066@nvidia.com>
Date: Mon, 5 Jan 2026 12:23:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Francesco Lavra <flavra@baylibre.com>,
 thierry.reding@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mayank Rana <mayank.rana@oss.qualcomm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shradha Todi <shradha.t@samsung.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Inochi Amaoto <inochiama@gmail.com>, Vidya Sagar <vidyas@nvidia.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251126102530.4110067-1-flavra@baylibre.com>
 <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
 <e900f082-fb3e-45c6-a94b-935132190249@nvidia.com>
 <5cwg6tg2y2q4mkns5zblenvhhovnz52dp5bo4uyghs4yledh3v@7apj6wwy3kjf>
 <aVt_t3kxtT99wbwi@ryzen> <7bfb3ebc-2e8b-4fcc-8d13-a6f3e0b7141e@nvidia.com>
 <q2iezy4uydlvwgo6m6yv2nlucafyvxgonm2o5q3g32p73vemwb@x33rmfffnwlu>
 <aVurA-MUECufgTw0@ryzen> <8b5dc374-77e0-4957-8ecc-6c646aff36a1@nvidia.com>
 <hbhvydcqr7lcpvijw5vu57biqato2znjf4txshfepc7zszsptk@6ft3jujbyvtd>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <hbhvydcqr7lcpvijw5vu57biqato2znjf4txshfepc7zszsptk@6ft3jujbyvtd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 34febfe1-34c0-4192-e89b-08de4c5534d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1VWblZmWGtZTVJ3SFh1ZXlONHo3SzZqbVkxQUNwaHNYemVnNHlBWk83L0NH?=
 =?utf-8?B?OTR6emU3UHptdjdvd21Kc3l5VDhOaTYyTzJoQ0pPRmo5OXJmSGJuUlk5WjdS?=
 =?utf-8?B?REE0ZWtJM200QlhmL2ZCNHRDWThXWVViMlZwOG45OXROeDAwWkQvVTByaUhS?=
 =?utf-8?B?WEdNVFRSY25FSzgxcU9wamtuUmo4c0RTdzB5ZEVCaHdSRjNYOG9hS0d0TjBR?=
 =?utf-8?B?ZVRacHBBMEZ2aTdaQ2ZDczRpdlhEVC9VODFFcGFCOHMxK3dJNjQwaWFBeGxQ?=
 =?utf-8?B?bEJHSXVTZ2lZUDFJcDBmSTdROUoxOUlKeFZnU2pWZm51MHV2c0FFMGt4NDBP?=
 =?utf-8?B?QnlKeERQRWNiUjIrZWpPOHh5b2NiNkt5azdGZzFqRlNJWkxZSngyeEtPSlBR?=
 =?utf-8?B?VEdSNjcydFFzMysySzRkOWtEL28rOXFFVVd0NStDaFBobkU1U3I4Y3F6UlNG?=
 =?utf-8?B?VmlLTTNnZm5taUZHdDV1OEFxMFg3MytyS0NkQm8xRDQ0czJyVFBTWExsMjhK?=
 =?utf-8?B?aUt3NEZjaVBhLzYwNWNrbDJLMGNXWHhWaVpkTXh0cm1VNklrZnVjeXpXUGJ2?=
 =?utf-8?B?bFV6S2l2Y0Z4VTRMcTYzRi9SNGtKLzJFVXI0STNWWGNmUUhhREZiVit4SG44?=
 =?utf-8?B?RHVCelRpT25DRlJkVktJMnpLaUJ5OXBRa3JUNy9yaUpXdWREWjlBZitVYXRD?=
 =?utf-8?B?bHhkZm5QL2NpVUFLZTVGS1A2VC8wNnVKUGp2NjU1dkxEUGp6Vno5QlBrSTNV?=
 =?utf-8?B?cjRYOWFFeU8vYzNUN0YydWFRbDRYOXVyN2cxOGpxUUQvTHVmUC92eU5UTnBw?=
 =?utf-8?B?ZjIrVVdjZnJEWloyRG53cnZLd0Z5Q2FkRnZ1My9YWTg2bzdwcWt4YXFwYXJm?=
 =?utf-8?B?RUhXZ0EzckVKWnJnVWJ1Z1dZUGZVSzFUNVVsS1RBOE9sWTV4V3VQK0JTNjJG?=
 =?utf-8?B?c1hGeGxlNHlEWTZSYXo0dXZCTkhyYlBlbUJ1dFRvREJ0RHBZZktaMmZjQkFI?=
 =?utf-8?B?NUJzTWxXZzdsbEppZjY5Q1NMT05KaGhnZWJuR3lXc0dkTDJGRkdDRC9DMnhT?=
 =?utf-8?B?NGE3NDZrUnVEVWZRVk81ZXAxOFc4aG9ocFozT2Vzekx2SHVKMmVaeU5NRVVj?=
 =?utf-8?B?cDlRWnJzTWdrSFhnSFAzcXdPY25kYlJEc2ZGVC9WY0hnNXIzWXBKcVU0dGt5?=
 =?utf-8?B?RG1iUTMvRm53WVlwWVdTNFJsb1dOV1BCM0kzRWdQb085Nm5TRlIxNVM5M055?=
 =?utf-8?B?Q1ppODdHRmY4NmxTSkxXc1JGVitaUW9ISXZJYzZ0UzBjQS8wcnoremJCRnlO?=
 =?utf-8?B?KzVtUnFTLzlBeFlGd3Q2b3pBbktPMzZPN3k0Y1VReERvVFZnWFRJVi9sQkt4?=
 =?utf-8?B?bTBSaEpFTDQ4ZU1FQklscFVSVERGN0VPMTk3OHhleVNBNWs2ZFhaektTcjlv?=
 =?utf-8?B?ZnRyb3BpVSs3YUkrZ29tOFV0SFJGTXhKSEE3RWN6amRjaExwSkZzMHpnM2dN?=
 =?utf-8?B?c1h0SlVZZ1hhSWVHYUErMjdJd29QS1lwWTJnTUFxOXFKQ3IvMFZZTm5mbmQ3?=
 =?utf-8?B?ZUFuY3lXZ0JNeU1uR21ZKzlZZDRmUmxlVmhkcDNNbU9wNitsUGZSOVlIb0VJ?=
 =?utf-8?B?NmdtaTV6TzBPZWRmU1U5UzFiN2JDbFhYWXBZemlWeGtKRU1ORlhtSmkwRlUz?=
 =?utf-8?B?aWZrOTdLWDkyOGVYbFZwaFRldFZGN3lYQkFlSEgwVllYYW5tTi9IekducU1Q?=
 =?utf-8?B?SWt3MDRoeVJqNXo0cDhQODR2T2VzVEQyR2k0VURJcXdoRHBWMjZ4UTNveDZ3?=
 =?utf-8?B?Y20vNVNIT3JrTWt1Vkp5UWpvSDBCOExXa1hxMXdnS3MyVVE3Tk5FUElPNXRL?=
 =?utf-8?B?NGVra0poSURHK2V3eWJQZTZMTjV4TnRzYU94ZCszZ2tsNVBEWWcrU2I3LzBM?=
 =?utf-8?B?RXBwZkVzNGxDNEs0Q1RYTHRWUDRaM1NHcW42NkE2dUN0SlBWMk5JbnRoc2JV?=
 =?utf-8?B?WFBiMXZvTVhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW9XWmkwSDlpUDFaclpKWlU0T3Q4ajgrM1lNNXMvYW0vc1RhNzN1YkM1alVR?=
 =?utf-8?B?bWF6RlVkL0ZkNXNRSytvSWllbVg1bW5sSXdlN2lsbTJnbHd2VW02aFU5YXA2?=
 =?utf-8?B?NFhoL3ZkaGJLSVJ2Q0lKNmVkc3RJSG9mUWhkcll5RlhXVXNSZWhsSlIxZk1s?=
 =?utf-8?B?L1NYd29ZMDZnV2M1ZVpsZHl2VmdjazFpNVFDaVlJQVlZb3ZoR1BiYzlOanhh?=
 =?utf-8?B?TUZtZlFtUkpPL2UzbEZZUE1hcE1KU05GN3NEUUx6Zk1tTmNlcGRHZ2tvM0lh?=
 =?utf-8?B?THkzL3QxRmdPaDFsRW9iMW1GMERWTEUxTU1SSmcwbHpBTU9UbEVtcjc0Rjd0?=
 =?utf-8?B?clB1ak53Ujc0aFpMc2lGeEZBcTJib3JGdHhHTnFaOUhsbzJ4dnVZMTM2Z2RO?=
 =?utf-8?B?eFRFa1lDczhrMXYyTm52VjErZWYxVm54NXIvdVhkSUF0emRMemtLd25wWXlx?=
 =?utf-8?B?RjJmVno4a3Z1N3B1NG9GcytzY1Y5YjJhZG1rVjVXVmw0RjJUS2pVb1BSNmI1?=
 =?utf-8?B?T0IyS0s5a3Qya0dldWxMY1c5V2QwZERBS29mdkhhZm1mb29RQit3YTRrZEVw?=
 =?utf-8?B?ejNmMEZUaWdNVTQycC9zMjdENmJRZFlxbVNVOG5zSmVRRkdyVkIvNXJlQnh0?=
 =?utf-8?B?VmlLVlFDdHdXOG5CUFMyRlJRTllpbGNJSi9XWDFMdEFabWNDTlVPdXpRR1Ru?=
 =?utf-8?B?SHJXSzZDd2hUZU11OGRNYTYrckdwME9sWngrSGRjQjhkQ0VPcHN0c2MzTzVM?=
 =?utf-8?B?MTVaZHovN09BZlVnT0NJWURVb1VibVE2cTVJYmJTRlh1dWNRdFBiRUZzTGZN?=
 =?utf-8?B?aTlQdjNweTlBbU96Y1hRYlFyQzZZWjkvblhPdjY1MkFMV2VJYXdSWGtJWHIz?=
 =?utf-8?B?MmNubWdkOWFtNnhMT1ZJL3A0djdlMVo2TCtvU0w0MkVSN2ZyWk9OSDAyYjFE?=
 =?utf-8?B?U2Q5YXlFeCsxQjlIRzFzUktGN2paeHlsVG81TzJoeUU3V2YvS29BaDNEcHBn?=
 =?utf-8?B?d2JHVkVyRUZRTjhVK0Rsd3ErWm54WUZ1K0hNOW5JYTVzNWdqa1lLY2Fhb21E?=
 =?utf-8?B?d0dERnE3RlJpNWhnWWNPay9DVE1zVlU3UlpQbXhaMGRBVmx6MnpuYWNVeTRC?=
 =?utf-8?B?WnN1S0lEK3dlamROQ1I3OURvRnJ5Y1pqZk5COHpaeGdzd0dpbm1oN1ZVTUE5?=
 =?utf-8?B?ZG5uQ1doZFRieHEvVkRiY1BXenl4dXMxVVh3NkhlSDNyTi83UlVnME9rdG5j?=
 =?utf-8?B?N3JvZVdHWkhBV3N5NE1PbXVNa0MrRFk1Y2x0Wm40bGt1OFFNdnVDUXIyTEhY?=
 =?utf-8?B?a2RWMTBlaWpWa1ZySEd2Y0VBb2hjQmpuNWQvODRDeVZaMlEzMXYxWW9WRVdr?=
 =?utf-8?B?dEpwVEFtUWhLWXZEbnFtazlsSEMzVXpZNU5QbUphUlBIenorVURnWllqMG1G?=
 =?utf-8?B?cFkrWW1MUnNMRHloUDQxcnJUQkVvOEpmUFB6a1F4N3YwNXBYbitMYjlyM0lK?=
 =?utf-8?B?Y0pqbi9iYS9OWGp3bnNyS3pMWFdpSklZTm9YMDJGNElNT0FzaHdocTRmMGdi?=
 =?utf-8?B?Nm5kbFJKVUx0enVpUTVhOHN0Tlg2VENwT0ZoV2RzeG5jVDVIRlNQNlRFWEF2?=
 =?utf-8?B?TFJCR1g2UTUyWG84alJRU01QaHp0OFgvTWpRQzZYQnRIVzcvRVVycStHQzBI?=
 =?utf-8?B?RVFPZW1nVW95bFpYNEJraGg4aUwvMTN3UEtZUUVaMm05b2grdUduWUcxbUpS?=
 =?utf-8?B?aUFLVC92K2NXTlNGVnNreFh6N0dCSEkvWVFVa21seEllQXZwdlZJRXhyMlB3?=
 =?utf-8?B?aUdLTjJuWEhFRm5IdVJtUjNMbGp4UmdRQ0Y0WVk1bjFMWmV1VFk1OURNM1FJ?=
 =?utf-8?B?MXZpWUEweVBqMGd1VUprdHdDWTYwWDVQNDJUakhpMmxrcTJhU3lBZExrQ29r?=
 =?utf-8?B?MmU4Q3l1SXRMeEM5QW0yOUE4OWd6RS9lSUJzdlBIT2ZMUklkQ0QwTHQwTWdk?=
 =?utf-8?B?SkhieXNNOFNjK1BsMUp3WGNkRng0SW02a1ZiUTFyc3FyTWd6NUxBdVhwbm8v?=
 =?utf-8?B?VVVhV2RXaUczZ2RublkxWTBSbEJBM0lmOEoxNWVZai92UWJkWnZVd2FRZ2xo?=
 =?utf-8?B?NUxxY0Q5OE81Mml2TEI1YW1xZE1HQnljK2pzbEVERlkxcnRZZXhva28xV1lu?=
 =?utf-8?B?VjZpbFBMN3FHSEkweTR6M1BiN1Jid0Z4QlJVeHUrQnpac0NGcyt2Y2hiL1Jr?=
 =?utf-8?B?MGVNYTkwZjMxa3BxVW45NEdMQUZRb0xQMDYySWVrUWdLWmg2Q0RCbDRYa2JY?=
 =?utf-8?B?WXViVnBFeWN0WGpXZUwvWWpHWUNUTWVFekVDNmd6S05qMy95cm1HTk94WjVH?=
 =?utf-8?Q?MbYWjP/1qURlVK6IySmtWjpN6KLaYAyrl/3xQbvQuI0jp?=
X-MS-Exchange-AntiSpam-MessageData-1: OF4ADa9ULTXKoA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34febfe1-34c0-4192-e89b-08de4c5534d3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 12:23:17.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj5FAtAM9o0yslJ1bqWgm7tVl2qy/CamNaLQJXkQxUQdlefArHLWBTZjDL+X3hMai6sdEMdu9kL3fi6/CwscvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003


On 05/01/2026 12:21, Manivannan Sadhasivam wrote:
> On Mon, Jan 05, 2026 at 12:18:35PM +0000, Jon Hunter wrote:
>>
>> On 05/01/2026 12:13, Niklas Cassel wrote:
>>> On Mon, Jan 05, 2026 at 05:38:34PM +0530, Manivannan Sadhasivam wrote:
>>>> On Mon, Jan 05, 2026 at 11:56:37AM +0000, Jon Hunter wrote:
>>>>>
>>>>>
>>>>> On 05/01/2026 09:09, Niklas Cassel wrote:
>>>>>> On Mon, Jan 05, 2026 at 02:09:34PM +0530, Manivannan Sadhasivam wrote:
>>>>>>> On Fri, Jan 02, 2026 at 10:58:15AM +0000, Jon Hunter wrote:
>>>>>>>>
>>>>>>>> On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
>>>>>>>>> On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
>>>>>>>>>
>>>>>>>>> + Tegra maintainers
>>>>>>>>>
>>>>>>>>>> This driver runs (for both host and endpoint operation) also on other Tegra
>>>>>>>>>> SoCs (e.g. Tegra234).
>>>>>>>>>> Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
>>>>>>>>>> dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
>>>>>>>>>> reflect the fact that this driver is no longer exclusive to Tegra194.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I vaguely remember asking about this a while back during some other patch review
>>>>>>>>> and I don't remember what we concluded.
>>>>>>>>>> Thierry, Jon, thoughts?
>>>>>>>>
>>>>>>>> So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra
>>>>>>>> devices as well as the current 64-bit Tegra devices (such as Tegra194).
>>>>>>>> Given that this driver is only used for Tegra194 and Tegra234, it seems it
>>>>>>>> would be better to only enable this for Tegra194 and Tegra234 instead of any
>>>>>>>> Tegra.
>>>>>>>>
>>>>>>>
>>>>>>> The dependency means, whenever someone tries to enable PCIE_TEGRA194_HOST,
>>>>>>> ARCH_TEGRA should be enabled. So as long as someone not trying to enable
>>>>>>> PCIE_TEGRA194_HOST for 32bit Tegra systems, ARCH_TEGRA should work fine and
>>>>>>> PCIE_TEGRA194_HOST is not selected by arch/arm/configs/tegra_defconfig. So I
>>>>>>> don't see any blocker with this patch. In fact, many other archs do the same.
>>>>>>>
>>>>>>> But I don't like extending the Kconfig with per SoC dependency as it won't
>>>>>>> scale.
>>>>>>
>>>>>> We already have a patch from Vidya:
>>>>>> [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
>>>>>> that was sent 2025-05-08
>>>>>>
>>>>>> Back then, the reason why it wasn't merged was because it required a
>>>>>> similar change to the PHY driver to go in first:
>>>>>> https://lore.kernel.org/linux-pci/174722268141.85510.14696275121588719556.b4-ty@kernel.org/
>>>>>>
>>>>>> The PHY driver change was merged in v6.16:
>>>>>> 0c2228731974 ("phy: tegra: p2u: Broaden architecture dependency")
>>>>>>
>>>>>> So, I think we could just merge:
>>>>>> https://lore.kernel.org/linux-pci/20250508051922.4134041-1-vidyas@nvidia.com/
>>>>>>
>>>>>> (Assuming it still applies.)
>>>>>
>>>>> Yes it does and applying Sagar's patch is fine with me. So it you want to
>>>>> apply Sagar's patch please add my ...
>>>>>
>>>>
>>>> Don't we need:
>>>>
>>>> 	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
>>>
>>> This is exactly what I originally suggested to Vidya:
>>> https://lore.kernel.org/linux-pci/Z6XjWJd9jm0HHNXW@ryzen/
>>>
>>>
>>>>
>>>> in the above patch?
>>>
>>> The above patch instead has:
>>>
>>> depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
>>>
>>> I don't know why Vidya did not use my suggestion exactly, but I guess I
>>> assumed that he had a reason not to use my suggestion exactly.
>>
>> Looking 0c2228731974 ("phy: tegra: p2u: Broaden architecture
>> dependency") we ended up just merging ...
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index f30cfb42b210..342fb736da4b 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -13,7 +13,7 @@ config PHY_TEGRA_XUSB
>>   config PHY_TEGRA194_P2U
>>          tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
>> -       depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
>> +       depends on ARCH_TEGRA || COMPILE_TEST
>>          select GENERIC_PHY
>>          help
>>
>> So I guess we could just merge Francesco's original suggestion for
>> consistency. Otherwise I would be happy with ...
>>
>>   depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
>>
> 
> I made the above change applied Vidya's patch. Thanks Jon and Niklas!

Thanks! Feel free to add my ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic


