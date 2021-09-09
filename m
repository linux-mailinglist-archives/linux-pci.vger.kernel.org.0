Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B84046C1
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 10:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhIIIJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhIIIJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Sep 2021 04:09:57 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571DFC061575
        for <linux-pci@vger.kernel.org>; Thu,  9 Sep 2021 01:08:46 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id l9so810913vsb.8
        for <linux-pci@vger.kernel.org>; Thu, 09 Sep 2021 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIFDeI9Rh8EjPAbkEUUVwKD10vMCtRtONYrGoLOeOUg=;
        b=LVXxjIML9p+8gC9QwGW7i57lgCpOWMdWr1cnjbrsEyQqQe6b9YAy024LfN6fWvLal2
         5JPGqxyW2ZBPqZci8BP0n8F+WUaV6AKIajebiF4cRdym5Qtl1L/J84fkfqBFhueuh+f9
         YXCz99uJ9FeA+yXRAhLc5aM4VzYPDuDQ+HLdtcxSSsKKG0jzp1kqjzhhwIgm7hFdVeI4
         4ZDvOeiXyQjwJJwup2QYfxvrkTybg7aGZTJTBjtKXEBWnYH8PWcAVNOA2qS1JDx43Vu0
         AR0OsQKkdd15yiyffSub3n733CjtVPBAMQa07XGunp/LlllS7aVTXdNDnuKQChQr7QLy
         UJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIFDeI9Rh8EjPAbkEUUVwKD10vMCtRtONYrGoLOeOUg=;
        b=4pJdQRqJBVhDDH5zxCbFuOmggN4W8y0wf1VOD/yKeT/F/IC02kSUAa3ElegVFV/VW6
         GDxXGWL60/e3bGg3Jjxk+7OdrZdLJD7N0IVqyZ901KEk9QrQWp6HEBsqtrR5P7yvWHBf
         9obEpJ+7A+y2N59J3/I5sC30n65NDXxwe1xwQEoGT25bgBbTmRj5FtviPJFRJWenQ3Jj
         8K/zL8jDFygsdmyHuD9kyXVorSXNpR9xFGLWlEuqFtXJnAAtrUv75M1kH4zGs6pPbAzC
         b6RdJjacJ3HL+zfiGDToNMWp07AXhowaQKW9XrS6UtNH0PjC6ZgLP1OQxVrrh3sQEvaB
         3dzA==
X-Gm-Message-State: AOAM532GthhdF6ZbGwfaaEaLT892eIQmWHwUXKMUIDBkYD+iGPPpKuGe
        fqNCBKXDvGuZXdv1uFzxcEocuW7pT2Tpq68J31aSOg==
X-Google-Smtp-Source: ABdhPJy826L8sK88o0GS9/P1Gse61dnGjPqDnRh8Gklc3UaAojwKh/DgwmrHbDwfnkprXvI343elHwyAX9lNaG+AFpg=
X-Received: by 2002:a67:1c86:: with SMTP id c128mr722331vsc.36.1631174925309;
 Thu, 09 Sep 2021 01:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aJhH1qagpz6qPEYLnO6UMuh_U5uCK3tzdoGJyR9Y73MOmneQ@mail.gmail.com>
 <20210908222422.GA911514@bjorn-Precision-5520>
In-Reply-To: <20210908222422.GA911514@bjorn-Precision-5520>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Thu, 9 Sep 2021 18:08:33 +1000
Message-ID: <CA+aJhH2v2kJ4qgNTNLQuodLuZ1EzK5Caom_=8U82pUZbOKVE4Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 9 Sept 2021 at 08:24, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Alex, beginning of thread:
> https://lore.kernel.org/r/20210903034029.306816-1-nathan@nathanrossi.com]
>
> On Mon, Sep 06, 2021 at 04:01:20PM +1000, Nathan Rossi wrote:
> > On Fri, 3 Sept 2021 at 16:18, Lukas Wunner <lukas@wunner.de> wrote:
> > >
> > > On Fri, Sep 03, 2021 at 03:40:29AM +0000, Nathan Rossi wrote:
> > > > The Pericom PI7C9X2G404 PCIe switch has an errata for ACS P2P Request
> > > > Redirect behaviour when used in the cut-through forwarding mode. The
> > > > recommended work around for this issue is to use the switch in store and
> > > > forward mode.
>
> Is there a URL for this erratum?  What is the issue?  Does the switch

Unfortunately the document is not public, it was provided under a NDA.
However with that said, there is very little additional information in
the document itself compared to the information provided in the commit
message/code comments here. The only other information in the document
that may be applicable is that the whole document is for a number of
Pericom switch models, however I do not have access to the other two
switch models and thus cannot validate if this fixup would also apply
to them.

For reference the models with PCI IDs:
- PI7C9X2G404 - 12d8:2404
- PI7C9X2G304 - 12d8:2304
- PI7C9X2G303 - 12d8:2303

> fail to redirect P2P requests upstream?  How would someone recognize
> that they are affected by it?

Firstly it only affects users if ACS P2P Request Redirect is enabled.
It is quite obvious when the issue is present as devices attached to
the switch will behave poorly. With network devices the observed
effects are drastically inconsistent ping (1ms - 1500ms) and very poor
TCP bandwidth (<1Mbit). With a serial port device, device generated
interrupts are not received causing no data to be received.

>
> > > > This change adds a fixup specific to this switch that when enabling the
> > > > downstream port it checks if it has enabled ACS P2P Request Redirect,
> > > > and if so changes the device (via the upstream port) to use the store
> > > > and forward operating mode.
> > >
> > > From a quick look at the datasheet, this switch seems to support
> > > hot-plug on its Downstream Ports:
> > >
> > > https://www.diodes.com/assets/Datasheets/PI7C9X2G404SL.pdf
> > >
> > > I think your quirk isn't executed if a device is hotplugged to an
> > > initially-empty Downstream Port.
> >
> > The device I am testing against has the ports wired directly to
> > devices (though can be disconnected) without hotplug so I will see if
> > I can find a development board with this switch to test the hotplug
> > behaviour. However it should be noted that the downstream ports are
> > probed with the switch, and are enabled with the ACS P2P Request
> > Redirect configured regardless of the presence of a device connected
> > to the downstream port.
> >
> > > Also, if a device which triggered the quirk is hot-removed and none
> > > of its siblings uses ACS P2P Request Redirect, cut-through forwarding
> > > isn't reinstated.
> >
> > The quirk is enabled on the downstream port of the switch, using the
> > state of the downstream port and not the device attached to it. My
> > understanding is that the only path that enables/disables the ACS P2P
> > Request Redirect on the downstream port is the initial pci_enable_acs.
>
> pci_enable_acs() is called during enumeration of each device
> (including the switch, of course):
>
>   pci_init_capabilities
>     pci_acs_init
>       pci_enable_acs
>
> and your quirk is DECLARE_PCI_FIXUP_ENABLE(), so it runs later, during
> pci_enable_device().  I don't think we ever turn on ACS P2P Request
> Redirect after enumeration.
>
> But we do also call pci_enable_acs() from pci_restore_state(), so this
> happens during resume.  I assume your quirk would also need to run
> then?  Is there a pci_enable_device() somewhere in the resume path
> that will do this?

There is a pci_enable_device path in pci_pm_resume, I initially
thought this would cover this device however that is not called for
pcieport devices as the pcieport driver provides its own pm ops.

I have tested and confirmed that this change will also need
DECLARE_PCI_FIXUP_RESUME in order to apply the fixup on resume. I will
send an updated v2 patch to include that.

Thanks,
Nathan

>
> > This means that devices attached to the downstream port either
> > initially or with hotplugging should not change the ACS configuration
> > of the switches downstream port.
> >
> > Which means nothing can cause the switch to need to be reinstated with
> > cut-through forwarding except the switch itself being hotplugged,
> > which would cause reset of the switch and the enable fixup to be
> > called again.
>
> Seems right to me, since we enable ACS P2P Request Redirect regardless
> of whether any downstream device exists.
>
> > > Perhaps we need additional pci_fixup ELF sections which are used on
> > > hot-add and hot-remove?
> > >
> > > Thanks,
> > >
> > > Lukas
