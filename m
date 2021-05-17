Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF427382D49
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhEQNWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 09:22:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39770 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhEQNWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 09:22:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14HDLBiG069884;
        Mon, 17 May 2021 08:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621257671;
        bh=aKJhphHTIRz/4OvbHwmcRnGbnQph6vycfFRpDRJ4ZTQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y6ONEvtWW8yJl7ikIF/WZmnNX6D/zs73ktDaaR8tx00/h0vg0Zsi1fUVKGuj9HjI0
         cMkr3f0Pg/Tcec5nXy3Bp49FoG+Ot27PCx1eYip+3yLNv5oJjZbkZ/TjY+bWuhfQro
         SjUzh82+jcCDvBEGZ58DGAssywV4wV2mF7ROEKII=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14HDLBN1060693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 08:21:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 08:21:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 08:21:10 -0500
Received: from [10.250.232.247] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14HDL6G1130696;
        Mon, 17 May 2021 08:21:07 -0500
Subject: Re: [PATCH 0/6] PCI: Add legacy interrupt support in Keystone
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210325090026.8843-1-kishon@ti.com>
 <CAH9NwWeOysq9yLheFAXgX0c7bOZAAX7ZuQHXM9Rmb1an_Z5ZYg@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <692ce108-c85f-7aa6-8e9e-987d54703e93@ti.com>
Date:   Mon, 17 May 2021 18:51:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAH9NwWeOysq9yLheFAXgX0c7bOZAAX7ZuQHXM9Rmb1an_Z5ZYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christian,

On 17/05/21 6:45 pm, Christian Gmeiner wrote:
> Hi
> 
> Am Do., 25. März 2021 um 10:04 Uhr schrieb Kishon Vijay Abraham I
> <kishon@ti.com>:
>>
>> Keystone driver is used by K2G and AM65 and the interrupt handling of
>> both of them is different. Add support to handle legacy interrupt for
>> both K2G and AM65 here.
>>
>> Some discussions regarding this was already done here [1] and it was
>> around having pulse interrupt for legacy interrupt.
>>
>> The HW interrupt line connected to GIC is a pulse interrupt whereas
>> the legacy interrupts by definition is level interrupt. In order to
>> provide level interrupt functionality to edge interrupt line, PCIe
>> in AM654 has provided IRQ_EOI register. When the SW writes to IRQ_EOI
>> register after handling the interrupt, the IP checks the state of
>> legacy interrupt and re-triggers pulse interrupt invoking the handler
>> again.
>>
>> Patch series also includes converting AM65 binding to YAML and an
>> errata applicable for i2037.
>>
>> [1] -> https://lore.kernel.org/linux-arm-kernel/20190221101518.22604-4-kishon@ti.com/
>>
>> Kishon Vijay Abraham I (6):
>>   dt-bindings: PCI: ti,am65: Add PCIe host mode dt-bindings for TI's
>>     AM65 SoC
>>   dt-bindings: PCI: ti,am65: Add PCIe endpoint mode dt-bindings for TI's
>>     AM65 SoC
>>   irqdomain: Export of_phandle_args_to_fwspec()
>>   PCI: keystone: Convert to using hierarchy domain for legacy interrupts
>>   PCI: keystone: Add PCI legacy interrupt support for AM654
>>   PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
>>
>>  .../bindings/pci/ti,am65-pci-ep.yaml          |  80 ++++
>>  .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++
>>  drivers/pci/controller/dwc/pci-keystone.c     | 343 +++++++++++++-----
>>  include/linux/irqdomain.h                     |   2 +
>>  kernel/irq/irqdomain.c                        |   6 +-
>>  5 files changed, 440 insertions(+), 102 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
>>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>>
>> --
>> 2.17.1
>>
> 
> Is there somewhere an updated version of this patch series?

I haven't posted an updated version yet. My plan was to re-work and post
it by early June.

Thanks
Kishon
