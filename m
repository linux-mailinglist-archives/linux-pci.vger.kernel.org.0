Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7879E7830A8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 21:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjHUTIW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHUTIV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 15:08:21 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414991BB;
        Mon, 21 Aug 2023 12:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+Ir2iwjUUF2AbQYyn1hnl/RVusMj96c4blZwhTMG+f1N9SUH2SfRWWp/WIBML8LNZ1PHwqS2ZdMAg/wmAp6/88J3pXGJ5YJKqGwfE2bmtRJJEB0MBYWurpQTB+qAliSsbiVmuYY5eh/XyrMQFefDt7XUEKonnHRp8GqdfzWt9Dgt6WUdnOi1hOTdqIyE1NKlqROlf7Q/KXCW57D1UCcLd0C57xnos4PQtXHIBDPIkmTLK+DyokhYdS5I/1Z9C3sjrP+IqnOdVq/HDzNK67EknjsyJW7a1tbmcEtnhBj3SAUYc4nM36/cY4WnVda0REpTEWodtAGiBL+PetCFwP/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikGcVF3RzrpuanPRnXZOfXLC3ZJ8N8vkYp0iCDN8H00=;
 b=ewsf68uqRdFljRGCHLey71bZn4zb3p/iNzD5A3SBz4r7qNurdgWivwPe++Vhd7zEjeFBsojxPcQL9Z9uIT6gBFsWUvY8z75RXK8FXfyE/X1wUpJ2bcCmekkVlWtjng0RGTIkWCrldROHoveWIXIP48E5zFBiwu6w6dOH8ExroUsywN+336mv2e72ZB7rL7XuGUMDTXKG0EGWjYPQqqUgWAk+b7Qf/KDJEGK/+WIV7C8N0jHJniBzc7NPSDpNtxG5m6JWRQjEjWPtJD6EDZXhtuggTPn0OdBb7yqpCR1nqBJvtGtI/Nlqogqu76nNy+MHYGvGMTdrJf+ZmaWk14vPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikGcVF3RzrpuanPRnXZOfXLC3ZJ8N8vkYp0iCDN8H00=;
 b=HVOdFdFmvROMTm94f3JIYN5lJQXP9yv8aJEQ7Ghe7WA+CLAYBgdx0/hthYdwGE+eKtD2uGIRH+3JUXvQt0XVyXjLPrPQ1mlHrLbrUwSypXDSfYbbyHI09CliSeDyK25glcpFM4tSWPWs4fbWYNQ7EOFRhbhd6gT1cQ7imSEhkpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 19:08:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:08:15 +0000
Message-ID: <eceb8980-d957-44b8-961c-3accfce962de@amd.com>
Date:   Mon, 21 Aug 2023 14:08:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14.b 0/7] Export LPS0 constraints
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230818194007.27410-1-mario.limonciello@amd.com>
 <CAJZ5v0gNZNRs4hpV5QxxTaPDu1Mp-vDhN-fZZ+_6AZg+nDmg1A@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gNZNRs4hpV5QxxTaPDu1Mp-vDhN-fZZ+_6AZg+nDmg1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: a53c9afd-7054-41fa-f2e7-08dba279f8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pYTy3rq1vGL7vHFLAlB9Qln1vLR8USDitER/j8LiSDjGfvOLlcc8+xuut5lR1MOVUWhWkmlcjXOPyOXuw+dRxfSXbYsmdc96gtQjMJSXHrSpaQVR5SDAw3hjZLg0ubsQBmrXI3vnb/cmKNiLiRBTelxijg7FCaaPUm3nP3y1hmLCb5y5lclFdAKrd0ZicuyHzV/Y5T3Y2zenchqJ2COGNKIXSk5aYDvn654ujPJroQkwhdQaH121buhzwEL7WJo9barUFcBtk8II8+RdSJg6S/f/DVWNRsxf1rCkFf+XPQdBYCX7SENJJ3/TKUgUx0TLMU1KnK4hXChMAkq2lyclKmKp2LGGrj7BXtPjcD2hfm1m/DlyszfNTXE1uEQWJsXNkKS3iYvLmBd3pUapec89EuHQKs8Iebgddxnu6i82o2JwqqahykOFEQSNwOF7DXkjfCCrGj6L9S7SHvDbugB1xTkaq1RmhDurbTinJkmuJeotq3F4bTqa3jQAgu1T8kYx7bbuur2Ir2Mgo8K5uIy7GaUM5Kk9FvKdId+hThT2h8lfAuRVUwM5nPmDghXJSO4+ZEIqVWxoIdF0S+r0d7qtWF/Pu1G1XZ1YeOyO8C5e6xF6POovxBNazvGEebXBElnRmtqP90TnEx+j32ezJOZBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(5660300002)(2616005)(41300700001)(66556008)(66476007)(316002)(2906002)(66946007)(6916009)(54906003)(31686004)(8676002)(478600001)(4326008)(8936002)(31696002)(6666004)(6486002)(53546011)(6506007)(38100700002)(6512007)(26005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVZNkRjbUNyNVhvL3FwbFViL090Rnk0QnoycHJHRVZTN21Gdno4QzhOamNV?=
 =?utf-8?B?YUowOVZ4eVpYdFp3N21JZFU5bEU3M1liV2FhMllXN2RvR29rRVRSbEUxa3lN?=
 =?utf-8?B?R0hZdmk2WURaWGhjM2lEMU1UOFFoUWtnMlUwTEtBL0NPeVBNS0JNckxDRTJz?=
 =?utf-8?B?a0wydWlWekw4Wk4wb2lmdkRhaENLaXBuaUJrVUlPaW1UM2VaamxMQXhMM3Va?=
 =?utf-8?B?WGNGNlNuSnFiMlJhaisyWjZOaVpHbitYZ3ZHL0hkZDZVbXlyc244c1ZrNTYr?=
 =?utf-8?B?N2dGUmp3dDEyY0pOalpNY3Q4N0FqVjNxakFvbGxYN216QUovZHVrbHhrOW5Q?=
 =?utf-8?B?Vy8xWWZVVldCWUJXdENlRlJPc1NiajJpNWVkRi9WcTVvWjkyOTYyMmlISjhD?=
 =?utf-8?B?Z0N1NUhJNTRZQ0J1WDRwNkMzYWhVb0lYeG90M2VISnpoLzFXMVM4aE5iaVla?=
 =?utf-8?B?eUd1bFJicThPWlI2UzgrV0ZFR09nMXN0SkFLU3NGemFpZzdhNWVFdnVXUHY5?=
 =?utf-8?B?YU5JM3RxOTBzS2lzNllNNExCMVhsVlZpU0V1aEM0STJJb3VsYmFVLytVY0xh?=
 =?utf-8?B?dVMrRmtGY011MzJpOTk5ekZmOFBCeVczdTJDVGI5SXFKYkc4RGRYODlFOG1C?=
 =?utf-8?B?Qi9YNTd4bGpBTFhzUFNKTG9GSjYwQ1FGRXVvcjdHZGEwY0xuT2w2M2kzYTQv?=
 =?utf-8?B?L0U1V1czT2J0bkRLZzF3YVM1aHlhelYrOUJXQ0M0NkFwT3BuNUYwREo0Zlh1?=
 =?utf-8?B?S2FENGU4a3RRZUl5ZlhjWXErMGF2VkdiWDJnSVIyZCtCS3k2N1BMYXlHSmlr?=
 =?utf-8?B?Zm5KZDJ5cGFOOGlYWFVFVDcwejNzdlp4UWZJeGZrMGZQemsxdHQ0bmxWM3NR?=
 =?utf-8?B?aE1iRmFISGt2ZkZVQm1sL3lJV04yRzhDUjZRaTNnM2RNRWp0SjU0NkRUTFBh?=
 =?utf-8?B?OXNhaWhLRC9EUTBQUTJhWFlxVU5saEVCZ2lDejlhYm1xekM1QlJiRTdpZGQz?=
 =?utf-8?B?K0w2NGxCUVMvTDFlWFJ5T3cvK2l1L214MlJteThJRHMvanRlOFpNMW9xUGRx?=
 =?utf-8?B?UXRDZnRRQUtCZnNHR0lUeWFxUVpReWFxeDM4Y0tvbWpSd3NEMWlrYU5CR1N1?=
 =?utf-8?B?cnRWZHZZbW9SaFlnMnpHWmdSSXVOQkFLOUpsMmY1TGkwemNHSHZRdzJNS2o5?=
 =?utf-8?B?ZmhDVHg5QkxKQ3Z3bnZsaE96RUorMTNDUjlzQkZPUG5TTTgxb2pPcEs4MDcz?=
 =?utf-8?B?c25mYVROMDhNNG9pTTNaRGcvZ0VoSDVMTzgxaFBCYUdlYWRPYnlyMW1ON0c4?=
 =?utf-8?B?YTJ1b3MrcFBLRFlXNmtIdkNQamExQzJGVHF2aURBZEdjeU4vaWR1dCtXbE4w?=
 =?utf-8?B?cE4vRFkxN21hYjlhME0vWmNBUkVDOUpyWDU3d2tTRk5pYnNYN3FUWGpyZ24w?=
 =?utf-8?B?Um9rTXdualplSzk2NitkOXBsM2FhMVFFTzQzRWVyMlFpMW5pOUt5a28xbk1k?=
 =?utf-8?B?dm9PQ1RxLzBueGlDcjBQQ0g0YUVKV0plZXFVK1psZm1wVkZ0WER4YzhHN3JK?=
 =?utf-8?B?K2VQYjNjN1R6QndKR0JpcGVabldMZWpiNUZoZ3B1SVpERU13dGkzYVBxTndI?=
 =?utf-8?B?YzN2dy9wZ2F3UVdWWUs2MVc1bklkVndqU01md2FiV3BoWjBxdXczWURLOW11?=
 =?utf-8?B?VHB0YlpQcmhmRnJSVWdCUDhNZ09HbDVsNHcvUXhISVB4RlQ2ZlgxR1B1WWg5?=
 =?utf-8?B?UG5QdmNwV1h5YlcxTUVrUDc4amt4Qm1hamNLVVJ6TmFVTWRZS3BuODB0VUFw?=
 =?utf-8?B?N0dLY21CMzZUZGVOUUxhNFFEZFRkZzJQTEVBcFIyR2c4Z0NvK3hKcnB0TGN4?=
 =?utf-8?B?N2E5UkdQaEVMZncza0VzR1NhNUt1K2RNSzR0VnZialAzRzJHaDdHZUQzaXpL?=
 =?utf-8?B?OFpJYlR6bkhQcitTT0Y5Qy8vcmd4ek5saWRIUXZmMldxM3lJQWhtSzJ4bzI2?=
 =?utf-8?B?T0tTOWNsdkUrRS8xczJUMjMwZGk1YWJ5aEhXQy84YUpDMlVwamZnMHFNQitO?=
 =?utf-8?B?UXdBNFRuajZldWNucmI5djNXc3V4aFJsT2w4bU1wUHlaT0J2NlVremRnWjhw?=
 =?utf-8?Q?olSDxut1eIwbQv+24mRui2ibo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53c9afd-7054-41fa-f2e7-08dba279f8ac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:08:15.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkkPOyKbqR4/iY1nrJb7zqS1sU5qXUVNMh1N4M9RoniEGUiSMVX9OfZbBeIspa9KHZFHUuQzS7jYiMP8lO7e6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/21/2023 1:31 PM, Rafael J. Wysocki wrote:
> On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> LPS0 constraints can be useful to other parts of the kernel to make
>> decisions what state to put devices into.
>>
>> In v14 this series has been split into 3 parts.
>>   part A: Immediate fix for AMD issue.
>>   part B: LPS0 export improvements
>>   part C: Long term solution for all vendors
>>
>> This is part B, it can be applied and reviewed independently from part A.
>>
>> Andy Shevchenko (1):
>>    ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
>>
>> Mario Limonciello (6):
>>    ACPI: Adjust #ifdef for *_lps0_dev use
>>    ACPI: x86: s2idle: Post-increment variables when getting constraints
>>    ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
>>    ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
>>    ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
>>    ACPI: x86: s2idle: Add a function to get constraints for a device
>>
>>   drivers/acpi/x86/s2idle.c | 96 +++++++++++++++++++++++++--------------
>>   include/linux/acpi.h      | 10 +++-
>>   2 files changed, 70 insertions(+), 36 deletions(-)
>>
>> --
> All applied as 6.6 material, but I rewrote the last patch my way, so
> please see the result in the bleeding-edge branch and let me know if
> there's anything wrong with it.
>
> Thanks!
Looks great, thanks!
