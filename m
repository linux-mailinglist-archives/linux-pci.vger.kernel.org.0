Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC6A338837
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhCLJE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 04:04:28 -0500
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:9185
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232724AbhCLJEF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 04:04:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtDihLrSKp5z5ySGgnX6/iJCRXFi2zNstTAlxc2g4ivuT3qERhBMIBLo66U1CNtoCzvxi+AeD+m1TRgTyiallIqR0eV0Y7YBSYAcC2LC59GYDq+b6AI7HhTacCQRFZfiGuSZP9Z1Zuo3hqrWmAQtNOhlUw1DYtGy2F1QGysVKmIgGtIJ8gS/BOxzpoze5fbr2Y8+Ug0rA9OVVcMxyg9lw6yk+siGDN9CZ49V/UZbgSFDA5g4BoRpuiQbSG5m+qDY0/NcWMfgE8MFiwBFO7KXQD1esGXiKQhnQ86oMhUNRi7VNmb0rzGgV8Qx3mSIq8DHptwiBMQ/N5CCgMfD3GqRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUGDiGCHas7RlVLi4wwQcUNVrK9GGvKrVdrvB6iIVaU=;
 b=c7mtusyOqtWsO4hloCNq6AEbfo+UcWTzzJucHzYLd/PlBteGGDxs5Yv+AyjZZ5Y7e0dzxvfDjLzM52R44Q6vA7NdoKHQZL/JFuxXCM4zo9kqQeOygdRJG8i+cSiWNBG9j9KyhbnFYcv7qaQct4kTI/Eh1y/eaIUae5E7f+sWpUjeYIVOtirKUJh2WHBtufSpcpGC+jFBcfxUwUx5wPGdk/fRo/W/k8ME/Ve3qH0pPEFqY5YU3bKeeSd/9PXete3bbcwtf10qQ1br6z4awAkVIvG+aU16OZiLBHoYDx3pCohaecsZkqsuwBXAaqncw1doY03LjDin3tqGOfoEilENGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUGDiGCHas7RlVLi4wwQcUNVrK9GGvKrVdrvB6iIVaU=;
 b=4T7XHstluagyZZL/VvOocKvQCZeb0Vw/Omfu4/jEjgwQf7XktGeBb6NyISZ7jNF5YIf5gS0kJ0xMDwVt/MjVLo3LHDWV3YVns93HVMLO/3LMCvy5cePGDZsij7+B4iI4bNzkQ4L/PS4fdPZsEKetIGzdbVBfkL3LP3fly+aruaI=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 09:04:00 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 09:04:00 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <dae8dfd8-3a99-620d-f0aa-ceb39923b807@amd.com>
 <7d9e947648ce47a4ba8d223cdec08197@yadro.com>
 <c82919f3-5296-cd0a-0b8f-c33614ca3ea9@amd.com>
 <340062dba82b813b311b2c78022d2d3d0e6f414d.camel@yadro.com>
 <927d7fbe-756f-a4f1-44cd-c68aecd906d7@amd.com>
 <dc2de228b92c4e27819c7681f650e1e5@yadro.com>
 <a6af29ed-179a-7619-3dde-474542c180f4@amd.com>
 <8f53f1403f0c4121885398487bbfa241@yadro.com>
 <fc2ea091-8470-9501-242d-8d82714adecb@amd.com>
 <50afd1079dbabeba36fd35fdef84e6e15470ef45.camel@yadro.com>
 <c53c23b5-dd37-44f1-dffd-ff9699018a82@amd.com>
 <8d7e2d7b7982d8d78c0ecaa74b9d40ace4db8453.camel@yadro.com>
 <f5a9bc49-3708-a4af-fff1-6822b49732c0@amd.com>
 <1647946cb73ae390b40a593bb021699308bab33e.camel@yadro.com>
 <3873f1ee-1cec-1740-4238-a154dd670d62@amd.com>
 <98ac52f982409e22fbd6e6659e2724f9b1f2fafd.camel@yadro.com>
 <146844cc-e2d9-aade-8223-db41b37853c5@amd.com>
 <e3f3de55-8011-77d8-25ac-f16f8256beff@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1f5add8b-9b2d-8efd-02d8-ee8ab33c070a@amd.com>
Date:   Fri, 12 Mar 2021 10:03:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <e3f3de55-8011-77d8-25ac-f16f8256beff@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:2108:8a72:3f15:1a1f]
X-ClientProxiedBy: AM0PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:208:154::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:2108:8a72:3f15:1a1f] (2a02:908:1252:fb60:2108:8a72:3f15:1a1f) by AM0PR02CA0087.eurprd02.prod.outlook.com (2603:10a6:208:154::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 09:03:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4816c76a-4321-4fd5-ded8-08d8e535c679
X-MS-TrafficTypeDiagnostic: BL0PR12MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4708F5D5777394AAC71B20EB836F9@BL0PR12MB4708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAri1qRkdFZsCH/xO7s5P/nm3GXlaL1b4Yv8gU9ym+odVVqgPBFRcxQkpwqo1PFgA8PZAZXw5yHcPl+7o0vq4FDIy0RgDRY1rd94HJXOC7x5cGeNIuBFZOk3YfDwxLZb5CDTblMkzzQDJv8VJ8HWLrgHc828aF9UEeqnuuCqGbFePRyfCz3NfPdx5/qwq2CAezYW29jkEp7RbV5gWRR4MXQWryUHt77XCgbohHeJW7/Gy8AXQB1dNS+byuIVkVJbgMVYbuj9a4Fb4+zcrmtIB23VGABSV5hhEiOxjVPaIXOd9LOFgnSDLLrPxUcmfoYq7y/S7HrzkfYPaEvsb58XXnsY3T3yo147yH9I/fFstdWFQEFgw10uTbZ/cj6HfP6T/FoIFfvMSF2NlMDnx///HUi+A5qS+F/fMhdtFvuGM/p0FlXZ1/iLqV8gDstAfl62M7m+VoSK/d8S8xW0IfKEEFH2SD36yxX6w7rVNygs4ZbtqaXk2U1Loy1s4eUiz3//lM9TIQR+rK6FhD4iRu0xqj87dL0ZqzgRpQasWItJ30Y3vHrm5gs/e4VGDCKTVvzkWDutw+Xbe2S2WGXLBx9TJrZtBvqDIP5w5I0ckyRtcQMRf3FnR8WXWNIxHxxg1Lx5MZUX6LJtDeEHEPnz/Nvrew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6486002)(66556008)(2616005)(83380400001)(66946007)(966005)(31696002)(316002)(2906002)(86362001)(4326008)(478600001)(5660300002)(110136005)(54906003)(31686004)(8676002)(16526019)(52116002)(186003)(36756003)(6666004)(66476007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVhaV01iV3ZQWDBxSFg1NWlXbHpiWWtEOHJJYS9Md0I0Y3dIRXpIWU5BZTlN?=
 =?utf-8?B?RTVHVHAwQnlLdjdjcndMQ2llRjVYRWZlUXNvV28xN0FWQzRYcEovaURpaytK?=
 =?utf-8?B?cjBHeStmdUFiMlh4SXpiZlR4ZHFCb1g3VXJkanRGUzViZ0VhVE90RG5jeUlq?=
 =?utf-8?B?S3VOU3Z4ZzlDVGVMVGJjVis2WDBmTndyU2J0K1VLTzZaNW13aVc0VEFsNzhG?=
 =?utf-8?B?QnRLN2Ixd0pKb3ZGampkYk9yekhad2VaRHBxTExzTXM2ZFFQRlZwRDhVMjdB?=
 =?utf-8?B?azNBdjhzYmJxaUtzemFDTktTYU0zWE9OT3ZtOWNNeGVCNXZmbjlWRVQ2UkpL?=
 =?utf-8?B?VDVtOUV2cWtqelZLMy9nbkFrTHZrcHp6b1gyam9HT0E1b3pzS3liUGVnb0hZ?=
 =?utf-8?B?WFZhQ2ZUTGl0NnhRKzE3dXZvQkdhaUJ0cEZaamR2cGIzanR6VTMyMUNyYm1s?=
 =?utf-8?B?WFJkWlZqdlo1bXFCNzF2RHArTXdyaXljN3MzMWd3KzNkelZHVjJ1VW5jTDZU?=
 =?utf-8?B?Q01RRmJiSjcvY0p3YUlkb2JOOXpVUHdKQXVjZ0RJajBZYkVCWkRiQWx3UWor?=
 =?utf-8?B?MFkvbC8zcTVjbEVYbGQzSFBYM3A5TnZJTmZGUk1oRVhRaDQ2RjczRGNteDNm?=
 =?utf-8?B?dnV3dmtCRGthWHhQRytPOHBnSjljUENQeXgvWDF2aEpNbVhHQjlDWERxWkk5?=
 =?utf-8?B?NDU4cW4yZ3I2R05qQzFmVW94aHFFejkyMXRPSzBaRmlYOENGbWdac2FrUVB6?=
 =?utf-8?B?NFVETWp5WER1T0dYOFdjMU1GVnF1cldQOU42bjZDWGxMMlM4S1BOSFIvY1BT?=
 =?utf-8?B?TlQ4U3pmQXd6ekNMMnlMUVZkVDMvS1Y5QmZDdDJEN2JFZTRsTzJWZ25TN0tz?=
 =?utf-8?B?SHJPTkZEZy83bWVkdExOMjZreHFkTWhYWGRqM3NETGhJOUlFOWVIZWwvSHBO?=
 =?utf-8?B?SHd5QXlXbThNSy9yMGNQQmp4OWJraFJHOTM4Qy9Bb2hZUHNTNUc0eDBkR2ha?=
 =?utf-8?B?ZXN6OG0xek12ZHVkUkxZdGZicEdPZEloZ1VrZngyQW1tN0t6VXV4OFlwcThk?=
 =?utf-8?B?a3RIN0pZdDRGLzJoSG05VDYvTUptSmFZTTdzcGVLTktUdEpQTU03enlmN2VQ?=
 =?utf-8?B?RmdZL1ovTmxvYTZCb2VCVWZQR2Y1bE1ibVcvUzlScFJDUkhvQU9iMEZzOHZ3?=
 =?utf-8?B?NStKaTBiOHg5N0Y2QWprUkdTWVVNK0w2Y0VWRHJFOU1pcjVlaEExTnQwRzhR?=
 =?utf-8?B?eGh3dWpUeTlWVjFTSG1qRUc0dDc4WlF1a2FYYU45QWFCQW5KUmd6WVllVkxn?=
 =?utf-8?B?YSs3TlZxYVN6aTU1TmV2YnJEbzZmNHYrUWFyZkV0QWlwckVlK1N5V0ZKazh0?=
 =?utf-8?B?dW9wcnAzRHpFRU1INmpHTmF4NWVhSGVvYUovUDYxK2o3UWRUa2hpejl2MVlU?=
 =?utf-8?B?OTNSS28zSittSnhyczd6UUdCUzZJNC92am1GWHlhMjIxNUdKZDIxclhWRS9Z?=
 =?utf-8?B?VDJjRE1HWkhmQWhEOEpBSlBLMFJTQllXV2FSOTF0ZWJQZUJqYlFJck9sK3FM?=
 =?utf-8?B?dzgrSFp5Y1FXdVUvOUpTcXJhZGwrR1RTRUtCaVUza0IrZVN0V2pLZUFmYXRU?=
 =?utf-8?B?OWJyNWZWa2xJaEVhOVZ0cktWUDZVcVJDNnR0M2o4YjVEOFROUEZSV1VsQ2RJ?=
 =?utf-8?B?V2NkazhKZG1SaWJZb1paeFhSSjJrWlZlNk9tVnBlSFN2QVY2Z3F6endyUnk4?=
 =?utf-8?B?WWRleDlWdlExay9NbnFrTVRlUTJydEhJRm03STNjWmxkMkI1eGNHQzdtRTBI?=
 =?utf-8?B?MGhzN290TXB2ZFp1UUxIY25CVFJVL2g1VERJOHl2RWtrc1ZJbXZzTzFJamoz?=
 =?utf-8?Q?A1Stl61EqsXI3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4816c76a-4321-4fd5-ded8-08d8e535c679
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 09:04:00.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHE2xN6pHx3YlDKitmfi1q6/RpR6d8te/ecjqmGSV7JzPpv4ghGt9lo7Pded9qXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
> [SNIP]
>>> The expected result is they all move closer to the start of PCI address
>>> space.
>>>
>>
>> Ok, I updated as you described. Also I removed PCI conf command to stop
>> address decoding and restart later as I noticed PCI core does it itself
>> when needed.
>> I tested now also with graphic desktop enabled while submitting
>> 3d draw commands and seems like under this scenario everything still
>> works. Again, this all needs to be tested with VRAM BAR move as then
>> I believe I will see more issues like handling of MMIO mapped VRAM 
>> objects (like GART table). In case you do have an AMD card you could 
>> also maybe give it a try. In the meanwhile I will add support to 
>> ioremapping of those VRAM objects.
>>
>> Andrey
>
> Just an update, added support for unmaping/remapping of all VRAM
> objects, both user space mmaped and kernel ioremaped. Seems to work
> ok but again, without forcing VRAM BAR to move I can't be sure.
> Alex, Chsristian - take a look when you have some time to give me some
> initial feedback on the amdgpu side.
>
> The code is at 
> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1

Mhm, that let's userspace busy retry until the BAR movement is done.

Not sure if that can't live lock somehow.

Christian.

>
> Andrey

