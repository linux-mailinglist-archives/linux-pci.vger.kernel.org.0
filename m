Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC526B3326
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 01:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCJA5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 19:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCJA5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 19:57:44 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3678FA0A8
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 16:57:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mASZ0YMCwctNOcXWboC2HuKzQhCJ1/OVWYzHQ6rkC34eWaGU8KysP81ebRTv/bPrT7tW+aTo+Bm27tR82UY0cbkIhAnivtorZ+/q/Ia56p9Iuow3K6+8ZrAVosBcSQHYwta2hGGbWZmx20fW9yZs25xdoHGXcJHHsmsnxuYJKMU5QSPbpTrdfizI0OHW8kyLuJnfyD3EYyO//qdLDLARtdl+4Q4Cyq5Im9eEUNAX2w09ovOkuVLn0HYKLfUt9fchmtQP3MdA8heYHKY/Z3SJyYk/EVAcoc74uOam4X3ZmheSmmcIG++mTaGLQ/2/hqJPljgyONw85hTHWBpBpmyKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVVnglayk12pgkeBxNQQXpUJAeUwUBiusbQ4nrVjkLk=;
 b=eUETj2MmARq3SQAV8kutpkcQcpaYw2F2ltcnRyVobtQYMHPKD3usLQwKlrJ4Ovi2SnAbUWOUvLl7LxE4GMULTxswrB/LT5TvJlxCW9aoRn/pXgbvNiP725JOz/B9IZ7XQnUAWhqMMxqnWPP53WBGSFGGVCPtGSsJcorqrEtl8QNVg1tSDhggTLhakTkDsVgnSfWGTRKWEdyrI0FY1sAHYJB/P2y6gBc+5NfRnsh60ddDTNiCPWvrXu5PILGEk7K+SFDg8bzSH7KxBoco9WDrvOqYXRp4sLaDu6rL9CuBhkF8WsIzvrO9dxthukooaO5298SdyXhmNdx0C6pGxKdkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVVnglayk12pgkeBxNQQXpUJAeUwUBiusbQ4nrVjkLk=;
 b=ZJZeq8oiaIjA3aLCzcL6ZPC7p85Wp43f0mnlFqf9gVQejA2iySjZscYeSgywN8SnteAb3AOx615CyiuUnz7Xdw+T+joWrOnD1EX/IDtHcJEDNKUF9t31xR9aHnr/qLGRQKaXWUNBEqcaKSFoMtAoXryFehz36+uURA93NV5JVA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Fri, 10 Mar 2023 00:57:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6156.029; Fri, 10 Mar 2023
 00:57:40 +0000
Message-ID: <0e1bd2cd-ea0e-7f2f-3d4a-62e9dea892b8@amd.com>
Date:   Thu, 9 Mar 2023 18:57:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Basavaraj Natikar <bnatikar@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
References: <20230309223051.GA1178661@bhelgaas>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230309223051.GA1178661@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:805:ca::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8ab225-5f22-4982-474e-08db21027233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOwh/wsEKiktRB0J1cV2OS/YSLUf5rZAPwuUpx0FupU3ZpGh/3p1NlRtTnG3Rv4L9mKg7QBjcTP7/mqyKC/En8vtc8s3nlh4p9fYBRyDE3bFZtqSJ+T9sAE5Hc+Rm7dSe3bIzVwIkbHklIoBTbzufMYwFmOWFwTAr2JVyGkX1kUmxANdsRfPeCgscrHRFF3JdtsHVaDmu5aHgb2eosmjG0UdmSMA0wBcp8zB3PJqw2fo57lBRo9/pXQ1I3sOVKuSBhh4cAA2zJEsvE4tsOdx8WcTBlzatLwb1i9T5XRktx7kuGs2/MjVOBhz12eUYiSDaAV2q4IQwg/2dSFl81Cvy6Kf2OA9zs7Y3h+tQ3PBIPbfJ3LT2WPCUssTydSxXjaman6sur5BbBBPOGkwTlc8Wor7/5Qx9cp414cqwZkBRDhoKpF+VU4r3JcV/bm5H0S2iaBLG/G564uIM/J2xEPRxkiAicoiLGARmiEoWy72Yeygz9ynjjeL7/ahOO2a3ZFX2WNwlNCeVohg5fGODeyw0W0mw8g1F6htusFuiPXDVeNaD6oZXYVwuGKiA/tTjA/MFCmoPI9eqOdLvwVwL4WvDKJFaa0dY+OYUPkSnp3HrT1D2w7WaSrGs2cJAmsH6JH5RXSN8aIFvkqdwvk9m9hhVTjV//U6h3fsMTzCruOc+5Q0RgFDoV9cYX3LYe5r9ojK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199018)(8676002)(41300700001)(66946007)(66556008)(4326008)(66476007)(6916009)(2906002)(316002)(54906003)(8936002)(38100700002)(31686004)(186003)(478600001)(44832011)(36756003)(6486002)(966005)(6506007)(53546011)(83380400001)(2616005)(6512007)(5660300002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlnY05sUkd5b09HdnhXQVRwa1pQN2NFSWMyQVk3eGR4bE9aWStGK01MeE95?=
 =?utf-8?B?N01kWUVSSFlWZlFOakdzSmlnZDR3Y2lYVjZ0UVVCSzhwaVRDR0NiREdYWUxz?=
 =?utf-8?B?QjhJeDYzV3ordjRFNDBXYmRmZGtsTmNWd0pVVWRsSUkwNExSNVN6TnlSR1kw?=
 =?utf-8?B?UUt3QWZiZk1hb2szbUhoYW5RY0NVWksyVWtGc3ZNdGRkcG1HSXh5elFTSHRS?=
 =?utf-8?B?QVoreFFJVHY1bWYxWkE3NDRDWEdSdHdFQi9Ea3VuMTUzRXRZZ3VDcUo2MWlG?=
 =?utf-8?B?SzlyNDdOSGZqcTRtRk1jRmlidnFWMG9JNmdLd2tsdlluejE2c3pvTTliYnlK?=
 =?utf-8?B?ejFVM3pMTnBJMjVrMjQ0MkxiSmovSjIzU0NBajNyUTlwVlhqd3FLRGdEUXpa?=
 =?utf-8?B?RFJ3Z0d2b2E4eWRlcjBlejR5eVV1cnVkN2JWL0VFRENYbGFPWDE3MnhIV0M3?=
 =?utf-8?B?b0Q4S2xjcDNSMWdENVdDbWM1N2pUOFNHWmlmSHg5ZUtMVGw5OWRuc2QyMS9E?=
 =?utf-8?B?WnlYMTRGWWNRR1NDbm8vaFdHM1FBNnFXSStITStxbzFHWUdSdHdSdXh5bU5q?=
 =?utf-8?B?WDBHdU9sd2VETmw4UWZmVTlIVmErdnJiVHFwUnJVN25oNnVuNjZJUDBjNUNw?=
 =?utf-8?B?cGkzdXczeVlob2VXNFBMRmJRb3pZUWdKZC9RL2VJUHkzRE95dlJUeFRBdFlT?=
 =?utf-8?B?TzA0TjBHM2JBc21mZ21VcjMrR3ZzQ2VQcytKQUdIN2pDbEplZE9FUVp0YTRU?=
 =?utf-8?B?SWJNQ21MeDNSTFBYd1NzRHZuQy9MczJ1NE13dkUxVU9vWVJ2a3RnSEkydHNF?=
 =?utf-8?B?SXBlWEVCQ1RlK3BzYVcvbUcxRFNQdkplTGZFSE5INmNSTkh5NzZKZk1WdCtj?=
 =?utf-8?B?bThmM2FzVng2cW91Z2hjOXhMWDBka0FNQ2s1cGFNNzZJd0xsUHVYUElMbk8v?=
 =?utf-8?B?WHU4ZVR6cHRsOGo5RVZKWWE4RVhRNnp0czI0b09CekNYcURsMmczeVhzSHFs?=
 =?utf-8?B?WGwwRnVVK0N0Qy9zMk0rQ2JkZzMrK1FzOVlSUUgwRGwyNVQyY1JwU3pKTUxW?=
 =?utf-8?B?dGhKYzZxMkpoN0xFd3orQlFKWnI5Z2Zlenp1MDlmZkQ0Y0NZVDNjQ3lBSkNh?=
 =?utf-8?B?MWRpRDZNL1NCeFhPQmZ3L1V4NXQ1S2hoWUdLaDdzK3FzL3FZNkNrR3VpUUdY?=
 =?utf-8?B?N3lMb09iSnJQY01KbE5YcXNKeXJVU3I1aXY0dUtRYUk2Lzh2bEJWOUt1eW9B?=
 =?utf-8?B?Y2U5UnZyRmxUV3czWTRsV0Nid3dCeEZSbnR4WldkZmxjbzZVRk8yOHhYT2hM?=
 =?utf-8?B?TEcxT0ZHRVdLY3plMC94b1FvTHhibXdIT3VnTzMxRUFqajZERHlOWS8rN3da?=
 =?utf-8?B?WTVYUjI1ZUEwTm1FOGMzK1lUeVJhSE1uUWZUdkIvZGdPRjh5aXhHRVhDYVB2?=
 =?utf-8?B?Z0pNMUpLclNIV0FRYmx0OElBdmRKVXJSRWZDck9JdlRrRE1OZDM3djhRZWk0?=
 =?utf-8?B?L3o4OUIzL2FLVVpSRlMxMHcwd1prbzB5VGxxaTB1NW1vbGxxVG00bkF5bm10?=
 =?utf-8?B?QVFBRVNqUHg1NmMxVE5jVURURGxsZkl3aWJ3OU9FQXlmYVRENlVJK2I1cEpB?=
 =?utf-8?B?ekgyY3cweUk4bVNNaU81cWxlU2lhSUczV01lSnkzWHB3UXJuODB1dWVTKzVZ?=
 =?utf-8?B?bXduOVRKMytzWnR1czh2UGhEaHZFYmJOUDZZV3JmUmU0YUR6SzkrL0NHdEJR?=
 =?utf-8?B?ckhLM200MFgrTDgyUkVpaDVtODJQTVNoMVRkQ1R1Y2dSZklsd0l1RXhaUEN6?=
 =?utf-8?B?bVBld3lqTjMrOEFsL3JTR0xpc0hFRTZsZGF3eFdUVmVpMExZVzhhdGtwK0hF?=
 =?utf-8?B?WC9PaWdIeENjRHQ3N1ZkV3B5ZGErWmVlTmJ3ZEZPT1hOOUZvMlBTeExnTmc0?=
 =?utf-8?B?WDJwRHZDaUl6SEpFR2RPTnhWbWhkT0ZMbjNKU1B2Q3lhejB4akVtVEZhOWNn?=
 =?utf-8?B?Y01NZEVOT3ZDbk51TURPQXE3b0RkRUdpWHlNWUVMQnpFaTNGa2FWV2tNM1pq?=
 =?utf-8?B?WU5WR0ZuMTNwZVJCOURERXAxSjNsWC9LM0h1SDhlN3I2eGQxcWJHV1FyMW91?=
 =?utf-8?B?N3ZUODVmL2hWQ3Fadk05NTFla080Mm42L25HWWRVallCcGUyc0JxdkNlUHRJ?=
 =?utf-8?Q?rTM3uvET1mvbjzXMVQCJ6Y5iJDcpMOd1OQMuGs09J0yJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8ab225-5f22-4982-474e-08db21027233
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 00:57:39.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDYQM3Ubomp4zEzMp9/FmD1gAE9ThPmxxQ/ia13PToSfQYf3MBqAy8FDk8jsPmxa9SkmuHP5NG+NH6bse1+e7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/9/23 16:30, Bjorn Helgaas wrote:
> On Thu, Mar 09, 2023 at 12:32:41PM -0600, Limonciello, Mario wrote:
>> On 3/9/2023 12:25, Bjorn Helgaas wrote:
>> ...
> 
>>>>> https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a46b5c53e0e4403139
>>>
>>> That nbio_v7.2.c patch and this patch don't look anything alike.  It
>>> looks like the nbio_v7.2.c patch might run once?  Could *this* be done
>>> once at enumeration-time, too?
>>
>> They don't look anything alike because they're attacking the problem from
>> different angles.
> 
> Why do we need different angles?

The GPU driver approach only works if the GPU is enabled.  If the GPU 
could never be disabled then it alone would be sufficient.

> 
>> The NBIO patch fixes the initialization value for the internal registers.
>> This is what the BIOS "should" have done.  When the internal registers are
>> configured properly then the behavior the kernel expects works as well.
>>
>> The NBIO patch will run both at amdgpu startup as well as when resuming from
>> suspend.
> 
> If initializing something as BIOS should have done makes the hardware
> work correctly, isn't once enough?  Why does the NBIO patch need to
> run at resume-time?

During suspend some internal registers are in a power domain that the 
state will be lost.  These are typically restored by the BIOS to the 
values defined in initialization tables before handing control back to 
the OS.


> 
>> This patch we're discussing treats the symptoms of the deficiency and avoids
>> the impact.
>> This patch runs any time the controller is runtime resumed.  So, yes it will
>> run more frequently.  Because this patch is treating the symptoms it needs
>> to be applied every single time the controller exits D3.
> 
> This patch runs at *suspend*-time (DECLARE_PCI_FIXUP_SUSPEND), not
> resume-time.
> 
> The difference is important because with this broken BIOS, MSI-X is
> disabled between the suspend quirk and some distant point in resume.
> With non-broken BIOS, MSI-X remains *enabled* for at least part of
> that period, and I don't want to have to figure out whether that
> difference is important.

I'll let Basavaraj comment on the timing here with the behavior 
workaround and sequence of events.

> 
> We have fragments of a coherent commit log, but it's not quite a
> complete story yet.  I think so far we have:
> 
>    - Issue affects only the 1022:15b8 USB controller (well, I guess it
>      also affects some GPU device?)

Same device.  It's just a way to access the internal registers.

>    - Only a problem when BIOS doesn't initialize controller correctly
>    - Controller claims to preserve internal state on D3hot->D0
>      transition, but it doesn't
>    - D0->D3hot->D0 transitions do preserve external PCI_MSIX_FLAGS
>      state; only internal state is lost
>    - When MSI-X is enabled and controller transitions D0->D3hot->D0,
>      MSI-X appears enabled per PCI_MSIX_FLAGS, but is actually
>      *disabled* because the internal state was lost
>    - MSI-X being disabled leads to xhci_hcd command timeouts because
>      interrupts are missed
>    - Not possible for an enumeration-time quirk to fix the controller
>      initialization problem (why not?)
>    - Writing PCI_MSIX_FLAGS with a *different* value fixes the internal
>      state; writing the same value does nothing
>    - A suspend- or resume-time quirk can work around this, and this is
>      safe on *all* 1022:15b8 devices regardless of whether the BIOS is
>      broken
>    - The same approach can't be used for both 1022:15b8 and the GPU
>      device because ...?
> 
> Bjorn

