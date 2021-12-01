Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF546576B
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbhLAUyA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbhLAUx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:53:28 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3F8C061756;
        Wed,  1 Dec 2021 12:50:06 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t23so51167718oiw.3;
        Wed, 01 Dec 2021 12:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3lAtleqfk79RizN4Xfz/dv/nqBhWl4vDwc0f8SGgsxY=;
        b=KKYTA5Ku21eIUzrkOUBNprVJhnXu6Wu+pkGI21cKM8rtadKU9es1ODKMn0ZVPmHcDr
         Zo/ASlBWBgg0rv4KKzfFL5eoXrRtXPYtIUeT4V0QcsUh2ejUR9L4IOwbSThxczRPCegA
         F3QiDUtjWeS+iExMM0X3csJQG7Li1L5IPTvsvbNifEo9f0QFuBrYF420Uec875KmlHr7
         xb51HeL4U+B8g6EMZzqcmLh6iNpuFbDc7rWRNXq1N1QBfzhg8MicQ+r/gSjS7luUrNde
         CFwgoVp5ltRayrxzn0otRSHWhHDrc71ADzySTp1UqF1YBdZLQ6bdpjLMj1dXiOSaC6TY
         xV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3lAtleqfk79RizN4Xfz/dv/nqBhWl4vDwc0f8SGgsxY=;
        b=phoH202eJhiBWlVhBWl7M+5/In7iShbUj4/1/tJo8FYIefjdyHoaIiyGjfQCW/hWlv
         3MnREwsx1M93AggyaRdnc0KyqJeOk2V1FUuQQDcpbvW3fp2Kx87VZJqLD3v5E+JwAZsY
         Nxk4KXhQj52jh/R+5motjggZPNFoGkmgsGqNJTYn/Hlibnjb+cvROs3PTEuoF9tUIoV9
         OoVXxLyS99nllEiUeOg9M+FxyTWXH3ho8KbIFZ6XKG/+PleLe4GG5Np/uiNUa5zhrHSu
         2xVu1k7itwKJB+2RVUjeI6gtE4UXKWtnr7ZdbCeHDdE5WIdhPuwY5JcX7pOJOJjtCGJX
         oNmA==
X-Gm-Message-State: AOAM531DUedQRhaGC0JGiTk7inV5BVnxM79TYcRUHs9kMsVrd8MmSokU
        ht5aDPmsM/o0HFzGnIQA55JcjgwU0aY=
X-Google-Smtp-Source: ABdhPJwViydUn1I4EprG4LndgvL2P0TFnWLOe1G91Z/AZbNE7DUadF5hsCCyosozj/NwiFTwxImxKA==
X-Received: by 2002:a05:6808:150c:: with SMTP id u12mr681911oiw.6.1638391805132;
        Wed, 01 Dec 2021 12:50:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5sm328523otd.74.2021.12.01.12.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 12:50:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.16-rc3
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20211201203822.GA2840039@bhelgaas>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <542e38c7-afed-ebf5-5254-8aa6ee22b01a@roeck-us.net>
Date:   Wed, 1 Dec 2021 12:50:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201203822.GA2840039@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/1/21 12:38 PM, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> On Mon, Nov 29, 2021 at 01:18:12PM +0100, Sergio Paracuellos wrote:
>> On Mon, Nov 29, 2021 at 5:17 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 11/28/21 7:07 PM, Randy Dunlap wrote:
>>>> On 11/28/21 17:59, Guenter Roeck wrote:
>>>>> ...
>>>>> Build results:
>>>>>      total: 153 pass: 152 fail: 1
>>>>> Failed builds:
>>>>>      mips:allmodconfig
>>>>> Qemu test results:
>>>>>      total: 482 pass: 482 fail: 0
>>>>>
>>>>> Building mips:allmodconfig ... failed
>>>>> --------------
>>>>> Error log:
>>>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
>>>>> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
>>>>>
>>>>> There is still no fix for the mips:allmodconfig build problem as far
>>>>> as I can see. It is a bit odd, because the fix would be as simple as
>>>>>
>>>>>    config PCIE_MT7621
>>>>> -    tristate "MediaTek MT7621 PCIe Controller"
>>>>> -    depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
>>>>> +    bool "MediaTek MT7621 PCIe Controller"
>>>>> +    depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
>>>>>        select PHY_MT7621_PCI
>>>>>        default SOC_MT7621
>>>>>        help
>>>>>
>>>>> Context: tristate doesn't make sense here because both RALINK and
>>>>> SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
>>>>> already depends on it. The compile failure is due to missing exported
>>>>> symbols, and it is only seen if PCIE_MT7621=m - which is only possible
>>>>> if COMPILE_TEST=y. In other words, the dependencies above are set such
>>>>> that test builds, and only test builds, fail.
>>>>>
>>>>> The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
>>>>> Add MediaTek MT7621 PCIe host controller driver"). Copying some of
>>>>> those responsible to see if we can expect a solution sometime soon.
> 
> Can we do a minimal patch along the lines of the above for v5.16?
> 

I would suggest to either do that or, if module support is mandatory,
revert the patch and re-apply it if and when it can be built as module.

Guenter
