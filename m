Return-Path: <linux-pci+bounces-23031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00EA54136
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 04:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4BB3AC0D3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 03:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C91957E2;
	Thu,  6 Mar 2025 03:24:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2124.outbound.protection.outlook.com [40.107.215.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27A1917F1;
	Thu,  6 Mar 2025 03:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231491; cv=fail; b=Xn3pAjmJgMAEKLcZP3mYdAyYK3YDEkczju968G2NP5nf2zRt0l/sJR5FIKfjHOEtt02VrFvZgmYCswU9ms7pM3RVeEXj8CzPqDgZpYkeKXW/fjfKkJTbWh41LyT2mHBPOFbwhAL6cgYZ3px6ubABqi0DlMYdRp0t2/K0toKmBWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231491; c=relaxed/simple;
	bh=DygZGGTdy2zknfX0SgPBrGFXe84ETEpGyVs8gTOEIh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsittlZCGQANrB/ZJpuT8OnG39ry7HUORBDCNMK2O/33+z18P6ln+Ex1021DhOWamzL9tQrYt9Qj69sk8h0AhFGVi8JN7Mwd5NumcWL0CGPkXodWBBuwk0TqBrrYEtq2HieFMhjnA9Anp3szBGcPm9qZbeGpTtfVwenAUqNLXXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrVwBeZ+wRF4KzQV38UMBhtS0fd3Y0s2FlFZByliuZrRnXdzG3TO/cgX/yUypDqu+iIHEphMyZJCehqsU4XOZ0x74z8fqBiafvLlhwEAEisSJbDO6YYQ9BUvA7izq/vBPHwILccMF4i/BICBxSeGhwv5FJQBKWVceBV/6uZX3QcjEs/aHsvoVjOrtTT0Ddwgod9EAWmEmCBZY2S9VQC2IgDSgeoGDnOEofKZjGncx4fG8j8nyx9PlgoaKGLznRi97iXaBzV/aYq+IFprrH59bV6RE/J16j/JruZZ6VNbjt51tWX4Oy486KvpTiLmg554ASLJozbRSJEbpkXUoPxCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdlnHfRmCJLkoi7nW3b/ahMquVKTpHk9RVBbgIQQMBg=;
 b=B4H/heEH7YVSTewvSXkfsDiVGukxo9StSPWCwTa9jDCtNS+HSDw3V2Mqz50tVMT8sAvGDjzN/d4jG0BP2JVnFj9QIUf8v0nVn7xv3olKdOzvBXezveyKE/uHlc5gHhOACD1h8aadV7SYh2UQClrHO3Puj93nmqQbkBsaRuKagMaUh5oX9IiEAI88rX4+9tM/kua6XNP2730mRCdOfcRtQ8wHiXxx9pVsrBgKXHFYiffk+QiuSPZj46/fY+lUhyAIAbPaDI8Pa9VPsryCU3HbGnK8paL0Tk6yTmxiTAR6HdROdcVED2C07Z80BtHYWcs4YVwTMZ2uBUVh1t7RSDfOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) by SEZPR06MB5046.apcprd06.prod.outlook.com
 (2603:1096:101:46::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 03:24:43 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:192:cafe::7a) by SI2PR01CA0023.outlook.office365.com
 (2603:1096:4:192::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 03:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 03:24:42 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 234664160CA0;
	Thu,  6 Mar 2025 11:24:42 +0800 (CST)
Message-ID: <2112b1dc-7ac6-4d4b-a9a1-1b57d414aae4@cixtech.com>
Date: Thu, 6 Mar 2025 11:24:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pci_ids: Add Cixtech P1 Platforms vendor and device
 ID
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Chen <peter.chen@cixtech.com>
References: <20250305174931.GA304679@bhelgaas>
Content-Language: en-US
From: "hans.zhang" <hans.zhang@cixtech.com>
In-Reply-To: <20250305174931.GA304679@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SEZPR06MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: e784a718-2c1b-426e-fd21-08dd5c5e6fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUEwQ2NGeWJXaEJDQWZJTkNoTTYxbld3Ymx1ckd5ZUNZYlEyK3dNYS82NEJi?=
 =?utf-8?B?blpaUXBtVDlRcUQ4bmZFZUxZVkZPWEJTL21zdkE2QUFweVNjb09OSlIyeWtv?=
 =?utf-8?B?dUxwUy9pZW1hL0FuR3dKRWRaejRTYVJoMHZWeDg3QStoS1p0MGNwZUZFcFlK?=
 =?utf-8?B?Ni9SQTJSNU5mV0ZxR3lxNGllUFIvcjk1bDhJQy8vbS9UTlBUQlI4Y01lWFd4?=
 =?utf-8?B?Y1dmRnAyOVlWUE81L2NSckswNG5RQWI1N2drYS9zV2ltZDZ3aHZoRUcwWGZ2?=
 =?utf-8?B?d2FzOEdaU2JzT20zWVAzU0ZoT1l6OUYwRXlFNCt4VHI2MzJMaVk3dmt5eXBh?=
 =?utf-8?B?amVGQys5SktTZ21waUtYSUEwZDV0N0VrdklzTUZEc3cyTmhkSG9vK00raldo?=
 =?utf-8?B?MUhGQXM1dUhTNDFQbmxQbjVtc2s0UlJPUHpsOHpLYU5qblIreE9FbnhkWVB2?=
 =?utf-8?B?MklBVWlIV2xqL25xdVhCdXJpMTdNMXJDeXRDSlpVbzNSd3k1VTdxRFpoRXhI?=
 =?utf-8?B?RUZRZ1FMODJmNGR5K00rSDJRanpjODB5N3l2cFVzNENnYkMxb1NQYkhpV0tO?=
 =?utf-8?B?MkZDK2V2VlhhU3FOZ0pRQ2VOdDMyQWRHUkJNYVl0SlUwZWFqNHAvNFJ4NEJ2?=
 =?utf-8?B?VEMyZEJ0NjhadUI5ckJqVVIwNzFnUjltbHZPUFR4VmZVOFZqZTM4cS9qQ1Q4?=
 =?utf-8?B?UU94M2JSbHNKTTVNQXNJOGxpUi91YXE3Y2d6OUdUS0tCc1JqNmJCbktJMzMx?=
 =?utf-8?B?M3BIWGlsb2QreE8vbzltNUc3bVFWLzJJaEhSK2FuUkZnN3BFbkVuOUc3Y242?=
 =?utf-8?B?QjJEMDVLS3dLKzFKT2JTemQ4NWlFb05kRFc4NUZ4Vm0rcjNtM2pUamJSM1c3?=
 =?utf-8?B?S29ZYUZGMmMzWUZWdlFodjdwanFveEZ1YndGTmhPTi90NTFhamlNNDZXK1F1?=
 =?utf-8?B?MnVOaGpzZkoyMWxlMUlSMUFqUXg1dmQxZnZJNXEySjNONkQxbDExdGR0V2Ft?=
 =?utf-8?B?dG1FUXhURDJLaGxvM3VoZWc4dTJCdy9Rbld2R1NRSkNiWGwzTWtuamNjazlF?=
 =?utf-8?B?ejQ3V3hBR1lKbmRZS1REMkpWN0dFdi9qekN4YUR1K25FM1NRWmk3WTloaXdJ?=
 =?utf-8?B?SjIycmw0ZGQrSWthdjZNbDZWZ3Q4NWdzVHExR3hkUklDVm9vSjU5cDhwbG4v?=
 =?utf-8?B?NC9ZTkpKbGJsTjVUOTVlaEtBSSsrdzRXb1BLV2FOUmRzOGlNNDh3L1ZrVE1n?=
 =?utf-8?B?TFZLTkh3VU9kSkgwNTI4UjZoSy9xR3N6ekM4Y0ZiSkZLMkJNb2Rhb0x6Mitx?=
 =?utf-8?B?NTVLb0tOaWNtTHFRdlpvaVg5MDgwK1ROZTJ4UDhFTzdlN1lXaFB0cUlFbzJ6?=
 =?utf-8?B?RU5SUGc3TUxMYVJJa2ZyTktlQkx0Q1pFL0x4QStjeUFxbDlYQ21OekNDYklz?=
 =?utf-8?B?ZW1PT3VJNEQxVjRNUmJ5Z1A0bkZHQ3N6TGJRRjFGSWM4TEdkeFhSWTRLYVJ6?=
 =?utf-8?B?ZXJVaEFxUWk1eTJDTEhVOEkwOWZ5NHd4M1pWY2MwYjBiaG8xNHN4dTZGR2xt?=
 =?utf-8?B?bzgwajNZTzNER0l5SWdZYVdQckZ0NFd5SStPK1p2aFFOUUtQb1lOOEc0MFM1?=
 =?utf-8?B?VTV6dHN5Y0tnL2hIUTdKYWlhNEpkTDV2Ly9nMnRuMU5KOEtwZTRSREJ2MXRq?=
 =?utf-8?B?MXBQbG9VSWJsTjEwUTFEWUc5N0p6dEFWOGFGZ2FoUy9NMm9KUG1Pd1c4cWpu?=
 =?utf-8?B?KzNWNUE3dnJMVldsd1V3RXlXeFYwVmZ3U0FyOUxSSTZsSG9Ycnl5eFovaHZT?=
 =?utf-8?B?TGt1VHNOcEZJUzFPdnRqQjk3VVEzOHFPT3dQRnFaVXY1cTk1bDNvVGpibjd4?=
 =?utf-8?B?a1Yyd1pXTVV6YXZzUmxSM2hYMy9oVlY1UlFtTXIvTCtBeXNZT1NOdmFzdG5r?=
 =?utf-8?B?K1hCelE4bVJjdW5sd3Vod1RLQmdZSDhpdFcwZUc2OUkzUy8rNyt5V3lCUkI1?=
 =?utf-8?Q?FeMyZU89Q/iJ4ex051DsJR2KslsZDw=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 03:24:42.7317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e784a718-2c1b-426e-fd21-08dd5c5e6fd1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5046



On 2025/3/6 01:49, Bjorn Helgaas wrote:
> EXTERNAL EMAIL
> 
> On Wed, Mar 05, 2025 at 02:30:18PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
>> devices so we can use the macro for future drivers.
> 
> See note at top of file:
> 
>     *      Please keep sorted by numeric Vendor ID and Device ID.
>     *
>     *      Do not add new entries to this file unless the definitions
>     *      are shared between multiple drivers.
> 
> Include this patch in a series that shows multiple drivers using it
> and mention those drivers in the commit log.

OK. I will submit it together and use it in the future when our PCIe 
controller drives upsteam.

> 
> Update the subject line to match the existing style (use "git log
> --oneline include/linux/pci_ids.h"):
> 
>    PCI: Add Cix Technology Vendor and Device ID

Will change.

> 
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> ---
>>   include/linux/pci_ids.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 1a2594a38199..531b34c1181a 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -200,6 +200,9 @@
>>   #define PCI_DEVICE_ID_COMPAQ_THUNDER 0xf130
>>   #define PCI_DEVICE_ID_COMPAQ_NETFLEX3B       0xf150
>>
>> +#define PCI_VENDOR_ID_CIX               0x1f6c
>> +#define PCI_DEVICE_ID_CIX_SKY1          0x0001
> 
> This is not sorted by Vendor ID.

Will change.

> 
>>   #define PCI_VENDOR_ID_NCR            0x1000
>>   #define PCI_VENDOR_ID_LSI_LOGIC              0x1000
>>   #define PCI_DEVICE_ID_NCR_53C810     0x0001
>>
>> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
>> --
>> 2.47.1
>>

