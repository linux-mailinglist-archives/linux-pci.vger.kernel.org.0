Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56523722DB8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjFERgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFERgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 13:36:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9228F;
        Mon,  5 Jun 2023 10:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+hGLxeLuGUzC0h4Hr1TojfgvVJHTwvMK2Ko034j+PwUNc1jnSuovB/XsbExrQWbJKDqLPJjrtWqH8GN3PSMU8MuHpgpKNPqYbsSLbwzsRBQi3JyT3ArevM3cEqfsVrvepU1BW2ld6uqAmNcZWebiRzBtMuI8FV2Wniigs+zxkwwTcBWdPehC9sZ4NF2ibgs1NUflqkjipZlPCrQ+vHkCgy/wUB3vaOqHmdW2+FBUL7Q8McYGXYifXB/KQZXW+65kgmFr/XYY2uw8zsbXqqmFhmMZaaUwaN0rTi6axy7HFlDYclYNQ7imYv3rXwW6DUgSe+60A3zTrhowttM3adTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK6m37pDeiSgP7H9IaRYBSBmnxN3mAnli2uHvHNBTcg=;
 b=k3jGBlVV6Jb/XOgkxHeWfDsT089JHxcdlI/8KAVewoWJV/dayDhfi99dnUDZM/kHu0vIz/xZ8TcAMa5MYYjYnWc7yuYgm4tjxJJise56v3WWBVkeiDZaaeGVIj3DXLtj1Hnvbc7VoFXfig2OmBolN6OtGUOha3PJYzrQdYRinoc/Ctio51aHZGKtTyyu0zSBDbWG+9i1a7xlpP/wqvEVeYygWD1IIpBdZSjWHknEveFIZbLEvbREwxJXNGmsCMv3nkAIp/OjN29TQnEq/JAoFi8B3otfbuApMXkQIiFxYM3cxy4IcofDLeb+v3HpkiPJ0cCS1bK6PDNJwTiGbOQw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK6m37pDeiSgP7H9IaRYBSBmnxN3mAnli2uHvHNBTcg=;
 b=mvYiOLSnQDhxAT5Gs29FAL02U8GUF1/TSz5ktZGdNB52cMqpGSVfBdnB8Lt4LMI8Q1PP9Hv++ql5aYuJKeMqzb+3IxCPIxGWnhw0dZsqFJdTcc7oH+VNcvUCvCtqI2hzmo9X6c5S51VEqkTID2Q7OHDkthbh5WPof1EajrEp8MA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5026.namprd12.prod.outlook.com (2603:10b6:610:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 17:36:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 17:36:19 +0000
Message-ID: <10897bd9-b9b4-f41d-7a4d-63c5d57fb792@amd.com>
Date:   Mon, 5 Jun 2023 12:36:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <ZHprL3oavxW+tUsX@bhelgaas>
 <af1bbb31-36d4-4924-e02a-bc22b938c7e4@amd.com>
 <CAJZ5v0hz2B3Y1HFE9Rvo4B+YHZR5CeoTSLhTc0GO9mZKrwykPA@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hz2B3Y1HFE9Rvo4B+YHZR5CeoTSLhTc0GO9mZKrwykPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:5:80::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3bf9ee-7cec-4ac2-4fe3-08db65eb5f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j58fby83WekdNn2nemuIrsFm1g9LhG+PUYjNnVSU3owy0gvyDz1DwMnbF+TGINsVBrBIQvFPbN0va4A4pTtpqawup+JLQpjgeKs85aENT9pWG4goku93UqB6iLC7jfkAuqxrovLWv1W5cIJiVZ7t9HBD3ugBmqGXEMeLlwLFD+V2qzhE8mjdpjDgI1IY/2u/Q6CMLzKZD8hN0WDdmmhNFSX2oJgFQlDAwhPHNOy7UvrDnGz0X85k+7ma5gF5jvJfbYh7OChBv5KjxHoI7HvJ7SoMv2af08ptOil2OOJRKDc77qzTnYVbkuUwshd5fypEOt+00UOU51KusuKw8nqmo3ljAVTScBU4RO6nraWx6FqHIpLUDR9rgKSjkU7D1FuJcMrjW2BEVY6bPIxIawe6CBEKNm12nsRCr+5ZeeiMImz/GBJXJD/q/8oFnTGY9TK+y74ODDOQmIifR/wVeiBuyAzQcQkFcaExfEnc3RAMzzz5QWU7UvmFxCfKCJWEht184wJW5iKG95jMyD0GBWFaeYkdm+5Bd9bPo+4y/eNtiqVbQdK4aOtOOcj/Sm65JpdBMOseRPeYY26LsZqa8JJAdwxd8UpVQ8JrruytEnQLUhh9ZMai0JfW3UlGP/NGtPNEUQxpH+x4LQrUiqwY18Cvkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(8676002)(7416002)(4326008)(66556008)(6916009)(66476007)(8936002)(66946007)(5660300002)(316002)(31686004)(41300700001)(54906003)(2906002)(478600001)(38100700002)(53546011)(6512007)(26005)(6506007)(31696002)(86362001)(186003)(36756003)(6486002)(966005)(66574015)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNYNjlyUWxCUU9jWGg2Y3NRcFZnTmd1QmZpQmM5Tzl3UkJmbmluMXNLTDBn?=
 =?utf-8?B?VmRKSVRIZG5sSi9xNEkwVk9lMi9JeUdxbFZRNTZTcjF4Q3FRUjkxdkpwWEZI?=
 =?utf-8?B?ZVlJWUM5TFUvWkJxeXBmRk9KL2h3UWd3L2ZiSG5PUXJEV3dJREVvZ2NQdmg5?=
 =?utf-8?B?aGJuQ3h1S1gvVi9WWi9OdU5zWExoWTcxWEV3ZFp3N3pqZzFaV2VHbnhiNjJY?=
 =?utf-8?B?MGJaQ2pnYnFsYmQ3aE1IckVuRFpzT3JRbnUzK2d2ZlRtRm5LcVBaeEdDQ0sw?=
 =?utf-8?B?YTYzTkxJTmg0WFVrTlJpYmh4U3A4QVNGaEhvTm5BTklLcU5WN1B1RStEamRW?=
 =?utf-8?B?WHFKMVc4Wk95eUdNTUlxRFFLKys1TEhoWG1VdS8zTzRERS9XcnpKK2ZWN2Y5?=
 =?utf-8?B?TUtkNFFHNHBYNUFVYzE3aWZFcTJuMWY5QkZuaHdUMEFDUHJjeU9zTUxHL2Nj?=
 =?utf-8?B?NElpaUNiVnpXcVJsa2hYanhXV3hVZ1dOZm1mTFZKb1dtQU5wYXgvTXJ4M3lu?=
 =?utf-8?B?OEN0NXRzcWV1c2Z4MXg3TkVWTGpFdGxxenNEVGJvVzAxakJDVG9PNkJLeU5O?=
 =?utf-8?B?M1JsNCs1UlJCaG5FMjhyYUkrS3NCSnlXZ2RXLzlOSWpxa2FaZHM2MHRzLzUz?=
 =?utf-8?B?UExJY09GUUtZQ3YvYnJGSjNwcUlpRDBtSGFYRHN5c0FNVnBVZXFSWmxreElI?=
 =?utf-8?B?VElCQWU1V0d3NnQrcnR1V1NRZjdsa0RsWHI4R1RRVGhEMHd6K3lUTFFWYW1a?=
 =?utf-8?B?NnVRZS9aQm9taFdtSysvQUJOaXpRTTQwRXBSQ05LdnFwNTRDNnBxRlZKTE5N?=
 =?utf-8?B?WDdqZ0pYWHV4ZDZhUmNUcktGR0xtczF1dFdNZGVNZXdvdzdxcFlQNS8xVWd5?=
 =?utf-8?B?OStqT25TRlhONmc1V2x0WGJRdEo4TE8vSnlRSGRGYjNOSnhjQWlaaER1ZGtN?=
 =?utf-8?B?ek5Cdm9qNFNXOC9aL05MY0FkV1o3WE5iZHEwTEdnN2V5VU5ZM3pxTUZjNCtV?=
 =?utf-8?B?bkVPTndjQ0NTcXV5OXFPZnczL1gvQWtXTnRiL2lzbnFaZ1ZKT29laGV6UjV0?=
 =?utf-8?B?ZzRjeDMrMG9xdldLbUo1V0pMSDVXcDc4MmlEaVhucTZUMDQ1aTJJYkF5ckZH?=
 =?utf-8?B?Wmt5RzVHdU51U0hiM28wV2kybUp5ZVNjZVA5RlhQci9Nc3JHRXFEQzNJMFJn?=
 =?utf-8?B?RjVZTTZ0TGdKd0UxcHg3dDlieFIzNjZib1Y1VHp6dkt1MzRRd1ExVkJkVkVR?=
 =?utf-8?B?d2N1T2ozWHpjaGRwQ2pFV2tKR3JwVHpzc3ErZVcrYzBpZUlVZDdRcUw3Sy9Y?=
 =?utf-8?B?d21keWN5NGpQSTRqUEl1VEdRd0ZSQU51VEFlMk1QMy8vYmlRVmRxVitzSjRQ?=
 =?utf-8?B?NFl3RFgvaWhIUS9YekZaMjgzYUN6Ly9uZUZpcklGK0Vvc2M2Vy9FUHdYNDV3?=
 =?utf-8?B?ajN0RExSbUo5aWlpa3RBRk1YbHdBL3p2a2FYdGRUNUZreUFSMGVDeTBMVUNp?=
 =?utf-8?B?cTlUREtKNkNzNmQydFkrejUzaHJxQVJielRQaWgwRFlBNDA0cWhUQnZmN0Fs?=
 =?utf-8?B?UHVndDRCQUg3UFZIWUFUSlpkcW9OTG1tQWozY28wYzd1YTBwTXNEV1N2U0Vj?=
 =?utf-8?B?RENxSWloRTk0RTNCVThjQ0VPMXZxc2tNWHMyUmg2anA4TFNsL3k1UGZteEs2?=
 =?utf-8?B?UlRUeThvUHBpVElkZjNSOUs0MGtKUndHRllLVmt5M0UxZmRDWDdwZVg1d3Za?=
 =?utf-8?B?ZHp4S2J3Z1pta2xEbkI3YkN4QU4vc3RxUVdvYkdBTDZVZnZrVTNZYXR4KzlT?=
 =?utf-8?B?OWxjUFJiMnF5TXdIenJVRFpib0NtR3dMeDhPT0p0L0N0OWgxWDFyMzduWkJ2?=
 =?utf-8?B?UE1UVEw1b0tpRUJlZW1Ebmc5Y0VDT25rOVVhdUNiZzc1dU42MDRhdGp2SWxp?=
 =?utf-8?B?RnZna0ZpWTA3dWRTVlVvUGduSVlxelVlV01RL1B6R3N2TXh4dm82ZWZqTXdq?=
 =?utf-8?B?MFYwNUs1bDJZNnRYMkhlMUNJZ2tEVHpaZnFGbGtNNUYrRk1aNjhIcEF0RTFI?=
 =?utf-8?B?QTBqcVR4RDlJeG1vZC83ZldVY0hNU2ZSK3ZGc0c0djdmdDNqbk1VMDFaS04y?=
 =?utf-8?Q?4Dqr264RDy03B8RB5ZWhcSP5B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3bf9ee-7cec-4ac2-4fe3-08db65eb5f60
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 17:36:19.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhSnlKlZDhEAgd6p6b8LG9qvGZslDVdvx5Sx8StNdg7DSkRWOXIBE4xcIu4JjTaGtrUYaKQ1WxiBgvmsuhOUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5026
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/4/2023 6:40 AM, Rafael J. Wysocki wrote:
> On Sat, Jun 3, 2023 at 12:38 AM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>> On 6/2/2023 5:20 PM, Bjorn Helgaas wrote:
>>> Hi Mario,
>>>
>>> The patch itself looks fine, but since I don't have all the power
>>> management details in my head, it would help me a lot to make the
>>> description more concrete.
>> OK, please let me know if after reviewing my responses you
>> would prefer me to take an attempt at rewriting the commit
>> message or if you can handle changing it.
>>> On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
>>>> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
>>>> that xHCI device is connected to a USB-C port for an AMD USB4 router.
>>> It sounds like the real issue is that "Root Ports in D3hot/D3cold may
>>> not support wakeup", and the USB, xHCI, USB-C, AMD USB4 router bits
>>> are probably not really relevant.  And hopefully even the "AMD
>>> platforms" mentioned below is not relevant.
>> Yeah.  It comes down to how much you want in the commit
>> about how we got to this conclusion versus a generic
>> fix.  I generally like to be verbose about a specific case
>> something fixes so that when distros decide what to pull
>> in to their older maintenance kernels they can understand
>> what's important.
>>>> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> all PCIe ports go into D3 during s2idle.
>>>>
>>>> When specific root ports are put into D3 over s2idle on some AMD platforms
>>>> it is not possible for the platform to properly identify wakeup sources.
>>>> This happens whether the root port goes into D3hot or D3cold.
>>> Can we connect this to a spec so it's not just the empirical "some AMD
>>> platforms work like X" observation?
>>>
>>> "s2idle" is meaningful on the power management side of the house, but
>>> it doesn't appear in PCI or ACPI specs, so I don't know what it means
>>> here.  I assume the D3hot/D3cold state of the Root Port is the
>>> critical factor, regardless of how it got there.
>> Unfortunately (?) for this particular issue it's only a
>> critical factor when the system is in s2idle.
>>
>> PME works fine to wake up the device if the root port is
>> in either D3hot or D3cold when the system isn't in s2idle.
> Why doesn't it work fine when the system is in s2idle then?
>
> Getting to the root of this would be really helpful here IMO.
The process of the hardware going into s2idle has a certain
sequence of events by the platform.

This sequence is what causes the PME to not be able to work
during resume.  This issue has been root caused and is
understood by AMD platform designers.

It's why the AML doesn't provide any of those ACPI power
management routines outlined in the ACPI spec.

If the AML is patched to advertise these routines the exact
same issue is reproduced under Windows 11.

>>>> Comparing registers between Linux and Windows 11 this behavior to put
>>>> these specific root ports into D3 at suspend is unique to Linux. On an
>>>> affected system Windows does not put those specific root ports into D3
>>>> over Modern Standby.
>>>>
>>>> Windows avoids putting Root Ports that are not power manageable (e.g do
>>>> not have platform firmware support) into low power states.
>>> The Windows behavior was probably useful to you in debugging, but I
>>> don't really care about these Windows details because I don't think
>>> they help us maintain this in the future.
>> OK.
>>>> Linux shouldn't assume root ports support D3 just because they're on a
>>>> machine newer than 2015, the ports should also be deemed power manageable.
>>>> Add an extra check explicitly for root ports to ensure D3 isn't selected
>>>> for them if they are not power-manageable through platform firmware.
>>> But I *would* like to know specifically what "power manageable" means
>>> here.  I might naively assume that a device with the PCI Power
>>> Management Capability is "power manageable", and that if PME_Support
>>> includes D3hot and D3cold, we're good to go.  But obviously it's more
>>> complicated than that, and I'd like to cite the spec that mentions the
>>> actual things we need here.
>> Power manageable through platform firmware means the device
>> has ACPI methods like like _PR0, _PS0.
>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>>>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v4->v5:
>>>>    * Add tags
>>>>    * Fix title
>>>>    * Adjust commit message
>>>> v3->v4:
>>>>    * Move after refactor
>>>> ---
>>>>    drivers/pci/pci.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index d1fa040bcea7..d293db963327 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>>>       if (dmi_check_system(bridge_d3_blacklist))
>>>>               return false;
>>>>
>>>> +    /*
>>>> +     * It's not safe to put root ports that don't support power
>>>> +     * management into D3.
>>> I assume "it's not safe" really means "Root Ports in D3hot/D3cold may
>>> not be able to signal PME interrupts unless ... <mumble> platform
>>> firmware <mumble> e.g., ACPI method <mumble> ..."
>>>
>>> Can we include some of those hints here?
>> I'm cautious about hardcoding logic used by
>> acpi_bus_get_power_flags() in a comment in case it changes.
>>
>> How about:
>>
>> "Root ports in D3 may not be able to reliably signal wakeup
>> events unless platform firmware signals power management
>> capabilities".
> I would rather write "unless then can be power-managed with the help
> of the platform firmware".
>
> The meaning of "signaling" is unclear in this context and even if it
> was clear, the platform firmware support actually needs to be used
> here, its mere existence is not sufficient AFAICS.
OK thanks!
