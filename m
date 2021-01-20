Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3664A2FD585
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391413AbhATQWx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 11:22:53 -0500
Received: from foss.arm.com ([217.140.110.172]:42470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403839AbhATQUw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 11:20:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9822731B;
        Wed, 20 Jan 2021 08:20:06 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC27D3F68F;
        Wed, 20 Jan 2021 08:20:04 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20210118091739.247040-1-xxm@rock-chips.com>
 <c9ff67c7-ca1d-d4a6-aef5-4c75688ed6d3@arm.com>
 <CAL_JsqK=roMm7vb=WAcLUsiru5qwFg=Sc_po1gD8oJu=JipZbg@mail.gmail.com>
 <3792680.3daJWjYHZt@diego>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0f83d344-c257-a576-ed38-8f9299047f73@arm.com>
Date:   Wed, 20 Jan 2021 16:20:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3792680.3daJWjYHZt@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-01-20 14:54, Heiko Stübner wrote:
> Am Mittwoch, 20. Januar 2021, 15:16:25 CET schrieb Rob Herring:
>> On Tue, Jan 19, 2021 at 12:40 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 2021-01-19 15:11, Johan Jonker wrote:
>>>> Hi Simon, Heiko,
>>>>
>>>> On 1/19/21 2:14 PM, Heiko Stübner wrote:
>>>>> Hi Johan,
>>>>>
>>>>> Am Dienstag, 19. Januar 2021, 14:07:41 CET schrieb Johan Jonker:
>>>>>> Hi Simon,
>>>>>>
>>>>>> Thank you for this patch for rk3568 pcie.
>>>>>>
>>>>>> Include the Rockchip device tree maintainer and all other people/lists
>>>>>> to the CC list.
>>>>>>
>>>>>> ./scripts/checkpatch.pl --strict <patch1> <patch2>
>>>>>>
>>>>>>    ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
>>>>>> --nogit <patch1> <patch2>
>>>>>>
>>>>>> git send-email --suppress-cc all --dry-run --annotate --to
>>>>>> heiko@sntech.de --cc <..> <patch1> <patch2>
>>>>>>
>>>>>> This SoC has no support in mainline linux kernel yet.
>>>>>> In all the following yaml documents for rk3568 we need headers with
>>>>>> defines for clocks and power domains, etc.
>>>>>>
>>>>>> For example:
>>>>>> #include <dt-bindings/clock/rk3568-cru.h>
>>>>>> #include <dt-bindings/power/rk3568-power.h>
>>>>>>
>>>>>> Could Rockchip submit first clocks and power drivers entries and a basic
>>>>>> rk3568.dtsi + evb dts?
>>>>>> Include a patch to this serie with 3 pcie nodes added to rk3568.dtsi.
>>>>>>
>>>>>> A dtbs_check only works with a complete dtsi and evb dts.
>>>>>>
>>>>>> make ARCH=arm64 dtbs_check
>>>>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>>>>>
>>>>>> On 1/18/21 10:17 AM, Simon Xue wrote:
>>>>>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>>>>>>> ---
>>>>>>>    .../bindings/pci/rockchip-dw-pcie.yaml        | 101 ++++++++++++++++++
>>>>>>>    1 file changed, 101 insertions(+)
>>>>>>>    create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..fa664cfffb29
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>>>>>> @@ -0,0 +1,101 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
>>>>>>> +
>>>>>>
>>>>>>> +maintainers:
>>>>>>> +  - Shawn Lin <shawn.lin@rock-chips.com>
>>>>>>> +  - Simon Xue <xxm@rock-chips.com>
>>>>>>
>>>>>> maintainers:
>>>>>>     - Heiko Stuebner <heiko@sntech.de>
>>>>>>
>>>>>> Add only people with maintainer rights.
>>>>>
>>>>> I'd disagree on this ;-)
>>>>
>>>> All roads leads to Heiko... ;)
>>>>
>>>> It takes long term commitment.
>>>> Year in, year out.
>>>> Keeping yourself up to date with the latest pcei development.
>>>> Communicate in English.
>>>> Be able to submit patches without errors... ;)
>>>> Review other peoples patches.
>>>> Respond in short time.
>>>> Bug fixing.
>>>
>>> Crikey, it's only a DT binding... :/
>>>
>>>> If that's what you really want, then you must include a patch to this
>>>> serie for MAINTAINERS.
>>>
>>> I think if Bjorn and Lorenzo want a specifically named sub-maintainer
>>> for the driver itself, we can let them say so rather than presume.
>>
>> For the binding it's my call. :)
>>
>> This should be someone who cares and knows the h/w. IOW, if I want to
>> delete the binding, someone who will object.
>>
>> Of course, I'd like that someone to have all the above qualities too.
> 
> I guess that would be separate entites then ...

Yup, that's the point I was trying to clarify - binding maintainer and 
driver maintainer are technically distinct roles. Of course if someone 
is a driver maintainer then it's usual - and preferable - for them to 
maintain the relevant bindings as well, so MAINTAINERS entries for 
drivers typically also cover those for convenience and pre-schema 
historical reasons. However, someone can take responsibility for a 
binding without signing up to explicitly maintain a corresponding driver 
(I know I have), and in that case the schema makes the binding 
self-documenting already - we don't have MAINTAINERS entries that *only* 
cover bindings, other than the top-level one that says Rob's in charge 
overall :)

Robin.

> Shawn and Simon know the hardware way better, though I'm not sure if their
> work commitments will allow them to keep track of binding deletions
> 
> So maybe all 3 of us ;-)
> 
> Heiko
> 
> 
