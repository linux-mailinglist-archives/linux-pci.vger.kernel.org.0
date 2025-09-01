Return-Path: <linux-pci+bounces-35211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62301B3D6EA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 05:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2761E173246
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 03:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906531E1E16;
	Mon,  1 Sep 2025 03:03:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022109.outbound.protection.outlook.com [40.107.75.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08048CFC;
	Mon,  1 Sep 2025 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695804; cv=fail; b=htFCLrWf2aq2ZuiYOCFJj9OCetdjh8InbHjjl+L+IZufzfR8H1EpP935xzZt768iOHWvFrHGRe2sXHSJuiohJnZot988z5Xg2GFOwNfDG0Lcq8pNlAY+eC51odHNxdqkOlxjcjTCqTiCK2fINeA8i+ZNJaZxebiUvprSdkFhEms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695804; c=relaxed/simple;
	bh=yMA/k5kh53syV7IYV1i77CYnyVTTD+OPAy5ArTcs/48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXTh5dsH+kBobX08z/WD/bITe7f//X9r8y6G9uRLg+bVd/W8ilEPbpXYVKFk5KijBRvUh7iGliPQV+0fpbKMgJDL89vhV6f3kQY5YrLfCQNoALkW6tPCn/j3olB7JW6zHfuXKLsVk6u2Nf2BwSQniiKxqXsluzKMOfu909hax8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBM2/Rqio3m6bnCjQ/jR/W+ozgIKYJ1F0BJmzkWaz/a7mop2FR7q0MbE3v/NWSTQB1B/STgRUN1cNOwQCi1mRt5aUl4NvJ4Ik/sXqxtHDqdfmQOo/2B9KMhh3AK9e2PqWukIbVITFbByMd+XeUVQjXv93oM+0VIdH3hHm0KmtEgW8UDMj1h6cKXgWODK4sPnT4N2ZrTE1c9MYk2AR8sAPkA/K3GNkid0MFahEHNfQp9bsxu+ckVJAbxB0tlmuLvrnVapksMDgkA4kHMepkMZLggUkde8Rdliu51KN0Y0ZmXNbCALbaasBwkfd1Pjaxpz0WGGjJc700bT/Yn/Accfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNXk3/QmwO7I6AI5U3skLfxWTt5kEggQOKwjBqwJjtI=;
 b=sbi/cebho2RKuXAoeLIxdFSf+yANpfEGbueMc0tnHXbDRWIzrRp8XkV5TO7sPNOFNTjDhky0EPYDaq9GOlGTBOQwi3Dn85bd4diBJgQmDPK1MpR/pL2/ISbKY712gCqXBidQqoEOFjZoF9hO4rzs5n0ZIAKj2m7NNv4pb/9Cr+rtzAQJiSbboyGHLrmp9PaVHPoRLTYAhvGXZLyc70dQLR5gTOl8cF8asPTDgr8oNq/bzVmfnK2NzXFAThP6l/HYuI47t8FPZApDkUmx5TuTshXxBb2WyM/JnAX1DftEkhBCNyFVC2H3wrHhnMXKVnNFonWvrujVvRE2cHPummTaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0053.apcprd02.prod.outlook.com (2603:1096:4:54::17) by
 TY0PR06MB5233.apcprd06.prod.outlook.com (2603:1096:400:21b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Mon, 1 Sep 2025 03:03:17 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::56) by SG2PR02CA0053.outlook.office365.com
 (2603:1096:4:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 03:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 03:03:14 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C7A9941604E2;
	Mon,  1 Sep 2025 11:03:10 +0800 (CST)
Message-ID: <3d562be0-d3d9-492b-a894-f836a80caaec@cixtech.com>
Date: Mon, 1 Sep 2025 11:03:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/15] PCI: Add Cix Technology Vendor and Device ID
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
 guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-12-hans.zhang@cixtech.com>
 <y62iiqee7w3ogttzaboulkyea2b4srbta424adgjcrflx4c7or@uq6en5nyctl3>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <y62iiqee7w3ogttzaboulkyea2b4srbta424adgjcrflx4c7or@uq6en5nyctl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TY0PR06MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5307e7b4-1212-45c5-54b0-08dde9041826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THNqSWx6ZE9qODBlT2tKYlhNaG5vb1FBOVFheExLOURMYkRpZ3BqaXFBV3hI?=
 =?utf-8?B?ZzliQnZDWFJrU3ZxcS9jVWt1RDliYnljSXA1cm1VWUp5bjVuNHpTcHB2M3FN?=
 =?utf-8?B?WDNkZCtWY1ZqNnlFWGgzdXgyR0NhbERkdGZQTGQ0Vnl2WFY3MXZjc2lCNVNU?=
 =?utf-8?B?NWk0bkpVVngrWkxQNEROUVdsSjlSREZZbmhGUzVjRVVia056R0F1VnJ4NWpB?=
 =?utf-8?B?dUpramJRU05ySk9YR0cwRURhQ1FVcmZGMkMxbjQ5bkhDSXI5WXpERmdIbnZn?=
 =?utf-8?B?T090UzA5M2lGT3hMaEVGSmhPa0lJcVZoNG1qb25kVGtHKzA5azNvTm01cGtK?=
 =?utf-8?B?K2JmWjRrRTFBSndoOGFUVzlaSDg5Z2VLczZxRGtaSkF2TTcvcnkyZE1PWkxR?=
 =?utf-8?B?OWZYUGdyRkhrQnBpcmxmZitNK05YMEZYRE8zbHFacGlUOFo2N0JZNDNLSWl3?=
 =?utf-8?B?RnU1RVk3YjA5enlZV2tOUkxSaHg2Undvbk9BM1N3Z2VOejVwczNES092UGZW?=
 =?utf-8?B?L2N2REZNUk5hZGRhUXV2QWZFekIxbC85U2R1Zm9JSkhKYXozdEJ6clk4ZzBX?=
 =?utf-8?B?bHVyMG1WVXJkZ0ttd0EvRFpUZ2YvOU8zMmMwZWwvcjA4NHYyRzNxNVZDKzNL?=
 =?utf-8?B?NGhabXNQb0EwZjFxNkRhMXgvN1Y4MGxIVTVsRzk1RmJsSzgrKzk4R2VtTCtU?=
 =?utf-8?B?N2JTam1KTjBPMVlocFJSN3hYUmxKN1pwV3EyQW9oQUFQNVpEK1J0bDJBdytS?=
 =?utf-8?B?K29XSU91SmpLV215RGlOdEpYVkNBamR4S2pqQmE1bmFXN1UzQXQxaVdGVU5T?=
 =?utf-8?B?Y21mc3BKd2M4WDYwZXhTYW01c1M5YU03Tyt3bDFMY0I5VWdtbEMydXRWVGxw?=
 =?utf-8?B?YmdpODBUemVodVZwUlhIT2U4dnV1THhRV0xzQjQ0WXkrL1cwTmJrQldWQmg2?=
 =?utf-8?B?YmJsZ2hoeEdVbUc2bmI2ek11MXVlbU5JRWZuRHdTeWlQdTA0ekcrRE1mdmdP?=
 =?utf-8?B?U0ZodmJ6aGt3dTFOeTdkT2tZakR2dTlmMThXYkkyY01zTWpNS2ZHTGdsRkdF?=
 =?utf-8?B?a29wSXB2MEFyNDRya3RKZFdXN2VkN3RISTkwMUE1N0NFYTB0cHordnJpR0Rx?=
 =?utf-8?B?YzV3STJtbGx6TGxHNEJkeXhIOFRqY25La3ZKSHk1WnIxMmxiQ3pSdGF0aTQ1?=
 =?utf-8?B?NTk2R3lFdlVhMjlNcExCa1UwcGxJeHhORXI5NHY5dHNYbjJnWUFRaUZUUDdh?=
 =?utf-8?B?RHJ1NWhSajYrWjFlN2lCU0c4b2p1SndLRG50VWxkUXRaYkFrV3VzaUVOM21m?=
 =?utf-8?B?V3p1VklHQlRxMktiMGJXWmRtNEV6YWpaaVlHWHZQcWQrK1U2Y3dHNW1peW1G?=
 =?utf-8?B?aUV3K2V6Wlc4K2dUZDJ2S1VMNlIxUFQ5aXM5YzVpNk9kZ0lKeEpWTGE5U3FS?=
 =?utf-8?B?c09JZDg0VElqQlRsTUcwNFk4Qzk1RHo3T2pDWmFzc3ZsNm1seHFVSUsrQ2cy?=
 =?utf-8?B?R3Z0MzM0enY5TXhldEdwMGJ1RmdDSEFkOHArZXZjdytlNC85V1I2NmMvb01o?=
 =?utf-8?B?Sy9CeUpZVTN3R3ZEWXdoSWNTSFR5RWJLVXRrZ2NzT0xEWTVnVk9scnFpemJZ?=
 =?utf-8?B?OVY2ZmtNbmhTYk1yYlFUQ0hoZ01aZlZzb3JuR0pzS3l6cUdHSEVxR2l3aVph?=
 =?utf-8?B?eFRFT2E5MFYvelJqSStLZ0VPazFuSWNGVi96MHZPSnBROVd5Tm0zQkx2MjVJ?=
 =?utf-8?B?YVR4bmhQVWdSV0FMQ3VHTHFuSSszNUZWYW5zZ3lJaVdsczdqM0EzUkpCdWxK?=
 =?utf-8?B?RXlaakRldndzU1Bjb0NYS01pMitHWFQwbnNkMkF2Y3RLSGM3YzJjRnltaWRV?=
 =?utf-8?B?WENxcUhRK0lIZFVHYjZEN0ZnMnJLNVY4cmRoQ2FlL2k5a3dHK3Y3S2Ixbi9G?=
 =?utf-8?B?eHV6dmJPK0VRYmJqRHRWeTRTWnBvQTdKK0NpOXhZa2VxV21MUTlHV0pzNkRj?=
 =?utf-8?B?YmRmRGhia0Flekk2VDBYRFN0c3A5Vi9rc29WWTV2YU9UQjg5ZXJKQ1Vibjgz?=
 =?utf-8?Q?y+CzGE?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:03:14.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5307e7b4-1212-45c5-54b0-08dde9041826
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5233



On 2025/8/30 21:21, Manivannan Sadhasivam wrote:
> [Some people who received this message don't often get email from mani@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Tue, Aug 19, 2025 at 07:52:35PM GMT, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
>> devices. This ID will be used by the CIX Sky1 PCIe host controller driver.
> 
> Nit: Use CIX everywhere.
> 

Dear Mani,

Thank you very much for your reply.

Will change.

Best regards,
Hans

> - Mani
> 
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>   include/linux/pci_ids.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 92ffc4373f6d..24b04d085920 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2631,6 +2631,9 @@
>>
>>   #define PCI_VENDOR_ID_CXL            0x1e98
>>
>> +#define PCI_VENDOR_ID_CIX            0x1f6c
>> +#define PCI_DEVICE_ID_CIX_SKY1               0x0001
>> +
>>   #define PCI_VENDOR_ID_TEHUTI         0x1fc9
>>   #define PCI_DEVICE_ID_TEHUTI_3009    0x3009
>>   #define PCI_DEVICE_ID_TEHUTI_3010    0x3010
>> --
>> 2.49.0
>>
> 
> --
> மணிவண்ணன் சதாசிவம்

