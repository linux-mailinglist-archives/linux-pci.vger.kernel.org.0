Return-Path: <linux-pci+bounces-31325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BABAF6749
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 03:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D71C42AF1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB93FE7;
	Thu,  3 Jul 2025 01:47:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023114.outbound.protection.outlook.com [40.107.44.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B54A00;
	Thu,  3 Jul 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507277; cv=fail; b=XnGsALMqBVPDFoS/DkCN/H8KCjbTsoFeAKA4h66eAOtW4i3rGbbWVtsMhpv4FvTqIQpIF4GF1C7XO4/nnTXXmPXyfeNt3YHz0VcAWvgsI6LagR9coDR4dFdqqvbttng5uSr1BAKC6n/i/R9+8aZgzquZT4QQV8HlzzvEQiQ64fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507277; c=relaxed/simple;
	bh=G5I6G7WB3LosTMxc0w8cH83uvgxZiqXlnmFXEYfGFd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbi+pr5TLNABfzOXbrlnTi5oMLHYTcuabhT/StFEq+QJgzAmpdTno0/mNngEVenlW0XJDlJDfiGBzokWl4j/nt+pLS1js7bUi80/Q1vX045sTAUnSfANeISqAoywP0n69IuaYk7n16hDPmfhZRI57YKzxp3J6wyRUDhb+ip5dWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weKYYiFYH7jQkw08SU3Up45+ZOqRAeQV0k8ZgI1XnUDe9vTNbVFMmw3PhDYlml9bloAK0s5y9c2IsBor1VOt6djmQBsOzn9Sksz1dmg0a+/7GrNt8/OSKOQb6AcniBenI0RR/dKmN2eZyd2/3JvDqODMpEUPTB0EMbh+t13Ml8sDgHEbyq31B27Fxy77mA5fsTbGiKtjg8zdGNwfyw+khPkpOihL7APidnL4eli7jns90zoOzFTErtiHhuNwxpa3H65YC4UtYqcl8ES609iASoeuuKTBv98QFaUkUUrGjIV28WGHZQSSYRC14jPgII6k+m2KX0lX78QIcpdl2XdeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtAxDENErq4rut6mf3iHFwy7zP0d9gUwd7mbl7gQiMA=;
 b=TFAnmUyh2dKDe7/UdDtn9dYIMfwgKusaWPAGlhfAsZWwfe/CJuaB8ME06fDdzy8WfTEtdNoHrMS5uKOfA4xR6t3rFgKlZTukX2m6L4XOYan6e4BS/9C9ciy1Xu4JpA8iFPFmJ5Pz7aYtthDsXX1mIB5nnohqtnhm0hFMnq+5q3zpRtD1BGS6NKSf8NoMBnjHFquDM60+WFuRq+cuZBCSVC9LINfnYiCpct5ZMr3UJLOAMQBWwOJub2EWW7eNiwXNOr752kpC0leM+50J5OAacfnYOXCmv3FNLsCF6fsONPIQr9R3FDXNwRmZO/kWxU/tgEaon0Uwj7X3V9rJIs3h4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) by
 TYPPR06MB8036.apcprd06.prod.outlook.com (2603:1096:405:313::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Thu, 3 Jul 2025 01:47:50 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:29) by SG2P153CA0015.outlook.office365.com
 (2603:1096::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.12 via Frontend Transport; Thu,
 3 Jul 2025 01:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Thu, 3 Jul 2025 01:47:49 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8B84844C3CB6;
	Thu,  3 Jul 2025 09:47:48 +0800 (CST)
Message-ID: <50592fad-850c-4dab-92d8-a71cb89daf58@cixtech.com>
Date: Thu, 3 Jul 2025 09:47:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
 <20250630-graceful-horse-of-science-eecc53@krzk-bin>
 <bb4889ca-ec99-4677-9ddc-28905b6fcc14@cixtech.com>
 <5b182268-d64c-424c-9ada-0c3f120d2817@kernel.org>
 <2b608302-c4a6-404d-9cc5-d1ab9a6712bd@cixtech.com>
 <a7aac65e-848b-4bb3-bd52-963766410698@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <a7aac65e-848b-4bb3-bd52-963766410698@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|TYPPR06MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c819b7-9233-4a72-1f9d-08ddb9d39dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZktENzB2RHB6cHVsZFdrMjJOT05xNU8yeC9UU1RPQzVLMUxlN2NwckhWc1pw?=
 =?utf-8?B?QXBMb0FFTzE3NlpKaHhxMURlTjQ5NUs4cWdlclRpVGN3NW5nNFdzekFNVExH?=
 =?utf-8?B?ckVRRkRTN0Zva1BHUTNUbTJwSS9FN2lpQnRrMXhOOFZmS2R0Sk04VkVoaGxq?=
 =?utf-8?B?S0hhUXZEcmJFVEZDUC94SG1aTzdBN3MyMDQ5NFU4QzU5cmlwQ0JReVEvUnpj?=
 =?utf-8?B?NjYvZGxTdncrWnEyWjNGRnFacVZYTnRpY0JGWEJDSnpDQ3RTbnlvc25FMFp6?=
 =?utf-8?B?NGc3T3UzZzUrRERyNUhDdFE3STJpT2dSTnFWeGZQaHlEeFpSa2dKQk16Yzk1?=
 =?utf-8?B?WUowcGVZc09uTGlHU1BIL0pGZk95bEpWSkNZSFV2KzF3T2dUQllDQWdzWGpM?=
 =?utf-8?B?anh3SDVHRmZpRnkySUxqeHdzK3F3VllVRjVmV2tPMnJGa3dhUzJwZnNjWjlx?=
 =?utf-8?B?SXdUMXVDUjhBWHl5eHRqTVJkN1RicURaQXcvTDdlN25wRHdpdDhURGRlaWJ4?=
 =?utf-8?B?dUZSUThmUFhKd3pkSWk5VTQwYmpPSVRRSXJZNVBybGxDYVlCc2tEWFU4T0dL?=
 =?utf-8?B?TGVPc3VjRDhZNE9EcW4wcXRPeGtVYTBTMTZtYlJpc0FVSkdNdWpSSENuZlE2?=
 =?utf-8?B?emRRSnVPbFN1QXNOMCsveS90M1lFWTFlSlBQcmdyMTBreGxMUjVQWmxTTlZV?=
 =?utf-8?B?eXU0UmhYTzlSQmowODhuUC9DdzJUNGtCZjhHVWlkZGp4bUVPbWd0QW1pVUsw?=
 =?utf-8?B?bmorcHZIWVhYWTVJeVNzYldnaWZwYnYzbzg0V3dta3g0SS9yeVlLVHlWMFRH?=
 =?utf-8?B?Z0VoQkQxTkV1TmhOcHFHTEZicmdUWmRJTmFXb2gxeEx0ZlFOVGVwMjc4RkhB?=
 =?utf-8?B?UThzSHdXMlI1MDVLR2ZUSzEra3RIVnhEaFBaSnZDTnVsNlVtNkJZNXpyLytZ?=
 =?utf-8?B?Mm1XRG9NZndhTmF3cERDWGNiZGVka2lIcm9jTVR3MHpxMjV6K0pxYVlQa2ta?=
 =?utf-8?B?dWl5ZllpZ0RWeXpMS25lNjUzK2swTEYra2ZkN3IzMEd1d2paV0hCL3ZhVzVG?=
 =?utf-8?B?MFdJZW1iSE45MlRSYmFiZnVQSWhnaHpTWmZISjY2dFEvSTR3cHpUdTBLVkZG?=
 =?utf-8?B?SHBZL0kwT3RYbXFCaEhiNG81VzZ1TU05c2E5SEEvM2grUFpYNXUzQzJlTmhp?=
 =?utf-8?B?bVlXZU4ycWYyZjBzNzhnL05aams3S0hqbzRaLzMzLy9NeENpeC9FNmlOckpT?=
 =?utf-8?B?QnJZMXdzSnpoLzFpUmoyLzEvNFdFcGxseG9CLy9NS2t3aUFkQkxCbkgxNm9P?=
 =?utf-8?B?bHJWd2ZGSnFRb0t2NzNnbnZqM2U5U3hwYmVaUzlFQ1BPMjVpQ0ttcURsaXo3?=
 =?utf-8?B?QWhKSmU3RVFOdnp0dGtOQTNranNpZHNaUFdvRzBhZG9JT25WZEdOWGZGYkpQ?=
 =?utf-8?B?MnBZM1J2ZGlqbWdFaVNqekQ0OGdVV3JGSjBCWm5wYmZDN1oyd29mZE83dXlQ?=
 =?utf-8?B?MjNkN05JdjFlamV1b01JeDZzZlRWV1hMVDI2a0M1OEcwWWFzWGtJa1VVZlBt?=
 =?utf-8?B?TWF4QjU5QXJYd2ZIMzRNaUpWdUNtdnlFV0NpbUtWSStCVmFqQjRmZFJuTkl6?=
 =?utf-8?B?V3cxcDdOUWRQYkNIaldBcW9Jd2U0M3FxdmgvaWY2SlFuUS8xYUNqN1NodGVC?=
 =?utf-8?B?bW9YN3l5a1ZYZXVXNUNDRUNYbjV6THlhV211TE13cVlVbUVES2lOUWwzaUZt?=
 =?utf-8?B?VDZNMjZ2Mzc2ZUtueEpMYURiNXRtazJuMXRWTXhmTElZUmhQVytSVnpDc2pY?=
 =?utf-8?B?bVNLdGFicEY0ZVQ2eE9WazZVcTJzc256ak9HTGg4ZEdETEJ5MUZSMHJnWWJL?=
 =?utf-8?B?Q2FPMWFhREZZclkvZEFOTXdqWks0RjEvL2tPVm5ZTFQ5NVNYSFpOUllYNlJ6?=
 =?utf-8?B?ODZNelBnSVBCQ3ZuNkpseVRoN3lxNTZ0bWlVVkNmRHpYdStscTBvVFBDdU4v?=
 =?utf-8?B?N25ocWV0b3FSTXhzdXY5YTdIS2pQYXNIY24yYTVNRnJEMFZXd2JINmo3Qm5q?=
 =?utf-8?Q?0ZVIk3?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 01:47:49.0763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c819b7-9233-4a72-1f9d-08ddb9d39dc1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8036



On 2025/7/3 04:23, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 30/06/2025 17:30, Hans Zhang wrote:
>>
>>
>> On 2025/6/30 19:14, Krzysztof Kozlowski wrote:
>>> EXTERNAL EMAIL
>>>
>>> On 30/06/2025 10:29, Hans Zhang wrote:
>>>>>> +
>>>>>> +  num-lanes:
>>>>>> +    maximum: 8
>>>>>> +
>>>>>> +  ranges:
>>>>>> +    maxItems: 3
>>>>>> +
>>>>>> +  msi-map:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  vendor-id:
>>>>>> +    const: 0x1f6c
>>>>>
>>>>> Why? This is implied by compatible.
>>>>
>>>> Because when we designed the SOC RTL, it was not set to the vendor id
>>>> and device id of our company. We are members of PCI-SIG. So we need to
>>>> set the vendor id and device id in the Root Port driver. Otherwise, the
>>>> output of lspci will be displayed incorrectly.
>>>
>>> Please read carefully. Previous discussions were also pointlessly
>>> ping-ponging on irrelevant arguments. Did I suggest you do not have to
>>> set it in root port driver? No. If this is const here, this is implied
>>> by compatible and completely redundant, because your driver knows this
>>> value already. It already has all the information to deduce this value
>>> from the compatible.
>>>
>>>
>> Dear Krzysztof,
>>
>> Thank you very much for your reply.
>>
>> These two attributes are also in the following document. Is this place
>> out of date?
>> Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> 
> I would need to spend time to investigate that and I choose to do other
> things instead. I am recently very grumpy on arguments "I found this
> somewhere else". I found bugs somewhere else, so am I okay to introduce
> them?
> 

Dear Krzysztof,

Thank you very much for your reply.

No, no, no.  You misunderstood me.  I didn't mean to say this because we 
don't study dt-binding doc every day.  So we can only refer to the 
practices of other SOC manufacturers.  If it's incorrect, we will 
definitely listen to your opinion.  Here, I'm just explaining the origin 
of what I did.

Anyway, I have solved this problem by following your method and using 
compatible.

>>
>>
>> We initially used the logic of Cadence common driver as follows:
>> drivers/pci/controller/cadence/pcie-cadence-host.c
>> of_property_read_u32(np, "vendor-id", &rc->vendor_id);
>>
>> of_property_read_u32(np, "device-id", &rc->device_id);
>>
>> So, can the code in Cadence be deleted?
> 
> Don't know. If this is ABI, then not.
> 

According to my understanding, this is not ABI.

Best regards,
Hans

> 
> Best regards,
> Krzysztof

