Return-Path: <linux-pci+bounces-23470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2FA5D448
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 03:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF6B189710A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 02:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB57A142E6F;
	Wed, 12 Mar 2025 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U/ss0D21"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011039.outbound.protection.outlook.com [52.103.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7295684;
	Wed, 12 Mar 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741745338; cv=fail; b=D8tpWvlIqqj19KNaDxdsTVSZWUGQ4SK7c9pvwI9BJ7UerImtd1FN2VhdflR/yJJvZoq1bqjeUZ7GR2Wf7eO6pnIZg5k18tklEP31rmDfh07hg5geh+l0uq5GyiOy7/Zt+fWV2lCMvoMkZBO6lDYoxiE48M9LnZXz6Y+obo+dILw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741745338; c=relaxed/simple;
	bh=KRtCelirQEGiDmV96A4JBeB51TlI0rxAVxUwdZnFI8I=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bGsvmS1qo1EHLVWEX0hBJdivjoAtBVg7ZqqpqObSLrPH4232lH+s1q1Hhm6whHJLhAuXI3y/3zEJyKFd1zULJkVcn1NQEGYn11WKiYtzIiV88T/VU2qXi9Ywh8fma2fui3D8jnCT2NoIIjrt53tTFXaUnkPPMaoR/5LvOjAipX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U/ss0D21; arc=fail smtp.client-ip=52.103.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqdcSJ2uAaqYellS10HmggUZeRrNCS8E00GnoEjn44Z2sJp6vlmIDClRiLcmO5oUR/4CjjVRLmEOnwTLHi2aw72323zXYA3k6bdtbETpEDvjdfewZLVYI2MopOIB25gSrZjmtqdJ2dc8zYDp8TiaxvKONbHlUTeBXfNhK+VDaJ5M35Xs9MhpjHZeEnuMX+i4YUVt2DHTIUiJ5Nr4caYN1vk2ihWuM1OY/Qg/+TedDCoAvfLFke/cjea974ydUrDo47lPWIpVf2rHaNouAatMh305eE9aAljA4lY0zlNsXW86+p9nQv7lo0MRzhlcbJvOHrAWz+u7gHy9USm+kuSWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUi0WHHwsjr2PPnmO444d7kxrLVb9LAs2+YO9jXiECU=;
 b=fEwayxYNDcor0sXMlcCqwaHZRhtJsU+DnjN5l7p8oggQgWruAQOjNJ1QWO14W51cqnrKatofuqrYj9taxqFcvzseSng7mk4ti5a+OPvmoiN+6S9bDt4zkO5wTIXhQ9YAdjfXjQvLN1Q/80nkBC5vCgl6RWq7TK1FESBX/FBNMzLcMPW8oknDektW68pocSPqGzt9fui4jwa424mMMgW3keg8gTTtaPR7Ir6ZLKgKdeZyfVK+wmEN4nutE+9U2QneoE5Vru3Wuy8u69Cw7fbBaF5c/ZYST0SMToQC6swwXINnn/C8rQVqMIZOqREEAwr7fnizc6j4OrB09onP6plc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUi0WHHwsjr2PPnmO444d7kxrLVb9LAs2+YO9jXiECU=;
 b=U/ss0D21WU2efu/Y7m0ly/5ShPzK05yDkkm9VuqaaOWy4te82w5WxqNubfRhv4O4DzrdJFXGLMzVHLWEDCY6RV5+Ek3JJVr2R+16PvTNM2gxxeC1IHvZDf1Y/wQP+WzIh6WNQYXfuF4elPhw/aQ+T5j1mBT7j6NRRrH/1t4gSh8G3TbCTzUflinSbNQNc9CVwYP5zCOWw4li79llmw4Eev+3u7vbH4JB7w6p8pmQjrrK7rSMVF3ON4tVxQ5vyYtJqkuR33x+eARH+W9XXguNQwvbI1tP/2hS+3WP4bl0Yp+HihWPCMIsWOVvRLqVrwCXuonjZTvW3XaoZsstk73duA==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MAZPR01MB5778.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:65::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 02:08:49 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:08:49 +0000
Message-ID:
 <PN0PR01MB10393B57EAC99498561CC30FAFED02@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 12 Mar 2025 10:08:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Fix NULL pointer error for ops
To: "lpieralisi@kernel.org >> Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250304081742.848985-1-unicornxw@gmail.com>
Cc: Chen Wang <unicornxw@gmail.com>, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
 s-vadapalli@ti.com, thomas.richard@bootlin.com, bwawrzyn@cisco.com,
 wojciech.jasko-EXT@continental-corporation.com, kishon@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 sophgo@lists.linux.dev
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250304081742.848985-1-unicornxw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:404:a::30) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <f1e4fd67-32c3-43ce-9dfa-2fcddb3e8c7f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MAZPR01MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cd3a0a-7063-40b8-b0ea-08dd610ad408
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|7092599003|15080799006|19110799003|6090799003|5072599009|10035399004|440099028|4302099013|3412199025|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU8rSzJMVkNvSmJZMmVieUFEdExZWHNNUGRNUjFTTzJaOW5VQUtzendDeG5h?=
 =?utf-8?B?cG9HMS9ZekFqWDJRNTVpeE9LTG5QWi9lUCtJNDRlRWVJd2NqTUk2SW5USlZ4?=
 =?utf-8?B?bVh3RlZmK1k0dVFlZUJ3WWxxMEZ4ZlhHOEVvSFdTV09PdkJjUVl3eUxBditk?=
 =?utf-8?B?cWtNRk9LSlVuaTVqWHZWRDUxZWdkZVJrSXlwamNpMDZIOFF6WXpDaDdOamd0?=
 =?utf-8?B?T3Z5S1VQbGYzVzlEWGRCUnczMW41LzQyVHJGWW5XSEVqSkVCbWs2VVBOOEdi?=
 =?utf-8?B?T09ac0FUMDRJaVZDZFB1NlAyZ0VRNlpldldNeUFlaVU1TDJvSU8wUGZ6N3Zl?=
 =?utf-8?B?NjhNZVFwL2VwMW9GNE1PWVRrL3ljbzdyTTdRcFBmZU8rY1VrNUFJa3JKYUYw?=
 =?utf-8?B?R1VlUUo4bWVpMFdIOW1WS2JNWHIvNFlBNU9EVW04ZW5hUVVMRGg4ZS9ZRHNH?=
 =?utf-8?B?NXlqWFkxSXo2YWZZM1orL3c3RGRNVUtDc1hNb1libDBpOTFTQSsxTjFXajEy?=
 =?utf-8?B?ZVhmdEpyZXN5OFJqR0ZoUHV0bU9sR0NPcXE2d1F2YnE5ZXdlTmduYloyY2NG?=
 =?utf-8?B?TkZyZ0Ewa2VuZ0RhT0VvVXIwODFMV3FjbzkzUEpJSFo2emwrT29zQUtDTXhV?=
 =?utf-8?B?VHhDTzVsdlJVSUdsa1VaSnZNNWZVdlcrSXNnMG5wSklSZ2Z4eTFWeFBWRENi?=
 =?utf-8?B?N2pMZmZPZXREckNGREhEYUk5bTJ5a1RuRkpoblo2QWdtdld1dnZsVmNKMmt2?=
 =?utf-8?B?UTZKWVpsUFUwNjhjWmZjR2ZYOFJlaVFjUHBIbjNaOWl6NlRtOWhQcEMyVnpK?=
 =?utf-8?B?V0JVcEc1YkVtejg4WTlzTXZ6SFBsWGJuc1dDTk8zUERqNGZjTnY4ZmNYME9C?=
 =?utf-8?B?N3YrM1M2L2tLbGNwZFhNazZqMHZuaHVKSTM2YTJDUlZkR1JRam85cmh3WC8x?=
 =?utf-8?B?SWJIME1oVkdaRlAzc3NENkIyeFZhMzQ4VUJCNU81a2E4Y2FxNkw2VWZRb3VH?=
 =?utf-8?B?MkkzMWZ4WG5MZjNKVFM2R3grK2ZSQ2JJeXNpeVdNNzZGWjBBV0xFd3czVHdt?=
 =?utf-8?B?dHAxVkRpTW9lWE1FNTVibzBIZnQrbWV5cDh2UTlQNThONFBDRlRZclNsMjJK?=
 =?utf-8?B?bEtRUUY3MlV1UUFrcld5cWE5VFRROFdVNjRzVDFxcmhINlJIN1cxclFrQW5O?=
 =?utf-8?B?OUx3bVVLVGEydk1sMHQzVEwrNXFLVythcSswcTNMUTUrei9TVXRwRFpFbk9M?=
 =?utf-8?B?QzNTRU81dXFTZGY2UzNybk1VaUhaSm9mMTQ5dEo0ZVF6SVRNTTVxK29hQzdx?=
 =?utf-8?B?SW43aWtxM0ZtM1NOdFZmV1QxVko4THc0ZFRTQldpTnp0b3JETmJpc0NhV0Vp?=
 =?utf-8?B?ZmgwSWQrMmlUcXc4NXBBOTQzazdvcmZTd2YrSlNHY1MzN253ZDdHWWFqWFBO?=
 =?utf-8?B?NDRuTjhYdG80NUs3QUF3cVdRcTV1U0N4VTBiTmwrTjV1Q0REK01vZVZEMVkr?=
 =?utf-8?B?bDA5dXVPZzJlZXdqbVNZcE9ML0UrNDlYUFBlVk5zM0xteFRxN28yWXFraUtS?=
 =?utf-8?B?ZDBWNHd2NkJNRlpDck9RbGIyNnpaSWhzLzQwRWdIWUpTb0hNek9kUVlLdjlx?=
 =?utf-8?B?bExpZHN6K0hTZjdkNDJua25LZzJIbCs4clJhMHB2czlaKzlocWt5Z2I3WGt3?=
 =?utf-8?B?ZXJEU2F1ZTdNUWs4TU5wOFlhNkNYcmd2a0R6bzhjMTVZR29JUWZUajhrd2Ra?=
 =?utf-8?Q?tjILq6sAgYmiSLpkbc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkdOSk9XcjFubUhjR3hQRHRjOGhEWlFNN0Uyd0tyOUlmeDFCK2NBa0c5RE05?=
 =?utf-8?B?K1VNdytWOE14YWRLc05pTnJEMnFkRU5ONS96eGZlcC9zcXNzTmJBa3g3R2xI?=
 =?utf-8?B?ME1lUW5pL0h1SGJSN1pzT2F4Ti9lOTdSa012V0ZkRUpsS0ZTTWJaSWtCWWli?=
 =?utf-8?B?T3lwMzNKSWo4ZERjcjRsWEJGdVQwMHhzSWtvMlp3aHkvQ04wcXNiVytEVG9m?=
 =?utf-8?B?U2w5YXQ1M09pL1k1K29MRlI2dThON1dLOHRrc1hOdHFWcEpuSkc5MkFlekty?=
 =?utf-8?B?eEcvKzB0Q2hXQzZNV0lNbWE3SE5mdTJqVGxjUVVXYk1RZWZEaDU4YmEzZUZm?=
 =?utf-8?B?emQzeWZ4eGZKYitBS1haTzRXYjF6RUx1cE5hbEE4UERibDdaMEFScjJIUlRh?=
 =?utf-8?B?ZjJERFRGVlJPVjdyWlFZUXRrTHRqVmFpUkdMZ2xZL0JVaWszK0JkbWtRZEtM?=
 =?utf-8?B?eVdVT05TQlpsNXVzbytTK21mV2I0OUZ2ZUdJVnVCVnBSZi91cDJGSDVLZXk2?=
 =?utf-8?B?WXRSTVJ3ZWY0RWdHaWNJTEIwVGZIZ00wVDBVYzBMbjlORkw0bGRyUGVyWUph?=
 =?utf-8?B?RENoQlhBUTNVMEtRTHZ3SCs0VnNBMmFuV1FuVTFxU2M5bkI2Z2pXTlBpamNT?=
 =?utf-8?B?dTc1cnluNVBCM0ZhSGZXZWtZVVRnVXp1b2ZOTEE5ak1sMEVtZlVFY285NU5u?=
 =?utf-8?B?ZFMveXg0ME1JWTZjWDJGdnp1cGRrRDdiQTFHbVdnZXZHdFhsMG5XbEIyRllQ?=
 =?utf-8?B?aUIvVWE3bGhJMU9Rb1lxY3RtUFdJM25rM3V6bkdQaUFwTkpwWE9vbzFTMWtk?=
 =?utf-8?B?S3pRYkR1OWVUM2ZvZWJWdU01U0h1N1Npalppa0dOdlNadURqbHM3YW01bVY1?=
 =?utf-8?B?eTZuMllwZnZXMjZTY0xXeXdRbDRLbGxnOXNsNHlVeUFiRkt2ajVRajRDaVVq?=
 =?utf-8?B?KzFZNGExeTdBMjc0NVJQMER0YTJRSXEzWFg4dmUyd2U1TW9ETTF4cExCUm1D?=
 =?utf-8?B?bTJ3U25jd0xPaVlXVW1oRWhWU2lOaUFSeGtoQUNLSVQyTFBMNnhVYk0veTBj?=
 =?utf-8?B?RS9BU1ZhOVlVcDZiWC9nMlYzZDU2R1Y2dnR6NXlLTHYyMGk4a3Y3YU1reExU?=
 =?utf-8?B?NnVCUHB2emNNWHZtSkY2T250NkdDL1ovNEdMcy85cnlDemZNa3JEUzZJczZV?=
 =?utf-8?B?MlB5blpjUEFUVEhpdGRWYS9qZmRwcjhjOHNKVWRubFB2NXc5b1FyNFBsU0dZ?=
 =?utf-8?B?MExYbEt2ZVV4VWlFMHZ5UlhrUEpVUWhNQ2lCUTBGcFJ4cno1U1BueHh6Szll?=
 =?utf-8?B?MCtLc0ZjZzc5b1Q1TXUvYlVNS3pNUTZ2elhycnhRQ2dhVVMwaXJjaldOdVdI?=
 =?utf-8?B?NG9zZWJxa2s4eUNCeXUzaXBLd245bkpydmpQQkVNWWJPY0wzcVlPbFdzZWJs?=
 =?utf-8?B?TzhzVWlSYkRQVWVJeGlMejdzdXloRXZROXR1L2s5VnJhSHVkVnhSUjhZNVZD?=
 =?utf-8?B?QnBrYVlhdE0vMlBzUnNCT3pDNGZTZG10YTdXRzlwaCtDYldYdDNYZUtNZVdq?=
 =?utf-8?B?dmM1ODJJQ1h4bWJPRjcvQTVpVmhuM0NwL09zWmdtd25jRG12cFE5V0ZtWHJo?=
 =?utf-8?B?K3kxbTk4cUNEYUxrMmRXNm9vVW5hajhpSGYvVlFTbnpyeVRFS1lEYkVLYm9l?=
 =?utf-8?B?ZHBqNU5NazJkLysrYXJrZ1JpSTMzR1J5RVovZy9XUFk1STJ6RmNtcmQrdU5i?=
 =?utf-8?Q?iOZqyqHZY/fUYAWL+MPaZOp0kKuIyyjuumj4nSZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cd3a0a-7063-40b8-b0ea-08dd610ad408
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:08:49.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5778

Hello, Bjorn, Lorenzo & Manivannan,

I find your names in MAINTAINERS for PCI controllers, could you please 
pick this patch for v6.15?

Or who else should I submit a PR for this patch to?

BTW, Siddharth signed the review for this patch (see [1]). Please add 
this when submitting, thanks in advance.

Link: 
https://lore.kernel.org/linux-pci/20250307151949.7rmxl22euubnzzpj@uda0492258/ 
[1]

Regards,

Chen

On 2025/3/4 16:17, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> ops of struct cdns_pcie may be NULL, direct use
> will result in a null pointer error.
>
> Add checking of pcie->ops before using it.
>
> Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
>   drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
>   drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 8af95e9da7ce..9b9d7e722ead 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -452,7 +452,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>   
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>   
>   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index 204e045aed8c..56c3d6cdd70e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -90,7 +90,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>   	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
>   
>   	/* Set the CPU address */
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>   
>   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
> @@ -120,7 +120,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
>   	}
>   
>   	/* Set the CPU address */
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>   		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>   
>   	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..436630d18fe0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -499,7 +499,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>   
>   static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>   {
> -	if (pcie->ops->start_link)
> +	if (pcie->ops && pcie->ops->start_link)
>   		return pcie->ops->start_link(pcie);
>   
>   	return 0;
> @@ -507,13 +507,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>   
>   static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
>   {
> -	if (pcie->ops->stop_link)
> +	if (pcie->ops && pcie->ops->stop_link)
>   		pcie->ops->stop_link(pcie);
>   }
>   
>   static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
>   {
> -	if (pcie->ops->link_up)
> +	if (pcie->ops && pcie->ops->link_up)
>   		return pcie->ops->link_up(pcie);
>   
>   	return true;
>
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

