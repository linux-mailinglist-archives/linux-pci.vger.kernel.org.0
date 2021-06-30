Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D583A3B89DA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 22:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhF3Uso (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3Usn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 16:48:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C76C061756;
        Wed, 30 Jun 2021 13:46:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t3so5086232edt.12;
        Wed, 30 Jun 2021 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyOIws1NwRjU5AeOGv92EO33F5wkxRy0F4p5GCbs6FE=;
        b=ALwGJCrSJiGSH1zjPXW3co4uYtKh6dGDqsnqebW8IRN62HIXGubTfsN0DNwZXbmNkK
         43ni97FbrwjtS5rKLaTABF2rekhP9gK+hgUjbMVJWEZcEzEHhQsuVk1VYzUIIBgYZmYn
         CO8V+uNwkv2d4C8xvRSW+QdRWNnVVxP8OuV0rqHWcaQ/NtIN1FEsZyJ9KDYRYFgjmQ6e
         iH0NtT9hUEVzA7cZzKlPrFVDuJmOpfo4t+C0iV0JHLlLx8VbhlMswu7RnyI8Mx/EduGc
         6QEH5KxGETFbMPGtvyptrQr/BK/WOgwK9KF876fTJkxHVODUHt/NcnOSbJsqmyZxGOgU
         gejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyOIws1NwRjU5AeOGv92EO33F5wkxRy0F4p5GCbs6FE=;
        b=TQqH5Mgg6HDjXGPacKjwTUnAc+lDnhN0qNM++j4G6+y/ewIlY2vLU752A7T6l48qp2
         Jt38xI6K6jwmI/YRgPlz2GhUPDlKZPE30G5Bt5YF4KqlZYrBHhFa6nrxZaGlUZ7eG1eD
         LnpTk0opOolNw69BGBjIIseW69BXAXQ9s6y5WVUarFgaDuMlmXYbwFX0Zw+NUlVf4SgH
         0e3/q/L+2IcppMWrDmschmpTydF/YPIPKSP5urG4BNe9usTCLM+MBWkKEufJGCbe4ciS
         pPRqZZHjQsfHMBzgYOmuxaVZkDani7VMLKNqZU0TNiQBHXFHXOZQ8BoPctNskqkjo6nZ
         uSGA==
X-Gm-Message-State: AOAM5324Rb0fi0gW/DXaadBHRzojAGEirSZ7kDvfYeYQ/N58Rwf5Ksr/
        +PrKHVifqDjwIJOVeiCkHjR/dKBFQz63MumKIvc=
X-Google-Smtp-Source: ABdhPJwwnn9NVGiuvvqx8+JFJpK5tsR8/WFhvHyYY8hQw1xjn/WA4R/G+XYCIy6mZn7SpKdR8k07K4CX6l/orEOcK5Y=
X-Received: by 2002:a05:6402:5cc:: with SMTP id n12mr49591923edx.354.1625085973084;
 Wed, 30 Jun 2021 13:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <e7f3bd28-8e5e-362d-11a9-43a60ff79dd2@redhat.com> <20210630203030.GA4178852@bjorn-Precision-5520>
In-Reply-To: <20210630203030.GA4178852@bjorn-Precision-5520>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Wed, 30 Jun 2021 21:46:01 +0100
Message-ID: <CALeDE9P0bNWTDO+4kUt66QOQFbp548Jum_XkGKUQro7_G+YQdA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 30, 2021 at 9:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jun 30, 2021 at 09:59:58PM +0200, Javier Martinez Canillas wrote:
> > On 6/30/21 8:59 PM, Bjorn Helgaas wrote:
> > > [+cc Michal, Jingoo, Thierry, Jonathan]
> >
> > [snip]
> >
> > >
> > > I think the above commit log is perfectly accurate, but all the
> > > details might suggest that this is something specific to rockchip or
> > > CONFIG_DEBUG_SHIRQ, which it isn't, and they might obscure the
> > > fundamental problem, which is actually very simple: we registered IRQ
> > > handlers before we were ready for them to be called.
> > >
> > > I propose the following commit log in the hope that it would help
> > > other driver authors to make similar fixes:
> > >
> > >     PCI: rockchip: Register IRQ handlers after device and data are ready
> > >
> > >     An IRQ handler may be called at any time after it is registered, so
> > >     anything it relies on must be ready before registration.
> > >
> > >     rockchip_pcie_subsys_irq_handler() and rockchip_pcie_client_irq_handler()
> > >     read registers in the PCIe controller, but we registered them before
> > >     turning on clocks to the controller.  If either is called before the clocks
> > >     are turned on, the register reads fail and the machine hangs.
> > >
> > >     Similarly, rockchip_pcie_legacy_int_handler() uses rockchip->irq_domain,
> > >     but we installed it before initializing irq_domain.
> > >
> > >     Register IRQ handlers after their data structures are initialized and
> > >     clocks are enabled.
> > >
> > > If this is inaccurate or omits something important, let me know.  I
> > > can make any updates locally.
> > >
> >
> > I think your description is accurate and agree that the commit message may
> > be misleading. As you said, this is a general problem and the fact that an
> > IRQ is shared and CONFIG_DEBUG_SHIRQ fires a spurious interrupt just make
> > the assumptions in the driver to fall apart.
> >
> > But maybe you can also add a paragraph that mentions the CONFIG_DEBUG_SHIRQ
> > option and shared interrupts? That way, other driver authors could know that
> > by enabling this an underlying problem might be exposed for them to fix.
>
> Good idea, thanks!  I added this; is it something like what you had in
> mind?
>
>     Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ handler when it
>     is being unregistered.  An error during the probe path might cause this
>     unregistration and IRQ handler execution before the device or data
>     structure init has finished.

Would it make sense to enable CONFIG_DEBUG_SHIRQ in defconfig to
better pick up these problems?

Peter
