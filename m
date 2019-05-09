Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585E618BE5
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEIOe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:34:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIOe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:34:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so3413579wrq.1;
        Thu, 09 May 2019 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4w4DTndeQ/6WA6sZLNm1mQcuIPr4s7Ze9vyCYSUFt+4=;
        b=dm04I8RDlBfxT6Jr8PH4EiNyEMeFsOqPu1vs8EOD2JjFbneka6dy4xg8sp6xcUkG0P
         b29Hq0z0dtnOzhS4wGsTwbuMHmvGPJBkchGx7kRtuDgHoFghWmy7BlwqhZqcGtH7vqHq
         LNjy88Wn7RJ7s99Am7mt18j0BWGTHtF0XEMZGJ5X+y/NI+h8enAbejPHwNLQ18IKhKc5
         /jSfOL2AMELYVhRwuHu+93kE9QsOe5bziQm3rjGnUZQY5hABxPGIp5ivcLxXz6xTzY3Y
         oUL/Xc0iUYNNuy3J44As1eERC7zLKxyZN4hN1j3kQ8Rkf2o+cS2SeFekgNwTft97CjeW
         s3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4w4DTndeQ/6WA6sZLNm1mQcuIPr4s7Ze9vyCYSUFt+4=;
        b=qceeh+hWjwMERNV1bEtbJwDHrCQ2Bj8QZZ6M+fvCYPKqtNFGtskJdqMwT4Dligyids
         PBw80zBncLM7iUvspj3Nfu1GoCHZh9dtA3NpinzsBWdf/aeRMdpvpHtad3VRnhHV6XGE
         5sEBTHN8uGoBzcRsxDldEDSeyzsR+/8p6txe0/8oo4B/VgFWgDNFGjllx6j4or1AN4wD
         v1rfnIMyBAwK0IIyri/V6y8zk6ekLpegU2vFpSeuhYQNvwdIjf3g1C6zMoNiU/TeFpNT
         TtBP28h7mOgZzQyKhVul+smFQaOcYRKo1dRF/Km/GHB8rF/wMp+NwTc3GovwygloVpbw
         VlIA==
X-Gm-Message-State: APjAAAVLLn3NoKzrJTkNhf9sdOrXUuNKWYSvqjAkEA/0MFtHQU76Axms
        U7yLRMXc/tX6jtjaoJdDj3Q=
X-Google-Smtp-Source: APXvYqzu1s425fIFwntOgkrWpOjD4mught9+mDCKO3jbWZuZIEJPfOeKhXEeKlnneIFWIZ40KEThUg==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr3591438wrn.128.1557412466260;
        Thu, 09 May 2019 07:34:26 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u8sm3612880wmj.27.2019.05.09.07.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:34:25 -0700 (PDT)
Date:   Thu, 9 May 2019 16:34:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190509143424.GR8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-23-mmaddireddy@nvidia.com>
 <20190423202430.GC14616@google.com>
 <5043c67a-1d21-efcd-63ca-7feb270f9fb0@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WTbgq2twYBxfsYA6"
Content-Disposition: inline
In-Reply-To: <5043c67a-1d21-efcd-63ca-7feb270f9fb0@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--WTbgq2twYBxfsYA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 09:21:07AM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 24-Apr-19 1:54 AM, Bjorn Helgaas wrote:
> > On Tue, Apr 23, 2019 at 02:58:19PM +0530, Manikanta Maddireddy wrote:
> >> Add PCIe link up check in config read and write callback functions
> >> before accessing endpoint config registers.
> > I mentioned before:
> >
> >   We need to either eradicate this pattern of checking for link up, or
> >   include a comment about why it is absolutely necessary.
> >
> > I still think this check should be unnecessary, but if you really
> > think you need it, at least add the comment.
> Sorry, I missed to add comment in V2. I will take care of it in V3.

Please make sure to explain when exactly this happens. I've never seen
this happen before and I don't understand what circumstances could lead
to this.

Thierry

>=20
>=20
> Manikanta
>=20
> >
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
> >>
> >>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controll=
er/pci-tegra.c
> >> index 8ba71e314b1b..05586672a221 100644
> >> --- a/drivers/pci/controller/pci-tegra.c
> >> +++ b/drivers/pci/controller/pci-tegra.c
> >> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie *p=
cie, unsigned long offset)
> >>  	return readl(pcie->pads + offset);
> >>  }
> >> =20
> >> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
> >> +{
> >> +	u32 value;
> >> +
> >> +	value =3D readl(port->base + RP_LINK_CONTROL_STATUS);
> >> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
> >> +}
> >> +
> >>  /*
> >>   * The configuration space mapping on Tegra is somewhat similar to th=
e ECAM
> >>   * defined by PCIe. However it deviates a bit in how the 4 bits for e=
xtended
> >> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struct p=
ci_bus *bus,
> >>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int d=
evfn,
> >>  				  int where, int size, u32 *value)
> >>  {
> >> +	struct tegra_pcie *pcie =3D bus->sysdata;
> >> +	struct pci_dev *bridge;
> >> +	struct tegra_pcie_port *port;
> >> +
> >>  	if (bus->number =3D=3D 0)
> >>  		return pci_generic_config_read32(bus, devfn, where, size,
> >>  						 value);
> >> =20
> >> +	bridge =3D pcie_find_root_port(bus->self);
> >> +
> >> +	list_for_each_entry(port, &pcie->ports, list)
> >> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> >> +			break;
> >> +
> >> +	/* If there is no link, then there is no device */
> >> +	if (!tegra_pcie_link_up(port)) {
> >> +		*value =3D 0xffffffff;
> >> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >> +	}
> >> +
> >>  	return pci_generic_config_read(bus, devfn, where, size, value);
> >>  }
> >> =20
> >>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int =
devfn,
> >>  				   int where, int size, u32 value)
> >>  {
> >> +	struct tegra_pcie *pcie =3D bus->sysdata;
> >> +	struct tegra_pcie_port *port;
> >> +	struct pci_dev *bridge;
> >> +
> >>  	if (bus->number =3D=3D 0)
> >>  		return pci_generic_config_write32(bus, devfn, where, size,
> >>  						  value);
> >> =20
> >> +	bridge =3D pcie_find_root_port(bus->self);
> >> +
> >> +	list_for_each_entry(port, &pcie->ports, list)
> >> +		if (port->index + 1 =3D=3D PCI_SLOT(bridge->devfn))
> >> +			break;
> >> +
> >> +	/* If there is no link, then there is no device */
> >> +	if (!tegra_pcie_link_up(port))
> >> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >> +
> >>  	return pci_generic_config_write(bus, devfn, where, size, value);
> >>  }
> >> =20
> >> --=20
> >> 2.17.1
> >>
>=20

--WTbgq2twYBxfsYA6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOnAACgkQ3SOs138+
s6ECsxAAuyaGWZDxThXi1GKxyIQ1NXEI8Dp9GZTq9aJ0B4W2G5ktYmxqDsXagWSm
3BqtbgTIQ6OCNZjvTTZNl2DiW/IWmA3QQ4mgVw08+XKuzGvt9pbBuLzwMStOU164
qqly7bbigtCSsxtyueGi0nIeDJWjt2LlILvcrjzWB43O+VtVmpGRT4f/zNly2jhS
0wEWlNR//zN5OBwghoh0XKHP3kBxVRmvw+1kLhwtE5IFkQXIAWxqyesKxki1+BY3
L2K0N6y7igwc7oWHADBSxyejXJ2pMJyZXLjJgLW3hlD9ECH1iXK5augJhK92Bwai
78P1OFXL+FHYss7hMyunWGs8s1b+39jWwER8BZOkUTrhNNsdyPFbAX/r56zEemAL
fUu/nOZGhv4FRRBVmvJweRj5LcZIpiapzWSGuGiW3WeO0cMaJhdd3rQzRT9+nBgg
u4gCh5ro5CkOEHg3pKw+L1vWZXhCAgASw4eRNGP/EC6pb/ezC9CqU1kSxdw7FA9m
4jGmFLhJex8jH2pcUjtMdKsCdoQTP+P4H28XKglsttXO6BkO3mEeE9BX5H3x7Rec
fslZhk5TBmLstSIocwDoZiNNGJ1hbVIsvVW1XC4AbIt7fzlIK396pKIAMPl1zv6R
n4+UvKG/r7Vv1vAEwe5Lks/A29u36C70Xit6ytk1z3VM3KjRBrU=
=T0ew
-----END PGP SIGNATURE-----

--WTbgq2twYBxfsYA6--
