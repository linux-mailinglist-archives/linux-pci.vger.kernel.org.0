Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85F22D1405
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgLGOtw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgLGOtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 09:49:52 -0500
X-Gm-Message-State: AOAM530ecnSqT59fZ5m+k4Nm9KsR+ZG0Jrj5+auErwkbhba9ZRhjgFct
        akDK6gXzTTv2g6JqEaXMOuaOMXnxIZ9YSDVVuxg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607352551;
        bh=/7uV17ZjcWZRBQZBsaxXCvaCcx8EDJrzmSGwZfIHZBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3B5NqZCUFukUOspe1ucdNJwSWpbKS1a3OEv7qGiI+AY5ORP39F5PVuoye/LBPICS
         teTcw177mtPE15AMkM0+fPHaQLBOVJONa6TkjWV9JSWYjPPTGZyrbSrNUT0vbDWHjH
         akxCIblLuwb9qhcZ4zQ7Mz2EUB2+k8sJC3rMQynkNKZbWuCzHaizMsWPnK5SmJBAZl
         9E27x6WEF90tFbsTXEncNltMefT5e5QWoRS766VlwIvl6THvmMjVoaS+4npaAnAU7s
         0bHD4Ce1PZYmbhxZTCdWu+Su3tIQK/g+j8icvylhE4CHe5wZhz3vSCFA+2Pt/kCgYK
         bDfcHgHznI9qQ==
X-Google-Smtp-Source: ABdhPJzazfYYPi5tQ9qZHGKKTiqRYg1UwkAMXPK70lDr0uNGzI5KsYWNMuHafXqRdFME11jw4UVOwQTvauB6kYEvQ1s=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr9525803otm.305.1607352550928;
 Mon, 07 Dec 2020 06:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20201204165841.3845589-1-arnd@kernel.org> <CAL_JsqLCWK99AXzCWXpPsRxA+X5OKsHEGZtBhAsaVFhXoeRb9g@mail.gmail.com>
In-Reply-To: <CAL_JsqLCWK99AXzCWXpPsRxA+X5OKsHEGZtBhAsaVFhXoeRb9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 7 Dec 2020 15:48:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UH1O2kWOkHGAmFQ4Ys7MKBiC2OoDs96Ba4yWSf7vyTg@mail.gmail.com>
Message-ID: <CAK8P3a1UH1O2kWOkHGAmFQ4Ys7MKBiC2OoDs96Ba4yWSf7vyTg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: exynos: add back MSI dependency
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 7, 2020 at 3:23 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 4, 2020 at 10:58 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 020101b58155..e403bb2eeb4c 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -85,6 +85,7 @@ config PCIE_DW_PLAT_EP
> >  config PCI_EXYNOS
> >         tristate "Samsung Exynos PCIe controller"
> >         depends on ARCH_EXYNOS || COMPILE_TEST
> > +       depends on PCI && PCI_MSI_IRQ_DOMAIN
>
> PCI isn't needed here.

Ah right. I had copied this from PCIE_DW_PLAT_HOST, and
I'm fairly sure it used to be needed at some point in the past,
but the Kconfig file has been changed enough over time that
it clearly is not needed any more, as the entire menu depends on
PCI nowadays, i.e. you can no longer have an endpoint-only
configuration.

      Arnd
