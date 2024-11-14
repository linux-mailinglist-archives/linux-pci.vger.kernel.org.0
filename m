Return-Path: <linux-pci+bounces-16724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F59C812A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 03:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7F7B259EE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 02:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5F1E3DE8;
	Thu, 14 Nov 2024 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U5RadFiy"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB21EABC2;
	Thu, 14 Nov 2024 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552698; cv=fail; b=G7BTzTBGvrTYg8P4dRZLkLbT3/ParCs2lYGQSpOioUMHEwPpSdl/L/xjs8eLPOOm3eZPGysdn/0xFs55nwMOL0BvzvtFpPB7AIOr1EpC+uaFDIsFpIPyjeiu3PggMt1ITVyNaeeYyVcwVUXFAVkN0k4v/x6w/TPTfx3wzNOFr/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552698; c=relaxed/simple;
	bh=KNQMGkTYMYrQyzPENwWjOC378oyAl/r+b+g25CLFtrQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jl6ifvMEl+QDmV0zNFxDR9e6LjEhv557TMQI8G9aHjqRoFrTM5C4x+nLP5Ri3MuDIU0ZXSet9RQxwztZhDkX9nqAnHgt4sCugVvwxlP9h3nz0yE0EXQ7XzyiXiVP9wOjm5B9Huzfewkj8iaNfMzRE/tyIYSDPQrLASrYGaujVTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U5RadFiy; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4+G8ZuaR6i/1YejgV6SkwapNFzP5Hz3lzWav/c7KYCtorBB+wsCwK1h8UzQscv8A1RM37bQ82+jWa6yOGCPAi4ss+xv7bZ+sVbzjzUToBQj9ia9iz0B0TmPpKHAZ7FLOd41ZFZV3jeFWHP3g5xBEJeYpPr9bT3FX/nmT9O0EU+Dla0yJHMf6iHYK5Fp4mEOd2aBzKl3UPxOjxIeD1Znb8vMtBPO9tYSKY3O37s9nDRV4ARq4hbJcdinyqMY2Aw+IN+bEYAET0VgoOhyjrzO32B6ispjFgYWES+l2q8xTeW0z+Jn+YDjc+HAQc9mPYy6idrNXE8TdFEgHUptwfFEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QmyrSexW1QmE6ipi3xh1tasNCzXUR0ei8apF5brOLg=;
 b=xHfjLIcpV2dzaEkZRA284ABsyxagVy80agvig3EXlVzhp/cfi/c4w1yokPjwvAoGtp0ttId4cotQ6gWyssmZX1jNHgbORc7U+zNHz0IDyP7yJw4Ck29B/ZVKtEgXNJgtBin0/XkL7bqiH9YeB8rSrqwOXZXnva8hy7Yy8zJcjf1eHNtpOHBKXcFnMGjTcJ/y7R8ws1XONaLquAvtD6g9GRGEmKEj5yqMb5ST6PJv+6oVopj2y7YetECLQqbHSBo8O1e/fNixh+tirdqhCjvQE0mWF1MuMW99C7KAGPms742yMFDsZK0vCUw59pAhhJ35fZo0dLfdVJEYwsvlFVJ6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QmyrSexW1QmE6ipi3xh1tasNCzXUR0ei8apF5brOLg=;
 b=U5RadFiyYMIjtpq8k1pMPYfSZeBswri7ywT4YCMqaUwOgt1dmjQEVfSAI38LzrRuY+ZvuU+5k1LAXcP3E1EZcBgr4EMG1g7MGy6C+iL+a0JYuJ2W1svB1Z5AIe00Plhfkmw8JNZsFS5EB4WCcDXONftN9aBqG0XcT8mFKRdCaKjSB2K5jksyiN9N+eNm+K93Afr2CQcPM1t46g3RH8M55m13x5eJ5gbFZKwJEZnNIcQTsJkxk80pL2RNm3biGQyctigtOEytbLDoHwewr+9ZH058Nr/qckQxw5EiKDTbeKVnPaOVLt7uO1JP1Pa++p1VUq9d4C5BHJZjAAqhI1Dl9Q==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2000.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 02:51:27 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 02:51:26 +0000
Message-ID:
 <MA0P287MB2822642BE6F4B448410A28FAFE5B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 14 Nov 2024 10:51:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Rob Herring <robh@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1731303328.git.unicorn_wang@outlook.com>
 <1edbed1276a459a144f0cb0815859a1eb40bfcbf.1731303328.git.unicorn_wang@outlook.com>
 <20241112155913.GA973575-robh@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241112155913.GA973575-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <7cb6a172-33ea-414b-b105-40c3609327bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2000:EE_
X-MS-Office365-Filtering-Correlation-Id: b0027114-1a80-4966-022a-08dd04573b9b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|461199028|5072599009|15080799006|8060799006|7092599003|4302099013|10035399004|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE1CZys4RTNuQVQwcU9XZ1pHU1NndXkwTUFLb0QrdmJoM002aWMwVUVycUw1?=
 =?utf-8?B?SXJWY1VtaVdHRzVqbVlORXZYRUdFcHlCaWZhRTYydmM2cHB4a0JoZjNuTmdk?=
 =?utf-8?B?anE3Z3Jabmw1d3UxTURQNXV0NmsxWHN4U3RkdTk3dkpHZ1VpTXEzazJncUph?=
 =?utf-8?B?S0JzdVhxN0o3TjVTaVErUTBtR3VyemszVzUxc2lWRmdCYm1iVS9RQkg2c2N6?=
 =?utf-8?B?RHNBRUlpdkVWY00rcWVVM0dacGdJVDFjYzZnZDdoTmFTcmp4ZW5YeWQ3UEY0?=
 =?utf-8?B?R1R4MThENU1Oa040OGkwN1lyd0w1enpRT1pIczJHQlpkU0tKNFByY01vQ0NP?=
 =?utf-8?B?RWRNN1puM2dKMnpqVzM3UXRMZnFoMlhPZWtvQlUxV0I1ZjdDWml5UytVTVk3?=
 =?utf-8?B?alpGdGlrY0hSeXVKcFdZZTBpWnJPcFlKZDREZWhkWUI1bkhBVHdPdEw3eTc0?=
 =?utf-8?B?N3VMVTl0bWNNU0ZKbUY0ZlhnMlkxcUx2cFd0Ym51SUNoRjJNWHdBT1lqQWxM?=
 =?utf-8?B?VnB0V3NmbTUxK0VCYnAxUDArQU4xcFZlRFY2ZGJ0ZUNDeStoMmlrT002VzRE?=
 =?utf-8?B?aDhQY1JYbWVOZmNkdURpVE96M2kvNjVNd20waFZBemNkZTlRcFNoSmFBOFhw?=
 =?utf-8?B?elJXVEh6cmlQSHdMVi9KRXZab1NXaVBwSFhsR0Z6dm90TEQ3VU5RaG52M21F?=
 =?utf-8?B?RUdla3oybHVQN2NiMDkvOHI5a0N3dEdJNXdHZ3ZaaFhrbUlqWUZURlZicHdG?=
 =?utf-8?B?b2ltTnpaVzhrdW1ZNmhRRDJCanRERkd4N1ZGMGx3R2V5QTdYdDlCSTcxZ3lP?=
 =?utf-8?B?QWRzZzg0VFllV3ZhTHRWOTkrY2dmaE1RYlRDWnhHRi9YYzZZQlV1VGJUOW5K?=
 =?utf-8?B?SWFWVXZPWWk4WTYwaTRrbzJ4MTB6SjV4VHVKK2k1ZERvTnV3NzdFdFZBZ3R5?=
 =?utf-8?B?UzRrSHllMzVjeVhYUlRnMXZETEJ3RVltYng1WFN6VnlYMlhsWmJCRmRGbi9t?=
 =?utf-8?B?a0JSZnVYdUFZRkZLbXBITEIvUlhLd0YyV1ZPNzNzTEg3WnFHZ1c1azliaHIy?=
 =?utf-8?B?bUpJQjk0aFZYdmdPVFhRVkd0N3YzeGRyRFpjUWptUGxmb3ZPQS9wdk9IU3JK?=
 =?utf-8?B?elp3MDVxQ2VRSXRBSjM5R1BibzQrRkVtU1FtTHdOSFJmQWFsNWtJVGFmekQ4?=
 =?utf-8?B?S1cyTk8xU0pCV2NjQm5sK0ovRy9PMUV2SFNQNjBWN2tCVE0veEtaY3hCelFJ?=
 =?utf-8?B?Z2gxeExkRHRtaklwV0FqOENTbm0wR3RoRnFLMWl1NW0razZ4Njh3ZkpWWHp0?=
 =?utf-8?B?aGJQR1gvRGxyMXUrQ2xLNzE1MW5LZ1B5U0NNaE9xMUZ5aDFUQUQyL0djVDZW?=
 =?utf-8?B?Y2IyN0J3anBCOUZPUmExUDhCSTNhRlh0UCs5NTVqcGd1UFh1YjE2K2dJenhw?=
 =?utf-8?B?UURzMjBTOXpsWmx4VHlMaS9MMWFJNnE1SDVQMFNpc1U0eW54eXViOURjT3F1?=
 =?utf-8?B?S0lrckZ4UDhjUG9BSzhhZ2hXUEZjdllHRnY5NXY0STZSUVA2bS9zbUFjbHdu?=
 =?utf-8?Q?9mBj5HLqJXRKWBwbS2zmCl3eKlFLoyiIMgfBwL2QnAZmFL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGFTbGt0UlNML2NuZlZZWWFiZGJyZzczcENqZmQwSU1rRUIrMEVSU2JhcG1v?=
 =?utf-8?B?bis1TWZtZllxR1lHV3ZESVlmbXhEZ0VXYzBtK21HMnNlNyt0S2F5djlKSTQx?=
 =?utf-8?B?T3l1YVM4TW9Sb2JJQW9BZEg0a012b3pDVWVNRldYQWJqWHBzVitma2c1SEVB?=
 =?utf-8?B?TUtGc2tJbGhzTGx3NElKV0RtQUJqMXhzZ2h5bzdXdklSeHIvOWRMREppbUx0?=
 =?utf-8?B?cjd2eEttbE1yUFcxZ3BuS1lDd2ZxS0NMNHNsZTZuTXBaNHRnODlWdUprTkVV?=
 =?utf-8?B?SnZKR3pNdHhNR1lmZGRheFNKc3lOZW93OUxKUS8yd3RRM2prV3JiR1NmVGNN?=
 =?utf-8?B?dlZHQVpvS0FsTTBNT3RTVUdvbU1iWWtmb3p0M1NnNFpBZXM0Rmd3cTVnZ1pG?=
 =?utf-8?B?dUxxR0xHTTRPdGwyOW5SVFc1M25Na1VDRmg1dE51ZENDY004RG9YdlNwV0xk?=
 =?utf-8?B?NE8zQXBaTTRuTnVCUjUrRjd0ZW5hVjl4V2NjcjVlb0hURit5MFVrbzdVWi9p?=
 =?utf-8?B?Z1krVTA2bUZQWW1IZ3dURXd1dEVIUStiL3lmQjU4V0Q2aGlsVUlsWGxINWtO?=
 =?utf-8?B?U09zTjREZTY3VG9PVnk1eTN5M01HRVY1OGFnQVdpbTNmWTgzdG4vRGsxZkE5?=
 =?utf-8?B?cVJ5cllkTXJEd1dMU0R6N21ZbzJJemRLUWJhVmZ2U3pKTHlTQUNqekpFVU1W?=
 =?utf-8?B?djdmb2FsTEpZNGczclBoZlZiRGsybjJvUUNrWVlCR0xXanUrd0xXQ2xhSGdv?=
 =?utf-8?B?WjNvbUJNSDVEdFBRWlY0UVNub29ES0g0bjZLSTN5ZzIrblk0N3dOZnJhcStW?=
 =?utf-8?B?My9zVG1CaHVTM3hEcU9zR0lRbTBDTmFlbEM5ankrd2E0UnROTnExdmpwczM1?=
 =?utf-8?B?R3I1YlNwcWpFMnF5LzB1K0lIakt5WTc2TXRFOXdHdXZQWmlBakhlL21CRkp6?=
 =?utf-8?B?WHAyUWcxalVXRVpBMXBiSS9zVVRjbGZSQ2xFRmF1cTdMcktKMFI1NGdvNHM1?=
 =?utf-8?B?dzk0QVpHTXhVLzgwN3NvWkQyaTJjTXNRbU12VWd3eDBsVlhna002bWNyNG1j?=
 =?utf-8?B?UnRLbXZzSU9XNW5qQ0l0eXEvckowNExEdTlYblh0K0diTkg3SGQ1OGdtckc2?=
 =?utf-8?B?VVRzRTBjY0llUFp6YmJ2NDdLMFRWL2RHQzYyWmROaXQ5bXMzWEpVaXhCSit4?=
 =?utf-8?B?aWd1Qm9PYWlHdTdFYW8wa01rR2lvVTBtMDI4TmJkQXZNT2QvSG1QNnA3SWRh?=
 =?utf-8?B?VndBMUF3ZCt3MXhMVTVvTURDSzBqTGlTbXBwNG1IejdKTHpQaENqYytFVURW?=
 =?utf-8?B?MHJOZGlhRm5KaGtvOW1RL0dvVndCWktDSUJUM2RhMW5DL3JZWTVBMjJEOGdJ?=
 =?utf-8?B?c2VvbXN4MjBZMXZaMzdxTEMydUluVU11eGl6UHFqaDNJbCt1aUhtSDVFQ1ZW?=
 =?utf-8?B?NFA0Rnk5RFg4TkJLQkpaMjB5VmtrSXhVRUxXSVl0RVF4REtFMmlUdm8rTCsz?=
 =?utf-8?B?WHd3dWNTcEVFdGkzZlZQc0dHK2NrRGVDR1Z5WTlpOU1ZUFVHRTBFeXpaMXpS?=
 =?utf-8?B?UWVVVDVtYWVzZEMySm4ycG9DV2RXMVo5ZXpPTlE5OW9wa1hLT3BCRXRDdlFv?=
 =?utf-8?B?RHZ2dXg4YWorVDlTVWZuRVEybkVjQTRqVEF2MU8rcFE2dUhlS2J3WTBZMGo0?=
 =?utf-8?Q?5xGOzFu3r4Xrn6VUpmll?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0027114-1a80-4966-022a-08dd04573b9b
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 02:51:26.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2000


On 2024/11/12 23:59, Rob Herring wrote:
> On Mon, Nov 11, 2024 at 01:59:37PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding for Sophgo SG2042 PCIe host controller.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 88 +++++++++++++++++++
>>   1 file changed, 88 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
>> new file mode 100644
>> index 000000000000..d4d2232f354f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
>> @@ -0,0 +1,88 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
>> +
>> +description: |+
> Don't need '|+'
Got, thanks.
>
>> +  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.
>> +  It shares common features with the PCIe core and inherits common properties
>> +  defined in Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml.
> That's clear from the $ref. No need to say that in prose.
Got, thanks.
>
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-pcie-host
>> +
>> +  reg:
>> +    maxItems: 2
>> +
>> +  reg-names:
>> +    items:
>> +      - const: reg
>> +      - const: cfg
>> +
>> +  sophgo,syscon-pcie-ctrl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the SYSCON entry
> Please describe what you need to access.
>
>> +
>> +  sophgo,link-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Cadence IP link ID.
> Is this an index or related to the syscon? Nak for the former, use
> linux,pci-domain. For the latter, add an arg to sophgo,syscon-pcie-ctrl.
Let me give you some background info.

SG2042 uses Cadence IP, every IP is composed of 2 cores(called link0 & 
link1 as Cadence's term). The Cadence IP has two modes of operation, 
selected by a strap pin.

In the single-link mode, the Cadence PCIe core instance associated with 
Link0 is connected to all the lanes and the Cadence PCIe core instance 
associated with Link1 is inactive.

In the dual-link mode, the Cadence PCIe core instance associated with 
Link0 is connected to the lower half of the lanes and the Cadence PCIe 
core instance associated with Link1 is connected to the upper half of 
the lanes.

SG2042 contains 2 Cadence IPs and configures the Cores as below:

```
                +-- Core(Link0) <---> pcie_rc0   +-----------------+
Cadence IP 1 --+                                | cdns_pcie0_ctrl |
                +-- Core(Link1) <---> disabled   +-----------------+
                +-- Core(Link0) <---> pcie_rc1   +-----------------+
Cadence IP 2 --+                                | cdns_pcie1_ctrl |
                +-- Core(Link1) <---> pcie_rc2   +-----------------+
```


pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in DTS.
cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") defined in DTS

cdns_pcieX_ctrl contains some registers shared by pcie_rcX, even two 
RC(Link)s may share different bits of the same register. For 
example，cdns_pcie1_ctrl contains registers shared by link0 & link1 for 
Cadence IP 2.

So we defined "sophgo,link-id" to flag which core(link) the rc maps to, 
with this we can know what registers(bits) we should use.

That's why I don't use "linux,pci-domain" and also it's not proper to 
define it as arg to "sophgo,syscon-pcie-ctrl".


>> +
>> +  sophgo,internal-msi:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: Identifies whether the PCIE node uses internal MSI controller.
> Wouldn't 'msi-parent' work for this purpose?
I will check it out, thanks.
>
>> +
>> +  vendor-id:
>> +    const: 0x1f1c
>> +
>> +  device-id:
>> +    const: 0x2042
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    const: msi
>> +
>> +allOf:
>> +  - $ref: cdns-pcie-host.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - sophgo,syscon-pcie-ctrl
>> +  - sophgo,link-id
>> +  - vendor-id
>> +  - device-id
>> +  - ranges
> ranges is already required in the common schemas.
Got.
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    pcie@62000000 {
>> +      compatible = "sophgo,sg2042-pcie-host";
>> +      device_type = "pci";
>> +      reg = <0x62000000  0x00800000>,
>> +            <0x48000000  0x00001000>;
>> +      reg-names = "reg", "cfg";
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
>> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
>> +      bus-range = <0x80 0xbf>;
>> +      vendor-id = <0x1f1c>;
>> +      device-id = <0x2042>;
>> +      cdns,no-bar-match-nbits = <48>;
>> +      sophgo,link-id = <0>;
>> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>> +      sophgo,internal-msi;
>> +      interrupt-parent = <&intc>;
>> +    };
>> -- 
>> 2.34.1
>>

