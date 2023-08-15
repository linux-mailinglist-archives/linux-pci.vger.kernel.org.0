Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9477CCC2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjHOMfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjHOMfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 08:35:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE46919A0
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 05:35:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bad7499bdcso41648821fa.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692102905; x=1692707705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Y3oIqOhRO0uWp2mArjniwORLx4U87Lw45vPlVBsYQ=;
        b=JUfNLzLs17mijvz1fYo6EuT5RNHlEF8czxmU1TRPenZ/cuY6axdbFzHGc2VAv0NWdb
         U9tuJLbfktsZ08DVqYzK/Dbv8++n25O4XrbgrvU9Dlmg+9otpX7rX6AiA4cNr7ctfYD3
         bcrn0fm9mfvsiv70/wmruFhwuJkbUjjN/8j3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692102905; x=1692707705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2Y3oIqOhRO0uWp2mArjniwORLx4U87Lw45vPlVBsYQ=;
        b=X3UUVKALuU8y2y/JO7s+60V8HEppH25Yk4n9dGR2iOiQSwjUA+368Z6W0HJGspADPZ
         9lPMN0aiXOFYkkOHLkWmfmuTjOtF/cH3gWOegnEduZZED7VZo+WCdPIt9gzwQfNE71mM
         vDa18Hn/4zyxdL29CvP7bpRgEwQLWj1tJ/djU4gAaYf3G6vwHWtaMJHvn8VWbYNuYWGU
         JxZOfZHnKX5I0ZGqbQ2ijFfaZ6FOTakGk43LTnK+8BDeBY1/6+pA+hjGGtzalilG1Vzv
         Yxr8LimgGzfuTunmJEs99+oiTqMzTLJTpZaDOvyQ/tgLPfjbYMgR2FwLwQdsEEy2xcdF
         hBVQ==
X-Gm-Message-State: AOJu0Yz82GZ9J7kV0swSlw5Vtevp1pKGrgY+FoLSydVozB2ElVpDLd/2
        tuU52ztWFYCBan9db1SvZmQ2v9LsB3HRseVcQbgW0w==
X-Google-Smtp-Source: AGHT+IFbOtA156FiWsXlyK18JrqEPOUYOFXK00VWwoxCDlJX24+nUfX70QgaqT+oHwHvN7BW20289+ErVQ+s+InW1nE=
X-Received: by 2002:a05:651c:44f:b0:2b6:e7c7:b039 with SMTP id
 g15-20020a05651c044f00b002b6e7c7b039mr9157053ljg.28.1692102905366; Tue, 15
 Aug 2023 05:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-6iNzKB4vMkM4Qt6781GN-WwzCCdUYY3o=stgPSjQyJPr6vQ@mail.gmail.com>
 <20230814220658.GA193031@bhelgaas>
In-Reply-To: <20230814220658.GA193031@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 15 Aug 2023 08:34:54 -0400
Message-ID: <CA+-6iNyYx6VK-pudUV=fGLM88vUZuQEf-moPa=q6CP-pwR_5Tw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] PCI: brcmstb: Set higher value for internal bus timeout
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009ea1340602f568de"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000009ea1340602f568de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 6:07=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Aug 14, 2023 at 03:30:07PM -0400, Jim Quinlan wrote:
> > On Fri, Jul 28, 2023 at 12:15=E2=80=AFPM Jim Quinlan <james.quinlan@bro=
adcom.com> wrote:
> > > On Thu, Jul 27, 2023, 10:44 PM Lorenzo Pieralisi <lpieralisi@kernel.o=
rg> wrote:
> > >> On Fri, Jun 23, 2023 at 10:40:56AM -0400, Jim Quinlan wrote:
> > >> > During long periods of the PCIe RC HW being in an L1SS sleep state=
, there
> > >> > may be a timeout on an internal bus access, even though there may =
not be
> > >> > any PCIe access involved.  Such a timeout will cause a subsequent =
CPU
> > >> > abort.
> > >> >
> > >> > So, when "brcm,enable-l1ss" is observed, we increase the timeout v=
alue to
> > >> > four seconds instead of using its HW default.
> > >> >
> > >> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > >> > Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> > >> > ---
> > >> >  drivers/pci/controller/pcie-brcmstb.c | 16 ++++++++++++++++
> > >> >  1 file changed, 16 insertions(+)
> > >> >
> > >> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/c=
ontroller/pcie-brcmstb.c
> > >> > index d30636a725d7..fe0415a98c63 100644
> > >> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > >> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > >> > @@ -1034,6 +1034,21 @@ static int brcm_pcie_setup(struct brcm_pcie=
 *pcie)
> > >> >       return 0;
> > >> >  }
> > >> >
> > >> > +/*
> > >> > + * This extends the timeout period for an access to an internal b=
us.  This
> > >> > + * access timeout may occur during L1SS sleep periods even withou=
t the
> > >> > + * presence of a PCIe access.
> > >> > + */
> > >> > +static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
> > >> > +{
> > >> > +     /* TIMEOUT register is two registers before RGR1_SW_INIT_1 *=
/
> > >> > +     const unsigned int REG_OFFSET =3D PCIE_RGR1_SW_INIT_1(pcie) =
- 8;
> > >>
> > >> Nit: you could define an offset for the TIMEOUT register, if that ma=
kes
> > >> it any cleaner, up to you.
> > >>
> > >> > +     u32 timeout_us =3D 4000000; /* 4 seconds, our setting for L1=
SS */
> > >>
> > >> It would be useful to describe why this has to be 4 seconds in case
> > >> someone in the future will have to change it.
> > >
> > > IIRC our customer requested 2s and we doubled it.  Bjorn, can you
> > > please add this comment or a paraphrase of it before applying --
> > > I'm currently on vacation.
> >
> > Is the above request okay with you?  What is the status of these
> > commits -- will they be applied to pci-next in the near future?
>
> The "brcm,enable-l1ss" DT property is either unnecessary or an
> indication of a hardware defect in the controller.

Agree.
>
> Requiring the property is a terrible user experience, completely
> antithetical to the PCI compatibility story, and per the conversation
> at [1], there are no known problems that would occur if we ignored
> "brcm,enable-l1ss" and always configured mode (c) ("Bidirectional
> CLKREQ# for L1SS capable devices").

Agree, but I don't believe this issue will be in the top five problems of R=
Pi
folks getting their PCIe systems to work.

>
> Even when configured as mode (c), L1SS is not *always* enabled.  It's
> certainly not enabled before ASPM init, and users can always disable
> L1SS whenever they desire via the sysfs interfaces or pcie_aspm=3Doff,
> so if there's some problem with running in mode (c) with L1SS
> disabled, we're still likely to see it.
>
> But if you want to require the DT property, I guess it's mainly an
> issue for you and your customers.

I believe this to be the best solution for the current HW.  As Cyril
and I have noted, it
allows some platforms to work that were not working previously.

So I am all for these commits being applied.

FWIW, I am currently advocating changing the PCIe HW core to
seamlessly handle all
of the ASPM (sub)states transitions w/o awkward SW driver
intervention.  I am also
advocating other changes as well.  So there is a possibility things will
be changed for the better in the future.

Regards,
Jim Quinlan
Broadcom STB

>
> So to answer your question, yes, I'm OK with this series.
>
> Bjorn
>
> [1] https://lore.kernel.org/r/20230428223500.23337-2-jim2101024@gmail.com
>
> > >> > +     /* Each unit in timeout register is 1/216,000,000 seconds */
> > >> > +     writel(216 * timeout_us, pcie->base + REG_OFFSET);
> > >> > +}
> > >> > +
> > >> >  static void brcm_config_clkreq(struct brcm_pcie *pcie)
> > >> >  {
> > >> >       bool l1ss =3D of_property_read_bool(pcie->np, "brcm,enable-l=
1ss");
> > >> > @@ -1059,6 +1074,7 @@ static void brcm_config_clkreq(struct brcm_p=
cie *pcie)
> > >> >                * of 400ns, as specified in 3.2.5.2.2 of the PCI Ex=
press
> > >> >                * Mini CEM 2.0 specification.
> > >> >                */
> > >> > +             brcm_extend_rbus_timeout(pcie);
> > >> >               clkreq_set |=3D PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_=
ENABLE_MASK;
> > >> >               dev_info(pcie->dev, "bi-dir CLKREQ# for L1SS power s=
avings");
> > >> >       } else {

--0000000000009ea1340602f568de
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDgtugKkZJi/a5pT5Kg+M4rJKu/Yvuv
WwZBbdlVMih9HTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA4
MTUxMjM1MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAbTIpkuWBNEfxJpEgQIoR6GfQzWQquR1WEyutVHMi2O+7uDQF
3RcxG8sV7fGigfJYGK61s4jyAKmn5QxKF4zmNEDJJy3Cou20J7KlsL+1z7o2RKDqR5xrj8GCFz1U
yX1HbjUDF3qkOYSLP3ZYdkoc0qdxXc8lCIbmrLlkjI0S6Nn5kRS9oeaH7jQDCAzNaBOBCsEZ9bja
X0SL1vnUf0Bl9QwyjOu7KnQEhz2yn3BhntlKwsYP2i4d2jf7UWrA+I6UQAJHA76PdV9VcEhvrE/M
oNONNOBe4QF64i0xkVXim+Qxs1rUq1Br9pcnMbAXhgj51TlJScM8b97zC569zpaB2g==
--0000000000009ea1340602f568de--
