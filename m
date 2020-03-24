Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C678190AD4
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 11:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCXKZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 06:25:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36962 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXKZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 06:25:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id a32so8810157pga.4;
        Tue, 24 Mar 2020 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niMBZQskqIvvbvSQd3Vs9C4OFVhjiYiDfUEWD3hhgQU=;
        b=WL57huwoohYOXgJDpFwNTccWhDvbdVj53HP9RTAYqeUArAowfq+8wm7C8xnQS+d7Xg
         T6ZEXRd83CkutsSV26moPh6SFShAu8y5bgcdaa94+vyt5gv9L7FHOWY/xTwiS3ZXTJoo
         mYyatVs+4JSkglhV/DZno5DkKWgsDuV6Nq3GIgrszTouv3+HdzH3Ue4zNWg9IJabYRM5
         Yc/KKpuGqrb71fAUqQdj6kfvkI7Fc5ogXvzI4kRXgF1utZe1N1Trsq00q5ItgQsyJMa1
         K51p515UguhiI4YjD4zkfxOZoju5Vs4RIc7CzfPQSFesYRhhKwf5f8kTncK3eqxsX1rE
         yirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niMBZQskqIvvbvSQd3Vs9C4OFVhjiYiDfUEWD3hhgQU=;
        b=MzFd2Jhj6NnyoTXDhkIDFXZaVVEeeRk7Ymt0c9yhAa02N+aUf3a2bgMGpJVsI0eyeb
         dOiCM7PPIjQ7Vy9vzvWavWC/dB5HRgGAX84io8H7x8yQwYGe45tzV8kg3FmX5+KuoT5t
         4deALsSaFDZjh44GUqT0q4JNNoF+98YMHrDsQhiKmkzRmTvZDXMjkjFRs22HbctASBKf
         fsytqVC2ZwiG3APXDtOU2kuJmfobubjcFW+5LF70sJzJrqTcnH9PkrIyHA/F0/SmkjI4
         u3ABbxCxzs7gfxoQZu9QRHtG5xcWiv9ikSPZ1eKCmWL/z1c0mU8DJnGlrg+/XBlexkNE
         vtBQ==
X-Gm-Message-State: ANhLgQ1JOAWWi5gPBJvE5LVcy14E2W0ND1MVLJbZRfqVsZSxIOEgewVQ
        l7nJZI/CkU4AdsGKMvy4n0CbhmtUPRNG4ZxZcbc=
X-Google-Smtp-Source: ADFU+vtRP5kcse4VydJXhIWcSQg5qG4qh1fLLlH+sYOY0YXmbvxSTKNtq7OW900chK9pK0hyoRdDWpT1dROadSow+qU=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr17417161pfs.36.1585045502171;
 Tue, 24 Mar 2020 03:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131509.564059710@linutronix.de> <20200324060124.GC11705@shao2-debian>
In-Reply-To: <20200324060124.GC11705@shao2-debian>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Mar 2020 12:24:54 +0200
Message-ID: <CAHp75VeeKZLeZ8E3Py7LECN54SPFHaRgkxrMzBYQWXM8x+4JhA@mail.gmail.com>
Subject: Re: [cpufreq] 06c4d00466: will-it-scale.per_process_ops -53.4% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
        linux-crypto <linux-crypto@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 8:02 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -53.4% regression of will-it-scale.per_process_ops due to commit:

> commit: 06c4d00466eb374841bc84c39af19b3161ff6917 ("[patch 09/22] cpufreq: Convert to new X86 CPU match macros")
> url: https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-devicetable-Move-x86-specific-macro-out-of-generic-code/20200321-031729
> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
>
> in testcase: will-it-scale
> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> with following parameters:


drivers/cpufreq/speedstep-centrino.c change missed the terminator,
perhaps it's a culprit, because I don't believe removing dups and
reordering lines may affect this.
Can you restore terminator there and re-test?

-- 
With Best Regards,
Andy Shevchenko
