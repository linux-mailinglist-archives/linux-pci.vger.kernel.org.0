Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E050E2B7B7A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 11:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgKRKiK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 18 Nov 2020 05:38:10 -0500
Received: from fralinode-sdnproxy-1.icoremail.net ([172.104.134.221]:61492
        "HELO fralinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725613AbgKRKiJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 05:38:09 -0500
Received: from [192.168.1.100] (unknown [218.77.105.7])
        by c1app9 (Coremail) with SMTP id CQINCgBHW519+bRfB5WGAA--.58353S2;
        Wed, 18 Nov 2020 18:37:50 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH V2] acpi/irq: Add stacked IRQ domain support to PCI
 interrupt link
From:   Chen Baozi <chenbaozi@phytium.com.cn>
In-Reply-To: <20201117185720.GA1397876@bjorn-Precision-5520>
Date:   Wed, 18 Nov 2020 18:37:49 +0800
Cc:     Ard Biesheuvel <ardb@kernel.org>, Guohanjun <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C1B76F68-1692-4E46-90BD-33BE74B445FF@phytium.com.cn>
References: <20201117185720.GA1397876@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-CM-TRANSID: CQINCgBHW519+bRfB5WGAA--.58353S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4fGw4kGr48tryUCF1kGrg_yoW5WFWrpF
        WrK3sxJrykGr4FyFn7Aw1FvFZ3ZwsxtFW5J34kG3y3Za15Xr1IgF1xtFW5X3ZrWrn3KF4S
        qF13t395Wa98XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
        wI1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x07bOlk3UUUUU=
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiDALgP17uHv9idwAAsV
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for reviewing. I’ll try to fix all existing issues and send a new
version later.

> On Nov 18, 2020, at 2:57 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> Nit: please don't just make up random styles for the subject.  Run
> "git log --oneline" on the file and/or the directory and try to follow
> the existing convention.  Using random styles adds noise to the
> system.
> 
> On Tue, Nov 17, 2020 at 09:42:14PM +0800, Chen Baozi wrote:
>> 
>> Therefore, we introduce an stacked IRQ domain support to PCI interrupt
>> link for ACPI. With this support, we can populate the ResourceSource
>> to refer to a device object that describes an interrupt controller.
>> That would allow us to refer to a dedicated driver which implements
>> the logic needed to manage the interrupt state. With this patch,
>> those PCI interrupt links can be supported by describing the INTx
>> in ACPI table as the following example:
> 
> "Stacked IRQ domain" sounds like a detail of how you're implementing
> support for the Resource Source field for PCI Interrupt Links.
> 
> I don't know what the dedicated driver refers to.  This *should* be
> all generic code the follows the ACPI spec (which is pretty sketchy in
> this area).  But I assume that there's no special driver needed for
> devices like \SB.IXIU, and the logic associated with the interrupt
> controller is in the AML associated with IXIU.  It would probably be
> useful to mention the relevant methods in the IXIU methods in the
> example below.
> 
> From ACPI v6.3, Table 6-200, it looks like this patch should include
> changes to acpi_bus_osc_support() to advertise "Interrupt
> ResourceSource support".

According to my understanding, does it mean to add something like：

+       capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_INTR_RS_SUPPORT;

and check whether the platform supports usage of ResourceSource after
acpi_run_osc() returns successfully:

+		osc_sb_intr_rs_support_confirmed =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_INTR_RS_SUPPORT;

with this bool value, we can then determine if we would ignore the
ResourceSource field later.

Or we just advertise this capability from the OS side without introducing
the ‘osc_sb_intr_rs_support_confirmed’?

I am not certain about it because:

1) If we strictly flow the spec, which says “the platform will indicate to
OS whether ... If not set, the OS may choose to ignore the ResourceSource
parameter in the extended interrupt descirptor”, this means this capability
can be used to determine whether we would ignore to parse the field later.

2) On the other hand, Since the ResourceSource has already been used to
create hierarchical domain for platform device (introduced by 621dc2fdcea1)
and previous driver does not check this capability, I am not sure whether
it would break the existing platforms. 

Fix me if I am wrong.

Cheers,

Chen Baozi.


