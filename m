Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611BF32A38
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 10:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfFCIA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 04:00:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9477 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFCIA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 04:00:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf4d3b60000>; Mon, 03 Jun 2019 01:00:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Jun 2019 01:00:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Jun 2019 01:00:56 -0700
Received: from [10.24.216.245] (172.20.13.39) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Jun
 2019 08:00:54 +0000
Subject: Re: [PATCH 2/2] PCI: Create device link for NVIDIA GPU
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        <linux-pci@vger.kernel.org>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
 <20190531050109.16211-3-abhsahu@nvidia.com>
 <20190531203908.GA58810@google.com>
From:   Abhishek Sahu <abhsahu@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d0824334-99f2-d42e-3a5e-3bdc4c1c37c8@nvidia.com>
Date:   Mon, 3 Jun 2019 13:30:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531203908.GA58810@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL108.nvidia.com (172.18.146.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559548855; bh=p+xegJbC84egOu+mcFTbHds+0MLhlADR+aBmh+MBItc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gA3FAsnSDFeIHk78Hb2XWwzultzpUyaWf5DQQBsKwEi5I4soVfDuY4LfEye0NSaJ3
         lV3BpPM2Pif86qplRaglbVkwPjPmoxvSsg01yaXid3I9Ji10rQdbz8mSKuZbLlDbRG
         0YFt5F5UOWg53v4ePWsq5uktJQVyqsqoWV31YU8dRw3IVjiKFDOaZcwSmGRhAyZ8HA
         5AU9+IqsJN0swCEP/oHpjJYtK1H5ckehGdvRfeDrkWGVio/u+d6CaM+nSyU5ksFk4k
         gB60ezJDc4WCKLRsNOQWXHX3OdAmnXmh4coIUdQRSYQm7+Qu7Id1ohK9yEOpK04fTy
         jxnzHfjOxwccA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 Thanks Bjorn for your review.

On 6/1/2019 2:09 AM, Bjorn Helgaas wrote:
> [+cc Lukas, author of 07f4f97d7b4b ("vga_switcheroo: Use device link
> for HDA controller")]
> 
> On Fri, May 31, 2019 at 10:31:09AM +0530, Abhishek Sahu wrote:
>> NVIDIA Turing GPUs include hardware support for USB Type-C and
>> VirtualLink. It helps in delivering the power, display, and data
>> required to power VR headsets through a single USB Type-C connector.
>> The Turing GPU is a multi-function PCI device has the following
>> four functions:
>>
>> 	- VGA display controller (Function 0)
>> 	- Audio controller (Function 1)
>> 	- USB xHCI Host controller (Function 2)
>> 	- USB Type-C USCI controller (Function 3)
>>
>> The function 0 is tightly coupled with other functions in the
>> hardware. When function 0 goes in runtime suspended state,
> 
> "Runtime suspended" is a Linux concept, not a PCI concept.  Please
> replace this with the appropriate PCI term, e.g., "D3hot" or whatever
> it is.

 Sure. I will change this.

> 
>> then it will do power gating for most of the hardware blocks.
>> Some of these hardware blocks are used by other functions which
>> leads to functional failure. So if any of these functions (1/2/3)
>> are active, then function 0 should also be in active state.
> 
> Instead of "active" and "active state", please use the specific states
> required in terms of PCI.

 Sure. I will use specific states name.

> 
>> 'commit 07f4f97d7b4b ("vga_switcheroo: Use device link for
>> HDA controller")' creates the device link from function 1 to
>> function 0. A similar kind of device link needs to be created
>> between function 0 and functions 2 and 3 for NVIDIA Turing GPU.
> 
> I can't point to language that addresses this, but this sounds like a
> case of the GPU not conforming to the PCI spec.  The general
> assumption is that the OS should be able to discover everything it
> needs to do power management directly from the architected PCI config
> space.

 The GPU is following PCIe spec but following is the implementation
 from HW side

 Normal GPU has VGA and Audio controller in which Audio is dependent
 upon VGA. For these GPU, the VGA is managed by GPU driver and Audio is
 managed by sound driver. Now the VGA driver can go to D3hot while
 Audio still in D0 if there was no device link (added in commit
 07f4f97d7b4b). It would lead to Audio functionality failure. The
 device link is making sure that GPU is in D0 while Audio is D0.

 Now the NVIDIA Turing GPU has one USB Type-C port mainly to support
 virtual reality headset. With default mode, this USB port will act as
 normal USB port and any USB device can be connected over it. It will
 be managed with PCI xHCI USB controller driver.  Now, to support VR
 headset, This USB Type-C alternate mode is going to be used. This
 alternate mode setting will be managed with [1] and [2] which is part
 of 5.2-rc1. More detail for this is available in [3] and virtual link
 open industry standard [4].  These VR frame-buffers are internally
 going to be rendered by GPU only and managed by function 0 (VGA)
 driver. Now, from HW side, we need to make sure VGA is in D0 while any
 of other functions are in D0.

 [1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/typec/altmodes/nvidia.c
 [2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-nvidia-gpu.c
 [3]
https://fullcirclemagazine.org/2019/04/30/nvidia-creates-free-virtual-link-driver-for-linux/
 [4] https://sites.google.com/view/virtuallink-consortium/home

> 
> It is definitely not ideal to have to add quirks like this for devices
> designed this way.  Such quirks force us to do otherwise unnecessary
> OS updates as new devices are released.

 I can understand but this is the HW requirement. To support,
 VR headset in GPU, the HW has provided USB Type-C. Now, from
 SW side, we are working on supporting this with runtime PM.
 Currently runtime PM is not possible without adding the
 dependencies between different functions.

> 
> If all the devices in a multi-function device were connected
> intimately enough that they all had to be managed by the same driver,
> I could imagine putting these non-discoverable dependencies in the
> driver.  But these devices don't seem to be related in that way.
> > If there *is* spec language that allows dependencies like this, please
> include the citation in your commit log.
> 

 The PCIe specification treats each function separately but GPU case is
 different. So, it won't be part of PCIe spec. in GPU, the different
 kind of devices are internally coupled in HW but still needs to be
 managed by different driver.

>> This patch does the same and create the required device links. It
>> will make function 0 to be runtime PM active if other functions
>> are still active.
>>
>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>> ---
>>  drivers/pci/quirks.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index a20f7771a323..afdbc199efc5 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4967,6 +4967,29 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>>  
>> +/* Create device link for NVIDIA GPU with integrated USB controller to VGA. */
>> +static void quirk_gpu_usb(struct pci_dev *usb)
>> +{
>> +	pci_create_device_link_with_vga(usb, 2);
>> +}
>> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>> +			      PCI_CLASS_SERIAL_USB, 8, quirk_gpu_usb);
>> +
>> +/*
>> + * Create device link for NVIDIA GPU with integrated Type-C UCSI controller
>> + * to VGA. Currently there is no class code defined for UCSI device over PCI
>> + * so using UNKNOWN class for now and it will be updated when UCSI
>> + * over PCI gets a class code.
> 
> Ugh.  Here's a good example of having to do yet another OS update.
> 

 Correct. But currently we don't have any other way.
 Same thing we did for
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-nvidia-gpu.c#n248

 Once it gets a class code then we can replace at all the places.

 Regards,
 Abhishek

>> + */
>> +#define PCI_CLASS_SERIAL_UNKNOWN	0x0c80
>> +static void quirk_gpu_usb_typec_ucsi(struct pci_dev *ucsi)
>> +{
>> +	pci_create_device_link_with_vga(ucsi, 3);
>> +}
>> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>> +			      PCI_CLASS_SERIAL_UNKNOWN, 8,
>> +			      quirk_gpu_usb_typec_ucsi);
>> +
>>  /*
>>   * Some IDT switches incorrectly flag an ACS Source Validation error on
>>   * completions for config read requests even though PCIe r4.0, sec
>> -- 
>> 2.17.1
>>
