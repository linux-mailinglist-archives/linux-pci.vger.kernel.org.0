Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E384166BE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbhIWUeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 16:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbhIWUeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Sep 2021 16:34:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568DC061574;
        Thu, 23 Sep 2021 13:32:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y89so16786914ede.2;
        Thu, 23 Sep 2021 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6+Gu/iRqyPqcbnYKhgZwOW6+iVLuEgjvKfe8sK2yqJ4=;
        b=IGPed7unYhr4J6+l9bBHGFs3XhmPB0N2w2JNTrFN8VrOJeavUYgCkbOwOOU4qs6MED
         g6Q3rwfB9FK/VmHdg/V8f/VO9Lwyppjr2zjbvqNSPAOGYa09zLsHuuEoj8ZnOSuxfDoP
         CH2an08ZtT7gpdQuQNt8BX854wb2sDjXtM4JmoLLk4NdZCNde2wO0GwIc9mXG03rYCZA
         dewyBEZX7tGAhd/Jkxv4nZicY+bEZ8PhDtNkz1TTlJxoM6HJTSHqz56JJKkgcobval0w
         PkdOP+ldEPbFfCToJMqDmN82SxHoxTVgZqRw7XxMzCZEPRXWZ4syul9/fWFeI4udxQ7Z
         Ls4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6+Gu/iRqyPqcbnYKhgZwOW6+iVLuEgjvKfe8sK2yqJ4=;
        b=5AVTHhIUyMjxfhB02tMhg7UVUlWTiuVEZ9DAzuSra0r8z8/xD3BrCakfUMp4rBcYen
         w+ifVWdlVTK4UqC8tpEHdbVub6qyX2bra3hDGmDZJPp4HjAVB9RlsaEcpq0EKQXpxVpW
         wS9JKPJ16Dhy7fVQKpiKkoq7t6L1cUJFutFGfD/lck4EYHfgwKyvByH+8yn3AqvvfUX/
         jneWds1lXvOwHUiucD9m+mjQN1+iOrLSPfjXW2vfy9d9M0jdIi9vQQ03Xx/Ia+tq/bH8
         UMCM0XwTwrUaJKvgN34OxsbN0kbeuKXN4mSuV8KXolTZzAPE56287ZK9/W40Kf+rmKWp
         zL2g==
X-Gm-Message-State: AOAM530RgLeGU8eLvpwH7ALLjA0AQU8ou5GfaNYW/FvcR7nnU/6OAVnI
        lIlCvaluK9avBfFibFEoa0vKKKvP5g8=
X-Google-Smtp-Source: ABdhPJzEbSkJoi4rqRH0CFl7JJmp+6NbnJGKOhLOcHOXbSP38NZ4QJyIwRvFerAxtL++kL/UgyRcAw==
X-Received: by 2002:a17:906:1146:: with SMTP id i6mr7416372eja.12.1632429160840;
        Thu, 23 Sep 2021 13:32:40 -0700 (PDT)
Received: from ?IPv6:2001:981:6fec:1:2b01:e09b:ffd3:5fee? ([2001:981:6fec:1:2b01:e09b:ffd3:5fee])
        by smtp.gmail.com with ESMTPSA id x25sm3687473ejy.46.2021.09.23.13.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 13:32:40 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for
 ACPI
From:   Ferry Toth <fntoth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1800633.tdWV9SEqCh@kreacher> <8879480.rMLUfLXkoz@kreacher>
 <069444f7-d623-fae2-5cd0-83cbbc919aff@gmail.com>
 <CAJZ5v0gpodPPXTagy5gFFf6mp_jCAdc864CE_giaue72ke7UyQ@mail.gmail.com>
 <ab803fb5-045d-98dd-2754-688a916f8944@gmail.com>
Message-ID: <d151c91c-cb65-2830-2453-a02057137400@gmail.com>
Date:   Thu, 23 Sep 2021 22:32:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ab803fb5-045d-98dd-2754-688a916f8944@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Op 23-09-2021 om 15:51 schreef Ferry Toth:
> Repost (with formatting removed, sorry for the noise)
> Op 23-09-2021 om 13:30 schreef Rafael J. Wysocki:
>> On Wed, Sep 22, 2021 at 11:31 PM Ferry Toth<fntoth@gmail.com>  wrote:
>>> Hi,
>>> Op 20-09-2021 om 21:17 schreef Rafael J. Wysocki:
>>>> From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>>>
>>>> Using struct pci_platform_pm_ops for ACPI adds unnecessary
>>>> indirection to the interactions between the PCI core and ACPI PM,
>>>> which is also subject to retpolines.
>>>>
>>>> Moreover, it is not particularly clear from the current code that,
>>>> as far as PCI PM is concerned, "platform" really means just ACPI
>>>> except for the special casess when Intel MID PCI PM is used or when
>>>> ACPI support is disabled (through the kernel config or command line,
>>>> or because there are no usable ACPI tables on the system).
>>>>
>>>> To address the above, rework the PCI PM code to invoke ACPI PM
>>>> functions directly as needed and drop the acpi_pci_platform_pm
>>>> object that is not necessary any more.
>>>>
>>>> Accordingly, update some of the ACPI PM functions in question to do
>>>> extra checks in case the ACPI support is disabled (which previously
>>>> was taken care of by avoiding to set the pci_platform_ops pointer
>>>> in those cases).
>>>>
>>>> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>>       * Rebase on top of the new [1/7] and move dropping struct
>>>>         pci_platform_pm_ops to a separate patch.
>>> I wanted to test this series on 5.15-rc2 but this patch 2/7 doesn't
>>> apply (after 1/7 applied). Should I apply this on another tree?
>> This is on top of
>> https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/ 
>>
>> which is not yet in any tree.
>>
>> Sorry for the confusion.
> No problem at all. If I can I will try to report back tonight. Else, 
> will be delayed 2 due to a short break.

With those 3 extra patches followed by 7 from this series it builds. But 
on boot I get:
dwc3 dwc3.0.auto: this is not a DesignWare USB3 DRD Core
Then after this it reboots. Nothing in the logs. Nothing else on 
console, I guess something goes wrong early.

I tried both in host / device mode - no change.

Normally in host mode I have:
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, 
bcdDevice= 5.14
Only ref to dwc3 is:
tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup / using lookup 
tables for GPIO lookup / No GPIO consumer cs found
