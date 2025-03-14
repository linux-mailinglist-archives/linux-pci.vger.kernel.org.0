Return-Path: <linux-pci+bounces-23724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A01BA60C31
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02F8460BF3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E31DD866;
	Fri, 14 Mar 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TnAsQZaY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2037.outbound.protection.outlook.com [40.92.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1D1DB34C;
	Fri, 14 Mar 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942251; cv=fail; b=dCAPthM5/L7/n9kG8T+WXteF4Ah4DDJfxMopoBr91AHvAed9kpw0zoRt5uOClI0pS20wzesWHxpXmqhvmeRAvWuP73buk1m0bDSLm6d4N8i/eFSTftGSbU7GgihkrMNqhhC0zdpX4uvvOfqBGeh5VJurRllfsmsWaMsFkVLrEmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942251; c=relaxed/simple;
	bh=O7pNYV/U/eF91cX2mUjXGtWl0ZSZGYnfP+HGr8whY2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwv+LXbVcqLEERp1OloOG72HWJYg2Y7TXs5HfQPU7MBMyINd9WDT2Nf9oAWWerycQ3Z+hZusl7vVzl2R+B6Zaq2GQ8RIhgW+bibA6xc0uNOxp0wjqDSfw6jhuWdP65sAV+SS3UeQR9yq0HpoOm8b1oI5sFM5DUir9pQeUk6Wjdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TnAsQZaY; arc=fail smtp.client-ip=40.92.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mU9k6mXYxQkwpOXADfww22UfXFgYiOqBTNHsKK1U5cx3LDSIg7tDamKct2kRbo5EWRNv579h/8+oNdn1e0PEvp2j/TjgJHEgObl3kvL8YyZ3IzubM66I3Mra6lR0dbaN3tXqkHtRfeomrJwcS5DmhT4320OIzTmNoFGMTJBesjENsUCjtUmqQsAhw6e4p9SllqX+l4p/LuZE8x699M2DBHf2TK07Wsbs1D72HxH9PUfFnopb0C/KgAHjx90Gsxu9vIZwsBTfuCromCHhCkPUkGdLdbgJsFBzjsKAoboo/vdKHnRJpaZXBsBTfk4QlKSXZ1SCvZ3Mnx4ohSKM7Da8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqA6KTG5++1i5hOPG6cVtDA6TUW6/WmYhknNItV1Y/A=;
 b=otQvtFHP14dbZJyvhoMV++6kuFxbuMad0oMSQQ0OYu86Zs8EfVv7iZp1p6HubA+mENrsAY9rY/506+j5u9NyJtQqFNxvkLIeYO15ozTLh8Ohh0PUkrVY0BNWh4E3d0KKWXlimqeHT7Ejcndnj4X+Ecx40AT0kL72kAQb+JDDnlH8tnQSCsfMflFFE5aq1zv6UfsXCMz8v1rpIJOQ9L5jw3JHMDvKsKthxzxLi0KcpDs7utgHKd4sZGv0w9p+zGZdN7USVWcIeMsrTChgwdlFFRwp0Xg9LJiYvA54srM67hBrqFrHgTic7YpZh3xkPWPqGLyQdfG65G0KXnp00brghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqA6KTG5++1i5hOPG6cVtDA6TUW6/WmYhknNItV1Y/A=;
 b=TnAsQZaY2WPL71nphhY/GJgZJpF2/6Mkh2vOX2l6QQv004ByO1/h+TwPE6giaYsQyfsb1FtWKTeUsJygAs3S7NdfxiQ4NO7rZBRRJS9qvU+NvlePlC7cf3YVKl+ZWKoEp+yAUGhYNCK2mfAsnTuzV6dETNgbgkqRl9g4ZI3S5zAinw+Bgel3/eBuXS9mtQXJqXAXQch+gvlkK7x71xIaP5b4z+1ShozYOJagFS33QuGuy9a9EasVyUtdM8Eyy2VydAZQNBxP44DMk4c9R33ItaBXt72jaXirnBkEE0evyYJR8K9R5TnyqsDf2L+zVW9L4yOixEGj7t+sINjuEAnq7g==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by PH0PR19MB7602.namprd19.prod.outlook.com (2603:10b6:510:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 08:50:45 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 08:50:45 +0000
Message-ID:
 <DS7PR19MB8883946B587724F649CA55309DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 14 Mar 2025 12:50:33 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
 andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, lumag@kernel.org, kishon@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org,
 robimarko@gmail.com, vkoul@kernel.org, quic_srichara@quicinc.com
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
 <DS7PR19MB888366F3BFE6262375217FA69DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314-perfect-free-oarfish-b153be@krzk-bin>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20250314-perfect-free-oarfish-b153be@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0031.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::9) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <124a77c5-b4ff-445d-baff-639abd969700@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|PH0PR19MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 6695b8b1-51ec-4ea8-1ed3-08dd62d54eb9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|19110799003|461199028|8060799006|5072599009|6090799003|1602099012|3412199025|440099028|10035399004|4302099013|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkZhNGtJZyt0REZ2NE5EY0JQeG81SmFKQmw0U1R5bXdIcFJsaGtwcm9rVUJW?=
 =?utf-8?B?d0RhZkx4REZvM0JkZ2FtMCsxQWt1TWtSUW1pVThMRzJvclRrODJEY0JTQkor?=
 =?utf-8?B?QmowL2xBQlc0YmpZYUMzb1lJWVhublEwUXhxTTh4ank0bGg0Y3pIUUxpclJ3?=
 =?utf-8?B?bGxrU0RBRjJOSmhjR29aVjMxRkpTeDBVUG0yRnhMdTkvUnpybDFSc1JaWTZR?=
 =?utf-8?B?UVRjZGM5WTRuUU5Odk5mSXhJSTN0dFg3Sjk1OGVBTm1ZcHRSSzVFR3VWbXhF?=
 =?utf-8?B?SGVFWnVGbThJeGMwV2Z0OGVabHdXbnNUZmw3QlYyMVd4TDR3YUQwbWtkVk0r?=
 =?utf-8?B?R3pFQXFCRDFaajhtKzlxWDM5QWZ6L3d2VnJDYkErUG1Ia2UyRm5QNTZXMVdQ?=
 =?utf-8?B?QjhlQ202V0lCakhyOWtvczlpT2ZYTTRjcXBCK3VuODdVRFh3RnZGOEVGR3BI?=
 =?utf-8?B?YzljUTRjQmJrQjVvM2Yyb2s2R3VzSytUdGFKZ2VtS2VaMFIvVWl2SlNxb01G?=
 =?utf-8?B?eit2T3BnY09xT1ZxdGJLOFRLTlFHWmN1SUlsRGdRMTNXeDVHZm1mUUdLL25R?=
 =?utf-8?B?UkprSWNyNVZqQ2swR3RZUnBoQnIwdlgvSEE4UHk0MTF2RWc1SmNHNTdTQzl1?=
 =?utf-8?B?MHRrS2F2UDhKVWw5RHpzaWhZcTlPVXlxZFFXUXFFUmVrbjFSWG16NHN1WlFE?=
 =?utf-8?B?R3o3dFZmZVd3eTZOcXB0bDllSkhPbytLa1ZiZFU0Zzg2bFFhK2hLSjU2cGhp?=
 =?utf-8?B?bThBM3lCbDFoN3RpdTgvdTV3TDhvSXlzUU5zNTNXQlQ4WHFXYzZGbUlyUktY?=
 =?utf-8?B?ZXNvMlF6N3BrdGRhbkJnc1JITTdIRlByQTBScXZKazk2OTcwT2pMVEJkakZl?=
 =?utf-8?B?TS81N3VnK1NkUVZkRkFJWkYvYkFlNThmOVg5NjB4RFpoblRjNjd2QzhFVmdE?=
 =?utf-8?B?cXN5RWtMb3p6VFRUdStHR3Ruc2poTDdPOEVOVjhMOGkrVmZ6MjF1a1J2U2R2?=
 =?utf-8?B?VUFDejFMd2JIMFgrZk9LVERORXJZQ1kySFBBN2Frb1c1QmFSaEZ2emVoVStk?=
 =?utf-8?B?MTNHMGZHS2hLRDBrMG1iTTlOUGcvRG5kNW5qTXlIVU1hb1hROXBDRXRoUkMy?=
 =?utf-8?B?NitQYkNJdnN2KzVwVUIzZFFJakN1MENPWnE0WldxRTAvbjlBWlJQN1BIaXdk?=
 =?utf-8?B?b2E5bGNGS1pCZENrUEJRRFZsVHZhOVNsaGdTUUlLbnZpTUROd2o4Mml0U2do?=
 =?utf-8?B?MEo4RWdBT21CNUwySWJtV254emQ1UEsyNGl2N3VkMnZJRG1QdWFXSkhIL0ph?=
 =?utf-8?B?T0RGNklrK3dPNUh2T3k2Q2ZtTWlTeWxidVpzeml1allHbzRZTVNCQXhnbDFX?=
 =?utf-8?B?QXdoQ3h2SUtZQzgzY3FGVnpKM1dkOEdqM3hHRktjVTh2aTU5eVp1K3hNQlFU?=
 =?utf-8?B?TGhxL3NXeXlRcnNyekxiZVYzdjNBSEhRL0NPc0NUTXBhcmFTeG9oWmF6RHNS?=
 =?utf-8?B?OEI4UWp3MTFuY1B6S1ZncEp2RFBIQ3BHRFZlODdKUUdlVGY3UFpoU2ZKa1Ux?=
 =?utf-8?B?OEdLdVFQdUhGb08reGY0djdFVFU3aHVDWndMU3ZOTndnV1ZHaUJBKzNHRXpL?=
 =?utf-8?B?ZnVZSlVkblcwQXNScktXQnFyWWx4TVVma2YyY1lwaENnZi9MSE9jeUJUTUpB?=
 =?utf-8?B?UThiKzZRYkY4TFZncCtlNmhtT3d4U0hwOGJ4dDN0R2YwdFlSZDF5SUg2RHFT?=
 =?utf-8?Q?AgfkIUy3LW5AsSBF/I=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDZySUd4VGNvMUlRam5vdHZiT3FGRzNrSDhRUlFUZEMrdWsyRVBmdlE2UGhL?=
 =?utf-8?B?KzFITlc1MjRTUVVHeWR0TFMrNkVGbnM3VUtUR1p5aHlmYUJBeXRDNWFpUFdl?=
 =?utf-8?B?ZnE2MFdoVkd0SnlpSnAzYk5XczhTZkpOZmZ0T3ZmeGJjVUhQV1ZIbHh3QjZr?=
 =?utf-8?B?SGlLdm5vc0xxV3Izc0praVdUelpSM2kvUkppaDdFMDJnMWxoS3lJOEJ5bnNm?=
 =?utf-8?B?SmU2Mmh4WVVwUDZEMTBJalhHY1hvMk9PcFNUdWw5dHRMQUIrSGJqV1ZtaGdP?=
 =?utf-8?B?OVJydXV5K3JQYzI4SVVQMm1RVXV3andFSXhLUmp1MlhldEl3YWtscHQzam5Q?=
 =?utf-8?B?Z3duMXpBZkt6WFIwamdrV0FZb01vdjF5UFhTUVJ3R2poaGtyQXBDeTJQTFli?=
 =?utf-8?B?V3BvNjZtK1lZaThxd1k2RHhDaFpjTDQrOHVkaUlpRktEdVhJM284c0g5ZSta?=
 =?utf-8?B?Rk5vSE9BclFGQXFBcSt2bDRXenhqWlJSSCthSHJmSDBsb2RTU0hLVkdxWTB0?=
 =?utf-8?B?Tmp4c2ZobDFvby9UR3hnMnRVZmswejk2RHNzaE9HcitlL0laR0FmNUxGb1Vm?=
 =?utf-8?B?VmNLdzNKT3V4cFdTc3NmdlNMUTUvKzA1bm4xallWT3V5SkE0V2xQY0FhZ296?=
 =?utf-8?B?WFRrYy8xekd1ZTlkK3FMc2pZMDZiL2RWSjdQNmdXOGszK1k2azdkWUJHRGFa?=
 =?utf-8?B?SU11MEl3dUpTdWRsVlhYK3VobkZEMGNvLzVPZUpKeWZRTTNzb0ZRcXRCbG5t?=
 =?utf-8?B?SFZRbW5IMkpIZUh0a1Uwc0h3TUlNN2lSNENXaGdyMTFQaVZjVHZxODdEK29i?=
 =?utf-8?B?eHd2bjlSdThlUzVxZ1Q4enJrY2l5aWgzTldRaFdwbFRCaVlPZUNyT25DcC9h?=
 =?utf-8?B?QVBGTThLY0JoaUNKSy9ZaTZteG5oWWtUSFdSc3pXUzh3SjU5QldYT1JWRTBq?=
 =?utf-8?B?QzJDOXIzSHJNeEdwdEtEbkpXTHVEZVROUlFRc1lyWFdZTG0rQ2NTMURveEVG?=
 =?utf-8?B?NTNwdU1LaTNnTXR1Q2xkd0dyNENtQmljbkxLR2NoTDdpaWhNVzdXNHZMRXFW?=
 =?utf-8?B?WE1PMXN1ZkwzR2theVNzK21XNURzaGQrL0NkVXNVMDRHT0RqVkFZYjNzUm80?=
 =?utf-8?B?dEppSWNxNlNNQ2k5b2dJbXpHbjV2NEJzUGkya0pwR3pjc0dhbC9yWUYrM0hH?=
 =?utf-8?B?VHVPWjNXenFHcmRRQVdUckxPeENaN3NndUlXcFFyMnQ1SjFpOVZSMUM0bWxO?=
 =?utf-8?B?anpaNDdpSUhsVTd3SlVmZFRqRkJSaVRWVldEaFhnNE1SeDJ4aTRlaHdLSW1J?=
 =?utf-8?B?bGhVRnFjcXpDNDk5N1JCeU82dFN1T05Fc0ZGU0tVUm1SWkR3WmdUWTd6WXlY?=
 =?utf-8?B?alVMbWZvZEYyOEdBdEJySzJURGdqb1ZjT2l3NXZpcnZ4bFgvUWd1TnZINmk0?=
 =?utf-8?B?VC83a0xQTHVsb3RQZlpmZTJhMFVHZTgzcXFTK3VwaEdpZmJ5dHdZdURka203?=
 =?utf-8?B?dTdDcmUzbXl2QTV3QjNCdDVVQ2hUQWFQRHVWSDBZY3N0MkpJNFBvenArRTVm?=
 =?utf-8?B?dlB4TEdqcW5EQURydllJQnBEOFBMWTFGL3ZRQndWZys5NitLVFhwbkxKc2M1?=
 =?utf-8?B?QkRVZHNUU1FTdDIzRWRRVklIcWhTTVhoNW5EbU9hT1NmQW1YTlQ1dUgwVEJy?=
 =?utf-8?Q?rVqQXVZrqbVdnNDc4YAY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6695b8b1-51ec-4ea8-1ed3-08dd62d54eb9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:50:44.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7602



On 3/14/25 12:23, Krzysztof Kozlowski wrote:
> On Fri, Mar 14, 2025 at 09:56:43AM +0400, George Moussalem wrote:
>> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
>> +
>> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> 
> Was this tested?
> 
> Anyway, your patchset cannot be even applied due to broken threading.
> 
> We keep pointing to issues in your toolset since more than a week.
> Sending is so trivial that I do not understand why you keep it having
> broken:
> 
> `b4 send`
> or
> `git format-patch -v4 --cover-letter -6 && git send-email ./v4-*`
> 
> NAK

Not disagreeing, but I'm not sure why it still breaks.

The git send-email command is exactly what I used before but I found out 
it's not an issue in the toolset itself. Outlook.com SMTP servers 
replace the original 'Message-ID' header with their own. That is what 
causes threading to break. As a workaround, I first send the cover 
letter, lookup the Message-ID value and then send the actual patches 
using 'git send-email --in-reply-to=<Message-ID>'. I do see them 
threaded in my mail client (Thunderbird) and in:
https://lore.kernel.org/all/DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com/#r

If this doesn't work, I may need to switch to a different email address.

> 
> Best regards,
> Krzysztof
> 

Best regards,
George

