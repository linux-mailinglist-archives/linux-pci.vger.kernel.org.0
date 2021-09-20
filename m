Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5C411375
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhITLY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 07:24:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50516 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhITLY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 07:24:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KBMqGM075675;
        Mon, 20 Sep 2021 06:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632136972;
        bh=j3vJELj0Rm/vFv9+zWZ74XoUk9PbZCKPUbY2twBH8o0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EeemYHWxpBqvXQJXDBTh+Oblvqw8ECBQHlzWaa77aJu5UqNQPfpZXWU/2YIpgaDkF
         v9nDsYRGoKJ6v9aaJjxhGxdaaBdr9MxhErB2rZTIVnCH+KRlnrCr2R61YZAsZwhI3N
         ZDIEiakKj8AY3GliYRSno44g/j77Y3Cs/TUvv+80=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KBMq9g051430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 06:22:52 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 06:22:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 06:22:52 -0500
Received: from [10.250.232.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KBMnaq116306;
        Mon, 20 Sep 2021 06:22:50 -0500
Subject: Re: [PATCH 0/3] PCI/gic-v3-its: Add support for same ITS device ID
 for multiple PCIe devices
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <lokeshvutla@ti.com>
References: <20210920064133.14115-1-kishon@ti.com>
 <871r5jwqw3.wl-maz@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <96caa71f-2632-6eb7-e211-1c2f43a3be16@ti.com>
Date:   Mon, 20 Sep 2021 16:52:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <871r5jwqw3.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 20/09/21 2:44 pm, Marc Zyngier wrote:
> On Mon, 20 Sep 2021 07:41:30 +0100,
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> AM64 has an issue in that it doesn't trigger interrupt if the address
>> in the *pre_its_window* is not aligned to 8-bytes (this is due to an
>> invalid bridge configuration in HW).
>>
>> This means there will not be interrupts for devices with PCIe
>> requestor ID 0x1, 0x3, 0x5..., as the address in the pre-ITS window
>> would be 4 (1 << 2), 12 (3 << 2), 20 (5 << 2) respectively which are
>> not aligned to 8-bytes.
>>
>> The DT binding has specified "msi-map-mask" using which multiple PCIe
>> devices could be made to use the same ITS device ID.
>>
>> Add support in irq-gic-v3-its-pci-msi.c for such cases where multiple
>> PCIe devices are using the same ITS device ID.
>>
>> Kishon Vijay Abraham I (3):
>>   PCI: Add support in pci_walk_bus() to invoke callback matching RID
>>   PCI: Export find_pci_root_bus()
>>   irqchip/gic-v3-its: Include "msi-map-mask" for calculating nvecs
>>
>>  drivers/irqchip/irq-gic-v3-its-pci-msi.c | 21 ++++++++++++++++++++-
>>  drivers/pci/bus.c                        | 13 +++++++++----
>>  drivers/pci/host-bridge.c                |  3 ++-
>>  include/linux/pci.h                      |  8 ++++++--
>>  4 files changed, 37 insertions(+), 8 deletions(-)
> 
> What I don't see in this series is how you address the other part of
> the problem, which is your reuse of the Socionext hack. Please post a
> complete series addressing all the issues for this HW.

No additional patches are pending. Socionext configuration is used as is
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#n72

FWIW the issue that I address in this series is not observed with standalone USB
cards or NVMe cards. The issue was observed when I tried with a multi-function
PCIe card.

Thank You,
Kishon
