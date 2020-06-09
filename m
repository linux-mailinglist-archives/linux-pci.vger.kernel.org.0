Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981381F32DC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 06:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgFIECQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 00:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIECM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 00:02:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51009C08C5C3
        for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2020 21:02:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so7485959pld.13
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2020 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HNzwmKC7EPXO6n3v52ZypjHWMqVja532n8n2Tl/XPzU=;
        b=EOIGmeR3il5DVPJCDg4teJziBsjPIErqvQL1NApVhk0fIsJZDquLbvnv9AzOPFDTyM
         0Td9tgAsoePC+8tWwHQb/vU9PYB6G/Oyp14FK2hqZEG9usC/15NBI+bjl7shOVkS9PTS
         doO5YZ3ay6n1fRr9qSicgDl1sKMnJOAKnbUGeudLGxamrgFpyJqMg7/hVpo77ptwayW9
         gKyrCeWWc3sisMbmchG7OqNyEieqbYZexGGErCFQFvIiSgU0duds+YBbyLJBINOegnCw
         yZ0gUZKM/VpvoDsNXIFSXtVpSlXS2LMjFDE0fUXYn6WfLpaSP3YHgKbbD3TgUmNi7e1F
         Z0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HNzwmKC7EPXO6n3v52ZypjHWMqVja532n8n2Tl/XPzU=;
        b=YTcoa2WtTwsG+R9xFwZguUA3D1riKRwJ3rDEC/SULlJmyJd2n7EWYr5pzPrjlsmkBx
         DPnVOATBz+o4Z/42PhjG0rwbkB55m7sIpctkQUZ2+4PFcJEhRn9xinLRtdeARD/1S6Vm
         EKdHS1KbdiEHhT3vM9s7b1Kp/kuzUlHyhVG+jkS+7m1Mvz1I43q0QqkMvvGCOC99zkdh
         YgTDJ65a6d/2PIEP3BnqZD6SFWa9C2zFHLlN46p7K+tB/JbR+aBGDoSXzWHlNQu1Qnuv
         HberortYM+2PCrRq4fJ9hph4iIv+4UX4k/AJQnX/Vb8YC0IZ5cf8t/Mgtdzxn1zuFZ7A
         RZrw==
X-Gm-Message-State: AOAM532fyTFud0Ird0QYljphk/YWZ88awNMKx8rA2fBzRe5j86vO7LAI
        Rj4WNzlC1ZlkEsJLNFA2fdmybiGtpGXV9A==
X-Google-Smtp-Source: ABdhPJyCOlAhj/JYQL1lnU7VkdOeuU3CmI3RIp+QFxWZE3BRnL4347U0JAtJdOIRBNQs52eLSw55aw==
X-Received: by 2002:a17:90a:36cf:: with SMTP id t73mr2680766pjb.100.1591675330529;
        Mon, 08 Jun 2020 21:02:10 -0700 (PDT)
Received: from [10.175.1.166] ([45.135.186.20])
        by smtp.gmail.com with ESMTPSA id b24sm8402002pfo.112.2020.06.08.21.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 21:02:09 -0700 (PDT)
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
References: <20200608164148.GA1394249@bjorn-Precision-5520>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <bcf0a327-87b5-01ff-2f9c-ec6a6bd6c738@linaro.org>
Date:   Tue, 9 Jun 2020 12:01:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200608164148.GA1394249@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn

On 2020/6/9 上午12:41, Bjorn Helgaas wrote:
> On Mon, Jun 08, 2020 at 10:54:15AM +0800, Zhangfei Gao wrote:
>> On 2020/6/6 上午7:19, Bjorn Helgaas wrote:
>>> On Thu, Jun 04, 2020 at 09:33:07PM +0800, Zhangfei Gao wrote:
>>>> On 2020/6/2 上午1:41, Bjorn Helgaas wrote:
>>>>> On Thu, May 28, 2020 at 09:33:44AM +0200, Joerg Roedel wrote:
>>>>>> On Wed, May 27, 2020 at 01:18:42PM -0500, Bjorn Helgaas wrote:
>>>>>>> Is this slowdown significant?  We already iterate over every device
>>>>>>> when applying PCI_FIXUP_FINAL quirks, so if we used the existing
>>>>>>> PCI_FIXUP_FINAL, we wouldn't be adding a new loop.  We would only be
>>>>>>> adding two more iterations to the loop in pci_do_fixups() that tries
>>>>>>> to match quirks against the current device.  I doubt that would be a
>>>>>>> measurable slowdown.
>>>>>> I don't know how significant it is, but I remember people complaining
>>>>>> about adding new PCI quirks because it takes too long for them to run
>>>>>> them all. That was in the discussion about the quirk disabling ATS on
>>>>>> AMD Stoney systems.
>>>>>>
>>>>>> So it probably depends on how many PCI devices are in the system whether
>>>>>> it causes any measureable slowdown.
>>>>> I found this [1] from Paul Menzel, which was a slowdown caused by
>>>>> quirk_usb_early_handoff().  I think the real problem is individual
>>>>> quirks that take a long time.
>>>>>
>>>>> The PCI_FIXUP_IOMMU things we're talking about should be fast, and of
>>>>> course, they're only run for matching devices anyway.  So I'd rather
>>>>> keep them as PCI_FIXUP_FINAL than add a whole new phase.
>>>>>
>>>> Thanks Bjorn for taking time for this.
>>>> If so, it would be much simpler.
>>>>
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
>>>> fwnode_handle *iommu_fwnode,
>>>>           fwspec->iommu_fwnode = iommu_fwnode;
>>>>           fwspec->ops = ops;
>>>>           dev_iommu_fwspec_set(dev, fwspec);
>>>> +
>>>> +       if (dev_is_pci(dev))
>>>> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
>>>> +
>>>>
>>>> Then pci_fixup_final will be called twice, the first in pci_bus_add_device.
>>>> Here in iommu_fwspec_init is the second time, specifically for iommu_fwspec.
>>>> Will send this when 5.8-rc1 is open.
>>> Wait, this whole fixup approach seems wrong to me.  No matter how you
>>> do the fixup, it's still a fixup, which means it requires ongoing
>>> maintenance.  Surely we don't want to have to add the Vendor/Device ID
>>> for every new AMBA device that comes along, do we?
>>>
>> Here the fake pci device has standard PCI cfg space, but physical
>> implementation is base on AMBA
>> They can provide pasid feature.
>> However,
>> 1, does not support tlp since they are not real pci devices.
>> 2. does not support pri, instead support stall (provided by smmu)
>> And stall is not a pci feature, so it is not described in struct pci_dev,
>> but in struct iommu_fwspec.
>> So we use this fixup to tell pci system that the devices can support stall,
>> and hereby support pasid.
> This did not answer my question.  Are you proposing that we update a
> quirk every time a new AMBA device is released?  I don't think that
> would be a good model.
Yes, you are right, but we do not have any better idea yet.
Currently we have three fake pci devices, which support stall and pasid.
We have to let pci system know the device can support pasid, because of 
stall feature, though not support pri.
Do you have any other ideas?

Thanks
