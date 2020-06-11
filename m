Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188BA1F602D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 04:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgFKCzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 22:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgFKCzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 22:55:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F6C08C5C4
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 19:55:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so1651791pjb.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2020 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j30R0UZzrDd+0W4T3mjyr9hSWvrdW6CBf5sEGoGyfXI=;
        b=YbaZTSS93EP7PjECnua8oQ5ab7vBqk+ABuJX3e/qK8iuRB9AZboQWcjN9nOMr3LEbO
         Ic3FExHwmXhD8IBQDuvf7PFai5iqbX30bSunhs2TMSctm3jwu2Uzv76XGLvxka7YiNwP
         bq+7hOvVNy4n3/9jtpUQgXYOsSMEVQBHAJrUYqakK406cocI/KCCzcSLB4+ueA0JzKqs
         Buiehe3CYrBtuZdIAg4nRXYalSDn4FcRin/SU3b538yPpBy/RMKVFtRfxjP1BOW3HND4
         /VPgwJwonI+rVPBxtz/j8jsZ6O4mcvc2fzPJnUW6EshfwLCtM9V+VFfrn06vgaptR/YO
         6ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j30R0UZzrDd+0W4T3mjyr9hSWvrdW6CBf5sEGoGyfXI=;
        b=Eg35JyfNUPac6iwL68xSX9LC5JwBHADCeOSH0qG/E6jaIZA8Gl6gwk7MSGj5AEl8b3
         l6zoYzqlSbC2gipldvM/lSesF9O6uNnd/iF7CDybXQtarWauYFAUd4oSK8TCNEiVOmFc
         4En2jIjic0V/0laL+ZtwA5sEFPDUqB5QWq/x6eoomf3+SbcR67imxiVogjFMBAL47EUv
         LrNexD/g1+MA7schBRFOML+6K5N8m4/SM6HCKiax+4WbgYQnmMl3bQRRl8MvNpsIkViE
         cK08j8LFOiR/m+RMWnPPsOkJr67W0phmanJMx4BBwDo0QH8lA5tNat9VJtXZGwXdO0Eo
         vmXw==
X-Gm-Message-State: AOAM530jThzc81sJNUEvRxHnuomrw4jneebILstI2aApZd4mgKE91sNI
        ozOFgzuu+qjEL91vrGcD/fXOny4lI2+Kkg==
X-Google-Smtp-Source: ABdhPJy13QPXB7ndCJTCJUZMyAvmhnKxmSP60f1ha+1dPVVCf9spfvGWBTpxKJ0hiwq4FFMTSLSh6Q==
X-Received: by 2002:a17:90a:c717:: with SMTP id o23mr5951320pjt.195.1591844100426;
        Wed, 10 Jun 2020 19:55:00 -0700 (PDT)
Received: from [10.80.1.206] ([45.135.186.73])
        by smtp.gmail.com with ESMTPSA id 6sm1259143pfi.170.2020.06.10.19.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 19:54:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
References: <20200609164926.GA1452092@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <1d8a7ec4-b578-a97a-7835-453806f4e3ef@linaro.org>
Date:   Thu, 11 Jun 2020 10:54:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609164926.GA1452092@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/6/10 上午12:49, Bjorn Helgaas wrote:
> On Tue, Jun 09, 2020 at 11:15:06AM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 9, 2020 at 6:02 AM Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>>> On 2020/6/9 上午12:41, Bjorn Helgaas wrote:
>>>> On Mon, Jun 08, 2020 at 10:54:15AM +0800, Zhangfei Gao wrote:
>>>>> On 2020/6/6 上午7:19, Bjorn Helgaas wrote:
>>>>>>> +++ b/drivers/iommu/iommu.c
>>>>>>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
>>>>>>> fwnode_handle *iommu_fwnode,
>>>>>>>            fwspec->iommu_fwnode = iommu_fwnode;
>>>>>>>            fwspec->ops = ops;
>>>>>>>            dev_iommu_fwspec_set(dev, fwspec);
>>>>>>> +
>>>>>>> +       if (dev_is_pci(dev))
>>>>>>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
>>>>>>> +
>>>>>>>
>>>>>>> Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
>>>>>>> Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
>>>>>>> Will send this when 5.8-rc1 is open.
>>>>>> Wait, this whole fixup approach seems wrong to me.  No matter how you
>>>>>> do the fixup, it's still a fixup, which means it requires ongoing
>>>>>> maintenance.  Surely we don't want to have to add the Vendor/Device ID
>>>>>> for every new AMBA device that comes along, do we?
>>>>>>
>>>>> Here the fake pci device has standard PCI cfg space, but physical
>>>>> implementation is base on AMBA
>>>>> They can provide pasid feature.
>>>>> However,
>>>>> 1, does not support tlp since they are not real pci devices.
>>>>> 2. does not support pri, instead support stall (provided by smmu)
>>>>> And stall is not a pci feature, so it is not described in struct pci_dev,
>>>>> but in struct iommu_fwspec.
>>>>> So we use this fixup to tell pci system that the devices can support stall,
>>>>> and hereby support pasid.
>>>> This did not answer my question.  Are you proposing that we update a
>>>> quirk every time a new AMBA device is released?  I don't think that
>>>> would be a good model.
>>> Yes, you are right, but we do not have any better idea yet.
>>> Currently we have three fake pci devices, which support stall and pasid.
>>> We have to let pci system know the device can support pasid, because of
>>> stall feature, though not support pri.
>>> Do you have any other ideas?
>> It sounds like the best way would be to allocate a PCI capability for it, so
>> detection can be done through config space, at least in future devices,
>> or possibly after a firmware update if the config space in your system
>> is controlled by firmware somewhere.  Once there is a proper mechanism
>> to do this, using fixups to detect the early devices that don't use that
>> should be uncontroversial. I have no idea what the process or timeline
>> is to add new capabilities into the PCIe specification, or if this one
>> would be acceptable to the PCI SIG at all.
> That sounds like a possibility.  The spec already defines a
> Vendor-Specific Extended Capability (PCIe r5.0, sec 7.9.5) that might
> be a candidate.
Will investigate this, thanks Bjorn
>
>> If detection cannot be done through PCI config space, the next best
>> alternative is to pass auxiliary data through firmware. On DT based
>> machines, you can list non-hotpluggable PCIe devices and add custom
>> properties that could be read during device enumeration. I assume
>> ACPI has something similar, but I have not done that.
Yes, thanks Arnd
> ACPI has _DSM (ACPI v6.3, sec 9.1.1), which might be a candidate.  I
> like this better than a PCI capability because the property you need
> to expose is not a PCI property.
_DSM may not workable, since it is working in runtime.
We need stall information in init stage, neither too early (after 
allocation of iommu_fwspec)
nor too late (before arm_smmu_add_device ).

By the way,
It would be a long time if we need modify either pcie spec or acpi spec.
Can we use pci_fixup_device in iommu_fwspec_init first, it is relatively 
simple
and meet the requirement of platform device using pasid, and they are 
already in product.

Thanks

