Return-Path: <linux-pci+bounces-33274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF35B17F36
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAC1C21F6D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AEC2236FB;
	Fri,  1 Aug 2025 09:26:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023106.outbound.protection.outlook.com [40.107.44.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851E222582;
	Fri,  1 Aug 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040361; cv=fail; b=X9JKUq0Jd2vlaSSy0JHX8KUr/f9NEZxmkpaeIPzzjqPDX7JXHuRneEZs9RQUIxGEkRk6+7dndwGL4hS1BWyvGgRSTMjWm5OL1AB1PaOpiUQmHj2+eWYcldDFaEGqTHLLN9vSBgFUCK8RyDeuj1CBEL+nf/8k5l1aio2OokJXglo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040361; c=relaxed/simple;
	bh=1/M7zABI/7N/sbzQRrruqlEwOApLUUO2WBdV3nbHAKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzUstFwoboKUcdG7l2K8W6HAuxVYva3TuzHvmO5IaKtYS1LKV8wJvm7Mpe+Eu3lV68jwGOoC1JFpEpx2TawoOh5OrLpjSgRJ52nMuh3t3fBZlfDzSxZ9ZuvO0zIzx81v1Yk/Xw+4U932hq4+t9DY8iM5M2rUe5GDVqcZt/Ke9xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB4u3zNBaUYkdsxFookAAoU9XL0lZmtKItrProi3Rvyy0KFpUQJUHuJaFWxaEyyLvv1Hw5aznJYOoZDJ35n0YVqVly0Xsp8W44G9UaujMa7eZhdUVQTPSMvw24SqewVbZJ2iTL+GpH1bgr6iVyODyC1FBMaxBwgTAQhJ5L01adkeHp49Q8Wh3CgLRyqEiq837y9CNFmzHvot2qSqEbgi3esxsx1fTAlzK77TleW7j7ZLFTtGT7dJGTVMOU1chagb4GikfxO+o9f6W+yMvnKe0HcXgJgnPQbeD/hV7DaQS9mIqJxY7d2FNe/1oyNGDlV7kVmj+4TmkekqCDf3WXtNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uPGm5D3ov6rVU0L1Hj4SruwKig9ENsSMwym+43HnAE=;
 b=jN/cT7m+JsBxB3sszulGhB/NpOKyQot061zikmB0KikhkZ1eyjfj0Y8NmkpdzAWaoE2y3PUjxsWPFodc2Av0svnReKGqlcVLefMvlLw/Uzfv6FywxtNds9DnocNLS7ye0bWc1qKUam9UBp8HW3SUchbXiCMacSGWuBxAzNRn707m2w+hP7ePGQwgaQKCDnrp9X4//T46y22Hd1t8aUjuyKt0p9B5rmxCi4Ff2V2EAK+ya7Taz5M5YtfDNLihMQOocKLX3zrjtP1fKzGsNMCaF5uT6fwmx8NZlNkBA4H3qSd3rO9WYMy+IqR4JD4KbazpTIZAAJ+uELLugIz6cPS0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0019.apcprd02.prod.outlook.com (2603:1096:300:41::31)
 by SG2PR06MB5240.apcprd06.prod.outlook.com (2603:1096:4:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 09:25:54 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:300:41:cafe::1c) by PS2PR02CA0019.outlook.office365.com
 (2603:1096:300:41::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 09:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 09:25:53 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3C3FE4126FFC;
	Fri,  1 Aug 2025 17:25:52 +0800 (CST)
Message-ID: <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
Date: Fri, 1 Aug 2025 17:25:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Manivannan Sadhasivam <mani@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
 Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 ilpo.jarvinen@linux.intel.com, geert@linux-m68k.org
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|SG2PR06MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: 49904621-939e-4218-27f1-08ddd0dd69a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTlzK0dUVFFERURRekx0eWlrTFBtTXpsaVFwWnJLZTBDcG5zNFZ1SkZuYml2?=
 =?utf-8?B?Um9EdlE2VlpZVnFxU2N0K1ZsclM0UmZiaG9iaGlPanRtNExWWjlldlVlNnAy?=
 =?utf-8?B?MnVNMzdmRUNJVitEVFlHditWcHdBckRGNkhUakVOdzRURG8zL0VEZkVEam11?=
 =?utf-8?B?S3F5UU5pL2QzRG90aXVLNHRIdFdHZGZ4VU1aWjBMcGdrbE4rZ0NEKzRvR0hW?=
 =?utf-8?B?R05tZWtUc3hTbDNCSTZ3SmtVelZwMW9HVjNYYWpiM0hmUzlVaUJ0OVNHeHVk?=
 =?utf-8?B?STIxSzA3eWpCc2RsWjAzNTRiNUVOMkM2MVVjbS8wQ0pteVFWVzlqTUpVNS93?=
 =?utf-8?B?a2d6RXBjR1dQUEVtQVhhL3I2NHNuS1d1dmR6dmJ4aWlaamRvNVdRWUFVUTc4?=
 =?utf-8?B?RCsvYktBdmYyRGc2c3V1Uyt5SEZnaGJzVkpHKzMrTkR6QWdSTzJOcjVRa05S?=
 =?utf-8?B?cE5DM2xEQlNWbkkzdTZFMW96T21udXdvQ0pnOVNER0c2VHRPNXNjVHFIdFNB?=
 =?utf-8?B?RVNPSElIbHdPTkRCcE1EWmdwUVkyVXVlZmNyNVFuRlk5eldoYVl3eGFkYTJZ?=
 =?utf-8?B?ZVBpRVdWay8yYkhPZkZCbHA5eVZ5SUN5U0xUaDRZSmtGZHZPSHV3QU5OdEtB?=
 =?utf-8?B?TUcxQjhWVnhsTERkN1cxZnkydDI1SkVJekhRMmYxQ2MvYkxSVFZWdDBtS0FL?=
 =?utf-8?B?WUlIV0NLRHI4ejB1RUZnRkdyR0FYbmJzcm5WQm92Tjg1SE1ocFhWc2xJMnph?=
 =?utf-8?B?ZUZ1STBoNkcwS25yazA4dW92SEpqQkFTckxIS1crUjg0RDBkdGwzSXRHVnlw?=
 =?utf-8?B?U2syRXJsdHdDekFic1k0ai91N0Fid0puZFFPOTMydnZvYk14Qlc3blp0dnVE?=
 =?utf-8?B?Zm5JcVBac21kUlNHM250VnAvWk56NEU5NERKUDJmYmc1dGovSGplY2k5Zm5N?=
 =?utf-8?B?OC93bUtLcU8xdEZoUG8xQVhVMGJBV0Y2bmJiYmhzTXRuQllNWnMvNTdHUzFi?=
 =?utf-8?B?cks3b04yWWpRUktVcFhqVFN2N1BqUDQvVGRKNHB6NG56TWE4ak1RTEhNWi90?=
 =?utf-8?B?SkRQbGJ3dUNXUFpwTGVvbWhDdkVGdTdUYVRUVGVJQldMVkRWUUtSTFV5L2J0?=
 =?utf-8?B?SlEyMmd4aHlOSEc0NGZxQzJwTDFyZnBJVElzV04vREtHTFVJSS9NaGxlNlIy?=
 =?utf-8?B?OTdGbzlUdTFzQTk0WURrTXF0d052T1owanUzUzNBaHVPbThzWnpDc0luNFpp?=
 =?utf-8?B?MXR1ZDViTytPN0FQQ1JRYU9VdG1pYTRNTDFUM2RPTjlncGRhTnhOS2hyTkJ4?=
 =?utf-8?B?YUM4dzRFTHZwM3hSVjlkK3FDTndhZ0EvM1VjSUhaMjVxa2I2YmFOVnh6d1VJ?=
 =?utf-8?B?WVhnbktOYmJxVGlSZUZEd0ZQSGpHM2xhZStzTGtIVjg0dm5nUzRPSXBjTFk4?=
 =?utf-8?B?RUg0TXV6R09RVHgwRUNhUThjWFpkMTBtVmQ1ckI1T3o5bHhEQ1JDMGxidXFJ?=
 =?utf-8?B?eHIxaExaaksrUFZ1T2Q5cExSOU1DWmtXeTBpTlNhSGxESVYwOHJYNExvSVY3?=
 =?utf-8?B?U0RIOUhrRzJxTHZLTzh5MFAzRTEraWZ6ckhWWUJqd2hTc0lOcG1JM2dQNkxr?=
 =?utf-8?B?K3FvRnJqcTR5WXNRajJEZ0V2YkM3eDNGOFRzREVWOVRXZjFOMW9LRXhGVjc0?=
 =?utf-8?B?UldxeVZHQVU2OGtYMUVRZ1JwczMyaDI5UU94VVYxSmlnckF0eGoxVWRyQ1Y3?=
 =?utf-8?B?YXZPK256bzRhblQ5dFZJLzRkY0dOaWUyZERKdFhYQWNldVpNTVdEWWg5dTdH?=
 =?utf-8?B?Znp1YjUwYXFZZjd2alpjTHRNNHRVcXRpVmJIMXlzaUZGcXg4K1ZEUnpwMVZE?=
 =?utf-8?B?SitBWlFuMFRyUzg4TXNQYzZaTnl2dnp1dkxXeVZ4RGJpNms1V2Z3TDNmTFdY?=
 =?utf-8?B?T0pNeVc2RkZ6RVgxOHE1dlpvZlhLUTZSM0ZnMlhUOWhnQklJNjJLdTlNbWZ3?=
 =?utf-8?B?TCtXZlVqaTNMMFIxOVJuaWQwRGNpbHBhWXYyQ0RJSWFGRGY4N3RvSjFLV3do?=
 =?utf-8?B?TTF2WU9MSUwxRmI4Q2lCZ2daY1JSZzhWWm9wUT09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 09:25:53.3365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49904621-939e-4218-27f1-08ddd0dd69a9
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5240



On 2025/8/1 16:18, Manivannan Sadhasivam wrote:
> EXTERNAL EMAIL
> 
> On Thu, Jul 31, 2025 at 09:01:17PM GMT, Arnd Bergmann wrote:
>> On Thu, Jul 31, 2025, at 20:39, Bjorn Helgaas wrote:
>>> On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
>>>>
>>>> -  if (size == 1)
>>>> -          return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>>>> -  else if (size == 2)
>>>> -          return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>>>> -  else if (size == 4)
>>>> -          return pci_bus_read_config_dword(bus, devfn, where, val);
>>>> -  else
>>>> -          return PCIBIOS_BAD_REGISTER_NUMBER;
>>>> +  if (size == 1) {
>>>> +          rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>>>> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>>>> +          *val = ((*val >> 24) & 0xff);
>>>> +#endif
>>>
>>> Yeah, this is all pretty ugly.  Obviously the previous code in
>>> __pci_find_next_cap_ttl() didn't need this.  My guess is that was
>>> because the destination for the read data was always the correct type
>>> (u8/u16/u32), but here we always use a u32 and cast it to the
>>> appropriate type.  Maybe we can use the correct types here instead of
>>> the casts?
>>
>> Agreed, the casts here just add more potential for bugs.
>>
> 
> Ack. Missed the obvious issue during review.
> 
>> The pci_bus_read_config() interface itself may have been a
>> mistake, can't the callers just use the underlying helpers
>> directly?
>>
> 
> They can! Since the callers of this API is mostly the macros, we can easily
> implement the logic to call relevant accessors based on the requested size.
> 
> Hans, could you please respin the series based the feedback since the series is
> dropped for 6.17.
> 

Dear all,

I am once again deeply sorry for the problems that occurred in this 
series. I only test pulling the ARM platform.

Thank you very much, Gerd, for reporting the problem.

Thank you all for your discussions and suggestions for revision.

Hi Mani,

Geert provided a solution. My patch based on this is as follows. Please 
check if there are any problems.
https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com/

Also, please ask Gerd to help test whether it works properly. Thank you 
very much.


If there are no issues, am I sending the new version? Can this series of 
pacth 0001 be directly replaced?




The patch is as follows:
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index ba66f55d2524..2bfd8fc1c0f5 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -89,15 +89,25 @@ int pci_bus_read_config(void *priv, unsigned int 
devfn, int where, u32 size,
                         u32 *val)
  {
         struct pci_bus *bus = priv;
+       int rc;
+
+       if (size == 1) {
+               u8 byte;
+
+               rc = pci_bus_read_config_byte(bus, devfn, where, &byte);
+               *val = byte;
+       } else if (size == 2) {
+               u16 word;
+
+               rc = pci_bus_read_config_word(bus, devfn, where, &word);
+               *val = word;
+       } else if (size == 4) {
+               rc = pci_bus_read_config_dword(bus, devfn, where, val);
+       } else {
+               rc = PCIBIOS_BAD_REGISTER_NUMBER;
+       }

-       if (size == 1)
-               return pci_bus_read_config_byte(bus, devfn, where, (u8 
*)val);
-       else if (size == 2)
-               return pci_bus_read_config_word(bus, devfn, where, (u16 
*)val);
-       else if (size == 4)
-               return pci_bus_read_config_dword(bus, devfn, where, val);
-       else
-               return PCIBIOS_BAD_REGISTER_NUMBER;
+       return rc;
  }

  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,



Best regards,
Hans




