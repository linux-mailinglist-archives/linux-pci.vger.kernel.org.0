Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAE26502
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfEVNtA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 09:49:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54431 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVNtA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2019 09:49:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so2306939wml.4;
        Wed, 22 May 2019 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SnKhUBZrT/sPuCdV1Uv2QnIPymrUbdqHNXKAWe9qXx0=;
        b=tc9v4nSBpMS7KH8OcDKfw9mE24cGP7vo4U5ys9Bsb6j1xdlQj5d5eyk9K4WsRAMU5G
         JGAbivJF1QcHu10RfRUvkNTFA1LcMy5Lve2RTFrcNg6EYU2/OCJWeqLryddoQ8gzfKEr
         OnDOD3EW9Im73HGQAkxhsSBmR+KNkVwkB1QtVchg6p+8CZZha8TIdkELcdcRQ1Ul/7Bm
         6zI3vZigEptpEkpvZJ2KHLNN0as+VxWQtT/y0LU0A0f84ijXIkY3K5Cg6oIyQtYEYla+
         x0r+EjSGD0ONdygV+aFyQaMNWrFC9wDjgDAlnCRTKe8KhPIWL55K5ep1NntIvz9h1Mhu
         xrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SnKhUBZrT/sPuCdV1Uv2QnIPymrUbdqHNXKAWe9qXx0=;
        b=GQZyKdi/Tq0DoSeZl2Hg/U4HUzmheD6wbKaQY/xVMd7KygzGSWugHkbGnZecTnlphQ
         Y0EcCQhGByV2gdLKSHVZ0sdByfi3chzjskBDORbTVf77WHGQaoNvBobif9wBTls8wHng
         7VlfxTDv2ylDx8v6LesemCGa+mYGNDHkew0AQcirvt+PBWXvgAPQRnpz+j53NzBzZ/4k
         nfBFxGaJF2uEJuCpL+s01PcYov5BN6froXLv1lJS5zvj2FQznbvjyEDYMrOdr/vCklRg
         kJTJmjmhOm+xiAAHMccxf63FA27TUjlg9vWEeMCi2lhtfmdQqftTiV0ZhzloWHV4Sj2W
         ac7g==
X-Gm-Message-State: APjAAAV68/iamrydpxGuZVnjyBylLB24Vo5osWg7AhkH14GSnvgRJcBf
        0GHqQ5Ei1k4ZvIyRfio7FtA=
X-Google-Smtp-Source: APXvYqyoUq0PiLCevdgg8MU0+OYTj4c8Uv/Is0aaVHA/cmny/YgEluTqa5TutJOH9d6+bzbC3brOgg==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr8018674wmj.87.1558532936965;
        Wed, 22 May 2019 06:48:56 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n1sm4623910wmc.19.2019.05.22.06.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:48:56 -0700 (PDT)
Date:   Wed, 22 May 2019 15:48:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 12/15] arm64: tegra: Enable PCIe slots in P2972-0000
 board
Message-ID: <20190522134855.GQ30938@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-13-vidyas@nvidia.com>
 <20190521105455.GK29166@ulmo>
 <6a2c0a9a-1c37-3e32-535a-aaf0db2f101d@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aNvCJ41Feu8IgPyB"
Content-Disposition: inline
In-Reply-To: <6a2c0a9a-1c37-3e32-535a-aaf0db2f101d@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--aNvCJ41Feu8IgPyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 11:47:45PM +0530, Vidya Sagar wrote:
> On 5/21/2019 4:24 PM, Thierry Reding wrote:
> > On Fri, May 17, 2019 at 06:08:43PM +0530, Vidya Sagar wrote:
> > > Enable PCIe controller nodes to enable respective PCIe slots on
> > > P2972-0000 board. Following is the ownership of slots by different
> > > PCIe controllers.
> > > Controller-0 : M.2 Key-M slot
> > > Controller-1 : On-board Marvell eSATA controller
> > > Controller-3 : M.2 Key-E slot
> > >=20
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > Changes since [v6]:
> > > * None
> > >=20
> > > Changes since [v5]:
> > > * Arranged PCIe nodes in the order of their addresses
> > >=20
> > > Changes since [v4]:
> > > * None
> > >=20
> > > Changes since [v3]:
> > > * None
> > >=20
> > > Changes since [v2]:
> > > * Changed P2U label names to reflect new format that includes 'hsio'/=
'nvhs'
> > >    strings to reflect UPHY brick they belong to
> > >=20
> > > Changes since [v1]:
> > > * Dropped 'pcie-' from phy-names property strings
> > >=20
> > >   .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  2 +-
> > >   .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 41 ++++++++++++++++=
+++
> > >   2 files changed, 42 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/ar=
m64/boot/dts/nvidia/tegra194-p2888.dtsi
> > > index 0fd5bd29fbf9..30a83d4c5b69 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
> > > @@ -191,7 +191,7 @@
> > >   						regulator-boot-on;
> > >   					};
> > > -					sd3 {
> > > +					vdd_1v8ao: sd3 {
> > >   						regulator-name =3D "VDD_1V8AO";
> > >   						regulator-min-microvolt =3D <1800000>;
> > >   						regulator-max-microvolt =3D <1800000>;
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arc=
h/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> > > index 73801b48d1d8..a22704e76a84 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> > > @@ -167,4 +167,45 @@
> > >   			};
> > >   		};
> > >   	};
> > > +
> > > +	pcie@14100000 {
> > > +		status =3D "okay";
> > > +
> > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > +
> > > +		phys =3D <&p2u_hsio_0>;
> > > +		phy-names =3D "p2u-0";
> > > +	};
> > > +
> > > +	pcie@14140000 {
> > > +		status =3D "okay";
> > > +
> > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > +
> > > +		phys =3D <&p2u_hsio_7>;
> > > +		phy-names =3D "p2u-0";
> > > +	};
> > > +
> > > +	pcie@14180000 {
> > > +		status =3D "okay";
> > > +
> > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > +
> > > +		phys =3D <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
> > > +		       <&p2u_hsio_5>;
> > > +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3";
> > > +	};
> > > +
> > > +	pcie@141a0000 {
> > > +		status =3D "disabled";
> > > +
> > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > +
> > > +		phys =3D <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
> > > +		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
> > > +		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
> > > +
> > > +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
> > > +			    "p2u-5", "p2u-6", "p2u-7";
> > > +	};
> >=20
> > This last controller is disabled by default. Why do we need to include
> > all of this if it's not going to be used anyway?
> I want to keep this entry ready by populating all the required fields. Wh=
en pinctrl
> driver is ready, I'll send out patches to enable this node as well.

Okay, makes sense.

Thierry

--aNvCJ41Feu8IgPyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlU0QACgkQ3SOs138+
s6H22w/+NtFf3N+erJ1kmeI6iADQ1aPCyQLeYyKJnlpmga3nBTGjnWKcMOMvvKWJ
dd5BJVw/2y4WG/4MPOHVwNWqgikVwh9bWC1hvozWqOCVTgLfKmuJFDCuhYeEbRvo
IYvQ+1NC+9VOrsL/L4g9LprbvZaIcCjIRKlVJBuTddpjq9fKeNQq8eAuuronYKj4
ahrHQ4Xahni/Qe8R2crqo8qltCHwd4qWVPnTwJ0N90seqIh2sB6ZyPTUhb8WKeiL
NoGYw5w3VAVxgV8g6nXnWPcSbhV3lM7ju0M8g1d482EpNARag+nuFMyiKkBhO3uB
SQJQuXSJaclaThtJmdRKoL/HGd3efiJQBysjmdOyTHLPZ4Kth3Rtk7JHXJgiRmsD
zuh+P0KOe2aYUY4ZIx6jOG2SEHGghntBpGUpyZCpPoaVhmckstaRLxObmQAd/Q9a
tBwzjs2D1uSRLvGPYnA7BmGxzuEVq0gkg+a7EIESiEiNnuht4eIyfpaNLXaTAafU
RwDop6KWQk7Itcpt73agmOsXf5UyLJQpf6fT4yXX1kac4YdEr3gNLo2R0rENXgp+
THNyLcvLPPZGeS2oScl0wvhTObeAPoM42ELGLrIoZl8S8LrGYueIVjmThbsTIX1P
QuPXkfgLQNU6KQMzDMC9Dwa0+8lAH+ofvoEqihJkSre0uBwIMqY=
=SO5k
-----END PGP SIGNATURE-----

--aNvCJ41Feu8IgPyB--
