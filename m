Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD40F1C750E
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgEFPgz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 11:36:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40407 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgEFPgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 11:36:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A3BCF58032B;
        Wed,  6 May 2020 11:36:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 May 2020 11:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/+05KqBTk3oydVggvk0oaQyCPAJ
        z1Y/tOkrcMC1KWGU=; b=dYMsW87kzQdTYVzBdsHEEWUk+IY0JF5You9OLDT0Plf
        bjPLfchBAW+G3HReL9Ft0Yfc9GNlDMFzQTv9rce9eVI+Qs6xSqw1/KDwNng44Stc
        44k5Mj5hXWzWpCDyd9MPU7HRi/9OWXUag+9V9IfUrsfwNmIuZW8V33H2jVKJofBA
        +RDI+3yqD6rBVx4u36C65xL/8TpyJeqvQRhmtcBHaIwFz6DC6/WHIxVSglCE1zzv
        FSzwQ9MypkyDIVOEb/P/bzN7cFoygVZd6TMP7pHshw7pf1jVdYyOJJ+lqMei4K29
        9b5/bbhyzHCQN6nMeaRdVXyEIkbBlbMSFhLOTAhlJTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/+05Kq
        BTk3oydVggvk0oaQyCPAJz1Y/tOkrcMC1KWGU=; b=QVJBUdD+tRrFspsGcUoA2F
        PoD0sa7ltQTt4QsnvkUQSaO3LL+S3/rG7CMvrFmVeDRYgAqQ1+BeS8SPjLY0hYi4
        EkMHkLDFPY0+kE4xdWuRSaISvGvZSKyENuV6SDNVy2xysZJsSiMz7bbw1qV++Wd2
        eqSlhLMObAED8BZFQ9gpgwPSwmrr0GeemNFLmEiUSO8OCNQMhujg/EPIax6evtyP
        NJ0EE1S1vFIElq+GKgPcBjaQ2Y4lyWvW/K3TsI2/mgzeDAz3RlvroOsKG7mg2EIE
        YfkpyICiEFCK6w5rJpifKeEDJU4uv6dVDyJyC9/buFRhUigfalit1BJPhwQ8Jkwg
        ==
X-ME-Sender: <xms:lNmyXgqrCcQNdAIPVuBzajR5lgSq-T-q887yRciGH4wQ7POZKR97Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeekgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeethfeiueffueeikeeifefhheeijeeigfelteehheetjeekueevtdfhlefhgfdt
    ieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgrrhhmsghirghnrdgtohhmnecukf
    hppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lNmyXhlmALE-N71etmI62IoUcm6VIVJqxnhmcYUGF8GOjgbHXwZvDQ>
    <xmx:lNmyXn3UCN8LilgAP3FDW-4A8rSV_1Cj31Jy1FI5Wtoom_IQAPRjog>
    <xmx:lNmyXmp7l0HhvY1DRQ0pIQia1SN6AJdaFGDpEl1IA3fHLvkLB_vhEg>
    <xmx:ldmyXvedgtdvWjzIrDy8oNd09iM8YIUKOKz54FJdGSAdnYSixBEKLA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F3E8328006C;
        Wed,  6 May 2020 11:36:52 -0400 (EDT)
Date:   Wed, 6 May 2020 17:36:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH] PCI: dwc: add support for Allwinner SoCs' PCIe
 controller
Message-ID: <20200506153649.ahzlhcquyhnggbou@gilmour.lan>
References: <20200402160549.296203-1-icenowy@aosc.io>
 <20200406082732.nt5d7puwn65j4nvl@gilmour.lan>
 <13564b9a57f734524357a26665c48211e436e305.camel@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p2kmtjzg5nllbilb"
Content-Disposition: inline
In-Reply-To: <13564b9a57f734524357a26665c48211e436e305.camel@aosc.io>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--p2kmtjzg5nllbilb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 04:18:58PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2020-04-06=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:27 +0200=EF=
=BC=8CMaxime Ripard=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >=20
> > On Fri, Apr 03, 2020 at 12:05:49AM +0800, Icenowy Zheng wrote:
> > > The Allwinner H6 SoC uses DesignWare's PCIe controller to provide a
> > > PCIe
> > > host.
> > >=20
> > > However, on Allwinner H6, the PCIe host has bad MMIO, which needs
> > > to be
> > > workarounded. A workaround with the EL2 hypervisor functionality of
> > > ARM
> > > Cortex cores is now available, which wraps MMIO operations.
> > >=20
> > > This patch is going to add a driver for the DWC PCIe controller
> > > available in Allwinner SoCs, either the H6 one when wrapped by the
> > > hypervisor (so that the driver can consider it as an ordinary PCIe
> > > controller) or further not buggy ones.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > ---
> > > There's no device tree binding patch available, because I still
> > > have
> > > questions on the device tree compatible string. I want to use it to
> > > describe that this driver doesn't support the "native Allwinner H6
> > > PCIe
> > > controller", but a wrapped version with my hypervisor.
> > >=20
> > > I think supporting a "para-physical" device is some new thing, so
> > > this
> > > patch is RFC.
> > >=20
> > > My hypervisor is at [1], and some basic usage documentation is at
> > > [2].
> > >=20
> > > [1] https://github.com/Icenowy/aw-el2-barebone
> > > [2]=20
> > > https://forum.armbian.com/topic/13529-a-try-on-utilizing-h6-pcie-with=
-virtualization/
> >=20
> > I'm a bit concerned to throw yet another mandatory, difficult to
> > update, component in the already quite long boot chain.
> >=20
> > Getting fixes deployed in ATF or U-Boot is already pretty long,
> > having
> > another component in there will just make it worse, and it's another
> > hard to debug component that we throw into the mix.
> >=20
> > And this prevents any use of virtualisation on the platform.
> >=20
> > I haven't found an explanation on what that hypervisor is doing
> > exactly, but from a look at it it seems that it will trap all the
> > accesses to the PCIe memory region to emulate a regular space on top
> > of the restricted one we have?
> >=20
> > If so, can't we do that from the kernel directly by using a memory
> > region that always fault with a fault handler like Framebuffer's
> > deferred_io is doing (drivers/video/fbdev/core/fb_defio.c) ?
>=20
> I don't know well about the memory management of the kernel. However,
> for PCIe memory space, the kernel allows simple ioremap() on it. So
> wrapping it shouldn't be so easy.

I'm not sure this would cause any trouble, it's worth exploring I guess. Th=
is
would solve all the current shortcomings.

Maxime
>

--p2kmtjzg5nllbilb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrLZkQAKCRDj7w1vZxhR
xdzrAP9eNr9KcfU2kbvxMpWxzsG/4z0BCVJuoyB9oqqcCJ+rSgEA8LASQMw0yBXS
EWoo2T8XCMOXkT+flamRrPJwfGv3/AQ=
=oD3G
-----END PGP SIGNATURE-----

--p2kmtjzg5nllbilb--
