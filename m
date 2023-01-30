Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FA6680DCB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 13:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbjA3MfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 07:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjA3MfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 07:35:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E94211;
        Mon, 30 Jan 2023 04:35:21 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pMTNV-0004kO-85; Mon, 30 Jan 2023 13:35:17 +0100
Message-ID: <c0c58ec0-3cb2-5385-eeac-6ca37b6b1509@leemhuis.info>
Date:   Mon, 30 Jan 2023 13:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2 2/2] PCI: Add quirk for LS7A to avoid reboot failure
Content-Language: en-US, de-DE
To:     Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAAhV-H59FLAFGD8oDZGjXWgL2ei_L=rYAaFWWp1skUT9nUPVYg@mail.gmail.com>
 <20230120153644.GA636025@bhelgaas>
 <CAAhV-H4LDn4YmM6Cwse-yjEeooeyqQ4Gy0gPxN0WS=H6KmuSJw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAAhV-H4LDn4YmM6Cwse-yjEeooeyqQ4Gy0gPxN0WS=H6KmuSJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675082121;4ae6adba;
X-HE-SMSGID: 1pMTNV-0004kO-85
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21.01.23 16:10, Huacai Chen wrote:
> On Fri, Jan 20, 2023 at 11:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Fri, Jan 20, 2023 at 09:31:43PM +0800, Huacai Chen wrote:
>>> On Thu, Jan 19, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> On Thu, Jan 19, 2023 at 08:25:20PM +0800, Huacai Chen wrote:
>>>>> Ping?
>>>>
>>>> I suggested another possible way to do this that wasn't so much of a
>>>> special case.  Did you explore that at all?
>>>
>>> That is a little difficult for me, but what is worse is that the root
>>> cause doesn't come from gpu or console drivers, but from the root
>>> port. That means: even if we can workaround the gpu issue in another
>>> way, there are still problems on other devices. Besides the graphics
>>> card, the most frequent problematic device is the sata controller
>>> connected on LS7A chipset, there are incomplete I/O accesses after the
>>> root port disabled and also cause reboot failure.
>>
>> Yes, SATA sounds like another case where we want to use the device
>> after we call the driver's remove/shutdown method.  That's not
>> *worse*, it's just another case where we might have to mark devices
>> for special handling.
> That needs too much effort because we need to modify nearly every pci
> driver, and it exceeds my ability. :)

Just wondering: what's the status here? This looks stalled.

I'm asking, as the patches in this thread are supposed to fix this
regression:
https://bugzilla.kernel.org/show_bug.cgi?id=216884

Or should we try to find a different fix/workaround because the proper
solution discussed in this thread needs more time?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> If we remove/shutdown *any* Root Port, not just LS7A, I think the idea
>> of assuming downstream devices can continue to work as usual is a
>> little suspect.  They might continue to work by accident today, but it
>> doesn't seem like a robust design.
> The existing design works for so many years, so it is mostly
> reasonable. For the LS7A case, the root cause comes from the root
> port, so a workaround on the root port seems somewhat reasonable.
> 
> Huacai
>>
>>>> I know there's no *existing* way to mark devices that we need to use
>>>> all the way through shutdown or reboot, but if it makes sense, there's
>>>> no reason we couldn't add one.  That has the potential of being more
>>>> generic, e.g., we could do it for all console devices, as opposed to
>>>> quirking a Root Port that just happens to be in the path to the
>>>> console.
>>>>
>>>>> On Sat, Jan 7, 2023 at 10:25 AM Huacai Chen <chenhuacai@gmail.com> wrote:
>>>>>> On Fri, Jan 6, 2023 at 11:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Fri, Jan 06, 2023 at 05:51:43PM +0800, Huacai Chen wrote:
>>>>>>>> After cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe
>>>>>>>> services during shutdown") we observe poweroff/reboot
>>>>>>>> failures on systems with LS7A chipset.
>>>>>>>>
>>>>>>>> We found that if we remove "pci_command &=
>>>>>>>> ~PCI_COMMAND_MASTER" in do_pci_disable_device(), it can
>>>>>>>> work well. The hardware engineer says that the root cause
>>>>>>>> is that CPU is still accessing PCIe devices while
>>>>>>>> poweroff/reboot, and if we disable the Bus Master Bit at
>>>>>>>> this time, the PCIe controller doesn't forward requests to
>>>>>>>> downstream devices, and also does not send TIMEOUT to CPU,
>>>>>>>> which causes CPU wait forever (hardware deadlock).
>>>>>>>>
>>>>>>>> To be clear, the sequence is like this:
>>>>>>>>
>>>>>>>>   - CPU issues MMIO read to device below Root Port
>>>>>>>>
>>>>>>>>   - LS7A Root Port fails to forward transaction to secondary bus
>>>>>>>>     because of LS7A Bus Master defect
>>>>>>>>
>>>>>>>>   - CPU hangs waiting for response to MMIO read
>>>>>>>>
>>>>>>>> Then how is userspace able to use a device after the
>>>>>>>> device is removed?
>>>>>>>>
>>>>>>>> To give more details, let's take the graphics driver (e.g.
>>>>>>>> amdgpu) as an example. The userspace programs call
>>>>>>>> printf() to display "shutting down xxx service" during
>>>>>>>> shutdown/reboot, or the kernel calls printk() to display
>>>>>>>> something during shutdown/reboot. These can happen at any
>>>>>>>> time, even after we call pcie_port_device_remove() to
>>>>>>>> disable the pcie port on the graphic card.
>>>>>>>>
>>>>>>>> The call stack is: printk() --> call_console_drivers() -->
>>>>>>>> con->write() --> vt_console_print() --> fbcon_putcs()
>>>>>>>>
>>>>>>>> This scenario happens because userspace programs (or the
>>>>>>>> kernel itself) don't know whether a device is 'usable',
>>>>>>>> they just use it, at any time.
>>>>>>>
>>>>>>> Thanks for this background.  So basically we want to call
>>>>>>> .remove() on a console device (or a bridge leading to it),
>>>>>>> but we expect it to keep working as usual afterwards?
>>>>>>>
>>>>>>> That seems a little weird.  Is that the design we want?
>>>>>>> Maybe we should have a way to mark devices so we don't
>>>>>>> remove them during shutdown or reboot?
>>>>>>
>>>>>> Sounds reasonable, but it seems no existing way can mark this.
>>>>>>
>>>>>> Huacai
>>>>>>>
>>>>>>>> This hardware behavior is a PCIe protocol violation (Bus Master should
>>>>>>>> not be involved in CPU MMIO transactions), and it will be fixed in new
>>>>>>>> revisions of hardware (add timeout mechanism for CPU read request,
>>>>>>>> whether or not Bus Master bit is cleared).
>>>>>>>>
>>>>>>>> On some x86 platforms, radeon/amdgpu devices can cause similar problems
>>>>>>>> [1][2]. Once before I wanted to make a single patch to solve "all of
>>>>>>>> these problems" together, but it seems unreasonable because maybe they
>>>>>>>> are not exactly the same problem. So, this patch add a new function
>>>>>>>> pcie_portdrv_shutdown(), a slight modified copy of pcie_portdrv_remove()
>>>>>>>> dedicated for the shutdown path, and then add a quirk just for LS7A to
>>>>>>>> avoid clearing Bus Master bit in pcie_portdrv_shutdown(). Leave other
>>>>>>>> platforms behave as before.
>>>>>>>>
>>>>>>>> [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
>>>>>>>> [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
>>>>>>>>
>>>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>>>>> ---
>>>>>>>>  drivers/pci/controller/pci-loongson.c | 17 +++++++++++++++++
>>>>>>>>  drivers/pci/pcie/portdrv.c            | 21 +++++++++++++++++++--
>>>>>>>>  include/linux/pci.h                   |  1 +
>>>>>>>>  3 files changed, 37 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>>>>>>>> index 759ec211c17b..641308ba4126 100644
>>>>>>>> --- a/drivers/pci/controller/pci-loongson.c
>>>>>>>> +++ b/drivers/pci/controller/pci-loongson.c
>>>>>>>> @@ -93,6 +93,24 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>>>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>>>>>                       DEV_PCIE_PORT_2, loongson_mrrs_quirk);
>>>>>>>>
>>>>>>>> +static void loongson_bmaster_quirk(struct pci_dev *pdev)
>>>>>>>> +{
>>>>>>>> +     /*
>>>>>>>> +      * Some Loongson PCIe ports will cause CPU deadlock if there is
>>>>>>>> +      * MMIO access to a downstream device when the root port disable
>>>>>>>> +      * the Bus Master bit during poweroff/reboot.
>>>>>>>> +      */
>>>>>>>> +     struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
>>>>>>>> +
>>>>>>>> +     bridge->no_dis_bmaster = 1;
>>>>>>>> +}
>>>>>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>>>>> +                     DEV_PCIE_PORT_0, loongson_bmaster_quirk);
>>>>>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>>>>> +                     DEV_PCIE_PORT_1, loongson_bmaster_quirk);
>>>>>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>>>>>>>> +                     DEV_PCIE_PORT_2, loongson_bmaster_quirk);
>>>>>>>> +
>>>>>>>>  static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>>>>>>>>  {
>>>>>>>>       pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
>>>>>>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>>>>>>> index 2cc2e60bcb39..96f45c444422 100644
>>>>>>>> --- a/drivers/pci/pcie/portdrv.c
>>>>>>>> +++ b/drivers/pci/pcie/portdrv.c
>>>>>>>> @@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
>>>>>>>>  {
>>>>>>>>       device_for_each_child(&dev->dev, NULL, remove_iter);
>>>>>>>>       pci_free_irq_vectors(dev);
>>>>>>>> -     pci_disable_device(dev);
>>>>>>>>  }
>>>>>>>>
>>>>>>>>  /**
>>>>>>>> @@ -727,6 +726,24 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>>>>>>>       }
>>>>>>>>
>>>>>>>>       pcie_port_device_remove(dev);
>>>>>>>> +
>>>>>>>> +     pci_disable_device(dev);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>>>>>>> +{
>>>>>>>> +     struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>>>>>>>> +
>>>>>>>> +     if (pci_bridge_d3_possible(dev)) {
>>>>>>>> +             pm_runtime_forbid(&dev->dev);
>>>>>>>> +             pm_runtime_get_noresume(&dev->dev);
>>>>>>>> +             pm_runtime_dont_use_autosuspend(&dev->dev);
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>> +     pcie_port_device_remove(dev);
>>>>>>>> +
>>>>>>>> +     if (!bridge->no_dis_bmaster)
>>>>>>>> +             pci_disable_device(dev);
>>>>>>>>  }
>>>>>>>>
>>>>>>>>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>>>>>>>> @@ -777,7 +794,7 @@ static struct pci_driver pcie_portdriver = {
>>>>>>>>
>>>>>>>>       .probe          = pcie_portdrv_probe,
>>>>>>>>       .remove         = pcie_portdrv_remove,
>>>>>>>> -     .shutdown       = pcie_portdrv_remove,
>>>>>>>> +     .shutdown       = pcie_portdrv_shutdown,
>>>>>>>>
>>>>>>>>       .err_handler    = &pcie_portdrv_err_handler,
>>>>>>>>
>>>>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>>>>> index 3df2049ec4a8..a64dbcb89231 100644
>>>>>>>> --- a/include/linux/pci.h
>>>>>>>> +++ b/include/linux/pci.h
>>>>>>>> @@ -573,6 +573,7 @@ struct pci_host_bridge {
>>>>>>>>       unsigned int    ignore_reset_delay:1;   /* For entire hierarchy */
>>>>>>>>       unsigned int    no_ext_tags:1;          /* No Extended Tags */
>>>>>>>>       unsigned int    no_inc_mrrs:1;          /* No Increase MRRS */
>>>>>>>> +     unsigned int    no_dis_bmaster:1;       /* No Disable Bus Master */
>>>>>>>>       unsigned int    native_aer:1;           /* OS may use PCIe AER */
>>>>>>>>       unsigned int    native_pcie_hotplug:1;  /* OS may use PCIe hotplug */
>>>>>>>>       unsigned int    native_shpc_hotplug:1;  /* OS may use SHPC hotplug */
>>>>>>>> --
>>>>>>>> 2.31.1
>>>>>>>>
