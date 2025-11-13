Return-Path: <linux-pci+bounces-41078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD5C5709A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4777A349ED0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86568333444;
	Thu, 13 Nov 2025 10:52:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023108.outbound.protection.outlook.com [52.101.127.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD21331A6D;
	Thu, 13 Nov 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031131; cv=fail; b=OaTWdlshcWSZg8AdK3Lu553w50h1P5cQU0S/DgcT8mK6Exlf+axXAEFXbdrjdihhYwLstsE+Q2MHci18ULNqwAYTGrUbkuTWSqrIWU3IbpO9onpBq2atn2flFtMsCRVGyyK97g0xN12JFBD2Uv3Gflo2wvxVhJ2o2/Y8qDvU6qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031131; c=relaxed/simple;
	bh=uwS7SHK8bekkiID8pR3JiuZAmrkzPFKl2Kj3ePWrl84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiDE2rwVEwcIZmm4NrD3zV/LgE13krD5rDkxxTO1S5I6VmK1T6UgpmI2KcsOu1I2V2P/AasQ6AdZEh/W10MrWRnWzaN3sIO5t3MzsfsT97orQA9rWjytUuGcxlzSISNk/jfwZ1dcvoJVseJTwYyqUPnlfohkK9gVuwCk98SMjhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQiwIhCgz62fdfoIqM/du8vEJHMxXUaNJaR1/58SkGhGk/zwUk/g6NDB8djfX6q19DR/LI1y270KbMul7O51Dx8ClHGSHTxiPO+4/EqUsb6O4SpZ8LkVyABcTnKr+zxdm99abbLDVtnKlXoBDAZoY5YU0U2VUL4gNhiInYqn6o1yud1bS6i+b6jwD311kmAEs2Oa/rz4XP2m/qUjvvw+DHBnsMDoBJXqJi2OXeijP/c7gG4xE40OzI/6yR58Aeveq9Wx6eyZ2vubVD0PgVO66tx4kt7YZyH1V2wqR8tZh2+ZT5uPkn0wMSoFwwaVItEOP5/R+/btcl4j8rvGGiS79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm39iNR6dNotxR7n77foxtOdlkiTgJfxOdRsnvxB1C0=;
 b=bdzSxA2kmEEpoltsy+LeXr9wLL1DmrUn+sDhHpWm3L89NclbTTCU5AlBLuWXckr/UE2x8NctDhfZolFQRmsiAZd8G+SJ3NbmOQapAobdliZJ0qd0CSVVV5hdK+AQo1VN2h2aynOjS+TG3DA+1wHvrX9iw+5/6K/swc/gEGLtjPfxGDCJ9EAUUhYyiOhmAC9H0rL23U+kQJHA2FWA8+FCSn7i9B4lf8y11btkRuJ90WDDzgvZCfpCcOOOmCLxCvldbWJm2Y+rpR4Wnsx0zeiVOorbP0tG8O650wVdNJivd5p0BQCtXES8jB4gWuXM1A3J1N7NOVoqbPXEo5k1aIzSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::18) by TYUPR06MB6194.apcprd06.prod.outlook.com
 (2603:1096:400:346::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Thu, 13 Nov
 2025 10:52:02 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::57) by PS2PR01CA0054.outlook.office365.com
 (2603:1096:300:57::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 10:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:52:01 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 760A341604E0;
	Thu, 13 Nov 2025 18:52:00 +0800 (CST)
Message-ID: <d53942f3-fa4e-4d9b-bcf0-5d58eb6bf739@cixtech.com>
Date: Thu, 13 Nov 2025 18:51:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from
 tristate to bool
To: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, unicorn_wang@outlook.com, kishon@kernel.org
Cc: arnd@arndb.de, stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
 <da56386a-b6ac-4034-a063-811cd7d71fa5@cixtech.com>
 <d0516a4c5b9e5b04df25220a32c259cce89f7d1b.camel@ti.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <d0516a4c5b9e5b04df25220a32c259cce89f7d1b.camel@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|TYUPR06MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: b53b4633-d441-4d69-8cea-08de22a2acf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFpnSk5pQUlsRTlCSUN1SFQwYmV2V2xnQWdNcmhyRllUM0VBRSswZDdYSHN3?=
 =?utf-8?B?SEtDZTZVNi9ST3VLRGxyYlNlOWhmR3BsYU5uMjgxR2Job0ttSVl0eTBTM1ZR?=
 =?utf-8?B?bHo4UVljc3RsYTBTZDUzcXBtdHdTZUtMeEtaOGJWV0RucnVyU2M0WXY1b1BI?=
 =?utf-8?B?emN2NkQ4OXc1NDBFTHd5WFNWNEpPZ1VpR3U2d0RFNlljSVRvNFQyT0trYVdq?=
 =?utf-8?B?a1JJSys4S2RkaWhzbURHMld6dFNrVFRQQTJGbkNWRHY4MzhZNGhJdDBwK1Zq?=
 =?utf-8?B?cS9TK05qNGlBYUFpQWN4WkNVZTJpRkZrOENmSWhaWXdXRUtqYk9ueUNzNjVm?=
 =?utf-8?B?Y3BWckhldmF1SGhrNUNuRmxJMkttYVlhRTliN2cwUzJWMkcwRG1yN1NSNTJ6?=
 =?utf-8?B?bWNVZjJlRjJuWVUxVWU3MUFScTdVUTJaUm03bUxpRFh4TDBnV1VyZ1A1Z2NY?=
 =?utf-8?B?QldCTFB5cTBTV3dPY0VMVENJNzRsTTgvRElldlAwS2lsMEFuMHhDK2t3ME1U?=
 =?utf-8?B?K0lhaGxyYzVoN2dwZWYvMnJzOVBZOG4yeEthVUJxSi8wS2VZa1J0ai9IeXRD?=
 =?utf-8?B?YzFydWZFMmlMTHlpTGlobFlBOEdXcGhtdzhhWlJmTDlvYlh0WkFlcTcrdEtO?=
 =?utf-8?B?cmlGUzhteEQxOXNSYkNJZmg0bTVGVTU2ckJFVWwrbldkMDk3cjZnY3VWVEtt?=
 =?utf-8?B?ZFlhdzdwQ09LNC9tK21OaEpXb1ZqRm5hbjBQL3ovQW5KanczbUR0aWRVU0tK?=
 =?utf-8?B?VEhTYWZZMW9EV0dEY2F0MjVOL2RtMFN0YmRwbUxlRFJVeHhZRkl4MXFJR1hB?=
 =?utf-8?B?ZHBCVUQ3dzV4YW04NGowdmtYaWo1L0lYNU05SVpJQ3VjQUhEMFBJeEppeXpO?=
 =?utf-8?B?cW53NExSVklUd2lwTzlJcjRNN3ROVGs4VXFNcDVsa0Z6L09ySHVCTkIxSFlJ?=
 =?utf-8?B?bi85ZFRPM09UUUpLNmswNkxhOVRqNnBnR1FwVkJFMDY1U3Q1NXBRK3cwMWFw?=
 =?utf-8?B?MjN4bVVQVDhxWGh2Z1Iwc0NEc3g3YVJhOGg0eFl2SHB4NzF4OVprc1R6dUgw?=
 =?utf-8?B?N2hkOGRzYUFVQzJXdUVaWmJ3OHZCbHZmK1BUUkM5UGtpaFM5Yk0xUS9PWEVa?=
 =?utf-8?B?Z3JHQXFHZHQrOXFlOWQySVJsNDlsSmppelA2NDV2YnBONnBqb2N2dSs5OUxj?=
 =?utf-8?B?Z3dpNEF0S1h0bTVtUHl5dDVxWVZqSzkrL3haSGFuZzZJL0tuMjRleGpoS28x?=
 =?utf-8?B?aS9sMTZMODZZNHdsbUppYmNheXNGZFlVSWlUblBsMFk3WEpGaUQyN2F0YkM4?=
 =?utf-8?B?VjJvcFFxd3NtbngycXBIZlB5MFBhRzNLZWZiTnNmMldYMUlWYkZoWDhzOGxX?=
 =?utf-8?B?a2hUWTgvbjFxVlRHYzlTQWo4eUp4ZFlTVXlwQzZsWDVuU0ZKa2xvZEZ2aXlF?=
 =?utf-8?B?TkpsSHZSRzVZUDZnN2VybGlqdEdzZlBFdzZkYkg0S0ZpTmRZV3hnellSS280?=
 =?utf-8?B?VmxteklTOVhObkxFN09sdVpoWjJMSHFCV2Z4WkJYV3V4cjJablB1TEN6R1Bx?=
 =?utf-8?B?YWthdndYVUZiR1NtdnFQek50N0h1eFZxdmpLZk1WUnVWREJ5UFpvZVA3RVdE?=
 =?utf-8?B?dW1CMkF5dnRDNHMvYjk5UHdiOFJ1RzBFK25mVlpIbUlRS1ZXajIxZmNDT3lv?=
 =?utf-8?B?OEM5T3VhcEc0MUs0T25OQVRMSDhQQkY5Zm81OGVhR1d2MkoxdXdiNWJEeUNp?=
 =?utf-8?B?dS9WK1lqc0xKUE5yd042dXlIV0Y0NVdXQW5zTXpOenAyd3dzei9xcTh6OEFM?=
 =?utf-8?B?bnNnSGhDWHRqdzEzTW5GdExSQy9NenBTYzZDbG1NRTdtaVNYV2NERW02ZFlC?=
 =?utf-8?B?cjkxYUFBaU0vYVdraG1XcE1QL2U0VW1XMUFDcHdqSm45dW10YmhTbk1aRnBT?=
 =?utf-8?B?dXlPcGpwZ0owZ2dWMGQ5elBIY1V0VnIxNjAxV0NzNmZGSHhKb2F1TGRHTC83?=
 =?utf-8?B?QnJMcEV4bjU3SWVzeG51WW02SHhYMU1DemdPRTBHVDRvUjFGR1piUlc3K3Ba?=
 =?utf-8?B?d3l0UmJsQlYxRncwbjRmZkpvSjFaN2dkZjlwcjhOK0pUK1BNUC91bzduUU5Z?=
 =?utf-8?Q?Fi2CDnK1iTCSoi3Rd6L20yniK?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(32650700017);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:52:01.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53b4633-d441-4d69-8cea-08de22a2acf0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6194



On 11/13/2025 6:43 PM, Siddharth Vadapalli wrote:
> EXTERNAL EMAIL
> 
> On Thu, 2025-11-13 at 18:38 +0800, Hans Zhang wrote:
>> Hi Siddharth,
>>
>>
>> Your patch repeats this part.
> 
> I am not sure I understand the "repetition" that you are referring to. The
> patch below is updating:
> PCIE_CADENCE_PLAT, PCIE_CADENCE_PLAT_HOST and PCIE_CADENCE_PLAT_EP
> from 'bool' to 'tristate'.
> 
> The current patch is updating:
> PCIE_CADENCE, PCIE_CADENCE_HOST and PCIE_CADENCE_EP
> [No 'PLAT' in the configs]
> from 'tristate' to 'bool'.
> 
Hi Siddharth,

Sorry, I was mistaken.

Best regards,
Hans

>>
>>
>> https://patchwork.kernel.org/project/linux-pci/patch/20251108140305.1120117-2-hans.zhang@cixtech.com/
>>
>> Best regards,
>> Hans
>>
>> On 11/13/2025 5:27 PM, Siddharth Vadapalli wrote:
>>> EXTERNAL EMAIL
>>>
>>> The drivers associated with the PCIE_CADENCE, PCIE_CADENCE_HOST AND
>>> PCIE_CADENCE_EP configs are used by multiple vendor drivers and serve as a
>>> library of helpers. Since the vendor drivers could individually be built
>>> as built-in or as loadable modules, it is possible to select a build
>>> configuration wherein a vendor driver is built-in while the library is
>>> built as a loadable module. This will result in a build error as reported
>>> in the 'Closes' link below.
>>>
>>> Address the build error by changing the library configs to be 'bool'
>>> instead of 'tristate'.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
>>> Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>    drivers/pci/controller/cadence/Kconfig | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>>> index 02a639e55fd8..980da64ce730 100644
>>> --- a/drivers/pci/controller/cadence/Kconfig
>>> +++ b/drivers/pci/controller/cadence/Kconfig
>>> @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
>>>           depends on PCI
>>>
>>>    config PCIE_CADENCE
>>> -       tristate
>>> +       bool
>>>
>>>    config PCIE_CADENCE_HOST
>>> -       tristate
>>> +       bool
>>>           depends on OF
>>>           select IRQ_DOMAIN
>>>           select PCIE_CADENCE
>>>
>>>    config PCIE_CADENCE_EP
>>> -       tristate
>>> +       bool
>>>           depends on OF
>>>           depends on PCI_ENDPOINT
>>>           select PCIE_CADENCE
>>> --
>>> 2.51.1
>>>
>>>
> 
> Regards,
> Siddharth.


