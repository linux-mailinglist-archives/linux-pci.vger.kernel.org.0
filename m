Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FA305DA8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 14:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhA0N5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 08:57:25 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38240 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhA0Nz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2021 08:55:59 -0500
Received: by mail-ot1-f41.google.com with SMTP id s2so1711107otp.5;
        Wed, 27 Jan 2021 05:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDZ9IcAY1Ra/HGuPkeM6YM2rGi50xEQXMR0u8HvIMgU=;
        b=bwUqAKhaoFMWjFB2mI1kk+omhPQuZigqgrzgrC9iHppGBfU44a3SsOsKWVJdjjeoLz
         EZmAc/TTQr3IFKKtgkvq1FIf+gSrxTHQ+Ur2D8z+7IA26sjuW0i2YsZWyGOGvU9x5jyS
         lEW0Nl3O2Vx6I+dwFw4JbNCQV7PYC1ABRujpeuZNxO1sqSwz2A9XEdOfrgxqcEMLRzup
         1T4sbUT2n6WIAZnN3ZxFOa+esAt7H9uDojYba/PA8ROGFkDjqEXBqpMIFq2+9/XyYCzY
         PHJNEsKeourGNt4wvOO+NFIosq0LwavNbuFX+vQF9tNH4CnixLRpgIwUuto9vdmT/z8r
         9uyw==
X-Gm-Message-State: AOAM531VTIQAvUIZi92JFXfIRQ9c7aTuVT/5T131Q1K95YUBws2d4l20
        v7JOxxLFklOrfTh+iPtMijGh3pwaT3DzCtkJENo=
X-Google-Smtp-Source: ABdhPJwcHFeUuHnByO/9uC6f/8jLlf6iwx9IE6eWbQKgjbUgK/YxU5fiBYHTruvd2pilvX+5oZgZG4u6BOedoE+4iBk=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr7926135otm.206.1611755719215;
 Wed, 27 Jan 2021 05:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20210126220311.2925565-1-helgaas@kernel.org>
In-Reply-To: <20210126220311.2925565-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 14:55:07 +0100
Message-ID: <CAJZ5v0i_HJzBM1+e3oU4b_y==0hoQJWJ+ZKxLCU5HCdnjdFYqA@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI/ACPI: _OSC cleanups
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 27, 2021 at 1:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Clean up a few _OSC-related things.
>
> We talked about the _OSC failure message in the last patch long ago, and I
> just dropped the ball, sorry about that.  Previous discussion:
> https://lore.kernel.org/linux-pci/20200602223618.GA845676@bjorn-Precision-5520/
>
> I'm happy to merge these given your ack, Rafael, or you can take them if
> they look good to you.

They do look good to me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the whole series.

I don't think it really matters which way they go in and I'm guessing
that it will be somewhat more convenient to you to apply them, so
please route them through the PCI tree.

Cheers!
