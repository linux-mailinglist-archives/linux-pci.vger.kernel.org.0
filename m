Return-Path: <linux-pci+bounces-30151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208F8ADFD15
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEC53ADB87
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA307241CB2;
	Thu, 19 Jun 2025 05:42:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022077.outbound.protection.outlook.com [40.107.75.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769B4A06;
	Thu, 19 Jun 2025 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311746; cv=fail; b=bg6+0mJ1pEYwsahnAOsV7gcF+CeMMC+El1sHKbqvxo/GulSSKDen03BnyfcSRVcogN0tCEf4WX47azgO618EHbrWI9oGozw9zbgqYQF7TOPZGncAZhyGi0Ii6nq9aUqAjlozNZ/x4odoPm7jMAiSXSXx/0MrIPTzNtSCYPHtoTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311746; c=relaxed/simple;
	bh=7dvSXa+frypb9GhtOgiE+dyTIeZd4OtGwLI6ft9ANV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFr9WLV0Bfv+ziZFOE4ku7ilrr0s5cw7a1bkw0OHV+T9cE8SoMPILaiPIqfOV69ajdGPD5k9jHbPIrQwqI7aeJDr1ky7jcrYS73XtrZVD91RV68rjY5oih+buhOPnZv5FN3kU4F68P1Q0jvX5D+Z4gQ5NiY12qAjz3GuPYJd8T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaCQnYNLJlyJyTgRnolYI+cnesWwILcVr38G+w2M8p6jZVQovtl1YY4WKX79zRpZwdB8ghL6qY7G35FqFJPTcQBzqYHRMIQeQVZGzveT/F0Xl/PsngQUGcFxWrs3R8dWgQ+w2ukgheuELc4ujq66ChIk4SwYTyJuy1vWsTodDjbXnq/CNSMf967i/1AS2GB0w1gvsZPN5UHJYgjU/WGaPydVrlfm7wPieu6Db4Bjl544QOBF9hJMCE0S1trNI+z0T2Fg/4Hnyb6TkCkQiZXHe/9C5jbPNlVu01dBpmYtnC47orHCyoWM0hvJeLaAArSFl4oUs8gDd2k/8sGquCsflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDZ3pXTeupJrLoQPFdYIkPSU8s6p/c+vJWf8OKGgZCs=;
 b=lXdeR7lHDDdYZvK1HH557/omaDcohOEkMvqU9mPGUfi+qO/Ip/bcKC2EPVzcmZw4YvFMu9WEFmr/4rywHtLwudyXwGCqnXkZT1vWeWJ6wZM4tHgpfn3QUVC6qS+UvRGLrJbuN7cI13+0jlD0ZpNoTbzlq7Gf9D2KmENdVo6wlfKnqv0WNy3apzGCi2ByIL9zLJHO7KEx0N3MEKrDcLFE1pTUzc4mrjwlRhDM4pEAxIwweHiEveMCzzVCMGxXECt/RVYSesY9LbneifJ93jhEPXt/Yqcf+10XEIsg/uYFetAP3Uz5037VKjt3HKdfNRoorMFYu/qgpfoaHHZCJsq/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=163.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP301CA0004.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:386::12)
 by SEZPR06MB5522.apcprd06.prod.outlook.com (2603:1096:101:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 05:42:17 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:400:386:cafe::b2) by TYCP301CA0004.outlook.office365.com
 (2603:1096:400:386::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 05:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 05:42:15 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A986F410F606;
	Thu, 19 Jun 2025 13:42:10 +0800 (CST)
Message-ID: <02c3d0b2-e97e-47ce-b472-4525e8eff68a@cixtech.com>
Date: Thu, 19 Jun 2025 13:42:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for
 register bit manipulation
To: Frank Li <Frank.li@nxp.com>, Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250618152112.1010147-1-18255117159@163.com>
 <20250618152112.1010147-2-18255117159@163.com>
 <aFOSIj1fimMwWCT7@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <aFOSIj1fimMwWCT7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|SEZPR06MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: 2981461e-5167-4376-8191-08ddaef40c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3RiWjUrNUNWa1Z1b3gzR1ZsK3hKLzlhSXY0Y3JKSGJDdGJpdHBSaDZyT1lK?=
 =?utf-8?B?VzhqdzBSdHQ4YThTUzhvcHRDd1BCUkN0cThFUzJ6WEdxTXRYcG1LSjBhSU5x?=
 =?utf-8?B?dUp5bXhJRFVUWGM2a0h4QmVHcElubUxjUk5UcmU0aEs4RENNZVBVVW1QQ0Rs?=
 =?utf-8?B?OEtmZXc4OFNZNVhrK01vQUZ1T1NYUk9adm5VWmliLzJLZEx2Q0g1eHFSVUhE?=
 =?utf-8?B?em1lZSt2VXA4Q3ZlcmFGS1ZlWGxCYkNscFR2bzdtSFo3U1FWNFhMbHM4S3Vj?=
 =?utf-8?B?QWhmMjNLR1hDQXJqNFFFWnp1WTdOVnF6U0hUSHEvNnBLc3pmd3RqU1NJaEly?=
 =?utf-8?B?eTdCY2szUW4rU3RjZjBnR1VVUERRaGF6S3UrbzAxMnhBeEpzUFhnS3ltYlcx?=
 =?utf-8?B?cThUV1RaMnUwVTJ6M3l3TXlCSXN4RC9HcUJNa1NhVk13WFZBVDJwaG53QmFz?=
 =?utf-8?B?dzUwRmY1TklGNEZ2TGIvRTB6V3l6TnEzM1RnRWN0OVFnM1NSZngzWHJHNDBu?=
 =?utf-8?B?MmlaNUZqRHAxYTlHcEpCVHN5MFM1a1FTUEN6M1hEMTloMktKNUM0TFZpc1hK?=
 =?utf-8?B?SEdWa1lBTnpjdTFxbGhTTUF4N0QvVmp6bVNSWVU2M3FXS1JuWVVGd0JmWm5p?=
 =?utf-8?B?ajFGaDV2MytuWXRKK3psSGc2MHpoY210NFp2eFY1N0Zvd05VKzBReFFRVlpX?=
 =?utf-8?B?OTdRL0czM0phcWlZR3dZeUFOWEFBOFNoay9RanJZMUNIOVZvWWVkWHR5ckxy?=
 =?utf-8?B?eGFGeG5URXV1TVllYWVhL05ybEZ1QlI2ZEhFcG1wdlNrUVJHM2tsU3IvRko3?=
 =?utf-8?B?eXhSU3MyYzFtVEhVVmtBV0d3dUJlRS9EV2ZCVmk3Nm9XVE5YdkN5Mi92OHU5?=
 =?utf-8?B?TEZ6MjdHMi9LNWxvbUdQeHF6ald0ZWU0NHU1a0RoNTNiZ3dRVmNxdGNRV0lZ?=
 =?utf-8?B?akJLZGJtVlRiTXZCU2Y5aUZGK1FORWlDWjdNT3Z3YU9YZFR3NXppbTZiRnpD?=
 =?utf-8?B?em9mZDVXR1FiWHFDRXgzS1Rlcmw2V0Jrd0plMHcwRlFLcXk1SlZVWjdDNzM1?=
 =?utf-8?B?M2FESkw4d0ZhTDJ3UStXV0FYUVNDL1hvZ2hCQmo0MnJFWlpDQTB2OXhMdjRh?=
 =?utf-8?B?TXltUkVkY0JaOHl5UFhFak91ais3L2cwZTA0WnExd3B1VDZ4WTJIRit5RmV6?=
 =?utf-8?B?REJqdk9kRzg0aUIyMnk0N3V2RUNJQU1NUER1WXlqdStocVcyNTNYQUp6eUs0?=
 =?utf-8?B?YWx5aUlHd2d6L2p5dHBQWisyM3dqQ3RxTmlOL0IxYVZQSXo2UzFZYjhRV2lQ?=
 =?utf-8?B?eUJTS3MxdUFjV2JrY0dmdStRdURhL1NHY0JHSHAwTnRuaHFOTC83MWRLTWtJ?=
 =?utf-8?B?MStnSHVQTGlRYzlheGR2UVg1dkNjMWpwaStXWnhybHdHUkEwNFVRN1dWa3Jr?=
 =?utf-8?B?RDkwNG5lM2JML2oyV2F5d3oreEZXMDBDZm5LRmtIQlhjRXBVZCtTZEVNSWRK?=
 =?utf-8?B?OVdMMHhpcGpsbXRLeEtEZ3JzQk9KMldtaWI0aU8zeWlKREp5ZkNQeE0vbENk?=
 =?utf-8?B?YzRxU25uN3NyQUJkeFZUdWIxbWYxNWszMFFvVTJpRDlCWGtlOFFmZ0RLK1Vj?=
 =?utf-8?B?UzV2L01JWENXbWJSR2FPc3pnTmR4RkpXZWRSa3FkK25abDlHTVM1dWN1YVha?=
 =?utf-8?B?WlQyczRFNHhNcEl3Szd2b0x5N3N2cGhwSU94MmpueXZML2pkMW1NTGdRdTBS?=
 =?utf-8?B?NVIwYjVibEtOMC9PazlMQjJvbVo3RExmUDExY20wMHdYdElIOHoxZE1TdzhK?=
 =?utf-8?B?YzBJL212S2tzUzVNQnBIdGlIOHZZMnlEU1ZmbVdsQml1MmwxTU1wTUFiSklJ?=
 =?utf-8?B?NTg1OUp3U0VhZzA4R1RzWHRUYmkyb0RhWUM1bVJ6dmJtSUR6SUdzc1VjYzNx?=
 =?utf-8?B?U0hWTnlMMDlDODhTeFJ3bFp0UGEwNEttazhDV3NBb0FhaUdWS3JONjY4bTM5?=
 =?utf-8?B?eG5VR2RLUDdPcHB4bk1PMzVSamM1SDY4eGFBSG9xTFFjK1pyZnUrVy81N3Fo?=
 =?utf-8?Q?JMYSEP?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:42:15.6241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2981461e-5167-4376-8191-08ddaef40c56
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5522



On 2025/6/19 12:29, Frank Li wrote:
> EXTERNAL EMAIL
> 
> On Wed, Jun 18, 2025 at 11:21:00PM +0800, Hans Zhang wrote:
>> DesignWare PCIe controller drivers implement register bit manipulation
>> through explicit read-modify-write sequences. These patterns appear
>> repeatedly across multiple drivers with minor variations, creating
>> code duplication and maintenance overhead.
>>
>> Implement dw_pcie_clear_and_set_dword() helper to encapsulate atomic
>> register modification. The function reads the current register value,
>> clears specified bits, sets new bits, and writes back the result in
>> a single operation. This abstraction hides bitwise manipulation details
>> while ensuring consistent behavior across all usage sites.
>>
>> Centralizing this logic reduces future maintenance effort when modifying
>> register access patterns and minimizes the risk of implementation
>> divergence between drivers.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.h | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index ce9e18554e42..f401c144df0f 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -707,6 +707,17 @@ static inline void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no,
>>        dw_pcie_ep_write_dbi2(ep, func_no, reg, 0x4, val);
>>   }
>>
>> +static inline void dw_pcie_clear_and_set_dword(struct dw_pcie *pci, int pos,
>> +                                            u32 clear, u32 set)
> 
> Can align with regmap_update_bits() argumnet?
> 
> dw_pcie_update_dbi_bits()?
> 

Dear Frank,

Thank you for your reply.


Personally, I think it should be the same as the following API. In this 
way, we can easily know the corresponding parameters and it also 
conforms to the usage habits of PCIe. What do you think?


drivers/pci/access.c

int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
					u32 clear, u32 set)
{
	int ret;
	u32 val;

	ret = pcie_capability_read_dword(dev, pos, &val);
	if (ret)
		return ret;

	val &= ~clear;
	val |= set;
	return pcie_capability_write_dword(dev, pos, val);
}
EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);


void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
				    u32 clear, u32 set)
{
	u32 val;

	pci_read_config_dword(dev, pos, &val);
	val &= ~clear;
	val |= set;
	pci_write_config_dword(dev, pos, val);
}
EXPORT_SYMBOL(pci_clear_and_set_config_dword);


Best regards,
Hans

> Frank
> 
>> +{
>> +     u32 val;
>> +
>> +     val = dw_pcie_readl_dbi(pci, pos);
>> +     val &= ~clear;
>> +     val |= set;
>> +     dw_pcie_writel_dbi(pci, pos, val);
>> +}
>> +
>>   static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>>   {
>>        u32 reg;
>> --
>> 2.25.1
>>
> 

