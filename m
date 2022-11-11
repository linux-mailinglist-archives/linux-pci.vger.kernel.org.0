Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED86261B7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 19:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiKKS6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 13:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKS6i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 13:58:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93184E407;
        Fri, 11 Nov 2022 10:58:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmUDkLxTnwjEFpwNgwuFJBuxEBSDDcrleXkr3l2N6eK6l4Y86KIbJ4M2Ybm6Ne6Z8QTZng91GxfJ3++mK6qd9aUQ0HC5PRtw8TX20wEGsmbZKVUac+GU2bbkhlJ+5oxQSmqJ4+sB4RPrzLLKlv+SUaa2oUR+J0AiKTIdFeI8NRO9L0Or6LirQyQrXqqxCnsLyKZaXxA10w7q7vuncAQGPoF5+lgPd5QlPdYiGWQ+BoUbOG7AUA/vXfE7ciNZbAdAz1g/xYLjyQhOaQ5E06r8cD9JHMmPkOuYFYFJSCKzh72CeXlKQyr81RKX5OlEZt5Qt0h2Ygti8biLmN32VaGX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcGy1BZEGS6Wln3A9XUNFDCiJoWj2Rei4HJ0hOBHk7k=;
 b=YxcY/redmTFrhMj+tRDsYPBK3zM1tDOH1FtySNEuR9YkpTMi0FcAb1ymQysh69toe0IBwtEFERTQX/yAVn1Q9irWbrMdW74vEqhX8tmnan1AGrEXcfQW4+90xHUL0kTHoBG4hjwx/3fJjp+17Qal6ipxl0MPf/ifvQm4EaRoVIEpAYKfwJyvFiLNhs+2mdCxO4qRAmQTk78/Sw9Mm/uz4ROXorXzjUjMmIFXFM3z0ckifyuBtVfU6oub+g5EBQrX3K1yRBfrp1IY8kZFFZ8EwZteb1kDNcItptUZh8kjCBlSo04JLJZKd1ZqIViR48nEr8CKh7Qflw/iXd4rfYuk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcGy1BZEGS6Wln3A9XUNFDCiJoWj2Rei4HJ0hOBHk7k=;
 b=AbI4zZXzG8/uCRqL2TE9f9UkMz8yrPLxWp/JtyxGO4e484x9fN4axMjLFgvfydX7BO1HwhXf6cse/q4LSpegdt/sTb1A7ai3KSc/0zU670VZKldqyh09vBRqSSpIcdV29QypKifKrfeqg1nihAYFV8AF7+1DyD2+s8yP9HhPdwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 18:58:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 18:58:31 +0000
Message-ID: <5754039e-e3c6-cdb8-8d64-6332b0093940@amd.com>
Date:   Fri, 11 Nov 2022 12:58:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221111174101.GA729137@bhelgaas>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221111174101.GA729137@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bf8e95-187b-415c-6103-08dac416b9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0Miwev0Q6mPwLSax4wVbLvtW4Xfjnl6UdkTQZ/noj/XwbHLd9DlUzKzsIAizKhhpFrPm3hWIbiBkSeCAyIfmzM3Vn3db2TMDXIO4y2ipYE3jtqGTy7rNX8A+/zaMtTvK/RSZ0gRSAfs/3EvBpT+ID7txGkkGIfy0oZtoFQ4XCXG0ESysyxANYNXDaPER7N4ueZvsNi5ZrqPN+ii0NzO2mUfIpJQWM3J7/fnqObRcBm6e+0fSfCLS34BxA3rG3uEJ7nHkAQXHg5/FbQ+edOW5y7PJzAxHRAIxtStdXSS2qbcB8l18JQBgIMnM90uEvR/bx+T73L77CRqRBKuqqB67H42tvK+5tJywF9L5mfmPScMgGwxoiN6uOKnP6scd7mI2jCKAn6KEr2LNPavK5qmOLtQVhpXwE0kx12iFiHDsptF31heexUdZZei9NqsDAKL/asjDDXeK2GeRt1thCSUCQrygY0HaWCDAIYhLE+XJP41gJxfBthbxX7krcdKLTNMF+A8qniNQKf8c26m0gNIKTzrlacDxLFNc60qkROCzAXZOKpv6/0FWRqMXj/Cfcp25+miv2WE7mv9j3kqlF52hxYk3s7CEdHGljPqBHWg8npy38uJRDZCC24aikapmkVYEiVdSfx8S5sNFUx6uSmttepMZt7HrMMZWHj+tvO3A4mOXhN374+lv+9SvplrziY9gp4fuXcvI46lTek79BrlpvDUpEL4T7ahWvtrHVS7EoEqYp9aRTQmdDuBTAEwD/TE2phrSJmxRClb1YkCKZs1NbIYq/ySV6Hv4DN1//rp+Tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(316002)(66574015)(2616005)(186003)(66556008)(66476007)(66946007)(6512007)(26005)(6916009)(6666004)(6506007)(53546011)(478600001)(15650500001)(2906002)(6486002)(86362001)(8676002)(31696002)(4326008)(41300700001)(36756003)(19627235002)(38100700002)(5660300002)(7416002)(31686004)(8936002)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHNuZTdaa0t3R1BzbzlIb09hUGtTWE9hZDBXdGsxbWppNVJZVEJPS3RjN3ZP?=
 =?utf-8?B?bEkxVFdRZ0FzQ2lBdzk0TElSM09VRWdQbFVPOXh4NHFqMDQ0RTF3Wi9nRWNO?=
 =?utf-8?B?N1pBdjkrbS9Oc24yRktBaEdSbnFzUUhFQ0psYmF5N2ZZY2Zxd2JBS2lIdU9o?=
 =?utf-8?B?VitrdkJsZ0p0RGRaN20rNTJqekxVT2pYNjViVHBXend3RlFZbjdwRmRJUXor?=
 =?utf-8?B?ZFNHbGM4MnpVQ2tsVXEzakRJa1NKSVJpMnpTQkN4OVhRN3BHOG9Hd2ptZm5D?=
 =?utf-8?B?UHFRVTdkd3Y5bXFUV1FMQUNKYy85Sktxc0ozRTdKME9WcGtpS0lDV0FIcGxa?=
 =?utf-8?B?WjRFTDY4a0JwcWpUcHJoMEdNWDBJSXE3clZpQUVaRCs5OHBLQzBIMmVPRDlp?=
 =?utf-8?B?TVdna3V6Z2s3QXRvSUhDMEVNRit6SFg1VERYWnMycTdMZ29CaXlsbkFNblZE?=
 =?utf-8?B?azArK2ZIRmVnbExOUG5SeU8wd3RTY052Y0V5MW9DL0QyeTBwSkVDYVhWRERC?=
 =?utf-8?B?RU96UncvUzJxK0RPMGczbTZESGN1bFN4endDWXFqZzlWTFB5alpUWTA2bngv?=
 =?utf-8?B?ZDA1N1haZ3BMMDMwTFJsR2FaRGg4T1lwRHR5U3JHVlR3c1VkYUoyYXhqR0xR?=
 =?utf-8?B?dk4vTVBCZTVDMG1XWUl1TzlVRVM1TU9tMkl3dS9PdXBLTFQxQXFaMHVYSE84?=
 =?utf-8?B?NlBpTTR1eU9aSUhFTVVIVWVObFpxRlRXM3duRkdvNG1VcndVUWtnWlZmcXZl?=
 =?utf-8?B?WlNLdkdoR3lqcUFlTlFqVHJtdjZ4VnRGSkVZVXFDWW1pUlpCMVdaMFVaclo3?=
 =?utf-8?B?UXJsZzFZRHMrN0JWREpWd0hId1E2TUwyRUJSNUhYOWwwU2hOWVdRRW9NM0dJ?=
 =?utf-8?B?TStURWVzMXdWTmxPUk0vSCs1cTZRcnhNb1JWQ2g0QVhjNG1XU0U1QnNPeE41?=
 =?utf-8?B?dVlNUXl5UHZKWWZnQ0JRd09UTldnclNLQ0pWZXUySTQxOWJJRDJZcFV5Q24w?=
 =?utf-8?B?WVh1SnROWnpibjNnWFFTbjQ5RFEyZFU0Y2t1NGhLTDB2cFFYeDkvZkUxWjB4?=
 =?utf-8?B?azczZVBnY3lEb0JWYzljRUJiVXhWR0pDcGduOHBrZThNbFI3SDNmWnVPVnd6?=
 =?utf-8?B?WnFhS2hFUXdTcWdoSng3azFzL3NFa0ZRUU0wMWpwQnNnY1M2OGNBVUFBeGNo?=
 =?utf-8?B?QnNBbFNDQmNOdUM3UzZxVnFyWTJDVjZzb2toUFpwNEsvUDI0dzhKMEt0WXEz?=
 =?utf-8?B?Sk42elZxS1ZyL3R2bGNtSFI1TFZhT1NoQSt3dFlteHM0a3U3cHl1QnZsT3Zp?=
 =?utf-8?B?TjMwbXJHTXVjMzF3c2dvRGVZV0tWaGFTVTk2WEVZQVc5cmxQUXZmbU0wOXRq?=
 =?utf-8?B?R2hFRUJsTDVSNTZEU3ZZNWNBemNvNzNUVzhQN1R1ZmZrUTloWTlLUmE1bUEr?=
 =?utf-8?B?T3ZOd09xRFVhTzVMS3hhRElHY3NUTE41LyszVXFPWFlTMndKTS8vLzZRZ1VO?=
 =?utf-8?B?b2pVL0xkMFhvMVVFVTg4NjRXbW9xcUU0bkNZWk1kVTF5Qy9tVlQzUGcxd0pS?=
 =?utf-8?B?OHFrbFVHdkhOVUZvaDZ0d3dTaHRMMnNHR0Nud08xUnpwWTBXTXZRYkNNVVdw?=
 =?utf-8?B?R1hzdE8yODBRYTBHQnJoSHZCMFkwSEIxcm1pYXk1TERMdlFSVVFNZTAweXdG?=
 =?utf-8?B?aVlTTlM3cmFkYWlqd1l2aHNMcVVFT09sWWFGODFEVWVMUmIvYlVhRGRxK0N3?=
 =?utf-8?B?STdLQjR3Z24wNjc0aEhBbzh6UUpzOUl2c3NsZXlYRXNabW43NzBhUWJMYmRR?=
 =?utf-8?B?VkNSeEl2Rm85N2N1VUVGQTVxanFZS2tYZHprZ2Y1WEFqWktPVGcwNnRLMkl6?=
 =?utf-8?B?eVgzOHZOTVYxM0pGbVFwRy9MMVkxdjQyVDBwQlUwdStmM0swTkpLdVNwajVM?=
 =?utf-8?B?ZWI3QkE2a2U3bTdrcDRTUVYwbllzTHRhcG5Zejl5c3V5Qi9iUVcxTjc3Ynda?=
 =?utf-8?B?QzJiK2FhV2dMb291aC9kdjZYcXJGOEJwTEhQcjB2U3I2RUswMnRNUUdibFFn?=
 =?utf-8?B?L0F1anNDK29QaXdQc25MWkdWMlYvUWp5Ykk0RjdCb0ZrQU41cUEwcGdOTDdQ?=
 =?utf-8?Q?C1jaE0PcQRH7Q8foRYGProhTq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bf8e95-187b-415c-6103-08dac416b9f3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 18:58:31.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3qNSqYQ6gRw3mGCN4jIJINKOW25WsvhPQ1uhMtF2aX3fDm6fosH9xQqNasaKm1KIDT5fqdooxg+1bR8uCzWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/11/2022 11:41, Bjorn Helgaas wrote:
> On Mon, Oct 31, 2022 at 05:33:55PM -0500, Mario Limonciello wrote:
>> Firmware typically advertises that ACPI devices that represent PCIe
>> devices can support D3 by a combination of the value returned by
>> _S0W as well as the HotPlugSupportInD3 _DSD [1].
>>
>> `acpi_pci_bridge_d3` looks for this combination but also contains
>> an assumption that if an ACPI device contains power resources the PCIe
>> device it's associated with can support D3.  This was introduced
>> from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
>> D3 if power managed by ACPI").
>>
>> Some firmware configurations for "AMD Pink Sardine" do not support
>> wake from D3 in _S0W for the ACPI device representing the PCIe root
>> port used for tunneling. The PCIe device will still be opted into
>> runtime PM in the kernel [2] because of the logic within
>> `acpi_pci_bridge_d3`. This currently happens because the ACPI
>> device contains power resources.
>>
>> When the thunderbolt driver is loaded two device links are created:
>> * USB4 router <- PCIe root port for tunneling
>> * USB4 router <- XHCI PCIe device
>>
>> These device links are created because the ACPI devices declare the
>> `usb4-host-interface` _DSD [3]. For both links the USB4 router is the
>> supplier and these other devices are the consumers.
>> Here is a demonstration of this topology that occurs:
>>
>> |
>> ├─ 00:03.1
>> |       | "PCIe root port used for tunneling"
>> |       | ACPI Path: \_SB_.PCI0.GP11
>> |       | ACPI Power Resources: Yes
> 
> I guess this means it has _PR0 and/or _PS0?  (same for devices below)

Yeah.

> 
>> |       | ACPI _S0W return value: 0
>> |       | Device Links: supplier:pci:0000:c4:00.5
>> |       └─ PCIe Power state: D0
> 
> What bus does 00:03.1 lead to?  I guess it doesn't lead to any of the
> devices below?

By default - nothing.  The topology was drawn correctly.

When you plug in a USB4 device with PCIe the newly enumerated devices 
hang off this bus.

> 
>> └─ 00:08.3
>>          | ACPI Path: \_SB_.PCI0.GP19
>>          ├─ PCIe Power state: D0
> 
> I guess 00:08.3 is a Root Port leading to bus c4?
> 

Right.

>>          ├─ c4:00.3
>>          |       | "XHCI PCIe device used for tunneling"
>>          |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
>>          |       | ACPI Power Resources: Yes
>>          |       | ACPI _S0W return value: 4
>>          |       | Device Links: supplier:pci:0000:c4:00.5
>>          |       └─ PCIe Power state: D3cold
>>          └─ c4:00.5
>>                  | "USB4 Router"
>>                  | ACPI Path: \_SB_.PCI0.GP19.NHI0
>>                  | ACPI Power Resources: Yes
>>                  | ACPI _S0W return value: 4
>>                  | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
>>                  └─ PCIe Power state: D3cold
> 
> I'm reading the excellent Documentation/driver-api/device_link.rst and
> trying to match up with this topology.  This is a case where 00:03.1
> is a consumer of c4:00.5.  The driver core automatically enforces that
> children are suspended before parents, but since 00:03.1 is an aunt
> (not a child) of c4:00.5, the device link enforces the requirement
> that 00:03.1 be suspended before c4:00.5.  Right?

Yup!

> 
> Is c4:00.5 an NHI?

Yes.

> 
> The PCI power states shown above are the failure case?  c4:00.5
> *should* remain in D0 as long as 00:03.1 is in D0, but was instead put
> in D3cold?

Yes.

> 
>> Currently runtime PM is allowed for all of these devices.
> 
> This is because they all have _PR0 and/or _PS0?  (Diagram doesn't show
> that for 00:08.3, but I assume it must?)

For the root port used for tunneling it's because 
pci_bridge_d3_possible() returns TRUE.
This returns true because platform_pci_bridge(d3) return TRUE.

For the NHI it's because thunderbolt.ko sets this for all NHIs (see 
drivers/thunderbolt/nhi.c).

> 
> And I guess they all must have dev->is_hotplug_bridge set?

The PCIe root port for tunneling does; yes.

> 
>> This means that
>> when all consumers are idle long enough, they will runtime suspend to
>> enter their deepest allowed sleep state. Once all consumers are in their
>> deepest allowed sleep state the suppliers will enter the deepest sleep
>> state as well.
>>
>> * The PCIe root port for tunneling doesn't support waking from D3hot or
>>    D3cold so although runtime suspended it stays in D0.
>> * The XHCI PCIe device supports wakeup from D3cold so it runtime suspends
>>    to D3cold.
>> * Both consumers are in their deepest state and the USB4 router supports
>>    wakeup from D3cold, so it runtime suspends into this state.
>>
>> At least for AMD's case the hardware designer's expectation is the USB4
>> router should have also remained in D0 since the PCIe root port for
>> tunneling remained in D0 and a device link exists between the two devices.
>> The current Linux behavior is undefined.
> 
> Is the requirement that the supplier can never be in a lower-power
> state than the consumer?
> 
> I guess that's *not* actually a requirement even though that's the
> effect of this patch in this situation.  If it *were* that simple, we
> would just check the supplier and consumer power states instead of
> looking at all these ACPI properties.

Yeah I think that's too broad of a generalization.

I don't know how realistic this is but for example what if the supplier 
supported D3 but the consumer supported D2?

> 
>> Instead of making the assertion that the device can support D3 (and thus
>> runtime PM) solely from the presence of ACPI power resources, move the check
>> to later on in the function, which will have validated that the ACPI device
>> supports wake from D3hot or D3cold.
>>
>> This fix prevents the USB4 router being put into D3 when the firmware
>> says that ACPI device representing the PCIe root port for tunneling can't
>> handle it while still allowing ACPI devices that don't have the
>> HotplugSupportInD3 _DSD to also enter D3 if they have power resources that
>> can wake from D3.
> 
> So I guess this changes what acpi_pci_bridge_d3() returns for 00:03.1?
> Previously it returned "true" because it has _PR0/_PS0 (so
> acpi_pci_power_manageable() is true), but now it will return "false"
> because _S0W says it can only wake from D0?
> 

Exactly.

