Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A05851A4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiG2OgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiG2OgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 10:36:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB556248C;
        Fri, 29 Jul 2022 07:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6LajMwrjh4CW0AANBImCB0yuqXwgVdE7YNQTuO6t7GOK74rdRay9CouO8BpGMbikcWDZ6A1mTa5a5ZAXckqpVwK89ZIQp2q+z7yoj7N4KzzFm2Na4VlvFeSgDcPM0qCKA8j0rpN/cq0KPQM7byBYkGjioXccsEq8/aiq33ka4Wj1ZMbVeVNfntCFi/qpPT6I1NsZHzTFklprzZy8tEJH4ylm7Yu90ZE5ccNL99HV6155m9xD9g0HVKJ3FZJDbPgSTGZWbVE6n+KJBFCI/IrPebNjONpPLprGo+4KLbbHj/Ro5XPsoPX2/JVxUWRG3VV/sCHeeF04oqo++VeYkk39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkt3hZcAgEm4ssy0pJyTVxq1NUaf+mdrAm+3VledS6A=;
 b=X58cB/D3MAnxEgy4E0OEHqpeFRnBZ/RBblNQmnph6otOOFnrRUhEfKkokD3wUUFx9wn0XFPIxbzW4t+nYghE2dDl5HCv6RrWKPCK67HABi/DhR7jJxqd7cysADdhYT085bRa2yaYfWwU4FKH2/y5T3GNdbPFV3s+3Ef+k+khfVkBUAc36iN5PnELLfPO8d9z3eU7h4NHGPgx25eRSOifWly+pHtu9Y/LhxqvhBYGMhaN+S8f++uTfFSPGm4vUzxinKP1GFZOtvB1c8XuAtvzwzFm5Eh9s477MqldPPMWRCKxHTDNHQrj4Lm0SdOlB0yI3ba/lcUln+FBGLDqRiMb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkt3hZcAgEm4ssy0pJyTVxq1NUaf+mdrAm+3VledS6A=;
 b=ATrm1WKw2TL4fuV8xVo27TGSu3U/kCMy2SZH3W49+e/tg9jajQx8m4QATXBnGJ5H8YLYF+yBnYYhi1ag8vOadstyFkKkP+t1OBiYAv4Tnabct0oIYIDcSoTqKxYVXtJgwG3LKPu7vLxePH8WRP1FI76aREgTTDJgUKA87GaxoPFcSWCZRTsF6hTV1TEtJFq6Tqrt2AkdzqP/UzN+7WLNwvXd6Kg+bTCDYXKR4p0TbaQK1dHgWbRFDrIW0HUZYCTRUAC65227nQSBKax/zkpC53Aj9A6mfRdvbzy9t2m85kFQauf+rsTBtbS5XW/ayEWqeq1H+bDe+uu9Br7ZeyzRNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by BYAPR12MB3190.namprd12.prod.outlook.com (2603:10b6:a03:132::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Fri, 29 Jul
 2022 14:36:05 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b150:321c:21e4:40c9%7]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 14:36:05 +0000
Message-ID: <8b36f97c-0cc4-3f4a-3b5b-49ad5786d9e9@nvidia.com>
Date:   Fri, 29 Jul 2022 20:05:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     Lukasz Majczak <lma@semihalf.com>, Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
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
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAFJ_xbqyxJ591DgC=xQEzokip6i_j0mex5SDTBrwkOe=-8bikg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::21) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 823cba45-d571-401a-fb4c-08da716faaa3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3190:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUU0c0djWWczNVlBZkRzY21ZV2lhVWJzbzhORy9rOHZJMzRGczU4QWowaWI0?=
 =?utf-8?B?KyttcVpreFZ6bjY3TDV3cGJDWHBWdWpRa0ZRdmZOWEdRNUlBaGpVWGRmS1B5?=
 =?utf-8?B?bFc0cGM2L1dtT1JxWGFtVDJUeE0wQ2VzWEFNL2RwRUtDR2lCYzNiQUFBM1o3?=
 =?utf-8?B?T3lKQ0pyQ3k3cnltMklwdHQvdjZKQ2IycVM3aXJFcHF0U3FVeGVyU1dLcjRw?=
 =?utf-8?B?L2Z2MTFZZEE5OHJlUWQ2eDhUaVk3ZjY3SEFMQ3NHdEQ1SVpVdFdBVVRRVVhE?=
 =?utf-8?B?Zms2dUxubmNTR3FTQlBKdW4yN0JZdnA0a01FZ1dqdG5QcXhQbmRvOFlHTFd5?=
 =?utf-8?B?WUdCYnljaG1kN3NzZUJIZ0Q1Zmx5UDFlcURUaUdCYVA1b3V2YnBQTDZRdEhU?=
 =?utf-8?B?L3poRFVRRkkzNXMxcXRxU1BjVXM1cnptQ05XYXc0cE5EN1pjVXprZE9sUkpl?=
 =?utf-8?B?Q0lRWlR2aTBMRUxaVVJhVzhlbWZpVmY1dmtXQytvVGRvVzQ1ZXpXczlSNm5u?=
 =?utf-8?B?a2s5VCt6MlVSWjYxamp3Vk5lWkdvUnpDTHhQL0w0UDFIQjVUS0VmTForN1JQ?=
 =?utf-8?B?ZHpOaEFyRTE4cnFvVE9LeDdGZ0ZvOUdMOGlDaVpXWVRFaW9DMStHejBkSmdV?=
 =?utf-8?B?NWE1UWtibFhaZ1o1Y1kwakVYdzgwanpWVGtOakVlcHBsQjQ5S09Ga05DMGM3?=
 =?utf-8?B?SkxhZ3RYV3JlQmtUVFAwOFFNakx6QmY1V01LZWY2akoyTDVUY2FiOG5ERzBG?=
 =?utf-8?B?YldqQUl4b2RhQ29HNHhFYUdFVXV2d0xrK1VWdWtUaDV3THZZRy9COWRHWjVm?=
 =?utf-8?B?ZkRnQ2UzZFNkVitzUnhuRXJpZFJCRU9Gb09tVGIraTh6MHUvbFA3a1JaalNS?=
 =?utf-8?B?SVJ0WjdBTk1wc00xZkNXd0Y4YzRBWFZLT2s0OGRYdjVXQzV3MDJ4MFIxVk84?=
 =?utf-8?B?YUJ5Z3RJMytIek01ekt2aDhzZEV3NzgyZStlSDJTengwTjFwZFRhL1JhdSt1?=
 =?utf-8?B?d1oxcnhmbUYyZWRPaFN6K3p0MG9lU2V0bGFweFNxS1kybCs4NkdVcEc5dUFC?=
 =?utf-8?B?c3JNL1dZbGIyc0x6d1VsOGpNNVlkTDlveWY2V1R4Z3FiKzdlcmdneVphWkN1?=
 =?utf-8?B?SVZPVHgrVFk1QlVCaEw0aXVXLzBSS3NYMzRVL0l4WDl4QVJzMWE0L3M5ZE1r?=
 =?utf-8?B?VlZnUVNkM1VPeDlJN3hDbmdZTmF1b2tFMEZLYXNaSjZLaEE2ZDRraU0xeFkx?=
 =?utf-8?B?MWVBd1NFLy9RZVMwZzc2Z2JLZjVXWW44cVUvNGlnWDJ2c0dXR2VhY0hVOFg2?=
 =?utf-8?Q?2nDtEDUxprTA8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(6486002)(66556008)(66946007)(2616005)(186003)(66476007)(31686004)(30864003)(2906002)(54906003)(110136005)(36756003)(6666004)(41300700001)(83380400001)(8676002)(15650500001)(6512007)(53546011)(86362001)(31696002)(38100700002)(26005)(8936002)(7416002)(6506007)(966005)(5660300002)(4326008)(478600001)(316002)(19627235002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmxGN1BGa0Y3REFoMmMwdHRtK0wyUWdqNUVDOWZyQXFWNlNOdEl4V2RvQWM1?=
 =?utf-8?B?R2ZGNTRJS01SdlNLd2hkdjJoU0Y3dVZOR1dVTEk5bEkxYS9ab0tXYmNXaG1u?=
 =?utf-8?B?Z3dVVVZUcWl2azdTZ3pRODI0Nk95dER1V1BVUG1YdzdnTlNMdzU5c0RoWThz?=
 =?utf-8?B?ZFpqWlVpUVNDdjlIeGNyV2VwY25IVUNCUmRhbm1zc2t5eGVTZ25hcmNsR3o2?=
 =?utf-8?B?QnFiQmpEY0ZkTURHUHNUSXA2QWg5Ui9EL205dHZkL3NnU1dVYzUvMndMVS95?=
 =?utf-8?B?WVJRV1FYY1R2U0dvdWU0U1VZWENmTXJvM3N6WGVRUlNNUTR4ZnUyWlFiT1JD?=
 =?utf-8?B?eVU1Wkp6MVR1YnphVk9pZ095enZocDVobzQ4TzNsQ2hBNTBneGFSaTNvdmpZ?=
 =?utf-8?B?TktHWmwweTAvWG8xRE4zNllQRmRScDcyM0pJb0c3L1lUMlRwa0E0QS9PSlVZ?=
 =?utf-8?B?RVIrYlZNbnFZOW5uUEJPQkxMVXY5Y0krZUFxQnFtQmR4RW5pV2lvVVBpdWpD?=
 =?utf-8?B?ZU5WR3B1aVc3NnE3OHpGNVNmMUlZNEdlUGlYUUlJWEJ0cGNmWW9uMkJQTFg5?=
 =?utf-8?B?YWpMa2xsc01YRkxsM1V0bWN4eU5KNXU4dk9MeFpxK2Q0Q05qRllEcHFEU0dZ?=
 =?utf-8?B?MWpzZ0ptYVVURS9JZlpVREFLcEtxUVlTRWhSc3NIVVV1NUVSdWY0cmN4REpi?=
 =?utf-8?B?M3g0Mks3OEh4bnRQZUFYamhmK0xPNmFLa2FBZWowOHlxRlA3dGtxcG5XWDV5?=
 =?utf-8?B?TW1OVHFiVjFJQU52ZnJCalpIRjZOaDd5Qm5xZ2ZNVk94d1B1d1hXT1FWbTVo?=
 =?utf-8?B?dGVqRXVJb3g3TTBNNVZaNUtaTDFmUmNRMDIvalJMOU1GemxibkgxaXl4WjRC?=
 =?utf-8?B?UXNES0RXdE5uN0tHdFRvQjk0K3hVUllOT2lXT1VPNkZjbmRNY2JSZXl3WlJ3?=
 =?utf-8?B?YUlTNXgxdDVZMHRnU0hzc3k5VVBxTjJKaCtyZDRlbFRQNStHa3piM3BjZG51?=
 =?utf-8?B?d1pUNVA1TzdVZGxrV0p6UkYreTZoNXdya2tBS0dZeldqcVJvYjJjdkVKeU1M?=
 =?utf-8?B?R1gwbVZwMHR4UmduOVdtOWxhbUdwdFZ2eGFJSzlGQzFjODRDblJrYnd4ckJM?=
 =?utf-8?B?R3FHK3lEd2tDSlZrVTB4cUZsd2Y5VkNUQ3UzS0t3NDl3YmU4eURLNjJiMUU5?=
 =?utf-8?B?K0tqcmJYV2JrNk5HWmxOTnNKbDZlSzZrUFgwU1pWZ1F2WEVwaWl4UnNaRzYx?=
 =?utf-8?B?R1R5czVuLzVHMitreGR2ejAzTmdPSEZKMWdpalBBQitTNmc4bDlZY0xpUzlF?=
 =?utf-8?B?OEhVeFBjTFFlQloySEVGV3hkcFBrMHp4OG14SXJ6Y3VxZHVKQTdUcVRRK0Fq?=
 =?utf-8?B?RkMvZnN2RW1xQzNacGVyeHN1ZGVQNWZKR1lOWWR4MGRMbkJnOHBVQk9aYm5o?=
 =?utf-8?B?YlNqZzVEMHVCaXYxd0J3STVMc0Z6UExzU0Z2T1MxRllpcGpqVkl4QytnVnlD?=
 =?utf-8?B?eU03cjRPVjlZTUUwYWF1eWFCZ1FLNE4xQUtXU3JNYy9WVHFlWUoxdUdTYlZj?=
 =?utf-8?B?NXpKOHRmZGd1WHJBVE9SREpwZVpMa0syU0QzZDRzclJsVUhzVDdZVi9IRXd4?=
 =?utf-8?B?SEMwdTJTcEhLUlVDRDlmZ2g1TGJSeHlJVjNKa25Qam1nRGZBTEgxSlJGczhM?=
 =?utf-8?B?aCtzd2FzZ2R1R29jOUt6c0Q0YUlTckVUSzg1cXZrcVo5UzJuYisvWWtPeUNK?=
 =?utf-8?B?ZDNsMlEzR2huV0s3eWdZUC94SGcvSnFYakFSTmcvNzBDb081Z2VYT3RYL29s?=
 =?utf-8?B?TnkvdnNNSWRlRVJuMlhZd3lrV0E1WHN3bUloeHg5YTJvM0tzS1JkUDRVczNC?=
 =?utf-8?B?cllaUzcxWU0rVzBBMDVHSTRjNUd1ZmlBQkF6NWNzSWtvN2RBc0daWFIzUGpn?=
 =?utf-8?B?WnBSaU1CYU1oSFBVMFJYN2JUUXBxSE9WWm0yckZmM1hyeEhnWVU0cEp4SzA4?=
 =?utf-8?B?ZTNJeUozQ1F3bGU3UHRGMU9SQTRKSG1SWXU0aU5OdnJxM2ZUOVJIeUw0ODdJ?=
 =?utf-8?B?aWVWTUdOc0I1TmxYN0JQSDBtMGRlVWpWRE5VeFl1V2FYQ2hIbi9ScXJ0ZGE1?=
 =?utf-8?Q?8IGQFS0sC/rGRLbaTWKdnGcBk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823cba45-d571-401a-fb4c-08da716faaa3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 14:36:04.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyLhl1HOiceo181VjX38QIJPZ9zXW//n71B8hxZ/BWg1XzWFa/YmxAl9kfn/utnPFiOItHknEto3CVxY5f9E0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3190
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukasz,
Thanks for sharing your observations.

Could you please also share the output of 'sudo lspci -vvvv' before and 
after suspend-resume cycle with the latest linux-next?
Do we still see the L1SS capabilities getting disappeared post resume?

Thanks,
Vidya Sagar

On 7/29/2022 3:09 PM, Lukasz Majczak wrote:
> External email: Use caution opening links or attachments
> 
> 
> wt., 26 lip 2022 o 09:20 Lukasz Majczak <lma@semihalf.com> napisał(a):
>>
>> wt., 26 lip 2022 o 00:51 Rajat Jain <rajatja@google.com> napisał(a):
>>>
>>> Hello,
>>>
>>> On Sat, Jul 23, 2022 at 10:03 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>
>>>> Agree with Bjorn's observations.
>>>> The fact that the L1SS capability registers themselves disappeared in
>>>> the root port post resume indicates that there seems to be something
>>>> wrong with the BIOS itself.
>>>> Could you please check from that perspective?
>>>
>>> ChromeOS Intel platforms use S0ix (suspend-to-idle) for suspend. This
>>> is a shallower sleep state that preserves more state than, for e.g. S3
>>> (suspend-to-RAM). When we use S0ix, then BIOS does not come in picture
>>> at all. i.e. after the kernel runs its suspend routines, it just puts
>>> the CPU into S0ix state. So I do not think there is a BIOS angle to
>>> this.
>>>
>>>
>>>>
>>>> Thanks,
>>>> Vidya Sagar
>>>>
>>>>
>>>> On 7/22/2022 11:12 PM, Bjorn Helgaas wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Fri, Jul 22, 2022 at 11:41:14AM +0200, Lukasz Majczak wrote:
>>>>>> pt., 22 lip 2022 o 09:31 Kai-Heng Feng <kai.heng.feng@canonical.com> napisał(a):
>>>>>>> On Fri, Jul 15, 2022 at 6:38 PM Ben Chuang <benchuanggli@gmail.com> wrote:
>>>>>>>> On Tue, Jul 5, 2022 at 2:00 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>>>>>>>>>
>>>>>>>>> Previously ASPM L1 Substates control registers (CTL1 and CTL2) weren't
>>>>>>>>> saved and restored during suspend/resume leading to L1 Substates
>>>>>>>>> configuration being lost post-resume.
>>>>>>>>>
>>>>>>>>> Save the L1 Substates control registers so that the configuration is
>>>>>>>>> retained post-resume.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>>>>> Tested-by: Abhishek Sahu <abhsahu@nvidia.com>
>>>>>>>>
>>>>>>>> Hi Vidya,
>>>>>>>>
>>>>>>>> I tested this patch on kernel v5.19-rc6.
>>>>>>>> The test device is GL9755 card reader controller on Intel i5-10210U RVP.
>>>>>>>> This patch can restore L1SS after suspend/resume.
>>>>>>>>
>>>>>>>> The test results are as follows:
>>>>>>>>
>>>>>>>> After Boot:
>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>           Capabilities: [110 v1] L1 PM Substates
>>>>>>>>                   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>                             PortCommonModeRestoreTime=255us
>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>                   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>                              T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>                   L1SubCtl2: T_PwrOn=3100us
>>>>>>>>
>>>>>>>>
>>>>>>>> After suspend/resume without this patch.
>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>           Capabilities: [110 v1] L1 PM Substates
>>>>>>>>                   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>                             PortCommonModeRestoreTime=255us
>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>                   L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>>>>                              T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>>>>                   L1SubCtl2: T_PwrOn=10us
>>>>>>>>
>>>>>>>>
>>>>>>>> After suspend/resume with this patch.
>>>>>>>> #lspci -d 17a0:9755 -vvv | grep -A5 "L1 PM Substates"
>>>>>>>>           Capabilities: [110 v1] L1 PM Substates
>>>>>>>>                   L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
>>>>>>>> ASPM_L1.1+ L1_PM_Substates+
>>>>>>>>                             PortCommonModeRestoreTime=255us
>>>>>>>> PortTPowerOnTime=3100us
>>>>>>>>                   L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>>>>                              T_CommonMode=0us LTR1.2_Threshold=3145728ns
>>>>>>>>                   L1SubCtl2: T_PwrOn=3100us
>>>>>>>>
>>>>>>>>
>>>>>>>> Tested-by: Ben Chuang <benchuanggli@gmail.com>
>>>>>>>
>>>>>>> Forgot to add mine:
>>>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Ben Chuang
>>>>>>>>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> Hi,
>>>>>>>>> Kenneth R. Crudup <kenny@panix.com>, Could you please verify this patch
>>>>>>>>> on your laptop (Dell XPS 13) one last time?
>>>>>>>>> IMHO, the regression observed on your laptop with an old version of the patch
>>>>>>>>> could be due to a buggy old version BIOS in the laptop.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Vidya Sagar
>>>>>>>>>
>>>>>>>>>    drivers/pci/pci.c       |  7 +++++++
>>>>>>>>>    drivers/pci/pci.h       |  4 ++++
>>>>>>>>>    drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>    3 files changed, 55 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>>>> index cfaf40a540a8..aca05880aaa3 100644
>>>>>>>>> --- a/drivers/pci/pci.c
>>>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>>>> @@ -1667,6 +1667,7 @@ int pci_save_state(struct pci_dev *dev)
>>>>>>>>>                   return i;
>>>>>>>>>
>>>>>>>>>           pci_save_ltr_state(dev);
>>>>>>>>> +       pci_save_aspm_l1ss_state(dev);
>>>>>>>>>           pci_save_dpc_state(dev);
>>>>>>>>>           pci_save_aer_state(dev);
>>>>>>>>>           pci_save_ptm_state(dev);
>>>>>>>>> @@ -1773,6 +1774,7 @@ void pci_restore_state(struct pci_dev *dev)
>>>>>>>>>            * LTR itself (in the PCIe capability).
>>>>>>>>>            */
>>>>>>>>>           pci_restore_ltr_state(dev);
>>>>>>>>> +       pci_restore_aspm_l1ss_state(dev);
>>>>>>>>>
>>>>>>>>>           pci_restore_pcie_state(dev);
>>>>>>>>>           pci_restore_pasid_state(dev);
>>>>>>>>> @@ -3489,6 +3491,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
>>>>>>>>>           if (error)
>>>>>>>>>                   pci_err(dev, "unable to allocate suspend buffer for LTR\n");
>>>>>>>>>
>>>>>>>>> +       error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
>>>>>>>>> +                                           2 * sizeof(u32));
>>>>>>>>> +       if (error)
>>>>>>>>> +               pci_err(dev, "unable to allocate suspend buffer for ASPM-L1SS\n");
>>>>>>>>> +
>>>>>>>>>           pci_allocate_vc_save_buffers(dev);
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>> index e10cdec6c56e..92d8c92662a4 100644
>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>> @@ -562,11 +562,15 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>>>>>>>>>    void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>>>>>>>>>    void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>>>>>>>>>    void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>>>>>>>>    #else
>>>>>>>>>    static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>>>>>>>>    static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>>>>>>>>    static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>>>>>>>>    static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>>>>>>>> +static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>> +static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>>>>>>    #endif
>>>>>>>>>
>>>>>>>>>    #ifdef CONFIG_PCIE_ECRC
>>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>>>>>> index a96b7424c9bc..2c29fdd20059 100644
>>>>>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>>>>>> @@ -726,6 +726,50 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>>>>>>>>>                                   PCI_L1SS_CTL1_L1SS_MASK, val);
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>> +void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>> +{
>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>> +       u32 *cap;
>>>>>>>>> +
>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>> +               return;
>>>>>>>>> +
>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>> +               return;
>>>>>>>>> +
>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>> +       if (!save_state)
>>>>>>>>> +               return;
>>>>>>>>> +
>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
>>>>>>>>> +       pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>>>>>>>>> +{
>>>>>>>>> +       int aspm_l1ss;
>>>>>>>>> +       struct pci_cap_saved_state *save_state;
>>>>>>>>> +       u32 *cap;
>>>>>>>>> +
>>>>>>>>> +       if (!pci_is_pcie(dev))
>>>>>>>>> +               return;
>>>>>>>>> +
>>>>>>>>> +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>> +       if (!aspm_l1ss)
>>>>>>>>> +               return;
>>>>>>>>> +
>>>>>>>>> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>>>>>>>>> +       if (!save_state)
>>>>>>>>> +               return;
>>>>>>>>> +
>>>>>>>>> +       cap = (u32 *)&save_state->cap.data[0];
>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
>>>>>>>>> +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>    static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>>>>>>>>>    {
>>>>>>>>>           pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
>>>>>>>>> --
>>>>>>>>> 2.17.1
>>>>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> With this patch (and also mentioned
>>>>>> https://lore.kernel.org/all/20220509073639.2048236-1-kai.heng.feng@canonical.com/)
>>>>>> applied on 5.10 (chromeos-5.10) I am observing problems after
>>>>>> suspend/resume with my WiFi card - it looks like whole communication
>>>>>> via PCI fails. Attaching logs (dmesg, lspci -vvv before suspend/resume
>>>>>> and after) https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3
>>>>>>
>>>>>> I played a little bit with this code and it looks like the
>>>>>> pci_write_config_dword() to the PCI_L1SS_CTL1 breaks it (don't know
>>>>>> why, not a PCI expert).
>>>>>
>>>>> Thanks a lot for testing this!  I'm not quite sure what to make of the
>>>>> results since v5.10 is fairly old (Dec 2020) and I don't know what
>>>>> other changes are in chromeos-5.10.
>>>
>>> Lukasz: I assume you are running this on Atlas and are seeing this bug
>>> when uprev'ving it to 5.10 kernel. Can you please try it on a newer
>>> Intel platform that have the latest upstream kernel running already
>>> and see if this can be reproduced there too?
>>> Note that the wifi PCI device is different on newer Intel platforms,
>>> but platform design is similar enough that I suspect we should see
>>> similar bug on those too. The other option is to try the latest
>>> ustream kernel on Atlas. Perhaps if we just care about wifi (and
>>> ignore bringing up the graphics stack and GUI), it may come up
>>> sufficiently enough to try this patch?
>>>
>>> Thanks,
>>>
>>> Rajat
>>>
>>>
>>>>>
>>>>> Random observations, no analysis below.  This from your dmesg
>>>>> certainly looks like PCI reads failing and returning ~0:
>>>>>
>>>>>     Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
>>>>>     iwlwifi 0000:01:00.0: 00000000: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
>>>>>     iwlwifi 0000:01:00.0: Device gone - attempting removal
>>>>>     Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
>>>>>
>>>>> And then we re-enumerate 01:00.0 and it looks like it may have been
>>>>> reset (BAR is 0):
>>>>>
>>>>>     pci 0000:01:00.0: [8086:095a] type 00 class 0x028000
>>>>>     pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00001fff 64bit]
>>>>>
>>>>> lspci diffs from before/after suspend:
>>>>>
>>>>>      00:14.0 PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port B #1 (rev fb) (prog-if 00 [Normal decode])
>>>>>        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>>>>>     -               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPwr+ TransPend-
>>>>>     +               DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>>>>>     -               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>     +               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>>>>     -               LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>>>>>     +               LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
>>>>>     -       Capabilities: [150 v0] Null
>>>>>     -       Capabilities: [200 v1] L1 PM Substates
>>>>>     -               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>     -                         PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
>>>>>     -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>     -                          T_CommonMode=40us LTR1.2_Threshold=98304ns
>>>>>     -               L1SubCtl2: T_PwrOn=60us
>>>>>
>>>>> The DevSta differences might be BIOS bugs, probably not relevant.
>>>>> Interesting that ASPM is disabled, maybe didn't get enabled after
>>>>> re-enumerating 01:00.0?  Strange that the L1 PM Substates capability
>>>>> disappeared.
>>>>>
>>>>>      01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
>>>>>                     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
>>>>>     -                       ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>>>>>     +                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>>>>             Capabilities: [154 v1] L1 PM Substates
>>>>>                     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>>>>>                               PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
>>>>>     -               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>>>>     -                          T_CommonMode=0us LTR1.2_Threshold=98304ns
>>>>>     +               L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>>>>     +                          T_CommonMode=0us LTR1.2_Threshold=0ns
>>>>>
>>>>> Dmesg claimed we reconfigured common clock config.  Maybe ASPM didn't
>>>>> get reinitialized after re-enumeration?  Looks like we didn't restore
>>>>> L1SubCtl1.
>>>>>
>>>>> Bjorn
>>>>>
>>
>> Hi,
>>
>> Thank you all for the response and input! As Rajat mentioned I'm using
>> chromebook - but not Atlas (Amberlake) - in this case it is Babymega
>> (Apollolake)  - I will try to load most recent kernel and give it a
>> try once again.
>>
>> Best regards,
>> Lukasz
> 
> Hi,
> 
>   I have applied this patch on top of v5.19-rc7 (chromeos) and I'm
> still getting same results:
> https://gist.github.com/semihalf-majczak-lukasz/4b716704c21a3758d6711b2030ea34b9
> 
> Best regards,
> Lukasz
> 
