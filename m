Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5107218D0F3
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCTOdX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:33:23 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53857 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCTOdX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 10:33:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so2547933pjb.3;
        Fri, 20 Mar 2020 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8CL3zZj4yGG4lD3L6yv8lcW+KdsOuZ+KSCgXBMVoeQ=;
        b=L9sgbN6wN5LoekRNwV3OkrwtTgMc/JlHqiY7y9vO3HDdjEG/orGFjNxp/q2gIpR2HX
         cU6tHLQns13rsmmNdoEI7Nv2tbx4XbTTK3yI0Ugeb8037dKJAGcbafkBWz5WUYEGvUES
         mr4CF0f7lD5Ovkymjy0j4fN+23aB2juafQuLbQCUK8eg6CppHfxoO6WNxz5Un1/qDb/7
         YTbJyV3ooQQlJT7MjAeroDiUw5ja4n/ivZCszT3H/j46hYkIeHWwf6lkmIIjR+oqM69R
         wGCC9vfLD+DwxaR+M3PBGwaej7BdJmmi7YgWJAUynp/EXPazIGucxui5Wg1SngYwtTf7
         V5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8CL3zZj4yGG4lD3L6yv8lcW+KdsOuZ+KSCgXBMVoeQ=;
        b=cbkhty0CR0uDCynseRjlBn7ZUVKwi+znClQFrAfuBR6BKbI/eXoMkQcvr4q/ONR01q
         Ea9FGh70f0762cnnZj7w6uxxlPDXlirFhULxUie0qMGQz9rugVNz6Y5VROZhiObiAM5x
         M4ePcBMYsCP6sazkyEvoy5Tqp0M9JpEWkN9g6xMQIVMG+yqT3MyQ2B4XlCWDjB6PF3mm
         FllqcvBKWOPRGhnfGc1h2lBt9I8Qdr2WgXm82BVfvdH2ld2MSOfBqOf+1khFYS/s5dwM
         i7D9IvlN9nnt+23sLDvB66FD8ye56BWmYf4yfJ9puboriIVjepbl9RZ8s8nBohUD3tT9
         gZWg==
X-Gm-Message-State: ANhLgQ317M+AP555oM4VSQZGjw5k1AJWorRRAqm9qcd93xtago9rxSgz
        yLOGkBVvLy2OEBWP9nIUbgxkWyxWesP12GHZmRk=
X-Google-Smtp-Source: ADFU+vtfmvNWzKVRIO3O61UeKiXfFAkZ78miDvEyQJ+ZPA+9PqY48/8tdpjDkFa9gmPvQSHovm3oH5zXZ65598V9cJg=
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr9079029plo.18.1584714801666;
 Fri, 20 Mar 2020 07:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de> <20200320131508.736205164@linutronix.de>
In-Reply-To: <20200320131508.736205164@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 16:33:14 +0200
Message-ID: <CAHp75Vca0j0=EB2qdvGgFOq2s_ohHUEzY4OeNrv-oynLBVYh1w@mail.gmail.com>
Subject: Re: [patch 01/22] x86/devicetable: Move x86 specific macro out of
 generic code
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

On Fri, Mar 20, 2020 at 3:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There is no reason that this gunk is in a generic header file. The wildcard
> defines need to stay as they are required by file2alias.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/cpu_device_id.h   |   13 ++++++++++++-
>  arch/x86/kvm/svm.c                     |    1 +
>  arch/x86/kvm/vmx/vmx.c                 |    1 +
>  drivers/cpufreq/acpi-cpufreq.c         |    1 +
>  drivers/cpufreq/amd_freq_sensitivity.c |    1 +
>  include/linux/mod_devicetable.h        |    4 +---
>  6 files changed, 17 insertions(+), 4 deletions(-)
>
> --- a/arch/x86/include/asm/cpu_device_id.h
> +++ b/arch/x86/include/asm/cpu_device_id.h
> @@ -6,10 +6,21 @@
>   * Declare drivers belonging to specific x86 CPUs
>   * Similar in spirit to pci_device_id and related PCI functions
>   */

> -

Seems you are going to remove below anyway in the next patches, so,
why not to do this also there?

>  #include <linux/mod_devicetable.h>

-- 
With Best Regards,
Andy Shevchenko
