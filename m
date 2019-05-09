Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465AB18BAB
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEIOZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:25:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38411 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIOZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:25:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id f2so3471479wmj.3;
        Thu, 09 May 2019 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QPVJL1hiB63knF8TG35uA+ns00b0bTqcCg9aMQnOMtY=;
        b=KIVEp9OaiSOjQFNfvTRqvL6gTA0tb+94kAqeq6l5rzsuzulzOrJIQtSCHwvcnpSTmI
         rY7m8Y5Rlq6tBbF/j75Gma8eEmysA9hwbOBLWnKVQT55iVQwhLa/suiiO/oLrqJryym1
         GOZwu/JmSaWHG73Qtkuk2BZDHiQ2/aJgpyA2O1/5NKtdr2u5rxIpI6dzHvmZhZw02Pey
         hPdSEDM9IJmlGUqzuBtrx+9DNFdoUzevXycfA0yp48mRXLL2dy4AimKd0Ba7do9xILFp
         gu+JmQir9hrBCh3ETKWCrEM15l/46FhujrR6WdNdWIhoLkSxZ8akyp/lxrAE9NkiDfwo
         J/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QPVJL1hiB63knF8TG35uA+ns00b0bTqcCg9aMQnOMtY=;
        b=h9LCvpY8LZGhCDvh7GsVjsLvIoKqDhLPffamxZ4RmzKzU2p2KU5fef8v0mzSXDmeek
         M3Gelg1xlK7EXAGDyVpp0JDUtHnxczQKlhXeVr+insvXGxUyAhBKZ9DChGVIiZGDLAN5
         /r47QvERsXnXfhcAGQ6m043tRWbx32MnCVW1WNolJp440BKTVfutgIGyxQfqXnDh5WTr
         dbu+xkNJ5q8Fvifd4rxELSMe9dKKxzACb+lewFx/unqyh+qvJABGysaR2uprw+7+F8kI
         XK7qTLakyKrFn8OF7jMNVA9WbsXG/lt/AnulZmjX3vzolxKJcK/igGuQBfw080oKlVTJ
         036w==
X-Gm-Message-State: APjAAAVt+6h2u/yV9xZyXeK02JhMjO3Vh0cekyPI4MiyyoTmfNCbLINp
        4QjcoD7ZkdNY2XSd3PPh/6dEv+pbWlM=
X-Google-Smtp-Source: APXvYqxbWLl01xT4/JOfCdizYGf6FeuQSvmi5bxaKBBPmvViEG2HXvibF5LzvJQIiNSuo2iBPmoT8g==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr3123631wmj.88.1557411912830;
        Thu, 09 May 2019 07:25:12 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id p6sm1348566wrs.6.2019.05.09.07.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:25:11 -0700 (PDT)
Date:   Thu, 9 May 2019 16:25:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 18/28] PCI: tegra: Program AFI_CACHE* registers only
 for Tegra20
Message-ID: <20190509142511.GO8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-19-mmaddireddy@nvidia.com>
 <20190426153219.GE19559@ulmo>
 <600692ae-2a0c-766a-1b8f-827a9c73db36@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eQyCKlb8USywWNtC"
Content-Disposition: inline
In-Reply-To: <600692ae-2a0c-766a-1b8f-827a9c73db36@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--eQyCKlb8USywWNtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 03:00:01PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 26-Apr-19 9:02 PM, Thierry Reding wrote:
> > On Tue, Apr 23, 2019 at 02:58:15PM +0530, Manikanta Maddireddy wrote:
> >> Cacheable upstream transactions are supported in Tegra20 and Tegra186 =
only.
> >> AFI_CACHE* registers are available in Tegra20 to support cacheable ups=
tream
> >> transactions. In Tegra186, AFI_AXCACHE register is defined instead of
> >> AFI_CACHE* to be in line with its MSS design. Therefore, program AFI_C=
ACHE*
> >> registers only for Tegra20.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >> V2: Used soc variable for comparision instead of compatible string.
> >>
> >>  drivers/pci/controller/pci-tegra.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controll=
er/pci-tegra.c
> >> index f74930654443..9b841b0392ac 100644
> >> --- a/drivers/pci/controller/pci-tegra.c
> >> +++ b/drivers/pci/controller/pci-tegra.c
> >> @@ -323,6 +323,7 @@ struct tegra_pcie_soc {
> >>  	bool program_deskew_time;
> >>  	bool raw_violation_fixup;
> >>  	bool update_fc_timer;
> >> +	bool has_cache_bars;
> >>  	struct {
> >>  		struct {
> >>  			u32 rp_ectl_2_r1;
> >> @@ -932,11 +933,13 @@ static void tegra_pcie_setup_translations(struct=
 tegra_pcie *pcie)
> >>  	afi_writel(pcie, 0, AFI_AXI_BAR5_SZ);
> >>  	afi_writel(pcie, 0, AFI_FPCI_BAR5);
> >> =20
> >> -	/* map all upstream transactions as uncached */
> >> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> >> -	afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> >> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> >> -	afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> >> +	if (pcie->soc->has_cache_bars) {
> >> +		/* map all upstream transactions as uncached */
> >> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_ST);
> >> +		afi_writel(pcie, 0, AFI_CACHE_BAR0_SZ);
> >> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_ST);
> >> +		afi_writel(pcie, 0, AFI_CACHE_BAR1_SZ);
> >> +	}
> >> =20
> >>  	/* MSI translations are setup only when needed */
> >>  	afi_writel(pcie, 0, AFI_MSI_FPCI_BAR_ST);
> > You need to squash the below into this patch. If I do that, then
> > TrimSlice works again.
> >
> > Thierry
> Thank you Thierry for verifying the series on T20 and T30.
> I will take care of this comment in V3.
> Please review other patches and provide Ack.

For the record, with the patch below squashed in, this patch is:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> Manikanta
> >
> > --- >8 ---
> > diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controlle=
r/pci-tegra.c
> > index 7071fd026a80..fc61074f6886 100644
> > --- a/drivers/pci/controller/pci-tegra.c
> > +++ b/drivers/pci/controller/pci-tegra.c
> > @@ -2530,6 +2530,7 @@ static const struct tegra_pcie_soc tegra20_pcie =
=3D {
> >   .program_deskew_time =3D false,
> >   .raw_violation_fixup =3D false,
> >   .update_fc_timer =3D false,
> > + .has_cache_bars =3D true,
> >   .ectl.enable =3D false,
> >  };
> >
> > @@ -2558,6 +2559,7 @@ static const struct tegra_pcie_soc tegra30_pcie =
=3D {
> >   .program_deskew_time =3D false,
> >   .raw_violation_fixup =3D false,
> >   .update_fc_timer =3D false,
> > + .has_cache_bars =3D false,
> >   .ectl.enable =3D false,
> >  };
> >
> > @@ -2581,6 +2583,7 @@ static const struct tegra_pcie_soc tegra124_pcie =
=3D {
> >   .program_deskew_time =3D false,
> >   .raw_violation_fixup =3D true,
> >   .update_fc_timer =3D false,
> > + .has_cache_bars =3D false,
> >   .ectl.enable =3D false,
> >  };
> >
> > @@ -2604,6 +2607,7 @@ static const struct tegra_pcie_soc tegra210_pcie =
=3D {
> >   .program_deskew_time =3D true,
> >   .raw_violation_fixup =3D false,
> >   .update_fc_timer =3D true,
> > + .has_cache_bars =3D false,
> >   .ectl =3D {
> >    .regs =3D {
> >     .rp_ectl_2_r1 =3D 0x0000000f,
> > @@ -2645,6 +2649,7 @@ static const struct tegra_pcie_soc tegra186_pcie =
=3D {
> >   .program_deskew_time =3D false,
> >   .raw_violation_fixup =3D false,
> >   .update_fc_timer =3D false,
> > + .has_cache_bars =3D false,
> >   .ectl.enable =3D false,
> >  };
> >
>=20

--eQyCKlb8USywWNtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOEYACgkQ3SOs138+
s6F77g//UnCHaLe+ewj8A+IX9zB5yReJNI6LVkiiWgsyyASQAC9aGJq5HieB8mw/
+41dhfl0td10srRlYQb7arJnvlftobclCIF1iBNKaqz6eu4ykL3ofw1ytpD8HPjK
vubSu7ZaNBVBE1q/yZgenivpjaglBTnyJGSPLzKGpjIsZYq4hTWgvQBXONxJi52/
I+TbJIc0+g5nd1Yl0J2zlfctdHKVrzp3r8lJp580KaVRwgJjcZVi2P0kcDxlAHXC
x32k34UHVzOPRE9CKpuppKhh/mJeU4EOTTrWUBLEWfZIDJV8as4O4NTxT4AxKLAL
KplGU0BwERJs4sAvXtCWjWyvzyDMBEJpBV6sHofles5AyWZw8cX2FMJdVU+avvmc
hiT2VonXluMAEXlkheqSFwbFqMrLV/ofnY0SsOXNFql7IVVwwE38cZGFivv2ZZYP
w9Q8O75yCZtE0azVuDtmo8iTMejA+gLIIY0UK502oANxVnlWIMJYYwEPlo1oQ3EE
pmiZEdYCd1NfH2j9MUT8SSKCO2AEdGTuR7XbdY/w7e9Ctv60vCVgDPiM6gXqEBCl
a06JAPSesOiuWJgw7U5DpQ9HKrdB4q/M4EmxNAP9b/tYq8Zdt/L1tTae2pHUXSZS
NLgr7ACSfRtA6+LNXoSzUJQ4qsefpWcUO/31+2gL73aEdIiMNm4=
=oKzY
-----END PGP SIGNATURE-----

--eQyCKlb8USywWNtC--
