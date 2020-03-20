Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7318D134
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgCTOj0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:39:26 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55402 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgCTOjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 10:39:25 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so2548711pjb.5;
        Fri, 20 Mar 2020 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a54IW0oB44nJzFv1TQssWnIGDqT1Lq9rUj5K2IpDqwI=;
        b=qNBIADHAq6ehPS/ovZWHrsu7MGd/UxDlnzD+zweINjMHVHnMtBB6FOCc8mZ4AK2sn+
         0jf8BXHyflIAVz+hE0NX3UYbiaCl06w8BZxkazyhDNur8jMHzNsTQkS/jbggtOTtNowT
         abxarJPlIPxtpGpCYE1GeC+BvrILbtVOFTMLCHOuHtnuAT321KZ6Vp8xTeoVRAuqnnII
         Jalcy7DC+PP0+sC6IxYTuGSL5qsSGRtQsmKX6oTK8VYKu5/Uc580sGHivzbxojUFrSa0
         tGef9gFQWBsjqWIyKiY7khPTi39m+Xc80oV4jD0C4fVyEBhyhfePUTBSh/KTrfeWNzWs
         FoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a54IW0oB44nJzFv1TQssWnIGDqT1Lq9rUj5K2IpDqwI=;
        b=lGdYQsS1lMTFL2f3HE/C4uGOLhdeyOQyBbf2ng39wLcOX3LJnWU5RbpCq79QzX1yaK
         FyVWtHLDapbzRC38FCge9lXbKSlnZuAprcoAlyC+Nwx1yNux303YpcfOL4brxHjWXB5k
         V9TaiyJaG0t+kFB7V9JjvL6y+36Q0l9JhRjlarCl6bSKGvIPUBu07B8j+qOmBYFcPCT/
         uIs9EB3YVVxNRPhmi65WqKDZJCQ+qRPfBIa2IO9kSK2QLhXY4licGdQ2xxMDBwGGQ5/i
         H1EMWC6b/po99zYdhQuNXtxY4eTRxG8YmedMsBEh7hXz94sYFiP4b9iHAeZKMkewMKj0
         eTEQ==
X-Gm-Message-State: ANhLgQ0QWljoUU8vHe2lFNJ2rioNk8B0ayuxDxM/6voAPljVvgx9NkpL
        0z+REK/k/x0V2IRmjXeGhEXu+n5SZF+HD/zKvFg=
X-Google-Smtp-Source: ADFU+vvvaVCkXdplje1O4GxrsGz4U6GUkJ3qUTDhDx4G7N8RLK5zRd1Pc/WBHOoPDY8ll979CQXu9IGQKSDD2UQAADM=
X-Received: by 2002:a17:90a:fb49:: with SMTP id iq9mr9739946pjb.143.1584715163452;
 Fri, 20 Mar 2020 07:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de> <20200320131508.826011988@linutronix.de>
In-Reply-To: <20200320131508.826011988@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 16:39:16 +0200
Message-ID: <CAHp75VdKavBD=yTR6Mz4iaGKQVP__xCsf-fWdy1MMJJywhDd-Q@mail.gmail.com>
Subject: Re: [patch 02/22] x86/cpu: Add conistent CPU match macros
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

On Fri, Mar 20, 2020 at 3:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Finding all places which build x86_cpu_id match tables is tedious and the
> logic is hidden in lots of differently named macro wrappers.
>
> Most of these initializer macros use plain C89 initializers which rely on
> the ordering of the struct members. So new members could only be added at
> the end of the struct, but that's ugly as hell and C99 initializers are
> really the right thing to use.
>
> Provide a set of macros which:
>
>   - Have a proper naming scheme, starting with X86_MATCH_
>
>   - Use C99 initializers
>
> The set of provided macros are all subsets of the base macro
>
>     X86_MATCH_VENDOR_FAM_MODEL_FEATURE()
>
> which allows to supply all possible selection criteria:
>
>       vendor, family, model, feature
>
> The other macros shorten this to avoid typing all arguments when they are
> not needed and would require one of the _ANY constants. They have been
> created due to the requirements of the existing usage sites.
>

> Also a add a few model constants for Centaur CPUs and QUARK.

I would perhaps made this as a separate change(s).

...

> +#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(_vendor, _family, _model,   \
> +                                          _feature, _data) {           \

I would leave it on one line despite the length, but it's up to you.

> +       .vendor         = X86_VENDOR_##_vendor,                         \
> +       .family         = _family,                                      \
> +       .model          = _model,                                       \
> +       .feature        = _feature,                                     \

> +       .driver_data    = (unsigned long) _data                         \

For sake of consistency shouldn't be this kernel_ulong_t ?
Or we are going to get rid of that type?

>  }

...

> +#define X86_MATCH_VENDOR_FAM_FEATURE(vendor, family, feature, data)    \

> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family,              \
> +                                          X86_MODEL_ANY, feature, data)

I would leave it on one line despite the length, but it's up to you.

...

> +#define X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, data)                \
> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model,       \
> +                                          X86_FEATURE_ANY, data)

Ditto.

...

> + * X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_BROADWELL,
> + *                                   X86_FEATURE_ANY, NULL);

Perhaps one line?

-- 
With Best Regards,
Andy Shevchenko
