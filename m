Return-Path: <linux-pci+bounces-26781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D12A9CEED
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9110F4E28BC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D41C3BE2;
	Fri, 25 Apr 2025 16:51:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021104.outbound.protection.outlook.com [52.101.129.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE51DC98B;
	Fri, 25 Apr 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599910; cv=fail; b=D6rUG37NaKc2XTRLMsfkY96Cf2I9NCRyvNpxcZhEQqHsWecU4FjiHyIBj3t6XG4cmIhbFc/I64rlwiWUXBCMin1SfEKNaGIV5BTn25f0hp1nG1hEviibkmHNckwzJZreoGuU7UJGSa+hqkpwUsLvRVPpFV7IrOvztCLzE9NWdOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599910; c=relaxed/simple;
	bh=oypVbg1NErWPm5xfBnRIBiyKvTcu+nesDvtZRlWYSbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5//6mIEh5RYYMIHRXVcGXC4xrVYJ3LDhUNPdYNMWYdiBHC/0PAOY9NzUHrIN+hk1mgob0wTRJEY4VKJNqUE69YTdaU5p+xJzQ4yV7SCtbMZy6SjPLM39yTmxIcOBIdbhSeIXzazrWN64SGHxHz+n5Pi88a9Dl+UTHFL2KqKwPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.129.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiBqeTh3Ud0TPW/MsSdB5d/GUx9hivYQPEy6ZmHeiVOthhPZU+O9nKmOYFfH5gzNf9DaRqpV+nwfWJBJyxzOuTZ+cwgMw8SPfW73wfI4AbYGtykXZIWOT5yTigSQsATbiv/a5Sld3Xu0KTIQhY7uBh5HVIvPHMMFY1IXeCX2yoOsc+mgp+GycKkN1EPz1hQh8CCSkWE9NTUhqAKnTEVweuPH/2Z0AtNPhlE1tu1JsP0zNJ6XkZ7pUZ5MLiQrl1FhOJhjBNgYcjT4pFWfpFKtNqWYZQcFvY4DwmQvmkEHLKZZ9AeSrNWBKLg9wj32o5sMrLxnnvGaXSDLdT5NN94lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0zQyp1CHTDi52dNyCdGyr/hvXjfaYJjAMZd9RQr5rU=;
 b=d+sOU/v6NbeVlKEMMc+gJi7m+TIgCDho/70rDUAwLR3aLy4p3965jbKh+ZblVvJ1fjMZK7lKufvd8TxcLNtQ6xu+5onoahb0L8XLeEX5LCtktY0bHrjoCJXBi+KoNMD9dA6R12J+Th8Vbe/TxFrV75wPn3isZ+wpPbBkRJ/qr/tyuuS5xzFllVJ03dNHYohbygMqKvIIyV8lBoVWeCBppgVlBxWLYW/d1HKgXUdYvvvgxP7u8dcg6Z2uH8TiX56j3kqMef5+jPaWs+R7aqBfbXXKiR/0w/stzEHzqFvNMIYspN4laW10QFWerVfPUO3tZK520KkWYLlHca6AXGLfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PUZP153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::23)
 by SEZPR06MB6531.apcprd06.prod.outlook.com (2603:1096:101:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 16:51:43 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::cf) by PUZP153CA0008.outlook.office365.com
 (2603:1096:301:c2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.11 via Frontend Transport; Fri,
 25 Apr 2025 16:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 16:51:41 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 5935940A5BFE;
	Sat, 26 Apr 2025 00:51:40 +0800 (CST)
Message-ID: <e6c84c59-e784-4631-8076-98c6461b8c15@cixtech.com>
Date: Sat, 26 Apr 2025 00:51:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and EP
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: peter.chen@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manikandan K Pillai <mpillai@cadence.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-6-hans.zhang@cixtech.com>
 <25f5e8e4-1b64-478f-84ab-eede2c669655@kernel.org>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <25f5e8e4-1b64-478f-84ab-eede2c669655@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|SEZPR06MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 52321e5d-9544-41b7-8a4a-08dd8419747a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlA4U1dhMGNOc2I5U1RqQWdNKzVrbzRTRXVvSm5peS9RN0NkMFlQSW1jSC8r?=
 =?utf-8?B?TWhMdHpENVZhYjhUcEpiVUNKKzk5cmZJckw1YW1QYmNaTklNc3krWHFyR3lK?=
 =?utf-8?B?MFF6emNlL0RUTWU0clYza0luc08wdVdPL0o2VklKRHpSVTJLU2tVeU9BMFpG?=
 =?utf-8?B?S3NwUGtkeXdUTmFsK2lqOHVLMWRkZ0I2VEh0Z2U3UU9IQktvcDQxZmhibStF?=
 =?utf-8?B?dmtsNmtCU2JEZEx0dEE3aHlZTXd2Nm81cVBwcm5vTUdoazBjamdXd0hWekh0?=
 =?utf-8?B?blVhbmJKcXBDNE9VM0RobE52MGU0WkJTcWFkdkt6d1phaGlEVUpJUzJXY2dM?=
 =?utf-8?B?WDcvay9SSS8yTkJzL0NTYVdtb25wK1dCQ3AyT3V6SUkrbTNCdUxWU1BaNXg3?=
 =?utf-8?B?TnNaTkNEM2tMNDdFT0JKVi9MZlJnZVI3TURmamJXeTBidkJBMUF1ZGRQWHRI?=
 =?utf-8?B?cHNXZWlCUExEQWlHVDFoLzc2ZzNEY2tyZiswcitzZUN1V2ZGaDhySjNxdVJa?=
 =?utf-8?B?c0dsSkR2UXNPcjJabm9EWks5UVJrREs0NXh1TDZ5OWtJK3RKWjRaRWNGRndK?=
 =?utf-8?B?YkFOd1U5MTFYaUNZTzNPZFI1ZE9oUmtiYmdieDgvOHAyaDVtUi92eGVPQ3A2?=
 =?utf-8?B?ZkR0TlNQenVDVkthd3drcllkMzYwdTBFbmlTTkxUTzZURjhzVU1QVjJxYWJr?=
 =?utf-8?B?dndtRzhsR09MZEFsNHVFYTJ1bDFWRkpCRXlSZ3UxUFZ4d2FkYlhaRW8zRnBD?=
 =?utf-8?B?M2ZTaEVGK28vZ2w2d2dyQ1ZqUVBTOWw4Vm02aEJLWWFDRUJHbU1aS0E4L1lC?=
 =?utf-8?B?WGJ2dCsva0ZycGNsQnhvaVpoUG0ySEFmNHJFNkU3cWFVSXBDV1NUQ082Mm53?=
 =?utf-8?B?em9vVGRTWUw4VCt1VGk1Q1ZkMUZrNmdHbXVFV2szanBUMTlQbWtnOXJidUdR?=
 =?utf-8?B?YTZiRjQ0S2xrUjkxNDZ6YmVlTVI0TmJkZFBZazBCWXRCV2N1allHdWJBSWlU?=
 =?utf-8?B?cE5wYzkrb2o2aG0zZE5EckNZRVNOY0wrWHhjZEREZElDZis0aEJISDJNVDZL?=
 =?utf-8?B?Ly9vQzN4eUpKMGJpMXJjckhlOXQ4SGtUalhVS3dncklHK2FjTGlySFpLbkFC?=
 =?utf-8?B?QlBDemp5bW43UVM4R0p4YWFndXVwZFRMMHVoNXhQNVMyUnNvSlJYVW9xS2RM?=
 =?utf-8?B?SU5peTFJczQwdnlLd241VFJWd0Eya1VQbGxWVDNPQW1HdXRJSjJWU29SL1Bo?=
 =?utf-8?B?SlJkVCtLMkQyWFJYY25qTGFSMWtpS0ZQSy85Wjd1VE5qVXpTOGxaUVBoc0Zt?=
 =?utf-8?B?UDVxYUVNWnUzRnJqNTV2aVBxTENJM0NEL0c5QVJVcXBmQlAwQ0FQZW5rMUNs?=
 =?utf-8?B?L1FtTXpDU2wyeXdPTmxCd0NmNFp1bS8vamtKbGdPTzV1SURaMjdIZlBoOFBo?=
 =?utf-8?B?ejIwTGM3dFN2Z2p0ckxlakJkZ3pPUXJJU3hHbDNYNVY0TXorbWdmajFFaHcv?=
 =?utf-8?B?YlRMaFZyY0ZvR1pIY1NYOWxUT0xkRllmbERZekM0dmptNjU2NXJiSWpPY01S?=
 =?utf-8?B?M2dUai8rdHo3S3d1djNPUmZGL3ZPZUtBQUpTcXVWaG0xcmNvV1BFUmZIZFZo?=
 =?utf-8?B?RDcrYmVCOEJ2SmE1VkV0aHMySWtsTWpyK2x0dFVnZ1dBTmNNajNLSW5sWmoy?=
 =?utf-8?B?TkN0QVI2TnAyUFZma1NhRURjSXUwZGpZS3hxZ0w1V2krY21NUVpvOGpjbW9j?=
 =?utf-8?B?Nm5BRDZqdzc2QyttTFZ0UXIza0NnU0thT2pOR1FtUjlQeUJIRnZ5aitiRE9r?=
 =?utf-8?B?cVV6cjBNTyt1NGZ3REc0REVBdnoyL21rN2pFUU04UDN0R040QUZxenVoeUph?=
 =?utf-8?B?QVFscUY4SWFyWWRNVm5JcnQ3WHBDUmNuYllqKzI1TUFWMlB6blFqODM2dXdI?=
 =?utf-8?B?amRod3N1VE0xM1UxeGpubVVhVWNkWnBQRWZDTzV3WCs4SHAxQTJ6QXNIRVJS?=
 =?utf-8?B?dXZBd250eGwzbGoyOWYwQ280c3diZzJwaEU4UHVEZzJJdTE0dFRnUENHeURY?=
 =?utf-8?Q?nmVANc?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:51:41.6901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52321e5d-9544-41b7-8a4a-08dd8419747a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6531



On 2025/4/26 00:27, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 24/04/2025 03:04, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Add support for the Cadence PCIe HPA controller by adding
>> the required callback functions. Update the common functions for
>> RP and EP configuration. Invoke the relevant callback functions
>> for platform probe of PCIe controller using the callback function.
>> Update the support for TI J721 boards to use the updated Cadence
>> PCIe controller code.
>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
>> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>   drivers/pci/controller/cadence/pci-j721e.c    |  12 +
>>   .../pci/controller/cadence/pcie-cadence-ep.c  |  29 +-
>>   .../controller/cadence/pcie-cadence-host.c    | 263 ++++++++++++++++--
>>   .../controller/cadence/pcie-cadence-plat.c    |  27 +-
>>   drivers/pci/controller/cadence/pcie-cadence.c | 197 ++++++++++++-
>>   drivers/pci/controller/cadence/pcie-cadence.h |  11 +-
>>   6 files changed, 495 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>> index ef1cfdae33bb..154b36c30101 100644
>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>> @@ -164,6 +164,14 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
>>        .start_link = j721e_pcie_start_link,
>>        .stop_link = j721e_pcie_stop_link,
>>        .link_up = j721e_pcie_link_up,
>> +     .host_init_root_port = cdns_pcie_host_init_root_port,
>> +     .host_bar_ib_config = cdns_pcie_host_bar_ib_config,
>> +     .host_init_address_translation = cdns_pcie_host_init_address_translation,
>> +     .detect_quiet_min_delay_set = cdns_pcie_detect_quiet_min_delay_set,
>> +     .set_outbound_region = cdns_pcie_set_outbound_region,
>> +     .set_outbound_region_for_normal_msg =
>> +                                         cdns_pcie_set_outbound_region_for_normal_msg,
>> +     .reset_outbound_region = cdns_pcie_reset_outbound_region,
> 
> How did you resolve Rob's comments?
> 
> These were repeated I think three times finally with:
> 
> "Please listen when I say we do not want the ops method used in other
> drivers. "
> 
> I think you just send the same ignoring previous discussion which is the
> shortest way to get yourself NAKed.

Hi Manikandan,

Please reply to Krzysztof's question.

Best regards,
Hans

