Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BB47E7424
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 23:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjKIWGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 17:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIWGd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 17:06:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1F3C01
        for <linux-pci@vger.kernel.org>; Thu,  9 Nov 2023 14:06:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50930f126b1so1728506e87.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Nov 2023 14:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699567589; x=1700172389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y82BzpTv7cyl6IIFop0Gnim+2ptsxtHU/vEQvoxXaNs=;
        b=HnSaBXFlStubfPL59p4zxreeizG650zzKRpdFesDuplKMYZRpPr+Rii2XjM5uTgFl3
         K+135ePbMgmcyqnSNpxllAzD+0wREuoc8fS/cGH56TXbocXDDh0SOljKLvyUz27X9fQU
         YfHX3xZm8JvM6DmAifO+xgJOqxDiR5gejW0UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699567589; x=1700172389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y82BzpTv7cyl6IIFop0Gnim+2ptsxtHU/vEQvoxXaNs=;
        b=GC8W/lex6aYADcHNTf7FfTsmVXNcMG+CsQ2WBiHqxqd5NBC0Z0k3Ox7Xi/Q96Gv8GR
         qxyL7VeBlrLsIQv6jP57SdgIQJhSSEAYU1J10uMc+C3yveO9TgYJ10gMJ+/OfcprJx/6
         dRfsTvWZq/K+SHAL8V65XHmnwKLm1uIDS8xx6dpFc9j4EI8y9/KtY/w4OHNRdb9iy3pc
         CM3rYH/awdTiCOTs9MVn9H/11lRoG0vsP6rqzsNKyFfZyS4QuWN6X2cNmKDPLv1UEsgk
         gmJUekjRcOoBKwEOgYh/xMzVD4rthKZsJNBvFIBIPG8gf4DvLXrXrh0MhVQaydBLPsYS
         geWA==
X-Gm-Message-State: AOJu0Yw8vFrbG9+6feJGXhXKRbnywlPp+jGlXfAT3EdgtQ5JV1pTux8z
        ewJqcvlngoYS+q+pvkF86Md4H439jRWLfxlzcWRJDw==
X-Google-Smtp-Source: AGHT+IFeTv9PsRIjWmBwBsUwPnc6zZPEDNvj9QpWg9MmxhaN1UFgmaCHycQ3fFPEovE7gY/7EEcVGovjf8TQuwGAUiY=
X-Received: by 2002:ac2:54b9:0:b0:509:4814:ed7a with SMTP id
 w25-20020ac254b9000000b005094814ed7amr2332565lfk.36.1699567589352; Thu, 09
 Nov 2023 14:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20231109191355.27738-3-james.quinlan@broadcom.com> <20231109212703.GA491818@bhelgaas>
In-Reply-To: <20231109212703.GA491818@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 9 Nov 2023 17:06:15 -0500
Message-ID: <CA+-6iNxKavvTthcpWeMTu5FfeqZhvMbALK1WwdRqQhivHJFWTQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007577550609bf6a77"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--0000000000007577550609bf6a77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 4:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Nov 09, 2023 at 02:13:53PM -0500, Jim Quinlan wrote:
> > The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must =
be
> > deliberately set by the PCIe RC HW into one of three mutually exclusive
> > modes:
> >
> > "safe" -- No CLKREQ# expected or required, refclk is always provided.  =
This
> >     mode should work for all devices but is not be capable of any refcl=
k
> >     power savings.
> >
> > "no-l1ss" -- CLKREQ# is expected to be driven by the downstream device =
for
> >     CPM and ASPM L0s and L1.  Provides Clock Power Management, L0s, and=
 L1,
> >     but cannot provide L1 substate (L1SS) power savings. If the downstr=
eam
> >     device connected to the RC is L1SS capable AND the OS enables L1SS,=
 all
> >     PCIe traffic may abruptly halt, potentially hanging the system.
> >
> > "default" -- Bidirectional CLKREQ# between the RC and downstream device=
.
> >     Provides ASPM L0s, L1, and L1SS, but not compliant to provide Clock
> >     Power Management; specifically, may not be able to meet the Tclron =
max
> >     timing of 400ns as specified in "Dynamic Clock Control", section
> >     3.2.5.2.2 of the PCIe spec.  This situation is atypical and should
> >     happen only with older devices.
>
> The PCIe base spec r6.0 has no section 3.2.5.2.2.  Looks like this
> could be:
>
>   PCIe Mini CEM r2.1, sec 3.2.5.2.2 (December, 2016), or
>   PCIe CEM r5.1, sec 2.8.2 (August, 2023)
>
> I don't know the relationship between the "Mini CEM" and the "CEM"
> specs, but CEM r5.1 seems to have the same text as the Mini CEM r2.1
> about Dynamic Clock Control.
>
> We're hampered by the lack of clear subscripts here, but the text in
> both capitalizes the "CRL" part, e.g., "T_CLRon".
>
> > Previously, this driver always set the mode to "no-l1ss", as almost all
> > STB/CM boards operate in this mode.  But now there is interest in
> > activating L1SS power savings from STB/CM customers, which requires "as=
pm"
> > mode.  In addition, a bug was filed for RPi4 CM platform because most
> > devices did not work in "no-l1ss" mode.
> >
> > Note that the mode is specified by the DT property "brcm,clkreq-mode". =
 If
> > this property is omitted, then "default" mode is chosen.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 65 ++++++++++++++++++++++-----
> >  1 file changed, 55 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index f9dd6622fe10..f45c5d0168d3 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -121,9 +121,12 @@
> >
> >  #define PCIE_MISC_HARD_PCIE_HARD_DEBUG                                =
       0x4204
> >  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK     0=
x2
> > +#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK             0=
x200000
> >  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK             0=
x08000000
> >  #define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK        =
       0x00800000
> > -
> > +#define  PCIE_CLKREQ_MASK \
> > +       (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
> > +        PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
> >
> >  #define PCIE_INTR2_CPU_BASE          0x4300
> >  #define PCIE_MSI_INTR2_BASE          0x4500
> > @@ -1028,13 +1031,61 @@ static int brcm_pcie_setup(struct brcm_pcie *pc=
ie)
> >       return 0;
> >  }
> >
> > +static void brcm_config_clkreq(struct brcm_pcie *pcie)
> > +{
> > +     static const char err_msg[] =3D "invalid 'brcm,clkreq-mode' DT st=
ring\n";
> > +     const char *mode =3D "default";
> > +     u32 clkreq_cntl;
> > +     int ret;
> > +
> > +     ret =3D of_property_read_string(pcie->np, "brcm,clkreq-mode", &mo=
de);
> > +     if (ret && ret !=3D -EINVAL) {
> > +             dev_err(pcie->dev, err_msg);
> > +             mode =3D "safe";
> > +     }
> > +
> > +     /* Start out assuming safe mode (both mode bits cleared) */
> > +     clkreq_cntl =3D readl(pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG=
);
> > +     clkreq_cntl &=3D ~PCIE_CLKREQ_MASK;
> > +
> > +     if (strcmp(mode, "no-l1ss") =3D=3D 0) {
> > +             /*
> > +              * "no-l1ss" -- Provides Clock Power Management, L0s, and
> > +              * L1, but cannot provide L1 substate (L1SS) power
> > +              * savings. If the downstream device connected to the RC =
is
> > +              * L1SS capable AND the OS enables L1SS, all PCIe traffic
> > +              * may abruptly halt, potentially hanging the system.
> > +              */
> > +             clkreq_cntl |=3D PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DE=
BUG_ENABLE_MASK;
>
> Does this somehow change the features advertised by the Root Port,
> e.g., does it hide the L1 PM Substates Capability completely, or at
> least clear the L1 PM Substates Supported bit?

>
> It it doesn't, the PCI core may enable L1SS and cause this hang.
> Every feature advertised in config space is expected to work.
Agree, I'll put this back in and also reconcile your other comments.

BTW, besides the RPi4, I haven't been able to find a Linux platform
where I can do

        echo $POLICY > /sys/module/pcie_aspm/parameters/policy

It seems that the FW/ACPI typically locks this down.  I did see a
comment somewhere that
said that the reason it was locked down is because too many devices
cannot handle it.
FWIW.

Regards,
Jim Quinlan
Broadcom STB/CM

>
> > +     } else if (strcmp(mode, "default") =3D=3D 0) {
> > +             /*
> > +              * "default" -- Provides L0s, L1, and L1SS, but not
> > +              * compliant to provide Clock Power Management;
> > +              * specifically, may not be able to meet the Tclron max
> > +              * timing of 400ns as specified in "Dynamic Clock Control=
",
> > +              * section 3.2.5.2.2 of the PCIe spec.  This situation is
> > +              * atypical and should happen only with older devices.
> > +              */
> > +             clkreq_cntl |=3D PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENAB=
LE_MASK;
> > +     } else {
> > +             /*
> > +              * "safe" -- No power savings; refclk is driven by RC
> > +              * unconditionally.
> > +              */
> > +             if (strcmp(mode, "safe") !=3D 0)
> > +                     dev_err(pcie->dev, err_msg);
> > +             mode =3D "safe";
> > +     }
> > +     writel(clkreq_cntl, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > +     dev_info(pcie->dev, "clkreq-mode set to %s\n", mode);
> > +}
> > +
> >  static int brcm_pcie_start_link(struct brcm_pcie *pcie)
> >  {
> >       struct device *dev =3D pcie->dev;
> >       void __iomem *base =3D pcie->base;
> >       u16 nlw, cls, lnksta;
> >       bool ssc_good =3D false;
> > -     u32 tmp;
> >       int ret, i;
> >
> >       /* Unassert the fundamental reset */
> > @@ -1059,6 +1110,8 @@ static int brcm_pcie_start_link(struct brcm_pcie =
*pcie)
> >               return -ENODEV;
> >       }
> >
> > +     brcm_config_clkreq(pcie);
> > +
> >       if (pcie->gen)
> >               brcm_pcie_set_gen(pcie, pcie->gen);
> >
> > @@ -1077,14 +1130,6 @@ static int brcm_pcie_start_link(struct brcm_pcie=
 *pcie)
> >                pci_speed_string(pcie_link_speed[cls]), nlw,
> >                ssc_good ? "(SSC)" : "(!SSC)");
> >
> > -     /*
> > -      * Refclk from RC should be gated with CLKREQ# input when ASPM L0=
s,L1
> > -      * is enabled =3D> setting the CLKREQ_DEBUG_ENABLE field to 1.
> > -      */
> > -     tmp =3D readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > -     tmp |=3D PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
> > -     writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> > -
> >       return 0;
> >  }

--0000000000007577550609bf6a77
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA5azFL0FHZ2PzqvV9OUX2pImZDk+cQ
jgkLPHnLr47eIzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzEx
MDkyMjA2MjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAmX+6vmDShXvSKks1uRYEhpEwN1UnB8WXPUXmLdI008hEL7fz
d9kHpnwD+UqZDcM2dlSr1hBMqogsuQusRafm6jwepyC1Kg5pMCNGDp+fYz+I32vxYZUXbVmF4sZq
adewGODTT6Zvz0FnGuxuiVNmOwZrSzHOEhFpZiNihwYDAmP0bRfk3ISo/SDn2E+pMAGrX+4LO2h7
mKuDEH6hM65E9lIT1eYTiR9jUS+VdkSlrbtmMd8Vx1mTiCyytu+OC4Ai8rVnc/JCQ4HmZGmjG02O
HnOrS69ZWoyYHfJIR0sp75U41+NjpYt+mAmB5e4Be9JXMTcA2KfvP0Acw8eaHPZmOg==
--0000000000007577550609bf6a77--
