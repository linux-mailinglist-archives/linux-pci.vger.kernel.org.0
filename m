Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC11914EC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 16:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgCXPiu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 11:38:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:39337 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgCXPit (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 11:38:49 -0400
IronPort-SDR: BEFFkdBFxk7mRHJWpm9/RHq3IgnTmzEXOBWsUrH6m8vuJAnWduQl+Zg4o4BMZ5/r5DzjqYcVmW
 I0MuydOxiWPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:38:48 -0700
IronPort-SDR: OH9LOnbiL4v4JZEOKEB/asPk1R/gzlJCOgYYDD8Y/4+mtRjZPj4rORMZ9Y6HhOwPh9gE+I4cRC
 Soiz8Ghm/JHg==
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="238262386"
Received: from spandruv-mobl.amr.corp.intel.com ([10.134.90.138])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:38:47 -0700
Message-ID: <406e39aa9890d4d518a2259b539858d82f4d6e18.camel@linux.intel.com>
Subject: Re: [cpufreq] 06c4d00466: will-it-scale.per_process_ops -53.4%
 regression
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
Date:   Tue, 24 Mar 2020 08:38:46 -0700
In-Reply-To: <CAHp75VeeKZLeZ8E3Py7LECN54SPFHaRgkxrMzBYQWXM8x+4JhA@mail.gmail.com>
References: <20200320131509.564059710@linutronix.de>
         <20200324060124.GC11705@shao2-debian>
         <CAHp75VeeKZLeZ8E3Py7LECN54SPFHaRgkxrMzBYQWXM8x+4JhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-03-24 at 12:24 +0200, Andy Shevchenko wrote:
> On Tue, Mar 24, 2020 at 8:02 AM kernel test robot <
> rong.a.chen@intel.com> wrote:
> > Greeting,
> > 
> > FYI, we noticed a -53.4% regression of will-it-
> > scale.per_process_ops due to commit:
> > commit: 06c4d00466eb374841bc84c39af19b3161ff6917 ("[patch 09/22]
> > cpufreq: Convert to new X86 CPU match macros")
> > url: 
> > https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-devicetable-Move-x86-specific-macro-out-of-generic-code/20200321-031729
> > base: 
> > https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
> > linux-next
> > 
> > in testcase: will-it-scale
> > on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz
> > with 8G memory
> > with following parameters:
> 
> drivers/cpufreq/speedstep-centrino.c change missed the terminator,
> perhaps it's a culprit, because I don't believe removing dups and
> reordering lines may affect this.
> Can you restore terminator there and re-test?

This is a Ivy Bridge. So if it has to do anything cpufreq then it is
not loading the cpufreq driver (intel_pstate or acpi_cpufreq).
What is
 cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor


> 

