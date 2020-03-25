Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3751925A4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 11:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCYKcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 06:32:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47439 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYKcy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2020 06:32:54 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jH3KR-0007j8-0u; Wed, 25 Mar 2020 11:32:07 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 25179100C51; Wed, 25 Mar 2020 11:32:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rong Chen <rong.a.chen@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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
        linux-crypto <linux-crypto@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [cpufreq] 06c4d00466: will-it-scale.per_process_ops -53.4% regression
In-Reply-To: <43a4189a-7153-18e8-4657-4a4400002c05@intel.com>
References: <20200320131509.564059710@linutronix.de> <20200324060124.GC11705@shao2-debian> <CAHp75VeeKZLeZ8E3Py7LECN54SPFHaRgkxrMzBYQWXM8x+4JhA@mail.gmail.com> <43a4189a-7153-18e8-4657-4a4400002c05@intel.com>
Date:   Wed, 25 Mar 2020 11:32:06 +0100
Message-ID: <87zhc4ybbt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> writes:
> On 3/24/20 6:24 PM, Andy Shevchenko wrote:
>> On Tue, Mar 24, 2020 at 8:02 AM kernel test robot <rong.a.chen@intel.com> wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -53.4% regression of will-it-scale.per_process_ops due to commit:
>>> commit: 06c4d00466eb374841bc84c39af19b3161ff6917 ("[patch 09/22] cpufreq: Convert to new X86 CPU match macros")
>>> url: https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-devicetable-Move-x86-specific-macro-out-of-generic-code/20200321-031729
>>> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
>>>
>>> in testcase: will-it-scale
>>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
>>> with following parameters:
>>
>> drivers/cpufreq/speedstep-centrino.c change missed the terminator,
>> perhaps it's a culprit, because I don't believe removing dups and
>> reordering lines may affect this.
>> Can you restore terminator there and re-test?
>>
>
> I have retested with the change, but it has no effect on the performance.

Bah. The binary equivalence testing detected this, but I obvioulsy
missed it. Delta fix below.

Thanks,

        tglx

8<--------------
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2727,7 +2727,7 @@ static inline void intel_pstate_request_
 
 #define X86_MATCH_HWP(model, hwp_mode)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
-					   X86_FEATURE_APERFMPERF, hwp_mode)
+					   X86_FEATURE_HWP, hwp_mode)
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
 	X86_MATCH_HWP(BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),
