Return-Path: <linux-pci+bounces-44010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F2CF38D9
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EFE93017878
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4843396F3;
	Mon,  5 Jan 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eGTAgHzm"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AD2F25EF;
	Mon,  5 Jan 2026 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615528; cv=fail; b=S2RL8jFheV/km26yr05HZi7F/GOnHiww7L3x7zYmTqwN8od0RaQy99qqQWurc3S0QGxyKeAxD1IwVQi4VAwMGFhCXHcPMmX40bqw//OhuEi1MnQYALlvdRL0l7gftD5eAkQrLV6QG+r0nLD3nHk/LonKpqYLmnk4ys3E9VqIUgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615528; c=relaxed/simple;
	bh=m+2SYsWj66+6/UxlaLqQ98FoHPmfo91/CGhi7x6kahg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6f8weU+lZRg1zb+KtqsQJXLr9b+BEHe9IpjxzeZdPMnNA4aJoBnXM+HHeWobBkW0ABrzH9MQNM+lv83MF1SZbfCIe7sfovJXayLslUQ7u20shsB5emvFI/pNteIVGBmMn5lA9wEccTfxWUTs+AUEbRCOESz/UmwfcLKNy+5T1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eGTAgHzm; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKSUlR+Mh8ECTJVFCpKzVydre0nZHEiK9hqEcB4Q3BgJ8ejCCBAdTqecWHIT+6/oHlNYU0gQwbNIJbhvo7Kq4pVd413TTepS3/OZk+ZPWxJY77Keg/IhxGC5c6SpJ4xP6Cv1+2Yf78cFcWM6pbgiL2Zwv39/dv5RTcm355lBqadkLcMXX25AsrhyPZQd1lIjKXXDZR4O3Un+L70Meb4j/AYYiPcGHsFNOeUvXeoQgqewP7RrHZ7z6pfUVILn7z0k+cAOcxv2DwaxLp4qiRYc6FzLomYKyHi9XUK/rnYaxyTFBdYGX7C2qCwqzNF1RdJs3ymfVpRx8IpYH2WeXMB2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3usv7AbaRYnhrNM16AKr/VHiDFwVDxY8mYLh7O9qA4g=;
 b=BINQlBEoTVG6KesQQPgI9vj7JKQCDFRmtXbPFv2Li/FPG1Z8RemIS4BXUOgf60d5WYFKzlzvzkaCoO5uny+kaCdD3Cgl7mEB5ATlWQyOJzPVo9pr4emP+94KClX1qxQwjqfH77uU3Arm4hO9IH+4slEdqv3jo1w3XGGp5ZcETXReCQPpJxnsY7NriSJxU804EraaT1mZoJkyjiKpwLDmoctJOAPQv4sfwF59wKVsRZTRdaKQuyzIViVJpQnYD0sQg6j6tGjSf1sftuk4XuarL4DLkYltQ7nVFkmotblPI16jitY9A9EMxI2BbY69CzJVe6bH+9r7EwfDZGAapMYEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3usv7AbaRYnhrNM16AKr/VHiDFwVDxY8mYLh7O9qA4g=;
 b=eGTAgHzmEI/Rn76AWg63j/oSjjiZrCFIK98xjWIOMR3hWUtJOPqoiNRxgK5MoctGbYLXsL4wBqMjJ1jKcSWkmy4gDa6c+jcVMx+lHFnn8U2mi+3FbCTTd61/o/QOjxLEaWWpp+ZZnH79I5JEYGwa0OrD/E0KECJCj6G0pMhM+bSKiUkdoeeAo/PuOnDdlXZ3L8u1kNHSjpytO45pya3R8esZU9Js9X1dauhCRR57607ff29572kWyl51mwx3Qdp2Rtod8j6SJlrAda5urfu6qtX27HiIqwDnorSuZnAPry2mHpu/p/gY8HHOJFJGWpQGjUK92YSm3ecZaHufyDNQXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:18:42 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:18:41 +0000
Message-ID: <8b5dc374-77e0-4957-8ecc-6c646aff36a1@nvidia.com>
Date: Mon, 5 Jan 2026 12:18:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>, thierry.reding@gmail.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
 <aVurA-MUECufgTw0@ryzen>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <aVurA-MUECufgTw0@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::29) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 11383d46-bebd-476d-34d8-08de4c549069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU1QWmoxNEhXWnlQTEVIejBsU01ad2V2Z3BJbWljSkJxdzVGUWFzQ2ttQWdC?=
 =?utf-8?B?OTZYQzg3QVN1djAxdWZ1bmtBZEJlUTV4YzBpZzBkczhueUtaWmJPSjdMSlg1?=
 =?utf-8?B?bVlxZ2ZvM0kyMXkyYlB3REJIdXYwdCtoaGFjRitTZy90Mk9zUGNTMi84MHlD?=
 =?utf-8?B?eEtJaG5jOGNoUUIyTVlhSU8zczUyajBrT3VrOXd5Z1IwbGFoT1kycTUwRkNP?=
 =?utf-8?B?ZGxlNzhlemYyN2VFSmNya2k0WFM5TnRvNVBsTklLYUNMUUVTRnA1MzhZenFU?=
 =?utf-8?B?STZDL3ZiTVl2OHpaMHRjZVBLMzRWUnFYd0lacXZjMi9JNlg3UXRXK25iSGVq?=
 =?utf-8?B?UzR1ZFI2dllMOGJoSkFMRjBtWVJkL25sUDMyUFBtK1hDeVVDb1JYTVM2MVls?=
 =?utf-8?B?UzE2THRYMStMWkxCZkFXQisvN1o5QitWZ1RCbEM1Q203SEdZMG9Tb0JhV1B2?=
 =?utf-8?B?TFVScWZaNHFONUplZzd1ZGtLanduZ3ZaMk9jNUQzdFI0c3B5NnJYNVJSUzRC?=
 =?utf-8?B?TmZUd3Y5RmRSYk5jdGxkd1lPOFg5ckd3TmJSQmNMaWw1RFliMWhVTEJCVEYv?=
 =?utf-8?B?MHNBeDY3RjBFY25QTlI3d2pteFdXYklHT2F3ai9UbXQ0OUlyOUhDY0xpb2FF?=
 =?utf-8?B?ckpReWw3ZGNnY0tWWnBKTDUweGxiODZLTno1SUE5NGxKdEZNSVd1ODNvN1NX?=
 =?utf-8?B?R2R1bHZJcGpXSFNoYTRBVkcydU9MU0FYVUpJdklnaEVwcElWdWJScVFkK1Bh?=
 =?utf-8?B?bnJtTmQvMkRwVTg3ZVlsTWliaDdjMkpzLzg0VmJPZVRZVjA3U2xzSzNqNWNW?=
 =?utf-8?B?YVZjZmRIbDZoZW11SUN1OCtrdXIxem5JSjZucnZCT3JnSmdEckZlQXprSWVW?=
 =?utf-8?B?d2JkM0YvU3V1SHd6czBBSXI0NDlBSXA3OFRQcDlxMHFGVFluamVudDlnSTdO?=
 =?utf-8?B?Q3B2TDdrK2pnR1R3UWgwSTNscGFGM1BENTd6aXZwT3RsOWFqR3dkaUphenUy?=
 =?utf-8?B?RnE2UVhraTFZblRFWDhwRDBwc2N3T1g3cUQwOVZObTJwV3VMZzVTQWQ5Sk1V?=
 =?utf-8?B?WkdoQjlKUG9DYTkvM0xNa1BoMWZLcWJVSE5UbjBVUHhWbDUvSnF6Q0s4dUto?=
 =?utf-8?B?MW5HWEZOTHJ2MHhuSkFFWC8vb0NsQzU5QXpjSWFHRUtMRnJYck9tWXlnM0dV?=
 =?utf-8?B?TXIrOFlVbHowYlR6MExrem1zUGpnUTdJYS9CbDUzbjNubE43cEJJUjZPZ1k2?=
 =?utf-8?B?eEJOb2JWRzUyZnByVThOU1VoZFlaSTRHMlZ6VmdCL0VZdHUwRlhNYWtYd2NN?=
 =?utf-8?B?TWpSczcxY1p0Zm5RRWpnNFA1WThhOEtoOHMwYlNqc1oxOUJIRjJ3S0Z1c05L?=
 =?utf-8?B?THVVeHdJNXdBeWx3SW1UdzNLZUJyWVE0NGxKbzN5K08vc1lucmo0ZHVyU3JN?=
 =?utf-8?B?STZJcmJmWkxMT0J5VXlQcVYwWjh1ejFIblpEMDE4Z1ViVnF5US80YVA1U3hN?=
 =?utf-8?B?dzVZbkdDUm91eVA0U3NnMkI5NDUxZE1Rb2JabFJpOWhYYUx3Z0ZIbUdrVllv?=
 =?utf-8?B?ejF5SVZMc0ptc1Z4dFhkc0VacTBDM3Z3ZFRRYW9zM1BEWWVoNWRGOHpGVUF1?=
 =?utf-8?B?WERxanFpSnpTVWc0a0tJc0tIbXpKMDVvV0xXZksraHgrUHdpZ25uZkc5UnU3?=
 =?utf-8?B?a2lFNWdYTzJTTkRyWGJMT0tXd0MrM3NRRG1hOW1qRUdNZ3pKKzdkblRtWjJa?=
 =?utf-8?B?aDhNN0x1Z3VrTU1lNC82VFJqeDFYcG9HdUFUVDFkRHY1VzRjTzNCRC9RcDFC?=
 =?utf-8?B?b25INFQ4bTN3bjVMWnV4VHB2dmpNOWEvemtvRXVPNXJvbXh2NUU1YzlhTlE3?=
 =?utf-8?B?a3M2bHpTaUhNTHlnVzVPdVZ6U00vTDBnUzhzT3lscnh5WmhSamp0RnV0aUsv?=
 =?utf-8?B?QWEzSWVxMy9odk5IOEdTYWRydkU0cHI0UEovZ1FiRDFaeEFzbENpOUliUzk3?=
 =?utf-8?B?cTdLUndycmt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2t3TWRHWlhBUUtBN1oyVDVnOCtYd1BLUXI0bVdjSnQ4T0xTWVAyUDZGUGJO?=
 =?utf-8?B?aGUvMmMzanNhT0ZjVjF2KzdWZVh4Vjg5VENmZFdIb2s0cDhoaWFrVVpGbzlU?=
 =?utf-8?B?ZmdXeElWb0ltMm5KNlpDNEtnN1AwN0dqQ21BVlkxcEZRekhxM3BTazhDdGx4?=
 =?utf-8?B?T1ptTkg3NHhwSmhTK3pkeTExazRnSVhBNGw5QnV4TUlGYlozL00zUDJqOER6?=
 =?utf-8?B?L2FvbTRkaWxUSEVyOW9XRHBKNmkyeW5DSVU1a3RuSVdDNHlJSDg3U05qRVFx?=
 =?utf-8?B?RnVBVWF6OUZ2Y1ZndHBGMTZVbzlyWm1lcTRQVzlURDNKVElSWER3cDVrU3Iz?=
 =?utf-8?B?RndkTTBUeDZDRWN4UVFUZHlKQWNYMnhwWG5jTW85WE1yTVZ5NkpxNXZMZkJP?=
 =?utf-8?B?ZHZ6YXBvSDlwS281Y1JwWEl4TEhCUzNiRFFhOHdWWUdmaXJ1RXpoVlI3VXQv?=
 =?utf-8?B?MG0ybngvdjI5bWgyTG12ZE9nZ1NZR21paDFKcHNsc2xRLzF0ZlNybGdZemdo?=
 =?utf-8?B?ZktvcDIyQTlrY2hxSHpCZkFCY3R4OVgxY2l2bXBMN0F0U3VyS01IVjdTcm1O?=
 =?utf-8?B?VmExWHZMU1pDNkxHYXlOZFlVNDk1WVhkV2NNV1ZyMlRVZld5WlczOVRYMDNC?=
 =?utf-8?B?MTVVb2Jua2lSV2FlSCtTaU12OHhlMVJ1Sm9wdmxseis0VGRLTkNwdWovMko5?=
 =?utf-8?B?RDdEVGErSmVURXFaVzRzamJPSDc4anRveHhFZDdZOUpSUmV4aWhYT3BiejI2?=
 =?utf-8?B?aTZObE1KZ2t5bi9BbjI5bzdLZkpOZHdSZVBVdUVHVHZrRFA5VGNndWx3eUhK?=
 =?utf-8?B?NlZMbER0VFdEYm10OTF5TXYvckRpOTJTYk4rRG9qaEU1TGpKZmlZNWlweUNj?=
 =?utf-8?B?MFZGRHpxTk8yQXFmeFRhV3ZnL0ZZWVF3QXUwUFA5cWtwUW14WkU5TnMrb3ov?=
 =?utf-8?B?OTFSdGxrMGhWRUZCSlZHSkhFQ3duNUtkL2lPMmZick1oZEQwTEtqdGlEOFYv?=
 =?utf-8?B?bWJ4Q3lwWDQ4QlRiMldnUGV2bkdKeXI1djNuT0o1TFJ2SlExdXNrenF3UUVT?=
 =?utf-8?B?KzlyMmI1L20weGxremZSN3dsT1lPQzg2UjM2N1F1Qk9LUHFFVlpKT056L0xD?=
 =?utf-8?B?NS9MdjdXNVpjb3NHS3FSK2ZSYmhQM05PcWQrTjl5RzZYR2cyRVA3Y3FIdlF6?=
 =?utf-8?B?My9GODBBODhoMkphTDU3a3laQzVtV0pZQ3A4djdISTNBNm1WUkptU09FNXBk?=
 =?utf-8?B?YU5Od1M5Z0szbXdKRTBWbVpCRU12cmVoWHZVMFBPMzNuUm9naldpWDZMVkdX?=
 =?utf-8?B?SWdjaGlSS1NBZCt6QlpvZVViM1JuUlV6OTJXR2hRVFJQYTRzU0V4eDNJVGp0?=
 =?utf-8?B?Ulh0eXkwZjVwNXJ4cXJuYnp3bVpFeTZRdTEvZ1ZyaDJqSkFjUHFoMGk3SzZY?=
 =?utf-8?B?WEJpaG93c01OOTJtelJnVktnWWdmckJrTWFNMzhQQmFnZGl1TnZDRExXemli?=
 =?utf-8?B?NXRlblZ2cEx0Z3VpNnlpaVl3L1B4SmpPOHRFWk1tQUlVa1RWYjM0aFduNmpq?=
 =?utf-8?B?Und3VFhCbU81aTNHUk1mNU9pbzQ5K0c2dXNzZWsxakNkN05va3ZGZ09nemwx?=
 =?utf-8?B?bVV1TWV4V2M2UlU5RkxzNURhQ2QvcHdBNG4wc3pFUFpYWGRCV3R3NlB5dXdy?=
 =?utf-8?B?WmVKSll5amxBc0lVdTVlUWRYYnRrTW9Od2t1LzdvY01qNDRjQXdYdDhlaisy?=
 =?utf-8?B?RkxqUURlU0JTbzM0Nkl6ZGpCN1FkL2d1eE9QZG9xVG5iNTVCbEdUK1BMYmJn?=
 =?utf-8?B?d0NKSHpPUWprWGVBVU1MNWJ1Q2RGRzIzWlViaDN3RGFOYUViUCs5WGkydzlJ?=
 =?utf-8?B?c3A2Mzl3djFadlZuM0pCYjMxdzNsc0pvR3ovVVdGTlc2UXhGR2hGa3BGQUFG?=
 =?utf-8?B?S0FSOTRXTHUzdG9UanYxekFvVCtRYXRFeDVqSzlGQUpzVmE4U0oycm90bXpT?=
 =?utf-8?B?ZVhLbmhCRG1rbCswaTdWMTdSSXc3M1dZQkE3VFZYRkdBN1JlM0ZQK2NaY0hW?=
 =?utf-8?B?ZExLaVd0cXhoSDA3MHREeTJzck9tcWx1NjJRQ2xEdVUzTVRRc09FakRNUUFT?=
 =?utf-8?B?N3EvVlV3dzZvM0VXeXVZRlAyUHdpNTFLbzdnUnVhUVhFNGpPRGJjUDU4MnVX?=
 =?utf-8?B?c3pTd1ZwaW9lTXNsakl0cThlNTJ5d3pPNkFCOFdzalROSEUvY3pUcG5ZOE0z?=
 =?utf-8?B?ZUFUMW5DTnRzbXRkOGd5dVBQNGt0NjBQTlBTNnFLT2wzcXd3Vzd1YnBEUHZK?=
 =?utf-8?B?Z1V2OW9Za0dRRndBcTJac3VsVXpwUC9uRkIvblM3SFR6ME4vaFJUZVR1ek1j?=
 =?utf-8?Q?uFzbEiauywbWUIZD+MOxYx7OcbyGBVBaKSTbuKbxPLgwa?=
X-MS-Exchange-AntiSpam-MessageData-1: GMxyU+jNLJ78vA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11383d46-bebd-476d-34d8-08de4c549069
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 12:18:41.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaGxyao+Z5/mNlq5rGEFqr+0/7K/0K/fBX2khIoQUdvmUCpy7o4mKKKFEvVnTsKNuvpVUXFE0x3DTKh9Uj3UVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003


On 05/01/2026 12:13, Niklas Cassel wrote:
> On Mon, Jan 05, 2026 at 05:38:34PM +0530, Manivannan Sadhasivam wrote:
>> On Mon, Jan 05, 2026 at 11:56:37AM +0000, Jon Hunter wrote:
>>>
>>>
>>> On 05/01/2026 09:09, Niklas Cassel wrote:
>>>> On Mon, Jan 05, 2026 at 02:09:34PM +0530, Manivannan Sadhasivam wrote:
>>>>> On Fri, Jan 02, 2026 at 10:58:15AM +0000, Jon Hunter wrote:
>>>>>>
>>>>>> On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
>>>>>>> On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
>>>>>>>
>>>>>>> + Tegra maintainers
>>>>>>>
>>>>>>>> This driver runs (for both host and endpoint operation) also on other Tegra
>>>>>>>> SoCs (e.g. Tegra234).
>>>>>>>> Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
>>>>>>>> dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
>>>>>>>> reflect the fact that this driver is no longer exclusive to Tegra194.
>>>>>>>>
>>>>>>>
>>>>>>> I vaguely remember asking about this a while back during some other patch review
>>>>>>> and I don't remember what we concluded.
>>>>>>>> Thierry, Jon, thoughts?
>>>>>>
>>>>>> So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra
>>>>>> devices as well as the current 64-bit Tegra devices (such as Tegra194).
>>>>>> Given that this driver is only used for Tegra194 and Tegra234, it seems it
>>>>>> would be better to only enable this for Tegra194 and Tegra234 instead of any
>>>>>> Tegra.
>>>>>>
>>>>>
>>>>> The dependency means, whenever someone tries to enable PCIE_TEGRA194_HOST,
>>>>> ARCH_TEGRA should be enabled. So as long as someone not trying to enable
>>>>> PCIE_TEGRA194_HOST for 32bit Tegra systems, ARCH_TEGRA should work fine and
>>>>> PCIE_TEGRA194_HOST is not selected by arch/arm/configs/tegra_defconfig. So I
>>>>> don't see any blocker with this patch. In fact, many other archs do the same.
>>>>>
>>>>> But I don't like extending the Kconfig with per SoC dependency as it won't
>>>>> scale.
>>>>
>>>> We already have a patch from Vidya:
>>>> [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
>>>> that was sent 2025-05-08
>>>>
>>>> Back then, the reason why it wasn't merged was because it required a
>>>> similar change to the PHY driver to go in first:
>>>> https://lore.kernel.org/linux-pci/174722268141.85510.14696275121588719556.b4-ty@kernel.org/
>>>>
>>>> The PHY driver change was merged in v6.16:
>>>> 0c2228731974 ("phy: tegra: p2u: Broaden architecture dependency")
>>>>
>>>> So, I think we could just merge:
>>>> https://lore.kernel.org/linux-pci/20250508051922.4134041-1-vidyas@nvidia.com/
>>>>
>>>> (Assuming it still applies.) 
>>>
>>> Yes it does and applying Sagar's patch is fine with me. So it you want to
>>> apply Sagar's patch please add my ...
>>>
>>
>> Don't we need:
>>
>> 	depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST
> 
> This is exactly what I originally suggested to Vidya:
> https://lore.kernel.org/linux-pci/Z6XjWJd9jm0HHNXW@ryzen/
> 
> 
>>
>> in the above patch?
> 
> The above patch instead has:
> 
> depends on ARCH_TEGRA && (ARM64 || COMPILE_TEST)
> 
> I don't know why Vidya did not use my suggestion exactly, but I guess I
> assumed that he had a reason not to use my suggestion exactly.

Looking 0c2228731974 ("phy: tegra: p2u: Broaden architecture
dependency") we ended up just merging ...

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index f30cfb42b210..342fb736da4b 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -13,7 +13,7 @@ config PHY_TEGRA_XUSB
  
  config PHY_TEGRA194_P2U
         tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
-       depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || COMPILE_TEST
+       depends on ARCH_TEGRA || COMPILE_TEST
         select GENERIC_PHY
         help

So I guess we could just merge Francesco's original suggestion for
consistency. Otherwise I would be happy with ...

  depends on (ARCH_TEGRA && ARM64) || COMPILE_TEST

Jon

-- 
nvpublic


