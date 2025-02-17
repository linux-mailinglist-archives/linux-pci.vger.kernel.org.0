Return-Path: <linux-pci+bounces-21589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCFA37D15
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 09:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7BA1887006
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85019CC02;
	Mon, 17 Feb 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cMS4seh4"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011039.outbound.protection.outlook.com [52.103.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5F17B506;
	Mon, 17 Feb 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780547; cv=fail; b=hgOd/8EP/7uPm5wpurmeRwtaAHoLwnGAkpVC3pA2bKDzhaZWCOVSlFZCbBYhsvj0UtvqpUZ+LWnHfMkRnNZbh3DACQpDiF+gAJNToGL90C7fSgSYqLCPKB0XR9M7Qli+pwwSOGIadcDvOPu4i0rwCv8SRhkUDx6n8YLhK/cqZrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780547; c=relaxed/simple;
	bh=MYbbFLfn8NU05AYSvjk7PNzVZotERAXVIAgEqXeiBow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OSzI4cYoo6OvOWZPgxiwjn4VzsfedKTDkDNetTt8RhmQhO9vWoSy1DbhQj0frJnGKHMxn7ZnyaobmT9+8IWEZd7b0UB/SWtcPw6zPoMFVroeixs+xH14POspQpFBQey3fnSLqOL55LrroMSLhdlhzGN/dtbMTiNz+3ttrf8XVpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cMS4seh4; arc=fail smtp.client-ip=52.103.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2oCNUiBmlOG73nVn0rA6EYbbUf1Xolbi/evrY+oSf967G0Jpia1yfe/pCrg54+Q0EYCTneHbwYAO2AN4auIYHWlPycHJB16hYofYYpFynqwhrDCXJUqeHoMD68K7O7H1NQKsFvyB8WIU3KVTskqT3MmJ46iDOKrGqy0+xJdJyjK2Uzjft9W6oQH4ELyx8TAi+CAPbEdqOX/yDux42mnApXXCw7Bxw6eZgHTMvTqqZ489105K7jO9wOQZyqwiQJrldya0VCwJoDRz0hB/Hp/t1ZNEyve0wfUodvge97dKvIcMz7us+XOm0w8cywBHqVO4yQs7ZmjSwfg8VHHNA8ubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Z80JjkPmiEvyWEEXR8fcj0Ka9yDmmar+GY94yExG0=;
 b=Kaes00iKK8v0Rqaw1Y2V2ZpLwXvJBe4xHE4FesCU0ffkmozG45QQAxS1Efpu0stL96zcj+kbfCCYh6I1o4oaFdKwNE78NOjBsMoAFtJ0qZIkQ3gFUIZVfgt0Rf2UkdkV+K0KhjME8BTbhuPMTr9Rv9Rcqs7Bjhy52abCjGFWorfWuMlV2P+vTAmXggCF9bUjcIpfwv4o2CGYuT7fsc93A9S+tqLigp4+gGONKAWB5F3+B1ibCITz3Irol+84v84eIesiY5cJr7m/3sXxHuZBRITci2lTvLol1LPdCZvqsdMmJaCsHjeUFRf99KSgoBfkitWl0eKSQWqrVagQmqbDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Z80JjkPmiEvyWEEXR8fcj0Ka9yDmmar+GY94yExG0=;
 b=cMS4seh4E5B2w3bdFOV9T6L7wp6qHoIAmjvUUq+cghGHiWRAeqXtBaBK+WSE6TPCieo2OgSJrjp/VmrcgYgTguiXMcpDH24+3So/Xm46sDhhLW7NRfuDlikidOe26yeXikWrTSSGF9Uard6jfnGo2LDk6zu5OY6wRmTY+evGN4j0Gyt6YdmpQ4q9J2ZisHZAiOIZ0VMrR3UZZtkWxi2vF5MOyVxtM+d3rgvNPZHeM6s97bKBG9lgcp5H0zTKotnD6J6uP6RvAtHjGi/AOQ3yGJ+6Ousg9rzVpjus9zF4DGqxyexHhPWsP5lrw+phU9Gs5fQ1NrKzTt3xg/AxuxBppA==
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::9)
 by PN0PR01MB7719.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 08:22:15 +0000
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee]) by MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee%2]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 08:22:15 +0000
Message-ID:
 <MA0PR01MB56715414B26AA601CFFB54C8FEFB2@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 17 Feb 2025 16:22:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, maz@kernel.org
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pbrobinson@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, helgaas@kernel.org
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>
 <20250119122353.v3tzitthmu5tu3dg@thinkpad>
 <BM1PR01MB254540560C1281CE9898A5A0FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
 <20250122173451.5c7pdchnyee7iy6t@thinkpad>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250122173451.5c7pdchnyee7iy6t@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYBP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::23) To MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:6e::9)
X-Microsoft-Original-Message-ID:
 <82f5ef91-4305-4b18-ae57-5d6f20a33fc7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5671:EE_|PN0PR01MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7df507-f591-4f13-99ee-08dd4f2c2f1a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|19110799003|8060799006|15080799006|461199028|7092599003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTczTmo3MGpxZEJuR0ZmWHhlbWdEUEgySGlzdEFyRTJYL1JrQmZKenpjTFgw?=
 =?utf-8?B?RXM1d0Mvdk13RWE5ODZYdGt3VTNnREZhRTJ3ZUwwbUJ0L1dvVndieEtSd3J4?=
 =?utf-8?B?ekxuK2lxMUFXR0ptanJNOXhGdCtKdGJRWHJWem93WWNnVUI2RUg0ZmpOYnEy?=
 =?utf-8?B?UW14dTN6NEZXZHNpWG5FTGV3d0x6ajhiZTlzSk9wZTd5eVZWbnA5clRpVzBF?=
 =?utf-8?B?TGdNRFZxTnU4ZlkrTkJ0dlNXMjF2VzVoVHJkb0RMM0xIYXFpUGY1ajR1NmJZ?=
 =?utf-8?B?dzR2UHFoU1FnYjEvczd2VnJobGFOYlc3d0dSSUptaUZTR1IrYmJmTkZPdlBY?=
 =?utf-8?B?UUhpanI3U0dvTUpvczhmYTBuM3ZRbjBUdFJxVXEvY01lN3hxZzZTUlVkWFRX?=
 =?utf-8?B?WEFLSjhQR3pjanJuSGZza2pSZW44S2JhcGdqMkJiOWtwa3kyeEU5Szc5UW9k?=
 =?utf-8?B?c0t3bk9GRU9sdWlVUnR0cTFWQVRQLzF6aERTeVdHdk5jOUJhdmVoOG0rUWRm?=
 =?utf-8?B?dk1kcmoxajVxSzF4cnUzbnF4NTFtRjZvaWlZS3VqU1VobUNwSmdhb2I5YzBN?=
 =?utf-8?B?SFpXWjBXOWhYVTROSVluQjNHSFkrcWl6WVdLNllDeUJOZXgxVmJKTC9HV09S?=
 =?utf-8?B?UnVsMlpLbEdBVkhjcjBRTERJcllsMGR3dkgrSlN2eUpua2J1RDJUQ2x0ekJu?=
 =?utf-8?B?Vld6WlVBdEUyU0ZiS3pycUZIOU9kbWkyY3B1aEU1WU4vVEZIY295L1IzSEh5?=
 =?utf-8?B?NVV6aDdpa3FTVUhKbXdCeWdYSk15NXZnTHI2ZGFTOHU3elIvajNGTnBGMnJM?=
 =?utf-8?B?aWtsRU1OSmF3YjZKZVhCUVJ0eFcvREx2U0N3NjN5OHpYYi9sUWRveUszSkFP?=
 =?utf-8?B?TkthN0NRL2tjZHFYSGFxNzJzc09RVUtocmdNVFRsakJSMlJyZUpwQm9nZzVj?=
 =?utf-8?B?bjZ1WWdsOHdNQjZMdmpvcjgxOFFINUpRWktBSUtqakQ0TSsxaU5VTVdTQ0pz?=
 =?utf-8?B?MHEwVGVlVGFNSWhNTmxPN1hldFRKYVRyaCs1dTB0d1JZQnpsNER4VUVDWTBW?=
 =?utf-8?B?M0tLQXFtcU9PRmhHL1RLYzFnN1NZSFp3Y2VKTnpUTlNuSjZXY3U2TUxhU204?=
 =?utf-8?B?eFdLcnFtMUJ1WW5kbHc2OTNNR3BVSlB6Vi9MaWtQUWQ0aS9uR1dvaG41SDBY?=
 =?utf-8?B?dXM5M2MySUo3d0x2RSt0WXJNcGJVc1Q2YnBWMi9MSklGdXZuM0xQVkc2alpY?=
 =?utf-8?B?VGFpcWI5RGdFclphREtLSzRKMjJreGg2LzJTMVF4WXhVYWRrcDVaeUhhenpn?=
 =?utf-8?B?MUptTGg0T0MzVXJPT0VNZXlLQWoyTlp5Yi9OYWdnMTd0L08yRVF5eDZHQW8r?=
 =?utf-8?B?cVBOMCtyMFBpVTU4bnJCK2hRdUNrZ2c3OE8wOEJRT21GT3J0K1VBTzhoOC90?=
 =?utf-8?B?NjRvdHRDT3FrblN1c2JLNVdjSzNVQlFncXdrenN5dkNFSGxlRlp0L1Y4RWpW?=
 =?utf-8?B?T1JtNlgxS2FwK2dEM3QrRUI3WHdneFF4eGRTWWxOSmo5VzVEanYrcVlMV1Ri?=
 =?utf-8?B?Q0hRZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHpCTkpXY3ZDRjM4S0YzLzQ5ZUs1UGJ0UVFmL0xsYzZsVTBHYS9WeXNZVU54?=
 =?utf-8?B?SkxkWlpwUkpyeE5PR3o4QnI0Z3VpbXhneGhKZWxlZ3hDNkVQZXltRDN4ampx?=
 =?utf-8?B?RWdLRzkrM2lVN2Rab1dUd2ExUnkwSGp3cjlSUklIZng0Mmo1UU13ZWw0eGFI?=
 =?utf-8?B?RnBqWUxBUFpKY1VucXVWQ2hLU09DUFJEbVFpRElybC9lcklhRisyQ3FNZVJW?=
 =?utf-8?B?T2ZLTWs2STcwQ1FRN28yenlNcHg3emxNTE9uYjRWOWNQaVA2aFJrMlVuRll5?=
 =?utf-8?B?ZzZ4UEdkQXdEUVFFWjFXSzFHeFBWRzQrc0xQUG1iWit4eDZoVkVMdkU2b3Az?=
 =?utf-8?B?NlVINm1nZ1JiUEY0M3grRUNNbnlhaUl3dU4vbXR1dmlaMjV4cUZpTm1iczR5?=
 =?utf-8?B?d0ZYSFdjMVhXVE4rUHBtTE0xSmJZYnZ3WU5rRE5ETERzSVJzTDNHcnlzVElo?=
 =?utf-8?B?ZVd2VnA5RlpyWW5rNlZweTM2ZGxyL295SHpOaWxOZ2VvQk1lR3d4M0l4aHho?=
 =?utf-8?B?ZnZtRXZaOWs5dzRDRnBGVzBTSVo2cjlpaU5OK1BTazNESGM2QUJTNHJ5aGpl?=
 =?utf-8?B?cjZFQzlJZENRUmhXT2FMNGxoMTBsZzU5VFBsbjg2VFRKMTk5TVpyY2ZtU3BD?=
 =?utf-8?B?bk82TStvUWJ4RlRZdEVyUjRldk9URW9IbnRYOXZJWHdsb1BkYjJ3bXptbXFk?=
 =?utf-8?B?dzN4OHFiN3JIMnk4WlpOaHVycGRtWkpLYTFra1RlekRrN243UkduUThSZWZz?=
 =?utf-8?B?SG9XRWE1RllQRlkrTnpCT2JrZHg3aEptVjJ3WnN3cWdQdXFXQ3lRTFZoWjB5?=
 =?utf-8?B?dHpsOHNuTG1sZFBWMG5vdnJCS0M5eDdaN1FBUllhNVpYUEJoZXRCdGlDQ0gz?=
 =?utf-8?B?UGJydzJIb2xaczhmQndHTGU2UzdpVXlST1dwK0RVZ3pJV0hGdGQzTDFUNnJC?=
 =?utf-8?B?ODFuSGh0YVBuTG14MVhDZHdlVkxhemJzMTljcU1zelRhRlBBNVFKMlUyQTZi?=
 =?utf-8?B?SGZJWHZTMDAvTlZ6L0NZbG9sRS9tcWVoRU5HN3JGbDR0NmM1eXZOZEFsZDNm?=
 =?utf-8?B?a3lxdG9FaTJHMlhnOFJDRXVLZEFjQ2pUSnFmVUFodi9XUlgyZlBaK01Rc1pV?=
 =?utf-8?B?em9XbE9ZRFkzelpjdW0yUE1Sd0UrR3JzUG9vMmoyZ0djNVZYNWJNVHZpN3hq?=
 =?utf-8?B?SzliUTIxeGtHeDR6dWhpRS9aYlZXdllYZFFKY05nV2lvR1h5eG9GS09KSGp0?=
 =?utf-8?B?bWZJb0FESVFCNHREREovZTBaMjlpenJMbEQyMVdlY3ZqaFlVZlMyZDJ1YTdN?=
 =?utf-8?B?dE9FcDB3NkdRMHVqZFh0bXY0S2p2VGkxK1crc1lNc1ZBWTBzVVlWaEM0blpo?=
 =?utf-8?B?SWhnMkFFbzFyenFFdnhPaTVZU0cwVGZLeThvTVR0N0gwd3pWZkUyeFM3VUdz?=
 =?utf-8?B?UU9zbXZ6SnVQdXBrTWloRkppYk1rZXVhRHNJa1djQjV3TlNNWmtrL1NMa1Bp?=
 =?utf-8?B?U0VCMi9oWWJ0YVRoU2pWbnNKU0N2NnpwQmRSZklUQ3I2ZHBlK29MYVpIY1Uz?=
 =?utf-8?B?eUl4OUlhcXVtT0dNSHpzeURMbXVBLzJGSUJlcHNneTk3WnF2OGlhcjhsWFhO?=
 =?utf-8?B?c1NZSnF6WkZIeXJ5MlpsODZnWlJkdk1jKzBCeFduNk1zNi9UQ2x3MGpCWG4z?=
 =?utf-8?B?NnVZRmJUdjNnNFR3VTRGTFR1RnIvbnFkQjFneTEvWWt6NXVuRHk1U2JxSlN5?=
 =?utf-8?Q?rB0uUzsedTznTSpTG5NIJWk6IwvjlpQ2bd0HUXv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7df507-f591-4f13-99ee-08dd4f2c2f1a
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 08:22:14.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7719


On 2025/1/23 1:34, Manivannan Sadhasivam wrote:

[......]
>>>> +/*
>>>> + * SG2042 PCIe controller supports two ways to report MSI:
>>>> + *
>>>> + * - Method A, the PCIe controller implements an MSI interrupt controller
>>>> + *   inside, and connect to PLIC upward through one interrupt line.
>>>> + *   Provides memory-mapped MSI address, and by programming the upper 32
>>>> + *   bits of the address to zero, it can be compatible with old PCIe devices
>>>> + *   that only support 32-bit MSI address.
>>>> + *
>>>> + * - Method B, the PCIe controller connects to PLIC upward through an
>>>> + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
>>>> + *   controller provides multiple(up to 32) interrupt sources to PLIC.
>>>> + *   Compared with the first method, the advantage is that the interrupt
>>>> + *   source is expanded, but because for SG2042, the MSI address provided by
>>>> + *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
>>>> + *   it is not compatible with old PCIe devices that only support 32-bit MSI
>>>> + *   address.
>>>> + *
>>>> + * Method A & B can be configured in DTS, default is Method B.
>>> How to configure them? I can only see "sophgo,sg2042-msi" in the binding.
>>
>> The value of the msi-parent attribute is used in dts to distinguish them,
>> for example:
>>
>> ```dts
>>
>> msi: msi-controller@7030010300 {
>>      ......
>> };
>>
>> pcie_rc0: pcie@7060000000 {
>>      msi-parent = <&msi>;
>> };
>>
>> pcie_rc1: pcie@7062000000 {
>>      ......
>>      msi-parent = <&msi_pcie>;
>>      msi_pcie: interrupt-controller {
>>          ......
>>      };
>> };
>>
>> ```
>>
>> Which means:
>>
>> pcie_rc0 uses Method B
>>
>> pcie_rc1 uses Method A.
>>
> Ok. you mentioned 'default method' which is not accurate since the choice
> obviously depends on DT. Maybe you should say, 'commonly used method'? But both
> the binding and dts patches make use of in-built MSI controller only (method A).

"commonly used method" looks ok to me.

Binding example only shows the case for Method A, due to I think the 
writing of case for Method A  covers the writing of case for Method B.

DTS patches use both Method A and B. You can see patch 4 of this 
patchset, pcie_rc1 uses Method A, pcie_rc0 & pcie_rc2 use Method B.

> In general, for MSI implementations inside the PCIe IP, we don't usually add a
> dedicated devicetree node since the IP is the same. But in your reply to the my
> question on the bindings patch, you said it is a separate IP. I'm confused now.

I learned the writing of DTS from "brcm,iproc-pcie", see 
arch/arm/boot/dts/broadcom/bcm-cygnus.dtsi for example. Wouldn't it be 
clearer to embed an msi controller in topo?

And regarding what you said, "we don't usually add a dedicated 
devicetree node", do you have any example I can refer to?

Thanks,

Chen

[......]



