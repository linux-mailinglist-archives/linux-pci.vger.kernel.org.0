Return-Path: <linux-pci+bounces-2207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A882F00A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CE2B22F09
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A81BDD3;
	Tue, 16 Jan 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/Py/Duj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AF1BDC8;
	Tue, 16 Jan 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR+incU/vuFT65a0D4jOwvrK4w+BBY8sXMgTbTETyOLLceFPuH7GggOxTRRtU5twjDyOv1Sat+gv/ZP4kc8pI/F+loS6Ab2eguyZMVFiy/mFXs4GaxmvKBYaqWOWON2mbxR2sNdazmn8bcC8IYfi8qvpQQULt7phrhCxF9rBPlw6gWGtAXZuMSOcOWaV+7frWzZumBi6wMqRKPdydQtwPJKVziDzYSQhf3xGq0F/4WRuILSFYQ4sBmt5LSNs1TXl1mRN/P+Si9hUO33q0WcgvN/Wt8+mb4icmb2+6+mEQhGdqnL7EQCvsT1koKV6RWRVawiXsGXr1N5N6leIri9Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fInF4TrnvOYo00WXuIw3zcF5pdiUYcUZZD0tomXNqHo=;
 b=KMgts157lMO4EI7QWjrWUQw8K3asO6n5cTnqlT2OIyOEOXk7k2i2HCv/J6kFMrYK4JOYB8H++zRRVbCRvR4p6WQSYvUOiJ/IhsTNyShW0U/knj0f30PvMTwCWyEzM/Q3Bwep8u0Z+ot7/4GXWAXDR6UymiK2uF4zpLVaOlTkJxCjpq6DLz3f0CApzKLHqNNcKr4OiPh9oxTopodRkGIpW/ZMatDGQKPLWeyA18OkETmbhI8Sq5CHMPm3NlCU3HkJHiJDwUOmG2/DBza+xiOZpDKpapyGACSs5vKJnY0Hmv/r+IAUWHrZOsvqAT/9SmczVtgJyLCVvEa+X8rhlNuT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fInF4TrnvOYo00WXuIw3zcF5pdiUYcUZZD0tomXNqHo=;
 b=H/Py/Duji3kimjOkYVbp3DO5m5h+fVTE8CKbJGEfe8hd0eBtQ6yRSgnizjRlJVBRes6tpwqpz2xwg2WrqkfTUOqiLflfU6EzFWJkMGxN64r9cBPzzfOqD+m298ng4P8kTAV9rXXEg83zVxbqrMLWo469ZbG2omrJg+O7s4N+ltce+jhi97C1MLVPJg/iNSe5S+em81nfdJMZo/fCJ5jX1ETMOB3+0DlloYzSrkHA13LYcp9t7Oc+848t69rpTR8E32cvnBZ/e50gvbYcecqelpvq9+XudEqhB/DapC4muZ/zC5lov92/RWtGCDuVKwKt3X0x8YOQEsVO0PuAFh4CZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 13:54:11 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 13:54:10 +0000
Message-ID: <2223a0c6-e627-4608-88ea-230fd1b5c507@nvidia.com>
Date: Tue, 16 Jan 2024 19:24:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI: Clear errors logged in Secondary Status Register
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240112170622.GA2272469@bhelgaas>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240112170622.GA2272469@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: ca544864-8138-4364-e1ac-08dc169a9da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ee9t0PS/Th2IzlHT1bWeMT2lXqc+cg7usKks2QRL3JqgC0OwLlkKhD9YFBDQ1YN5NezAd7UrAsWo9ETWA9G4M2X3PghO9NuS07DtubMFzyT8eizop+phPdgpDjh/oXdkn4D7pqtXiHyQw2Cy7W6t0g+iEx8IMDyCBv2e3snzBmUupekJiwQWy7tV5lNLVsZ+6PgVNbS5gtugN/ZZL9d2JRIckQGRmsmHiQ4b9ZTOe1Iz4NecjkIshPKiNbxb4DNI7cHZKLiR5fsMdsVL4lom6m+k/v7vAyhfsVw+G+RhNW44W2pEj6mr1CQAybfusFgSSZk3Dg9Lz0pDXIw1srn2XUWJP/as2Ee7UXTCTdAbJebbizyMZkDJ4dcqfTowiiIiIh4lrMcgpJEe0yPHRRV/aOQs1gFnAet+9Fj4urxYmh/znRSqXxG5lqXEg1IT5TFV7koGlrTMJjnSwTJZINIH4aX4aiHKKAjLdqIPDyW7OFUlCciVYnAk720luO+Bx6vVTH0UvGao2AaXr6DPA+QbwUBEjaTAleY0l39Moj9ZTUfOjmFGBUV8Tr5c67ENjSAfK8CPGU47T23R05PVUws9bZjrIkr3DhrR6gFC8CXAj3aEYasNwISvOp1S0EkTPjy/uilyJbtYBTS37SF4lRR5CLeE0tiRYN5FGU1MxQVMHduL9IwEZY9Tks9CcJl+e/jmJm8FwiKXg+Bbymti/H/27qVgrkD1m1fFL4bdRI9oR60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(8676002)(6916009)(6666004)(478600001)(316002)(966005)(66946007)(66556008)(66476007)(6486002)(26005)(6506007)(53546011)(6512007)(2616005)(83380400001)(8936002)(41300700001)(4326008)(5660300002)(2906002)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3VBS2p2NWVKVVhYWVd3SnB1K0VIbHRwTmZXZGI1SXRYMm1BZFd2bitMN0hS?=
 =?utf-8?B?RjJta1BMcElDK0d4WnF5RHVwL081a1NGNkVmZWxabFpTRnAwRStnVlQ3V3FH?=
 =?utf-8?B?c0VBU2h0a0QrVVBRSzFObGdwVDQwSEJpYXBtQUdFTVRCVjFMN2RNbjdDV0xT?=
 =?utf-8?B?UWV3Y1YwRy9QU24wQzRSY0oyNzQveDBnYkJSZ0Rwdk1wb294dVBBQ0srZEEv?=
 =?utf-8?B?VkJrSXZPbFkvMFZTZk1aSjVSa3M3WTJ1WFMvbVd2NjhRUndrTjd3UU9iWlVv?=
 =?utf-8?B?V2pQYVpJLzY4Y2JzV1kvWGVneitObEpTME5UNXJmVnoxMi95aDJmMWV6NXdC?=
 =?utf-8?B?S3hXYU9XcWhuYlNseUtSc0Y0TzJoWHVub3dRbVZLY0cxY2lRajZNL3VYam10?=
 =?utf-8?B?N1BaQzV4Y3hreEkxd1pkblE5WE9PakhlOFJiMU13eHdKNFBkbUFIN3Z1dGlM?=
 =?utf-8?B?OVR1NEVvQVRyNS9ReDBjaWE4RUxRbkU4UTFhWWRFRUZIaFlxK1VpYUpaSHRy?=
 =?utf-8?B?Ylp1aGpFTE43YVlYZkJDUzVJWHNvajZSSitBQmw1TGtqTHZMUS9Za2ZyN0Iz?=
 =?utf-8?B?cmlKRytNNWlubFZidjNpSmRQUStZYzhoeE1jZzlKRFJUVkdRdDRtUFBMalFJ?=
 =?utf-8?B?eURKRjJ2eGQyTVl1eDZSUVR5d1pHSmh0ZjZsYXVwUWhqM1BqcGl5cUlnRTBn?=
 =?utf-8?B?djhYOWlackd3MG80bXByZFhPTVZrVVU1MmhvZW9zU1grdDJJN3dCM1dxU202?=
 =?utf-8?B?ekt1azczYm5QUjRyd3VPQmNkdjN4ZzFVbHVWdjdsd2FoeStucnRjWCtmb3Z6?=
 =?utf-8?B?SHVhZFJmTE5KOWNwVURxdkdKckQ1ajZsb1ZUUktiTjFWV1VMOU9Bd0pSSHNt?=
 =?utf-8?B?dU83QllQdjd3bFM4UkdqbGtvRS9vaWhZMk5udkJkaDZ0T2VPRUl0MTBBQ25n?=
 =?utf-8?B?NHptRnRWL21vTnp4bkNpL1lzTVlTS1FkcWVTSjhIT09QYnFQSmluekhWNkxu?=
 =?utf-8?B?QUlEVWlQdll1YjJQVmJrTlROV0YrZnp4KzJGeHB0OGh5c2hLai8xamRXcXY1?=
 =?utf-8?B?a2MvRUtuQmwrNlB4c1NlUXlTWDhRaFZzU3oraEdhem42b0RrdVoxTEErc0xh?=
 =?utf-8?B?WHVWV2dyeFRIRU4vWWlaZ2NSS3lVMVR1SUdISmJtY1d6bE55VVBTZkxZOHRO?=
 =?utf-8?B?MnRRWnBHOHRZU2l1UmVjTENmT2c5MkIwd3doMkNqazFqdEl1S1lQOVNlMnVD?=
 =?utf-8?B?MG1sdWVNME1PMSs4anNFWUQ1SGNvODJFVm9kU2F3ekwrSlh4dDhvWUs1Visx?=
 =?utf-8?B?OHRzYlNDK3pLQlJNWFc2SFFIcUVHRlhTeVRPbC9JNWsxa3VHT3N6eTBuS3Bz?=
 =?utf-8?B?MHV3T251ZWhFWkdlVEdsZ0NNTzNIajM1SzZaUXAwU3hoeDEyd3hTd0YyM3NU?=
 =?utf-8?B?UG9NMU9BcS9qenl1ZmlsejNaWlBzQXovNnk1b3JRUWg5bk1La016WHp5T1Qv?=
 =?utf-8?B?VzdxcFJYSFVCVG1FWGIyVmtIMzlORmFaeXlkZElHZitNcDRPaFplZ0NSS0g1?=
 =?utf-8?B?OFpWUlptMHdQWnl5ZGhNL01COFdsZmlsR3drRitXNzdoQ3kvMDl2bXdWVWdM?=
 =?utf-8?B?NEZEQjArVnl4THp4T3ZHS21URU9zMFJ1Y25VY0tMZTNnT3dqL3FNY3E3NFlN?=
 =?utf-8?B?ZXJMWWJmUndodklSRGMva1FHMXRqTE5GTTFJbjdXRWd6eFV2RjdQNE5UeTJS?=
 =?utf-8?B?TEZHRE1RQnVGN0J0K2lYQkxaREFBVWViMVcrTW1hVi96c1FORmsxa3YrcFVV?=
 =?utf-8?B?SkhJR3pvWXlVa01PclJqZkRCaEppT0ZMZnpYamZYNnI4S21UMGYrVDFTZWN5?=
 =?utf-8?B?SWZmUzk0THh4bklkUGFMdW03MDdLKzl3V3prSUxIc2tBNmJ5NVU3MXBOajF4?=
 =?utf-8?B?dnVXWUVPbWdkU2pmYm0zRWd5L2JqODhJV1hCdUduVXJDY3Bvd2lUQ2M3bUk4?=
 =?utf-8?B?TnRqakZYZCsyazBoOEJtU09jRHJ1aW1DbTVJbTBRTnl6RElEbG1RdlczelRr?=
 =?utf-8?B?OEpXTXk5ZHlRYUxnK3ljREVEZ2xOYkpGZDFIalhTTEZZcG5YaUd4cTlzT1Jm?=
 =?utf-8?Q?/UD/oBJhSmIMGPf8eNsjnG5YU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca544864-8138-4364-e1ac-08dc169a9da0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 13:54:10.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0j+KzBnAYUQqxa+vOzYeQKsrdQ/3Kdf6dt28zNuyZPlLJz1IDHvCbj1J4AfNVW5OiEaHjnaGkwy/nbhgYHw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211



On 1/12/2024 10:36 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jan 04, 2024 at 07:02:29AM +0530, Vidya Sagar wrote:
>> If a downstream port has a PCIe switch connected to it, the enumeration
>> process leaves the 'Received Master Abort' bit set in the Secondary
>> Status Register of the downstream port because of the Unsupported
>> Requests (URs) take place in the downstream hierarchy. Since the
>> ownership of Secondary Status Register always lies with the OS including
>> systems with Firmware-First approach for error handling[1], clear the
>> error status bits in the Secondary Status Register post enumeration.
> 
> I would expect these URs to happen when enumerating below *all* PCIe
> Root Ports (not just when switches are present), and Master Aborts
> should happen in conventional PCI.
Agree.
There was a misunderstanding from my side because of which I had said
that the 'Received Master Abort' bit gets set only if there is a PCIe
switch connected downstream. I'll correct it in my next patch.

> 
> Similarly, I don't think Firmware-First is relevant here.  Only the
> fact that the OS owns PCI_SEC_STATUS because there's no mechanism to
> negotiate for platform ownership of it.
I mentioned about Firmware-First as a continuation to the discussion we
had in [1]. But, agree that, this being a standalone patch, there is no
need to mentioned about Firmware-First flow.

> 
> We're in the merge window right now, so we'll start merging v6.9
> material after v6.8-rc1 is tagged.
> 
>> [1] https://lore.kernel.org/all/1fb9d746-0695-4d19-af98-f442f31cd464@nvidia.com/T/
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/probe.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 43159965e09e..edf8202465d8 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1470,6 +1470,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>>        }
>>
>>   out:
>> +     /* Clear errors in the Secondary Status Register */
>> +     pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
>> +
>>        pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>>
>>        pm_runtime_put(&dev->dev);
>> --
>> 2.25.1
>>

