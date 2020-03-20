Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9D18D16F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCTOrT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:47:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCTOrS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 10:47:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id j10so3317028pfi.12;
        Fri, 20 Mar 2020 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzqksOZo9oKzssQWd4+TCqMTVJHNfIm+9Q0SEfaLBjU=;
        b=jvK6zIz+Qr1G8bcWBVBwn3UfzcaK9sRBJks8raIHNoHYfHO2DmiGRVxPhd4Zu5DrCz
         ssEKRSg6XEUN2Bh1T3t8FxP+2Llw4OryQC/PYqdtuX2VGcpgpXUJOggqoxLEX14U+Ycg
         LuBarYM6L87ZRlUuDNsMpGMqd9Lb0heHLMtAbs43E7wHfpmR6nmXZQONvOHiQl54CxGC
         FbYDgx36/VNKIJit0ypjsiN2/VZSsJQdz4/Mwai+3I0nY+qHqo5TS73yp5yHMdK5Qlep
         kuFS3nbtw7pZAsbQO+unr7n7vI9tW6NkdNc+MtzoBeK6iS8kQ/6WAkOhGDlo0f0qjuhv
         Qn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzqksOZo9oKzssQWd4+TCqMTVJHNfIm+9Q0SEfaLBjU=;
        b=U5ck6+lKlgn5sTOS5RWvgpsCNcJXPaHjnWkqQU1h1GU6ZY7YR/YtKJaq/xELTmo7+H
         aTrxPs/1yuSrMx+tDzdd4BpBR3gkjY9/iEpf+qcWKTrS554suBY+H2NCKz8utLTGa7H+
         0uqqxV3yLvKEmIw9765/E/KTYlRY+ko/tnoeCg7HOwJQzNrewJg5aCWxc3N9gJznTAEP
         SGbJqu7clSt3/osBYr+skzxiuqLqRQI3YnZuUoVgdAMBnAd3ekffZCg7nzCppopSmjra
         PqxlKei2M/AWTkFJ/nOkeQd1rNlT2IgzAtuVcZDfwfAxnIQhBh0RI34faWQI6zJWFx4Q
         zPuQ==
X-Gm-Message-State: ANhLgQ0sgjdP5uJfn7kQg/7n9J4P5lEe9bxQQhopwtfSRDfIIepf2szt
        eBXcz4PkzABVgVx7ZZxseX2hdKXW6jvw0upGOaw=
X-Google-Smtp-Source: ADFU+vtsQgQOnLRlTrTgGM50EY41vnr51HFNUk9V7349gPUFHWyFKZzvnxnlkchBu6NONcJcSUPuUU7T2einYPojAXw=
X-Received: by 2002:aa7:9348:: with SMTP id 8mr10286496pfn.36.1584715637228;
 Fri, 20 Mar 2020 07:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de> <20200320131509.467730627@linutronix.de>
In-Reply-To: <20200320131509.467730627@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 16:47:10 +0200
Message-ID: <CAHp75VcK3tL0YayjF=CSkSkHiOpg2zOV3rdkXQWJmLZ9fmevpg@mail.gmail.com>
Subject: Re: [patch 08/22] ACPI: Convert to new X86 CPU match macros
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
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
> The new macro set has a consistent namespace and uses C99 initializers
> instead of the grufty C89 ones.
>
> Rename the local macro wrapper to X86_MATCH for consistency. It stays for
> readability sake.

> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        NULL),

> -#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> +#define X86_MATCH(model)       X86_MATCH_INTEL_FAM6_MODEL(model, NULL)

Maybe we can do a generic macro to avoid all these ', NULL' repetitions?

-- 
With Best Regards,
Andy Shevchenko
