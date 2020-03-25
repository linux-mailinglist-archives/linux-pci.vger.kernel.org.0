Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83A1921FA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 08:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgCYHwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 03:52:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:26691 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgCYHwS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 03:52:18 -0400
IronPort-SDR: DPrxQQjSBTJXYiJjGylkrM46xCXQG3APSU3hzHFa8EDSHn/KZehkgSuO10A227vECG/2tFcEr5
 cIwi6wZcJdQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 00:52:16 -0700
IronPort-SDR: b9NUigpcjzSgCWaJzS+gAC7SOJZvwROrkN35wifXdCKcc5seuVeFG1rItyM9IeW7XizSaBR4xH
 sow6ixJ9UXcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="238457732"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2020 00:52:05 -0700
Subject: Re: [cpufreq] 06c4d00466: will-it-scale.per_process_ops -53.4%
 regression
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20200320131509.564059710@linutronix.de>
 <20200324060124.GC11705@shao2-debian>
 <CAHp75VeeKZLeZ8E3Py7LECN54SPFHaRgkxrMzBYQWXM8x+4JhA@mail.gmail.com>
 <406e39aa9890d4d518a2259b539858d82f4d6e18.camel@linux.intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <6f3067fd-5f2e-20f5-ca75-3e43d61c97b7@intel.com>
Date:   Wed, 25 Mar 2020 15:51:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <406e39aa9890d4d518a2259b539858d82f4d6e18.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/24/20 11:38 PM, Srinivas Pandruvada wrote:
> On Tue, 2020-03-24 at 12:24 +0200, Andy Shevchenko wrote:
>> On Tue, Mar 24, 2020 at 8:02 AM kernel test robot <
>> rong.a.chen@intel.com> wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a -53.4% regression of will-it-
>>> scale.per_process_ops due to commit:
>>> commit: 06c4d00466eb374841bc84c39af19b3161ff6917 ("[patch 09/22]
>>> cpufreq: Convert to new X86 CPU match macros")
>>> url:
>>> https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-devicetable-Move-x86-specific-macro-out-of-generic-code/20200321-031729
>>> base:
>>> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git
>>> linux-next
>>>
>>> in testcase: will-it-scale
>>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz
>>> with 8G memory
>>> with following parameters:
>> drivers/cpufreq/speedstep-centrino.c change missed the terminator,
>> perhaps it's a culprit, because I don't believe removing dups and
>> reordering lines may affect this.
>> Can you restore terminator there and re-test?
> This is a Ivy Bridge. So if it has to do anything cpufreq then it is
> not loading the cpufreq driver (intel_pstate or acpi_cpufreq).
> What is
>   cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
