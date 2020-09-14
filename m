Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317B12684A8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 08:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINGRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 02:17:40 -0400
Received: from mail.loongson.cn ([114.242.206.163]:48156 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgINGRe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 02:17:34 -0400
Received: from [10.130.0.155] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX8fsCl9fdx4VAA--.5787S3;
        Mon, 14 Sep 2020 14:17:17 +0800 (CST)
Subject: Re: [RFC PATCH v2] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1600028950-10644-1-git-send-email-yangtiezhu@loongson.cn>
 <tencent_44F0201A70619BA613F16BA4@qq.com>
 <CAAhV-H5-X9OcBe3iRxF8PnKW-0j_10FVqm8cbiqW2-Lv4mTTdQ@mail.gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, oohall <oohall@gmail.com>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhouyanjie <zhouyanjie@wanyeetech.com>, git <git@xen0n.name>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <939d35d9-bbe7-3fef-7fc6-ff331d8f5010@loongson.cn>
Date:   Mon, 14 Sep 2020 14:17:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5-X9OcBe3iRxF8PnKW-0j_10FVqm8cbiqW2-Lv4mTTdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxX8fsCl9fdx4VAA--.5787S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary3tr18tw1rZr4UAw4DCFg_yoW7Xw47pF
        ZxJa92yFWFqry2gr4avFyUuFy5XwsFy348Kry8G343Wr42yryktFWxtFyY9a4kZrZYgF17
        JF98Jr97GFyUJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnc_TUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/14/2020 12:31 PM, Huacai Chen wrote:
> Hi, Tiezhu
>
>> ------------------ Original ------------------
>> From:  "Tiezhu Yang"<yangtiezhu@loongson.cn>;
>> Date:  Mon, Sep 14, 2020 04:29 AM
>> To:  "Bjorn Helgaas"<bhelgaas@google.com>;
>> Cc:  "Konstantin Khlebnikov"<khlebnikov@openvz.org>; "Khalid Aziz"<khalid.aziz@oracle.com>; "Vivek Goyal"<vgoyal@redhat.com>; "Lukas Wunner"<lukas@wunner.de>; "oohall"<oohall@gmail.com>; "rafael.j.wysocki"<rafael.j.wysocki@intel.com>; "Xuefeng Li"<lixuefeng@loongson.cn>; "Huacai Chen"<chenhc@lemote.com>; "Jiaxun Yang"<jiaxun.yang@flygoat.com>; "linux-pci"<linux-pci@vger.kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>;
>> Subject:  [RFC PATCH v2] PCI/portdrv: Only disable Bus Master on kexec reboot and connected PCI devices
>>
>>
>>
>> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
>> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
>> services during shutdown"), it also calls pci_disable_device() during
>> shutdown, this leads to shutdown or reboot failure occasionally due to
>> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().
>>
>> drivers/pci/pci.c
>> static void do_pci_disable_device(struct pci_dev *dev)
>> {
>>          u16 pci_command;
>>
>>          pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>>          if (pci_command & PCI_COMMAND_MASTER) {
>>                  pci_command &= ~PCI_COMMAND_MASTER;
>>                  pci_write_config_word(dev, PCI_COMMAND, pci_command);
>>          }
>>
>>          pcibios_disable_device(dev);
>> }
>>
>> When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well.
>>
>> As Oliver O'Halloran said, no need to call pci_disable_device() when
>> actually shutting down, but we should call pci_disable_device() before
>> handing over to the new kernel on kexec reboot, so we can do some
>> condition checks which are similar with pci_device_shutdown(), this is
>> done by commit 4fc9bbf98fd6 ("PCI: Disable Bus Master only on kexec
>> reboot") and commit 6e0eda3c3898 ("PCI: Don't try to disable Bus Master
>> on disconnected PCI devices").
>>
>> drivers/pci/pci-driver.c
>> static void pci_device_shutdown(struct device *dev)
>> {
>> ...
>>
>>          /*
>>           * If this is a kexec reboot, turn off Bus Master bit on the
>>           * device to tell it to not continue to do DMA. Don't touch
>>           * devices in D3cold or unknown states.
>>           * If it is not a kexec reboot, firmware will hit the PCI
>>           * devices with big hammer and stop their DMA any way.
>>           */
>>          if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
>>                  pci_clear_master(pci_dev);
>> }
> Have you really tried kexec? Why do you think kexec can disable pci
> device successfully while normal reboot/poweroff cannot?

Yes, I test it on kexec reboot,  it  works well.

>
> Huacai
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   drivers/pci/pcie/portdrv_core.c |  1 -
>>   drivers/pci/pcie/portdrv_pci.c  | 25 ++++++++++++++++++++++++-
>>   2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 50a9522..1991aca 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>>   {
>>          device_for_each_child(&dev->dev, NULL, remove_iter);
>>          pci_free_irq_vectors(dev);
>> -       pci_disable_device(dev);
>>   }
>>
>>   /**
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
>> index 3a3ce40..ce89a9e8 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/init.h>
>>   #include <linux/aer.h>
>>   #include <linux/dmi.h>
>> +#include <linux/kexec.h>
>>
>>   #include "../pci.h"
>>   #include "portdrv.h"
>> @@ -143,6 +144,28 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>          }
>>
>>          pcie_port_device_remove(dev);
>> +       pci_disable_device(dev);
>> +}
>> +
>> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
>> +{
>> +       if (pci_bridge_d3_possible(dev)) {
>> +               pm_runtime_forbid(&dev->dev);
>> +               pm_runtime_get_noresume(&dev->dev);
>> +               pm_runtime_dont_use_autosuspend(&dev->dev);
>> +       }
>> +
>> +       pcie_port_device_remove(dev);
>> +
>> +       /*
>> +        * If this is a kexec reboot, turn off Bus Master bit on the
>> +        * device to tell it to not continue to do DMA. Don't touch
>> +        * devices in D3cold or unknown states.
>> +        * If it is not a kexec reboot, firmware will hit the PCI
>> +        * devices with big hammer and stop their DMA any way.
>> +        */
>> +       if (kexec_in_progress && (dev->current_state <= PCI_D3hot))
>> +               pci_disable_device(dev);
>>   }
>>
>>   static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>> @@ -211,7 +234,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>>
>>          .probe          = pcie_portdrv_probe,
>>          .remove         = pcie_portdrv_remove,
>> -       .shutdown       = pcie_portdrv_remove,
>> +       .shutdown       = pcie_portdrv_shutdown,
>>
>>          .err_handler    = &pcie_portdrv_err_handler,
>>
>> --
>> 1.8.3.1

