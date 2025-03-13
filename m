Return-Path: <linux-pci+bounces-23575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE50A5EB85
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 07:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB816E7AB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 06:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD61F9F72;
	Thu, 13 Mar 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FC8xAE9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2108.outbound.protection.outlook.com [40.92.40.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32D78F4A;
	Thu, 13 Mar 2025 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846165; cv=fail; b=J0hR4/fQj+wZBCldOFaipPnlaOaI6VjN7aefsgnDE15pXbcn5N9fzRt1SBrMCEi10p2SLak3ZQpYj8LgWWDzN/sAidEqJtiBXkEaGWMTDG4eaL413zEkuCgRq6dlJgA+S6cAVpJPT/sJ5NuLedP/wbfzJniGtgGNDuAf2EbHUxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846165; c=relaxed/simple;
	bh=7vfNuw1fq0qJr7pudu0Wayo5vsXmp1dg/5WEG/etqJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+Ww1zaX+fhTGupV4f7nUsZslbvmcm+WF1v7LemYjzXKkBEepySqtd9/f5yTfxIJhvcHAU5cDl2OYPMcPtd1TfVBDbCVZNPJU4e8xOzfJU0mQ5FBP5NCVeau/M7oBd7fCL4L26G1Jfs4++Iyr+RUp6O+f15Ay/0VrHYA/+/A7sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FC8xAE9W; arc=fail smtp.client-ip=40.92.40.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBV4UKimxpClTEhuQndh1kK/91OKLxTr7St1fPXSqq1L3QFuL4GFV8mJ6/ol94dQeatBDl12zhAL82L+s9grzHDLmZ7AMendQA8K8c4ZuIDIJhQTjNhvJLmlamoU+F2/57BZMy0BzNyjjRWELHDs6sksv1Akeoz0Z8Duo6ppGmOhIwLkKJjZv3UrooHzxqOUTubs8tOWHhX+SVQbRP997Bi95YG0YBdXYpM3ldw8oTrt9uiTlVBEsWEtdLZNTcEdgryyE9lrmZLDC1XfVatCDkVqGGCoNj5qyIi8UNZYqLh16kFHOlYbSKSb9l5qMlrfnUP5hvVHr3nO6tuC4ZnqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfGxMTQzOdrij5LaIl5bC7E6g9N+/VpQzenBtZyOr3g=;
 b=a7V89VduqizGQSYcYpNNxYQ/NbAX6ljo+FyFhF558kmkdvkn0c2uknQesovaVj9f3e5WWj+S1ZmElTlZHwyDSxOdwJkeq/E+q3A6u7LoTLeRRyRUlhBh/eVdwWLQ9WCE9uNtGQqkekeXfULd9JH0kPkT56tgMz7SeiK2NWegjmQAeliI3zx5R6h6dt8IXoGGuViNulM0G3KgEA+L3XCmaH/605ptVK/EjGoaT2o2ksDnyhyvVA+a+LAVSIjWTOnz8a8FWT+y8T1qwIOpS3/zlmoCnMVADce1ldKsIQr7+MtXjGafiIygYLNPO+5MnUZAuOoI4rCq/aBFhClKUaqfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfGxMTQzOdrij5LaIl5bC7E6g9N+/VpQzenBtZyOr3g=;
 b=FC8xAE9WcqNfRzJJ7/+rZuT6T5cRdVeMi3WipjCqJqTlcFLQ2wG2JbddbcHjqYA8+lPdhEF1zOTlKOcNkP4Fr2huVQPGnsjBUkun4Sjb3Z11EATPLs7SG8m5SU5Ilzkmjhg45B9COSvtPWi0R/0s2l2W3ZOsnoUQGdvAKpJjlwF5UWKYXZujD82vvuf+o8TTAiprw6Ioa5JrB/VLKVe8a/h5grx8+jf9xtPLmSDWlBelIC+HTm3redA1zeAKzHO/x7TIqUHbUJR2qEAeaDhf2f3qQwMA624DrauOC6NkwiyX4LPK4AS5sC7aymVIBX87iAb7Ldz+V8XS4vLE5Hw8XQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8755.namprd19.prod.outlook.com (2603:10b6:408:28d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 06:09:21 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 06:09:21 +0000
Message-ID:
 <DS7PR19MB88833DD28977A0740FA4D2FA9DD32@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Thu, 13 Mar 2025 10:09:09 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
 andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, kishon@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org,
 robimarko@gmail.com, vkoul@kernel.org
Cc: quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <aff4fd18-59a2-4378-bfd2-840bcd1a2392@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <aff4fd18-59a2-4378-bfd2-840bcd1a2392@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0060.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <78d23edf-d31e-4a22-b59e-c30f9d54999c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: b08a0311-ed1b-4a1b-a96d-08dd61f5983a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|7092599003|15080799006|8060799006|461199028|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWNEZXlyNW9sLzZ5a0ZQYVFsREdmeDlzRm5CNmQ5MXB4Z3M2Z2V2SzZwcVND?=
 =?utf-8?B?Z1pPd2dOLyt2K0ZlU2pIRTFwOFNDV2pJTlk5L2FrVnJDSWNEcklaOGNCdSsw?=
 =?utf-8?B?cmRUOGZhN3hnNmkyQk5oUkR6QUtnbGVDQzljcC9hclhiM3NDN1VDQkMwSHNO?=
 =?utf-8?B?UFEzSzZYVm5reWl6MXE2U3VNd3lxMlVGUUp6Q01CZ2h3cVVZaEFXNmhKTis3?=
 =?utf-8?B?MDBzRys5UUNyRis0SU9lUFpxZlIrSnNCOUd3Z0xEMi9waEUzVFJKd1M0a3pZ?=
 =?utf-8?B?WHg0Y0RYQmovZEsxYXM0b2RWOXh6WlUzcVVScVV5WGZmUUYwVW05dDJJK3h5?=
 =?utf-8?B?RjBpQkxYYjJtbTV0eWZKUHV1UnRoVVFBVUMvRWladFoyZ1dyL0tKRTYvZE5Q?=
 =?utf-8?B?RndFRG84WWtwOXBOWmxUR0ZKM1p4NDA0UGJjQjRweS81OXg3RHBwamp4K2NK?=
 =?utf-8?B?cWtQQ3NOdUllZ2FqRXBRR2NwVUxjRXd4TTVPTDUzM0g4ZUU0OVJMWUk1REFy?=
 =?utf-8?B?YVRQK3NvVHhQWWNYTzFjd2JYOWlTVklOb2pHbFNySTRqWmZ1VnJGSGhET1Y0?=
 =?utf-8?B?MU1icWRTY1l2bHI1cjdMLzRKTjdqNUUwMzNxL1N5WFNRMEZ4Z1dQdVVGVm5P?=
 =?utf-8?B?RTF0REo4K3ZxSXRObXZmaXdPTk9ka1hnZGt3Q3lTUDhuMWRSNlJYWTd3TzJG?=
 =?utf-8?B?US90Uzc2Uk4vakJ4RTFWNU5pcldOaUVRWlJCdThSeCtseFk1QndPbGY4L1ov?=
 =?utf-8?B?NkhDaUd2bVN6OExMNzdtV0tmMlowRHBMYTNGdGVxZGVVengxU053RVJ6aUY2?=
 =?utf-8?B?WXNnQmFyUWtVZkgwVVR1c20rRjNzZGZwcDZBbGVqN0JiT2ZEREo2MzNDYTA3?=
 =?utf-8?B?RUk1cmVnTXJibXFGcmEwbDIydlBLWlErdDlNVVhLK1BaVkhQS21KY3RwcWJB?=
 =?utf-8?B?S0p4WG1XNUhpMUV0bmRkZlhLbnNoM3haeU5yYnRIR1JXSnk4TEVPeVNXVlNz?=
 =?utf-8?B?ZHI4bU05dDJwSGhncUVFOFlyNHhSZ2g1N3FmUUNFOU4vUG9NblhxZE1mTEZ4?=
 =?utf-8?B?eWlReVFoaHF0UVRtbVcxRW1qdG9UVmEwc3FUK043ODBzMEZUUXdVdWtnNjUy?=
 =?utf-8?B?U0ZuL3VMUVZTRCsvR1RDSzhBYWNLSU9JbzJOSjVIVTNUUCtLaVVSa3YvZXo4?=
 =?utf-8?B?TVMrd2pUUi9RcVdSZHVrMnd2OVQ5YUJGMC9McndSSnVUd3dPWm5XMXdwY1FJ?=
 =?utf-8?B?QW1jMzR0MmdhZkZ1NlpMdlhDMG9lU2loc0pzWWtMTkxweGJlT0Y3Zm9aWS9y?=
 =?utf-8?B?cHZpQmhBdnFaZkRJYTFnVnI1VTA0d2JmWjh5ZU4xOWxTdEY2MzVrQm9XMFlh?=
 =?utf-8?B?Vk9JZ3VsZWE3bVBNVmg3bFNsVU02UVdLVlJOSUYxOGI0SEFoNDJEMnlkN3Uw?=
 =?utf-8?B?VkhVQkNrL05QamQrUFJhL3NiU1lPYXhVcnI3QzBxblVPZlZMUlZQZ3lGSEtB?=
 =?utf-8?Q?UuJNIY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGp3L1dPbmc3d1ZiZFM4L2U2L2N6cVoyTjBjS1picXNTdklEWk1iWjFpL1RZ?=
 =?utf-8?B?VkNXcVIybjh4ME5VK3ZBcHlUKzZVMEM4dXFxOTdERm51eGZaMW5VSWlCTk12?=
 =?utf-8?B?YU92bXBVK1lxRTVCYnlEcW45NEtZSkYvZklpcDJhaXMrQkhoVHJuOWtOdEpL?=
 =?utf-8?B?SVByMWpvMGQ0VXpFUlBmWWFmRTBaNml2bE8zbnFFTEFSZ3p4VU5icHd0cEda?=
 =?utf-8?B?Sy9Fa2VVOU1mY2F3VDFpbnhVZ3hHVVRoSHZMVHVWc01YRG53eEpKYXBDKzVI?=
 =?utf-8?B?cHJsV2JOUXJxY0xSekEyV1lEZkFGV2wyT1FZbFFxTHpyOG1SRWNVbjBMTFdJ?=
 =?utf-8?B?ZThCN2dieE1zVnduMFdtelZCOHpQaGNmSlAyNExMRCtJNE44MjZBQUcyWFNQ?=
 =?utf-8?B?OWlJK3h3b1FQQ0E3bzgxT2lMNUMyTElZRE5WMDhpczUwK2NsZnJlVkY2anMy?=
 =?utf-8?B?Z2g1N3Z1WTV4MDR0UXFqWjJORmJRU1I2Z2Z3UlA5MlBkYW5XSUt1VTNIUWhO?=
 =?utf-8?B?SEJGZVpCbU5QaGJXSmFVclZNY1JCZU0xZmVrMS96NDFKVTVKamhUWERCVlpk?=
 =?utf-8?B?ZER0Ylp6VXhnWkl0S2NiUUVzdnhyR0xkdXUyRHpyNTdBMVRVdGp5SGhncGN2?=
 =?utf-8?B?RU9MMkpxenVCbXFzM01JUXk2TGowZUV5L2NXSHFrVTdjQWs3a2R6TXU1V0xr?=
 =?utf-8?B?cCtmQytnR041TGc5ZThoM2RxUkorQzNDbUpmbEhJUk1EUUIvZ29OeVFSajlj?=
 =?utf-8?B?OGl1NGEzd1JsZEdodnB6TkROY3ovTm03cDkyYjlYeFErNmd1UVJRZk1MZkh3?=
 =?utf-8?B?RFNyakcrbGxxa3JDWTRteDZsOFRiV0U3Z0M5dzZiOUo3eWg4N3Z4UUhIaFNj?=
 =?utf-8?B?Y0JQVG15bmN0bmdPZ3lPR3AwcWxubnc4aklsSTYyN3FVMVl0SDJZUmJKYXZh?=
 =?utf-8?B?b21qaDl5UGpwNTlVUloyZUtLMHNscUtKSDJGTy90Qm4xUGYrK0RicTQ5T2Vn?=
 =?utf-8?B?T3hMZWpIa21tckhDN2dvelo0cnNVZHJoeCtGVmVpallSY3lPeEZYWDY1SE50?=
 =?utf-8?B?dFVWdGhFSXJtbGxzaXR2UWZlVFpJR2RSeVI0T3ZkZFgyQXFNUEFRazdRR1o4?=
 =?utf-8?B?dGVuc0tQNmdhVTc2TTdSb3k5M20vNDVhT2NZUDY4U3l6TWhCVVV6RVVpa3Nj?=
 =?utf-8?B?VWtXRWVOL2Q1VUFGemZYK3hsVFppRTBZNlQrT1hmQXJDc0g4aWVSNWgzSnVG?=
 =?utf-8?B?b1oydnRYZldGYzlNSnZIcTlXVzltODVPQ1F2R0gvKzFIczk1cHIweEJGOWFV?=
 =?utf-8?B?MG5PdWZhZ1kxZnFIZmMzbDZLay9nZmJiczVXTldGSnpucHVxK0E1d1VORXdV?=
 =?utf-8?B?Vm5Pa0J5ZmVZcSt3dWdBL1ZuRGFUR25JYmZqYm5Mb1V3TE5lNmh2dEVrVGhu?=
 =?utf-8?B?NzBFemVPZGlUWHl6b0lhcVBWL1BUSkpQVzUxSS9vcjV4Y0FPemI3NFVLVDl1?=
 =?utf-8?B?c05PeGRENTI1WkVEQndlRHdMWFFUbWFWTVdBVEM5ajNXc1FSQXFhZEc4dHZB?=
 =?utf-8?B?R0JPWGFzR3NScUF3Z2QzVzZSdWVnN2MrcWN6V3Z1RFN4TWp4cHZraC80TWRx?=
 =?utf-8?B?bWRXVlF5dWV0RDlVaDJmQkxNbC9EajJjOEpCS1UwamxGSE1vb1c5QXlXNndz?=
 =?utf-8?Q?LzDUdsJxjSV7HfeIuZ9l?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08a0311-ed1b-4a1b-a96d-08dd61f5983a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 06:09:21.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8755



On 3/8/25 19:08, Konrad Dybcio wrote:
> On 5.03.2025 2:41 PM, George Moussalem wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> Add phy and controller nodes for a 2-lane Gen2 and
>> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
>> one global interrupt.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
> 
> [...]
> 
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> 
> Please all the comments in this patch, they're not very useful

Will remove in next version, thanks!

> 
> Konrad

Best regards,
George

