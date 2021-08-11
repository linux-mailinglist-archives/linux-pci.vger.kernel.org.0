Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC53E8BFD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhHKIkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 04:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbhHKIkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 04:40:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6EEC061765;
        Wed, 11 Aug 2021 01:39:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so1382837wmd.3;
        Wed, 11 Aug 2021 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/cH18u9OhTCq+UpoTOaDG1DbIfkplQjzOdXKSsM62pY=;
        b=rhcOyetStHFST5GEeY1BJw0x7RWCBh9KJoHPIxjlpISW1LTUNyjLuUyAPLHTj6Xgco
         mfCVCXvil0lwxvRCLm5akQNAE1L5oq6ORX8ElGjg3o9IboKQhQaoaDFNvX/aEMjTUaeT
         mbGMuXEzF3j31qdvoqj2HimFUECogfbCXEBLwmayU/t4YKjutfmN+/8nHbmACAwp0h+j
         ZWPtqo03iknDZHwqSwfu8vDSf/lm4zbqikKpHf8s8wv2Ay2cK49riyP/A9KvIj8wVyYw
         OPal5vsEZuP/AOn2+7E02in4Fm3lpF6mmb3YJcdYU9OuK7PP8aue4SN8rLSwm/c1CQKE
         aVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/cH18u9OhTCq+UpoTOaDG1DbIfkplQjzOdXKSsM62pY=;
        b=VxxdS8OrnMfhHQ3DFnahh/HPMAuwG0cDxR2Xq4y0fW0X9KsjEqrJ8Jmw1GW5nKY6Os
         /bCcEL4P32ngD2jvUU6cFYDMwYn7AVcEDEs55dlhNgH//yVMoDQ3iBT69JwNgFmT5XkU
         modPYgCchZvIyIuie/ziwnGha6megBH2ryh8y86KHcBIEseWvyiec85RYAO7r0pVzAKJ
         aOyoPNO6XGyjRfwWmzAd/OTda297Y5qRJpiEklV7Dk825CODAuG3WERGFoQlRmEm9C+o
         gOeT0jRcDLrm5AHWkAr8yDCWCcSvWa8fMq35CgGSI7f1NehpsAbj33n+ipP/vhtcluGE
         Ghlg==
X-Gm-Message-State: AOAM5321y52gNDV9Pfq5hxic+8Bmoi1PAth/JE4rR5TdywEVBMSQycZS
        Ngvz5G72QoDT/bew+Jz96DfbV1HV5hLs3g==
X-Google-Smtp-Source: ABdhPJzvXPBtPce351ozTgUTJzAFC8LeON/hShsPJeZMmb9e8OuKPmGCXGsHChYOwT4/VHQjTHse6g==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr8745229wmk.97.1628671193039;
        Wed, 11 Aug 2021 01:39:53 -0700 (PDT)
Received: from ?IPv6:2a01:cb05:8192:e700:90a4:fe44:d3d1:f079? (2a01cb058192e70090a4fe44d3d1f079.ipv6.abo.wanadoo.fr. [2a01:cb05:8192:e700:90a4:fe44:d3d1:f079])
        by smtp.gmail.com with ESMTPSA id h9sm22884485wmb.35.2021.08.11.01.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 01:39:52 -0700 (PDT)
Subject: Re: [PATCH 1/3] PCI: brcmstb: Break register definitions into
 separate header
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210805211200.491275-1-jeremy.linton@arm.com>
 <20210805211200.491275-2-jeremy.linton@arm.com>
 <f82761b1-fb7e-08b2-8bc3-c84d258e26d3@gmail.com>
 <ab2aa9e3-cdc7-1bc7-d493-8f3c991c3285@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ff7c598a-4c1d-7da0-f40a-f0c435e785d3@gmail.com>
Date:   Wed, 11 Aug 2021 01:39:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ab2aa9e3-cdc7-1bc7-d493-8f3c991c3285@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/10/2021 8:10 AM, Jeremy Linton wrote:
> Hi,
> 
> Thanks for taking a look at this!
> 
> 
> On 8/10/21 5:07 AM, Florian Fainelli wrote:
>>
>>
>> On 8/5/2021 2:11 PM, Jeremy Linton wrote:
>>> We are about to create a standalone ACPI quirk module for the
>>> bcmstb controller. Lets move the register definitions into a separate
>>> file so they can be shared between the APCI quirk and the normal
>>> host bridge driver.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   drivers/pci/controller/pcie-brcmstb.c | 179 +------------------------
>>>   drivers/pci/controller/pcie-brcmstb.h | 182 ++++++++++++++++++++++++++
>>>   2 files changed, 183 insertions(+), 178 deletions(-)
>>>   create mode 100644 drivers/pci/controller/pcie-brcmstb.h
>>
>> You moved more than just register definitions into pcie-brcmstb.h you 
>> also moved internal structure definitions, enumerations, etc. which 
>> are not required since pcie-brcmstb-acpi.c does not access the 
>> brcm_pcie structure but open codes accesses to the MISC_STATUS 
>> register instead.
>>
>> There are no include guards added to this file (it is debatable 
>> whether we should add them), and it is also not covered by the 
>> existing BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE MAINTAINERS file 
>> entry.
> 
> Sure, I will reduce the .h to just the register definitions, guard it, 
> and tweak maintainers to cover pcie-brcmstb*.
> 
> 
>>
>> Given that there can be new platforms supported by this PCIe 
>> controller in the future possibly with the same limitations as the 
>> 2711, but with a seemingly different MISC_STATUS layout, you will have 
>> to think about a solution that scales, maybe we cross that bridge when 
>> we get there.
> 
> Yes, given I don't know what those changes are I can't predict how they 
> would have to be handled, or even if the platform would be a target of 
> the community maintaining the UEFI/ACPI port on the RPi. So punting on 
> that topic seems a reasonable solution at the moment. Better yet, more 
> of the linux community will see the advantage of the firmware interface 
> and this platform can utilize that method.

Ideally newer platforms would support ECAM and would not require a 
custom quirk if nothing else, we do have discussions about that right 
now, although it is not clear to me how it will materialize into a 
product that people can buy.
-- 
Florian
