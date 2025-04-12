Return-Path: <linux-pci+bounces-25715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E1A86DFE
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270B98C6003
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9519D071;
	Sat, 12 Apr 2025 15:45:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021087.outbound.protection.outlook.com [52.101.129.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001BC148850;
	Sat, 12 Apr 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744472716; cv=fail; b=ASlJJqi0H3bYnbDlC4JDRNMN9UCLmGWujr4hA+aFsaIJuBPMCeMpXZKoqFcfI12Spz0dSevB5p6EyqGCKs3/+y3f6/eDyK9XI+JPh9zHQ88STs/9NDEnWOyTihkIBxptmeKldKz0c3+mbDdhXL5pFiUTZ7TY0U+yaI8l6BWpqPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744472716; c=relaxed/simple;
	bh=TPjWYsfIDpWD0e+oCxZeJDK6nV1vCreXAhyCPbKyhRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDshe2pHVkdZSLC74tJSf/RtxfCGJ83p3aD8pNrPTE5qJHfiEQfgd6Nbal+NHgeObRAqBGkrM0+6ve8Jk0Byhw8As3UDnbq7nT/KiMFf98hgfmmoERuVhsg5pj4McmuDzSkBtiNgo8bM6MCye6X1ir+92oQjZLtdCqFCrXI0KAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWtc/wp6Et8BWZL6z8bQntqqAaUlsbM7wp1A+joPOxwhqbYVCpAnK4i/86OQYQHcOcRg1zXKaS2rk1LRSuL7+fYAhHouDIYEUfXBc3z2i5wrsZfn5SfEyGPPZu7gG274znYuwMvKajNcQ00V5+0af9abF8mHVTSRqSQZDtzWtYcYuqtspQhEVvvmheiJd6E2eOf3d2qIIOoieyG+sV+GT70cLZNjbYon4GJMglLVR4PBEopOru+PdVYkFc1GExcmdNc9JctBB+Qjn6iP/W6ILU3FZs2RkvXJRvTge24f5FrFsdDt6aUiO0Rw7axeg/pV/DIE1Pyoo0K+K274qcgkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dJCEVo0NXck24uC1OiyQt3boqhHxdvHlYNHyrV5wOc=;
 b=imWACdEsGdOWxsUOrZNNifw9MuNX70YV3NXvPXKnHw2eXLuT7hVPzspxCm8jujePzbiwzhXpTJNr+oSFXjaGejn5WaQ14UshDWDo1lB5iCcDzzArnz5MJJBB24WnfcRvConIXw+LvwYlS1yrK4Z76OZUaRlp6QkifnW3t7q/Y/SgP6xO+/oUWMy+RSOXVKMcoo5DrExVYCcQOfo7nrDSwkGNdYkJEBF+15b7Nxs5bEyxzpDUk/vyRRUYfRMJWAqGdwrBkAoyTGAGvxwuh+wmeac70icHE36itlEYYpBF1Lb2gHTC3nZ64H4JGtGt9Ptg8Wtg5cdt+2/yS8na21Ar4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14) by
 SEYPR06MB6983.apcprd06.prod.outlook.com (2603:1096:101:1e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Sat, 12 Apr 2025 15:45:09 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:be:cafe::97) by SG3P274CA0002.outlook.office365.com
 (2603:1096:4:be::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Sat,
 12 Apr 2025 15:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 12 Apr 2025 15:45:06 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0EDC841604EB;
	Sat, 12 Apr 2025 23:45:06 +0800 (CST)
Message-ID: <07457d00-82bb-4096-ba07-6cc7b7d118e3@cixtech.com>
Date: Sat, 12 Apr 2025 23:45:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP
 controller
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manikandan K Pillai <mpillai@cadence.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-6-hans.zhang@cixtech.com>
 <20250411202420.GA3793660-robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250411202420.GA3793660-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SEYPR06MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f75adc-9d98-48d8-2d3c-08dd79d90005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDZxRjl4eFFZbVQxOFprY0RCeENIWWxOUWJrUTNSUGk4bmVzaWt3bmo2RGpv?=
 =?utf-8?B?YjVZSWQyN2tXSTJVS0dRU0U5aFA5V3R6WHNZUkcyalBHbWhhRTYrbGNBYkw5?=
 =?utf-8?B?cTFaaU13cnEwbURLRXNad0l3aDV5VnV6cjlmNzN2YStwdFY4OHJkL1c4Smg5?=
 =?utf-8?B?Nk9NRElhNUUyaEo1U2k0YWVYUWZKcG83MkJSSVNKTEUzOFc4N0w1NC9lUm1j?=
 =?utf-8?B?L3gwa3VUVC9xOURzWjdkUFRMSVVJQWNIcHZhWlU0ZXZLUitTTllRVzhLZlVy?=
 =?utf-8?B?KzJHclVIa0V0Ry9Rcmk0R2owYkRqNkNTQi9WTUtCTlJDdTJ0ZnMzbGVnaWVt?=
 =?utf-8?B?dnNoS1pKZ2sybitGeGNDcDJEeXZBQ05ZbUI4eUZ3N1VBTVlGd2k4dmhYd1Vr?=
 =?utf-8?B?Y2t5RHd1Q1JxS1Btb0I0RDJ3YXd2ZHFFV3N1MXZFS3o0bEtPMllZbmh3OWpN?=
 =?utf-8?B?MVBpK1lEOG5rcTVCa2s4U2pDRWphTHJMVGNnMEViUitWdGljbnQrWkVJS2pq?=
 =?utf-8?B?VjhtUU9xdWJpUWY3ckxGQTZTazVlMCt4SEVicjRRRFpLUFY3M1BIOXVDSjZk?=
 =?utf-8?B?WkZGaWYrdWFha3p0TDk3WnNzUFZpZ2U1MHZDbmZZUUdvT3g0RVpnRGpwR1ha?=
 =?utf-8?B?MlRLMFkvNjVoRHdzWHowUlEzdWh6cUp5ZHgzYytIT2VmVXBYWWhqVEVpNFcv?=
 =?utf-8?B?YVRFZjJybUwvTklFc0NYVHVtRGF4OUI2bkpSeHRaVlJFRHlyWm5Zb3drRWpq?=
 =?utf-8?B?aUFIVjBRbjBxK3FKMWRpSWdVOWhlWHBCQnFyd3lSbXRrbm5GN2t5K2trRjZh?=
 =?utf-8?B?anlFNW5yNzZxUFJTZjhsaGMzb3lTWFlVbklLQmRGTTRYRlNGTXMvT1lCcEg4?=
 =?utf-8?B?VDN1SUFieGFieUllT3dEMFM0ZG13Y09ib3NKa2hmL20wUUcvNFlCZEVqNGFy?=
 =?utf-8?B?eVNUVXpWL1U5QTBPRTZKVVBHOVUwRTVJTStBV2p0RFBXc09EYzlIREgzZWlP?=
 =?utf-8?B?WTV5d2I4MkFRKzZBd0FBeHZFUlEyWjA3UGlTUDU5em9PNURoT3MxNFJDWHhk?=
 =?utf-8?B?RmxpUDBYL2ZrV2R1bHJFVThNTldUbmI5ek9sVkZpaXpnZ0F2SzhackcydFh3?=
 =?utf-8?B?Vm90QmVBK0VUVGRqS1dYUnVkbGlqVW5wM3pWVkI4TnhueTlib01HVXNGSWU4?=
 =?utf-8?B?Q1FocWNUYUJXeHJmWHUxY09BZjl4ZzRTWWtOSzlBdHhXc3pRdVgrMWU3NTdN?=
 =?utf-8?B?U04zOTdQcHAwYzQyU3BJZERpRGd4WU5WblB1cUJJWG1RS212WmdLM2dUaCto?=
 =?utf-8?B?TUtLdDFHS2tOSWQ2dG11U2ZUYm1wYlVQRGR6dENJMENEemcyUWdWaDYrRnFH?=
 =?utf-8?B?NXZiSzZ1ZzBNdk5qc0pyNm1DbmxzU3RwdmNQK2IzL1NBQVNlNDVhMUVvN0gx?=
 =?utf-8?B?TzNBM1k5WGFsanBCVmVlZ3ZHV1ZmVkJqdS9yMzVHWG5wZzRBK080T04vWGVJ?=
 =?utf-8?B?UHpEeDJob0Zub1RjeVp3cUNLNUxpZ2R5aEZBOEpwc3MwQ1dvaE84c2F1QTVR?=
 =?utf-8?B?M3RvYkxQUlNMZlpqVlUrU1VYVzBJQXBkZzJzWDE0dVR6YUlRdGUxQ2lEWml0?=
 =?utf-8?B?eEZLb0ZCU0QzMXFkdnhWS2JaNEtCOE1BL0loTmZTN1p3eU5CV2czakFrRUdC?=
 =?utf-8?B?azJNUlZxK0twbklVTkVXUVN0YWtqb29TU2hTSFQrdldKREVFbWFHTEFVK3kr?=
 =?utf-8?B?U01SdmhTWE8rNFVsZjRNcktrb09Yek0rYmNiYzNnemJhazI2bktBVjV3T2xJ?=
 =?utf-8?B?cElUM0lQMXIvMGtKeWJ5VTlNUzFJWE5OOEg2bStyYTFtdVc4UEpsRHdPM0tr?=
 =?utf-8?B?SE9VSTNmcEJPOTl4WG1qMkZZQzlFZnRWb1NqMHJMaWJEY3FGaGNXbUhua1lv?=
 =?utf-8?B?UFRLd0lUY3YzaFhkaUxHeTVaUHZYdGdxVVVxNVExRWdBcUxqVVhtYVRzeGd4?=
 =?utf-8?B?Q0d5TU15N3dQczRPRGY0NitRYjQ0ZEVUQzVCTlhnSitiYURJaEQ4TDhJVUFv?=
 =?utf-8?Q?0i33EQ?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 15:45:06.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f75adc-9d98-48d8-2d3c-08dd79d90005
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6983



On 2025/4/12 04:24, Rob Herring wrote:
>> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +                                int where)
>> +{
>> +     struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>> +     struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
>> +     struct cdns_pcie *pcie = &rc->pcie;
>> +     unsigned int busn = bus->number;
>> +     u32 addr0, desc0, desc1, ctrl0;
>> +     u32 regval;
>> +
>> +     if (pci_is_root_bus(bus)) {
>> +             /*
>> +              * Only the root port (devfn == 0) is connected to this bus.
>> +              * All other PCI devices are behind some bridge hence on another
>> +              * bus.
>> +              */
>> +             if (devfn)
>> +                     return NULL;
>> +
>> +             return pcie->reg_base + (where & 0xfff);
>> +     }
>> +
>> +     /*
>> +      * Clear AXI link-down status
>> +      */
> 
> That is an odd thing to do in map_bus. Also, it is completely racy
> because...
> 
>> +     regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
>> +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
>> +                          (regval & GENMASK(0, 0)));
>> +
> 
> What if the link goes down again here.
> 

Hi Rob,

Thanks your for reply. Compared to Synopsys PCIe IP, Cadence PCIe IP has 
one more register - CDNS_PCIE_HPA_AT_LINKDOWN.  When the PCIe link 
appears link down, the register -CDNS_PCIE_HPA_AT_LINKDOWN bit0 is set 
to 1.  Then, ECAM cannot access config space. You need to clear 
CDNS_PCIE_HPA_AT_LINKDOWN bit0 to continue the access.

In my opinion, this is where Cadence PCIe IP doesn't make sense.  As 
Cadence users, we had no choice, and the chip had already been posted to 
silicon.

Therefore, when we design the second-generation SOC, we will design an 
SPI interrupt. When link down occurs, an SPI interrupt is generated. We 
set CDNS_PCIE_HPA_AT_LINKDOWN bit0 to 0 in the interrupt function.

If there are other reasons, please Manikandan add.



In addition, by the way, ECAM is not accessible when the link is down. 
For example, if the RP is set to hot reset, the hot reset cannot be 
unreset. In this case, you need to use the APB to unreset. We mentioned 
an RTL bug to Cadence that we currently can't fix with our first or 
second generation chips. Cadence has not released RTL patch to us so far.

This software workaround approach will also later appear in the Cixtech 
PCIe controller series patch.


Best regards,
Hans

