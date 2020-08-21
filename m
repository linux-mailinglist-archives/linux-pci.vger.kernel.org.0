Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C019E24E1E8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgHUUNg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUUNe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 16:13:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB4C061573;
        Fri, 21 Aug 2020 13:13:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598040806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cd01+IYTmMwy+WorGdOB9Ygq1tYc3Vhe72+j6zoROj8=;
        b=d3/WygYO8E18Gdtt35+3GOSK0B3ENJI1vQTg+o0EbaalOkbRSoITg4n4AuLfMZq8cQ/Tjx
        04DGJ7Qmh94/hqzIExQ+bxP9CMHvB+1dkB/qdiSggm+Rl/md+8uLAIQRbC5bO4NgnzEVeN
        sUvYgVJS09dYJylBYpiOB+ffEPv9LGue3vgRVFipZSjCEaJwlXRa6KZAXcmbt823gaQDCl
        WktaAHksNbDyeyxn1D3ohdnsWe+5xyv2TTmIpJJ9GfnRCpAvqAGTuyajQR8sS1GtzzvwQ5
        5OIB58Wsw4LgSk6K3/YEc+gEYgCEKY7vlk0OeKYQOTZRf4xeG6fJMwsn85CRRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598040806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cd01+IYTmMwy+WorGdOB9Ygq1tYc3Vhe72+j6zoROj8=;
        b=TODm4aFRVKSXfRFD/U0SaSllWDlZowJk0CVRFBYDIhwbc0uewEAwlOMiOCq+ZToAR1J9jZ
        K60i51vccu8STCBg==
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] x86/pci: don't set acpi stuff if !CONFIG_ACPI
In-Reply-To: <20200820125320.9967-1-kilobyte@angband.pl>
References: <20200820125320.9967-1-kilobyte@angband.pl>
Date:   Fri, 21 Aug 2020 22:13:25 +0200
Message-ID: <87y2m7rc4a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 20 2020 at 14:53, Adam Borowski wrote:
> Not that x86 without ACPI sees any real use...
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> Found by randconfig builds.
>
>  arch/x86/pci/intel_mid_pci.c | 2 ++
>  arch/x86/pci/xen.c           | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index 00c62115f39c..f14a911f0d06 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -299,8 +299,10 @@ int __init intel_mid_pci_init(void)
>  	pcibios_disable_irq = intel_mid_pci_irq_disable;
>  	pci_root_ops = intel_mid_pci_ops;
>  	pci_soc_mode = 1;
> +#ifdef CONFIG_ACPI
>  	/* Continue with standard init */
>  	acpi_noirq_set();
> +#endif

If CONFIG_ACPI=n then acpi_noirq_set() is an empty stub inline. So I'm
not sure what you are trying to solve here.

Ah, I see with CONFIG_ACPI=n linux/acpi.h does not include asm/acpi.h so
the stubs are unreachable. So that needs to be fixed and not papered
over with #ifdeffery

Thanks,

        tglx
