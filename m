Return-Path: <linux-pci+bounces-33278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDEB17FDF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 12:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9B4624D14
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9B224882;
	Fri,  1 Aug 2025 10:06:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023078.outbound.protection.outlook.com [40.107.44.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8372E36FF;
	Fri,  1 Aug 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042786; cv=fail; b=QZc+xRDKaVJTv7lA4UpNyZ+H8txtrXDChkNYwILUbijBBmNO3acEXL2rUck3u7/1h/cB9elVbpON1shxCC1ZxB3jw1tOwakCU2pmg0F06Rur+KAcpK4M5TkBLS7uGS2hSkLPl02aG86sUV6bt80k+imEiLWXqIuNDQubH87RZ7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042786; c=relaxed/simple;
	bh=FW+tdn47Ge3VOujWMs72sghoXaW/2BgGMiV96k7VVdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrv5LrAElJ0KEpLuKmgPgBCF8Fr7kN0vfrvXi41xbWN9X3dJAY7hveTb0ELwKhm3W8mJNfhx/ZwX5fT8uN+29SNBZXnokFnR/99FsROiV5SFAT+JIClRbKH49PqEL7tC1RVuFIxTCSaBtcQw3l+qba/m7crMz1aoPIKl56nqN7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caBt7vW4DIUCbV4A8h7ulclpxueh3/DpS1OKdFhnuB2alIq63Dm0bEb7pnpk6qYMLRaXv6XRJ1hH/wlife/IwG0ybcfnt3+C2vQJQ+g9leVblqHCfvrjSF/BnHXDbCJaEJZ1OF5ZjzknZaeXBAAzpTkFJDK7GtOtGHbhTlHiL2zUnAnNmQvXvrfbAkoY+CBa5UVkyBGlRx0pbmxHc2QXTdE862hn/H6xtNknXkwXxM3i0NHIFCYVUmSA6xKfTCXjhC6pGC3rihO3y9sBtLqhs/Dv/19++/B8TXvmHXhLb9o3V8Uhe+EHT+KIKNxTbC8a1Uny9BzHgUfCNvabLF27IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z147ylW9dXEGROALME1xlz5dF0HaGLJFqvDpMnlJyxo=;
 b=WhecXjSM9iTOXp0Ty0XBrfCQQzMmpsjNjUeIX5moyWQrvvtV+9dT6k2W/mEBTadX4ur6HgLqAyxdUSnDOvTISQVXYRFI+DNgGW9HLJMTTt/vHgWEG18rzkJxfHveDHcWA5FtagIVEtoZUvIn6RxYKfKK9EWNHZJmk5LvV8ZHGAoGbZDr8LngDDIRybzp+xhxlN2tLlgBKDVmlmOt8ITwu/WKC5Qjr3GlS4P6y0CeDsFCEzeZtPigfGDyG31CGC6pKS4h5wNhHjfKQQSarY51w26KmEATCtXZBf6v1ucj8GN/5U10bgcnhMlbrl0cceQKM4RIgXtxgwb9agll7qEuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYAPR01CA0155.jpnprd01.prod.outlook.com (2603:1096:404:7e::23)
 by TYSPR06MB7048.apcprd06.prod.outlook.com (2603:1096:400:466::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 10:06:18 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:404:7e:cafe::b8) by TYAPR01CA0155.outlook.office365.com
 (2603:1096:404:7e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 10:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 10:06:17 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9F1F041604E0;
	Fri,  1 Aug 2025 18:06:16 +0800 (CST)
Message-ID: <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
Date: Fri, 1 Aug 2025 18:06:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, Hans Zhang <18255117159@163.com>,
 bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 geert@linux-m68k.org
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|TYSPR06MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b36658a-f7a0-497a-cfb2-08ddd0e30eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3cyU3VBbU1BS2pvTzZnVUVGcnBJVHBSeVo2WnF1ZmdNbkdsYTg2ek14czM0?=
 =?utf-8?B?UUhkbDdhVFplSlNQZXkvNUoyekxPM3l6Y2trcG94S2ROcW80d3lBelUxQ244?=
 =?utf-8?B?eXc2TnBKaER2WjN5NVlhT29qRGFYZS9la05tR2NmWi9QNVlZWDBNSTF1Z1kw?=
 =?utf-8?B?cmlyZHV2c05SaVB2aUgvM0pyVEtGOEdMMzNPYVlwRHoxaWlRbEZkZUZRQXp2?=
 =?utf-8?B?eEo3eTJFYUx2Z0pKNkRjYklPL1JPVFVEUU5NNkR6U0ZNNTRNS29YeE1mSWRK?=
 =?utf-8?B?Mlh0S0hqb2M2UStDWll3dWwwajhMNytrcFAwRDdOMkI3ZXVsWTNtdDFQTEE0?=
 =?utf-8?B?cFhGc0hUczR6YXVxSEkvWUhhbVZGV1lSV01HMXVMblcyZXV4WmlEejUxL3Rh?=
 =?utf-8?B?SllsUHM0aE1qcDYwRGRWZEMwU1BDWitBWGZRN3ZDZ2tMZjdYYkQvZmEvQ2dY?=
 =?utf-8?B?MSthVy9oZTE1WHFXOEk1M2hBQmNhUExBQWdreHJjTDlVR2IzVFlZc2ZDalZO?=
 =?utf-8?B?K2ZoSDh2OFlrQ3AvQ21lU1EvOUZTbldZQ2FMdTJyTCtTYjNPY0VnRUN4Tlo5?=
 =?utf-8?B?NnplcmtjQzU1bFNZT3BLZktHdzBEZVIrb2pGRnd4bUhMOWlMZE9tclBXN1l2?=
 =?utf-8?B?OWduMDBUNFE3SE14cXVUSlVIdTJ1UTVnUDZUOHRRMVZnMFpsQWc2VW9zWUNi?=
 =?utf-8?B?VmF0TWR5a01kTnpyayswdVl4dUlJVW9RVGVqZEFWT1k1cmhsUkdYWmJOakNO?=
 =?utf-8?B?bW9HZFJMMGZKcHVHcTV6V09ETXNFTG5mbzdOZWJ4cm93dlRRYnhJZllRVnNT?=
 =?utf-8?B?YmN5WExPL21NeGlOeEtFcE5VeWJzTXhmVG1yaTh0UEVveElNUG9zOE5TRG5I?=
 =?utf-8?B?RkRKM0J6WUM2VXluSG1rRG85TzgrMFJqdDc0d3ZETi9tN2ZUeXJLaHVmYlJG?=
 =?utf-8?B?ZTZsTkI4QkpySVdxeDBidXZ1ajVNVHNYMmxiRU5OSFlIaHFtbi9hWkY5Qm93?=
 =?utf-8?B?N1FiSlQweWNRTEhqNzVRWVZpL29abEx2anBSNllXOVZQSjVvRW9TTEJqU2hZ?=
 =?utf-8?B?TDNFK1NobWVEUElXbzR3eUhmZVIxdEVUUE1SUU9JVXorTFBJWE1NdjRVdGdh?=
 =?utf-8?B?WGJQL3p3QkhyangrSldBYm9oSzVLU1dvWWFhdVVxcTVVV1crY3ZEVUVlSXhj?=
 =?utf-8?B?d0NWRkJtUEJpQ0ptTTNCRWIwZ3FyUUg3UjFJMFhGMzc1SDRCRTNiTGZ6eVhP?=
 =?utf-8?B?VENRak10cGk5OTBQcnJ4WnBMRjBoVFRqNFNtZWNuZTBTTU82d1VERGs3eUZ5?=
 =?utf-8?B?dnpWcndpNlJKRTB1NklVTzFibEh5SzJlcGRJTW1ianA2MVRWRmVGZWprQ0ps?=
 =?utf-8?B?ODU3WUc1aVAweVVGbzE2K045bzdEZHlzeXVNQUpHTlhCSVlmV2UyQ3Zsc2Ew?=
 =?utf-8?B?SDlpdkVHaG9BQkZzSHpmTGlCVWZ4ak9FMXk3QUxZbkZWdmZBOE81WXU3ODVW?=
 =?utf-8?B?cVJSdWxCdDVkZzlyMTMrMVNocDJjczRRemtzblZjcDU0ZzUySkczVTU4WHBi?=
 =?utf-8?B?VXF2a1o3aVV1UFNRcVlDcnp2ZVpuQW1PV2kybUpoWXNDTFdPdjRPUERGeFBm?=
 =?utf-8?B?Q0FxY2JnUmJVWHB6MEVpL2Ftd0pRY3FZb2hJaTY4OXFFbzZNZi9IS0p6dmRo?=
 =?utf-8?B?S0pkK3FjRFErajAreFBmdUdzYkhFTktNQjBNMGFrR3EzL09vbjZJUkZWZU1a?=
 =?utf-8?B?S29IRlZLTkM3ZFpWbmd0Q3BrT0h0TnlXOWhnajBZa1FQQ241Yys4WDAzTGlP?=
 =?utf-8?B?cFBEbVM3b0xoZHNUaGpVZ1hsZ3BIQ3Z5bk16bjVuZTd4MEk2ZmRXanNZMGJL?=
 =?utf-8?B?aE92RGNpMk1PVGxrbnRLQXkweXhTUnJCWEwrWDZoWGIrQnhobWY4Vk8veU1B?=
 =?utf-8?B?WXBKelBadmtYaGYxcjFxNWxGWi9EblNjU2Z4UkhERkVzcjZyRUxML0JFOVp1?=
 =?utf-8?B?b1dHajV3VllmaDIrdjZjMVU2SXhJUGIrdlJxOUFDVElXS0ZOdnRPQ1A2ZkVz?=
 =?utf-8?B?NWhLWWJZMEY0Y3labUVDZUdHbVdrMHVsZTJBdz09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 10:06:17.7370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b36658a-f7a0-497a-cfb2-08ddd0e30eb8
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7048



On 2025/8/1 17:47, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Fri, Aug 01, 2025 at 05:25:51PM GMT, Hans Zhang wrote:
>>
>>
>> On 2025/8/1 16:18, Manivannan Sadhasivam wrote:
>>> EXTERNAL EMAIL
>>>
>>> On Thu, Jul 31, 2025 at 09:01:17PM GMT, Arnd Bergmann wrote:
>>>> On Thu, Jul 31, 2025, at 20:39, Bjorn Helgaas wrote:
>>>>> On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
>>>>>>
>>>>>> -  if (size == 1)
>>>>>> -          return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>>>>>> -  else if (size == 2)
>>>>>> -          return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>>>>>> -  else if (size == 4)
>>>>>> -          return pci_bus_read_config_dword(bus, devfn, where, val);
>>>>>> -  else
>>>>>> -          return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>>> +  if (size == 1) {
>>>>>> +          rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>>>>>> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>>>>>> +          *val = ((*val >> 24) & 0xff);
>>>>>> +#endif
>>>>>
>>>>> Yeah, this is all pretty ugly.  Obviously the previous code in
>>>>> __pci_find_next_cap_ttl() didn't need this.  My guess is that was
>>>>> because the destination for the read data was always the correct type
>>>>> (u8/u16/u32), but here we always use a u32 and cast it to the
>>>>> appropriate type.  Maybe we can use the correct types here instead of
>>>>> the casts?
>>>>
>>>> Agreed, the casts here just add more potential for bugs.
>>>>
>>>
>>> Ack. Missed the obvious issue during review.
>>>
>>>> The pci_bus_read_config() interface itself may have been a
>>>> mistake, can't the callers just use the underlying helpers
>>>> directly?
>>>>
>>>
>>> They can! Since the callers of this API is mostly the macros, we can easily
>>> implement the logic to call relevant accessors based on the requested size.
>>>
>>> Hans, could you please respin the series based the feedback since the series is
>>> dropped for 6.17.
>>>
>>
>> Dear all,
>>
>> I am once again deeply sorry for the problems that occurred in this series.
>> I only test pulling the ARM platform.
>>
>> Thank you very much, Gerd, for reporting the problem.
>>
>> Thank you all for your discussions and suggestions for revision.
>>
>> Hi Mani,
>>
>> Geert provided a solution. My patch based on this is as follows. Please
>> check if there are any problems.
>> https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com/
>>
>> Also, please ask Gerd to help test whether it works properly. Thank you very
>> much.
>>
>>
>> If there are no issues, am I sending the new version? Can this series of
>> pacth 0001 be directly replaced?
>>
> 
> What benefit does this helper provide if it simply invokes the accessors based
> on the requested size? IMO, the API should not return 'int' sized value if the
> caller has explicitly requested to read variable size from config space.
> 

Dear Mani,

This newly added macro definition PCI_FIND_NEXT_CAP is derived from 
__pci_find_next_cap_ttl. Another newly added macro definition, 
PCI_FIND_NEXT_EXT_CAP, is derived from pci_find_next_ext_capability. The 
first one has no return value judgment, while the second one has a 
judgment return value. So, pci_bus_read_config is defined as having an 
int return value.

Best regards,
Hans

> 
>>
>>
>>
>> The patch is as follows:
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index ba66f55d2524..2bfd8fc1c0f5 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -89,15 +89,25 @@ int pci_bus_read_config(void *priv, unsigned int devfn,
>> int where, u32 size,
>>                          u32 *val)
>>   {
>>          struct pci_bus *bus = priv;
>> +       int rc;
>> +
>> +       if (size == 1) {
>> +               u8 byte;
>> +
>> +               rc = pci_bus_read_config_byte(bus, devfn, where, &byte);
>> +               *val = byte;
>> +       } else if (size == 2) {
>> +               u16 word;
>> +
>> +               rc = pci_bus_read_config_word(bus, devfn, where, &word);
>> +               *val = word;
>> +       } else if (size == 4) {
>> +               rc = pci_bus_read_config_dword(bus, devfn, where, val);
>> +       } else {
>> +               rc = PCIBIOS_BAD_REGISTER_NUMBER;
>> +       }
>>
>> -       if (size == 1)
>> -               return pci_bus_read_config_byte(bus, devfn, where, (u8
>> *)val);
>> -       else if (size == 2)
>> -               return pci_bus_read_config_word(bus, devfn, where, (u16
>> *)val);
>> -       else if (size == 4)
>> -               return pci_bus_read_config_dword(bus, devfn, where, val);
>> -       else
>> -               return PCIBIOS_BAD_REGISTER_NUMBER;
>> +       return rc;
>>   }
>>
>>   int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>>
>>
>>
>> Best regards,
>> Hans
>>
>>
>>
> 
> --
> மணிவண்ணன் சதாசிவம்

