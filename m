Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773C57CBA3B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 07:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQFn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 01:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQFn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 01:43:27 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072AA2;
        Mon, 16 Oct 2023 22:43:20 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 168D18067;
        Tue, 17 Oct 2023 13:43:12 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Oct
 2023 13:43:12 +0800
Received: from [192.168.125.85] (183.27.98.194) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Oct
 2023 13:43:10 +0800
Message-ID: <6182d9f9-8810-4704-b314-a5612d2aa795@starfivetech.com>
Date:   Tue, 17 Oct 2023 13:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/22] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Daire McNamara" <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20231011110514.107528-1-minda.chen@starfivetech.com>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20231011110514.107528-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.194]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/11 19:04, Minda Chen wrote:
> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.
> 
> For re-use the PLDA controller codes, I request refactoring microchip
> codes, move PLDA common codes to PLDA files.
> Desigware and Cadence is good example for refactoring codes.
> 
> ----------------------------------------------------------
> The refactoring patches total number is 17,(patch 1-17)
> which do NOT contain changing logic of codes.
> 
> These patches just contain three type basic operations.
> (rename, modify codes to support starfive platform, and moving to common file)
> If these patched are all be reviewed. They can be accepted first.
> 
> Refactoring patches can be devided to different groups
> 1. (patch 1- 3 is the prepare work of refactoring)
> patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
>        docs from microchip,pcie-host.yaml
> patch2 is move PolarFire codes to PLDA directory.
> patch3 is move PLDA IP register macros to plda-pcie.h
> 
> 2. (patch4 - 6 is processing and re-use PCIe host instance)
> patch4 is add bridge_addr field to PCIe host instance.
> patch5 is rename data structure in microchip codes.
> patch6 is moving two data structures to head file
> 
> 3. (patch 7 - 9 are for re-use two PCIe setup function)
> patch7 is rename two setup functions in microchip codes, prepare to move
> to common file.
> patch8 is change the arguments of plda_pcie_setup_iomems()
> patch9 is move the two setup functions to common file pcie-plda-host.c
> 
> 4.(patch 10 - 17 are for re-use interupt processing codes)
> patch10 add a plda default event handler function.
> patch11 is rename the IRQ related functions, prepare to move to
> pcie-plda-host.c
> patch 12 - 16 is modify the interrupt event codes, preparing for support starfive
> and microchip two platforms.
> patch17 is move IRQ related functions to pcie-plda-host.c
> 
> ------------------------------------------------------------
> The remainder patches (patch 18 -22) are not refactoring patch.
> They are for adding StarFive codes and dont modify the microchip's
> codes.
> 
> patch18 is set plda_event_handler to static.
> patch19 is Add PLDA event interrupt codes and IRQ domain ops.
> patch20 is add StarFive JH7110 PCIe dt-binding doc.
> patch21 is add StarFive JH7110 Soc PCIe codes.
> patch22 is Starfive dts config
> 
> This patchset is base on v6.6-rc5
> 

Hi Kzysztof(K.W)
   Could you please take time to review this series patches? Thanks.

Hi Conor
  The patch 4- 6 is split from previous version patch. You have added your review tag to that patch.
  May I add your review tag to patch 4 -6 ?
  And linux-riscv do NOT run compile test to this patch set.
