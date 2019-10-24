Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C970EE28FF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 05:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392948AbfJXDpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 23:45:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38005 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392926AbfJXDpM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2019 23:45:12 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so27696558iom.5
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2019 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mD92XtRViE3fuwX27/t4J88Vliq5/m5DxH+E0QdDcfY=;
        b=np4oLXeE8XD06z6WLNxROOXayg/7ADY4dvhHQRnY2EXH3D4wrZ4uvVBzCLMBAl1YKs
         X3kjp8uzPDq4VFJgPdRFGu+FIl4wDfiqtU7w6PZp+88i4oloYYBmdlOIiElf/8JWsI1Z
         Asi6bKnndFHWV2XnQ7GtzdTCxFqXBosXW6SW7BTP4mM/aa8KaGla/jn36tffYO0Wt5WZ
         v07XyDQEpncMj1ATg9d8591dV5+amUkJ8XZE3wwTs15BAh2IP3CMjZNWG3jRNsPU2znN
         nUG3QgiKea3A6gmmbuQUPKoqxBCEyOdOKc4JWkScnPgEO4NAoOElT2mBNY1hnetWB3TF
         uPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mD92XtRViE3fuwX27/t4J88Vliq5/m5DxH+E0QdDcfY=;
        b=VZ+4lh+wSmG0JNJruSDzm8reALQas66CqUbLKNdd849pA+Alkv46x8szSWdLXelE/R
         nArZI+clGno1HhYzsDOaCkGgOESkuVjTYYIY/5JaPiDAvQuPG2mQGfwn0vr6w0hhObcf
         Yn2xzuNsYCVF98abBRJ8/vEXn9EFrpqr2SzGpsbH8eqUKbeRzgSwxKcqIuok9CEHQgTH
         G5ctoAjkmcfbyeEWEtd+31rWzJFr/2U0aH63XZiuQxf+oPhcTWP23nXKDkqXg9Vtkvbe
         TrKegoYIn/eFHmnU+vwrWcw7rnVCZp1HBYJ/K2eA9TNElngqAwP+rVmywNcKkOAdcKP9
         NWig==
X-Gm-Message-State: APjAAAUdqrWwoztZ6TDqLSfeqsvn3XyFYtGyB1oFarwI74uY4kZDXBkq
        fVhe2RyG934bovlPSeXnzqtIE9IUINKXj12Yt9jr4A==
X-Google-Smtp-Source: APXvYqwrUjk8l2F1yVqbPWkm0wkJV8sufdaMmeDVQTVHJSKP7u8y4ic/BWRmmzodfowZBBFsGH12nFuVxyoZKg2IkUo=
X-Received: by 2002:a5d:87ce:: with SMTP id q14mr985334ios.278.1571888711746;
 Wed, 23 Oct 2019 20:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191023192205.97024-1-olof@lixom.net> <20191024023704.GA3152@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191024023704.GA3152@redsun51.ssa.fujisawa.hgst.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 23 Oct 2019 20:45:00 -0700
Message-ID: <CAOesGMjXc1ezF+sC+Nc+VoXScE8kSzy1ZG_iBUBgs5RS4M0y2g@mail.gmail.com>
Subject: Re: [PATCH] PCI/DPC: Add pcie_ports=dpc-native parameter to bring
 back old behavior
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 7:37 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Oct 23, 2019 at 12:22:05PM -0700, Olof Johansson wrote:
> > In commit eed85ff4c0da7 ("PCI/DPC: Enable DPC only if AER is available"),
> > the behavior was changed such that native (kernel) handling of DPC
> > got tied to whether the kernel also handled AER. While this is what
> > the standard recommends, there are BIOSes out there that lack the DPC
> > handling since it was never required in the past.
> >
> > To make DPC still work on said platforms the same way they did before,
> > add a "pcie_ports=dpc-native" kernel parameter that can be passed in
> > if needed, while keeping defaults unchanged.
>
> If platform firmware wants to handle AER events, but the kernel enables
> the DPC capability, the ports will be trapping events that firmware is
> expecting to handle. Not that that's a bad thing: firmware is generally
> worse at handling these errors.

Right, and in particular (and what I'm looking for here): It brings
back the older behavior that some platforms rely on. :-/

> > +/*
> > + * If the user specified "pcie_ports=dpc-native", use the PCIe services
> > + * for DPC, but cuse platform defaults for the others.
>
> s/cuse/use

Thanks

> > @@ -1534,9 +1534,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
> >  #ifdef CONFIG_PCIEPORTBUS
> >  extern bool pcie_ports_disabled;
> >  extern bool pcie_ports_native;
> > +extern bool pcie_ports_dpc_native;
> >  #else
> >  #define pcie_ports_disabled  true
> >  #define pcie_ports_native    false
> > +#define pcie_ports_dpc_native        false
> >  #endif
>
> You do not have any references to pcie_ports_dpc_native outside of files that
> require CONFIG_PCIEPORTBUS, so no need to define a default.

If these are the only comments, maybe Bjorn can fixup when applying.
Bjorn; let me know if you prefer that or if you want a fresh version.
Either is fine with me.


-Olof
