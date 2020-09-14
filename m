Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B62693D8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 19:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgINRnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 13:43:49 -0400
Received: from out28-52.mail.aliyun.com ([115.124.28.52]:33380 "EHLO
        out28-52.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgINMGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 08:06:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743629|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0574032-0.0013211-0.941276;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.IWz8lxr_1600085165;
Received: from 192.168.10.195(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IWz8lxr_1600085165)
          by smtp.aliyun-inc.com(10.147.42.135);
          Mon, 14 Sep 2020 20:06:07 +0800
Subject: Re: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
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
References: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn>
 <tencent_13F0F91E196BCF3F0E458509@qq.com>
 <CAAhV-H4ogJYcK9E9hQ663dGcJn4GjWZUSp47xgzTtjAZ-nrybA@mail.gmail.com>
 <45a3e3a0-3dc6-e60e-9381-b436a7d6889a@loongson.cn>
 <CAAhV-H5t1gCgBHtx=+Lu-9Fb7syJr0TsqdHc0qYQOfhXs-fJcQ@mail.gmail.com>
 <db559a40-a36e-a97b-703e-86ae1f0254a1@loongson.cn>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <13b939f7-0e63-e81f-ae16-a620a0a765ff@wanyeetech.com>
Date:   Mon, 14 Sep 2020 20:06:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <db559a40-a36e-a97b-703e-86ae1f0254a1@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Tiezhu

在 2020/9/14 下午7:24, Tiezhu Yang 写道:
> On 09/14/2020 05:46 PM, Huacai Chen wrote:
>> Hi, Tiezhu,
>>
>> On Mon, Sep 14, 2020 at 5:30 PM Tiezhu Yang <yangtiezhu@loongson.cn> 
>> wrote:
>>> On 09/14/2020 04:52 PM, Huacai Chen wrote:
>>>> Hi, Tiezhu,
>>>>
>>>> How do you test kexec? kexec -e or systemctl kexec? Or both?
>>> kexec -l vmlinux --append="root=/dev/sda2 console=ttyS0,115200"
>>> kexec -e
>> So you haven't tested "systemctl kexec"?
>
> Yes, the distro I used is Loongnix which has not kexec service now.
> Is there any problem when use systemctl kexec? If you have more details,
> please let me know.
>

It is inevitable that there will be some omissions during testing. This 
is understandable, but what I am more curious about is why you send the 
patch that Huacai has already sent every time. Why not strengthen 
communication with Huacai and avoid duplication of work?


>>
>> Huacai
>>>> P.S., Please also CC my gmail (chenhuacai@gmail.com) since lemote.com
>>>> has some communication problems.
>>> OK, no problem.
>>>
>>>> Huacai
>>>>
>>>>> 陈华才江苏航天龙梦信息技术有限公司/研发中心/软件部 ------------------ 
>>>>> Original ------------------From: "Tiezhu 
>>>>> Yang"<yangtiezhu@loongson.cn>;Date:  Mon, Sep 14, 2020 03:57 
>>>>> PMTo:  "Bjorn Helgaas"<bhelgaas@google.com>; Cc: 
>>>>> "linux-pci"<linux-pci@vger.kernel.org>; 
>>>>> "linux-kernel"<linux-kernel@vger.kernel.org>; "Rafael J. 
>>>>> Wysocki"<rafael.j.wysocki@intel.com>; "Konstantin 
>>>>> Khlebnikov"<khlebnikov@openvz.org>; "Khalid 
>>>>> Aziz"<khalid.aziz@oracle.com>; "Vivek Goyal"<vgoyal@redhat.com>; 
>>>>> "Lukas Wunner"<lukas@wunner.de>; "Oliver 
>>>>> O'Halloran"<oohall@gmail.com>; "Huacai Chen"<chenhc@lemote.com>; 
>>>>> "Jiaxun Yang"<jiaxun.yang@flygoat.com>; "Xuefeng 
>>>>> Li"<lixuefeng@loongson.cn>; Subject:  [RFC PATCH v3] PCI/portdrv: 
>>>>> Only disable Bus Master on kexec reboot and connected PCI devices 
>>>>> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
>>>>> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
>>>>> services during shutdown"), it also calls pci_disable_device() during
>>>>> shutdown, this leads to shutdown or reboot failure occasionally 
>>>>> due to
>>>>> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().
>>>>>
>>>>> drivers/pci/pci.c
>>>>> static void do_pci_disable_device(struct pci_dev *dev)
>>>>> {
>>>>>           u16 pci_command;
>>>>>
>>>>>           pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>>>>>           if (pci_command & PCI_COMMAND_MASTER) {
>>>>>                   pci_command &= ~PCI_COMMAND_MASTER;
>>>>>                   pci_write_config_word(dev, PCI_COMMAND, 
>>>>> pci_command);
>>>>>           }
>>>>>
>>>>>           pcibios_disable_device(dev);
>>>>> }
>>>>>
>>>>> When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work 
>>>>> well when
>>>>> shutdown or reboot.
>>>>>
>>>>> As Oliver O'Halloran said, no need to call pci_disable_device() when
>>>>> actually shutting down, but we should call pci_disable_device() 
>>>>> before
>>>>> handing over to the new kernel on kexec reboot, so we can do some
>>>>> condition checks which are already executed afterwards by the 
>>>>> function
>>>>> pci_device_shutdown(), this is done by commit 4fc9bbf98fd6 ("PCI: 
>>>>> Disable
>>>>> Bus Master only on kexec reboot") and commit 6e0eda3c3898 ("PCI: 
>>>>> Don't try
>>>>> to disable Bus Master on disconnected PCI devices").
>>>>>
>>>>> drivers/pci/pci-driver.c
>>>>> static void pci_device_shutdown(struct device *dev)
>>>>> {
>>>>>    ...
>>>>>           if (drv && drv->shutdown)
>>>>>                   drv->shutdown(pci_dev);
>>>>>
>>>>>           /*
>>>>>            * If this is a kexec reboot, turn off Bus Master bit on 
>>>>> the
>>>>>            * device to tell it to not continue to do DMA. Don't touch
>>>>>            * devices in D3cold or unknown states.
>>>>>            * If it is not a kexec reboot, firmware will hit the PCI
>>>>>            * devices with big hammer and stop their DMA any way.
>>>>>            */
>>>>>           if (kexec_in_progress && (pci_dev->current_state <= 
>>>>> PCI_D3hot))
>>>>>                   pci_clear_master(pci_dev);
>>>>> }
>>>>>
>>>>> [   36.159446] Call Trace:
>>>>> [   36.241688] [<ffffffff80211434>] show_stack+0x9c/0x130
>>>>> [   36.326619] [<ffffffff80661b70>] dump_stack+0xb0/0xf0
>>>>> [   36.410403] [<ffffffff806a8240>] pcie_portdrv_shutdown+0x18/0x78
>>>>> [   36.495302] [<ffffffff8069c6b4>] pci_device_shutdown+0x44/0x90
>>>>> [   36.580027] [<ffffffff807aac90>] device_shutdown+0x130/0x290
>>>>> [   36.664486] [<ffffffff80265448>] kernel_power_off+0x38/0x80
>>>>> [   36.748272] [<ffffffff80265634>] __do_sys_reboot+0x1a4/0x258
>>>>> [   36.831985] [<ffffffff80218b90>] syscall_common+0x34/0x58
>>>>>
>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>> ---
>>>>>    drivers/pci/pcie/portdrv_core.c |  1 -
>>>>>    drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
>>>>>    2 files changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/portdrv_core.c 
>>>>> b/drivers/pci/pcie/portdrv_core.c
>>>>> index 50a9522..1991aca 100644
>>>>> --- a/drivers/pci/pcie/portdrv_core.c
>>>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>>>> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>>>>>    {
>>>>>           device_for_each_child(&dev->dev, NULL, remove_iter);
>>>>>           pci_free_irq_vectors(dev);
>>>>> -       pci_disable_device(dev);
>>>>>    }
>>>>>
>>>>>    /**
>>>>> diff --git a/drivers/pci/pcie/portdrv_pci.c 
>>>>> b/drivers/pci/pcie/portdrv_pci.c
>>>>> index 3a3ce40..cab37a8 100644
>>>>> --- a/drivers/pci/pcie/portdrv_pci.c
>>>>> +++ b/drivers/pci/pcie/portdrv_pci.c
>>>>> @@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct 
>>>>> pci_dev *dev)
>>>>>           }
>>>>>
>>>>>           pcie_port_device_remove(dev);
>>>>> +       pci_disable_device(dev);
>>>>> +}
>>>>> +
>>>>> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>>>> +{
>>>>> +       if (pci_bridge_d3_possible(dev)) {
>>>>> +               pm_runtime_forbid(&dev->dev);
>>>>> +               pm_runtime_get_noresume(&dev->dev);
>>>>> + pm_runtime_dont_use_autosuspend(&dev->dev);
>>>>> +       }
>>>>> +
>>>>> +       pcie_port_device_remove(dev);
>>>>>    }
>>>>>
>>>>>    static pci_ers_result_t pcie_portdrv_error_detected(struct 
>>>>> pci_dev *dev,
>>>>> @@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver = {
>>>>>
>>>>>           .probe          = pcie_portdrv_probe,
>>>>>           .remove         = pcie_portdrv_remove,
>>>>> -       .shutdown       = pcie_portdrv_remove,
>>>>> +       .shutdown       = pcie_portdrv_shutdown,
>>>>>
>>>>>           .err_handler    = &pcie_portdrv_err_handler,
>>>>>
>>>>> -- 
>>>>> 2.1.0
