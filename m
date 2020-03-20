Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68218D0E6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCTOcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:32:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43844 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCTOb7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 10:31:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so3305976pfa.10;
        Fri, 20 Mar 2020 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6c+JSVCxP0/exR74ChVM1yt+TIcfNUXUTN2EWov9Law=;
        b=AbnB4wwwyxJU822g6/gWFpEQ4P3sPvgEIZgPVxj0ueTSXGScHWIdqu8Bfum8A4f6/t
         2cDmx+mRDs0d1aBYc9kuZWhUGlZQopNmfAxvsBGjJ2W8LGR85UU6GLrxxvJOy3kJTSkt
         JE2nO9goUQjnpdlunQj2qxtw4FlMydNhnNhEBXWivBv1tMzUcJQVSsDGBYU36GYVMp8q
         bKTQBBUmTNmI+aPH3SFqG5lItDWQRccn1+Dg8YPYsBTJRjVLTIQ2IzJKGId0vHuwsZiT
         VE+EXhUwgiTuaSOm8mlyq4iFfyyT5oKb3cv24fO6Y63UPc6pY5TFkmuaGyR5BMx2pRpy
         uzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6c+JSVCxP0/exR74ChVM1yt+TIcfNUXUTN2EWov9Law=;
        b=N4vP1x9b5UIRMUoaHsufgdel9ydo049Hsoh30WQXs0Xkb+75bcDQwThYLsCDQnG7LT
         Q99MRF8SdG9z7TMPqeLLFyXDMprt1leBnRa3EmUfK2oZvS/pPq84hEP9f7oUx9wDkvMV
         b/PD+5/u+16HOQpvI3Itsyo6p7+ClqY4vwb7KHpM77YOU8Xh35Gxwmd4Zh3YeVAsEm4/
         9lWRFizv9N3BJZwwnRE7lW+mjCj47m1Z4brKhQ7DSWBtpgpWoFbPYmSZN92105rd2rfM
         gUuHdTgC6227kZgrbnr5ftjTlfS9F6ysH567qp7EqNhwrpbrLElq7JS+ISiztniH7hdH
         d5bQ==
X-Gm-Message-State: ANhLgQ1k8ltKcE+nJlaokrCPHdl6Fg5h/DRRh//joq/GlfowSHdyQp03
        eBLfojP+G3Zeb9+X2fzoXi84GCKurVrdEmB/kRw=
X-Google-Smtp-Source: ADFU+vup5g2RU5zzwiEF27K/7Facn+zu9j1qO5AF3IVfdl5lu3UZTrDLOmtE7bcC/STD/7WybqqCoP0QLrfa0c2hinA=
X-Received: by 2002:a63:798a:: with SMTP id u132mr9271382pgc.203.1584714709588;
 Fri, 20 Mar 2020 07:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de>
In-Reply-To: <20200320131345.635023594@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 16:31:42 +0200
Message-ID: <CAHp75Vffg5jm5knwuAKwkDZ16=kDujT1LCpzGU8mUV9NrXkSag@mail.gmail.com>
Subject: Re: [patch 00/22] x86/treewide: Consolidate CPU match macro maze and
 get rid of C89 (sic!) initializers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 3:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The x86 CPU matching based on struct x86_cpu_id:
>
>   - is using an inconsistent macro mess with pointlessly duplicated and
>     slightly different local macros. Finding the places is an art as there
>     is no consistent name space at all.
>
>   - is still mostly based on C89 struct initializers which rely on the
>     ordering of the struct members. That's proliferated forever as every
>     new driver just copies the mess from some exising one.
>
> A recent offlist conversation about adding more match criteria to the CPU
> matching logic instead of creating yet another set of horrors, reminded me
> of a pile of scripts and patches which I hacked on a few years ago when I
> tried to add something to struct x86_cpu_id.
>
> That stuff was finally not needed and ended up in my ever growing todo list
> and collected dust and cobwebs, but (un)surprisingly enough most of it
> still worked out of the box. The copy & paste machinery still works as it
> did years ago.
>
> There are a few places which needed extra care due to new creative macros,
> new check combinations etc. and surprisingly ONE open coded proper C99
> initializer.
>
> It was reasonably simple to make it at least compile and pass a quick
> binary equivalence check.
>
> The result is a X86_MATCH prefix based set of macros which are reflecting
> the needs of the usage sites and shorten the base macro which takes all
> possible parameters (vendor, family, model, feature, data) and uses proper
> C99 initializers.
>
> So extensions of the match logic are trivial after that.
>

Thank you, Thomas!

Briefly looking to the code, I like the idea. I'll do (minor) comments
on individual patches.

I see it incorporates my previous attempts to extend this, but now it
looks better.

> The patch set is against Linus tree and has trivial conflicts against
> linux-next.
>
> The diffstat is:
>  71 files changed, 525 insertions(+), 472 deletions(-)
>
> but the extra lines are pretty much kernel-doc documentation which I added
> to each of the new macros. The usage sites diffstat is:
>
>  70 files changed, 393 insertions(+), 471 deletions(-)
>
> Thoughts?
>
> Thanks,
>
>         tglx
>
>


-- 
With Best Regards,
Andy Shevchenko
