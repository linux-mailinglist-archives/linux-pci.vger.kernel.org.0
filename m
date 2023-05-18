Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46694707791
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 03:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjERBsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 21:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERBsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 21:48:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF536E7A;
        Wed, 17 May 2023 18:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaLtqE3sh+YlrcahCEH3i19TYse36+z/Z20EqcXe5Jz62wrTVxA7dT9hA5aF5dVSINWcBwEgFl6LHGwEs7gxr6mU2f1ySHh5d1vjPHNxpha2gTShQX5QHivlcu+AW6auLUrkqavqxKa0HDiL2foT5UtRuzx/QG2FijsGwOjHOkfaCZtv4TEIZPGmIFShKwqVb9CjldhYoku0wgtQEyHtNBSXCdxPOkTHk3tk3bF4OQROeiIgVk495wnycWCj6TxXZTAAfTpW5ESJdLqW+w2mi/J4agOi20++gyDflg5KGsSeLWolcu8AFm0z0p2MN8My5T8HLJBIiLzd0CHzOEfg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNp8XGz/ce+pKQfThtMdf0R14IVz40jVlBv+9QqBXhM=;
 b=gsko7W5GXk7Xu7psyNHWiauTif/PaGLs2fRnxfZYkszQHifbr1Zk47S3votFGKDa8Ol6rHiQCR+vC12KYg0c71GaLWn19IZwDqORqrWrduyDsE+Tn/aSXR2n/46kR/wdLuS+fOFCR3Ae7wdwTDz5GppyECHqwRZVl+is9I4zbNuELggf06IwXKR/Go6H8MFb3wgHWoF4glnNSBLSTMy/UcHD7ZUawJkkAucKVQ2f5Sm8/EY4ty7ubTf16waAl1z6dJs+Wm01irACBitITNdi9WEoCUMbzNuz9ir5jN3ReHce0GnmN0Fz7NOmsDA6HN0S37GWdotczuSYgtjHX9hRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNp8XGz/ce+pKQfThtMdf0R14IVz40jVlBv+9QqBXhM=;
 b=ZoI9W65wZ/Apd2gfsJxny3hdXOxQhjn6KPXBA6tl7qbdFj+4GUKWqY2XMTTF6hGuvbqr88LhDZcvLeol+pB2TepXxkga6VR9/BJYb0H3Cpcr6nI8qZ3AMmwCSQTUTANe1mErc0Ddl+zugWCP3McH+XoaeigLQ7KEYQf+GMdwR5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 01:48:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 01:48:15 +0000
Message-ID: <a71a662d-27a6-5c74-a44a-9538ed503a05@amd.com>
Date:   Wed, 17 May 2023 20:48:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Limonciello, Mario" <mlimonci@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230515231515.1440-1-mario.limonciello@amd.com>
 <20230516055918.GS66750@black.fi.intel.com>
 <f0417d28-0c1a-f46e-9cbd-f20f2ac1e9f9@amd.com>
 <20230517071527.GU66750@black.fi.intel.com>
 <8e7e23dc-f01b-6f78-f383-7706795e386e@amd.com>
 <20230517125811.GG45886@black.fi.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230517125811.GG45886@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0046.namprd05.prod.outlook.com
 (2603:10b6:803:41::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 699e8bc3-1ee2-4a57-113f-08db5741f20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TsP/wyhlO/dskEi5Ynz8eMvUe/o9KgfW11HrZawWjRVq1AlOjBgLb80WuUkyPNy4z9p3pfhDGTyauPC7Is5a89tncILGSBS8h7BehAPgkMunve0/erOcOx4xfaquHf2Yxf3YIXHqJ+2boOzz9rXUK2M3zedHQdGDTz2kLdpe+a/GY9Uj5UFdYAXNMMtMob1C/4sz6Mx6sxJFRTHVHwQQwsSpeM8Ipjoirb4e4QeyjBKI7dI2ioJeNU+a9kTMpUjyQt3e6SQo1+wXmw5kykTHCAm82Nyy6RfNU+DENjmH8jFbydzNFPQXQ/t7ELrtZkzjsUSJpl24AnZwAyGQTLYJEAFARggAEIVWeRNsZgm09G78Qb5kIv7KX0LG8zpryI9IOtNCtJyrGwHJSaDPtnt7B6Va5mPPv3UXvbeiAd0EYTmhPe6GpAuc9EFDehNnR1a4xpBMQZyiGq9Joa6gVGrnBakNw9nuxALEGYM2t4CteN5Djj46u1Pl6TqghGvG7x5WEzipEF+X6ztpI48coDYaBS09Sl5BMolAF7CD6r+QecIi9ojmAWMb+udcBdkzW8tZGcEROaMngRSBFtt6J/2O7o8xhve0Mb9uTTP/k3/xfZLAzj5KcjgP490kt7Afyiz/AayMkAKpC8CntEL3bdNcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(2906002)(478600001)(8676002)(41300700001)(8936002)(31686004)(316002)(54906003)(6486002)(6666004)(6916009)(4326008)(66476007)(66946007)(66556008)(5660300002)(6512007)(53546011)(6506007)(26005)(186003)(83380400001)(36756003)(86362001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JsY2Qrb2FFWTlpUEpuVHVFM0lCK3dtOXFEVDB0cVQ0YUU4bUhsb1o4RDQy?=
 =?utf-8?B?SnUzdG41dnFoZlpydDh6VWxMKzRHQThOYXBQNUVIMDVmaktoQ0pKVmFsZVNs?=
 =?utf-8?B?Mk83TWpkQUx4V2NoOEN6NjJ2V1p1YmF3Z0JQVWduRUZVTUFCV3JMcFd0N2JH?=
 =?utf-8?B?WlFzUnlCdk4zNzJtd3VTZDFCM2xZalVKbmo5Tk92VjQ5dFptQ2cvWTBFbFcx?=
 =?utf-8?B?aGN6Nm5vcWNRNUMrQ0xRY1hIb1hONHhCdEdTeGpyVWtDSFVkaGtrZ0ZuUDM2?=
 =?utf-8?B?WWNjTGpRenlYOUVOUXl2UUNQRFozaFhHdVJrQzNIQmRjQmt0VUJvU0RFbkg2?=
 =?utf-8?B?MWN6ait3RkRMY3RzK25MMHRtTllhMmxqZk5LT3NhU2R5RzRDUFBnYnVNRnlq?=
 =?utf-8?B?WCtEYUpqTW91SXdUT0hCSFNkZzZZakRtVlNHVjc0ZHJYS0c0Szh1Z2Z4MFVG?=
 =?utf-8?B?NTg0VUNaSDRoZnpJdVVIRWZwNnh4MGhHUk5NaFhrSlpjY2ljdFp3dURNU2tV?=
 =?utf-8?B?NUNPYk1ZckZ6dm14SEpGZit3R2xJWnFPdHNnVTRMSjZLSFVGL3FoUnRFb3lh?=
 =?utf-8?B?azBITThFU2RoeW9JcGc1NlZFaVUxTWFFTEJvUjVQbE1ReWZxZUZqemg4WVJm?=
 =?utf-8?B?d0ljaEk5dE9DaGdyRGVyT25TVy9RS21LWDNRbzcvYVlWOUc1U2FkQ1UxeWJE?=
 =?utf-8?B?SWcvbTFDTVFwUVlwUTJUWDZOVU5vZFBnTFczQ0pwbmpiQnp4cGlHYUk1dlF6?=
 =?utf-8?B?bW42RExUcU8yTHBxRkNOVkgvUVlJL0NTZ1p1YzhDaVQwa29BbmVaV0N4Unc2?=
 =?utf-8?B?SWVqbmpxcmg1dmpvUHRHNE5SRXd2VGU2NG00K3JUM3BTc1Z2cEYySEpVS2Jm?=
 =?utf-8?B?dS9BQlRlRDNtNTE3d2gxRXZYRVJiN0tvcTM1encyN1dNbk03NGp1emlReDd2?=
 =?utf-8?B?dEt6aHNPN1ROOVVmVFY0T2ZFZU9NR3NobTRLNU1RTy9FSlJPU0ZUZHlka2Zk?=
 =?utf-8?B?WHFSclZ4M1JaVWJoQXQyRnhCMUswS0ovYUxuNUpqUjFUZlNjYjU5WkE3WWIv?=
 =?utf-8?B?U0QzY0VPOVBTTUw0cHJRQzg4WEhGY0I4UWIvcTJ2NkYwMUMwcTJjdndhL3Nz?=
 =?utf-8?B?K2cyZzJud0crRkFzN3I1R2lVWjdxK1FMbFhlSFJGSTV5aXNpVVc5WUEvcXc2?=
 =?utf-8?B?Rm1GMS9hbkpia09mUVE5Yk1wTFRqNFp4SE9SU0VoQnR2dUFtNnhORUdoUnpS?=
 =?utf-8?B?OGhzTHFoaUJoaWM2Y1BIOTNrOTJmZGsrV1dNbGRoa1NHNWlkd1l2VDF2TWVW?=
 =?utf-8?B?Q0JQMlVuY1BORlBCVkZOYnZKVHh1NXBXeFNGeHFGMlZZTEQ4Wmhudmw1N1Fl?=
 =?utf-8?B?cXNoR2w2N3RiSGMyaWJUc0xydWEzdlJDMXF4dm1mT3NqVGhNbUJEcHRvTlZY?=
 =?utf-8?B?akh3czFodVVuQmRMcE5uRHg2ci9zZFc5RXUyOXlPZXdTdTVjZUFsTVJsanIr?=
 =?utf-8?B?eGN6aFB4SnJaQ3dlaHNCd1FRMGZReU5WUG9KRyttQjV4ejlVczZoRXl3dFlM?=
 =?utf-8?B?K0xONUVPRW1ic0pIeDFnbWErREtvWWRpRCtNUWNsNlcxcnNiUC9SZ2VRUC8y?=
 =?utf-8?B?cE9QMkJ6QlpuU1NCUTNycW5ySS9DdDVTWVZhZDZ5ZzhHTitZc0RoWWtLZk1a?=
 =?utf-8?B?WUFqYitnKzlPUnpxRVRBcCtsZC9CQjdSOXVLMXRSOEtDU2lJSmlhREQzMXcx?=
 =?utf-8?B?YTlJTktyZnI0QUxmNEdmK2kwZmFuaVBVMit2RW84V0t1aGVYNDlkTUVFNk5q?=
 =?utf-8?B?Y2hlTFBIU2lPN0IzbUtPMHpSYUtqeXpWQWowaFNtcHFjNk5YK3NBeE53SXdr?=
 =?utf-8?B?bGtGQ1pmTVIvV0Y5b0FHWG1CZXZuUWZ6dWc2SThZV2EwdEtSaTNxMDhFU0Z5?=
 =?utf-8?B?N2d3MkJaR3Z3L2REWnF3bmZrcFBSVGpTRUtzK29sSmJ4Q1RaR09tdUlOQzNa?=
 =?utf-8?B?R05rVDBvNjhiRUVTVW04ZThGdllsV3gxd3JaSkhEdG9pa2lSY1p0UWprN1BW?=
 =?utf-8?B?bW0yejFWQnFMSldhWmk0cmdoWHZCSzd2VWk4R3VUYVJYTXRiN0FqT01hNTRR?=
 =?utf-8?Q?5Y+3bmqYu95QAop7xge+l6V8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699e8bc3-1ee2-4a57-113f-08db5741f20a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 01:48:15.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/jfyMv0h7q9K8qpUeaam3q9ivvbPVkqwloE/OBh1JnmgrT9M/7XeCnvii1V2ubkWNwxZzAQtPuY1uDKb2Idvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 5/17/2023 7:58 AM, Mika Westerberg wrote:
> On Wed, May 17, 2023 at 07:33:17AM -0500, Limonciello, Mario wrote:
>>>> AFAICT the actual issue is entirely a wakeup platform firmware sequencing
>>>> issue
>>>> while in a hardware sleep state and not PMEs.
>>>>
>>>> It's only exposed by putting the root ports into D3 over s2idle.
>>> But there are two ways to enter s2idle (well or the S0ix whatever is the
>>> AMD term for that). Either through system sleep or simply waiting that
>>> all the needed devices runtime suspend. There should be no difference
>>> from device perspective AFAICT.
> I should correct that the wakes may be configured differently, though.
>
>> On AMD all devices in runtime suspend and SoC entering system
>> suspend aren't the same state.
> Okay.
>
>>>> As an experiment on an unpatched kernel if I avoid letting amd-pmc bind then
>>>> the
>>>> hardware will never enter a hardware sleep state over Linux s2idle and this
>>>> issue
>>>> doesn't occur.
>>>>
>>>> That shows that PMEs *do* work from D3cold.
>>>>
>>>> With all of this I have to wonder if the Windows behavior of what to do with
>>>> the root
>>>> ports is tied to the uPEP requirements specified in the firmware.
>>>>
>>>> Linux doesn't do any enforcement or adjustments from what uPEP indicates.
>>>>
>>>> The uPEP constraints for the root port in question in an affected AMD system
>>>> has:
>>>>
>>>>                       Package (0x04)
>>>>                       {
>>>>                           Zero,
>>>>                           "\\_SB.PCI0.GP19",
>>>>                           Zero,
>>>>                           Zero
>>>>                       },
>>>>
>>>> AMD's parsing is through 'lpi_device_get_constraints_amd' so that structure
>>>> shows
>>>> as not enabled and doesn't specify any D-state requirements.
>>> AFAIK this object does not exist in ChromeOS so Linux cannot use it
>>> there.
>> OK that means that if we came up with a solution that utilized
>> uPEP that it would have to remain optional.
> Right.
>
>>>> What do they specify for Intel on a matching root port?
>>> I think the corresponding entry in ADL-P system for TBT PCIe root port 0
>>> looks like this:
>>>
>>> 	Package (0x03)
>>> 	{
>>> 	    "\\_SB.PC00.TRP0",
>>> 	    Zero,
>>> 	    Package (0x02)
>>> 	    {
>>> 		Zero,
>>> 		Package (0x02)
>>> 		{
>>> 		    0xFF,
>>> 		    0x03
>>> 		}
>>> 	    }
>>> 	},
>>>
>>> I'm not entirely sure what does it tell? ;-)
>> It's parsed using `lpi_device_get_constraints`.
>>
>> So should I follow it right this means for ACPI device
>> \\_SB.PC00.TRP0 the constraint is disabled.
>>
>> It's described as
>> Version 0, UID 0xFF has a minimum D-state of 3.
> I see, so it needs to be in D3 for this "constraint" to be valid.
>
>> That means my idea to try to only change D-states at
>> suspend for enabled constraints won't help.
> :(

At least on an Alder Lake P system can you check
whether your root ports actually respond
affirmatively to acpi_pci_bridge_d3() or they need
to fall back to that logic?

In my case the problematic ones don't have _PRW or
_S0W, which might explain why Windows doesn't try
to use D3 (hot or cold) for them either.

If the root ports on your current systems do respond
through acpi_pci_bridge_d3() a possible solution here
might be an allow list for systems from 2015-2018 rather
than everything > 2015.

