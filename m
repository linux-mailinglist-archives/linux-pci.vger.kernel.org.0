Return-Path: <linux-pci+bounces-21590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582AFA37D43
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 09:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FB4189424A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9507519D081;
	Mon, 17 Feb 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EMOy8Ad1"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D13D68;
	Mon, 17 Feb 2025 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781437; cv=fail; b=f7sGlbjT7jGOVAdQJdr3Sl9UbTeSgPSKCTaf+cvMv0VTtm0gsP4bKD8dzYIZr9KHpbNMAd5VyPdN638hErnxHwdtHTaaSNYLhvMxsjIZd5UFUjtO9jBrdASp2FeOaVKcPmqgweZOFNAIVUirDwN3xnI0sGdrfP0Ox4TEwH+VHYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781437; c=relaxed/simple;
	bh=cDDjq8Rc0W7pwnzSzNOO36t2fVDFZ5b3cylx5XxXOqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YCpdBRkBN8gzE2be3b8lHneyLpH5L/gq9rpRR0+KKFOVBTf+phiGU5YC3kRb+uHwEgTD1dEM7pk2eK5sLyYp9iPnt589jGdYtvzR9H/zB5mKu+9R8KRAB49oMoU1TItoKZnXuvSCUibtsDUvSDuDVYAkQ6Jfval6FKGfdEm2lMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EMOy8Ad1; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCAOIrjCYaXyrLtWSgPlPBABkKfOnu5cyRHFrVNBs7Ue9J3KMKoGWS1vXHmaLJWd9HIRCFxxBHGhoYDXn8kqk8Ose3R3gsdDs1UsJVMizD5Xx9nUBHnsBjaitNsIuSoQDW8r0pe4Lwh8YUA3jwguvWWzjTnqJyzSIOXxLL3vcbepXaLPBWy1x3qxM6wk8j2Xu6DVixCqTGDuwvEYHe9PKv/cT6VNpSDJ+2HHpF8GM6vZVVlGEtQI7kc7I7+7LXp9i1Y8K38jvrkY7SYIktJ1Hgp43odWtbBlUv09SxXgrTuIrTplOwMlQpYsLIVevMH4UOxEIyEkuay6JuyMEOyooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/lmH3hliXFfrwhuPd2qi9Ax/nF386Fu4E7znrcRs5w=;
 b=XSK13fnoIzAO2ILIGO5fZnjaqO3ooE9VmArEse4uUfE3muQmxOW7iHHKVys9kJUtGBZ3B+K7aaXLgGhM1mp2RBjmDqaVOYsdJ2nOZotYQv0Tg6WZj5uDD8Gwl2bVJqaeKYtQ71xaS75Egr18F7XphXT4z93ypG7MT2n51qHJr7FGx1le/SyjHQLT8Nf/6YGLlrx/sMEOpeE+s1BHnMa1WdSLNBMb20jzTkyooTvzHWXJFqOP/XpZhCq5EBvNaPSR+KdwS2Ctvl8Qm5isqiHOPxyKDyAyDDq6L7iFBVMQabGe3ZNSFpFnc2WQ3QNnCAOX/jfq+0oGOk+QmZYCfDvAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/lmH3hliXFfrwhuPd2qi9Ax/nF386Fu4E7znrcRs5w=;
 b=EMOy8Ad1ETTXN73Ut++u+Ap/t4f4uy1gSDsM78yVCa7K4VKugudk9Ed+Bmlc/FuGAh1Za38tQdKuVguagXK2O+FXM1THvyHrOmaubLmN37tq0Gurb9jQv6Z2NWwWYNtvmDdIJbJC/T/mBiKfBwYUJAsVxJQ3119FziyqR7tIsL9QGuPTk/1OSScwC0wM+ud2rZCRVzc74f35ZaR5Lmjc5i6Roq/M/QukTKYn1xluaQQIqWE5j8p8/MJ0ownn8sJ/laDfFaGfLDSLHSB80kFo+c5FhVwPvemF2P8RbyS9OJ/IMtnL/IyPOle7SX9X6CW2WcNCADm9DrHTurFCaxNRKg==
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::9)
 by MA0PR01MB6441.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 08:37:04 +0000
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee]) by MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee%2]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 08:37:04 +0000
Message-ID:
 <MA0PR01MB56715CA3F83F4ADF298D2E4CFEFB2@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 17 Feb 2025 16:36:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250122213303.GA1102149@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250122213303.GA1102149@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:6e::9)
X-Microsoft-Original-Message-ID:
 <762afb26-e11d-4f55-a374-6bd215bb79ba@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5671:EE_|MA0PR01MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 08562252-7ca3-43d9-f27f-08dd4f2e417c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|7092599003|6090799003|5072599009|8060799006|19110799003|1602099012|4302099013|3412199025|10035399004|440099028|12091999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzZ0YlJ4L2hVU1JNVEpBTGMvQ2xXSG1SNGtLZFU5QWlYNFNWVUc5ZlZzQW93?=
 =?utf-8?B?ZnBqOE1pT21YVGlQOTV6VXcyczZMbEpMZit2RmJKS2FUL0dZcGtmL2tINmVJ?=
 =?utf-8?B?K204YnlXUUgyUUFZSzdTb01ocEdPb1U5Rk9vdkpCTEVwSWlEb3hyWkJiU256?=
 =?utf-8?B?Tyt3WW1zMjJUQmJ2a2dUalNiSEhyZ2ZtZnlGS3BGeUVzMXJRemx6VmZ5bEV6?=
 =?utf-8?B?N0t1bksyMVdQNm1sTXJZUXFPYTU4YUlBcVVkRGs3bkFLdE9XeGJyZDd0Tzkx?=
 =?utf-8?B?Z0dBRHlCWHpGYVFia3hRbFExL3FjK1JCQmZPcGRrcnZFQWZqTUI1K3kzNTZx?=
 =?utf-8?B?YkNpSWRZblRnTzcrK0FUNnNSeE5PbXYvcUQveW9QeHlONC9YNmEyVmtrRXJL?=
 =?utf-8?B?SW9YcjZuWVMzSmxtVnRoQW9VMjVtU2dVY09zUzF4anVXdk9qVHBCcVB1SE4z?=
 =?utf-8?B?bkJ3em8yeFV0VStjZmRtWjBHRk0yVVVDVXM0SG1VWXpoRjhwclVmZkZtSmFX?=
 =?utf-8?B?dGliSk9hRGVkczFyQTEzYVBJUE9tRUJFdTdPSzVZWTJMaC9UeE90YW5WNENs?=
 =?utf-8?B?Z1dPVUVIRm42Qyt3YTJUWFgwZnNTb29LWWZtUnNPajQ1M0kraVdBWW1kN3d5?=
 =?utf-8?B?QjUzSk9ySDh5Ni9GdmdOUXN0Q0dlS3BGeksxcS9SUlp1Y1VyTkhpMmpNUUI0?=
 =?utf-8?B?UTQ4ZXhLVGo1SDU5b1VpV1hNK3BWSHJSdCt2Mkxvdk1yYWhyR3h3RmVOQjNn?=
 =?utf-8?B?MmJ4WmhTZm5nTVNmQjhubkdhVEN1RS9qM1pKL0d0VkFQQXp4b3FKaWg5NElM?=
 =?utf-8?B?STR5VzJ2cDFCeHN0SGQybjUvcDF1MjF0Y1NPTlM0ZVlRU1NIeFh3bStBaGJX?=
 =?utf-8?B?QTZXVmQ5cUU2anpKbFVCSEp3TXc2L0xleS8wcGhRSXBRVmU2c1NQZ1RjSHY3?=
 =?utf-8?B?NlMzYmRPOGx5aXNIT2txRlV0bzdpUzk3ck9BMW5odDNNRE4wY2l4RUNBUjdi?=
 =?utf-8?B?SWFCeWd5TDQ3RERlSHRKQXBhNDl0QmYxQUxhcWo1QzJRK0wxLy9yU1JRWThD?=
 =?utf-8?B?OE90dUh1emZSZVcrcDA0ZkFpR1p5WS9XemcwYTRsYWhpWjgwbWN6TklQMkds?=
 =?utf-8?B?dUZaVUI0M0ltOG5hMEpueFJreUgwK3B0cUIxTlM4Z2xOa0NkUUJvd2hReStW?=
 =?utf-8?B?bk1KVlBYd1h5ek9KQnBzWDhCaElXMEg5NGJJYmVxMTExTWhlQ2lYQm5YS3I2?=
 =?utf-8?B?N3lmVVExZHdiQzlPSlZoRkhtM1lSeGVLM3pkc05UbVQxT25UVFNZWmNOOEs2?=
 =?utf-8?B?ck9ZaWhOMVgxU1BaejNabGhVaEdJeHY2UW1IZWNDNElRWVlwcm1mYml6NWVz?=
 =?utf-8?B?U1NITTZ5aE4wVXdtekxyTTZGK2pObjRIbVdGUno0b1YwL0Z6cjBmYlpYWm14?=
 =?utf-8?B?UGRQTkswNFlXakNkSHVaMHg1NHlkQ3dLTHlqdERQdWdKVnJuUldpS0VXNWVj?=
 =?utf-8?B?UGJDckRJSHQyY0ZGQlBuL1dsTnBVeC81T1Rjb1ZrRUtNZ0QyYjl6dlhRUVVs?=
 =?utf-8?B?Z09NUDJ0K1Zld1ZsTkFDM1M4OVFWKzNJME9Lb1BvcW50eHpBb1l3d2h6Q3Jo?=
 =?utf-8?B?UmxEUDlkemMwZWsrUzM1aERGSGZ4bWlqMG5yS1AxQzFBRlZvZjVWb0pmSm5R?=
 =?utf-8?B?c2grTE15cnJJQzhLSGcrMU1JemhMbjJuNk1xMktHcFNvcFhrNXpEd0lHK0hp?=
 =?utf-8?B?M091OXJtbnJzbDVXWUZPMnV0NDB4dHZFTnVQNUNUUXpQUnFHRUVRODlKTk1I?=
 =?utf-8?B?eTJramMvSTVwS1BvWndEZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDQvV01Sai8zc01iaXRVN1JTL1NNbnZ0S3UxRmdyNTlRNzNxeUZPSGZrZ0hT?=
 =?utf-8?B?N0NacUx3ZllOWHhQdHQ3cmFmNTQ3QXlSMXVaOVpuZkhsS2krYjY4SGx6YUlY?=
 =?utf-8?B?dS90S3MxVTVZT0wzeVg1eHRVQVBOM2xTeTZRcDlnMDh0djNrdWx3bnBrbmpY?=
 =?utf-8?B?TWZyQ21kVEhScVZVNlUrUjNoVXM0RVNJMUpWTGQ1OXhlRDNxTFhTTjJHOWll?=
 =?utf-8?B?ZHVzZHhDcWxHM0NyMWJPVGRMRzZ3dUtVbzRkek9PZ2x0S25VWko0TDBhbGRG?=
 =?utf-8?B?b1lIaWJRRnAxSTFtNlBMcDh4SnRXdVN2VFd3Tk9RUk9hdDFoM2QvK0RqeDZh?=
 =?utf-8?B?VUF2QlZiTTIyaUlPeEtLQzZtRHVvOHRuelJkcDRrbGJBUjY4QWwvRHhhTTFI?=
 =?utf-8?B?TDBFVUJpUkVwRTBHS0c2a1BMYlMwWVhYSW5HSFBPeExLOCtEQXRvc3ZOdllC?=
 =?utf-8?B?TDhBM2g0NjYyVjhKamRnL2xxbm1MUjVuV3NKa0RTQUYzeXlXckxXdVErNk9p?=
 =?utf-8?B?d0Vpb0F5T0lLOWwvK0VyampYYldHNkkyaVkxNEpSQmtYWFBOY1kyWXpnSHZB?=
 =?utf-8?B?SFhyN1MxUU5oZFkwN1M2Ulo5NzJJckl1dzdZTVpGRk9vbncyNTFWUHdKT0dI?=
 =?utf-8?B?KzBMaGFYUENvc1VHdkNFL0JQeEhEMjFVVFZXbEN3ZTNPZE5YclFjblJMdjRF?=
 =?utf-8?B?aC9qd0xqRkI3MFM4SkpUN1RkOVcyYy9iUnR3REVHN1JrM0oxcFZKZnQvWWlN?=
 =?utf-8?B?L0w2aVBhTGFjY2dJbDJpeDVuRmhmQ3BCRFVQMEFiU3RNV3Zsc0xkRm5Qb1pW?=
 =?utf-8?B?MXdORXNFdlFxbndIditnL3NLVzBuMnVGUmcwVlNiYXV3bVQybkR3Y0xEemY4?=
 =?utf-8?B?emZ5QUlBWFdoQXNmd0I4dml2eWQyemtleXFDT0tNdjNoWlVNMzUvOC9WSnNl?=
 =?utf-8?B?ZyticEovcFJnRXRjL1I2ZDBQV28rN0hqQUF2MW9JdXhUVndqOUJSc2ZoQ1BK?=
 =?utf-8?B?NTRFdHlMUTRoS3REZEZLOEtrNnBwQVJwM3JHR0t6eGpCVUI2WENwbDFhVE9J?=
 =?utf-8?B?QU8rSEhpcktoK3NITHlRRjJZdVovRW9KbkdhdVBwNHgyWFlLTENWR2VOOGhh?=
 =?utf-8?B?bS9KN0psSkhqN1MvcU9rb3RpdkdXMHpEeG9RZExsUmsvSDJaNDdVYWVnL0hs?=
 =?utf-8?B?QzY5THpxeHJJSmMwZ0FSNitUOTlOUmd3aENPckVzeEw1WjJLNXgzczN5WnF0?=
 =?utf-8?B?cmhBblFYNmV5SDVmdzIwcVE0SS9YTVlvOHNKME9WVHBZL2p2cWhwSzhvODN6?=
 =?utf-8?B?TXRBZVpDa2ZmSWUyd1NzZ21neGxxRHlBUzFJME0xZ3c2LytvN0FHMWdLWFVj?=
 =?utf-8?B?SjdhZnZWWnRqRm9rUkZSalMrOWxrSjRueXB4bmdxc2xPL1lxeTk5M2VqUkpG?=
 =?utf-8?B?b1Z6bTVENnJOTytOWXhVVU5QdllBOEp2bm9VYkZNdXFsSDRMbXZySTA2UEQr?=
 =?utf-8?B?QzlQWGU0QlUzZDhIVFFrczRRT2JSVnNsUDJHeWhvM1Q0TWhvV3JHbEUwcUcr?=
 =?utf-8?B?REpUWDhIRFR4U09EUUlRczA5Q1YyK1R6K0NVa0dnWnI0dlRGQmxQWW5IK2Fp?=
 =?utf-8?B?WGREdUMvNE1PWEVCblE1Z0UrNk5iOGZhZHRVdGg5ekw5OXkxVmRtblN1ZnR3?=
 =?utf-8?B?VnNaYTBzdmxGT3d5QUQvaE1OUVE0RXU1WUxBQlZiNDU5YUlzOWtYc2ZTMk54?=
 =?utf-8?Q?215U/nFU1fmgQ9xdFZD68h8jdlDyAqwW9nwJWjX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08562252-7ca3-43d9-f27f-08dd4f2e417c
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 08:37:04.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6441


On 2025/1/23 5:33, Bjorn Helgaas wrote:
> On Wed, Jan 15, 2025 at 03:06:57PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add support for PCIe controller in SG2042 SoC. The controller
>> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
>> PCIe controller will work in host mode only.
>> + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
> I'm guessing this is the first of a *family* of Sophgo SoCs, so
> "sg2042" looks like it might be a little too specific if there will be
> things like "sg3042" etc added in the future.
As I know, SG2042 will be the only one SoC using Cadence IP from Sophgo. 
They have switched to other IP(DWC) later.
>> +#include "../../../irqchip/irq-msi-lib.h"
> I know you're using this path because you're relying on Marc's
> work in progress [1].
>
> But I don't want to carry around an #include like this in drivers/pci
> while we're waiting for that, so I think you should use the existing
> published MSI model until after Marc's update is merged.  Otherwise we
> might end up with this ugly path here and no real path to migrate to
> the published, supported one.
>
> [1] https://lore.kernel.org/linux-riscv/20241204124549.607054-2-maz@kernel.org/
OK, I will switch back to use the existing published MSI model.
>> + * SG2042 PCIe controller supports two ways to report MSI:
>> + *
>> + * - Method A, the PCIe controller implements an MSI interrupt controller
>> + *   inside, and connect to PLIC upward through one interrupt line.
>> + *   Provides memory-mapped MSI address, and by programming the upper 32
>> + *   bits of the address to zero, it can be compatible with old PCIe devices
>> + *   that only support 32-bit MSI address.
>> + *
>> + * - Method B, the PCIe controller connects to PLIC upward through an
>> + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
>> + *   controller provides multiple(up to 32) interrupt sources to PLIC.
> Maybe expand "PLIC" the first time?
Sure.
>
> s/SOC/SoC/ to match previous uses, e.g., in commit log
> s/multiple(up to 32)/up to 32/
ok
>> + *   Compared with the first method, the advantage is that the interrupt
>> + *   source is expanded, but because for SG2042, the MSI address provided by
>> + *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
>> + *   it is not compatible with old PCIe devices that only support 32-bit MSI
>> + *   address.
> "Supporting 64-bit address" means supporting any address from 0 to
> 2^64 - 1, but I don't think that's what you mean here.
>
> I think what you mean here is that with Method B, the MSI address is
> fixed and it can only be above 4GB.
Yes, I will fix it.
>> +#define REG_CLEAR_LINK0_BIT	2
>> +#define REG_CLEAR_LINK1_BIT	3
>> +#define REG_STATUS_LINK0_BIT	2
>> +#define REG_STATUS_LINK1_BIT	3
>> +static void sg2042_pcie_msi_clear_status(struct sg2042_pcie *pcie)
>> +{
>> +	u32 status, clr_msi_in_bit;
>> +
>> +	if (pcie->link_id == 1)
>> +		clr_msi_in_bit = BIT(REG_CLEAR_LINK1_BIT);
>> +	else
>> +		clr_msi_in_bit = BIT(REG_CLEAR_LINK0_BIT);
> Why not put the BIT() in the #defines for REG_CLEAR_LINK0_BIT,
> REG_STATUS_LINK0_BIT, ...?  Then this code is slightly simpler, and
> you can use similar style in sg2042_pcie_msi_chained_isr() instead of
> shifting there.
Ok, I will check this out in new version.
>> +	regmap_read(pcie->syscon, REG_CLEAR, &status);
>> +	status |= clr_msi_in_bit;
>> +	regmap_write(pcie->syscon, REG_CLEAR, status);
>> +static void sg2042_pcie_msi_irq_compose_msi_msg(struct irq_data *d,
>> +						struct msi_msg *msg)
>> +{
>> +	struct sg2042_pcie *pcie = irq_data_get_irq_chip_data(d);
>> +	struct device *dev = pcie->cdns_pcie->dev;
>> +
>> +	msg->address_lo = lower_32_bits(pcie->msi_phys) + BYTE_NUM_PER_MSI_VEC * d->hwirq;
>> +	msg->address_hi = upper_32_bits(pcie->msi_phys);
> This seems a little suspect because adding "BYTE_NUM_PER_MSI_VEC *
> d->hwirq" could cause overflow into the upper 32 bits.  I think you
> should add first, then take the lower/upper 32 bits of the 64-bit
> result.
OK, I will check this out in new version.
>> +	if (d->hwirq > pcie->num_applied_vecs)
>> +		pcie->num_applied_vecs = d->hwirq;
> "num_applied_vecs" is a bit of a misnomer; it's actually the *max*
> hwirq.
"max_applied_vecs"？
>
>> +static const struct irq_domain_ops sg2042_pcie_msi_domain_ops = {
>> +	.alloc	= sg2042_pcie_irq_domain_alloc,
>> +	.free	= sg2042_pcie_irq_domain_free,
> Mention "msi" in these function names, e.g.,
> sg2042_pcie_msi_domain_alloc().
ok
>
>> +static int sg2042_pcie_init_msi_data(struct sg2042_pcie *pcie)
>> +{
>> ...
>> +	/* Program the MSI address and size */
>> +	if (pcie->link_id == 1) {
>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_LOW,
>> +			     lower_32_bits(pcie->msi_phys));
>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_HIGH,
>> +			     upper_32_bits(pcie->msi_phys));
>> +
>> +		regmap_read(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, &value);
>> +		value = (value & REG_LINK1_MSI_ADDR_SIZE_MASK) | MAX_MSI_IRQS;
>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, value);
>> +	} else {
>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_LOW,
>> +			     lower_32_bits(pcie->msi_phys));
>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_HIGH,
>> +			     upper_32_bits(pcie->msi_phys));
>> +
>> +		regmap_read(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, &value);
>> +		value = (value & REG_LINK0_MSI_ADDR_SIZE_MASK) | (MAX_MSI_IRQS << 16);
>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, value);
>> +	}
> Would be nicer to set temporaries to the link_id-dependent values (as
> you did elsewhere) so it's obvious that the code is identical, e.g.,
>
>    if (pcie->link_id == 1) {
>      msi_addr = REG_LINK1_MSI_ADDR_LOW;
>      msi_addr_size = REG_LINK1_MSI_ADDR_SIZE;
>      msi_addr_size_mask = REG_LINK1_MSI_ADDR_SIZE;
>    } else {
>      ...
>    }
>
>    regmap_write(pcie->syscon, msi_addr, lower_32_bits(pcie->msi_phys));
>    regmap_write(pcie->syscon, msi_addr + 4, upper_32_bits(pcie->msi_phys));
>    ...
Ok，I will check this out.
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t sg2042_pcie_msi_handle_irq(struct sg2042_pcie *pcie)
> Which driver are you using as a template for function names and code
> structure?  There are probably a dozen different names for functions
> that iterate like this around a call to generic_handle_domain_irq(),
> but you've managed to come up with a new one.  If you can pick a
> similar name to copy, it makes it easier to compare drivers and find
> and fix defects across them.
>
>> +{
>> +	u32 i, pos;
>> +	unsigned long val;
>> +	u32 status, num_vectors;
>> +	irqreturn_t ret = IRQ_NONE;
>> +
>> +	num_vectors = pcie->num_applied_vecs;
>> +	for (i = 0; i <= num_vectors; i++) {
>> +		status = readl((void *)(pcie->msi_virt + i * BYTE_NUM_PER_MSI_VEC));
>> +		if (!status)
>> +			continue;
>> +
>> +		ret = IRQ_HANDLED;
>> +		val = status;
> I don't think you need both val and status.
Yes, I will fix this.
>
>> +		pos = 0;
>> +		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
>> +					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
> Most drivers use for_each_set_bit() here.
Ok, I will check this out.
>> +			generic_handle_domain_irq(pcie->msi_domain,
>> +						  (i * MAX_MSI_IRQS_PER_CTRL) +
>> +						  pos);
>> +			pos++;
>> +		}
>> +		writel(0, ((void *)(pcie->msi_virt) + i * BYTE_NUM_PER_MSI_VEC));
>> +	}
>> +	return ret;
>> +}
>> +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie,
>> +				 struct device_node *msi_node)
>> +{
>> +	struct device *dev = pcie->cdns_pcie->dev;
>> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
>> +	struct irq_domain *parent_domain;
>> +	int ret = 0;
> Pointless initialization of "ret".
Yes, I will fix this.
>> +	if (!of_property_read_bool(msi_node, "msi-controller"))
>> +		return -ENODEV;
>> +
>> +	ret = of_irq_get_byname(msi_node, "msi");
>> +	if (ret <= 0) {
>> +		dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
>> +		return ret;
>> +	}
>> +	pcie->msi_irq = ret;
>> +
>> +	irq_set_chained_handler_and_data(pcie->msi_irq,
>> +					 sg2042_pcie_msi_chained_isr, pcie);
>> +
>> +	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
>> +						 &sg2042_pcie_msi_domain_ops, pcie);
> Wrap to fit in 80 columns like 99% of the rest of this file.

Ok, I will check this out.

Thanks,

Chen

>
> Bjorn

