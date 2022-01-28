Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD214A024C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiA1UtP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 15:49:15 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:40688 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiA1UtO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 15:49:14 -0500
Received: by mail-ej1-f50.google.com with SMTP id p15so19878776ejc.7;
        Fri, 28 Jan 2022 12:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq5dwGgkiq/tjKMtkNEpgpX6pW2tDIubIfAQctI09OQ=;
        b=R8QrTPQ1TnxjfVBxm/vPbSs+zZoij6ff/S5aKTxlp2+ttjb1Q0WhRqnUjx2ZJ3Biei
         UNfKTz3xzLPiQBTHWFK+9MgXkQnFBTEHa/MJwGRcvhyD1sIgWKfQP58v0VPU/Jt0brDv
         RDZ+p8wigIcTVvF+lp8GckSZBkL5TNCBWlEgitH4IgrssdqOOxGv/LSeOHrqX6VlZCji
         7p40IOYzL/RVtIftNnJ18ieDX7mUYDGt2M7EsYAtgzcKYvDc6ncet4P/omXQfNCwOb/1
         hrSRId/zJ0PckyUyi8iR72kNXSB7rHnY8/+DWgQBd7oiPkixruHoafy3n07v9JHlX62T
         xsTQ==
X-Gm-Message-State: AOAM531KCam80TpzOUu3GawXJjFWqyCT9OrYcAFaMGPTDKmLJ0fWESwb
        A9CTKcA60IvXKE4+q/jI+F8zgR0vTXdjgoQO6/o=
X-Google-Smtp-Source: ABdhPJy/HStjEBmsl8P/QuvAKGCD5KVvaoBga4gudMrXZBSCYYO7DY4qoIKGdMjUOarIsRls2oxcIn9/TIrpW/CHaSQ=
X-Received: by 2002:a17:906:910:: with SMTP id i16mr7916287ejd.677.1643402953464;
 Fri, 28 Jan 2022 12:49:13 -0800 (PST)
MIME-Version: 1.0
References: <YfQpy5yGGqY8T0wW@jupiter.dyndns.org> <a7ef2455-ede5-2238-639b-b3a66842a04b@intel.com>
In-Reply-To: <a7ef2455-ede5-2238-639b-b3a66842a04b@intel.com>
From:   Brent Spillner <spillner@acm.org>
Date:   Fri, 28 Jan 2022 20:48:47 +0000
Message-ID: <CAGwJgaNa2u8vmxsnaSdpSH+ZO0e2GCYObSwC+j03843gXQ_vwg@mail.gmail.com>
Subject: Re: [PATCH] arch:x86:pci:irq.c: Improve log message when IRQ cannot
 be identified
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 6:00 PM Dave Hansen <dave.hansen@intel.com> wrote:
> Shockingly enough, that parameter is in the documentation:
> and double-shockingly, it's even called out as X86-32-only:

Right, seeing that is what convinced me that not customizing the log
message for x86_64 could be considered a (admittedly very minor) bug,
and perhaps worth fixing.

> Given that, do we really need to refer to the line numbers of the
> implementation which will probably be stale by the time this is merged
> anyway?

Understood, will change the commit message to just refer to the
command line documentation.

> Any chance you could make that, um, a bit more readable?  It's OK to add
> brackets to the else{} for readability even if they're not *strictly*
> necessary.
>
> It might also be nice to use
>
>         if (IS_ENABLED(CONFIG_FOO))
>                 ...
>
> rather than the #ifdefs.

I don't mind doing either of those if that's the maintainer consensus,
but would note that neither would be consistent with the surrounding
code. Prior to the patch, the .c files in arch/x86/pci contain a total
of 33 #ifdefs and just one IS_ENABLED(), and systematically avoid
superfluous braces around single-statement if/else/for bodies.
Granted, the code has other style problems and triggers a number of
checkpatch.pl warnings (although not in the region affected by this
patch), but I was trying to be as light a touch as possible.

> I'd also be perfectly OK having two different strings rather than
> relying on string concatenation and the #ifdefs.
>
> Is the "or enabling ACPI" message really necessary?

Not strictly necessary--- it seems fair to assume that anyone
disabling ACPI does so intentionally and with good reason--- but I
thought it might stimulate the right thought process for someone who
doesn't understand why their hardware isn't being properly detected,
as ACPI triggers some very different code paths through this driver.

It seems like the multiline string literal is your main pain point--- would

+#ifdef CONFIG_ACPI
+                       if (acpi_noirq)
+                               msg = "; consider removing acpi=noirq";
+                       else
+                               msg = "; recommend verifying UEFI/BIOS
IRQ options";
+#else
+                       msg = "; recommend verifying UEFI/BIOS IRQ
options or enabling ACPI";
+#endif

be OK without going to IS_ENABLED()?  (Personally, I think the #ifdef
style is more readable.)
