Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79F542D49E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhJNIRW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 04:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230007AbhJNIRW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634199317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5a+aHMVGVrFDHdJWn+4DTBCLTUpCJYznGy41cSM3uoY=;
        b=Z5IWhgjbaI9kumF5DBuua8OAVM2BZyn2+z9Zxu1Pya0I2ARP2268dc7l7ZHXcbfT+ZlkaT
        9XX5nTQhgjku/d+cT9G/kJ/HqsPlApBV7A7Xdq42f8l+7BFpxdoaTIrW5XIRGL9a1YZciI
        caI9b4eUvsNpVomYguO+MFnmkofy1Gc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-s9i_92EWOXCNkss2EE48ig-1; Thu, 14 Oct 2021 04:15:16 -0400
X-MC-Unique: s9i_92EWOXCNkss2EE48ig-1
Received: by mail-ed1-f71.google.com with SMTP id x5-20020a50f185000000b003db0f796903so4488058edl.18
        for <linux-pci@vger.kernel.org>; Thu, 14 Oct 2021 01:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5a+aHMVGVrFDHdJWn+4DTBCLTUpCJYznGy41cSM3uoY=;
        b=nl386Pm4iQbLZRJR3GdHn6O4u0dm+UrNUMikYQZyWOmVBSBH5XVKpjIRBC8XwZoCMY
         TpGE7ra04sWb1ZXW14Lic5ll365dScyq4s3s/7qIFS+FzOZbpsLC8o3qMD3YebFQoT1B
         BHcFsK4g/fpvHXXx65L/nqxFg/2e1pU22kSlm8B3q5Dt1UMquVwuvA4BS40SstsZNGST
         uvTXXsrelECE76fzcRGIiXbwfv43w//wq6VYygYImZh3crI+WZ56YMrsb0+ewFRgkGaK
         YSZaYT4Bhupv/UWFC7HyLaUwTDKu5atkmul4RgH+CcZfu8t0RKvVbGVJ2BNMgPdlDPwL
         9WhQ==
X-Gm-Message-State: AOAM531g1hmBNwsKZgFMhBODL81PtNw+skJy3JAFwbuq91eEJDc0Vw3Q
        aI34mpOW4cCFbgqTR+daa2enMknqSOqohw6Yv5WAGzpEl9kEGAr4D9jKb/DxFTfZEpfBEyOaC7w
        AuaX1tI+jd1+6VsMdBFSu
X-Received: by 2002:a05:6402:d47:: with SMTP id ec7mr6633978edb.230.1634199314892;
        Thu, 14 Oct 2021 01:15:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwQtnZJojIovyiPOonwJDr3EXVRnDOoATmAnIKftTDkWjcJice3DMcta9pxc3ohkNRGVRnMQ==
X-Received: by 2002:a05:6402:d47:: with SMTP id ec7mr6633948edb.230.1634199314669;
        Thu, 14 Oct 2021 01:15:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p7sm1651715edr.6.2021.10.14.01.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 01:15:14 -0700 (PDT)
Subject: Re: [PATCH v2] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
References: <20211011090531.244762-1-hdegoede@redhat.com>
 <YWdaJVhoPDrg3Tsd@rocinante>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <10ae4edf-277c-41cf-020a-56406213a3f4@redhat.com>
Date:   Thu, 14 Oct 2021 10:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YWdaJVhoPDrg3Tsd@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 10/14/21 12:13 AM, Krzysztof Wilczyński wrote:
> Hi Hans,
> 
> Thank you for sending the patch over!
> 
> [...]
>> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>> [    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> 
> A very small nitpick: we usually remove time/date stamps from kernel ring
> buffer outputs keeping only the relevant message parts left.

Ok, I'll do a v3 fixing this.

> 
> [...]
>> Old systems are defined here as BIOS year < 2018, this was chosen to
>> make sure that pci_use_e820 will not be set on the currently affected
>> systems, while at the same time also taking into account that the
>> systems for which the E820 checking was orignally added may have
> 
> A tiny typo of "originally" in the sentence above.

And this.

> [...]
>> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>>  # define x86_default_pci_init_irq	NULL
>>  # define x86_default_pci_fixup_irqs	NULL
>>  #endif
>> +
>> +#if defined CONFIG_PCI && defined CONFIG_ACPI
> 
> I know that Mika already asked about this, and you responded, so I can only
> added: brackets, let's add brackets, most definitely. :)

I've no big preference either way, so I'll move to using
parentheses for the next version.

> 
> [...]
>> +/* Consumed in arch/x86/kernel/resource.c */
>> +bool pci_use_e820 = false;
> 
> A small nitpick: not sure if this comment is needed as probably most people
> working with this code would use "git grep" and likes to list occurrences
> where the variables is used.  But, this is highly subjective, thus there is
> probably nothing to change here.

I put it the comment there because the other use_foo flag directly above
it are all static, so it is there to explain why this one is not static.

At least that was my idea behind the comment :)

> 
>> +	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
>> +	       pci_use_e820 ? "Honoring" : "Ignoring");
> 
> I know you followed the existing style, which is very much appreciated, but
> if and where possible, we should move to newer API/style and replace the
> printk() above with pr_info().  New code should not be adding old style if
> it can be helped (checkpatch.pl would warn about this too).  What do yo you
> think?

Yes checkpatch complained about this, still I deliberately ignored that,
as you said I'm following the existing style here. I very much dislike
mixing styles in a single file.  If we want to change this for this file
then IMHO the right thing to do would be a follow up patch changing all
the printk-s at once.

Regards,

Hans

