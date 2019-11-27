Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42910AA5F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 06:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfK0FpY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 00:45:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48138 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK0FpY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 00:45:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAR5iw31020018;
        Tue, 26 Nov 2019 23:44:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574833498;
        bh=ghIhQuJ9aHS97LO4zAtdQCLPCJDJTY7NbKzwS6TyyAw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qndVf33YNLkQZU0nWotc7RdalzlFQ+JstoxF8ycG9eZBnDYfY/9carjo8SclfjI4X
         j7o7vWluLgW7LnpKzrtc4uwH7N7pAKZHZl8RyJCZFurCkosFACCMWgNW7VwRkjky9H
         7zU+CnLxcJxErGfyfY9QjF2lQdJhb6HJnbDh4Nis=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAR5iwf4108619
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Nov 2019 23:44:58 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 26
 Nov 2019 23:44:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 26 Nov 2019 23:44:58 -0600
Received: from [10.24.69.157] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAR5iocX018864;
        Tue, 26 Nov 2019 23:44:51 -0600
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree
 bindings
To:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
 <CA+V-a8swtOUaxKnCdiTV5wvvxLEJ6XdODL=7bvQmFKY0zQTj2w@mail.gmail.com>
 <CAMuHMdXkbWkQgswMNL7Dw7_jucH+MsuAW+-CjoGVYsm=tjShRw@mail.gmail.com>
 <20191113040802.GA8269@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3b218f7f-78a8-c158-80ac-67a3b9f5970c@ti.com>
Date:   Wed, 27 Nov 2019 11:14:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113040802.GA8269@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 13/11/19 9:38 AM, Rob Herring wrote:
> On Thu, Nov 07, 2019 at 09:08:35PM +0100, Geert Uytterhoeven wrote:
>> Hi Prabhakar,
>>
>> On Thu, Nov 7, 2019 at 10:26 AM Lad, Prabhakar
>> <prabhakar.csengg@gmail.com> wrote:
>>> On Thu, Nov 7, 2019 at 8:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> On Wed, Nov 6, 2019 at 8:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>>>>> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>>
>>>>> This patch adds the bindings for the R-Car PCIe endpoint driver.
>>>>>
>>>>> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>>
>>>> Thanks for your patch!
>>>>
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
>>>>> @@ -0,0 +1,43 @@
>>>>> +* Renesas R-Car PCIe Endpoint Controller DT description
>>>>> +
>>>>> +Required properties:
>>>>> +           "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
>>>>> +           "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
>>>>> +                                    RZ/G2 compatible device.
>>>>
>>>> Unless I'm missing something, this is for the exact same hardware block as
>>>> Documentation/devicetree/bindings/pci/rcar-pci.txt?
>>>> So shouldn't you amend those bindings, instead of adding new compatible
>>>> values?
>>>> Please remember that DT describes hardware, not software policy.
>>>> So IMHO choosing between host and endpoint is purely a configuration
>>>> issue, and could be indicated by the presence or lack of some DT properties.
>>>> E.g. host mode requires both "bus-range" and "device_type" properties,
>>>> so their absence could indicate endpoint mode.
>>>>
>>> yes its the same hardware block as described in the rcar-pci.txt, I
>>> did think about amending it
>>> but  it might turn out to be bit messy,
>>>
>>> required properties host ======required properties Endpoint
>>> ====================||==================
>>> 1: reg                                || reg
>>> 2:bus-range                      || reg names
>>> 3: device_type                  || resets
>>> 4: ranges                          || clocks
>>> 5: dma-ranges                  || clock-names
>>> 6: interrupts                      ||
>>> 7: interrupt-cells               ||
>>> 8: interrupt-map-mask     ||
>>> 9: clocks                          ||
>>> 10: clock-names             ||
>>
>> We have a similar situation with SPI, where a controller can operate in
>> master or slave mode, based on the absence or presence of the
>> "spi-slave" DT property.
>>
>>> and if I go ahead with the same compatible string that would mean to
>>> add support for endpoint
>>> mode in the host driver itself. I did follow the examples of
>>
>> You can still have two separate drivers, binding against the same
>> compatible value.  Just let the .probe() function return -ENODEV if it
>> discovers (by looking at DT properties) if the node is configured for
>> the other mode.
>> Which brings us to my next questions: is there any code that could be
>> shared between the drivers for the two modes?
>>
>>> rockchip/cadence/designware where
>>> its the same hardware block but has two different binding files one
>>> for host mode and other for
>>> endpoint mode.
>>
>> Having two separate DT binding documents sounds fine to me, if unifying
>> them makes things too complex.
>> However, I think they should use the same compatible value, because the
>> hardware block is the same, but just used in a different mode.
>>
>> Rob/Mark: Any input from the DT maintainers?
> 
> Separate files makes sense because different modes will want to 
> include different common schemas. We've generally been doing different 
> compatibles too which makes validating the node has the right set of 
> properties easier.
>  
>>>>> +- reg: Five register ranges as listed in the reg-names property
>>>>> +- reg-names: Must include the following names
>>>>> +       - "apb-base"
>>>>> +       - "memory0"
>>>>> +       - "memory1"
>>>>> +       - "memory2"
>>>>> +       - "memory3"
>>>>
>>>> What is the purpose of the last 4 regions?
>>>> Can they be chosen by the driver, at runtime?
>>>>
>>> no the driver cannot choose them at runtime, as these are the only
>>> PCIE memory(0/1/2/3) ranges
>>> in the AXI address space where host memory can be mapped.
>>
>> Are they fixed by the PCIe hardware, i.e. could they be looked up by the
>> driver based on the compatible value?
> 
> That would be strange for a memory range.
> 
> Sounds like like 'ranges' though I'm not sure if 'ranges' for an EP 
> makes sense or what that should look like.

These are similar to "memory node" with multiple address, size pairs. I'm
thinking if these should be added as a subnode within PCIe EP controller device
tree node?

Thanks
Kishon
