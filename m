Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8C3458A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfFDLil (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 07:38:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2599 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfFDLil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2019 07:38:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf6583e0000>; Tue, 04 Jun 2019 04:38:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 04:38:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Jun 2019 04:38:38 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 11:38:38 +0000
Received: from [10.24.216.245] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun 2019
 11:38:36 +0000
Subject: Re: [PATCH 1/2] PCI: Code reorganization for VGA device link
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
 <20190531050109.16211-2-abhsahu@nvidia.com>
 <20190603171552.GB189360@google.com>
X-Nvconfidentiality: public
From:   Abhishek Sahu <abhsahu@nvidia.com>
Message-ID: <9b15f919-583b-a445-3d47-6a2dbfc9cbb3@nvidia.com>
Date:   Tue, 4 Jun 2019 17:08:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603171552.GB189360@google.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559648318; bh=qNGxiWS2QRLeAyI8fjEvPOChZL49AO194zOzra25Fys=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Vt0CXTF9zaE69sEciDiQw0/zZ6kEXe2OXK7q8sQ3+9ThA2XO8AvhU9oWkuKL84RQe
         nRhliecJxxyc8vX8LoKovAZIFZWUDG2FRXkYAWN9WbAQLYhjQn/ihx4n7lOiX36K4n
         9cWu5fTIRKWhbbRsaBaMMmHr5toJTvGmPeURecgdZcs04MGJGLVUJKwxUCGQ8+APYj
         MEA1l7CMEnTdF7mNKQ9YFYKnsWX4Ieu+2Zb4ErLqbNDA4MeONCDpliWZUUVSyNIP4j
         22QEg54QHTYW9SNKUoJHGBHcF5zSSKMvJxPfK1Frh/Jo8QvZAtuoDgKugPGGSl29YM
         PuiUpWp9VN7AA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2019 10:45 PM, Bjorn Helgaas wrote:
> [+cc Lukas]
> 
> On Fri, May 31, 2019 at 10:31:08AM +0530, Abhishek Sahu wrote:
>> This patch does minor code reorganization. It introduces a helper
>> function which creates device link from the non-VGA controller
>> (consumer) to the VGA (supplier) and uses this helper function for
>> creating device link from integrated HDA controller to VGA. It will
>> help in subsequent patches which require a similar kind of device
>> link from USB/Type-C USCI controller to VGA.
>>
>> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
>> ---
>>  drivers/pci/quirks.c | 44 +++++++++++++++++++++++++++++---------------
>>  1 file changed, 29 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index a077f67fe1da..a20f7771a323 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4916,36 +4916,50 @@ static void quirk_fsl_no_msi(struct pci_dev *pdev)
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_no_msi);
>>  
>>  /*
>> - * GPUs with integrated HDA controller for streaming audio to attached displays
>> - * need a device link from the HDA controller (consumer) to the GPU (supplier)
>> - * so that the GPU is powered up whenever the HDA controller is accessed.
>> - * The GPU and HDA controller are functions 0 and 1 of the same PCI device.
>> - * The device link stays in place until shutdown (or removal of the PCI device
>> - * if it's hotplugged).  Runtime PM is allowed by default on the HDA controller
>> - * to prevent it from permanently keeping the GPU awake.
>> + * GPUs can be multi-function PCI device which can contain controllers other
>> + * than VGA (like Audio, USB, etc.). Internally in the hardware, these non-VGA
>> + * controllers are tightly coupled with VGA controller. Whenever these
>> + * controllers are runtime active, the VGA controller should also be in active
>> + * state. Normally, in these GPUs, the VGA controller is present at function 0.
>> + *
>> + * This is a helper function which creates device link from the non-VGA
>> + * controller (consumer) to the VGA (supplier). The device link stays in place
>> + * until shutdown (or removal of the PCI device if it's hotplugged).
>> + * Runtime PM is allowed by default on these non-VGA controllers to prevent
>> + * it from permanently keeping the GPU awake.
>>   */
>> -static void quirk_gpu_hda(struct pci_dev *hda)
>> +static void
>> +pci_create_device_link_with_vga(struct pci_dev *pdev, unsigned int devfn)
> 
> There's nothing in this functionality that depends on VGA, so let's
> remove "GPU, "VGA", etc from the description, the function name, the
> local variable name, and the log message.  Maybe you need to allow the

 Thanks. Then we can make this function generic where we can pass
 device link supplier and supplier pci class mask. It will help
 in creating device link from one function (other than 0 also) to
 any another function. Later on, same can be used by non
 GPUs devices also, if required.

> caller to supply the class type (PCI_BASE_CLASS_DISPLAY for current
> users, but Lukas mentioned a NIC that might be able to use this too).
> 
> Follow the prevailing indentation style, with return type and function
> name on the same line, i.e.,
> 

 I will fix in v2.

>   static void pci_create_device_link(...)
> 
>>  {
>>  	struct pci_dev *gpu;
>>  
>> -	if (PCI_FUNC(hda->devfn) != 1)
>> +	if (PCI_FUNC(pdev->devfn) != devfn)
>>  		return;
>>  
>> -	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(hda->bus),
>> -					  hda->bus->number,
>> -					  PCI_DEVFN(PCI_SLOT(hda->devfn), 0));
>> +	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
>> +					  pdev->bus->number,
>> +					  PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
>>  	if (!gpu || (gpu->class >> 16) != PCI_BASE_CLASS_DISPLAY) {
>>  		pci_dev_put(gpu);
>>  		return;
>>  	}
>>  
>> -	if (!device_link_add(&hda->dev, &gpu->dev,
>> +	if (!device_link_add(&pdev->dev, &gpu->dev,
>>  			     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME))
>> -		pci_err(hda, "cannot link HDA to GPU %s\n", pci_name(gpu));
>> +		pci_err(pdev, "cannot link with VGA %s\n", pci_name(gpu));
> 
> I think we should emit a message in the success case, too.  There is
> one in device_link_add(), but it's a dev_dbg() so we can't count on it
> being in the log.  I'd like a pci_info() that we can count on.
> 

 I will add this in v2.

 Regards,
 Abhishek

>> -	pm_runtime_allow(&hda->dev);
>> +	pm_runtime_allow(&pdev->dev);
>>  	pci_dev_put(gpu);
>>  }
>> +
>> +/*
>> + * Create device link for GPUs with integrated HDA controller for streaming
>> + * audio to attached displays.
>> + */
>> +static void quirk_gpu_hda(struct pci_dev *hda)
>> +{
>> +	pci_create_device_link_with_vga(hda, 1);
>> +}
>>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
>>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>> -- 
>> 2.17.1
>>
