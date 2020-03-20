Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 899A018D948
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 21:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgCTU2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 16:28:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37077 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCTU2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 16:28:24 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFOFL-0003Pp-8l; Fri, 20 Mar 2020 21:27:59 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 857A71039FC; Fri, 20 Mar 2020 21:27:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
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
Subject: Re: [patch 02/22] x86/cpu: Add conistent CPU match macros
In-Reply-To: <CAHp75VdKavBD=yTR6Mz4iaGKQVP__xCsf-fWdy1MMJJywhDd-Q@mail.gmail.com>
References: <20200320131345.635023594@linutronix.de> <20200320131508.826011988@linutronix.de> <CAHp75VdKavBD=yTR6Mz4iaGKQVP__xCsf-fWdy1MMJJywhDd-Q@mail.gmail.com>
Date:   Fri, 20 Mar 2020 21:27:58 +0100
Message-ID: <87h7yipy9d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
>> Also a add a few model constants for Centaur CPUs and QUARK.
>
> I would perhaps made this as a separate change(s).

Can do.

>> +#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(_vendor, _family, _model,   \
>> +                                          _feature, _data) {           \
>
> I would leave it on one line despite the length, but it's up to you.
>
>> +       .vendor         = X86_VENDOR_##_vendor,                         \
>> +       .family         = _family,                                      \
>> +       .model          = _model,                                       \
>> +       .feature        = _feature,                                     \
>
>> +       .driver_data    = (unsigned long) _data                         \
>
> For sake of consistency shouldn't be this kernel_ulong_t ?

I can change that though in kernel space this does not matter.

> Or we are going to get rid of that type?

No.

Thanks,

        tglx
