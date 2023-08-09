Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B9775261
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHIFtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 01:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjHIFtM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 01:49:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F11BF3
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 22:49:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68730bafa6bso389516b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Aug 2023 22:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691560150; x=1692164950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVTaAMwRyC5EbNmGnKMt5GVO62sfdhMkzEYvy7bRsXA=;
        b=pMiFqkbnzjp3jnyPBYTlRVYHWKdOC3du5VSbz4kIkpsKYuFw9hdbPRFTVwZMALrr6e
         SZQa4f+4WZaBbUbb6WuQfpPki/JvBjPp3gjUfPEIXaiLa05X12JMBBOfzjSrRxroNd8E
         U8Edn8SEcynqoXeuGV5OH3SalOEtqtT5FxFqX3SU35gIbEJIMsWiFKFV8NvAmigpo6ZX
         1VFuoHP8/06kb6ySqnq3J06knDAvIozFyfM6zzK+UBFfagPTFrZhAS/6e+TQ40mMrgEV
         TIYNk8nuqoeDiKI9nMVSb8/4cZxnMmXu4gGya+KvDa2cNxeo6xZuYxs2vwpsCYCPIRLF
         DSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691560150; x=1692164950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVTaAMwRyC5EbNmGnKMt5GVO62sfdhMkzEYvy7bRsXA=;
        b=GjrKMS3nOejOtuUil7LM6m7lBQFwNUbTPMNdEaenlsgBvFsVpLyWwNEKE/Bunw3UKP
         lH0nQYALYUWgtHb5XvNcRAi2ri7GRFib3izhlfNtv8xu50+v4aQuNgn04YWtwKwf9Ofe
         EJjQmAEml2Su6+p2lrkOIFwGirzR2HTTbJOL7mHFEaIqyBoaa0Jxy2xh7OXf4J/AI6SG
         1qYQKcm0Ce7irXtMVxTd2cXOckiV6fqbH+6yyh7xL/N8I3Qf17YWn2oFjIsWajf07kUN
         lu94L7cMttc4Sh+Ud5QKLIizl0ZK78PF1B9vVmlVcpVzGUBqvCZnAe8KYcm5qrbER0B+
         klWA==
X-Gm-Message-State: AOJu0YxcJjsR5w3108akj9zzDgE1OMEP50wiCJJ1zz6CUpu5fn7vRXpC
        GZ5g7NuQQkbfBDGsVhZ762Mstg==
X-Google-Smtp-Source: AGHT+IE7jfHYeQCcbaWLiyPRjvliIUWRMsM3DMDq94jcA4CT6KzEh4TL3KUw8Az8khdjGzhK4KpCbw==
X-Received: by 2002:a05:6a20:9147:b0:141:2cb:2954 with SMTP id x7-20020a056a20914700b0014102cb2954mr2498077pzc.3.1691560149975;
        Tue, 08 Aug 2023 22:49:09 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id z21-20020aa791d5000000b006829969e3b0sm9001358pfa.85.2023.08.08.22.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 22:49:09 -0700 (PDT)
Date:   Wed, 9 Aug 2023 11:19:00 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>, Haibo Xu <haibo1.xu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Anup Patel <anup@brainfault.org>, Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v1 12/21] irqchip/riscv-intc: Use swnode framework to
 create fwnode
Message-ID: <ZNMozPV2yU1G9+1z@sunil-laptop>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-13-sunilvl@ventanamicro.com>
 <20230808-chuck-jailhouse-0cb08b55d1bd@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-chuck-jailhouse-0cb08b55d1bd@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 09:31:49AM +0100, Conor Dooley wrote:
> Hey Sunil,
> 
> On Thu, Aug 03, 2023 at 11:29:07PM +0530, Sunil V L wrote:
> > By using swnode framework, all data from ACPI tables can
> > be populated as properties of the swnode. This simplifies
> > the driver code and removes the need for ACPI vs DT checks.
> > Use this framework for RISC-V INTC driver.
> 
> btw, you are permitted to use more than 60 characters in a commit
> message...
> 
Sure.

> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  Documentation/riscv/acpi.rst     | 21 +++++++++++++++
> >  arch/riscv/include/asm/acpi.h    |  1 +
> >  drivers/acpi/riscv/Makefile      |  2 +-
> >  drivers/acpi/riscv/irqchip.c     | 46 ++++++++++++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-intc.c | 12 ++++-----
> >  5 files changed, 75 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/acpi/riscv/irqchip.c
> > 
> > diff --git a/Documentation/riscv/acpi.rst b/Documentation/riscv/acpi.rst
> > index 9870a282815b..e2406546bc16 100644
> > --- a/Documentation/riscv/acpi.rst
> > +++ b/Documentation/riscv/acpi.rst
> > @@ -8,3 +8,24 @@ The ISA string parsing rules for ACPI are defined by `Version ASCIIDOC
> >  Conversion, 12/2022 of the RISC-V specifications, as defined by tag
> >  "riscv-isa-release-1239329-2023-05-23" (commit 1239329
> >  ) <https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-1239329-2023-05-23>`_
> > +
> > +Interrupt Controller Drivers
> > +=======
> > +
> > +ACPI drivers for RISC-V interrupt controllers use software node framework to
> > +create the fwnode for the interrupt controllers. Below properties are
> > +additionally required for some firmware nodes apart from the properties
> > +defined by the device tree bindings for these interrupt controllers. The
> > +properties are created using the data in MADT table.
> 
> I don't really understand this text, specifically what you are getting
> at w/ the dependency on devicetree properties. What exactly does "apart
> from the properties defined by the devicetree bindings" mean?
> 
> Is there prior art for this kind of "ACPI needs swnodes that look
> vaguely similar to devicetree" for other interrupt controllers?
>
Never mind. This will not be required with Marc's feedback.

Thanks,
Sunil 
