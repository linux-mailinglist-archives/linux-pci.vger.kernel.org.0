Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28302273ABB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgIVGUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 02:20:47 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49552 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbgIVGUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 02:20:46 -0400
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_92yl2lf9_4WAA--.1914S3;
        Tue, 22 Sep 2020 14:20:35 +0800 (CST)
Subject: Re: [PATCH] PCI/portdrv: Don't disable pci device during shutdown
To:     Sinan Kaya <okaya@kernel.org>, Huacai Chen <chenhc@lemote.com>
References: <1600680138-10949-1-git-send-email-chenhc@lemote.com>
 <45e7272c-e074-d894-9319-ee29f451f282@kernel.org>
 <CAAhV-H6+57ss5p037r04-X7=YZrQnLUsLDB3GrR-_OPXiucUgw@mail.gmail.com>
 <d2fee988-d41d-d2c4-3420-a4258c5379aa@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <dbae169e-061c-9306-9e5c-40e268bff128@loongson.cn>
Date:   Tue, 22 Sep 2020 14:20:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d2fee988-d41d-d2c4-3420-a4258c5379aa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx_92yl2lf9_4WAA--.1914S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UWF1UKw4kGw1UJFWUArb_yoW8Kw15pF
        WDJas8ArWqgry2gw4xtry5J3W5Gr4Yva4fXw18G345uw4fWry5ArWxtFsa93WDGrZY9Fy7
        Ja9Fq3yxW34UXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxUkVWLUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/22/2020 12:30 PM, Sinan Kaya wrote:
> On 9/21/2020 10:11 PM, Huacai Chen wrote:
>>> his sounds like a quirk to me rather than a behavior that should be
>>> applied to all platforms.
>> Yes, this is very like a quirk, but it seems there are a lot of
>> platforms that have problems, and removing the pci_disable_device()
>> has no side effect.
> Why is there no side effect?
>
> AFAIK, kexec goes through the shutdown path and you are leaving a PCI
> device enabled during kexec boot which can corrupt the booting OS
> memory.

Hi,

The related kexec operations are already executed afterwards by the function
pci_device_shutdown(), this is done by commit 4fc9bbf98fd6 ("PCI: Disable
Bus Master only on kexec reboot") and commit 6e0eda3c3898 ("PCI: Don't try
to disable Bus Master on disconnected PCI devices").

drivers/pci/pci-driver.c
static void pci_device_shutdown(struct device *dev)
{
  ...
         if (drv && drv->shutdown)
                 drv->shutdown(pci_dev);

         /*
          * If this is a kexec reboot, turn off Bus Master bit on the
          * device to tell it to not continue to do DMA. Don't touch
          * devices in D3cold or unknown states.
          * If it is not a kexec reboot, firmware will hit the PCI
          * devices with big hammer and stop their DMA any way.
          */
         if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
                 pci_clear_master(pci_dev);
}

device_shutdown()
   dev->bus->shutdown() == pci_device_shutdown()
     drv->shutdown() == pcie_portdrv_shutdown()
     pci_disable_device()

[   36.159446] Call Trace:
[   36.241688] [<ffffffff80211434>] show_stack+0x9c/0x130
[   36.326619] [<ffffffff80661b70>] dump_stack+0xb0/0xf0
[   36.410403] [<ffffffff806a8240>] pcie_portdrv_shutdown+0x18/0x78
[   36.495302] [<ffffffff8069c6b4>] pci_device_shutdown+0x44/0x90
[   36.580027] [<ffffffff807aac90>] device_shutdown+0x130/0x290
[   36.664486] [<ffffffff80265448>] kernel_power_off+0x38/0x80
[   36.748272] [<ffffffff80265634>] __do_sys_reboot+0x1a4/0x258
[   36.831985] [<ffffffff80218b90>] syscall_common+0x34/0x58

Early discussions:
https://lore.kernel.org/patchwork/patch/1304917/#1499666
https://lore.kernel.org/patchwork/patch/1305067/


Thanks,
Tiezhu

>
> I don't think you can generalize a behavior based on a few quirky
> devices. You should be quirking only the device that has a problem
> rather than changing the behavior of all other platforms.

