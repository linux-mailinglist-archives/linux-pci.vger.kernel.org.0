Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4449811A52B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 08:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfLKHh3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 02:37:29 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:28689 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfLKHh3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Dec 2019 02:37:29 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id xBB7a8aS017640;
        Wed, 11 Dec 2019 15:36:08 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id xBB7a0Nr096889;
        Wed, 11 Dec 2019 15:36:00 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from [172.20.21.12] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 11 Dec
 2019 15:36:02 +0800
Subject: Re: Linux v5.5 serious PCI bug
To:     Takashi Iwai <tiwai@suse.de>, Lukas Wunner <lukas@wunner.de>
CC:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        <alexander.deucher@amd.com>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209131239.GP2665@lahna.fi.intel.com>
 <PSXP216MB043809A423446A6EF2C7909A80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210072800.GY2665@lahna.fi.intel.com>
 <PSXP216MB04384F89D9D9DDA6999347CF805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210122941.zzybs4z5jphpjsu2@wunner.de> <s5h1rtccpqh.wl-tiwai@suse.de>
From:   Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <50eb6e32-296a-0086-f172-60103b89b5a5@hygon.cn>
Date:   Wed, 11 Dec 2019 15:33:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <s5h1rtccpqh.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn xBB7a8aS017640
X-DNSRBL: 
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/12/10 20:46, Takashi Iwai wrote:
> On Tue, 10 Dec 2019 13:29:41 +0100,
> Lukas Wunner wrote:
>>
>> [cc += Alex, Takashi]
>>
>> On Tue, Dec 10, 2019 at 12:00:23PM +0000, Nicholas Johnson wrote:
>>> On Tue, Dec 10, 2019 at 09:28:00AM +0200, mika.westerberg@linux.intel.com wrote:
>>>> On Mon, Dec 09, 2019 at 01:33:49PM +0000, Nicholas Johnson wrote:
>>>>> On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
>>>>>> On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
>>>>>>> I have compiled Linux v5.5-rc1 and thought all was good until I
>>>>>>> hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the
>>>>>>> GPU was not loaded (blacklisted) so the crash is nothing to do with the
>>>>>>> GPU driver.
>>>>>>>
>>>>>>> We had:
>>>>>>> - kernel NULL pointer dereference
>>>>>>> - refcount_t: underflow; use-after-free.
>>>
>>> The following is the culprit responsible for the issues:
>>>
>>> commit 586bc4aab878efcf672536f0cdec3d04b6990c94
>>> Author: Alex Deucher <alexander.deucher@amd.com>
>>> Date:   Fri Nov 22 16:43:50 2019 -0500
>>>
>>>      ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD
>>
>> Does the below fix the issue?
>>
>> -- >8 --
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 35b4526f0d28..b856b89378ac 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1419,7 +1419,6 @@ static bool atpx_present(void)
>>   				return true;
>>   			}
>>   		}
>> -		pci_dev_put(pdev);
>>   	}
>>   	return false;
>>   }
> 
> Oh this looks really like a bug, even if this isn't the root cause.
> 
> Care to submit a proper patch?
> 
Hi Nicholas
I have disassembled the vmlinux by objdump -Sdl, but is it too big to
send as an attachment. Just take a look at the key information:
The file dmesg-5 show trace:
[   71.693210] general protection fault: 0000 [#1] SMP PTI
[   71.693215] CPU: 1 PID: 184 Comm: irq/128-pciehp Not tainted 5.5.0-rc1 #2
[   71.693217] Hardware name: Dell Inc. XPS 13 9370/09DKKT, BIOS 1.11.1 
07/11/2019
[   71.693223] RIP: 0010:pci_remove_bus_device+0x9a/0x100
[   71.693250] Call Trace:
[   71.693256]  pci_remove_bus_device+0x31/0x100
[   71.693259]  pci_remove_bus_device+0x31/0x100
[   71.693261]  pci_stop_and_remove_bus_device+0x1b/0x20

.....

[   71.709515] Call Trace:
[   71.709527]  kobject_put+0xfc/0x1c0
[   71.709536]  __device_link_free_srcu+0x51/0x60
[   71.709538]  srcu_invoke_callbacks+0xd2/0x170
[   71.709547]  process_one_work+0x1ec/0x3a0
[   71.709550]  worker_thread+0x4d/0x400
[   71.709554]  kthread+0x104/0x140
[   71.709557]  ? process_one_work+0x3a0/0x3a0
[   71.709559]  ? kthread_park+0x90/0x90
[   71.709563]  ret_from_fork+0x35/0x40

the disassembling file
ffffffff814eea30 <pci_remove_bus_device>:
pci_remove_bus_device():
/home/higon/linux/drivers/pci/remove.c:86

static void pci_remove_bus_device(struct pci_dev *dev)
{
ffffffff814eea30:	e8 bb 2e 51 00       	callq  ffffffff81a018f0 <__fentry__>
ffffffff814eea35:	41 55                	push   %r13
ffffffff814eea37:	41 54                	push   %r12
ffffffff814eea39:	55                   	push   %rbp
ffffffff814eea3a:	53                   	push   %rbx
ffffffff814eea3b:	48 89 fd             	mov    %rdi,%rbp
/home/higon/linux/drivers/pci/remove.c:87
	struct pci_bus *bus = dev->subordinate;
ffffffff814eea3e:	4c 8b 6f 18          	mov    0x18(%rdi),%r13
/home/higon/linux/drivers/pci/remove.c:90
	struct pci_dev *child, *tmp;

........

static inline void list_del(struct list_head *entry)
{
	__list_del_entry(entry);
	entry->next = LIST_POISON1;
ffffffff814eeac0:	48 b8 00 01 00 00 00 	movabs $0xdead000000000100,%rax
ffffffff814eeac7:	00 ad de
ffffffff814eeaca:	48 89 45 00          	mov    %rax,0x0(%rbp)
/home/higon/linux/./include/linux/list.h:141
	entry->prev = LIST_POISON2;
ffffffff814eeace:	48 b8 22 01 00 00 00 	movabs $0xdead000000000122,%rax
ffffffff814eead5:	00 ad de
ffffffff814eead8:	48 89 45 08          	mov    %rax,0x8(%rbp)
pci_destroy_dev():
/home/higon/linux/drivers/pci/remove.c:39
ffffffff814eeadc:	e8 2f 23 bf ff       	callq  ffffffff810e0e10 <up_write>
/home/higon/linux/drivers/pci/remove.c:41

In the file source/sound/pci/hda/hda_intel.c, atpx_present can not call
pci_dev_put(pdev) because the reference count for pdev is always
decremented if it is not NULL after call pci_get_class.
Resource of pdev will be released when the reference count for it
decremented to zero. Hotplug service dereferences NULL pointer when 
remove the device from the device lists.

static bool atpx_present(void)
{
	struct pci_dev *pdev = NULL;
	acpi_handle dhandle, atpx_handle;
	acpi_status status;

	while ((pdev = pci_get_class(PCI_BASE_CLASS_DISPLAY << 16, pdev)) != 
NULL) {
		dhandle = ACPI_HANDLE(&pdev->dev);
		if (dhandle) {
			status = acpi_get_handle(dhandle, "ATPX", &atpx_handle);
			if (!ACPI_FAILURE(status)) {
				pci_dev_put(pdev);
				return true;
			}
		}
		pci_dev_put(pdev);
	}
	return false;
}
struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
{
	struct pci_device_id id = {
		.vendor = PCI_ANY_ID,
		.device = PCI_ANY_ID,
		.subvendor = PCI_ANY_ID,
		.subdevice = PCI_ANY_ID,
		.class_mask = PCI_ANY_ID,
		.class = class,
	};

	return pci_get_dev_by_id(&id, from);
}
static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
					 struct pci_dev *from)
{
	struct device *dev;
	struct device *dev_start = NULL;
	struct pci_dev *pdev = NULL;

	WARN_ON(in_interrupt());
	if (from)
		dev_start = &from->dev;
	dev = bus_find_device(&pci_bus_type, dev_start, (void *)id,
			      match_pci_dev_by_id);
	if (dev)
		pdev = to_pci_dev(dev);
	pci_dev_put(from);
	return pdev;
}

Thanks,
Jiasen Lin

> 
> thanks,
> 
> Takashi
> 
