Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F51E6BF6D2
	for <lists+linux-pci@lfdr.de>; Sat, 18 Mar 2023 01:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCRAPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 20:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCRAPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 20:15:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B91C926B
        for <linux-pci@vger.kernel.org>; Fri, 17 Mar 2023 17:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx3M9jU88H3tT9MN7MgOU0dNcUWOyIe51lCorrVvLwayrRKyohInQWBqctZKLdMixM69fnmpdbHNYKMdbaj3HWaH6oOAqIoXkdmSaltjcnlYtVxFwDuRdLe2iE638Jpi6/ykj1gtZaCEnFDbtxbCGzTuHif0pHv+eYk9ZlFRtpf4bKGeixk7rvl9fuHDp9G59iGzjWO+7lYiYzsjvApe4fwSHOQzDj70/knv6AnWunbqHx6Pl4O9Ie2qh89mz6l/GOB/k3y6OaWz0YeRMsA89/T4GgVflQrVB9HOX4/fiYUn2NXcpsLdlhlMVzMWS4/B0lg11OlYJCiIXq89/pDOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBBK+RixVNchn/MsZ02G+3T+rMUUVCn20p7M7d2r0r8=;
 b=igN0zM0p9smI5iFX1TfFwQMd5s17RywH1o/AIzsAV1EcZdNOS0YOYM7gcYXrlQVpA3djbuG8sTJ76zBvWOIBZLEqWUQ3m/uyyPNezrLFWYth4qr3IHpBB+jL3vAU/0Meh2zhZ9ny4K0FPlaqn7J6Ds+HkXl5UsU6Dsf+opKMKY+OemuvV2nuI2NLZ/LMw9ZzdeJl7rHH9E2ELZklMtyY3i+np7YZ5WoybLEoWC/jST+p40P+I2DcBkyv5h4dMqOWD6Jzf5epIy0P2zgTONDQtHbqcOgk2MKnWT4j9DM25kPCEnf8yJ9QqGzkGwiAcpELy0l3ZSWf+k72Ojz7XRRiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBBK+RixVNchn/MsZ02G+3T+rMUUVCn20p7M7d2r0r8=;
 b=s2Imtyy2z/O5BWS7hCVUfu9YpNABspINsYMAtvLA7eKNJS1h8PpYyEPbf1/3Jhv+rXwwi4JvlwbdksKY3C4kVEImiXmUWZRlEHxhsgNDn+CtTHbyFWT8QCFJuN7E6zhkIW9pnZuZ+Cpxhnv9yLyoZzoj211BYVG1UEq1vNV9WYtBqa5Waf0ynHEwxigCIjmccDmeCmJQSa1KXhGn6r+MQNqotuESrIATiVlTAPtcEqH9hZyhs8xSFutG3Cig6Wj6jrCS+1eD1lTlvxTMAiap8mAOGZthk6yJUz/D9owg9Tr08Sw7EVRL39tBBzrAHfBBgPFRk1QIDJw3WuCXweeaYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sat, 18 Mar
 2023 00:15:40 +0000
Received: from BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d]) by BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d%5]) with mapi id 15.20.6178.035; Sat, 18 Mar 2023
 00:15:40 +0000
Message-ID: <350b1488-761e-1aaf-bf36-ca5341ea3ec3@nvidia.com>
Date:   Fri, 17 Mar 2023 17:15:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
From:   Tushar Dave <tdave@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <c17f7476-8ed0-212e-9480-78732635ee3f@nvidia.com>
 <20230314161127.GA1648664@bhelgaas>
 <ZBCuPM0WcWaLwWXJ@kbusch-mbp.dhcp.thefacebook.com>
 <e598b84f-2f90-b29a-6209-17309763514f@nvidia.com>
In-Reply-To: <e598b84f-2f90-b29a-6209-17309763514f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To BYAPR12MB3189.namprd12.prod.outlook.com
 (2603:10b6:a03:134::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_|BN9PR12MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: ef705650-17b8-4d9c-3668-08db2745e815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBOLLsDGL4IWMm7XjsAsk1YUZVgFC0l1OrFf74+/H3Y49JfCZHFoofMrR+lJapgZRStA1PCE5CovaOBP/W4RJQVuUutY6pJo9EWci7HfX1we95VxArfvYoLvESKthrni2xRtjxKHvi4qJgEzaCotE2zM0YXQ7dzCuB0kDV3fYIMrYZ315PebobXFxfYwigHxDdQiPm3XrUGOrsaqYb8A11ziEP7udQ6dQSvkOesDqubCdIA2T5PSIh3tFIZTzN5edWqONJ/PJqAtLJdMhK9Vzu1lYcMLXep29cXLmtuarU/z1m6dgeGt3/QqSDuo5Sp9bxArHSZpfGml519lY8qh/CJV7iJyyOTUzTl2vN70HUSJxGp512LNM3J1+HzxfQ5leARJsbE3pr0mRfdB8yFd+yLt3QNog/KD5hHrjgZ6D05trpnhO6TchO0v7KzlZm2llmnl3zl4Q/NXS10UXHMNZ0cldmL5upkfb4QSpgAvdAZ8y+ArtAk9v8G/LuBVWcti647uuNXDEcnDAMFzLJxDJVjQEFAW+ENyZJW8Qvtfvg9LfBssJUOiSZuU6kPvJMTF7XEp7gcycI94tuHoNjDX7z7LPbvd8sxEqtOJ6ydqeY5H5XIMBuOCtE9mHg+wCM1/IZpFrMijDSZuS54HNUsI1YHqy/HW+30yzaqny2EUf2IFxVK9C6K/bbUPYS6ReExpbAq3BgHrPO0wLeJ/xLoDm9HnMIyDmhKNRWU25Qbacqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199018)(66899018)(31686004)(54906003)(110136005)(41300700001)(478600001)(66556008)(8936002)(8676002)(66476007)(86362001)(31696002)(66946007)(36756003)(38100700002)(53546011)(26005)(186003)(6486002)(5660300002)(4326008)(6512007)(30864003)(6506007)(316002)(2906002)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG0vMkhTd1BNeTgyeUFkT0tXSlJRbFNHalNDQWViWGpmQUt2RXMvVXZjWElM?=
 =?utf-8?B?MGp3SWtDZVJaZzBkamVwY2tocDdmZDZ6NUsrMnEwQWR2U0RJZ3lwMEF4V1Vp?=
 =?utf-8?B?UDNYOTMrSlh6QlJ0NXEzclVHYVFBWktyMFdQaDQyU0JvUVRXcDNLalR6VlJ3?=
 =?utf-8?B?bTNtdVRtd1FLRzNJcmJ4MkhOaWlRdHNlYzNlUW1uTEhOckc5L2h3SEVCbGJJ?=
 =?utf-8?B?YzBXN1FJdkJzRVppUFZvajhtKzVyNFpQT1lFNWRRQ2s2b3RmNnBSUmFsaWpu?=
 =?utf-8?B?RXZkWWNRTVRrbFJZcTZUUjNnaE9xb2xUWW01NlVFM3pGQ3FMZm5BK09sQnhi?=
 =?utf-8?B?ZjQybmpuQWFsOGtQTitaOU5BSVBYWmVEakNKNytZVVYvdVVKbGZGM21XWEZS?=
 =?utf-8?B?K2krTU1vZHJRVzA1aHdUQWNKOVB0Z0xQZ3Vyc1Z2U0ZHbzJTeXo2MWNwTVBP?=
 =?utf-8?B?K3V4cFkzTUhoM1hvck5qSndRaS85cWtWdmE1MEVuY0VielEzQmxueWlTMnlZ?=
 =?utf-8?B?VU5PS1FJaWRia1krNVNkTWt6MDFpaUJLRVZ0bzM0MlZkQWpHaS90YSszWjlp?=
 =?utf-8?B?RXhqd2JLOStXQ1BQdTIzNk9YK29jMGJQNlRvd08ydHdQMEFGd1BpUnFPOXZT?=
 =?utf-8?B?QUJFSUhEOWJkNS9UbkNFNHowQkYxZm9HZ0JnZVZwRFJ1ZGpQS0dHSFNOUnow?=
 =?utf-8?B?aG4yWTU2d0IxNW5PMERaOFVKOHdLL3pobE5FMkRLenFoRUU4aU45OUw4VU1U?=
 =?utf-8?B?dWs1MTVKZDhNT3Z5MlBwaVB4NDdrSGxVYW9IZVFjMUh5eGpvTzJvTVBLZnhH?=
 =?utf-8?B?TEw4dWVwb3ppVk5kZ2FLTTA1MGxIT0dMQ0ZHdUNXZVkvR05vemU5Y1ZJYzIx?=
 =?utf-8?B?VEd6M1FyWE5VWFhRYW9xVzdYVWJUdVErMXVMRFZ3ZXMzMmZTRmhSbEc3cUQz?=
 =?utf-8?B?RzlkakN4NktzcEV0Tnd2b1IwZ2ZDOGRUTUkrc2d4TFEyd3lGUWJsVEI3dys0?=
 =?utf-8?B?TUxILzBORVFndVorWGhqNFlpTTBoU3R4M3FzazVKbUlKR3JqSnpqODFMNXBO?=
 =?utf-8?B?R2J4dGp3eS8vNU5RRFhaYVdZczVYTjhiZUVYcGFMYVhqSHVoM2ZCdjJKQUM2?=
 =?utf-8?B?NUhQOXJBVGdmRC8wTzFFeHd5cDc5Zmxma1pmMkxMdXlOYkM4Vkx3YXVsalJq?=
 =?utf-8?B?TjF2clI4eVRpcmFRWE5HckVuZ3RZZS8xRkd2TEpXS0QyWDVGSktWU3R4M3pv?=
 =?utf-8?B?R3lrdmFwRkJYbU1iZEVjeW43bWw0blZSVE0yL2tKWTFjZ29BMnl6ZzlVakVi?=
 =?utf-8?B?NUlDUjc2R1F5eFkwSUw3UFBSQjA4L3dLQ3VCUU91TmZvbHI2ektWMGFWWUdJ?=
 =?utf-8?B?OFcxZ01TRUdYd2hEZ09Ia2FLbWI5T2dhbnJzKzQ1SFpWZnZBTTVNczdHRzdk?=
 =?utf-8?B?TjdDN1RLWkwwVjA4cVdJQ3ovanpzVW16dDdLU3NIeVVtbXpZdnBiR1Q0WURn?=
 =?utf-8?B?STdWcEZ3OEVXUVo2RUFEcXFHeWpaUkh5Tkw4WitHS1BmMU1qSFUwMkNrTTFD?=
 =?utf-8?B?TFkyb3lETURvQ0F4a014OGtlK0Z4MFRyZi9KYWtTTng5OFRXZkpEOTJ5MHpi?=
 =?utf-8?B?R0g1KzZtRHluSGJBZnRBaDdQOUUyWVlOWG9rckJKR2JLdVFVSWVGQ0hhVFBr?=
 =?utf-8?B?V3FsbTNnbTFKRWJIY0NLY1l5T0RaVWdDZFdtUEM5QTZhVW5DYUVQVjU3a1ZF?=
 =?utf-8?B?Tkt6YW14dFAxNHpyYTNrMWJKdFdVVWRub0NCek11Z2hXVThpVDBldTRkQ295?=
 =?utf-8?B?SDBaV0xJTlgra3dLWnlpMlVVWFphK0oxVlNQTjRUbjRydTRLL1k2RjhlR1py?=
 =?utf-8?B?dUNCZmtKSENVL2NRdGFBZmlPL3c2ZG53bGZTdGRqUnZLMzdvRzZHSWJ5RTI4?=
 =?utf-8?B?NzdaaU9JUVlxT1lHRU1ocXZGTUhxSFRwdEJZREtmSkI1akpvMXlQOGpDTDJJ?=
 =?utf-8?B?NENyamY3d2d4RlFqK0VqckFxbDhlY2dsQTM2ZXRmWWwyZmFCT3VFdVZ2VGNy?=
 =?utf-8?B?NGFMTmMrQXc5RFY0ZE0vYkNOUWduOFdxV0hyUDk4RjM0L2RyeC92ZGNIV1Ry?=
 =?utf-8?Q?R/M9OVs9ylOJ9Uq1SM3dOGdtf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef705650-17b8-4d9c-3668-08db2745e815
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 00:15:40.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G43e5cY6z2NBuZVozSY9zzraLEVKmh5o0qoKgdcxCJ1bIDm5lPG/cYSuLEXAjAp/kRiBUhoxPAsgghjQD9OykA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/15/23 13:01, Tushar Dave wrote:
> 
> 
> On 3/14/23 10:26, Keith Busch wrote:
>> On Tue, Mar 14, 2023 at 11:11:27AM -0500, Bjorn Helgaas wrote:
>>> On Mon, Mar 13, 2023 at 05:57:43PM -0700, Tushar Dave wrote:
>>>> On 3/11/23 00:22, Lukas Wunner wrote:
>>>>> On Fri, Mar 10, 2023 at 05:45:48PM -0800, Tushar Dave wrote:
>>>>>> On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
>>>>>>> In the log below, pciehp obviously is enabled; should I infer that in
>>>>>>> the log above, it is not?
>>>>>>
>>>>>> pciehp is enabled all the time. In the log above and below.
>>>>>> I do not have answer yet why pciehp shows-up only in some tests (due to DPC
>>>>>> link down/up) and not in others like you noticed in both the logs.
>>>>>
>>>>> Maybe some of the switch Downstream Ports are hotplug-capable and
>>>>> some are not?  (Check the Slot Implemented bit in the PCI Express
>>>>> Capabilities Register as well as the Hot-Plug Capable bit in the
>>>>> Slot Capabilities Register.)
>>>>> ...
>>>
>>>>>>> Generally we've avoided handling a device reset as a
>>>>>>> remove/add event because upper layers can't deal well with
>>>>>>> that.  But in the log below it looks like pciehp *did* treat
>>>>>>> the DPC containment as a remove/add, which of course involves
>>>>>>> configuring the "new" device and its MPS settings.
>>>>>>
>>>>>> yes and that puzzled me why? especially when"Link Down/Up
>>>>>> ignored (recovered by DPC)". Do we still have race somewhere, I
>>>>>> am not sure.
>>>>>
>>>>> You're seeing the expected behavior.  pciehp ignores DLLSC events
>>>>> caused by DPC, but then double-checks that DPC recovery succeeded.
>>>>> If it didn't, it would be a bug not to bring down the slot.  So
>>>>> pciehp does exactly that.  See this code snippet in
>>>>> pciehp_ignore_dpc_link_change():
>>>>>
>>>>>     /*
>>>>>      * If the link is unexpectedly down after successful recovery,
>>>>>      * the corresponding link change may have been ignored above.
>>>>>      * Synthesize it to ensure that it is acted on.
>>>>>      */
>>>>>     down_read_nested(&ctrl->reset_lock, ctrl->depth);
>>>>>     if (!pciehp_check_link_active(ctrl))
>>>>>         pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
>>>>>     up_read(&ctrl->reset_lock);
>>>>>
>>>>> So on hotplug-capable ports, pciehp is able to mop up the mess
>>>>> created by fiddling with the MPS settings behind the kernel's
>>>>> back.
>>>>
>>>> That's the thing, even on hotplug-capable slot I do not see pciehp
>>>> _all_ the time. Sometime pciehp get involve and takes care of things
>>>> (like I mentioned in the previous thread) and other times no pciehp
>>>> engagement at all!
>>>
>>> Possibly a timing issue, so I'll be interested to see if 53b54ad074de
>>> ("PCI/DPC: Await readiness of secondary bus after reset") makes any
>>> difference.  Lukas didn't mention that, so maybe it's a red herring,
>>> but I'm still curious since it explicitly mentions the DPC reset case
>>> that you're exercising here.
> 
> Commit 53b54ad074de ("PCI/DPC: Await readiness of secondary bus after reset") 
> didn't help.
> 
> [ 6265.268757] pcieport 0000:a5:01.0: EDR: EDR event received
> [ 6265.276034] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
> [ 6265.283780] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 
> source:0x0000
> [ 6265.292972] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
> [ 6265.301284] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected 
> (Fatal), type=Transaction Layer, (Receiver ID)
> [ 6265.313569] pcieport 0000:a9:10.0:   device [1000:c030] error 
> status/mask=00040000/00180000
> [ 6265.323208] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
> [ 6265.331084] pcieport 0000:a9:10.0: AER:   TLP Header: 6000007a ab0000ff 
> 00000001 629d4318
> [ 6265.340536] pcieport 0000:a9:10.0: AER: broadcast error_detected message
> [ 6265.348320] nvme nvme1: frozen state error detected, reset controller
> [ 6265.419633] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after 
> activation
> [ 6265.627639] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
> [ 6265.635289] nvme nvme1: restart after slot reset
> [ 6265.641016] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 
> 0x100, writing 0x1ff)
> [ 6265.651248] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 
> 0x0, writing 0xe0600000)
> [ 6265.661739] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 
> 0x4, writing 0xe0710004)
> [ 6265.672210] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, 
> writing 0x8)
> [ 6265.681897] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 
> 0x100000, writing 0x100546)
> [ 6265.692616] pcieport 0000:a9:10.0: AER: broadcast resume message
> [ 6265.716299] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading 
> 0xa824144d)
> [ 6265.725614] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading 
> 0x100546)
> [ 6265.734657] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading 
> 0x1080200)
> [ 6265.743824] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
> [ 6265.752348] nvme 0000:ab:00.0: saving config space at offset 0x10 (reading 
> 0xe0710004)
> [ 6265.761647] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
> [ 6265.770247] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
> [ 6265.778857] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
> [ 6265.787450] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
> [ 6265.796034] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
> [ 6265.804620] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
> [ 6265.813201] nvme 0000:ab:00.0: saving config space at offset 0x2c (reading 
> 0xa80a144d)
> [ 6265.822473] nvme 0000:ab:00.0: saving config space at offset 0x30 (reading 
> 0xe0600000)
> [ 6265.831816] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
> [ 6265.840482] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
> [ 6265.849037] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 
> 0x1ff)
> [ 6275.037534] block nvme1n1: no usable path - requeuing I/O
> [ 6326.920009] nvme nvme1: I/O 22 QID 0 timeout, disable controller
> [ 6326.988701] nvme nvme1: Identify Controller failed (-4)
> [ 6326.995253] nvme nvme1: Disabling device after reset failure: -5
> [ 6327.032308] pcieport 0000:a9:10.0: AER: device recovery successful
> [ 6327.039781] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
> [ 6327.047687] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
> [ 6327.083131] pcieport 0000:a5:01.0: EDR: EDR event received
> [ 6327.090173] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
> [ 6327.097816] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 
> source:0x0000
> [ 6327.107009] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
> [ 6327.115330] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected 
> (Fatal), type=Transaction Layer, (Receiver ID)
> [ 6327.127640] pcieport 0000:a9:10.0:   device [1000:c030] error 
> status/mask=00040000/00180000
> [ 6327.137319] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
> [ 6327.145236] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 
> 00000001 5ad65000
> [ 6327.154728] pcieport 0000:a9:10.0: AER: broadcast error_detected message
> [ 6327.162624] nvme nvme1: frozen state error detected, reset controller
> [ 6327.183979] pcieport 0000:a9:10.0: waiting 100 ms for downstream link, after 
> activation
> [ 6327.387969] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
> [ 6327.395596] nvme nvme1: restart after slot reset
> [ 6327.401313] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 
> 0x100, writing 0x1ff)
> [ 6327.411517] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 
> 0x0, writing 0xe0600000)
> [ 6327.422045] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 
> 0x4, writing 0xe0710004)
> [ 6327.432523] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, 
> writing 0x8)
> [ 6327.442212] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 
> 0x100000, writing 0x100546)
> [ 6327.452933] pcieport 0000:a9:10.0: AER: broadcast resume message
> [ 6327.460184] pcieport 0000:a9:10.0: AER: device recovery successful
> [ 6327.467533] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
> [ 6327.475367] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
> 
>>
>> Catching the PDC event may be timing related. pciehp ignores the link events
>> during a DPC event, but it always reacts to PDC since it's indistinguishable
>> from a DPC occuring in response to a surprise removal, and these slots probably
>> don't have out-of-band presence detection.
> 
> yeah, In-Band PD Disable bit in Slot Control register of PCIe Downstream Switch 
> port is set to '0' , no idea about out-of-band presence detection!

I debug further and noticed that pciehp_isr() _not_ getting triggered at all
(in spite of DPC link down/up activity).
Would that rule out that it has less to do with timing but the hotplug interrupt?
In my case, pciehp_isr() doesn't fire even though Downstream Switch port has
all required settings and condition met that ideally should fire Hot-plug
interrupt for PDC(and DLLSC) events!


e.g.
Before the test:

SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
         Slot #272, PowerLimit 25.000W; Interlock- NoCompl-
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
         Changed: MRL- PresDet- LinkState-

And after the MPS test with no engagement of pciehp :
(please note  Changed: MRL- PresDet+ LinkState+ )


SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
         Slot #272, PowerLimit 25.000W; Interlock- NoCompl-
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
         Changed: MRL- PresDet+ LinkState+


-Tushar
