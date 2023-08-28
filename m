Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E778B0D9
	for <lists+linux-pci@lfdr.de>; Mon, 28 Aug 2023 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjH1Mot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Aug 2023 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjH1MoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2023 08:44:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77CBE102;
        Mon, 28 Aug 2023 05:44:16 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.102])
        by gateway (Coremail) with SMTP id _____8CxtPCbluxkhIEcAA--.58922S3;
        Mon, 28 Aug 2023 20:44:11 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzyOXluxkS7NlAA--.8361S3;
        Mon, 28 Aug 2023 20:44:09 +0800 (CST)
Message-ID: <2637fb35-4328-4cfe-ab16-566994c44b5a@loongson.cn>
Date:   Mon, 28 Aug 2023 20:44:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/PM: Only read PCI_PM_CTRL register when available
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        chenhuacai@loongson.cn, loongson-kernel@lists.loongnix.cn,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20230825212507.GA627427@bhelgaas>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230825212507.GA627427@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyOXluxkS7NlAA--.8361S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw17Zr45XrW7Kw48Gr4xXwc_yoW3uw4Up3
        9YkFnxGFWkJa48GFnIqr1UCF90939Fyr98Wr95C342vFnFgr95Kr15XFyYga47ArZ7Wa18
        XFWjvr4UuF45CagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
        6Fy7McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU022NJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2023/8/26 05:25, Bjorn Helgaas 写道:
> On Fri, Aug 25, 2023 at 11:57:00AM +0800, Feiyang Chen wrote:
>> On Fri, Aug 25, 2023 at 5:59 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Thu, Aug 24, 2023 at 09:37:38AM +0800, Feiyang Chen wrote:
>>>> When the current state is already PCI_D0, pci_power_up() will return
>>>> 0 even though dev->pm_cap is not set. In that case, we should not
>>>> read the PCI_PM_CTRL register in pci_set_full_power_state().
>>>>
>>>> There is nothing more needs to be done below in that case.
>>>> Additionally, pci_power_up() has two callers only and the other one
>>>> ignores the return value, so we can safely move the current state
>>>> check from pci_power_up() to pci_set_full_power_state().
>>> Does this fix a bug?  I guess it does, because previously
>>> pci_set_full_power_state() did a config read at 0 + PCI_PM_CTRL, i.e.,
>>> offset 4, which is actually PCI_COMMAND, and set dev->current_state
>>> based on that.  So dev->current_state is now junk, right?
>> Yes.
>>
>>> This might account for some "Refused to change power state from %s to D0"
>>> messages.
>>>
>>> How did you find this?  It's nice if we can mention a symptom so
>>> people can connect the problem with this fix.
>> We are attempting to add MSI support for our stmmac driver, but the
>> pci_alloc_irq_vectors() function always fails.
>> After looking into it more, we came across the message "Refused to
>> change power state from D3hot to D0" :)
> So I guess this device doesn't have a PM Capability at all?  Can you
> collect the "sudo lspci -vv" output?  The PM Capability is required
> for all PCIe devices, so maybe this is a conventional PCI device?

Hi


I executed this command on the LS2k2000 platform, and this is part of 
the output：


00:03.0 Ethernet controller: Loongson Technology LLC Device 7a13 (rev 01)

     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 45
     NUMA node: 0
     Region 0: Memory at 51290000 (64-bit, non-prefetchable) [size=32K]
     Capabilities: [40] MSI: Enable+ Count=32/32 Maskable- 64bit-
         Address: 1fe01140  Data: 0060
     Kernel driver in use: dwmac-loongson-pci

00:03.1 Ethernet controller: Loongson Technology LLC Device 7a13 (rev 01)
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 78
     NUMA node: 0
     Region 0: Memory at 51298000 (64-bit, non-prefetchable) [size=32K]
     Capabilities: [40] MSI: Enable+ Count=32/32 Maskable- 64bit-
         Address: 1fe01140  Data: 0080
     Kernel driver in use: dwmac-loongson-pci

00:03.2 Ethernet controller: Loongson Technology LLC Gigabit Ethernet 
Controller (rev 02)
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 64, Cache Line Size: 64 bytes
     Interrupt: pin C routed to IRQ 111
     NUMA node: 0
     Region 0: Memory at 512a0000 (64-bit, non-prefetchable) [size=32K]
     Expansion ROM at 512b3000 [disabled] [size=2K]
     Capabilities: [40] MSI: Enable+ Count=32/32 Maskable- 64bit-
         Address: 1fe01140  Data: 00a0

     Kernel driver in use: dwmac-loongson-pci


00:04.0 USB controller: Loongson Technology LLC Device 7a44 (prog-if 30 
[XHCI])

...


>
>>> This sounds like something that probably should have a stable tag?
>> Do I need to include the symptom and Cc in the commit message and
>> then send v4?
>>>> Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
>>>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>>>> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>>>> ---
>>>>   drivers/pci/pci.c | 9 +++++----
>>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 60230da957e0..7e90ab7b47a1 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
>>>>                else
>>>>                        dev->current_state = state;
>>>>
>>>> -             if (state == PCI_D0)
>>>> -                     return 0;
>>>> -
>>>>                return -EIO;
>>>>        }
>>>>
>>>> @@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>>>>        int ret;
>>>>
>>>>        ret = pci_power_up(dev);
>>>> -     if (ret < 0)
>>>> +     if (ret < 0) {
>>>> +             if (dev->current_state == PCI_D0)
>>>> +                     return 0;
>>>> +
>>>>                return ret;
>>>> +     }
>>>>        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>>        dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> One thing that makes me hesitate a little bit is that we rely on the
> failure return from pci_power_up() to guard the dev->pm_cap usage.
> That's slightly obscure, and I liked the way the v1 patch made it
> explicit.
>
> And it seems slightly weird that when there's no PM cap,
> pci_power_up() always returns failure even if the platform was able to
> put the device in D0.
>
> Anyway, here's a proposal for commit log and updated comment for
> pci_power_up():
>
>
> commit 5694ba13b004 ("PCI/PM: Only read PCI_PM_CTRL register when available")
> Author: Feiyang Chen <chenfeiyang@loongson.cn>
> Date:   Thu Aug 24 09:37:38 2023 +0800
>
>      PCI/PM: Only read PCI_PM_CTRL register when available
>      
>      For a device with no Power Management Capability, pci_power_up() previously
>      returned 0 (success) if the platform was able to put the device in D0,
>      which led to pci_set_full_power_state() trying to read PCI_PM_CTRL, even
>      though it doesn't exist.
>      
>      Since dev->pm_cap == 0 in this case, pci_set_full_power_state() actually
>      read the wrong register, interpreted it as PCI_PM_CTRL, and corrupted
>      dev->current_state.  This led to messages like this in some cases:
>      
>        pci 0000:01:00.0: Refused to change power state from D3hot to D0
>      
>      To prevent this, make pci_power_up() always return a negative failure code
>      if the device lacks a Power Management Capability, even if non-PCI platform
>      power management has been able to put the device in D0.  The failure will
>      prevent pci_set_full_power_state() from trying to access PCI_PM_CTRL.
>      
>      Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
>      Link: https://lore.kernel.org/r/20230824013738.1894965-1-chenfeiyang@loongson.cn
>      Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: "Rafael J. Wysocki" <rafael@kernel.org>
>      Cc: stable@vger.kernel.org	# v5.19+
>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..39728196e295 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1226,6 +1226,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>    *
>    * On success, return 0 or 1, depending on whether or not it is necessary to
>    * restore the device's BARs subsequently (1 is returned in that case).
> + *
> + * On failure, return a negative error code.  Always return failure if @dev
> + * lacks a Power Management Capability, even if the platform was able to
> + * put the device in D0 via non-PCI means.
>    */
>   int pci_power_up(struct pci_dev *dev)
>   {
> @@ -1242,9 +1246,6 @@ int pci_power_up(struct pci_dev *dev)
>   		else
>   			dev->current_state = state;
>   
> -		if (state == PCI_D0)
> -			return 0;
> -
>   		return -EIO;
>   	}
>   
> @@ -1302,8 +1303,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>   	int ret;
>   
>   	ret = pci_power_up(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (dev->current_state == PCI_D0)
> +			return 0;
> +
>   		return ret;
> +	}
>   
>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>   	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;

Thanks a lot!


Thanks,

Yanteng

