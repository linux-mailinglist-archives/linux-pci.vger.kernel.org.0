Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100217BD919
	for <lists+linux-pci@lfdr.de>; Mon,  9 Oct 2023 12:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjJIK7K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Oct 2023 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjJIK7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 06:59:10 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97619C;
        Mon,  9 Oct 2023 03:59:07 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 70B5C24E225;
        Mon,  9 Oct 2023 18:59:00 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 9 Oct
 2023 18:59:00 +0800
Received: from [192.168.125.85] (183.27.97.165) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 9 Oct
 2023 18:58:59 +0800
Message-ID: <fd5b8d0f-67d0-4e0e-9a15-6f3ae53b6db2@starfivetech.com>
Date:   Mon, 9 Oct 2023 18:58:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/19] Refactoring Microchip PCIe driver and add
 StarFive PCIe
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230927100802.46620-1-minda.chen@starfivetech.com>
Content-Language: en-US
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230927100802.46620-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.97.165]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/9/27 18:07, Minda Chen wrote:
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
> This patchset is base on v6.6-rc3
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
Hi Conor and Daire
Have you ever test this patchset？ I'm sure I am not  change logic of the PolarFire PCIe driver,
But I can not test it.
Since this series patch is delegate to nobody and no response now. I don't know when this patch set can be accepted.
I still hope the refactoring patches can be accepted first. 
(I know you want to add the function of inbound and outbound address translation, Hope this series patch do not influence your upstream plan)
