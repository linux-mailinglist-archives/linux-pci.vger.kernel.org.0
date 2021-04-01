Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7B351CE6
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhDASW7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbhDASOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 14:14:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD22C0613B4
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 05:04:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo769474wmq.4
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LU2QGi1y2AeEk2lgB60SVhXreDrajjklTU6JlxJPWE4=;
        b=VZ1hELN0g34f705ivCVi4xQjpXQvTtRtuEIaFFaRVx5xmVJ+dSTPZv6yn4yoVs0iw/
         bZJercOGWsA8ccu/AtXn/+7fwl9SsabnLyEl9UUBjkoN2/RiJ8usc7TbTn6AjTff7idX
         ltznsvMboIqJ8/G+NSFSjOPCDKRPq/JXn10UJy3wfflae/5RF/VmYySG3JjXANei+iZ6
         g/mkTmzz+mFnx6QA1z7PMXpiBgYLBy8YeNRVcjWJAfjENnCl/gv3qxAad5vyTn4C2+kx
         OUJTOlVohTUUga9IbDC8+BmxrKUaunVkaVD+B8sxgd0gP06nfVJcJTR5FAILcPf590k7
         5q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LU2QGi1y2AeEk2lgB60SVhXreDrajjklTU6JlxJPWE4=;
        b=gHlVY7qroid5crcjRQVogDHKHXPwfh98tAuxBGtnpljJJNZ5uPi97JAtnoWcjvMOfN
         uWPz6rTAJje+13XkrnXIiWKktpiede4EqawHF7GSWScdOr6kbiiLUMSgtFiphwsYZOhR
         r3gX7D7hz6qwhI+idr4j9406HCg3vAFQVuQxdKHeUEm8qRCB7W3cq2QCu3D8aOtuqHz5
         WO7l/ZhDO18cE6b374Wwta76KvVYXJEMYpCk6Bn/wofINUhyE1Ma3maCeFDyP4jsviob
         mR4LFx+dDAI4N44FNwyNHtITQDJMZnTUKZTPBjxNnTg39Ev2lh4LV5xnC6+Rp+PzwnIa
         PWXQ==
X-Gm-Message-State: AOAM532Y8rBh/xdvy9jxlXDbnLj0auacFKjRAiuRxX0mkLq0zIMMdXqi
        nTa7ZB/nmOD36eGEOlRg8h4pE72p4BJV8g==
X-Google-Smtp-Source: ABdhPJxhMojNtUGZEqELnNUzMtY+79uMElwYN8BdxW23qmZHVb8z5a0FHl9CcXEesRbBpIsETRHkJg==
X-Received: by 2002:a7b:cb90:: with SMTP id m16mr7716619wmi.162.1617278663611;
        Thu, 01 Apr 2021 05:04:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:5544:e633:d47e:4b76? (p200300ea8f1fbb005544e633d47e4b76.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5544:e633:d47e:4b76])
        by smtp.googlemail.com with ESMTPSA id p16sm12014849wrt.54.2021.04.01.05.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 05:04:23 -0700 (PDT)
Subject: Re: [PATCH] PCI/VPD: Silence warning if optional VPD PROM is missing
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210330195611.GA1305306@bjorn-Precision-5520>
 <541f7965-b981-c277-21b5-6de0a47118ac@gmail.com>
Message-ID: <ef281028-a1b2-483a-ac61-b876550aed95@gmail.com>
Date:   Thu, 1 Apr 2021 14:04:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <541f7965-b981-c277-21b5-6de0a47118ac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31.03.2021 13:14, Heiner Kallweit wrote:
> On 30.03.2021 21:56, Bjorn Helgaas wrote:
>> On Sun, Mar 07, 2021 at 10:34:25PM +0100, Heiner Kallweit wrote:
>>> On 07.03.2021 19:27, Krzysztof Wilczyński wrote:
>>>> Hi Heiner,
>>>>
>>>>> Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
>>>>> optional VPD EEPROM can be connected via I2C/SPI. However I haven't
>>>>> seen any card or system with such a VPD EEPROM yet. The missing EEPROM
>>>>> causes the following warning whenever e.g. lscpi -vv is executed.
>>>>>
>>>>> invalid short VPD tag 00 at offset 01
>>>>>
>>>>> The warning confuses users, I think we should handle the situation more
>>>>> gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
>>>>> optional VPD PROM as and silently set the VPD length to 0.
>>>> [...]
>>>>
>>>> True.  I saw people on different forum and IRC asking for clarification
>>>> assuming their NIC broke, or that something is wrong, so this would
>>>> indeed save them some worry, nice!
>>>>
>>>> Having said that, I also saw this particular warning showing up for some
>>>> storage controllers (often some SAS cards), so a question here: would it
>>>> warrant adding a pci_dbg() with an appropriate message rather than just
>>>> returning 0?  I wonder if this might be useful for someone who is trying
>>>> to troubleshoot and/or debug some issues with their device.
>>>>
>>>> What do you think?
>>>>
>>> I don't have a strong opinion here, but yes, that's something we could do.
>>
>> How about if we just downgrade the pci_warn() to a pci_info()?
>>
> pci_info() would still expose a quite cryptic message to users and leave
> them with the question whether something is wrong. If in case of VPD tag 00
> a message is desired, I'd say it should be rephrased to something like:
> "VPD tag 00 at offset 01, assuming missing optional VPD EPROM"
> 

I submitted a v2 with this change.
