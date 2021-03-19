Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC734242E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 19:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhCSSMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhCSSLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 14:11:49 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2660C06174A
        for <linux-pci@vger.kernel.org>; Fri, 19 Mar 2021 11:11:49 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w70so5693344oie.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Mar 2021 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3z4Ip00lYdJc5oGJqkZi/FZJHg9JJdinGpv4fGHlXnw=;
        b=UixOYv8kqZcjzaQfODhZIaIjkiRC8MjI3+jqaUXIxPOE4992q28tK6qKadLqopGvZd
         N27kPwRT+DSqVr+tgh7KWbJZ7Wh7f6ytHrgwoeukn8wD+diDdgLSM1I7vMq+vJKPxUNB
         xgxSOAHpiop/KQQgOBSuYnCodc9jLkXzZThrafS50p3+OMwWGQjkZva2TtN+ECQod3Wc
         p7rP0KlEmiszGtBarclnpYPR6BPz0DpW8ZYJ5iI2OtYNdsNBAEJjMD6t/tiEAoXScL2O
         ybdW5UezcZUeW7b6u8qZwxKIaPEUmoXXTYXJV3/FZeemwV6r0RBp/3unV+RuHuPaT/3Y
         ynBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3z4Ip00lYdJc5oGJqkZi/FZJHg9JJdinGpv4fGHlXnw=;
        b=Jht8GiQLcV8DGEcsUbTYsEjllCfkn3O94tcbR8ITWDmhZHithvGI/4xUSeGPLzf0PY
         JlZXOr6DC6kSiMOx1LcKyf2wK5cbV4bfYOgRdhCpSeCMdcKpGeVRKsVqBHnWlLcfzU7+
         DAhy7+fwEi2yMtuQ6hdn5wjY82TK/w1khrJ/9emRp3yt+mVhnCAzcWZz9e/HZF+QHgdR
         vKV++vDc2yrgqeQbSqhinE0SF0XBrEqMU5nW5WTNZVjVXXQLLoJSYI3q5g4pm5ptivFk
         /dK7VQ7m48rMx1oMZOCt+ez8cSD7kCfz66+K3x5X41vGGD/ivSowbQZydA2WDX1kosVb
         Oh9g==
X-Gm-Message-State: AOAM532GSr3QLejDXpdLBg65gIeOvovH7TZgEP4rhYOn93J5+ZnvpZN0
        wB3jigPPaUbdZy9+UeX2hDndnpSYEBrzkyKGqbU=
X-Google-Smtp-Source: ABdhPJzR86QWoDCxkQPmd3OBmR0ZOm9XTHhyFOBjEE8EgTr803+bjwp5hjJCpgZmhh+gnkoJRo2w5rKGA94slJ2PAVA=
X-Received: by 2002:aca:af10:: with SMTP id y16mr1910455oie.120.1616177509039;
 Fri, 19 Mar 2021 11:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210316192851.286563-1-alexander.deucher@amd.com> <20210318183639.GA158657@bjorn-Precision-5520>
In-Reply-To: <20210318183639.GA158657@bjorn-Precision-5520>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Mar 2021 14:11:38 -0400
Message-ID: <CADnq5_NN=Of+b4N6gUFsLiOuTkEznp8f5aVW4fuJX3sOZpHy5w@mail.gmail.com>
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>, Shyam-sundar.S-k@amd.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        Prike Liang <Prike.Liang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Marcin Bachry <hegel666@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 2:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 03:28:51PM -0400, Alex Deucher wrote:
> > From: Marcin Bachry <hegel666@gmail.com>
> >
> > Renoir needs a similar delay.
>
> See https://lore.kernel.org/linux-pci/20210311125322.GA2122226@bjorn-Precision-5520/
>
> This is becoming a problem.  We shouldn't have to merge a quirk for
> every new device.  Either the devices are defective, and AMD should
> publish errata and have a plan for fixing them, or Linux is broken and
> we should fix that.
>
> There are quite a few mechanisms for controlling delays like this
> (Config Request Retry Status (PCIe r5.0, sec 2.3.1), Readiness
> Notifications (sec 6.23), ACPI _DSM for power-on delays (PCI Firmware
> Spec r3.3)), but most are for *reducing* delay, not for extending it.
>
> Linux supports CRS, but not all the others.  Maybe we're missing
> something we should support?
>
> How do you deal with these issues for Windows?  If it works on Windows
> without quirks, we should be able to make it work on Linux as well.

It works fine in windows.  Unfortunately, it's hard to tell what
windows does exactly since MS supplies the USB driver in that case.
Also, the extended delays are not necessary on our reference
platforms, these seem to only be an issue on some OEM platforms.  I
did confirm with the windows team that we use d3hot for USB on our
current platforms due to bios bugs, but this is fixed on upcoming
platforms.  Still digging for any more details.

>
> > Signed-off-by: Marcin Bachry <hegel666@gmail.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/pci/quirks.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 653660e3ba9e..36e5ec670fae 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -1904,6 +1904,9 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
> > +/* Renoir XHCI requires longer delay when transitioning from D0 to
> > + * D3hot */
>
> No need for "me too" comments that add no additional information.

Will drop that.

Alex

>
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
> >
> >  #ifdef CONFIG_X86_IO_APIC
> >  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> > --
> > 2.30.2
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
