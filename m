Return-Path: <linux-pci+bounces-7260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9D8C03D6
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 19:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC50DB24B1A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E920309;
	Wed,  8 May 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xn1urmVD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC4C12C464
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190940; cv=none; b=DjU5B7NgS8bQ0c1Rrh1T6g3VJVV2HbV8Pa+pCD5AUryzNFuDe3xdDYTse2b97QITQpGYxM/TqRGvOR3WmMxHWXsQyufGQPikfzIKtJRM/X41RR8+nGmgKnoLKFXxBJKsS8qKbJRNHcUh9rxKXPAhrL1DTUgoL0F0Jjs91g/7iyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190940; c=relaxed/simple;
	bh=/QflDND2SpVRCHyCeAWHoA/Ee0Cr4TPi38wA5B/+Ipg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELkLt6s9GqSLD4V3Qn9xACM2YhOkmEiXUYkeE9A1gIyqImv0wdsvbPxQqAZ2EUPOxHd0HY4/k451ai4K13WGHZtGhcnmbAAUixcpW2wrKpCzn1kzxD8i9L7mVSMAdzUYehxVBGuN1NBPaF+ouPhoo4mRP5ELXPOFQoRNQ+EBZ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xn1urmVD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f60817e34so5578197e87.2
        for <linux-pci@vger.kernel.org>; Wed, 08 May 2024 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715190937; x=1715795737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HMDrXxcBlMugfjN2erKKywhVgbF9Lq7ACCUIAkzuvZk=;
        b=Xn1urmVDjab0588yLP0Zg3Od+WEuT896HXgntt63cZBWXx5MyCmPdNge1LLIJwuAlU
         DxlcN3c2CrIwrRidHD8SugsDzWtfKY1B5Hud46MdxV77v12zY1H463cea7qt9KBaAUZo
         tbLK5aAQ2z2XeyNQKldNhHAsbg4qM2Zcrm2+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715190937; x=1715795737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMDrXxcBlMugfjN2erKKywhVgbF9Lq7ACCUIAkzuvZk=;
        b=SGrxpPp2t348vApMCUC13iDF4qX0+o0clUdLQWuEisW7BJ/dDdHfTIzmtDDA/rdiZJ
         iwWEsr9okt64lmfnhCqZ7UJInRIxLHOO4p5wD1hIKU2EMYW7Zj3uTJGHykiHsl7XZQd/
         RGqcxYeHIoFip3SYlqFSGSExFqBWzNqHttJmvv+u4rSKf/3AH3pSeEmIgMomUw9cbkS6
         vkQYwnCnqaa1sLjAR8SQTMQdoYECB2GBkdpXn35VsyiUMkH5P+zh4kyHJannwe918rEg
         FWQu2+qj+GW8ZgCTcSlMJw+xjeWidJv+2D2N6j6zleBtewVyHgFhmTeownTk+ReVE8jy
         LRsw==
X-Gm-Message-State: AOJu0YwGZJGZZ+aeqSE0rmLpkAKLYf2iRo3fL8dhhpkFD2keyOh58+g4
	T6ZxjHzuIlc5ppfSxsiFNXCnXMxtxG4/l6foIuBGUJL6F3vrrznHe1mPbcoYtG3xdBTiL8fhYlb
	pc7tUMqO19F0xY1BMXsGaWUNrr/C6wdfbfUBh
X-Google-Smtp-Source: AGHT+IGKhxSyqp746HzlQERCUl8CNd2z8ip666Qe3qRrj0441mZ3ZrOYamIDCC8C914GUOAqgi9tppoZ1i39ghwtcos=
X-Received: by 2002:ac2:4e97:0:b0:519:2c84:2405 with SMTP id
 2adb3069b0e04-5217cc42bbamr1948485e87.44.1715190936604; Wed, 08 May 2024
 10:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403213902.26391-5-james.quinlan@broadcom.com> <20240506232031.GA1714174@bhelgaas>
In-Reply-To: <20240506232031.GA1714174@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Wed, 8 May 2024 13:55:24 -0400
Message-ID: <CA+-6iNxEZm=axRAeeAKwxemjEdjjmJYTUs8nThp_NDohXcV5Jg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, Phil Elwell <phil@raspberrypi.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008672e70617f50296"

--0000000000008672e70617f50296
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 7:20=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Apr 03, 2024 at 05:39:01PM -0400, Jim Quinlan wrote:
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
>
> s/refclk is always provided/the Root Port always supplies Refclk/
>
> At least, I assume that's what this means?  The Root Port always
> supplies Refclk regardless of whether a downstream device deasserts
> CLKREQ#?
>
> The patch doesn't do anything to prevent aspm.c from setting
> PCI_EXP_LNKCTL_CLKREQ_EN, so it looks like Linux may still set the
> "Enable Clock Power Management" bit in downstream devices, but the
> Root Port just ignores the CLKREQ# signal, right?
>
> s/is not be/is not/
>
> > "no-l1ss" -- CLKREQ# is expected to be driven by the downstream device =
for
> >     CPM and ASPM L0s and L1.  Provides Clock Power Management, L0s, and=
 L1,
> >     but cannot provide L1 substate (L1SS) power savings. If the downstr=
eam
> >     device connected to the RC is L1SS capable AND the OS enables L1SS,=
 all
> >     PCIe traffic may abruptly halt, potentially hanging the system.
>
> s/CPM/Clock Power Management (CPM)/ and then you can use "CPM" for the
> *second* reference here.
>
> It *looks* like we should never see this PCIe hang because with this
> setting you don't advertise L1SS in the Root Port, so the OS should
> never enable L1SS, at least for that link.  Right?
>
> If we never enable L1SS in the case where it could cause a hang, why
> mention the possibility here?

Hello Bjorn,

I will remove this.

>
> I assume that if the downstream device is a Switch, L1SS is unsafe for
> the Root Port to Switch link, but it could still be used for the link
> between the Switch and whatever is below it?
Yes.  The "brcm,clkreq-mode" only applies to the root complex and the
device to which it is connected.

>
> > "default" -- Bidirectional CLKREQ# between the RC and downstream device=
.
> >     Provides ASPM L0s, L1, and L1SS, but not compliant to provide Clock
> >     Power Management; specifically, may not be able to meet the T_CLRon=
 max
> >     timing of 400ns as specified in "Dynamic Clock Control", section
> >     3.2.5.2.2 of the PCIe Express Mini CEM 2.1 specification.  This
> >     situation is atypical and should happen only with older devices.
>
> IIUC this T_CLRon timing issue is with the STB/CM *Root Port*, but the
> last sentence refers to "older devices," which sounds like it means
> "older devices that might be plugged into the Root Port."  That would
> suggest the issue is with those devices, not iwth the STB/CM Root
> Port.
According to the PCIe HW designer, more modern chips have extra circuitry
to overcome this issue.  I really do not know if this is the case, nor am I
sure that he knows for sure.  But the spec says that T_CLRon should meet
a certain value, and this RC cannot do that in some situations.

>
> Or maybe this is meant to refer to older STB/CM Root Ports?
>
> > Previously, this driver always set the mode to "no-l1ss", as almost all
> > STB/CM boards operate in this mode.  But now there is interest in
> > activating L1SS power savings from STB/CM customers, which requires
> > "default" mode.  In addition, a bug was filed for RPi4 CM platform beca=
use
> > most devices did not work in "no-l1ss" mode (see link below).
>
> I'm having a hard time reconciling "almost all STB/CM boards operate
> in 'no-l1ss' mode" with "most devices did not work in 'no-l1ss' mode."
> They sound contradictory.

I concur, it is no longer clear to me why some device+board+connector
combos work
in "no-l1ss" mode and not in "default mode", and vice versa.  Our
existing boards
work in "no-l1ss" mode and the RPi CM HW works fine with "default"
mode (l1ss possible).

This is not just due to older devices, although I've noticed that a
lot of older devices
have no trace connected to their CLKREQ# pin, and the signal is left floati=
ng.
Another thing that has recently surfaced is that some of our board
designs are using a unidirectional level-shifter for CLKREQ#, which is
a bidirectional signal.  This may be causing mayhem.  Another issue is
that some if not a majority of the
adapters I use to test PCIe devices on a board with a socket interfere
with the CLKREQ# signal;
e.g. some adapters ground it, leading me to believe that systems are
working when
they would not if CLKREQ# was not grounded.

I have not enumerated all of the reasons for which
brcm,clkreq-mode setting will make a device+board+connector combo work or n=
ot.
But I do know that being able to configure these modes is a must-have
requirement.  I also
know that the "default" setting I am proposing is the same configuration
that is used by the RaspberryPi folks with RaspianOS.  The STB consumers ha=
ve no
problem changing the DT property if required.  Similarly, a Linux
enthusiast should be
able to set  the brcm,clkreq-mode property to "safe" if they are
having PCIe issues,
just like they may configure  CONFIG_PCIE_BUS_SAFE=3Dy.

Please keep in mind that currently the upstream Linux will not run on
an Rpi CM board until
this submission or something like it is accepted.

TL;DR  Let me rewrite this text and resubmit.

>
> > Note that the mode is specified by the DT property "brcm,clkreq-mode". =
 If
> > this property is omitted, then "default" mode is chosen.
>
> As a user, how do I determine which setting to use?
Using the "safe" mode will always work.  In fact I considered making
this the default mode.
As I said, I cannot enumerate all of the reasons why one mode works and one=
 does
not for a particular device+board+connector combo.  The HW folks have not r=
eally
been forthcoming on the reasons as well.

>
> Trial and error?  If so, how do I identify the errors?
Either PCIe link-up is not happening, or it is happening but the
device driver is non-functional
and boot typically  hangs.

>
> Obviously "default" is the best, so I assume I would try that first.
> If something is flaky (whatever that means), I would fall back to
> "no-l1ss", which gets me Clock PM, L0s, and L1, right?  In what
> situation does "no-l1ss" fail, and how do I tell that it fails?

For example,"no-l1ss" fails on the Rpi CM.  Perhaps the reason for that
is that the CLKREQ# signal is left floating  and some devices do not connec=
t
their CLKREQ# pin.  But I am not sure of that -- I do not have access to
the signals and I do not have the requisite RPi CM design info.

Regards,
Jim Quinlan
Broadcom STB/CM


>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 79 ++++++++++++++++++++++++---
> >  1 file changed, 70 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/contro=
ller/pcie-brcmstb.c
> > index 3d08b92d5bb8..3dc8511e6f58 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -48,6 +48,9 @@
> >  #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY                    0x04dc
> >  #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK 0xc00
> >
> > +#define PCIE_RC_CFG_PRIV1_ROOT_CAP                   0x4f8
> > +#define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK   0xf8
> > +
> >  #define PCIE_RC_DL_MDIO_ADDR                         0x1100
> >  #define PCIE_RC_DL_MDIO_WR_DATA                              0x1104
> >  #define PCIE_RC_DL_MDIO_RD_DATA                              0x1108
> > @@ -121,9 +124,12 @@
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
> > @@ -1100,13 +1106,73 @@ static int brcm_pcie_setup(struct brcm_pcie *pc=
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
> > +     int ret, tmp;
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
> > +             /*
> > +              * We want to un-advertise L1 substates because if the OS
> > +              * tries to configure the controller into using L1 substa=
te
> > +              * power savings it may fail or hang when the RC HW is in
> > +              * "no-l1ss" mode.
> > +              */
> > +             tmp =3D readl(pcie->base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
> > +             u32p_replace_bits(&tmp, 2, PCIE_RC_CFG_PRIV1_ROOT_CAP_L1S=
S_MODE_MASK);
> > +             writel(tmp, pcie->base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
> > +
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
> > +
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
> > +
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
> > @@ -1138,6 +1204,8 @@ static int brcm_pcie_start_link(struct brcm_pcie =
*pcie)
> >        */
> >       brcm_extend_internal_bus_timeout(pcie, BRCM_LTR_MAX_NS + 1000);
> >
> > +     brcm_config_clkreq(pcie);
> > +
> >       if (pcie->gen)
> >               brcm_pcie_set_gen(pcie, pcie->gen);
> >
> > @@ -1156,13 +1224,6 @@ static int brcm_pcie_start_link(struct brcm_pcie=
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
> >
> >       return 0;
> >  }
> > --
> > 2.17.1
> >
>
>

--0000000000008672e70617f50296
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCvxvfqzpk9K+yKY0bafV2LbpDnTWz3
iQ706DPCgwW4KTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA1
MDgxNzU1MzdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAf9P7fUCECTilY6BX5dhX1SxL6XigyWW/XTSVuHlGUM9eCxxZ
sGpPHCTsRM03MpjGVvcnVg26V4nW/nWMk16JNOQFCHrrhG6VAHhXju9chsQXvBY42vfmJWS/Kk1z
f7lOoU58CttxcV/8yD//1kQ9mXTKb3LrChCM2ykXpKM4OEV6bxjXC4zcHktvcQ7GJZjsLWycbto8
Tsm1VsyfKlV2lHSKmDMpHGCyG+MzACCYzcwIKlcuWebKUNZX9+wKqQ5VzThOxUn1mkvAyZavnYyi
oTJSwFdeabmVBSqQxqL92DWZ30QUl6x1oEpP/StF1fugm70htAdCXSHe3fpGq5XstA==
--0000000000008672e70617f50296--

