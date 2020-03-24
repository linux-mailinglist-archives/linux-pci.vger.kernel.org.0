Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF711919F0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 20:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgCXTbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 15:31:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:28777 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgCXTbs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 15:31:48 -0400
IronPort-SDR: SWAUlNmxPqaC/IYu6LoO96NdmH/12TO+OZ/Hzyjxpe7vdW+ly/YNvt3TJksHPFI6luqoVC4YNb
 yN7UXgm1Qrqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 12:31:47 -0700
IronPort-SDR: 8/VWxHUZ8NY4RmIqej7yewcPHcwLNpP4scEJKK1G8flVXsWoOafuGEnpmA/GWWQR4A85a5Q5RF
 SBwJJ7+F7kKw==
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; 
   d="scan'208";a="420008785"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 12:31:46 -0700
Date:   Tue, 24 Mar 2020 12:31:44 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        linux-edac@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [patch 10/22] EDAC: Convert to new X86 CPU match macros
Message-ID: <20200324193144.GA4104@agluck-desk2.amr.corp.intel.com>
References: <20200320131345.635023594@linutronix.de>
 <20200320131509.673579000@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320131509.673579000@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 02:13:55PM +0100, Thomas Gleixner wrote:
> The new macro set has a consistent namespace and uses C99 initializers
> instead of the grufty C89 ones.
                 ^^^^^^

grufty? Did you mean crufty?

Though I suppose grufty may work as well here:

	gruft. Noun. (uncountable) (dialect) the particles of soil
	that are spattered up onto grass by the rain.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested the Broadwell EDAC driver. The other changes look
good too.

Acked-by: Tony Luck <tony.luck@intel.com>
