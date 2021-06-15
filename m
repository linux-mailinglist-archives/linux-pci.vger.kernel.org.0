Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6593A8A93
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhFOVHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 17:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOVHS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 17:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB94B613B9;
        Tue, 15 Jun 2021 21:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623791113;
        bh=AT/YWuvp+v63KTyI56swC1rEnVdNJWMoRG4ND7HA4KA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n6tT00FVQznwzOGIIdBYbh/aHJKHZLnZ574HMi7CNf0a93WlZ/tZmtGiet1WLWCxw
         Evbf4kru4No8xMzpBlHEnO7S9+I/NQBLFtTGzDbZewieg7bGo9UcwyUbwPoofs5YYN
         k9cGnYkop+LSx8Dq40IbTe2roBfIXZ6ZWzNhePBuA1HvAsax2fjGTqKOzD8184N6vH
         s2FnEdcI7mPtwRB0+p4NowTlYbMAU5kGl4q6Tz7R6Or6zTjiHIP5a/i5fMnXz13dVp
         DLMzk+lttdt3G2nLSg+8Lv0R5YNmPrg59x0V67uW8iTFU3hjRU18PTM9xnRjfrh5ch
         L/4qQTAAiTclg==
Received: by mail-qv1-f51.google.com with SMTP id l3so484192qvl.0;
        Tue, 15 Jun 2021 14:05:13 -0700 (PDT)
X-Gm-Message-State: AOAM533jPz7BOCkIwX/CKmIkFoWuLRLBWa1q0TexhN+uBAMKXUKBIj37
        NWNXUY6RqZ5Qe/+zPB7wqZ3jYc8ZH0uFf4KZfA==
X-Google-Smtp-Source: ABdhPJxqGIKq/19yHiujzhM/mZ4CCHT4l5CZU9/js7h0X1EYq3fFr5jvC1yrNNhNjStPfF4km4lRf3BEzJIfTAl6fKo=
X-Received: by 2002:a05:6214:1551:: with SMTP id t17mr7322023qvw.50.1623791112917;
 Tue, 15 Jun 2021 14:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <2970bdf2-bef2-bdcb-6ee3-ac1181d97b78@nvidia.com> <20210615194209.GA2908457@bjorn-Precision-5520>
In-Reply-To: <20210615194209.GA2908457@bjorn-Precision-5520>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 15:05:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLSTp+AUw1-83n0mQCLazk-Eb=YQxoJMXB7GQ-hwwu9UQ@mail.gmail.com>
Message-ID: <CAL_JsqLSTp+AUw1-83n0mQCLazk-Eb=YQxoJMXB7GQ-hwwu9UQ@mail.gmail.com>
Subject: Re: Query regarding the use of pcie-designware-plat.c file
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 15, 2021 at 1:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jun 09, 2021 at 05:54:38PM +0100, Jon Hunter wrote:
> >
> > On 09/06/2021 17:30, Bjorn Helgaas wrote:
> > > On Wed, Jun 09, 2021 at 12:52:37AM +0530, Vidya Sagar wrote:
> > >> Hi,
> > >> I would like to know what is the use of pcie-designware-plat.c file. This
> > >> looks like a skeleton file and can't really work with any specific hardware
> > >> as such.
> > >> Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT is
> > >> enabled in a system where a Synopsys DesignWare IP based PCIe controller is
> > >> present and its configuration is enabled (Ex:- Tegra194 system with
> > >> CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen that the probe of
> > >> pcie-designware-plat.c called first (because all DWC based PCIe controller
> > >> nodes have "snps,dw-pcie" compatibility string) and can crash the system.

Linux provides no guarantees of what driver will probe if multiple
match. This has been a known 'problem' forever.

> > > What's the crash?  If a device claims to be compatible with
> > > "snps,dw-pcie" and pcie-designware-plat.c claims to know how to
> > > operate "snps,dw-pcie" devices, it seems like something is wrong.
> > >
> > > "snps,dw-pcie" is a generic device type, so pcie-designware-plat.c
> > > might not know how to operate device-specific details of some of those
> > > devices, but basic functionality should work and it certainly
> > > shouldn't crash.
> >
> > It is not really a crash but a hang when trying to access the hardware
> > before it has been properly initialised.
>
> This doesn't really answer my question.
>
> If the hardware claims to be compatible with "snps,dw-pcie" and a
> driver knows how to operate "snps,dw-pcie" devices, it should work.

I try to tell people that generic compatibles like this are pointless...

> If the hardware requires initialization that is not part of the
> "snps,dw-pcie" programming model, it should not claim to be compatible
> with "snps,dw-pcie".  Or, if pcie-designware-plat.c is missing some
> init that *is* part of the programming model, maybe it needs to be
> enhanced?

The driver will only work on an implementation with no clocks (though
the binding defines clocks), resets, phys, host specific registers or
interrupt muxing. That's practically no one. We could probably enhance
the driver to handle the first 3 if there's not differing sequencing
requirements. If we did this, we'd move the specific compatibles to
the plat driver, not add "snps,dw-pcie" to DT (because internal kernel
refactoring shouldn't require a DT change).

> > The scenario I saw was that if the Tegra194 PCIe driver was built as a
> > module but the pcie-designware-plat.c was built into the kernel, then on
> > boot we would attempt to probe the pcie-designware-plat.c driver because
> > module was not available yet and this would hang. Hence, I removed the
> > "snps,dw-pcie" compatible string for Tegra194 to avoid this and ONLY
> > probe the Tegra194 PCIe driver.
>
> Maybe something like driver_override (I know this is supported via
> sysfs, but maybe not via a kernel parameter) or a module parameter for
> pcie-designware-plat.c to keep it from claiming devices?

We could simply bail probe if "snps,dw-pcie" is not the most specific
compatible. I don't think we have a ready made helper for that, but it
would be just checking "compatible" string index 0 against
"snps,dw-pcie".

> > Sagar is wondering why this hang is only seen/reported for Tegra and
> > could this happen to other platforms? I think that is potentially could.
>
> Maybe pcie-designware-plat.c works on other platforms, i.e., they
> don't require the hardware init?

At least upstream, I don't think there are any. But a lot of platforms
have 'snps,dw-pcie' as a fallback.

Rob
