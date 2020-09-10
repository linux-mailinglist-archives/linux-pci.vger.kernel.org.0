Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE7265457
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIJVms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgIJM5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 08:57:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D70C0613ED
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2020 05:57:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so5559044wmj.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2020 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cwhB3RGzoBlvRzynnFlBgssHA0WGX2a2ejRWpX5sFc=;
        b=N6Gl71r6ia+IrzI4M5tNejZlUU0SLCWSC/QFDo9xjzPDGIbavTAb4mHBV+vqc/OCW6
         nMbQhI/XJyvwiabjMcp0L0A85fZn8kS7YcyC50vlgsSok+5n0D36G9quVjb0XbldHeDH
         RRB98iIUPKZa/gfmPIlb6JBbkPoDNrfEewoBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cwhB3RGzoBlvRzynnFlBgssHA0WGX2a2ejRWpX5sFc=;
        b=VWhqKi1WGwL1YLEnFC6BMzLZsw7LUgOvsTdwq9jzqrIWQGxLkisrRtQBIj8ph1dyrB
         0MVGxfj9W/vVrguzp78FFnaGF58wtgvwozCJHx1njYEp80pEdObdpRjFRNStau3AFZ0C
         /rXaWpsXL1pMxH/W8yyror3aaVChYpURsxu0uT7HScyrAkG8WabFLHb0S8NhmWtujMyk
         g8RwZnKzcWx+Jr5cx9GA1Vp64LYrUhWo4dyhCe43trYg8legnrdPkl0D7gDUf0dkTGks
         Td8czOkvhJghqIXVGbW55UPdqKFehNoQQhH19vvhNhG4FtAfSOJ4jLAMtdx1N2RvDL0C
         l7ZA==
X-Gm-Message-State: AOAM531RkB7z+8Qiv/3NsjrTLVqXEjhL5yADHiG8LQXJDPV+B9nbm3JM
        0b5odkGZsXFtwbocKv4CihP4nR3gc8pvDGNq/qDiIA==
X-Google-Smtp-Source: ABdhPJxg0if+XXM3axrOLpGf+ouR3+O04vSxnaA9Z0ED7iapGZTlDYmJDCiSB1IKh6EGA/5tHNh5IwoJC6sAQiZBOKg=
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr8759377wmf.111.1599742642108;
 Thu, 10 Sep 2020 05:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200908163248.14330-1-james.quinlan@broadcom.com> <20200910022555.GA749829@bjorn-Precision-5520>
In-Reply-To: <20200910022555.GA749829@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 10 Sep 2020 08:57:10 -0400
Message-ID: <CA+-6iNzyuVm4gw2socQuQtdrXWCam3GfQj61jYJEUa75fnbvtQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] PCI: pcie_bus_config can be set at build time
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f0e08705aef51bd4"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000f0e08705aef51bd4
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

On Wed, Sep 9, 2020 at 10:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 08, 2020 at 12:32:48PM -0400, Jim Quinlan wrote:
> > The Kconfig is modified so that the pcie_bus_config setting can be done at
> > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > pci_bus_config setting may still be overridden by the bootline param.
>
> I guess...  I really hate these build-time config settings for both
> ASPM and MPS/MRRS.  But Linux just isn't smart or flexible enough to
> do the right thing at run-time, so I guess we're kind of stuck.
>
> I guess you have systems where you need a different default?
Yes, we've been shipping our kernel with the DEFAULT and since we do
not have FW it is not configured optimally.  Some customers have
noticed and I tell them to put 'pci=pcie_bus_safe' on their bootline
but I'd rather have this setting work for all customers as it yields
the option we want.

>
> It'd be nice if we could put a little more detail in the Kconfig to
> help users choose the correct one.  "Ensure MPS matches upstream
> bridge" is *accurate*, but it doesn't really tell me why I would
> choose this rather than a different one.
IIRC I just copied the comments that were in the bootline settings.
I'm concerned about there being the same comment in two places; sooner
or later someone will update one place and not the other.

>
> Maybe we could mention the corresponding command-line parameters,
> e.g., "This is the same as booting with 'pci=pcie_bus_tune_off'"?
Will do and resubmit.

Thanks,
Jim Quinlan
Broadcom STB
>
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.c   | 12 ++++++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 4bef5c2bae9f..efe69b0d9f7f 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -187,6 +187,46 @@ config PCI_HYPERV
> >         The PCI device frontend driver allows the kernel to import arbitrary
> >         PCI devices from a PCI backend to support PCI driver domains.
> >
> > +choice
> > +     prompt "PCIE default bus config setting"
> > +     default PCIE_BUS_DEFAULT
> > +     depends on PCI
> > +     help
> > +       One of the following choices will set the pci_bus_config at
> > +       compile time.  This will still be overridden by the appropriate
> > +       pci bootline parameter.
> > +
> > +config PCIE_BUS_TUNE_OFF
> > +     bool "Tune Off"
> > +     depends on PCI
> > +     help
> > +       Use the BIOS defaults; doesn't touch MPS at all.
> > +
> > +config PCIE_BUS_DEFAULT
> > +     bool "Default"
> > +     depends on PCI
> > +     help
> > +       Ensure MPS matches upstream bridge.
> > +
> > +config PCIE_BUS_SAFE
> > +     bool "Safe"
> > +     depends on PCI
> > +     help
> > +       Use largest MPS boot-time devices support.
> > +
> > +config PCIE_BUS_PERFORMANCE
> > +     bool "Performance"
> > +     depends on PCI
> > +     help
> > +       Use MPS and MRRS for best performance.
> > +
> > +config PCIE_BUS_PEER2PEER
> > +     bool "Peer2peer"
> > +     depends on PCI
> > +     help
> > +       Set MPS = 128 for all devices.
> > +endchoice
> > +
> >  source "drivers/pci/hotplug/Kconfig"
> >  source "drivers/pci/controller/Kconfig"
> >  source "drivers/pci/endpoint/Kconfig"
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e39c5499770f..dfb52ed4a931 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
> >  #define DEFAULT_HOTPLUG_BUS_SIZE     1
> >  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> >
> > +
> > +/* PCIE bus config, can be overridden by bootline param */
> > +#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> > +#elif defined CONFIG_PCIE_BUS_SAFE
> > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
> > +#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
> > +#elif defined CONFIG_PCIE_BUS_PEER2PEER
> > +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
> > +#else
> >  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> > +#endif
> >
> >  /*
> >   * The default CLS is used if arch didn't set CLS explicitly and not
> > --
> > 2.17.1
> >

--000000000000f0e08705aef51bd4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIFI6FipT+dr
MwGXGvDbWyJgVtvtKdZ+dlZMr2mSHKjUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMDkxMDEyNTcyMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBfRXy5n4p9oTsIUeGs0l894iMIiWcz
WJ72t/Qca02PiqBZy56O56At6ti0DP6wBqgXZpSLZ37eakdnjOagNoFGMPMQxgZiI4Fxf+YkB8Z1
JvgceGwRwbdWSB5x38rK8aLlquszPkqfaPFSInFP7I3G7jZp3QCCH8MKdjRcvg8OiUfZpZIGtcp5
FlbQAuLmRASi+Dtp5OucJp9QQ7m4Ct3dc3BIiGCLpvoLZTwSJIrghiF5FdDyH0UozVcj4vHdU6Ot
M7AfbDzprFJA7E9ST+SS5M95rMK31NOYC555b2aJimab0/S/f1PHWCV43OZIPG7ZrfvPn7MZtmMY
ZZ4p2Kif
--000000000000f0e08705aef51bd4--
