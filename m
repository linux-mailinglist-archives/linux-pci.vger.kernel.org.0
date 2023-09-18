Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4235F7A4C35
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjIRP2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 11:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjIRP2k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 11:28:40 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52C210A
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 08:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcRh7qlYHliRtcwLgrUE6OLMuk81ZFDiEMk5dWRz/RxXwGO5tj7G7W79pgQ57l3nRl9qXxw5hv6/RigoVKtE7qoTZKl17TKZAObwv4qqlKai1uw7N2GpMZ/y266ESOkOpuP9JQimblojj528BoFqqZ8lrYNhWc6K18KeDMYxHg7ns14fPdmnDyAoglF3vM7spoZGa94IDPu+n8+YsnURoKL1S+i+T8ja1h3GHEVwOuOlYVZbBAii+ELYyaJPmi17VGomhH72kkf0QqADI+n5WNo8+67HHIgDP91wV+0BUmHCZqOJANglzvsa+nt09rTHA11uRC4o5IIgQvXM9OI8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fmKGwZ4W0fnHvHNH5PDrREmQScYxFo7cC405zstauY=;
 b=A2F3TRNRUqwnOtUZlhEt5BReiPkjLdx3R96vxlCHoqt0Byjfms8wPE52nBbRDLIH7cgrvF+YV3m7OKy/g4HfJwOvgtp3HOLf+1vpQuVkKMWCbOGuzoehytud4ytg5QhyruAdrNr5BRDlFp50SWA2alfgmjsF6+Fs1YGg51n0Qncu2YjtPWMgR3cnFVNZGs6gV9AesyV/x/UxKT7c67EhPZWs1uYQEMFoTuLRGSZhWYy+3jE0QB5HCNAssHFvXxv4162uE4tCph8diMPYUJiRXmWloIWAhJXhCySMmjB2yfkY9PYYMN2PtHAzQ1+XttbVO95h+nkAxg5K/DKdk0v5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fmKGwZ4W0fnHvHNH5PDrREmQScYxFo7cC405zstauY=;
 b=QlR5Nfo4U7EQuTtrpXn6qC/3GKEV5ri+2p6RfUNnyr5Ked4YtjqfcieO+KzgeUBhP2LxMgDjrDtpCk3/9xY5Rloxv6zVABIsYAJqmDLlCt2J+yZbxMSj17swsYdWp4g4Dx3seNYEqG1gEW7TxQohKs/xTe4vQ27bixsnLQqxvC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 13:28:53 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:28:53 +0000
Message-ID: <888824f7-06b5-4df4-ac04-c6cd599ff6f7@amd.com>
Date:   Mon, 18 Sep 2023 08:28:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org
References: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
 <20230918130742.GU1599918@black.fi.intel.com>
 <fd432ea4-247a-49ca-88e6-c9f88485eb98@amd.com>
 <20230918132424.GA11357@wunner.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230918132424.GA11357@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:f2::14) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cfcb73-3351-4e44-30a7-08dbb84b3380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37v65ThusC12sDxBYvdfi4EyD5GHFCJMWlNn8uIwkS4CJEyKyrhVLS+7FCJMzjn2czMIG4p3xbV7QtXfx/w9MyY3u+I9rtop5Jgv5Vx+5r6jZtZW1uiUwd3YO97B5KyqISJ1lb+8EIpsAsEjXxVxQsgXzW3pelmVY3YfxLSQVcvLBQHCZ9horFPd1EYozEGjQMHVToROvAVkLmbJxxqQFaQUxtSQup52y8Uq2e+MEP7yQOMt5F15JSfFUZiX3H0qp+ypkrMWlJEizJQgvKche7c9vfjYVbGDDaeJj/2TsT6f/LfKPEgbvnIEZvbyFBzrIype9VNz/EuPRuW/0BlMOzoDibebZ1i5ztLE5Pv0+tDcVfBB5fJOEWyOnalJiVFEg3zQXvTTZLf+lZtUPv5MgFq5Nxm/vGhWrnCrWojVvv46Vg/rFv2G8H/0NuKxAykeCbEZGRw88azKQ5bJ4IagibKfzf5t7dLl9VUyfg5iEPIuyOVeHDzVV56ltK363rLaaXdJ+eI33J0j1Qvc5rKLA9O6r/61EMf6XDJbaJVcBizZ2fI4hgiFYvFdmaInb0VEyOIAdLDKdCbf0ow8/lepuMIIyYHvaotweU/oKitSoUAIMFqLUO8BSWpKkl2ozIGPyfZIReKuy8ytSZmfO5gPnpt0ma2fTGxDcIQs6raQ1sA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(6486002)(5660300002)(44832011)(6506007)(53546011)(86362001)(6512007)(54906003)(316002)(66946007)(66556008)(66476007)(38100700002)(41300700001)(31686004)(478600001)(6916009)(2616005)(8936002)(26005)(2906002)(31696002)(36756003)(4326008)(8676002)(83380400001)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M204d1laSUZrNktUcnlGVmRQdGFVUkVoVHNtSWRlTzdVRDhrMWxWWHlHakl2?=
 =?utf-8?B?SzNNSnQ5emxvTk9LVWQvU00zanNpTzhHcklVK05VdDRFcDRQcEROSkxMd0Jx?=
 =?utf-8?B?TitrMEhQcEd2T0U2RHFqdjg5RklKWVVrZnoxVjZ3bVRIb1NyeURYWDhsNG80?=
 =?utf-8?B?UHlXN3diV2d2YytOK2x1NFk3a3pNb28xR242OXFPYURZakRkUU5SMXNGQlJ1?=
 =?utf-8?B?Q3BBL05nNEtLMy9uZ2R4dzBJMkdwQ3dlTHg4ZlRML0ZGNFI2K2ptdHlFRVVT?=
 =?utf-8?B?bnkyVXhCNGV6dTg5TlMvbFNlSzk0N2t5U0NlTERRenR5MG5MNFBnUTFsckxH?=
 =?utf-8?B?bm5tMXlVZlpFc0RmUkUxUE9hN0JOSGtaeFJLRzFMM2Nna1BDOU93QmcvRUtm?=
 =?utf-8?B?eGJOUXlpZVovcmszUHhQbHNnbCtMWCt1TlB5bVNtYWc0WVBDOXdPTXpxRzFI?=
 =?utf-8?B?bW9jdndoN01QOUV0dE1BZHptVjVVTzk5VGRXMUZIRERDcHlaNXltcWRnWFE2?=
 =?utf-8?B?VWZVdThXa3BqOStubTIrUnVDTkpKSTZpTjd3VjkwZUs5NzhNbTRrT1pTelU5?=
 =?utf-8?B?VmlJUW1BQXhJU3dYNnRtRXZEeGYzWTdNVkVBeE94ZG5oVUk2UExWNklsS2pj?=
 =?utf-8?B?b1RwYVM3QUJkTVdmVERhMEhwYzNXNUlvVG1WOU8zekxmVzV2TEpyZkZEZUVm?=
 =?utf-8?B?ZGFZRXlobDhFWVAzU29LRWxjWUJwcEhjdmtEVElnMkplYSttSnllTHpySTZW?=
 =?utf-8?B?SjM2YnV5ZHlpL0pFRzVxWFFYVnB4cDNFYVE5dlZXdHE2VUhmSmkwTGxyUVhS?=
 =?utf-8?B?dlR4VWpZTlBMbDBSY3FRbklKditVdHNrTG5Wd3VkN3RxeE5BWmY2N092VElC?=
 =?utf-8?B?WjNQQU0zVy9vNFlETWd3Q3NJcmtuR011dVExRyt6YWVUVVB3LyszV2twdDhP?=
 =?utf-8?B?QURyOTNxTVU4S1Y3UDcxOVNPYmdhemtERERPUm1vQW5vajNYVVNXQTliTWIz?=
 =?utf-8?B?MFdQc2tEdUpSK2YreFM3VFlKeE9GQVFTS2d2Y0VHcnBJRkR4ZzhFL0hEREZ2?=
 =?utf-8?B?YUJ2Q0tIM3hKMEJOSjVDTUYxdStjN3h0bVFVMzh3QmdrNkk2VFkxdFVIMnk1?=
 =?utf-8?B?M1ZJeCtnRGJ1ZlJDeFY0OS90TXBjYkRKakFmRDY0OHFndmRReFJnOFlkSmdo?=
 =?utf-8?B?TURNcXlwRERxaU1CNFFld3RmbkVvZHQzUUlMQ2xtNDdndWk0V2QzZ2k0YjE0?=
 =?utf-8?B?TnkrbFZhbXRFdkxWVjQ2SmxOUTBuMkFjTU5hTWNyT1VSTUltblk3cHpoUjZ6?=
 =?utf-8?B?UUZYTjBFbWtKcTRHUzRQZXNkenJSb3JZUTV3cDlNUk4rWTNsa25IOEJmeTBw?=
 =?utf-8?B?WERGTTFVV2g0Mi9GdGNlWVRvcmNlYThjRVA1YitNa1FZdG1JZkZaNkNQMity?=
 =?utf-8?B?bXRlekt4NmlDUjE3ZFdKYlphQkNMWVZVY2JzRUVKdzE4R2Jrb2cxVWJUd1Z4?=
 =?utf-8?B?YVZJSk9JRThRdTdmRHZpY0ZOVUZTbkNsdTd0VW1scTJuZHpoWVkrVlVNc0xZ?=
 =?utf-8?B?THVFOE52V1FLSlRpNlJNdHpEbHpONnowaG5NUmI1RHNmU2hEVTNaQVBvWktU?=
 =?utf-8?B?RDIyajdjSmh1dm1BRERTNHZkN0I4cmZ2WUJ2L3dXcjB3aHdmTE9VVzhqeGdo?=
 =?utf-8?B?ZmJ0WldHSFF4MVhxMlJUTHc2TTU1Nk4ydEJFTDlQVTIvMDZGSE05UllDTmZs?=
 =?utf-8?B?dlNJWmI5bjYrWGZCN3hXNXBsbk9lNHhrMFNpMGY1U05qcDluZ21wMzBSMUlo?=
 =?utf-8?B?N2U3Y3pUOUNGQzVkT0dCWVVId1RVSWZDdFVOSDMvUmpqMitMYythbXl4R2lM?=
 =?utf-8?B?VGxqbmdHM2xkTHkySWZ2MGdKUGxmeWs5MlZDSThJZEFJdGQ5QmVUemhyZHc1?=
 =?utf-8?B?NXNYaVpIcjBxc1M4WmNaRVVNNDhkL2xNRklSS0J1UmhUN2hPcTh2eGhkcXl6?=
 =?utf-8?B?TFlrZWMwTzkwTitaRVhZN1M1cUFCWXFGZTh1TzRyL1I1ZEpLY0Y2Ui80TFh6?=
 =?utf-8?B?S3o0RnZSdG1tWFo3L0tua0FuZlExdlN2VG9QVnV3YnRDMzZNQWd2QVpBd3JG?=
 =?utf-8?Q?ZlinhX/Jk9g5Hna/FmHODa+X2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cfcb73-3351-4e44-30a7-08dbb84b3380
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:28:53.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWwwWN7cJkSz2c5xqGYvh110q7et62BijDOgC7XUwSL4qYNRS0jD8CG7u4K3JWz2QcBFcDooW/87yTQhlgLD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/18/2023 08:24, Lukas Wunner wrote:
> On Mon, Sep 18, 2023 at 08:14:21AM -0500, Mario Limonciello wrote:
>> On 9/18/2023 08:07, Mika Westerberg wrote:
>>> On Mon, Sep 18, 2023 at 02:48:01PM +0200, Lukas Wunner wrote:
>>>> struct pci_dev contains two flags which govern whether the device may
>>>> suspend to D3cold:
>>>>
>>>> * no_d3cold provides an opt-out for drivers (e.g. if a device is known
>>>>     to not wake from D3cold)
>>>>
>>>> * d3cold_allowed provides an opt-out for user space (default is true,
>>>>     user space may set to false)
>>>>
>>>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"),
>>>> the user space setting overwrites the driver setting.  Essentially user
>>>> space is trusted to know better than the driver whether D3cold is
>>>> working.
>>>>
>>>> That feels unsafe and wrong.  Assume that the change was introduced
>>>> inadvertently and do not overwrite no_d3cold when d3cold_allowed is
>>>> modified.  Instead, consider d3cold_allowed in addition to no_d3cold
>>>> when choosing a suspend state for the device.
>>>>
>>>> That way, user space may opt out of D3cold if the driver hasn't, but it
>>>> may no longer force an opt in if the driver has opted out.
>>>
>>> Makes sense. I just wonder should the sysfs write fail from userspace
>>> perspective if the driver has opted out and userspace tries to force it?
>>> Or it does that already?
>>
>> What's the history behind why userspace is allowed to opt a device out of
>> D3cold in the first place?
>>
>> It feels like it should have been a debugging only thing to me.
> 
> That's a fair question.
> 
> Apparently the default for d3cold_allowed was originally "false"
> and user space could opt in to D3cold.  Then commit 4f9c1397e2e8
> ("PCI/PM: Enable D3/D3cold by default for most devices") changed
> the default to "true".  That was 11 years ago.
> 
> I agree that today this should all work automatically and a
> user space option to disable D3cold on a per-device basis only
> really makes sense as a debugging aid, hence belongs in debugfs.
> 

Thanks.  Then perhaps as part of moving it to debugfs it makes sense to 
simplify the logic.

IE also drop the d3cold_allowed member from struct pci_dev and instead 
make the debugfs item reflect the "no_d3cold" member.

