Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCABE2B09F9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgKLQ3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgKLQ3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 11:29:00 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80316C0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 08:28:59 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b8so6673575wrn.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKiHRV82MzKhMN/IJbdz3ZwUnPMQX/3uBt7DMExSr/E=;
        b=RZbEeW9U/hBadioHNqlkRcFMKZtBgSGbCJNXE2Li8RuCLmogACxWMaK/vrMK6f4QRo
         m721GQo36UuQgNwL8zN5iPDxlHlp7UwoVleNmbN1cGLDmFxZWrQhWur/pyD038KKY09g
         Rc1LVWQZf49EjOVArkjegeWxzzcij8Ied9HIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKiHRV82MzKhMN/IJbdz3ZwUnPMQX/3uBt7DMExSr/E=;
        b=c9tcvm06Bfh2LHPy/MbSh0AXM/Ev9IgX4J+ufi6O9Utj+TQWVhXbf3+iMIixvvSsHj
         /WXlyqaVtZU+lJeJ/WvlvOEWihNhHqpIWnzgups29tfyebQSczOzMSGP71SicLYwSUCp
         AGWDsIi+yGDUR+uxwJyvvZiRPTzaFniqxENF5gLgMmxDK3L7mPkmn96hLHUf1+lawPHx
         Bk/PX+DTJgWMvrtD2IIFXNSF78c891J7H8B/4z/ocRvzefESdMaFILzkgnQg0bpa89py
         8uc9DKAw17AfsvNPf3vsdqb/CET3PvsgJ3oDyO0UDQ+FQlhKidF/BdEuPGVugLDnmDWi
         18aA==
X-Gm-Message-State: AOAM531pdtDvoZiJ1BasgGeRTXzNKTVZ4aGLqMdp6N7Whakyof3wIPUQ
        Qs71nsyJZyA1qtrE3hcpeGwfgtWVl1ZeWzqVqU7BVQ==
X-Google-Smtp-Source: ABdhPJxWOXIGUYeugwDM05K3tISZwLuWZQw02BhpQVnRNk8492CnfgR0wPKErHdkXGnzE/Vfqd/bGTqQqTpNGyBw1e4=
X-Received: by 2002:a5d:660f:: with SMTP id n15mr339954wru.345.1605198536403;
 Thu, 12 Nov 2020 08:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20201112131400.3775119-1-phil@raspberrypi.com> <883066bd-2a0c-f0d8-c556-7df0e73f0503@gmail.com>
In-Reply-To: <883066bd-2a0c-f0d8-c556-7df0e73f0503@gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 12 Nov 2020 11:28:45 -0500
Message-ID: <CA+-6iNxc9UiEqFXj4jMJRXW1XAS7aB4hANa7mHRsK8++t2A18A@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Restore initial fundamental reset
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000adaaeb05b3eb686c"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--000000000000adaaeb05b3eb686c
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 12, 2020 at 10:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> +JimQ,
>
> On 11/12/2020 5:14 AM, Phil Elwell wrote:
> > Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > replaced a single reset function with a pointer to one of two
> > implementations, but also removed the call asserting the reset
> > at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> > VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> > used for USB booting but then need to be reset so that the kernel
> > can reconfigure them. The lack of a reset causes the firmware's loading
> > of the EEPROM image to RAM to fail, breaking USB for the kernel.
> >
> > Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> >
> > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>
> This does indeed seem to have been lost during that commit, I will let
> JimQ comment on whether this was intentional or not. Please make sure
> you copy him, always, he wrote the driver after all.
Hello,

This wasn't accidentally lost; I intentionally removed it.  I was
remiss in not mentioning this in comments, sorry.

The reason I took it out is because (a) it breaks certain STB SOCs and
(b) I considered it superfluous (see reason below).  At any rate, if
you must restore this line please add the following guard so
everyone's board will work :-)

        if (pcie->type != BCM7278)
                brcm_pcie_perst_set(pcie, 1);



As for me considering that  this line is superfluous -- which
apparently it is not : AFAIK PERST# is always asserted from cold start
on all Brcm STB SOCs, and I expected the same on the RPi.  Asserting
PERST# at this point in time should be a no-op.  Is this not the case?

Thanks,
Jim Quinlan
Broadcom STB


>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index bea86899bd5d..a90d6f69c5a1 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -869,6 +869,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >
> >       /* Reset the bridge */
> >       pcie->bridge_sw_init_set(pcie, 1);
> > +     pcie->perst_set(pcie, 1);
> > +
> >       usleep_range(100, 200);
> >
> >       /* Take the bridge out of reset */
> >
>
> --
> Florian

--000000000000adaaeb05b3eb686c
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGvkfbKq6ge4
HsDOvjXVp0t5aQmgHdfALYsMTrdAFUn7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTExMjE2Mjg1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB5Rml/gx4ZC0P+BiGsWHDlSAg9i6I4
DXI87XHkPdGb9hXm+tVglLbRaekwwUsadAGj2PbKGJ2Mi/sMVDYABSdpqBGIfg97tvjNryFLkATE
0lEJa07HxmLkm6mEV8KSvX9BEngQGYW+aAvpxZlYQoO0ve/uDdpKPJYgy7LM+7CBsvQ5I9rrN06C
VPW07I19yFvpu1PM7dj5GWaQUvkeWqCSf9MBc+m3h4XCuz891mxmEpuG7pBFM9uN5psvHTVGSb9D
EE34TQTIkP1kbs0BlOIZuMdMMWBU5/f+pt3ZTkv9Ga33T06Ewx0WYcz9JKmPAReXIgTTYFGn2gWc
EUrZJnQ+
--000000000000adaaeb05b3eb686c--
