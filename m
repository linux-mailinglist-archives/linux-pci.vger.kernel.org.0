Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AAD2B7F0B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 15:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgKROFu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 18 Nov 2020 09:05:50 -0500
Received: from lonlinode-sdnproxy-1.icoremail.net ([139.162.193.133]:57650
        "HELO lonlinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726325AbgKROFu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 09:05:50 -0500
Received: from [192.168.0.104] (unknown [113.247.217.134])
        by c1app7 (Coremail) with SMTP id BwINCgBXj5AqKrVfJQSyAA--.31695S2;
        Wed, 18 Nov 2020 22:05:30 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH V2] acpi/irq: Add stacked IRQ domain support to PCI
 interrupt link
From:   Chen Baozi <chenbaozi@phytium.com.cn>
In-Reply-To: <20201118095129.GA20571@e121166-lin.cambridge.arm.com>
Date:   Wed, 18 Nov 2020 22:05:29 +0800
Cc:     Marc Zyngier <maz@kernel.org>, Guohanjun <guohanjun@huawei.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <17EDC3AB-FF11-4624-912E-95832DB20804@phytium.com.cn>
References: <20201117134214.970-1-chenbaozi@phytium.com.cn>
 <20201118095129.GA20571@e121166-lin.cambridge.arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-CM-TRANSID: BwINCgBXj5AqKrVfJQSyAA--.31695S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur13Wr4kWw45ur45JFykGrg_yoW5XF4rpF
        WUK393AFWDCF43Ga9rX3W8JryFvanxA398G3s3A3yjv343ZF10gFyIkF4rGFy3Cwsa9w12
        vF4jy34rWasrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6ry5MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8fnY5UUUUU==
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiAQPgP17E3YHxogAAsI
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> On Nov 18, 2020, at 5:51 PM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> On Tue, Nov 17, 2020 at 09:42:14PM +0800, Chen Baozi wrote:
>> Some PCIe designs require software to do extra acknowledgements for
>> legacy INTx interrupts. If the driver is written only for device tree,
>> things are simple. In that case, a new driver can be written under
>> driver/pci/controller/ with a DT node of PCIe host written like:
>> 
>>  pcie {
>>    ...
>>    interrupt-map = <0 0 0  1  &pcie_intc 0>,
>>                    <0 0 0  2  &pcie_intc 1>,
>>                    <0 0 0  3  &pcie_intc 2>,
>>                    <0 0 0  4  &pcie_intc 3>;
>> 
>>    pcie_intc: legacy-interrupt-controller {
>>      interrupt-controller;
>>      #interrupt-cells = <1>;
>>      interrupt-parent = <&gic>;
>>      interrupts = <0 226 4>;
>>    };
>>  };
>> 
>> Similar designs can be found on Aardvark, MediaTek Gen2 and Socionext
>> UniPhier PCIe controller at the moment. Essentially, those designs are
>> supported by inserting an extra interrupt controller between PCIe host
>> and GIC and parse the topology in a DT-based PCI controller driver.
>> As we turn to ACPI, All the PCIe hosts are described the same ID of
>> "PNP0A03" and share driver/acpi/pci_root.c. It comes to be a problem
>> to make this kind of PCI INTx work under ACPI.
> 
> In this respect this patch is a minor detail. The major detail is how
> those host controllers are going to probe and initialize with ACPI and I
> am against merging this patch stand alone with no user before
> understanding what you really want to do with those host controller
> drivers in the ACPI world.
> 
> Side note, there is ongoing work for a generic interrupt MUX:
> 
> https://bugzilla.tianocore.org/show_bug.cgi?id=2995
> 
> If we ever come to support those MUXes with ACPI that must be a
> starting point, the binding above can be your first "user".
> 
> I still have reservations about bootstrapping the host controllers
> you mentioned in platforms with no firmware support whatsoever for
> PCI initialization (eg address decoders, link bring-up, etc. - the
> ACPI host bridge model relies on FW to carry out that initialization)
> with ACPI - I would like to see the whole picture first.

Frankly, I’m also waiting for my first “user” to be announced at the moment,
so that I can make the whole picture clearer. And it is why I mark this
patch as an RFC. 

Yes. I admit it is a little weird to add another interrupt controller
between the GIC and INTx device. But if it is not only about
initialization but also about hooking into the INTx processing (e.g.,
introduce an extra ack operation...), it seems we cannot only rely
on FW. I have looked for a FW solution without introducing a new
driver later but failed... I’m happy to be fixed if there is a pure
FW solution.

Thanks.

Baozi.

