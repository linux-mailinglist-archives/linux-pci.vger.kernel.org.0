Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4421C2D1A88
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 21:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgLGUaS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 15:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLGUaR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 15:30:17 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD5C061793
        for <linux-pci@vger.kernel.org>; Mon,  7 Dec 2020 12:29:37 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so439733wmb.5
        for <linux-pci@vger.kernel.org>; Mon, 07 Dec 2020 12:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpP8ykG4lA66iomJhrR9otrflb0L+fekZmktPrnoTRQ=;
        b=ZNORiLf4wJR589XdHXpJDMM+Rp0MN72cwnndyP25yzzAdfMG+QNe0X7EVMR9MI9GpM
         FNnLT+pVasDdivAS6YDOB9kt7esxUh4jFWPvqXol0urrPYs2Wpp2z3HXPZGAMYLbzcEx
         Qr97Eq19Jzbj6wF0yUJ0G6nOU7XQzhJQD6MG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpP8ykG4lA66iomJhrR9otrflb0L+fekZmktPrnoTRQ=;
        b=t6+x3kjykM80QloZslpZLPZoY4cJbwMRdrVwo41ef5Vb2N1aTvEohplL9Bb877itnv
         aVXovg8NVhZGA23SQ1czW0cmYLPDaydqdFCPX/xxvkbbXfASVmDjhhDqBd5++r/72pyH
         Dfcn1J6J17w3WsVDODLOoE4jkBi8iLE4JSYG4IYdVSoFM87bfOkSIepVbDiCDXjrCR12
         Vc1kQ8CtxFgNGSGYClOxNoh9cLWd2kRxmmHx3PXess9RJtDXnISOnmGkm7Ndts47Shtf
         1CtF73rCJ9E+uUMZODpuZ6dIOskfDmVrT0j02mSUJvebKFL9ufuTjYQMtKG09ajSnITw
         joWA==
X-Gm-Message-State: AOAM5304YtUMotBuL/5IlGzw9B4psT6VPxsbNRm90W0A0JPVnzRezt32
        Ofusyni42yRRu1+hM6UrUVa86czpeMgiQG8n1gRll+hyFned/x1r/rUpSmPzUHMnuPSPIBuyEL/
        5fBHnNbhwcuCP5j5ntMKI8cGBRIU=
X-Google-Smtp-Source: ABdhPJz2rzqH3CYlLvsRHPPLOcG0oVD3DD5pvDv4x4Kx5bxHIAD5bFpSEXL5B8bNThfG3tcQztwQ7cGlzDSSiV3A9OM=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr588266wmi.35.1607372976076;
 Mon, 07 Dec 2020 12:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20201129230743.3006978-1-kw@linux.com> <20201129230743.3006978-2-kw@linux.com>
 <X808JJGeIREwqIjb@rocinante> <094b314f-7f61-d0fd-fd63-c9c4da9e84a8@gmail.com>
In-Reply-To: <094b314f-7f61-d0fd-fd63-c9c4da9e84a8@gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 7 Dec 2020 15:29:24 -0500
Message-ID: <CA+-6iNzmx6nCZh_y9du1Dz=dFUBGABAJPEEviF9OSGORUnx-GQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] PCI: Unify ECAM constants in native PCI Express drivers
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000048ab8c05b5e5af7d"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000048ab8c05b5e5af7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 6, 2020 at 10:25 PM Florian Fainelli <f.fainelli@gmail.com> wro=
te:
>
> +JimQ,
>
> On 12/6/2020 12:16 PM, Krzysztof Wilczy=C5=84ski wrote:
> > Hello Nicolas, Florian and Florian,
> >
> > [...]
> >> -/* Configuration space read/write support */
> >> -static inline int brcm_pcie_cfg_index(int busnr, int devfn, int reg)
> >> -{
> >> -    return ((PCI_SLOT(devfn) & 0x1f) << PCIE_EXT_SLOT_SHIFT)
> >> -            | ((PCI_FUNC(devfn) & 0x07) << PCIE_EXT_FUNC_SHIFT)
> >> -            | (busnr << PCIE_EXT_BUSNUM_SHIFT)
> >> -            | (reg & ~3);
> >> -}
> >> -
> >>  static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned=
 int devfn,
> >>                                      int where)
> >>  {
> >> @@ -716,7 +704,7 @@ static void __iomem *brcm_pcie_map_conf(struct pci=
_bus *bus, unsigned int devfn,
> >>              return PCI_SLOT(devfn) ? NULL : base + where;
> >>
> >>      /* For devices, write to the config space index register */
> >> -    idx =3D brcm_pcie_cfg_index(bus->number, devfn, 0);
> >> +    idx =3D PCIE_ECAM_OFFSET(bus->number, devfn, 0);
> >>      writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
> >>      return base + PCIE_EXT_CFG_DATA + where;
> >>  }
> > [...]
> >
> > Passing the hard-coded 0 as the "reg" argument here never actually did
> > anything, thus the 32 bit alignment was never correctly enforced.
> >
> > My question would be: should this be 32 bit aligned?  It seems like the
> > intention was to perhaps make the alignment?  I am sadly not intimately
> > familiar with his hardware, so I am not sure if there is something to
> > fix here or not.
Hello Krzystzof,

The value gets assigned to our config-space index register, which has
the lower two bits marked "unused".    We're making sure that we are
putting zeroes there but it is most likely not necessary.

> >
> > Also, I wonder whether it would be safe to pass the offset (the "where"
> > variable) rather than hard-coded 0?
The answer is "no" for this code but "maybe" in the future -- allow me
to explain.  We have two methods to access the config space:

(1) Set a designated index register to map to the base of a device's
config-space.  From then we can access a 4k register set.  This is the
method you see in the code and is why we set reg=3D0 for the index value
and then add "where" to the return address.

(2) Set our index register to the bus/slot/func/reg value, and then we
access a single data register.  In this case we do set the "reg" to
the register value to set the index and then only add "where & 0x3" to
the return address.

As it turns out, (1) is not compatible with some MIPs SOCs that we
still support as they do not have the 4k data register set.  So I may
be changing to (1) in a future pullreq, and if so, I will invoke
PCIE_ECAM_OFFSET(bus->number, devfn, where & ~3);

Regards,
Jim Quinlan
Broadcom STB


> >
> > Thank you for help in advance!
> >
> > Bjorn also asked the same question:
> >   https://lore.kernel.org/linux-pci/20201120203428.GA272511@bjorn-Preci=
sion-5520/
> >
> > Krzysztof
> >
>
> --
> Florian

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--00000000000048ab8c05b5e5af7d
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKMmyfFHCBT5
8tdnIJE5gvx5OfBLGRC61eEa/vZCH4uHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTIwNzIwMjkzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDSboJG00LmxV6jHd21AJouftSGlC8f
fLd6z85tqJYm/qvcSfAJ4pQZNvEbetZvzAdZjJZ0HKNAQeF7vZcyF+KYJxs2hj/YROl4hiFouPBF
O0IlepqF6ilkJKSGF472+mh3lhhX9M1KQfGlXs7iM+2UDfRbGFKXx98foJqmS1Euk1U20d89kng0
j+mrzYkct9q05owFezEjssvqv+GI+LROFOqjSpIpZAHp7y25N27qJnxg8xDjy2dCmfjbeNMXsZjK
ZyoxA3DUt+nWWKqg2uY4SkD33njTZa6pmLbjwZa7kJb2BW01/E+K2KLj1F2aDKH+liguoqREVZ0N
k/WHpj20
--00000000000048ab8c05b5e5af7d--
