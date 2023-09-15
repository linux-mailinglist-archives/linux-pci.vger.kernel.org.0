Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118167A1C4E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjIOKdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIOKdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 06:33:32 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF294;
        Fri, 15 Sep 2023 03:33:26 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 39BBE7FEF;
        Fri, 15 Sep 2023 18:33:25 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Sep
 2023 18:33:25 +0800
Received: from [192.168.125.57] (113.72.144.67) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Sep
 2023 18:33:23 +0800
Message-ID: <88ba051e-040c-4ff0-1cb0-2b6f01cb950c@starfivetech.com>
Date:   Fri, 15 Sep 2023 18:33:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 0/19] Refactoring Microchip PCIe driver and add
 StarFive PCIe
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
Content-Language: en-US
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230915102243.59775-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.67]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/9/15 18:22, Minda Chen wrote:
> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.
> 
> For re-use the PLDA controller codes, I request refactoring microchip
> codes, move PLDA common codes to PLDA files.
> Desigware and Cadence is good example for refactoring codes.
> 
> So first step is extract the PLDA common codes from microchip, and
> refactoring the microchip codes.(patch1 - 16)
> Then, add Starfive codes. (patch17 - 19)
> 
> This patchset is base on v6.6-rc1
> 
> patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
>        docs from microchip,pcie-host.yaml
> patch2 is move PolarFire codes to PLDA directory.
> patch3 is move PLDA IP register macros to plda-pcie.h
> patch4 is rename data structure in microchip codes.
> patch5 is rename two setup functions in microchip codes, prepare to move
> to common file.
> patch6 is change the arguments of plda_pcie_setup_iomems()
> patch7 is move the two setup functions to common file pcie-plda-host.c
> patch8 is Add PLDA event interrupt codes and IRQ domain ops.
> patch9 is rename the IRQ related functions, prepare to move to
> pcie-plda-host.
> patch10 - 14 is modify the event codes, preparing for support starfive
> and microchip two platforms.
> patch15 is move IRQ related functions to pcie-plda-host.c
> patch16 is set plda_event_handler to static.
> patch17 is add StarFive JH7110 PCIe dt-binding doc.
> patch18 is add StarFive JH7110 Soc PCIe codes.
> patch19 is Starfive dts config
> 
> previous version:
> v1:https://patchwork.kernel.org/project/linux-pci/cover/20230719102057.22329-1-minda.chen@starfivetech.com/
> v2:https://patchwork.kernel.org/project/linux-pci/cover/20230727103949.26149-1-minda.chen@starfivetech.com/
> v3:https://patchwork.kernel.org/project/linux-pci/cover/20230814082016.104181-1-minda.chen@starfivetech.com/
> v4:https://patchwork.kernel.org/project/linux-pci/cover/20230825090129.65721-1-minda.chen@starfivetech.com/
> v5:https://patchwork.kernel.org/project/linux-pci/cover/20230907091058.125630-1-minda.chen@starfivetech.com/
> 
> change:
>   v6:
>     v5 patch 4 split to patch 4 -6. New patches just contain one
> function modification. It is more reguluar.
>     patch 7: Just move the two setup functions only
>     patch 8 : draw a graph of PLDA local register, make it easier to
> review the codes.
>     v5 patch 7 split to patch 9- 14. Each patch just contain one
> function modification. It is more regular.
>     patch 9: rename IRQ related functions.
>     patch 10 - 14 : modify the events codes, total five patch.
>     patch 15: move IRQ related functions to pcie-plda-host.c
>     patch 16: Add new patch 16.
>     patch 18- 19 using "linux,pci-domain" dts setting.
> 
Hi Bjorn
I have noticed that the previous patches of refactoring codes is not so regular( the patched of modify Microchip' codes), and you
don't give any comment to the patches. 
Now this verison is more regular and easier to review. Could you please review the driver codes?

Hi Conor and Daire
Thanks for reviewing. Now I split more patches and make it easier to review. 
