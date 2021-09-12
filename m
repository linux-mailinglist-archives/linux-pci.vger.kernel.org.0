Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F6407EAA
	for <lists+linux-pci@lfdr.de>; Sun, 12 Sep 2021 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhILQjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Sep 2021 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhILQjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Sep 2021 12:39:05 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A138C061574
        for <linux-pci@vger.kernel.org>; Sun, 12 Sep 2021 09:37:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j12so12646559ljg.10
        for <linux-pci@vger.kernel.org>; Sun, 12 Sep 2021 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=jWPI8FMHxpkjRRP2hW75gdsTWoBT12rosNOIrVTbCgA=;
        b=TSKqZjVE8XvwqpDpY6xJx9q3cXlrukCXgz3Rk81BCdHfEwoUrlw9WUy67WJ8OpoqEW
         GrsfefQx7ssMNnOXfUSl4tw5j8FXbce9g2+fEpxTRc8qpSKYom/gzJWElPskrOB4Bdej
         b8EnURGPrQ3LgHfbSIKk42MvvBpkktQX20bpFwLIBTw8FD1A06RJ3+iygWmbQdkqsJ/i
         q0yU7oEVVdR/Ayks4L9VV1r7VwY4vghuwq7fVd690TTQcX5o2NhNXL2gqu9Ul8Q04uq/
         zlI6+Fexy1/HTg+1QiB7K4vFbikh0np52ticgRGj2XyCNunhjKE3VSTB9VcFLIM2buq4
         hNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=jWPI8FMHxpkjRRP2hW75gdsTWoBT12rosNOIrVTbCgA=;
        b=RHxqgK2vyLfjF5fUZNI2HWGvEMGuSVHDcfXKu1/DO17W4WD6erarpW0w/xFFGk0vym
         H9OdDG/uMgCch7g5hsotvH9QhyXAL37VUKfODXEgcHLhu4WPZHXjnHnaWh3//dijNNh8
         9EjikRyR7m+iTS/g86SxdeTVZi+P8uuInfcw3g5A7PiyieVuDn/myIwXwbgFqHQcceeu
         6CWYSKpke0+ZRNk9kxI3qMGotv/OKl+cnc17vJEu1EeKHnxgAxOXV7PoVAAgkYgR0Z7R
         HXkIVkJn4x1LJE+exSz2sAVoxBtoi5CNMf9YcOrINAHH4x5dRaHiItHgO7zIsnFxOSZ6
         F8Qg==
X-Gm-Message-State: AOAM532nwhsAHksg64QEYSHs+BlMNFV4Xz9L5W2dGGRhqex1f6OIkBcV
        0OqtCQSysbwI0QwlF3OjL4M=
X-Google-Smtp-Source: ABdhPJxS6MbYC465rTlFA7MNlzs5R1COkTgPjTQpdcHZ8Asot+XtfaO06sqcsmVMATDaxDNk/krUng==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr6619343ljk.146.1631464668640;
        Sun, 12 Sep 2021 09:37:48 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id z16sm599241lfu.110.2021.09.12.09.37.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 12 Sep 2021 09:37:47 -0700 (PDT)
Message-ID: <613E3009.4050007@gmail.com>
Date:   Sun, 12 Sep 2021 19:51:21 +0300
From:   Nikolai Zhubr <zhubr.2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] x86: PIRQ/ELCR-related fixes and updates
References: <alpine.DEB.2.21.2107171813230.9461@angie.orcam.me.uk> <611993B1.4070302@gmail.com> <alpine.DEB.2.21.2108160027350.45958@angie.orcam.me.uk> <61377A45.8030003@gmail.com> <613CCBE3.20802@gmail.com>
In-Reply-To: <613CCBE3.20802@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

11.09.2021 18:31, I wrote:
> this new table into a small unused ROM area. All looks good:
> =====
> [ 0.623757] 8139too: 8139too Fast Ethernet driver 0.9.28
> [ 0.623757] 8139too 0000:00:03.0: PCI INT A -> PIRQ 01, mask def8, excl
> 0000
> [ 0.623757] 8139too 0000:00:03.0: PCI INT A -> newirq 11
> [ 0.623757] PCI: setting IRQ 11 as level-triggered
> =====
> Dumping registers with a separate program then confirmed that settings
> are correct indeed.
> But I'd like to note that PIRQ values passed to pirq_finali_get/set
> should better be somewhow checked for validity, as otherwise some
> totally unrelated chipset registers are being unintentionally accessed.
>
> I'm now going to test IRQ sharing.

I can confirm IRQ sharing works fine, too.
I've inserted some PCI USB addon card and added "pci=usepirqmask 
pci=irqmask=0x800" to force a collision, now /proc/interrups says:

11:      61350    XT-PIC      ehci_hcd:usb1, ohci_hcd:usb2, eth0

Now doing USB stick reading and ethernet benchmarking in parallel shows 
no problem whatsoever.

Excellent work, Maciej!


Thank you,

Regards,
Nikolai

>
> Thank you,
>
> Regards,
> Nikolai
>
>
>> [ 0.630068] 8139too 0000:00:03.0: IRQ routing conflict: have IRQ 11,
>> want IRQ 15
>> [ 0.641901] 8139too 0000:00:03.0 eth0: RealTek RTL8139 at 0xc2582f00,
>> 00:11:6b:32:85:74, IRQ 11
>>
>> First, INTA is apparently routed to IRQ11 (and the network card works
>> just fine with that), whereas pci code wants IRQ15 for some reason.
>>
>> Second, dumping chipset reg 44 shows that INTA is still set to EDGE mode
>> anyway, although dumping port 4D1 now shows IRQ15 was changed to LEVEL
>> mode, exactly as indicated in the above output. I'm not sure, but the
>> datasheet (page 77) seems to indicate that INTx mode set in reg 44
>> should match the respective IRQx mode in port 4Dx (Although the ROM BIOS
>> seems to only have code to change triggering mode in the 44 register and
>> does not care about port 4Dx whatsoever, which kinda contradicts the
>> datasheet)
>>
>> I'll do some more digging later, but any hints are appreciated anyway.
>>
>>
>> Thank you,
>>
>> Regards,
>> Nikolai
>>
>>>
>>> I'm a little busy at the moment with other stuff and may not be able to
>>> look into it properly right now. There may be no solution, not at least
>>> an easy one. A DMI quirk is not possible, because:
>>>
>>> DMI not present or invalid.
>>>
>>> There is a PCI BIOS:
>>>
>>> PCI: PCI BIOS revision 2.10 entry at 0xf6f41, last bus=0
>>>
>>> however, so CONFIG_PCI_BIOS just might work. Please try that too, by
>>> choosing CONFIG_PCI_GOANY or CONFIG_PCI_GOBIOS (it may break things
>>> horribly though I imagine).
>>>
>>> Maciej
>>>
>>
>

