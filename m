Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2E392CC1
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhE0Lcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhE0Lcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 07:32:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8733C061574;
        Thu, 27 May 2021 04:31:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso2381547wmh.4;
        Thu, 27 May 2021 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KATMEEULbArdKg71v5u/QUDQiIEPhSKpklwnDwdn0qU=;
        b=plVpYTQiKgnHx+Nxz1Ixlr285XcJe75rG/mDA0AFTqI+sZrTrC848CnhTyTb9fEiSn
         7yJ5zgfwf6ALO37QjuqM/Y7cJ6sIBfM2k8kGb+/lPt6gK/VIVfDMwXJ0b6oNnk1e1HuD
         vAExsNAXyfaLlaa8LteEjtM7EDvM0hI5Dk2iFPdlweiU6QS/xWLfjM8gCQqNH0Ds9ef1
         5v1HvxpjIeaHcfLbe9tEktgZNEOz3S09UrRdrjY54pahpdR+BE47wq/pRav5f/rtv2lB
         G+KSha+BrIFKisz6hmyBJrAP3Wu99iD/JXWS1h2mVY7NUcXHbtv0HFFqiE3Xf1a/FGDe
         Vl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KATMEEULbArdKg71v5u/QUDQiIEPhSKpklwnDwdn0qU=;
        b=Hl9f9fYQVy65kTJo2OjthoE7sg6zU/JmEuOswxjwzJqDb1FG74qlaDWmY0gFTMne7u
         gja0RLIMsY66vjnXuKv4TuoSnQVwaD2fWZ49Aou3D/5Gop0+83pLVBecByM2Nz0E6Ie8
         EW741784K7aNk/h41T38SIHl/6Ye0875I5Km2VIJihU5nN7aWFD4j1IkFfza77ht4puk
         6YaRdA7o3Y1d9z9Fl5B+cBjsdIn4ueau9ge2WJ6md3nGHQ1kfUf/ybgCTztN19y/swWa
         rV8DljMAAIoir5NMCiahgvq8x5sOf5rFX62l/rb1v7YNBQSTQzvXW32VctNZYupcOAoj
         3u9Q==
X-Gm-Message-State: AOAM5334CQkKVLXgTrZ7Rw/hbsts9yAydBUt1R4diu9dZS92598OgWxF
        hw9nuT7XXas+WJX2XO/ba+Viy8PpqQw=
X-Google-Smtp-Source: ABdhPJxckNo2cCoxb0942vCm1JKgR8GRKEysnugWK/PPZeg8n9i4HjJDoX4d9u+MZqOsEFADEzBP8A==
X-Received: by 2002:a1c:8016:: with SMTP id b22mr2921485wmd.43.1622115078937;
        Thu, 27 May 2021 04:31:18 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a576.dip0.t-ipconnect.de. [217.229.165.118])
        by smtp.gmail.com with ESMTPSA id m11sm2288979wmq.33.2021.05.27.04.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 04:31:18 -0700 (PDT)
Subject: Re: [RFC PATCH] Revert "arm64: PCI: Exclude ACPI "consumer" resources
 from host bridge windows"
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210510234020.1330087-1-luzmaximilian@gmail.com>
 <20210526205836.GA20320@willie-the-truck> <20210527093200.GA16444@lpieralisi>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <e90401dc-e146-743d-93c7-8525ac0f639e@gmail.com>
Date:   Thu, 27 May 2021 13:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210527093200.GA16444@lpieralisi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/27/21 11:32 AM, Lorenzo Pieralisi wrote:
> On Wed, May 26, 2021 at 09:58:36PM +0100, Will Deacon wrote:
>> On Tue, May 11, 2021 at 01:40:20AM +0200, Maximilian Luz wrote:
>>> The Microsoft Surface Pro X has host bridges defined as
>>>
>>>      Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
>>>      Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
>>>
>>>      Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>>>      {
>>>          Name (RBUF, ResourceTemplate ()
>>>          {
>>>              Memory32Fixed (ReadWrite,
>>>                  0x60200000,         // Address Base
>>>                  0x01DF0000,         // Address Length
>>>                  )
>>>              WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>>>                  0x0000,             // Granularity
>>>                  0x0000,             // Range Minimum
>>>                  0x0001,             // Range Maximum
>>>                  0x0000,             // Translation Offset
>>>                  0x0002,             // Length
>>>                  ,, )
>>>          })
>>>          Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
>>>      }
>>>
>>> meaning that the memory resources aren't (explicitly) defined as
>>> "producers", i.e. host bridge windows.
>>>
>>> Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
>>> host bridge windows") introduced a check that removes such resources,
>>> causing BAR allocation failures later on:
>>>
>>>      [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
>>>      [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
>>>      [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
>>>      [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
>>>
>>> This eventually prevents the PCIe NVME drive from being accessible.
>>>
>>> On x86 we already skip the check for producer/window due to some history
>>> with negligent firmware. It seems that Microsoft is intent on continuing
>>> that history on their ARM devices, so let's drop that check here too.
>>>
>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>>> ---
>>>
>>> Please note: I am not sure if this is the right way to fix that, e.g. I
>>> don't know if any additional checks like on IA64 or x86 might be
>>> required instead, or if this might break things on other devices. So
>>> please consider this more as a bug report rather than a fix.
>>>
>>> Apologies for the re-send, I seem to have unintentionally added a blank
>>> line before the subject.
>>>
>>> ---
>>>   arch/arm64/kernel/pci.c | 14 --------------
>>>   1 file changed, 14 deletions(-)
>>
>> Adding Lorenzo to cc, as he'll have a much better idea about this than me.
>>
>> This is:
>>
>> https://lore.kernel.org/r/20210510234020.1330087-1-luzmaximilian@gmail.com
> 
> Sigh. We can't apply this patch since it would trigger regressions on
> other platforms (IIUC the root complex registers would end up in the
> host bridge memory windows).
> 
> I am not keen on reverting commit 8fd4391ee717 because it does the
> right thing.
> 
> I think this requires a quirk and immediate reporting to Microsoft.

Since I wrote this I have found other arm64 devices with the same
problem. I don't think that this is Microsoft exclusive anymore, but
rather that this is a Qualcomm problem (Qualcomm SoC seems to be the
common thread). See e.g. DSDTs in [1]. So it should probably be reported
to them.

Regards,
Max

[1]: https://github.com/aarch64-laptops/build/tree/dfce25bc12655713c7e1e0422b191e9c944e4fb2/misc
