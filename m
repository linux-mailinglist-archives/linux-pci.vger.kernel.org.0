Return-Path: <linux-pci+bounces-18749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC49F72AB
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 03:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A38E16974A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 02:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A913959D;
	Thu, 19 Dec 2024 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U/2Bj0YM"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8386351;
	Thu, 19 Dec 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734575709; cv=fail; b=kPlhMFXbKbuEhXeDSXYbjL3WqQEXohZ54SoI2J627GlCGtLA0BO9GjAm+nhLoRPnVmXJtzFLt+79gNAHNbV/afE5dESZde9oeS9pAUJBI1axgxXx05huLiV8lPoKag1Q6/Xe6Rsweh03iW5uGnYC6dVFjeT3pT+furvkV2Q69mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734575709; c=relaxed/simple;
	bh=yGextHBjkJ/s32iK3OFGJ+OxteksglFZiwcZBcUphbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pgstqEdHDcQWdxRVcpC42HawSLWkDnFz3Otl/Q2ee/pSeEOE9AJ/SbVuHJM72Pu1BfDtXOIn1byE5+WX/OAefBWUxwpTYidDU3kf8p23WpFh4lsP33pPROKIsER9ypN3+K4O2B/VT7HxwSjh4ONwkp60TyVxeYN1oJuxpIBLmGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U/2Bj0YM; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7jz1RhIbrBnsw9V3sH+lqRNm9Br/WQoDDqcyUZ2jvr/mbJHorwF5niSHvUfxXF62f6i4M928e9jZioDYPX2HzrNnWZublLQJwszJ/hERXi56b/M2JY+iHFKvxiWUh3RwSpNf51ZRlxOV9JYmDx2ZjeSgwR9cdWp/o1U5oInQfG0PO+6CmoIxudXy26BcaKVIiPgL5g+3MwKQutuXuIa8K87bz1Dc6IoG54I/8HVfGXcNIS0R/gj5VwDFSMbH0b2rZKx5/kGY9BDCsIZGel2n9gtthmhOcvKDrt3pE3N3EZTXr1RM6nIu7xPDFzWIMdBnQ86QnhKhSfd+tI9gCb0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKH+pcfoE8FlgzqGj2cxedQVbQWBDZQLvKLNhq0TJ8Y=;
 b=IO8Jstomn265/dDX1DCpXirkBNm1KxFYvEIKqK5tgPkTeaByuamxgBli1+8BG+qJ6iw1iwWl1Yp+h40KgU5BCzCXZ7exDdKjE7IHgPjyACUzPWecoMuSd55HkCIvYdVFyGndARUnlx4St7H1OpYGT65b6/bCkfvyG0MaoxR+k4e9St1nDCCWzMNof8AIz/6d1z9b9IdKLCCUy354Y2eR34n2gm0dw8nqVQQCx1ZpjDsDP7BkKf7MhX6jqRnEvPuqQqJJNlifut3bFhLpgTCg/PjcbRwlaovXKRQ82KfCtmEk4Rj2j85Onr15Inzmgz6ZMQu4/JkTstdrDci8xPFDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKH+pcfoE8FlgzqGj2cxedQVbQWBDZQLvKLNhq0TJ8Y=;
 b=U/2Bj0YMcb8DlKG7v98qf0S/V344/yGQ0aO6mlv5ybEYFUlwqaQDUR+kTQIs5Tk4gS22KSKmqPRP57OiYMRKBwA2yozCwniaOtK8iXWYDqyNaOFcKFLa/+ZCCEU0MPdmDTZris7OooBnfd4FnKmoTwK+8AsXwSd2P54wf9sHfmR73Wuu/k4O28Ne1FVgFJYhRmc42JI+6TXvp/l1JSTKHXTMKfkPcpCPJVWxTo+9LMD+5pEwLuDoKRg244iPGRi0XtO1fWdWlXz7VULjcGF07NI7MxJJvQkBUDyvDiGj6dTSUJ1m23R8waA5jhy4FS1In47P/KJuJyeRwyanpNdrRQ==
Received: from BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:46::11)
 by PN0PR01MB5860.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 02:34:55 +0000
Received: from BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::67d0:f11f:b82f:1f5d]) by BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::67d0:f11f:b82f:1f5d%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 02:34:55 +0000
Message-ID:
 <BM1PR01MB2116EB0657EA6E231AB75BD5FE062@BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 19 Dec 2024 10:34:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20241210173350.GA3222084@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241210173350.GA3222084@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:46::11)
X-Microsoft-Original-Message-ID:
 <a700338b-26e9-4c9c-9567-ec05bc0daa71@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB2116:EE_|PN0PR01MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4121c664-9e93-4bb8-dcb7-08dd1fd5b87a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|19110799003|5072599009|6090799003|8060799006|461199028|10035399004|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE1UcDZDZVNHOHN2aGNqWUxIZFpCWWtqR1B5V1lkQXI4UDVLR2N6eVJ4NWti?=
 =?utf-8?B?UXZpZTJBL0hucUZGWnlyZ292WHN2UU5DS0w5RUVRM21UejRpcWNrQWdObSt5?=
 =?utf-8?B?RCtaR1AyamNTc0I1M2FJZ3NXODh5RUN4Wmc0K0cwSXNkRm14VWUvYWhwMnVj?=
 =?utf-8?B?dWdXemdmaUhidm0wSUtuelVmVjVMa1pGU1hDNEE5NmpwRHUyVFNSaEFydmZH?=
 =?utf-8?B?SFI1QWFMRzlnNmwweTM2K3RwdFdQa3ZGT0JEUlBqYndPSkNhdE9RNDAyanh5?=
 =?utf-8?B?L3FVam5PSWNIUUFsZEZqSUxON2FvN3VVZjQzd0JTdUMxSDEzVXJ5eXR0bjFV?=
 =?utf-8?B?QnBVVlBMdnBpNzFWWmxhdHg1SHVFYzNUZmNtd2NHS2g0MXNMd0JKT1VjanNw?=
 =?utf-8?B?ZGM3OVFtNFF0TE01NGF5UlpmV3RnMzJKV0FwVFVCOEdUMU5XenFzZ1plWXEx?=
 =?utf-8?B?SjRodFA3V3BsTklJSS93K0dQZUJIcWFvaEJFWFR1VjhnNTFZMkx1WkdKU0FO?=
 =?utf-8?B?aGN2d1NMd2J5QUhGUVdiNUFjOGVHdlVUY1Q1K3FBamtlQUVMMTdEdWtOTTQv?=
 =?utf-8?B?OEM4OW5HZVpYeE9pcHRQcTBOUEpmQXpqcXNZMEZGcEd6cEJBMVhlWlJnc2hU?=
 =?utf-8?B?aEJhUks5NDJiNk5FZlJ1UFo0S0pJRlJQa3B5N3hYYjFNcHhQVXVJZTZVOUdj?=
 =?utf-8?B?MklMazhHQ25LUHFNWm1QTU16dEdwRHV0bnpCaGMzbTlQaCt5RDV1Y1BEZmxY?=
 =?utf-8?B?TUE0YSt0dGdyenA3SklkVC91YlJzYTFGOWN5NzI0dzJXdVF1R2xiZit6L3Ns?=
 =?utf-8?B?VEovdHFzMUVjazhoMjZTZGxCL3kzaW9qdzZyRmNXMnR4ZVljOFhDa2VOS21V?=
 =?utf-8?B?UGVTM1NNQzk0SG5uV25LNy9CVWxQWGhCRldNSVc2UDBYVDBtVi8yNGJGMmVS?=
 =?utf-8?B?dzB4NmNRQzBaaWlDelliUlhSNlNOSHZJVzdrMG1IRVE0bUJzcGFxbkVQUFFM?=
 =?utf-8?B?NVhmdkRjdjhTcWZZWk5LNXpJQzNOaGZ3WHVyWmovTC9rVGVYb0tyQ1BPcEF5?=
 =?utf-8?B?cFJxalRtKytjaisrdmUrRFE2MU1DOHlyTmhzeis4WGI4ZzIzV0lmdFArc044?=
 =?utf-8?B?SG9QRjdaNlFtMkthT3NtZWRuSWpxRWtXQ2NWekh4ejV5NG9BcmwvUHRFYWdi?=
 =?utf-8?B?NW9BS3EvQnAxSHhkUDkzcXhoaWE3RWlaYytua29menpPc0lPempkMWJLQmtR?=
 =?utf-8?B?UEpTU2Rka1J3c24xNFVlNUhoS21yU0RqcXIyeUxZQ2lNWnYxKzJyMVhSVExD?=
 =?utf-8?B?VDdSUi9aQ1hLWkpFUk5HT29NK1l6dEgzK05HSHlnaWUvQzdaK3E1SzlMNXZh?=
 =?utf-8?B?RVpnSEs2bENkenZ3K3RtQmhja1cxM01NS21LdDUwdm1lYXNYTnpGaTdSR2Jm?=
 =?utf-8?B?VGV5NWpjclFqMzI2blg5dG5aMGgrMVplaWJabXVIZDB4SGNBbUtjb2NNTmRB?=
 =?utf-8?B?NGJabVdJQzVmRDBIMUlvWk91MXE1Ui8vZlE5MW13Y0cwNko2a3lDVE5PTG5V?=
 =?utf-8?Q?1lOYnZQZFANxFbdbSLbCE9k6M=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpvNVNPbVFEOWlWNWkzeEFUWWxWZ1YyaTNtdEh0VlFqdm9kWFpXdXlqVzZN?=
 =?utf-8?B?eWsxaTN5MUZvUFRuc1lWUEQ5L2xTblkyK0NSaXJWV2NqekkwV3lwZEhVNVpP?=
 =?utf-8?B?QkRmTk1BR05reFI0SzMvV2lJT2xZd2Y5YjlhMHdrWjFwK2IwaWdPeVVnY2hS?=
 =?utf-8?B?cFY5NkFlQkRkeFZBTlVIUzFKQU5FM2IxNFhnckJYRmhweVpacE44WDZkMW1K?=
 =?utf-8?B?Y1g1cmRxaklKSnRhNHRhRTBTTGZ1ZzNnaTJSYmw0Z3BxNmJzb0Z2T2hrdnM4?=
 =?utf-8?B?TXljaU1MRjFFaXlzVDUzcGJvdXFEY0dBNEo5NjlXbUUvKy8vbWhTN3J6L0Fw?=
 =?utf-8?B?d1BWYzBoT1FFdU45bHpaQjJYRjIybTYvZzZTbHNJVjFWS2ZGWFVNdW5pZXo3?=
 =?utf-8?B?UlpvMzIxaURLdmkwSnFvdWJCbDlad2RYaFp0djV6blNwYnpRTzNxa0lDaWxk?=
 =?utf-8?B?MWFtK2g5SHlyeVRack5jc05PQ1VWcEVkcWVHSkVpd3F6YjlIVDZOTENlUi9C?=
 =?utf-8?B?Mk9nRFphaDhMQ0ZlUy8rRzZYZ2F4d2hSWlNIMHNWSWFpN3dudFF0UXFHZ1NN?=
 =?utf-8?B?Y0tKZkNWWTNta1pTVTVjbWlTSjl1YkNDR211V0VXanFwWWdZOFRHcCtzNCsr?=
 =?utf-8?B?b1pxVVY0SVUvOEdGRllnaDNWU0srTEhycmtaSTNMSFg2dE1odWZ0VU9LZ080?=
 =?utf-8?B?RUhnQ1BhZ2djbGZ6aFlQbUxIeXZGRHovRDBlMVk4NEVYWXcxSVVoRnFtNHky?=
 =?utf-8?B?TDFPSUJKby8zN1NKSVpmMkJnRzBKN2htL1hsWE1jRUIrTzVrcDFNSXZwcHRE?=
 =?utf-8?B?UjNTUjJBY0hQZk9SWXRsR2piYllIS2ZFVUpWUUpHMFVZcnUrQ2xRTk1DV2pq?=
 =?utf-8?B?UE9WODBJWlVjZVM5VCswaWFpNGhucXFlUmxLc092aUQ4ZVdBUWJFTy9lM3RR?=
 =?utf-8?B?NW9XNVhDMm8wTFQ3MmhJRTJXVTBUT0dvY1EwSW5hS0J2cGdobklnT1k2a3dR?=
 =?utf-8?B?WTNnYXlSZTFscFpEV0orVDRsRXhrSUJHQnRBRm5CVE80SzFXZUhaMEI4WTlm?=
 =?utf-8?B?OUpsb0NKVVJWZGU1V2VraXRzTktORk41QjdyYmk1WmRVRmNQYlJDcU4zRXhQ?=
 =?utf-8?B?VjBxVytRdUJkdm1hZytPMWhHVHFvZ3cveFNISmhqS1NNV1g3ckcrZFB4aU5Y?=
 =?utf-8?B?WTltQ1plcWNreGJYekdBeEhzcjNMQS9MNDRtNnJ1aTBIajVWOG0vbFpmb21j?=
 =?utf-8?B?RmI0dk4rVkhtdWhCSTY4dDdRZHZyQTRpOU9IL1Q3bm5CUU9RV1dSSFZEdDFB?=
 =?utf-8?B?TTduZkFqZ1N2eS9sU1k0MUZNdk94bTBublFWaUhaK2RTNFRFVENBQ1ZVb0kv?=
 =?utf-8?B?WlplRzRzVjlUdThRV1dwNWxZcHdRTHN6SEo5dWpXcWxCdE5FOFhkYno0MUVP?=
 =?utf-8?B?ZFh1UzA2WTg1dW5nWC8zMzY4ck5YTGpxVW9RS1Q5TFdFWU5waUI4eXkzOFV3?=
 =?utf-8?B?UUJYRWM0clRhQUczV3gyRlJpT2kwWDFXdHJlMTRvVFR0bVU5SitLWnBaRzZo?=
 =?utf-8?B?Y1ZIekZ2a1FkR1BYdnhqblJrUE9vUWNkTTlxam9WSm13Y0kzeFpyWXdtMCtD?=
 =?utf-8?B?eU1RQXJPQzBkcytsRTFLeVM5L25VaGNSZm5IOVZTQWN1VllIYmIweVJKbGJ0?=
 =?utf-8?Q?mc73S47TzKwsM4TORYdq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4121c664-9e93-4bb8-dcb7-08dd1fd5b87a
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 02:34:55.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5860

hello ~

On 2024/12/11 1:33, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2024 at 03:19:38PM +0800, Chen Wang wrote:
>> Add binding for Sophgo SG2042 PCIe host controller.
>> +  sophgo,pcie-port:
[......]
>> +      The Cadence IP has two modes of operation, selected by a strap pin.
>> +
>> +      In the single-link mode, the Cadence PCIe core instance associated
>> +      with Link0 is connected to all the lanes and the Cadence PCIe core
>> +      instance associated with Link1 is inactive.
>> +
>> +      In the dual-link mode, the Cadence PCIe core instance associated
>> +      with Link0 is connected to the lower half of the lanes and the
>> +      Cadence PCIe core instance associated with Link1 is connected to
>> +      the upper half of the lanes.
> I assume this means there are two separate Root Ports, one for Link0
> and a second for Link1?
>
>> +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
>> +
>> +                     +-- Core(Link0) <---> pcie_rc0   +-----------------+
>> +                     |                                |                 |
>> +      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
>> +                     |                                |                 |
>> +                     +-- Core(Link1) <---> disabled   +-----------------+
>> +
>> +                     +-- Core(Link0) <---> pcie_rc1   +-----------------+
>> +                     |                                |                 |
>> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
>> +                     |                                |                 |
>> +                     +-- Core(Link1) <---> pcie_rc2   +-----------------+
>> +
>> +      pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in DTS.
>> +      cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") defined in DTS
>> +
>> +      cdns_pcieX_ctrl contains some registers shared by pcie_rcX, even two
>> +      RC(Link)s may share different bits of the same register. For example,
>> +      cdns_pcie1_ctrl contains registers shared by link0 & link1 for Cadence IP 2.
> An RC doesn't have a Link.  A Root Port does.
>
>> +      "sophgo,pcie-port" is defined to flag which core(link) the rc maps to, with
>> +      this we can know what registers(bits) we should use.
>> +
>> +  sophgo,syscon-pcie-ctrl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the PCIe System Controller DT node. It's required to
>> +      access some MSI operation registers shared by PCIe RCs.
> I think this probably means "shared by PCIe Root Ports", not RCs.
> It's unlikely that this hardware has multiple Root Complexes.

hi, Bjorn,

I just double confirmed with sophgo engineers, they told me that the 
actual PCIe design is that there is only one root port under a host 
bridge. I am sorry that my original description and diagram may not make 
this clear, so please allow me to introduce this historical background 
in detail again. Please read it patiently :):

The IP provided by Cadence contains two independent cores (called 
"links" according to the terminology of their manual, the first one is 
called link0 and the second one is called link1). Each core corresponds 
to a host bridge, and each host bridge has only one root port, and their 
configuration registers are completely independent. That is to say，one 
cadence IP encapsulates two independent host bridges. SG2042 integrates 
two Cadence IPs, so there can actually be up to four host bridges.


Taking a Cadence IP as an example, the two host bridges can be connected 
to different lanes through configuration, which has been described in 
the original message. At present, the configuration of SG2042 is to let 
core0 (link0) in the first ip occupy all lanes in the ip, and let core0 
(link0) and core1 (link1) in the second ip each use half of the lanes in 
the ip. So in the end we only use 3 cores, that's why 3 host bridge 
nodes are configured in dts.


Because the configurations of these links are independent, the story 
ends here, but unfortunately, sophgo engineers defined some new register 
files to add support for their msi controller inside pcie. The problem 
is they did not separate these register files according to link0 and 
link1. These new register files are "cdns_pcie0_ctrl" / 
"cdns_pcie1_ctrl" in the original picture and dts, where the register of 
"cdns_pcie0_ctrl" is shared by link0 and link1 of the first ip, and 
"cdns_pcie1_ctrl" is shared by link0 and link1 of the second ip. 
According to my new description, "cdns_pcieX_ctrl" is not shared by root 
ports, they are shared by host bridge/rc.


Because the register design of "cdns_pcieX_ctrl" is not strictly 
segmented according to link0 and link1, in pcie host bridge driver 
coding we must know whether the host bridge corresponds to link0 or 
link1 in the ip, so the "sophgo,link-id" attribute is introduced.


Now I think it is not appropriate to change it to "sophgo,pcie-port". 
The reason is that as mentioned above, there is only one root port under 
each host bridge in the cadence ip. Link0 and link1 are actually used to 
distinguish the two host bridges in one ip.

So I suggest to keep the original "sophgo,link-id" and with the prefix 
because the introduction of this attribute is indeed caused by the 
private design of sophgo.

Any other good idea please feel free let me know.

Thansk,

Chen

>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - vendor-id
>> +  - device-id
>> +  - sophgo,syscon-pcie-ctrl
>> +  - sophgo,pcie-port
> It looks like vendor-id and device-id apply to PCI devices, i.e.,
> things that will show up in lspci, I assume Root Ports in this case.
> Can we make this explicit in the DT, e.g., something like this?
>
>    pcie@62000000 {
>      compatible = "sophgo,sg2042-pcie-host";
>      port0: pci@0,0 {
>        vendor-id = <0x1f1c>;
>        device-id = <0x2042>;
>      };
As I mentioned above, there is actually only one root port under a host 
bridge, so I think it is unnecessary to introduce the port subnode.
In addition, I found that it is also allowed to directly add the 
vendor-id and device-id properties directly under the host bridge, see 
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-host-bridge.yaml
And refer to the dts for those products using cadence ip: 
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi

In this way, when executing lspci, the vendor id and device id will 
appear in the line corresponding to the pci brdge device.

[......]



