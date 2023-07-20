Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43F75A44B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 04:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGTCQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 22:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTCQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 22:16:05 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A21FFE;
        Wed, 19 Jul 2023 19:16:02 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3FCC580C5;
        Thu, 20 Jul 2023 10:15:54 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 10:15:54 +0800
Received: from [192.168.125.127] (113.72.147.86) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 10:15:53 +0800
Message-ID: <52ebc991-0e73-8df4-61b2-32989ab4e62c@starfivetech.com>
Date:   Thu, 20 Jul 2023 10:15:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 0/9] Refactoring Microchip PolarFire PCIe driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719152626.GA502469@bhelgaas>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230719152626.GA502469@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/19 23:26, Bjorn Helgaas wrote:
> On Wed, Jul 19, 2023 at 06:20:48PM +0800, Minda Chen wrote:
>> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
>>   dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
>> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
>> same IP and have commit their codes, which are mixed with PLDA
>> controller codes and Microchip platform codes.
> 
> I guess this actually adds TWO drivers: PCIE_PLDA_PLAT_HOST (claims
> "plda,xpressrich-pcie-host" devices) and PCIE_STARFIVE_HOST (claims
> "starfive,jh7110-pcie" devices), right?
> 
Yes, plda,xpressrich-pcie-host is IP controller driver. Do it like designware/cadence/mobiveil, (pcie-(ip)-plat.c)
But I can't test it. I don't whether need it. If it not required, I will delete it.
>> For re-use the PLDA controller codes, I request refactoring microchip
>> codes, move PLDA common codes to PLDA files.
>> Desigware and Cadence is good example for refactoring codes.
>> 
>> So first step is extract the PLDA common codes from microchip, and
>> refactoring the microchip codes.(patch1 - 4)
>> Then add the PLDA platform codes. (patch5, 6)
>> At last, add Starfive codes. (patch7 - 9)
>> 
>> This patchset is base on v6.5-rc1
> 
> Doesn't quite apply cleanly for me:
> 
I am sorry, The driver need stg clk and syscon driver, which are have't be merge to main line.
mainly dts is(patch9) rejected, Must apply this series patch first. (I forget add this link in cover letter)
https://patchwork.kernel.org/project/linux-riscv/cover/20230712092007.31013-1-xingyu.wu@starfivetech.com/
and this syscon patch 
https://patchwork.kernel.org/project/linux-riscv/patch/20230717023040.78860-7-xingyu.wu@starfivetech.com/
>   10:10:15 ~/linux (main)$ git checkout -b wip/minda-starfive-v1 v6.5-rc1
>   Switched to a new branch 'wip/minda-starfive-v1'
>   10:10:33 ~/linux (wip/minda-starfive-v1)$ git am m/20230719_minda_chen_refactoring_microchip_polarfire_pcie_driver.mbx
>   Applying: dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
>   Applying: dt-bindings: PCI: microchip: Remove the PLDA common properties
>   Applying: PCI: PLDA: Get PLDA common codes from Microchip PolarFire host
>   Applying: PCI: microchip: Move PCIe driver to PLDA directory
>   Applying: dt-bindings: PLDA: Add PLDA XpressRICH PCIe host controller
>   Applying: PCI: PLDA: Add host conroller platform driver
>   Applying: dt-bindings: PCI: Add StarFive JH7110 PCIe controller
>   Applying: PCI: PLDA: starfive: Add JH7110 PCIe controller
>   Applying: riscv: dts: starfive: add PCIe dts configuration for JH7110
>   error: patch failed: arch/riscv/boot/dts/starfive/jh7110.dtsi:629
>   error: arch/riscv/boot/dts/starfive/jh7110.dtsi: patch does not apply
>   Patch failed at 0009 riscv: dts: starfive: add PCIe dts configuration for JH7110
> 
>>   dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
>>   dt-bindings: PCI: microchip: Remove the PLDA common properties
>>   PCI: PLDA: Get PLDA common codes from Microchip PolarFire host
>>   PCI: microchip: Move PCIe driver to PLDA directory
>>   dt-bindings: PLDA: Add PLDA XpressRICH PCIe host controller
>>   PCI: PLDA: Add host conroller platform driver
> 
> "controller"
>ok
>>   dt-bindings: PCI: Add StarFive JH7110 PCIe controller
>>   PCI: PLDA: starfive: Add JH7110 PCIe controller
>>   riscv: dts: starfive: add PCIe dts configuration for JH7110
> 
> Use "PCI: plda: " prefix for PLDA things that are shared across
> multiple drivers.
> 
> Use "PCI: starfive: " prefix for starfive-specific things.
> 
> This is the same as how drivers/pci/controller/dwc/* looks.
> 
ok, thanks.
> Bjorn
