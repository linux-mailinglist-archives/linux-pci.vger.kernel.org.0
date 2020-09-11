Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4178D265752
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 05:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgIKDUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 23:20:05 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53688 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgIKDUF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 23:20:05 -0400
Received: from [10.130.0.155] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9_a7FpfRnEUAA--.4009S3;
        Fri, 11 Sep 2020 11:19:55 +0800 (CST)
Subject: Re: [RFC PATCH] PCI/portdrv: No need to call pci_disable_device()
 during shutdown
To:     Oliver O'Halloran <oohall@gmail.com>
References: <20200910202106.GA811000@bjorn-Precision-5520>
 <b8f0d64d-8a29-aa4f-c764-397e87527600@loongson.cn>
 <CAOSf1CGM0SV2ux-TYv_N2frgZtqin8yfvh1wUDj+oMVmjr3GHQ@mail.gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <da291cff-4f56-c849-f0c3-3af1115bd06e@loongson.cn>
Date:   Fri, 11 Sep 2020 11:19:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAOSf1CGM0SV2ux-TYv_N2frgZtqin8yfvh1wUDj+oMVmjr3GHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxr9_a7FpfRnEUAA--.4009S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr45Xw1rZFW8KF4fCFWUCFg_yoW5ZF1UpF
        W3Ja4vk3yrWF12gwsIqr1UXFy5JwsFy34rtr18Gw43Cr4IyFyrtFWxta4Yva4UXa9Y9F12
        qa98ta48Way5JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUj8nY7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/11/2020 10:35 AM, Oliver O'Halloran wrote:
> On Fri, Sep 11, 2020 at 11:55 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>> On 09/11/2020 04:21 AM, Bjorn Helgaas wrote:
>>> [+cc Huacai]
>>>
>>> On Thu, Sep 10, 2020 at 02:41:39PM -0500, Bjorn Helgaas wrote:
>>>> On Sat, Sep 05, 2020 at 04:33:26PM +0800, Tiezhu Yang wrote:
>>>>> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
>>>>> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
>>>>> services during shutdown"), it also calls pci_disable_device() during
>>>>> shutdown, this seems unnecessary, so just remove it.
>>>> I would like to get rid of the portdrv completely by folding its
>>>> functionality into the PCI core itself, so there would be no portdrv
>>>> probe or remove.
>>>>
>>>> Does this solve a problem?
>> Yes, sometimes it can not shutdown or reboot normally with
>> pci_disable_device().
> Do you have any more details about what goes wrong here?

This issue is related with the operation "pci_command &= 
~PCI_COMMAND_MASTER;"
in the following function:

drivers/pci/pci.c
static void do_pci_disable_device(struct pci_dev *dev)
{
     u16 pci_command;

     pci_read_config_word(dev, PCI_COMMAND, &pci_command);
     if (pci_command & PCI_COMMAND_MASTER) {
         pci_command &= ~PCI_COMMAND_MASTER;
         pci_write_config_word(dev, PCI_COMMAND, pci_command);
     }

     pcibios_disable_device(dev);
}

When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well.

> Leaving
> devices enabled when actually shutting down probably doesn't matter.

Yes, I think so too.

> However, .shutdown() is also used when kexec()ing into a new kernel
> and we probably should be disabling devices before handing over to the
> new kernel.
>
> Is the real issue that we're closing the bridge windows before the
> endpoint drivers have had a chance to clean up?

I notice that check kexec_in_progress first before call pci_disable_devie()
in pci_device_shutdown(), can we do the similar thing in pcie?

drivers/pci/pci-driver.c
static void pci_device_shutdown(struct device *dev)
{
     struct pci_dev *pci_dev = to_pci_dev(dev);
     struct pci_driver *drv = pci_dev->driver;

     pm_runtime_resume(dev);

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

Something like this:

diff --git a/drivers/pci/pcie/portdrv_core.c 
b/drivers/pci/pcie/portdrv_core.c
index 50a9522..3de1dab 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -491,7 +491,8 @@ void pcie_port_device_remove(struct pci_dev *dev)
  {
         device_for_each_child(&dev->dev, NULL, remove_iter);
         pci_free_irq_vectors(dev);
-       pci_disable_device(dev);
+       if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+               pci_disable_device(dev);
  }

  /**

>
> Oliver

