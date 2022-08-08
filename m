Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044158CBF9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243637AbiHHQRH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiHHQRG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 12:17:06 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC17E2F;
        Mon,  8 Aug 2022 09:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+JQHzjYqZeqoaFo0CzFGG85/okxZqgjdD6F8jNu1LQBRwRO++0NCIbNKCNskrpO0g4qpeHUxA4UXAsBdtAMzht4+iJIZ6z7KTQDecGClzlXFyc3EhIKAywMPFBcxPh2cKLD94o4XQ143xXHzVUmAv7CXz0gGjVuPqzAnO3xvNcafCdB3A322nrYEewJs+M/lvuN0Nv+KI5q4kjh1HwuQiYv+aLqOXaTWRH1I+Yba7Mj4x/tfa7n0bfQf3mbOXCxOdojbroZSGQEf/55wzE4dTsJHKMgnWRpbPJjEH/S1l1rj4TdJ0rIz09CWBuR1SBlvL5P0fYqvIhlA4grVPtW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYwMW8q0Z/Fro88mLq9JYK9eBFTT4WZ2CSAhxDCY3HE=;
 b=Wku7SD6MIvyWtXUD/TL0OIIyS502n1EGKRSMsbGTCUxQrboQ0piSdX0Ik7fagKRpzDMf3i1K6Q9dTIAM+vZyR84oqL6W+yBSw8ic8OMcmDXbN9tl32gBhU2hjjyzx6Nhrs+AeDK9jzG3ZcBVXnZo9ordrVTv6nFNjAvNkUfJxSkfgmLP7BClUnLcay32ZEHwWlihqxleZqanPpOtV+EUy1njxlueqLShrRTjv16Jp7QYuiNZhmu9wk9Jm43cPfYEWPxawXn/b6EDg+CT3FHYlC2k70AAFHyFKDwej86dzY3xhoxNbXG3DClUPhtfYQbRNxL5GQ5qAy42of19CXj+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYwMW8q0Z/Fro88mLq9JYK9eBFTT4WZ2CSAhxDCY3HE=;
 b=l4FEAK1+dQpxKpGpIOO5jIbsWJOWTit+9wFfY4Svp0JhjBS/UW4TGT5/p8K+yvHioL6HF+eAzz9KPyb6J0aY+ibkciw9GdO9lbO2zmkixqgYgoVuz+Yr77PxcStte+s+kFUcKO7jJ+N2/IpenEJqBHx3vPyRiERktg4QAjtxeIsCVdKT7JPRW6beIXkaAMqhznHZcbKIsv3xAUG/S8Pd6rKWCUdicm3NZRPu8SdwdUdud3uiStJhDSiH8TGWnyk9bsVByv7ZXJ7PBKhvE5c4FQnNa0qNjiV8vh7gkBFg93RQXD0TDvLFP6h/6CSxuFrGzIXP/NXy+GhKt2SNjm9qKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 16:17:01 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 16:17:01 +0000
Message-ID: <b841fe9f-6091-ff55-cd0f-76bc6b04ff46@nvidia.com>
Date:   Mon, 8 Aug 2022 21:46:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Lukasz Majczak <lma@semihalf.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220722174212.GA1911979@bhelgaas>
 <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
 <CACK8Z6FSr_ztkZ5+ULjHiDZ5L9qR=Ewtq1ZuDofzvJX=mW5WAQ@mail.gmail.com>
 <CAFJ_xbpYrtFrt-hEd7M0jqyH7R9pOKA9884sgMvV2RZXycj7hA@mail.gmail.com>
 <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
 <8b36f97c-0cc4-3f4a-3b5b-49ad5786d9e9@nvidia.com>
 <CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com>
 <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com>
 <CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7d0ca66-3898-4bb6-11a0-08da79596cd5
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm8xQTVyMHJBd0NHdUt0MytOSVltSk1RTzdWeTNNOEZJakFyRTlEaUhkNWNu?=
 =?utf-8?B?Y0dLMUtzTFVxMnlqTllxdis1T1ZOcTJHMU53ZjQ2RkhKejJ3SkNzQm5XSkRI?=
 =?utf-8?B?SkVneW5kWmFISG1OQ2w4cTVnNUlabVk2c0dvaWg3eThrU3lHZGxDd3JUV1Zk?=
 =?utf-8?B?dmYrS3FxR1dCb2tsSE9BdjVFRVNYR2pQajk0MGNLTlBuV3djcDJONmZWazZq?=
 =?utf-8?B?MXpjMnFJN3dUd0VxSXZHVDdyYUxmRHNhSXNzNmVaa1VlRlp0MlY0dENFUG5r?=
 =?utf-8?B?Yi80TGNXM2s1dWR6T3JRZm00RGJJaG4xQzAxSHhsQk04QXMrSFc1UnZraGp1?=
 =?utf-8?B?Wjd5b1BXbVhiUU4rdmIxbTFGSGNuSUtJNjNzU1lsZG96QjlGYXNjbnlXRXJS?=
 =?utf-8?B?NmpDeWhncUhaalJZenNFazIwcTV5YUxoakZXMnhtc3N6L2RUL3ZodnhVY3Q5?=
 =?utf-8?B?V05zU0xQZVVqbFFMQU5BRWZ4SGZIVGcrNUhZM25ZMmxLNHptNnFXZmJmbVpn?=
 =?utf-8?B?N2RMeEo0cGhsQXRibnR2NTdTaGtlRkRGRmd4VEFRR3ptRXV4K25pb3hHcW1H?=
 =?utf-8?B?MFJSN0NoNVRuVXU0ZzA4UExyNEVtTHVxRDVrejRpZ0N6SFVGcGRweWtWQzRZ?=
 =?utf-8?B?YlU3RnF4dzF1OG54YmdvNTB6enNoZTlPaks4N2JRRTBKZjd3c00ybTlycjl2?=
 =?utf-8?B?SCtFYyswTzN5aGkyWGZsL2ZiTVFkUVFBbUlUQjRraVhHaVBhV0xtMzk3c2o3?=
 =?utf-8?B?T2xNMEEwYkJoWG1jNHNOZ2piN2ErOXE2YkNYZ3FQWktUN2U1cENPdjhpS2wy?=
 =?utf-8?B?M21HN1M4U3M1ZmovYmlTVDNpU0djUHE1L09DQWNzdXVkY0RqVFlzaHRxeHAw?=
 =?utf-8?B?MzdGdDdzMS9nZ3N5bkRJblNDc1pGa2RJVDRhc0RIY25tZ0VZem9adlBEYU1H?=
 =?utf-8?B?NlBHb3BvUWtSZmFBRDh2eWZqTmhBbXd4WHl3emZ5YzdBdzAraG9ETVZxYU12?=
 =?utf-8?B?NTdSb3NxajlTV3F0SEF3azFwZ3hUcDlidDQrZTZMcDFkeGhoTnN6Q2R5SSsv?=
 =?utf-8?B?Mjl6VkpNT0RzQ2xKZ0puT0UwSytDL0xLWE04dFFVK2V4M1BtR3pkbCt5dWE2?=
 =?utf-8?B?OCtqTTFTN3AybEd1QlpCQWRJUWlEb2txa2ZpRDJ2cENlUms2ZlpmZlNvYk1m?=
 =?utf-8?B?S0hXWGExalNLY3dpVk43emU0bnBVK3JPdFg1RzZwTWFUR2U4UTR2SXN3M3RI?=
 =?utf-8?B?TzFoSkx6V0ZrVXp5TDJONzhYenYwaHNPMU4zWG5pZExlTWlQQVhnOWx3WHF1?=
 =?utf-8?Q?seh0cbR+2IGgY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(110136005)(66556008)(36756003)(54906003)(966005)(31686004)(66946007)(66476007)(8676002)(4326008)(86362001)(5660300002)(31696002)(6486002)(8936002)(478600001)(316002)(19627235002)(38100700002)(6666004)(15650500001)(41300700001)(53546011)(6506007)(2906002)(7416002)(30864003)(83380400001)(26005)(2616005)(6512007)(186003)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODE4dzJ3TjhBVDQwTEZZbVJsZzVDaUNMVng5T1JYRGd6SDBZeis3VFE5Tm5p?=
 =?utf-8?B?S3FYQTB4TUVRUlg4TDJUdHRGdG9mLzQxdHFleGRvQ2x0Q012dUxHRC9OSStO?=
 =?utf-8?B?blh3ekhqSzNzcGJubjI4VURBRXZvckVMNEw2WXB1UDVsWm83bjRSdDMrcEdW?=
 =?utf-8?B?Z3RWZitINnI5V3B6YWN5VkFickh2bjNzWXpvM0pRVWRuWnFBNGc2U1VRWjRw?=
 =?utf-8?B?LzYrQ1dEMWZRV2tGUlYwT0xuQTM3RWhpaC9ZWnE0dmkzUC9pendodjltZUg2?=
 =?utf-8?B?WFdScnNObXZhOERvdUplMXgzUFNLODRuK2FJUkZBQ0tBanM0dW5RT004ZmU5?=
 =?utf-8?B?QVo5TDh6WTlxWk9UWmJjZHo3UEN1YVE4MDhJcC94TTVFenF5cmplTTkyanhM?=
 =?utf-8?B?dXd6aWdDeThxZFUwWkIvdFBhazBQamFOcWhFTnNqQS81QWJFYSs0Mm95Z1lQ?=
 =?utf-8?B?cnlLVldZQmM0R2dlTEdIL2ViQ3dzaTJnelFFVlFKZkx2NVNtdXZOMFZyektY?=
 =?utf-8?B?a1JiZ1F1QTFHbThBWjhuQWR2YkcrNXdjOWNTYWs3ZXNrcm55U2hYdWs0QWJu?=
 =?utf-8?B?MzVIZ0xEczQxYjZtTExYK0srVmtvU1prNFJ0ajE1a1FJVXI2RmxLYmZ3TERj?=
 =?utf-8?B?eTJxOTRvSUE3S2xoTmFhNWF3Z1RGL0cxM2ozNk9UOFdnc0hSYW9pUDgwdnBB?=
 =?utf-8?B?ckxLRGhaVTU2ek1SSXFiM29WSDc2N2h5bmdNamk0Znh4TVN4TFM1bHNwcXFR?=
 =?utf-8?B?VHhUWG5tOTUya1dFMjliUHhYOG5zdEhsSnE0c2V4TjFYd2JtOVdkdjRHTnEr?=
 =?utf-8?B?QTh1Y1JqdDYvZVl4WFQ1eDhzWEphYWlLRE9BSVlnK2h1OHU4d3F4dHNYeTlF?=
 =?utf-8?B?eHJKalJ6Mi84cTBoWXQ5ZXJhQTdoOGJNSHNJa1JGSWNkcEtUM3VQVEdZQXgv?=
 =?utf-8?B?SFJ5YzhoOFVHWTBOWlVuWDlheHNBOWpzbEs3Z0dXK3I4NTM1Rlk0VFRPckVW?=
 =?utf-8?B?a0svWmtoVTdkemdPVzBNdk5SK0dyb2ZETzJyb2Qrd0ZpSXJyaFd4eWFIbk5H?=
 =?utf-8?B?K2xrdWt2Y21uaWgvc09udXgydmhHWHh3T0JxTzZJSkN0bnpHWmRnQmt4L0JJ?=
 =?utf-8?B?cmJSaWNsN0lHTXdaQ0p1cVBvSU1kRlF2OUFGQ3dDVTBqY0RHNkJOSkJJekNr?=
 =?utf-8?B?SWFQYTJGZGg2Wjg4eEl4azBldHp2elp1d0FOQ0EvMkNVUWVQRVNSYU5CZ2k2?=
 =?utf-8?B?NEhiT2NrdmFiK0hROXRvNzNXS3FMZzQ1VzZzMXpPNWlSekliVUhxakoramVi?=
 =?utf-8?B?WVkxWjY2SWpKaDBOcmtYa3p3dUVZZkh3WmxQOGNOWUtWdnNhN0dIaVoxZGlD?=
 =?utf-8?B?NFNWZFNEdTljQUlnZzlQK1VOeXQzTTQxWmNDY21ycnI1bUFBTXFJbnpsUUNp?=
 =?utf-8?B?RFNSaEhzdEdJZnBiSEV5elo4dVE1TEw1ZHp4c1ZXY2Yzd1V5RWRaNHNNci9C?=
 =?utf-8?B?MVNmTXFrU0dneVJoNlVyaWtxblNZN0VtV3lRZE8xUUpqL0kzSFF4U0t4OEpR?=
 =?utf-8?B?UlExVXRDS2NEeVFWTHEwQUpHZjI3a3BlUUZTOW1zeUY5TXhWdHdsaUVxU3Z5?=
 =?utf-8?B?b0lveFlHTzI5cU5vTzQxR2VTYmJiSXQzQkNOZ1M2SzJiRjdEeDRGQ2hWZjhz?=
 =?utf-8?B?Y3dOd3kwM2F3Sm1Xdno5TmEzTHVPc2pBZWhWTmFnVEZQRVU4Tll4eGJkRExo?=
 =?utf-8?B?TmJzRHVIQ3c2d1BvZm5yNjBsUWRVdTFXTkc4RUJSM1M1MVZWRC95VW5HUTJq?=
 =?utf-8?B?d25ZelVZcmtYN0F0OU1Ickp1WkVVbXE5QTNhYWxnRkMzRTJvcGZBYnFWdElu?=
 =?utf-8?B?OFpFRnlkODcxMnAwRDdZOFhHbkRLTTkrUlBieWprbTV3Wlh0QUNZdE43UjVE?=
 =?utf-8?B?VXlmS2Nndzl4bUp3aXBRRDM0K1BjMFRobzJselh3Y0R5MzQzeVJ4bytjTWpQ?=
 =?utf-8?B?U1RGR2E2dG04bUs0MEI5aGdPRjl0Zitha0xFN28zRG03QXhhZUFuTmtLWjJp?=
 =?utf-8?B?dDZUNzJ5d2tIUytkQmVrc05ZZWNSNWdKbngwc0gyOVRPSEpNQW1SMm1MNWlk?=
 =?utf-8?Q?b81T5KDwOyrjPNw8W4LLdR3y3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d0ca66-3898-4bb6-11a0-08da79596cd5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 16:17:01.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahK5/3oPqG/fh5G31ymlAw4e/uBhIkIFpXrYEmZHen2ZfHgy7CE4Vh+9OfVFrbKVYtZ5sefU04NZHgUuWY0pzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Lukasz for the update.
I think confirms that there is no issue with the patch as such.
Bjorn, could you please define the next step for this patch?

Thanks,
Vidya Sagar

On 8/8/2022 7:37 PM, Lukasz Majczak wrote:
> External email: Use caution opening links or attachments
> 
> 
> śr., 3 sie 2022 o 14:55 Vidya Sagar <vidyas@nvidia.com> napisał(a):
>>
>> Thanks Lukasz for the logs.
>> I still that the L1SS capability in the root port (00:14.0) disappeared
>> after resume.
>> I still don't understand how this patch can make the capability register
>> itself disappear. Honestly, I still see this as a HW issue.
>> Bjorn, could you please throw some light on this?
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 8/3/2022 5:34 PM, Lukasz Majczak wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> pt., 29 lip 2022 o 16:36 Vidya Sagar <vidyas@nvidia.com> napisał(a):
>>>>
>>>> Hi Lukasz,
>>>> Thanks for sharing your observations.
>>>>
>>>> Could you please also share the output of 'sudo lspci -vvvv' before and
>>>> after suspend-resume cycle with the latest linux-next?
>>>> Do we still see the L1SS capabilities getting disappeared post resume?
>>>>
>>>> Thanks,
>>>> Vidya Sagar
>>>>
>>>> On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisał(a):
>>>>>>
>>>>>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisał(a):
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>>>>
>>>>>>>> Agree with Bjorn's observations.
>>>>>>>> The fact that the L1SS capability registers themselves disappeared in
>>>>>>>> the root port post resume indicates that there seems to be something
>>>>>>>> wrong with the BIOS itself.
>>>>>>>> Could you please check from that perspective?
>>>>>>>
>>>>>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. This
>>>>>>> is a shallower sleep state that preserves more state than, for e.g. S3
>>>>>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come in picture
>>>>>>> at all. i.e. after the kernel runs its suspend routines, it just puts
>>>>>>> the CPU into S0ix state. So I do not think there is a BIOS angle to
>>>>>>> this.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Vidya Sagar
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
>>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
>>>>>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> napisał(a):
>>>>>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>>>>>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
>>>>>>>>>>>>> saved and restored during suspend/resume leading to L1 Substates
>>>>>>>>>>>>> configuration being lost post-resume.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Save the L1 Substates control registers so that the configuration is
>>>>>>>>>>>>> retained post-resume.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>>>>>>>>>>
>>>>>>>>>>>> Hi Vidya,
>>>>>>>>>>>>
>>>>>>>>>>>> I tested this patch on kernel v5.19-rc6.
>>>>>>>>>>>> The test device is GL9755 card reader controller on Intel i5-10210U RVP.
>>>>>>>>>>>> This patch can restore L1SS after suspend/resume.
>>>>>>>>>>>>
>>>>>>>>>>>> The test results are as follows:
>>>>>>>>>>>>
>>>>>>>>>>>> After Boot:
>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>>>             Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>>>                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>>                               PortCommonModeRestoreTime=255us
>>>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>>>                     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>>>                                T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>>>>>                     L1SubCtl2: T_PwrOn=3100us
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> After suspend/resume without this patch.
>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>>>             Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>>>                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>>                               PortCommonModeRestoreTime=255us
>>>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>>>                     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>>>>>>>>                                T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>>>>>>>>                     L1SubCtl2: T_PwrOn=10us
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> After suspend/resume with this patch.
>>>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>>>             Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>>>                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>>>                               PortCommonModeRestoreTime=255us
>>>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>>>                     L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>>>                                T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>>>>>                     L1SubCtl2: T_PwrOn=3100us
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
>>>>>>>>>>>
>>>>>>>>>>> Forgot to add mine:
>>>>>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Best regards,
>>>>>>>>>>>> Ben Chuang
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
>>>>>>>>>>>>> on your laptop (Dell XPS 13) one last time?
>>>>>>>>>>>>> IMHO, the regression observed on your laptop with an old version of the patch
>>>>>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Vidya Sagar
>>>>>>>>>>>>>
>>>>>>>>>>>>>      drivers/pci/pci.c       |  7 +++++++
>>>>>>>>>>>>>      drivers/pci/pci.h       |  4 ++++
>>>>>>>>>>>>>      drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>      3 files changed, 55 insertions(+)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
>>>>>>>>>>>>> --- a/drivers/pci/pci.c
>>>>>>>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
>>>>>>>>>>>>>                     return i;
>>>>>>>>>>>>>
>>>>>>>>>>>>>             pci_save_ltr_state(dev);
>>>>>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
>>>>>>>>>>>>>             pci_save_dpc_state(dev);
>>>>>>>>>>>>>             pci_save_aer_state(dev);
>>>>>>>>>>>>>             pci_save_ptm_state(dev);
>>>>>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
>>>>>>>>>>>>>              * LTR itself (in the PCIe capability).
>>>>>>>>>>>>>              */
>>>>>>>>>>>>>             pci_restore_ltr_state(dev);
>>>>>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
>>>>>>>>>>>>>
>>>>>>>>>>>>>             pci_restore_pcie_state(dev);
>>>>>>>>>>>>>             pci_restore_pasid_state(dev);
>>>>>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>>>>>>>>>>>>>             if (error)
>>>>>>>>>>>>>                     pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>>>>>>>>>>>>>
>>>>>>>>>>>>> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
>>>>>>>>>>>>> +                                           2 * sizeof(u32));
>>>>>>>>>>>>> +       if (error)
>>>>>>>>>>>>> +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
>>>>>>>>>>>>> +
>>>>>>>>>>>>>             pci_allocate_vc_save_buffers(dev);
>>>>>>>>>>>>>      }
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
>>>>>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>>>>>>>>>>>>      void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>>>>>>>>>>>>      void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>>>>>>>>>>>>>      void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>>>>>>      #else
>>>>>>>>>>>>>      static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>>>>>>>>>>>>      static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>>>>>>>>>>>>      static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>>>>>>>>>>>>      static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>>>>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>>>>>>      #endif
>>>>>>>>>>>>>
>>>>>>>>>>>>>      #ifdef CONFIG_PCIE_ECRC
>>>>>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
>>>>>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>>>>>>>>>>>>>                                     PCI_L1SS_CTL1_L1SS_MASK, val);
>>>>>>>>>>>>>      }
>>>>>>>>>>>>>
>>>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>>>>>> +       u32 *cap;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>> +       if (!save_state)
>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
>>>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>>>>>> +       u32 *cap;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>>>> +       if (!save_state)
>>>>>>>>>>>>> +               return;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
>>>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>>>>>>>>      static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>>>>>>>>>>>>>      {
>>>>>>>>>>>>>             pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
>>>>>>>>>>>>> --
>>>>>>>>>>>>> 2.17.1
>>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> With this patch (and also mentioned
>>>>>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@canonical.com/)
>>>>>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems after
>>>>>>>>>> suspend/resume with my WiFi card - it looks like whole communication
>>>>>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
>>>>>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3
>>>>>>>>>>
>>>>>>>>>> I played a little bit with this code and it looks like the
>>>>>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
>>>>>>>>>> why, not a PCI expert).
>>>>>>>>>
>>>>>>>>> Thanks a lot for testing this!  I'm not quite sure what to make of the
>>>>>>>>> results since v5.10 is fairly old (Dec 2020) and I don't know what
>>>>>>>>> other changes are in chromeos-5.10.
>>>>>>>
>>>>>>> Lukasz: I assume you are running this on Atlas and are seeing this bug
>>>>>>> when uprev'ving it to 5.10 kernel. Can you please try it on a newer
>>>>>>> Intel platform that have the latest upstream kernel running already
>>>>>>> and see if this can be reproduced there too?
>>>>>>> Note that the wifi PCI device is different on newer Intel platforms,
>>>>>>> but platform design is similar enough that I suspect we should see
>>>>>>> similar bug on those too. The other option is to try the latest
>>>>>>> ustream kernel on Atlas. Perhaps if we just care about wifi (and
>>>>>>> ignore bringing up the graphics stack and GUI), it may come up
>>>>>>> sufficiently enough to try this patch?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Rajat
>>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> Random observations, no analysis below.  This from your dmesg
>>>>>>>>> certainly looks like PCI reads failing and returning ~0:
>>>>>>>>>
>>>>>>>>>       Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
>>>>>>>>>       iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
>>>>>>>>>       iwlwifi 0000:01:00.0: Device gone - attempting removal
>>>>>>>>>       Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
>>>>>>>>>
>>>>>>>>> And then we re-enumerate 01:00.0 and it looks like it may have been
>>>>>>>>> reset (BAR is 0):
>>>>>>>>>
>>>>>>>>>       pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
>>>>>>>>>       pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>>>>>>>>>
>>>>>>>>> lspci diffs from before/after suspend:
>>>>>>>>>
>>>>>>>>>        00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal decode])
>>>>>>>>>          Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>>>>>>>>>       -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr+ TransPend-
>>>>>>>>>       +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>>>>>>>>>       -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>>>       +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>>>       -               LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>>>>>>>>>       +               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
>>>>>>>>>       -       Capabilities: [150 v0] Null
>>>>>>>>>       -       Capabilities: [200 v1] L1 PM Substates
>>>>>>>>>       -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>       -                         PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>>>>>>>>>       -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>       -                          T_CommonMode=40us LTR1.2_Threshold=98304ns
>>>>>>>>>       -               L1SubCtl2: T_PwrOn=60us
>>>>>>>>>
>>>>>>>>> The DevSta differences might be BIOS bugs, probably not relevant.
>>>>>>>>> Interesting that ASPM is disabled, maybe didn't get enabled after
>>>>>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates capability
>>>>>>>>> disappeared.
>>>>>>>>>
>>>>>>>>>        01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
>>>>>>>>>                       LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>>>       -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>>>>>>>>>       +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>>>>>>>               Capabilities: [154 v1] L1 PM Substates
>>>>>>>>>                       L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>                                 PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
>>>>>>>>>       -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>       -                          T_CommonMode=0us LTR1.2_Threshold=98304ns
>>>>>>>>>       +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>>>>>       +                          T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>>>>>
>>>>>>>>> Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn't
>>>>>>>>> get reinitialized after re-enumeration?  Looks like we didn't restore
>>>>>>>>> L1SubCtl1.
>>>>>>>>>
>>>>>>>>> Bjorn
>>>>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Thank you all for the response and input! As Rajat mentioned I'm using
>>>>>> chromebook - but not Atlas (Amberlake) - in this case it is Babymega
>>>>>> (Apollolake)  - I will try to load most recent kernel and give it a
>>>>>> try once again.
>>>>>>
>>>>>> Best regards,
>>>>>> Lukasz
>>>>>
>>>>> Hi,
>>>>>
>>>>>     I have applied this patch on top of v5.19-rc7 (chromeos) and I'm
>>>>> still getting same results:
>>>>> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d6711b2030ea34b9
>>>>>
>>>>> Best regards,
>>>>> Lukasz
>>>>>
>>> Hi Vidya,
>>>
>>> Sorry for the long delay, I have retested your patch on top of
>>> linux-next/master (next-20220802) - the results for my device remain
>>> the same.
>>> Here are the logs (lspci -vvv before suspend, lspci -vvv after resume and dmesg)
>>> https://gist.github.com/semihalf-majczak-lukasz/c7bfd811359f23278034056a8002b3ef
>>> Let me know if you need any more logs and/or tests.
>>>
>>> Best regards,
>>> Lukasz
>>>
> Hi Vidya,
> 
> After your last email, I've re-tested my setup and (without your
> patch)  the capability register also disappears - so it looks there is
> - in fact - some problem in my setup and your patch just brings it to
> the top as after resume tries to write to a register that is no longer
> present. I'm very sorry for the confusion here and I've not notice
> that at the very beginning.
> 
> Best regards,
> Lukasz
> 
