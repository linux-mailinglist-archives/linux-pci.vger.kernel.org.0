Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450BF5F80E0
	for <lists+linux-pci@lfdr.de>; Sat,  8 Oct 2022 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJGWp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Oct 2022 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJGWpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2022 18:45:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9DD994F;
        Fri,  7 Oct 2022 15:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ura9u66txJkfNhX6Yjf0JC7ff1hAzED3NblGloutUpEvmZN1pYYONHVaEax7EHTeWWS0N97H4w1hX/peytZw+QH3hOc33BraFKjwICsH50W9pVscEiYqoCY+oQrtjtUAg88bJJ84jq1qKekIap6VIKNrlcmMt2c95e/R5cZ6pZow8IcQfq78NHbiA5E01LHP0XXFzBCtCWhglZ4DzWyJaCaptYRLFFduR6gra6KGPW3W2pAmZ7t1e1Q3YFrD2RvtV4e0t78AlDtEMZZY5dy3QM0dMmP9cdWq3OXNjNIAZipQmOZ2yNrzxW1cpsyLNkA9fAxIWQu6mCD++4LEthBXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV6+JznRciddzFJIX+zTChAVA7v0FdF9omXljvRoU6o=;
 b=SxzVbTbxrt0Xzfvk68zKclS74jAJ5ckbOArr6C9NHj0J7YO8/jWde+olMZlIWhDSyhRpuMkxNNF6M9cgWLs9Xdj8Ndw9mCTx/Te+3X6rKqYp1O2S1/JG2/gT4GHW12fbsxjaR+lxVWWZdP0K+EMv0QUUZlURIVgLELhJl/6gpt5z3SI6p6HUZ+ekB/rjLW+77YeRxldw+a+1XUHPQyIhX0bEayNQcA4xX7ynjLGzhSq+J/anKJdVuQUewVqtA0XMJeY7OApcEIH+FsDA/z/6E6zEBEWgOCNxBscMhh+1ASpa+uZ1BawumYXelvITTZeJ2IYl3jcuUey4kBiSgdZHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV6+JznRciddzFJIX+zTChAVA7v0FdF9omXljvRoU6o=;
 b=CDujKbpAlFA3nnOdXj2dDcdBEcQy1sYuGrS9m7Yig2h/rwb/XiY+y2Xwj+IRSdY9En/dauX5w9JgrJlGQ4FgwELj3wnULAKdPHX65XWCddJVbHeIdZyQvy+WGFY8RPWp0aNDM/dLBvUCF3XDGOaomDhIbjSyga89+J/837MPaAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 7 Oct
 2022 22:45:21 +0000
Received: from MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::b182:d24b:ba8a:1635]) by MN2PR12MB4502.namprd12.prod.outlook.com
 ([fe80::b182:d24b:ba8a:1635%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 22:45:21 +0000
Message-ID: <7f2dc633-23a2-16dc-8a55-0611e2cd6b7c@amd.com>
Date:   Fri, 7 Oct 2022 15:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC 0/2] Generate device tree node for pci devices
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org, clement.leger@bootlin.com, max.zhen@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <f831f62b-004b-4f73-2a66-de9d675c44b6@gmail.com>
 <CAL_JsqJn=i=TT9NArHK25g1NkZN_G1GjN3EGEeTAvyW_PUhgcw@mail.gmail.com>
 <8ea70992-d4e9-8bbd-0fca-d5700f84e071@amd.com>
 <CAL_JsqJA8K0nKO=O2QjyHdue6=EHYNqCTw6pKUsBKwrdrYGePA@mail.gmail.com>
Content-Language: en-US
From:   Sonal Santan <sonal.santan@amd.com>
In-Reply-To: <CAL_JsqJA8K0nKO=O2QjyHdue6=EHYNqCTw6pKUsBKwrdrYGePA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::24) To MN2PR12MB4502.namprd12.prod.outlook.com
 (2603:10b6:208:263::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f36692-b2c3-4e43-8139-08daa8b59d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5sh0q3UaGyAx8f4e/yRfgxJQxIOouOpq8Gq6UQUwz5Yo/Ei1NMEwQKygYo+Ir8bVgiJBA2NrYoT4QSPjxtIp1/TVudK9N0YAfVIY8Y5Iq7pcJ1f0L7BcjxrGnIWK1zZfEbh0lrs8Ni4RsKBlLd2tPe5MzEh6LUH7rB6ZhVy90cAT4UbRT7A5Ubps7AeCCO9O1+vxqkGtJWkEnEAAH0p1l4rUp14v5iM01i6SJhdhOHGWdUvZ2Tzy6Lp0cd4z+ZrYZKzDLdu5dGDnNiZP2GP5SW9KO9us1jCXaIK1yhCeXN5TLjr7i04Yu8P5mADjr+MWLdMeC1g7XskmId3znPboPJY75xu2l+2Mno+1KJkJq9EMuboRTBwhnTDSsvSCAfLHYAIqJ0SR+ldE1ajIKL6GdyPKdly+vlwUT/Sl2PnxwoL+AXZW0xTLGHAi80Uib/JO8JWG13/biRWnPTdXS1nVPWfGffx66FEtelKbjrDHsKNj/0drX5n6IaAe8+eMxV+3vCBVzo6lMJmMlXr+AdQrXzGQtcGqAgSHoowVj6I5I0mFnbtt+YwXfHrvMZg5C5Y8eBBnpwY9BGRhASYscoJGWcCCOvvYBSOogbVOcbJ+y8Nm6AZGcyqrsfy4zLsQy5zi4iCro9wnCfByjpAqdEdtyJNk2Qfxm3q9aLRaaNfh3JtJt5by/eELzJ3T+4SI+/MNjcj5QrQzVUGYB+Ymiuwcmvx6HKQf8ULyFZ+5wDPIKUy9RQBSqPHbZ63LC4Ez9k1M8ddGshkkboRn3W9SmRDiT/dMA5tX0euDm6fMsq1uCzUVr5U5ZW5WF36tTF3hHElMfzV3GRJo2guXNwkUpc2O6Zgw2skdGfGLlZ4wQ4BjR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(2906002)(66946007)(66556008)(6506007)(4326008)(8676002)(6916009)(54906003)(36756003)(316002)(478600001)(966005)(6486002)(53546011)(66476007)(31696002)(38100700002)(26005)(83380400001)(6512007)(186003)(86362001)(2616005)(8936002)(6666004)(41300700001)(31686004)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHB5Y3d0aUtrRzFtajlmNWk3YVBIdUJxK1pHQVFKV2R4Nm51aVJJWnZlRVZH?=
 =?utf-8?B?aC9DYlU5RjFwOW1SbmJJSUpXMjl2SjdNVVNzL1dGdTg5eWNNNElKTVpyU3NO?=
 =?utf-8?B?d1Bsd29YN2lEUmJjK1gzRzc2RUkrbUlMR0NOTVJpQkxMc2xUQ3hlQVdWN3RW?=
 =?utf-8?B?TW9hNkxzVlR2WXR1Wko1MkdQaTR5TElXc3A4eExlRE9wSHMyeDAzd01GS1oz?=
 =?utf-8?B?NDVVb0NqSFZQOHdUYUhPUVlwekR1VlhKOHZodXpWQ3Zob0FkMWhaUFE2aFNE?=
 =?utf-8?B?RFpyT2QvZ1hJWXQ0SXV1WDBFRFE4QkdDaXZyN3RrOFlveElZZ3JISU9lVHo3?=
 =?utf-8?B?eGlBcHhaR29FNjZ2ZmdSWHlnYmUzREdDMW9GWEI2MWVMd3hncFZXY0o3ZTh0?=
 =?utf-8?B?bGQ2TU5weDBMRW9BSmkzYmQ5MVJ4MUJwVkZ0aDlxb0RmVytiU0R2YTJiMmtU?=
 =?utf-8?B?U2FIWFdYK1pST0QrQ1VYcmtVUXdGaWhiQytzWnNyNDFCSHZPZWxMV2tic2I3?=
 =?utf-8?B?czRXV3ljZXJEcVVwWWZ6bEllRW5mcDJDVHJhSUNSMVZnRVR3cG5neVBjZEcv?=
 =?utf-8?B?Zzk2bXdVRHVvaWVBTmRZdkFldUVFTkxDa242bENrVXM1MDUrL25jQm9oQkdJ?=
 =?utf-8?B?aFVZUWxnK0d6d3ZrdTNNS0ZYQjltaGZmYkVuWHJVMG9SVDBVdGtoSmFYL2t5?=
 =?utf-8?B?TDFYZG0zL0xzeFpmMGVhTzFPa3BOWWQ0aEUxOXRVbHR5VytBa2VuT2ZTNHRR?=
 =?utf-8?B?endBTVM3TG5MM0JyaTY1WGJYNjBsZFA0NkFlTnFiS3EzUWMvTE1peThQZnhQ?=
 =?utf-8?B?RHM0b2ZlQktBOVhCa0ZEWUJ3M0J1dStXZ0FLM2o3SlBVMitUSlBvcHVLZzRz?=
 =?utf-8?B?OE9JM0U3WDRURjNFWW9IM2hXWG1pcGlCbU1PSm1xZGIrd01Ta0hyZ2JIQ0pp?=
 =?utf-8?B?ZXRpekd0ZFgrRWFIZW5ONHRReGFSMkJOZUg3U3RvVThxVUJxVVVWYi9CS1Z2?=
 =?utf-8?B?NThMYklYZnlqZm9NUVhlM1ErenVmMzdZMVdaNmw1dkdjN3NUM3JBNThEQXRB?=
 =?utf-8?B?b2dGY1VEWVhxK1VHRHpzZ3ZUbmQ1NytjVzZpdUtDUFo4MkdKVjYwb1dGYm41?=
 =?utf-8?B?UXR0b2pwVmRzMnducDVHNndSNGFlWlArOWppcHBqcFUrUzMwa0xtM202cDhn?=
 =?utf-8?B?elFoaFlYNldYWW1mUm5LVGFzdU1EVjgrQVY2eWxYV3oxTStjbS9DVFZoRXVN?=
 =?utf-8?B?cWU0UjVHTG56TWsxcFVyZDJZU0dsdmdUY09qS09neElVeEtjSjNqYTAvYlha?=
 =?utf-8?B?S25UZjJwMXhzU1VLQ051VDhtRG1tWEg3NExMQ1h6R0FGOG1vUW5oWWxmeURN?=
 =?utf-8?B?bldMcEtnYVJHWXczakJrY3VZZ2VNYTcySCtubSszUmgxTDRKeS9JcEhGMkZY?=
 =?utf-8?B?Yy9FZVM3UVdVWU96L21kZWNJK3U1SUFXMUVLOFJXbEhESXZlYXdwcXg4WCtB?=
 =?utf-8?B?NmpJckpEMGg0aThITGd2aTMvWjAwY3Eyc2x0YjdQMUhYTkErUHBiaEV1YWY5?=
 =?utf-8?B?SVNQRDA1Qnl0UWlPME5GTEVuemVUbWE2R2F0ZGR5dHUraDFsVHRZamhRV0p6?=
 =?utf-8?B?azZLSTRlc0xBYVdYblNiaW5LVlJjdElSdlc2eVhDWVdvWUlLWVEzMVV0aTRt?=
 =?utf-8?B?L01EY3NRWmpQTHU5anlvdjVzQUNGYWRFWEd4cHBTSnE1L2VoclJEYU4yZGtk?=
 =?utf-8?B?ZmJBRkhaR3pnbHZzQUd5OHVUMCtwRW1LSVdWT2VPVkNHdFBrTTROOHh0WnFp?=
 =?utf-8?B?ay82OW9xU1hmTklMaS96K205ZW9KZWNSTFRKemxacFVXbmdhWm9nMnE4cWNT?=
 =?utf-8?B?bFpLREgvajYxQWozRW5lR0FnaFR6NnJoMFA2OG9MR1lrdVgrMzh3TUxzSFUv?=
 =?utf-8?B?SGNMayt3UlcvNkxObXJ3SkpFbGtxd3JmSEh5bTlGSitRdUVmRVFKWldYM21U?=
 =?utf-8?B?N21WVThZQW9ldlU2bnlHWXRtaUhaWWgwZUlsTWVGcWQ2N2xiNzloWWJkcjRC?=
 =?utf-8?B?My81UklLQ0thQmtRQTJwdzQ3UWhGeFB2L2E2dUhLZVFoNWlxTkxoZ0E0YTNq?=
 =?utf-8?Q?7UENIK4NX5dwseNrZpkzxpfLN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f36692-b2c3-4e43-8139-08daa8b59d4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 22:45:21.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0wUKkk28QrwIJhLkATGaZ0U4GWABor0tmbUD4ZdEgvovWzCgAFYm9gwLgYTZpYp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/6/22 08:10, Rob Herring wrote:
> On Fri, Sep 30, 2022 at 2:29 PM Sonal Santan <sonal.santan@amd.com> wrote:
>>
>> On 9/26/22 15:44, Rob Herring wrote:
>>> On Fri, Sep 16, 2022 at 6:15 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 8/29/22 16:43, Lizhi Hou wrote:
>>>>> This patch series introduces OF overlay support for PCI devices which
>>>>> primarily addresses two use cases. First, it provides a data driven method
>>>>> to describe hardware peripherals that are present in a PCI endpoint and
>>>>> hence can be accessed by the PCI host. An example device is Xilinx/AMD
>>>>> Alveo PCIe accelerators. Second, it allows reuse of a OF compatible
>>>>> driver -- often used in SoC platforms -- in a PCI host based system. An
>>>>> example device is Microchip LAN9662 Ethernet Controller.
>>>>>
>>>>> This patch series consolidates previous efforts to define such an
>>>>> infrastructure:
>>>>> https://lore.kernel.org/lkml/20220305052304.726050-1-lizhi.hou@xilinx.com/
>>>>> https://lore.kernel.org/lkml/20220427094502.456111-1-clement.leger@bootlin.com/
>>>>>
>>>>> Normally, the PCI core discovers PCI devices and their BARs using the
>>>>> PCI enumeration process. However, the process does not provide a way to
>>>>> discover the hardware peripherals that are present in a PCI device, and
>>>>> which can be accessed through the PCI BARs. Also, the enumeration process
>>>>> does not provide a way to associate MSI-X vectors of a PCI device with the
>>>>> hardware peripherals that are present in the device. PCI device drivers
>>>>> often use header files to describe the hardware peripherals and their
>>>>> resources as there is no standard data driven way to do so. This patch> series proposes to use flattened device tree blob to describe the
>>>>> peripherals in a data driven way.
>>>>
>>>>> Based on previous discussion, using
>>>>> device tree overlay is the best way to unflatten the blob and populate
>>>>> platform devices.
>>>>
>>>> I still do not agree with this statement.  The device tree overlay
>>>> implementation is very incomplete and should not be used until it
>>>> becomes more complete.  No need to debate this right now, but I don't want
>>>> to let this go unchallenged.
>>>
>>> Then we should remove overlay support. The only way it becomes more
>>> complete is having actual users.
>>>
>>> But really, whether this is the right solution to the problem is
>>> independent of the state of kernel overlay support.
>>>
>>>> If there is no base system device tree on an ACPI based system, then I
>>>> am not convinced that a mixed ACPI / device tree implementation is
>>>> good architecture.
>>>
>>> Most/all of this series is needed for a DT system in which the PCI
>>> devices are not populated in the DT.
>>>
>>>>    I might be more supportive of using a device tree
>>>> description of a PCI device in a detached device tree (not linked to
>>>> the system device tree, but instead freestanding).  Unfortunately the
>>>> device tree functions assume a single system devicetree, with no concept
>>>> of a freestanding tree (eg, if a NULL device tree node is provided to
>>>> a function or macro, it often defaults to the root of the system device
>>>> tree).  I need to go look at whether the flag OF_DETACHED handles this,
>>>> or if it could be leveraged to do so.
>>>
>>> Instead of worrying about a theoretical problem, we should see if
>>> there is an actual problem for a user.
>>>
>>> I'm not so worried about DT functions themselves, but places which
>>> have 'if ACPI ... else (DT) ...' paths.
>>>
>>
>> Bringing this thread back into focus. Any thoughts on how to move forward?
> 
> Reviewers raise concerns/issues and the submitters work to address
> them or explain why they aren't an issue. The submitter has to push
> things forward. That's how the process works.
> 
We are working on updating the patch set to address the feedback. The 
design is still based on device tree overlay infrastructure.

> As I noted, much of this is needed on a DT system with PCI device not
> described in DT. So you could split out any ACPI system support to
> avoid that concern for example. Enabling others to exercise these
> patches may help too. Perhaps use QEMU to create some imaginary
> device.
To verify this patch set, in addition to a x86_64/ACPI based system, we 
also have an AARCH64/DT QEMU setup where we have attached a physical 
Alveo device. We haven't run into any ACPI or DTO issues so far.

Perhaps we can introduce this feature in a phased manner where we first 
enable DT based platforms and then enable ACPI based platforms?

-Sonal
> 
> Rob

