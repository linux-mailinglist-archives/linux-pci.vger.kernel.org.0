Return-Path: <linux-pci+bounces-41470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D2C66B14
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 01:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E6954E1355
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 00:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11B2144C7;
	Tue, 18 Nov 2025 00:45:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022122.outbound.protection.outlook.com [52.101.126.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC735D27E;
	Tue, 18 Nov 2025 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426721; cv=fail; b=gKDYA2ymSNlEZQUXTbVsGBTScrFHUvccCzEaxIxkRUcmEC9OARIgtW0rUEbvFF7uVpDqFEMAw04+bkVYfQpHGUMoIm9vxVCWZqX2Fnt7mJTOyI0vI4SJ10ZLEBsvXU2LsITdLEOSOWrACcgJqjJAQxEbsun5R2VLQlWS+3mPnn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426721; c=relaxed/simple;
	bh=IS1ANQWeQCYcFhjbGRh6yMIMyHHtuXBm2i8qrMxDe/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dc0ZvOEg5kCMABOGh0dxFhPEk/Ckze+sEpNoqRZjy3xYMTzIk03/kwmHOS6Ha5BqkXA5PdjyqYA3top9+0454F8XuJleyh2N32pq689BvatTMwN793x1aqwwPpAFgUBqSb/X/uj/EEztAdE7MLv1CLrwIBu6ORp2b2SK4QK9/JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdaDafT7HC5u8tgoF3UckXGS/dUXdnFgWpjtB/KHRBKXY4kFQ9/lK0AOxC7B4StqE1t/Sp/igF/gLgN6Yd6rrgNz9n4KBXP7toTKANgO8w/aHJJWTB9AyvdoU1LQAUfpFjmFBpRsRgaFtTsYVBk3oPMuX6y/GWu+gfyuDO+lpyxM8CpSX88OOh33v/bFInFuVRZ0X3gjupFVnpMcU5/6vkQpmSMB1MdOVv+FiE5jPsvXnLHPiGoPX0XynX8I96iRN74zT8F9Zjg4x0VrIzk37VODmDaqrJIt4LMsPvQUDttnFx3z59wFi+Pxwteaz+1WLjVYmG2cdRTsmBzaNgduJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyJ323Z5AhwEQzdPgj3mL5ZWT/g6bYsJ08EAboDc1LQ=;
 b=ee+o3KQ4q6twn9E8ZpsS19fD+mdW2xt3cpjGWbaYzMC5umF9cAkG/TjpkceB0mZHy1thEL+7NPEDKG9QFBrPU/c5vnQuSu2ob3LnPDgLtA0jIW+yXt0CO2NKZtoNp+gKEGtSZIQ6ixxgVwuA7vFVY5Wk7akaKZViu3KjyVjXQRXW6rPVgBJr8bRSWPr2i7yp4E7PGEZ60NVyRFmWkfTjc2xjw73St06J8wUW3U5yrt84nxrMOCK+f4eRWeby3VBbfyGUN3NhB8N6g03V/FTVgx/3EpofHnA29zWE+T7HyvDlOi7cwzBCn65FIkjfPdKIBfY1IBGvXO6k3ZwXkPX76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::29) by KL1PR06MB6517.apcprd06.prod.outlook.com
 (2603:1096:820:f8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 00:45:13 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:300:2d:cafe::a5) by PS2PR01CA0017.outlook.office365.com
 (2603:1096:300:2d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 00:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 00:45:11 +0000
Received: from [192.168.129.22] (unknown [192.168.129.22])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 8D7BD41C0145;
	Tue, 18 Nov 2025 08:45:10 +0800 (CST)
Message-ID: <52abaad8-a43e-4e29-93d7-86a3245692c3@cixtech.com>
Date: Tue, 18 Nov 2025 08:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117210805.GA2531096@bhelgaas>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20251117210805.GA2531096@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|KL1PR06MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ee2d28-5d37-420b-fb10-08de263bbb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1FUVVp3MmlFeDl5dkhtRVFnbythUTgzdzFFT3pXb0RGQ0wxaEROMEViNkFx?=
 =?utf-8?B?TWJJQmVLb3VvZ1U2ZVppcE1sR1lzY3cxcGRBbEtSQXNBekZqOVJEcmlFbVRY?=
 =?utf-8?B?aStXa0lPQ0tNUkNqZmc0MnRHU0dhL3BVdVJ5Sk0rTDlrU2JNSS9BdHZNT0xZ?=
 =?utf-8?B?dklSay9MWUZjcElmdFhoMU1XWTRHTll5MlhDY1FIYVAzbE4rM0ptV1FGUG1H?=
 =?utf-8?B?TVpIeHVoNnNkTGZIZ2d2NVdWZ2FLK296UW5qdWp5Q0dlR1FLUWVxa2NjaU52?=
 =?utf-8?B?UUJmUTRvN2hwME5rM1B2SHBkcXBCajEvVEk1bHhMMnk3QnlxTnA1aHlCamZz?=
 =?utf-8?B?c3JpdWlhcUJQU0xKTjRCVjRueEJWZFlEVm01S3JJcy9GbmQ2ZGN5M2l1WVlU?=
 =?utf-8?B?bFViZVZYd0x5UlJudTlIMEJUNE01SUVuelJ2YWd0a3ZkOE12MENrY0o1TGdB?=
 =?utf-8?B?dlA5TG14VDJ5Wkl0VU9aanB6b3VJc1VmNDV1UmJmNmU4SjlKcUh2NW5iRjAr?=
 =?utf-8?B?NnVMV3g4SEY5QjZIaFRrcWpyNkJ3R0g1amFEUjBySEFUZWxvSm8zQlRXOTdE?=
 =?utf-8?B?R0V2UG5SVVdTbkNIcXprN28yZXBHemtIN0pScytNdkVuV25FYUxIMDlwdUN6?=
 =?utf-8?B?Si9UNlNFV2xRdFJnU2s3MlQ0aTBHTUJhVkhET0kwcm1TNXl3amlBRU1zaXNM?=
 =?utf-8?B?UDF2NUVFUE9OS2Z6dWVnUjJSa2pzU244UnBXb3V1N0FoYnBaR3M0QnA3WkZP?=
 =?utf-8?B?M3Y4cEc3Nlg2RldDbmI0OEM1NWpwOERBbDIxVkxudjdLQnprelNFbnJjaUdh?=
 =?utf-8?B?QkE4d3F6ZGdXekNaMEpJaTJKTDB1eTRsMTc2QjdoWXNaaDZqMjFIbXJocGdv?=
 =?utf-8?B?cU15OGZFOVpGODNLRWtHWWNnZHVLRE9iSUFuOUUxSllpT2ZkcEw0WFgvRVRP?=
 =?utf-8?B?d1BJWUg1VWh6bGdsTEFuNUVUMkRROUV6VHlUWWZwYXRZV05lUWd3K29vL3RR?=
 =?utf-8?B?ZmJyYXUweUxhZTVjV2NuYjhCV2lRNnBxdWF4QjE4WGlvTHdpVGJ5MWVweHVJ?=
 =?utf-8?B?WmhsT2JsOE5mQk92YkJPMzlxUmk2RjhkZVl0QmpVMjVHTGsxN0E2MWJNQzlF?=
 =?utf-8?B?RnZIRUErcWhOUGZGNlF3MTc0cWJjOXJvZm4rRG1FaWdkTmc0RGZpVU04UDlD?=
 =?utf-8?B?MnJvYjY4cDRnRzZUbnFsZURRbjQvUW9WREE3eDAwWEZFaUxEYXlIcHRpcXcv?=
 =?utf-8?B?VCtJZDN0VVB1dXBWQXlaRTJDVkgyYUF6OUMraExnbjNBT3hXNEg4WTNaZmZq?=
 =?utf-8?B?YWFTY2JZSUlKRXJnOS9SbDRDbmx3K1prS1pEWlUxV3p2NFNBdXZCWUIybEpC?=
 =?utf-8?B?TXIyUDRkY2c4QnhPVWo5VDNvODk5aTZWd2hPbkZOWjZUTG9peXFQYVRYb0pk?=
 =?utf-8?B?bVJHL3A5czVsRlM2S1R4dEtDOU1KOVBTSXJ4ZTdSMTdOc0puQXY4NmFJZVFk?=
 =?utf-8?B?RE5BKzNhdEQ5VGJtY2lFTmhRS3dFS1lNa0RnS05qeHV4SWpXRDVVSWFjMkR1?=
 =?utf-8?B?OHBRM1NyMnBmNlA4ZlBkb2lwNVNMOElkZnh1Rzk4UisyOFhNRW01ODdESHkw?=
 =?utf-8?B?QUZsRHNPNFMycVRXMGlFQWtPOG1SRWl4TnZuUHJKWjFUQjZEZXg4T0ZnQ1NM?=
 =?utf-8?B?cEgxYld1T1Boa3M2VzE1WGlWVEFxNm1kTW9LREs1Q0l6QWRWZngzNUQ3WXJp?=
 =?utf-8?B?ajVhZjdkdTJzeWY5amdoYzBIOU5lZHNiTHAwd2dTZ2ZaY0hCMzQvSCtsd2Rr?=
 =?utf-8?B?cDZQQURWYkNnRGdDLzdCRTFxK0hIR1lQbVNlek9jY0QxelRyRW1lY0R6MEZT?=
 =?utf-8?B?NFVSVGlrSmEycGliL1lNZ0QwckkxLzFQaHBFcGV3elh4WU9uV21JUDJLblJn?=
 =?utf-8?B?SDY0SytaRHc5Q1BNMENIRUYxZXU1dmdkUzBhZGFYck9KOFFYWEl0dDlMSWh6?=
 =?utf-8?B?K3lNMHdVelFiekMzaFFRNXpTYkwzRXhSL0tuM0IrdTJPMlZndk96RktSaHJq?=
 =?utf-8?B?cUFEbjBsNzBXeTA4VWxaOHplNjVHYzl1L2E4TWl2ZkNBUU85OUt0Y0pqeDIv?=
 =?utf-8?Q?okJM=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 00:45:11.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ee2d28-5d37-420b-fb10-08de263bbb3d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6517



On 11/18/2025 5:08 AM, Bjorn Helgaas wrote:
> EXTERNAL EMAIL
> 
> On Sat, Nov 08, 2025 at 10:02:59PM +0800, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Add support for Cadence PCIe RP configuration for High Performance
>> Architecture (HPA) controllers. The Cadence High Performance
>> controllers are the latest PCIe controllers that have support for DMA,
>> optional IDE and updated register set. Add register definitions for High
>> Performance Architecture (HPA) PCIe controllers.
> 
>>   /**
>>    * struct cdns_pcie - private data for Cadence PCIe controller drivers
>>    * @reg_base: IO mapped register base
>>    * @mem_res: start/end offsets in the physical system memory to map PCI accesses
>> + * @msg_res: Region for send message to map PCI accesses
>>    * @dev: PCIe controller
>>    * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
>>    * @phy_count: number of supported PHY devices
>> @@ -45,16 +85,20 @@ struct cdns_pcie_ops {
>>    * @link: list of pointers to corresponding device link representations
>>    * @ops: Platform-specific ops to control various inputs from Cadence PCIe
>>    *       wrapper
>> + * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
>>    */
>>   struct cdns_pcie {
>> -     void __iomem            *reg_base;
>> -     struct resource         *mem_res;
>> -     struct device           *dev;
>> -     bool                    is_rc;
>> -     int                     phy_count;
>> -     struct phy              **phy;
>> -     struct device_link      **link;
>> -     const struct cdns_pcie_ops *ops;
>> +     void __iomem                         *reg_base;
>> +     void __iomem                         *mem_base;
> 
>    $ DIR=drivers/pci/
>    $ find $DIR -type f -name \*.[ch] | xargs scripts/kernel-doc -none 2>&1
>    Warning: drivers/pci/controller/cadence/pcie-cadence.h:101 struct member 'mem_base' not described in 'cdns_pcie'
> 
> Can you supply text for this doc?  We can amend the commit to include
> it.

Hi Bjorn,

This variable should be deleted. Mani, could you please help handle it?

It seems that Manikandan missed deleting this variable during the 
modification process. I checked and found that it wasn't used.


Best regards,
Hans




