Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2FC771AE6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjHGG7H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 02:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHGG7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 02:59:07 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEC21A4;
        Sun,  6 Aug 2023 23:59:05 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 70B5224E2AA;
        Mon,  7 Aug 2023 14:59:03 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 14:59:03 +0800
Received: from [192.168.125.127] (113.72.146.246) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 14:59:02 +0800
Message-ID: <4921ac0b-a877-6f3f-50a9-b2a053b1a09a@starfivetech.com>
Date:   Mon, 7 Aug 2023 14:59:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] Refactoring Microchip PCIe driver and add StarFive
 PCIe
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <CAJM55Z-r3EtMGui=g8PhwbkYbuPFJgk8OcAF6S_1LcTRAqbOdw@mail.gmail.com>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <CAJM55Z-r3EtMGui=g8PhwbkYbuPFJgk8OcAF6S_1LcTRAqbOdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.246]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/8/5 21:05, Emil Renner Berthing wrote:
> On Thu, 27 Jul 2023 at 12:40, Minda Chen <minda.chen@starfivetech.com> wrote:
>>
>> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
>> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
>> same IP and have commit their codes, which are mixed with PLDA
>> controller codes and Microchip platform codes.
>>
>> For re-use the PLDA controller codes, I request refactoring microchip
>> codes, move PLDA common codes to PLDA files.
>> Desigware and Cadence is good example for refactoring codes.
>>
>> So first step is extract the PLDA common codes from microchip, and
>> refactoring the microchip codes.(patch1 - 2)
>> Then, add Starfive codes. (patch3 - 4)
>>
>> This patchset is base on v6.5-rc1
>>
>> patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
>>        docs from microchip,pcie-host.yaml
>> patch2 is extracting the PLDA common codes from microchip Polarfire PCIe
>>        codes. The change list in the commit message.
>> patch3 is add StarFive JH7110 PCIe dt-binding doc.
>> patch4 is add StarFive JH7110 Soc PCIe codes.
> 
> Hi Minda,
> 
> To test this series properly it needs matching nodes in the VisionFive
> 2 device trees, but it seems to be missing from this version of the
> patch series. If I apply the device tree patch from v1 I get errors
> like this:
> 
>   pcie-starfive 2b000000.pcie: invalid resource (null)
>   pcie-starfive 2b000000.pcie: error -EINVAL: failed to map reg memory
> 
> It would be great if you included the device tree patch in the next
> series so this can actually be tested.
> 
> /Emil
> 
ok. thanks.
>> I have noticed that Daire have changed microchip's codes.
>> https://patchwork.kernel.org/project/linux-pci/cover/20230630154859.2049521-1-daire.mcnamara@microchip.com/
>> I have changed patch2 base on their commits. StarFive
>> PCIe driver still can work. But their codes is under reviewed and
>> maybe changing. Do not base on their changes first.
>> I will base on their commit to change patch2 as soon as
>> their commits are accepted.
>>
>> previous version:
>> v1:https://patchwork.kernel.org/project/linux-pci/cover/20230719102057.22329-1-minda.chen@starfivetech.com/
>>
>> change:
>>   v2:
>>     patch1:
>>       - squash dt-bindings patches to patch1
>>       - add 'required' list.
>>       - plda doc rename to plda,xpressrich-axi-common.yaml
>>     patch2:
>>       - squash the microchip modification patch to patch 2.
>>     patch3:
>>       - remove the plda common required property.
>>     patch4:
>>       - Sync the hide rc bar ops with config read function.
>>       - Revert the T_PVPERL to 100ms and add comments for the source.
>>       - Replace the link check function by the standard link ops.
>>       - Convert to new pm ops marcos.
>>       - Some formats modification.
>>       - pcie-plda-host modification merge to patch4.
>>     other:
>>       - remove the pcie-plda-plat.c
>>       - remove the starfive dts patch first. for it depends on
>>         stg clock and syscon setting.
>>
>> Minda Chen (4):
>>   dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
>>   PCI: plda: Get common codes from Microchip PolarFire host
>>   dt-bindings: PCI: Add StarFive JH7110 PCIe controller
>>   PCI: starfive: Add JH7110 PCIe controller
>>
>>  .../bindings/pci/microchip,pcie-host.yaml     |  49 +-
>>  .../pci/plda,xpressrich3-axi-common.yaml      |  69 ++
>>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 133 ++++
>>  MAINTAINERS                                   |  19 +-
>>  drivers/pci/controller/Kconfig                |   9 +-
>>  drivers/pci/controller/Makefile               |   2 +-
>>  drivers/pci/controller/plda/Kconfig           |  31 +
>>  drivers/pci/controller/plda/Makefile          |   4 +
>>  .../{ => plda}/pcie-microchip-host.c          | 594 ++--------------
>>  drivers/pci/controller/plda/pcie-plda-host.c  | 665 ++++++++++++++++++
>>  drivers/pci/controller/plda/pcie-plda.h       | 242 +++++++
>>  drivers/pci/controller/plda/pcie-starfive.c   | 438 ++++++++++++
>>  12 files changed, 1645 insertions(+), 610 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
>>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>>  create mode 100644 drivers/pci/controller/plda/Kconfig
>>  create mode 100644 drivers/pci/controller/plda/Makefile
>>  rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (50%)
>>  create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
>>  create mode 100644 drivers/pci/controller/plda/pcie-plda.h
>>  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
>>
>>
>> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
>> --
>> 2.17.1
>>
