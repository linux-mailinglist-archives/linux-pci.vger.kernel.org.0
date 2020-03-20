Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9196318D230
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 15:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgCTO7Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 10:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCTO7P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 10:59:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99F7A2072D;
        Fri, 20 Mar 2020 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584716354;
        bh=Hd3zAvAezuFSVlozOz44ullhVT1eSajSxemMLbZxlBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ff33wKiw1HbXy93zCGoh1lWvVOk00lgxJdeoknvNzKnVdJSPvefa0ML3LysbJ4nTO
         6rAp6ASm4qt4uUIq2mtTpgvdRMDHrrSeBb59UaWhHjcJKEKHYeRpe3xmrMj7LtAtPD
         nmjVJ+xUohzhMq/MhLV3uoj+bRi4FVjkP6UigI8o=
Date:   Fri, 20 Mar 2020 15:59:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [patch 00/22] x86/treewide: Consolidate CPU match macro maze and
 get rid of C89 (sic!) initializers
Message-ID: <20200320145906.GA762057@kroah.com>
References: <20200320131345.635023594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320131345.635023594@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 02:13:45PM +0100, Thomas Gleixner wrote:
> The x86 CPU matching based on struct x86_cpu_id:
> 
>   - is using an inconsistent macro mess with pointlessly duplicated and
>     slightly different local macros. Finding the places is an art as there
>     is no consistent name space at all.
> 
>   - is still mostly based on C89 struct initializers which rely on the
>     ordering of the struct members. That's proliferated forever as every
>     new driver just copies the mess from some exising one.
> 
> A recent offlist conversation about adding more match criteria to the CPU
> matching logic instead of creating yet another set of horrors, reminded me
> of a pile of scripts and patches which I hacked on a few years ago when I
> tried to add something to struct x86_cpu_id.
> 
> That stuff was finally not needed and ended up in my ever growing todo list
> and collected dust and cobwebs, but (un)surprisingly enough most of it
> still worked out of the box. The copy & paste machinery still works as it
> did years ago.
> 
> There are a few places which needed extra care due to new creative macros,
> new check combinations etc. and surprisingly ONE open coded proper C99
> initializer.
> 
> It was reasonably simple to make it at least compile and pass a quick
> binary equivalence check.
> 
> The result is a X86_MATCH prefix based set of macros which are reflecting
> the needs of the usage sites and shorten the base macro which takes all
> possible parameters (vendor, family, model, feature, data) and uses proper
> C99 initializers.
> 
> So extensions of the match logic are trivial after that.
> 
> The patch set is against Linus tree and has trivial conflicts against
> linux-next.
> 
> The diffstat is:
>  71 files changed, 525 insertions(+), 472 deletions(-)
> 
> but the extra lines are pretty much kernel-doc documentation which I added
> to each of the new macros. The usage sites diffstat is:
> 
>  70 files changed, 393 insertions(+), 471 deletions(-)
> 
> Thoughts?

Much nicer looking, thanks for cleaning up this mess:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
