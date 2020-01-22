Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FCA144D0A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 09:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgAVINe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 03:13:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40544 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgAVINd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 03:13:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00M8Cxqb099296;
        Wed, 22 Jan 2020 02:12:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579680779;
        bh=DhZNPVYtbrpKrZkAkg13qDd9TroZfhPQ/2aqImA4XLQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YyTGJm0CliogdcFd9gnifEAk8QmkOT+QCVGoH27ocDzrZPB7avzwnza5mzPX+UheB
         WfIed/40LSUiLyMMRn74ExRwIwhhSSv1UJr7souRbL0Yr2UkTH1rE9itP9it9eg9Og
         aM+RXxLq2QWw9UixnNzaKOvthN/78MMYypz3cRkI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00M8CwGh095984
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 02:12:58 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 02:12:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 02:12:58 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M8Co0Y069651;
        Wed, 22 Jan 2020 02:12:51 -0600
Subject: Re: [v3 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8s1Jx8uZiSr0uiryS492EbFRoFg9QTwkosZsuyfRYp-3g@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9c65eb7a-539b-1fa3-f988-40c32aa8dfe3@ti.com>
Date:   Wed, 22 Jan 2020 13:45:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CA+V-a8s1Jx8uZiSr0uiryS492EbFRoFg9QTwkosZsuyfRYp-3g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On 21/01/20 11:27 PM, Lad, Prabhakar wrote:
> Hi Rob/Kishon,
> 
> On Wed, Jan 8, 2020 at 4:22 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>>
>> This patch adds the bindings for the R-Car PCIe endpoint driver.
>>
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  | 76 +++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
>> new file mode 100644
>> index 000000000000..99c2a1174463
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
>> @@ -0,0 +1,76 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/rcar-pcie-ep.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Renesas R-Car PCIe Endpoint
>> +
>> +maintainers:
>> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: renesas,r8a774c0-pcie-ep
>> +      - const: renesas,rcar-gen3-pcie-ep
>> +
>> +  reg:
>> +    maxItems: 5
>> +
>> +  reg-names:
>> +    items:
>> +      - const: apb-base
>> +      - const: memory0
>> +      - const: memory1
>> +      - const: memory2
>> +      - const: memory3

As I had mentioned in the other patch, I'd prefer if we can create
standard binding for representing the memory regions. IMHO we should
create subnode for memory regions Each sub-node itself may or may not
have more than one memory region.

In your platform, since there can be only one allocation in a memory
region, there should be 4 sub-nodes for each of the memory region and
each node should have page_size (or some equivalent property) property
to indicate page_size (= region_size).

For a platform that doesn't have the restriction, there can be a single
sub-node containing all the memory region.

Let's wait for Rob's comment though.

Thanks
Kishon
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: pcie
>> +
>> +  max-functions:
>> +    minimum: 1
>> +    maximum: 6
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - resets
>> +  - power-domains
>> +  - clocks
>> +  - clock-names
>> +  - max-functions
>> +
> apart from dt_binding_check error are we OK with dt bindings ?
> 
> Cheers,
> --Prabhakar
> 
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
>> +    #include <dt-bindings/power/r8a774c0-sysc.h>
>> +
>> +     pcie0_ep: pcie-ep@fe000000 {
>> +            compatible = "renesas,r8a774c0-pcie-ep",
>> +                         "renesas,rcar-gen3-pcie-ep";
>> +            reg = <0 0xfe000000 0 0x80000>,
>> +                  <0x0 0xfe100000 0 0x100000>,
>> +                  <0x0 0xfe200000 0 0x200000>,
>> +                  <0x0 0x30000000 0 0x8000000>,
>> +                  <0x0 0x38000000 0 0x8000000>;
>> +            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
>> +            resets = <&cpg 319>;
>> +            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
>> +            clocks = <&cpg CPG_MOD 319>;
>> +            clock-names = "pcie";
>> +            max-functions = /bits/ 8 <1>;
>> +    };
>> --
>> 2.20.1
>>
