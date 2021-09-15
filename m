Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5540C9B5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhIOQHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbhIOQHJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 12:07:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E089AC061574;
        Wed, 15 Sep 2021 09:05:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so5218464wmq.1;
        Wed, 15 Sep 2021 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pUEDn+wGVFuZIGgP7SMh1pO9rPToQCJ2HXOPEQfBxeM=;
        b=kxIkdNsxQCClLdZT44Z1sBKv9y8euz2zes/UaPqWvKSTKO/wlfspE+KVQskDKPWG+G
         oIoOS8by6DF1EGy6jjy9Vso3/8r3S4ctU39w1RhXJZ6RnV6mx5ofoThii1RfeyGMu8Jw
         8aLusHRCacWIq5HkP3k+UT2YPpRbjCqnzBDnnI4cD6QqcMI6pBt1CO6msIJVrkMGySz7
         RjUnEExFYS61wwRp/K5btLBtwzK1m58mnN4CgvEF0omgJw+yESzDITUYzTvWnEP3VphW
         zp6mUYlUkDh4wO/MZV9PdoW6+KGofORVATctnneoZP1t34ynP0mzN7uEyxMm/lsHORvP
         YOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pUEDn+wGVFuZIGgP7SMh1pO9rPToQCJ2HXOPEQfBxeM=;
        b=sKfeShpbpSC9xFgZmdtjaF37rdHYCXEc9z30/mEIY7h5Hqysx9B/+mXIO05GmX8YXN
         87wB1mY4j7QprFOry8xhDlz1CqwA+J21exSNJTgb3rijJxgNCZo7M+fJcuhunTsBbxNF
         AvQdVzC//BhvW4SDX27jHc9D+35FNkstYPQ8pp2+jD4ehJKCaLxjLVqm9PGxg+a42lIp
         NDpxZqk8bMJVpfkKaFN2RwkwDjzYUXj0DXsExS7ZDfp75VIQ5jM8OTuQ1pVMpCY4Cjvv
         wWHXNY4XMpq184MaL33yBvlRVhSnbIJD0GbW57EyTQtMeeEW9KtxSyayyjFPkA/qO2TZ
         xuWA==
X-Gm-Message-State: AOAM533N4weHyKNMreQtCa/F33PloIXeLxGKbxiKWcQ11YE4tw8SB5Am
        vyvFEJ2pkG6gbbZZW8Z5nHaK2PDbCFg=
X-Google-Smtp-Source: ABdhPJwq7e9x09s+3oaFDVBVCy7WaLr9skjRUIm4gGsRhnyhhmWNbe2zalWVuWq8F1iJTkXhZG9kzw==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr5494618wmi.10.1631721948396;
        Wed, 15 Sep 2021 09:05:48 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:619b:3ca6:ce93:7943? (p200300ea8f084500619b3ca6ce937943.dip0.t-ipconnect.de. [2003:ea:8f08:4500:619b:3ca6:ce93:7943])
        by smtp.googlemail.com with ESMTPSA id j2sm387829wrq.35.2021.09.15.09.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:05:48 -0700 (PDT)
Subject: Re: [Intel-wired-lan] Linux 5.15-rc1 - 82599ES VPD access isue
To:     Hisashi T Fujinaka <htodd@twofifty.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk>
 <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk>
 <b84b799d-0aaa-c4e1-b61b-8e2316b62bd1@gmail.com>
 <20210913203234.GA6762@codemonkey.org.uk>
 <b24d81e2-5a1e-3616-5a01-abd58c0712f7@gmail.com>
 <b4b543d4-c0c5-3c56-46b7-e17ec579edcc@twofifty.com>
 <367cc748-d411-8cf8-ff95-07715c55e899@gmail.com>
 <20210914142419.GA32324@codemonkey.org.uk>
 <c02876d7-c3f3-1953-334d-1248af919796@twofifty.com>
 <80718d5e-a4d2-ff85-aa8f-cd790c951278@gmail.com>
 <14f6d9e9-aca8-133-67f5-92effa2ea280@twofifty.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d49182d6-15fe-15a1-c063-4808942a84c1@gmail.com>
Date:   Wed, 15 Sep 2021 18:05:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <14f6d9e9-aca8-133-67f5-92effa2ea280@twofifty.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15.09.2021 16:18, Hisashi T Fujinaka wrote:
> On Tue, 14 Sep 2021, Heiner Kallweit wrote:
> 
>> On 14.09.2021 22:00, Hisashi T Fujinaka wrote:
>>> On Tue, 14 Sep 2021, Dave Jones wrote:
>>>
>>>> On Tue, Sep 14, 2021 at 07:51:22AM +0200, Heiner Kallweit wrote:
>>>>
>>>>>> Sorry to reply from my personal account. If I did it from my work
>>>>>> account I'd be top-posting because of Outlook and that goes over like a
>>>>>> lead balloon.
>>>>>>
>>>>>> Anyway, can you send us a dump of your eeprom using ethtool -e? You can
>>>>>> either send it via a bug on e1000.sourceforge.net or try sending it to
>>>>>> todd.fujinaka@intel.com
>>>>>>
>>>>>> The other thing is I'm wondering is what the subvendor device ID you
>>>>>> have is referring to because it's not in the pci database. Some ODMs
>>>>>> like getting creative with what they put in the NVM.
>>>>>>
>>>>>> Todd Fujinaka (todd.fujinaka@intel.com)
>>>>>
>>>>> Thanks for the prompt reply. Dave, could you please provide the requested
>>>>> information?
>>>>
>>>> sent off-list.
>>>>
>>>>     Dave
>>>
>>> Whoops. I replied from outlook again.
>>>
>>> I have confirmation that this should be a valid image. The VPD is just a
>>> series of 3's. There are changes to preboot header, flash and BAR size,
>>> and as far as I can tell, a nonsense subdevice ID, but this should work.
>>>
>>> What was the original question?
>>>
>> "lspci -vv" complains about an invalid short tag 0x06 and the PCI VPD
>> code resulted in a stall. So it seems the data doesn't have valid VPD
>> format as defined in PCI specification.
>>
>> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection (rev 01)
>>        Subsystem: Device 1dcf:030a
>>     ...
>>             Capabilities: [e0] Vital Product Data
>>                *Unknown small resource type 06, will not decode more.*
>>
>> Not sure which method is used by the driver to get the EEPROM content.
>> For the issue here is relevant what is exposed via PCI VPD.
>>
>> The related kernel error message has been reported few times, e.g. here:
>> https://access.redhat.com/solutions/3001451
>> Only due to a change in kernel code this became a more prominent
>> issue now.
>>
>> You say that VPD is just a series of 3's. This may explain why kernel and
>> tools complain about an invalid VPD format. VPD misses the tag structure.
> 
> I think I conflated two issues and yours may not be the one with the
> weird Amazon NIC. In any case, the VPD does not match the spec and two
> people have confirmed it's just full of 3's. With the bogus subvendor
> ID, I'm thinking this is not an Intel NIC.
> 
> Next step is to contact whoever made the NIC and ask them for guidance.
> 
In an earlier mail in this thread was stated that subvendor id is unknown.
Checking here https://pcisig.com/membership/member-companies?combine=1dcf
it says: Beijing Sinead Technology Co., Ltd.

> Todd Fujinaka <todd.fujinaka@intel.com>

