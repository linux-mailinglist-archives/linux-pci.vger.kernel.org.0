Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32B2C4813
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 20:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgKYTNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 14:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgKYTNa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 14:13:30 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BBBE204EF;
        Wed, 25 Nov 2020 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606331609;
        bh=FC8/17vFVWvuI6Z/lTpx8ksjxC5pw0ZG4iAAR2bBv1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NZ0H1DV1ZhzRzS1BkpUsELQk4Xd+ASsUXZQdBCesQ8WU5ySsTAWzqZlfKGxBV/iza
         IxfO5pctTNk8Twx81Rag/NSZSNahU4thguMEVwLe2lKXGzROYvtdjOu3IH6mHslmun
         EKvtu69SnQwEgGW4q7SCLF6JaO5Zn/sSAYff01xw=
Date:   Wed, 25 Nov 2020 13:13:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
Message-ID: <20201125191327.GA653914@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 01:46:23PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 19 2020 at 12:19, Bjorn Helgaas wrote:
> > 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail
> > platform") implemented force_disable_hpet() as a special early quirk.
> > These run before the PCI core is initialized and depend on the
> > x86/pci/early.c accessors that use I/O ports 0xcf8 and 0xcfc.
> >
> > But force_disable_hpet() doesn't need to be one of these special early
> > quirks.  It merely sets "boot_hpet_disable", which is tested by
> > is_hpet_capable(), which is only used by hpet_enable() and hpet_disable().
> > hpet_enable() is an fs_initcall(), so it runs after the PCI core is
> > initialized.
> 
> hpet_enable() is not an fs_initcall(). hpet_late_init() is and that
> invokes hpet_enable() only for the case that ACPI did not advertise it
> and the force_hpet quirk provided a base address.
> 
> But hpet_enable() is also invoked via:
> 
>  start_kernel()
>    late_time_init()
>      x86_late_time_init()
>        hpet_time_init()
> 
> which is way before the PCI core is available and we really don't want
> to set it up there if it's known to be broken :)

Wow, I really blew that, don't know how I missed that path.  Thanks
for catching this!  I'll drop this patch.

> Now the more interesting question is why this needs to be a PCI quirk in
> the first place. Can't we just disable the HPET based on family/model
> quirks?

You mean like a CPUID check or something?  I'm all in favor of doing
something that doesn't depend on PCI.

> e0748539e3d5 ("x86/intel: Disable HPET on Intel Ice Lake platforms")
> f8edbde885bb ("x86/intel: Disable HPET on Intel Coffee Lake H platforms")
> fc5db58539b4 ("x86/quirks: Disable HPET on Intel Coffe Lake platforms")
> 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail platform")
> 
> I might be missing something here, but in general on anything modern
> HPET is mostly useless.
> 
> Thanks,
> 
>         tglx
> 
