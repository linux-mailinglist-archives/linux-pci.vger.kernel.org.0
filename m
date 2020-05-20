Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEF01DB740
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 16:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETOlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 10:41:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETOlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 10:41:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC4A0AD7C;
        Wed, 20 May 2020 14:41:36 +0000 (UTC)
Message-ID: <347f6b51e6ab74ad2ccf1dd60a345ce41b0defb3.camel@suse.de>
Subject: Re: [PATCH 04/15] PCI: brcmstb: Add compatibily of other chips
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 20 May 2020 16:41:31 +0200
In-Reply-To: <CA+-6iNwE7CkD0r7Z0cKGXxE14Unf7ZGsr4q7Z8dPhgYYXHXHEg@mail.gmail.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
         <20200519203419.12369-5-james.quinlan@broadcom.com>
         <5a52e39ce99214877e83104b8ea9f95c0d5b4e90.camel@suse.de>
         <CA+-6iNwE7CkD0r7Z0cKGXxE14Unf7ZGsr4q7Z8dPhgYYXHXHEg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3J5TA+ZbKVPEYhHFoms+"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-3J5TA+ZbKVPEYhHFoms+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-20 at 10:30 -0400, Jim Quinlan wrote:
> On Wed, May 20, 2020 at 7:51 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
[...]
> > > +
> > > +static const struct pcie_cfg_data bcm7278_cfg =3D {
> > > +     .reg_field_info =3D pcie_reg_field_info_bcm7278,
> > > +     .offsets        =3D pcie_offset_bcm7278,
> > > +     .type           =3D BCM7278,
> > > +};
> >=20
> > It's not essential, but if v2 is due I'd suggest factoring out the bcm2=
728
> > specific structures above, and moving them to patch #15. This will keep=
 a
> > clearer division between the patch introducing the infrastructure and t=
he
> > one
> > adding the support for a new device.
> The problem is that one of the commits needs the 7278 type so it has
> to be declared earlier.

Fair enough.

> > > +
> > >  struct brcm_msi {
> > >       struct device           *dev;
> > >       void __iomem            *base;
> > > @@ -176,6 +238,9 @@ struct brcm_pcie {
> > >       int                     gen;
> > >       u64                     msi_target_addr;
> > >       struct brcm_msi         *msi;
> > > +     const int               *reg_offsets;
> > > +     const int               *reg_field_info;
> > > +     enum pcie_type          type;
> > >  };
> > >=20
> > >  /*
> > > @@ -602,20 +667,21 @@ static struct pci_ops brcm_pcie_ops =3D {
> > >=20
> > >  static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pc=
ie,
> > > u32
> > > val)
> > >  {
> > > -     u32 tmp;
> > > +     u32 tmp, mask =3D  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MAS=
K];
> > > +     u32 shift =3D pcie->reg_field_info[RGR1_SW_INIT_1_INIT_SHIFT];
> >=20
> > I don't think you need shift here, IIUC u32p_replace_bits() will take c=
are
> > of
> > all the masking and shifting internally, moreover, you'd be able to dro=
p the
> > shift entry from reg_field_info.
> Got it.
> > > -     tmp =3D readl(pcie->base + PCIE_RGR1_SW_INIT_1);
> > > -     u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_INIT_MASK);
> > > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1);
> > > +     tmp =3D readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > > +     tmp =3D (tmp & ~mask) | ((val << shift) & mask);
> > > +     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > >  }
> >=20
> > Regards,
> > Nicolas
> >=20
> Thanks!
> Jim


--=-3J5TA+ZbKVPEYhHFoms+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7FQZsACgkQlfZmHno8
x/6VQgf/cJT/5x/71u3+htRaslZTFTyUAZQv/3eizMzwVZpl9O6CXq9BBYywwvsh
8Sqil2C6vuPMZSEc2QpkQfSzNgj887ewvXpUIz7nN7igG1lxcStg7WjplO0EBEw5
XXlsbKu7z6Khi5OGhjBvdh/ldGrHMgHQsqlrP+vVPjflwuR0xQWxMnYKoIVZwQlS
vOf6mtBgTpNs/0+9C8L+nk+0nVKAxil0DEyu/Qy2U4Xl75F3aV/2cmG+RUDYFGcu
A1zXTMp9rIYEbth53z12ChDVnGi52c3WrW7Mnh2Hsm9JEqZ+AVAldoymlKRuZPXs
VFFZVSzKSLklY9R193lnxj/GiPV1pw==
=XlCJ
-----END PGP SIGNATURE-----

--=-3J5TA+ZbKVPEYhHFoms+--

