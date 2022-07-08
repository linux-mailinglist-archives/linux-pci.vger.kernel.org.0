Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD556C402
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiGHUiq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbiGHUio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 16:38:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876141EEE7
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 13:38:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g1so20512191edb.12
        for <linux-pci@vger.kernel.org>; Fri, 08 Jul 2022 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCAFrRIQxoumd1u+aRgs6//4OAe8byy9gJ8krxiP/Gw=;
        b=PSQm9ZqpIvGK6et7j6BksSCYZJp546xj7k0pEPxzyLMME0HRU1BMtqdwtTiRrdB5Oi
         Fg9WUx6V3CWwlb/avK9EXwLUPsaz/Ue7NCdbxc+rOeSeOuJ0WXa/CxdbPmQBp1cEqekK
         8TEMggKbU1P3IRbIkvzJ7IJhNj+wq5AI3TiTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCAFrRIQxoumd1u+aRgs6//4OAe8byy9gJ8krxiP/Gw=;
        b=EcS19znh3bcozTw1jmtWr1FbC4JaRPxpa0pWHqkw3v9FppZoWTA4ckQ21poZrmT2Pp
         LfNfVapLzOCU9HhBhVx1jILwJq/OYwrQp7hx+LUvSorfWb38Kt6enXN613JwPdAIvAxC
         S0ayi7xo2yuM0W9vxz6aM95lvReW6u7NBx+5LQ9f6GHixQe91TH4oV8RNmQOvwXL9LpW
         N+D4Ag9l/mxO9NMJlvnGpvs0+g0STizIeXAuvUgTUQ0ZYUaaPhNpVjt3RoJVkv0osRZC
         Cub4vCftU51mTSoZ/FDO1ytbmv7tmzvmLXlBZdRyWmfbuK9lBdISZtqG0fYdqC5LPoFu
         W5cA==
X-Gm-Message-State: AJIora/bFn0cx+DCNLZ6M7cvmKSCzYEIYwyox6Op1XWJr0sm8MsqXgGg
        Y+1MBzpDL5+KmFkQavyJo8pGXYiZi6cYiokf16sarQ==
X-Google-Smtp-Source: AGRyM1tM7+juLJUiTyAKd1Z5zk/+OliQGrwaqy+1Mz+c7qZqqcgd+8XSu+LW1BSE9YJYtilRKWxGnmq2WGLSVo8hPSI=
X-Received: by 2002:a05:6402:26d2:b0:435:ccc1:822b with SMTP id
 x18-20020a05640226d200b00435ccc1822bmr7290885edd.53.1657312721980; Fri, 08
 Jul 2022 13:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-6iNxTYz_yDSbaXc_UKRGr=BxPCa1Lk001uCSmRbVY-WVxvw@mail.gmail.com>
 <20220708195940.GA369714@bhelgaas>
In-Reply-To: <20220708195940.GA369714@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 8 Jul 2022 16:38:30 -0400
Message-ID: <CA+-6iNxDTTKfxKbNPVnRaKmbXuy8cJAr22mws50=GkX3ncxWgA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] PCI: brcmstb: Split brcm_pcie_setup() into two funcs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001792ed05e35130cf"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000001792ed05e35130cf
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 8, 2022 at 3:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jul 08, 2022 at 03:40:43PM -0400, Jim Quinlan wrote:
> > On Fri, Jul 8, 2022 at 3:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Jul 08, 2022 at 09:29:27AM -0400, Jim Quinlan wrote:
> > > > On Wed, Jul 6, 2022 at 5:56 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Jul 01, 2022 at 12:27:22PM -0400, Jim Quinlan wrote:
> > > > > > We need to take some code in brcm_pcie_setup() and put it in a new function
> > > > > > brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
> > > > > > be called indirectly by pci_host_probe() as opposed to the host driver
> > > > > > invoking it directly.
> > > > > >
> > > > > > Some code that was executed after the PCIe linkup is now placed so that it
> > > > > > executes prior to linkup, since this code has to run prior to the
> > > > > > invocation of pci_host_probe().
> > > > >
> > > > > This says we need to move some code from brcm_pcie_setup() to
> > > > > brcm_pcie_linkup(), but not *why* we need to do that.
> > > > I will elaborate in the commit message.
> > > > >
> > > > > In brcm_pcie_resume(), they're called together:
> > > > >
> > > > >   brcm_pcie_resume
> > > > >     brcm_pcie_setup
> > > > >     brcm_pcie_linkup
> > > > >
> > > > > In the probe path, they're not called together, but they're in the
> > > > > same order:
> > > > >
> > > > >   brcm_pcie_probe
> > > > >     brcm_pcie_setup
> > > > >     pci_host_probe
> > > > >       ...
> > > > >         brcm_pcie_add_bus               # bus->ops->add_bus
> > > > >           brcm_pcie_linkup
> > > > >
> > > > > Is there something that must happen *between* them in the probe path?
> > > >
> > > > Yes.  In the probe() case, we must do things in this order:
> > > >
> > > > 1. brcm_pcie_setup()
> > > > 2. Turn on regulators
> > > > 3. brcm_pcie_linkup()
> > >
> > > Ah, I see, both 2) and 3) happen in brcm_pcie_add_bus:
> > >
> > >   brcm_pcie_add_bus                    # bus->ops->add_bus
> > >     pci_subdev_regulators_add_bus
> > >       regulator_bulk_enable            # turn on regulators
> > >     brcm_pcie_linkup
> > >
> > > > Since the voltage regulators are turned on during enumeration,
> > > > pci_host_probe() must be invoked prior to 3.  Before regulators, we
> > > > did not care.
> > >
> > > I guess in the pre-regulator case, i.e., pcie->sr not set, the power
> > > for downstream devices must always be on.
> > >
> > > > In the resume case, there is no enumeration of course but our driver
> > > > has a handle to the regulators and can turn them on/off w/o help.
> > >
> > > And I guess we don't need brcm_pcie_setup() in the resume path because
> > > suspend turns off power only for downstream devices, not for the root
> > > port itself, so the programming done by brcm_pcie_setup() doesn't need
> > > to be done again.
> >
> > I'm not sure I understand what you are saying -- brcm_pcie_setup()  is
> > called by brcm_pcie_resume()
> > because it is needed.  brcm_pcie_setup() isn't concerned with power it
> >  just does the preparation
> > required before attempting link-up.
>
> Oh, sorry, I totally misread that.
>
> But I wonder about the fact that probe and resume do these in
> different orders:
>
>   brcm_pcie_probe
>     brcm_pcie_setup                          # setup
>     pci_host_probe
>       ...
>         brcm_pcie_add_bus
>           pci_subdev_regulators_add_bus
>             regulator_bulk_enable            # regulators on
>           brcm_pcie_linkup                   # linkup
>
>   brcm_pcie_resume
>     regulator_bulk_enable                    # regulators on
>     brcm_pcie_setup                          # setup
>     brcm_pcie_linkup                         # linkup
>
brcm_pcie_setup() should be order-independent of brcm_pcie_linkup(),
but your point is valid -- it is prudent to keep the orders
consistent. Let me think
about this.

> Maybe pci_subdev_regulators_add_bus() could be done directly from
> brcm_pcie_probe() instead of in brcm_pcie_add_bus()?
> regulators must be directly under the root port node in DT, it seems
> like it would be reasonable to look for them in the probe path, which
> seems like what pcie-dw-rockchip.c, pcie-tegra194.c, and
> pcie-rockchip-host.c do.
At some point in the original patchset -- IIRC -- the RC driver was
searching the DT
tree for regulators.  However, doing a "get" on these regulators is pretty much
impossible if the "owning" device does not exist.  I even had a version that
partially created the downstream device;  this pullreq was a mess and
got feedback which  put me on the current approach.

Reviews suggested  that the best location for the regulators should be located
in the root port DT node(s).  I agree with this. In addition, there
was a request to allow multiple regulators
to exist at each of the root ports in the downstream tree.  So if the RC driver
has to  potentially add multiple buses.  I really don't know how it
would do that,
and then call the pci_host_probe() w/o it failing.  Perhaps this is what ACPI
does before boot  -- I'm guessing here -- but I would also guess that it is
a decent amount of code as it is not far from doing enumeration.

One thing I could do is to allow the port driver's suspend/resume to do the
turning off/on of the regulators.  There are two issues with this: (1)
feedback suggested
to put the code local to the Brcmstb driver and (2) the "ep wakeup_capable"
code would also have to live in the port driver and I'm not sure this
would be welcome.

>
> Or maybe brcm_pcie_resume() should enable the regulators after
> brcm_pcie_setup() so it's the same order as the probe path?
I  think I'll do this.

Thanks,
Jim Quinlan
Broadcom STB
>
> Bjorn

--0000000000001792ed05e35130cf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LeylbuEJGL9I80yqq8e6Z+Q6ulLxa6SopzpoysJe/vEVHgp9jPNppZzwKngVd2iDBRqpKlCngIAM
DXgVGyEojXnuEbRs3NlB7wq1kJGlYysrnDug55ncJM8CAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFCeTeUYv84Mo3T1V+OyDdxib
DDLvMA0GCSqGSIb3DQEBCwUAA4IBAQCCqR1PBVtHPvQHuG8bjMFQ94ZB7jmFEGhgfAsFJMaSMLov
qyt8DKr8suCYF4dKGzqalbxo5QU9mmZXdLifqceHdt/Satxb+iGJjBhZg4E0cDds24ofYq+Lbww2
YlIKC2HHxIN+JX2mFpavSXkshR5GT29B9EIJ8hgSjbs61XXeAcrmVIDfYbXQEmGbsnwqxdq+DJpQ
S2kM2wvSlgSWDb6pL7myuKR5lCkQhj7piGSgrVLJRDRrMPw1L4MvnV9DjUFMlGCB40Hm6xqn/jm0
8FCLlWhxve5mj+hgUOPETiKbjhCxJhhAPDdCvDRkZtJlQ8oxUVvXHugG8jm1YqB5AWx7MYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMI+Aj9XRk/wFexb9/
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBBshNxTn+5ctWKXOpH+njPp+q1rS6h
oADl+iAU3TsmzTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjA3
MDgyMDM4NDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAdEQRfV94a+1gu43pnoBddV0bWkBehWKdjzNYOxF4x19nUnUG
FXwQkXtCIHd8j+ZofxK9j0rjz+DAxewjUp/weCKlU27CBtoeJ7Qj0CP5fIUU3BuaMyGiL1sTUPfI
6IZok1Xem+0g2V8neocwX2EXBg+Lbh0LhWKZbu7uxAiUFkQtAugFR1B0eqJeJ0OaC4PhnfxXM1Zy
VW5F9L0zUzHph6VJnSD0NSmlzZbqhNv+h4l8ShpPEjcRHfks4Dr7sF1p/UOwORQlYJkD1ZXp7cmB
grlVDUyaqeHqoV+NYS5iAK+DWjugO69YRjmArHh61j2ZavxvpFXuphh6PtxcIzg+RA==
--0000000000001792ed05e35130cf--
