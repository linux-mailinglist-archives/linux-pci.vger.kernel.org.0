Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5DD160D9
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEGJ0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 05:26:30 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12219 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfEGJ0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 05:26:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd14f210000>; Tue, 07 May 2019 02:25:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 02:26:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 May 2019 02:26:27 -0700
Received: from [10.25.73.250] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 09:26:22 +0000
Subject: Re: [PATCH V5 10/16] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-11-vidyas@nvidia.com> <20190503111923.GE32400@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <af37a21a-a14e-70c0-8687-de2c29e2d99b@nvidia.com>
Date:   Tue, 7 May 2019 14:56:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503111923.GE32400@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557221153; bh=eWcAPdSLPxJziq38mCpdrLZ+f2V3YxaE900UI9oR3M8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OWYcMWvJ73bokiGH63V36U0ZgG8nxhs8EQ2XMAIA4G0gV+uy3N+HNa8DmcsgGNdK0
         D1NepnPvHbMlRi2jlis8jLRQJ/IIL+3whFkwsP/EOIb41Y13dZMzHL2p8jXCg9/mUt
         dzQGM0Y9s2al3Sc0vyWiY0c/fRmZungo6rW+z8pJBvjs10N+DySMc/bawK835Q/Zpf
         uvMRmbvvdco9nPfEO86i4nn+WiklGhd20caEUBkxbgDF/UOKvKPr7Mf31b+5jafde3
         +Rttxta7sKTnjOTzIbVEi1vFuO19t/QK5Amj/+moN09AKuMqVtEpYp4LMjhkR3bqPK
         DK5cwNjqUrygA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/2019 4:49 PM, Thierry Reding wrote:
> On Wed, Apr 24, 2019 at 10:49:58AM +0530, Vidya Sagar wrote:
>> Add support for Tegra194 PCIe controllers. These controllers are based
>> on Synopsys DesignWare core IP.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * None
>>
>> Changes since [v2]:
>> * Using only 'Cx' (x-being controller number) format to represent a controller
>> * Changed to 'value: description' format where applicable
>> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
>> * Provided more documentation for 'nvidia,init-link-speed' property
>> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
>>
>> Changes since [v1]:
>> * Added documentation for 'power-domains' property
>> * Removed 'window1' and 'window2' properties
>> * Removed '_clk' and '_rst' from clock and reset names
>> * Dropped 'pcie' from phy-names
>> * Added entry for BPMP-FW handle
>> * Removed offsets for some of the registers and added them in code and would be pickedup based on
>>    controller ID
>> * Changed 'nvidia,max-speed' to 'max-link-speed' and is made as an optional
>> * Changed 'nvidia,disable-clock-request' to 'supports-clkreq' with inverted operation
>> * Added more documentation for 'nvidia,update-fc-fixup' property
>> * Removed 'nvidia,enable-power-down' and 'nvidia,plat-gpios' properties
>> * Added '-us' to all properties that represent time in microseconds
>> * Moved P2U documentation to a separate file
>>
>>   .../bindings/pci/nvidia,tegra194-pcie.txt     | 187 ++++++++++++++++++
>>   1 file changed, 187 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> new file mode 100644
>> index 000000000000..208dff126108
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> @@ -0,0 +1,187 @@
>> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>> +
>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
>> +and thus inherits all the common properties defined in designware-pcie.txt.
>> +
>> +Required properties:
>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
>> +- device_type: Must be "pci"
>> +- power-domains: A phandle to the node that controls power to the respective
>> +  PCIe controller and a specifier name for the PCIe controller. Following are
>> +  the specifiers for the different PCIe controllers
>> +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C1
>> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C2
>> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C3
>> +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>> +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>> +  these specifiers are defined in
>> +  "include/dt-bindings/power/tegra194-powergate.h" file.
>> +- reg: A list of physical base address and length for each set of controller
> 
> Perhaps "list of physical base address and length pairs".
Ok.

> 
>> +  registers. Must contain an entry for each entry in the reg-names property.
>> +- reg-names: Must include the following entries:
>> +  "appl": Controller's application logic registers
>> +  "config": As per the definition in designware-pcie.txt
>> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>> +             Translation Unit) registers of the PCIe core are made available
>> +             fow SW access.
> 
> s/fow/for/
Done.

> 
> Thierry
> 

