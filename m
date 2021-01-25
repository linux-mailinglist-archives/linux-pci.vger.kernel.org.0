Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A413230202F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 03:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbhAYCKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Jan 2021 21:10:21 -0500
Received: from regular1.263xmail.com ([211.150.70.198]:40434 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbhAYCHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Jan 2021 21:07:01 -0500
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 0FA626A9;
        Mon, 25 Jan 2021 09:53:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24739T140082531448576S1611539600296563_;
        Mon, 25 Jan 2021 09:53:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dcf0c7cb0998b121b2b8409034ca4d48>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_1/2=5d_dt-bindings=3a_rockchip=3a_Add_D?=
 =?UTF-8?B?ZXNpZ25XYXJlIGJhc2VkIFBDSWUgY29udHJvbGxlcuOAkOivt+azqOaEj++8jA==?=
 =?UTF-8?B?6YKu5Lu255Sxcm9iaGVycmluZzJAZ21haWwuY29t5Luj5Y+R44CR?=
To:     Rob Herring <robh@kernel.org>, Johan Jonker <jbx6244@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
References: <20210120101554.241029-1-xxm@rock-chips.com>
 <3af70037-c05d-1759-2bae-41db1e8e2768@gmail.com>
 <20210122155503.GA860027@robh.at.kernel.org>
From:   xxm <xxm@rock-chips.com>
Message-ID: <5bde2bf9-2492-78a2-5281-c3694efa405d@rock-chips.com>
Date:   Mon, 25 Jan 2021 09:53:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210122155503.GA860027@robh.at.kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

ÔÚ 2021/1/22 23:55, Rob Herring Ð´µÀ:
> On Wed, Jan 20, 2021 at 06:07:29PM +0100, Johan Jonker wrote:
>> Hi Simon,
>>
>> Thanks you for version 2.
>> A few comments, have a look if it is useful or that you disagree.
>>
>> This patch has no commit message. Add one in version 3.
>>
>> Submit all patches in one batch with the same sort message ID to all
>> maintainers including Heiko.
>>
>> Heiko Stuebner <heiko@sntech.de>
>>
>> Example message ID:
>> 20210120101554.241029-1-xxm@rock-chips.com
>>
>> /////
>>
>> Included is a copy of the Rockchip pcie nodes in a sort of test.dts below.
>> Could you confirm that the properties in that dts are the one that we
>> can expect for Linux mainline and can base our YAML document on?
>>
>> With rk3568-cru.h and rk3568-power.h manualy added we do some tests with
>> the following commands:
>>
>> make ARCH=arm64 dt_binding_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>
>> make ARCH=arm64 dtbs_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>
>> make ARCH=arm64 dtbs_check
>> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/pci/pci-bus.yaml
>>
>> /////
>>
>> Example notifications:
>>
>> /arch/arm64/boot/dts/rockchip/test.dt.yaml: pcie@fe270000: reg: [[3,
>> 3225419776, 0, 4194304], [0, 4263968768, 0, 65536]] is too long
>>
>> /arch/arm64/boot/dts/rockchip/test.dt.yaml: pcie@fe270000: ranges:
>> 'oneOf' conditional failed, one must be fixed:
>>
>> Before you submit version 3 make sure that all warnings gone as much as
>> possible.
>>
>> On 1/20/21 11:15 AM, Simon Xue wrote:
>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>>> ---
>>>   .../bindings/pci/rockchip-dw-pcie.yaml        | 140 ++++++++++++++++++
>>>   1 file changed, 140 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>> new file mode 100644
>>> index 000000000000..9d3a57f5305e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>> @@ -0,0 +1,140 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
>>> +
>>> +maintainers:
>>> +  - Shawn Lin <shawn.lin@rock-chips.com>
>>> +  - Simon Xue <xxm@rock-chips.com>
>>       - Heiko Stuebner <heiko@sntech.de> ;)
>>> +
>>> +description: |+
>>> +  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
>>> +  PCIe IP and thus inherits all the common properties defined in
>>> +  designware-pcie.txt.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/pci/pci-bus.yaml#
>>> +
>>> +# We need a select here so we don't match all nodes with 'snps,dw-pcie'
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: rockchip,rk3568-pcie
>>> +  required:
>>> +    - compatible
>>> +
>>> +properties:
>>> +  compatible:
>>> +    item:
>>      items:
>>
>>> +      - const: rockchip,rk3568-pcie
>>> +      - const: snps,dw-pcie
>> Add empty line
>>
>>> +  reg:    items:
>>        - description:
>>        - description:
>>
>> Add some description for regs.
>>
>>> +    maxItems: 1
>> remove
>>
>> This reg maxItems gives errors.
>>
>>> +
>>> +  interrupt:
>> interrupts:
>>     items:
>>
>>> +      - description: system information
>>> +      - description: power management control
>>> +      - description: PCIe message
>>> +      - description: legacy interrupt
>>> +      - description: error report
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: sys
>>> +      - const: pmc
>>> +      - const: msg
> MSI? If so, use 'msi'. The DWC core will handle setting it up now.

No, it is SoC designed interrupt for some purpose. Currently, we don't 
use interrupt, will remove

these.

>>> +      - const: legacy
>>> +      - const: err
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: AHB clock for PCIe master
>>> +      - description: AHB clock for PCIe slave
>>> +      - description: AHB clock for PCIe dbi
>>> +      - description: APB clock for PCIe
>>> +      - description: Auxiliary clock for PCIe
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: aclk_mst
>>> +      - const: aclk_slv
>>> +      - const: aclk_dbi
>>> +      - const: pclk
>>> +      - const: aux
>>> +
>>> +  msi-map: true
>>> +
>>> +  power-domains:
>>> +    maxItems: 1
>> /////
>> These properties come from designware-pcie.txt
>> Maybe add them here for now till there's a common yaml?
>>
>>    num-ib-windows: number of inbound address translation windows
>>    num-ob-windows: number of outbound address translation windows
> These can be and are now detected at runtime.

Will remove.

Simon Xue

>
> Rob
>
>
>


