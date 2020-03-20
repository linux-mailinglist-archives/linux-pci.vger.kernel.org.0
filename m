Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0318DA92
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCTVw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 17:52:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTVw5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 17:52:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so3965104pfo.13;
        Fri, 20 Mar 2020 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a04BEXBq6T16pF8YgWqXF8qeXZZehjOHDxhsKaZX814=;
        b=Skn7flJSlYGzwEVidWCfP5Sxs1un6UzXQtQz+bWdWoAKNnRM80PqPvhDZwvv2wJKw6
         Mj81HfQM/zfiGt9ileOkKRRQWiF7jWjG6JhV+9WIbVnMz/dnDuFUHCHtIbQX4/CY7DkK
         noOtt/A9DKzcRzAlH+RqcMdMCY2dyTdaWE9AE5cShMSjs4HBzANhTM2+7CpxOlPpNBsU
         9nhE6/1XKN4/0cmtxXDNEwjoXngQLqF8QiIUQVIm1NRPbQReCnfpG/6XbUusceYyN0mz
         qR1CBCi2y2i3OXLUvaPOWqAKkvUGIR4nJ+prrBs7mnq20vlj/y21DMR6IS0a4SS96qyg
         vOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a04BEXBq6T16pF8YgWqXF8qeXZZehjOHDxhsKaZX814=;
        b=osqubrMHaroAdX2xmT5TcDKYfdmAD2rMkehhh4Gjs6SU9CAVegfxsZ/rvJVGVvKVFz
         Bp/ePrg74/IzI2RMVmLRIumo6AhN55yNnBupg84Yka97VGX+Ju6Qc+hSuJn3CaeNUmZb
         NWABF2Df3o+Qu6Om8CCwyr7I/1tp0/Qz0grX/AHAFaS6J1+eL72L8PQ+La7TCzwricRJ
         tRpnhaEkAG71W9VCt9IZr2oN0wnK4hGC7yhIX6UZyu3QTvZtlRVSClNYoH4zp4ZHbaQe
         rnoAjskCtXhlg5ee4Wc/mya6JnqCmro/bbfv+OzrnQjdbfEoLD0ATwp3+t3z6HLJmvQB
         VK1Q==
X-Gm-Message-State: ANhLgQ0PnxycUN+1pg4nT0yArAW59uWKknhE+IZQ1BEByRakKPx41L48
        mMNWjfI7jzf2fsAQ425fXk55KAHoHQiix6AltUE=
X-Google-Smtp-Source: ADFU+vsmV5czmNKtoJg0C7AeN7wX4S5Al3MMjqsDaMzJBp9Kh1vmxFKQ2VcZyX/I27EONEdC3cCFyRbcSUnbF2ixLdU=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr178775pfs.36.1584741173473;
 Fri, 20 Mar 2020 14:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de> <20200320131509.564059710@linutronix.de>
 <CAHp75VdkvyqOaAsLmz8K2j4bdd0sboPoUpRr6U-zvtkSaQfPRQ@mail.gmail.com> <87eetmpy56.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eetmpy56.fsf@nanos.tec.linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 23:52:42 +0200
Message-ID: <CAHp75VfuU98gEriS+GDJqZX4BV-cZT9hPbrDX-roeo63O8UvYQ@mail.gmail.com>
Subject: Re: [patch 09/22] cpufreq: Convert to new X86 CPU match macros
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Fri, Mar 20, 2020 at 10:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Fri, Mar 20, 2020 at 3:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
> >> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
> >
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
> >
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
> >> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
> >
> > Perhaps use names instead of 6 and 15?
>
> Thought about that and did not come up with anyting useful. FAM6 vs. 6
> is not really any better

Hmm... Do we have family 15 for Intel? Perhaps I missed something...
Or is it for any family?

-- 
With Best Regards,
Andy Shevchenko
