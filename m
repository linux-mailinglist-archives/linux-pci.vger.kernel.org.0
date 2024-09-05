Return-Path: <linux-pci+bounces-12815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13796D02F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 09:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6051F2358C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 07:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D16189523;
	Thu,  5 Sep 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="A9C26yYc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831104C80;
	Thu,  5 Sep 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520567; cv=fail; b=H91J8mAI0GfsiXEgn497MrK/QKZufSsE29+XTf5uZihvclYfQivICA71xT4/ZiFIbEtzVzLUb+EEls0UWwnAxCztOzB4KQIgQBm3fkzrJPyPpZR+nA76t6Y/YVwHDa5UkIS7Z6jHcqqkoWCEYLK9jofa9QAHoMRvA9G31N4tb2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520567; c=relaxed/simple;
	bh=ojXN5490vl/E6nYPNerS0dlgKyYurCev7m5KgmXsQGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tOX2jko9zamAt1FO9YTm5TszkD0Wpj+Ne7oBlOKdak/5LfxllIAyVDhZJTSMT5UQlXoIXLch7YBExD66d2mrRwHNh5CofrV5r0WTre0kmpbQxDvhdExjr4s89wBlwaApe7WqdTTir1fo+Y2lMAKVUkZBqbyV10Z/4ua92KqhXWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=A9C26yYc; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX4nAzfgsYUC+orqFmIbfJd7q0ePMoVaMU07nSfiZ5TEVDcm3XtA6l4qBjISnTnVJPf5LTwEtlTkASP4etGqPQ1zwpOEH2lqLHDP+wUvep+5ENBoHmTfsiPe6kb+yJky6nSIGx8lN8vKRgPL/LsHSJYMbxBlU7WOVNW5VpjSG/Ts50IXJ5jLHczuRxlGIHP/5xYELwKkz+HaPW5QZ8+X65NcYI3KLliC9HNKTjsmYEJrQl979PUsC9zG3hJ7TE/OQdGq05YifYz6pztd+eqfW/nN/F7bUhZydi82qnkW6aVSbUscSPzl3XnuHjpwwL88CPoq5vXgixKjvOh0NchgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fnFXoDlf83IyWImExLUZS8jDrn5eJAdbFRoq3U0WbE=;
 b=GR5n/HS5WaC2DGTT45c1anhHCoZ2jhhWb08ZzYtOUBKzKRWDQ/Fkhyb0Cv/XvqZ7tMKOMP4xgHAycegyRjgrAy6pBHkTcN5O3ruNyhwlO569rIZvcAgEVhsKZLI+A+18jQHBfF/rwbr4ULVKXMYYMidydOouJfVTDkP1WmJoIti60ubfCQoZy7umPrDsY2D2v9DNkjW1R7327ZZWBarnFJC9ofwXEMHULdXcN6ijFr2geouOMUqZYixCivyU8DVh9gyzdez2qoSwvn6ZkGr47pqoP9mq0AXrnPPmL+QWvB833YZFf4p4kUgXQ7tdrDrG5VBQn5cUBCGfGxRsEOqdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fnFXoDlf83IyWImExLUZS8jDrn5eJAdbFRoq3U0WbE=;
 b=A9C26yYcwf20vSMpfoaGvb2DKqjumQnxBJOvwG0QvTbSJLKSE8S9DN0SVASpDtV2w2w/sudFN+RINGpw+p35A2jLzD/3xpzLYGpAcdu6WahshUPZRl+oxBs1HY2G+agtQkHGapNSWhpA3pKUCQz5BhmCjOv3cSdbVyHJBhGbEPhYXQ/BZY9tg4X6M/lr8UF+3aXlHJfKmUr4etZ4cSJ6r0dyd2VjmwwfVr4TAJrEkl8UWzBGa/nyE/t2yMdGdMlfq0VpiA5F7hCdelPjtpFaseZJVerOTA2MnhbAtof/DONukKGU4n5dbq9niepq0XIUNHxgQDNuu1RTiLnbzOGAOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:15:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:15:57 +0000
Message-ID: <50ee7c83-7dd2-44b7-ad80-649db9a76077@siemens.com>
Date: Thu, 5 Sep 2024 09:15:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
 <t2mqfu62xx5uztlintofp4pquv6jalzace6w5jpymyyarb2wmn@vvo23e4cmu57>
 <4fd1d6e8-8a66-4eff-a995-5f947a4b707d@siemens.com>
 <669fa971-05f2-43f2-8c7b-d9de68d8910f@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <669fa971-05f2-43f2-8c7b-d9de68d8910f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae08bb1-6205-4f8d-442a-08dccd7a9695
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkZWaGNIZzE5dGplY2lHSFZqL293VUM4SHdEaXJHbXhrSUpLUXdIcDBiaG01?=
 =?utf-8?B?Wlc3Z3B1V3FhNmFUczVHKzM1NmxRTktEcWNpekoza1dJY1JPbjVTQ21XZklH?=
 =?utf-8?B?bHc5c2NtYm1xK3drQzI1bVBZU01jdjh1OFFRV05wcFplUDk4SksvQVhrbXgx?=
 =?utf-8?B?MkxEZ2VQV1ozYVlxYW14VnFFYXBQVjkzUlpTKzdyVlJhOHk4K1UrYWxwNEQv?=
 =?utf-8?B?bmlJZ0pTVXpRaEZyOE0wRG1aTzRUa3liV0pHdmluZ2lpd1BZKzdkZG5WN2Ev?=
 =?utf-8?B?YzdrMm96cVZqQStPNHRKUVpRalhaZjVwUW50aGNzYm51eHd5M2FSZUNZMEpa?=
 =?utf-8?B?WUVSazNXWUFEWFo0TC9ndHdaZWdBZU50L0pXQUdPSkhrQUxFZUpCMklsZ2JM?=
 =?utf-8?B?Q2FCNnVmWHpkUXNIdGU4V0lRZTgyeHMzcW5tbGIrTnRsRmFxVEUvTGd3Unpr?=
 =?utf-8?B?bDNyNzZVNUpMSjlEekl4Q1dMVVBHbytUS2xQL1B2MVlLZFh3SnZEMmtrWmxP?=
 =?utf-8?B?Q3AySlFiV0wrTkZFM293WjlPNiswQ3JyK1J5NFRhZFNBTlpwb1J1akRPYkky?=
 =?utf-8?B?engyOFMyUjBaems2VjdVV2I2bXlzeW91TndJdW13VERBZ0o5SzVwVjNHYXh0?=
 =?utf-8?B?M2hZbEprN1M4dWhmbDBhdUFWUGhGM0ZYemJkY2dMY01jWVZWc3Y0S1YyN3dh?=
 =?utf-8?B?NFgwVGlZUzRjN2lsQ2dkaE90TUtiN05QV2VzMDRvb1JrMkJVaWp4MWVZVzlk?=
 =?utf-8?B?NWduWldiVFFRNnZzZDhyZjFTTkJmR1lhaEZNVzNKOXVwU2lVaEhTMHEvbUgx?=
 =?utf-8?B?bFVuaFVoSmVYMFNPZkR0RmNYbHlUSU1WK3FEMURFT2M1b3NMQ3JTNWdmSWJn?=
 =?utf-8?B?dVZ0RDZrbkdNcm5qbkdEcUd0c0RqSHB3bnVDdFZsbDBkazdKTW9ya2sxZUw0?=
 =?utf-8?B?UnJMR1NqZnlUZnBSVEVBSFpWcHo1OUNXenFqS2lXbzZhTlk1UkRaWGsrMCtt?=
 =?utf-8?B?b3BuZC9IOVJtaHdBelY0aVR5NFNIeCtlMzZtTjZsOHYxY2RCUXFCMzFRdkpI?=
 =?utf-8?B?YXVUZHl1dllrTHZ2YjN3bmUyQjhVOHMyZVVKbDZaejNiMWNuS3dVODRCMGhp?=
 =?utf-8?B?RmhkZXdpd3F0U1FpblByV3BpMDFKQTFWNmYxdnhmQURhZTNaVnFia2ZiSDBv?=
 =?utf-8?B?TUdPRGNnUStLeXNVSnRrZTFNSVhQSUlFaDhoVlFiSXJETXNjQzdlc1MvZ1VE?=
 =?utf-8?B?bDkwZHcxNDJLQzJya2FkS1M0U3JnMEpQcW5pZW5kSjRPUzRYd0JoMmZ6ekNn?=
 =?utf-8?B?L29rcE0xbFp6NDV0M0ZQTVFzQURkbGJ5SFZTRXpxQ2xpVnFzaENYNFMyWEtJ?=
 =?utf-8?B?QmxqcEM5WW82UkFZMTUxR1hRelArUUI1dlNhUWxacVNDWWloWWhvSkZoQTFM?=
 =?utf-8?B?aWF5K2NsSzZISzJqYUd4b2ZTa2k2M2t6VHpjQkVPa0JaRnlDdTJlTGlBZTBH?=
 =?utf-8?B?RTVKdTJUZGFQQXBXMG5RNWtITUVVREw3aEdsRzBNaVRIaUpobzhEblUrM3Y0?=
 =?utf-8?B?NXVWL3g0NURHdGZ5UmRsTGQ4YWkrN3RVTndvQTR0SVVOeTdtUlUwZEZBZ20y?=
 =?utf-8?B?ZzhKRFBnL1ZTQVhjdFh3V1lnbmFlM0M4dnZoOXIzU1RPeVZHVldSRU5QYWJK?=
 =?utf-8?B?d1BMNU15U0N2NTZnbzhpcWdoUnBBcjhNM3B0Z3RMS0djQ1BvS1ZBK3NrUmdG?=
 =?utf-8?Q?1yzBV9Bbc0glSBNxl0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlhQWEVOMTNOSUx5QnBHY2tGMnUwMmFQNXZOakowMzBxS3VsTStKV0ZVbEVZ?=
 =?utf-8?B?U3UwcWJUL0lxRDJVM2FzS3dCbzRpVVI5V3FOcHh5Q2pjNnBiTmRRQmFMSi9x?=
 =?utf-8?B?anZFdm80UWlyRStEWUdpV1paNEM0WUU4aGROWlRCbDA4aXJyVThlSDl4RnY1?=
 =?utf-8?B?RUpGY2pQSlFEWW1Yb1paQTNrRHVubHhIQ04vbmJ0cEIxSUtVTEdaTUZJZGVs?=
 =?utf-8?B?SjdGSlNaYUttc0hTeStnN3ZvMHV3ZW9TaHpYQ3RKbTdjR2k0OVhZYjJhV0lW?=
 =?utf-8?B?YkkxOGZFMlhFb3NuN0NoZjRuL2NjSHpsV3ZCajVVcTFCZy9pVjhodmgwemZT?=
 =?utf-8?B?d2pKcVloK0F5RHNqc0NFVHE4ZndiOEwyY2NJVnQ4V3B0NzEweFlWTUxVRFNL?=
 =?utf-8?B?cjZKRGdzc0xIVWF4bGxLRURXeThjSFhvbFdvTkp1dEhiY0pwMlpNSzIrNUpD?=
 =?utf-8?B?UFlmN25tTXZxa1R3QVFVSDR0V3R2VHdxZjNLOWd4enY4enUxTCt6ZExaS1ZJ?=
 =?utf-8?B?dnJoNkg2Tmp0OTlXeHVkR3FuSFVLRC9ERjlNdkwzWFJmeW4wRXFkWDdMV0NB?=
 =?utf-8?B?ZktsMFdveFd6QkJFTmhLMktzR1V0ZmJ0V3grVWtEdERTc2gzZkw4MkwvMVc0?=
 =?utf-8?B?T0w0Ym5jNm04R1RuRGJMbFRlSjNaL0lObHhxN0dTaEI4MGZJOE92VlcwSHE3?=
 =?utf-8?B?MDBQbVZtbW5vRWlWbW5WSGpDTzVHOUhmM213c2ZYaUtuRjVXUHliYWgwUEJa?=
 =?utf-8?B?T2RseHV3K25Mdnk2Rnlpb25qUkJMTDUwTGdSbWtsa2J3U25ISXpZVUlwMTU5?=
 =?utf-8?B?TENVSWxLKzBiZ0Y0dFUrdTM4dXVwNEZ6VmVoS2ZxN3pqZ214ODMzeE9jTkI2?=
 =?utf-8?B?Rlh2OWR0d3YyOFd3TjNSVExKcWdOSERmU0VnNHhnUVNtbUY0Y0kyR01KKzVa?=
 =?utf-8?B?cUJEQ0w4cWc0clNwU0ZYT1BkNmhZMy81VW8yV0x0LzR1Z1d1UWNnYm9iRTVX?=
 =?utf-8?B?Snl6Y0VaSzJjMmRiNVIrZTI4MWNuMW9ScGhqWlp3L2tTbVZYV2NTTnc5M3h0?=
 =?utf-8?B?SzRuYmovUktRRm00Vy9OejE2OVlZYVhWRXcyQzBZSm5Cd3lSc2JuMjBsVW4x?=
 =?utf-8?B?amoyY1V0a29xT0F6ZVExVTVwc0h5S1hnM2hpK1hWRmRjUGxwSGQzV1dwbytJ?=
 =?utf-8?B?WEFGNjJVN2Z4U29VNEwyN1UyM3o1U0Vhbk5MVDh5dExxc0ZZQjBRM0ExT3VS?=
 =?utf-8?B?cmlYOWZlK2thcElUR2FmeWRUQXlHYWtZZlR5U25LUzR6TFRhRnhKWEkzZU5k?=
 =?utf-8?B?dWZLaWgwVk8xbkZXRWx5SXdxM1oxbVNiMnd1dm5vZzk1cTVCaVBKS3hnWFg3?=
 =?utf-8?B?RncyWWo2M2JieGo3ZVdZWFNxdk12OVRpTXFKdXRWdGJGZVA3UlQ3YmZsWldk?=
 =?utf-8?B?cm9qOHdCU3NvR0FVd2hlNlROWi94RUlWQWlPMkUzYXU2L2Fyakt2SWVFV1BX?=
 =?utf-8?B?V1hOYjcrbjJ6Tk95UzhoaUtPNE9wbURXTlhQQmtCRUVxNGlHcUk3MDM1dkFZ?=
 =?utf-8?B?ais0WmtpVnZVZzB4OVcrR2dtVVlyU095WjZ6WElJWXhaOXdzTG1GVitJRlRE?=
 =?utf-8?B?Mzl3emIxYnJqbkNXTHNmTlZtcW5DdHQ0OFNNYXRaZzR0Ukk2NU8rc1RqTzZm?=
 =?utf-8?B?NFUvd2Z5dUNycFhiV2hLU1RzZEhmZnBCU29ncWJqVDArODN6T3lGK2xBdnFD?=
 =?utf-8?B?MndiQkI0djVrQ0k4MldQRWt2Rm1MVXZlNE9HblRkeXlNRm1uSFlRVFlVMmFr?=
 =?utf-8?B?bmZvSWhBbW1wUzdxZ2xKL04wVnJ1OSsxL0RJaUthM3E4c0VtV3VqTVo1ZEd4?=
 =?utf-8?B?T05SemlEWWdROUUyNkxmZ3RxRE9pamlkWGNGcU9UWFk5TU5JbXp0V2tSd2Zv?=
 =?utf-8?B?Zi96ZlJlYVJMV3IrY0FVd1VYWVowMmFDS28xSnFkcFFDMWRYaGIzNGpBWjBM?=
 =?utf-8?B?YnRwTndXSEtNcUxydHludFJBZ3pJbGpBOVo1TmpmSDNJV3JNbmd3bithZGdx?=
 =?utf-8?B?VzdrdEpUYlZmYUZsSjROWk9HbG1BMElLMzJBSEM1SmlSVzNIalc0UjJhTEJM?=
 =?utf-8?B?S2tuZkNLd3dSVVIvWHhLdVh5WWdUeCtqSmNScVYvNDlUbzY2TTQzY0JpYlkz?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae08bb1-6205-4f8d-442a-08dccd7a9695
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:15:57.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsbhE98MLg887/OObbi/sOOheUTymZCWS0+isR27rm1kynJu9+G1yhhrTgtja0BbxyoXR55l5Z8dRZ1So8VN3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6776

On 05.09.24 08:53, Krzysztof Kozlowski wrote:
> On 05/09/2024 08:40, Jan Kiszka wrote:
>> On 05.09.24 08:32, Krzysztof Kozlowski wrote:
>>> On Wed, Sep 04, 2024 at 12:00:11PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>>>> to specific regions of host memory. Add the optional property
>>>> "memory-regions" to point to such regions of memory when PVU is used.
>>>>
>>>> Since the PVU deals with system physical addresses, utilizing the PVU
>>>> with PCIe devices also requires setting up the VMAP registers to map the
>>>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>>>> mapped to the system physical address. Hence, describe the VMAP
>>>> registers which are optionally unless the PVU shall used for PCIe.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>>>> CC: Bjorn Helgaas <bhelgaas@google.com>
>>>> CC: linux-pci@vger.kernel.org
>>>> ---
>>>>  .../bindings/pci/ti,am65-pci-host.yaml        | 52 ++++++++++++++-----
>>>>  1 file changed, 40 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>> index 0a9d10532cc8..d8182bad92de 100644
>>>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>>> @@ -19,16 +19,6 @@ properties:
>>>>        - ti,am654-pcie-rc
>>>>        - ti,keystone-pcie
>>>>  
>>>> -  reg:
>>>> -    maxItems: 4
>>>> -
>>>> -  reg-names:
>>>> -    items:
>>>> -      - const: app
>>>> -      - const: dbics
>>>> -      - const: config
>>>> -      - const: atu
>>>
>>>
>>> Nothing improved here.
>>
>> Yes, explained the background to you. Sorry, if you do not address my
>> replies, I'm lost with your feedback.
> 
> My magic ball could not figure out the problem, so did not provide the
> answer.
> 
> I gave you the exact code which illustrates how to do it. If you do it
> that way: it works. If you do it other way: it might not work. However

The link you provided was unfortunately not self-explanatory because if 
I - apparently - do it like that example, I'm getting the errors below.

> without seeing anything, magic ball was silent, so I am not
> participating in game: would you be so kind to give more information so
> I won't waste my day in asking what is wrong.

With my patch:

# make ... dtbs_check
  DTC [C] arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb
  DTC [C] arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb
  DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dtb
  DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dtb
  OVL [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtb
  OVL [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtb
  DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dtb
  DTC [C] arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dtb
  DTC [C] arch/arm64/boot/dts/ti/k3-am654-base-board.dtb

With this revert on top:

diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index d8182bad92de..dd753dae24c6 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -19,6 +19,16 @@ properties:
       - ti,am654-pcie-rc
       - ti,keystone-pcie
 
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: app
+      - const: dbics
+      - const: config
+      - const: atu
+
   interrupts:
     maxItems: 1
 
@@ -104,18 +114,6 @@ then:
     - msi-map
     - num-viewport
 
-else:
-  properties:
-    reg:
-      maxItems: 4
-
-    reg-names:
-      items:
-        - const: app
-        - const: dbics
-        - const: config
-        - const: atu
-
 unevaluatedProperties: false
 
 examples:

# make ... dtbs_check
  DTC [C] arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb
.../arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb: pcie@5500000: reg: [[0, 89128960, 0, 4096], [0, 89133056, 0, 4096], [0, 268435456, 0, 8192], [0, 89153536, 0, 4096], [0, 42991616, 0, 4096], [0, 43024384, 0, 4096]] is too long
        from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
.../arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb: pcie@5500000: reg-names: ['app', 'dbics', 'config', 'atu', 'vmap_lp', 'vmap_hp'] is too long
        from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
.../arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb: pcie@5600000: reg: [[0, 90177536, 0, 4096], [0, 90181632, 0, 4096], [0, 402653184, 0, 8192], [0, 90202112, 0, 4096], [0, 43057152, 0, 4096], [0, 43089920, 0, 4096]] is too long
        from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
.../arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dtb: pcie@5600000: reg-names: ['app', 'dbics', 'config', 'atu', 'vmap_lp', 'vmap_hp'] is too long
        from schema $id: http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#
  DTC [C] arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dtb
...


Which magic dtschema spell am I missing to make this work like you 
suggest?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


