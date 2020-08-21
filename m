Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1EE24E21B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHUUcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 16:32:50 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B1C061573;
        Fri, 21 Aug 2020 13:32:50 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1k9DiC-0000s1-NO; Fri, 21 Aug 2020 22:32:32 +0200
Date:   Fri, 21 Aug 2020 22:32:32 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] x86/pci: don't set acpi stuff if !CONFIG_ACPI
Message-ID: <20200821203232.GA2187@angband.pl>
References: <20200820125320.9967-1-kilobyte@angband.pl>
 <87y2m7rc4a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2m7rc4a.fsf@nanos.tec.linutronix.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 10:13:25PM +0200, Thomas Gleixner wrote:
> On Thu, Aug 20 2020 at 14:53, Adam Borowski wrote:
> > Found by randconfig builds.
> >
> >  arch/x86/pci/intel_mid_pci.c | 2 ++
> >  arch/x86/pci/xen.c           | 2 ++

> > --- a/arch/x86/pci/intel_mid_pci.c
> > +++ b/arch/x86/pci/intel_mid_pci.c
> > @@ -299,8 +299,10 @@ int __init intel_mid_pci_init(void)
> > +#ifdef CONFIG_ACPI
> >  	/* Continue with standard init */
> >  	acpi_noirq_set();
> > +#endif

> If CONFIG_ACPI=n then acpi_noirq_set() is an empty stub inline. So I'm
> not sure what you are trying to solve here.
> 
> Ah, I see with CONFIG_ACPI=n linux/acpi.h does not include asm/acpi.h so
> the stubs are unreachable. So that needs to be fixed and not papered
> over with #ifdeffery

If I understand Randy Dunlap correctly, he already sent a pair of patches
that do what you want.


Meow.
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋⠀ It's time to migrate your Imaginary Protocol from version 4i to 6i.
⠈⠳⣄⠀⠀⠀⠀
