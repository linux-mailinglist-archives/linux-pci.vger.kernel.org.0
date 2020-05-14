Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0E1D3051
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgENMu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 08:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgENMu4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 08:50:56 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA6820727
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2020 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589460655;
        bh=iKLgjmz5pkacXEaepXpdtH2UAIhEM0ikY1BH7yv/wW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m4IGGqCq/CA+nwMZQ1j57C81H3lnxPwmBcUwFu8f/GITt6Jc5C1+xAn808VhZnusg
         2YM9TX0KBWZEVdCiW1p3OUkc1dZXMCZUYcQSAroFx8qKkux4PLkLOCz7+y/iIb/Mb4
         kV2B2eKo9xJ7POgKvqwp4e6hovZXzKDagaSfMgas=
Received: by mail-oi1-f171.google.com with SMTP id j145so2583418oib.5
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2020 05:50:55 -0700 (PDT)
X-Gm-Message-State: AGi0Pub/8gYbrqjD8U3xcOqRcrDRBOspp4NHLtar/awoir1SVF2AF2Bo
        RA8W76oZG4bXIYtAw70hxrU0s50Qn1PfupXLsQ==
X-Google-Smtp-Source: APiQypLyZ7aMlibTpz5tnoJ2Hjilzr1pnZp/A4rOA9oqX7KZlczCyxrUMW62hxaejBo+u2dRsp5iWKmOLeDutggDN/s=
X-Received: by 2002:aca:1904:: with SMTP id l4mr31078321oii.106.1589460654863;
 Thu, 14 May 2020 05:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200513223859.11295-1-robh@kernel.org> <20200513223859.11295-2-robh@kernel.org>
 <20200514103028.GA16121@red-moon.cambridge.arm.com>
In-Reply-To: <20200514103028.GA16121@red-moon.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 May 2020 07:50:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLC0MBgCxGmoGj7+JZec9ZWaBU5_BQibY9-nO35Jm+VcA@mail.gmail.com>
Message-ID: <CAL_JsqLC0MBgCxGmoGj7+JZec9ZWaBU5_BQibY9-nO35Jm+VcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Fix pci_host_bridge struct device release/free handling
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 5:30 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, May 13, 2020 at 05:38:59PM -0500, Rob Herring wrote:
> > The PCI code has several paths where the struct pci_host_bridge is freed
> > directly. This is wrong because it contains a struct device which is
> > refcounted and should be freed using put_device(). This can result in
> > use-after-free errors. I think this problem has existed since 2012 with
> > commit 7b5436635800 ("PCI: add generic device into pci_host_bridge
> > struct"). It generally hasn't mattered as most host bridge drivers are
> > still built-in and can't unbind.
> >
> > The problem is a struct device should never be freed directly once
> > device_initialize() is called and a ref is held, but that doesn't happen
> > until pci_register_host_bridge(). There's then a window between
> > allocating the host bridge and pci_register_host_bridge() where kfree
> > should be used. This is fragile and requires callers to do the right
> > thing. To fix this, we need to split device_register() into
> > device_initialize() and device_add() calls, so that the host bridge
> > struct is always freed by using a put_device().
> >
> > devm_pci_alloc_host_bridge() is using devm_kzalloc() to allocate struct
> > pci_host_bridge which will be freed directly. Instead, we can use a
> > custom devres action to call put_device().
> >
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/probe.c  | 36 +++++++++++++++++++-----------------
> >  drivers/pci/remove.c |  2 +-
> >  2 files changed, 20 insertions(+), 18 deletions(-)

[...]

> > @@ -908,7 +910,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >       if (err)
> >               goto free;
> >
> > -     err = device_register(&bridge->dev);
> > +     err = device_add(&bridge->dev);
> >       if (err) {
> >               put_device(&bridge->dev);
> >               goto free;
> > @@ -978,7 +980,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >
> >  unregister:
> >       put_device(&bridge->dev);
> > -     device_unregister(&bridge->dev);
> > +     device_del(&bridge->dev);
>
> I think we need to execute device_del() first, then put_device().

No, because after the device_add, there's a get_device() adding the
bridge ptr to the bus. So the put_device here is for that. The final
put_device() is in the bridge free or devm action.

Rob
