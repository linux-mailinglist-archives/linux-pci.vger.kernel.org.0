Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D935320002A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 04:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgFSC1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 22:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgFSC1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2020 22:27:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0067FC0613EE
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 19:27:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so3808520pge.12
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2020 19:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1NQyD9WrJsbI510glYgHlSP0TyLa8enW/S/MPeeFMi8=;
        b=iSB7ZTw+y0hCECv5tinmjWIPeUtBXssd1nCzvz4v0Ji07pHfe4hOOuinagdLEsBnl3
         1yvnOogYr4IdD4GKi+hlWXiXUcBp+mI1mL0rQnbc5LiAwqrSjyiV+ePIuyZGXynZj/kA
         MsOHM8PJTRRZfUNM9zxlB+rjPg44kU5qgB+H1jJ9cyDYvWo1c8ZmTgkKLupeID2Q/nHK
         KS2/2XoHlKRQXxal9WCrDhn7AYRQzNByypRXA3NWxWldotqEMAZIh6VkflS8HSQ21XgB
         KKf0sLNo8kZ+iQKLWmNZafoS1eN4KpmYVWogKmmLYWx36Y+RjG6YCMKZa0wgaqvm3cM5
         yX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1NQyD9WrJsbI510glYgHlSP0TyLa8enW/S/MPeeFMi8=;
        b=OkA6Nai3Oy/gIculsUVNbuvkuCnN34Cf4t1+FuFtBPEdUVkMZJFPWWjhs0eFFso0zb
         Xg18+EeG/rMErHSCPj9v4S+NpAT13F40IpvfhU988ZPXAFnF1a8u6NYK9pfHLqNJggDX
         ZKEAFZcmm4wIKxw+iNei6s6A3M1Krk0zFn/fJnujPkkxYMCUk7Wfhik1J0WiB6w+NY3D
         YSIIco6TNuXOmratiIbEoTsyYsjE82ggUi/6wW5P+V0XtfzOPDhiU0GkGouiLaUTXhYS
         mxvU5VXMtr2xYymqs7ekYpHyeAN4TtfpxDZ9tx0n/7IyoZk7FYyzQ8AOYlEKA3PSzKFw
         fqBQ==
X-Gm-Message-State: AOAM5307ohHBP9bHVY1j051E+putfkkeVvd5QgBo6pifQ6328KcNVI7L
        x80OOMjKIEJnOS7G0gbpAX7Uuw==
X-Google-Smtp-Source: ABdhPJwPV/l1romnvuaB3bf+oXNo9TD61AfC0QGCLewyWOibz0ocQr1j4hIskA+JR5hNdLoitEbUKQ==
X-Received: by 2002:a65:6496:: with SMTP id e22mr1264866pgv.63.1592533652044;
        Thu, 18 Jun 2020 19:27:32 -0700 (PDT)
Received: from ?IPv6:240e:362:4d1:900:683e:57c:525:a3cd? ([240e:362:4d1:900:683e:57c:525:a3cd])
        by smtp.gmail.com with ESMTPSA id a8sm1181029pga.64.2020.06.18.19.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 19:27:31 -0700 (PDT)
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
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20200615235217.GA1921846@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <c5d7b2f1-6b32-d965-3b60-eb70a26e02b4@linaro.org>
Date:   Fri, 19 Jun 2020 10:26:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615235217.GA1921846@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On 2020/6/16 上午7:52, Bjorn Helgaas wrote:
> On Sat, Jun 13, 2020 at 10:30:56PM +0800, Zhangfei Gao wrote:
>> On 2020/6/11 下午9:44, Bjorn Helgaas wrote:
>>> +++ b/drivers/iommu/iommu.c
>>>>>>>>>>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
>>>>>>>>>>> fwnode_handle *iommu_fwnode,
>>>>>>>>>>>              fwspec->iommu_fwnode = iommu_fwnode;
>>>>>>>>>>>              fwspec->ops = ops;
>>>>>>>>>>>              dev_iommu_fwspec_set(dev, fwspec);
>>>>>>>>>>> +
>>>>>>>>>>> +       if (dev_is_pci(dev))
>>>>>>>>>>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
>>>>>>>>>>> +
>>>>>>>>>>>
>>>>>>>>>>> Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
>>>>>>>>>>> Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
>>>>>>>>>>> Will send this when 5.8-rc1 is open.
>>>>>>>>>> Wait, this whole fixup approach seems wrong to me.  No matter how you
>>>>>>>>>> do the fixup, it's still a fixup, which means it requires ongoing
>>>>>>>>>> maintenance.  Surely we don't want to have to add the Vendor/Device ID
>>>>>>>>>> for every new AMBA device that comes along, do we?
>>>>>>>>>>
>>>>>>>>> Here the fake pci device has standard PCI cfg space, but physical
>>>>>>>>> implementation is base on AMBA
>>>>>>>>> They can provide pasid feature.
>>>>>>>>> However,
>>>>>>>>> 1, does not support tlp since they are not real pci devices.
>>>>>>>>> 2. does not support pri, instead support stall (provided by smmu)
>>>>>>>>> And stall is not a pci feature, so it is not described in struct pci_dev,
>>>>>>>>> but in struct iommu_fwspec.
>>>>>>>>> So we use this fixup to tell pci system that the devices can support stall,
>>>>>>>>> and hereby support pasid.
>>>>>>>> This did not answer my question.  Are you proposing that we update a
>>>>>>>> quirk every time a new AMBA device is released?  I don't think that
>>>>>>>> would be a good model.
>>>>>>> Yes, you are right, but we do not have any better idea yet.
>>>>>>> Currently we have three fake pci devices, which support stall and pasid.
>>>>>>> We have to let pci system know the device can support pasid, because of
>>>>>>> stall feature, though not support pri.
>>>>>>> Do you have any other ideas?
>>>>>> It sounds like the best way would be to allocate a PCI capability for it, so
>>>>>> detection can be done through config space, at least in future devices,
>>>>>> or possibly after a firmware update if the config space in your system
>>>>>> is controlled by firmware somewhere.  Once there is a proper mechanism
>>>>>> to do this, using fixups to detect the early devices that don't use that
>>>>>> should be uncontroversial. I have no idea what the process or timeline
>>>>>> is to add new capabilities into the PCIe specification, or if this one
>>>>>> would be acceptable to the PCI SIG at all.
>>>>> That sounds like a possibility.  The spec already defines a
>>>>> Vendor-Specific Extended Capability (PCIe r5.0, sec 7.9.5) that might
>>>>> be a candidate.
>>>> Will investigate this, thanks Bjorn
>>> FWIW, there's also a Vendor-Specific Capability that can appear in the
>>> first 256 bytes of config space (the Vendor-Specific Extended
>>> Capability must appear in the "Extended Configuration Space" from
>>> 0x100-0xfff).
>> Unfortunately our silicon does not have either Vendor-Specific Capability or
>> Vendor-Specific Extended Capability.
>>
>> Studied commit 8531e283bee66050734fb0e89d53e85fd5ce24a4
>> Looks this method requires adding member (like can_stall) to struct pci_dev,
>> looks difficult.
> The problem is that we don't want to add device IDs every time a new
> chip comes out.  Adding one or two device IDs for silicon that's
> already released is not a problem as long as you have a strategy for
> *future* devices so they don't require a quirk.
>
>>>>>> If detection cannot be done through PCI config space, the next best
>>>>>> alternative is to pass auxiliary data through firmware. On DT based
>>>>>> machines, you can list non-hotpluggable PCIe devices and add custom
>>>>>> properties that could be read during device enumeration. I assume
>>>>>> ACPI has something similar, but I have not done that.
>>>> Yes, thanks Arnd
>>>>> ACPI has _DSM (ACPI v6.3, sec 9.1.1), which might be a candidate.  I
>>>>> like this better than a PCI capability because the property you need
>>>>> to expose is not a PCI property.
>>>> _DSM may not workable, since it is working in runtime.
>>>> We need stall information in init stage, neither too early (after allocation
>>>> of iommu_fwspec)
>>>> nor too late (before arm_smmu_add_device ).
>>> I'm not aware of a restriction on when _DSM can be evaluated.  I'm
>>> looking at ACPI v6.3, sec 9.1.1.  Are you seeing something different?
>> DSM method seems requires vendor specific guid, and code would be vendor
>> specific.
> _DSM indeed requires a vendor-specific UUID, precisely *because*
> vendors are free to define their own functionality without requiring
> changes to the ACPI spec.  From the spec (ACPI v6.3, sec 9.1.1):
>
>    New UUIDs may also be created by OEMs and IHVs for custom devices
>    and other interface or device governing bodies (e.g. the PCI SIG),
>    as long as the UUID is different from other published UUIDs.
Have studied _DSM method, two issues we met comparing using quirk.

1. Need change definition of either pci_host_bridge or pci_dev, like 
adding member can_stall,
while pci system does not know stall now.

a, pci devices do not have uuid: uuid need be described in dsdt, while 
pci devices are not defined in dsdt.
     so we have to use host bridge.

b,  Parsing dsdt is in in pci subsystem.
Like drivers/acpi/pci_root.c:
        obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), 
&pci_acpi_dsm_guid, 1,
                                 IGNORE_PCI_BOOT_CONFIG_DSM, NULL);

After parsing DSM in pci, we need record this info.
Currently, can_stall info is recorded in iommu_fwspec,
which is allocated in iommu_fwspec_init and called by 
iort_iommu_configure for uefi.

2. Guest kernel also need support sva.
Using quirk, the guest can boot with sva enabled, since quirk is 
self-contained by kernel.
If using  _DSM, a specific uefi or dtb has to be provided,
currently we can useQEMU_EFI.fd from apt install qemu-efi


Thanks
