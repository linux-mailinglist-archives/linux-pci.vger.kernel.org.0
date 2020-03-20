Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45818D0DD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCTOa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbgCTOa4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 10:30:56 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C056820709;
        Fri, 20 Mar 2020 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714655;
        bh=52Xt58OqUaoPzIyx2RiiYnf960SUCTMedb2XAv4lFFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vIX+qQZYLNKPVpyxQxDqiiuzNENPu9X6ZNRTmUVnZeFBLM6jUCmeuzitwjEjGwIkV
         RWxUyRzcqkADZZbPi9wUXZaRSXUlPucFtFtH0KNabzC33j/DZs69E8prKIEUlZZQzi
         o+NGGewctojC0k2ckCEygCX64nx0PWmvmiIzJU1M=
Date:   Fri, 20 Mar 2020 09:30:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [patch 17/22] PCI: intel-mid: Convert to new X86 CPU match macros
Message-ID: <20200320143053.GA187287@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320131510.393113444@linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 02:14:02PM +0100, Thomas Gleixner wrote:
> The new macro set has a consistent namespace and uses C99 initializers
> instead of the grufty C89 ones.
> 
> Get rid the of the local macro wrappers for consistency.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-mid.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/drivers/pci/pci-mid.c
> +++ b/drivers/pci/pci-mid.c
> @@ -55,15 +55,13 @@ static const struct pci_platform_pm_ops
>  	.need_resume	= mid_pci_need_resume,
>  };
>  
> -#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> -
>  /*
>   * This table should be in sync with the one in
>   * arch/x86/platform/intel-mid/pwr.c.
>   */
>  static const struct x86_cpu_id lpss_cpu_ids[] = {
> -	ICPU(INTEL_FAM6_ATOM_SALTWELL_MID),
> -	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
>  	{}
>  };
>  
> 
