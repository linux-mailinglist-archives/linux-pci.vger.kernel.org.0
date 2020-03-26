Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A5193AFC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 09:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCZIeW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 04:34:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:44735 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgCZIeV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:21 -0400
IronPort-SDR: RVr/sKGyhxIMdz6HpIaaMhZpfgGs268wiRdrLx+0F/vTNiomitmxvpQm9rcyLdfPmw+VnHiadS
 Pn7Gy77wADBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 01:34:21 -0700
IronPort-SDR: nly9xD30xpsmGWYFWXpCQfSK56dqJFIPOST3nuhEheHKExNfIQ5XgPc3HXfYowGvGJpdixXyaW
 B8k9bFVtCr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,307,1580803200"; 
   d="scan'208";a="446919804"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2020 01:34:13 -0700
Date:   Thu, 26 Mar 2020 16:33:55 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Subject: Re: [cpufreq] 06c4d00466: will-it-scale.per_process_ops -53.4%
 regression
Message-ID: <20200326083355.GO11705@shao2-debian>
References: <20200320131509.564059710@linutronix.de>
 <20200324060124.GC11705@shao2-debian>
 <CAHp75VeeKZLeZ8E3Py7LECN54SPFHaRgkxrMzBYQWXM8x+4JhA@mail.gmail.com>
 <43a4189a-7153-18e8-4657-4a4400002c05@intel.com>
 <87zhc4ybbt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhc4ybbt.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 25, 2020 at 11:32:06AM +0100, Thomas Gleixner wrote:
> Rong Chen <rong.a.chen@intel.com> writes:
> > On 3/24/20 6:24 PM, Andy Shevchenko wrote:
> >> On Tue, Mar 24, 2020 at 8:02 AM kernel test robot <rong.a.chen@intel.com> wrote:
> >>> Greeting,
> >>>
> >>> FYI, we noticed a -53.4% regression of will-it-scale.per_process_ops due to commit:
> >>> commit: 06c4d00466eb374841bc84c39af19b3161ff6917 ("[patch 09/22] cpufreq: Convert to new X86 CPU match macros")
> >>> url: https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-devicetable-Move-x86-specific-macro-out-of-generic-code/20200321-031729
> >>> base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> >>>
> >>> in testcase: will-it-scale
> >>> on test machine: 4 threads Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz with 8G memory
> >>> with following parameters:
> >>
> >> drivers/cpufreq/speedstep-centrino.c change missed the terminator,
> >> perhaps it's a culprit, because I don't believe removing dups and
> >> reordering lines may affect this.
> >> Can you restore terminator there and re-test?
> >>
> >
> > I have retested with the change, but it has no effect on the performance.
> 
> Bah. The binary equivalence testing detected this, but I obvioulsy
> missed it. Delta fix below.
> 
> Thanks,
> 
>         tglx
> 
> 8<--------------
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2727,7 +2727,7 @@ static inline void intel_pstate_request_
>  
>  #define X86_MATCH_HWP(model, hwp_mode)					\
>  	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
> -					   X86_FEATURE_APERFMPERF, hwp_mode)
> +					   X86_FEATURE_HWP, hwp_mode)
>  
>  static const struct x86_cpu_id hwp_support_ids[] __initconst = {
>  	X86_MATCH_HWP(BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),

Hi Thomas,

The patch can fix the regression:

commit: 
  06c4d00466 ("cpufreq: Convert to new X86 CPU match macros")
  d369f9be1a ("the fix patch")

06c4d00466eb3748  d369f9be1ad1e22da4e8f03557  testcase/testparams/testbox
----------------  --------------------------  ---------------------------
         %stddev      change         %stddev
             \          |                \  
     93200             114%     199599        will-it-scale/performance-process-16-read2-ucode=0x21/lkp-ivb-d02
     93200             114%     199599        GEO-MEAN will-it-scale.per_process_ops

Best Regards,
Rong Chen
