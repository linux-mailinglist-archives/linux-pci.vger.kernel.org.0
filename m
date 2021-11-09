Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337F244AFE1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhKIPCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:02:07 -0500
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:60024
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230007AbhKIPCF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 10:02:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKBtPRwO9nMrzdkeGORtlQ3ELAnI85k6cUeYFb48FYbXfy8dr/N+VHoU/NyW2zLoHTReJ0/6EZc/RH7yLIJMAslb6yfc6ZyJ/lFoJp5KR9luZvMPjeXBkA70R0gTrK2+XDwMHhCBPrrvPHwn0NLr2suSJL2tJOz41afmR1NJAQHZhRyY1FzUkX0pW8oI1ku9fz8V+8rkpO6ZXf/ejmBmcjW8aQlDERt0o4DdzI4Fri1aUAqb34rxVeSXD6xKlttbGhkLr807oQM24Jha0QDvhjkMKW/q1fAPbuesl6Qt4TnfceiIv0I7ChBRP81m9Tv/vmHOBRJixSs68FLbw4d4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR8H+Doorm7Rj9O7Kgsbcdpk9uqmAC/Ov/ZawkhUOLQ=;
 b=YdSQ0ZE/KfT9I4MkNGsdOETwBM2UKLaBh0NVaA8jeVLOhIpwkKXNeQngGWDvnxGXx2da088XgNw30WcNdywmXBJlCvsvghVO3vAOfHdV2MhpM3A5J9h89iOZXrA8oUruEYnD5ViLdSFzyrm6tpa2XnyJPvNfvysThtDi787LLdcyDm+X3hx43yoILm26OH0BF7l6cHh+SQUmFV9Qxg4DEnMF8+EnXGaDeiO3hSyeXZdE2XYiqRFTRBkOFMfIgqXrcxoiQBX4fKrg9mwwAb4GfREW0+7cOYELh2Y7X80fLqCAh81+V9HfvxHNfhzpJNXRrMK6/i8psYtgaqzHtTPMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR8H+Doorm7Rj9O7Kgsbcdpk9uqmAC/Ov/ZawkhUOLQ=;
 b=pbWiQZyZgMk0Q9gAij4Kgh1bS+Ja5UKxS7o6F+LpzNCrgjjy3to3Ei3cEYrKFe+DIqmH15XoW5M0o9HVXCoRYweMPMJOCo5LGtijpd15XSXmpFWHhFGZNODVThlfPIRTpp7HfMa1VZQ/6XOSjCNErKVpkpxsE1UIO63vqSpt2x4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1357.namprd12.prod.outlook.com (2603:10b6:300:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 14:59:11 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f0e1:d37b:e4ca:395e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f0e1:d37b:e4ca:395e%2]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 14:59:11 +0000
Subject: Re: [PATCH 1/3] x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and
 (A0h-AFh) PCI IDs
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        clemens@ladisch.de, jdelvare@suse.com, linux@roeck-us.net,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
References: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
 <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
 <YYm8h1wDTAm7Rkf5@rocinante>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <8e9e63db-3236-3527-f81a-59cd46dfe3d7@amd.com>
Date:   Tue, 9 Nov 2021 08:59:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YYm8h1wDTAm7Rkf5@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by MN2PR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:236::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.4 via Frontend Transport; Tue, 9 Nov 2021 14:59:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d4b9d1-e6fc-4fc4-1702-08d9a3917d18
X-MS-TrafficTypeDiagnostic: MWHPR12MB1357:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13576C1E4876A034E0CB6E9195929@MWHPR12MB1357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBc/tlzjI9yZgsqYEPfYDH/ix48OJJk/vYclx64tSaQH8Biu1PxMvvXUiggCMJpLsXZGrUlHrQ+3yOznZkE7GAIrb1FzoG8WRaJaZEvfmmklIeqQjfTABUcAb4U1PdSj4WXYlnK6BZvUILNtkb3/tHnjQZNjo2gx2a4S6OCJeY9RcD7r4lJUJ9Bdi1GmY1ETkPNoli4kFzuNcG3u9XYCExKBQ7onfqaq5SxkWFr5vAbPVv2pvNzxrW3FLPzXVz/dgWe39I/fud+FApBVatArZaWav7spVUCPXHkK+wsNT5cchAj2gwoLeYg50UEZDnDEIUp+ODyvpZgUyU0r2VjsdkducH/fePvg7ISCWPGlYXci3iMjczNYz7u3nog1d+UN4Zc+J6wEq5kS1t7BhcGIWVOVxy5uMWdnslGOJY336fhgUieuS8+1AaTJKxTQbNgF0SM3dQXyHLxfoAnvnA2uocgBCDiCN4SD2CjX9VEgSlH0g+k2tPAW8cBlHHfhH9kL0VYLVvlGCYiJxkSuXt1X/xHgjkefl1Kr19DINEEKb7KJJ7a8kPYMxwe1Raqhhs0cNumjVK4xtB4w2COPubuBshJQbjldc0YqJggnchGwZpF/nzVY5rntIaB/yW9/V/oLUr1T0hYgDYwnG1NVq1mD78ZAgB851deTEk2UAZ8DcqpqVraU3sWZzNY1HoVeagZG+kbWObJrG9ls47y9WB/rXeSK69aNfwK9ON0e1H/sKJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(4326008)(2616005)(36756003)(66946007)(16576012)(2906002)(508600001)(6486002)(53546011)(5660300002)(86362001)(26005)(186003)(44832011)(31696002)(316002)(66574015)(66556008)(6916009)(31686004)(8936002)(66476007)(83380400001)(8676002)(7416002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERLSGtTQkhvOXZJcDYybDBHZXRGSTBNWXZ2MnlVU1RscGMzdFhHZlJUSnRl?=
 =?utf-8?B?Qkc5NEFMYjZGQjNScXdpK2lVOVZXZWR2RTJhLzFod05MQVZITk1QNEpZSkxi?=
 =?utf-8?B?bFdsalN1ZGEyRWVjeGswaWV3THJNS1gyMHR1ZzAxRTVlQUlnUEIyZEVHSHBK?=
 =?utf-8?B?UFhSY05KazZIem8rS1BHaDNVUWNvZ1VpOVMrSDYzejdDTGk3REwrR0ppUEg0?=
 =?utf-8?B?dDNjUHlxRkppZHpxVGU5K2tSbEl2RG5WZExOMnNaZnRtTytIK0prem9YYmsz?=
 =?utf-8?B?QUJ4QjMyVzE0ZXQrZ1VwaHAzbXo0U25yOUZ5TThLTTlORHJ6ZWg1VXFablFX?=
 =?utf-8?B?MEdsT05QUUhIaUVtbzhmR3FtMW52aW9rWkVsWmxSbFg3WWdRdVNBOUhZWkNQ?=
 =?utf-8?B?NS9EVk1OQUJvQTFNRzMycUtBUVZZRnJRS1FkTDY4SmJKNlV5ZjlvSnVaOUpE?=
 =?utf-8?B?RWVhVCtQRXU4RWw4Q3Z3ZlpoYWlXSHg5a0I4Y0JucDJrQ2ZXeG1MYVNwOUpM?=
 =?utf-8?B?bkhBTk5tVks3WW1xLzhpYm5ZQUhucUdrVEU4K2lUc3hoM0E3UDc5SFgrdTVv?=
 =?utf-8?B?SngxMVAwUUxqMzFSdGxjYWxwM20wczRUaXhkaFpYS05SdmxEWGhpck5CenNQ?=
 =?utf-8?B?aTg0QVB2S0JUSUN4Zm93NGtZS3NXbk8wZ0xnUkxwc3RtR00za2djVnY2djQ3?=
 =?utf-8?B?ZWxjQ0R3SmNOL2ZCN3pVNU9SU3J1VE1SNTVYMHNCeEhHK01oN2tRQlNDc1d2?=
 =?utf-8?B?dGhEaXkvN0kyeWlac05YYkpMSTMxSXpuNDN6aHptSHRsaEVMSHhFV21iMGV3?=
 =?utf-8?B?cHMwR0s4OFhjOU5mVjRQVFFMWi9pSHFHMExJMUhQY1A3SDdRN2lhaU9qT0Zy?=
 =?utf-8?B?Y1JZbTYvMGlWVWJ4M0llNko0K3pTVDlncEJWMlJ4OXhBV2xrWDJqdDkwR3JX?=
 =?utf-8?B?MDdtcjBMWnRrWmhFWnJ1NVJjZVVxZHFuV2pXcjRBdVFUUjBzQ2hJdXozc2VM?=
 =?utf-8?B?UjE1UzRhWGxOV2RnOU1HNHdITTJkUkFYV2VXZ0d5U3o3aVRKTTIraGlOQm1k?=
 =?utf-8?B?TXlKeWRRYTYzN2pkU2Q5dlEzVEEyUWVWOGlGWUhVZjlEOHNzbjdmSlFGcU0r?=
 =?utf-8?B?OGxyamowNXdrMHZqbWkvSXIzSXRWOWhlSUlOZmN3QmNRbWp5K21STnVHTXRV?=
 =?utf-8?B?RHQ3b0d1TzhkTG5GQzVDOTNWd0lCd1ZMdVJSSUw0Q1hqSktnc2pzZ1hMKzNa?=
 =?utf-8?B?cm5wVWdpSnoxWnFSSEFYUmp4VmpFOXphM0haaFlYYVVGOGdVcXQybkY1Vjdh?=
 =?utf-8?B?bnRZSS9LSnhOTFlIbnRVN2lmZzBYYWVrMDB5Z3ViMTVZQ0p0czZ6aDY4TCs2?=
 =?utf-8?B?KzIzSzZaRDh0WVZUMjQ3VTBCcVNsakxUZmZFYmtzSmdINTNnM1QzMXc4L0U5?=
 =?utf-8?B?M2xrcmFzOE5ndy9pSmt5RzBXNHZTMmluS2tucDYrZ1JBVVExU1RUaWtXdDNu?=
 =?utf-8?B?b2liM3h5emlWdFZyZ1NYd05DWDA4OWhXOHNlSG5COHdqc0lxV3lHZk4xK0pH?=
 =?utf-8?B?YjFDZFovdTJEUklEcU14L2ZQZHYvM0g1Q1VRZnNQVC9zM3dXclE1Um0vQTl1?=
 =?utf-8?B?UVFSVmIwSCszeExCMGRDaWcyT2F6QlJNKzdxZG0xTjNmcmo4WEJnNjJQam5j?=
 =?utf-8?B?dDdKeWRxeGhFQis3bDR0R1hReDNzOFlCL0ZHd01YV2xOTXNBM0k2ZWl6TVhD?=
 =?utf-8?B?eXl0TEtyUURUV09adzJZZ2h3KzJ4OUpiaFZ5SEc2b2xTcTJWRDdHb1F3b051?=
 =?utf-8?B?TXNzTU9HekJOZk1VVlBvbDA0cy8wQnpuQW1TTG9IZXpEV0swR0NrWnI1VW5Y?=
 =?utf-8?B?K3BkemdzWE91ODFST2ExYUZTQ1RrdTBNRm1pa2ZYRmdvU25rcTB2Zlo3VmpX?=
 =?utf-8?B?di8rVVJDVHdSQzVRMno2UzJCY0RkRncxb3pxRmhXa1lCczd2ZmJqT3h6U0ZJ?=
 =?utf-8?B?RUNKa0N6cWxnc1VDcUQvdUl4Qk1QUnFVUFBrVHorVXpKTGFQSTg4Q3kvSlM4?=
 =?utf-8?B?SmtaVWQzSERKU0pHSi9UWGp1UW9CdlZ4ckdKZS9DRjR4UkF6ekUvU1JXaU9v?=
 =?utf-8?Q?Aj+8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d4b9d1-e6fc-4fc4-1702-08d9a3917d18
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:59:11.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9WFVkn3m5OrmPd04ysjX2vqwrGzBgsj4nnjTU5RSoZ+dbNm+ohdHO7HPyzMjqN/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1357
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 11/8/21 6:10 PM, Krzysztof Wilczyński wrote:
> Hello!
>
>> Add the new PCI Device IDs to support new generation of AMD 19h family of
>> processors.
> This commit message matches the spirit of past additions very well, as per:
>
>   commit b3f79ae45904 ("x86/amd_nb: Add Family 19h PCI IDs")
>
> Admittedly, it would be nice to know what platform and/or generations of
> AMD family of CPUs this is for.  Unless this is somewhat confidential and
> in which case it would be fair enough.
Yea. It is kind of confidential to spell out the platform at this point.
>
> For the following PCI related changes:
>
> [...]
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -555,6 +555,7 @@
>>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>> +#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
> Acked-by: Krzysztof Wilczyński <kw@linux.com>
> Thanks
> Babu Moger
