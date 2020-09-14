Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09E26849B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 08:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINGNv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 02:13:51 -0400
Received: from mail.loongson.cn ([114.242.206.163]:47200 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbgINGNv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 02:13:51 -0400
Received: from [10.130.0.155] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv98MCl9fQh4VAA--.5455S3;
        Mon, 14 Sep 2020 14:13:33 +0800 (CST)
Subject: Re: [RFC PATCH v2] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Lukas Wunner <lukas@wunner.de>
References: <1600028950-10644-1-git-send-email-yangtiezhu@loongson.cn>
 <20200914040625.GA20033@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>, oohall@gmail.com,
        rafael.j.wysocki@intel.com, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <43683243-f8e2-c555-447a-f108740c70e8@loongson.cn>
Date:   Mon, 14 Sep 2020 14:13:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200914040625.GA20033@wunner.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxv98MCl9fQh4VAA--.5455S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4rWryDuw1DCr1fuFyUZFb_yoW8uFykpF
        WDJa92yFy0qry7Xr43XFyxXF15JwsIy34Fkr18C3y3Wrs3Ar95trWrtF909wn5X3yvyFW7
        Ar95trn7GrWxJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1uc_DUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/14/2020 12:06 PM, Lukas Wunner wrote:
> On Mon, Sep 14, 2020 at 04:29:10AM +0800, Tiezhu Yang wrote:
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -143,6 +144,28 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>   	}
>>   
>>   	pcie_port_device_remove(dev);
>> +	pci_disable_device(dev);
>> +}
>> +
>> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
>> +{
>> +	if (pci_bridge_d3_possible(dev)) {
>> +		pm_runtime_forbid(&dev->dev);
>> +		pm_runtime_get_noresume(&dev->dev);
>> +		pm_runtime_dont_use_autosuspend(&dev->dev);
>> +	}
>> +
>> +	pcie_port_device_remove(dev);
>> +
>> +	/*
>> +	 * If this is a kexec reboot, turn off Bus Master bit on the
>> +	 * device to tell it to not continue to do DMA. Don't touch
>> +	 * devices in D3cold or unknown states.
>> +	 * If it is not a kexec reboot, firmware will hit the PCI
>> +	 * devices with big hammer and stop their DMA any way.
>> +	 */
>> +	if (kexec_in_progress && (dev->current_state <= PCI_D3hot))
>> +		pci_disable_device(dev);
> The last portion of this function is already executed afterwards by
> pci_device_shutdown().  You don't need to duplicate it here:
>
> device_shutdown()
>    dev->bus->shutdown() == pci_device_shutdown()
>      drv->shutdown() == pcie_portdrv_shutdown()
>        pci_disable_device()
>      pci_disable_device()

pcie_port_device_remove() deletes pci_disable_device(dev)  at the beginning of this patch.


diff 
<https://lore.kernel.org/linux-pci/CAAhV-H5-X9OcBe3iRxF8PnKW-0j_10FVqm8cbiqW2-Lv4mTTdQ@mail.gmail.com/T/#iZ2e.:..:1600028950-10644-1-git-send-email-yangtiezhu::40loongson.cn:0drivers:pci:pcie:portdrv_core.c> 
--git a/drivers/pci/pcie/portdrv_core.c 
b/drivers/pci/pcie/portdrv_core.c index 50a9522..1991aca 100644 --- 
a/drivers/pci/pcie/portdrv_core.c +++ b/drivers/pci/pcie/portdrv_core.c 
@@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)   {
  	device_for_each_child(&dev->dev, NULL, remove_iter);
  	pci_free_irq_vectors(dev);
- pci_disable_device(dev);   }

>
> Thanks,
>
> Lukas

