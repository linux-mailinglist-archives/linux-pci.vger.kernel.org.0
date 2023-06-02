Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC5720C03
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jun 2023 00:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjFBWip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjFBWio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 18:38:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8F1AD;
        Fri,  2 Jun 2023 15:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADN9VOsW3G5ncmdB3C/Xn5qpBqaYJdABdzVx1j6kpSAiC5eWe49JhApY+chgBlVhuqIQGrOjFKSP0fRfHk6Kr3yLygdaxww0wyWnTRLg9GLQAF6nhrVz2q5oDw5/ca7YvnzPmC1KovR9iU/16huIQF5hj2u3fXAt9kt9bVDmvh8X4e18AO0j5Nh9fFViWqXNHYR7wXePS1n+wtc5x96q8rde5KvaF/bNoJKe0XYjK4AmVY9sLpvMTIyvVCH8FB8IggLasFbKZ6e/9Mx+Cupl39EdIZXRxRogF+e6P5zsG8UqZVAykxq52dUdeRHtfXiqtF2OR8HFc3Gn1KsvDH+Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDJ7OZmM8X+mOvnANA+DF5Qg2tpGVZPHvRKGiINO8bI=;
 b=IOMN9NOcjvhX5fYEg7Td3VWOCTxi6YgXZ8a7dlDxCEBKzzc2Cby+ynveiTiOXKqs4oEAOotJgX3uLiFR673xkSTL8ar6nYqHqEvuicbYvdvUnyXiypumc3kqtK2sywN9WFRF3xFXhdvY1XQbc/uNdCSYwUcpsJvSqUDIQhavNCyhXaLMTtBEU5TbTINmQ4ZuWKerWAgBLk792F9C5deQ+vVuHAMp70Ii4aQW2J2i2DzPSF/Cym3LQC2xQCgyh9Wxog0eShcYPgmhGwanqIceodHXkBpQtiXtLJJ0gL8nsyIDEhxiNN8r2LmA+V+dTBBcjVL6TTm7cx9QZu1mcpQO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDJ7OZmM8X+mOvnANA+DF5Qg2tpGVZPHvRKGiINO8bI=;
 b=luz3wb3/oR9Q/DP6B5mPqaqN51unVg9mQ4ZawvDfVN/dchuxNE2SUllAGlPE0Jl/JZmpMfzNs3ziPC0b4dXHHq1NScjbnMhfP3YDfTm2V7la3YWzv8AncyZ+IgN/6+J7eUKcxOYX7n38HViEFhl6w2aBX7GoAK3dHWUIbQ6GSi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 22:38:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Fri, 2 Jun 2023
 22:38:40 +0000
Message-ID: <af1bbb31-36d4-4924-e02a-bc22b938c7e4@amd.com>
Date:   Fri, 2 Jun 2023 17:38:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <ZHprL3oavxW+tUsX@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZHprL3oavxW+tUsX@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:802:20::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 09562387-11b0-497b-6240-08db63ba1ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZwY6W3LvRtebefp6EPuvPKbaNR4E19YjPNwgxerEPf3nJsEL5J6giVelpCiLa/a0+mQSeeEcpQ27A+JJpr5Mxp3n7Vd6a36qEIr7AjInFr7Q56dBzzt2GZRm7Pf3fNlG5PS8SBmJcKgGCyzgHr3H+vsMahMx1vcJppWjIFcdj8CiqyoU7agKhxKWZjOHCdvo1eiEC1h815pMdj5C4Fi76camurndUGJYEq5ozQj8mk5jSiEuY+veg0fFr5qvpRP1V2x0jL514bSQvVfGvAhH7D0GWuyZFv+ZOUljobrCmUX3FdKnU3vEDkFWYz/AsbPr7+kBu9YQabhI54z2W+wd02Lr/Vke7VoT2TEHIYqXEj4S7flWSnElP0+PnszyoNJtk+tzlynjGGff91Wjx5qGDrTBP4nMyZpq0K/jveF4/rElA9HoxYj6EbS57xcVwSxQ/TU8ERtX928AceaFNJvh9vwO+QUJ+U997Wr/zpiLqUCsa3hvW8v9xk5xvf3xLc+D6hLQo5QrSpv2SLqQ/BYNpOeWLKPI97fRtLXvHT7O0bMsJMcJFTC9G9AAj/Mfq7ahaa6ZS2bFt5ohEF49MV4FOpQ8n9YNI+9GAgWiCcYr4yagA3YQ/pp3LPm59WiHzxJPFMO7Qud+tpgnQsGfvAOzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(66946007)(66574015)(83380400001)(66476007)(66556008)(6512007)(6916009)(6666004)(53546011)(966005)(6486002)(6506007)(2616005)(54906003)(478600001)(86362001)(186003)(8676002)(8936002)(5660300002)(31696002)(2906002)(7416002)(36756003)(41300700001)(4326008)(316002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUlPWU0vUCtxV05iV2hYMHhsK2FnWXMxMmhHR1FtdUtjR011TThieE56VEVN?=
 =?utf-8?B?NnJuMGR2SUdFTG1yeXVNcHB2UEF3TDBJUWhCWWV6cGdkVGFMalU0ZW1ueFNr?=
 =?utf-8?B?eUJqV21vK1hKeVBab2dtMGdDZDF3WHdRa1VacCtYaWk2Z002R1cvNFB3ZXQz?=
 =?utf-8?B?eFdLa3VOSXhIaVB4dlorN2EwR3UxaUU1UUdTM0lkYldXbCtrS21QNVN6SDBh?=
 =?utf-8?B?Wk83Z0tkNnI2SDVHdW5zUUtOM0xVUlpSTHJrQ0s0d1NOR1NXaDZHOVo5WWRu?=
 =?utf-8?B?NUxnTXRubGdQNUducDF3MldxSjIxY0hoRjNVWlVsc1BaV3FrdmlpRU5kdzFN?=
 =?utf-8?B?akY5bUFIbWNoOVpsb2hZeXB1TTUySWRCUEliN3poWC84YmZhOGF4SzVYVzJC?=
 =?utf-8?B?QlRVSmFXTkROVnN2amJHNGQ1QW5XWXN3UU1CVWM3c0E5R21BU0dzbmUxRHZG?=
 =?utf-8?B?ejB0am1qdml1TDlkZTBrcGxCLzBsRGI3dXZhZ1dMa2Q1S0tnY0xzZVNlSDZj?=
 =?utf-8?B?MC9TOFAwUlpiVk1jckRVaXZLakh4ZGpicUdJeFB0cXAzUlp2cFVuWlhpQ2xH?=
 =?utf-8?B?UkdJbGN5aDZXSit1S2x3NnA3amVXTTRvYWdrZUpUVnloS0ZHcGxoT0FlVE1M?=
 =?utf-8?B?eUp1d0d1dmNuSnpNOUVsaHRSbmI1WGpkalpGYjEwL1BOSTZ2Rkx6clZQeDRB?=
 =?utf-8?B?U0NEL2pTOHl4aXFiVm10V1dPd0VvTytjZ1NVTzcvaDF1UGV2T3BZSUtGMlM5?=
 =?utf-8?B?UUZzNzN0dzU4TWVMUGYzc3N2MG85My9mTy8xeWxsYzhKeG5yQ3hqcFJhMzFv?=
 =?utf-8?B?ZWRlYU5xSDdTUDRxS1hXTGc3YmZuemcxK3ErTE5UaVhid0RRbGEvWk9oNXNz?=
 =?utf-8?B?Yk5aNWEzL0t3YXZRcW9Zekp4RUZoVXp4ZTFjRDlXU2kwWUdHMGp1NXU5cDJM?=
 =?utf-8?B?RnR2T2VTbExkRmZnclZqTnZnbjhCWWtleTlLVDRzV1FJdU9za2duR3llOHFw?=
 =?utf-8?B?eCthUG5aUXhjcXg1QStXY01FSHFWMTBHWXZTSWdMSzB6RzViTWp1eEw3TTBl?=
 =?utf-8?B?ZnhZUDZvemlnbVFTK1JvdnJQYk94eVBSczdUeHRBV2ZOaUgzZHJxcDI1Qjgy?=
 =?utf-8?B?SW5NYkU0VXNIVUVUMFMrWlBWY1dXb1F4cGM3RG45Tmg0RWVHcGpxZU1EdEw3?=
 =?utf-8?B?ZjhNNU94SnNSdEMzNit4dEh2STNYOS93cmR4b0xWblZUamoydGNmVFdNb2V5?=
 =?utf-8?B?SWpBNmlBa0pJSmVtR2FTaDR1SFZjeXdlaUNta2h4ZTV2VnlsL0ZPL05yaXFF?=
 =?utf-8?B?YXNaQW91cVBRMHNFaW9PRWtRTDRhYi81VDQ4OUEvdXFZY3VHNGMyQW5rUTZ5?=
 =?utf-8?B?QmxuT1VaeitVanRRaGROTktTbm1mY1FOWS9RL01QNzRnVDBaRTF5VEFHQUR2?=
 =?utf-8?B?R3J1UWd1SEZUZTRiQmdFbDh5Qno4WjVsdjl6ZWk1dFFqMHJ0dXZNRGtvYldE?=
 =?utf-8?B?aXQwZSsrV1BKQWNQcWhSRjFjc1ppMTlmNDJuY0NBSFA0RkZEcGxIV3pPSUVI?=
 =?utf-8?B?L1NmMlNuWm9UYnhiNnBpYU15L3VQUWNtWVVrSzJLQWdadHloUVRqK2JtWmFv?=
 =?utf-8?B?eTh0L204ak9lQXh1Q1hKYW43WjBnL2dlUnFzUmJsQk9jUWxXcGUvTFkyc0Fm?=
 =?utf-8?B?NEZUa09VTTNOSmh6czM1TUVlaUthRG9IbkNjUEFnZmFyQjNIOUVVb2R3Tm1x?=
 =?utf-8?B?Z0FseFBtQXozT3NYRFNvY05mYk4xTFlvbDhxVDJ6VE84V1U4dld3Tlc4NDNM?=
 =?utf-8?B?bEtiNCtaWGpQQWZNOHBFVDBGaDFnUmFlL3FNcWdZSEI5ZlZ2Tk4vSlZOL3Vq?=
 =?utf-8?B?K2RSb0lVSE1PTXV5d0xQeStZcDgvZXRwdSsyNW95MVhxNjY2SE9aNXl4YU8w?=
 =?utf-8?B?ZHpSK2QwcHhIVGErS2tuK1NDQk9sc3AyclpCY0xJaU5IMkp3RlRkeWpUelh4?=
 =?utf-8?B?RGdNazFwalFHZ2xtM1QvQ0xDUzFuK3lkNEl6bloybmRiQTJGY3BwRm9ndG5v?=
 =?utf-8?B?U2oyTUpuY2xHTWs1enBPRGpiK0J5bjYwbWdqWDlOR1kzVnVJNnp2L3p3bTF3?=
 =?utf-8?B?SU1XMDFYUHdhM1JRVWRiclRVV1Q0TzFVa09uTWFrYTVKQldlM1lKYkxYMG9R?=
 =?utf-8?Q?rBHe3R1L4RUd+uyzFFvYA1OcyTmekcFRi1QNqM+rgqKZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09562387-11b0-497b-6240-08db63ba1ca6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:38:40.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTc6w/9DmLc7lVBmKgx4i3tf9b/yAOFB6D7L7AIkOSXiGtTGjt/HLXUC+Xd8qX0aeqSQmNU58g4t4hoy1lSWmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/2/2023 5:20 PM, Bjorn Helgaas wrote:
> Hi Mario,
>
> The patch itself looks fine, but since I don't have all the power
> management details in my head, it would help me a lot to make the
> description more concrete.
OK, please let me know if after reviewing my responses you
would prefer me to take an attempt at rewriting the commit
message or if you can handle changing it.
>
> On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
>> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
>> that xHCI device is connected to a USB-C port for an AMD USB4 router.
> It sounds like the real issue is that "Root Ports in D3hot/D3cold may
> not support wakeup", and the USB, xHCI, USB-C, AMD USB4 router bits
> are probably not really relevant.  And hopefully even the "AMD
> platforms" mentioned below is not relevant.
Yeah.  It comes down to how much you want in the commit
about how we got to this conclusion versus a generic
fix.  I generally like to be verbose about a specific case
something fixes so that when distros decide what to pull
in to their older maintenance kernels they can understand
what's important.
>> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> all PCIe ports go into D3 during s2idle.
>>
>> When specific root ports are put into D3 over s2idle on some AMD platforms
>> it is not possible for the platform to properly identify wakeup sources.
>> This happens whether the root port goes into D3hot or D3cold.
> Can we connect this to a spec so it's not just the empirical "some AMD
> platforms work like X" observation?
>
> "s2idle" is meaningful on the power management side of the house, but
> it doesn't appear in PCI or ACPI specs, so I don't know what it means
> here.  I assume the D3hot/D3cold state of the Root Port is the
> critical factor, regardless of how it got there.

Unfortunately (?) for this particular issue it's only a
critical factor when the system is in s2idle.

PME works fine to wake up the device if the root port is
in either D3hot or D3cold when the system isn't in s2idle.

>
>> Comparing registers between Linux and Windows 11 this behavior to put
>> these specific root ports into D3 at suspend is unique to Linux. On an
>> affected system Windows does not put those specific root ports into D3
>> over Modern Standby.
>>
>> Windows avoids putting Root Ports that are not power manageable (e.g do
>> not have platform firmware support) into low power states.
> The Windows behavior was probably useful to you in debugging, but I
> don't really care about these Windows details because I don't think
> they help us maintain this in the future.
OK.
>> Linux shouldn't assume root ports support D3 just because they're on a
>> machine newer than 2015, the ports should also be deemed power manageable.
>> Add an extra check explicitly for root ports to ensure D3 isn't selected
>> for them if they are not power-manageable through platform firmware.
> But I *would* like to know specifically what "power manageable" means
> here.  I might naively assume that a device with the PCI Power
> Management Capability is "power manageable", and that if PME_Support
> includes D3hot and D3cold, we're good to go.  But obviously it's more
> complicated than that, and I'd like to cite the spec that mentions the
> actual things we need here.
Power manageable through platform firmware means the device
has ACPI methods like like _PR0, _PS0.
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4->v5:
>>   * Add tags
>>   * Fix title
>>   * Adjust commit message
>> v3->v4:
>>   * Move after refactor
>> ---
>>   drivers/pci/pci.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d1fa040bcea7..d293db963327 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   	if (dmi_check_system(bridge_d3_blacklist))
>>   		return false;
>>   
>> +	/*
>> +	 * It's not safe to put root ports that don't support power
>> +	 * management into D3.
> I assume "it's not safe" really means "Root Ports in D3hot/D3cold may
> not be able to signal PME interrupts unless ... <mumble> platform
> firmware <mumble> e.g., ACPI method <mumble> ..."
>
> Can we include some of those hints here?

I'm cautious about hardcoding logic used by
acpi_bus_get_power_flags() in a comment in case it changes.

How about:

"Root ports in D3 may not be able to reliably signal wakeup
events unless platform firmware signals power management
capabilities".

>
>> +	 */
>> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    !platform_pci_power_manageable(bridge))
>> +		return false;
>> +
>>   	/*
>>   	 * It should be safe to put PCIe ports from 2015 or newer
>>   	 * to D3.
>> -- 
>> 2.34.1
>>
