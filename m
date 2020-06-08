Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919BB1F1195
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 04:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgFHCyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 22:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgFHCyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Jun 2020 22:54:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1CC08C5C6
        for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2020 19:54:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so5137589pju.3
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2020 19:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TNiiby0GhibJHmG02ytGWtb3GrXv/h2IE3SFE6qK8wY=;
        b=izDTLbNFapAPFawYa8bP5L1UpCxlkSTCCzx2ye/9STM1DqXymdysNnGkX12FV0/OIo
         tKcjXEIEuxSNO572pWS545T9DoQqGqTM8DmMcj/pjObZb/s4KuucXPV8lxnGJsPOEWOP
         creFxg4Q8lnO5UPN6FiY9AkscKdJteM1nKY+Qmci5RctGzZp1Lm8RhpxAeqkzQiUCQxI
         Gn/htYffz0hnLWeWv7zjKwwzU0TiNbE2IVaAoUldJmQdAcEGN9qicP3+rskQKiUOfzQ9
         T1+IF9bYkLx6QP/gZ6BWN651hoOpft0Cc6Lq2cjMJoEoVussc3m5Gv9e47HSM5NkG+Yl
         PSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TNiiby0GhibJHmG02ytGWtb3GrXv/h2IE3SFE6qK8wY=;
        b=eiQ0idfp1gOV6UCxMTOjBbT6VCzeUkrlCfb86V3+vwosfWgAmjjPGI1HwdCCVnfyYX
         ldTgqoCE1YVpr2SE0nYUcdWMYVuggrnEqN5nl8syYlMLGv6AQJWG9jztHQ24KfAb6pci
         R50SICjeRf2E5CZDOrc37IVVwr3ne9HRCBenzH7fyqGKCdoEME1hw9OFrYadXhrdcoIG
         dbnVhU1qVmvYRihqpVYtIroQ8IiGh85xglMHnAY/Ykg9lEPMZKtBPA3NeZ32gzqSJAA3
         r9+Z2eBk2/OXtF/6zO6d7deLjGA8p2GSwBNNzwbyTBNYW1MKbEmV5j3a1c9u+r1vV9Aq
         h9EQ==
X-Gm-Message-State: AOAM530qvWbLM/K8Wt+ZgWx+m1V+LCwo+PPZmmgIv4MlsO0RlHqByXq5
        2VWTtFfKWNBMMMurTswn5NqXGdIJ2HWeXw==
X-Google-Smtp-Source: ABdhPJxkqD1zFPHkx/wch8a4hS4Dcd7qZB1Ug7k+ig+u/wKNnkcnbqH/JdvGWQP6MIHxl1bz+Ni7fQ==
X-Received: by 2002:a17:90a:f3c4:: with SMTP id ha4mr15260604pjb.18.1591584870012;
        Sun, 07 Jun 2020 19:54:30 -0700 (PDT)
Received: from [10.80.2.98] ([45.135.186.73])
        by smtp.gmail.com with ESMTPSA id t9sm9533489pjs.16.2020.06.07.19.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 19:54:29 -0700 (PDT)
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20200605231909.GA1155454@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <be91b0f0-c685-789d-6868-1c8ebd62b770@linaro.org>
Date:   Mon, 8 Jun 2020 10:54:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200605231909.GA1155454@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On 2020/6/6 上午7:19, Bjorn Helgaas wrote:
> On Thu, Jun 04, 2020 at 09:33:07PM +0800, Zhangfei Gao wrote:
>> On 2020/6/2 上午1:41, Bjorn Helgaas wrote:
>>> On Thu, May 28, 2020 at 09:33:44AM +0200, Joerg Roedel wrote:
>>>> On Wed, May 27, 2020 at 01:18:42PM -0500, Bjorn Helgaas wrote:
>>>>> Is this slowdown significant?  We already iterate over every device
>>>>> when applying PCI_FIXUP_FINAL quirks, so if we used the existing
>>>>> PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
>>>>> adding two more iterations to the loop in pci_do_fixups() that tries
>>>>> to match quirks against the current device.  I doubt that would be a
>>>>> measurable slowdown.
>>>> I don't know how significant it is, but I remember people complaining
>>>> about adding new PCI quirks because it takes too long for them to run
>>>> them all. That was in the discussion about the quirk disabling ATS on
>>>> AMD Stoney systems.
>>>>
>>>> So it probably depends on how many PCI devices are in the system whether
>>>> it causes any measureable slowdown.
>>> I found this [1] from Paul Menzel, which was a slowdown caused by
>>> quirk_usb_early_handoff().  I think the real problem is individual
>>> quirks that take a long time.
>>>
>>> The PCI_FIXUP_IOMMU things we're talking about should be fast, and of
>>> course, they're only run for matching devices anyway.  So I'd rather
>>> keep them as PCI_FIXUP_FINAL than add a whole new phase.
>>>
>> Thanks Bjorn for taking time for this.
>> If so, it would be much simpler.
>>
>> +++ b/drivers/iommu/iommu.c
>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
>> fwnode_handle *iommu_fwnode,
>>          fwspec->iommu_fwnode = iommu_fwnode;
>>          fwspec->ops = ops;
>>          dev_iommu_fwspec_set(dev, fwspec);
>> +
>> +       if (dev_is_pci(dev))
>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
>> +
>>
>> Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
>> Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
>> Will send this when 5.8-rc1 is open.
> Wait, this whole fixup approach seems wrong to me.  No matter how you
> do the fixup, it's still a fixup, which means it requires ongoing
> maintenance.  Surely we don't want to have to add the Vendor/Device ID
> for every new AMBA device that comes along, do we?
>
>
Here the fake pci device has standard PCI cfg space, but physical 
implementation is base on AMBA
They can provide pasid feature.
However,
1, does not support tlp since they are not real pci devices.
2. does not support pri, instead support stall (provided by smmu)
And stall is not a pci feature, so it is not described in struct 
pci_dev, but in struct iommu_fwspec.
So we use this fixup to tell pci system that the devices can support 
stall, and hereby support pasid.

Thanks
