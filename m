Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0461525595F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgH1La1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgH1LaO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Aug 2020 07:30:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9677BC061234;
        Fri, 28 Aug 2020 04:30:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so326379pgl.3;
        Fri, 28 Aug 2020 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Ir08O/FRZ4qPrZ5PzXvykvoCwYOUG/y2iYaDxVTzSI=;
        b=Get91mXP9levB/OIzEQfD0lst9rr5Zxsw29Fr7y0M3Sa9HNIDACs1PbFiX5qiksnBZ
         KbOt1aeKYYQzUioYPjGqPmydqwt6ptGngS9PutET4a18WIVEjevuOf7krPs9pJFNxBGU
         Ap7GexPIrs1iurY5EdaA0kGp8igP2cLWaNrGFB+zwihaFsBj/eP/8QMKpn7W9kernS13
         sunKpvNVZh11JL4U5zrTTEC/LUgfTo835GiOdCT2cFYCBMn9Y68s56a7x/iWeW8mUkJ+
         NIDYsMFN4Xzb03BSaYCka9LX7rFIvb2cGt4hTA/Got5mlCtNaUgBP1IMHsHJPO5jdajo
         Nz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Ir08O/FRZ4qPrZ5PzXvykvoCwYOUG/y2iYaDxVTzSI=;
        b=pzt58YyEuLDMbSv/GVL6BZJZBfYvCAgpf3TW1yCWkai40eVF6VnPJ2fsTghqAYy0Uj
         tpZk/m0LDSTwT01WE6HS8r2IM2li49X3sLWPUTuzNbMDafTwZZoO7KgHvcMFw+6Y5jMZ
         oe9lxC9ceEu1LDCvL/2qHVGiiB98d9FcnfySr1y1q/45k1zyOQXSoic5m/YvGIbgrzw3
         1P9egPoADBoM06AFi2/JwuXJlwlxDebX0qb8oOz0saxlVAhYIx8+GubkgcO4pmj9kv8M
         t/85UYf0ZCCMZvdnsFvBL7Ly+Sdd4lqKX0TixrPckSPj9J96HG1u8szFX5HWwxrPglfR
         uJng==
X-Gm-Message-State: AOAM530vVluwkR1A/mqI7WWgyaeWOgg1N5zAAhyOiUAiNJBFL2MQN2+P
        OuSOmNXB2UbrbFASQrhNhz6nw3kGW+wQ+JeB0Sg=
X-Google-Smtp-Source: ABdhPJx6G7zzlnVD6DRJQjeDAre9lwctclrWqhYGs5dLxE7oz93YQnJTDSEuwGDVzZIrXDfyHahsrkenT1mbxPgbv4E=
X-Received: by 2002:a62:9215:: with SMTP id o21mr923005pfd.268.1598614211822;
 Fri, 28 Aug 2020 04:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200819180255.11770-1-david.e.box@linux.intel.com> <20200828105655.GU1826686@dell>
In-Reply-To: <20200828105655.GU1826686@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Aug 2020 14:29:54 +0300
Message-ID: <CAHp75VcKrkxuAJvXnLGnHJTkVfac6N0RTH-3OEA5ksV2psWBew@mail.gmail.com>
Subject: Re: [RESEND PATCH V5 0/3] Intel Platform Monitoring Technology
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 28, 2020 at 1:57 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 19 Aug 2020, David E. Box wrote:
>
> [...]
>
> > David E. Box (3):
> >   PCI: Add defines for Designated Vendor-Specific Extended Capability
> >   mfd: Intel Platform Monitoring Technology support
> >   platform/x86: Intel PMT Telemetry capability driver
> >
> >  .../ABI/testing/sysfs-class-pmt_telemetry     |  46 ++
> >  MAINTAINERS                                   |   6 +
> >  drivers/mfd/Kconfig                           |  10 +
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel_pmt.c                       | 220 +++++++++
> >  drivers/platform/x86/Kconfig                  |  10 +
> >  drivers/platform/x86/Makefile                 |   1 +
> >  drivers/platform/x86/intel_pmt_telemetry.c    | 448 ++++++++++++++++++
> >  include/uapi/linux/pci_regs.h                 |   5 +
> >  9 files changed, 747 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_telemetry
> >  create mode 100644 drivers/mfd/intel_pmt.c
> >  create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c
>
> What's the plan for this set?
>
> I'm happy to pick it up and take it through MFD if required.

I guess that was already agreed like this and you were in Cc list of
that discussion.

>
> If that's the route of choice, I'll pick it up in just over a week.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
With Best Regards,
Andy Shevchenko
