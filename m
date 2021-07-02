Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD23BA38C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGBRSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGBRSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 13:18:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE52C061762;
        Fri,  2 Jul 2021 10:16:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n14so19319696lfu.8;
        Fri, 02 Jul 2021 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=eIvDzQe/4c2beVLlwKPyRniIDsc7hswiYgzlsE5Kshk=;
        b=GpO48OnCXjeMIc/hn94VOetuU2mb6gg0Avt9i9Pc1aslIWu4DYQ8VgHwZsOH6NoDD4
         xQCT1pi0X5VeZw/7wiRm+sXwhpIr2gZKbu7phPR1NvCq/FR69Es7+aQikn6a/IKsGR1Q
         pWZ6ekRu10y1CFTyJZDdrEIT1e5zDdmfPIAYWK+sIE53dLpJkQLdWbpvVAp18O4F1Mga
         k5kslE8jCnyl67aL+sbfm6A3gTjx1sngUJZvczviE5z5isMTMkpcfCB6EvgelkL07P7G
         kamX7ZE6QeD7lTHYeQkYpcrPGvUbNOMVolcHBwnFu+1BTt6dCa8UEaXep9GwKR7Sr/v8
         5iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=eIvDzQe/4c2beVLlwKPyRniIDsc7hswiYgzlsE5Kshk=;
        b=M2vFWSmW6MwjuXR2GTl4kjqmmUdBHKEJ9/KSJCw9vb7TNO4gfTaNYIK0xbPbBpLjNq
         dbG3/ShuN9n5gyVL4KBUJqfnr0goIxZNMDL4xN923JWddzad9xs6j/zl2gzaOzHrPu3x
         iq+6UMflxpz7PA+mY/c7z2EJTUR6RvlRAUGnPMKn0Zot89cwnlFexty+9lnxMWatkFaX
         r5h7agojAnWC0VKOEWjKOnwyWrZ0Itqj26UAKHdSipEqzyMyLJr5caRz1ZEy1OA5j5jC
         6u18h+rC2wBShvZMi1KVK7hQDAQ0urRM9PR/WMC3/JCEAQCVNVFao308rPSFzpWuS1UP
         Suzw==
X-Gm-Message-State: AOAM533e9+sXBGWQonv5HXsyBuKcU35AW5gmkP15Msa/dgn29VU/3FmW
        AkF60fDTm56oYuxsrpBqO7Y=
X-Google-Smtp-Source: ABdhPJxczqe5g7CIi6mXET/ZC4ShVPsY/7ocyMy/ayiB7sEhLmvDLOOeuCp6nwv0Giey4R8Dv7SZDQ==
X-Received: by 2002:a05:6512:3761:: with SMTP id z1mr480053lft.99.1625246166141;
        Fri, 02 Jul 2021 10:16:06 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id o14sm410325ljp.25.2021.07.02.10.16.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 02 Jul 2021 10:16:05 -0700 (PDT)
Message-ID: <60DF4C75.7020609@gmail.com>
Date:   Fri, 02 Jul 2021 20:27:17 +0300
From:   Nikolai Zhubr <zhubr.2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] x86/PCI: SiS PIRQ router updates
References: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

24.06.2021 2:38, Maciej W. Rozycki:
>   As we use the generic `sis' infix (capitalised or not) for the SiS85C503
> southbridge I have prepared this small patch series to first make the
> existing SiS program entities use a more specific `sis503' infix, and then
> provide a suitable PIRQ router for the SiS85C497 device.
>
>   Posted as an RFC at this stage as it still has to be verified.
>
>   Nikolai, can you please give it a hit with the extra debug patch as
> requested in my other message?

With
linux-x86-pirq-router-sis85c503.diff applied
linux-x86-pirq-router-sis85c497.diff applied
and DEBUG 1 in arch/x86/include/asm/pci_x86.h
here is new log:

https://pastebin.com/n3udQgcq

My feeling is that something went a bit wrong because:

8139too 0000:00:0d.0: can't route interrupt

and

# 8259A.pl
irq 0: 00, edge
irq 1: 00, edge
irq 2: 00, edge
irq 3: 00, edge
irq 4: 00, edge
irq 5: 00, edge
irq 6: 00, edge
irq 7: 00, edge
irq 8: 00, edge
irq 9: 00, edge
irq 10: 00, edge
irq 11: 00, edge
irq 12: 00, edge
irq 13: 00, edge
irq 14: 00, edge
irq 15: 00, edge

Note: I still used 4.14 kernel for this test but your patches applied 
cleanly with no fuzz so I suppose it should be ok.


Thank you,

Regards,
Nikolai


>
>    Maciej
>

