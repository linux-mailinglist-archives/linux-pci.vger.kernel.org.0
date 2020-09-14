Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E951326885B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgINJa0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 05:30:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60696 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbgINJaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 05:30:25 -0400
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT8cTOF9flSsVAA--.5509S3;
        Mon, 14 Sep 2020 17:29:57 +0800 (CST)
Subject: Re: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn>
 <tencent_13F0F91E196BCF3F0E458509@qq.com>
 <CAAhV-H4ogJYcK9E9hQ663dGcJn4GjWZUSp47xgzTtjAZ-nrybA@mail.gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        zhouyanjie <zhouyanjie@wanyeetech.com>, git <git@xen0n.name>,
        Huacai Chen <chenhc@lemote.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <45a3e3a0-3dc6-e60e-9381-b436a7d6889a@loongson.cn>
Date:   Mon, 14 Sep 2020 17:29:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4ogJYcK9E9hQ663dGcJn4GjWZUSp47xgzTtjAZ-nrybA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxT8cTOF9flSsVAA--.5509S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw13XrWUWry8ZryfAryxXwb_yoW7Cry3pF
        ZxJFZFyFW0qry2gr4aqFyUZFy5XanFy340kry8G34fWrs2kry8tFW7tFyag34DArZY9F17
        JayDt3s7GFyUJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUsTmhUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/14/2020 04:52 PM, Huacai Chen wrote:
> Hi, Tiezhu,
>
> How do you test kexec? kexec -e or systemctl kexec? Or both?

kexec -l vmlinux --append="root=/dev/sda2 console=ttyS0,115200"
kexec -e

> P.S., Please also CC my gmail (chenhuacai@gmail.com) since lemote.com
> has some communication problems.

OK, no problem.

>
> Huacai
>
>> 陈华才江苏航天龙梦信息技术有限公司/研发中心/软件部   ------------------ Original ------------------From:  "Tiezhu Yang"<yangtiezhu@loongson.cn>;Date:  Mon, Sep 14, 2020 03:57 PMTo:  "Bjorn Helgaas"<bhelgaas@google.com>; Cc:  "linux-pci"<linux-pci@vger.kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>; "Rafael J. Wysocki"<rafael.j.wysocki@intel.com>; "Konstantin Khlebnikov"<khlebnikov@openvz.org>; "Khalid Aziz"<khalid.aziz@oracle.com>; "Vivek Goyal"<vgoyal@redhat.com>; "Lukas Wunner"<lukas@wunner.de>; "Oliver O'Halloran"<oohall@gmail.com>; "Huacai Chen"<chenhc@lemote.com>; "Jiaxun Yang"<jiaxun.yang@flygoat.com>; "Xuefeng Li"<lixuefeng@loongson.cn>; Subject:  [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec reboot and connected PCI devices After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
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
>> When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
>> shutdown or reboot.
>>
>> As Oliver O'Halloran said, no need to call pci_disable_device() when
>> actually shutting down, but we should call pci_disable_device() before
>> handing over to the new kernel on kexec reboot, so we can do some
>> condition checks which are already executed afterwards by the function
>> pci_device_shutdown(), this is done by commit 4fc9bbf98fd6 ("PCI: Disable
>> Bus Master only on kexec reboot") and commit 6e0eda3c3898 ("PCI: Don't try
>> to disable Bus Master on disconnected PCI devices").
>>
>> drivers/pci/pci-driver.c
>> static void pci_device_shutdown(struct device *dev)
>> {
>>   ...
>>          if (drv && drv->shutdown)
>>                  drv->shutdown(pci_dev);
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
>>
>> [   36.159446] Call Trace:
>> [   36.241688] [<ffffffff80211434>] show_stack+0x9c/0x130
>> [   36.326619] [<ffffffff80661b70>] dump_stack+0xb0/0xf0
>> [   36.410403] [<ffffffff806a8240>] pcie_portdrv_shutdown+0x18/0x78
>> [   36.495302] [<ffffffff8069c6b4>] pci_device_shutdown+0x44/0x90
>> [   36.580027] [<ffffffff807aac90>] device_shutdown+0x130/0x290
>> [   36.664486] [<ffffffff80265448>] kernel_power_off+0x38/0x80
>> [   36.748272] [<ffffffff80265634>] __do_sys_reboot+0x1a4/0x258
>> [   36.831985] [<ffffffff80218b90>] syscall_common+0x34/0x58
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   drivers/pci/pcie/portdrv_core.c |  1 -
>>   drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
>>   2 files changed, 13 insertions(+), 2 deletions(-)
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
>> index 3a3ce40..cab37a8 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
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
>>   }
>>
>>   static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>> @@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver = {
>>
>>          .probe          = pcie_portdrv_probe,
>>          .remove         = pcie_portdrv_remove,
>> -       .shutdown       = pcie_portdrv_remove,
>> +       .shutdown       = pcie_portdrv_shutdown,
>>
>>          .err_handler    = &pcie_portdrv_err_handler,
>>
>> --
>> 2.1.0

