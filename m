Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91C3588C79
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 14:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiHCMzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiHCMzo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 08:55:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D164BB9A;
        Wed,  3 Aug 2022 05:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT1eaJDyhoN0tlePQEs1zrPPzreFCjZXTCmfztBC7UpON4ddft9hMblOMaK4LI4afR0r7TC+SUSDQekqM/1acdu/y7m+HEtEEYNBBc+TdvNvnEj0rx2yZnRvh6QNi6tCCazhX3aMoyhspOUuqTnyckCBtJzGBSg5dc90XqtRQjZGujpCIyPcxyLHzRKUjjWM0DSbBlf+7ECUPNRJbocJLVxkhYuPGZb9xHPLlNwIYcCvDOyIUMrYT6qiDUuo5bylC/5QyZPyuYciDU0L2lB/PP4uTjcaGzvLwX3C7+UHgPsJgs9oOv3pb4nrwB/FRocyVlapK0ae/dEeMwJt5SD5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJPjfsEoEB20Kt0EAi6CjkXaK8+0ITQeGX17rUXdNt0=;
 b=NwJpun2BoBO410dfYjZKJBluhO7LQIgDU9WS37w8zQBEv5LGRx7smTks248s1YdcF33fjYPFqmTup6lZPpoO953gcky0nGYxndPSE1y/z1G7hQp8vbOqfmLr2dc2FJifrXxybbTB2QouE1ux1j5qkrb9EhX9zyDRakp85+ul7Nrl4skMNuXoymEp75sfYRAo7WTGuFE/7Zpr4Jv8GhrmK6GlJRpxhh79ZnprYoHyKPxNf572IDzRuZetIBzI/6Et7cYjBFbeLrtO1VDVfhv34OZLe0YtA2W1smvcGQ9ebfjRwwVV/s9w7TYnBLh+2hUN0+XEBhvpG/zycZe8t+6GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJPjfsEoEB20Kt0EAi6CjkXaK8+0ITQeGX17rUXdNt0=;
 b=cFORMQdpPhZpjffRe0BFDiPBQynIXhgn0jTWpgNBs43Z16HSvP09IfjW254+kMA4qtSOYeWW7GJ78ojliFazi2cCD6gVaCW6qBwdiS/EwFLnTeZs17Pxst+2U2CHG6Z6+mltU1meESzzScgXYtl6pUAWlnyXan2yVI9Sl4FRsT3BakiRhp1tHlap/SVJWTSZQAnLu37mBWX2AhDAQaDDmTeIFfHhVa91CaxmT2KI+PdkoqMslfyH0FI9obVOjXMAYstI4zKOPbzKmogWPEKopgp2142wMmGKJ8RWhW1u4uzmHkbYnQwir8aL/zcLveAvF+ORaby1+ftwzbQvzgIWGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 12:55:40 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 12:55:40 +0000
Message-ID: <d3228b1f-8d12-bfab-4cba-6d93a6869f20@nvidia.com>
Date:   Wed, 3 Aug 2022 18:25:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36f5789c-518d-4e1e-3449-08da754f77c8
X-MS-TrafficTypeDiagnostic: IA1PR12MB6531:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE95ZGpyeU5OUERLSTVlZi9KNEtDUmEyelh3Z2oxZFhzOUR2MVhPbTFNRGVN?=
 =?utf-8?B?bmxVc1FoY29XWWZ1bzRzemlkU0plQzI2cEY2d1ljYldKMDFNalZBalNWVmto?=
 =?utf-8?B?RUx4UkJJb2dpU01Xa3gxd0YzYjUwUzB4NllIRjlHUlJ5UzRGaE5kbmpWNXBp?=
 =?utf-8?B?M05IaTZiek1mWUJjVUg1enNxU3NKOWowcmMyZDVBVTAxQlcwMFRwbmV3a2N5?=
 =?utf-8?B?NER1MU5DS285bGM3UFlwSjZva1VicXpJeVo1T1crT1NRMUpIaUtSQ1EwRVZL?=
 =?utf-8?B?QlFGeEZ6MlFQdTVWMHhYWTZOK2V1QXJtTWNhK0ZrblZsV0lNSEhPVzF0U2h5?=
 =?utf-8?B?NFBqSjk2dVI2dWpZdU5BNzM2Qytwb0d6b0FQaEdoUnJqcFFPL0dsQkxMaHNZ?=
 =?utf-8?B?c2d6eXJVT1FGT2ZzbkNzcHVxZjAvRHFpMlNwUzBMaVIrZ2NYc0Vvd2ozaExH?=
 =?utf-8?B?VVdnQkY0Q1ZYbjdkYzhZUHIrY1NxakRKcnh2TWNxcUVsRnEyZ0F0cm1Hdity?=
 =?utf-8?B?NWdUR0FBWEhyZTNVQ2VVdjNkSm01WldKamozeHZ3QWloYU15L3NVdTJOcjNy?=
 =?utf-8?B?bSs1d1ZSbE9XS1o4WjRLZkhmVlpQbGJPSTNlWnE2b1B0cituK2pCd2k5eFkr?=
 =?utf-8?B?VEdDVVdHbWFZTnZrZ3MvdFdqQ0Zmc1lWblE0K2NCS1JYemhCZmtsODlYMjJW?=
 =?utf-8?B?NnBnSzI5RThMWEV3SXl4NEJPYWhzRkQ2aWRpKytpY2RXSkJNWkNtV2Rod0dm?=
 =?utf-8?B?UDVlNTVNbE5UYk9XbXFkaUlYNGFkZzg0OWMvaFYvUDNJK0E4bjI2Z2M2a3Ew?=
 =?utf-8?B?SU95b3pjN3JYVitEUHJObUl0VHJCb0htVEZwUVZPV2ZJZnI3MTFBQ0tOL0pj?=
 =?utf-8?B?YXBDa2N4UXUyZ1IzeE9mM0JjbUtCcUszWGhYaEdTdjMrZVErR254WGpvbVlJ?=
 =?utf-8?B?VUMvYnVkWWpkbGpKWFcxWEZxRGlvejdSRUhOeWtDbEhzWmIveUh4bG1PSmM5?=
 =?utf-8?B?YzB0cS9qQ1orQk91YjdOYVl6ZkJBc2pCVGFhZm5WdUQrVVRCM21ZczMrWUZr?=
 =?utf-8?B?aWpOTWh3YXU5SVJaWktQUjdnRUZ0QUtQSzlGM0xvb3hsZG5BbDJSMnpzMHAw?=
 =?utf-8?B?RWpNdUwzQjlvSUVPTUgyZXFidlJ1MmZSaEN1M3NNaVhqdUZJQXl1ZVZ2c2ZI?=
 =?utf-8?B?UXdPZzdQbkhYLzlHTmZXcG9uR2l2VXA1NXp0eHYvUUZwam12WUplVTM5SHhj?=
 =?utf-8?B?N1Fmc3U0ZUQ3VmNyWGJsdHNNL2xpTVlUcnRQMUNLcVF1cTc0RndSbmpvMTFT?=
 =?utf-8?Q?mZ9TFkAjyv8k4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(53546011)(6506007)(8936002)(26005)(6512007)(38100700002)(41300700001)(6666004)(86362001)(7416002)(2906002)(15650500001)(31686004)(36756003)(30864003)(5660300002)(66476007)(66556008)(66946007)(8676002)(31696002)(4326008)(966005)(6486002)(478600001)(83380400001)(6916009)(19627235002)(316002)(54906003)(186003)(2616005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRmWk90VVlqSmhhVnhOVzAzWUxlOVJIN1loS2k1U0w3bWZmckdUUTVzVjM4?=
 =?utf-8?B?UEtSTzNKUGtlcU1oTWZuNFFzV2lDczhKQWkwUWhJNVNvNjY4UXZBYnNBckdW?=
 =?utf-8?B?aWdES0s3SXhaVk90MXVCUG43RDFSeXlvY1FER0NIWjFhdzZFb01FTkVPZ1lW?=
 =?utf-8?B?dUt1dHk1NDNNN2swdXVpWUw4ZEEwZ1BPN21KcUJWdis0VlhMTWxvdjlORFNW?=
 =?utf-8?B?cGdSazJabmtoZ1ZsYzcwWFBjSTZCaDAwRnhTNDREVm55aFNScXpUZEMzSlBZ?=
 =?utf-8?B?YU5VZTlJZjI2ZHRnUU8vKzh1TWoreHVlUCtlUUl4cnNrSzNqYnB4c0tEOVB0?=
 =?utf-8?B?TUVqdFExR29FUWQ3NHJZVDlnQlFjNFpRbVg5VnNzNU5tRFBQU1k4UW1qOUhU?=
 =?utf-8?B?YzBJT0FKZmh1ODdqOVhWMzNETWdPTlVWVDNGZXNCSmNyQzNCV2NiYVcydTlL?=
 =?utf-8?B?VjhaYnJUcGlRT2dVQzlCYXZONmRleWw5SENVUi9RdUlFeEtyeUNQWkFua1dG?=
 =?utf-8?B?RTRvMEVEMEtUQVpOaEFLUjFjamZxRm93QitnVCsyQmIyaC9rMTlwdkJadVRN?=
 =?utf-8?B?UFVZOERaNWpUYi85RERGKzJ3WCt0WDdDWDNDbThpMElpeWVUU2FxRVlMVmU0?=
 =?utf-8?B?YVllN3lLZXhYb2x1eDBVR3NTbnVxQXNwU1NCVkNEZXBDZWlHMjRqNWExYlM2?=
 =?utf-8?B?WTl2OGhuRGJNMmJpamZCQ0tRWFo3ejFEZ1RTWlpVclIzN0hRekFpNTFQeUVH?=
 =?utf-8?B?Sm1zeGVjWE1LNWxGZHA2aWhWQ2RWbkxrTU9wL3VzYWtONGJub0N4ZFBOQVRL?=
 =?utf-8?B?VlNqWjNTNzdHQWtQVXJWa1oxOHpPR0NlOFZycE92d2V5Ynhyc0h5NkM2WWw4?=
 =?utf-8?B?ditVUzVKRm5BNnlUbkwvdmlJT21Nd3B2dEpGU1UzcWNSMksvSThLaHo4empw?=
 =?utf-8?B?UWdsakQ4TXZuUW1ITEV2MHlFL1k5NnQzTkVoam5pOVFnODJueHFOS3lNUGpt?=
 =?utf-8?B?YXFlNTdDSmoySStmaFh4bzh4NGNRUzdjeTFBbVRCQ0FXQkZ3TnBlTEdCYUQx?=
 =?utf-8?B?QzBqSXZFUVd4bGpNaFFZMWRNcTNEVGs2MDBxaWlOQWNObFJtNEQzWkxCeGlD?=
 =?utf-8?B?UW56SHdLN2JZcWZBNWVmUHFzclVHUUtIRE9uRGE4cE9KcWRtVVdPak9Cakxp?=
 =?utf-8?B?MDRneW9BdDNkVmpjVVhJa1k3c2xwbk9UbUVZVUZlU2ZoSUFZYTBtUzMrU2Fk?=
 =?utf-8?B?TGZqbi9MMkFJc25lbndmTFlFeTJna1UvREd5ei9rQnVkcWtGUWxRRDQwMW41?=
 =?utf-8?B?M1pFS0djWXcyNlB0bDE1bEMwcEpQQkYwaHd6Z3lKRVVaM2lDM2Y4aTIwcGgz?=
 =?utf-8?B?S1VsaEVQUndEZ3d1K3FJOU5ERUlqbCs0OU02TnA5cWIvK1VKbUhqWlRSTTlR?=
 =?utf-8?B?SWtoWGFFQUNPOVFHZUcwM2F6ZXBMQjV3S1NEVVFNekE4ck5OQ0dtZTJZN1g5?=
 =?utf-8?B?eldXS0RoM3Ztb2NTWVZXNjdIVkZ5Mm81eEo4VlNjNlRkSUJQcjJGY2hHZW1p?=
 =?utf-8?B?alNRdWFHNTV1clI0cGRaa1dRR1lWNU9FYTdjdmJMeTlFRDNJVzRwbjZFd1E3?=
 =?utf-8?B?S29NczFxblhyMTFhZG5ZR1pWMHY2TEhNTFhhOU1TMHpBR0ZsNTI1bXJyWEVN?=
 =?utf-8?B?c0kybUZTRmhqWVl4SklTSXNoQkZ1M2RTWmVSLzRheU1wSjJHMVVhWWJCREZK?=
 =?utf-8?B?L0E0cXpoY2puY2YzK2ZabkQrUzc3TGJzQzFZeCtKSWZJSTdvWFBQbkhGQUNI?=
 =?utf-8?B?THhqWXRzYldMK0d3b1JxOTVIUGMyd1Z2bFJJTkFmdHJENTR5MGJlZ2J3cEZV?=
 =?utf-8?B?dTJLM1gweTBJZ1dPVnRqcHVBL3dncFMyYm4xSXdBL05PTjEzRGw1c2dJZk9S?=
 =?utf-8?B?NDk5V2x5VXlhcm9HeGZmZWs5VXc5OEt0NTlzOVJvRUY0K3pYQ2R3dlJHZEp4?=
 =?utf-8?B?Y2tVUTJPV3ovK1JDbkFOa0VBZGRHR1diT1dYVEVPeXVMbkl0VzN2YjNIeDJm?=
 =?utf-8?B?ZzNCTzJzcy9IbkNnUUpKT1JWcWdCbWoxWFNxQU11UENwL1NucW91MVlCTTRI?=
 =?utf-8?Q?nL0gBZ7OwwT2Y4PYzLQ+l3fsm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f5789c-518d-4e1e-3449-08da754f77c8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 12:55:40.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSsGOpmiL64MFlPXSZSTrGlrmEbVfCPrBV+/areJVLtvoyilKrrw3PuJVBisAjvCoQiZEVthXYis+1JS1f+qPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Lukasz for the logs.
I still that the L1SS capability in the root port (00:14.0) disappeared 
after resume.
I still don't understand how this patch can make the capability register 
itself disappear. Honestly, I still see this as a HW issue.
Bjorn, could you please throw some light on this?

Thanks,
Vidya Sagar

On 8/3/2022 5:34 PM, Lukasz Majczak wrote:
> External email: Use caution opening links or attachments
> 
> 
> pt., 29 lip 2022 o 16:36 Vidya Sagar <vidyas@nvidia.com> napisał(a):
>>
>> Hi Lukasz,
>> Thanks for sharing your observations.
>>
>> Could you please also share the output of 'sudo lspci -vvvv' before and
>> after suspend-resume cycle with the latest linux-next?
>> Do we still see the L1SS capabilities getting disappeared post resume?
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisał(a):
>>>>
>>>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisał(a):
>>>>>
>>>>> Hello,
>>>>>
>>>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>>
>>>>>> Agree with Bjorn's observations.
>>>>>> The fact that the L1SS capability registers themselves disappeared in
>>>>>> the root port post resume indicates that there seems to be something
>>>>>> wrong with the BIOS itself.
>>>>>> Could you please check from that perspective?
>>>>>
>>>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. This
>>>>> is a shallower sleep state that preserves more state than, for e.g. S3
>>>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come in picture
>>>>> at all. i.e. after the kernel runs its suspend routines, it just puts
>>>>> the CPU into S0ix state. So I do not think there is a BIOS angle to
>>>>> this.
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Vidya Sagar
>>>>>>
>>>>>>
>>>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
>>>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> napisał(a):
>>>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>>>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
>>>>>>>>>>> saved and restored during suspend/resume leading to L1 Substates
>>>>>>>>>>> configuration being lost post-resume.
>>>>>>>>>>>
>>>>>>>>>>> Save the L1 Substates control registers so that the configuration is
>>>>>>>>>>> retained post-resume.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>>>>>>>>
>>>>>>>>>> Hi Vidya,
>>>>>>>>>>
>>>>>>>>>> I tested this patch on kernel v5.19-rc6.
>>>>>>>>>> The test device is GL9755 card reader controller on Intel i5-10210U RVP.
>>>>>>>>>> This patch can restore L1SS after suspend/resume.
>>>>>>>>>>
>>>>>>>>>> The test results are as follows:
>>>>>>>>>>
>>>>>>>>>> After Boot:
>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>            Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>                              PortCommonModeRestoreTime=255us
>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>                    L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>                               T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>>>                    L1SubCtl2: T_PwrOn=3100us
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> After suspend/resume without this patch.
>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>            Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>                              PortCommonModeRestoreTime=255us
>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>                    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>>>>>>                               T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>>>>>>                    L1SubCtl2: T_PwrOn=10us
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> After suspend/resume with this patch.
>>>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>>>            Capabilities: [110 v1] L1 PM Substates
>>>>>>>>>>                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>>>                              PortCommonModeRestoreTime=255us
>>>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>>>                    L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>>>                               T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>>>                    L1SubCtl2: T_PwrOn=3100us
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
>>>>>>>>>
>>>>>>>>> Forgot to add mine:
>>>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> Ben Chuang
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>> Hi,
>>>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
>>>>>>>>>>> on your laptop (Dell XPS 13) one last time?
>>>>>>>>>>> IMHO, the regression observed on your laptop with an old version of the patch
>>>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Vidya Sagar
>>>>>>>>>>>
>>>>>>>>>>>     drivers/pci/pci.c       |  7 +++++++
>>>>>>>>>>>     drivers/pci/pci.h       |  4 ++++
>>>>>>>>>>>     drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>     3 files changed, 55 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
>>>>>>>>>>> --- a/drivers/pci/pci.c
>>>>>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
>>>>>>>>>>>                    return i;
>>>>>>>>>>>
>>>>>>>>>>>            pci_save_ltr_state(dev);
>>>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
>>>>>>>>>>>            pci_save_dpc_state(dev);
>>>>>>>>>>>            pci_save_aer_state(dev);
>>>>>>>>>>>            pci_save_ptm_state(dev);
>>>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
>>>>>>>>>>>             * LTR itself (in the PCIe capability).
>>>>>>>>>>>             */
>>>>>>>>>>>            pci_restore_ltr_state(dev);
>>>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
>>>>>>>>>>>
>>>>>>>>>>>            pci_restore_pcie_state(dev);
>>>>>>>>>>>            pci_restore_pasid_state(dev);
>>>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>>>>>>>>>>>            if (error)
>>>>>>>>>>>                    pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>>>>>>>>>>>
>>>>>>>>>>> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
>>>>>>>>>>> +                                           2 * sizeof(u32));
>>>>>>>>>>> +       if (error)
>>>>>>>>>>> +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
>>>>>>>>>>> +
>>>>>>>>>>>            pci_allocate_vc_save_buffers(dev);
>>>>>>>>>>>     }
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
>>>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>>>>>>>>>>     void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>>>>>>>>>>     void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>>>>>>>>>>>     void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>>>>     #else
>>>>>>>>>>>     static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>>>>>>>>>>     static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>>>>>>>>>>     static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>>>>>>>>>>     static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>>>>     #endif
>>>>>>>>>>>
>>>>>>>>>>>     #ifdef CONFIG_PCIE_ECRC
>>>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
>>>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>>>>>>>>>>>                                    PCI_L1SS_CTL1_L1SS_MASK, val);
>>>>>>>>>>>     }
>>>>>>>>>>>
>>>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>>>> +{
>>>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>>>> +       u32 *cap;
>>>>>>>>>>> +
>>>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>>>> +               return;
>>>>>>>>>>> +
>>>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>>>> +               return;
>>>>>>>>>>> +
>>>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>> +       if (!save_state)
>>>>>>>>>>> +               return;
>>>>>>>>>>> +
>>>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
>>>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>>>> +{
>>>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>>>> +       u32 *cap;
>>>>>>>>>>> +
>>>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>>>> +               return;
>>>>>>>>>>> +
>>>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>>>> +               return;
>>>>>>>>>>> +
>>>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>>>> +       if (!save_state)
>>>>>>>>>>> +               return;
>>>>>>>>>>> +
>>>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
>>>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>     static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>>>>>>>>>>>     {
>>>>>>>>>>>            pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
>>>>>>>>>>> --
>>>>>>>>>>> 2.17.1
>>>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> With this patch (and also mentioned
>>>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@canonical.com/)
>>>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems after
>>>>>>>> suspend/resume with my WiFi card - it looks like whole communication
>>>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
>>>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3
>>>>>>>>
>>>>>>>> I played a little bit with this code and it looks like the
>>>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
>>>>>>>> why, not a PCI expert).
>>>>>>>
>>>>>>> Thanks a lot for testing this!  I'm not quite sure what to make of the
>>>>>>> results since v5.10 is fairly old (Dec 2020) and I don't know what
>>>>>>> other changes are in chromeos-5.10.
>>>>>
>>>>> Lukasz: I assume you are running this on Atlas and are seeing this bug
>>>>> when uprev'ving it to 5.10 kernel. Can you please try it on a newer
>>>>> Intel platform that have the latest upstream kernel running already
>>>>> and see if this can be reproduced there too?
>>>>> Note that the wifi PCI device is different on newer Intel platforms,
>>>>> but platform design is similar enough that I suspect we should see
>>>>> similar bug on those too. The other option is to try the latest
>>>>> ustream kernel on Atlas. Perhaps if we just care about wifi (and
>>>>> ignore bringing up the graphics stack and GUI), it may come up
>>>>> sufficiently enough to try this patch?
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Rajat
>>>>>
>>>>>
>>>>>>>
>>>>>>> Random observations, no analysis below.  This from your dmesg
>>>>>>> certainly looks like PCI reads failing and returning ~0:
>>>>>>>
>>>>>>>      Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
>>>>>>>      iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
>>>>>>>      iwlwifi 0000:01:00.0: Device gone - attempting removal
>>>>>>>      Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
>>>>>>>
>>>>>>> And then we re-enumerate 01:00.0 and it looks like it may have been
>>>>>>> reset (BAR is 0):
>>>>>>>
>>>>>>>      pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
>>>>>>>      pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>>>>>>>
>>>>>>> lspci diffs from before/after suspend:
>>>>>>>
>>>>>>>       00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal decode])
>>>>>>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>>>>>>>      -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr+ TransPend-
>>>>>>>      +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>>>>>>>      -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>      +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>      -               LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>>>>>>>      +               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
>>>>>>>      -       Capabilities: [150 v0] Null
>>>>>>>      -       Capabilities: [200 v1] L1 PM Substates
>>>>>>>      -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>>>      -                         PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>>>>>>>      -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>      -                          T_CommonMode=40us LTR1.2_Threshold=98304ns
>>>>>>>      -               L1SubCtl2: T_PwrOn=60us
>>>>>>>
>>>>>>> The DevSta differences might be BIOS bugs, probably not relevant.
>>>>>>> Interesting that ASPM is disabled, maybe didn't get enabled after
>>>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates capability
>>>>>>> disappeared.
>>>>>>>
>>>>>>>       01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
>>>>>>>                      LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>>>      -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>>>>>>>      +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>>>>>              Capabilities: [154 v1] L1 PM Substates
>>>>>>>                      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>>>                                PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
>>>>>>>      -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>      -                          T_CommonMode=0us LTR1.2_Threshold=98304ns
>>>>>>>      +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>>>      +                          T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>>>
>>>>>>> Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn't
>>>>>>> get reinitialized after re-enumeration?  Looks like we didn't restore
>>>>>>> L1SubCtl1.
>>>>>>>
>>>>>>> Bjorn
>>>>>>>
>>>>
>>>> Hi,
>>>>
>>>> Thank you all for the response and input! As Rajat mentioned I'm using
>>>> chromebook - but not Atlas (Amberlake) - in this case it is Babymega
>>>> (Apollolake)  - I will try to load most recent kernel and give it a
>>>> try once again.
>>>>
>>>> Best regards,
>>>> Lukasz
>>>
>>> Hi,
>>>
>>>    I have applied this patch on top of v5.19-rc7 (chromeos) and I'm
>>> still getting same results:
>>> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d6711b2030ea34b9
>>>
>>> Best regards,
>>> Lukasz
>>>
> Hi Vidya,
> 
> Sorry for the long delay, I have retested your patch on top of
> linux-next/master (next-20220802) - the results for my device remain
> the same.
> Here are the logs (lspci -vvv before suspend, lspci -vvv after resume and dmesg)
> https://gist.github.com/semihalf-majczak-lukasz/c7bfd811359f23278034056a8002b3ef
> Let me know if you need any more logs and/or tests.
> 
> Best regards,
> Lukasz
> 
