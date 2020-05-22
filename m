Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57D01DE366
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 11:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgEVJmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 05:42:50 -0400
Received: from foss.arm.com ([217.140.110.172]:60234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgEVJmu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 05:42:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4FC30E;
        Fri, 22 May 2020 02:42:49 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11AEE3F305;
        Fri, 22 May 2020 02:42:46 -0700 (PDT)
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        PCI <linux-pci@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        linux-acpi@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
Date:   Fri, 22 May 2020 10:42:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-05-22 00:10, Rob Herring wrote:
> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> The existing bindings cannot be used to specify the relationship
>> between fsl-mc devices and GIC ITSes.
>>
>> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
>> msi-map property.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> ---
>>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> index 9134e9bcca56..b0813b2d0493 100644
>> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
>>   the requester.
>>
>>   The generic 'iommus' property is insufficient to describe the relationship
>> -between ICIDs and IOMMUs, so an iommu-map property is used to define
>> -the set of possible ICIDs under a root DPRC and how they map to
>> -an IOMMU.
>> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
>> +to define the set of possible ICIDs under a root DPRC and how they map to
>> +an IOMMU and a GIC ITS respectively.
>>
>>   For generic IOMMU bindings, see
>>   Documentation/devicetree/bindings/iommu/iommu.txt.
>> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
>>   For arm-smmu binding, see:
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
>>
>> +For GICv3 and GIC ITS bindings, see:
>> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
>> +
>>   Required properties:
>>
>>       - compatible
>> @@ -119,6 +122,15 @@ Optional properties:
>>     associated with the listed IOMMU, with the iommu-specifier
>>     (i - icid-base + iommu-base).
>>
>> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
>> +  data.
>> +
>> +  The property is an arbitrary number of tuples of
>> +  (icid-base,iommu,iommu-base,length).
> 
> I'm confused because the example has GIC ITS phandle, not an IOMMU.
> 
> What is an iommu-base?

Right, I was already halfway through writing a reply to say that all the 
copy-pasted "iommu" references here should be using the terminology from 
the pci-msi.txt binding instead.

>> +
>> +  Any ICID in the interval [icid-base, icid-base + length) is
>> +  associated with the listed GIC ITS, with the iommu-specifier
>> +  (i - icid-base + iommu-base).
>>   Example:
>>
>>           smmu: iommu@5000000 {
>> @@ -128,6 +140,16 @@ Example:
>>                  ...
>>           };
>>
>> +       gic: interrupt-controller@6000000 {
>> +               compatible = "arm,gic-v3";
>> +               ...
>> +               its: gic-its@6020000 {
>> +                       compatible = "arm,gic-v3-its";
>> +                       msi-controller;
>> +                       ...
>> +               };
>> +       };
>> +
>>           fsl_mc: fsl-mc@80c000000 {
>>                   compatible = "fsl,qoriq-mc";
>>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
>> @@ -135,6 +157,8 @@ Example:
>>                   msi-parent = <&its>;

Side note: is it right to keep msi-parent here? It rather implies that 
the MC itself has a 'native' Device ID rather than an ICID, which I 
believe is not strictly true. Plus it's extra-confusing that it doesn't 
specify an ID either way, since that makes it look like the legacy PCI 
case that gets treated implicitly as an identity msi-map, which makes no 
sense at all to combine with an actual msi-map.

>>                   /* define map for ICIDs 23-64 */
>>                   iommu-map = <23 &smmu 23 41>;
>> +                /* define msi map for ICIDs 23-64 */
>> +                msi-map = <23 &its 23 41>;
> 
> Seeing 23 twice is odd. The numbers to the right of 'its' should be an
> ITS number space.

On about 99% of systems the values in the SMMU Stream ID and ITS Device 
ID spaces are going to be the same. Nobody's going to bother carrying 
*two* sets of sideband data across the interconnect if they don't have to ;)

Robin.

>>                   #address-cells = <3>;
>>                   #size-cells = <1>;
>>
>> --
>> 2.26.1
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
