Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B007A18D221
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCTO6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:58:48 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38564 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCTO6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 10:58:48 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so2563662pje.3;
        Fri, 20 Mar 2020 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0CYiHRmjAbhtOwx0x1mf5Pz7QynYzQVMMGgwVVNtoU=;
        b=eDQwtq1zQtOLd13ST3FOE7Sk2oulpHAzFYSjgwUoCzQ5WXHo9DAhlrJaeQIaykrd+D
         RplqyKdtZ/hBD2YanBGphKOaQw6ZGvbr0itJPAkcQv55q1L6wgeyumguRo6p+04KrtfS
         cuICJ881I+mOiFh+XhbFOLVUzh47gmQCawWmusNQ5h3rTXlwTQzV6jyF+TjbqNAuBBh4
         uOiRkmD2pufS8fD21xLXacQlf3uZ5k7XnWVnqm3MfyCs52uigESXh8xdmxrTEGhKK6nZ
         tdFZiB/kjTQl6dQHrucJG+0TR0zyhbbEFUdK76SQDWixZFCkUUWBTTTTzYOJdhdCS1D3
         aweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0CYiHRmjAbhtOwx0x1mf5Pz7QynYzQVMMGgwVVNtoU=;
        b=reG2UAJbZYVr+fAX61hc6JUMV6nO4l4XWNsn5FvCQomTxzQK589//RJ9gU4N+tcgid
         ThJgvuo3x4WknXD1T715yHf2CdBHoJ4Ma8PXhzXOZLl0ihOPuSYE/E2rD6H8resTqoHT
         c+uJw+0wSs6HQlcERZl/3wrweUyua3Dta7HRFJ/xBAErWTKiUoAvcS9orpGCC0vjhlhq
         IhpivcrYrMk6ZLDYQnW4j63Uo3fQOiniAq/8RDf/SJoZiYrKkx/eu/MiJxRX/YO4b90F
         p4UWKDTO+ECLOdkgFDHr26jNeGljTkkmOql0uOwaNj6lL20xodI1mi2Z7sUVibabBpPh
         BtRg==
X-Gm-Message-State: ANhLgQ3he0nB0LArE0DUb6tHd3Ufcy4WgcQUrMppJ7Cqyyhf+LRzAaYc
        MmfYINoFUXqllgFBMZbSBZVdxCtdxelc+UPqPrY=
X-Google-Smtp-Source: ADFU+vteYsnR7L5XY9pl14RxIG6UQ4TH7+FGZCql5w8AqUCpZZGK/AtSNu9A6VkE0ZiE9rOAuclYQjce/FWRjxLrLDc=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr8686783plf.255.1584716325841;
 Fri, 20 Mar 2020 07:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de> <20200320131510.594671507@linutronix.de>
In-Reply-To: <20200320131510.594671507@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 16:58:38 +0200
Message-ID: <CAHp75VdCTCk8OKBWKAapZz27zSvsDm_L6TChhSNpS0U0nS=wCQ@mail.gmail.com>
Subject: Re: [patch 19/22] ASoC: Intel: Convert to new X86 CPU match macros
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 3:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The new macro set has a consistent namespace and uses C99 initializers
> instead of the grufty C89 ones.
>
> Get rid the of the local macro wrappers for consistency.

> -#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  #define SOC_INTEL_IS_CPU(soc, type)                            \
>  static inline bool soc_intel_is_##soc(void)                    \
>  {                                                              \
>         static const struct x86_cpu_id soc##_cpu_ids[] = {      \
> -               ICPU(type),                                     \
> +               X86_MATCH_INTEL_FAM6_MODEL(type, NULL),         \
>                 {}                                              \
>         };                                                      \
>         const struct x86_cpu_id *id;                            \
> @@ -32,11 +30,11 @@ static inline bool soc_intel_is_##soc(vo
>         return false;                                           \
>  }
>

> +SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
> +SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
> +SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
> +SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
> +SOC_INTEL_IS_CPU(cml, KABYLAKE_L);

I'm wondering if driver data can be used in one macro to distinguish
which CPU we are run on.
Takashi, what do you think?

-- 
With Best Regards,
Andy Shevchenko
