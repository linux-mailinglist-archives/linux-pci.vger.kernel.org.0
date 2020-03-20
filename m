Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB618D95B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 21:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCTUa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 16:30:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCTUa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 16:30:56 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFOHm-0003TQ-I5; Fri, 20 Mar 2020 21:30:30 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E29761039FC; Fri, 20 Mar 2020 21:30:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
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
Subject: Re: [patch 09/22] cpufreq: Convert to new X86 CPU match macros
In-Reply-To: <CAHp75VdkvyqOaAsLmz8K2j4bdd0sboPoUpRr6U-zvtkSaQfPRQ@mail.gmail.com>
References: <20200320131345.635023594@linutronix.de> <20200320131509.564059710@linutronix.de> <CAHp75VdkvyqOaAsLmz8K2j4bdd0sboPoUpRr6U-zvtkSaQfPRQ@mail.gmail.com>
Date:   Fri, 20 Mar 2020 21:30:29 +0100
Message-ID: <87eetmpy56.fsf@nanos.tec.linutronix.de>
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
> On Fri, Mar 20, 2020 at 3:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
>> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
>> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
>> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
>
>> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
>> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
>> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
>
>> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
>> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
>> +       X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
>
> Perhaps use names instead of 6 and 15?

Thought about that and did not come up with anyting useful. FAM6 vs. 6
is not really any better

> Also, NULL vs. 0?

Both works, but yes I used mostly NULL.

Thanks,

        tglx
