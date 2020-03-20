Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FCD18D17D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCTOuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:50:25 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51520 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCTOuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 10:50:24 -0400
Received: by mail-pj1-f65.google.com with SMTP id hg10so2565870pjb.1;
        Fri, 20 Mar 2020 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3awxwIekRDUBiBlAlaIOOsVcqd9E8h+LzREGVIDTmsg=;
        b=Q2if4FSJkS5b1GBTG4smedIbHgap+zOMxVKm0PGblSmtf/+NGn7hAlBY00C7COP4f7
         C27sulG3G4VyEPccPDcjaordcpDVP/LDpNNmf7sdqdm28JOAOGKJshLks4pc/y5oKIVO
         KGWjEZRwmp9A5QPvKXR3HNp5EoCLSmTcvq/nHwo4lmnaUuCmvV03rO9qJQY+zLejwizQ
         rVPqPIO2lxX31ILA01SzR6U32fbAhkTK2XzMSE/6hJ7rSCIXhI1QFX+fZOO1s9e7xvNw
         N+qg30+gWi9AmmMO1AhsmNG/jzt0vIS4zqFSm63+qxFyPIPUowT5GJhOKpZjttaJD3NN
         t2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3awxwIekRDUBiBlAlaIOOsVcqd9E8h+LzREGVIDTmsg=;
        b=jYbzGxAffTFUJ0pX+A1BWagftbqXOTxECj/vzAZRFCTItFX9pCgyddf7DzVKvuDVNT
         T4D5aC1w4z7k+86Nivm59QBxW0qVCK0QPsBNCZ2L2GpkofA59ztBC/B3aA8QvtKQI3T5
         kh0fo80aLT086Ky0BNb2N5Mo3KwDdOAgF/Ckx7NkeqbxEyPoDsk7+P7niMfgc7wO5KA+
         0FHjkL3RDdX4ipugbUGE/9p0CcxXkMYaA+CRtVDp117OS/Fkd3+liWliecZoGJeJnDl3
         LCOy3mLhzXVKKHALRfvQLVaBjk9qzG1dQAtLzP4+TcNBUNFdeT7Nk+K9MzUV4j1Ov4GO
         hbVw==
X-Gm-Message-State: ANhLgQ3taz6cC7ffCEDvPIAMkk+LZ6/bAqE5HkvloYIL7hjGSkkBBrvc
        /ZYeM2jOuFcAH4j1nAOZADuSvK0aDJ+hX4zG/Ng=
X-Google-Smtp-Source: ADFU+vsJEMZmNCk8RrzRySH+vRQdh+TFU7wWO6UeDM8ozVAsygQtqKjCFI/e2CTKyamUM7Q0lbVz1aA3GBN4lADHJkU=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr8649803plf.255.1584715822790;
 Fri, 20 Mar 2020 07:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200320131345.635023594@linutronix.de> <20200320131509.564059710@linutronix.de>
In-Reply-To: <20200320131509.564059710@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Mar 2020 16:50:15 +0200
Message-ID: <CAHp75VdkvyqOaAsLmz8K2j4bdd0sboPoUpRr6U-zvtkSaQfPRQ@mail.gmail.com>
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

On Fri, Mar 20, 2020 at 3:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The new macro set has a consistent namespace and uses C99 initializers
> instead of the grufty C89 ones.
>
> Get rid the of most local macro wrappers for consistency. The ones which
> make sense for readability are renamed to X86_MATCH*.
>
> In the centrino driver this also removes the two extra duplicates of family
> 6 model 13 which have no value at all.

> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),

> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),

> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),

Perhaps use names instead of 6 and 15?
Also, NULL vs. 0?

-- 
With Best Regards,
Andy Shevchenko
