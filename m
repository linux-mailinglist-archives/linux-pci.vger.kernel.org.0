Return-Path: <linux-pci+bounces-21591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1AAA37D4C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 09:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9142716FF52
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E2919DF40;
	Mon, 17 Feb 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RDDYytDD"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25A3D68;
	Mon, 17 Feb 2025 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781632; cv=fail; b=JdTOcrw0WPXn2t9N/Z0JH6/+7rYSauXKwXrpauIaqW29MZKNVS+gO7u2WycoiQsZKbX1J8xJgMLhcJU/cz47gbOwaT7y2iVhoMRJ/Six9CBY0rExcv3X80Evy/k3fWqab0MtP2JIdeHR+6gjUooUe+ljYotTV/30xZdkAhjKgwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781632; c=relaxed/simple;
	bh=7uX/9bA6bghXF5EAyt+iZDhLRbLx7wyYiKY5CuylaH8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nz/ncM0eDBf1k1RHikyfY5BVeD+VjKCw4TQbUFrbjAhWzFneFPEj2McQ/pH9B7Fmt2WJW69KpnTHGMNrlsgiNXBfUuci0mW4Oko/N+GPp7ozSXuQPTdZO6mZtS+Xl3xnap+R9XqpqWUP3fB4J9ftCNzTvgWdXWYjk+N5GNxylVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RDDYytDD; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5mAKotDG8JPzlEZIH0kUxsOqX+g/jOVpMz3Pzduoz+30g1hDER7ogiTGSQXYzEExyilcr/48lWpPQ+q4BYp+m24llfeEMWPwDI8fGpuncqImr4aE5mI8GzrUZ2ZnRhmRexCNaCtEt8j48HiXrJnUZbOeeO7m5W017P/hLmUl+PEEBFmMRupHxXz1RWZ7CCYg4CczK1nXURS3A5uQmFdNhRjeBKS1bQZ5GmzTwa7YDqq/eoFPa+tk+U9CxpA1uVoq9v9Hf/r8w51I3DMkfITIQxOkyl5/eyiVMWrU2mln+8qsQ5fsvIuOoKXKQ/ahCmVk+aJyFTX6Z3znvO9x68xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd0cYfsnko93qDtnuMqztH+OfHtlJ+/v/cT0euvUNYM=;
 b=OjLMlaC1yR2TLc1VUdXBbNfeeBHJG7b9axLG0+ObV75zIENbINS5pRZtItDkB4yZaYZd1SnZbCNdDVz3J4FoU4HoPvD90jWokzlthRZ+3DYW4I1MHelm/rU73DiZ6qbcmOo+cUbAq/UJZW2rlyAzcyIl7yQj0YFB2C/D83suy5A3qSgh/1aIc+UUcDaFOUkRtr+G8ZCTSHr454jqvC4RVejF4CDMrDyCSJlc+ybMKsgWx/cM79c1pbAlqY144UOkLuJPY5cQA0/cs8ogI9+b+WlClL6RBnWZv80z2+s1f+hJKtS5ceFLhZwMzJQYEMEgejLSkeWiDPf+LklidGNLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd0cYfsnko93qDtnuMqztH+OfHtlJ+/v/cT0euvUNYM=;
 b=RDDYytDDabl664vkcBQcUEgt0v/jFp3AK0WQ0H6xz+8qEEb2E338NrJKUsAWrX0fhLiSObAa5t5shJYjpYw5yEOCePt1FfRBaCwe1fDEbKdePQscvOrE/RLwvCE5QHYEVlVS2Z0144SsMzNKpD0WHDrxp9S3sQBF333LPCQTjtOpY733YIZZtDfv+Aq6FCRmWrdw4c3CFcJQFYSKBz9e/TIrBbkuvhxo5+fdTNc6k/PDNZMVuLsdflwCpQEnMDPA3Gehw1bnTHxiRQJd8bLcw9Ejht8HXUP3bqnbEx/auCBVlYFvbs8jzAyZ+z6NyMrmVd8Pqxi9BBCOYPDyhqqD6A==
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::9)
 by PN2PR01MB9058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 08:40:21 +0000
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee]) by MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee%2]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 08:40:21 +0000
Message-ID:
 <MA0PR01MB5671F42DEE2C5491A65E3975FEFB2@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 17 Feb 2025 16:40:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
From: Chen Wang <unicorn_wang@outlook.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250212042504.GA66848@bhelgaas>
 <BMXPR01MB24403F8CD6BF5D4D2DDC57A4FEFC2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BMXPR01MB24403F8CD6BF5D4D2DDC57A4FEFC2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:6e::9)
X-Microsoft-Original-Message-ID:
 <67a810b4-ac33-45ee-ace7-73ba097e81f2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5671:EE_|PN2PR01MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d9620a-9d17-4ccb-e998-08dd4f2eb6e2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|19110799003|15080799006|8060799006|461199028|6090799003|5072599009|440099028|10035399004|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R05kYks2b3NZWlFpdnZZelVEbENuQ3RXOTNrdDFhVkY5RXlLaDgxZS9pWU9E?=
 =?utf-8?B?b0poZW5QZFB6Wm1DMzhsSFFXUWlMNmNHTWErSm1sd3EzMElOVS9UTkdOaG5P?=
 =?utf-8?B?YTV6RWRFMVFRMWVrTzdXY1JWb1dhdzdsWEJScS9rZUo0NER6RDgvR1lTcEhm?=
 =?utf-8?B?WEFoRE1YWWhySFBUTlA2ZkRHdHBYRjAwUTRJU08ySnd2bDVNK2FJNGhNRmJ3?=
 =?utf-8?B?MGFRVEpycWxuNGtYd0RJR29pSHkzNkFCbFpMcXNhNVpPS0dXcUEyQS9QYy9z?=
 =?utf-8?B?K2hmSUpsb1czTHYrZVBaVkN4NTZEbWwxTDl6ZkZKYmxSajZSTGdqUkw3dVow?=
 =?utf-8?B?eHU0NmVPRnRWaDdaZHhvUGxRTzBaMnpsMEUxajc1T01LVXM2Q0VmajV6MzhG?=
 =?utf-8?B?L0t4VTdHdFBaM29OYWM1QklORC9FR21OR3VLVWtSSEMycjlmMC9XazNzWmdE?=
 =?utf-8?B?Q3dmSmhaL3JYbzBIVFdQUG00YUJKSHJrenJlYk8zUWF0WXRwUFU1SHFCTkp6?=
 =?utf-8?B?K202S3gzNHlOSUx1c0dzUG9NK3N3V0xsRFhHOW5zWjNsZTRaZjdHa1Q5UXJv?=
 =?utf-8?B?WlNEM1lLbldZVGJCNkJQSjNPeG9kcHFkeWhZR0IxalEzQUd3NzJGTXRyemlM?=
 =?utf-8?B?RW9UdFZ3K2g5U3ZWQjhFMjdDK3JOc1VHOVRrS0lEcDNoSTVZOEdGSmN3bzBH?=
 =?utf-8?B?QUtkRzFtbFBjb2lmT3ZnVEFOcW15NlRZY1V5Vy8zU1N2MFJqNjNKL1h3a0ls?=
 =?utf-8?B?VnltREo4U0ZTYkdFZkFnSGZMTXkxMGdLaG00b2F3OU0zRGFyRi9kUHpWZlJ3?=
 =?utf-8?B?Y2hlL2xwQnlpMm1RUGMwTXNBSERoRWpyWnFMSjVQTEY1WjhHMmx0R3UzdFkw?=
 =?utf-8?B?M3QrVHdXMG11T0k1ZVI4c0dDVXpZdzgwTThuZllTWFVIcUFueWxYbHREV0VH?=
 =?utf-8?B?TlczWXFCaE1BK1RyU3ZzcFdwVjlRd2ErdHJQRTZBUGFYTXJsdWg0YmFOd3ZT?=
 =?utf-8?B?aDdZTXZIdGg2K0Ixd3hhcmQzcHRRcXJuakFnZnVZM0lRSk5WaFZpNHIwMUZz?=
 =?utf-8?B?YkJabW1LZVkzSVhhK2lKdlQzNVByZUZpY1BJYTBCVC9PQkdkQTRsOHNrWENv?=
 =?utf-8?B?VHZmZGQ2TDZOTFFUNFNNSDlLTk1nVmdtcEtYMHhhcDBrNHlFSlVuSHVGSEtr?=
 =?utf-8?B?cTBoa0JYR09DRUpMUjdGRGthenNpa3dTWXREOVN2b2toWDREUjZDQk1tc0dk?=
 =?utf-8?B?UmY3dnE4cVBqeUFIZGhVM2ZqRjZSQlozVkR4MXBueW5zL09HS0FmT2FveDMz?=
 =?utf-8?B?WWZHRHVMYTJrNHFnakZSZ1ZrbUVkVTVPVUI3MzVzVndNS200RzNSRS91RmlB?=
 =?utf-8?B?Wmp4dGNlUzRzTi9tTjlEVW5jNE1vazFGRUFJUUdKNE1MYjJmdmlkdFlIUmhq?=
 =?utf-8?B?bjZHcnJzOTU1NlhTTGZZeGVGYUoxbGo0UDB3Q1NOYk8xd2RicklOVVkxakxz?=
 =?utf-8?B?NzBGM1cybjNHbEEwciszYWh5NEFpT0cweFJaUWtuanpKbFN1U2JyWDBDbHVx?=
 =?utf-8?Q?wq9P5cglW69JQ5k3R3VIxtGnw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnJhUjJLbnNxR0ZKckxuaEwwazV5NTBWM0U1OFpFblUvM3RGWjJ3UXhqZ3ZV?=
 =?utf-8?B?YmhsM25XRXM2U2tCd1RrVWI0TkhvZTM5TjFSRnEySmoxM1daU2toMWZkTzZR?=
 =?utf-8?B?WTlJRVR4S1dJQ3N5aWlJU3dEdkhpQ1lnNlhFT1pDYkdhcUZNWlRBbmtCRWJS?=
 =?utf-8?B?czNkMDhBSDFkZzZzT3h6ZU1LYW50VVRyTm9PN01obU1tZDFPWTRzV2hJVys3?=
 =?utf-8?B?TTJVdjAwbVRVS1VZcXFyYVNLK3pOS1QvUVRReE5HTnQ2cVJsNDEwMUhSY2VC?=
 =?utf-8?B?TlRqRXhhZnBtb1d6ckxPaXFBelh6ZUhPaHU2ZzlHUDh6cjZ3NHVkeXRLOXR5?=
 =?utf-8?B?NGc3L1NjeXExM2UrcDdNRElLeXE4MGVSU0kwbUlwZ2dCZ2RPa3ZjaU4vdzFw?=
 =?utf-8?B?VWdBbjBabys0dTlVcVdZVXU4WG5ianE4WnZsdVBkS0J3VVg4V2F6MkYyM2tB?=
 =?utf-8?B?MEVNbkY5Y1J4M0ZncnpLVm5sMmZGaTZYVXJwN3hRRk5DeFhyZUg3dk11akpK?=
 =?utf-8?B?MTdqY0MyVGVBUWlhMTlqR0RxZllXbzNFd1pKdmtJU0ZvYWNPODFTQTZuY2lm?=
 =?utf-8?B?UTl5eFRsUlhPNitiQWhKRmc1UUtsVWFUcmFOcjRyaG1xQkZwVnc3UFcxQnRR?=
 =?utf-8?B?V3ZJUjNWOHZJSlFTbzZRN3NCK2MrRHRyT3FXSHJSV0dLeTk1MytVam03a3dt?=
 =?utf-8?B?clhleTVaNDhMTDBsSGYyRmRjYkl5RFNaeElOY3NSMDZKRVcvS2hKTjNJM2ZU?=
 =?utf-8?B?aXNsWG5HRHlzdHFmOXBxeE05ZHVFQ0Fod1RlcEpMODZHWnIyOXo2ZkVSUjB3?=
 =?utf-8?B?RURzZjdsTlRnb29pTWloWXJUNVRHeW9IV1EzMEtuWnpieHJ5TnZXL1dKbTJk?=
 =?utf-8?B?dXlpZ28wZXJwTzhyNVNEaGJUc0VpRC9jVmo3STRidUtIaGppVmdGYjBVMkZm?=
 =?utf-8?B?WW1FbklZWnVZcHVydzQ2KzExNXNYUS9RSDF3VWl2UmJqLzA0Zk9MTDlvRVFF?=
 =?utf-8?B?M29xOHJzS1ZwUWpiWU14YkVNT2I3Rm15bjI2RVpRWWpHSWEyT1ZMODhRVDNy?=
 =?utf-8?B?TG9zMzd3WUV5YnNTY0kyUjk0MDAvdFNjdGE0bGsxRU1IcWh4b2NwdFUzaTJk?=
 =?utf-8?B?OEZmN0k5UE5BblpteWNlajZrWnVXOFlZMnRFSEVoRi82YkpSL0R1RnAycFh4?=
 =?utf-8?B?U3NUZTAwTS9SblQ4Z3VGeUZtWWFXbWlrKzRwUStDL2NJT3cyQlB4U01DNlBX?=
 =?utf-8?B?czd0SElPakwyOGowTmdxMExxYUplWEVjMzZKdTdiVGE4bEVkWVpNV0I1SWlS?=
 =?utf-8?B?VC92VWljUjJZKzRzTUh6LzdXNjR6QjU2S1dVRldlNDlETFVaTDcyTDEwWk03?=
 =?utf-8?B?MjBOYzliR3V2Z1o1QVhiazAzcnlaOUkxT3JjQmtJQ3orZCsrVmdReEJ2NjRQ?=
 =?utf-8?B?dUcxd25GT0tVbmFjMmd3L3B4TjBQVlQwMGZlNERqdXg3ZHRKN0dQMWFabXFT?=
 =?utf-8?B?VWlNUGI4bVRhaG1udGpMazNhbkJMZ3lVUGpzcUN1RHJkSnYxSnlWRitaZGlT?=
 =?utf-8?B?ZDV3UzkzL3F6S3o4eW5QTTFDYWdxbFlsWUpVS0VobG82amxJWkRBSFNYUkhv?=
 =?utf-8?B?QVNxQUJtelZHYng5OWtzN1ZoOWRDazQ0bHJjSTNNd0FraldpeHlBdnRwcG80?=
 =?utf-8?B?aTBTdk5zekV1VWc3UnRSWVhHb1FXR0o4WVhZZjVCNVJtdi9HT1NaVnRacm92?=
 =?utf-8?Q?MJhZAdQdvRjfhtxMjFXmFB1vDjuFX/yM2n9omzD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d9620a-9d17-4ccb-e998-08dd4f2eb6e2
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 08:40:21.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9058

Hello, Bjorn, what do you think of my input?

Regards,

Chen

On 2025/2/12 13:54, Chen Wang wrote:
>
> On 2025/2/12 12:25, Bjorn Helgaas wrote:
> [......]
>>> pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using
>>> different "sophgo,core-id" values, they can distinguish and access
>>> the registers they need in cdns_pcie1_ctrl.
>> Where does cdns_pcie1_ctrl fit in this example?  Does that enclose
>> both pcie_rc1 and pcie_rc2?
>
> cdns_pcie1_ctrl is defined as a syscon node,  which contains registers 
> shared by pcie_rc1 and pcie_rc2. In the binding yaml file, I drew a 
> diagram to describe the relationship between them, copy here for your 
> quick reference:
>
> +                     +-- Core (Link0) <---> pcie_rc1 +-----------------+
> +                     | |                 |
> +      Cadence IP 2 --+                                | 
> cdns_pcie1_ctrl |
> +                     | |                 |
> +                     +-- Core (Link1) <---> pcie_rc2 +-----------------+
>
> The following is an example with cdns_pcie1_ctrl added. For 
> simplicity, I deleted pcie_rc0.
>
> pcie_rc1: pcie@7062000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     linux,pci-domain = <1>;
>     sophgo,core-id = <0>;
>     sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     };
> };
>
> pcie_rc2: pcie@7062800000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     linux,pci-domain = <2>;
>     sophgo,core-id = <1>;
>     sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     }
>
> };
>
> cdns_pcie1_ctrl: syscon@7063800000 {
>     compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
>     reg = <0x70 0x63800000 0x0 0x800000>;
> };
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

