Return-Path: <linux-pci+bounces-4591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCA18747EA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 07:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C1F2877A9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30D1BDE1;
	Thu,  7 Mar 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cok6DRvB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17E1BDE6;
	Thu,  7 Mar 2024 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791791; cv=fail; b=iE5+L0YMCA8Dw6j451d+jrMFNBwfrPR8cL38VYMWR+7iOiQQG4AXoN63Qz433Te0TC49Gyp4Zm1KXrZwcCNKYWJtWcbgS5vA99cmS2C8y6AAqE7uTEU0o0aLV3j9QGEAH0Q7fgA4ypQzJsLaMiTb750dWtCsOouleegn3jjpvWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791791; c=relaxed/simple;
	bh=LYLCjcnpUb0kdTQ1MvBpbkruTo4K8mANu52em2rLYkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2F/aEGe5tmqRPYj5hHP13bO5GO05jgU/goSdTgLIEHuS3E+R6VVIdyuesWbdyi9CS5Tjj80UPNmJsw7o5v5MROEcmAZFI+h/qvUUdK+ZuiLCnub3g6BIttOGpyiML+aQIXOZYyz5ZlFbWkqsFpfINTWBwQaGzn7oDKBKv/fihk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cok6DRvB; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAYdRLWtxEZZGifKM3kw3+pQACdGrIpNTQyIK9IBFHNoP+S2YKyOqz5qBysi9nr690oTdLxSDin+8A27XYMFdZ4ex/LuwKMnz6rMCBNSdEZDnG/P8rI/R24BIcG/WE/aQBoKdElgatJ43dOaZopSDMhnXBt45HbgkNJlcBaZLWUdwChQrV7Pd5Rzufo8c/9MaOKUjZQnu9z72Pn4EECKNzHgdXsrEmZOqyMD5tqdoZMNCbtu62n+2+60pPEyzI4I9ThmMCOEtkMZedp4G37eBqUV7WwqUQN3spg8wWJO3XQyZp3xFetJx9/CUE0H+pNiZiUdHNSdhmxU7/DDIypPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHie49l46/ytonxuzwwiY9dmwfKRx6qDUyA2yVhAMPI=;
 b=MCNEu3RSaXnDR1oyDUzMTpIKsOzQLsNBlH9vrnZRJQ52DlZLzVwNJV4O28h7a+XM5FT/oCac2UdMnQ+Ge3WXulE+QTgOueE04lqdn/6JSXZguw32lTEXSH3B4/X7myV4r57xAeo0roCOY8+/8YRnrZ7Qak3Lt+m7Zvcl1p/cw/PfUOBnirZNqb3WhrTYL/aqWeMI2VUgMkY9ptH/NTnmDFn4/Zgqp8X12upowJEJ5x9/zjiV0kUsuuehg/eczdV4CMCcVskEfhKVRqOaFjzG038v13g6z/ncsOxXxUjMjP7KsY2b0/jwxp5E0KMmmKthKpdgGttQMU9lW/SeIDiVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHie49l46/ytonxuzwwiY9dmwfKRx6qDUyA2yVhAMPI=;
 b=Cok6DRvBYToL4rlkl2tunYXNWdCmei+xIG97JdDmZxm/lIb2BsQLk0/KkDEOBNhyz1OAE7KeQ/ARGHF9s+OHKsgFsBZ3nGyIBEcM8YfhC7Z+x+t2WUF6ykt64jh9iCKxEglpfHWyrgwrX7uM9wS96RWYvz956YLLs5SzL/5Am3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 06:09:46 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539%5]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 06:09:46 +0000
Message-ID: <16120a31-c3d6-48a8-9355-7b063e28d242@amd.com>
Date: Thu, 7 Mar 2024 17:09:36 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel v3] PCI/DOE: Support discovery version 2
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lukas Wunner <lukas@wunner.de>
References: <20240307022006.3657433-1-aik@amd.com>
 <32ac2ee6-26b1-4f37-bd88-db1ef2a31267@linux.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <32ac2ee6-26b1-4f37-bd88-db1ef2a31267@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5ac55a-fa18-41d7-5ace-08dc3e6d3014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GEaM1mVL0PxHcLHF6a8+8biahe+Q+k5CqyzdQRe/5jUE7qEC/bxm/9yHL+FUiuVvaL+DfWu73wxUInmsFuov1SfXilc6S45daSF7OSmmkztEoZskqCxILBdC1SeOYC2q7DaWWipWoWOCvyF6rWfGUeBtDmXNa/xd187GucKf06X+pMtz7WZ10VQC1FikfFjOUij5uoZGF2bmooS36icDr1yg/2IWUCJBUhZmU/jw/dr9xgCm0Veewk4KbWoucWBxrSMuC/7xXqf3ODglndcv0NbH+tOkeYgH2twf0oMpl3T42mwl4Zc8EUkXlOH5bthNIJgyPEtoN8jAbNeilEO9RVz5lJxfzFYIKspjVyAEDqjVZfOUNORX6I/GNuZFNaujopIsYoUVDqKxyOFSOxFewHYelYE7WSXzHoi0NqeUNiz/2tsZzh096yrRNnRPbarYGzwHCs8PUw5k3ieaJDyKUdQPslPsC6j0KaJ+dfsHcnBOaQqbNlrVQn6crIXXIDfKBHPxlTNoNqcE3Vb3mUdHCw8OMbeIbRJme76NTUTcMgJipQzDMj6vNTtE7kFPA1mbHASEDNBFkibJb6uWxoj0iQrm9krcq8YTp+rOInH2+1/d6Y7pH1WdKrTI0IxRo36YsXwawNQ5QH5odq6xJ9BxKTyGLkQJgceyVd1k1qnXHTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHdGWkF1b3I5Yk1vbVlsb3dZMWFnQ1I5WWNVdTBpWDYwcWJSRHpqTkJ2M0pG?=
 =?utf-8?B?cXZ6bzNzckU4eTc0ME9FZWdGUEQvYVl2S1J0ZnYwQitTM2NOaXNvY3JVanpH?=
 =?utf-8?B?d1BJcEJGeWRqR203a0o3ZEpzQ0JaWEMrSk1ONUdGZXFQdG9hV1JGTzFjK1hI?=
 =?utf-8?B?S1hWWTcyak8zb2IrcWYySGRWQ0tBQ3NzRTZwUTNxN1d5UFhQVmp6cmlpOVQ2?=
 =?utf-8?B?akV2N2F3bkkrdjNic0M0K1dCS3hCYXA0RDNoKzFzSndDaUpJTmlVamg1NEdX?=
 =?utf-8?B?NHRqUkNOQ1JyemVOZmVlTTFyb0RyZ1JYUjVGeS8yRzBGZVdQVXB6ais3M3Bu?=
 =?utf-8?B?WUJFa1hLSUtBSFRPSTY0dkE5d1hDMUxPeE9kWG92U1FVZmJsaEMvNXFQajEw?=
 =?utf-8?B?UVBva0k4endNMlNBL250ZXFtVXhIMldQbURVL01Uc0pIL3NsSXdiSEhDaGk2?=
 =?utf-8?B?aEZZTnpGckc4WlJ6dzI5QkhaS2ZEb2JWQVpPbHNZTGZROFRoekpoSU0rNG9q?=
 =?utf-8?B?T0xtNzN1U2JPaGQ3bVRHNnlyeGJ3U3BRcGdDTHhpc0FRVHVVNjFnNEs0Ykxt?=
 =?utf-8?B?eFpBSHNNajJsNVZ1eGRwUVlTdm43dGtpS2gzakJCQ3BOQ3pGQm9sSE1lR29j?=
 =?utf-8?B?cVM4eVIvSTlPUEZ2NVJJNFM2OG5MUEZGNXJUdzV0ajY5aVRCWnY1MWM5SGI2?=
 =?utf-8?B?bUFtUHBwMEtaQ2NjWE1jb3owR1FlQ1pkVXpvRHpReDYvU3BCUmg1bGowdlJU?=
 =?utf-8?B?SnJ3WHB3N1R2Zk9ZTGNpUkRGUytPYUZvbWlRak05dEFlTHhKeGVsMTF6ZERz?=
 =?utf-8?B?blNxcGhGaHVKbWh5S0hjb2pJcjFMQ3g5aml0aFlza3c2UkxNMDU0Y3QzKzQz?=
 =?utf-8?B?RUdPaVVEQTdIaHBwWVNUV0x0ZWxnTmpDV1c2MHQ1cWdubFFjeHVvcjNXM0gw?=
 =?utf-8?B?dE1zVndYVUNnUGZBczRCUGpINytjcHg3S3A5YjU3dzF6OVlhNTh6enZrYkpD?=
 =?utf-8?B?b1g0c21zSi9IRW1tU2FPSWxQWmo3WG5DcEhuSmp3aG1jWXFqMzZteE8vNXhW?=
 =?utf-8?B?N3RXbGZtTlhaTGgrNkY4Vk9XU3gzYldXQndxRXo0MGJxaVBicXQ0RWZMWXdJ?=
 =?utf-8?B?Zjgza3p1cllYS21IZDh3VjlqQXR5RmpWQUR6Ui9YRVNPS0JmRnY4Uldad3ZJ?=
 =?utf-8?B?eWwxaU45cWI4VG9ubWFkT1JlVDUxSmFFdjRnTnB6ekhWZHlDTFhwWi9OTy82?=
 =?utf-8?B?aUxmcFp6clloRWt4T2d0cm1SNzg2VHMxZlZHNU1tQ0Y4czVYdFN3VWp2TlJD?=
 =?utf-8?B?bFhoUzlTR3lqSkp3SEJuSndRdjd6dktmS05ZaHBBb0N6TTRBUS9XZGF0U0t4?=
 =?utf-8?B?cHJJZWd5cFRweTVZcGxHbGFsRXd0aDJNeHNZekxndWFzNkROaUowM21PWHpP?=
 =?utf-8?B?RHpWeUhuNXpQRTAvcC9mYnpYN1dZZzFyVk5jdGNVUERXdkpvQWlGTys5MDMv?=
 =?utf-8?B?cTF5VlBiaUM0Mm5nMEwvZzhWWGF5MjM2K2FjSkxvNnVoeHQ3SU1EczVudDR1?=
 =?utf-8?B?Y3ljcjY1Y0hFVWoyUUtHZXhzeGozQ01kTnZqVytDQ2RNM24rK3RyMHJ3WDla?=
 =?utf-8?B?bDNJRE5ubFhGYkZFaGZQYVI4TGdieCt4QzVlZVlCOVJkc0dBSFNnUmgxRkxt?=
 =?utf-8?B?b0tjQnF3bFVkVlNJaTlvTGNnZFpHTUMvRDBDVFVCenlrOWlna0dEbUJLWXNP?=
 =?utf-8?B?UmFqUTU1V3RzUFJQalorNHo5TW9zRDJNOTVQbGpqbUYxTW9nc0s0NWhHa2I0?=
 =?utf-8?B?b1BYL2N5b2JoSzdybitSdENUbmZYelZpRFJuOGs4R2Q2SENhbnlpdkl0U1c3?=
 =?utf-8?B?Q2FPM1hpbjZEOGJ3S2s2cGJwdzV3a21PODF5ZkY4UkdLbHpPRElGb1hHZjFG?=
 =?utf-8?B?cTNWdzFmczg1QVJ0eEt3VitqSXYyeUcxeGcvckp5M2EyRjhpR2Z3SUg4NU5Q?=
 =?utf-8?B?MkNwa1RnbXB1Rmg1SDVPb244S0tXTHVaREQ3Rk1IZFh6V2dHanhac2dNalZ0?=
 =?utf-8?B?UThWWEFubVZDSnFZS3NpTS9qOGdlRWluMFVDL3pHODc3b3ZMNGtFU1JsOERx?=
 =?utf-8?Q?9/WIkANG2FD9FZoqB4CXU7w2C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5ac55a-fa18-41d7-5ace-08dc3e6d3014
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 06:09:46.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfCVuaUpln4Zpr785eDgK2XNnhOWZDXbS+XXJtByU/YZg//agE70j0ftZkymTuLafWwc57LjXRgVu2j7f9dQlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202



On 7/3/24 16:06, Kuppuswamy Sathyanarayanan wrote:
> 
> On 3/6/24 6:20 PM, Alexey Kardashevskiy wrote:
>> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
>> the DOE Discovery Request Data Object Contents (3rd DW) as:
>>
>> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
>> the Data Object Exchange Extended Capability is 02h or greater.
> 
> Does this change fix any functional issue? If yes, please add Fixes:
> tag and probably CC stable?

The issue is that before this patch the DOE driver was following PCIe 
r6.0 and it was not working on a device with DOE cap v2 added in r6.1. 
Is it "fixes"?


>>
>> Add support for the version on devices with the DOE v2 capability.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
> Change wise looks fine to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks!

>> Changes:
>> v3:
>> * updated subject line
>> * dropped "DISCOVER_" from the new field macro
>>
>> v2:
>> * added the section number to the commit log
>> ---
>>   include/uapi/linux/pci_regs.h |  1 +
>>   drivers/pci/doe.c             | 11 ++++++++---
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index a39193213ff2..fbca743b2b86 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1144,6 +1144,7 @@
>>   #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
>>   
>>   #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
>> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER		0x0000ff00
>>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
>>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
>> index 61f0531d2b1d..c94c2b0767f3 100644
>> --- a/drivers/pci/doe.c
>> +++ b/drivers/pci/doe.c
>> @@ -381,11 +381,13 @@ static void pci_doe_task_complete(struct pci_doe_task *task)
>>   	complete(task->private);
>>   }
>>   
>> -static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
>>   			     u8 *protocol)
>>   {
>>   	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>> -				    *index);
>> +				    *index) |
>> +			 FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER,
>> +				    (capver >= 2) ? 2 : 0);
>>   	__le32 request_pl_le = cpu_to_le32(request_pl);
>>   	__le32 response_pl_le;
>>   	u32 response_pl;
>> @@ -419,13 +421,16 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>>   {
>>   	u8 index = 0;
>>   	u8 xa_idx = 0;
>> +	u32 hdr = 0;
>> +
>> +	pci_read_config_dword(doe_mb->pdev, doe_mb->cap_offset, &hdr);
>>   
>>   	do {
>>   		int rc;
>>   		u16 vid;
>>   		u8 prot;
>>   
>> -		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
>> +		rc = pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &index, &vid, &prot);
>>   		if (rc)
>>   			return rc;
>>   
> 

-- 
Alexey


