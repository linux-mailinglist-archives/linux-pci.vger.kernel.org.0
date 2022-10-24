Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628DE60AF4B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJXPlK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 11:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiJXPkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 11:40:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECAEF6C03;
        Mon, 24 Oct 2022 07:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBQCqELD2rnbDXOY11hnJ6aT+dt7+WvRTrdl0oJAoSLC0wsqZtZtHLX6Hm9P3z2uY8yziEHe6k4WoUyDzCJrvybWG592QxWPIASC6FqtEWqshVeFGGF0zffrrICYZ1IiFHQqmp/6saXwN2LP0n6va93tzAekUC5siK4u5+za1ipl1VjmG/KbkLm9zpJDOJPEKKvK4hqBAW3sujmk+w2JAjpB/VEVj54oXbkFeoRCDHu6fGJkKnonr/pw6/kRqwGPgi7ayNzUDeyZuZTwu3aEAx/utfdvjV3sJkbJ/Ss/6QOxoQaQM3qczGG0ACox258ktDxgfcuEys29o+aNuT5Jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDCKlHDXQDQXkPbeF1IjeQN92m9QY+YM1Eu+f8pdecI=;
 b=EGlsP7D3L8ihlOEyoCQCPRDQsFbAhLc1Z3U8SW8ji6oK+WLawq3C1UUflbXtRPlmK5Z0GcJJGbRAXrfKXeaoSZcP3cZ182uQj63abTdryTlkH5kSNR9eAhYlE2uGwzQupE1ScRdRDWwsBnrhzTAD9qTKqtXZKqOT+Pq5kUOt6NtFZenW8QX7vSyA1quLfqyIhBTof8+X8y5cI5I9rGD5VaxmdjlCCin+QgBS8oEYoGQ0wTKBkxy0h91GPzmypilQGpm4PHvTP4itjsia1t7K8xqDMEWe/kNxQb+QnSMM2cWb3bFgRh/0VVW53rAm6cO2W57nxTtC5hrnZzT9iPrBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDCKlHDXQDQXkPbeF1IjeQN92m9QY+YM1Eu+f8pdecI=;
 b=QlbnkolpHpQYqPNeS4BlUjBoNAaTnjVbJYH90Pzx54zNgYke+dt0QCR61t10hdbrSfBWJ13YeMfZsBpGV536aY6EWxRRTgd9oy8xPZMHBzjMrWfsojSwXhu4DzL6kmilDa7ctF1lziWMi6/kVBLbetqDZ0oB8O5zWnOl2MEqSLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 24 Oct
 2022 14:26:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 14:26:33 +0000
Message-ID: <6f436279-4654-63ee-91e8-f58dcadd148c@amd.com>
Date:   Mon, 24 Oct 2022 09:26:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] PCI/ACPI: Don't assume D3 support if a device is power
 manageable
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
References: <20221022172005.GA456826@bhelgaas>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20221022172005.GA456826@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0048.namprd05.prod.outlook.com
 (2603:10b6:803:41::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 682283ba-795e-448e-893a-08dab5cbbffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKMASZ65G8s5vjTrFnteK9I1yhBacKrX4ba3RmBS+ick2tya0FPLHP3d8eGazIh118VnyHV9RLX+S2z4iVItTAZmekXxTeve5zyXAbELaAyPA37GrGSi5JOLjOPS/OhjLUkRZogzFJxDSd9WFPk/p3dzpggWl13l1fm3LNXdKjO68wunR950mCqvYWsKZYoB7nsFaPVupizTNgP/DCinm4WXKVUoy0FSo+acEuPmpi/TasODFJ93vqgZErQrj54dd5VxOh9zAxOHHexwL1q0Cb72PUP+4mHVi66afCLmmmCtV4F9dN9kSwmsR4b7/zokFZTwh5SA6teJCJYD8rlVK/wwq7K6Pr9rk5Xwwe8dHrHduvXItMV80jOpI1QlUXm0N4bzulpilsqxTPaT9E5N7ENuCPjv6480dwZeFI1SC5D3NrF0glxi2RX3fuG3P67aHLeOoFZm5hZsQLO+Cy6CrX/f2T346rIpFJyVgZ1Cb2h5wH8740LuWZvqxExaQd5jVURCOPbctUyRH7lYAZuB1LTDEHZtMNpS9mnzOHpKD/B5DlcjJpxRp8jkigScgr48oGaz3RVbnS+GmRE8qnRR1y9nq9u/pXufA/ASSdEQvXaITNfp7dqR202JN5nN5OXoq+kUPHdOpqNnTS8KnSYrp0VxL7ZimrnocHLK1kM2h21TxmsMF/BTJIPAJEcqJq3cncPQu2fzkPtzBxQTE6NvZYNXqBvUknhHQmn9eLVqKUF1ZA2iQbt5qL+Mdu5c/weigfKKob9nOgN/ChCdAo8Fd/r3t8wh2RpQI9dwPIwfYU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(31686004)(36756003)(66556008)(186003)(41300700001)(83380400001)(38100700002)(66476007)(31696002)(478600001)(54906003)(5660300002)(2616005)(6486002)(6506007)(53546011)(6916009)(66574015)(2906002)(316002)(8936002)(44832011)(8676002)(66946007)(6512007)(4326008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2kvcmVZamcrdlZXRjdjajFObkVtTnB6VG5NSytmZGI3YmdzYnI5MHF5Z1ZB?=
 =?utf-8?B?Z0dVWVdscE93QWd6VDVLcEpSYWo0K2tHZWxodjVHTEwzT3MyS0dFdmVxakpK?=
 =?utf-8?B?TXFTZkpUcWUzU2gyVHZITG5reFZXekhJYlhGbjJ4dUJscEdYTkxDZC9qZ0kx?=
 =?utf-8?B?Q1k5SXM1R0tidmUwNTdJTzd6VkdZWUJzWkJqSEZvU3dicTBJQW91TFROKy9B?=
 =?utf-8?B?Mmhkb2VqK1V0Yk90cUtMaytYc2x5UmtMM0Z5NjkwZmdSWG9FNGc3dVZFZWYw?=
 =?utf-8?B?VVpRNTY1b25RcXlEZjQ5dGF4NGNaL1dneTB3enNabGphMXlraGFzUjlYZ1Zz?=
 =?utf-8?B?UzU0NzNpSkVrMlYyZU1obWpjY05ONVJQT3dZTnZZS2pGN1JoeExmaEl5TU5C?=
 =?utf-8?B?K3NaSHcxcGlycjZRMEVkVS9Ka2pjVk9HWnd1b0wxaW1TeC9SNTI3Qkl1ZFBX?=
 =?utf-8?B?TEZJL1YxTys4cDUvOWdBeFdDOU5oenFUeG9YRWZGeGVUZjEvQk9EbUtWLzBC?=
 =?utf-8?B?Yml4M3UrK1JTaFRGWEVLdCtGQUFQZWhuVnF1MStHUklOQlVFZlpMWDBWSnVG?=
 =?utf-8?B?NWdnVlZXWmJXaUpOSVpJL1dkUElCWkRpV0lmVXNqZXVTRlFYaytTOGE5dUxU?=
 =?utf-8?B?UC8wR1JVSTB5UlV2dHVyNlZEaXpuVFVZT2hwaE1sTVZWZ0Evd0RaS3FQbTBH?=
 =?utf-8?B?bHdwdXZKc1graXhhTDNmK095bG9mSWpGc05kZHFSL3JHRkJDWHhJcHB0Q24x?=
 =?utf-8?B?NmVDU09jTktHTEhJZy81SnNkcXRVNzl4bTlPK1djazIvVlpNWG56M2RFY0RH?=
 =?utf-8?B?WS96VnUvKzFDbW1DSXJLTGZYOGI2ZDNuTitjVUgwUGtqaEtTak9Nci9nQzhY?=
 =?utf-8?B?Y0pXQ2c3REVQelhSM21VL20zNkVkVDVIaEpFU0M2K1F1L2NCRGtTRXlDaEhS?=
 =?utf-8?B?d1BXcWFEM3QxanBxN2hlQ3lGMSsvTzAxdUFNQnlnOHNwTXBNeCtrcEdCZFF3?=
 =?utf-8?B?SU4ycUpTYU5JZFN1aHRKcmxNSUlZaUNEWHNDZS9WeUdnYm5Wd2FuVTI3L3J6?=
 =?utf-8?B?RmVhdnk5YWUzYndMMytacFk3a3BRYUR1ejlsUHZUMDd1bDFBL3FlUytkMVpH?=
 =?utf-8?B?bDVhVjJ3dUhKOGs2VjZVT0R6YmVacXU1TUVQbFRZcGlnaGx6NEJWSk5mYmNR?=
 =?utf-8?B?OVJEY2NsVnRUc2loTjI0OFRBN3VKZVZPY2ViYmJpNkFVc3BHRHhhUVo4d2Nz?=
 =?utf-8?B?R1JWSFVHemlsbE84Z2kycUVyVzN0dmpVU1VUYVc2eXZ6N0Jlc1ZFUEtrRXc4?=
 =?utf-8?B?Z1hac0lCekRENUN6cm5IdXhPQzNxbzdVSDUrQjVqbVEwNURhcmZSbjlnMEhB?=
 =?utf-8?B?VHh4MG80Nk5DOWNzcEljSm5uSW95TXZnL2RseG9LbDl6eHU1cFJjb3ptWUdE?=
 =?utf-8?B?WjRYS1JvZ2Yrcm9JTGhYaUZwVFdFZTZEaTY0dEt2U0R6MjhKWkI2aTV6VmhT?=
 =?utf-8?B?M3FYQjNOUW9LSitVdTdiYlFXT2Fic3REemZvRFpqckgrTFBvYVd4cy92bXlR?=
 =?utf-8?B?STBvQVJ5Q2o2TjM0bHpsODdZU3NnbVpCWWhKcTBCb3JKeWhTWnFVNmxqT0JS?=
 =?utf-8?B?NFI5N2lUY0JLUWlDY2pkdmtmVHV3N0VUZkwwM0RPeEExNkRjeUl2dDdsRitp?=
 =?utf-8?B?UmpVT1Z3bzVtOWRlZmppNlJHM2Zud0ozUGp4cTNRYUwxYTJBaE1meEtsR1hS?=
 =?utf-8?B?Y1c4S2dtOHBORE9LYW9yWHRIaDVzRjBadFlSLzViYTg3dmRvdXU5d09sVzZ2?=
 =?utf-8?B?V0syQWcxcGw2VU9JS1NXRDdrdUMxWi80N0w5Y3c1Vm5FMHNHYUo5Z20zTHh2?=
 =?utf-8?B?QzBtL3NjNkR6a2h0alM0Qkd6RWZGTjJNYVdTU21VdU1GSlVmYTUweTEzSE95?=
 =?utf-8?B?UFMvSWk2TmJ2bEV4NHNnR0tXWk9YanBJVXIyeUFpN3p2eFVCcTh5OEMrVDg3?=
 =?utf-8?B?dGNjYmxKdkpaTWtuZnJmcGxqUFV2RGhiY0JnbFJHTVlaam9xN1dOVllncFcr?=
 =?utf-8?B?NWI5MHpVMG8vNU1CMTRkYVAwN2F5VW5NNTBjSUhUa1MrSG5rWGgwYzhKeDZH?=
 =?utf-8?B?N2R2andVTUtBOVB6QytYUDJMSFVnL0MyaW1aV1ZJY0xzSjZkNGMzajB3MVFL?=
 =?utf-8?Q?0ORp7x8UcctDDhnajtxezUZWB9tjB1P9lWg9OO6+Er9K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682283ba-795e-448e-893a-08dab5cbbffb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 14:26:33.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQhVj8EVqRcutKAHJWtgBncxIm1S8bC2wtsJ/canxeRHVW/Ilul+RjjGh6Wik98w7FsQALOXpIBi7gR5nralVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/22/22 12:20, Bjorn Helgaas wrote:
> [+cc Lukas, in case you have comment on acpi_pci_power_manageable()]
> 
> There's a little bit of cognitive dissonance between the subject and
> the comment line:
> 
>    PCI/ACPI: Don't assume D3 support if a device is power manageable
>    +	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> 
> I suggest tweaking the subject to mention the actual issue here.  It
> looks like it might be something to do with _S0W?
> 

Ah, I changed the patch from when I first wrote the commit message.

When I resubmit I'll change the subject should to:

"PCI/ACPI: Validate devices with power resources support D3"

> On Thu, Oct 20, 2022 at 03:11:11PM -0500, Mario Limonciello wrote:
>> On some firmware configurations where D3 is not supported for
>> "AMD Pink Sardine" the PCIe root port for tunneling will still be
>> opted into runtime PM since `acpi_pci_bridge_d3` returns true.
> 
> This paragraph sounds like it describes where you found the problem,
> but I don't think it helps us understand what the problem *is* or how
> to make sure the patch will work on other systems.
> 
>> This later causes the device link between the USB4 router and the
>> PCIe root port for tunneling to misbehave.  The USB4 router may
>> enter D3 via runtime PM, but the PCIe root port for tunneling
>> remains in D0.  The expectation is the USB4 router should also
>> remain in D0 since the PCIe root port for tunneling remained in D0.
> 
> I'm not very familiar with device links.  How does the link misbehave?
> Is the link doing something wrong, or is it just that we're putting
> one of the devices in the wrong power state?

Depending upon how the link is expressed will determine it's behavior. 
In this case the device link is between the USB4 router and the PCIe 
root port that is used for tunneling where the the PCIe root port for 
tunneling is a consumer.

When all the consumers enter runtime PM the USB4 router will also enter 
runtime PM.

> 
> I assume the USB4 router would be a descendant of the Root Port.
> Generally descendants can be in lower-power states than their parents.
> What expresses the constraint that the router must stay in D0 because
> its parent is in D0?
> 

Actually the topology that the root port used for tunneling and the root 
port for the USB4 router are siblings not parent/child.

The code that creates the link between the two lives in 
drivers/thunderbolt/acpi.c

Here is a small diagram showing it from a system with a dock connected:

├─ 0000:00:03.1
|       | pcieport
|       ├─ D0
|       └─ 0000:03:00.0
|               | pcieport
|               ├─ D0
|               ├─ 0000:04:02.0
|               |       | pcieport
|               |       ├─ D0
|               |       └─ 0000:05:00.0
|               |               | xhci_hcd
|               |               └─ D0
|               └─ 0000:04:04.0
|                       | pcieport
|                       └─ D3hot
├─ 0000:00:04.1
|       | pcieport
|       └─ D3cold
├─ 0000:00:08.3
|       | pcieport
|       ├─ D0
|       ├─ 0000:64:00.0
|       |       | xhci_hcd
|       |       └─ D0
|       ├─ 0000:64:00.3
|       |       | xhci_hcd
|       |       └─ D3cold
|       ├─ 0000:64:00.4
|       |       | xhci_hcd
|       |       └─ D3cold
|       ├─ 0000:64:00.5
|       |       | thunderbolt
|       |       └─ D0
|       └─ 0000:64:00.6
|               | thunderbolt
|               └─ D3cold

0000:00:04.1 and 0000:00:03.1 are PCIe root ports used for tunneling for 
USB4 routers at 0000:64:00.6 and 0000:64:00.5.

>> `acpi_pci_bridge_d3` has a number of checks, but starts out with an
>> assumption that if a device is power manageable introduced from
>> commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if power
>> managed by ACPI") that it will support D3.  This is not a valid
>> assumption, as the PCIe root port for tunneling has power resources
>> but does not support D3hot or D3cold.
> 
> It looks like acpi_pci_power_manageable(dev) means "the device has
> _PS0 or _PR0".  Currently we assume that means we can put dev in D3.
> 
> And I think you're saying that assumption is a little bit too
> aggressive because if _S0W says the device can't wake from D3hot or
> D3cold, we should *not* use D3?

Exactly, it's too aggressive.  This exact firmware configuration when 
brought to Windows will prohibit the PCIe root port for tunneling going 
into D3.

> 
>> Instead of making this assertion from the power resources check
>> immediately, move the check to later on, which will have validated
>> that D3hot or D3cold can actually be reached.
> 
> IIUC the intervening code doesn't check whether D3hot/D3cold can be
> *reached*, but whether the device can *wake* from D3hot/D3cold.

Right; but acpi_pci_bridge_d3 is used to decide whether the device is 
opted into runtime PM.

> 
>> This fixes the USB4 router going into D3 when the firmware says that
>> the PCIe root port for tunneling can't handle it.
> 
> For maintenance purposes, I think it will be helpful to know
> specifically which devices are involved (e.g., the PCI bus/device/fns
> would show the PCI relationship) and how the firmware says the Root
> Port can't handle D3.  I assume this would be _S0W?

Yes, it's _S0W, which is why I have this marked as:

Fixes: dff6139015dc6

It's very similar to that, but in this case power resources are also 
declared.

> 
> Maybe even a pidgin example of the ACPI pieces involved here, e.g.,
> 
>    RP01._PR0
>    RP01._S0W (0x0)    # in S0, can wake from D0 only

Yeah; I think I can amend my diagram above with some of this information.

> 
>> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v1->v2:
>>   * Just return value of acpi_pci_power_manageable
>>   * Remove extra word in commit message
>> ---
>>   drivers/pci/pci-acpi.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index a46fec776ad77..8c6aec50dd471 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>>   		return false;
>>   
>> -	/* Assume D3 support if the bridge is power-manageable by ACPI. */
>> -	if (acpi_pci_power_manageable(dev))
>> -		return true;
>> -
>>   	rpdev = pcie_find_root_port(dev);
>>   	if (!rpdev)
>>   		return false;
>> @@ -1023,7 +1019,8 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	    obj->integer.value == 1)
>>   		return true;
>>   
>> -	return false;
>> +	/* Assume D3 support if the bridge is power-manageable by ACPI. */
>> +	return acpi_pci_power_manageable(dev);
>>   }
>>   
>>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>> -- 
>> 2.34.1
>>

