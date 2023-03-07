Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8796AD44F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Mar 2023 02:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCGBzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 20:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCGBzs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 20:55:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5421B2CD;
        Mon,  6 Mar 2023 17:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6vJ8xJ+fdnRkCJb0cNoeivsFt0DVcdBgxn2VUPqrwdU4zKSP0NA8bPxh1EGGeBx/WZAZkO6DG0CIrTkaPlACOamnpNbtFES/NsIjQsaRcDXWFHylx3vPPRf76LMCp7BFeK6J5narb3lQfXnQLhRm9zNCvVsvuLoDZypq1fTadxQC0Wdbjb0n1RFrum4MJDb+FE5DrmW+8nzBuV8x1+q9LV0R0zCJaqEquvOlylbeD4ozgoUyX2zIU8HRy3CbYNBdYck+/M+V74y8rYPswHuEmwjli/7TB1Eqxg2LrWfqjBL9yv9gUb14KtX6aUhqPKLuPFcNV0azXT1iIBVAd5h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKRnLlskJkhfpiEp7h+5JqnEjAgTuSeMJtZ08mScH4Q=;
 b=X41+jMkAdNl6TODWv9E7gKDayqL0qpOOvksS1eXcoJWnRpqPhqAlMDi9s1KKu6A+VN66JUKEcQrPDYGRx6z3jvVmACkXlupGKF7YdBbkwztThGbVHj2oqHKUSUfRQKPmQBzJLEyo4vLjyiaRDQy2bHHWn8MZtMF7Qp+SkP6l5pTs4dRKvNLfg80iPEJtDw2aSPZC0VUnKXBZmIVcUXh3gQHlR31Ua+Jw6itm8IL0V016jTIHnmoyqNNKIXkYnK/9y7CNvgt0t+czV290oZxiMzCmWCE4kj81pxdNlKuzlIdNJGyf/Y+3bTIJDM/zP2+DrpuG09xsIIfHNQWzXMtB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKRnLlskJkhfpiEp7h+5JqnEjAgTuSeMJtZ08mScH4Q=;
 b=LYwFCBd7yxR5pCJhnVDA6deBSy+eMe2WhaF39cfk/VKbbxLIhUdQk2peJ37e/+OqjnTvgJjA9wbLa9yno6JUT+xHuNiNJjnX9YHFI7c0BkdVyZ+G5LdoiabpJIAGXxv2+ikS1uB71QbWg1o+VXXi2+jB/7cfXQojKhfb92denFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 01:55:43 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3%7]) with mapi id 15.20.6156.019; Tue, 7 Mar 2023
 01:55:42 +0000
Message-ID: <959c0702-3955-01b0-0792-f2d8f86b517a@amd.com>
Date:   Tue, 7 Mar 2023 12:55:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
References: <cover.1676043318.git.lukas@wunner.de>
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
 <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
 <20230228054353.GA32202@wunner.de>
 <66ca8670-6bd2-a446-d393-3c327aa45ccc@amd.com>
 <20230302202245.GA14357@wunner.de>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20230302202245.GA14357@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::10) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9da0bf-510b-4fbb-56cb-08db1eaf0f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfXc8dTO2KcUcCBVK2kQ7+Mg/8hbFPcbkZQYctTJFIwuCNEBva7MrVfnfKlv6V/+WCldPKHMBBrgIb1BjBameki0cJtTKghQTeYuswn9awHf9yCKeOWahePbZxwzHUAV6+l9IstmnO4qEihZl9RkIcd8MLYekJB73HWWIUAuF9B0DUs3+2zKL82eJyY/Bw6QMiTS6m1oWk50EyE8cth4Rji4QgT4F8mUFJL8+DWrBzVkx8aoxtk0UEB/5L9owpsilRT2Dte9o4vrl0Dc72n00Ei5/Bpltoa5F9kn/uLH46l/KdQihIm/j9cJ7bx/VGUNyXB9DO3OluWTWBpy9GAdqfw3mjpk52pYNlGWOV8tHXED6/vdzxI5ABbbB0xczXjIOOP02o5m+XTJ4c4Zk869KKkuBhn6CcwCWnemf8e4GXiofujRjO0VA57HhKjGcnxG8jVQctwcVoGtxKo29lHPZnOTwOzPShW5+UXg4okN4fbZk0jlePYuSIn0Pjai6t1ubdBa36jkPkP/fLLbovdX2h2N+arOprqiFN4GqWGDVAFg5DymZTOOLUVkg29ddP1+5BDdW68ImDMCO65TiTqje1jfGZXXGRIgcJyY1eNo55ENR4xW4q1FRXiGpUPS7tzVKY+wEIQ9Rq2wqsVGdNVOPeTnqoiXPb+w3vzAg7Rv+N4vUvFFNd39Y+wDl3/X0t4qfCMhsAXEPztZF6b9mOusQkXiZaoGmyjibYJftePmQYzmJdOVWE4orngk9QbJqn4s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(31686004)(66899018)(36756003)(83380400001)(478600001)(54906003)(316002)(38100700002)(5660300002)(2616005)(6486002)(966005)(6666004)(6512007)(6506007)(53546011)(26005)(186003)(41300700001)(15650500001)(7416002)(66476007)(66946007)(6916009)(8936002)(2906002)(66556008)(31696002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFZxeW9aY25TNDZOb0FhRGhUUzFqQ0NQZkpuNnp5MkI5MjNvN0lXOW1qVHUr?=
 =?utf-8?B?OHVSdzJ6WnYrYzg3Zy92VXRrN01OZzI5Y0VUZjhBMEFEbjdicFhibjFRMzhL?=
 =?utf-8?B?UVJGcHJ1emp0VlU3QWFDQytkamh3RnpnaWtpK1l3bTM0N243c3FXRE92MzZQ?=
 =?utf-8?B?REdnaXNpSXk5TzlmMko3Y1VZa01adlM0ZDVVRlRkRll0eW43bzVkSHI1SGt4?=
 =?utf-8?B?SEFsY3B5T0hZV09Ua1F6alhHd3BsZGdIeGxBUmtTK1luZi82YmQvOFJjdEtU?=
 =?utf-8?B?eG1oVWl5ZHM0WnJ1SUdPYmhhekFBbU01dWFsenlLMVBYOSt5OVpFVDJkTEIz?=
 =?utf-8?B?TFRjemZrQmlibFdkbzEwYTBPd2IwMFhwdCtyMzJJYVcrVWpaTnRwM3FDeGR4?=
 =?utf-8?B?SEkvYzNod01NNHM1ZGhjcVZqN3UvSTBZbk1ZVGR1VXcybDNWbGJHWG1ISWJh?=
 =?utf-8?B?ZkR5YS9MQTZJQUpIM3J3VUVzV21BbVdyUmRrbS9BUzBRcTd2ZURNVUgvM25n?=
 =?utf-8?B?ZXZFUWtuSGV2bVp3ZGFzUUg4NHpDVWFPVmEwVFpCYzhoa1ZFcDRmN1Y1YzUr?=
 =?utf-8?B?N1p3RDZBbkVLOHA5eWJLcVFzTjJTdFhSc2VjZVY0OXNnWWYwc2xsbUNWc0c2?=
 =?utf-8?B?SjdoVmdHcHNMTWxyL1BzaEx3NUNvbzZ3Q3ZnRFIrUXpLaHpqWC9yYXUvMS92?=
 =?utf-8?B?am5KYUlNWGtWYUM5L0ZYQzJMYldyUDRiczJNWk9CMmlyS1VBOC9kczROdkhD?=
 =?utf-8?B?aW90SW0xb1Q2NXFVZFZxRjRtM3Z4Qjdpczl6SloyYkRGcEFEVHZoOHlvaERG?=
 =?utf-8?B?Zm0wcHJHNzhOVGdFcDNuQTd0bSthR3JBa2xIeHdoZjlGYjZYVDdSeEdWOFRW?=
 =?utf-8?B?ZWZiUGZFRnNNSHdVeEZVUi9pN3ROMWF4NGpid1MvOWM1OTAxS3pRMTdzem91?=
 =?utf-8?B?bnY1cmlMWjdScWx4d3dSRHRHZ0xkdVUyOUdJMDgzZWJhSkVVdHdZR2hNWVpV?=
 =?utf-8?B?ZVYvSjdVMnEvdC85RUNwZVVwT3VVTFZubmpITTRvMlJsdUJkSkxRbDRrZ0VD?=
 =?utf-8?B?V3ZMemZqNVg2cUdYc05vMStXMHJocTVIY2wrTDc1TElUUXF6aDdXZDB2Q3dP?=
 =?utf-8?B?QnJUQ0svaHh5cS9GSnh3aDU1RkRnbUJkL0M5K0NIZERWQmorVlhuVjZzbkNE?=
 =?utf-8?B?Q0VlTk5hSGx4Z2s1TklIQXhpOHl4RmxPR1dVR0JjLy8zMG1ZVTNFL1hlKzRQ?=
 =?utf-8?B?MjArUTVVS3Rwb09lN0lsejhSTk5BT2ZmbWM5L29IazFHR2ErTjNydW8yd3NQ?=
 =?utf-8?B?N3BMTEE4WC9kTW5sWGw3R2FqN3ozOFo2dzMrQTRjS08zblp3aGlWaStzYTg4?=
 =?utf-8?B?QzhrRnMycy9iWVRIVW1DZzIvenF6eitwNytnbE95Kyt0Y1hsN1VkaUcvLzJi?=
 =?utf-8?B?a0NrakpEK3JQZ2N4MkptWEY0Y29iRnhFL1FMdUVmTnEyakxCUUoyY0tDZmlS?=
 =?utf-8?B?aVRKNk1KLzAyalVzY20wTTM1RzVSK0ZERlhTNTEyU25zU1p1VHlSNDBMd3ZY?=
 =?utf-8?B?Zmd0MC9lMSt1QWUyRXdscFJrTVZpSFh4LzlNN0NCaHZvRWcrcUoyQi9lL0VK?=
 =?utf-8?B?YWo3b3NkZEViOTUrZHdiY2dFcHAweHFxZUZtSDJYa0J6dE5LYVc4U05zVGl2?=
 =?utf-8?B?TXR0MWhzWTJhVlZLdDJFdXpUQ05RQThSaHlHMUc2Y05DbEtqUmxLS0ROWUVZ?=
 =?utf-8?B?djRBK0g1U2gwbkoxcmc4Sk5qSXI2eU5QekZRM2ZSa0RlMk9mWWJNQWFGS2gw?=
 =?utf-8?B?bWdmbCs1SzU5Y3lQcnBzamlJd2c1dUtOYWZUc2pLbG11eTVjUm50MStQTTIy?=
 =?utf-8?B?cmdSL3NmUXhKTXU2dUcwZlhPNGZJWDR3UzFjSHFESGRVZ0tybjRQS3JVeWZO?=
 =?utf-8?B?cWRWV0F0T2VmUEkxa0dlL2JJdGdvSlorL25GQ05Odlk1cW9XM3BXL1J3dnJB?=
 =?utf-8?B?eUkyQ2NNQTk5K3c2YjNKZFNVTW9EN3pySXpKZlZnTmloTEFMVDg3QXE2WGdk?=
 =?utf-8?B?RHFZWmpzcnZmMVhDcGxkL3R5QS80dC9ITFZiMndVZWYzU1IzYWk4QkNnRmlH?=
 =?utf-8?Q?ADPDf/AGcvWks2RytX+p00TKh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9da0bf-510b-4fbb-56cb-08db1eaf0f37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 01:55:42.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW/qCu3Uwk6LE2soh/GnNUPWEyWbdcSG33ygojELhYN9VXoaPDba/uJWcCOdiVfWmK49hOYm8XweqA+bTOGRBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/3/23 07:22, Lukas Wunner wrote:
> On Tue, Feb 28, 2023 at 06:24:41PM +1100, Alexey Kardashevskiy wrote:
>> On 28/2/23 16:43, Lukas Wunner wrote:
>>> On Tue, Feb 28, 2023 at 12:18:07PM +1100, Alexey Kardashevskiy wrote:
>>>> On 11/2/23 07:25, Lukas Wunner wrote:
>>>>> For the same reason a DOE instance cannot be shared between the
>>>>> PCI core and a driver.
>>>>
>>>> And we want this sharing why? Any example will do. Thanks,
>>>
>>> The PCI core is going to perform CMA/SPDM authentication when a device
>>> gets enumerated (PCIe r6.0 sec 6.31).  That's the main motivation
>>> to lift DOE mailbox creation into the PCI core.  It's not mentioned
>>> here explicitly because I want the patch to stand on its own.
>>> CMA/SPDM support will be submitted separately.
>>
>> I was going the opposite direction with avoiding adding this into the PCI
>> core as 1) the pci_dev struct is already 2K  and 2) it is a niche feature
>> and  3) I wanted this CMA/SPDM session setup to be platform specific as on
>> our platform the SPDM support requires some devices to be probed before we
>> can any SPDM.
> 
> We had an open discussion at Plumbers with stakeholders from various
> companies and the consensus was that initially we'll upstream a CMA/SPDM
> implementation which authenticates devices on enumeration and exposes
> the result to user space via sysfs.  Nothing more, nothing less:
> 
> https://lpc.events/event/16/contributions/1304/
> https://lpc.events/event/16/contributions/1304/attachments/1029/1974/LPC2022-SPDM-BoF-v4.pdf
> 
> Thereby we seek to minimize friction in the upstreaming process
> because we avoid depending on PCIe features layered on top of
> CMA/SPDM (such as IDE) and we can postpone controversial discussions
> about the consequences of failed authentication (such as forbidding
> driver binding or firewalling the device off via ACS).
> 
> The patches under development follow the approach we agreed on back then.
> 
> I honestly think that the size of struct pci_dev is a non-issue because
> even the lowest-end IoT devices come with gigabytes of memory these days
> and as long as we do not exceed PAGE_SIZE (which is the limit when we'd
> have to switch from kmalloc() to vmalloc() I believe), there's no
> problem.

Well, not sizeof(pci_dev) as much, it is more about DOE/SPDM code being 
compiled into vmlinux - it is hard for me to imagine this running on my 
laptop soon but distros dislike multiple kernel configs. Not a huge deal 
but still.

> The claim that DOE and CMA/SPDM is going to be a niche feature is at
> least debatable.  It seems rather likely to me that we'll see adoption
> particularly in the mobile segment as iOS/Android/Chrome promulgators
> will see an opportunity to harden their products further.

These guys all use custom configs (as was also suggested in that threat 
thread - "Linux guest kernel threat model for Confidential Computing").

> It's intriguing that you need some devices to be probed before you
> can perform authentication.  What do you need this for?
> 
> Do you perhaps need to load firmware onto the device before you can
> authenticate it?  Doesn't that defeat the whole point of authentication?
> > Or do you mean that certain *other* devices need to probe before a device
> can be authenticated?  What are these other devices?

The AMD CCP device (which represents PSP == a secure processor == TCB 
for SEV VMs) is a PCI device and when we add TDISP/etc to the TCB, we 
will need the host to speak to PSP to set this up. It does not matter 
for host-only IDE support though.


> What happens if the device is suspended to D3cold or experiences a
> Conventional Reset?  Do you need to do anything special before you
> can re-authenticate the device?
> 
> On the one hand, performing authentication in the PCI core could be
> considered a case of midlayer fallacy.  On the other hand, I think we
> do want to afford CMA/SPDM and the features layered on top of it
> (IDE, TDISP) regardless whether a driver is bound:


https://cdrdv2-public.intel.com/742542/software-enabling-for-tdx-tee-io-fixed.pdf 
suggests that TDX is going to have to reimplement SPDM/IDE/TDISP again 
so the common base here is DOE only, is not it?

And what is the value of TDISP without a device driver, how can the PCI 
core decide if the device is alright to use? I am sure there is value 
but my imagination fails me.


>  That way we can
> protect the PCI core's communication with the device and with ACS
> we can protect other PCI devices in the system from peer-to-peer
> communication originating from a malicious device which failed to
> authenticate.
> 
> I would like to make the implementation under development work for
> your use case as well, but to do that I need a better understanding
> what your requirements are.

While I am figuring this out, is it a bug? :)
https://github.com/l1k/linux/commit/c1b242d74d55d361934bdcff1bb4f881922b10ae#r102531215

Thanks,

> Thanks,
> 
> Lukas

-- 
Alexey

