Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5787F18FA06
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 17:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgCWQis (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 12:38:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:30481 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgCWQis (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 12:38:48 -0400
IronPort-SDR: Rriv0Z8hJsGqsw3IoOkPAtgtiPO6JHB23PHs7p4zPBv+48a/GJlbM73vt8QMk6fMAwnqRW4mjh
 p3JleAiIVMMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 09:38:46 -0700
IronPort-SDR: BNtv86v3w8JwvH4wJojnjAtNBR5zND3RBh/ddNAj1/0KWdAuOS7J1X36McxoHrFDWlrsVZa05+
 xW30ri8rHyMA==
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="269933222"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 09:38:45 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id E3150636B;
        Mon, 23 Mar 2020 16:38:43 +0000 (UTC)
Date:   Mon, 23 Mar 2020 09:38:44 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [patch 08/22] ACPI: Convert to new X86 CPU match macros
Message-ID: <20200323163844.GB123290@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200320131345.635023594@linutronix.de>
 <20200320131509.467730627@linutronix.de>
 <CAHp75VcK3tL0YayjF=CSkSkHiOpg2zOV3rdkXQWJmLZ9fmevpg@mail.gmail.com>
 <87bloqpy1x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bloqpy1x.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 09:32:26PM +0100, Thomas Gleixner wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> 
> > On Fri, Mar 20, 2020 at 3:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> The new macro set has a consistent namespace and uses C99 initializers
> >> instead of the grufty C89 ones.
> >>
> >> Rename the local macro wrapper to X86_MATCH for consistency. It stays for
> >> readability sake.
> >
> >> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,     NULL),
> >> +       X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,        NULL),
> >
> >> -#define ICPU(model)    { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> >> +#define X86_MATCH(model)       X86_MATCH_INTEL_FAM6_MODEL(model, NULL)
> >
> > Maybe we can do a generic macro to avoid all these ', NULL' repetitions?
> 
> I opted for having the data argument everywhere to keep the macro maze
> small. And we have enough places where data is actually used.
+1

--mark

> Thanks,
> 
>         tglx
