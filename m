Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778155F1278
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiI3T35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiI3T3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 15:29:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452695A8;
        Fri, 30 Sep 2022 12:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWZY3uxXLv8ZWYqWIE9Q/LcA6ND/AKLSSN/+9XqxMybpAvnbhV+bqTW2nNCo49ckBp/AZMwea2uXFVVLkzeryjY6Yq6xdxaKlK1IZywd4vMiClkO27+sDJyNG/UlAo9G3syZJD+Hm2D5YDx7S1+Sbzgwint3HDx6tbNk5PM0GxAFhGG3wJVFScBB/gOkNB9lsI+rqqFYfuWbwnNxZKg4JtYpm5uAaAxfuxg/iOm42pPsdRiK/5ouS40Ax84W5PljHzalWfi7RLRW0qUx6Z/eyr/8jCLROolltIsRl+HO1xm3Cww9WAZGhunUosONi6Q3SJxyUcxREm5JkRW2zEHZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXh8LWLUXOEsbfCPwRW4iRCCUYYTfClz4Pz8oDoAdag=;
 b=NC3pCSFj14AbadgEOnyOGJa0+4oVni6bk/fqXMJLAvS0hgVW8Ij8RZ36gvPV8wRAnm0TOJZAu0Ucv/ZxPyhI+faWGpoMI1pkwIPJ+VBywEkX0La0vhZ2UgV5ibipqVgpUG46XR/f9AWdoOQjLvAMv19H/iyzLYF7NoO+PM1t7EmI4Ofe5OAQxFtU1T48CGxB9LVKi1A5a4WfD3IszZZy+9aYPvCg1P+Kn9jakg0l3CpjU6H/W7znJDn2ngxZa3gyvRdfMRn2E8cllB+vaEo7xvzQfwyT7XyQsoWTL2Wi19qwSkCKIaRXFOLja/AwVH/nJf0A56mWnTJa6H0LCLyaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXh8LWLUXOEsbfCPwRW4iRCCUYYTfClz4Pz8oDoAdag=;
 b=Jz5sLFuEzT6fRsryqBWJqN5rOLU8yvoT8+ear2wusfuuW7mehgS2uudL7mDw7yeo8zy1gvh/sObWWcnpgGtmKlDzYOQ6Ik4DAtzQGUgE71pu2o7y0/dg/NLWkFoL+ODqR/fDIIAvHjWHaHGFfhABjfNqd40fXD1/0S6KUt/4FyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Fri, 30 Sep
 2022 19:29:44 +0000
Received: from MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::ac92:e220:f51c:895]) by MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::ac92:e220:f51c:895%4]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 19:29:44 +0000
Message-ID: <8ea70992-d4e9-8bbd-0fca-d5700f84e071@amd.com>
Date:   Fri, 30 Sep 2022 12:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com>
 <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
From:   Sonal Santan <sonal.santan@amd.com>
In-Reply-To: <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31)
 To MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7cc266-5273-4478-3c1f-08daa31a2094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAG3sfl5hSK3zygawF89ZBn207axl1GGDasupKrEqi5IjIi+5stE1DMFMzsN0v496CHiQyrFmCdPdW6NtNZmdCJDJcUKcRktSmAc/YSHc8XEOpaxZNlrOIP9vRng8xRKnyt6/PzwJV1jAGydf96x4IJQthMv76tNVDWYJQpRISvHsGQVapX6BhvySZMmX/Kqx/kdxc8Wr7PYiMiUYh/OCOkRYvv2SLJvub31PWvuD0vdiR2+7tiRtg9wQPZdNTcxTbRVInxoHBV1NsGQcScohaCzEQ5eisWfrfRutGBqnVCxNkkeNyj2excUsgzhNgTxcPbuLkvS38jbJYI9ikHCM1DNkSNxjJ40asdo3VujupzWGPgQfnTOZeuBnfMpf3i1lp+SfVB7xTvGfqBhkq3jMIkew8wGdgLm/RMQhLku9UUjTj5lu3Erp9YfdphyvFZEE+Rdrd4s+CV8Y056mRKCJxLs2oMzZZ79c0UTFmVpr5i/ukDD5jgkCKnjSXufhy7tIItyHJJxNWOjT38Gz0pNOchToZK8DpJJgxIDSzVCguV3B94d15tm+XnTPe3IOJfl4dmVmZoLXkjzxsXpYMKTzn7Cs7tFMHfKoZfQuRx9Qy3IhHGkxia8y146PnpW8xwrG0qxb+TXtNG6oA0+kKCLooDR6v29SW7QsCHw7sXihQaup/Avnnfv/O5r7498BScUVYaH8/jQnTsgbub5yiajuBM1HYaw6g9UVahefiubYV9XK6xX9sAS13VH0InOGqKLDc4SEm1OFTb3PLW7HSPyj4VqIEnFQ6YNb7qG6aPNSFtSjQ4ssgpP3pSOEQszxeTw0hPGLZQpdNrDkOpkND2GNtwrmGHBswTFzU9h+e5jOBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(2616005)(4326008)(66476007)(66556008)(66946007)(8676002)(186003)(31686004)(31696002)(86362001)(5660300002)(966005)(44832011)(6486002)(8936002)(38100700002)(6512007)(26005)(36756003)(316002)(83380400001)(41300700001)(2906002)(6506007)(6666004)(478600001)(53546011)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXB2R1pVeXFGaWF6djVlN25oN0NVaXVGZWMxRGJGa1dPYnA1WEtUUWZtblB5?=
 =?utf-8?B?d2xMOXF0UWRDVDU5QzQ2eHBmdjRxWk1WYWJNcjZkWHZhZGdyMFJmTVJCVUh3?=
 =?utf-8?B?SDd5WHJMR0UvRWxhYkNCSmhSOWFIT3g4TnErYitndHhXSE8zMmNsQzZVR1RB?=
 =?utf-8?B?dXFKSmE5TC9SajJDS0RsSHR1M0x5YUxNMThRcXpzQkxKSjBRNUdsQ2c3Z3R3?=
 =?utf-8?B?NjZQZVg3S2ljaHAvTmI0SGR4S2Y1N3FtdWZmM3g5SmlvM05XeU1SNEgzajdZ?=
 =?utf-8?B?c1RhZHpOUTRqVEZqMmsrQ3JGY25YZDkyL0YxT2FjUkY0UFFzd3Baem1XaURx?=
 =?utf-8?B?UDBsblIzKzl4T1hYZjVvSERpWVloczhWQTFjeE4rT3d1RWdOeUhLeDJvaGRo?=
 =?utf-8?B?QWZjYnVBdUwyQmtDeUZZbTY2aDY3Rk1DUWtNRk53MWdObFYreXJ4b0F1dmNn?=
 =?utf-8?B?YnI0aThqcXArbTR5WTVSODMwSTQxVVJSNVNwdEl3Z0U1TGNTT2lSN2ltUDI4?=
 =?utf-8?B?dFdWQ0tIRCttcExHbGVKVXJ1LzJrZGt2RmEyeTNnU04yNGtvNm01dEFIYmxZ?=
 =?utf-8?B?a3ViSXgxZG5pNDR1SkpuYVIyL1lGQklDcGVpU3RRRDNWNmgrd3RDR1F1eHl4?=
 =?utf-8?B?K01JVitIZENERll2L2RUL0g3QUcxUmFEYkpCckNGRTl4TEFsVTM4TTN0WkIx?=
 =?utf-8?B?bXpGQU9MZHI2WE5DQ0dSdG1TYUdiLy90QXlybU9mejhNYmErUmdmSjhBSTVI?=
 =?utf-8?B?cytmME9sc2x2dlNhbEk5Nms2ckJ5eEphV0RORUFKbTc1SS9haWNaK0d4QjJj?=
 =?utf-8?B?Y0E0dEY1SzhybUEvQU41WFZubnRhc1BySHI2TlVidGI2eDBCZlA4dmt2UXB6?=
 =?utf-8?B?TlJYRmUrU0htbWFyWVR3UTg3ZUtvWmZFWndnaUdiZy9qREozSGV5SGx5aVda?=
 =?utf-8?B?dm12QldaWDlmOS9OdzFqNFpiVzhEQ0c0ZWsvWmRWOUYvaXJQTWZ4UmxyN0c0?=
 =?utf-8?B?UUo4MWpLNTZlbnQ1aXRrRDZQdk1DVHBDZzJLa0t0ZEdDV08ybFRUd203MkxP?=
 =?utf-8?B?a0Q4YUJuUjNsaXlQSWdnZW0yL3orcU9tOXp3MkcwTis5MlNRZ0xDeVVGVm5O?=
 =?utf-8?B?RXJHYXdKOWxlSmRXaWdlWk5QN1VkVDcxTjRpWHBjeUVMai9Gazh5M1llWW1l?=
 =?utf-8?B?MnNGMGxGS2twcVVoOWNobitSUm50cmE4cWowbjc2WDdPSkVHM1hRejlHRHJJ?=
 =?utf-8?B?QVBpN2ZGT2E2aVJQSFdaakZkWVdlb3BEUnpqNkRHMTZhMGJRTWpveHBKUUxH?=
 =?utf-8?B?VFcrS1l4enpzQ1N2RnJ5U0h1bnNNTTE3WFVCNUVtb0RrWmE3T2l0OGJiZ0Uz?=
 =?utf-8?B?Y2R0TzJFNVY4Z2tWVEdmK3g5MEFucEdKZ1VRbG9nVm5MM1h0anQ5ZXNMaS9M?=
 =?utf-8?B?UVQrT3N1cXJSVnJJM3h2S1VKNGtiV1lmdURkOXJ5WXlYK1gvb3hPQ0FJdlg3?=
 =?utf-8?B?SFRRY0dKODdLSW5YcTZxaEl6bk1LTUFoWjBkc3VHTTQ1NnRDYlUzT1VQdnJk?=
 =?utf-8?B?YTN1TTNTSzVMM3QvU3EybFlnQTJzSjRKOVFSRC9MSWh5RUg2dlA1UXpId2dW?=
 =?utf-8?B?TzcrY0VTdmNnd3NNNDJTSlpqRmE0UHF6U2x1dE5HZUZpNmUxSVlJL3dhS1Rx?=
 =?utf-8?B?dDhvVGtsRytLREpQNzFaOTZkUFZoWEp3Q1VaS3FmWVZ2SkxZSzBOQ3hhSHFH?=
 =?utf-8?B?bUdOR1YvWHpJcDJaODU5ZU94MFF3VCtzOWVacFkva3Y5OUV3eEpGeDhMOEll?=
 =?utf-8?B?MkR6T0FZSEozSmFKVndIOCtwT3NQMU5vT0oxOFJKUEg2Z25XNGhyYitpbXJL?=
 =?utf-8?B?TE9WTUdEVmwyWjgwRVZQelF6cklOU1RBa2dkUjZxN1RZVk9CMzB4emZyVjA1?=
 =?utf-8?B?VDROdTUxa3EzdHJlWTR2WWxPRTZjdTdTMi9VUHY0NEpRcGgrQTRSWDJBc0Fj?=
 =?utf-8?B?N2pJL3A3ZFpNbStTWlc1RnY3WDhpZWozd2pMMWIxWG1Tb0pLSTBpL1hTZGFa?=
 =?utf-8?B?enE3elZmM1hlZmUvaXhuSytIWEpWTXJndmNCdDRkSWlIMm9FYmRieDBYeVFt?=
 =?utf-8?Q?CIGVFx8FOgV/q13LoCjk+8l8t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7cc266-5273-4478-3c1f-08daa31a2094
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:29:43.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0YETLiaBA1GQ2G/MA0oGE/ji9VnQSTgo2dd3qK2GSeKuNiHJAz8LucInYqU6uRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/26/22 15:44, Rob Herring wrote:
> On Fri, Sep 16, 2022 at 6:15 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 8/29/22 16:43, Lizhi Hou wrote:
>>> This patch series introduces OF overlay support for PCI devices which
>>> primarily addresses two use cases. First, it provides a data driven method
>>> to describe hardware peripherals that are present in a PCI endpoint and
>>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>>> driver -- often used in SoC platforms -- in a PCI host based system. An
>>> example device is Microchip LAN9662 Ethernet Controller.
>>>
>>> This patch series consolidates previous efforts to define such an
>>> infrastructure:
>>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>
>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>> PCI enumeration process. However, the process does not provide a way to
>>> discover the hardware peripherals that are present in a PCI device, and
>>> which can be accessed through the PCI BARs. Also, the enumeration process
>>> does not provide a way to associate MSI-X vectors of a PCI device with the
>>> hardware peripherals that are present in the device. PCI device drivers
>>> often use header files to describe the hardware peripherals and their
>>> resources as there is no standard data driven way to do so. This patch> series proposes to use flattened device tree blob to describe the
>>> peripherals in a data driven way.
>>
>>> Based on previous discussion, using
>>> device tree overlay is the best way to unflatten the blob and populate
>>> platform devices.
>>
>> I still do not agree with this statement.  The device tree overlay
>> implementation is very incomplete and should not be used until it
>> becomes more complete.  No need to debate this right now, but I don't want
>> to let this go unchallenged.
> 
> Then we should remove overlay support. The only way it becomes more
> complete is having actual users.
> 
> But really, whether this is the right solution to the problem is
> independent of the state of kernel overlay support.
> 
>> If there is no base system device tree on an ACPI based system, then I
>> am not convinced that a mixed ACPI / device tree implementation is
>> good architecture.
> 
> Most/all of this series is needed for a DT system in which the PCI
> devices are not populated in the DT.
> 
>>   I might be more supportive of using a device tree
>> description of a PCI device in a detached device tree (not linked to
>> the system device tree, but instead freestanding).  Unfortunately the
>> device tree functions assume a single system devicetree, with no concept
>> of a freestanding tree (eg, if a NULL device tree node is provided to
>> a function or macro, it often defaults to the root of the system device
>> tree).  I need to go look at whether the flag OF_DETACHED handles this,
>> or if it could be leveraged to do so.
> 
> Instead of worrying about a theoretical problem, we should see if
> there is an actual problem for a user.
> 
> I'm not so worried about DT functions themselves, but places which
> have 'if ACPI ... else (DT) ...' paths.
>

Bringing this thread back into focus. Any thoughts on how to move forward?

-Sonal

> Rob

