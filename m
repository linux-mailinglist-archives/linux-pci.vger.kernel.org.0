Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19A402AC2
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhIGOaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbhIGO37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 10:29:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA7C061757
        for <linux-pci@vger.kernel.org>; Tue,  7 Sep 2021 07:28:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s3so16864872ljp.11
        for <linux-pci@vger.kernel.org>; Tue, 07 Sep 2021 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=whvYaFH59Rez4QJOHtl63bTFpS5yvf3k6GUxV1SO+Fw=;
        b=Kv9riToGxtt4koxXqxkMHDZxpkvsFveZThacXqqlXyJ4ZfTs6hAUTbzUMikTdKYRhe
         oR+o3nl5R6EzOF9TUOE87DMKqHgW2w5Tz9MTq1BIR8utD4DI0jA7RLxo5nDUYCvmAD3e
         Kmw2ZBK7Bype7A/xiKs56T4ZrMUCuyKPlxxPYewascHatQkdcK/og7uZIK69WKnj9gMR
         cpIG2MkLSh+qPYzyTgZYTyQvDRJpQDI2rcMAc2loVUy3eXzDOcHBdPm4p4sc1ki0mBYC
         SBQ8BcgSrwxmIJ2sAi92YmO1Hk4jj5bm45rN29z6MV38OEiWEyHEUh8UG9/geg8T/cMG
         zZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=whvYaFH59Rez4QJOHtl63bTFpS5yvf3k6GUxV1SO+Fw=;
        b=WnMYDZMyp20C71rwsBSDnLZG7/8qC8t0fHQbPCEulvVNNK1QgpVycsUsYSLb3FMlXl
         9TDOtAvwgamYwZem+a/58y2IGpMSWwl1aWI1Y4mpAuKYL///R/jWBPTglDy66bg8gpL2
         JhcaFBYEqiAD/sUgb1gUc3t6FgoEsXWyZ+85oD/RtXX2+aFhycIy5LIlXRuwoiaMNzgR
         9aYcjmWvlLE/YtgPOf9L0GT6xQ5Sa61K4jcAJyK4YMvs9edXjJKUfMV/8LKOI4+hTJui
         DUpXgzmFCLCIcz7kzL2SqYRmJkRJ8GqecQFAG03PQ5BrKg82Ger1Vt5jdfHqsEuvRAZS
         gcbw==
X-Gm-Message-State: AOAM532lc52lX3q4Qi2Cb2XGb5yiLfDTWBrUTbJRHnsl8Z6Sf2bvMwb9
        UDCmfqVvyRCGASUBvd5g7GtIEl2BkA0=
X-Google-Smtp-Source: ABdhPJzDFQ5Js2gWJ0QODqBQFxM3Q8ihv6lNRL18oqbazaMsH9YxknrkiKQtrctp9/upLCRmkmV3Ug==
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr15069732ljp.527.1631024931438;
        Tue, 07 Sep 2021 07:28:51 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id x24sm1022624lfc.246.2021.09.07.07.28.50
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 07 Sep 2021 07:28:50 -0700 (PDT)
Message-ID: <61377A45.8030003@gmail.com>
Date:   Tue, 07 Sep 2021 17:42:13 +0300
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
References: <alpine.DEB.2.21.2107171813230.9461@angie.orcam.me.uk> <611993B1.4070302@gmail.com> <alpine.DEB.2.21.2108160027350.45958@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2108160027350.45958@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

17.08.2021 1:30, Maciej W. Rozycki:
[...]
> If you have a look through /dev/mem and see if there's a "$PIR" signature
> somewhere (though not a Linux kernel area of course), then we may know for
> sure.

There is no "$PIR" signature anywhere, including all uncompressed 
internal ROM modules. Instead though, there is an "$IRT" signature and a 
table following it:

F9A90: 24 49 52 54 04 04 00 00 00 18 10 F8 DE 28 F8 DE │ $IRT
F9AA0: 41 F8 DE 89 F8 DE 01 00 00 20 28 F8 DE 41 F8 DE │
F9AB0: 89 F8 DE 10 F8 DE 02 00 00 28 41 F8 DE 89 F8 DE │
F9AC0: 10 F8 DE 28 F8 DE 03 00 00 08 89 F8 DE 10 F8 DE │
F9AD0: 28 F8 DE 41 F8 DE 04 00 00 09 03 0A 04 05 07 06 │
F9AE0: 00 0B 00 0C 00 0E 00 0F 60 1E 0E 1F E8 98 00 8B │
F9AF0: FA 1F 72 6B 0A C0 74 67 3C F0 73 45 8A C8 24 01 │

By stepping through some BIOS initialization code in bochs, I've 
determined that this table is being consulted just before modifying 
chipset registers 44 and 42/43, so no doubt it is related to IRQs. From 
the same BIOS code it is clear that every entry is 16 bytes long (just 
like in pci_x86.h), the very first entry starts at offset 8 (counting 
from the start of the above fragment), and total number of entries is 
stored at offset 5 in a 16-bit word. My guess is 0-value byte at offset 
7 might be padding, and 4 at offset 4 looks like header size, because 
there is just nothing else in the header.

The entries look similar to irq_info defined in pci_x86.h, so I decided 
to give it a try. For a test, I've modified the struct irq_routing_table 
defined in pci_x86.h and irq.c to match this $IRT structure. Now I get this:

[    0.312000] PCI: IRQ init
[    0.316000] PCI: Interrupt Routing Table found at 0xc00f9a90
[    0.316000] 00:03 slot=01
[    0.316000]  0:10/def8
[    0.316000]  1:28/def8
[    0.316000]  2:41/def8
[    0.316000]  3:89/def8
[    0.316000] 00:04 slot=02
[    0.316000]  0:28/def8
[    0.316000]  1:41/def8
[    0.316000]  2:89/def8
[    0.316000]  3:10/def8
[    0.316000] 00:05 slot=03
[    0.316000]  0:41/def8
[    0.316000]  1:89/def8
[    0.316000]  2:10/def8
[    0.320000]  3:28/def8
[    0.320000] 00:01 slot=04
[    0.320000]  0:89/def8
[    0.320000]  1:10/def8
[    0.320000]  2:28/def8
[    0.320000]  3:41/def8
[    0.320000] PCI: Attempting to find IRQ router for [0000:0000]
[    0.320000] PCI: Trying IRQ router for [10b9:1489]
[    0.320000] pci 0000:00:00.0: FinALi IRQ router [10b9:1489]

Not sure if the table was parsed correcly, but the following messages 
later obviously show some problem:

[    0.625911] 8139too 0000:00:03.0: runtime IRQ mapping not provided by 
arch
[    0.625911] 8139too: 8139too Fast Ethernet driver 0.9.28
[    0.625911] 8139too 0000:00:03.0: PCI INT A -> PIRQ 10, mask def8, 
excl 0000
[    0.625911] 8139too 0000:00:03.0: PCI INT A -> newirq 11
[    0.630068] PCI: setting IRQ 15 as level-triggered
[    0.630068]  -> edge
[    0.630068] 8139too 0000:00:03.0: found PCI INT A -> IRQ 15
[    0.630068] 8139too 0000:00:03.0: IRQ routing conflict: have IRQ 11, 
want IRQ 15
[    0.641901] 8139too 0000:00:03.0 eth0: RealTek RTL8139 at 0xc2582f00, 
00:11:6b:32:85:74, IRQ 11

First, INTA is apparently routed to IRQ11 (and the network card works 
just fine with that), whereas pci code wants IRQ15 for some reason.

Second, dumping chipset reg 44 shows that INTA is still set to EDGE mode 
anyway, although dumping port 4D1 now shows IRQ15 was changed to LEVEL 
mode, exactly as indicated in the above output. I'm not sure, but the 
datasheet (page 77) seems to indicate that INTx mode set in reg 44 
should match the respective IRQx mode in port 4Dx (Although the ROM BIOS 
seems to only have code to change triggering mode in the 44 register and 
does not care about port 4Dx whatsoever, which kinda contradicts the 
datasheet)

I'll do some more digging later, but any hints are appreciated anyway.


Thank you,

Regards,
Nikolai

>
>   I'm a little busy at the moment with other stuff and may not be able to
> look into it properly right now.  There may be no solution, not at least
> an easy one.  A DMI quirk is not possible, because:
>
> DMI not present or invalid.
>
> There is a PCI BIOS:
>
> PCI: PCI BIOS revision 2.10 entry at 0xf6f41, last bus=0
>
> however, so CONFIG_PCI_BIOS just might work.  Please try that too, by
> choosing CONFIG_PCI_GOANY or CONFIG_PCI_GOBIOS (it may break things
> horribly though I imagine).
>
>    Maciej
>

