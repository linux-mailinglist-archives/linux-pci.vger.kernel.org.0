Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80B57F081
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jul 2022 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiGWRDa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Jul 2022 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWRD3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jul 2022 13:03:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8434B17E26;
        Sat, 23 Jul 2022 10:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7Y72nYeZmNpYRsoLe7lfBRdYOFRNw9QyAe3yX9aprTOgw8j9ZiB9SRrIWN6APGM0rSpKNNOfqNEyWqu9MZTC4QlqeZcIMfsk4pPsBEXJ7iX0sQbQooNofKyD95tQgjDLQ79OqRIeaEf3tjbQ2JNIWr395JEYU+UNR4fMxaR4d7pwzEnboosm4yohR6qrrV2reSC+LJ6MBmM+z8qOrO0Mxs1n1cSIcSYN7ZbdDStpIsQ69DiwQ7WzEEE5rdKzK3qkORaiHtxVDqJzg2co7nc9JbNhSKj1SoHssX7+BfC1WQN4jvDQQJOHpQNIFX8pjQaJjIg1JPOp6wJ78DL+k+EEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOJHxwtZZctbrUHzkG0kvn0wfNuRIkd/+L3nhQ8tYIw=;
 b=YOUCjKnaYT8iXhb76J20nFELobYOQtKYorcqZXmIYBx6zSuAyucwHgQqM2YtoJ7ebRyRCvZbEecCNc/91oLmGO8AvjiIqTLO0OWSZwngqekh3PQRgqVT4l/3KF4dZl69eyvTN4F8aaUKYc0Ubb0NnsCZNt4NNCahZFPMTc8SijbhdngD6YuY+iQmEf00KgRXdFiY/a6Ks2NNBVfNBMXK+xr1WeafGsgr85VITsoacGug5lDxazkkceua3UgQaoW9/7PQhbrbKcBow3tpbu/51Erz4okyiQYC9oTtTWeuBV+FfpL0dDwrdc77j8xlxYwYsqgKDvTr9g29SiV8fur7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOJHxwtZZctbrUHzkG0kvn0wfNuRIkd/+L3nhQ8tYIw=;
 b=aIoryY5APoZtN5wb9HU+C72GvV28eLZ/H/wWx7QIe69i89gZN6NHhADdmDpotYrKMq0UT6hLAQSZxPM06U439cIHG9u5evz/fs6RXeCWJE5BJWbKl2qBRLA2Z/VSi3M6iHzqRgPgiBc7RslFKFe6LUZaYRnYQxh5L9IzXxsItgaNCfrzlQj+1+xL1PfzP97x2Uf9ijaAMTBwsWmr3sNHSC/rIVq0QzIpde88T6Z3tKeR/8IXH7MoH4j1FlZM3lTt3tZ71S4PnDkRXRmSOuTiHnN1NWNPW6uEt32jtAwnUOLebmUbNf3sjl9kg9e7PxhKW8nMrg9DAUGeKU+GnFzAtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 17:03:25 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::9437:8b73:188e:66e2]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::9437:8b73:188e:66e2%7]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 17:03:24 +0000
Message-ID: <86522aa5-2855-0f73-ddb2-a2b50b2fd1b7@nvidia.com>
Date:   Sat, 23 Jul 2022 22:33:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lukasz Majczak <lma@semihalf.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, kenny@panix.com, treding@nvidia.com,
        jonathanh@nvidia.com, abhsahu@nvidia.com, sagupta@nvidia.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220722174212.GA1911979@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220722174212.GA1911979@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0074.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::14)
 To BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbfb9b1b-16e2-4505-1ccf-08da6ccd40f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3309:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7awOvLmXYmEQUeHo6imJY9ceCcSkPKc4c3sCqW+ZG9zUBniZLxnGlXKUMYkRjyoIdab+ijS4mhzraNimVuxS7TM7wf46T7gMrNehetmx01y/zV4eex2As35bjDBpWOdYsDOVVKZmCUab36cFLnY405cQDeDB4L2JFk3gtjNSAiZwHXXP5LQyJZ9D/fWzWTTHClzzflkts7CMPgaiWiOGjifj4lZlKABdQkJyVvMton1lV8+Q2jUOy/eNBAczgRj7yb+YN34lFqPP/VNWDAy3EMFvNDokZLkC3peVMFshmJ1UZzlz1aHOORkhJZxdTbMJJd1MWv2rdVB927afJudgMW5Om44s62QSvFuvF9rCMiNUbobuu0KEQMiDGXaPHwZsLz+NJpKKLCEyzkPI4ttvW9RwuUZ7tZt+b0crM0G0Y6To3G+7Y5N446YzW+lTE8tKIgkCLzNJuRutRtoPcfUDngUYXjWi9wn9Zw48GoYg+VelNbU+rlKjtBzrWIBkDc7OgFUHEWzEJGyot3QXbkzsNFlubnvLT/CT2H4huOYJYDYRN21WYopXx1fGDf+dyP1Ip/xhWhIQmB6JY8huWPb4KVM93fFLk+r1jIxgvN5egMxWkcKBlYQ3vW5oIPHRWodz4Fe11nIR7TvBuU+mriIUouHfmP3Qun9d1hnBOEhYtfkN8AcoGqp2cTLpfj4QbhvCuWlQGFu+k9akcY0dW9socZIpNYssBbivsTz7tRZ4BXLfTo5AHt2kmSgiGRz+kRq77XkGOS4TjQkD/2rRjEubEvN08Zn3f27PH8mhjTj1In/+oUzSpdfF9Oh4/GLAbG7fa/lCszhKThRT5CAH6KWfNgrh8t/SFzvKyBF7xFyeOShamsZs5BfxSewhzQIuRnlnKf6vSXAkAC8rscfx8gPOc5FtaGugE2PVPeLDOy8X62D0yEmEarqfMvBdHIe/MEH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(2616005)(6506007)(186003)(83380400001)(54906003)(31686004)(6512007)(110136005)(41300700001)(36756003)(6666004)(30864003)(15650500001)(38100700002)(26005)(66476007)(2906002)(19627235002)(7416002)(5660300002)(53546011)(478600001)(66946007)(966005)(66556008)(6486002)(316002)(8936002)(4326008)(31696002)(8676002)(86362001)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZrYTZpYVRUc1RLSkEydEljMlB6WloyZjRMelFmNEZkUGxQRkVHN2YvRUhZ?=
 =?utf-8?B?a3VObjZ1bjBSN1ZmVzBGalQ0VzZTQmpLQUVaNkpERFRGb0dBeWo5amtjeHlk?=
 =?utf-8?B?bHpCY0h5UFlhczJtclphb1pPSm0yTm51ZFgyRS9WRkhlUFd4K2djai9HZXVZ?=
 =?utf-8?B?NnlUUC9obnIxQzQ5VU1vbWUxWkFmRElVMThWSFZCdDdvZ2tzK2dKMFJQaXBV?=
 =?utf-8?B?LzV0SCtWTGUrYjRURTRaN3E3OHBLS0dEQWlnZHcrUCtZZ25oU2JuMlM3Y2ZH?=
 =?utf-8?B?MzJNRkw1bW1WL2w1eTkydm1PMmJWaXhRcGdJaytrSGxLSWpCM2s5eFVUM1hR?=
 =?utf-8?B?TmFqaWxaWEVVYmxhU0lUNTVkcW1ybTFpOGhPL3doYk5PVDc2N0NXMFVaOUd6?=
 =?utf-8?B?a2dhajA3UEFXUHlkZFE4akgzbGdIUG9tS0NxR0RtZ3JvcVdEOTRBNkhESU84?=
 =?utf-8?B?QVFGYXFqbEljK1ViT0IvbTRaUE5iS3liY0dYQi9TbjdTUmhoUGZlRUMwZmU3?=
 =?utf-8?B?a2J2cDA4bmZCbjRZUkRQMGtvejkyRVZicUNrUVRGNTNTRTlXd3VDVERicCsy?=
 =?utf-8?B?WGZiWmE2bzgxTkE5SFFUNFJwOU5aSWF3SERrSnVNMnk3ZVEwbDltOWMxT3Ro?=
 =?utf-8?B?YzZxZHFzQkpCQXlMUjgwS0lhQkZnOSt6YjljVHpvNHJkb3puVVdXaU5qaFpu?=
 =?utf-8?B?K3pZbW85alQwYVBvRisxUC9LRmc1K2M3Z0pmT1JzZ3lzazk3b1FhSzJueWZv?=
 =?utf-8?B?Uy9jNEFLYTZ0YXhhUy9BSmYrR0xkOWI3VkdUYlZFQnJjVFYwbVhESytrdkJw?=
 =?utf-8?B?ODV3NUdENWdUUENXdHhsM2tyeEw2eXZ3eStNamNLZWx5WDhwRzF0TWFpYm5J?=
 =?utf-8?B?REY3ZWx2emp5dXByMjNjQVFrdWtlZmR2a3ZuSkYxd2w2TEtQUzhpZ1lnbkU5?=
 =?utf-8?B?dUJUUVR4WFVLbXg5S3BqU1FkVTJhUnFQVmJPV2d0OW5xNmtpeDhCdWlQS1hX?=
 =?utf-8?B?U0pTMUpDMEdqT3lNTWhnSFBrMlVKcW52V2tabHZETk9HZTl5cVdRS3orNTAw?=
 =?utf-8?B?TmNDaGRTMVpVdGxWSmd6NGpLVmtVamZIbnkvNDhXV1NHcllwMjZvMkpVMTZF?=
 =?utf-8?B?TXpqYTB5TWR3eFUxdFpyQkZRUlZWYmVwT2htVEVjd0M2WXRjRnlsc2pHb2Q4?=
 =?utf-8?B?aUZTbUpCQldkZ0QvaEoyV3F0U1Y4NC93bDk1VGloM3l4T1BSQ05pbStFMm5r?=
 =?utf-8?B?YVR1SVR6U21UNGV5UUFyb08wT0NiR1NNWFBqbytUUU5Qb1hTQTNJZUpicE55?=
 =?utf-8?B?bStCLzJJTTBUeTNvUFNKTGEvZDB0OXJzMi82QndVdWtwNjJvZk14b3lqL2kx?=
 =?utf-8?B?UUhyUlV2T1U4QmVJL3E0NzFmZngyMlM3SHNRRTNTUWZlUzJ5a2FFWGVxcGRo?=
 =?utf-8?B?ZTVWT3ltYm1YOFNzcFh5NllxTTA3SGc0R1NvR2hCRGpnQWxpMFVaY3ZvOWFu?=
 =?utf-8?B?S25KQ0NCK281amRVMHorRHBKcWVuZVAzQ2VJZ1VLZ3pWRXlzc2grVUxlNjJ6?=
 =?utf-8?B?VmQ0a1FWY0swckcyemtOTW5lK09ML081ZVBPaDNycW4rQXRZcS9UUGJvc1pP?=
 =?utf-8?B?M2J1RTBjdGFnd2pFaHVGSDF2M2NCQXpWeDBrL1Jqb0UyanNKNjNiRlFzS0lC?=
 =?utf-8?B?a1cwdXE5dGhsQVl2V0llS2MvSzhYRHdHS3orVEtTZUt0NlFxNTQxNXRoSVVv?=
 =?utf-8?B?QTRUK0JEekd4UzA2K0lIUHdIRFUxQWNJNkV1dFFtWm1Ud1MrV3BCQVhSRHB5?=
 =?utf-8?B?N0RuOEdkM2gybFZOdS9jNEdLTGx2S3dZbkJRQWZvT1FkVHdOeTNzMHZNMzNO?=
 =?utf-8?B?TURCVDFSZU0rc3M2K3l2OWhaam5BM2hkMjBvc0dObFdaZ0xXaXczTU44Y29v?=
 =?utf-8?B?RVRtRmlqaDdreDU4MjdiblFPRjZTc05NaTVVVUFtMkR3aXNqWmhrWTNyQ09k?=
 =?utf-8?B?TFRQZE92ZSt6Q3Vhdis4MUZYSDJsKzVUbkNOWmFZeG96S1loUG0vUUhYRHJQ?=
 =?utf-8?B?U1VyaXY5K3hMWHk0Ny9NWXV3ems3RGszbk1GQnBua1pmWGQyK2VJdlhYSWFj?=
 =?utf-8?Q?WKiGSRWlxsqLthD+Jfhqv+Ed1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfb9b1b-16e2-4505-1ccf-08da6ccd40f6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 17:03:24.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VcTJg9sRGRx5tYQMfJrlC1yDl+9+6HVZLk2CcVmw+qKI+Tqf0gadFFnyVoXhvuWJKghgr/QAjkyAGfH6/6K4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3309
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Agree with Bjorn's observations.
The fact that the L1SS capability registers themselves disappeared in 
the root port post resume indicates that there seems to be something 
wrong with the BIOS itself.
Could you please check from that perspective?

Thanks,
Vidya Sagar


On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> napisał(a):
>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>
>>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
>>>>> saved and restored during suspend/resume leading to L1 Substates
>>>>> configuration being lost post-resume.
>>>>>
>>>>> Save the L1 Substates control registers so that the configuration is
>>>>> retained post-resume.
>>>>>
>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>>
>>>> Hi Vidya,
>>>>
>>>> I tested this patch on kernel v5.19-rc6.
>>>> The test device is GL9755 card reader controller on Intel i5-10210U RVP.
>>>> This patch can restore L1SS after suspend/resume.
>>>>
>>>> The test results are as follows:
>>>>
>>>> After Boot:
>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>          Capabilities: [110 v1] L1 PM Substates
>>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>                            PortCommonModeRestoreTime=255us
>>>> PortTPowerOnTime=3100us
>>>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>                             T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>                  L1SubCtl2: T_PwrOn=3100us
>>>>
>>>>
>>>> After suspend/resume without this patch.
>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>          Capabilities: [110 v1] L1 PM Substates
>>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>                            PortCommonModeRestoreTime=255us
>>>> PortTPowerOnTime=3100us
>>>>                  L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>                             T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>                  L1SubCtl2: T_PwrOn=10us
>>>>
>>>>
>>>> After suspend/resume with this patch.
>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>          Capabilities: [110 v1] L1 PM Substates
>>>>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>                            PortCommonModeRestoreTime=255us
>>>> PortTPowerOnTime=3100us
>>>>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>                             T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>                  L1SubCtl2: T_PwrOn=3100us
>>>>
>>>>
>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
>>>
>>> Forgot to add mine:
>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>
>>>>
>>>> Best regards,
>>>> Ben Chuang
>>>>
>>>>
>>>>> ---
>>>>> Hi,
>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
>>>>> on your laptop (Dell XPS 13) one last time?
>>>>> IMHO, the regression observed on your laptop with an old version of the patch
>>>>> could be due to a buggy old version BIOS in the laptop.
>>>>>
>>>>> Thanks,
>>>>> Vidya Sagar
>>>>>
>>>>>   drivers/pci/pci.c       |  7 +++++++
>>>>>   drivers/pci/pci.h       |  4 ++++
>>>>>   drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>>>>>   3 files changed, 55 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index cfaf40a540a8..aca05880aaa3 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
>>>>>                  return i;
>>>>>
>>>>>          pci_save_ltr_state(dev);
>>>>> +       pci_save_aspm_l1ss_state(dev);
>>>>>          pci_save_dpc_state(dev);
>>>>>          pci_save_aer_state(dev);
>>>>>          pci_save_ptm_state(dev);
>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
>>>>>           * LTR itself (in the PCIe capability).
>>>>>           */
>>>>>          pci_restore_ltr_state(dev);
>>>>> +       pci_restore_aspm_l1ss_state(dev);
>>>>>
>>>>>          pci_restore_pcie_state(dev);
>>>>>          pci_restore_pasid_state(dev);
>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>>>>>          if (error)
>>>>>                  pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>>>>>
>>>>> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
>>>>> +                                           2 * sizeof(u32));
>>>>> +       if (error)
>>>>> +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
>>>>> +
>>>>>          pci_allocate_vc_save_buffers(dev);
>>>>>   }
>>>>>
>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>> index e10cdec6c56e..92d8c92662a4 100644
>>>>> --- a/drivers/pci/pci.h
>>>>> +++ b/drivers/pci/pci.h
>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>>>>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>>>>   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>>>>>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>>>>   #else
>>>>>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>>>>   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>>>>   static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>>>>   static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>   #endif
>>>>>
>>>>>   #ifdef CONFIG_PCIE_ECRC
>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>> index a96b7424c9bc..2c29fdd20059 100644
>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>>>>>                                  PCI_L1SS_CTL1_L1SS_MASK, val);
>>>>>   }
>>>>>
>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>>>> +{
>>>>> +       int aspm_l1ss;
>>>>> +       struct pci_cap_saved_state *save_state;
>>>>> +       u32 *cap;
>>>>> +
>>>>> +       if (!pci_is_pcie(dev))
>>>>> +               return;
>>>>> +
>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>> +       if (!aspm_l1ss)
>>>>> +               return;
>>>>> +
>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>> +       if (!save_state)
>>>>> +               return;
>>>>> +
>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
>>>>> +}
>>>>> +
>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>>>>> +{
>>>>> +       int aspm_l1ss;
>>>>> +       struct pci_cap_saved_state *save_state;
>>>>> +       u32 *cap;
>>>>> +
>>>>> +       if (!pci_is_pcie(dev))
>>>>> +               return;
>>>>> +
>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>> +       if (!aspm_l1ss)
>>>>> +               return;
>>>>> +
>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>> +       if (!save_state)
>>>>> +               return;
>>>>> +
>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
>>>>> +}
>>>>> +
>>>>>   static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>>>>>   {
>>>>>          pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
>>>>> --
>>>>> 2.17.1
>>>>>
>>
>> Hi,
>>
>> With this patch (and also mentioned
>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@canonical.com/)
>> applied on 5.10 (chromeos-5.10) I am observing problems after
>> suspend/resume with my WiFi card - it looks like whole communication
>> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
>> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3
>>
>> I played a little bit with this code and it looks like the
>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
>> why, not a PCI expert).
> 
> Thanks a lot for testing this!  I'm not quite sure what to make of the
> results since v5.10 is fairly old (Dec 2020) and I don't know what
> other changes are in chromeos-5.10.
> 
> Random observations, no analysis below.  This from your dmesg
> certainly looks like PCI reads failing and returning ~0:
> 
>    Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
>    iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
>    iwlwifi 0000:01:00.0: Device gone - attempting removal
>    Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
> 
> And then we re-enumerate 01:00.0 and it looks like it may have been
> reset (BAR is 0):
> 
>    pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
>    pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
> 
> lspci diffs from before/after suspend:
> 
>     00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal decode])
>       Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>    -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr+ TransPend-
>    +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>    -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>    +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>    -               LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>    +               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
>    -       Capabilities: [150 v0] Null
>    -       Capabilities: [200 v1] L1 PM Substates
>    -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>    -                         PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>    -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>    -                          T_CommonMode=40us LTR1.2_Threshold=98304ns
>    -               L1SubCtl2: T_PwrOn=60us
> 
> The DevSta differences might be BIOS bugs, probably not relevant.
> Interesting that ASPM is disabled, maybe didn't get enabled after
> re-enumerating 01:00.0?  Strange that the L1 PM Substates capability
> disappeared.
> 
>     01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
>                    LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>    -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>    +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>            Capabilities: [154 v1] L1 PM Substates
>                    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>                              PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
>    -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>    -                          T_CommonMode=0us LTR1.2_Threshold=98304ns
>    +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>    +                          T_CommonMode=0us LTR1.2_Threshold=0ns
> 
> Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn't
> get reinitialized after re-enumeration?  Looks like we didn't restore
> L1SubCtl1.
> 
> Bjorn
> 
