Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC32656C2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 03:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgIKBy6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 21:54:58 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34130 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgIKBy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 21:54:57 -0400
Received: from [10.130.0.155] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxeMXg2Fpf1moUAA--.4782S3;
        Fri, 11 Sep 2020 09:54:41 +0800 (CST)
Subject: Re: [RFC PATCH] PCI/portdrv: No need to call pci_disable_device()
 during shutdown
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200910202106.GA811000@bjorn-Precision-5520>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b8f0d64d-8a29-aa4f-c764-397e87527600@loongson.cn>
Date:   Fri, 11 Sep 2020 09:54:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200910202106.GA811000@bjorn-Precision-5520>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxeMXg2Fpf1moUAA--.4782S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWkXFy7KF4fAF17ZF48Crg_yoW5Ww1kpF
        WUGanIkFy0qry7Xr4ayFyUZFyYqFsFyry09r1xGw47ursFvr1kJFW3JF1Y9r95XrWkWFy7
        Jr97JFyfuFZ5JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUOgAwDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/11/2020 04:21 AM, Bjorn Helgaas wrote:
> [+cc Huacai]
>
> On Thu, Sep 10, 2020 at 02:41:39PM -0500, Bjorn Helgaas wrote:
>> On Sat, Sep 05, 2020 at 04:33:26PM +0800, Tiezhu Yang wrote:
>>> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
>>> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
>>> services during shutdown"), it also calls pci_disable_device() during
>>> shutdown, this seems unnecessary, so just remove it.
>> I would like to get rid of the portdrv completely by folding its
>> functionality into the PCI core itself, so there would be no portdrv
>> probe or remove.
>>
>> Does this solve a problem?

Yes, sometimes it can not shutdown or reboot normally with 
pci_disable_device().

>> If not, I'm inclined to just leave it
>> as-is for now.  But if it fixes something, we should do the fix, of
>> course.
> This looks awfully similar to [1], so I guess we *do* need to do
> something here.  I'll respond there since it has more details.
>
> [1] https://lore.kernel.org/r/1596268180-9114-1-git-send-email-chenhc@lemote.com
>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>   drivers/pci/pcie/portdrv_core.c |  1 -
>>>   drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
>>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>>> index 50a9522..1991aca 100644
>>> --- a/drivers/pci/pcie/portdrv_core.c
>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>>>   {
>>>   	device_for_each_child(&dev->dev, NULL, remove_iter);
>>>   	pci_free_irq_vectors(dev);
>>> -	pci_disable_device(dev);
>>>   }
>>>   
>>>   /**
>>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
>>> index 3a3ce40..cab37a8 100644
>>> --- a/drivers/pci/pcie/portdrv_pci.c
>>> +++ b/drivers/pci/pcie/portdrv_pci.c
>>> @@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>>   	}
>>>   
>>>   	pcie_port_device_remove(dev);
>>> +	pci_disable_device(dev);
>>> +}
>>> +
>>> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>> +{
>>> +	if (pci_bridge_d3_possible(dev)) {
>>> +		pm_runtime_forbid(&dev->dev);
>>> +		pm_runtime_get_noresume(&dev->dev);
>>> +		pm_runtime_dont_use_autosuspend(&dev->dev);
>>> +	}
>>> +
>>> +	pcie_port_device_remove(dev);
>>>   }
>>>   
>>>   static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>>> @@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver = {
>>>   
>>>   	.probe		= pcie_portdrv_probe,
>>>   	.remove		= pcie_portdrv_remove,
>>> -	.shutdown	= pcie_portdrv_remove,
>>> +	.shutdown	= pcie_portdrv_shutdown,
>>>   
>>>   	.err_handler	= &pcie_portdrv_err_handler,
>>>   
>>> -- 
>>> 2.1.0
>>>

