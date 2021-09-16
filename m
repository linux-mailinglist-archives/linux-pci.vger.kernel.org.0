Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A658640D0A6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 02:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhIPAMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Sep 2021 20:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhIPAMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Sep 2021 20:12:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2AEC061574
        for <linux-pci@vger.kernel.org>; Wed, 15 Sep 2021 17:11:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b18so10066811lfb.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Sep 2021 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=rhlwSjpYZQyHsd/Gkc+Bh2o21qGKlRrQkNZBT83/ADs=;
        b=bvGj/rqEdTzJmRh3WXRLsj/QO7d24EggTLX7hfyjoPQKYreHU1vtsUmpA6LvBz4hIv
         Hp/S+0XpRQbzMlzRuIvkecOCsk8lLmaYhf6bDuo6xsmyexbaxkJv4UFteA8NjTVVKglI
         wmyZorYb9LptyLiojk1XEcksTym6PQbCyBZwjwclAxHvnDHgqKrz2wPtZWu9uYd1FS4c
         /vUeZsk7Lg7Rr2hfF3Zt6JDEVTMhBE3AAp2vHuf4HU1LBKyjWyWhqveFW2gGvWKRwPQc
         oyxPT2meLQQzWXr30LWUROyfkY03ePd9zm+a4dEyTo5ridFfjb3YD4s4LspxhJzS/Q3K
         qD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=rhlwSjpYZQyHsd/Gkc+Bh2o21qGKlRrQkNZBT83/ADs=;
        b=DWLhf+srgINFKokldyqp896f9byVxlgIHzPJwshQqE2t7Mi6Haf1fD/NhZp9BBBNhG
         D/07Fxx4pVSuoxgsJJzTlXw7BSNcWTouuOSi1MpWOuQ5+VZAIzRoZ8gbzGVDH4Q/y6qi
         KVyXj2dIRjkWrHQF/bjbthAlfEwsqIAXnbnvE8jyso2wI8EFTgQxqqJWypHiEQl1d0NG
         /e1f/8Z25G0JzFrZ8iGI4rCZNp4Hd3SzzmzaLlgebCSXrVJamGjyFdTob9HETnyA1nQc
         6bXVpkCy5eNRplFSdZBrLsG3dfkEWgSchlgfvu0nDG0ouwqANzRAEur1t6sVdwdC+VPf
         e5ZA==
X-Gm-Message-State: AOAM5327ZvQIRLTHklUhX/h2utog8oCCr1GY8IuKsgEHmjKAklImGpGt
        f352YPrvxoJLj43oCKeNQY4=
X-Google-Smtp-Source: ABdhPJxPfrBGIvFu2rS2HY7enSwT6JD3wa5ZvUCFTvltCmU0EoUAr106vHWDKoU2cM6cgcvIJHTB4A==
X-Received: by 2002:a2e:912:: with SMTP id 18mr2374278ljj.290.1631751085539;
        Wed, 15 Sep 2021 17:11:25 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id o7sm161720lji.17.2021.09.15.17.11.24
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 15 Sep 2021 17:11:24 -0700 (PDT)
Message-ID: <61428EDF.9030203@gmail.com>
Date:   Thu, 16 Sep 2021 03:25:03 +0300
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
References: <alpine.DEB.2.21.2107171813230.9461@angie.orcam.me.uk> <611993B1.4070302@gmail.com> <alpine.DEB.2.21.2108160027350.45958@angie.orcam.me.uk> <61377A45.8030003@gmail.com> <alpine.DEB.2.21.2109141102430.38267@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2109141102430.38267@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

14.09.2021 12:24, Maciej W. Rozycki:
>   Would you be able to share a disassembly of the piece of BIOS code in
> question?  I can read x86 assembly, so maybe the interpretation of the
> 10/28/41/89 cookie can be inferred from it.  The high nibble looks
> remarkably like a bit lane selector and swizzling is clearly visible, but

Ok, I've solved the puzzle.
High nibble is a ready-to-use bitmask for chipset reg 0x44 (so indeed, 
it is 1 << X).
Now, in low nibble, bit 0 selects one of two (0x42 or 0x43) chipset 
registers and further bit 3 selects one of two halves, and bits 1 and 2 
are apparently ignored. So actually, 10-28-41-89 is then just a freaky 
representation of simple 1-2-3-4 numbering. Good news it is exactly the 
numbering I chose when converting from $IRT to the supported $PIR 
format, and then it just worked (Some more details about my testing with 
this converted table where reported in my followup messages a bit 
earlier, you have probably seen them already).

Here is the relevant code with my remarks:

f9c1d: test al, 0x01 // Here AL bit 0 = Edge/Level CMOS setting.
f9c1f: pushf
f9c20: mov ah, dh // Here DH = PIRQ from $IRT table.
f9c22: shr ah, 4 // PIRQ's high nibble is a mask to set/clr E/L bit in 
reg 44 (1 << X)
f9c25: mov al, 0x44  // AH is ignored.
f9c27: call read_chipset_reg_AL // Register value returned in AL
f9c2a: or al, ah
f9c2c: popf
f9c2d: jnz .+4 (9c33)
f9c2f: not ah
f9c31: and al, ah
f9c33: mov ah, al
f9c35: mov al, 0x44 // Write AH to chipset register number 0x44.
f9c37: call write_chipset_reg_AL
f9c3a: mov al, 0x42
f9c3c: mov ah, dh
f9c3e: and ah, 0x01
f9c41: add al, ah    // PIRQ's bit 0 is reg 42/43 selector (X >> 1)
f9c43: mov ah, al    // AH is ignored
f9c45: call read_chipset_reg_AL // Register value returned in AL
f9c48: test dh, 0x08 // PIRQ's bit 3 is reg's nibble selector (X & 1)
f9c4b: jz .+3 (9c50) // Here 0 value selects lower nibble.
f9c4d: ror al, 0x04
f9c50: and al, 0xf0
f9c52: or al, dl     // Here DL contains wanted IRQ number to set.
f9c54: test dh, 0x08
f9c57: jz.+3 (9c5c)
f9c59: ror al, 0x04
f9c5c: xchg ah, al
f9c5e: call write_chipset_reg_AL

> I fail to guess the algorithm from this pattern.  Given that the PIRQ
> routing handler is chipset-specific we could try interpreting just the
> high nibble, but would it work for the next system with the same chipset?

This is certainly unclear. However, 10-28-41-89 can be arithmetically 
verified for consistency against the numbering scheme described above. 
So a respective test could be added somewhere. Also, prime numbers 1 to 
4 could probably be treated as valid numbering, too. Everything else 
should probably be refused unless some other numbering scheme pops up.

>   Also who is the BIOS vendor?  Maybe they would be able to tell us
> something about the "$IRT" BIOS service.

It is some regular AMIBIOS (American Megatrends) from 486 era, for 
EXP8449 motherboard, here is a manual I found for it:

https://www.elhvb.com/mobokive/Archive/Oldman.ixbt.com/mb/Expertboard_8449/exp84491.pdf 


>   Datasheets are not always right, but this one is the best source we have
> for this chipset.

Well, my testing has shown that practically, with your patch all works 
fine, including IRQ sharing. So other than this unclear numbering 
problem, I think it can be considered correct and usefull.


Thank you,

Regards,
Nikolai

>
>    Maciej
>

