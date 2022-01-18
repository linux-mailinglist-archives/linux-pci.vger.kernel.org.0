Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654F24920E4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 09:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiARIGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 03:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiARIGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 03:06:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D1C061574;
        Tue, 18 Jan 2022 00:06:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z22so75892179edd.12;
        Tue, 18 Jan 2022 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=a+ONpBE38UG2qCUQaCrIV2oHqq///dyR+oKiKgzc/sM=;
        b=JyUmywjOPWjUq1IS0mjOYPN+6q1V/POucBNXde9UF9okgT8qoINdDqZ76Ryabc0QGF
         ebsij4RbRCty1YJEJF1lXcujwmt+3+WP09q97RQ0AbaUnwxHDqehRnsNAgmk1DUNQW/I
         LJu/sAD3TMNj4k0GPncdC/v0NAOUjQ79jzxxyUKvwavS+x2vTFcBK2dN5t8H2c24CNCK
         0W6etmKZhW62e0eaCtcHXyi943vwOCIhPlK0aifxCw8ZZKcsbgZ5uKsh/EkKgd5kkWEu
         Tz6AJverbNjUe62XBVcWGZiuuwcQv76+rMG+q3TCh4Q3CVy+TB6/9xPsXPmgQW3bpNby
         UTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=a+ONpBE38UG2qCUQaCrIV2oHqq///dyR+oKiKgzc/sM=;
        b=u/UzQiaN0AWJi0ndBq0ffEvJbwTZwN1f+a1PO1S1gihEsOvhHKAls9W7987s87qhJd
         lYakxwQnDc3KEVNFSDXq8DRqBayiwu+bftOk+LHgQ2qgf0nZsY4eXgu0KaPyMRGHJoEQ
         H1tdLwpynlQkGGBIxqiXQhDwauvrFMdl5ixpnYC5RSgE1wI3XkbEgm2BPlf9am5CwFRL
         1Q42KetYsU6CoBHWllwmhrUvntQvyK2Qsy8jB1bCPaxavT+PvHIdf/CkuswfZ3ansnSo
         dqviYgjmbLA33OxotYpUK5/vi8b6jQ9QpUIA2oOKcyAIwHhIuunhnjsYgNxq2A3CUz1E
         MD6w==
X-Gm-Message-State: AOAM532/1eEUKS88Nz6D+t06x4CabLMsYAFRKvRWWAfp2eNZyqhqF7rW
        eSI/aLAcim1l96/bNMnpWgNxIJHBGzM=
X-Google-Smtp-Source: ABdhPJxvrFU5SG+hTId++Wxdbp95JPnj57uzdtKy5ho64CX7dziG3JeDcdoQM/AvnazwPkLM9LA32Q==
X-Received: by 2002:a17:906:f02:: with SMTP id z2mr20180911eji.499.1642493177943;
        Tue, 18 Jan 2022 00:06:17 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2f:5b00:dc7a:ba2b:7acf:f9eb? (p200300ea8f2f5b00dc7aba2b7acff9eb.dip0.t-ipconnect.de. [2003:ea:8f2f:5b00:dc7a:ba2b:7acf:f9eb])
        by smtp.googlemail.com with ESMTPSA id b10sm6735848edu.42.2022.01.18.00.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 00:06:17 -0800 (PST)
Message-ID: <faf0416b-196e-de5b-d858-22767edc604c@gmail.com>
Date:   Tue, 18 Jan 2022 09:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20220117233522.GA815664@bhelgaas>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
In-Reply-To: <20220117233522.GA815664@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.01.2022 00:35, Bjorn Helgaas wrote:
> [+cc Kai-Heng, Lukas, Mika, since they were cc'd or commented on [0] below]
> 
> On Mon, Jan 17, 2022 at 11:51:54AM +0100, Heiner Kallweit wrote:
>> Currently PCI core forbids RPM and requires opt-in from userspace,
>> apart from few drivers calling pm_runtime_allow(). Reason is that some
>> early ACPI PM implementations conflict with RPM, see [0].
>> Note that as of today pm_runtime_forbid() is also called for non-ACPI
>> systems. Maybe it's time to allow RPM per default for non-ACPI systems
>> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
>> was published in 2011.
> 
> Let's reword this to use the positive sense, e.g., something like
> "enable runtime power management for non-ACPI and ACPI 5.0 and newer."
> 
> This feels like a potentially significant change that could cause
> breakage.  
> 
>   - How would a user recognize that we're doing something different?
>     Maybe we need a note in dmesg?
> 
>   - If a system broke because of this, what would it look like?  How
>     would a user notice a problem, and how would he or she connect the
>     problem to this change?
> 

Don't know what the exact symptoms of the original problem are.
I'd more see a certain risk that this change reveals bugs in RPM usage
of PCI device drivers. There's not a fixed list of potential symptoms.

One example: igb driver caused a hang on system shutdown when RPM was
enabled due to a RTNL deadlock in RPM resume path.

>   - Is there a kernel parameter that will get the previous behavior of
>     disabling runtime PM as a workaround until a quirk can be added?
>     If so, we should probably mention it here.  If not, should there
>     be?

For each device in sysfs: power/control: "auto" -> "on"

> 
>> [0] https://lkml.org/lkml/2020/11/17/1548
> 
> Please use an https://lore.kernel.org/r/... link instead.
> 
> Let's mention bb910a7040e9 ("PCI/PM Runtime: Make runtime PM of PCI
> devices inactive by default") as well to help connect the dots here.
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/pci.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 428afd459..26e3a500c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
>>  	u16 status;
>>  	u16 pmc;
>>  
>> -	pm_runtime_forbid(&dev->dev);
>> +#ifdef CONFIG_ACPI
>> +	/* Some early ACPI PM implementations conflict with RPM. */
>> +	if (acpi_gbl_FADT.header.revision > 0 &&
>> +	    acpi_gbl_FADT.header.revision < 5)
>> +		pm_runtime_forbid(&dev->dev);
>> +#endif
>>  	pm_runtime_set_active(&dev->dev);
>>  	pm_runtime_enable(&dev->dev);
>>  	device_enable_async_suspend(&dev->dev);
>> -- 
>> 2.34.1
>>

