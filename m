Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD67D9903
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 14:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbjJ0MzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 08:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0MzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 08:55:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D836128
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 05:55:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b20a48522fso2007686b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698411314; x=1699016114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtR5YHlVvuHvzI/nsFjHhzkEP3xQ5iNgT/02AgGSWcY=;
        b=eaaagx6NDkfQFgJo9sUQQmAQNfajIGMpoXKob72Poy79+Ux5Ksmp1ACsWi5q04olmg
         4H6DQtFNdYdYKNljv++MNGOgGL7lntA58GKdrN3WI+AIz5EIn8VQ+WGhNWmlUG2Y+OlJ
         qK8lfyKbpgYWvNVXCceHQ311fa9K/4So1K0Olvdxx8hzecyqNjh6YO7HJ62LXKubO9xb
         GyTLR8h5sArH7U81tKasS0PdncPEiOkMnWyUsrT36i60PN1EDQO6tySOVTw3va7JvRn/
         GtgXG2YtFEhYLmbS56xu4hdctI3FLs9PO8DZdp8nEzmqkHQB36NAxYG7xNgj4hWK8AKF
         7U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411314; x=1699016114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtR5YHlVvuHvzI/nsFjHhzkEP3xQ5iNgT/02AgGSWcY=;
        b=X2INBAVo4txPfCaRRG5idHF7MLcjAso4j+2I5znRbpzqpMwH3NR1oK7cWtIqlGmFKb
         1uVXgQs/qp9aa1+93InkJDHIC5F4wrrOWZX7FUbtgSee5sCoiUToVExX5YACAdu+nzCi
         w/GJkuvTiaF0rhzDTXwCBK7EgQot1azpWwy/f4JbmtWlZEpB3ketXn68/UFEC/QERiS3
         RqmXNkvx5ikI6UEFqEPrfZgZaMOqXk99CuXRe2WXi2/RQJrC09p1ZzDu+ZGTRvezopW5
         MlWfbjnEbL3mBhsCLy82A869FHJ04CVTaxd53Y/2Ic7Iz1LW1QeBs2N16smU5D4xj9R7
         5DCA==
X-Gm-Message-State: AOJu0YxLWGD3S+JF20FaTKNlptNNemB3vmHeR15GK5PKHUgDR6BxmHV8
        kMykAn/hs39M/ADi+axFN9POiQ==
X-Google-Smtp-Source: AGHT+IFhOP7YUnwDjtkHfZaRuwApUBuBpo87R1Ao7f/FkzvpRDYjh5UpMDOWwDtBZTINnRMBGE38uw==
X-Received: by 2002:a05:6a21:a5a8:b0:174:129d:3978 with SMTP id gd40-20020a056a21a5a800b00174129d3978mr3501864pzc.32.1698411313970;
        Fri, 27 Oct 2023 05:55:13 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id bu22-20020a632956000000b00528db73ed70sm1053268pgb.3.2023.10.27.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:55:13 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:25:03 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 06/21] RISC-V: Kconfig: Select deferred GSI probe
 for ACPI systems
Message-ID: <ZTuzJ1nsicZYp+uh@sunil-laptop>
References: <20231025202344.581132-7-sunilvl@ventanamicro.com>
 <20231026170408.GA1825378@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026170408.GA1825378@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 12:04:08PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 26, 2023 at 01:53:29AM +0530, Sunil V L wrote:
> > On RISC-V platforms, apart from root interrupt controllers (which
> > provide local interrupts and IPI), other interrupt controllers in the
> > hierarchy are probed late. Enable this select this CONFIG option for
> > RISC-V platforms so that device drivers which connect to deferred
> > interrupt controllers can take appropriate action.
> 
> Quite a bit of this series seems related to the question of interrupt
> controllers being probed "late".
> 
> I don't see anything specific about *how* late this might be, but from
> the use of -EPROBE_DEFER in individual drivers (8250_pnp explicitly,
> and acpi_register_gsi() and pnp_irq() and acpi_pci_irq_enable(), which
> are called from driver .probe() paths) it seems like interrupt
> controllers might be detected even after devices that use them.
> 
> That seems like a fairly invasive change to the driver probe flow.
> If we really need to do that, I think it might merit a little more
> background as justification since we haven't had to do it for any
> other arch yet.
> 

Hi Bjorn,

In RISC-V, the APLIC can be a converter from wired (GSI) to MSI interrupts.
Hence, especially in this mode, it has to be a platform device to use
device MSI domain. Also, according to Marc Zyngier there is no reason to
probe interrupt controllers early apart from root controller. So, the
device drivers which use wired interrupts need to be probed after APLIC.

The PNP devices and PCI INTx GSI links use either
acpi_dev_resource_interrupt() (PNP) or acpi_register_gsi() directly
(PCI). The approach taken here is to follow the example of
acpi_irq_get() which is enhanced to return EPROBE_DEFER and several
platform device drivers which use platform_get_irq() seem to be handling
this already.

Using ResourceSource dependency (mbigen uses) in the namespace as part of
Extended Interrupt Descriptor will not ensure the order since PNP/INTx
GSI devices don't work with that.

Is there any other better way to create dependency between IO devices
and the interrupt controllers when interrupt controller itself is a
platform device? While using core_initcall() for interrupt controllers
seem to work which forces the interrupt controller to be probed first,
Marc is not in favor of that approach since it is fragile.

Thanks a lot for your help with review and feedback!

Sunil

