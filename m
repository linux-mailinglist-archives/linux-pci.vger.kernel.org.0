Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F31F83B5
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jun 2020 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFMObT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Jun 2020 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgFMObS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jun 2020 10:31:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07817C08C5C2
        for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2020 07:31:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z63so4773349pfb.1
        for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2020 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nwRd2enOMG4jt4Uk5EPLoc0tMcEuCb0goMle7pInqTY=;
        b=v1phM+buXJcNsgCbhY7OeaSaTKaeubsTt31NEtds009yu+XOUKHTvTIJCV+/7YcP/V
         RRB6uQe1xI40VJj/AJw4XoZNbMCTxwJ8ojDQMjIglpRrRQfwOBEgZZHV9o2ll7pAC6EF
         Twqy38hGUe+MkCIEi+6Hs7RN/CkIefm4ZE/k1NI45g2U9FYwv/xQDiF1rN5GZ1vjx0QH
         1I0elXulDV4eaWIGPMLNX06hEsLSxXUX2ukHpdfI47T9c2QAPXzzsZFSmwzz03GwHY/U
         8k624e+htQjxxyypyCK+/cSTD96gRrZIuOHcPlPDOsQXuCD+CW492fDB2SN9XKS4xal7
         aHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nwRd2enOMG4jt4Uk5EPLoc0tMcEuCb0goMle7pInqTY=;
        b=rsclmxhulqXwqztA5A3petrKroosemrd0j2wPR3FFc9FPkGIEVbXlF3C48v2vhH7RB
         j0+ljM4ELP//m0x+roUs3LFVO7TcEMtpDYxwH/KArLgNUVa9hXAgHWpWhAk/Th1u5S+I
         7fdTeneDx24nL9LkZRafkJs3ENPFLeCYcd11H642MV3MNpDeXVacv7Y7bsmHnG2KsCwo
         5AswfBJOF7rZwnTmj401WnGXf7FJnWNm3EJMqqqZBNjt3L/EK+E1e+mQ8a4JlgXexRPs
         7+pGs/2O+tP984GTK840OyjieaT2N8h9o8CNKhBostWKKOXHKS2BoAE9om3VJ3+H/hBH
         emnQ==
X-Gm-Message-State: AOAM532edmlREY6olRAHlmkX+lQ7hEfEjnfJXTZYx/hpDEZ1TWX0Bxxf
        2IrL9iY8C6UgD7mDNirpwJPf9w==
X-Google-Smtp-Source: ABdhPJxVRAOxi33M/Yo5lLiq44LB4Tmp+B+4yQr8teDhdEXqGSSr5eMFvu/Bf4aSvjnBDXFZJvwmhg==
X-Received: by 2002:a62:7c49:: with SMTP id x70mr15175032pfc.66.1592058676966;
        Sat, 13 Jun 2020 07:31:16 -0700 (PDT)
Received: from [10.82.1.102] ([45.135.186.60])
        by smtp.gmail.com with ESMTPSA id 23sm9295417pfy.199.2020.06.13.07.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 07:31:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
References: <20200611134410.GA1586057@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <8f9f6a77-4a65-afeb-0af9-e4868b52d7ce@linaro.org>
Date:   Sat, 13 Jun 2020 22:30:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611134410.GA1586057@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/6/11 下午9:44, Bjorn Helgaas wrote:
> +++ b/drivers/iommu/iommu.c
>>>>>>>>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
>>>>>>>>> fwnode_handle *iommu_fwnode,
>>>>>>>>>             fwspec->iommu_fwnode = iommu_fwnode;
>>>>>>>>>             fwspec->ops = ops;
>>>>>>>>>             dev_iommu_fwspec_set(dev, fwspec);
>>>>>>>>> +
>>>>>>>>> +       if (dev_is_pci(dev))
>>>>>>>>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
>>>>>>>>> Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
>>>>>>>>> Will send this when 5.8-rc1 is open.
>>>>>>>> Wait, this whole fixup approach seems wrong to me.  No matter how you
>>>>>>>> do the fixup, it's still a fixup, which means it requires ongoing
>>>>>>>> maintenance.  Surely we don't want to have to add the Vendor/Device ID
>>>>>>>> for every new AMBA device that comes along, do we?
>>>>>>>>
>>>>>>> Here the fake pci device has standard PCI cfg space, but physical
>>>>>>> implementation is base on AMBA
>>>>>>> They can provide pasid feature.
>>>>>>> However,
>>>>>>> 1, does not support tlp since they are not real pci devices.
>>>>>>> 2. does not support pri, instead support stall (provided by smmu)
>>>>>>> And stall is not a pci feature, so it is not described in struct pci_dev,
>>>>>>> but in struct iommu_fwspec.
>>>>>>> So we use this fixup to tell pci system that the devices can support stall,
>>>>>>> and hereby support pasid.
>>>>>> This did not answer my question.  Are you proposing that we update a
>>>>>> quirk every time a new AMBA device is released?  I don't think that
>>>>>> would be a good model.
>>>>> Yes, you are right, but we do not have any better idea yet.
>>>>> Currently we have three fake pci devices, which support stall and pasid.
>>>>> We have to let pci system know the device can support pasid, because of
>>>>> stall feature, though not support pri.
>>>>> Do you have any other ideas?
>>>> It sounds like the best way would be to allocate a PCI capability for it, so
>>>> detection can be done through config space, at least in future devices,
>>>> or possibly after a firmware update if the config space in your system
>>>> is controlled by firmware somewhere.  Once there is a proper mechanism
>>>> to do this, using fixups to detect the early devices that don't use that
>>>> should be uncontroversial. I have no idea what the process or timeline
>>>> is to add new capabilities into the PCIe specification, or if this one
>>>> would be acceptable to the PCI SIG at all.
>>> That sounds like a possibility.  The spec already defines a
>>> Vendor-Specific Extended Capability (PCIe r5.0, sec 7.9.5) that might
>>> be a candidate.
>> Will investigate this, thanks Bjorn
> FWIW, there's also a Vendor-Specific Capability that can appear in the
> first 256 bytes of config space (the Vendor-Specific Extended
> Capability must appear in the "Extended Configuration Space" from
> 0x100-0xfff).
Unfortunately our silicon does not have either Vendor-Specific Capability or
Vendor-Specific Extended Capability.

Studied commit 8531e283bee66050734fb0e89d53e85fd5ce24a4
Looks this method requires adding member (like can_stall) to struct 
pci_dev, looks difficult.

>
>>>> If detection cannot be done through PCI config space, the next best
>>>> alternative is to pass auxiliary data through firmware. On DT based
>>>> machines, you can list non-hotpluggable PCIe devices and add custom
>>>> properties that could be read during device enumeration. I assume
>>>> ACPI has something similar, but I have not done that.
>> Yes, thanks Arnd
>>> ACPI has _DSM (ACPI v6.3, sec 9.1.1), which might be a candidate.  I
>>> like this better than a PCI capability because the property you need
>>> to expose is not a PCI property.
>> _DSM may not workable, since it is working in runtime.
>> We need stall information in init stage, neither too early (after allocation
>> of iommu_fwspec)
>> nor too late (before arm_smmu_add_device ).
> I'm not aware of a restriction on when _DSM can be evaluated.  I'm
> looking at ACPI v6.3, sec 9.1.1.  Are you seeing something different?
DSM method seems requires vendor specific guid, and code would be vendor 
specific.
Except adding uuid to some spec like pci_acpi_dsm_guid.
obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
IGNORE_PCI_BOOT_CONFIG_DSM, NULL);

>> By the way, It would be a long time if we need modify either pcie
>> spec or acpi spec.  Can we use pci_fixup_device in iommu_fwspec_init
>> first, it is relatively simple and meet the requirement of platform
>> device using pasid, and they are already in product.
> Neither the PCI Vendor-Specific Capability nor the ACPI _DSM requires
> a spec change.  Both can be completely vendor-defined.
Adding vendor-specific code to common files looks a bit ugly.

Thanks

