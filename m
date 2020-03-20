Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1685B18D0C8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCTO3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCTO3P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 10:29:15 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF00C2070A;
        Fri, 20 Mar 2020 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584714554;
        bh=zLmNUAA4P1tSFHHWI4Xam3091wLPGZ+vmX5HjmCwmR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nwAeGaU8qigoXMYurhIrdwIitZrUDneAFgBTrb5mReZswg0PkpXOth9NT3V9N2YFa
         3cy442JJiVUidsTyRkniPmwskvAf7Tk+csvS0wyBNiUBUWP2FBIRcGkfikyQ9ZiDiF
         gTv7OWpZTiM4gB7F67Ku0ksNKQyMRCtGl1eoQa7o=
Date:   Fri, 20 Mar 2020 09:29:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
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
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [patch 02/22] x86/cpu: Add conistent CPU match macros
Message-ID: <20200320142912.GA186731@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320131508.826011988@linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/conistent/consistent/ in subject

On Fri, Mar 20, 2020 at 02:13:47PM +0100, Thomas Gleixner wrote:
> Finding all places which build x86_cpu_id match tables is tedious and the
> logic is hidden in lots of differently named macro wrappers.
> 
> Most of these initializer macros use plain C89 initializers which rely on
> the ordering of the struct members. So new members could only be added at
> the end of the struct, but that's ugly as hell and C99 initializers are
> really the right thing to use.
> 
> Provide a set of macros which:
> 
>   - Have a proper naming scheme, starting with X86_MATCH_
> 
>   - Use C99 initializers
> 
> The set of provided macros are all subsets of the base macro
> 
>     X86_MATCH_VENDOR_FAM_MODEL_FEATURE()
> 
> which allows to supply all possible selection criteria:
> 
>       vendor, family, model, feature
> 
> The other macros shorten this to avoid typing all arguments when they are
> not needed and would require one of the _ANY constants. They have been
> created due to the requirements of the existing usage sites.
> 
> Also a add a few model constants for Centaur CPUs and QUARK.

s/Also a/Also/
