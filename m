Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF11DE90F
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgEVOec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 10:34:32 -0400
Received: from foss.arm.com ([217.140.110.172]:36650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgEVOec (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 10:34:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AEA0D6E;
        Fri, 22 May 2020 07:34:31 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E7D3F68F;
        Fri, 22 May 2020 07:34:29 -0700 (PDT)
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To:     Rob Herring <robh+dt@kernel.org>,
        Diana Craciun OSS <diana.craciun@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-acpi@vger.kernel.org,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
 <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
 <ee7a5c04-814e-215f-ec74-52c2f3b881d0@oss.nxp.com>
 <CAL_JsqKf+cq9Nhs+M8ihC-Ls24YH-WEofW8H4kkFPWMhZw=unA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7f8d00ae-b225-a58d-8a11-e8c68edc877b@arm.com>
Date:   Fri, 22 May 2020 15:34:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKf+cq9Nhs+M8ihC-Ls24YH-WEofW8H4kkFPWMhZw=unA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-05-22 15:08, Rob Herring wrote:
> On Fri, May 22, 2020 at 3:57 AM Diana Craciun OSS
> <diana.craciun@oss.nxp.com> wrote:
>>
>> On 5/22/2020 12:42 PM, Robin Murphy wrote:
>>> On 2020-05-22 00:10, Rob Herring wrote:
>>>> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>>
>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>
>>>>> The existing bindings cannot be used to specify the relationship
>>>>> between fsl-mc devices and GIC ITSes.
>>>>>
>>>>> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
>>>>> msi-map property.
>>>>>
>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>> ---
>>>>>    .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30
>>>>> +++++++++++++++++--
>>>>>    1 file changed, 27 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> index 9134e9bcca56..b0813b2d0493 100644
>>>>> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit
>>>>> value called an ICID
>>>>>    the requester.
>>>>>
>>>>>    The generic 'iommus' property is insufficient to describe the
>>>>> relationship
>>>>> -between ICIDs and IOMMUs, so an iommu-map property is used to define
>>>>> -the set of possible ICIDs under a root DPRC and how they map to
>>>>> -an IOMMU.
>>>>> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties
>>>>> are used
>>>>> +to define the set of possible ICIDs under a root DPRC and how they
>>>>> map to
>>>>> +an IOMMU and a GIC ITS respectively.
>>>>>
>>>>>    For generic IOMMU bindings, see
>>>>>    Documentation/devicetree/bindings/iommu/iommu.txt.
>>>>> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
>>>>>    For arm-smmu binding, see:
>>>>>    Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
>>>>>
>>>>> +For GICv3 and GIC ITS bindings, see:
>>>>> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
>>>>>
>>>>> +
>>>>>    Required properties:
>>>>>
>>>>>        - compatible
>>>>> @@ -119,6 +122,15 @@ Optional properties:
>>>>>      associated with the listed IOMMU, with the iommu-specifier
>>>>>      (i - icid-base + iommu-base).
>>>>>
>>>>> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
>>>>> +  data.
>>>>> +
>>>>> +  The property is an arbitrary number of tuples of
>>>>> +  (icid-base,iommu,iommu-base,length).
>>>>
>>>> I'm confused because the example has GIC ITS phandle, not an IOMMU.
>>>>
>>>> What is an iommu-base?
>>>
>>> Right, I was already halfway through writing a reply to say that all
>>> the copy-pasted "iommu" references here should be using the
>>> terminology from the pci-msi.txt binding instead.
>>
>> Right, will change it.
>>
>>>
>>>>> +
>>>>> +  Any ICID in the interval [icid-base, icid-base + length) is
>>>>> +  associated with the listed GIC ITS, with the iommu-specifier
>>>>> +  (i - icid-base + iommu-base).
>>>>>    Example:
>>>>>
>>>>>            smmu: iommu@5000000 {
>>>>> @@ -128,6 +140,16 @@ Example:
>>>>>                   ...
>>>>>            };
>>>>>
>>>>> +       gic: interrupt-controller@6000000 {
>>>>> +               compatible = "arm,gic-v3";
>>>>> +               ...
>>>>> +               its: gic-its@6020000 {
>>>>> +                       compatible = "arm,gic-v3-its";
>>>>> +                       msi-controller;
>>>>> +                       ...
>>>>> +               };
>>>>> +       };
>>>>> +
>>>>>            fsl_mc: fsl-mc@80c000000 {
>>>>>                    compatible = "fsl,qoriq-mc";
>>>>>                    reg = <0x00000008 0x0c000000 0 0x40>,    /* MC
>>>>> portal base */
>>>>> @@ -135,6 +157,8 @@ Example:
>>>>>                    msi-parent = <&its>;
>>>
>>> Side note: is it right to keep msi-parent here? It rather implies that
>>> the MC itself has a 'native' Device ID rather than an ICID, which I
>>> believe is not strictly true. Plus it's extra-confusing that it
>>> doesn't specify an ID either way, since that makes it look like the
>>> legacy PCI case that gets treated implicitly as an identity msi-map,
>>> which makes no sense at all to combine with an actual msi-map.
>>
>> Before adding msi-map, the fsl-mc code assumed that ICID and streamID
>> are equal and used msi-parent just to get the reference to the ITS node.
>> Removing msi-parent will break the backward compatibility of the already
>> existing systems. Maybe we should mention that this is legacy and not to
>> be used for newer device trees.
> 
> If ids are 1:1, then the DT should use msi-parent. If there is
> remapping, then use msi-map. A given system should use one or the
> other. I suppose if some ids are 1:1 and the msi-map was added to add
> additional support for ids not 1:1, then you could end up with both.
> That's fine in dts files, but examples should reflect the 'right' way.

Is that defined anywhere? The generic MSI binding just has some weaselly 
wording about buses:

"When #msi-cells is non-zero, busses with an msi-parent will require 
additional properties to describe the relationship between devices on 
the bus and the set of MSIs they can potentially generate."

which appears at odds with its own definition of msi-parent as including 
an msi-specifier (or at best very unclear about what value that 
specifier should take in this case).

The PCI MSI binding goes even further and specifically reserves 
msi-parent for cases where there is no sideband data. As far as I'm 
aware, the fact that the ITS driver implements a bodge for the "empty 
msi-parent even though #msi-cells > 0" case is merely a compatibility 
thing for old DTs from before this was really thought through, not an 
officially-specified behaviour.

Robin.
