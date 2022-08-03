Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C407B588AA1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbiHCKdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiHCKb1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 06:31:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D83F6140AE;
        Wed,  3 Aug 2022 03:30:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 360A7113E;
        Wed,  3 Aug 2022 03:30:30 -0700 (PDT)
Received: from [10.57.12.36] (unknown [10.57.12.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4093F3F67D;
        Wed,  3 Aug 2022 03:30:28 -0700 (PDT)
Message-ID: <50d04f45-6aa9-dee8-6647-3f0b909049ea@arm.com>
Date:   Wed, 3 Aug 2022 11:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: PCI: host-generic-pci: Allow IOMMU and MSI
 properties
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220728175137.1172841-1-robh@kernel.org>
 <a673e846-e3d7-63e3-70cd-4adef3f761cc@arm.com>
 <CAL_JsqL37RQqGv6ZB5uxsnPFoUjKPh6uc7_SWpaqDJqvWAF4Dg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAL_JsqL37RQqGv6ZB5uxsnPFoUjKPh6uc7_SWpaqDJqvWAF4Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-08-02 23:21, Rob Herring wrote:
> On Tue, Aug 2, 2022 at 3:26 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-07-28 18:51, Rob Herring wrote:
>>> Allow 'iommu-map', 'iommu-map-mask', and 'msi-parent' properties for
>>> generic host. This fixes unevaluated property warnings on Arm Juno, AMD
>>> Seattle, and FSL LS1028a.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>    Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>> index 6bcaa8f2c3cf..d25423aa7167 100644
>>> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>>> @@ -106,6 +106,9 @@ properties:
>>>        maxItems: 3
>>>
>>>      dma-coherent: true
>>> +  iommu-map: true
>>> +  iommu-map-mask: true
>>> +  msi-parent: true
>>
>> Hmm, in general this set looks suspiciously incomplete without msi-map
>> and msi-map-mask too. Am I right in thinking that the ideal thing to do
>> here would be to convert pci-msi.txt and pci-iommu.txt to schema and
>> $ref them?
> 
> I already added msi-map/msi-map-mask to pci-bus.yaml[1] as well as
> schemas for iommu-map/iommu-map-mask[2] and msi-parent[3]. Since
> msi-map is already in the referenced schema, it is allowed here.
> msi-parent is separate because it is used elsewhere. iommu-map is
> separate largely to make copying pci-iommu.txt as-is easier.
> 
> And yes, pci-iommu.txt can now be removed. pci-msi.txt is more
> complicated as all of it hasn't been moved into schemas.

Ah, great! One general comment, though - iommu-map/msi-map have pretty 
much grown into common IOMMU/MSI consumer properties by now, so IMO 
they'd be better off living alongside their respective iommus/msi-parent 
counterparts, so that other consumers like fsl-mc and host1x can 
reference a common definition rather than duplicating their own. The 
only aspect that should still belong to the PCI binding is the detail of 
how PCI B:D:F forms the input ID for the mappings (and equivalently for 
other bus bindings).

Thanks,
Robin.

> 
> Rob
> 
> [1] https://github.com/devicetree-org/dt-schema/commit/109bde712466281e8c96a4fadb0f68e7a90a6eca
> [2] https://github.com/devicetree-org/dt-schema/commit/3d44bf2b46a9ac638550ca3916d7d7f70823bb58
> [3] https://github.com/devicetree-org/dt-schema/commit/59f2e3103b6e776afe4f42e45897f7eabae06fa4
