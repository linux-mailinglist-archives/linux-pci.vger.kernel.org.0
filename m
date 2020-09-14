Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3091268B52
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgINMn0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 08:43:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:37104 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgINMdt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 08:33:49 -0400
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf90PY19fBTYVAA--.5827S3;
        Mon, 14 Sep 2020 20:33:20 +0800 (CST)
Subject: Re: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Huacai Chen <chenhuacai@gmail.com>
References: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn>
 <tencent_13F0F91E196BCF3F0E458509@qq.com>
 <CAAhV-H4ogJYcK9E9hQ663dGcJn4GjWZUSp47xgzTtjAZ-nrybA@mail.gmail.com>
 <45a3e3a0-3dc6-e60e-9381-b436a7d6889a@loongson.cn>
 <CAAhV-H5t1gCgBHtx=+Lu-9Fb7syJr0TsqdHc0qYQOfhXs-fJcQ@mail.gmail.com>
 <db559a40-a36e-a97b-703e-86ae1f0254a1@loongson.cn>
 <13b939f7-0e63-e81f-ae16-a620a0a765ff@wanyeetech.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>, git <git@xen0n.name>,
        Huacai Chen <chenhc@lemote.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b47a0e17-5006-9479-42db-ce52a6e358a4@loongson.cn>
Date:   Mon, 14 Sep 2020 20:33:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <13b939f7-0e63-e81f-ae16-a620a0a765ff@wanyeetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxf90PY19fBTYVAA--.5827S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry3Wr48Ar47Aw47Kr1kAFb_yoW3GF4DpF
        ZrJa1qyrWUJry2qr12qF1UXFy5tr1qy348Xr1UG343WrsFkr1UJr47JF1j9FykJrZ5CF17
        JryDtryxWFyUJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOAwIDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/14/2020 08:06 PM, Zhou Yanjie wrote:
> Hello Tiezhu
>
> 在 2020/9/14 下午7:24, Tiezhu Yang 写道:
>> On 09/14/2020 05:46 PM, Huacai Chen wrote:
>>> Hi, Tiezhu,
>>>
>>> On Mon, Sep 14, 2020 at 5:30 PM Tiezhu Yang <yangtiezhu@loongson.cn> 
>>> wrote:
>>>> On 09/14/2020 04:52 PM, Huacai Chen wrote:
>>>>> Hi, Tiezhu,
>>>>>
>>>>> How do you test kexec? kexec -e or systemctl kexec? Or both?
>>>> kexec -l vmlinux --append="root=/dev/sda2 console=ttyS0,115200"
>>>> kexec -e
>>> So you haven't tested "systemctl kexec"?
>>
>> Yes, the distro I used is Loongnix which has not kexec service now.
>> Is there any problem when use systemctl kexec? If you have more details,
>> please let me know.
>>
>
> It is inevitable that there will be some omissions during testing. 
> This is understandable, but what I am more curious about is why you 
> send the patch that Huacai has already sent every time. Why not 
> strengthen communication with Huacai and avoid duplication of work?

Oh, maybe there exists some misunderstanding, let me explain it.

when I update the latest kernel, the shutdown or reboot failed, I debug it
and try to solve it, then I sent a RFC patch.

I notice that there exists a similar patch by Huacai until Bjorn Helgaas cc
Huacai's patch to me. Because I have a different thought, so I sent RFC v2
and v3.

I think cc the related people at first can avoid this case.

>
>
>>>
>>> Huacai
>>>>> P.S., Please also CC my gmail (chenhuacai@gmail.com) since lemote.com
>>>>> has some communication problems.
>>>> OK, no problem.
>>>>
>>>>> Huacai
>>>>>
>>>>>> 陈华才江苏航天龙梦信息技术有限公司/研发中心/软件部 ------------------ 
>>>>>> Original ------------------From: "Tiezhu 
>>>>>> Yang"<yangtiezhu@loongson.cn>;Date:  Mon, Sep 14, 2020 03:57 
>>>>>> PMTo:  "Bjorn Helgaas"<bhelgaas@google.com>; Cc: 
>>>>>> "linux-pci"<linux-pci@vger.kernel.org>; 
>>>>>> "linux-kernel"<linux-kernel@vger.kernel.org>; "Rafael J. 
>>>>>> Wysocki"<rafael.j.wysocki@intel.com>; "Konstantin 
>>>>>> Khlebnikov"<khlebnikov@openvz.org>; "Khalid 
>>>>>> Aziz"<khalid.aziz@oracle.com>; "Vivek Goyal"<vgoyal@redhat.com>; 
>>>>>> "Lukas Wunner"<lukas@wunner.de>; "Oliver 
>>>>>> O'Halloran"<oohall@gmail.com>; "Huacai Chen"<chenhc@lemote.com>; 
>>>>>> "Jiaxun Yang"<jiaxun.yang@flygoat.com>; "Xuefeng 
>>>>>> Li"<lixuefeng@loongson.cn>; Subject:  [RFC PATCH v3] PCI/portdrv: 
>>>>>> Only disable Bus Master on kexec reboot and connected PCI devices 
>>>>>> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
>>>>>> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
>>>>>> services during shutdown"), it also calls pci_disable_device() 
>>>>>> during
>>>>>> shutdown, this leads to shutdown or reboot failure occasionally 
>>>>>> due to
>>>>>> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().
>>>>>>
>>>>>> drivers/pci/pci.c
>>>>>> static void do_pci_disable_device(struct pci_dev *dev)
>>>>>> {
>>>>>>           u16 pci_command;
>>>>>>
>>>>>>           pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>>>>>>           if (pci_command & PCI_COMMAND_MASTER) {
>>>>>>                   pci_command &= ~PCI_COMMAND_MASTER;
>>>>>>                   pci_write_config_word(dev, PCI_COMMAND, 
>>>>>> pci_command);
>>>>>>           }
>>>>>>
>>>>>>           pcibios_disable_device(dev);
>>>>>> }
>>>>>>
>>>>>> When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work 
>>>>>> well when
>>>>>> shutdown or reboot.
>>>>>>
>>>>>> As Oliver O'Halloran said, no need to call pci_disable_device() when
>>>>>> actually shutting down, but we should call pci_disable_device() 
>>>>>> before
>>>>>> handing over to the new kernel on kexec reboot, so we can do some
>>>>>> condition checks which are already executed afterwards by the 
>>>>>> function
>>>>>> pci_device_shutdown(), this is done by commit 4fc9bbf98fd6 ("PCI: 
>>>>>> Disable
>>>>>> Bus Master only on kexec reboot") and commit 6e0eda3c3898 ("PCI: 
>>>>>> Don't try
>>>>>> to disable Bus Master on disconnected PCI devices").
>>>>>>
>>>>>> drivers/pci/pci-driver.c
>>>>>> static void pci_device_shutdown(struct device *dev)
>>>>>> {
>>>>>>    ...
>>>>>>           if (drv && drv->shutdown)
>>>>>>                   drv->shutdown(pci_dev);
>>>>>>
>>>>>>           /*
>>>>>>            * If this is a kexec reboot, turn off Bus Master bit 
>>>>>> on the
>>>>>>            * device to tell it to not continue to do DMA. Don't 
>>>>>> touch
>>>>>>            * devices in D3cold or unknown states.
>>>>>>            * If it is not a kexec reboot, firmware will hit the PCI
>>>>>>            * devices with big hammer and stop their DMA any way.
>>>>>>            */
>>>>>>           if (kexec_in_progress && (pci_dev->current_state <= 
>>>>>> PCI_D3hot))
>>>>>>                   pci_clear_master(pci_dev);
>>>>>> }
>>>>>>
>>>>>> [   36.159446] Call Trace:
>>>>>> [   36.241688] [<ffffffff80211434>] show_stack+0x9c/0x130
>>>>>> [   36.326619] [<ffffffff80661b70>] dump_stack+0xb0/0xf0
>>>>>> [   36.410403] [<ffffffff806a8240>] pcie_portdrv_shutdown+0x18/0x78
>>>>>> [   36.495302] [<ffffffff8069c6b4>] pci_device_shutdown+0x44/0x90
>>>>>> [   36.580027] [<ffffffff807aac90>] device_shutdown+0x130/0x290
>>>>>> [   36.664486] [<ffffffff80265448>] kernel_power_off+0x38/0x80
>>>>>> [   36.748272] [<ffffffff80265634>] __do_sys_reboot+0x1a4/0x258
>>>>>> [   36.831985] [<ffffffff80218b90>] syscall_common+0x34/0x58
>>>>>>
>>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>>> ---
>>>>>>    drivers/pci/pcie/portdrv_core.c |  1 -
>>>>>>    drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
>>>>>>    2 files changed, 13 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pcie/portdrv_core.c 
>>>>>> b/drivers/pci/pcie/portdrv_core.c
>>>>>> index 50a9522..1991aca 100644
>>>>>> --- a/drivers/pci/pcie/portdrv_core.c
>>>>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>>>>> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev 
>>>>>> *dev)
>>>>>>    {
>>>>>>           device_for_each_child(&dev->dev, NULL, remove_iter);
>>>>>>           pci_free_irq_vectors(dev);
>>>>>> -       pci_disable_device(dev);
>>>>>>    }
>>>>>>
>>>>>>    /**
>>>>>> diff --git a/drivers/pci/pcie/portdrv_pci.c 
>>>>>> b/drivers/pci/pcie/portdrv_pci.c
>>>>>> index 3a3ce40..cab37a8 100644
>>>>>> --- a/drivers/pci/pcie/portdrv_pci.c
>>>>>> +++ b/drivers/pci/pcie/portdrv_pci.c
>>>>>> @@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct 
>>>>>> pci_dev *dev)
>>>>>>           }
>>>>>>
>>>>>>           pcie_port_device_remove(dev);
>>>>>> +       pci_disable_device(dev);
>>>>>> +}
>>>>>> +
>>>>>> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>>>>> +{
>>>>>> +       if (pci_bridge_d3_possible(dev)) {
>>>>>> +               pm_runtime_forbid(&dev->dev);
>>>>>> + pm_runtime_get_noresume(&dev->dev);
>>>>>> + pm_runtime_dont_use_autosuspend(&dev->dev);
>>>>>> +       }
>>>>>> +
>>>>>> +       pcie_port_device_remove(dev);
>>>>>>    }
>>>>>>
>>>>>>    static pci_ers_result_t pcie_portdrv_error_detected(struct 
>>>>>> pci_dev *dev,
>>>>>> @@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver = {
>>>>>>
>>>>>>           .probe          = pcie_portdrv_probe,
>>>>>>           .remove         = pcie_portdrv_remove,
>>>>>> -       .shutdown       = pcie_portdrv_remove,
>>>>>> +       .shutdown       = pcie_portdrv_shutdown,
>>>>>>
>>>>>>           .err_handler    = &pcie_portdrv_err_handler,
>>>>>>
>>>>>> -- 
>>>>>> 2.1.0

