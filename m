Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9297C753FE3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjGNQhk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjGNQhj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 12:37:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F42630EA;
        Fri, 14 Jul 2023 09:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwYmbpi5zhvqImCTybebhbgzxoxHGNfBbZJKCSck805lMKuk1cmPaAK4sNgiLCEhrGYShfGlhRM3Mcvpb+sjJE8UrpV1wUBCUb9STv/6T5Ig4Qx5hg60ZAGXk54e/Lzgc7Qq3Xts5uJEI3bU0KmCL+dVEXaw8/+xz7RZIxXiu/nY7HNQJI8USas4Xx2QcJN74OQZwHp5qGCJPS9W/EuOcjyK4eEDx1V+5fIJWwRJWYx7RO39o+E0Hnm0IRWmNy27GlILjgmBlBUjoSpDWsWHjNwIlLQolMrO8zHfbzjTgkgyLDFzIX7irtmLCwR0gyoeDJiWgt7X1mWciM7LVRJ6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku8Qd1gTA3G5N8gWOEW0F8cp/PNKfT4eKhgCQDrpHtY=;
 b=H65dCWXG9bG5WN+nsqf11URXEPV8PJJ0m41GARaKWhZylusKB2xP+fOTTggKxwT8cPUuMXew2nJcSV9lF8HPLYFrOxqaLXkT/VR42Z4D5HiDbGp9CwljXl3oiWp7xcSI16C4jQAWu4Ho6HN3tXXGxVDBrxBbhtrrtHKtoQL78TqwlIPJW9UgkMx32UKtShPrEJJMjlMk2yiUFZ9JFyI/CoouStoubUKCUe4iR6LiJ/Pxl/VF6WaL0ql073i1GTm5YB1FeMF1T3AbSN0xSU3OPCvdM7xsFSxbqPmjjECJD/1cjfy/OlTd5RqqTfU5ElVNmn6Q5mJLnrzlwUoF8dBZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku8Qd1gTA3G5N8gWOEW0F8cp/PNKfT4eKhgCQDrpHtY=;
 b=2vyoidM7ZZdHe4LhbPcRjFlYXouFKQs/v1YiR3xlwXPECsSJkoC+58+th33MEKrgU5Iu2obQ7RB55JfjI0FPYaQDDZOvLbPXDb+lcFr3wjhAhdeGh5ix/6TAl6ehDKUOxoEDKoWG6gov+MAT04FwgiXpBa7QYwMI1h2d0KpIM58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 16:37:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 16:37:34 +0000
Message-ID: <60b2f5fb-8294-d104-16d8-0acfc70426c1@amd.com>
Date:   Fri, 14 Jul 2023 11:37:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH] PCI/ASPM: Enable ASPM on external PCIe
 devices
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        intel-wired-lan@osuosl.org, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20230705200617.GA72825@bhelgaas>
 <9d1095ab-23e5-3df3-58d6-b2974f87ee72@amd.com>
 <CAAd53p7L27dkzwb_Q9vhENhBye-JTcx2AuCG_YXAgb0F6MG-9w@mail.gmail.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p7L27dkzwb_Q9vhENhBye-JTcx2AuCG_YXAgb0F6MG-9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0099.namprd05.prod.outlook.com
 (2603:10b6:803:42::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 64668a2d-687a-45db-b524-08db8488a029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1lv7C73ilaVm7hOMtrWuFye3eDW/4oDFSuhAWQzmZAcFkhM5F3MYc4qWatVd3JB+zc9rSKnf6LW3isBKDF8vMcOA9g2AgqWgixS4arxgBws9Rw+L0AlAONPqQrEtdSJUmT0rcBVlSL4sKgTRkywo0cpzpCzFbDGGgKPx5kM0Tk70HUyxWOAYn+YLK+++dcfnFEe9yH0tobvSjljB9TTHOPLEJ1vbHxmoD48EfCWnTGr5f2j0n85jtJzhZtJfJDxu864Fs5vqwmHGVnKpc2wlO7xM5h7GBf+x4epjbisupbOtxOXBbDl1W81eZTo2byhCdUvhjUdfGo60TElTuBwgJpmdnedJnzFm8X0OZwol9aidQWg+SZdIPzNvg/vOn3yxW51i/nDLYOYko2G0Ois4iHKwhlXRXoQcnDoXhlSAuTJynaLRZHX61pO43iWEGv1a53fHYc4HW+r9po1efWRYMFliHdLr0qS+T1OHvmhsoTMHp+/Iuo9HbJy9QB2Wc0Zsh1qRnw8PHMSwlo4U19QcylqR1aaTx11r0xeaVllgrXChNE2xot3LmwZjm10xcszg27eX0v+juE2OqK1g3LUlLitSjZYTB4pUyJ9JbKQR8DmhSpb6WgaP7oPGp/omkgBAjuMxR2TdSeJrUxr1Hr5oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(38100700002)(86362001)(31696002)(36756003)(31686004)(6512007)(8936002)(6506007)(7416002)(6666004)(54906003)(53546011)(8676002)(41300700001)(44832011)(5660300002)(186003)(2906002)(2616005)(4326008)(83380400001)(316002)(66946007)(966005)(66556008)(478600001)(45080400002)(6916009)(6486002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZwVjQ3V2JqaWxDUEYwMjhPd3o3YzRmNkNUMTFKeVBBdkl0OU1scXFFa29q?=
 =?utf-8?B?bXpJUXg2YjlUeEJGZUdWVDhoSy9CZlNWblhPSjVPa1ozSmJkZmFRbS9kVGd0?=
 =?utf-8?B?TThpQUtHMWU3MEtQM3BYbXdoZlFIcXQ5b1oyd2duZUFGenBacWc1Q3d0cnBT?=
 =?utf-8?B?enNJMlRkdXNwZ0NZdmhXdHlSTWFDQkY0cmJCSzA1QlRkNktwYldBeHZzVk93?=
 =?utf-8?B?dURweTUwSHpmTlZQNVB6OVJvT3NxbnhZUjRiV3l5SlhENllHQ1pRK3hJb3Ny?=
 =?utf-8?B?NzNGdGs5YWVSVFpBOHM4enRsNkdCMWxTK1MveUIra3hVYm8vZVpuVVVlbk1t?=
 =?utf-8?B?dUNlQzJWN3NpMjY3VXI2d3NMT05hTGFaREp6d2Z1N3Z5d1BDcUhOR0hLV0lB?=
 =?utf-8?B?VlZCMDFmamhCaXpYMzNEVWhlMktXQm5reVBqUTZYTVI5aEhscTRNNmRqVG5l?=
 =?utf-8?B?RmUxdi9NaDVQd0plRXlxWjg4eUVBM3U5UXhoRFhlYzduWGVJS2FKaVdoVklt?=
 =?utf-8?B?UjNTaDkvUDc3S1VFc2VaWG5Kbi9vN2NsYThoM1BYN3FYMC9Pdjd2NnN3VXE1?=
 =?utf-8?B?WXhpSEJXNWJyTll1NW85bVV5ZFUvODlTVjNYYnorMzlzaDF0L1hxYmdnSDhI?=
 =?utf-8?B?SUllc2FNV0VDSkR4akloSlFWQm5RSkdKQ3Faa0V2R2hLUjEwRFBXYW96cWdS?=
 =?utf-8?B?SzNUdmYzUEJ1ekNPajk2NWE1cW03cGE2dXd1L0NkaXh0aW5rMGZPVnRrSFJR?=
 =?utf-8?B?MGVrRnMyR0FSbUVPa1FCUi9jT1NqcGJsTjdXUGZ6cEU0aTJGTmNNTFl5UTFM?=
 =?utf-8?B?K1JFY0NiY3hjVFZpNjdicXlmZzlFQmFVdzV1c0daWDJ3M3JZL2hLN2VJUmts?=
 =?utf-8?B?Sm4vWFVLdDlycktFTEZKL1UzWXVmU2RVbXpPM0k1RnRkUFJkQzZ4eVZVUkww?=
 =?utf-8?B?RW5RdWVkSmpSc2k1VWlORkhkS1ZoWUxLU0RBQzhJNTdGTXovbUNVcEduS2Jw?=
 =?utf-8?B?b1I5Nmg3QXpEWWJhLy8xQVp4dFNyOEJTdUJjSmFic3BwenFiOUUyTjhER1hO?=
 =?utf-8?B?SWJjcUlzdnNhZ3d4VHFmcW0ydTZ2cUQxWVQwS2JGNUNXTER2Rmc0b3VncnhH?=
 =?utf-8?B?cUJBcXFGR0pDS3RmbWttY3VlTXZ0SVA4T0Q1M1J5eXFUakZTQ0JjcWd1VitT?=
 =?utf-8?B?eWU4TkZTK2RFTUdub1pGL1JWK2ZhblNKeENVeHdUOG9nZy9oeUFwZWQwSTY3?=
 =?utf-8?B?YXMweDhhQnFTdHpvY0p2OXdtY01SRXlyYjBkYVlQUUp6ZmsxRVdUMmI4bzE5?=
 =?utf-8?B?Ym1FZW5zRXJFVWdiUWd6bmU0U0h2UHg5RTV4Z1hwd1IxTEJJTytOUyt2NWhl?=
 =?utf-8?B?QTJYUzRLdkNxZmhtbzJ2UnFhNTViMXpzNDVBN1NCMUhJM1hudEgwdTRSd0py?=
 =?utf-8?B?ZWxUeU1oSXhhWFZ4Y2x1ZVpCOEt3NURrTTIwekFWUE82RUIrU1JRWW9IVGZp?=
 =?utf-8?B?dTlFN1JuUHByRmNtbE5zV0ZUQW1hM3hIbU1zdktwR3lWNWkyYTJ1YzVpU05H?=
 =?utf-8?B?NlpPQzNWS3dkMXpWek5DZ2l3akZqQnYvemMrQlg0TVZMTURTZDJNUkNQQitF?=
 =?utf-8?B?ZzZIeGRwNDdxajYvdHcyZ2lheGJ3a09yOStCZlVtZW4xbWlxVytuSUM4dXBm?=
 =?utf-8?B?enVLTmN1VGhZcWVMc0FSSnZkU1gzME00WHNTTjZTbGJ2aVpHTDd4TVMrNVht?=
 =?utf-8?B?eklPQzhVUG9BMU9STzNOdFdtTU4yK2dCU2tBVjF6Q1h5U2Jta0ZqOGtudE55?=
 =?utf-8?B?YWRjMUdKL2syZGNONktjR3ZoMFl6cXhtTzRVbk5rSVRzV2ppUjM1U0wyY0lK?=
 =?utf-8?B?Uk05dVp3MEdtLzBUV2lteWd4OGpKTk54UEZHSXF1WitGUDZwTXJvYndISDNI?=
 =?utf-8?B?WHhGZ0pIU0xSYTR5TWZJZkNUYUJNMkgrRjRvSzRQNk5BaU9SZ1VidXhCU1VE?=
 =?utf-8?B?N09ZdmlOS2prTHIvSmExcTZqZXdOYlh1VjcvVUZWTmZnbHg2RDhmV3MyWGtV?=
 =?utf-8?B?TFBQdEpLQ3lTVTN0REFYdVBmanZpZGZoWmxMZFV3d24zMVpZOGhOSTdid2ZB?=
 =?utf-8?B?dU10WTBLTFhKM0FSZ05GSEt2QUxDNUJtRjFHc3ZjZGFMbDRxMnF6VFp3ckhM?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64668a2d-687a-45db-b524-08db8488a029
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 16:37:34.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bO0Pf53z73jBPBLAhn5FDc3rlSRGFsCj4eWPhP3FMGZtZzc7ZQYTNS5icqcfp+loh8CsC0v6xwLraM//jtIxfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/14/23 03:17, Kai-Heng Feng wrote:
> On Thu, Jul 6, 2023 at 12:07 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 7/5/23 15:06, Bjorn Helgaas wrote:
>>> On Wed, Jun 28, 2023 at 01:09:49PM +0800, Kai-Heng Feng wrote:
>>>> On Wed, Jun 28, 2023 at 4:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
>>>>>> On Fri, Jun 23, 2023 at 7:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
>>>
>>>>> It's perfectly fine for the IP to support PCI features that are not
>>>>> and can not be enabled in a system design.  But I expect that
>>>>> strapping or firmware would disable those features so they are not
>>>>> advertised in config space.
>>>>>
>>>>> If BIOS leaves features disabled because they cannot work, but at the
>>>>> same time leaves them advertised in config space, I'd say that's a
>>>>> BIOS defect.  In that case, we should have a DMI quirk or something to
>>>>> work around the defect.
>>>>
>>>> That means most if not all BIOS are defected.
>>>> BIOS vendors and ODM never bothered (and probably will not) to change
>>>> the capabilities advertised by config space because "it already works
>>>> under Windows".
>>>
>>> This is what seems strange to me.  Are you saying that Windows never
>>> enables these power-saving features?  Or that Windows includes quirks
>>> for all these broken BIOSes?  Neither idea seems very convincing.
>>>
>>
>> I see your point.  I was looking through Microsoft documentation for
>> hints and came across this:
>>
>> https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/pci-express-settings-link-state-power-management
>>
>> They have a policy knob to globally set L0 or L1 for PCIe links.
>>
>> They don't explicitly say it, but surely it's based on what the devices
>> advertise in the capabilities registers.
> 
> So essentially it can be achieved via boot time kernel parameter
> and/or sysfs knob.
> 
> The main point is OS should stick to the BIOS default, which is the
> only ASPM setting tested before putting hardware to the market.

Unfortunately; I don't think you can jump to this conclusion.

A big difference in the Windows world to Linux world is that OEMs ship 
with a factory Windows image that may set policies like this.  OEM 
"platform" drivers can set registry keys too.

I think the next ASPM issue that comes up what we (collectively) need to 
do is compare ASPM policy and PCI registers for:
1) A "clean" Windows install from Microsoft media before all the OEM 
drivers are installed.
2) A Windows install that the drivers have been installed.
3) A up to date mainline Linux kernel.

Actually as this thread started for determining policy for external PCIe 
devices, maybe that would be good to check with those.

> 
> Kai-Heng
> 
>>
>>>>>> So the logic is to ignore the capability and trust the default set
>>>>>> by BIOS.
>>>>>
>>>>> I think limiting ASPM support to whatever BIOS configured at boot-time
>>>>> is problematic.  I don't think we can assume that all platforms have
>>>>> firmware that configures ASPM as aggressively as possible, and
>>>>> obviously firmware won't configure hot-added devices at all (in
>>>>> general; I know ACPI _HPX can do some of that).
>>>>
>>>> Totally agree. I was not suggesting to limiting the setting at all.
>>>> A boot-time parameter to flip ASPM setting is very useful. If none has
>>>> been set, default to BIOS setting.
>>>
>>> A boot-time parameter for debugging and workarounds is fine.  IMO,
>>> needing a boot-time parameter in the course of normal operation is
>>> not OK.
>>>
>>> Bjorn
>>

