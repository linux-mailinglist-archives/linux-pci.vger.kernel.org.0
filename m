Return-Path: <linux-pci+bounces-1807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3864826D39
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1241C2206F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2990120316;
	Mon,  8 Jan 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="enOChvHJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780022575A;
	Mon,  8 Jan 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX/SygRH9v2ixSVQgRi0PkT00fg3ImKi24T0d4lhv7r8nmkejEx+TlD/RWWZY0vjQzlGE+IDudsbsWEFIGp6qBlEQ6nqccqcGCQ/zvnDbRmCSAi/BKS8CtzsLFI7W84USt4MeZ5C9KuggL4wBVZgPEmqekrCrT+aTjo2xzOW394Uvvk+ffDnqQl0VWne4h2m4xBo6jih0IKcbqSaKiVgIwYXYN6uiW9F/QtLuR5XGhEKPbLlXCSYKOlRNXW2fZsHuv38zRQRymDfoqkm9ubcT+RGuZ08r1wxAlv67BJiKW4rmos+U2kdhSbyfRN6IKooRc0NpDARG38rBcNtp5SBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7S8wRJY7RrhhwPK0JuWEJ+IDUdTX0ZCfV/IktDYUmpA=;
 b=fruUvLimxSkQvdltZfCoFSEVjT9DReKVh6TKnbK+5oqHaeZ9g1DFjTu+Z+mqUu2D/Qfrp9TrXB+QXtmdUjh1hVBha7ascvtPIGwNDSzWdSjf4Uwj764Mxb7kf2/v3J/gksAqbL9mUJECB+PNNXC7/7B41zEcgwOUKKGnW2U2JKNYuSz5Z3WBZJADsEB5TzVvYO05P6wk9ocqMt57+3LzLDBX6evWuSV2MaYKkWprREsD+bWwYR9hRQcUDy1A/dWLqecVFB7ehasC1QfERmKWci9KOXxx8Fng4b2uGguYkFZl6jPXGH/ErvhMd0S7sL1K/bsyWnSLiVU6EXYqiPMfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7S8wRJY7RrhhwPK0JuWEJ+IDUdTX0ZCfV/IktDYUmpA=;
 b=enOChvHJa4N7gl01HAJ5d1D+OzaBZzOespSSYL48IbxX1pPEY/wvTl+Enww7C9Uqo3zjk9ZSjmfhCfPbSH1H/FJZe6cmqCdD4lvnjF2WryeBCO9siDZ3onHLNtbnBDq1/1ZgV5qsSv5hTp6h1Yga2LsEDsUAMcvUth6vzg9Bcjw/v7Tl6nPqb367oVzaM8s8gRemjyiZi8vCqF/kvJoM+FXtpuFE8xqxBK5+gsD+dib1E8cljkc6C+/+MckDt09AV+upNeEzwgnUQQxnyYrDgdX0FwfKoGbsaM5Skys/CsCkkZBu39u/WRVRxs4wkNWnsiDdox4JP6e2vFWV2If7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 11:58:41 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 11:58:40 +0000
Message-ID: <d8ccc4ea-385a-4def-bc71-574a99538e34@nvidia.com>
Date: Mon, 8 Jan 2024 17:28:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI/MSI: Fix MSI hwirq truncation
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 tglx@linutronix.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240105134339.3091497-1-vidyas@nvidia.com>
 <e529aafc-7d97-4e38-b994-26ce99f2715d@linux.intel.com>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <e529aafc-7d97-4e38-b994-26ce99f2715d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::12) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6dbd60-da96-4a7e-cb82-08dc104127b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S3PW33u706WreM/Mv538vk2Mo/v7XoH90BrKzyE8kX68FtB0H2uHO8tDTJ1M52hYRMZT6SRn04BPkhiWQWQvW4AtrMWbuIkjWHrEQxbe0v0DTmZoGeZUBwxuSKZEwWLxtoVXER2ZKVJ0jXpxQacP7yeAfX7HkYF+pAgLHHHPkxl0ytulTAZMay4KR4ItFveWc3ImAvKFDnrxnn3INfgSA4gp2kJz5Jk3XHTQDW4lAcQ+zcECuuldlAzOMgK5Bh1FDKWz2SMudlnBEpep7gTu7/tBvQpiUa6lt5kjPS4HDjv2Wv3uNcE6KgXvEqtHLMXv9NRftBXnG/94rXmcfNqPePmxaFrGE9GhfgRH3F/9iOagyFxu30AnZR1yvnxHDFsHkoe0fwaAUhixxwLf/H/OhWxwI4gA/S+evhhvEhEUwC9EG6D562kASP/SLL3Jr2QqdzHjxzqhqAHs9pLvBIm2Wa97JMZ4BM/JPLsCrxokUruS8a/9pqIcgIqgj8dhSAq6xZbKsAe6vkQvg6WYnJtzeoMXBW/pXxDB9UtEX3SeMxu8vw8DaGA1ovT/pBnaNKGluttetPXM+tE5WV2yYV01HJeNuElofXOk6fAzrAn0NFwaDYLv526cQlSvcUmyDrPcQZYNRXAoG1fYOL1Xh17NpY6JLf32m+MoqzcapJGD6YqX1rfTXVQzsR+q7wYE0J0xQt5R12A32CElmMhZWPJ2jmIwHNOaT/MvukAerTDSzvU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(31686004)(26005)(53546011)(2616005)(6666004)(6512007)(6506007)(478600001)(6486002)(966005)(38100700002)(86362001)(31696002)(36756003)(5660300002)(2906002)(41300700001)(83380400001)(66476007)(66946007)(316002)(66556008)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djNJTVBNbzNCa3g5eVFSVzk0RGRlU3dYeE9MOTl1cm90UkNvRjhCZlNneFQx?=
 =?utf-8?B?dkttRGVESWpQS1dlbklEeGtwWnpRaUZjWDc3SDlyaTJuVXNWUGdyVlF1ODRD?=
 =?utf-8?B?UG90Nll2MlVXZlpnY1JBUkxjU3FUN2FhRVdrUWZteXJFSmZwb2ZVZ1RjK1N3?=
 =?utf-8?B?MDNFa3p2eUJUTTJ0YjJCM3ZMZ050ek1oTUswc2kvR0ZhVi9STDdhZnlwZTUr?=
 =?utf-8?B?YWNmUVRKTzdOSktzZlFHVVUzNXc0cGVBdWRMc2U5blFDUXIzc3hwZW03cVBs?=
 =?utf-8?B?aG1IVUVKZW4rbHBWQUZFeVl4V0xZSnFUN1hRV21UdGo0OXpHbjJoQlFOVVVY?=
 =?utf-8?B?NmxsMnNFdnovT3cyUEdpTzRmN0UxTlNmempkcTgrZHdmb2QzN3NCZkFvVDhs?=
 =?utf-8?B?dkpWbTNxV1ZDdlkzTU1GRUpXM3J4M2U2dUM5ZHYvQkZJWjJTQ0lFc2x5T0p0?=
 =?utf-8?B?My84d045Y1QyOGNRTWppSXNXMjRaeHA0VU8wVFpDZmZYUGMyYndsZU11OG1j?=
 =?utf-8?B?NnlMZFdLSWhaNm5rc0VtL2QyanhRUmN5ZkFERXpqR21CQVM5ZFFsMUNaekJl?=
 =?utf-8?B?SGJSQTEzL2NGVlJSTU1ZSHV3M1hLcCs0cE5icXFXc0NUSDdXbE5KTGlhNFY4?=
 =?utf-8?B?MXBhZmVxSUJWTU5ER202OUszd1AwcDY3YVluVE81TitVUHZTSU5QdWx1bXFl?=
 =?utf-8?B?bWtEdWhrUEdHcGtqZjZHaUtEMW15TTNFVFNNaEtJVkRMV21lc1pXZjU2cjFy?=
 =?utf-8?B?a2I1RTZYYzBHRTVuRE8vU0RqT1oyVUoyN2Y4YUlvQmczTW1CTmE5TWpMcU43?=
 =?utf-8?B?YTVpemFVL1krVFFTRTBBQWk0Y01sYi9zMnpUS1VwUnZzS0JjT0lBdS9Ob1Jq?=
 =?utf-8?B?R2lzVWFGcTBRajFVOTgyRlpBL0ZqajBTSml5MW0yalVqeGxUM0o1dElCeXBp?=
 =?utf-8?B?Rm81ejIvdmlIcThaeGdzU0RVWFJNSTNoRGtzdXRDemVZT2VZWlFmUm9ONUww?=
 =?utf-8?B?VXJzQmp1K1NWR01mMDZkNW5vY1lvem01elM5OTVFODlEVVI1b2pwTThxcFh3?=
 =?utf-8?B?Ty9qTHYyNmZaUHd2KzVSeXhVUXdGR0kzZ3VYVmFvQTE1cXJ2U3RRNjU1UVFM?=
 =?utf-8?B?czVxcGhEa2hwQTNNdWUvYTJBS3BUQUt3eFdCQUcwMGIxZjFoZkVPZzlHVkJv?=
 =?utf-8?B?eitJc1ZMOUhlekdmWUw1Z1ZHTVc0aGZXWjVyMW5yWTROT3dBTU1Oc1J2c1lv?=
 =?utf-8?B?UVkzMnRoYjI5Z1hNQ0VqMmtEdEFhV25KRjRQQjVsSHJPS3NCVmU1RDRsM0Qr?=
 =?utf-8?B?cHo0aUc4ZWdOekNTMTRiaW0yRi9Sa1hkeXQ4ZlhNUkM4YnUyRzZHdWlqN3oz?=
 =?utf-8?B?K0lROGpuUmhNRWkrZzR0M2diWDEvTGF6eXV5ay96MzFvd3JlQ1FCQmtTWWcw?=
 =?utf-8?B?S2JuL1k4SnRCcEV5MEFKa1ZJRUVGTm00anJMNnN3cC80b0VhSHgwTWNSbzNs?=
 =?utf-8?B?anRydGtoSjZiQmVQcW80ZnYrd21QdlprZHZNdjNhMnV6b3FVSzExUkxSaE1E?=
 =?utf-8?B?Wk5iYUdnRXB4UURQRytUdndEKzVJbk9KQjdyRmtUbC9EL0ViZDBxdHV5UHg5?=
 =?utf-8?B?RGxnSmwwVGtjRWxTbTgwcUdCSXBhVG4yWk9oY012SXNhUndjcnBoZEgrNGJp?=
 =?utf-8?B?Z1B5Q1VGZFZOTlBNbXZ0VHVTMkI1UUo3SEVSTktERVlqRm9OaFRHZnZSZGsx?=
 =?utf-8?B?ZzhuN095YXN6bUk2UTRQWVA5dlBzOVlnZmZCRVQ2TUdBdGREaWQ2emlFbm1o?=
 =?utf-8?B?M2I0OUhtZjZxSmdUalBHdjBnM1BQazU3ajV6WnhrVUFOL3lPcC9zSUhab3Ra?=
 =?utf-8?B?MWVFZEN6SHM2SGw3U2dSbGxqLzlpai8yd1pjVy90U013RFhCZ1h1TXNrSmtv?=
 =?utf-8?B?TnpDMHM2aDNVMDhvOGl1RWxPQWJCT2V0THVxNWJabWpRUXYxanYycUtVbU00?=
 =?utf-8?B?b3REQ2NQOHhVMFF0R3IwNUhmckhjTlRpQWN4a0hPSVUvN0RkNjJQYUd2a2h2?=
 =?utf-8?B?NFR5TncxbnZpSHZrRzB4Mi9GWmx0cGJndWx4WEVrRnBIWTMzZldTNlB3VTZ3?=
 =?utf-8?Q?YWYKXPxRLY15Wppad//cpy+qt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6dbd60-da96-4a7e-cb82-08dc104127b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:58:40.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76+pMmAOC2DI1Bg9rP/Gt2JxZuk+Hse/i4H+L3ZZHF5Ni7MdA4qa9lHC4xdnwbmOLv2LEgJ/Kuqcb0F3FZhhtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490



On 1/5/2024 10:32 PM, Kuppuswamy Sathyanarayanan wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 1/5/2024 5:43 AM, Vidya Sagar wrote:
>> While calculating the hwirq number for an MSI interrupt, the higher
>> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
>> number gets truncated because of the shifted value casting to u32. This
>> for example is resulting in same hwirq number for devices 0019:00:00.0
>> and 0039:00:00.0.
>>
>> So, cast the PCI domain number to u64 before left shifting it to
>> calculate hwirq number.
> 
> This seems like a bug fix. Why not add Fixes: tag?
This doesn't seem to be introduced by any recent change as such. It has
been from the time the original change appeared in the mainline. I'll
give the commit ID of the original change for 'Fixes'.

> 
> Is this issue detected in a platform test? Maybe including the relevant
> details about it will help reproduce the issue.
The issue is detected while running ARM's ACS test suite. But, I
couldn't give that info as there was some bug in the test suite itself
for which I raised an issue at 
https://gitlab.arm.com/linux-arm/linux-acs/-/issues/2

> 
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/msi/irqdomain.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>> index c8be056c248d..cfd84a899c82 100644
>> --- a/drivers/pci/msi/irqdomain.c
>> +++ b/drivers/pci/msi/irqdomain.c
>> @@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>>
>>        return (irq_hw_number_t)desc->msi_index |
>>                pci_dev_id(dev) << 11 |
>> -             (pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
>> +             ((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
>>   }
>>
>>   static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
> 
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

