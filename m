Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9265C76679C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjG1IrR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 28 Jul 2023 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjG1IrB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 04:47:01 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5443590;
        Fri, 28 Jul 2023 01:46:58 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3AFFC24E276;
        Fri, 28 Jul 2023 16:46:47 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 28 Jul
 2023 16:46:47 +0800
Received: from [192.168.125.127] (113.72.147.196) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 28 Jul
 2023 16:46:45 +0800
Message-ID: <dbb39cd2-4437-92ab-b6c6-8dae18748c98@starfivetech.com>
Date:   Fri, 28 Jul 2023 16:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] PCI: plda: Get common codes from Microchip
 PolarFire host
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230727120207.GA769710@bhelgaas>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230727120207.GA769710@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.147.196]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/7/27 20:02, Bjorn Helgaas wrote:
> On Thu, Jul 27, 2023 at 06:39:47PM +0800, Minda Chen wrote:
>> Add PLDA PCIe controller driver codes, Move them from Microchip
>> PolarFire PCIe host driver codes. And move pcie-microchip-host.c
>> to plda directory.
>> 
>> The change includes:
>> - copy the IP register marcos.
>> - Add related data structures of PCIe host instance.
>>   mc_pcie --> plda_pcie (Get most of data members)
>>   mc_msi  --> plda_msi
>>   add plda_pcie_ops and plda_evt data structures.
>> - function rename list:
>>   mc_pcie_enable_msi       --> plda_pcie_enable_msi
>>   mc_pcie_setup_window     --> plda_pcie_setup_window
>>   mc_pcie_setup_windows    --> plda_pcie_setup_iomems
>>   mc_pcie_init_irq_domains --> plda_pcie_init_irq_domains
>>   mc_allocate_msi_domains  --> plda_allocate_msi_domains
>>   mc_init_interrupts       --> plda_pcie_init_irq
>>   msi interrupts related functions and irq domain
>>   (primary function is mc_handle_msi):
>>   mc_handle_msi            --> plda_handle_msi
>>   intx interrupts related functions and irq domain
>>   (primary function is mc_handle_intx):
>>   mc_handle_intx           --> plda_handle_intx
>>   event interrupts:
>>   mc_handle_event	   --> plda_handle_event
>> - For PolarFire implements non-plda local interrupt events, most of
>>   event interrupt process codes can not be re-used. PLDA implements
>>   new codes and irq domain ops like PolarFire.
>>   New event functions:
>>     plda_event_handler
>>     plda_pcie_event_map
>>     plda_ack_event_irq
>>     plda_mask_event_irq
>>     plda_unmask_event_irq
>>     plda_hwirq_to_mask
>> - plda_handle_event adds a new irqnum to event num mapping codes for
>>   PLDA local event except DMA engine interrupt events. The DMA engine
>>   interrupt events are implemented by vendors. So do not add these
>>   events. PolarFire PCIe uses get_events function pointer to get
>>   their events num.
> 
> There's a lot going on here, which makes this hard to review.  If
> possible, I suggest splitting this into multiple patches:
> 
>   - Move code to plda/ directory with no other changes
>   - Rename structs/functions from mc_* to plda_* with no other changes
>   - Add PolarFire-specific code
> 
Yeah, This is a lot modification. I will try to split more patches to get it easier
to review. maybe split IP register macros first, second rename structs/function only.
third add the new event mapping codes， at last add PolarFire-specific codes.
> Other general things:
> 
>   - Capitalize PLDA, IRQ, INTx, MSI, PCIe in commit logs, comments,
>     dmesg text
>   - Sort MAINTAINERS entries alphabetically; see
>     https://git.kernel.org/linus/c192ac735768
> 
ok
> Bjorn
