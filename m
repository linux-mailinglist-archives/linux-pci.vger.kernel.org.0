Return-Path: <linux-pci+bounces-12285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D60960C49
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17D9285198
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ABF1BF331;
	Tue, 27 Aug 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zzsEHyNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B161A00EE;
	Tue, 27 Aug 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765901; cv=fail; b=GmckHRslYL77sedCVNIDL+w+972IbqOUauCah5rozPtD+l2qWajLYVjyF2R02dUyX1WERSwIf9R6tFCsEK8inj/x0Ay98VUxdEEv4WRYrL+rQRsiVwvV6/rAqS0016hVW2jis0Kc3iKoVfC8NQh7B0hHB3YtSpeLU2r7+3tbb58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765901; c=relaxed/simple;
	bh=YywR7p4tAl64pB+zofpcXybUj6jB/3pg+0wo3hQPdY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g5INaW6iGCGAdTU8po/lHV1TJ+FdW7yYHHfEOhbAfuB7Zeo7IqTE9V8Dj1v8WKiaLo4JF/Pd1xFvLwxluWBHgkyZtam+y1S8g7G57gBRInm3+FCxrX6fxLzIcWRq2WhFN3kQ2S0AUwomBfooumypAoy07VebFfg7qIv3XsUmqXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zzsEHyNi; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8N7nDrpMZrPZAk4MkmuOF3EtWw1k1HozUfmYV235y4XnDf6Fx4XHTS4HoUHQFB6fHbjTEkMPpH9TXHb8zxA7y0rX6T+92zD+KwubbQbbB35g3Jbh3iIjhti7vPJ2RaMEB86yO6+IpgIH4Fx5Qe4p8gRtJRv1rwD87/jSQqYSbP/C/UqLWmAVUcvtuVTPCm3Avul7ZbQ5zTZYOWBfdWDS6Jwlb2vHEi2bU/Jld5jcF93GAM/O76KV4qiJ3j45u3dPepBtOUYgOtrRrxx0nXjU7VOVs8MhAdvtEcrRtSD9wKz5SGBKMcoO/O69fkizlbXHevgoKRf2WGV3polKjlQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiBmM+MgVr/eYKD7xrGnlDSs438PiKhaaJI0eVij+Pw=;
 b=hHUHSJU5+FHd2DNs+0JvYbXv8zsIMdNpBJKVDyhDYlA0idOkMi66uY1tLfXGzcW/+vAGJS182ivY3dRnjLkT9rkOGsWCGbNg3/DBUKjsOU97rpYeYFUMrhVIPVSzO6waSxOvsjv+CkTDQs+k9Mfo3tJtVOVU/1DUSqZb2fPhJvZxe3Zm9W7T2vuHdlmYOGRj62qZcuvKT8eQLA76dZkjkWw6lBcWt0FgO+jVf7u8i47/pDb1JlA0Xl88HYxB4bJAtLk8u5aRceHmcPOlJ/CK/VVrN6nRaetk5g3c6l26BbpNGTE4QzNreYR8J+ioRwPjnpwG35MH8ukdueERNnoWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiBmM+MgVr/eYKD7xrGnlDSs438PiKhaaJI0eVij+Pw=;
 b=zzsEHyNiuE7EYIeGAvIBOtO6P75SzI/bzgj15ymEBI7uG0pwltScv/H9k/6lx8VYW/Nlu5h8ArtPGqa7gzn2ohXEX6FuSqnxoiOlHZ8zkpIZjf7PFm8M8z+4nWYHB+rEyNLMq20NRsnm2urE9s5q50kHb1yA7jgx8jN87AMx5VEDf+y2PcGNJzm5SO05rBBgGyUvHoKoOb7NzbGsXjS1mAF5wQnCfv8keDPM72Pco/IAXHm68GOu/6VzUedZ0D5+DQo68gDmR05N3bXpXy9GIGSiot2u7/4puZxTourp+s/hPKd9Fxd3zkYDqr3NCAxHYq4ICb/K7NgCuxGR9OT5ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 13:38:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:38:13 +0000
Message-ID: <5b09afe0-54c6-4f70-8748-c49918005b7d@siemens.com>
Date: Tue, 27 Aug 2024 15:38:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] soc: ti: Add and use PVU on K3-AM65 for DMA isolation
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <cover.1724694969.git.jan.kiszka@siemens.com>
 <93da058b-8d72-4f76-9ee7-f6837a1a4a9a@linaro.org>
 <3dcaee19-3671-4658-a2e7-247e42b85805@siemens.com>
 <2b368426-a572-4d3c-b991-9532fa828d23@linaro.org>
 <bac7e1fb-83d0-40de-b789-0a4e469a0b64@siemens.com>
 <d67019fe-2107-4a8b-8495-4b737afb6e93@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d67019fe-2107-4a8b-8495-4b737afb6e93@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3348:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5d663c-8395-4b6c-ad6d-08dcc69d7f6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk0rMFhMdE1ORDkxTnVBdmpKVGNUejQyUmJHYUwxdU1yNlpGaG1lUXNEQm1E?=
 =?utf-8?B?S0kzcld1MTRSb3l6c2RoWkZIMVcyN0FFM2psckJobXpRQ2dYYzd2VklRSHo5?=
 =?utf-8?B?cFJBdEVtTlFBbXRFVHBybGI4YXVqK09xMzlqYlArbURiQkl5UTRXdFpXYUF6?=
 =?utf-8?B?Q2dxc0NwRSs5bjNaMjgxSXo5dmlJaDRuVEJwL3N0QnlOUWREMDdKdkVsRHZo?=
 =?utf-8?B?UXJqMWFlWXlUWjZ3MXJJU2ZRYzRPRUZyUXl2Qm9jbXN6ZERvNlNFeTg2YVpQ?=
 =?utf-8?B?RTcrMStXOTFqalpRWUZ2c3JpMzBEaE1Cdk1lN2xUcEdrdnl5NHBzNmk1WXl2?=
 =?utf-8?B?WThQbVJocjRTWWY0cG1YVVBGZVZQS2dvaktjWkNoSXBWT3JSWDg3bnUwS0xE?=
 =?utf-8?B?bGROVEF2VzhoTGxLYW0rYlB0b1NSaE96OHU5ZWJpTTRWSlBneGgveWlBR2d0?=
 =?utf-8?B?RWovaUYzeGl3emhWMkJjcHFoR0Y2NnV3SGdFdWhmM0k0SXNMMW1xaVlpSFA0?=
 =?utf-8?B?d1NKWHRNKzlORUowTHBQZ21qSk9OcVBvUkhSM2IvQllhd0VPVms1RTIxRUNF?=
 =?utf-8?B?bVFob3BDNG1jREkweWJuendWdjBrMkZDTllWNWIvMklGUllwcVVLaTRtLzNP?=
 =?utf-8?B?S3VkZi8yeWpKTEVqbitFVThlUis4Y3V0NTJGRkEyOFFYekpqaTVFeFBwUDli?=
 =?utf-8?B?K003TFppTHdIMmhoY1RwZVhrcHRDa0o2Q1Q0OG8wRmQrNURKMjJxMm9PWFRG?=
 =?utf-8?B?MC9rVDQ5VVFpOHpWZXY0MmttcVB3QlpqMXA3b0pHNkpCdVd5em5SVGp2cTNV?=
 =?utf-8?B?UWFWK1NDRGdsdlN5SkhoTzY5ZDFvdHUveHRLQWdOVG85c2FCV3h5dE1Bankw?=
 =?utf-8?B?aWg1Y3gyL2UyZi85RGxaQVEyVU12alFBT1ZTdGVhcVRJdHgvVnpNcGhJVXd3?=
 =?utf-8?B?RUs2T3N1SzJJUXpySXE3U052TEJ4cExNZXZqcUJabmdJZWVkRzBBL3dBbnAz?=
 =?utf-8?B?NThkbkFOd1dzMDF2SEs0NURFNzJXNEFXSmFIZFpUTmdacHFoVy9XM3RjSjZS?=
 =?utf-8?B?VTR0MzZENHFuN2tUQ09VU2pKMHQzV3g1aWFVdDR0R0l1WHhkTGNEcDBJTFJo?=
 =?utf-8?B?dHQxdUpremNySzQ3S0MxQS9ZTVgwVkNHeHRidjdGYW1zTEZ5dFpXTUhQNThL?=
 =?utf-8?B?QmNRaThHTG83aU94VFRoZU80NnRXR25vTThVRUpYNCt1NksybHMxUXdubStk?=
 =?utf-8?B?Y1gvNVMrcG5FSm1hR0FoUDRmT0FrNlVnem1CUEgzUzcwc0pJWWpRS2Q0TFp6?=
 =?utf-8?B?NjJ3VDFMTXZaQzgvZXFSZ2VDNStRK2ZJa0NLVHFwbFVQMWR0bi94NzBGRXdG?=
 =?utf-8?B?V3gvOEp5cWhmdnc3NE9ENG5pQ3RHS1hUNk5qQXBzQkFkcWdVTEJmVWhLRkV1?=
 =?utf-8?B?U05QSm5vT3JTeW9rMnJtV0NZVXA5S0pGbzNNeDJudWljL1lmWUVBa2g4Wkpj?=
 =?utf-8?B?TlV3ZzRzUHlyLzkwODlBc01kUjNpTUpWd0hsN2N5VTJPMmJWbCt5V2hrNkRH?=
 =?utf-8?B?bVlGTDdHZUpveFJ1U0dOMDBkUVRpSDhWRU9zK294U2JydzdHNVJoVU1HRkRz?=
 =?utf-8?B?RC9KSjlxcklsUXBjS241R0RNZnNlWXlJQndpYU5Ud3Z5ZWpMV2JPb0RHS280?=
 =?utf-8?B?bnNDZXFFTWZYZUNZdGFOdmZVOStjTVVLWGowQmUrd0xqUDlhUjU1L3dSa1ZF?=
 =?utf-8?Q?PPKwHqzvPD7io8UR1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0dCL2czQmJJQWV5c2hZRXp5V0tiaEFmRnRDMkZRQzBLN0daTDdCcHViZUtk?=
 =?utf-8?B?T2FJaG9pK1dqdGRyeGxiQjdOU1A2NG5WVFcwVHlKdEpqUEhJV0NaNkpRdVU5?=
 =?utf-8?B?cEtIL3I2WGVRdWxNbU9LQTR6SytGTDlKOXhKNXl4VjlqeFBJRFgrbm5HNzdl?=
 =?utf-8?B?bFl0bHhMRWVxWFRNb2JiajBKaHkwTXpoZDRIVDlSUHdlS0d5aGhyU05OOU52?=
 =?utf-8?B?RzFUZHcxNmRSWldXREo3dmREZ3JUL01Ta3R2cTlQLzlsWTc0dERCU1VqQ3FJ?=
 =?utf-8?B?d1hrYnVaZVVlVWxJUkZzZytycnExVnhiTDRva0NoOHVXeXFadzFTeTRodHVn?=
 =?utf-8?B?SjNWSzVHaisrdlpVb290bVR5QWN2R2RjOForVHhRL0wraktCQkpuU3RZaXpI?=
 =?utf-8?B?bFlvMU9NdVhzZkRPanBwOUEvTnNIeDM1ZnRHSXhxRlc5ZTFDUXJ1Zy9VRlV5?=
 =?utf-8?B?a1Ewb2lINTlleS9RZldDRFVBRDlPRDNFeSt3S2dGUHZPRk5BKzl3R0pXWEdZ?=
 =?utf-8?B?N3VpdXlpQW5YVmxkMnZ2YVFmUFV4cHJPTzVwMDAvbjRxWG03VEY3UU9FTnVl?=
 =?utf-8?B?N2tYOHp1ZE9Pa2syWUpxOWlrd0Ivd3FpNGlVV0t2VGJsM3NWOW0xejJqeVlC?=
 =?utf-8?B?SEhUbVVvWktjQUVFSzR0N0VUUTgyTlNGTHIvRFpROHozLzNOdFNYL0kreHNN?=
 =?utf-8?B?d3k2RldZdFVKem5zQktNa2FKeVkwYjVkenU4MTlRQjMzZFRWZUFpcnU4R2d1?=
 =?utf-8?B?RnljWWZLV3gyeDBNOXJSbHVtVll1aVZFMnNXMXdaY3lyVFVIZStkOVljN2Ux?=
 =?utf-8?B?cWxjNmVYRDloSHNwNG1DS2x1NzUvcDV1OTJhN3k2V3o4ZjI3ZG5oN1diMXRE?=
 =?utf-8?B?alJ3U0xNMVpTUGJKTndaRUJMa1B3aG9ZUGxodjk1a2ZCTHd4K2FrY0JtRlQz?=
 =?utf-8?B?NFp6S1N5R0h2bW5ZZjA5M25sVEgwQVlvc1BDQXlwWkl0czF4ZldpbTlNTGI1?=
 =?utf-8?B?NWJuMndDTDBnRjA4Zm9pU2M0V3hyZTZsQVFxNzA4YVBxK29wZXVlL1NROVRC?=
 =?utf-8?B?TWtlWUd3K00wdVI5UitUMVNKTWpiUjdtZVZ6L1cvNStabmp4SUtNbEsrQjFZ?=
 =?utf-8?B?RnNISnRoK09UU0ZRVjczdVI1dFdCR09XTjJvOWwvbFhST0pOYk5GWjMyUXpQ?=
 =?utf-8?B?b3Nxc29EVmtTdDNUdkdTTktnZlVzRWJJYVdVekhMZk1XdjZiMHA2RlIzQjJQ?=
 =?utf-8?B?bTkrZ3N6MWdYc2tlc21HWUMzWW5YMy9vM2VDb1lZaTJQRWNxOWhCTmVIYmRV?=
 =?utf-8?B?aEV2d3Aya21CN1BsKzFJTVkyMzg0ZjZwVHhQVU1WNkhyK3ZXSS9tbnpIU0Z3?=
 =?utf-8?B?cG1xSTZ3THVieEQxRHVCQjMzQWlJdjZDVkZNS29PNitmdndlR2ltMU9pNUFx?=
 =?utf-8?B?Y1pmZk12ckMxZFFSVU1XbU16bjRtdGpVbTgyNVZYRnRZN01taHhjRnAwMVdy?=
 =?utf-8?B?QW0zSGVEeXpqZi9MWW05TDBobHR6SHlXR0RNakNYMlF5SHFSbFM5UU1yR0xt?=
 =?utf-8?B?Zm8yYjcweFM5M0ZuUkpneGhEOW9aKzllckg1eCtrbmpIM2VwK1lwM0J0cnQ2?=
 =?utf-8?B?Nk5pOXkycGZxYmgrcDNDVWpxWmp0cUxka1BNbm1kMW94YndkcEdyQmtWM2hQ?=
 =?utf-8?B?dW1SSy91SHNVYmVWY2NjYkFYb3d0Y2h5T1JoRWhmdXN2YUc0WUpBaWdrbzc4?=
 =?utf-8?B?RlRCWnJaNHhydi9GNC9OempUOWFOclI3eEpnZ2VudWZDWHJBOUNKeXR5NUpX?=
 =?utf-8?B?b2l6blZ0OE1FbVozNmMwaXQ1ZmJadmgxOStWRHZiaEl0MjM0RHIwMFZ4ekc4?=
 =?utf-8?B?Q094bWdBbXJVSFFma1ZpRnN2aEJVOXhMQ3gwRHBmSUpQNVhobTdzWEVKWjh2?=
 =?utf-8?B?OUoyWlQ5QmFFNS8vMDdoYk9vRVJZOUZRMCtuSFZWV01LUDRCd25MejdmRFhE?=
 =?utf-8?B?NmlIY0d4TXI4QUlJaVNwWXQyMUNlVCtXSGNjV2pMVHpiWTNwZEFxRWtGaDN2?=
 =?utf-8?B?R1VSNW8vdEtYWG5HNTNhdFVXeUhLZnZzNWN5YzlWMVU5WHhUc3FBTGE1SzQz?=
 =?utf-8?B?NGJKTDAxRSs1Y0FUQXBzclNWTjgvWlJiTGdvMmZ3NnkyNFAzcjlCWnAwVm5X?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5d663c-8395-4b6c-ad6d-08dcc69d7f6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:38:13.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP9nwGN4vc6wEpCbCULQy/Rd99msjv+oixdYSQoB8whDXsYYT1Z3hxzNolz2SKKbkoKpMQ2+hxv88vIi4A0g+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3348

On 27.08.24 14:44, Krzysztof Kozlowski wrote:
> On 27/08/2024 11:22, Jan Kiszka wrote:
>> On 27.08.24 08:35, Krzysztof Kozlowski wrote:
>>> On 26/08/2024 21:25, Jan Kiszka wrote:
>>>> On 26.08.24 20:53, Krzysztof Kozlowski wrote:
>>>>> On 26/08/2024 19:56, Jan Kiszka wrote:
>>>>>> Only few of the K3 SoCs have an IOMMU and, thus, can isolate the system
>>>>>> against DMA-based attacks of external PCI devices. The AM65 is without
>>>>>> an IOMMU, but it comes with something close to it: the Peripheral
>>>>>> Virtualization Unit (PVU).
>>>>>>
>>>>>> The PVU was originally designed to establish static compartments via a
>>>>>> hypervisor, isolate those DMA-wise against each other and the host and
>>>>>> even allow remapping of guest-physical addresses. But it only provides
>>>>>> a static translation region, not page-granular mappings. Thus, it cannot
>>>>>> be handled transparently like an IOMMU.
>>>>>
>>>>> You keep developing on some old kernel. I noticed it on few patchsets
>>>>> last days. Please work on mainline.
>>>>>
>>>>
>>>> How did you come to this conclusion? This patch set was written for
>>>> mainline, just rebased and tested again over next-20240826 before
>>>> sending today.
>>>
>>> You send it to addresses you CANNOT get from mainline kernel. There is
>>> no way mainline kernel get_maintainers.pl produces them.
>>>
>>
>> That is likely due to that I didn't re-run the get_maintainers.pl for
>> all areas of changes but rather reused an address list from a slightly
>> older posting, sorry.
>>
>> IOW, your assumption is still not correct when it comes to code.
> 
> Sure, I see results and I am guessing the reason. Keeping the list
> static is not the approach you should be using, as seen here. It does
> not make even sense, because then you need to keep several lists per
> different subsystems or you CC unrelated people (don't). Just use simple
> wrapper over git send email, b4 or patman.
> 
> https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91
> ha

Those options are useful, unconditional automated usage of the script is
not when you might be targeting multiple subsystems in a series (not
that uncommon in our scenarios). That's why shaping/confirming the final
list remains a manual step for me. But I'll improve on keeping it updated.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


