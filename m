Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD112C4075
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 13:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgKYMq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 07:46:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYMqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 07:46:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606308384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibGRAofmpl9csf99vMYbZAHCMGSI9TUViH/xR4MjRrw=;
        b=bgZmMtYXBZ31xn7nMCdGVgPuqyvz1QfI2g/2UEvONVPv+o71mXKp/VitDAIRERi++BeKlI
        8KCEMZiNgDFIHfw2jJ9lIKJjlTDZVz7lMeHECAk6IK0bNndcCR471VM4W7DdgNK3W9OtXu
        DJAeC5ude0jLgxaoBd5Lr5wOEIyFrfiqI0RRn2c/2joP2mjPcF5VyALkBrmSn6u1kT//9D
        yQ62+mr2FFyqH3QJsGcOI5i10WYpX0SlVxb/m7yMHlxnhbxPopkBRt4QfXJjA5JTIu8HOL
        A9BfJbxWSknPT58MenHFRqUUmvfa5XlWBme8uX3Cl6TBGa7azx4jvOhGl182zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606308384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibGRAofmpl9csf99vMYbZAHCMGSI9TUViH/xR4MjRrw=;
        b=xMrSwdMxci0rTF1/bkbt9xVPZBPqmu3Tl7I/QMA692+ixO+NPSsE0lPf+cLINk77lsQ6Ay
        x6ttygEAjKMpXRDA==
To:     Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] x86/PCI: Convert force_disable_hpet() to standard quirk
In-Reply-To: <20201119181904.149129-1-helgaas@kernel.org>
References: <20201119181904.149129-1-helgaas@kernel.org>
Date:   Wed, 25 Nov 2020 13:46:23 +0100
Message-ID: <87v9dtk3j4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19 2020 at 12:19, Bjorn Helgaas wrote:
> 62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail
> platform") implemented force_disable_hpet() as a special early quirk.
> These run before the PCI core is initialized and depend on the
> x86/pci/early.c accessors that use I/O ports 0xcf8 and 0xcfc.
>
> But force_disable_hpet() doesn't need to be one of these special early
> quirks.  It merely sets "boot_hpet_disable", which is tested by
> is_hpet_capable(), which is only used by hpet_enable() and hpet_disable().
> hpet_enable() is an fs_initcall(), so it runs after the PCI core is
> initialized.

hpet_enable() is not an fs_initcall(). hpet_late_init() is and that
invokes hpet_enable() only for the case that ACPI did not advertise it
and the force_hpet quirk provided a base address.

But hpet_enable() is also invoked via:

 start_kernel()
   late_time_init()
     x86_late_time_init()
       hpet_time_init()

which is way before the PCI core is available and we really don't want
to set it up there if it's known to be broken :)

Now the more interesting question is why this needs to be a PCI quirk in
the first place. Can't we just disable the HPET based on family/model
quirks?

e0748539e3d5 ("x86/intel: Disable HPET on Intel Ice Lake platforms")
f8edbde885bb ("x86/intel: Disable HPET on Intel Coffee Lake H platforms")
fc5db58539b4 ("x86/quirks: Disable HPET on Intel Coffe Lake platforms")
62187910b0fc ("x86/intel: Add quirk to disable HPET for the Baytrail platform")

I might be missing something here, but in general on anything modern
HPET is mostly useless.

Thanks,

        tglx

