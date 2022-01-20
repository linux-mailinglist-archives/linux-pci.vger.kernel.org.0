Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B7E495109
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 16:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376410AbiATPIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiATPIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 10:08:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F41C061574;
        Thu, 20 Jan 2022 07:08:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so7246297wms.0;
        Thu, 20 Jan 2022 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ddPVCxZ4dU5YjdeoeIUkKx7PGG9W/fGI0TtRqbFtTuw=;
        b=H6c4pby5QH1o8S7IPDYhT0iMNADpq3fH9CJ1YFaBUTbth7CK+XT0K1kj/KxEW3svMz
         qgPSkkw0v5ifu7wiTZ5ueesuwmt13mkAyXAHkbUvi5ZKfVSsMWLuc2Swh1ZByGg8Cwgs
         JCgHJ/p6N0it6jnvmy+yz+X9GiRJHqUyok4tcJwB1VTHCQ0wnhTroDypB1uqiwBLNjKo
         vLCmGDNpepIE/C0qTpl46MLnWh0+aWCljk+Umg70LvdYmUUHwHO/XvXINwEWnlXSlDnF
         NHmU9EwfPYCHUxAD5LD6QBcp0IM8253CUgv7gWuYyanHdMTY0yzw9xKdC9DHUQqu2N+H
         VsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ddPVCxZ4dU5YjdeoeIUkKx7PGG9W/fGI0TtRqbFtTuw=;
        b=iVpLMaGJZaR7e5Oi3gDcwRTdIJLBBXWr3252t7Ynviausn5dSiOBJJPxECZLNpe4HW
         MUwS+kaoZQgT06U+L76t76UVlYIJQutAoIsfZCxSo2eR2MCpMzBdGAwSEJBYA9dmBu8e
         q3WVf6/Mebcgdgzfw2PvjrosS9PNh4AkT4ymdAL58WPMBE2mXZxXyz83hkVPmmhGsRPK
         qEshXwkRqRTfuY+lPU0PtFIZMpR/2XBeQNPCLZH5KNBlr027rH6Vn784GvTboiy1O/5M
         Qbvq91gJdPx0xC29XDHPcMIY6+Rv0ol5Egh5/25RqP5ahxqLWBoowz/gEl6EdfUXLz+l
         dIew==
X-Gm-Message-State: AOAM532WFhyd018Ao/IaaXdooLbBgwXXjHxhmqxq2FOVvRm1jgpuqRkY
        vkNij/adjWODgxEAZ1Cm3Xae95Z20EpSarktVjG8Uc0CYho=
X-Google-Smtp-Source: ABdhPJycTIloH80MYHJgoCdcMS3sJYfpzZW6RfgpOkcOdf2Mub026i47AWJ9yyadXN1Q0Bwely+PGyslLzS6SnFiRN8=
X-Received: by 2002:a7b:c310:: with SMTP id k16mr9289871wmj.169.1642691296273;
 Thu, 20 Jan 2022 07:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20220120000409.2706549-1-rajatja@google.com> <CAE_wzQ_XxONXx5bgDNLAWM_UbV0r8hP9fW6s5sgRYRVSHQWjLw@mail.gmail.com>
In-Reply-To: <CAE_wzQ_XxONXx5bgDNLAWM_UbV0r8hP9fW6s5sgRYRVSHQWjLw@mail.gmail.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Thu, 20 Jan 2022 07:08:06 -0800
Message-ID: <CAA93t1pOi9mz9he41E+S+sb7F=0ptaWG4hmi+Nuac=7FXEBi7Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dmitry, Bjorn,

Thanks for your review and comments.

On Wed, Jan 19, 2022 at 6:25 PM Dmitry Torokhov <dtor@google.com> wrote:
>
> Hi Rajat,
>
> On Wed, Jan 19, 2022 at 4:04 PM Rajat Jain <rajatja@google.com> wrote:
> >
> > Today the pci_dev->untrusted is set for any devices sitting downstream
> > an external facing port (determined via "ExternalFacingPort" property).
> > This however, disallows any internal devices to be marked as untrusted.
> >
> > There are use-cases though, where a platform would like to treat an
> > internal device as untrusted (perhaps because it runs untrusted
> > firmware, or offers an attack surface by handling untrusted network
> > data etc).
> >
> > This patch introduces a new "UntrustedDevice" property that can be used
> > by the firmware to mark any device as untrusted.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/pci/pci-acpi.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..3d9e5fa49451 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1350,12 +1350,25 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
> >                 dev->external_facing = 1;
> >  }
> >
> > +static void pci_acpi_set_untrusted(struct pci_dev *dev)
> > +{
> > +       u8 val;
> > +
> > +       if (device_property_read_u8(&dev->dev, "UntrustedDevice", &val))
> > +               return;
> > +
> > +       /* These PCI devices are not trustworthy */
> > +       if (val)
> > +               dev->untrusted = 1;
>
> Should this all be replaced with:
>
> dev->untrusted = device_property_read_bool(&dev->dev, "UntrustedDevice");
>
> ?

Ack, yes, I will do this.

>
> Also, is this ACPI-specific? Why won't we need this for DT systems (or
> do we already have this)?.

Good point. Ack, Yes, I don't mind doing this for DT systems also. I
wanted to get some feedback and acceptance within the PCI subsystem on
the general idea of this property though. Bjorn?

Thanks & Best Regards,

Rajat

>
> Thanks,
> Dmitry
