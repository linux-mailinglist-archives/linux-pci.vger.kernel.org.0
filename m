Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C685042CDA0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhJMWQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 18:16:05 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:44884 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhJMWQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 18:16:04 -0400
Received: by mail-lf1-f50.google.com with SMTP id y26so18189145lfa.11;
        Wed, 13 Oct 2021 15:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhzvudXW7TBy3eiI9ls677r5nxPvZKx6UxcRBg2zP5M=;
        b=n5O6Si+s+Lu953h9xV1LacYHxtPcA20bm6KZEO7nwgJCsrloQvIJKGt0HeLdfkL73A
         LCaOmHNiGJVUK35wWrpkNvOPOa7kmAxxLtKsP7GzjxHA44WSFJvwzbYg1Kw3Xe+oyIvl
         xjm5CGKPAlsCq3h5pN/Sl5sOR6XY9AtlskIKX9hyYxa9IvqrKfdxO5V9OgOkoADuXs7n
         G4XvWpLR7o7uyPazQ+Wq2CppDRaO1Rj0bvFnXR54VBVR46djLgFqMz/e8VnjJ6AOkBo2
         99mdSgFx0B1FH6UZ4Hs9sr7OCCVy4AVpY8VnkCoBnpWEQQj2YIIprsmyKY530xKY32Ix
         Q+SQ==
X-Gm-Message-State: AOAM532jgeXSrEv8Ydk23Jm0J61CgHdq6MrkNiGd6fx1r3v3EQGmeu0S
        sCupaQ7evJrT32XvhyAOUBQ=
X-Google-Smtp-Source: ABdhPJwR53UWXD3XZWJEAjTkJ1ymjQWppGHRZ//U1wUZ9WwC/w23Aq3uhihef5g8OMq5CIkezmcqTg==
X-Received: by 2002:a05:6512:555:: with SMTP id h21mr1482911lfl.408.1634163239781;
        Wed, 13 Oct 2021 15:13:59 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id t18sm57656lfl.289.2021.10.13.15.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:13:59 -0700 (PDT)
Date:   Thu, 14 Oct 2021 00:13:57 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Benoit =?utf-8?B?R3LDqWdvaXJl?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v2] x86/PCI: Ignore E820 reservations for bridge windows
 on newer systems
Message-ID: <YWdaJVhoPDrg3Tsd@rocinante>
References: <20211011090531.244762-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211011090531.244762-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hans,

Thank you for sending the patch over!

[...]
> [    0.000000] BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> [    0.557473] pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]

A very small nitpick: we usually remove time/date stamps from kernel ring
buffer outputs keeping only the relevant message parts left.

[...]
> Old systems are defined here as BIOS year < 2018, this was chosen to
> make sure that pci_use_e820 will not be set on the currently affected
> systems, while at the same time also taking into account that the
> systems for which the E820 checking was orignally added may have

A tiny typo of "originally" in the sentence above.

[...]
> @@ -232,3 +236,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
>  # define x86_default_pci_init_irq	NULL
>  # define x86_default_pci_fixup_irqs	NULL
>  #endif
> +
> +#if defined CONFIG_PCI && defined CONFIG_ACPI

I know that Mika already asked about this, and you responded, so I can only
added: brackets, let's add brackets, most definitely. :)

[...]
> +/* Consumed in arch/x86/kernel/resource.c */
> +bool pci_use_e820 = false;

A small nitpick: not sure if this comment is needed as probably most people
working with this code would use "git grep" and likes to list occurrences
where the variables is used.  But, this is highly subjective, thus there is
probably nothing to change here.

> +	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> +	       pci_use_e820 ? "Honoring" : "Ignoring");

I know you followed the existing style, which is very much appreciated, but
if and where possible, we should move to newer API/style and replace the
printk() above with pr_info().  New code should not be adding old style if
it can be helped (checkpatch.pl would warn about this too).  What do yo you
think?

	Krzysztof
