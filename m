Return-Path: <linux-pci+bounces-25714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B60A86DED
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C054216EF20
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEBE1EA7C6;
	Sat, 12 Apr 2025 15:19:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2100.outbound.protection.outlook.com [40.107.215.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74D19CC34;
	Sat, 12 Apr 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744471165; cv=fail; b=jViSRe6BkhBfiO3dwDLLHld438orZqh+pSqPbMj0YYiHLOEZSupEWoqtaeNoOMyyyYbWf5+50fFlrzlK+NcZcbpJ/xUM8wg71ugSFnBN1cuTdUsuHJpyyaSjohL/+wNbGF0XUPP/8RuMmhfS0mf1ruC8lqeI3j3EZL55VAokUP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744471165; c=relaxed/simple;
	bh=cDh/0MijDAqZbx8PjF6m/15X/1d4wM+9zG/4MdiGlco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2lXYCj/FqBaqHItGTJ0FT1ANzUP6GNMDXhXblo6IonGuc7AoAxSsnCd//49IB0rUV6mlMSayM/KNvz15LqJGACCEdz6Cy0ZXDx3DTiszi/JwmXJ9wdBWNF0z1gzTqC7QwTEdMgu4aSgQYsi3NB4NKqR6tHMPOL0LkybyyzFY7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLcfa4ZQktjb7OzD0faEmKansJQy86R7Zpb3y5HYXb7zvkFhiKtwzes/273G22zu7NaAK0yeybG+t+tUR0NjuADaVb7ayLqeJHnSM9IVWvarDJ1RnVwurecQ1iTFc5xBY9ycLTtiSMElXprggHJQwYx64veA4DawHwy9x2tS8+6EdCSpj5w7Pyq9vBH+qPbCP4124aofIf6Z7sd23vx5isJKuIixCj+g7vhp2/uEGTJ3rRIIAAt2WbAIX4HoLluAeDJsyAyfBTf8DbAKMYmqlUkaMWyhLpzuTxs834ZA2LrqbGFJj0yTb9qguS3Eu1pVLXPN08Nb8kIiQfvn2tw2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYJF0J/HIUfPZD15VHY5gmTyAmQWdqf+2jMK5JMc7nk=;
 b=WOXwlL3B2ISZHig5uhC+pi33miZ7/pePo6dztpXNCqVZQe8a6Ta9jacDLc5zbssw7BITRMM7jzyIoAsopmKJcYhhAADmiqefDPZh7RgOnu81ObiynAS7VcyAOm+U3dVW8YPGie7RKR35jcqRrrg4CLD7HlzziNcxpj36Q0PcCxOHd68GIPucBYp0JiubvI9aSrVQrjqY5Ugut6MZGfZgKebjCTpgL4ZJZuyKzh4GLO1LJ2bLNunbtNJP83jCnLRnfYlzYyHwVXBT+VqDO4d8OQcZzOXfNgwhn1VnDSzi1xBBxthCH9jKo3OOsI+VL7RzqNcfiA/tq6T7REJEP92AvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) by SEZPR06MB6232.apcprd06.prod.outlook.com
 (2603:1096:101:f2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Sat, 12 Apr
 2025 15:19:14 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:4:40:cafe::a7) by SG2PR01CA0129.outlook.office365.com
 (2603:1096:4:40::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.29 via Frontend Transport; Sat,
 12 Apr 2025 15:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 12 Apr 2025 15:19:12 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8C1A141604EB;
	Sat, 12 Apr 2025 23:19:10 +0800 (CST)
Message-ID: <78124cca-e10d-4b32-8760-d825ac88dffe@cixtech.com>
Date: Sat, 12 Apr 2025 23:19:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] PCI: cadence: Add header support for PCIe HPA
 controller
To: Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manikandan K Pillai <mpillai@cadence.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-4-hans.zhang@cixtech.com>
 <20250411203128.GA3920652-robh@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250411203128.GA3920652-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SEZPR06MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e419490-0d2a-4d29-7b20-08dd79d56158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU41OWtjVHpNRHFkeDgwL2xPS242YTZQelVVdzBkQ2xlaHpQRGNmb0gwL3Ur?=
 =?utf-8?B?aUhnc0s1b2FMdWc3NVZtRmlSWXJxNzVLbmJGeTBtS2x0WVB5a3Vsd29MVWNC?=
 =?utf-8?B?WjJBRGZ2aC9JNTl2THk5bVRkOUZWWkdDWFVUVEZZOUFnb1ZyK1JybXNvRkN5?=
 =?utf-8?B?NFFmeG1sYksrNTN0NDROZDVuL3llYmg4ZlBJcmF1bFBkQktSLzBIWFhIV3lQ?=
 =?utf-8?B?aS92L2JPQTNrQ0xPaEc4R2wxb0c3dVlaNDVMNlordmR1eHp3a0docVRRdm0v?=
 =?utf-8?B?bXh6VUhCczdGRmlGMGNOUmM4MVFsbHN0WWdjR1NqMkF2UmpRa1J5Y1phaTRz?=
 =?utf-8?B?YTBnNTAydTQvNGVRVlEzODBkeWJQVWdnYnJneE9IaGZwQjRnWHBYQ0pQQWsy?=
 =?utf-8?B?RGw3a3FLLy9jYU5zdkNqQ21nNlZPZEdCeWc4V2pZOHdSU0J1Ti9JRk40aGRN?=
 =?utf-8?B?MEhuNi9OT2xHaWpSa2F3QXhvNGxLQ0FDZUpUK1VHZkl3NUtNcFV2WFhna0Fh?=
 =?utf-8?B?MEk2YVdDQVJUMHNCNEg2WFVCWG81Qm9rUGo5Q3h5MU5ZbUhQNkZmU3l2Skl1?=
 =?utf-8?B?cGQyREV0K2lEK0hJMWczL2VUY2xZQWg4UUgyRjczbDlZajduWTBjMkRCMEVn?=
 =?utf-8?B?SElTWHpzcytkVW9CeUg2eitOR1Y4dkh1b2t5UXdLYjFlZzRNejc1bTFKaVI2?=
 =?utf-8?B?UXNhNFc1eXAyN2dJeHFrR0lRYWpZcDhoelVwOHpxM1ZveExMMnVBSVBQZFdR?=
 =?utf-8?B?VDM4WGsrcDBQS1RDejVzQjlLemdjaUZMNXdNM0p0THRZZ1p6NmdiS3F0WW4r?=
 =?utf-8?B?MjlxckN3L0NkdmpNczV3Qys4N0k3cGkzaWV4aGJ6NENnY1BsZnpURzJqdFU0?=
 =?utf-8?B?S2h4RHd4dXpTb29pR3dGU3g0SGRtUmpJOHR4WjZYZlJvc3NWRlRUOUEwelBW?=
 =?utf-8?B?aHRWdENlUyswbTVmZUdETk1XTzVGQjZablZQWUNZRXlJTndidk9CL0RxN2N1?=
 =?utf-8?B?dkNiZnF1djFUYVVzUzErSmdWamRKSkpPbGR0aHBoRytZajJwNmdaYnh1Rkg0?=
 =?utf-8?B?RmhIR09zQnVWdnhzOUJYVGV0eTdjR2ZpcHQyTnc5L1d6SzNWbkQ2VjBGNmU4?=
 =?utf-8?B?OXJDUVR6MjZ3M2xvSksrRGp5bTVZczIxb2oxTWd1ZHJPWkFWZTQzeHZ0RnVz?=
 =?utf-8?B?MlZrdGkxOUIzNzlSOXVqZFR0R2VxajV4VFJEbzgya3JWMU1PR01UVDFKQlNB?=
 =?utf-8?B?Ri94SjdyU1FzbFM2S0htRGxydms2dnJVUG5SWDNWTzZ0WlN6VU5XOGJXaGZF?=
 =?utf-8?B?SG1TWVlxNGMxc3FIb3FXMTdyeU0zZjc3d3BFZkdXaUpOeXlFZmlGRVlNTTd1?=
 =?utf-8?B?R080WFZyejVMTkNhcStzWWxRZU5MRkxocHk5QnBDczFrMTBqYzl1aDgvK2Jt?=
 =?utf-8?B?Rjk5T3d3MGUvekJ4ZFE0eU5QbzF1SVR0UWhzcXNzMkVuOWJKTktRYUdrYVFL?=
 =?utf-8?B?SVlISGVOdXdUY2FFZVp2RzJ0SzlrQUhwZmx5NHlsVnNLdUJSb1NCMmlJS3pu?=
 =?utf-8?B?dHV2aEZONXJIZFpObjBiWWhmNTZBM285akoxZW5UUFo0dEVpOTV0ejI5VVNr?=
 =?utf-8?B?aWtMRlM4ZHJITkhWb1hDUktkVTlTWllPYkthUUhRdnBQZWVUeWhNaW1MWkdO?=
 =?utf-8?B?VnVTbzRVME94QS9BTDI4QlMzSkdiZm1KbGFBOFlObzNXKzhBcWdleVJyaC8v?=
 =?utf-8?B?M1FOUzEvYVdpZVhlaVUxMVRkL21oUWZYeU1xcFV0SjM1VUZENmUrOURzV25H?=
 =?utf-8?B?NHdjWm1hNXBabnJpZ29oeHI5OFBSVW1UOUNPeW5IVmtDd1llL2lMTVJTZG81?=
 =?utf-8?B?WVVmZ0VxbVFIZTNxMzZNb0JrOVd1RmNQZUhsUFQ4RkJSSTd1bEZtRzRBMmdY?=
 =?utf-8?B?d0VrU1JqWWtPWVBrVWxaSXFEcGlYVlE4UHBuVnpHTmgvTjBXSDRJS205L1l3?=
 =?utf-8?B?U2xKOHQzQnFaTWVUcTRaR3ZRRzJkY1RFNlY3UDRheTlCNk5TOHFNaWpxaURr?=
 =?utf-8?Q?V2glp1?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 15:19:12.2161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e419490-0d2a-4d29-7b20-08dd79d56158
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6232


On 2025/4/12 04:31, Rob Herring wrote:
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> index 0456845dabb9..b24176d4df1f 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> @@ -24,6 +24,15 @@ struct cdns_plat_pcie {
>>
>>   struct cdns_plat_pcie_of_data {
>>        bool is_rc;
>> +     bool is_hpa;
> 
> These can be bitfields (e.g. "is_rc: 1").
> 

Hi Rob,

Thanks your for reply. Will change.

>> +     u32  ip_reg_bank_off;
>> +     u32  ip_cfg_ctrl_reg_off;
>> +     u32  axi_mstr_common_off;
>> +     u32  axi_slave_off;
>> +     u32  axi_master_off;
>> +     u32  axi_hls_off;
>> +     u32  axi_ras_off;
>> +     u32  axi_dti_off;
>>   };
>>
>>   static const struct of_device_id cdns_plat_pcie_of_match[];
>> @@ -72,6 +81,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>>                rc = pci_host_bridge_priv(bridge);
>>                rc->pcie.dev = dev;
>>                rc->pcie.ops = &cdns_plat_ops;
>> +             rc->pcie.is_hpa = data->is_hpa;
>> +             rc->pcie.is_rc = data->is_rc;
>> +
>> +             /* Store all the register bank offsets */
>> +             rc->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off = data->ip_reg_bank_off;
>> +             rc->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off = data->ip_cfg_ctrl_reg_off;
>> +             rc->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off = data->axi_mstr_common_off;
>> +             rc->pcie.cdns_pcie_reg_offsets.axi_master_off = data->axi_master_off;
>> +             rc->pcie.cdns_pcie_reg_offsets.axi_slave_off = data->axi_slave_off;
>> +             rc->pcie.cdns_pcie_reg_offsets.axi_hls_off = data->axi_hls_off;
>> +             rc->pcie.cdns_pcie_reg_offsets.axi_ras_off = data->axi_ras_off;
>> +             rc->pcie.cdns_pcie_reg_offsets.axi_dti_off = data->axi_dti_off;
> 
> Why not just store the match data ptr instead of having 2 copies of the
> information?

Will change.

> 
>> +
>>                cdns_plat_pcie->pcie = &rc->pcie;
>>
>>                ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
>> @@ -99,6 +121,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>>
>>                ep->pcie.dev = dev;
>>                ep->pcie.ops = &cdns_plat_ops;
>> +             ep->pcie.is_hpa = data->is_hpa;
>> +             ep->pcie.is_rc = data->is_rc;
>> +
>> +             /* Store all the register bank offset */
>> +             ep->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off = data->ip_reg_bank_off;
>> +             ep->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off = data->ip_cfg_ctrl_reg_off;
>> +             ep->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off = data->axi_mstr_common_off;
>> +             ep->pcie.cdns_pcie_reg_offsets.axi_master_off = data->axi_master_off;
>> +             ep->pcie.cdns_pcie_reg_offsets.axi_slave_off = data->axi_slave_off;
>> +             ep->pcie.cdns_pcie_reg_offsets.axi_hls_off = data->axi_hls_off;
>> +             ep->pcie.cdns_pcie_reg_offsets.axi_ras_off = data->axi_ras_off;
>> +             ep->pcie.cdns_pcie_reg_offsets.axi_dti_off = data->axi_dti_off;
>> +
>>                cdns_plat_pcie->pcie = &ep->pcie;
>>
>>                ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
>> @@ -150,10 +185,54 @@ static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
>>
>>   static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
>>        .is_rc = true,
>> +     .is_hpa = false,
>> +     .ip_reg_bank_off = 0x0,
>> +     .ip_cfg_ctrl_reg_off = 0x0,
>> +     .axi_mstr_common_off = 0x0,
>> +     .axi_slave_off = 0x0,
>> +     .axi_master_off = 0x0,
>> +     .axi_hls_off = 0x0,
>> +     .axi_ras_off = 0x0,
>> +     .axi_dti_off = 0x0,
> 
> You can omit anything initialized to 0.

Will change.

Best regards,
Hans

