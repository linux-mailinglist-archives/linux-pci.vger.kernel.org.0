Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7D7B7228
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjJCUCu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJCUCt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 16:02:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDE0A1;
        Tue,  3 Oct 2023 13:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M17MwDFWoFHYzODpsn/bE+BTmXbo0jgiPdrqI96p8D8AC4ZPDu2nZAvbEhRnXllpoJD00kz5CzEW9mewOm4cmtnZYGLBnPwu4zfgvbuoCWqDA7D4wsnXMm4DAvH3PTIquuZsFp7pAm7WzY6UM0UPehE/jpU7++xmi0/T09QZNl/5O9QzTVHyLhCcjcCqVfsJH3aRwcxBErbTnEKBEjhy1uvIqU7H0caryvqvBPwgAYglxzXOek5FeURduzKOONrrnPXbWM5oq2OUPSq72oJ3K/anXcTp8Z3fyG4q3I5Xyspi0VmEqajUmJLKBWL5P3QcqYde8MGEOHdA/U/wAEbvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APZ8q5BoIg5JtAr4RjPGB/rUxLLF3knXiky83jW8Z80=;
 b=mPutEoj7Gy7xmqJqrwCShYPS2C7LRXhJ5Er/zIYz0OCgt6jAPF7Dvs2cn+Lt1DVNO0wjWL60rfftDw3hrS72VErHJXTQDXSTMjYsXMQLgb3o9V130bReeHDLK/bViwF2+9SgfAWEU1NZHJ1fBbe4nQT4rq0rtnwNGned+uDae9V5dHwcYDfCucOemAJyCc0HwtM6noMK/yiDHHmQBvCF4POvwJJivm5Rawx/Fwf0G2vJFeYthTCSQFJsZCp+dKwjZnSQ8fgbDGCtzV43Jqgpeut3kWmir4uIrYpyHD+jpasqEWOoz0p5AEHZ4ndZsDOcPQFWjfrnGzvcBYFY0WYi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APZ8q5BoIg5JtAr4RjPGB/rUxLLF3knXiky83jW8Z80=;
 b=DNgAWuB71vGgltKWMZjRRWlviDKmbFYh7QYTULM4rL32rSI2L9xYB+77hbhZQBVcSwQ3FG1I1SUlqy+nfgLmtaFNuRwPQpLi0qz8VRCM5Ixr1fo70ifM3QMeosqWMQQzgB+xryGUTvRKiDvKLLJQCN8eYVIUEao9QbIJOsbyr/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 20:02:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 20:02:44 +0000
Message-ID: <84d840c3-5557-4b18-8d49-e60759cfb27d@amd.com>
Date:   Tue, 3 Oct 2023 15:02:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21] PCI: Avoid D3 at suspend for AMD PCIe root ports w/
 USB4 controllers
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        iain@orangesquash.org.uk,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
References: <20231003195947.GA685849@bhelgaas>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003195947.GA685849@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0156.namprd04.prod.outlook.com
 (2603:10b6:806:125::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 38337f16-7021-4d49-c501-08dbc44bb4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYts6xv383FzLWUYqNuA4na20MBcf/mj5yHouh6T/valrpt1cNXJl52n7IegaJIcPylxdFzZ6ziocym7nMIjwE4As7Lrg4dcnOFu48uYx0KbdMFQDCliS8nPyWc1Nkw6zP5YDZamCEgI+OE3+xmFdm1txdfLJP4nzrfoqqh7EghDq9Rh7wdCCUCj/ksSbE+29mHxMHprGXfmTf+f4lEGQuebQ/CE0sbHRO3fC7GU11SHS3fN0uaKnWnv4wGXOfp9PxfUusO7AV1VwUQSfZ9iB6EYCKT/VYmlj+nz7D01OGnC9rtOT7cU4PCZAE7SIjK+JcPmoAB2zqAftfNPtBpPQIRloQu8gCJUyMJdnip6HmlNHaylpHC9Vvuo0baETw4Fj4xOHcZ/g9cDfbuqmzMaRJ9C6KD5PUSYP2YR5smgQCfCQdgOQ5o2d2rtXr3FNrRs0h/lviV96VMSdkM9PvZp8fmJ7BvMXFbXVkoBLHVfZabDV7dxmbIQbRy9zpPq4WvEuf7u7XkK0QVyFtV2eWxhyupJNvlVgxskH6UhuYbKZW8Ds9YRIWoSZ1/SEL5dH81mjnPZYz71ob2L6WYfGFl1qO+OvqD3L0TG5SwA7CPdEOaFn2w5zOHTqZ+Em6ghoe/Ps4Gs3nU+pblp8Ml4/ShJCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6506007)(53546011)(6512007)(2616005)(478600001)(6666004)(83380400001)(26005)(7416002)(15650500001)(2906002)(44832011)(5660300002)(54906003)(66476007)(6916009)(41300700001)(316002)(8676002)(8936002)(66556008)(4326008)(66946007)(6486002)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym11aDJzdHZTL0owbDhEU2FtcmxOajlzNkVzVXlod2tBbm1PekVQVndqQi9v?=
 =?utf-8?B?bFBoQUtvVWFrSTI2YWs5QlYrbWZrc0djUWMrMjdZZWQ5OCtiaVZ1dVBDV2tl?=
 =?utf-8?B?VzErY2RJamQxZ3lnQkF3MVNlQjBJTG13aEo2ZWJURk9NMHJVNzlKa0RsU0FI?=
 =?utf-8?B?SWIzRFlvY2hEQkNnV0Y4MUpITC9yK0ZQOUNYYlpEVDA5d1hWSE51SDcyWitw?=
 =?utf-8?B?ZGRUdVorWnNsOG9LMjNKaGRhaHN2Zll2ejhra3hqSUxEblpUSWNPOWtnM0da?=
 =?utf-8?B?NlRBSzM2bVVGOGhON2ZkNTYrQWJPSENoL3NrRVBLQmdOeHFTdElIbGNDeUtY?=
 =?utf-8?B?UmZ3c0RWU3VNN1Z2UjJDK1Q5Nnkwb084S0RWR2g1RDZZeUNta0ZDdkNVM0p3?=
 =?utf-8?B?RXljcnMwQzVSd1ZqNWNZNUNNTU5CdTA0azRvK3dOakVYUGdnbnJRSU83Tmtm?=
 =?utf-8?B?ZE9GVW9FalBnR3VSUldCUjJNOWM1NmxOU3hzNW1BMDR0RnpWUll1MjljMTNp?=
 =?utf-8?B?VlY1VVFVZzFkcHNzMHhIbFVadVJkYTl1ekJIUmhiSXArUjNZbzdWTkg2MVEw?=
 =?utf-8?B?cTVxcCtmOVU4TUpPUWxVTWpqV1FzNGNSa1NDWkVkYlVaTlhYMHBNTjZpc1hV?=
 =?utf-8?B?SVZnci9Nc2NITEhmMDM5MDNQVTAwZlZJOXQ3R0FxNzZBS0xJL0t1ejlzdXh2?=
 =?utf-8?B?TkMzQVVUQkt2cHVCcWdIbW5kcUxtMWZFYjBkRHlYSVp1amNlN0dBb0Uwb2xu?=
 =?utf-8?B?SEFwSnV5dlg3bWVRdXV0clBadk5xNGZlaXpYOUF4OFZob1dqMlFSK2d1NGEx?=
 =?utf-8?B?OEpZK3BzUTcxc0h4ZWFyZnFtU2xUTFpuRGRBQk1leFNCWmdZQ2VPODJZL1Nu?=
 =?utf-8?B?Snl4M0VsbGZ6LzNJU0w0d1Y5QlJ1NnIrR0VpN0tNVVFLaENEL2oyUk1pYzUw?=
 =?utf-8?B?cTV4RzZXTXpUWWFaZEdVV3RHZG9IR1VjV3JkdU02dlVlZTBuN0hKRjh6dG1z?=
 =?utf-8?B?U3VnY25XSWlLT3dUQVp5QnJheFFqdkM5Sld2U3ZBaWU3SU9kbUxSS0ZEQm1D?=
 =?utf-8?B?Y3RzUENPSFR4ZXB3c1hpNDIvUVBNRnJ0TGM2dHBYSXNVQ3RMdDc5SDZ5eUpM?=
 =?utf-8?B?UnFnaUZGbWhiUDRkZlhkM0oyMVd5ckdKZExkOUlDQkpFRXJtNFpORFUxRjlm?=
 =?utf-8?B?NmNJSDhTV0NDOUZFbjlyTGtZZTFhM3R2dGJlQ0tzalhuSUdLWGxZT0ZSK3NE?=
 =?utf-8?B?K2Y0M3UxcnBXL1VEZDdlUm9rVVJpY3oydGhETUxMNzl3SnZyOW9ubUdSdzFZ?=
 =?utf-8?B?L3ZuVjQ4djFjMVluUG5zMDNscEZGWkR2Tkc1SFV0b2k0QUpUWXBVdlNjUkJS?=
 =?utf-8?B?eWhQMU10VnV6d2NuUnZ3bUZ5Tnd3c0hDUlBsR094REVUVFR1emVsMkt4SDFx?=
 =?utf-8?B?QzZRK2Q2LzQ3T3c2L2lWQkdSd3lKaHR6bEo3RVk4QXM3WFRhNCtXU09GR3E0?=
 =?utf-8?B?eFc4U2RNMTJ2bW03V211clRYN2ZWeG1qcm5WOXgyYUNHVXdsbkZjcHJLNmFG?=
 =?utf-8?B?Q0NueGMzZkE0NHJBN0hwOWFWdWdoZyt0ako5a0FxeHhoMm02THphQlE2SXM0?=
 =?utf-8?B?UHQ3VG9DTllNc0M1L05QTEZXUlFFTDFYZG1yckt5a0FBamlZWkxOSTdzZkN0?=
 =?utf-8?B?bEFFQkthZFJ3aklLRU52OFBSbXpjTWVLYWh6bVI1cG5DYXk3bE8wQTJ6eDNl?=
 =?utf-8?B?QndnZmJsMFhBcFpKL0JlTFhBQTBhRmEvbm1NRS8xd0p2TVhUcVdpY0lLQ01y?=
 =?utf-8?B?VEdxNUpkcmIvcjVCd3cvMG52WXFvUUg4Q2tLcURYZ1hsdms2QVU0QVQzR2VN?=
 =?utf-8?B?UFFIdE16MHZGY2tpVXZwMWZPak4vazdJRCtNSHp6Q1JZSFlDamdUYXhxci9R?=
 =?utf-8?B?by9OeER5aC9uUUJyQ0NSWmJZNFVjcEZIa3BHcFNHeDJ6Vk52RC92NFBWNTcy?=
 =?utf-8?B?U0hubHFGUCtwVnAveVdZMWdPNUtPcTFzQ3lYbVp5K1p6Sk1QTmQzZ3Zzb2h5?=
 =?utf-8?B?UklWZ3p4Y2IwN1VHNm5wRzNEdE9lcmtES2UxOTU2WVBGVVVwWTlOWEM5Qisw?=
 =?utf-8?Q?JBjsPV6qkkOqV2llZOwkvfGpt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38337f16-7021-4d49-c501-08dbc44bb4f3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:02:44.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i+jDljvUh72R4J9+zYQtaRNws08GRziEKwdDFtuBZ06SFedVl/kSeIaEOJjZpCPAl+DSQSECfpS70LblpI/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/3/2023 14:59, Bjorn Helgaas wrote:
> On Tue, Oct 03, 2023 at 02:24:26PM -0500, Mario Limonciello wrote:
>> On 10/3/2023 14:16, Bjorn Helgaas wrote:
>>> On Tue, Oct 03, 2023 at 01:37:34PM -0500, Mario Limonciello wrote:
>>>> On 10/3/2023 13:31, Bjorn Helgaas wrote:
>> ...
> 
>>>>> That's one thing I liked about the v20 iteration -- instead of
>>>>> pci_d3cold_disable(), we changed dev->pme_support, which should mean
>>>>> that we only avoid D3hot/D3cold if we need PMEs while in those states,
>>>>> so I assumed that we *could* use D3 when we don't need the wakeups.
>>>>
>>>> If you think it's worth spinning again for this optimization I think a
>>>> device_may_wakeup() check on the root port can achieve the same result as
>>>> the v20 PME solution did, but without the walking of a tree in the quirk.
>>>
>>> Why would we use device_may_wakeup() here?  That seems like too much
>>> assumption about the suspend path,
>>
>> Because that's what pci_target_state() passes as well to determine if a
>> wakeup is needed.
> 
> That's exactly what I mean about having too many assumptions here
> about other parts of the kernel.  I like pme_support because it's the
> most specific piece of information about the issue and we don't have
> to know anything about how pci_target_state() works to understand it.
> 

Got it.

>>> and we already have the Root Port
>>> pci_dev, so rp->pme_support is available.  What about something like
>>> this:
>>
>> It includes the round trip to config space which Lukas called out as
>> negative previously but it should work.
> 
> True.  But I can't get too excited about one config read in the resume
> path.
> 
>>> +	rp = pcie_find_root_port(dev);
>>> +	if (!rp->pm_cap)
>>> +		return;
>>> +
>>> +	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
>>> +				    PCI_PM_CAP_PME_SHIFT);
> 
> Is it actually necessary to look up the Root Port here?  Would it be
> enough if we removed D3 from the xHCI devices (0x162e, 0x162f, 0x1668,
> 0x1669), e.g., just do this:
> 
>    dev->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
>                                PCI_PM_CAP_PME_SHIFT);
> 
> I assume that if we knew the xHCI couldn't generate wakeups from D3,
> we would leave the xHCI in D0, and that would mean we'd also leave the
> Root Port in D0?
> 
> Or is the desired behavior that we put the xHCI in D3hot/cold and only
> leave the the Root Port in D0?
> 
> Bjorn

The intended behavior is that the PCI end points go into D3, but the 
root port stays in D0.  That matches how Windows behaves.
