Return-Path: <linux-pci+bounces-24498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDEA6D5DE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC5716DF55
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54ED25D219;
	Mon, 24 Mar 2025 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uhHOJh8m"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2076.outbound.protection.outlook.com [40.92.46.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702525D206;
	Mon, 24 Mar 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803604; cv=fail; b=NJDznqB/JrFg+9xfmjjhrb8f5PxFkzMKmtlmhyuFI7/rhapdRoZ4Fnu+sV0P+8+Agv3ooaGiZCC73Lu0URNBAk8SkN8UjzmsGC/D8/mPA6E/Wm4d9wjHLsc9f8M7je1LyaGaUokDtn+4uAUk3OGoixkRaY0zdnqY5Dp/BlX9g6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803604; c=relaxed/simple;
	bh=9D4E7MNdF/r34H3NhEAsk9UA2b8khKBMe+sq668mTtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjOfqL+mQF82ctLp1onpio6PReCYK9idEpucf+lcKZXEHZhaSETyIyHlJGj7xyXZd162gYgSyScfeRrC3CHcCHyu+6YwqMAl7D17VDfDH0PWTGTyXwXoUlNSLUZoagCaxjn9nVSh+dyEspbKufEvPCF9o+X+CAtH35ObN1e02nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uhHOJh8m; arc=fail smtp.client-ip=40.92.46.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0AgQ7D2K8U9mMEYR9y6xahpMkbvJGNF5s7tkZTbubgE32viGe/ZBPVMHj21gwZ97aMd9s2hT1SqRhL4leIr1Xi+LMcazui0oIMr/7cNu2zw4MF/ZXR5Zk7DiFyPqJRJqvbUABiY51eeVVwCxdF2tFGR8LOG+7x+IXgauPsy21KYrHO9f3JgWf8hPV6Ih9QwBM4cS+Xjrqjv2SXpSbVy6gno/Vv+LSCM2unVDVxgHZBVVIzuT+7Q+F65M/6dgQnFG4HukeWi0d/x+9Yhk+/RNfUDUS30iKsWyLtBk8CMR7QZoDG0oGzsQb9BptNylWKUTbT13CJShZl2i6ZzQxV3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLdEXcHDKyU1XTLBhDcNm2pIva9ZBXkrf23a3RxzWgc=;
 b=QTwTUxF+lXgLwB0eWCr9yah553LAP8V2cew9G24Fa9RpY8Zp5FnKml0VCex/qBFGhClgYNlaDcflFbqY50aAqSljUkAEnHcSO1AkceFrf3zW9kKuvhptZMwznlmAixWKUudxEoufPCsdErksy3bN+IPGSdqRWPzgdV04m1VXFtnshRi+CuKM1xDEO9/u6mjiL+0v0lJ55VhlvOZGhRQ8KnHun3SJ43AQnp3/+lb1pTzjgOxRydYeL2wCuSEBZBqGVXPqM+PheRbQhHYGegdL+wOJdsA08ruH41w3a/YsaGA/tjwNlWHR8tAB+afXH27SjBxamtRFrVB9++6isRLNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLdEXcHDKyU1XTLBhDcNm2pIva9ZBXkrf23a3RxzWgc=;
 b=uhHOJh8mjiBATCSFLaCSqAr9mJ4hUJDJQkzupejg+q5Yw1iCRMN9XGmQqL/dkwaSwhqeQ61cPNSbeCuPHDb6t7ao/R1zg+Zxfm1DcqXvVjCk0FsR9xF1e4ZxwfZOgM8Iy28KhMH9ruhIgSlaQzIp1B8++C4+33kE43DUEKRGuuC028QzeXitIINllWZpwrvSKpGi8SI1iHJiLZbT3Zj0SjqfWaQsiW9VpNx1KQjX2QHtxtqUe2spkdGkQv1/JR/O5m1x27eizG+5WgDedMCosUxyX7yFuyKAZMaze1sdTzkGwEMU0kOecUnqLxVltKDxDduEib+Hk31VjjT2YcIhAg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM6PR19MB4026.namprd19.prod.outlook.com (2603:10b6:5:243::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:06:41 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:06:41 +0000
Message-ID:
 <DS7PR19MB8883D7102C8A7BE2A87B77009DA42@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Mon, 24 Mar 2025 12:06:29 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: ipq5018: Enable PCIe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nitheesh Sekar <quic_nsekar@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 20250317100029.881286-2-quic_varada@quicinc.com,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250321-ipq5018-pcie-v6-6-b7d659a76205@outlook.com>
 <5seajsw64e7mber5yga3ezcnvip3e4o2wylg3uhvaiu5pob47i@ea3rnxqrigcx>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <5seajsw64e7mber5yga3ezcnvip3e4o2wylg3uhvaiu5pob47i@ea3rnxqrigcx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0095.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <2d016be2-debc-4815-b87c-f282de408de3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM6PR19MB4026:EE_
X-MS-Office365-Filtering-Correlation-Id: d4833e36-c38b-48c5-464f-08dd6aaaced5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|19110799003|8060799006|15080799006|7092599003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXM3SGdtZVJ2QW1sdGswbHZIcE1jUDlqdWZUNVdZTUt3WlErRm9vbE54a3lT?=
 =?utf-8?B?TUllN2tlc3psYkxBbHNqUktGSndNQjJRZWxUQndtUjlVU1YxRVVWazhkNUNV?=
 =?utf-8?B?cW5nSnlVcFBFM1hHUGJpQVk4akdpaDJlYVdRaCt3NGtBYXduQ0t3Zk5PeDBr?=
 =?utf-8?B?SXpvbjRmVVVyUkNSMi8xeUcvMDBvUlEydDFGTHdDMTdpVjA5Tk9zdDI2TGtQ?=
 =?utf-8?B?Mkx1aWpabloyd3Y0YW84ck1NM1ZrNlFqOHcwc2xlV2FPaHMwOTB6MXZ6VUM1?=
 =?utf-8?B?aFFyZ0pxK3g3ekFESlJyNXUxWXlFRExaYjVncEs1Z1c1NHJUWHVQdFpxSjlV?=
 =?utf-8?B?NzRDNmVxakdSVzdrSkw4TlBvaG0wQm1QT0VCZGNxQlplbTVaWm9kVURmQzB5?=
 =?utf-8?B?ejVyVitHbHVXRlVHVkZDMExrbTVBNnFXZjQ2dXpyRE1FLzBEdWZEUFh0eEww?=
 =?utf-8?B?dnFGc2dZVE9GNGFKMDhDWVRXWnMxb3ZMc1cvcXRLeFlsTjY0S2FBVDJOWUVi?=
 =?utf-8?B?UnZsd0cvdDdialU1ODRUT3NtcjdMNWVCamlVcmZmUVRqa2pJV0M5VkduVFgx?=
 =?utf-8?B?TUhvSFBGRk54RWMvWTNuL2VaNTJpNllteDN2RHVkZ0xXMXJtcU16YjJ6aTA1?=
 =?utf-8?B?eVlKOGg3R3pxRk5CL2dZeGptTW9La1RmcVZYWDZRV2FpTUpZaEdmV0pNa0Vm?=
 =?utf-8?B?TmdSSGZCNitudkE4MUxtdGRVeFJoejVrR0IrNUlnV0I0bThwQWJpZXNIMloz?=
 =?utf-8?B?T1dDVWF2aVNwSTBnS0d6TlBDYUszUUwyb3BwL3VHOG1JNUNIK1liRTJ6djRJ?=
 =?utf-8?B?Wks2Y2UrbUExcnNJcXcxUEwrM3pCc05jTFFpa0tURk5BTzJHdGYvZGtnRnBH?=
 =?utf-8?B?QnlMUHdwL1BIOUYwQkc3UjB3TEVjbU9IcHErRXA1VXpxbGpqcEJUVlZiM3Ba?=
 =?utf-8?B?RDk2VUZ3d1FRWnlaNmw0ZHhLenRxdnhSV1NhRVR0S2krTUxPdkVTOGVtUFVE?=
 =?utf-8?B?b0p3NG5ZQXFacFMwOEFSSGxXUU5nSGthV2twVVBtZ0ZmSmxtVHJmN1lITmxD?=
 =?utf-8?B?amhrbHZTYlNPUzBLVjkxU2lkWFlhSW4xN2dtUFhndHNaVEd3TThWaUlhZVV3?=
 =?utf-8?B?NlZ1TE1XQnQvNmw1OTZaU0plb0NVbHdIQUhMM3FpVFJuKzdsV3VOZHUwK3p3?=
 =?utf-8?B?N3NJUm1ZbnM0dUlaZUorajZySGRMeHJuY0RlU0tUczFiOUN5QnNGVUg5VFRI?=
 =?utf-8?B?K01DTGp1SlpUaDlMcUtxeEtoblV0cngrWXhFakdYTzhRMlNaSUdqd3NkQkp4?=
 =?utf-8?B?K1JHQnU5b0tMYWtLcmlKTVlFSHhtYjdxUCswYUxncndBVnlFOWk1Ky85WFBn?=
 =?utf-8?B?NFlrTDB1MFNLOTkxejNkdkpPOHg2azN4Sy85SDg0YWNNaExtZEFkdTJPZ2xJ?=
 =?utf-8?B?d0lUZVBLMGdZaGhCSVJWQWZsdmE5SFloZDFZQUwxSjJVNXBVNzZUcmhibGVu?=
 =?utf-8?B?WnB3T29ueHNJYmRYWW5Wem5jamtKdFF6cjZZQm0rejRtdHJ3ckJCZld3UXdZ?=
 =?utf-8?B?ZXRadz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWg4OGJNQXY5Y0tnLzFqVnJpbWdFM2trczNuUHJXRHplenZzTG55MFBveng5?=
 =?utf-8?B?SmdpYU5jelp1UTdhcGVjRlhyOVcwdUN2dWNGVHR6RFFwTmEzeStES1BvTUs1?=
 =?utf-8?B?c1FhMXYxY2ZDOE5UY2tzN1ZRV0pRTHZJd3ZuTW5ZMy9GYVg0TDFGU1p1K1RR?=
 =?utf-8?B?WFhVbFRwQ3VwTTZ1dEpYWmE1Y01EUjI2dDRzbTRNdTYyN1A1WVBYaTdGSmk1?=
 =?utf-8?B?UzRSLzZvWWtkY3pvSk8rMzlLVVRJdDNiRnA1Yld4UEFNWm1RbDl1VCtMQWNt?=
 =?utf-8?B?azh2NkRwUzFWTVk5M01DdmxVcGRXS0JiTTVVYUQxeVRYWlU1T1pSWk1mWCs1?=
 =?utf-8?B?UEJkZzYvQkFyc0NyM2h0KzA3YzJMRGEvUXAzVnhTTFpteDZwejNoMUsvZzBC?=
 =?utf-8?B?TjNzUU9ncjdQTjlONnpyYUFBU1NmUkNYa3ZiMFd5K0xJbUJ1QlFESGJOQ0sx?=
 =?utf-8?B?R2p1Z3kzWE1ldTR2OVhqd3hhM1VwRE5TaUMrc0tvZ3BQbzdNZWlQbHAxbVI0?=
 =?utf-8?B?eHdIaGM0cmI4ZWFVdmZHaDVuNnNZaWFmZVIzS1NvTE9TRGFaNEZUNzVTRm9Z?=
 =?utf-8?B?SXl2OFVTVGd2MjVDMnRzUHZqL0tvaWZWSE1GRFZ2M0lPMFZlV3c3aXl4ZlNL?=
 =?utf-8?B?dnYyblgvS3B5WWk2Z3FJTXBhdEpNUUtWUXJSNDFOcW9tUis0NUE4amZ6T3BY?=
 =?utf-8?B?VFJuOHk2ZnZ6eHA4ZU10eWVsVllDU1hoQm05UzZaekdHTkdkRmZTZlZTVjVr?=
 =?utf-8?B?cW9DamxBeUNoK1dYVkgzRFM3WUdCYzJ0Vnpva1VHaGFxRjluWDliY1RSZHFS?=
 =?utf-8?B?dzlYbnp6WUV1elg3UlRoaVZsVmxjVEFHUE8zTlVPUzJYdlROWnNNdnU4cHJ3?=
 =?utf-8?B?NnJqT0VCRlVEZkY5SVNOMFk5MFZxa0JHUWR2SDlRbkVxcm1OUUZFcmhuZ2s2?=
 =?utf-8?B?ajVDOW9uTkN2aGdBRWZ2bGswRWlPQjJyTkNEK1dnMXNxRldXUDZ3enAzdWFW?=
 =?utf-8?B?ZjRFZmtQVmdsWDB0VGlhZHVkVjc1NHhWY09zMkpLVXZFSUc4c1lDelZiMXEz?=
 =?utf-8?B?MDVGZUwweWI2NUtkMDBKZ204Vi9JTTJ3Y1JyWExOTk9ZUHN4MjNNVWxONUdL?=
 =?utf-8?B?c3NVYmcydjFabjNxY1lUSjVXMzZGRmthVnAxUVJYK2pkUjdhUHNRa3pRTmtk?=
 =?utf-8?B?MmxDazNEODFoUWUrY3QyTGRGMk95RzhOOUEzUGZvMktETHBGMW9ENnZ1b0Yx?=
 =?utf-8?B?M0x2NVAvQTNGZ2hIbUtia0kvQVBsUHFMVlFIVHBEdk1hVDJYRDEyYUJyanlT?=
 =?utf-8?B?MnVraFdocWhxSWlGVUcxdWJ6NGczdlNoemJEcWduY0wvc25qMXdsTU9ZdUcz?=
 =?utf-8?B?THM4N0NQMnlvdDdzeG42YUovQS84VldYRXZQNjZRNlV3YWE5T1A3c0lXaFdt?=
 =?utf-8?B?VUJWUzVoNDJxUG5uV3hrVENkUDN3V0MvblNyWjFTU1Fpd2duanVNSnJGWTVD?=
 =?utf-8?B?Nlo4bnFrR0pHWVFDZThWQmc5RHo5bXFrUnhUZUk2aVh3TDlVQVN1OEF3aFFi?=
 =?utf-8?B?dFlnSHFvREs5N3B5T3dRd0IyWnpueW5GSnlzQWVSU2c2UjNtcTJzT1VWVjVw?=
 =?utf-8?B?RmUvbEVDZTRiRnB1V2pMRXFvY09EZjFpUllMMWZpS2NLZ3lQRXg5VFFzZlRk?=
 =?utf-8?Q?2HBCtEP+zlteMV+JGjM2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4833e36-c38b-48c5-464f-08dd6aaaced5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:06:41.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4026



On 3/21/25 18:13, Dmitry Baryshkov wrote:
> On Fri, Mar 21, 2025 at 04:14:44PM +0400, George Moussalem via B4 Relay wrote:
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> Enable the PCIe controller and PHY nodes for RDP 432-c2.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts | 40 ++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> Minor question below.
> 
>> +
>> +&pcie0_phy {
>> +	status = "okay";
> 
> If you have schematics, are you sure that there are no supplies for the
> PCIe PHY / PCIe PLLs on this board?

I don't have the schematics, but none of the boards I've personally 
tested (mostly Linksys devices) require any supply. I've also checked 
the downstream board files documented on codelinaro for ipq5018, and 
none mention a supply.

> 
>> +};
>> +
>>   &sdhc_1 {
>>   	pinctrl-0 = <&sdc_default_state>;
>>   	pinctrl-names = "default";
> 

Best regards,
George

