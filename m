Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624B8460DF2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 05:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbhK2EI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 23:08:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42386 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhK2EG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 23:06:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AT43Nrb110170;
        Sun, 28 Nov 2021 22:03:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638158603;
        bh=FrGdjPInShzB2+c5CZgij+JjrDs4konXtkz4L7PERYg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HiYXygwTe9XulGvCl67DC+QOwjY0dtITt4CSOysANUpioBlKJbNty5DTS+QPmSnj7
         3Oyd4U7YRCEdUjDwA5CT1+HA7mxgfATTJ2/M6bzJVAtdk39ZuyDxEZYHSEG8eHxAFd
         9PgKM1vZE3eFGnw8IVrv3GwlKviysLg3JhwTbL1I=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AT43N3Y086345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Nov 2021 22:03:23 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 28
 Nov 2021 22:03:23 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 28 Nov 2021 22:03:23 -0600
Received: from [10.250.234.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AT43KAY008660;
        Sun, 28 Nov 2021 22:03:21 -0600
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: ti,am65: Fix
 "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
To:     Rob Herring <robh@kernel.org>
CC:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211126083119.16570-1-kishon@ti.com>
 <20211126083119.16570-2-kishon@ti.com>
 <1638054802.141849.1973546.nullmailer@robh.at.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1d0490fe-9fbe-8ca3-7a27-0bed9aa1eac8@ti.com>
Date:   Mon, 29 Nov 2021 09:33:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1638054802.141849.1973546.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 28/11/21 4:43 am, Rob Herring wrote:
> On Fri, 26 Nov 2021 14:01:15 +0530, Kishon Vijay Abraham I wrote:
>> Fix binding documentation of "ti,syscon-pcie-id" and "ti,syscon-pcie-mode"
>> to take phandle with argument. The argument is the register offset within
>> "syscon" used to configure PCIe controller. Similar change for j721e is
>> discussed in [1]
>>
>> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/pci/ti,am65-pci-ep.yaml  |  8 ++++++--
>>  .../bindings/pci/ti,am65-pci-host.yaml           | 16 ++++++++++++----
>>  2 files changed, 18 insertions(+), 6 deletions(-)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.

Once this series is merged, I'll send an update to the device tree files.
Without the corresponding driver changes, update to DT will break functionality.

Thanks,
Kishon
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1559994
> 
> 
> pcie@21020000: compatible: Additional items are not allowed ('snps,dw-pcie' was unexpected)
> 	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
> 
> pcie@21020000: compatible: ['ti,keystone-pcie', 'snps,dw-pcie'] is too long
> 	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
> 
> pcie@21020000: reg: [[553783296, 8192], [553779200, 4096], [39977256, 4]] is too short
> 	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
> 
> pcie@21800000: compatible: Additional items are not allowed ('snps,dw-pcie' was unexpected)
> 	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
> 	arch/arm/boot/dts/keystone-k2hk-evm.dt.yaml
> 	arch/arm/boot/dts/keystone-k2l-evm.dt.yaml
> 
> pcie@21800000: compatible: ['ti,keystone-pcie', 'snps,dw-pcie'] is too long
> 	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
> 	arch/arm/boot/dts/keystone-k2hk-evm.dt.yaml
> 	arch/arm/boot/dts/keystone-k2l-evm.dt.yaml
> 
> pcie@21800000: reg: [[562040832, 8192], [562036736, 4096], [39977256, 4]] is too short
> 	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
> 	arch/arm/boot/dts/keystone-k2hk-evm.dt.yaml
> 	arch/arm/boot/dts/keystone-k2l-evm.dt.yaml
> 
> pcie@5500000: ti,syscon-pcie-id:0: [52] is too short
> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> 
> pcie@5500000: ti,syscon-pcie-id:0: [60] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 
> pcie@5500000: ti,syscon-pcie-id:0: [61] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> pcie@5500000: ti,syscon-pcie-mode:0: [53] is too short
> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> 
> pcie@5500000: ti,syscon-pcie-mode:0: [61] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 
> pcie@5500000: ti,syscon-pcie-mode:0: [62] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> pcie@5600000: ti,syscon-pcie-id:0: [52] is too short
> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> 
> pcie@5600000: ti,syscon-pcie-id:0: [60] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 
> pcie@5600000: ti,syscon-pcie-id:0: [61] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> pcie@5600000: ti,syscon-pcie-mode:0: [55] is too short
> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> 
> pcie@5600000: ti,syscon-pcie-mode:0: [63] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 
> pcie@5600000: ti,syscon-pcie-mode:0: [64] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> pcie-ep@5500000: ti,syscon-pcie-mode:0: [53] is too short
> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> 
> pcie-ep@5500000: ti,syscon-pcie-mode:0: [61] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 
> pcie-ep@5500000: ti,syscon-pcie-mode:0: [62] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
> pcie-ep@5600000: ti,syscon-pcie-mode:0: [55] is too short
> 	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> 
> pcie-ep@5600000: ti,syscon-pcie-mode:0: [63] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
> 
> pcie-ep@5600000: ti,syscon-pcie-mode:0: [64] is too short
> 	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
> 	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml
> 
