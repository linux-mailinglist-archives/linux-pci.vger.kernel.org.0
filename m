Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEBA2A9817
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 16:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgKFPKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 10:10:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53878 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgKFPKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 10:10:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FAcUY021603;
        Fri, 6 Nov 2020 09:10:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604675438;
        bh=cYq9nLX08g+AS2pblkyYqwuEvgJAblM0udPTzaUKv8s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=h3b2DP/fx0Ig2ry7sgpgiEY3IygBp5SacsDDkQ3MQUDn4efxMU4wo8HyB8aDyH6l4
         zfiQorUHqPWlcFLEXPXnV2ln185+sE1PUOcgjVXwOynWw8HwKji+dL9HGH3qlecvMC
         vQUzfEJIxbBnIfz1b+tTbj1zf/zQIN8pasgSTnUE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6FAcBF129824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 09:10:38 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 09:10:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 09:10:37 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FAYee002242;
        Fri, 6 Nov 2020 09:10:34 -0600
Subject: Re: [PATCH 8/8] arm64: dts: ti: k3-j721e-main: Fix PCIe maximum
 outbound regions
To:     Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-9-kishon@ti.com>
 <20201102164137.ntl3v6gu274ek2r2@gauze> <20201105165331.GA55814@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1825b8dc-89c4-f5e6-69f2-4b0f6f3e5944@ti.com>
Date:   Fri, 6 Nov 2020 20:40:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105165331.GA55814@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 05/11/20 10:23 pm, Rob Herring wrote:
> On Mon, Nov 02, 2020 at 10:41:37AM -0600, Nishanth Menon wrote:
>> On 15:41-20201102, Kishon Vijay Abraham I wrote:
>>> PCIe controller in J721E supports a maximum of 32 outbound regions.
>>> commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree
>>> nodes") incorrectly added maximum number of outbound regions to 16. Fix
>>> it here.
>>>
>>> Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> index e2a96b2c423c..61b533130ed1 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> @@ -652,7 +652,7 @@
>>>  		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
>>>  		clocks = <&k3_clks 239 1>;
>>>  		clock-names = "fck";
>>> -		cdns,max-outbound-regions = <16>;
>>> +		cdns,max-outbound-regions = <32>;
> 
> Can this be made detectable instead? Write to region registers and check 
> the write sticks? I'm doing this for the DWC controller.
> 
> Or make the property optional with the default being the max (32).

okay, I'll make this an optional property and send a patch which removes
cdns,max-outbound-regions in k3-j721e-main.dtsi.

Thanks,
Kishon
