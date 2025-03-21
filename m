Return-Path: <linux-pci+bounces-24284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F0AA6B298
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B8317645A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960DF9D6;
	Fri, 21 Mar 2025 01:17:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655A7E1;
	Fri, 21 Mar 2025 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519857; cv=fail; b=fagFULiNQ1nyI0yEbcTf+LIlLfDpJgcAmZ5ixQsqoU9QTODW10Fgy4Jfu2fJWYbDKrV/J0ayAB/TYp5VoZCMQ5aFcZpJZWelQSEly9jUfC7b3UpsEVDtXaMozJmF+9hGOyHH9E32h3+wjl4dpJ8dRpDg4xcVQ+qllR4dJjsdlCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519857; c=relaxed/simple;
	bh=+lL/PuaPfZbrM9FWfEQhwlVRMgu8sPvC26k1Tkum+ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q4FdZgLb4JQVv3KAWqvoZ9sr6Xz+HWpRbrMX78uv0SHBUVhSAvsc2hxl9vrciUk8VOiLx8rSSPBRn5CIh5vREuYpHl2oWibAHTX1q/xIIRxg/Ky8oKPcc9dQknSU4olXhYmQpQga/jYtEu1jBGcjDViQDKP63CwhLj2y+3vxct0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L15TZF003286;
	Fri, 21 Mar 2025 01:17:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45d0h96nbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 01:17:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk9T5nbCLmpQliwPZNJlkaZ02VstVmhJruYu7Clt+u73uE+i3OURkfYuE5vvR97tcmiefsPFPnV0yDcx6Hhkk/kko6znWnT4s/MrM1Ia5/NV7xpeZkYeUilONbwwvn4qEV41w8Q+0UHX4CiukGTxgWGNMDrZjWN86ZQlzJDqZO15b66mVrm+mOp39d3vLZGJ7fZzf5bIguXTIbVVwvkQFvj2yGzqPL4T85zdCzN3+B6Lr/TqGj/IBBvET/+i8b7oeLkK2kAynaVM26/ckiBNLtfIpomsUVc6Wj9sunu2l6Me0cOj5GslwvYlzZfYL98/6i8U+HV8QMcxQ1ONdAzN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8IXIoqFdNoO4ZedLRzDc4VgKCBdRjFtnOI2n3ty0Yg=;
 b=ky+CeA36pWxthpU0EUrPNXqbYtrUwZ4r9C1RmF8vl2XcQ1N8O3MfS5eXZwbT4NXMGZIQALRA0NofJX61KVpA+KZTzPmp35482cuG3E55pKTrrCtWGMbipgdeJRQi8DXkfveCOA4qeuaxinaorViAiSsmBk8BjA0s/Ndm0xIhxnwTTKSWMFmCpjsl2eDq8I2pVOKox/JQ7rXI19arvTmNd2AP1SuxlYKysp69AUSSVRQIkGHp4jsOiQjhPp4M3rPvapvXUrns1k3Qanu7frXlWIUY+9D5k8wa0vRMpEGhiodE3prXHJLY0wQt7a+bm3ApSIuKIlwJ2A9nO2pxwP+BBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by IA0PR11MB8304.namprd11.prod.outlook.com (2603:10b6:208:48b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 01:17:24 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 01:17:24 +0000
Message-ID: <0f75b9fc-88a5-410e-a07f-5901b16a1fbc@windriver.com>
Date: Fri, 21 Mar 2025 09:17:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: of_property: Omit 'bus-range' property if no
 secondary bus
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Vidya Sagar <vidyas@nvidia.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Hao <kexin.hao@windriver.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20250311135229.3329381-1-Bo.Sun.CN@windriver.com>
 <20250311135229.3329381-3-Bo.Sun.CN@windriver.com>
 <20250318062946.2udvt5uryf6y2jmk@thinkpad>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <20250318062946.2udvt5uryf6y2jmk@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:220:1ff::13) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|IA0PR11MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f673b7-225c-44c0-73e8-08dd681622dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHMyVTlMYUcwU0ZSVGRsejgvUVVBTXpIRWRJalN5ZEQwZCswaVgxbk9acExx?=
 =?utf-8?B?bitFaElqajA1YzdycG0vcmh0d1lFWWF4UmlFTFhrMmFjUnZKZ0NSYjNQZFJ6?=
 =?utf-8?B?NUpRWXdiVXNocldzWWs1NkhlNklPZWVBVnBUQlFPcFNjTDk3c0xmM1Vib0d5?=
 =?utf-8?B?ZlNuekpRdU5Fb29FUHMzakp6RSsvemQ5R1lpQzJQSWN5M1lIdlQ1OGIvWnhM?=
 =?utf-8?B?aDJ4OE51U2QrV2tEcytBU0pQUis3SXlLdmFVZG9LZXErTW9IRTVrTE9IUjRR?=
 =?utf-8?B?SFpnbXdLR2RKNENiYkh0akMwckkxL1hoYXA3bkZyMDlQTzd4c09sL0Vycjhn?=
 =?utf-8?B?SFR4RnJZQkM3TFZYK3UwSTJ2U21BWjY5cktPUk1wMUtwSFBzNEh0SkxJTHkz?=
 =?utf-8?B?MUlwTlg1UG9IYWYvcnM1ajJjSWxMOTVIa3U4dEZyQnVUWE4vMTB3aW9QcTF5?=
 =?utf-8?B?b3U2dzdQWWlvb0p4K2MvdnpaaDlKTFYzL1hGUEQ5YUIzZFBoMjNxTHIxZjBl?=
 =?utf-8?B?QklrdFlZOVFOUFBoeU5wcWpVbE9jcUxnZTVoKzRXemlOUzJPYXYxOVhCR1E2?=
 =?utf-8?B?eTlwWG5uS2tjTisyRUEzeGR0SUp0YmIzcjhqUExncVNBZ2NqcjlvQ2lOcjF6?=
 =?utf-8?B?emV2cUg1WmY4YnpCdUNhbnhFWHA3a2hFR0xFNklXaFBhTXVNMVdrdE9UeS8z?=
 =?utf-8?B?NEJJcVQ5akY5a0JsRW5Pb1JMUlJpZldXYzV1S0lWUUx2Y1dyblpuMlA4M2dV?=
 =?utf-8?B?NjBVc0xPU2Y2ejB2QmJFdXVCQiszNHhkQWVNR05rVjBEMnFlRE1yQ0FrdkF2?=
 =?utf-8?B?U0VPcFpCUXFXYm9ORzJKOThsTllmOC95SmpZc1ltVUcwREdnNit0WURHSnRF?=
 =?utf-8?B?TC9OZ2VkU1lKNVZyVk03c0hMTXAySkNtaFFKclRVcmwwZXVuQS9wTytIclM3?=
 =?utf-8?B?NG9yMG9oMTBSbkFhRlhMSlErU0R5RkFabkp3Y1JLZkIrK0VpWktYaHFKRGp4?=
 =?utf-8?B?TDNuMUdmeXZvcnd4V0Y2ZjhDbkVUTVdOcEs0NnM5RHdRN1hLWHYyOGswRkZE?=
 =?utf-8?B?SitZNW9mWE5FRHl2V3JxMnUwajMxQWw5d01hL3VhSUwyc2dsMG41d3Fnc25B?=
 =?utf-8?B?dENaWmd3S1R2UDBhaU1UU2p6UmRmaGIveHBVM0w1alduUzU0ZTJRTUtkR0tM?=
 =?utf-8?B?aFZuMG1qTTlGT3V3aTBzZDRac01YM2NOWUpaQUtzU1pNRWhCTHl3OCt5QWZO?=
 =?utf-8?B?ZWVzVGsrelNIb1V5NVhGZlMwY2o4QmZLREpPRGIvekpEQVVWcDUvem1vRGZD?=
 =?utf-8?B?K0xzYmw2cHZ0NitRK1BJWUVEaHo4Y2dMS3ZCdzRadTI3QklJVjJrajZIU2Vi?=
 =?utf-8?B?eHU3SzJnZFFpdEVwbDhXbUV2V2FCNFNFUVNNdzF2NFk3eXNqNVFSaUNKZmg4?=
 =?utf-8?B?RTVvNWZMay9iQXVQNjBBVHdRZ05GL1Ftdm1hb1UrVkIyYUpISGJJU1hBaFVH?=
 =?utf-8?B?Um9nUEtTRWRKM01zaUFOYklsMVFNNHFXaEFPNWVDOHdvOU9FVFVSSnZ6SHRq?=
 =?utf-8?B?RkdIbHFDOU95cE41VVF6NENya2dFL2JNRlZ3ZktsMGhhSFpud1pmMitobUNt?=
 =?utf-8?B?UmdObHhKcXpvWFpKKzRhSFh1Ui9Hc0x1NmRPV24rY1NyTTB4cytCNy9zK21h?=
 =?utf-8?B?OG1lYXk3ZWh1c2ZLQ2JJUVM3N0lzWjVyaWFRcjlla2tiOVd4dGFHMmwvNmxt?=
 =?utf-8?B?Qys4NURYWm9VVldEL25TS2R2NGZlNnIyekVualNwU2hNU0Npb08xMDJkSWZx?=
 =?utf-8?B?YTJoSmd0YkxoK3NpNFVyY2VQQStqc1BLN2F0ZUJJclU3YWV5OWVYdnNBeTlM?=
 =?utf-8?Q?JTXyv1zJtV96d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0syNDhHV21MU3doQWFEaEs1c0h3VlhoSXc4aEg4eXVBRUJHK2Vxb0ExOHRP?=
 =?utf-8?B?akMrN3c1RnEyMHdGMERqTG4wa1NhbWpYVEJadGpqVmZIazFUR2pWMGc3ZjFV?=
 =?utf-8?B?Y2FYUkFXT0dlL240U1hQWnVZWko1TmNLaWc5Z2lGajZFNUV0VkNQdTVuQ04r?=
 =?utf-8?B?b3E5NGNoVGEzMmMvOWFHK05scHlYSHd2MmljTXJuWFZ1cnViUFVwWTEwYjlt?=
 =?utf-8?B?Z3lnbkR6b0dlSjIxK0hKSmxVaE15SWZnMGJPN1ltWnNmS2dLUWYvak5TNjZV?=
 =?utf-8?B?S3NyR2xvZDVIN0F6NkczUkYzNXFhajR2N1g4S1M4OEp3S3k3eW1jYXFXbzJO?=
 =?utf-8?B?eUV1MGMvY1AwaHBSYXJoU1ZYWDVTbmZCWXM1KzVrb1NRa0FXQWlaa3FSOXBF?=
 =?utf-8?B?STlqcHgwM2ErSjk3azBxQStySUk1YTA1RzFHMFlVTWZHK1ZoOFN3U0pZUC9u?=
 =?utf-8?B?UlA0Mjh5UDQyNFdJaTExY2VLZENWQ0RpUUlUNCt5N1gyVVZNSWRsd01oL0ZR?=
 =?utf-8?B?aHRJYnUyQ0Irc3ZKdGZHZE5YdVdIcXZZK0RsM2xFRTl0OHFjQnhtN1ovOG54?=
 =?utf-8?B?QkNXTWQvaG9vcmZ3Rk96TStUUTFadCtUY0QzWEZIaWo3RU4xM3BwTHlOM3dF?=
 =?utf-8?B?QkkzdzZYWnpqcVpwTXVlRm1UN0lwVldLTGxtYXlEdEdESWRVZVAvOG9RRjJY?=
 =?utf-8?B?QXVCbHlUMGlDYzNNOFNBUE1BU0hMM3NZNXdWZXlWTDhyOXo1d1BkQVNGL0VX?=
 =?utf-8?B?cXk4RzlHYXp0dFZtRVErSmx1dHFNdUJuK0JtcE9KVmlFTmhYdmFMYUhvSmNy?=
 =?utf-8?B?c3c4VFFQNmREbm1iNHlxWENvRHlCejcvTmtVaFRENVU0WUY1THJnRXUrZkdk?=
 =?utf-8?B?ZXNhWFVVVCtsYXJMMnlVRFhXYUlZRU16bHV6T1FycEwvZnZlSTVNcS9kZTJt?=
 =?utf-8?B?b1B6cmZIUjFtM09LKzdXZnBwKzF2dmVBM1A3ek42SWxodmFQUmp4V3ZESGl6?=
 =?utf-8?B?L09JRFA0aXJWZGFRcm82M055d1BIangwRW5tcDc5Mi9HOW82cDNkU2hTQUZl?=
 =?utf-8?B?am5iWFRvOU83NzFUdGZHUC8yeVI1cXJxeXVFWXFJTFhDbVdzem9KaW5Jd0NJ?=
 =?utf-8?B?Qk80dkkrU3ZLc05uT0orZ3lQV0ZZakFlYTNqSEx4OXovd3N1YkZLTU9JdW4r?=
 =?utf-8?B?RXVBM2RmWXZBcHY4YTFnNzRUb1FuQld2VHRpZjd0eUZmY29kK2U0NE5hOGNB?=
 =?utf-8?B?Zk9nbkNOd0F0NGl4VlhyT2ZGNFE1SjM1REFpTFhJTVY3Sy8zRXhHd0ZrSjVP?=
 =?utf-8?B?YWJUMjk3M0Q3bEl1ZWxLM2Y2dDZwc0wvcUJvckRSaEgrTmNaa1Q0RzNJenBG?=
 =?utf-8?B?OVVHOHF1aDM3MEZaZ2I5eVJVc2c0UG1LcGpBMHFVazF0SkRjZHI4ZHBVd2tD?=
 =?utf-8?B?SHp3cnpQdDdGUkk0NGhPdTZYMWxnTXlJZy9vYWNyazliZlZxVk1JeE9YSGVQ?=
 =?utf-8?B?bTd5dTl4bFpnandqZjdRRTFhMkhrazJYWXVWM0VFTnlUZjhxTHUxMEJET2N2?=
 =?utf-8?B?TW04V1R6dWxmcUQ1Y1N4NUpaL0dsUWdWVlNoN3A0MWl3UnAzaU5qQUI2dmNC?=
 =?utf-8?B?QWpRTjZ1M3pqamhXS2xPZTJwYWhwbEJ4YkdJT2Z5Sjl6ZEtwUVA0Q1MwSTVH?=
 =?utf-8?B?RkRMTjlNOEF3RmFQczRsY1JqUC8vdFJwOVJaR0pIb1UvMUxtVG5EajRMOWxY?=
 =?utf-8?B?bFdQdytKQVIwNzRRVE80dkVYeUorV1VQMlorVFZRbWo4Y2U4VU1QNHR4YW8v?=
 =?utf-8?B?UXIwQy9FZTN2YXc1bWxsN05TdkNSUmxIWEZNUkxlTUxrenhFcXdVTTdmV2JB?=
 =?utf-8?B?Qk9CMUFDbWttWmJwMGlqczVFWE9EVGEzQWJmTjFRQ25qTDFWbmdpMGJIZUtH?=
 =?utf-8?B?RGcxb2Q0cU1JSUtGN0wybEtYQ0x1OElBRGxMRkVTQ2MrNStQWEl2dUxobWNm?=
 =?utf-8?B?b20xbGNLaUJwbVJkOU9sZXp1dDFGaTZnaDZNUndKS2tkMEljQmJHSWxQN1Y3?=
 =?utf-8?B?dk42eEppRGV3ODVBL3MyL0VlQ1dWVmlwVDkxdkZjaWQ5NitFamxjVEN0Y1kz?=
 =?utf-8?B?bXdmQWNGQnJhT1FYaWxPYzBzVS9vbWh5ZGtUY1dWODVzMzBjVGtic3V6UVBl?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f673b7-225c-44c0-73e8-08dd681622dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:17:24.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxUVSoD0/XLwdS7s27H896VDF5gYige5JtFXAUxTYXy+XfBEmA2ujjviPKFUxV0JOEy3vtihBjzHH/HWAUrOsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8304
X-Proofpoint-ORIG-GUID: p4CZV5aqvHoP4mRSdih1VAXneqGzSL7W
X-Authority-Analysis: v=2.4 cv=ROOzH5i+ c=1 sm=1 tr=0 ts=67dcbe28 cx=c_pps a=smr7v+wKk2SgYJk0SwJNKg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=gafl5Dy9YAt0WcwJN_QA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: p4CZV5aqvHoP4mRSdih1VAXneqGzSL7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_09,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=695 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503210007

On 3/18/25 14:29, Manivannan Sadhasivam wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Tue, Mar 11, 2025 at 09:52:29PM +0800, Bo Sun wrote:
>> The previous implementation of of_pci_add_properties() and
>> of_pci_prop_bus_range() assumed that a valid secondary bus is always
>> present, which can be problematic in cases where no bus numbers are
>> assigned for a secondary bus. This patch introduces a check for a valid
>> secondary bus and omits the 'bus-range' property if it is not available,
>> preventing dereferencing the NULL pointer.
>>
> 
> This definitely needs a Fixes tag and should be backported.

OK, I will add the Fixes tag and send the v3 patches.

Thanks,
Bo

