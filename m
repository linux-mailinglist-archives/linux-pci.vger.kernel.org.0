Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DD407905
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhIKPTd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhIKPTc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Sep 2021 11:19:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0615C061574
        for <linux-pci@vger.kernel.org>; Sat, 11 Sep 2021 08:18:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s10so10670173lfr.11
        for <linux-pci@vger.kernel.org>; Sat, 11 Sep 2021 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=pTlmEmLSO0kdM2XgKVfPQFxSs6RqbMEFQv4XcZRwJzo=;
        b=nV/4P14S0Xx2DpkNIWDouRPk72tECYY+Y21wZAzatIMmOEWHYKHnlnQPEQ3gNAvYV6
         CtxqjFmqYggUpp2m/3mTIFgdPMR/QdXKVLVx7M252dsPZUFOYrUUTP7t2v79+onNzZRI
         PmTVDm7QBp1APDdlczSt/ZzeQ+VuRe85534cpiM3TMGKsk5EBZCWioSIV6boTJkHfG/H
         ZsM+VZCMieV3l0xWgnE2Mqml4euT8s+QoLUkjSylaxvbIaQ4pTkWrS7XSRu7pm3Kemca
         MPHS/p3Ak0wcuUZRWyZ88lEd6uMtHFtZD6Zc9eUxkB6HusTSIdIbDEj8z+BJeM3R0yQF
         FFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=pTlmEmLSO0kdM2XgKVfPQFxSs6RqbMEFQv4XcZRwJzo=;
        b=1Mto3lpLuSNJwhSWF34EsYSPy2M7oHPq1keemk3LYFAg9wns8r49GYQfx3h/R18+d8
         zkPwrBFpqUZtwiIiPp6MnZ7z3w584nVb9L1YiLyHJj7HEVrJTp+YBa4nOFqX1n7k8WnU
         XDNuWIQ7iJG5pKKFBDJ1D39JGHezdBbnP+jNhsbpgYxvuEvSb3Uj6i3zgqVuDeJckF5o
         J5W1YYvKrsxTMIKIm3gAYtz82zRZs+ySCE/PEwHNzbyvXwisKo/Du/cN0ylpHM0qA7m1
         J7ouKIRJ+skeVB6bNJX3OjmItsD68oYCKj48T3XDidLvTUne/LUMEHnPLlI38x7g+cSV
         adHg==
X-Gm-Message-State: AOAM5326czmX7UVE1spNucYkeQCqxuxYLf2lbNMUGUIlbUp5Cqnna+mX
        ZuJNgVPYscKYPt/WNzDIMDA=
X-Google-Smtp-Source: ABdhPJxC09UUtiGvAuP7Tjd4ZWisCUegfDcl/CKsxxWbcDL5g0PqVa0pv97b+Y8ITJ4qI4lokqFi9A==
X-Received: by 2002:a05:6512:3b88:: with SMTP id g8mr2328770lfv.53.1631373496665;
        Sat, 11 Sep 2021 08:18:16 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id u12sm230810lfq.101.2021.09.11.08.18.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 11 Sep 2021 08:18:15 -0700 (PDT)
Message-ID: <613CCBE3.20802@gmail.com>
Date:   Sat, 11 Sep 2021 18:31:47 +0300
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
References: <alpine.DEB.2.21.2107171813230.9461@angie.orcam.me.uk> <611993B1.4070302@gmail.com> <alpine.DEB.2.21.2108160027350.45958@angie.orcam.me.uk> <61377A45.8030003@gmail.com>
In-Reply-To: <61377A45.8030003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

07.09.2021 17:42, I wrote:
> [ 0.625911] 8139too: 8139too Fast Ethernet driver 0.9.28
> [ 0.625911] 8139too 0000:00:03.0: PCI INT A -> PIRQ 10, mask def8, excl
> 0000
> [ 0.625911] 8139too 0000:00:03.0: PCI INT A -> newirq 11
> [ 0.630068] PCI: setting IRQ 15 as level-triggered
> [ 0.630068] -> edge
> [ 0.630068] 8139too 0000:00:03.0: found PCI INT A -> IRQ 15

Ok, I've sorted this out. Your patch works as intended, as long as the 
.link field values are encoded as numbers from 1 to 4. In the (severely 
obsolete) "$IRT" routing table I discovered in my BIOS, the .link values 
are some strange 0x10-0x28-0x41-0x89 numbers, whatever was the idea of 
BIOS writers behind this. AFAIK such numbering is not prohibited by PCI 
BIOS spec, but obviously it has to be in agreement with what register 
access routines expect, or otherwise it will all break apart.

Now because this old "$IRT" table can not normally be recognized anyway, 
I've converted the data to a more reasonable $PIR format, translating 
0x10-0x28-0x41-0x89 numbers into 1-2-3-4 along the way, and inserted 
this new table into a small unused ROM area. All looks good:
=====
[    0.623757] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.623757] 8139too 0000:00:03.0: PCI INT A -> PIRQ 01, mask def8, 
excl 0000
[    0.623757] 8139too 0000:00:03.0: PCI INT A -> newirq 11
[    0.623757] PCI: setting IRQ 11 as level-triggered
=====
Dumping registers with a separate program then confirmed that settings 
are correct indeed.
But I'd like to note that PIRQ values passed to pirq_finali_get/set 
should better be somewhow checked for validity, as otherwise some 
totally unrelated chipset registers are being unintentionally accessed.

I'm now going to test IRQ sharing.


Thank you,

Regards,
Nikolai


> [ 0.630068] 8139too 0000:00:03.0: IRQ routing conflict: have IRQ 11,
> want IRQ 15
> [ 0.641901] 8139too 0000:00:03.0 eth0: RealTek RTL8139 at 0xc2582f00,
> 00:11:6b:32:85:74, IRQ 11
>
> First, INTA is apparently routed to IRQ11 (and the network card works
> just fine with that), whereas pci code wants IRQ15 for some reason.
>
> Second, dumping chipset reg 44 shows that INTA is still set to EDGE mode
> anyway, although dumping port 4D1 now shows IRQ15 was changed to LEVEL
> mode, exactly as indicated in the above output. I'm not sure, but the
> datasheet (page 77) seems to indicate that INTx mode set in reg 44
> should match the respective IRQx mode in port 4Dx (Although the ROM BIOS
> seems to only have code to change triggering mode in the 44 register and
> does not care about port 4Dx whatsoever, which kinda contradicts the
> datasheet)
>
> I'll do some more digging later, but any hints are appreciated anyway.
>
>
> Thank you,
>
> Regards,
> Nikolai
>
>>
>> I'm a little busy at the moment with other stuff and may not be able to
>> look into it properly right now. There may be no solution, not at least
>> an easy one. A DMI quirk is not possible, because:
>>
>> DMI not present or invalid.
>>
>> There is a PCI BIOS:
>>
>> PCI: PCI BIOS revision 2.10 entry at 0xf6f41, last bus=0
>>
>> however, so CONFIG_PCI_BIOS just might work. Please try that too, by
>> choosing CONFIG_PCI_GOANY or CONFIG_PCI_GOBIOS (it may break things
>> horribly though I imagine).
>>
>> Maciej
>>
>

