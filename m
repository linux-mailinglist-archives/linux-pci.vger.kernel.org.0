Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2C2759FC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIWOaN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Sep 2020 10:30:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51527 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgIWOaM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 10:30:12 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kL5ma-0007D5-DI
        for linux-pci@vger.kernel.org; Wed, 23 Sep 2020 14:30:08 +0000
Received: by mail-pl1-f198.google.com with SMTP id f10so56919plo.20
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2020 07:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bTfab3UbFmb3i36HEK+E15jbAlsnpbbsPCZOXGV2m7Y=;
        b=QAManeL77ucxjRxyTYy1lqAPxcQklHFKwhhUfewkyNRMzhDvqNui7FLOfMBfMCE0l5
         mQsGXnohK2dyz5bbRsLkWbhpzsKmPBtPuSna4GTrldRETOUs1MUvl2cDGylwPiVQlF9f
         xTAq1WAfzP7JUQ0uYJuAHeZ0nbPtV1Q4vynU8kExlYw+opxqVDpPSzIFvXwad6mksA0F
         kijn6CVp2Ioo6gBY1yeElYhes3fQEGs5K4UNUFBNhEvOx8vFQkAF5dW6z0wZT/vwcg0z
         KzZMyD40T4N/dNQi8f/jQhTo/uynZSS9ZXFAP5+pDPk381VknVy2bRNZJTWgbwZChAfq
         ZFFA==
X-Gm-Message-State: AOAM533eILRfkBbHDr3HZsnmDT/3yV+Z4/wwbv37AvdNHnoxfryMuyQs
        YNmRIRZsYTRKQPQsANSEz968Uts340y2mfj7z6cK2tapnK12Gg72j9PZmlbBQiyDZdbz5SW3sWh
        eI5rL3L2OZqnbNS5aMIQM3SqJ6cOCnDWTZV6xMw==
X-Received: by 2002:a62:7743:0:b029:13c:1611:658e with SMTP id s64-20020a6277430000b029013c1611658emr209632pfc.11.1600871406814;
        Wed, 23 Sep 2020 07:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuF3wBMfqqTypFQALOKXjOzXHiWXaErIQvPGZx7JS6B0eLRg6hqfUAcaLput8HyMdvUO1QYg==
X-Received: by 2002:a62:7743:0:b029:13c:1611:658e with SMTP id s64-20020a6277430000b029013c1611658emr209583pfc.11.1600871406315;
        Wed, 23 Sep 2020 07:30:06 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 72sm18172040pfx.79.2020.09.23.07.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 07:30:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200917172010.GA1710481@bjorn-Precision-5520>
Date:   Wed, 23 Sep 2020 22:29:39 +0800
Cc:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "refactormyself@gmail.com" <refactormyself@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <49A36179-D336-4A5E-8B7A-A632833AE6B2@canonical.com>
References: <20200917172010.GA1710481@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Sep 18, 2020, at 01:20, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Thu, Sep 10, 2020 at 07:51:05PM +0000, Derrick, Jonathan wrote:
>> On Thu, 2020-09-10 at 14:17 -0500, Bjorn Helgaas wrote:
>>> On Thu, Sep 10, 2020 at 06:52:48PM +0000, Derrick, Jonathan wrote:
>>>> On Thu, 2020-09-10 at 12:38 -0500, Bjorn Helgaas wrote:
>>>>> On Thu, Sep 10, 2020 at 04:33:39PM +0000, Derrick, Jonathan wrote:
>>>>>> On Wed, 2020-09-09 at 20:55 -0500, Bjorn Helgaas wrote:
>>>>>>> On Fri, Aug 21, 2020 at 08:32:20PM +0800, Kai-Heng Feng wrote:
>>>>>>>> New Intel laptops with VMD cannot reach deeper power saving state,
>>>>>>>> renders very short battery time.
>>>>>>>> 
>>>>>>>> As BIOS may not be able to program the config space for devices under
>>>>>>>> VMD domain, ASPM needs to be programmed manually by software. This is
>>>>>>>> also the case under Windows.
>>>>>>>> 
>>>>>>>> The VMD controller itself is a root complex integrated endpoint that
>>>>>>>> doesn't have ASPM capability, so we can't propagate the ASPM settings to
>>>>>>>> devices under it. Hence, simply apply ASPM_STATE_ALL to the links under
>>>>>>>> VMD domain, unsupported states will be cleared out anyway.
>>>>>>>> 
>>>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>>> ---
>>>>>>>> drivers/pci/pcie/aspm.c |  3 ++-
>>>>>>>> drivers/pci/quirks.c    | 11 +++++++++++
>>>>>>>> include/linux/pci.h     |  2 ++
>>>>>>>> 3 files changed, 15 insertions(+), 1 deletion(-)
>>>>>>>> 
>>>>>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>>>>>> index 253c30cc1967..dcc002dbca19 100644
>>>>>>>> --- a/drivers/pci/pcie/aspm.c
>>>>>>>> +++ b/drivers/pci/pcie/aspm.c
>>>>>>>> @@ -624,7 +624,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>>>>>>> 		aspm_calc_l1ss_info(link, &upreg, &dwreg);
>>>>>>>> 
>>>>>>>> 	/* Save default state */
>>>>>>>> -	link->aspm_default = link->aspm_enabled;
>>>>>>>> +	link->aspm_default = parent->dev_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
>>>>>>>> +			     ASPM_STATE_ALL : link->aspm_enabled;
>>>>>>> 
>>>>>>> This function is ridiculously complicated already, and I really don't
>>>>>>> want to make it worse.
>>>>>>> 
>>>>>>> What exactly is the PCIe topology here?  Apparently the VMD controller
>>>>>>> is a Root Complex Integrated Endpoint, so it's a Type 0 (non-bridge)
>>>>>>> device.  And it has no Link, hence no Link Capabilities or Control and
>>>>>>> hence no ASPM-related bits.  Right?
>>>>>> 
>>>>>> That's correct. VMD is the Type 0 device providing config/mmio
>>>>>> apertures to another segment and MSI/X remapping. No link and no ASPM
>>>>>> related bits.
>>>>>> 
>>>>>> Hierarchy is usually something like:
>>>>>> 
>>>>>> Segment 0           | VMD segment
>>>>>> Root Complex -> VMD | Type 0 (RP/Bridge; physical slot) - Type 1
>>>>>>                    | Type 0 (RP/Bridge; physical slot) - Type 1
>>>>>> 
>>>>>>> And the devices under the VMD controller?  I guess they are regular
>>>>>>> PCIe Endpoints, Switch Ports, etc?  Obviously there's a Link involved
>>>>>>> somewhere.  Does the VMD controller have some magic, non-architected
>>>>>>> Port on the downstream side?
>>>>>> 
>>>>>> Correct: Type 0 and Type 1 devices, and any number of Switch ports as
>>>>>> it's usually pinned out to physical slot.
>>>>>> 
>>>>>>> Does this patch enable ASPM on this magic Link between VMD and the
>>>>>>> next device?  Configuring ASPM correctly requires knowledge and knobs
>>>>>>> from both ends of the Link, and apparently we don't have those for the
>>>>>>> VMD end.
>>>>>> 
>>>>>> VMD itself doesn't have the link to it's domain. It's really just the
>>>>>> config/mmio aperture and MSI/X remapper. The PCIe link is between the
>>>>>> Type 0 and Type 1 devices on the VMD domain. So fortunately the VMD
>>>>>> itself is not the upstream part of the link.
>>>>>> 
>>>>>>> Or is it for Links deeper in the hierarchy?  I assume those should
>>>>>>> just work already, although there might be issues with latency
>>>>>>> computation, etc., because we may not be able to account for the part
>>>>>>> of the path above VMD.
>>>>>> 
>>>>>> That's correct. This is for the links within the domain itself, such as
>>>>>> between a type 0 and NVMe device.
>>>>> 
>>>>> OK, great.  So IIUC, below the VMD, there is a Root Port, and the Root
>>>>> Port has a link to some Endpoint or Switch, e.g., an NVMe device.  And
>>>>> we just want to enable ASPM on that link.
>>>>> 
>>>>> That should not be a special case; we should be able to make this so
>>>>> it Just Works.  Based on this patch, I guess the reason it doesn't
>>>>> work is because link->aspm_enabled for that link isn't set correctly.
>>>>> 
>>>>> So is this just a consequence of us depending on the initial Link
>>>>> Control value from BIOS?  That seems like something we shouldn't
>>>>> really depend on.
>> Seems like a good idea, that it should instead be quirked if ASPM is
>> found unusable on a link. Though I'm not aware of how many platforms
>> would require a quirk..
>> 
>>>>> 
>>>> That's the crux. There's always pcie_aspm=force.
>>>> Something I've wondered is if there is a way we could 'discover' if the
>>>> link is ASPM safe?
>>> 
>>> Sure.  Link Capabilities is supposed to tell us that.  If aspm.c
>>> depends on the BIOS settings, I think that's a design mistake.
>>> 
>>> But what CONFIG_PCIEASPM_* setting are you using?  The default
>>> is CONFIG_PCIEASPM_DEFAULT, which literally means "Use the BIOS
>>> defaults".  If you're using that, and BIOS doesn't enable ASPM below
>>> VMD, I guess aspm.c will leave it disabled, and that seems like it
>>> would be the expected behavior.
>>> 
>>> Does "pcie_aspm=force" really help you?  I don't see any uses of it
>>> that should apply to your situation.
>>> 
>>> Bjorn
>> 
>> No you're right. I don't think we need pcie_aspm=force, just the policy
>> configuration.
> 
> I'm not sure where we're at here.
> 
> If the kernel is built with CONFIG_PCIEASPM_DEFAULT=y (which means
> "use the BIOS defaults"), and the BIOS doesn't enable ASPM on these
> links below VMD, then Linux will leave things alone.  I think that's
> working as intended.

Yes and that's the problem here. BIOS doesn't enable ASPM for links behind VMD.
The ASPM is enabled by VMD driver under Windows.

> 
> If desired, we should be able to enable ASPM using sysfs in that case.

I hope to keep everything inside kernel. Of course we can use udev rules to change sysfs value, if anyone prefers that approach.

> 
> We have a pci_disable_link_state() kernel interface that drivers can
> use to *disable* ASPM for their device.  But I don't think there's any
> corresponding interface for drivers to *enable* ASPM.  Maybe that's an
> avenue to explore?

Okay, I will work on pci_enable_link_state() helper and let VMD driver as its first user.

Kai-Heng

> 
> Bjorn

