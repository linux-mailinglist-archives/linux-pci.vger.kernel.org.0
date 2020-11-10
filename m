Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3B2AD3EC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 11:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgKJKjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 05:39:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40702 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJKju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 05:39:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id m143so13779956oig.7;
        Tue, 10 Nov 2020 02:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLlsEGFO+UNJyfsrDQkvwYBM++LmH/sVJXHnxUOe2bI=;
        b=NcMnBdrL65nIlh3wiaKqYV8yvknAy7rrYbgKcBuBEVCmaOd7Zo0jhiWyj23+23Oopa
         7+vBlbA/ngh2P4inkrrr7SpCZCF6AjffbbgTpmxR+rHCO4lyCIHPg4C5v8vkwQ29tBZz
         zDYR5Cw1qGGPkJ3qiPexMgK0xoNq4ZT38ypPqEF7gibGzA4dB9q6L63Il02h96tWE3x0
         D50vfXR4jrQLZAXHNCVj6RXKJx02QDXj0PubkPf6bDprykLnue9dyeMLMcundAgOsQhU
         T89PROXNRmAdYGlOKUdHZfJdVExwC7BzdHwhnNMEfYJWmIrxtWfJGpLXA+qqHhpGJoK0
         Yr9A==
X-Gm-Message-State: AOAM530nT47Q+RXvVpgtcme1U8gQ4SXexisdGnTdxtBurSZEjaucxoMz
        Z91QnrHns1gtd9x8JHitf9lOCv7zov17l7owjQM=
X-Google-Smtp-Source: ABdhPJwwKwNbQN1n31gBUed38kgWS04gn0L+J3MkMXf4pM/Ttl8CIVudwz/GsuGTgJomiwwMiiUIQ1OR3y+KTv2H2gQ=
X-Received: by 2002:aca:52c9:: with SMTP id g192mr2439496oib.54.1605004788072;
 Tue, 10 Nov 2020 02:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20201003013123.20269-1-david.e.box@linux.intel.com> <20201003013123.20269-3-david.e.box@linux.intel.com>
In-Reply-To: <20201003013123.20269-3-david.e.box@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Nov 2020 11:39:37 +0100
Message-ID: <CAMuHMdXPMNGtnvZKRVofQ7KhuveTadfp+V0Q73YOWkdTgr0aZQ@mail.gmail.com>
Subject: Re: [PATCH V8 2/5] mfd: Intel Platform Monitoring Technology support
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>, andy@infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alexey.budankov@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

On Sat, Oct 3, 2020 at 3:32 AM David E. Box <david.e.box@linux.intel.com> wrote:
> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring facilities. PMT supports
> multiple types of monitoring capabilities. This driver creates platform
> devices for each type so that they may be managed by capability specific
> drivers (to be introduced). Capabilities are discovered using PCIe DVSEC
> ids. Support is included for the 3 current capability types, Telemetry,
> Watcher, and Crashlog. The features are available on new Intel platforms
> starting from Tiger Lake for which support is added. This patch adds
> support for Tiger Lake (TGL), Alder Lake (ADL), and Out-of-Band Management
> Services Module (OOBMSM).
>
> Also add a quirk mechanism for several early hardware differences and bugs.
> For Tiger Lake and Alder Lake, do not support Watcher and Crashlog
> capabilities since they will not be compatible with future product. Also,
> fix use a quirk to fix the discovery table offset.
>
> Co-developed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for your patch, which is now commit 4f8217d5b0ca8ace ("mfd: Intel
Platform Monitoring Technology support") in the mfd/for-mfd-next.

> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -670,6 +670,16 @@ config MFD_INTEL_PMC_BXT
>           Register and P-unit access. In addition this creates devices
>           for iTCO watchdog and telemetry that are part of the PMC.
>
> +config MFD_INTEL_PMT
> +       tristate "Intel Platform Monitoring Technology (PMT) support"
> +       depends on PCI

Does this need a "depend on X86 || COMPILE_TEST", to prevent the
question from showing up on platforms where the PMT cannot be present?

I see the TGL and ADL PCI IDs are also referenced from
drivers/platform/x86/intel_pmt_telemetry.c, which suggests this is X86-only.
Perhaps the OOBMSM is a PCI device that can be used on non-X86 platforms?

> +       select MFD_CORE
> +       help
> +         The Intel Platform Monitoring Technology (PMT) is an interface that
> +         provides access to hardware monitor registers. This driver supports
> +         Telemetry, Watcher, and Crashlog PMT capabilities/devices for
> +         platforms starting from Tiger Lake.
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
